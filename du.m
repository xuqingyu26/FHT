result_paths = '/media/root/f/Qingyu/VOT_Project/pyCFTrackers-master/results/FHT/results';
dirt = dir(result_paths);
[c] = {dirt.name};
algs = c(3:end);
base_path = '/media/root/f/Qingyu/dataset/whispers-HSI/test';
virt = dir(base_path);
[v] = {virt.name};
video_sequence_name = v(3:end);
vid_num = length(video_sequence_name);



for i = 1 : numel(algs)
    fprintf(algs{i});
    distance_rec = zeros(vid_num, 50);
    PASCAL_rec=zeros(vid_num,50);
    average_cle_rec=zeros(vid_num,50);
    result_path = fullfile(result_paths, '/', algs{i});
    text_files = dir(fullfile(result_path, '*.txt'));
    text_files = {text_files.name};
   for j = 1 : numel(text_files)
       video_path = fullfile(base_path, '/',  video_sequence_name{j},'/HSI-FalseColor/');
       regions = read_vot_regions(fullfile(result_path, '/',text_files{j}));
       gt = read_vot_regions(fullfile(video_path, 'groundtruth_rect.txt'));
       [distance_rec(j,:),PASCAL_rec(j,:),average_cle_rec(j,:),~,~]= computeMetric2(regions,gt);
   end
   if(isdir(['/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/HSI-False/'])==0),
            mkdir(['/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/HSI-False/']);
        end
   save(fullfile('/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master/result/HSI-False/',  strcat(algs{i}, '.mat')), 'PASCAL_rec','average_cle_rec','distance_rec')
end