rect_result_path = '/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/bb_pd/';
base_path = '/media/root/f/Qingyu/dataset/whispers-HSI/test/';
py_path = '/media/root/f/Qingyu/VOT_Project/pyCFTrackers-master/results/FHT/results/';
imgpath_save = '/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master-原版/show_result/';
dirt = dir(base_path);
[c] = {dirt.name};
video_sequence_name = c(3:end);
vid_num = length(video_sequence_name);
for i = 2 : vid_num
    video_path = fullfile(base_path,  video_sequence_name{i},'/HSI/');
    
    
    groundtruth = dlmread(fullfile(video_path, 'groundtruth_rect.txt'));
    fht = load(fullfile(rect_result_path, 'Ours_HOG/', strcat('Ours_HOG',  video_sequence_name{i}, '.mat')));
    fht = fht.rect_position;
    KCF_CN = dlmread(fullfile(py_path, strcat( 'KCF_CN', '_fasle/',video_sequence_name{i},'.txt')));
    SAMF = dlmread(fullfile(py_path, strcat( 'SAMF', '_fasle/',video_sequence_name{i},'.txt')));
    
    
    
    
    img_path = strcat(base_path, video_sequence_name{i}, '/HSI-FalseColor/');
    dir_img_path = dir(strcat(img_path,'*.jpg'));
    [D] = {dir_img_path.name};
    img_all = D(1:end);
    num_per_seq = numel(img_all);
    nz	= strcat('%0',num2str(4),'d');
    for j=1:num_per_seq
        image_no = (j);
        id = sprintf(nz,image_no);
        img_ir = imread(strcat(img_path, img_all{j}));       
        [x,y,c]=size(img_ir);
        set(gcf,'Position',[0,0,y,x]);
        imshow(img_ir,'border','tight','initialmagnification','fit');
        
        
        x10 = groundtruth(:,1);
        y10 = groundtruth(:,2);
        h0 = groundtruth(:,3);
        w0 = groundtruth(:,4);
        x11 = fht(:,1);
        y11 = fht(:,2);
        h1 = fht(:,3);
        w1 = fht(:,4);
        x12 = KCF_CN(:,1);
        y12 = KCF_CN(:,2);
        h2 = KCF_CN(:,3);
        w2 = KCF_CN(:,4);
        x13 = SAMF(:,1);
        y13 = SAMF(:,2);
        h3  = SAMF(:,3);
        w3  = SAMF(:,4);
%         [x10,y10,h0,w0]=groundtruth;
%         [x11,y11,h1,w1]=fht(j,:);     
%         [x12,y12,h2,w2]=KCF_CN(j,:);  
%         [x13,y13,h3,w3]=SAMF(j,:);
        
        


        text(25, 30, ['#' id], 'Color','y', 'FontWeight','bold', 'FontSize',21);
        rectangle('Position', [round(x10(j)) round(y10(j)) abs(h0(j)) abs(w0(j))], 'EdgeColor', 'b', 'LineWidth', 4,'LineStyle','-');
        rectangle('Position', [round(x11(j)) round(y11(j)) abs(h1(j)) abs(w1(j))], 'EdgeColor', 'g', 'LineWidth', 4,'LineStyle','-');
        rectangle('Position', [round(x12(j)) round(y12(j)) abs(h2(j)) abs(w2(j))], 'EdgeColor', 'y', 'LineWidth', 4,'LineStyle','-');
        rectangle('Position', [round(x13(j)) round(y13(j)) abs(h3(j)) abs(w3(j))], 'EdgeColor', 'r', 'LineWidth', 4,'LineStyle','-');
        pathsave = strcat(imgpath_save, video_sequence_name{i}, '/HSI-false');
        if ~exist(pathsave)
            mkdir(pathsave);
        end
        imwrite(frame2im(getframe(gcf)), [pathsave  '/' num2str(j) '.png']);

    end
    
    
    
    
    
    
end