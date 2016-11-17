/********************************************************

KINECKoneMOUSE V0.4
Control of the movement of the mouse using a Kinect One.
Control de movimiento del mouse usando un Kinect One.
https://github.com/hiteclab/KINECKoneMOUSE

*********************************************************
ENGLISH
*********************************************************

Developed by Jose David Cuartas
Hypermedia Lab of Technologies for Communication
University Los Libertadores
2016, Bogotá, Colombia.
GPL license V3

This code is based in the example: "3D Skeleton" 
Made by Thomas Sanchez Lengeling
For the Kinect v2 for Windows library for processing

***********************************************************
ESPAÑOL
***********************************************************

KINECKoneMOUSE V0.4
Desarrollado por Jose David Cuartas Correa
Laboratorio Hipermedia de Tecnologias para Comunicación
Fundación Universitaria Los Libertadores
Bogotá, Colombia, 2015.
Licencia GPL Versión 3 

Este código se basa en el ejemplo: "3D Skeleton" 
Desarrollado por Thomas Sanchez Lengeling
Para la Librería Kinect v2 for Windows de Processing
********************************************************/

import KinectPV2.*;


import javax.swing.*;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent; 

int mousebutton=-1;
Robot mouse;

KinectPV2 kinect;
float hx=0, hy=0, hz, lx, ly, rx, ry;


void setup() {
  size(displayWidth, displayHeight);
  
  kinect = new KinectPV2(this);
  kinect.enableSkeleton3DMap(true); // read (x,y,z) positions of each joint
  //kinect.enableColorImg(true);
  kinect.init();
  
   try
  {
    mouse = new Robot();
  }
  catch (AWTException e)
  {
    println("Java Robot not supported");
    exit();
  }
  
}

void draw() {
  background(0);
  
  //image(kinect.getColorImage(), 0, 0, 800, 600); // show the image of the camera at 800x600 resolution

  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();

  // Read joints from Skeleton
  for (int i = 0; i < skeletonArray.size(); i++) {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();
      keyjoints(joints);
    }
  }

  fill(255);
  rect(hx,hy,10,10); // head (white rect)
  fill(255,0,0);
  rect(lx,ly,10,10); // left hand (red rect)
  fill(0,255,0);
  rect(rx,ry,10,10); // right hand (green rect)
  
  if(mousebutton==1){
    
    // Move the mouse with the right hand
    mouse.mouseMove(int(rx), int(ry));
    
    // Press left click of the mouse
    if (ly<150) {
      rect(width-100,0,100,100);
      mouse.mousePress(InputEvent.BUTTON1_MASK);
      mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    } /*else
  
    if (ly>height-100) {
      rect(width-100,0,100,100);
      mouse.mousePress(InputEvent.BUTTON3_MASK);
      mouse.mouseRelease(InputEvent.BUTTON3_MASK);    
    }*/
  }
text("Hitec Lab, Fundación Universitaria Los Libertadores, Bogotá, Colombia, 2016.",20,20);

}


void keyjoints(KJoint[] joints) {
  
                     //KinectPV2.JointType_HandRight
  rx= (width/2+(joints[KinectPV2.JointType_HandRight].getX()*width));
  ry= (height-(joints[KinectPV2.JointType_HandRight].getY()*height));
  
                     //KinectPV2.JointType_HandLeft
  lx= (width/2+(joints[KinectPV2.JointType_HandLeft].getX()*width));
  ly= (height-(joints[KinectPV2.JointType_HandLeft].getY()*height));
                     //KinectPV2.JointType_Head
  hx= (width/2+(joints[KinectPV2.JointType_Head].getX()*width));
  hy= (height-(joints[KinectPV2.JointType_Head].getY()*height));

}

void keyPressed(){
if(key==' ')mousebutton=mousebutton*-1;;
}