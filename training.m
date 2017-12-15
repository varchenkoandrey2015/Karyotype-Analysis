source = im2double(imread('dd.png'));
%������� 400 �� 400 ��� ������ �� �����
f = figure('Position',[0 0 400 400],'visible','off');
%�������� ���
set(gca,'visible','off');
%������� �����
set(gca,'position',[0 0 1 1],'units','normalized')

text(0.5,0.1,'hello world!')
%����������� ������ � �����������
label = print('-RGBImage'); 
label=imresize(label, [400 400]);
label=im2double(label);
%�������� ������� �� ���
result=immultiply(source, label);
imwrite(result,'result.png');

