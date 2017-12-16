function [ x ] = stripes( x,xfrom,centromere )
    length=size(x,1);
    brightness = zeros(length,1);
    x_int=im2uint16(x);
    for i=1:length
        sum=0;
        sum=uint32(sum);
        count=0;
        for j=1:length
            if(x_int(i,j)<60000)      
                sum=sum+uint32(x_int(i,j));
                count=count+1;
            end
        end
        if(sum~=0)
            brightness(i)=sum/count;
        else 
            brightness(i)=0;
        end
    end
    sum=0;
    count=0;
    for i=1:length
        if(brightness(i)~=0)
            sum=sum+brightness(i);
            count=count+1;
        end
    end
    brMean=sum/count;
    stripes=ones(length,1);
    for i=1:length
        if(brightness(i)<brMean)
            stripes(i)=0;
        end
    end
    a=50;
    b=65;
    for i=xfrom:xfrom+count
        for j=a:b
            x(i,j)=stripes(i);
        end
    end
    for j=a:b
            x(xfrom,j)=0;
            x(xfrom+count,j)=0;
    end
    for j=xfrom:xfrom+count
            x(j,a)=0;
            x(j,b)=0;
    end
    if(centromere~=0)
        c=xfrom+round(centromere*count);
        for j=c-2:c+2
            x(j,a)=1;
            x(j,b)=1;
        end
        for j=c-1:c+1
            x(j,a+1)=1;
            x(j,b-1)=1;
        end
        x(c,a+2)=1;
        x(c,b-2)=1;
        x(c-2,a+1)=0;
        x(c-2,b-1)=0;
        x(c-1,a+2)=0;
        x(c-1,b-2)=0;
        x(c,a+3)=0;
        x(c,b-3)=0;
        x(c+1,a+2)=0;
        x(c+1,b-2)=0;
        x(c+2,a+1)=0;
        x(c+2,b-1)=0;
    else
        x(xfrom,a)=1;
        x(xfrom,a+1)=1;
        x(xfrom,a+2)=1;
        x(xfrom,b-2)=1;
        x(xfrom,b-1)=1;
        x(xfrom,b)=1;
        x(xfrom+1,a)=1;
        x(xfrom+1,a+1)=1;
        x(xfrom+1,a+2)=0;
        x(xfrom+1,b-2)=0;
        x(xfrom+1,b-1)=1;
        x(xfrom+1,b)=1;
        x(xfrom+2,a)=1;
        x(xfrom+2,a+1)=0;
        x(xfrom+2,b-1)=0;
        x(xfrom+2,b)=1;
    end
end

