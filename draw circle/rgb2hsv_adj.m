function hsv = rgb2hsv_adj(img)
    hsv = rgb2hsv(img);
    hsv = imadjust_rgb(hsv);
end

