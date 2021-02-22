//
//  TwisterCoreWrapper.cc
//  twistercore
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
    int theMax = max;
    string author = "bbc_world";
    // get an array of followed usernames and transform it to required format
    //Array params1;
    //params1.push_back(account);
    //Array followingArray = getfollowing(params1,false).get_array();
    Array postSources;
    Object item;
    item.push_back(Pair("username", author));
    postSources.push_back(item);
    
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

extern "C" void *levelDBOpen(char *path) */
