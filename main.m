close all;
clear all;
clc;
warning('off','all');
source = im2double(rgb2gray(imread('pics/source.png')));
imageBW = im2bw(source, 0.9);
imageWB = imcomplement(imageBW);
imageWB=onlychroms(imageWB); %удаление лишних объектов
images=chromselection(source,imageWB);%заносим по отдельности
heights = {};
brightnesses = {};
centromeres = {};
for i=1:size(images,2)  
    x=images{i};
    [x,rect]=chromresize(x);%приводим к одному размеру
    brightness = mean2(x);
    height = rect(4);
    width = rect(3);
    [ x,height,xfrom ] = chromrotate(x,width,height);%поворот
    heights{i}=height;
    brightnesses{i}=brightness;
    [centromeres{i},x]=centromere(x,xfrom,height);
    x=stripes(x, xfrom, centromeres{i});
    name=strcat('pics/chr',int2str(i),'.png');
    imwrite(x,name,'png');
    images{i}=x;
end
heightsArr = cell2mat(heights);
heightsArr = heightsArr / max(max(heightsArr));
brArr = cell2mat(brightnesses);
brArr = brArr / max(max(brArr));