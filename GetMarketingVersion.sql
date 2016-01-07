/* 
  Licensed under MIT License (MIT)

  Copyright (c) 2015 Kennie Nybo Pontoppidan

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.  
*/

if object_id(N'GetMarketingVersion', 'FN' ) is not null
  drop function GetMarketingVersion
go

create function GetMarketingVersion()
returns nvarchar(10)
as 
begin
  declare @ProductVersion   sysname = convert(sysname, serverproperty('ProductVersion'))
        , @MarketingVersion sysname;

  set @MarketingVersion = 
    case 
      when @ProductVersion LIKE '8%' then '2000'
      when @ProductVersion LIKE '9%' then '2005'
      when @ProductVersion LIKE '10.00%' then '2008'
      when @ProductVersion LIKE '10.50%' then '2008R2'
      when @ProductVersion LIKE '11%' then '2012'
      when @ProductVersion LIKE '12%' then '2014'
	  when @ProductVersion LIKE '13%' then '2016'
      else null
    end

  return @MarketingVersion;
end
go

select dbo.GetMarketingVersion() as version
