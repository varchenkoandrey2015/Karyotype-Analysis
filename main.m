close all;
clear all;
clc;
source = im2double(rgb2gray(imread('pics/source.png')));
imageSize = size(source);
image = im2bw(source, 0.9);
image = imcomplement(image);

%удаление лишних объектов
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

%в images заносим исх. хромосомы по отдельности
[Ilabel num] = bwlabel(image);
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
 
%обработка каждой хромосомы
heights = {};
brightnesses = {};
center = {};

for i=1:num
    inputSize = [ 400 400 ];
    p = inputSize(1);
    q = inputSize(2);
    image = im2bw(images{i}, 0.9);
    image = imcomplement(image);
    Ilabel = logical(image);
    Iprops = regionprops(Ilabel);
    rect = [Iprops.BoundingBox];
    xfrom = rect(2);
    xto = rect(2) + rect(4);
    yfrom = rect(1);
    yto = rect(1) + rect(3);
    x = images{i}(xfrom:xto, yfrom:yto);
%     figure;
%     imshow(x);
    [m n] = size(x);
    brightness = mean2(x);
    height = rect(4);
    width = rect(3); 
    rotation = 5;
    switched = 0;
    x = imcomplement(x);%инверсия 400 400
    x = padarray(x, [floor((p-m)/2) floor((q-n)/2)],'post');
    x = padarray(x, [ceil((p-m)/2) ceil((q-n)/2)], 'pre');
    %x= imcomplement(x);
    %figure;
    %imshow(x);%black back
    while (1) 
        x_new = imrotate(x,rotation,'bicubic', 'crop');
        imSize = size(x_new);
%         figure;
%         imshow(x_new);%black back
        imaget = imcomplement(x_new);
        imaget = im2bw(imaget, 0.9);
        imaget = imcomplement(imaget);
%         figure;
%         imshow(imaget);%black back
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
                rotation = -5; 
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
    
    %пересчёт центромеры
    imaget = imcomplement(x);
    imaget = im2bw(imaget, 0.9);
    counts=zeros(1,p);
    l=1;
    min=0;
    for j=1:p
        for k=1:q
            if(imaget(j,k)==0)
                counts(l)=counts(l)+1;
            end
        end   
        l=l+1;
    end
    max1=0;
    max2=0;
    j=1;
    while(1)
        max1=j;
        if(counts(j+1)<counts(j))
            break;
        end
        j=j+1;
    end
    j=p;
    while(1)
        max2=j;
        if(counts(j-1)<counts(j))
            break;
        end
        j=j-1;
    end
    min=max1;
    for j=max1:max2
        if(counts(j)<counts(min))
            min=j;
        end
    end
    a=min-xfrom;
    centromere=a/height;
    if(centromere>0.5)
        centromere=1-centromere;
    end
    if(counts(max1)==counts(max2) && max2-max1<10)
        centromere=0;
    end
%     figure;
%     imshow(x);
    images{i}=x;
    heights{i}=height;
    brightnesses{i}=brightness;
    center{i}=centromere;
end
imshow(collaged_image);
heightsArr = cell2mat(heights);
heightsArr = heightsArr / max(max(heightsArr));
brArr = cell2mat(brightnesses);
brArr = brArr / max(max(brArr));