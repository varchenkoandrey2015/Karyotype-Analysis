function [ centromere, x ] = centromere( x,xfrom,height )
    length=size(x,1);
    imageBW = im2bw(x, 0.9);
    counts=zeros(1,length);
    l=1;
    min=0;
    for j=1:length
        for k=1:length
            if(imageBW(j,k)==0)
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
    j=length;
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

    if(abs(counts(max1)-counts(max2))<=2 && max2-max1<0.3*height)
        if(max2<xfrom+height/2)
            x=imrotate(x,180);
        end
        centromere=0;
    end
    if(centromere>0.5)
        centromere=1-centromere;
        x=imrotate(x,180);
    end
end

