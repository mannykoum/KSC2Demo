function darkenAxes(axes)
% gives the axes object "axes" a dark theme, unlike the default light 
%
% Axes Properties to be Modified:
% Box, color of axes, background color, grid color, grid visibility
% minor grid color, minor grid visibility, title color

axes.Box = 'on';
axes.XColor = 'w'; axes.YColor = 'w';
axes.Color = 'k';
axes.GridColor = 'w';
axes.XGrid = 'on'; axes.YGrid = 'on';
axes.MinorGridColor = 'w';
axes.XMinorGrid = 'on'; axes.YMinorGrid = 'on';
axes.Title.Color = 'w';
