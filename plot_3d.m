function plot_3d(img)
[w,h,c] = size(img);
if c ~=1
    return;
end
x=1:w;
y=1:h;
[xi,yi] = meshgrid(1:0.1:w,1:0.1:h);
zi = interp2(x,y, img,xi,yi,'spline');
% S= surf(X,Y,img, 'FaceAlpha', 0.5);
mesh(xi,yi,zi);

end % end function