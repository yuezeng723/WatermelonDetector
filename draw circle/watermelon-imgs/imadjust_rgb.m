function out = imadjust_rgb(img)
    out = cat(3, imadjust(img(:,:,1)), ...
            imadjust(img(:,:,2)), ...
            imadjust(img(:,:,3)));
end

