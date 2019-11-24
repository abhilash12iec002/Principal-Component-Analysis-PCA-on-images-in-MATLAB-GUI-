function varargout = PCA_final(varargin)
% PCA_FINAL MATLAB code for PCA_final.fig
%      PCA_FINAL, by itself, creates a new PCA_FINAL or raises the existing
%      singleton*.
%
%      H = PCA_FINAL returns the handle to a new PCA_FINAL or the handle to
%      the existing singleton*.
%
%      PCA_FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCA_FINAL.M with the given input arguments.
%
%      PCA_FINAL('Property','Value',...) creates a new PCA_FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PCA_final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PCA_final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PCA_final

% Last Modified by GUIDE v2.5 05-Nov-2019 15:00:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PCA_final_OpeningFcn, ...
                   'gui_OutputFcn',  @PCA_final_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PCA_final is made visible.
function PCA_final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PCA_final (see VARARGIN)

% Choose default command line output for PCA_final
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PCA_final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PCA_final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


a=imread('iiserb3.jpg');
imshow(a)
alpha(.2)

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[filename,filepath]=uigetfile({'*.png;*.jpg;*.JPG; *.jpeg; *.JPEG; *.img; *.IMG; *.tif; *.TIF; *.tiff, *.TIFF'},'Select and image');
axes(handles.axes2);
imshow((filename));
imread(filename);
whos
imwrite(ans,'myGray.png')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3);
a=imread('myGray.png');
g_image=rgb2gray(a);
imshow(g_image)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes4);
c_img=imread('myGray.png');
g_image=rgb2gray(c_img);
nComp=str2double(get(handles.edit1, 'String'))

if isnan(nComp)
   fprintf('Entry "%s" is not a valid number!\n', nComp);
    errordlg('Input must be a number','Error');
   return
end
 sizePC=size(c_img);
 MaxPC= sizePC(2);
if nComp>MaxPC
   
    errordlg('Entered no. is greater than the number of PCs','Error');
   return
 end




g_image_d=double(g_image);
g_image_d_m=mean(g_image_d);
g_image_d_m_adjusted=(g_image_d-g_image_d_m);
[coeff,score,latent,~,explained] = pca(g_image_d_m_adjusted);
reconstruction = score(:,1:nComp)*coeff(:,1:nComp)';
final_reconstruction=(reconstruction+g_image_d_m);
final_reconstruction=uint8(final_reconstruction);
imshow(final_reconstruction)
axes(handles.axes5);
d_c_imgr=double(c_img(:,:,1));
d_c_img_mr=mean(d_c_imgr);
d_c_img_m_adjustedr=(d_c_imgr-d_c_img_mr);
[coeffr,scorer,latentr,~,explainedr] = pca(d_c_img_m_adjustedr);
r_reconstruction = scorer(:,1:nComp)*coeffr(:,1:nComp)';
r_final_reconstruction=(r_reconstruction+d_c_img_mr);
r_final_reconstruction=uint8(r_final_reconstruction);


d_c_imgg=double(c_img(:,:,2));
d_c_img_mg=mean(d_c_imgg);
d_c_img_m_adjustedg=(d_c_imgg-d_c_img_mg);
[coeffg,scoreg,latentg,~,explainedg] = pca(d_c_img_m_adjustedg);
g_reconstruction = scoreg(:,1:nComp)*coeffg(:,1:nComp)';
g_final_reconstruction=(g_reconstruction+d_c_img_mg);
g_final_reconstruction=uint8(g_final_reconstruction);

d_c_imgb=double(c_img(:,:,3));
d_c_img_mb=mean(d_c_imgb);
d_c_img_m_adjustedb=(d_c_imgb-d_c_img_mb);
[coeffb,scoreb,latentb,~,explainedb] = pca(d_c_img_m_adjustedb);
b_reconstruction = scoreb(:,1:nComp)*coeffb(:,1:nComp)';
b_final_reconstruction=(b_reconstruction+d_c_img_mb);
b_final_reconstruction=uint8(b_final_reconstruction);
im=cat(3,r_final_reconstruction,g_final_reconstruction,b_final_reconstruction);
%Image=ind2rgb(final_reconstruction, map);
%subplot(2,2,4)
imshow(im)
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  %replace editbox_5 with actual name of edit box



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.

% Hint: place code in OpeningFcn to populate axes1
