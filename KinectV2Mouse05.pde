/*
KINECKoneMOUSE V0.4
by Jose David Cuartas
Hypermedia Lab of technologies for Communication
Faculty of Communication Sciences
University Los Libertadores
2016, Bogotá, Colombia.
GPL license V3

This code is based in the example: "3D Skeleton" 
Made by Thomas Sanchez Lengeling
For the Kinect for Windows v2 library for processing

KINECKoneMOUSE V0.4
por Jose David Cuartas Correa
Laboratorio Hipermedia de Tecnologias para Comunicación
Facultad de ciencias de la Comunicación
Fundación Universitaria Los Libertadores
Bogotá, Colombia, 2015.
Licencia GPL Versión 3 

Este código se basa en el ejemplo: "3D Skeleton" 
Desarrollado por Thomas Sanchez Lengeling
Para la Librería Kinect for Windows v2 de Processing

*/

import KinectPV2.*;


import javax.swing.*;
import java.awt.Robot;
import java.awt.AWTException;
import java.awt.event.InputEvent; 

int mouse=-1;
Robot robby;

KinectPV2 kinect;
float hx=0, hy=0, hz, lx, ly, rx, ry;


void setup() {
  size(displayWidth, displayHeight);
  
  kinect = new KinectPV2(this);
  kinect.enableSkeleton3DMap(true); // read (x,y,z) positions of each joint
  kinect.init();
  
   try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
  
}

void draw() {
  background(0);

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
  
  if(mouse==1)robby.mouseMove(int(rx), int(ry));// +1366

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
if(key==' ')mouse=mouse*-1;;
}