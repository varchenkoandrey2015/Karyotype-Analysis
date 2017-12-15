source = im2double(imread('dd.png'));
%создает 400 на 400 без вывода на экран
f = figure('Position',[0 0 400 400],'visible','off');
%скрывает оси
set(gca,'visible','off');
%убирает рамку
set(gca,'position',[0 0 1 1],'units','normalized')

text(0.5,0.1,'hello world!')
%преобразует фигуру в изображение
label = print('-RGBImage'); 
label=imresize(label, [400 400]);
label=im2double(label);
%помещаем надпись на фон
result=immultiply(source, label);
imwrite(result,'result.png');

