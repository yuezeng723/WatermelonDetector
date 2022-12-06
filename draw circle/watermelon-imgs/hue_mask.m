function mask = hue_mask(img, lo, hi)
    img_hue = rgb2hsv(img);
    mask = (img_hue(:, :, 1) >= lo) .* (img_hue(:, :, 1) <= hi);

end

