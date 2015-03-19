#include<libstorm.c>
#define cport 49152 //time sync port
#define TS_SYMBOLS \
	{ LSTRKEY("ts_init"), LFUNCVAL(ts_init)}, \

static const LUA_REG_TYPE ts_meta_map[] =
{




	{ LNILKEY, LNILVAL }
};

struct timeseries
{
	int index;
	uint16_t ctime;
	uint16_t mtime;
};

int udpsocket_callback(lua_State *L)
{
	const char *pay = lua_tostring(L,1);
	char *srcip = lua_tostring(L,2);
	uint16_t srcport = lua_tonumber(L,3);
	uint16_t master_time = (uint16_t)atoi(pay);
	struct *obj = lua_touserdata(lua_gettable(L, table_index));
	
	
}

int init(lua_State *L)
{

	lua_newtable(L);
	int table_index= lua_gettop(L);
	lua_pushstring(L, "TS_Object");
	struct timeseries *ts = lua_newuserdata(L, sizeof(struct timeseries));
	lua_settable(L, table_index);
	
	lua_pushlightfunction(L, libstorm_net_udpsocket);
	lua_pushnumber(cport);
	lua_pushlightfunction(udpsocket_callback);
	lua_call(L,2,0);

}
int sync(lua_State *L)
{
	

}
