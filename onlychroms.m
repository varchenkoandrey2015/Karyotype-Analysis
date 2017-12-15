function [ image ] = onlychroms( image )
    imageSize = size(image);
    [Ilabel num] = bwlabel(image);
    Iprops = regionprops(Ilabel);
    area = [Iprops.Area];
    meanArea = mean2(area);
    for i=1:imageSize(1)
       for j=1:imageSize(2)
            imageNumber = Ilabel(i,j);
            if ( imageNumber>0 && area(imageNumber) > 3*meanArea)
                image(i,j) = 0;
            end
       end
    end
end

