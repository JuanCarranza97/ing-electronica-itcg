import numpy as np
import cv2
    
def main():
    """We need to create a new instance of video capture,
       this will save de current frame of our video"""
    video=cv2.VideoCapture(0)
    
    while(True):
        image_complete,video_frame= video.read()
        
        if image_complete:        
            #Add a single message to the Video Frame
            cv2.putText(video_frame,"Press B to Close ...",(370,410),cv2.FONT_ITALIC,.8,(255,255,255),1,cv2.LINE_AA)
            
            #Show the video frame with the message 
            cv2.imshow("Video",video_frame)
            """Press B to termita test"""
            if cv2.waitKey(1) & 0xFF == ord('b'):
                break
    video.release()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    #Create a new video instance 
    main()


    

        