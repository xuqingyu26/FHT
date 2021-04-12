clear all;
base_path = '/media/root/f/Qingyu/dataset/whispers-HSI/test/';
dirt = dir(base_path);
[c] = {dirt.name};
video_sequence_name = c(3:end);
vid_num = length(video_sequence_name);
rect_path = '/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/bb_pd/';
distance_rec = zeros(vid_num, 50);
PASCAL_rec=zeros(vid_num,50);
average_cle_rec=zeros(vid_num,50);
for i = 1 : vid_num
    video_path = fullfile(base_path,  video_sequence_name{i},'/HSI/');
    img_dir = dir(fullfile(video_path, '*.png'));

    % initialize bounding box - [x,y,width, height]
    gt = read_vot_regions(fullfile(video_path, 'groundtruth_rect.txt'));
    rect = load([rect_path, strcat(video_sequence_name{i}, '.mat')]);
    rect_position = rect.rect_position;
    [distance_rec(i,:),PASCAL_rec(i,:),average_cle_rec(i,:),~,~]= computeMetric2(rect_position,gt);
    end
save(fullfile('/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/ours/',  strcat('CSR-DCF.mat')), 'PASCAL_rec','average_cle_rec','distance_rec')