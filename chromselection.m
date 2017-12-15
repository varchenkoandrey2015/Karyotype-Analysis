function [ images ] = chromselection( source, image )
    [Ilabel num] = bwlabel(image);
    imageSize=size(image);
    images = {};
    for i=1:num
       images{i} = ones(imageSize);
    end
    for i=1:imageSize(1)
       for j=1:imageSize(2)
            imageNumber = Ilabel(i,j);
            if (imageNumber > 0)
                images{imageNumber}(i,j) = source(i,j);                   
            end
       end
    end
end

