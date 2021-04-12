 video_name = {'card','toy1','toy2'};
 for vid = 1 : numel(video_name)
    base_path = ['/media/root/f/Qingyu/dataset/whispers-HSI/test/', video_name{vid}];
    rgb = dir(fullfile(base_path, strcat('/RGB/*jpg')));
    hsi = dir(fullfile(base_path, strcat('/HSI/*png')));
    [rgb] = {rgb.name};
    [hsi] = {hsi.name};

    frame = 5;

    image_frame = imread(fullfile(base_path, '/RGB/', rgb{frame}));
    hsi_frame = imread(fullfile(base_path, '/HSI/', hsi{frame}));
    hsi_frame = X2Cube(hsi_frame);

    [x,y,c] =size(image_frame);
    [h,w,f] = size(hsi_frame);

    result_path = '/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master-原版/fiter_tu';
    res = fullfile(result_path, '/', video_name{vid});
    if ~exist(res,'dir')
        mkdir(res);
    end
    for i = 1:f
        fig_name = fullfile(res, '/', strcat(num2str(i), 'png'));
        set(gcf, 'Position', [0,0,w,h]);
        imshow(hsi_frame(:,:,i)./max(hsi_frame(:,:,i)), 'border', 'tight', 'initialmagnification', 'fit');
        saveas(gcf, fig_name, 'png');
    end

    fig_name = fullfile(res, '/', strcat(num2str(i), 'RGB'));
        set(gcf, 'Position', [0,0,y,x]);
        imshow(image_frame, 'border', 'tight', 'initialmagnification', 'fit');
        saveas(gcf, fig_name, 'png');
 end