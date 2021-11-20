function startup(work_dir)
%startup - 初始化操作
%
% Syntax: startup(input)
%
% Long description

    % load data
    if exist('WORK_VAR.mat', 'file') == 2
        WorkState = matfile('WORK_VAR.mat');
    else
        WORK_DIR = 0;
        WORK_ENV = 0;
        save('WORK_VAR','WORK_DIR','WORK_ENV');
        WorkState = matfile('WORK_VAR.mat');
    end

    

    % ----- 配置工作目录 -----
    if  WorkState.WORK_DIR ~= 0
        cd(userpath);
        disp("[Tips]:Welcome back, Mr. Zhao! ");
        % cprintf('*blue', '[Tips]:Welcome back, Mr.Zhao !\n');
    else
        disp("[Tips]:Initializing the workspace ... ... ");
        % cprintf('*blue', '[Tips]:Initializing the workspace ... ...\n');

        % ---------------------------------------
        % 方式一：绝对路径
        % work_path = 'E:\WorkStation\MatlabStation';
        % config_path = strcat(work_path, '\config');
        % 方式二：相对路径
        % str = pwd;
        % index_dir = strfind(str,'\');
        % work_path = str(1 : index_dir(end)-1);
        % config_path = strcat(work_path, '\config');
        % 方式三：接收输入地址
        % work_path = work_dir;
        % config_path = strcat(work_path, '\config');

        if nargin == 0
            % 相对路径(默认当前目录的上一级目录作为工作目录)
            str = pwd;
            index_dir = strfind(str,'\');
            work_path = str(1 : index_dir(end)-1);
            config_path = strcat(work_path, '\config');
        elseif nargin == 1
            % 接收输入地址作为工作目录
            work_path = work_dir;
            config_path = strcat(work_path, '\config');
        else
            error('use error');
        end
        % ---------------------------------------

        if strcmp(userpath, work_path) ~= 1
            userpath(work_path); 
        end  
        % startup添加到环境变量  
        addpath(config_path);
        % 保证以任何方式启动MATLAB都以指定工作目录启动
        cd(userpath);
        disp("[Tips]:Initialization succeeded! ");
        % cprintf('*blue', '[Tips]:Initialization succeeded!\n')
        % 工作空间初始化完成
        WorkState.Properties.Writable = true;
        WorkState.WORK_DIR = 1;
    end


    % ----- 配置工作环境 -----
    if WorkState.WORK_ENV ~= 0
        disp("[Tips]:Everything is ready! ");
        % cprintf('*blue', '[Tips]:Everything is ready!\n');
    else
        disp("[Tips]:Loading the development environment ... ... ");
        % cprintf('*blue', '[Tips]:Loading the development environment ... ...\n ');
        % 环境一：机器人工具箱
        if exist('./config/support/Robotics Toolbox for MATLAB', 'file') == 7
            disp("[Tips]:Loading <Robotics Toolbox for MATLAB> ......");
            % cprintf('*blue', '[Tips]:Loading <Robotics Toolbox for MATLAB> ......\n');
            addpath('./config/support/');
            addpath('./config/support/Robotics Toolbox for MATLAB/lib/common');
            addpath('./config/support/Robotics Toolbox for MATLAB/lib/spatial-math');
            addpath('./config/support/Robotics Toolbox for MATLAB/data');
            addpath('./config/support/Robotics Toolbox for MATLAB/mex');
            addpath('./config/support/Robotics Toolbox for MATLAB/models');
            addpath('./config/support/Robotics Toolbox for MATLAB');
            addpath('./config/support/Robotics Toolbox for MATLAB/examples');
            addpath('./config/support/Robotics Toolbox for MATLAB/Apps');
            addpath('./config/support/Robotics Toolbox for MATLAB/simulink');
            addpath('./config/support/Robotics Toolbox for MATLAB/demos');
            savepath;
            disp("[Tips]:Successfully loaded！");
            % cprintf('*blue', '[Tips]:Successfully loaded！\n');
        else
            warning("@机器人工具加载失败！请检查环境目录设置！");
        end
        % 环境而：cprintf函数
        if exist('.\config\support\cprintf - display formatted colored text in Command Window') == 7
            disp("[Tips]:Loading <cprintf> ...... ");
            addpath('.\config\support\cprintf - display formatted colored text in Command Window');
            savepath;
            disp("[Tips]:Successfully loaded！")
        end
        % 工作环境初始化完成
        WorkState.Properties.Writable = true;
        WorkState.WORK_ENV = 1;
    end

    % clear Cache data 
    
    WorkState.Properties.Writable = false;
    % save('WORK_VAR','WorkState.WORK_DIR','WorkState.WORK_ENV');
    clear;

end