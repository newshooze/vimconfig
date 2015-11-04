:insert
ifstream filestream("".c_str());
if(filestream.is_open())
{
	std::string textline;
	while(filestream.good())
	{
		std::getline(filestream,textline,'\n');
	}
}
