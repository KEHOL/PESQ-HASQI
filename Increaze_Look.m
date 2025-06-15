function Increaze_Look(Fig_of_Element,Delta_point,Start_OF_Point,End_OF_Point)

Numbers_of_iterations=ceil((End_OF_Point-Start_OF_Point)/Delta_point);
%calculate of numbers of iteration to become end of point
        [an_vertical_itrations,an_horizontal_iterations]=label2creation(Numbers_of_iterations);
        % calculate to crate a label side

    axis_out=findall(figure(Fig_of_Element),'type','axes'); %capture all data from figure
Fig_exit_of_Element = figure('name',append(axis_out.Title.String,' from ',num2str(Start_OF_Point),' to ',num2str(End_OF_Point)));
set(gcf, 'WindowState', 'maximized');


    for Number_Iterate = 1:Numbers_of_iterations
 %create subplots to look side by side with delta of go
subplot(an_vertical_itrations,an_horizontal_iterations,Number_Iterate);
    copyobj(allchild(axis_out),gca); %give data back to build up

title(append(axis_out.Title.String,' from ',num2str(Start_OF_Point+Delta_point*(Number_Iterate-1)),' to ',num2str(Start_OF_Point+Delta_point*(Number_Iterate))));
    xlabel(axis_out.XLabel.String); 
    ylabel(axis_out.YLabel.String);
xlim([Start_OF_Point+Delta_point*(Number_Iterate-1) Start_OF_Point+Delta_point*(Number_Iterate)]);
grid on
    end
                                            %=== Global_export ===
                                    global Save_img; global type_save_img;
                                            %=====================
                Do_Save_an_img(Fig_exit_of_Element,Save_img,type_save_img) %=====save as img======
end