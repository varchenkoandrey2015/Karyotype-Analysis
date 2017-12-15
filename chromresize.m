function [ x,rect ] = chromresize( original )
    length = 200;
    
    imageBW = im2bw(original, 0.9);
    imageWB = imcomplement(imageBW);
    Ilabel = logical(imageWB);
    Iprops = regionprops(Ilabel);
    rect = [Iprops.BoundingBox];
    xfrom = rect(2);
    xto = rect(2) + rect(4);
    yfrom = rect(1);
    yto = rect(1) + rect(3);
    x = original(xfrom:xto, yfrom:yto);
    [m, n] = size(x);
    x = imcomplement(x);
    x = padarray(x, [floor((length-m)/2) floor((length-n)/2)],'post');
    x = padarray(x, [ceil((length-m)/2) ceil((length-n)/2)], 'pre');
    x = imcomplement(x);
end

