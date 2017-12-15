close all;
clear all;
clc;
source = im2double(rgb2gray(imread('pics/source.png')));
imageBW = im2bw(source, 0.9);
imageWB = imcomplement(imageBW);
imageWB=onlychroms(imageWB); %�������� ������ ��������
images=chromselection(source,imageWB);%������� �� �����������
%��������� ������ ���������
heights = {};
brightnesses = {};
centromeres = {};
for i=1:size(images,2)  
    image=images{i};
    [x,rect]=chromresize(image);%�������� � ������ �������
    brightness = mean2(x);
    height = rect(4);
    width = rect(3);
    [ x,height,xfrom ] = chromrotate(x,width,height);%�������
    images{i}=x;
    heights{i}=height;
    brightnesses{i}=brightness;
    centromeres{i}=centromere(x,xfrom,height);
    x=imcomplement(x);
    name=strcat('pics/chr',int2str(i),'.png');
    imwrite(x,name,'png');
end
heightsArr = cell2mat(heights);
heightsArr = heightsArr / max(max(heightsArr));
brArr = cell2mat(brightnesses);
brArr = brArr / max(max(brArr));