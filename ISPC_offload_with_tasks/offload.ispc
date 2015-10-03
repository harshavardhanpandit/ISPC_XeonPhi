export void foo(const uniform int n,
    			uniform float data[])
{
	foreach (i=0...n)
	{
		#ifdef __MIC__
			data[i] = 2.5;
		#else
			data[i] = 1.5;
		#endif
	}
}


task void foo_task(uniform int elementsPerTask, uniform float data[])
{
	uniform int start = taskIndex * elementsPerTask;
    uniform int end = start + elementsPerTask;

    foreach (i = start ... end)
	{
		#ifdef __MIC__
			data[i] = 2.5;
		#else
			data[i] = 1.5;
		#endif
	}


}

export void foo_with_task(const uniform int n,
    					  uniform float data[])
{
	uniform int elementsPerTask = n / 2;

	launch[2] foo_task(elementsPerTask, data);

}