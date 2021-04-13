function evaluate_FHT()

% set this to tracker directory
tracker_path = '/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master';
rect_result_path = '/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/bb_pd/';
% add paths
addpath(tracker_path);
addpath(fullfile(tracker_path, 'mex'));
addpath(fullfile(tracker_path, 'utils'));
addpath(fullfile(tracker_path, 'features'));

visualize_tracker = 1;
use_reinitialization = 0;

% choose name of the VOT sequence
% sequence_name = 'ball';    

% path to the folder with VOT sequences
base_path = '/media/root/f/Qingyu/dataset/whispers-HSI/test';
dirt = dir(base_path);
[c] = {dirt.name};
video_sequence_name = c(3:end);
vid_num = length(video_sequence_name);
% distance_rec = zeros(vid_num, 50);
% PASCAL_rec=zeros(vid_num,50);
% average_cle_rec=zeros(vid_num,50);
mm = load(fullfile('/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/ours/',  'Ours.mat'));
distance_rec = mm.distance_rec;
PASCAL_rec=mm.PASCAL_rec;
average_cle_rec=mm.average_cle_rec;
algorithms = {'ours', 'CSR-DCF','Ours'};
for i = 1 : vid_num
    video_path = fullfile(base_path,  video_sequence_name{i},'/HSI/');
    img_dir = dir(fullfile(video_path, '*.png'));

    % initialize bounding box - [x,y,width, height]
    gt = read_vot_regions(fullfile(video_path, 'groundtruth_rect.txt'));
    gt8 = dlmread(fullfile(video_path, 'groundtruth_rect.txt'));


    start_frame = 1;
    n_failures = 0;
    time = zeros(numel(img_dir), 1);
    n_tracked = 0;
    num_frames = numel(img_dir);
    rect_position = zeros(num_frames, 4);

    if visualize_tracker
        figure(1); clf;
    end
    
    
    
    frame = start_frame;
    while frame <=num_frames,  % tracking loop
        % read frame
        impath = fullfile(video_path, img_dir(frame).name);
        img = imread(impath);
        img=X2Cube(img);
%         img = hyper2im(img);
%         img=img./max(img(:));

        tic()
        % initialize or track
        if frame == start_frame

            bb = gt8(frame,:);  % add 1: ground-truth top-left corner is (0,0)
            tracker = create_csr_tracker(img, bb);
            bb = gt(frame,:);  % just to prevent error when plotting

        else

            [tracker, bb] = track_csr_tracker(tracker, img);

        end
        rect_position(frame,:) = bb;
        time(frame) = toc();

        n_tracked = n_tracked + 1;

        % visualization and failure detection
        if visualize_tracker

            figure(1); if(size(img,3)<3), colormap gray; end
            imagesc(uint8(hyper2im(img)))
            hold on;
            rectangle('Position',bb,'LineWidth',1,'EdgeColor','b');

            text(15, 25, num2str(n_failures), 'Color','r', 'FontSize', ...
                15, 'FontWeight', 'bold');

            if use_reinitialization  % detect failures and reinit
                area = rectint(bb, gt(frame,:));
                if area < eps && use_reinitialization
                    
                    n_failures = n_failures + 1;
                    if ~mod(n_failures, 10)
                        frame = frame;  % skip 5 frames at reinit (like VOT)

                        start_frame = frame+1;
                        disp(['Failure detected at frame ', num2str(frame), '. Reinitializing tracker at frame ', num2str(frame)]);
                    end
                    
                end
            end

            hold off;
            if frame == start_frame
                truesize;
            end
            drawnow; 
        end

        frame = frame + 1;

    end

    fps = n_tracked / sum(time);
    fprintf('%d FPS: %.1f\n',i, fps);
%     gt_boxes = [gt(:,1:2), gt(:,1:2) + gt(:,3:4) - ones(size(gt,1), 2)];
%     rect_boxes = [rect_position(:,1:2), rect_position(:,1:2) + rect_position(:,3:4)/2];
    [distance_rec(i,:),PASCAL_rec(i,:),average_cle_rec(i,:),~,~]= computeMetric2(rect_position,gt);
    if(isdir([rect_result_path algorithms{3}])==0),
            mkdir([rect_result_path algorithms{3}]);
        end
    save(fullfile(rect_result_path, algorithms{3}, '/',  strcat( 'Ours',video_sequence_name{i},'.mat')), 'rect_position')
    save(fullfile('/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/ours/',  strcat('Ours.mat')), 'PASCAL_rec','average_cle_rec','distance_rec')
end

end  % endfunction


