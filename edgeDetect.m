image = imread("1.jpg");
[~,G,~] = imsplit(image);
G0 = histeq(G);
imshow(G0)
BW = imbinarize(G0,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
imshow(BW)
blurred = BW;
se = strel('cube',4);
for i = 1:20
    H = fspecial('disk',4);
    blurred = imfilter(blurred,H,'replicate'); 
    blurred = imopen(blurred,se);
    imshow(blurred);
    pause(0.05)
end
approxLength = ceil(min(size(blurred)) * 0.2);
s = bwskel(~blurred,'MinBranchLength',approxLength);
imshow(s)


%% Hough
[H,T,R] = hough(s,'RhoResolution',15,'Theta',-90:5:89);
figure(Position=[400,400,1200,400]), subplot(1,2,1)
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P  = houghpeaks(H,5,'threshold',ceil(0.1*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

% find lineds
lines = houghlines(s,T,R,P,'FillGap',5,'MinLength',approxLength);
subplot(1,2,2), imshow(G0), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end