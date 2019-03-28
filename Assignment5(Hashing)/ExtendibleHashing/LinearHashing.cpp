#include <bits/stdc++.h>

using namespace std;

struct Bucket{
    list <int> bucket;
};

struct table{
    vector <Bucket *> dir;
    int splitIndex;
    int level;
    int n;
    int bucketSize;
};
int twoPower(int p){
	return 1<<p;
}
void createTable(int n,table * &linearHash,int bucketSize){
    linearHash->dir.resize(n);
    linearHash->level = 0;
    linearHash->n = n;
    linearHash->bucketSize = bucketSize;
    for(int i=0;i<n;i++){
        linearHash->dir[i] = new Bucket;
    }
    linearHash->splitIndex = 0;
}

void split(table * &linearHash){
    // cout<<linearHash->splitIndex<<endl;
    int index = twoPower(linearHash->level)*linearHash->n + linearHash->splitIndex;
    // cout<<index<<endl;
    linearHash->dir.push_back(new Bucket);

    list<int> &firstBucket = linearHash->dir[linearHash->splitIndex]->bucket;
	list<int> &secondBucket = linearHash->dir[index]->bucket;
	/*distributing values to two buckets*/
	for(auto itr=firstBucket.begin();itr!=firstBucket.end();){
        // cout<<*itr<<" "<<*itr % (twoPower(linearHash->level + 1) * linearHash->n)<<endl;
		if((*itr % (twoPower(linearHash->level + 1) * linearHash->n))==index){
            cout<<*itr<<" split from "<<linearHash->splitIndex<<" and inserted at "<<index<<endl;
			secondBucket.push_back(*itr);
			itr = firstBucket.erase(itr);
		}
		else itr++;
	}
    linearHash->splitIndex++;
    if(linearHash->splitIndex % (twoPower(linearHash->level)*linearHash->n)==0){
        // cout<<"yes"<<endl;
        linearHash->splitIndex = 0;
        linearHash->level++;
    }
}

void insert(int x,table *&linearHash){
    int mod = twoPower(linearHash->level)*linearHash->n;
    int index = x%mod;
    linearHash->dir[index]->bucket.push_back(x);
    cout<<x<<" inserted at "<<index<<endl;
    if(linearHash->dir[index]->bucket.size()>linearHash->bucketSize){
        split(linearHash);
        // cout<<"ds"<<endl;
    }    
}

bool search(int x,table *linearHash){
    int mod = twoPower(linearHash->level)*linearHash->n;
    int index = x % mod;
    for(auto itr = linearHash->dir[index]->bucket.begin(); itr!=linearHash->dir[index]->bucket.end(); itr++){
		if(*itr==x)
			return true;
    }
    return false;
}

void deleteKey(int x,table *linearHash){
    int mod = twoPower(linearHash->level)*linearHash->n;
    int index = x % mod;
    for(auto itr = linearHash->dir[index]->bucket.begin(); itr!=linearHash->dir[index]->bucket.end(); itr++){
		if(*itr==x){
			linearHash->dir[index]->bucket.erase(itr);
            cout<<"Deleted "<<x<<endl;
            return;
		}
    }
    cout<<"Delete fail"<<x<<endl;
}

int main(){
    int n=2;
    // cin>>n;
    table *linearHash = new table;  
    createTable(n,linearHash,1);
    
    insert(1,linearHash);
    insert(2,linearHash);
    insert(3,linearHash);
    insert(5,linearHash);
    insert(8,linearHash);
    insert(13,linearHash);
    insert(21,linearHash);
    if(search(8,linearHash))
        cout<<"8 found"<<endl;
    if(search(14,linearHash))
        cout<<"14 found"<<endl;
    deleteKey(8,linearHash);
    if(search(8,linearHash))
        cout<<"8 found"<<endl;
    deleteKey(14,linearHash);
    return 0;
}
