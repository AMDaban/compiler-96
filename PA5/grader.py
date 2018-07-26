from os import listdir
from os.path import isfile, join


def main():
	
	diff_files = [("grading/test-output/"+f) for f in listdir("grading/test-output") if f[-1] == 'f']
	mark = 63
	for file in diff_files:
		with open (file) as f :
			data = f.readline()[:3]
			if(data != "5c5"):
				mark-=1
			print("Difference_hash = " + data)

	print("Final_score according to fixed_grader = " + str(mark))

		



if __name__ == '__main__':
	main()
