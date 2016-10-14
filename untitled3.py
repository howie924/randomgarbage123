import os
from image_match.goldberg import ImageSignature
import fnmatch
import numpy


gis = ImageSignature()

p1 = "C:\Users\Haowen\Desktop\project\sift-matlab-exp\siftDemoV4\data"
c = "\\"
d = "r"

print len(fnmatch.filter(os.listdir(p1), '*.png'))


mat = numpy.zeros(shape=(len(fnmatch.filter(os.listdir(p1), '*.png'))+1,len(fnmatch.filter(os.listdir(p1), '*.png'))+1))

files = os.listdir(p1)
for f1 in files:
      if os.path.splitext(f1)[1] == '.png':
          f11 = p1+c+f1
          a = gis.generate_signature(f11)
          name1,ext = os.path.splitext(f1)
          print name1
          
          for f2 in files:
                  if os.path.splitext(f2)[1] == '.png':
                      f12 = p1+c+f2
                      b = gis.generate_signature(f12)
                      name2,ext = os.path.splitext(f2)
                      if int(name2)>int(name1):
                          mat[name1,name2] = gis.normalized_distance(a, b)
#                          if name1 == '3':
  #                            print 'name1 == 3'
 #                             print name1
#                              print name2
#                              if int(name2) >10:
   #                               print 'name2 > 10'
    #                              print name2
     #                             print gis.normalized_distance(a, b)
                         
#print mat
for i in range(len(mat)):  
    for j in range(len(mat)):
        if j<i:
            mat[i,j] = mat[j,i]
        elif i==j:
            mat[i,j] = 1
        
                          
                          
                          
matindex = numpy.zeros(shape=(len(fnmatch.filter(os.listdir(p1), '*.png'))+1,len(fnmatch.filter(os.listdir(p1), '*.png'))+1))


for i in range(len(mat)):
    v = mat[i,:]
#    print v
    matindex[i,:] = sorted(range(len(v)), key=lambda x: v[x])
#    print v
#    print mat[i,:]
#    print matindex1[i,:]
    mat[i,:] = sorted(mat[i,:])
#    print matindex1[i,:]
#    print mat[i,:]


#print matindex
#print mat
