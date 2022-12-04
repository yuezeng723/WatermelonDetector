
image = imread("./watermelon-imgs/melon2.jpg");
[~,G,~] = imsplit(image);
G0 = histeq(G);
imshow(G0)
BW = imbinarize(G0,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
imshow(BW)
blurred = BW;
se = strel('cube',4);

param1 = 10;
weightsArray = getWeight(param1);

center = zeros(1,2);
radius = 0;
for i = 1:param1
    H = fspecial('disk',4);
    blurred = imfilter(blurred,H,'replicate'); 
    blurred = imopen(blurred,se);
    %imshow(blurred);
    approxLength = ceil(min(size(blurred)) * 0.2);
    s = bwskel(~blurred,'MinBranchLength',approxLength);
    %imshow(s)
    [currentMelonCenter, currentMelonRadius] = getCircle(s,approxLength);
    center = center + weightsArray(i) * currentMelonCenter;
    radius = radius + weightsArray(i) * currentMelonRadius;
    pause(0.1)
end

imshow(G0), hold on
viscircles(center, radius,'Color','red');

