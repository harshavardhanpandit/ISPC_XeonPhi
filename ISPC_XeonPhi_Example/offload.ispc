export void foo(
    const uniform int n,
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
