function [out_sorted_a,out_sorted_b] = label2creation(Number_un_sorted)
%find which side of label can be create:
    switch Number_un_sorted
                 case 2; out_sorted=[2 1];    
                 case 3; out_sorted=[3 1];
                 case 5; out_sorted=[2 3];    
                 case 6; out_sorted=[2 3];
                case 10; out_sorted=[5 2];
                case 11; out_sorted=[4 3];    
                case 12; out_sorted=[4 3];
                case 13; out_sorted=[5 3];
                case 14; out_sorted=[5 3];   
                case 15; out_sorted=[5 3];
                case 17; out_sorted=[5 4];    
                case 18; out_sorted=[5 4];
                case 19; out_sorted=[5 4];
                case 20; out_sorted=[5 4];    
          otherwise
            out_sorted=[ceil(sqrt(Number_un_sorted)) ceil(sqrt(Number_un_sorted))];
         end
%export data of label creation
out_sorted_a=out_sorted(1);
out_sorted_b=out_sorted(2);
end