% display

function displayActivityLabel(label)

assert(length(label)==6)
if nnz(label==1)~=1 || nnz(label==-1)~=length(label)-1
    msg = 'not recognizable.';
else
    switch find(label==1)
        case 1
            msg = 'boxing';
        case 2
            msg = 'handclapping';
        case 3
            msg = 'handwaving';
        case 4
            msg = 'jogging';
        case 5
            msg = 'running';
        case 6
            msg = 'walking';
        otherwise
            msg = 'not recognizable.';
    end
end

figure;
axis([0 100 0 100]);
text(50,50,msg,'Color','g','FontSize',50,'HorizontalAlignment','center');
axis off;

end