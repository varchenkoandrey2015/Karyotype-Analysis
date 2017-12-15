function [ x,height,xfrom ] = chromrotate(x,width,height)
    angle = 5;
    switched = 0;
    x = imcomplement(x);
    while (1) 
        x_new = imrotate(x,angle,'bicubic', 'crop');
        imaget = imcomplement(x_new);
        imaget = im2bw(imaget, 0.9);
        imaget = imcomplement(imaget);
        Ilabel = logical(imaget);
        Iprops = regionprops(Ilabel);
        rect = [Iprops.BoundingBox];
        if(rect(3)/rect(4) < width/height)
            x=x_new;
            yfrom = fix(rect(1));
            xfrom = fix(rect(2));
            width=fix(rect(3));
            height=fix(rect(4));
            switched=1;
        else
            if(switched==0)
                switched=1;
                angle = -5; 
                yfrom = fix(rect(1));
                xfrom = fix(rect(2));
                width=fix(rect(3));
                height=fix(rect(4));
                x = x_new;
            else
                break;
            end        
        end
    end
end

