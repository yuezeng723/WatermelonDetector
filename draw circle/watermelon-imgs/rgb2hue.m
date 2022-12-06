function img_hue = rgb2hue(img)
    [x, y, ~] = size(img);
    img_hsv = rgb2hsv(img);
    img_hue = hsv2rgb(cat(3, img_hsv(:, :, 1), ones(x, y, 2)));
end

