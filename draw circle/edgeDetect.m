image = imread("watermelon-imgs/melon15.jpg");
I = image;
figure;
imshow(I)
bw_I = rgb2gray(I);
figure;
montage([bw_I, imfill(bw_I)])

h_mask_1 = hue_mask(I, 0.15, 0.6);
h_mask = uint8(repmat(h_mask_1, [1, 1, 3]));
hue_masked_img = I.*h_mask;
figure;
montage(cat(4, rgb2hue(I)*255, hue_masked_img))


%[~,G,~] = imsplit(image);
G = rgb2gray(image);
histogram(G);
G0 = imadjust(G);
G0 = histeq(G0);
BW = imbinarize(G0,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
imshow(BW)
blurred = BW;
se = strel('disk',4);

param1 = 10;
weightsArray = getWeight(param1);

center = zeros(1,2);
radius = 0;
figure, hold on;
imshow(image);
radius_adjust = 1;
for i = 1:param1
    H = fspecial('disk',4);
    blurred = imfilter(blurred,H,'replicate'); 
    blurred = imopen(blurred,se);
%     imshow(blurred);
%     pause(0.5)
    approxLength = ceil(min(size(blurred)) * 0.2);
    s = bwskel(~blurred,'MinBranchLength',approxLength);
    s = s.* (h_mask_1) + zeros(size(s)).*(~h_mask_1) ;
    imshow(s)
    pause(0.5);
    [currentMelonCenter, currentMelonRadius] = getCircle(s,approxLength);
    if isstring(currentMelonCenter)
        idx_end = i;
        radius_adjust = sum(weightsArray(1:idx_end ));
        center = center / radius_adjust;
        break;
    end
    center = center + weightsArray(i) * currentMelonCenter;
    radius = radius + weightsArray(i) * currentMelonRadius;
    viscircles(currentMelonCenter, currentMelonRadius,'Color','red');
    pause(0.5)
end
radius_factor = 1.2;

radius = radius * radius_factor / radius_adjust;
imshow(image);
viscircles(center, radius,'Color','red');
pause(0.5)

