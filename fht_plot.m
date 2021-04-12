clear all;
close all;framfr
% variable = load('f.mat');
% f = variable.f;
mask = load('mask.mat');
mask = mask.mask; 
% img_false = load('img_false.mat');
% img_false = img_false.img_false;
% imshow(img_false);
response = load('response.mat');
response = response.response;

% figName = ['/media/root/f/Qingyu/VOT_Project/PlotErr234/attribute/',attrDisplay,'_PR'];
    %figName = ['E:\zhaonan\MM2017\PlotErr\figsResults_TIP\TPR\',attrDisplay,'_TPR'];
    %saveas(gcf,figName,'png');
    
% for i = 1 : size(response, 3)
%     figure(),plot_3d(response(:,:,i)),axis off,grid off;
%     figName = ['/media/root/f/Qingyu/VOT_Project/csrdcf/csr-dcf-master-原版/中间变量/',num2str(i),'_response'];
%     saveas(gcf,figName,'png');
% end

% figure(),plot_3d(f(:,:,22)),axis off,grid off,hold on;
%  plot_3d(f(:,:,27)),hold on;
% plot_3d(f(:,:,5)),hold on;

figure(),plot_3d(fftshift(response)),grid off,axis off;
figure(),plot_3d(fftshift(response).*mask),grid off,axis off;