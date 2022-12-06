function mask = lasso_select(img, in_mask)
    figure
    imshow(img)
    if ~isnan(in_mask)
        coord = mask2poly(in_mask, 'CW');
        hold on 
        ps = polyshape(uint16(coord(:,1)), uint16(coord(:,2)));
        plot(ps, 'FaceAlpha', 0.3, 'FaceColor', 'b', ...
                 'EdgeAlpha', 0.6, 'EdgeColor', 'b', 'LineWidth', 1);
        hold off 
    end
    h = drawassisted;
    %coord = h.Position;
    mask = createMask(h);
end

