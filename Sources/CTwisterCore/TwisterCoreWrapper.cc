//
//  TwisterCoreWrapper.cc
//  CTwisterCore
//
//  Created by Amr Aboelela on 2/18/21.
//

#include "bitcoinrpc.h"
#include <string>

using namespace json_spirit;
using namespace std;

static char *CopyString(const std::string& str) {
    char *result = reinterpret_cast<char*>(malloc(sizeof(char) * str.size()));
    memcpy(result, str.data(), sizeof(char) * str.size());
    return result;
}

extern "C" long twisterCoreGetPosts(char *username, long usernameLength, long max, void **result, long *resultLength) {
    
    //map<string, string> parameterMap = parseQuery(uri);
    int theMax = max; //default value
    //string account = "bbc_world"; //parameterMap["account"];
    //string strMax = parameterMap["max"];
    string author = "bbc_world"; //parameterMap["author"];
    /*if (strMax!="") {
        try {
            max = boost::lexical_cast<int>(strMax);
        }
        catch(boost::bad_lexical_cast e) {
            return RSS_ERROR_NOT_A_NUMBER;
        }
    }*/
    
    //const Array emptyArray;
    //Array accountsArray = listwalletusers(emptyArray, false).get_array();
    
    /*
    // if no account was specified, choose the first one
    if (account=="") {
        if(accountsArray.size()>0) {
            account = accountsArray[0].get_str();
        }
        else return RSS_ERROR_NO_ACCOUNT;
    }
    // if an account name was specified, check that it exists
    else {
        bool accountExists = false;
        for(int i=0;i<accountsArray.size();i++)
        {
            if(accountsArray[i]==account)
                accountExists=true;
        }
        if(!accountExists) return RSS_ERROR_BAD_ACCOUNT;
    }*/
    
    // get an array of followed usernames and transform it to required format
    //Array params1;
    //params1.push_back(account);
    //Array followingArray = getfollowing(params1,false).get_array();
    Array postSources;
    
    /*if (author=="") {
        // default fetch posts from all followed authors
        for(int i=0;i<followingArray.size();i++) {
            Object item;
            item.push_back(Pair("username",followingArray[i]));
            postSources.push_back(item);
        }
    } else {*/
    // a single author has been specified to fetch posts from
    Object item;
    item.push_back(Pair("username", author));
    postSources.push_back(item);
    //}
    
    Array params2;
    params2.push_back(theMax);
    params2.push_back(postSources);
    Array posts = getposts(params2, false).get_array();
    //vector<Object> outputVector;
    string postMessages = "";
    for (int i=0; i<posts.size(); i++) {
        try {
            Object userpost = find_value(posts[i].get_obj(), "userpost").get_obj();
            string postTitle, postAuthor, postMsg;
            Value rt = find_value(userpost, "rt");
            
            if (rt.is_null()) {    // it's a normal post
                postAuthor = find_value(userpost,"n").get_str();
                /*Value reply = find_value(userpost,"reply");
                if(!reply.is_null()&&find_value(reply.get_obj(),"n").get_str()==account)
                {
                    postTitle = "Reply from "+postAuthor;
                }
                else postTitle = postAuthor;*/
                postMsg = find_value(userpost, "msg").get_str();
            } else { // it's a retwist
                postAuthor = find_value(rt.get_obj(),"n").get_str();
                postTitle = postAuthor + " - via " + find_value(userpost,"n").get_str();
                postMsg = find_value(rt.get_obj(), "msg").get_str();
            }
            
            Value postTime = find_value(userpost, "time");
            //encodeXmlCharacters(postMsg);
            fprintf(stdout, "postMsg: %s", postMsg.c_str());
            postMessages = postMessages + postMsg;
            /*Object item;
            item.push_back(Pair("time", postTime));
            item.push_back(Pair("title", postTitle));
            item.push_back(Pair("author", postAuthor));
            item.push_back(Pair("msg", postMsg));*/
            //outputVector.push_back(item);
        } catch(exception ex) {
            fprintf(stderr, "Warning: RSS couldn't parse a public post, skipping.\n");
            continue;
        }
    }
    *result = CopyString(postMessages);
    *resultLength = postMessages.size();
    return 0;
}

/*
static leveldb::ReadOptions readOptions;
static leveldb::WriteOptions writeOptions;

static char *CopyString(const std::string& str) {
    char *result = reinterpret_cast<char*>(malloc(sizeof(char) * str.size()));
    memcpy(result, str.data(), sizeof(char) * str.size());
    return result;
}

#pragma mark - Database

extern "C" void *levelDBOpen(char *path) {
    
    leveldb::Options options;
    options.create_if_missing = true;
    options.paranoid_checks = false;
    options.error_if_exists = false;
#if defined(__linux)
    //printf("levelDBOpen in Linux\n");
#else
    //printf("levelDBOpen in iOS\n");
    options.compression = leveldb::kSnappyCompression;
#endif
    
    readOptions.fill_cache = true;
    writeOptions.sync = false;
    leveldb::DB *db;
    leveldb::Status status = leveldb::DB::Open(options, path, &db);
    
    if (!status.ok()) {
        printf("Problem creating LevelDB database: %s\n", status.ToString().c_str());
        char *lockStr = "/LOCK";
        char *lockPath;
        if ((lockPath = (char *)malloc(strlen(path)+strlen(lockStr)+1)) != NULL) {
            lockPath[0] = '\0';   // ensures the memory is an empty string
            strcat(lockPath,path);
            strcat(lockPath,lockStr);
        } else {
            printf("malloc failed!\n");
            // exit?
        }
        long fd = open(lockPath, O_RDWR | O_CREAT, 0644);
        if (LockOrUnlock(fd, false) != -1) {
            printf("Was able to unlock the databse\n");
        } else {
            printf("Couldn't unlock the databse\n");
            return NULL;
        }
        status = RepairDB(path, options);
        if (status.ok()) {
            printf("Was able to repair databse\n");
        } else {
            printf("Couldn't repair databse\n");
            return NULL;
        }
        status = leveldb::DB::Open(options, path, &db);
        if (!status.ok()) {
            printf("Problem creating LevelDB database: %s\n", status.ToString().c_str());
            return NULL;
        }
    }
    return db;
}*/
