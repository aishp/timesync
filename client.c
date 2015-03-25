#include<libstorm.c>
#define cport 49152 //time sync port
#define TS_SYMBOLS \
	{ LSTRKEY("ts_init"), LFUNCVAL(ts_init)}, \

static const LUA_REG_TYPE ts_meta_map[] =
{
 {LSTRKEY("sync"), LFUNCVAL(sync)},
 {LSTRKEY("show_time"), LFUNCVAL(show_time)},
 {LSTRKEY("__index", LROVAL( ts_meta_map)},
 { LNILKEY, LNILVAL }
};

uint8_t drift = 0;
uint8_t mtime, ctime; //master time and client time

/*struct timeseries
{
	int index;
	uint16_t ctime;
	uint16_t mtime;
};*/

struct ts
{
	uint8_t drift;
	int sign;
	//uint16_t cport = 49152;
	storm_socket_t *csock;
}

int udpsocket_callback(lua_State *L)
{
	const char *pay = lua_tostring(L,1);
	char *srcip = lua_tostring(L,2);
	uint16_t srcport = lua_tonumber(L,3);
	mtime = (uint16_t)atoi(pay);
//	struct *obj = lua_touserdata(lua_gettable(L, table_index));
	lua_pushlightfunction(L, libstorm_os_now);
	lua_pushnumber(L,0);
	lua_call(L,1,1);
	ctime= (uint8_t)lua_tonumber(L, -1);
		
	
}

int init(lua_State *L)
{

	//lua_newtable(L);
	//int table_index= lua_gettop(L);
	//lua_pushstring(L, "TS_Object");
	//struct timeseries *ts = lua_newuserdata(L, sizeof(struct timeseries));
	//lua_settable(L, table_index);
	
	struct ts *obj = lua_newuserdata(L, sizeof(struct ts));
	
	//obj->cport =(uint16_t)malloc(sizeof(uint16_t));
	lua_pushlightfunction(L, libstorm_net_udpsocket);
	lua_pushnumber(obj->cport);
	lua_pushlightfunction(udpsocket_callback);
	lua_call(L,2,0);
	obj->csock=lua_touserdata(L,-1);
	
	lua_pop(L,1);
	lua_pushrotable(L, (void*)ts_meta_map);
	lua_setmetatable(L,-2);
	return 1;

}


int sync(lua_State *L)
{
	struct *obj = lua_touserdata(L, 1);
	if(mtime > ctime)
	{
		obj->drift = mtime - ctime;
		obj->sign = 1;
	}	
	else if (mtime < ctime)
	{
		obj->drift = ctime - mtime;
		obj->sign =0;
	}

	else
	{
		obj->drift = 0;
		obj->sign = 1;
	}

	return 0;
}



