%% �Ӻ��� DNA���� arr1��arr2��ʾ����Ҫ�����DNA����
%numΪ0ʱ����ʾ�ӣ�numΪ1ʱ����ʾ����numΪ2ʱ����ʾ���numΪ3ʱ��ʾͬ��
function fv=DNA_yunsuan(arr1,arr2,num)
[m,n]=size(arr1);
fv=zeros(m,n);          %Ԥ�����ڴ�
if num==0    %�ӷ�
    for i=1:m
        for j=1:n
            if arr1(i,j)=='A'
                fv(i,j)=arr2(i,j);
            elseif arr1(i,j)=='T'
                if arr2(i,j)=='A'
                    fv(i,j)='T';
                elseif arr2(i,j)=='T'
                    fv(i,j)='C';
                elseif arr2(i,j)=='C'
                    fv(i,j)='G';
                else
                    fv(i,j)='A';
                end
            elseif arr1(i,j)=='C'
                if arr2(i,j)=='A'
                    fv(i,j)='C';
                elseif arr2(i,j)=='T'
                    fv(i,j)='G';
                elseif arr2(i,j)=='C'
                    fv(i,j)='A';
                else
                    fv(i,j)='T';
                end
            else
                if arr2(i,j)=='A'
                    fv(i,j)='G';
                elseif arr2(i,j)=='T'
                    fv(i,j)='A';
                elseif arr2(i,j)=='C'
                    fv(i,j)='T';
                else
                    fv(i,j)='C';
                end
            end
        end
    end
elseif num==1       %����
    for i=1:m
        for j=1:n
            if arr2(i,j)=='A'
                fv(i,j)=arr1(i,j);
            elseif arr2(i,j)=='T'
                if arr1(i,j)=='A'
                    fv(i,j)='G';
                elseif arr1(i,j)=='T'
                    fv(i,j)='A';
                elseif arr1(i,j)=='C'
                    fv(i,j)='T';
                else
                    fv(i,j)='C';
                end
            elseif arr2(i,j)=='C'
                if arr1(i,j)=='A'
                    fv(i,j)='C';
                elseif arr1(i,j)=='T'
                    fv(i,j)='G';
                elseif arr1(i,j)=='C'
                    fv(i,j)='A';
                else
                    fv(i,j)='T';
                end
            else
                if arr1(i,j)=='A'
                    fv(i,j)='T';
                elseif arr1(i,j)=='T'
                    fv(i,j)='C';
                elseif arr1(i,j)=='C'
                    fv(i,j)='G';
                else
                    fv(i,j)='A';
                end
            end
        end
    end
elseif num==2        %���
    for i=1:m
        for j=1:n
            if arr1(i,j)==arr2(i,j)
                fv(i,j)='G';
            elseif (arr1(i,j)=='T' && arr2(i,j)=='A') || (arr1(i,j)=='A' && arr2(i,j)=='T') || (arr1(i,j)=='G' && arr2(i,j)=='C') || (arr1(i,j)=='C' && arr2(i,j)=='G')
                fv(i,j)='C';
            elseif (arr1(i,j)=='C' && arr2(i,j)=='A') || (arr1(i,j)=='A' && arr2(i,j)=='C') || (arr1(i,j)=='G' && arr2(i,j)=='T') || (arr1(i,j)=='T' && arr2(i,j)=='G')
                fv(i,j)='T';
            else
                fv(i,j)='A';
            end
        end
    end
else                %ͬ��
    for i=1:m
        for j=1:n
            if arr1(i,j)==arr2(i,j)
                fv(i,j)='T';
            elseif (arr1(i,j)=='T' && arr2(i,j)=='A') || (arr1(i,j)=='A' && arr2(i,j)=='T') || (arr1(i,j)=='G' && arr2(i,j)=='C') || (arr1(i,j)=='C' && arr2(i,j)=='G')
                fv(i,j)='A';
            elseif (arr1(i,j)=='C' && arr2(i,j)=='A') || (arr1(i,j)=='A' && arr2(i,j)=='C') || (arr1(i,j)=='G' && arr2(i,j)=='T') || (arr1(i,j)=='T' && arr2(i,j)=='G')
                fv(i,j)='G';
            else
                fv(i,j)='C';
            end
        end
    end
end
