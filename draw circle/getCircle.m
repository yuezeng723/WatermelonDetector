function [melonCenter, melonRadius] = getCircle(s, approxLength)
%parameter s: the preprocessed image 
%output melonCenter: coordinate of watermelon's center
%output melonRadius: radius of the watermelon
[H,T,R] = hough(s,'RhoResolution',5,'Theta',-90:5:89);
% figure(Position=[400,400,1200,400]), subplot(1,2,1)
% imshow(H,[],'XData',T,'YData',R,...
%             'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P  = houghpeaks(H,5,'threshold',ceil(0.1*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
% plot(x,y,'s','color','white');

% find lineds
lines = houghlines(s,T,R,P,'FillGap',5,'MinLength',approxLength);
% subplot(1,2,2), imshow(G0), hold on
max_len = 0;
xy_long = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
if xy_long == 0
    melonRadius = "Error";
    melonCenter = "Error";
else
    melonRadius = max_len/2;
    melonCenter = [mean(xy_long(:,1)), mean(xy_long(:,2))];
end
end

