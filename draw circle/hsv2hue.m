function hue = hsv2hue(hsv)
    [x, y, ~] = size(hsv);
%     if max(hsv(:,:,1), [], 'all') <=1
%         hue = uint8(hsv2rgb(cat(3, hsv(:, :, 1), ones(x, y, 2))) * 255);
%     else
%         hue = uint8(hsv2rgb(cat(3, double(hsv(:, :, 1))./255, ones(x, y, 2))) * 255);
%     end
    hue = hsv2rgb(cat(3, hsv(:, :, 1), ones(x, y, 2)));
end

