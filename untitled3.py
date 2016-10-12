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
          
          for f2 in files:
                  if os.path.splitext(f2)[1] == '.png':
                      f12 = p1+c+f2
                      b = gis.generate_signature(f12)
                      name2,ext = os.path.splitext(f2)
                      print f1
                      print f2
                      mat[name1,name2] = gis.normalized_distance(a, b)