function [ centromere ] = centromere( x,xfrom,height )
    imaget = imcomplement(x);
    length=size(x,1);
    imaget = im2bw(imaget, 0.9);
    counts=zeros(1,length);
    l=1;
    min=0;
    for j=1:length
        for k=1:length
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
    if(centromere>0.5)
        centromere=1-centromere;
    end
    if(counts(max1)==counts(max2) && max2-max1<10)
        centromere=0;
    end
end

