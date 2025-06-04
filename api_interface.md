# Character Interfaces
---
`Version: V0.1 2023-06-15`

Update record: 

| Date      | Version   | Explanation     | Remark |
|------------|------|--------|--------|
| 2023-06-15 | V0.1 |     |        |

# Directory

[TOC1]

---

This document describes the calling interface of the backend.

##  Unified return data format
* Unified return data format

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | code   | number | Y | status code        | '0' means success |
| 2 | msg    | string | Y | returned message content |           |
| 3 | result | javascript   | N | details   |           |
 
* Unified format:
    * fail
    ```javascript
    {
        "code": 1,
        "msg": "XXXXXX"
    }
    ```

## 0. base interface

### 0.0 get all character tag list
 * Basic Information: 

| interface description | get all character tag list |
|----------------|--------------|
| URL | /tags/complete/list     |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |
| 2 | from_app| number | Y   |   0/1    |        |
| 2 | lang| string | N   |       |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            display: [ 
                { Newest: '最新' }
            ],
            choose: [ 
                { Female: '女性'}
            ],
            interest: [],
            freeze: [ 
                { Newest: '最新'}
            ]
        }
    }
    ```

### 0.0.0 get character tag list    // deprecated
 * Basic Information: 

| interface description | get character tag list |
|----------------|--------------|
| URL | /tags/list              |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [ "Newest", "Popular", "tag1" ]
    }
    ```

### 0.1 get available tag list when create character
 * Basic Information: 

| interface description | get available tag list when create character |
|----------------|--------------|
| URL | /tags/listAvailableTags |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [ "tag1", "tag2" ]
    }
    ```

### 0.2 upload audio
* Basic Information: 

| interface description | upload audio |
|----------------|--------------|
| URL | /user/uploadAudio        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |
| 2 | audio   | file   | Y   |       |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            url: "https://xxxxxxxxxx.wav"
        }
    }
    ```

### 0.3 upload image
* Basic Information: 

| interface description | upload image |
|----------------|--------------|
| URL | /user/uploadImage        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |
| 2 | img     | file   | Y   |       |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            url: "https://xxxxxxxxxx.jpg"
        }
    }
    ```


### 0.4 get character voice list
 * Basic Information: 

| interface description | get character voice list |
|----------------|--------------|
| URL | /character/listVoices   |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | lang   | string    | N    |             |       |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            { 
                name: 'en_0',
                voice_id: 'en_0',
                preview_url: 'http://213.108.196.111:44746/samples/en_0.wav',
                meta_info: {
                    sex: "male",
                    feature: ""
                }
            },
            { 
                name: 'en_1',
                voice_id: 'en_1',
                preview_url: 'http://213.108.196.111:44746/samples/en_1.wav',
                meta_info: {
                    sex: "female",
                    feature: ""
                }
            },
        ]
    }
    ```


### 0.5 get novel tag list
 * Basic Information: 

| interface description | get novel tag list |
|----------------|--------------|
| URL | /novel/listTags         |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [ "Newest", "Popular", "tag1" ]
    }
    ```

### 0.6 get available tag list when create novel
 * Basic Information: 

| interface description | get available tag list when create novel |
|----------------|--------------|
| URL | /novel/listAvailableTags |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [ "tag1", "tag2" ]
    }
    ```

### 0.7 获取支付页面的图片
 * Basic Information: 

| interface description | get payment images |
|----------------|--------------|
| URL | /api/getPaymentImages |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [ 
            "https://storage.beyondedgellc.com/image/payment/1.gif",
            "https://storage.beyondedgellc.com/image/payment/2.gif" 
            ]
    }
    ```

### 0.8 url 记录
 * Basic Information: 

| interface description | url 记录 |
|----------------|--------------|
| URL | /notif/record/url       |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | url    | string | Y |       |       |
| 1 | org_url| string | Y |       |       |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 0.9 translate
 * Basic Information: 

| interface description | 翻译 |
|----------------|--------------|
| URL | /api/translate       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y |       |       |
| 1 | src_lang   | string | Y |       |       |
| 1 | target_lang   | string | Y |       |       |
| 1 | message   | string | Y |       |       |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: { 
            src_lang: 'en', 
            target_lang: 'zh-TW', 
            message: "hello", 
            target_msg: "你好" 
        }
    }
    ```

### 0.10 draw image
* Basic Information: 

| interface description | draw image |
|----------------|--------------|
| URL | /character/generate/image |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y  | user id      |        |
| 2 | type       | string | N  | chat/group chat |   default: chat     |
| 2 | session_id | number | Y  | session id   |        |
| 3 | is_gif     | number | Y  | 0/1   |      |
| 4 | from_app   | number | N  |       |      |
| 4 | system     | number | N  |       |      |
| 4 | lang       | string | N  |       |      |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            create_id: "xxxxxxxxxxxxxxxxx"
        }
    }
    ```
### 0.11 generate audio
* Basic Information: 

| interface description | generate audio |
|----------------|--------------|
| URL | /character/generate/audio |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y  | user id     |        |
| 2 | type       | string | N  | chat/group chat |   default: chat     |
| 2 | session_id | number | Y  |             |        |
| 3 | uniq_id    | number | Y  |             |        |
| 4 | from_app   | number | N  |       |      |
| 4 | system     | number | N  |       |      |
| 4 | lang       | string | N  |       |      |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            url: "https://xxxxxxxxxxxxxxxxx.wav",
            model_id: 10
        }
    }
    ```
### 0.12 query image/audio by create_id
* Basic Information: 

| interface description | query image/audio by create_id |
|----------------|--------------|
| URL | /character/query |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y  | user id        |        |
| 2 | create_id  | string | Y  |                |        |
| 2 | task_type  | string | Y  |    image/audio |        |
| 2 | system     | string | Y  |                |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            state: "Done",  // "Pending"
            url: "https://xxxxxxxxxxxxxxxxx.jpg"    // "xxxxxx.wav"
        }
    }
    ```

## 1. character chat related interface

### 1.0 get character profile
 * Basic Information: 

| interface description | get character profile |
|----------------|--------------|
| URL | /character/getProfile   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id      |       |
| 2 | character_id | number | Y | character id |       |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            avatar: "https://charactrxxxxxx/xxxxx.png",
            name: "Lily",
            greeting: "Hi~",
            visibility: "public",
            definitior_visibility: "public",
            long_description: "",
            short_description: "",
            tags: [ "tag1", "tag2" ],
            voices: [ "voice1", "voice2" ],
            image_generation: {
                enable: true,
                hide: true,
                style: ""
            },
            context: [
                "AI: Hi~",
                "You: Hello~"
            ],
            params: {
                temperature: 1,
                top_x: 1
            },
            creater: "ABC",
            line_count: 10000,
            role_star: 5,    // 1-5
            is_newest: true,
            is_popular: false,
            is_collect: false
        }
    }
    ```

### 1.1.1 new create character or edit character by character_id, only private can be edit
 * Basic Information: 

| interface description | new create character or edit character by character_id, only private can be edit |
|----------------|--------------|
| URL | /character/new/createOrEdit |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id               | number | Y  | user id |         |
| 2 | character_id          | number | N  |         |         |
| 3 | avatar                | string | Y  |         |         |
| 4 | appearance            | string | Y  |         |         |
| 5 | name                  | string | Y  |         |         |
| 6 | greeting              | string | N  |         |         |
| 7 | long_description      | string | Y  |         |         |
| 8 | short_description     | string | Y  |         |         |
| 9 | tags                  | array  | N  |         |         |
| 10 | voice                | string | N  |         |         |
| 11 | context              | array  | N  |         |         |
| 12 | params               | object | N  |         |         |
| 13 | lang                 | string | N  |         |         |
| 14 | charge               | number | Y  |         |         |
| 15 | sex                  | string | Y  | Male,Female,Non-Binary  |         |
| 16 | style                | string | N  | anime,2D,realistic  |         |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            character_id: 1
        }
    }
    ```


### 1.2 upload avatar   // deprecated
* Basic Information: 

| interface description | upload avatar |
|----------------|--------------|
| URL | /character/uploadAvatar |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |
| 2 | img     | file   | Y   |       |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            url: "https://xxxxxxxxxx.jpg"
        }
    }
    ```

### 1.3 generate dialog information
 * Basic Information: 

| interface description | generate dialog information |
|----------------|--------------|
| URL | /character/generatMsgs |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y    | user id   |        |
| 2 | count  | number  | Y   |   generate count    |    1~5    |
| 3 | name   | string  | Y   |      |         |
| 4 | greeting   | string  | Y   |      |         |
| 5 | long_description | string  | Y   |       |         |
| 6 | tags      | array   | Y   |        |         |
| 7 | context   | array   | Y   |         |         |
| 8 | params    | object   | Y   |         |         |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"messages":["msg1"],"done":false}}
    {"code":0,"msg":"success","result":{"messages":["msg1","msg2"],"done":true}}
    ```


### 1.5 create avatar new
* Basic Information: 

| interface description | create avatar new |
|----------------|--------------|
| URL | /character/new/createAvatar |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |
| 2 | data    | string | Y   |       |        |
| 3 | from_app | number | N  |       |        |
| 4 | sex     | string | N  |       |  `Male`, `Female`, `Non-Binary`    |
| 5 | style   | string | N  | anime,2D,realistic  |         |
| 6 | background | number | N  | 0/1  |         |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            create_id: "xxxxxxxxxxxxxxxxx"
        }
    }
    ```

### 1.6 get characters by tag
* Basic Information: 

| interface description | get characters by tag  |
|----------------|--------------|
| URL | /character/getCharactersByTag |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N   | user id   |        |
| 2 | tag     | string | Y   |           |        |
| 3 | limit   | number | Y   |           |        |
| 4 | page_no | number | Y   |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 1,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Lily",
                appearance: "big eyes",
                greeting: "Hi~",
                short_description: "",
                tags: "tag1,tag2",
                creater: "abc",
                line_count: 100000,
                role_star: 5,    // 1-5
                is_newest: true,
                is_popular: false,
                is_collect: false
            },
            {
                character_id: 2,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Mike",
                appearance: "big eyes",
                greeting: "Hi~",
                short_description: "",
                tags: "tag1,tag2",
                creater: "abc",
                line_count: 100000,
                role_star: 5,    // 1-5
                is_newest: true,
                is_popular: false,
                is_collect: false
            }
        ]
    }
    ```

### 1.7 get characters chat recently
* Basic Information: 

| interface description | get characters chat recently  |
|----------------|--------------|
| URL | /character/getCharactersChatRecently |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y    | user id   |        |
| 2 | limit   | number | Y    | number of each page   |        |
| 3 | page_no | number | Y    |            |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 1,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Lily",
                appearance: "beauty",
                session_id: 5,
                short_description: "",
                creater: "ABC"
            },
            {
                character_id: 2,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Mike",
                appearance: "beauty",
                session_id: 8,
                short_description: "",
                creater: "ABC"
            }
        ]
    }
    ```

### 1.8 get chat history by character
* Basic Information: 

| interface description | get chat history by character |
|----------------|--------------|
| URL | /character/getChatHistory |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y    | user id   |        |
| 2 | character_id  | number | Y    | character id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                session_id: 1,
                latest_chat: false,
                context: [
                    { name: "AI", content: "Hi~", star: 0, timestamp: "20230506 11:00:00", is_human: false, image: "https://xxxxxxxxxx.jpg" },
                    { name: "You", content: "Hello~", star: 0, timestamp: "20230506 11:00:00", is_human: true, image: "" }
                ],
                timestamp: "20230506 11:00:00"
            },
            {
                session_id: 2,
                latest_chat: true,
                context: [
                    { name: "AI", content: "Hi~", star: 0, timestamp: "20230506 11:00:00", is_human: false, image: "" },
                    { name: "You", content: "Hello~", star: 0, timestamp: "20230506 11:00:00", is_human: true, image: "" }
                ],
                timestamp: "20230506 11:00:00"
            }
        ]
    }
    ```

### 1.9 continue chat
* Basic Information: 

| interface description | continue chat |
|----------------|--------------|
| URL | /character/continueChat |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y  | user id        |        |
| 2 | character_id  | number | Y  | character id   |        |
| 3 | session_id    | number | N  | session id     |        |
| 4 | from_app      | number | N  |                |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 2,
            latest_chat: true,
            custom_profile: {
                username: "user name",
                age: 18,
                sex: "Female"
            },
            context: [
                { uniqId: 11, idx: 1, name: "AI", content: "Hi~", star: 0, timestamp: "20230506 11:00:00", is_human: false, audio: "http://xxxxxx.wav", image: "https://xxxxxxxxxx.jpg", create_id: "" },
                { uniqId: 13, idx: 2, name: "You", content: "Hello~", star: 0, timestamp: "20230506 11:00:00", is_human: true, audio: "", image: "", create_id: "" },
                { uniqId: 21, idx: 3, name: "AI", content: "Hello~", star: 0, timestamp: "20230506 11:00:00", is_human: true, audio: "", image: "", create_id: "xxxxxxxxx" }
            ],
            is_creater: true,
            is_generate: false  // if true, interval to request API, util is_generate=fasle
        }
    }
    ```

### 1.10 create chat session
* Basic Information: 

| interface description | create chat session |
|----------------|--------------|
| URL | /character/createChat   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y | user id        |        |
| 2 | character_id  | number | Y | character id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 1,
            latest_chat: true,
            custom_profile: {
                username: "user name",
                age: 18,
                sex: "Female"
            },
            context: [
                { idx: 1, name: "AI", content: "Hi~", star: 0, timestamp: "20230506 11:00:00", is_human: false, image: "" },
            ],
            timestamp: "2023-05-05 11:00:00"
        }
    }
    ```

### 1.49 migrate history by memory
* Basic Information: 

| interface description | migrate history by memory |
|----------------|--------------|
| URL | /character/memory/migrate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y  | user id        |        |
| 2 | memory_id | number | Y  | memory id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 2
        }
    }
    ```


### 1.11 generate dialog information for user
* Basic Information: 

| interface description | user chat |
|----------------|--------------|
| URL | /character/generatUserDialogs |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y    | user id   |        |
| 2 | count  | number  | Y   |   generate count    |    1~5    |
| 3 | name   | string  | Y   |      |         |
| 4 | greeting   | string  | Y   |      |         |
| 5 | long_description | string  | Y   |       |         |
| 6 | tags      | array   | Y   |        |         |
| 7 | context   | array   | Y   |         |         |
| 8 | params    | object   | Y   |         |         |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"messages":["msg1"],"done":false}}
    {"code":0,"msg":"success","result":{"messages":["msg1","msg2"],"done":true}}
    ```

### 1.12 generate chat dialog
* Basic Information: 

| interface description | generate chat dialog |
|----------------|--------------|
| URL | /character/genChat      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | content     | string | N  |             |        |
| 4 | uniqId      | number | N  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"done":false,"content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"uniqId":12,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```

### 1.13 reGenerate chat dialog
* Basic Information: 

| interface description | reGenerate chat dialog |
|----------------|--------------|
| URL | /character/reGenChat    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"done":false,""content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"done":false,""content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"uniqId":12,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```

### 1.14 set star
* Basic Information: 

| interface description | set star |
|----------------|--------------|
| URL | /character/setStar      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | star        | number | Y  |             |        |
| 4 | content     | string | Y  |             |        |
| 5 | uniq_id     | number | Y  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 1.15 delete chats from content_idx
* Basic Information: 

| interface description | delete chats from content_idx |
|----------------|--------------|
| URL | /character/delChatsFromIdx    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | idx         | number | Y  | content idx |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 1.16 delete character
* Basic Information: 

| interface description | delete character |
|----------------|--------------|
| URL | /character/delete       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y | user id        |        |
| 2 | character_id  | number | Y | character id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: { 
            statue: 0
            // status: 1    // can not delete
        }
    }
    ```

### 1.17 delete character's chat
* Basic Information: 

| interface description | delete character's chat |
|----------------|--------------|
| URL | /character/delChat      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | character_id | number | Y |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 1.18 generate audio
* Basic Information: 

| interface description | generate audio |
|----------------|--------------|
| URL | /character/generateAudio |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | idx         | number | Y  |             |        |
| 4 | uniqId      | number | N  |             |        |
| 5 | lang        | string | N  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            url: "https://xxxxxxxxxxxxxxxxx.wav",
            model_id: 10
        }
    }
    ```

### 1.19 get the last dialog
* Basic Information: 

| interface description | get the last dialog |
|----------------|--------------|
| URL | /character/getLastDialog |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y  | user id        |        |
| 2 | session_id    | number | Y  | session id     |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"idx":2,"is_generate":true,"done":false,""content":"\n\n"}}
    {"code":0,"msg":"success","result":{"idx":2,"is_generate":true,"done":false,""content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"idx":2,"is_generate":true,"uniqId":12,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```

### 1.20 set role star
* Basic Information: 

| interface description | set role star |
|----------------|--------------|
| URL | /character/setRoleStar  |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | character_id | number | Y |             |        |
| 3 | star_count   | number | Y |   1-5       |        |
| 4 | comment      | string | N |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0   
            // status: 1    // chat count < 10
            // status: 2    // already comment
        }
    }
    ```

### 1.21 get character role star detail
* Basic Information: 

| interface description | get character role star detail |
|----------------|--------------|
| URL | /character/getRoleStarDetail |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | character_id | number | Y |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            roleStarDetail: {
                1: 10,
                2: 10,
                3: 22,
                4: 0,
                5: 15
            }
        }
    }
    ```

### 1.22 get character role star comments
* Basic Information: 

| interface description | get character role star comments |
|----------------|--------------|
| URL | /character/getRoleStarComments |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | character_id | number | Y |             |        |
| 2 | limit   | number | Y    | number of each page   |        |
| 3 | page_no | number | Y    |            |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                id: 1,
                star: 5,
                comment: "this is a comment",
                timestamp: "20230506 11:00:00",
                username: "user1"
            },
            {
                id: 2,
                star: 2,
                comment: "this is a comment",
                timestamp: "20230506 11:00:00",
                username: "user2"
            },
        ]
    }
    ```

### 1.23 search character
* Basic Information: 

| interface description | search character |
|----------------|--------------|
| URL | /character/search       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | index_name   | string | Y |   return character_id list   |        |
| 2 | user_id      | number | N  | user id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 1,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Lily",
                greeting: "Hi~",
                short_description: "",
                tags: "tag1,tag2",
                creater: "abc",
                line_count: 100000,
                role_star: 5,    // 1-5
                is_collect: false
            },
            {
                character_id: 2,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Mike",
                greeting: "Hi~",
                short_description: "",
                tags: "tag1,tag2",
                creater: "abc",
                line_count: 100000,
                role_star: 5,    // 1-5
                is_collect: false
            }
        ]
    }
    ```

### 1.23.1 new search character
* Basic Information: 

| interface description | search character |
|----------------|--------------|
| URL | /character/new/search       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | index_name   | string | Y |   return character_id list   |        |
| 2 | user_id      | number | N  | user id        |        |
| 3 | from_app     | number | N  |                |        |
| 4 | lang         | string | N  |                |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            characters: [
                {
                    character_id: 1,
                    avatar: "https://charactrxxxxxx/xxxxx.png",
                    name: "Lily",
                    greeting: "Hi~",
                    short_description: "",
                    tags: "tag1,tag2",
                    creater: "abc",
                    line_count: 100000,
                    role_star: 5,    // 1-5
                    is_collect: false
                }
            ],
            allTags: [ 'tag1', 'tag2' ],
            all_tags_trans: [ 
                { Female: '女性' }
            ]
        }
    }
    ```
### 1.23.2 get characters by tags in search
* Basic Information: 

| interface description | get characters by tags in search |
|----------------|--------------|
| URL | /character/searchWithTag       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | index_name   | string | Y |   return character_id list   |        |
| 2 | user_id      | number | N  | user id        |        |
| 3 | from_app     | number | N  |                |        |
| 4 | lang         | string | N  |                |        |
| 5 | select_tags  | string | Y  |    tag1,tag2   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 1,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Lily",
                greeting: "Hi~",
                short_description: "",
                tags: "tag1,tag2",
                creater: "abc",
                line_count: 100000,
                role_star: 5,    // 1-5
                is_collect: false
            }
        ]
    }
    ```

### 1.24 share dialogs
* Basic Information: 

| interface description | share dialogs |
|----------------|--------------|
| URL | /character/getSharedDialogs |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | k | string | Y | The value should be base64 encoded string. After decoded, should be example as: 'session_id=1&idxs=1,2,3,4'   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            characterInfo: {
                name: "AI name",
                avatar: "https://xxxxx.jpg"
            },
            userInfo: {
                name: "user name",
                avatar: "https://xxxxx.jpg"
            },
            dialogs: [
                {
                    idx: 1,
                    name: "AI name",
                    message: "xxxxxx",
                    timestamp: "20230506 11:00:00"
                },
                {
                    idx: 2,
                    name: "user name",
                    message: "xxxxxx",
                    timestamp: "20230506 12:00:00"
                },
            ]
        }
    }
    ```

### 1.25 report role star comment
* Basic Information: 

| interface description | report role star comment |
|----------------|--------------|
| URL | /character/reportRoleStarComment |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 |   id    | number | Y | role star comment id          |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 1.26 report character
* Basic Information: 

| interface description | report character |
|----------------|--------------|
| URL | /character/report       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id          |        |
| 2 | character_id | number | Y | character id     |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 1.27 generate image by dialog new
* Basic Information: 

| interface description | generate image by dialog new |
|----------------|--------------|
| URL | /character/new/genImage |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y  | user id        |        |
| 2 | session_id | number | Y  | session id     |        |
| 3 | idx        | number | Y  | dialog idx in session    |        |
| 4 | from_app   | number | N  |       |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            create_id: "xxxxxxxxxxxxxxxxx"
        }
    }
    ```

### 1.28 generate gif by dialog new
* Basic Information: 

| interface description | generate gif by dialog new |
|----------------|--------------|
| URL | /character/new/genGif   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y  | user id        |        |
| 2 | session_id | number | Y  | session id     |        |
| 3 | idx        | number | Y  | dialog idx in session    |        |
| 4 | from_app   | number | N  |       |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            create_id: "xxxxxxxxxxxxxxxxx"
        }
    }
    ```

### 1.29 get dialog image/gif
* Basic Information: 

| interface description | get dialog image/gif |
|----------------|--------------|
| URL | /character/getImageOrGif |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y  | user id        |        |
| 2 | create_id  | string | Y  |                |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            state: "Done",  // "Pending"
            url: "https://xxxxxxxxxxxxxxxxx.jpg"    // ""
        }
    }
    ```

### 1.30 generate chat dialog for user
* Basic Information: 

| interface description | generate chat dialog for user |
|----------------|--------------|
| URL | /character/genUserChat  |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | batch_size  | number | Y  |             |        |

* Sample returned successfully( batch_size <= 1): 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"content":"\n\n*msgs"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":true,"content":"\n\n*msgs done*"}}
    ```
    
* Sample returned successfully( batch_size > 1): 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"contents":[{"content":"",target_message:"",target_lang:""}]}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"contents":[{"content":"\n\n*msgs",target_message:"",target_lang:""}]}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":true,"contents":[{"content":"\n\n*msgs",target_message:"",target_lang:""}]}}
    ```

### 1.31 release character
* Basic Information: 

| interface description | release character |
|----------------|--------------|
| URL | /character/release      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y | user id        |        |
| 2 | character_id  | number | Y | character id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            statsu: 0
        }
    }
    ```
### 1.32 unrelease character
* Basic Information: 

| interface description | unrelease character |
|----------------|--------------|
| URL | /character/unrelease    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y | user id        |        |
| 2 | character_id  | number | Y | character id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            statsu: 0
        }
    }
    ```

### 1.33 conmmit update content
* Basic Information: 

| interface description | conmmit update content |
|----------------|--------------|
| URL | /character/chat/commit  |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y | user id        |        |
| 2 | session_id  | number | Y  |             |        |
| 2 | uniq_id  | number | Y  |             |        |
| 2 | content  | string | Y  |             |        |
| 2 | lang  | string | N  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```


### 1.34 get hint examples
* Basic Information: 

| interface description | get hint examples |
|----------------|--------------|
| URL | /character/getExamples  |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | num    | number | N | count        |        |
| 2 | lang   | string | N | lang         |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 2,
                name: "org name",
                avatar: "https://xxxxxxx",
                replys: [
                        "what re you doing in my room",
                        "tu fala em português?",
                        "Huh?! What are you doing in my room?!"
                        ]
            },
            {
                character_id: 3,
                name: "org name",
                avatar: "https://xxxxxxx",
                replys: [
                        "what re you doing in my room",
                        "tu fala em português?",
                        "Huh?! What are you doing in my room?!"
                        ]
            }
        ]
    }
    ```

### 1.35 update user profile in session
* Basic Information: 

| interface description | update user profile in session |
|----------------|--------------|
| URL | /character/updateSessionProfile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id      |        |
| 2 | session_id   | number | Y | session id   |        |
| 3 | id           | number | Y | custom profile id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 1.36 user puchase character
* Basic Information: 

| interface description | user puchase character |
|----------------|--------------|
| URL | /character/purchase     |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |
| 3 | charge       | number | Y |              | compare price in svr cache |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 1.37 get random image
* Basic Information: 

| interface description | get random image |
|----------------|--------------|
| URL | /character/randomImage  |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |
| 3 | blur_url     | string | N |              | return origin image url if blur_url is not empty |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            url: "https://xxxxxxx.jpg"
        }
    }
    ```

### 1.38 get topic list
* Basic Information: 

| interface description | get topic list |
|----------------|--------------|
| URL | /character/listTopic    |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | N | user id     |  guest has no user_id       |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            topics: [
                {
                    title: "",
                    replys: []
                }
            ]
        }
    }
    ```

### 1.39 get photo wall by character id
* Basic Information: 

| interface description | get photo wall by character id |
|----------------|--------------|
| URL | /character/getPhotoWall |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N | user id     |  guest has no user_id       |
| 2 | character_id | number | Y |        |         |
| 3 | limit   | number | N    | number of each page   |        |
| 4 | page_no | number | N    |            |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            character_id: 1,
            total_count: 1,
            photos: [
                "https:xxxxxxx.jpg"
            ]
        }
    }
    ```

### 1.40 generate Narrator's dialog     // deprecated
* Basic Information: 

| interface description | generate Narrator's dialog |
|----------------|--------------|
| URL | /character/genNarratorChat |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | uniqId      | number | N  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":false,"content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```
### 1.41 reGenerate Narrator's dialog     // deprecated
* Basic Information: 

| interface description | reGenerate Narrator's dialog |
|----------------|--------------|
| URL | /character/reGenNarratorChat |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"done":false,""content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"done":false,""content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"uniqId":12,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```
### 1.42 edit Narrator's dialog      // deprecated
* Basic Information: 

| interface description | edit Narrator's dialog  |
|----------------|--------------|
| URL | /character/editNarratorDialog |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | uniqId      | number | Y  |             |        |
| 4 | content     | string | Y  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            id: 123,
            idx: 10,
            name: 'Narrator',
            message: "xxx",
            target_message: "xxxxx",
            target_lang: "ja"
        }
    }
    ```

### 1.43 can be summary 
* Basic Information: 

| interface description | can be summary  |
|----------------|--------------|
| URL | /character/summary/status/get |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            to_summary: 0 // 1, 2
        }
    }
    ```
### 1.44 generate Summary
* Basic Information: 

| interface description | generate Summary  |
|----------------|--------------|
| URL | /character/summary/generate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"done":false,"timestamp":"20241101 11:11:11","summarys":[{"content":"",target_message:"",target_lang:"",summary_model_id:"",model_id:0}]}}
    {"code":0,"msg":"success","result":{"done":true,"timestamp":"20241101 11:11:11","summarys":[{"content":"xxx",target_message:"",target_lang:"",summary_model_id:"",model_id:0,uniq_id:123123}]}}
    ```
### 1.45 edit Summary
* Basic Information: 

| interface description | edit Summary  |
|----------------|--------------|
| URL | /character/summary/edit |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | uniq_id     | number | Y  |             |        |
| 4 | content     | string | N  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```


### 1.46 get the creation example
* Basic Information: 

| interface description | get the creation example  |
|----------------|--------------|
| URL | /character/sample       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y  | user id     |        |
| 2 | sex     | string | Y  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            avatar: "https://charactrxxxxxx/xxxxx.png",
            name: "Lily",
            greeting: "Hi~",
            visibility: "public",
            definitior_visibility: "public",
            long_description: "",
            short_description: "",
            tags: [ "tag1", "tag2" ],
            voices: [ "voice1", "voice2" ],
            image_generation: {
                enable: true,
                hide: true,
                style: ""
            },
            context: [
                "AI: Hi~",
                "You: Hello~"
            ],
            params: {
                temperature: 1,
                top_x: 1
            }
        }
    }
    ```

### 1.47 check valid chat
* Basic Information: 

| interface description | check valid chat |
|----------------|--------------|
| URL | /character/message/valid |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N | user id     |  guest has no user_id       |
| 2 | message | string | Y |        |         |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            message: "xxxx",
            is_valid: true  // false
        }
    }
    ```

### 1.48 record user paid
* Basic Information: 

| interface description | record user paid |
|----------------|--------------|
| URL | /character/paid/record  |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id     |         |
| 2 | character_id | number | Y |        |         |
| 2 | platform | string | Y |        |         |
| 2 | is_subscription | number | Y |   0/1     |         |
| 2 | product_id | string | Y |        |         |
| 2 | system | string | N |        |         |
| 2 | world_id | number | N |        |         |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```
    
### 1.50 generate video (only for review)

* Basic Information:

| interface description |        |
|-----------------------|--------|
| URL                   | /character/generateVideo |
| message format        | javascript |
| request method        | POST    |

* Params:

| # | Param        | Data type | Must | Explanation | Remark |
|---|--------------|-----------|------|-------------|--------|
| 1 | user_id      | number    | Y    | user id     |        |
| 2 | character_id | number    | Y    |             |        |
| 3 | audio_prompt | string    | N    |             |        |
| 4 | lang         | string    | N    |             |        |

* Sample returned successfully:
```javascript
{
  code: 0,
  msg: "success",
  result: {
    create_id: 'xxxxxx'
  }
}
```

### 1.51 query video by create_id(1.50) (only for review)

* Basic Information:

| interface description |                |
|-----------------------|----------------|
| URL                   | /character/queryVideo |
| message format        | javascript     |
| request method        | POST           |

* Params:

| # | Param     | Data type | Must | Explanation | Remark |
|---|-----------|-----------|------|-------------|--------|
| 1 | user_id   | number    | Y    | user id     |        |
| 2 | create_id | string    | Y    |             |        |

* Sample returned successfully:
```javascript
{
  code: 0,
  msg: "success",
  result: {
    state: "Prepare",  // Waiting/Handling/Done
    url: ""
  }
}
```
    
## 2. novel related interface

### 2.0 get novel profile
 * Basic Information: 

| interface description | get novel profile |
|----------------|--------------|
| URL | /novel/getProfile       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id      |       |
| 2 | novel_id | number | Y | novel id |       |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            cover: "https://charactrxxxxxx/xxxxx.png",
            title: "Lily",
            world_view: "",
            scene: "",
            foreword: "",
            characters: "",
            tags: [ "tag1", "tag2" ],
            creater: 1,
            gen_count: 10000,
            role_star: 5    // 1-5
        }
    }
    ```

### 2.1 new create novel or edit novel by novel_id, only private can be edit
 * Basic Information: 

| interface description | new create novel or edit novel by novel_id, only private can be edit |
|----------------|--------------|
| URL | /novel/createOrEdit     |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y   | user id |         |
| 2 | novel_id   | number | N   |         |         |
| 3 | cover      | string | Y   |         |         |
| 4 | title      | string | Y   |         |         |
| 5 | world_view | string | Y   |         |         |
| 6 | scene      | string | Y   |         |         |
| 7 | foreword   | string | Y   |         |         |
| 8 | characters | string | Y   |  [{"name":"","desc":""}]       |         |
| 9 | tags       | array  | N   |         |         |
| 10 | lang      | string | N   |         |         |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            novel_id: 1
        }
    }
    ```

### 2.2 delete novel
* Basic Information: 

| interface description | delete novel |
|----------------|--------------|
| URL | /novel/delete           |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: { 
            statue: 0
            // status: 1    // can not delete
        }
    }
    ```

### 2.3 release novel
 * Basic Information: 

| interface description | release novel |
|----------------|--------------|
| URL | /novel/release          |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: { 
            statue: 0
        }
    }
    ```

### 2.4 unrelease novel
 * Basic Information: 

| interface description | unrelease novel |
|----------------|--------------|
| URL | /novel/unrelease        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: { 
            statue: 0
            // status: 1    // can not unrelease
        }
    }
    ```


### 2.5 clone novel         // deprecated
* Basic Information: 

| interface description | clone novel |
|----------------|--------------|
| URL | /novel/clone            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            novel_id: 1,
            cover: "https://charactrxxxxxx/xxxxx.png",
            title: "Lily",
            world_view: "",
            scene: "",
            foreword: "",
            characters: "",
            tags: [ "tag1", "tag2" ],
            creater: 1,
            gen_count: 10000,
            role_star: 5
        }
    }
    ```

### 2.6 get novels by tag
* Basic Information: 

| interface description | get novels by tag  |
|----------------|--------------|
| URL | /novel/getNovelsByTag |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N   | user id   |        |
| 2 | tag     | string | Y   |           |        |
| 3 | limit   | number | Y   |           |        |
| 4 | page_no | number | Y   |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                novel_id: 1,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                world_view: "",
                tags: "tag1,tag2",
                creater: "abc",
                gen_count: 100000,
                role_star: 5,    // 1-5
                is_newest: true,
                is_popular: false,
                is_collect: false
            },
            {
                novel_id: 2,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                world_view: "",
                tags: "tag1,tag2",
                creater: "abc",
                gen_count: 100000,
                role_star: 5,    // 1-5
                is_newest: true,
                is_popular: false,
                is_collect: false
            }
        ]
    }
    ```

### 2.7 get novels recently
* Basic Information: 

| interface description | get novels recently  |
|----------------|--------------|
| URL | /novel/getRecentlyNovelSessions |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y    | user id   |        |
| 2 | limit   | number | Y    |           |        |
| 3 | page_no | number | Y    |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                novel_id: 1,
                session_id: 5,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                scene: "",
                foreword: "",
                characters: "",
                creater: "ABC"
            },
            {
                novel_id: 2,
                session_id: 8,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                scene: "",
                foreword: "",
                characters: "",
                creater: "ABC"
            }
        ]
    }
    ```

### 2.8 get history by novel
* Basic Information: 

| interface description | get history by novel |
|----------------|--------------|
| URL | /novel/getHistoryByNovel |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                session_id: 1,
                is_latest: false,
                context: [
                    { content: "Hi~", timestamp: "20230506 11:00:00" },
                    { content: "Hello~", timestamp: "20230506 11:00:00" }
                ],
                timestamp: "20230506 11:00:00"
            },
            {
                session_id: 2,
                is_latest: true,
                context: [
                    { content: "Hi~", timestamp: "20230506 11:00:00" },
                    { content: "Hello~", timestamp: "20230506 11:00:00" }
                ],
                timestamp: "20230506 11:00:00"
            }
        ]
    }
    ```

### 2.9 continue writing novels
* Basic Information: 

| interface description | continue writing novels |
|----------------|--------------|
| URL | /novel/continue         |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y | user id    |        |
| 2 | novel_id   | number | Y | novel id   |        |
| 3 | session_id | number | N | session id |        |
| 4 | from_app   | number | N |            |        |
| 5 | limit      | number | Y |            |        |
| 6 | page_no    | number | Y |            |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 2,
            is_latest: true,
            scene: '', 
            foreword: '', 
            characters: '',
            context: [
                { uniq_id: 11, idx: 1, content: "Hi~", timestamp: "20230506 11:00:00", target_message: "http://xxxxxx.wav", target_lang: "" },
                { uniq_id: 13, idx: 2, content: "Hello~", timestamp: "20230506 11:00:00", target_message: "", target_lang: "" },
                { uniq_id: 21, idx: 3, content: "Hello~", timestamp: "20230506 11:00:00", target_message: "", target_lang: "" }
            ],
            is_creater: true,
            is_generate: false  // if true, means some task is generating
        }
    }
    ```

### 2.10 create novel session
* Basic Information: 

| interface description | create novel session |
|----------------|--------------|
| URL | /novel/createSession    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 1,
            is_latest: true,
            context: [
                { idx: 1, content: "Hi~",timestamp: "20230506 11:00:00", target_message: "", target_lang: "" },
            ],
            timestamp: "2023-05-05 11:00:00"
        }
    }
    ```

### 2.11 generate
* Basic Information: 

| interface description | generate |
|----------------|--------------|
| URL | /novel/generate         |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | uniq_id     | number | N  |             |        |
| 4 | lang        | string | N  |             |        |
| 5 | content     | string | N  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"timestamp":"","done":false,"content":"He","target_message":"","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"timestamp":"","done":false,"content":"Hello","target_message":"","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"timestamp":"","uniq_id":12,"done":true,"content":"Hello~","target_message":"","target_lang":""}}
    ```

### 2.12 reGenerate
* Basic Information: 

| interface description | reGenerate |
|----------------|--------------|
| URL | /novel/reGenerate       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | lang        | string | N  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"timestamp":"","done":false,"content":"He","target_message":"","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"timestamp":"","done":false,"content":"Hello","target_message":"","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"timestamp":"","uniq_id":12,"done":true,"content":"Hello~","target_message":"","target_lang":""}}
    ```

### 2.13 delete content from idx
* Basic Information: 

| interface description | delete content from idx |
|----------------|--------------|
| URL | /novel/delContentFromIdx |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | idx         | number | Y  | content idx |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 2.14 delete novel sessions
* Basic Information: 

| interface description | delete novel sessions |
|----------------|--------------|
| URL | /novel/delNovelSessions |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 2.15 get the last content
* Basic Information: 

| interface description | get the last content |
|----------------|--------------|
| URL | /novel/getLastContent |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | lang        | string | N  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_generate":true,"timestamp":"","done":false,"content":"He","target_message":"","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_generate":true,"timestamp":"","done":false,"content":"Hello","target_message":"","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_generate":true,"timestamp":"","uniq_id":12,"done":true,"content":"Hello~","target_message":"","target_lang":""}}
    ```

### 2.16 set role star
* Basic Information: 

| interface description | set role star |
|----------------|--------------|
| URL | /novel/setRoleStar  |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | novel_id     | number | Y | novel id    |        |
| 3 | star_count   | number | Y |   1-5       |        |
| 4 | comment      | string | N |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0   
            // status: 1    // chat count < 10
            // status: 2    // already comment
        }
    }
    ```

### 2.17 get novel role star detail
* Basic Information: 

| interface description | get novel role star detail |
|----------------|--------------|
| URL | /novel/getRoleStarDetail |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | novel_id | number | Y |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            roleStarDetail: {
                1: 10,
                2: 10,
                3: 22,
                4: 0,
                5: 15
            }
        }
    }
    ```

### 2.18 get novel role star comments
* Basic Information: 

| interface description | get novel role star comments |
|----------------|--------------|
| URL | /novel/getRoleStarComments |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | novel_id | number | Y |             |        |
| 2 | limit   | number | Y    | number of each page   |        |
| 3 | page_no | number | Y    |            |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                id: 1,
                star: 5,
                comment: "this is a comment",
                timestamp: "20230506 11:00:00",
                username: "user1"
            },
            {
                id: 2,
                star: 2,
                comment: "this is a comment",
                timestamp: "20230506 11:00:00",
                username: "user2"
            },
        ]
    }
    ```

### 2.19 report role star comment
* Basic Information: 

| interface description | report role star comment |
|----------------|--------------|
| URL | /novel/reportRoleStarComment |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 |   id    | number | Y | role star comment id          |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 2.20 search novel
* Basic Information: 

| interface description | search novel |
|----------------|--------------|
| URL | /novel/search       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | index_name   | string | Y |   return novel_id list   |        |
| 2 | user_id      | number | N  | user id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                novel_id: 1,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                world_view: "",
                scene: "",
                foreword: "",
                characters: "",
                tags: "tag1,tag2",
                creater: "abc",
                gen_count: 100000,
                role_star: 5,    // 1-5
                is_collect: false
            },
            {
                novel_id: 2,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                world_view: "",
                scene: "",
                foreword: "",
                characters: "",
                tags: "tag1,tag2",
                creater: "abc",
                gen_count: 100000,
                role_star: 5,    // 1-5
                is_collect: false
            }
        ]
    }
    ```


<!-- ### 2.21 report novel
* Basic Information: 

| interface description | report novel |
|----------------|--------------|
| URL | /novel/report           |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ``` -->

### 2.22 collect or uncollect
 * Basic Information: 

| interface description | user collect/uncollect novel |
|----------------|--------------|
| URL | /novell/doCollect       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | novel_id | number | Y | novel id        |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            is_collect: true // false
        }
    }
    ```

### 2.23 get collected novels
 * Basic Information: 

| interface description | get collected novels |
|----------------|--------------|
| URL | /novel/getCollectedNovels |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                novel_id: 1,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                world_view: "",
                tags: "tag1,tag2",
                gen_count: 100000,
                role_star: 5,    // 1-5
                is_collect: true,
                creater: "ABC"
            },
            {
                novel_id: 2,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                world_view: "",
                tags: "tag1,tag2",
                gen_count: 100000,
                role_star: 1,
                is_collect: true,
                creater: "ABC"
            }
        ]
    }
    ```

### 2.24 update session profile
 * Basic Information: 

| interface description | update session profile |
|----------------|--------------|
| URL | /novel/updateSessionProfile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |
| 3 | foreword     | string | N |             |        |
| 4 | characters   | string | N |             |        |
| 5 | scene        | string | N |             |        |
| 6 | lang         | string | N |             |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
                novel_id: 1,
                session_id: 1,
                scene: "Lily",
                foreword: "",
                characters: "tag1,tag2",
                is_latest: true,
                timestamp: "20231101 11:11:11"
            }
    }
    ```

### 2.25 conmmit update content
 * Basic Information: 

| interface description | conmmit update content |
|----------------|--------------|
| URL | /novel/commitContent    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |
| 3 | uniq_id      | number | Y |             |        |
| 4 | content      | string | Y |             |        |
| 5 | lang         | string | N |             |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
                status: 0
            }
    }
    ```

### 2.26 generate scene image
* Basic Information: 

| interface description | generate scene image |
|----------------|--------------|
| URL | /novel/genSceneImage    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id         |        |
| 2 | data     | string | Y |                 |        |
| 3 | from_app | number | Y |                 |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            create_id: "xxxxxxxxxxxxxxxxx"
        }
    }
    ```

### 2.27 report novel
* Basic Information: 

| interface description | report novel |
|----------------|--------------|
| URL | /novel/report       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y | user id        |        |
| 2 | novel_id  | number | Y | novel id       |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 2.28 get reported novels
 * Basic Information: 

| interface description | get reported novels |
|----------------|--------------|
| URL | /novel/getReportededNovels |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [ 1, 2, 4 ] // novel_id list
    }
    ```


## 3. user related interface

### 3.0.0 record busy error from web front
 * Basic Information: 

| interface description | record busy error from web front |
|----------------|--------------|
| URL | /user/getBusyErrMsg     |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | code    | string |  Y   |    |        |
| 2 | message | string |  Y   |       |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 3.0 register by email
 * Basic Information: 

| interface description | register by email |
|----------------|--------------|
| URL | /user/registByEmail     |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | email              | string |  Y   |    |        |
| 2 | email_valid_code   | string |  Y   |  email code     |        |
| 3 | password           | string |  Y   |       |        |
| 4 | invitation_code    | string |  Y   |       |        |
| 5 | guest_client_token | string |  N   |       |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.0.1 register/login by email code
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /user/code_login     |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | email              | string |  Y   |    |        |
| 2 | email_valid_code   | string |  Y   |  email code     |        |
| 4 | invitation_code    | string |  Y   |       |        |
| 5 | guest_client_token | string |  N   |       |        |
| 5 | system | string |  N   |       |        |
| 5 | from_app | string |  N   |       |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.1 login by email
 * Basic Information: 

| interface description | login by email |
|----------------|--------------|
| URL | /user/loginByEmail      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | email      | string |  Y   |    |        |
| 2 | password   | string |  Y   |       |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.2 send email code
 * Basic Information: 

| interface description | send email code |
|----------------|--------------|
| URL | /user/sendEmailCode     |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | email      | string |  Y   |    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 3.3 get user base info
 * Basic Information: 

| interface description | get user base info |
|----------------|--------------|
| URL | /user/getUserBaseInfo   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            level: 0,
            type: "email",
            email: "xxxx@xxx.xxx",
            username: "xxxx@xxx.xxx",
            avatar: "http://xxxxx:8520/public/img/avatars/default.jpg",
            inviter_id: 0,
            invite_code: "ABCDEFGH",
            invite_count: 0,
            registe_time: "2023-03-21 14:40:36",
            last_login_time: "2023-03-21 14:40:36",
            total_amount: 0,
            total_subscribe_amount: 0,
            available_amount: 0,
            withdraw_amount: 0,
            pending_withdraw_amount: 0,
            vip_expire_time: null,
            token_balance: 0,
            token_by_invite: 0,
            is_subscribe: 0, // 1
            freeGifTimes: 1,
            is_subscribe: 0,
            is_bind_email: true,
            total_profit: 0,
            follow_count: 0,
            followers_count: 0,
            popularity: 10,
            create_world_permission: true // false
        }
    }
    ```

### 3.4 set username
 * Basic Information: 

| interface description | set username |
|----------------|--------------|
| URL | /user/setUsername       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | username | string |  Y   |    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```


### 3.5 register or login by google
 * Basic Information: 

| interface description | register or login by google |
|----------------|--------------|
| URL | /user/registOrLoginByGoogle |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | invitation_code    | string |  Y   |       |        |
| 2 | google_token       | string |  Y   |       |        |
| 3 | guest_client_token | string |  N   |       |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg",
            is_register: true  // false
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.6 get created characters
 * Basic Information: 

| interface description | get created characters |
|----------------|--------------|
| URL | /user/getCreatedCharacters |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 1,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Lily",
                greeting: "Hi~",
                short_description: "",
                line_count: 100000,
                role_star: 1,
                is_collect: true,
                creater: "ABC"
            },
            {
                character_id: 2,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Mike",
                greeting: "Hi~",
                short_description: "",
                line_count: 100000,
                role_star: 1,
                is_collect: true,
                creater: "ABC"
            }
        ]
    }
    ```

### 3.7 collect or uncollect
 * Basic Information: 

| interface description | user collect/uncollect character |
|----------------|--------------|
| URL | /user/doCollect         |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | character_id | number | Y |             |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            is_collect: true // false
        }
    }
    ```

### 3.8 get collected characters
 * Basic Information: 

| interface description | get collected characters |
|----------------|--------------|
| URL | /user/getCollectedCharacters |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 1,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Lily",
                greeting: "Hi~",
                short_description: "",
                line_count: 100000,
                role_star: 1,
                is_collect: true,
                creater: "ABC"
            },
            {
                character_id: 2,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Mike",
                greeting: "Hi~",
                short_description: "",
                line_count: 100000,
                role_star: 1,
                is_collect: true,
                creater: "ABC"
            }
        ]
    }
    ```

### 3.9 reset password
 * Basic Information: 

| interface description | reset password |
|----------------|--------------|
| URL | /user/resetPwd          |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | email              | string  | Y   |      |     |
| 2 | email_valid_code   | string  | Y   |      |     |
| 3 | password           | string  | Y   | new password  |     |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            "status": 0
        }
    }
    ```

### 3.10 set user avatar
 * Basic Information: 

| interface description | set user avatar |
|----------------|--------------|
| URL | /user/setAvatar         |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | url          | string | Y   |      |     |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            "status": 0
        }
    }
    ```

### 3.11 delete user
 * Basic Information: 

| interface description | delete user |
|----------------|--------------|
| URL | /user/delete            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            "status": 0
        }
    }
    ```

### 3.12 register or login by google in mobile
 * Basic Information: 

| interface description | register or login by google in mobile |
|----------------|--------------|
| URL | /user/mobile/registOrLoginByGoogle |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | invitation_code    | string |  Y   |       |        |
| 2 | google_token       | string |  Y   |       |        |
| 3 | guest_client_token | string |  N   |       |        |
| 4 | system             | string |  N   |       |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg",
            is_register: true  // false
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.13 register or login by apple
 * Basic Information: 

| interface description | register or login by apple |
|----------------|--------------|
| URL | /user/registOrLoginByApple |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_identifier    | string |  Y   |    |        |
| 2 | identity_token     | string |  Y   |    |        |
| 3 | guest_client_token | string |  N   |    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg",
            is_register: true  // false
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.14 get user token balance
 * Basic Information: 

| interface description | get user token balance |
|----------------|--------------|
| URL | /user/getUserTokenBalance   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            token_balance: 1000,
            recharge_token: 500, 
            free_token: 500, 
            available_amount: 100, 
            level: 1, 
            vip_expire_time: "2023-12-12 18:00:00"
        }
    }
    ```

### 3.15 user daily sign in
 * Basic Information: 

| interface description | user daily sign in |
|----------------|--------------|
| URL | /user/signIn   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0,
        }
    }
    ```

### 3.16 get reported characters
 * Basic Information: 

| interface description | get reported characters |
|----------------|--------------|
| URL | /user/getReportededCharacters |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [ 1, 2, 4 ] // character_id list
    }
    ```

### 3.17 random login
 * Basic Information: 

| interface description | random login |
|----------------|--------------|
| URL | /user/randomLogin       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | uniq_token         | string |  Y   |    |        |
| 2 | system             | string |  Y   |  Android     |        |
| 3 | invitation_code    | string |  N   |       |        |
| 4 | from_app           | string |  Y   |    1   |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.18 bind email
 * Basic Information: 

| interface description | bind email |
|----------------|--------------|
| URL | /user/bindEmail |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | uniq_token | string |  Y   |    |        |
| 2 | email      | string |  Y   |    |        |
| 3 | password   | string |  Y   |       |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0,
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.19 get letters
 * Basic Information: 

| interface description | get letters |
|----------------|--------------|
| URL | /user/getLetters |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id   |        |
| 2 | type    | number | Y | 0: public message, 1: private message |        |
| 3 | limit   | number | Y |           |        |
| 4 | page_no | number | Y |           |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                id: 1, 
                message: "xxxxxx",
                timestamp: "2023-10-22 12:00:00",
                is_read: 0
            },
            {
                id: 2, 
                message: "xxxxxx",
                timestamp: "2023-10-22 12:00:00",
                is_read: 1
            },
        ]
    }
    ```

### 3.20 read letters
 * Basic Information: 

| interface description | read letters |
|----------------|--------------|
| URL | /user/readLetters |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id   |        |
| 2 | ids     | string | Y | 1,2,3     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: { status: 0 }
    }
    ```

### 3.21 delete letters
 * Basic Information: 

| interface description | delete letters |
|----------------|--------------|
| URL | /user/delLetters |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id   |        |
| 2 | ids     | string | Y | 1,2,3     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: { status: 0 }
    }
    ```

### 3.22 clear usage records
 * Basic Information: 

| interface description | clear usage records |
|----------------|--------------|
| URL | /user/clearRecords |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id   |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0,
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.23 send token
 * Basic Information: 

| interface description | send token |
|----------------|--------------|
| URL | /user/sendToken |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id   |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0,
            user_id: 1,
            token_balance: 1000,
            recharge_token: 500, 
            free_token: 500, 
            available_amount: 100
        }
    }
    ```

### 3.24 training custom audio   // deprecated
 * Basic Information: 

| interface description | training custom audio |
|----------------|--------------|
| URL | /user/trainingCustomAudio |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y | user id   |        |
| 2 | source_url | string | Y |           |        |
| 3 | prompt     | string | Y |           |        |
| 4 | name       | string | Y |           |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            npzUrl: "https://xxxxxxxxxxxxxxxxx.npz",
            url: "https://xxxxxxxxxxxxxxxxx.wav",
            model_id: 10
        }
    }
    ```

### 3.25 get created novels
 * Basic Information: 

| interface description | get created novels |
|----------------|--------------|
| URL | /user/getCreatedNovels |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                novel_id: 1,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                world_view: "",
                tags: "tag1,tag2",
                gen_count: 100000,
                role_star: 5,    // 1-5
                is_collect: true,
                creater: "ABC"
            },
            {
                character_id: 2,
                cover: "https://charactrxxxxxx/xxxxx.png",
                title: "Lily",
                world_view: "",
                tags: "tag1,tag2",
                gen_count: 100000,
                role_star: 5,    // 1-5
                is_collect: true,
                creater: "ABC"
            }
        ]
    }
    ```

### 3.26 bind apple
 * Basic Information: 

| interface description | bind apple |
|----------------|--------------|
| URL | /user/bindApple         |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | uniq_token         | string |  Y   |    |        |
| 2 | user_identifier    | string |  Y   |    |        |
| 3 | identity_token     | string |  Y   |    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0,
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.26.1 bind google
 * Basic Information: 

| interface description | bind google |
|----------------|--------------|
| URL | /user/bindGoogle        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | uniq_token         | string |  Y   |    |        |
| 2 | google_token       | string |  Y   |    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0,
            user_id: 1,
            level: 0,
            email: "xxxx@xxx.xxx",
            username: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 3.27 get user free times
 * Basic Information: 

| interface description | get user free times |
|----------------|--------------|
| URL | /user/getFreeTimes      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y | user id   |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            freeAvatarTimes: 0,
            freeGifTimes: 0,
            freeAudioTimes: 3,
            freeNovelTimes: 2,
            freeGroupChatTimes: 2
        }
    }
    ```

### 3.28 get gift list
 * Basic Information: 

| interface description | get gift list |
|----------------|--------------|
| URL | /user/listGift          |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id   |        |
| 2 | lang    | string | N |           |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                "id": 1, 
                "title": "Rewards for Daily Check-In",
                "content": "Check in and get tokens every day!",
                "reward": 200,
                "button": "Get",
                "link":  "",
                "received": false
            },
            {
                "id": 2, 
                "title": "Join Discord",
                "content": "Join our Discord, take part in our activities, and get more rewards.",
                "reward": 150,
                "button": "Join",
                "link":  "https://discord.com/invite/Naa2qkyMkt"
                "received": true
            },
        ]
    }
    ```

### 3.29 receive gift
* Basic Information: 

| interface description | receive gift |
|----------------|--------------|
| URL | /user/receiveGift       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | gift_id | number | Y | gift id          |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: { 
            statue: 0,
            // status: 1    // cannot receive with invalid gift_id
            // status: 2    // cannot receive, as owned gift
            user_id: 1,
            token_balance: 1000,
            recharge_token: 500, 
            free_token: 500, 
            available_amount: 100
        }
    }
    ```

### 3.30 get purchased characters
* Basic Information: 

| interface description | get purchased characters |
|----------------|--------------|
| URL | /user/getPurchasedCharacters |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 1,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Lily",
                greeting: "Hi~",
                short_description: "",
                line_count: 100000,
                role_star: 1,
                is_collect: true,
                is_purchase: true,
                creater: "ABC"
            },
            {
                character_id: 2,
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Mike",
                greeting: "Hi~",
                short_description: "",
                line_count: 100000,
                role_star: 1,
                is_collect: true,
                is_purchase: true,
                creater: "ABC"
            }
        ]
    }
    ```

### 3.31 transfer from withdraw, to token_balance (One-way transfer)
* Basic Information: 

| interface description | transfer from withdraw, to token_balance (One-way transfer) |
|----------------|--------------|
| URL | /user/transfer          |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | amount  | number | Y |                  |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            token_balance: 300,
            recharge_token: 200,
            free_token: 100,
            available_amount: 0
        }
    }
    ```

### 3.32 user applies for withdrawal
* Basic Information: 

| interface description | user applies for withdrawal |
|----------------|--------------|
| URL | /user/withdraw          |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | amount  | number | Y |                  |        |
| 3 | receive_account  | string | Y |                  |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 3.33 user set inviter ( valid in 24h register )
* Basic Information: 

| interface description | user set inviter |
|----------------|--------------|
| URL | /user/setInviter        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | invitation_code  | string |  Y   |      |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0,
            success: true
        }
    }
    ```

### 3.34 set user profile
* Basic Information: 

| interface description | user set profile |
|----------------|--------------|
| URL | /user/setProfile        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | field   | string | Y |   age/sex   |        |
| 3 | value   | string | Y |   age: 1,2,3  /sex: Male,Female,Non-Binary   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 3.35 count user clicks
* Basic Information: 

| interface description | count user clicks |
|----------------|--------------|
| URL | /user/click             |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | type    | string | Y | blur_image/clear_image/topic   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 3.36 list user custom profiles
* Basic Information: 

| interface description | list user custom profiles |
|----------------|--------------|
| URL | /user/custom/profile/list |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            profiles: [
                {
                    id: 1, 
                    username: 'name1', 
                    age: 8, 
                    sex: 'Male',
                    is_default: 1
                }
            ]
        }
    }
    ```

### 3.37 user add/update/del custom profiles
* Basic Information: 

| interface description | user add/update/del custom profiles |
|----------------|--------------|
| URL | /user/custom/profile/set |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | id      | number | N | custom profile id |        |
| 3 | username     | string | Y |              |        |
| 4 | age          | number | Y |              |        |
| 5 | sex          | string | Y | `Male`, `Female`, `Non-Binary` |        |
| 6 | appearance   | string | Y |              |        |
| 7 | infomation   | string | Y |              |        |
| 8 | avatar       | string | Y |              |        |
| 9 | del          | number | N | 0/1 |  1 to delete      |
| 10 | is_default  | number | N | 0/1 |  1 to set default |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            id: 1       // if id is 0, mean delete success
        }
    }
    ```

### 3.38 user send bug feedback to offical
* Basic Information: 

| interface description | user send bug feedback to offical |
|----------------|--------------|
| URL | /user/feedback/send   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id          |        |
| 2 | message  | string | Y |              |        |
| 3 | urls     | array  | N |              |        |
| 4 | reply_id | number | N |              |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 3.39 get sent bug feedbacks
* Basic Information: 

| interface description | get sent bug feedbacks |
|----------------|--------------|
| URL | /user/feedback/get      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | limit   | number | Y |           |        |
| 3 | page_no | number | Y |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            { 
                id: 1,
                message: 'xxxx',
                timestamp: '2024-01-01 11:11:11',
                has_new_reply: true
            }
        ]
    }
    ```
### 3.40 get bug feedback detail
* Basic Information: 

| interface description | get bug feedback detail |
|----------------|--------------|
| URL | /user/feedback/detail   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | id      | number | Y | feedback id      |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: { 
            id: 1,
            message: 'xxxx',
            urls: [],
            replys: [
                { 
                    id: 2,
                    message: 'xxxxx',
                    timestamp: '2024-01-01 11:11:11'
                }
            ]
        }
    }
    ```
### 3.41 delete bug feedback
* Basic Information: 

| interface description | delete bug feedback |
|----------------|--------------|
| URL | /user/feedback/delete   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | id      | number | Y | feedback id      |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 3.42 check email format exist
* Basic Information: 

| interface description | check email format exist |
|----------------|--------------|
| URL | /user/email/exist       |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | email  | string | Y |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            exist: true
        }
    }
    ```

### 3.43 set interest tags
* Basic Information: 

| interface description | set interest tags |
|----------------|--------------|
| URL | /user/tags/set       |
| message format | javascript   |
| request method | POST          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y |           |        |
| 1 | tags  | array | Y |           |    [ "NULL" ]    |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            exist: true
        }
    }
    ```


### 3.44 list custom photo wall
* Basic Information: 

| interface description | list custom photo wall |
|----------------|--------------|
| URL | /user/photowall/list    |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y |           |        |
| 1 | character_id  | number | Y |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                id: 1,
                url: "xxxxxxx",
                review_level: 0 // -1: no pass, 0: reviewing, 1: pass
            }
        ]
    }
    ```
### 3.45 add custom photo wall
* Basic Information: 

| interface description | add custom photo wall |
|----------------|--------------|
| URL | /user/photowall/add     |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y |           |        |
| 1 | character_id  | number | Y |           |        |
| 1 | url  | string | Y |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            id: 123
        }
    }
    ```
### 3.46 del custom photo wall
* Basic Information: 

| interface description | del custom photo wall |
|----------------|--------------|
| URL | /user/photowall/del     |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y |           |        |
| 1 | id  | number | Y |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```




### 3.47 get created worlds
 * Basic Information: 

| interface description | get created worlds |
|----------------|--------------|
| URL | /user/getCreatedWorlds |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                "world_id": 1,
                "creater": "xxx",
                "world_name": "xxx",
                "world_summary": "xxxxx",
                "world_opening": "xxxxx",
                "world_cover": "test",
                "cover": "https://xxxx.jpg",
                "characters": "[{\"name\":\"Lyra\",\"avatar\":\"https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg\",\"details\":\"Luminous spirit, harbinger of hope in times of darkness; gifted healer and skilled cartographer.\"}]",
                "create_time": "2024-09-05T10:15:26.000Z",
                "is_released": 1,
                "gen_count": 7
            }
        ]
    }
    ```
### 3.48 get collected worlds
 * Basic Information: 

| interface description | get collected worlds |
|----------------|--------------|
| URL | /user/getCollectedWorlds |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                "world_id": 1,
                "creater": "xxx",
                "world_name": "xxx",
                "world_summary": "xxxxx",
                "world_opening": "xxxxx",
                "world_cover": "test",
                "cover": "https://xxxx.jpg",
                "characters": "[{\"name\":\"Lyra\",\"avatar\":\"https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg\",\"details\":\"Luminous spirit, harbinger of hope in times of darkness; gifted healer and skilled cartographer.\"}]",
                "create_time": "2024-09-05T10:15:26.000Z",
                "is_released": 1,
                "gen_count": 7
            }
        ]
    }
    ```

### 3.49 get user adjust id
 * Basic Information: 

| interface description | get user adjust id |
|----------------|--------------|
| URL | /user/adjust/get        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 1 | system       | string | Y | ios/android     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_id: 1,
            adjust_id: "xxxxxx",
            system: "ios",
            app_device: "",
            app_mall: ""
        }
    }
    ```
### 3.50 set user adjust id
 * Basic Information: 

| interface description | set user adjust id |
|----------------|--------------|
| URL | /user/adjust/set        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 1 | adjust_id    | string | Y |      |        |
| 1 | system       | string | Y | ios/android     |        |
| 1 | app_device   | string | N |      |        |
| 1 | app_mall     | string | N |      |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            success: true   // false
        }
    }
    ```

### 3.51 get reported list by type
 * Basic Information: 

| interface description | get reported list by type |
|----------------|--------------|
| URL | /user/report/list       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id     |        |
| 1 | type    | string | Y | character/group/author |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            1, 2, 3
        ]
    }
    ```

### 3.51 list all users' withdraws
 * Basic Information: 

| interface description | list all users' withdraws |
|----------------|--------------|
| URL | /user/withdraw/list     |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                username: 'Al***',
                amount: 5000,
                done_timestamp: 'xxxxxxx'
            }
        ]
    }
    ```

### 3.52 list all profit
 * Basic Information: 

| interface description | list all profit |
|----------------|--------------|
| URL | /user/profit/list     |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                time: 'YYYY-MM-DD HH:mm:ss', 
                is_refund: 0,       // 1 已退款
                platform: 'paypal', 
                amout: 9.9,
                channel_fee: 0.9,
                profit: 1.8,
                character_id: 0,
                avatar: ''
            }
        ]
    }
    ```

### 3.53 get app grade level
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /user/grade/level       |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y | user id     |        |
| 1 | system      | string | Y |      |        |

* Sample returned successfully: 
    
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            _level: 1 // 1/2/3
        }
    }
    ```

## 4. guest related interface

### 4.0 guest login
 * Basic Information: 

| interface description | guest login |
|----------------|--------------|
| URL | /guest/login            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | client_token | string    |  Y   | a unique token created by client |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            guest_id: 1,
            token_balance: 0,
            client_token: "xxxxxxx",
            avatar: "http://xxxxxxxxxxx/1.jpg"
        }
    }
    ```
* Sample returned in headers: 
    ```javascript
    { 
        "session-token": "tokenabcde"    // The session-token here is used by subsequent interfaces, format in header: { authorization : `Bearer tokenabcde`}
        "expireTs": 1680747764247 // ms
    }
    ```

### 4.1 chat
* Basic Information: 

| interface description | chat  |
|----------------|--------------|
| URL | /guest/chat           |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            context: [
                { idx: 1, name: "AI", content: "Hi~", timestamp: "20230506 11:00:00", is_human: false },
                { idx: 2, name: "You", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true }
            ],
            is_generate: false  // if true, interval to request API, util is_generate=fasle
        }
    }
    ```

### 4.2 get the last dialog
* Basic Information: 

| interface description | get the last dialog |
|----------------|--------------|
| URL | /guest/getLastDialog    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"idx":2,"is_generate":true,"done":false,""content":"\n\n"}}
    {"code":0,"msg":"success","result":{"idx":2,"is_generate":true,"done":false,""content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"idx":2,"is_generate":true,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```

### 4.3 generate chat dialog
* Basic Information: 

| interface description | generate chat dialog |
|----------------|--------------|
| URL | /guest/genChat         |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |
| 3 | content      | string | N  |             |        |
| 4 | uniqId       | number | N  |             |        |

* Sample returned successfully: 

    ```text    
    {"code":0,"msg":"success","result":{"idx":2,"is_alternative":false,"done":false,""content":"\n\n"}}
    {"code":0,"msg":"success","result":{"idx":2,"is_alternative":false,"done":false,""content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"idx":2,"is_alternative":false,"uniqId":12,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```

### 4.4 reGenerate chat dialog
* Basic Information: 

| interface description | reGenerate chat dialog |
|----------------|--------------|
| URL | /guest/reGenChat        |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |

* Sample returned successfully: 

    ```text    
    {"code":0,"msg":"success","result":{"idx":2,"is_alternative":true,"done":false,""content":""}}
    {"code":0,"msg":"success","result":{"idx":2,"is_alternative":true,"done":false,""content":"Hi~ It's cool."}}
    {"code":0,"msg":"success","result":{"idx":2,"is_alternative":true,"done":false,""content":"Hi~ It's cool. Right? \nYOU:"}}
    {"code":0,"msg":"success","result":{"idx":2,"is_alternative":true,"uniqId":12,"done":true,"content":"Hi~ It's cool. Right?"}}
    ```


### 4.5 get random image
* Basic Information: 

| interface description | get random image |
|----------------|--------------|
| URL | /guest/randomImage      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            url: "https://xxxxxxx.jpg"
        }
    }
    ```
    
### 4.6 count guest clicks
* Basic Information: 

| interface description | count guest clicks |
|----------------|--------------|
| URL | /guest/click             |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | type    | string | Y | blur_image/clear_image/topic   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 4.7 generate Narrator's dialog  // deprecated
* Basic Information: 

| interface description | generate Narrator's dialog |
|----------------|--------------|
| URL | /guest/genNarratorChat |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |
| 3 | uniqId       | number | N  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":false,"content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```
### 4.8 reGenerate Narrator's dialog  // deprecated
* Basic Information: 

| interface description | reGenerate Narrator's dialog |
|----------------|--------------|
| URL | /guest/reGenNarratorChat |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":false,"content":"\n\n*我向Tom发出了疲衣表"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":true,"content":"\n\n*我向Tom发出了疲衣表眼*"}}
    ```

### 4.9 generate user's dialog
* Basic Information: 

| interface description | generate user's dialog |
|----------------|--------------|
| URL | /guest/genUserChat      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | guest_id     | number | Y | user id      |        |
| 2 | character_id | number | Y | character id |        |
| 3 | batch_size  | number | Y  |             |        |

* Sample returned successfully( batch_size <= 1): 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"content":"\n\n*msgs"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":true,"content":"\n\n*msgs done*"}}
    ```
    
* Sample returned successfully( batch_size > 1): 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"contents":[{"content":"",target_message:"",target_lang:""}]}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"contents":[{"content":"\n\n*msgs",target_message:"",target_lang:""}]}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":true,"contents":[{"content":"\n\n*msgs",target_message:"",target_lang:""}]}}
    ```


## 5. paypal related interface
### 5.0.1 get paypal token settings
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/paypal/token/get_profile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | package_id   | number    |  Y   | 1: 0.99, 2: 4.99 |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            domain: "https://aideeptranslate.com"
        }
    }
    ```
### 5.0.2 get paypal subscribe settings
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/paypal/subscribe/get_profile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | level   | number    |  Y   | 1: month pro, 2: month pro+, 4: year pro, 5: year pro+ |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            domain: "https://aideeptranslate.com",
            paypal_sid: "price_1Ov7vp067hw4xxxxxxxxxx"
        }
    }
    ```


### 5.1.0 get token package list
 * Basic Information: 

| interface description | get token package list |
|----------------|--------------|
| URL | /api/tokenPackages   |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
        {
        "code": 0,
        "msg": "success",
        "result": [
            {
                "package_id": 1,
                "amount_usd": 0.99,
                "token": 1000,
                "stripe_pid": "xxxxx",
                "apple_pid": "xxxxx"
            },
            {
                "package_id": 2,
                "amount_usd": 4.99,
                "token": 7500,
                "stripe_pid": "xxxxx",
                "apple_pid": "xxxxx"
            }
        ]
    }
    ```

### 5.1 get vip Level list
 * Basic Information: 

| interface description | get vip Level list |
|----------------|--------------|
| URL | /api/vipLevels   |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": [
            {
                "level": 1,
                "amount_usd": 9.9,
                "paypal_sid": "xxxxx",
                "stripe_sid": "xxxxx",
                "apple_sid": "xxxxx"
            },
            {
                "level": 2,
                "amount_usd": 19.99,
                "paypal_sid": "xxxxx",
                "stripe_sid": "xxxxx",
                "apple_sid": "xxxxx"
            }
        ]
    }
    ```

### 5.2 get paypal client id
 * Basic Information: 

| interface description | get paypal client id |
|----------------|--------------|
| URL | /api/paypal/clientId   |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "paypalClientId": "AWf3XFWoha_p4W-jrIDrr7V2L7S42uh7slotC2KQVFwoBAjjnEFE23eiNYUQsDCUIhz9F_I4GsAwAwCr"
        }
    }
    ```

### 5.3 create order
 * Basic Information: 

| interface description | create order |
|----------------|--------------|
| URL | /api/paypal/createOrder            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | package_id | number    |  Y   | token package id |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "id": "07U43138X7257990D",
            "status": "CREATED",
            "links": [
                {
                    "href": "https://api.sandbox.paypal.com/v2/checkout/orders/07U43138X7257990D",
                    "rel": "self",
                    "method": "GET"
                },
                {
                    "href": "https://www.sandbox.paypal.com/checkoutnow?token=07U43138X7257990D",
                    "rel": "approve",
                    "method": "GET"
                },
                {
                    "href": "https://api.sandbox.paypal.com/v2/checkout/orders/07U43138X7257990D",
                    "rel": "update",
                    "method": "PATCH"
                },
                {
                    "href": "https://api.sandbox.paypal.com/v2/checkout/orders/07U43138X7257990D/capture",
                    "rel": "capture",
                    "method": "POST"
                }
            ]
        }
    }
    ```

### 5.4 capture order
 * Basic Information: 

| interface description | capture order |
|----------------|--------------|
| URL | /api/paypal/captureOrder            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | order_id | string    |  Y   | order id |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "id": "07U43138X7257990D",
            "status": "COMPLETED",
            "payment_source": {
                "paypal": {
                    "email_address": "sb-fih2m26484442@personal.example.com",
                    "account_id": "LKEXMFJPQC79C",
                    "account_status": "VERIFIED",
                    "name": {
                        "given_name": "John",
                        "surname": "Doe"
                    },
                    "address": {
                        "country_code": "US"
                    }
                }
            },
            "purchase_units": [
                {
                    "reference_id": "default",
                    "shipping": {
                        "name": {
                            "full_name": "John Doe"
                        },
                        "address": {
                            "address_line_1": "1 Main St",
                            "admin_area_2": "San Jose",
                            "admin_area_1": "CA",
                            "postal_code": "95131",
                            "country_code": "US"
                        }
                    },
                    "payments": {
                        "captures": [
                            {
                                "id": "2R773692A3471950A",
                                "status": "COMPLETED",
                                "amount": {
                                    "currency_code": "USD",
                                    "value": "0.99"
                                },
                                "final_capture": true,
                                "seller_protection": {
                                    "status": "ELIGIBLE",
                                    "dispute_categories": [
                                        "ITEM_NOT_RECEIVED",
                                        "UNAUTHORIZED_TRANSACTION"
                                    ]
                                },
                                "seller_receivable_breakdown": {
                                    "gross_amount": {
                                        "currency_code": "USD",
                                        "value": "0.99"
                                    },
                                    "paypal_fee": {
                                        "currency_code": "USD",
                                        "value": "0.52"
                                    },
                                    "net_amount": {
                                        "currency_code": "USD",
                                        "value": "0.47"
                                    }
                                },
                                "custom_id": "2023070410334767700001",
                                "links": [
                                    {
                                        "href": "https://api.sandbox.paypal.com/v2/payments/captures/2R773692A3471950A",
                                        "rel": "self",
                                        "method": "GET"
                                    },
                                    {
                                        "href": "https://api.sandbox.paypal.com/v2/payments/captures/2R773692A3471950A/refund",
                                        "rel": "refund",
                                        "method": "POST"
                                    },
                                    {
                                        "href": "https://api.sandbox.paypal.com/v2/checkout/orders/07U43138X7257990D",
                                        "rel": "up",
                                        "method": "GET"
                                    }
                                ],
                                "create_time": "2023-07-04T10:34:09Z",
                                "update_time": "2023-07-04T10:34:09Z"
                            }
                        ]
                    }
                }
            ],
            "payer": {
                "name": {
                    "given_name": "John",
                    "surname": "Doe"
                },
                "email_address": "sb-fih2m26484442@personal.example.com",
                "payer_id": "LKEXMFJPQC79C",
                "address": {
                    "country_code": "US"
                }
            },
            "links": [
                {
                    "href": "https://api.sandbox.paypal.com/v2/checkout/orders/07U43138X7257990D",
                    "rel": "self",
                    "method": "GET"
                }
            ]
        }
    }
    ```

### 5.5 capture subscription
 * Basic Information: 

| interface description | capture subscription |
|----------------|--------------|
| URL | /api/paypal/captureSubscription            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | subscription_id | string    |  Y   | subscription id |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": "ACTIVE",
            "status_update_time": "2023-07-04T10:39:15Z",
            "id": "I-3GH7142NP6ED",
            "plan_id": "P-4T459969GN465812SMSR6WWA",
            "start_time": "2023-07-04T10:38:58Z",
            "quantity": "1",
            "shipping_amount": {
                "currency_code": "USD",
                "value": "0.0"
            },
            "subscriber": {
                "email_address": "sb-fih2m26484442@personal.example.com",
                "payer_id": "LKEXMFJPQC79C",
                "name": {
                    "given_name": "John",
                    "surname": "Doe"
                },
                "shipping_address": {
                    "address": {
                        "address_line_1": "1 Main St",
                        "admin_area_2": "San Jose",
                        "admin_area_1": "CA",
                        "postal_code": "95131",
                        "country_code": "US"
                    }
                }
            },
            "billing_info": {
                "outstanding_balance": {
                    "currency_code": "USD",
                    "value": "0.0"
                },
                "cycle_executions": [
                    {
                        "tenure_type": "REGULAR",
                        "sequence": 1,
                        "cycles_completed": 1,
                        "cycles_remaining": 0,
                        "current_pricing_scheme_version": 1,
                        "total_cycles": 0
                    }
                ],
                "last_payment": {
                    "amount": {
                        "currency_code": "USD",
                        "value": "19.99"
                    },
                    "time": "2023-07-04T10:39:15Z"
                },
                "next_billing_time": "2023-08-04T10:00:00Z",
                "failed_payments_count": 0
            },
            "create_time": "2023-07-04T10:39:14Z",
            "update_time": "2023-07-04T10:39:15Z",
            "custom_id": "5",
            "plan_overridden": false,
            "links": [
                {
                    "href": "https://api.sandbox.paypal.com/v1/billing/subscriptions/I-3GH7142NP6ED/cancel",
                    "rel": "cancel",
                    "method": "POST"
                },
                {
                    "href": "https://api.sandbox.paypal.com/v1/billing/subscriptions/I-3GH7142NP6ED",
                    "rel": "edit",
                    "method": "PATCH"
                },
                {
                    "href": "https://api.sandbox.paypal.com/v1/billing/subscriptions/I-3GH7142NP6ED",
                    "rel": "self",
                    "method": "GET"
                },
                {
                    "href": "https://api.sandbox.paypal.com/v1/billing/subscriptions/I-3GH7142NP6ED/suspend",
                    "rel": "suspend",
                    "method": "POST"
                },
                {
                    "href": "https://api.sandbox.paypal.com/v1/billing/subscriptions/I-3GH7142NP6ED/capture",
                    "rel": "capture",
                    "method": "POST"
                }
            ]
        }
    }
    ```

### 5.6 cancel subscription
 * Basic Information: 

| interface description | capture subscription |
|----------------|--------------|
| URL | /api/cancelSubscription            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```

### 5.7 paypal on cancel
 * Basic Information: 

| interface description | paypal on cancel |
|----------------|--------------|
| URL | /api/paypal/onCancel           |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```

### 5.8 paypal on error
 * Basic Information: 

| interface description | paypal on error |
|----------------|--------------|
| URL | /api/paypal/onError            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 1 | error | string    |  Y   | error info |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```


## 6. stripe related interface
### 6.0.1 get stripe token settings
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/stripe/token/get_profile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | package_id   | number    |  Y   | 1: 0.99, 2: 4.99 |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            domain: "https://aideeptranslate.com",
            stripe_pid: "price_1Ov7vp067hw4xxxxxxxxxx"
        }
    }
    ```
### 6.0.2 get stripe subscribe settings
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/stripe/subscribe/get_profile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | level   | number    |  Y   | 1: month pro, 2: month pro+, 4: year pro, 5: year pro+ |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            domain: "https://aideeptranslate.com",
            stripe_sid: "price_1Ov7vp067hw4xxxxxxxxxx"
        }
    }
    ```

### 6.1 create order
 * Basic Information: 

| interface description | create order |
|----------------|--------------|
| URL | /api/stripe/createOrder            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | package_id | number    |  Y   | token package id |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "gateway_url":"https://checkout.stripe.com/c/pay/cs_test_a1Sg9IWeL3HGlYk6fdfzCGueAgegHsUoARg5iU7"
        }
    }
    ```

### 6.2 subscribe
 * Basic Information: 

| interface description | subscribe |
|----------------|--------------|
| URL | /api/stripe/subscribe            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | level | number    |  Y   | level |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "gateway_url":"https://checkout.stripe.com/c/pay/cs_test_a1Sg9IWeL3HGlYk6fdfzCGueAgegHsUoARg5iU7"
        }
    }
    ```

### 6.3 get pay channels
 * Basic Information: 

| interface description | get pay channels |
|----------------|--------------|
| URL | /api/payChannels   |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": [
            "paypal",
            "stripe"
        ]
    }
    ```


## 7. apple pay related interface
### 7.1 buy tokens (deprecated)
 * Basic Information: 

| interface description | buy tokens |
|----------------|--------------|
| URL | /api/apple/order            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | package_id | number    |  Y   | token package id |        |
| 2 | receipt | json    |  Y   | receipt |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```

### 7.2 subscribe (deprecated)
 * Basic Information: 

| interface description | subscribe |
|----------------|--------------|
| URL | /api/apple/subscribe            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | level | number    |  Y   | level |  1 or 2   |
| 3 | receipt | json    |  Y   | receipt |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```

### 7.3 purchase
 * Basic Information: 

| interface description | purchase |
|----------------|--------------|
| URL | /api/apple/purchase            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 3 | receipt | json    |  Y   | receipt |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```

### 7.4 get receipts
 * Basic Information: 

| interface description | getRreceipts |
|----------------|--------------|
| URL | /api/apple/getRreceipts            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 3 | receipt | json    |  Y   | receipt |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "receipts": []
        }
    }
    ```

## 8. google pay related interface
### 8.1 buy tokens (deprecated )
 * Basic Information: 

| interface description | buy tokens |
|----------------|--------------|
| URL | /api/google/order            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | package_id | number    |  Y   | token package id |        |
| 2 | token | json    |  Y   | token |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```

### 8.2 subscribe (deprecated)
 * Basic Information: 

| interface description | subscribe |
|----------------|--------------|
| URL | /api/google/subscribe            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | level | number    |  Y   | level |  1 or 2   |
| 3 | token | json    |  Y   | token |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```

### 8.2 purchase
 * Basic Information: 

| interface description | purchase |
|----------------|--------------|
| URL | /api/google/purchase            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 3 | receipt | json    |  Y   | receipt |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "status": 0
        }
    }
    ```

### 8.4 subscription status
 * Basic Information: 

| interface description | subscribe |
|----------------|--------------|
| URL | /api/subscriptionStatus            |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | pay_channel | string    |  Y   | pay channel |  apple or google   |

* action:
 0:normal
 1:upgrade
 2:downgrade
 
* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "1": {
                "canSubscribe": 1,
                "action": 0,
                "note": ""
            },
            "2": {
                "canSubscribe": 1,
                "action": 1,
                "note": ""
            }
        }
    }
    ```

## 9. pay related interface
### 9.0.0 get middle pay page
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/mid_page |
| message format | javascript   |
| request method | GET         |

* Sample returned successfully:     密文返回，解密后返回样式
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": "https://fallfortalk.com"
    }
    ```
### 9.0.0.1 get middle pay page v2
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/mid_page/v2 |
| message format | javascript   |
| request method | GET         |

* Sample returned successfully:     密文返回，解密后返回样式
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            url: "https://xxxxxxx.com",
            has_year_sub: true
        }
    }
    ```

### 9.0.1 get pay token settings
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/pay/token/get_profile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | package_id   | number    |  Y   | 1: 0.99, 2: 4.99 |        |

* Sample returned successfully:     密文返回，解密后返回样式
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            domain: "https://aideeptranslate.com",
            platform: "stripe",
            product_id: "1"
        }
    }
    ```
### 9.0.2 get pay subscribe settings
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/pay/subscribe/get_profile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | level   | number    |  Y   | 1: month pro, 2: month pro+, 4: year pro, 5: year pro+ |        |

* Sample returned successfully:     密文返回，解密后返回样式
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            domain: "https://aideeptranslate.com",
            sub_id: "price_1Ov7vp067hw4xxxxxxxxxx",
            platform: "stripe"
        }
    }
    ```
### 9.0.3 get pay token subscribe settings
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/pay/token_sub/get_profile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | package_id   | number    |  Y   | 1: 4.99 |        |

* Sample returned successfully:     密文返回，解密后返回样式
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            domain: "https://aideeptranslate.com",
            sub_id: "price_1Ov7vp067hw4xxxxxxxxxx",
            platform: "stripe"
        }
    }
    ```


### 9.1.0 get token subscribe package list
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/subTokens   |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
        {
        "code": 0,
        "msg": "success",
        "result": [
            {
                "package_id": 2,
                "amount_usd": 4.99,
                "token": 4000,
                "paypal_pid": "xxxxx",
                "stripe_pid": "xxxxx"
            }
        ]
    }
    ```


### 9.0.3 cancel subscribe
 * Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /api/subscribe/cancel |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | type    | string    |  Y   | token/vip |        |

* Sample returned successfully:     密文返回，解密后返回样式
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": "https://fallfortalk.com"
    }
    ```

### 9.0 get current payment (stripe/paypal) for web
 * Basic Information: 

| interface description | get current payment (stripe/paypal) for web |
|----------------|--------------|
| URL | /api/currentPayment     |
| message format | javascript   |
| request method | GET          |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: "stripe" // paypal
    }
    ```

### 9.1 send data to appsfler
 * Basic Information: 

| interface description | send data to appsfler |
|----------------|--------------|
| URL | /api/appsflyer/send     |
| message format | javascript   |
| request method | POST         |

| 1 | user_id | number    |  Y   | user id |        |
| 2 | app_id  | string    |  Y   | token package id |        |
| 3 | data | json    |  Y   | token |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: { 
            status: 0 
            }
    }
    ```


## 10. author related interface
### 10.1 follow/unfollow
* Basic Information: 

| interface description | follow/unfollow |
|----------------|--------------|
| URL | /user/author/follow   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y | user id          |        |
| 2 | author_id | number | Y | author id      |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            is_follow: true // false
        }
    }
    ```

### 10.2 get author info
* Basic Information: 

| interface description | follow/unfollow |
|----------------|--------------|
| URL | /user/author/info   |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N | user id          |        |
| 2 | author_id | number | Y | author id      |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            author_id: 1, 
            author_name: 'xxxx', 
            level: 1,   // 0/1/2
            avatar: 'xxxxxxx.jpg',
            follow_count: 10, 
            followers_count: 10,
            popularity: 10,
            released_count: {
                character: 1,
                novel: 2
            },
            is_follow: true // false
        }
    }
    ```

### 10.3 get author's characters (page,limit)
* Basic Information: 

| interface description | follow/unfollow |
|----------------|--------------|
| URL | /user/author/characters/list   |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N | user id          |        |
| 2 | author_id | number | Y | author id      |        |
| 3 | limit   | number | Y   |           |        |
| 4 | page_no | number | Y   |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                character_id: 1, 
                name: 'xxx', 
                avatar: 'xxxx.jpg', 
                background: '', 
                tags: '', 
                short_description: '', 
                line_count: 111,
                is_star: true, 
                is_collect: true, 
                is_purchase: true
            }
        ]
    }
    ```
### 10.4 get author's groups (page,limit)
* Basic Information: 

| interface description |  |
|----------------|--------------|
| URL | /user/author/groups/list   |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N | user id          |        |
| 2 | author_id | number | Y | author id      |        |
| 3 | limit   | number | Y   |           |        |
| 4 | page_no | number | Y   |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
            "group_id": 80,
            "title": "group chat",
            "creater": " 124124",
            "creater_id": 351,
            "gen_count": 39,
            "cover": "",
            "background": "https://test.fallfor.ai/xxxxxx.jpg",
            "character_ids": [982,1009,20,29,28],
            "characters": [
                {
                    "character_id": 982,
                    "name": "123",
                    "avatar": "https://xxxxxx-0.jpg",
                    "background": "https://xxxxxx-0.jpg",
                    "short_description": "He'd had his eye on her for a whole year and now it was time to make a move and make her his."
                    "need_to_purchase": false
                }
            ]
        }
        ]
    }
    ```
### 10.5 report author
* Basic Information: 

| interface description | report author |
|----------------|--------------|
| URL | /user/author/report   |
| message format | javascript   |
| request method | POST          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N | user id          |        |
| 2 | author_id | number | Y | author id      |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```
### 10.6 get followed authors
* Basic Information: 

| interface description | get followed authors |
|----------------|--------------|
| URL | /user/author/followed/list   |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N | user id          |        |
| 2 | limit | number | Y |       |        |
| 3 | page_no | number | Y |       |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                author_id: 1,
                username: "author1",
                avatar: 'avatar1.jpg',
                is_follow: true
            }
        ]
    }
    ```

## 11. world related interface  
### 11.0 check permission to create world 
* Basic Information: 

| interface description | check permission to create world |
|----------------|--------------|
| URL | /character/world/create/permission |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 11.1 world generate
* Basic Information: 

| interface description | world generate |
|----------------|--------------|
| URL | /character/world/generate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | character_count | number | N |       |        |
| 2 | plot            | string | N |       |        |
| 2 | world_name      | string | N |       |        |
| 2 | world_summary   | string | N |       |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"content":"xxxxx\n\ngen_done_","world_info":{"world_name":"Arcana","world_summary":".","world_opening":".","world_cover":""},"timestamp":"2024-07-10 05:20:25","req_state":"svr_send_to_dispatcher","done":false}}
    {"code":0,"msg":"success","result":{"content":"xxxxx\n\ngen_done_","world_info":{"world_name":"Arcana","world_summary":".","world_opening":".","world_cover":""},"timestamp":"2024-07-10 05:20:25","req_state":"finish","done":true}}
    ```
    
### 11.2 generate characters in world 
* Basic Information: 

| interface description | generate characters in world |
|----------------|--------------|
| URL | /character/world/chars/generate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | character_count | number | N |       |        |
| 2 | world_summary   | string | Y |       |        |
| 2 | world_opening   | string | Y |       |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"content":"xxxxx","characters":[],"timestamp":"2024-07-10 05:20:25","req_state":"svr_send_to_dispatcher","done":false}}
    {"code":0,"msg":"success","result":{"content":" \n\n\ngen_done_","characters":[{"name":"","gender":"Male","details":".","appearance":"tall","greeting":"(nods solemnly)"}],"timestamp":"2024-07-10 09:17:47","req_state":"finish","done":true}}
    ```
    
### 11.3 generate image in world 
* Basic Information: 

| interface description | generate image in world |
|----------------|--------------|
| URL | /character/world/image/generate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |
| 2 | data    | string | Y   |       |        |
| 3 | from_app | number | N  |       |        |
| 4 | type     | string | N  |  avatar/cover     |      |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            create_id: "xxxxxxxxxxxxxxxxx"
        }
    }
    ```

### 11.4 create/edit world 
 * Basic Information: 

| interface description | create/edit world  |
|----------------|--------------|
| URL | /character/world/definition/put |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id            | number | Y  | user id |         |
| 2 | world_name         | string | Y  |         |         |
| 3 | world_summary      | string | Y  |         |         |
| 4 | world_opening      | string | Y  |         |         |
| 5 | world_cover        | string | Y  | cover description |         |
| 6 | cover              | string | Y  | cover url         |         |
| 7 | characters         | array  | Y  |   3~5   |   [{name,details,avatar}]      |
| 8 | world_id           | number | N  |         |         |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            world_id: 1
        }
    }
    ```
    
### 11.5 get world profile
 * Basic Information: 

| interface description | get world profile |
|----------------|--------------|
| URL | /character/world/profile |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | world_id     | number | Y | world id    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            world_name: "x'x'x",
            world_summary: "xxxxxxxxxx~",
            world_opening: "xxxxxxxxxxxxx",
            world_cover: "xxxxxxxxxxxx",
            cover: "https://charactrxxxxxx/xxxxx.png",
            characters: [
                {
                    name: "xxx",
                    details: "xxxxx"
                }
            ]
        }
    }
    ```


### 11.6 release/unrelease world
 * Basic Information: 

| interface description | release/unrelease world |
|----------------|--------------|
| URL | /character/world/release |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | world_id     | number | Y | world id    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 11.7 delete world
 * Basic Information: 

| interface description | delete world |
|----------------|--------------|
| URL | /character/world/delete |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | world_id     | number | N | world id    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```
    
### 11.8 like/dislike world
 * Basic Information: 

| interface description | like/dislike world |
|----------------|--------------|
| URL | /character/world/like |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | world_id     | number | Y | world id    |        |
| 3 | state      | number | Y | 1: like, -1: dislike    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0,
            success: true // false
        }
    }
    ```
    
### 11.9 create world session 
 * Basic Information: 

| interface description | create world session |
|----------------|--------------|
| URL | /character/world/session/create |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | world_id     | number | Y | world id    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 1,
            personal: {
                name: "xxxx",
                avatar: "xxxxxx.jpg"
            }
        }
    }
    ```
    
### 11.10 open world session
 * Basic Information: 

| interface description | open world session |
|----------------|--------------|
| URL | /character/world/session/open |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | world_id     | number | N | world id    |        |
| 2 | session_id   | number | N | session id  |        |
| 2 | system       | string | N |     |        |
| 2 | limit        | number | N |     |        |
| 2 | page_no      | number | N |     |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 1,
            personal: {
                name: "xxxx",
                avatar: "xxxxxx.jpg"
            },
            scenarios: [
                { 
                    id: 123,
                    idx: 2,
                    name: "You",
                    message: "xxxxxxxxx"
                },
                { 
                    id: 122,
                    idx: 1,
                    name: "AI",
                    scenario: {
                        title: "xx",
                        generate_content: "xxxxx",
                        optionA: "xxx",
                        optionB: "xxx",
                        optionC: "xxx"
                    }
                },
                // { 
                //     id: 122,
                //     idx: 1,
                //     name: "AI",
                //     scenario: {     
                //         iv: "xx",
                //         content: "xxxxx"
                //     }
                // }
            ]
        }
    }
    ```

### 11.11 delete world session(s)
 * Basic Information: 

| interface description | delete world session(s) |
|----------------|--------------|
| URL | /character/world/session/delete |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | world_id     | number | N | world id    |        |
| 2 | session_id   | number | N | session id  |        |
** (world_id, session_id) One of the two parameters must be provided

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 11.12 world scenario generate
 * Basic Information: 

| interface description | world scenario generate |
|----------------|--------------|
| URL | /character/world/session/generate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |
| 2 | select_option | string | N | A/B/C/D  |        |
| 2 | custom_content| string | N | if option is 'D', this MUST given  |        |
| 2 | last_scenario_id | number | N | change with regenerate  |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"idx":6,"content":"","scenario_info":{},"timestamp":"2024-09-06 09:19:54","req_state":"insert_user_option_done","done":false}}
    {"code":0,"msg":"success","result":{"idx":7,"content":"xxxxxxxxx","scenario_info":{"title":"","generate_content":".","optionA":"A","optionB":"B","optionC":"C"},"target_message":"","tagset_scenario_info":{},"target_lang":"en","timestamp":"2024-09-06 09:20:27","uniq_id":9,"done":true}}
    {"code":0,"msg":"success","result":{"iv":'xxxxx',"content":"xxxxxxxxxx"}}
    ```
    
### 11.13 world scenario regenerate
 * Basic Information: 

| interface description | world scenario regenerate |
|----------------|--------------|
| URL | /character/world/session/regenerate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"idx":6,"content":"","scenario_info":{},"timestamp":"2024-09-06 09:19:54","req_state":"insert_user_option_done","done":false}}
    {"code":0,"msg":"success","result":{"idx":7,"content":"xxxxxxxxx","scenario_info":{"title":"","generate_content":".","optionA":"A","optionB":"B","optionC":"C"},"target_message":"","tagset_scenario_info":{},"target_lang":"en","timestamp":"2024-09-06 09:20:27","uniq_id":9,"done":true}}
    ```
    
### 11.14 world scenario last scenario
 * Basic Information: 

| interface description | world scenario last scenario |
|----------------|--------------|
| URL | /character/world/session/last |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"idx":6,"content":"","scenario_info":{},"timestamp":"2024-09-06 09:19:54","req_state":"insert_user_option_done","done":false}}
    {"code":0,"msg":"success","result":{"idx":7,"content":"xxxxxxxxx","scenario_info":{"title":"","generate_content":".","optionA":"A","optionB":"B","optionC":"C"},"target_message":"","tagset_scenario_info":{},"target_lang":"en","timestamp":"2024-09-06 09:20:27","uniq_id":9,"done":true}}
    ```
    
### 11.15 get home page worlds
 * Basic Information: 

| interface description | get home page worlds |
|----------------|--------------|
| URL | /character/world/list   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | limit   | number | Y   |           |        |
| 3 | page_no | number | Y   |           |        |
| 3 | system  | string | Y   |           |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                "world_id": 1,
                "creater": "xxx",
                "world_name": "xxxxxxx",
                "world_summary": "xxxxxxxxx",
                "world_cover": "xxx",
                "cover": "https:xxxx.jpg",
                "characters": "[{\"name\":\"Lyra\",\"avatar\":\"https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg\",\"details\":\"Luminous spirit, harbinger of hope in times of darkness; gifted healer and skilled cartographer.\"}]",
                "create_time": "2024-09-05T10:15:26.000Z",
                "gen_count": 7,
                "creater_id": 3,
                "like_count": 0,
                "dislike_count": 0,
                "like_state": "0"
            }
        ]
    }
    ```
    
### 11.16 get chatted worlds
 * Basic Information: 

| interface description | get home page worlds |
|----------------|--------------|
| URL | /character/world/chatted/list |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | limit   | number | Y   |           |        |
| 3 | page_no | number | Y   |           |        |
| 3 | system  | string | Y   |           |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                "session_id": 11,
                "user_id": 3,
                "world_id": 1,
                "personal": "{\"name\":\"Lyra\",\"avatr\":\"https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg\"}",
                "timestamp": "2024-09-09T05:39:35.000Z",
                "is_deleted": 0,
                "creater": "xxxx",
                "world_name": "xxxxx",
                "world_summary": "xxxxx.",
                "cover": "https://xxxxx.jpg",
                "characters": [
                    "https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg",
                    "https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg",
                    "https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg",
                    "https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg"
                ],
                "creater_id": 3
            }
        ]
    }
    ```


### 11.17 get world details
 * Basic Information: 

| interface description |get world details |
|----------------|--------------|
| URL | /character/world/detail |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | N | user id     |        |
| 2 | world_id     | number | Y | world id    |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            "world_id": 1,
            "creater": "xxx",
            "world_name": "xxxx",
            "world_summary": "xxxxxx",
            "cover": "https://xxxxxxxxd.jpg",
            "characters": [
                {
                    "name": "Lyra",
                    "avatar": "https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg",
                    "details": "Luminous spirit, harbinger of hope in times of darkness; gifted healer and skilled cartographer."
                },
                {
                    "name": "Kaelin Darkhaven",
                    "avatar": "https://test.fallfor.ai/public/img/20240429/P-01cc0e89-07d9-4a22-9943-0445a9b3ff25-0.jpg",
                    "details": "Bastion of courage, wielder of ancient magic; fearless warrior with unyielding conviction."
                }
            ],
            "create_time": "2024-09-05T10:15:26.000Z",
            "gen_count": 21,
            "creater_id": 3,
            "like_count": 0,
            "dislike_count": 0,
            "like_state": "0"
        }
    }
    ```
 
### 11.18 report world
 * Basic Information: 

| interface description | report world |
|----------------|--------------|
| URL | /character/world/report |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y | user id     |        |
| 2 | world_id   | number | Y   |           |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```
 
### 11.19 edit scenario content
 * Basic Information: 

| interface description | edit scenario content |
|----------------|--------------|
| URL | /character/world/session/edit |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y | user id     |        |
| 2 | session_id | number | Y   |           |        |
| 2 | uniq_id    | number | Y   |           |        |
| 2 | content    | string | Y   |           |        |
| 2 | lang       | string | Y   |           |        |
| 2 | system     | string | Y   |           |        |

* Sample returned successfully: 
    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```




### 11.20 generate world scenario
 * Basic Information: 

| interface description | generate world scenario |
|----------------|--------------|
| URL | /character/world/scenario/generate/sse |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |
| 2 | select_option | string | N | A/B/C/D  |        |
| 2 | custom_content| string | N | if option is 'D', this MUST given  |        |
| 2 | last_scenario_id | number | N | change with regenerate  |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"model_id":1071,"content":"xxxxx","scenario":"xxxxx","timestamp":"2024-10-08 09:21:11","done":false,"target_scenario":"","target_lang":"en"}}
    {"code":0,"msg":"success","result":{"idx":1,"content":"zzzzzz","scenario":"zzzzzz","target_scenario":"","target_lang":"en","timestamp":"2024-10-08 09:21:11","uniq_id":1088,"done":true}}
    ```
### 11.21 regenerate world scenario
 * Basic Information: 

| interface description | regenerate world scenario |
|----------------|--------------|
| URL | /character/world/scenario/regenerate/sse |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"model_id":1071,"content":"xxxxx","scenario":"xxxxx","timestamp":"2024-10-08 09:21:11","done":false,"target_scenario":"","target_lang":"en"}}
    {"code":0,"msg":"success","result":{"idx":1,"content":"zzzzzz","scenario":"zzzzzz","target_scenario":"","target_lang":"en","timestamp":"2024-10-08 09:21:11","uniq_id":1088,"done":true}}
    ```
### 11.22 generate world scenario options
 * Basic Information: 

| interface description | generate world scenario options |
|----------------|--------------|
| URL | /character/world/scenario/options/generate/sse |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"idx":1,"content":"##optionA:A.\n##optionB:B\n##optionC:C.","options":{"optionA":"A","optionB":"B","optionC":"C"},"target_options":{"optionA":"","optionB":"","optionC":""},"target_lang":"en","timestamp":"2024-10-08 09:53:23","uniq_id":1088,"done":false}}
    {"code":0,"msg":"success","result":{"idx":1,"content":"##optionA:A.\n##optionB:B\n##optionC:C.","options":{"optionA":"A","optionB":"B","optionC":"C"},"target_options":{"optionA":"","optionB":"","optionC":""},"target_lang":"en","timestamp":"2024-10-08 09:53:23","uniq_id":1088,"done":true}}
    ```

### 11.23 world scenario last scenario (3 mode)
 * Basic Information: 

| interface description | world scenario last scenario (3 mode) |
|----------------|--------------|
| URL | /character/world/scenario/last |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | session_id   | number | Y | session id  |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"idx":6,"content":"","scenario_info":{},"timestamp":"2024-09-06 09:19:54","req_state":"insert_user_option_done","done":false}}
    {"code":0,"msg":"success","result":{"idx":7,"content":"xxxxxxxxx","scenario_info":{"title":"","generate_content":".","optionA":"A","optionB":"B","optionC":"C"},"target_message":"","tagset_scenario_info":{},"target_lang":"en","timestamp":"2024-09-06 09:20:27","uniq_id":9,"done":true}}

    {"code":0,"msg":"success","result":{"idx":7,"content":"xxxxxxxxx","scenario":"xxxxxx","target_scenario":"","target_lang":"en","timestamp":"2024-09-06 09:20:27","uniq_id":9,"done":true}}

    {"code":0,"msg":"success","result":{"idx":7,"content":"##optionA:A.\n##optionB:B\n##optionC:C.","options":{"optionA":"A","optionB":"B","optionC":"C"},"target_options":{"optionA":"","optionB":"","optionC":""},"target_lang":"en","timestamp":"2024-10-08 09:53:23","uniq_id":1088,"done":true}}
    ```
    
## 12. chat memory related interface
### 12.1 list chat memories
* Basic Information: 

| interface description | list chat memories  |
|----------------|--------------|
| URL | /character/memory/list  |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N   | user id   |        |
| 2 | limit   | number | Y   |           |        |
| 3 | page_no | number | Y   |           |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                memory_id: 1,
                title: "",
                character: {
                    avatar: "https://charactrxxxxxx/xxxxx.png",
                    name: "Lily"
                },
                user: {
                    avatar: "https://charactrxxxxxx/xxxxx.png",
                    name: "username"
                },
                images: [
                    "https://charactrxxxxxx/xxxxx1.png",
                    "https://charactrxxxxxx/xxxxx2.png"
                ],
                memories: [
                    { uniqId: 11, idx: 1, name: "AI", content: "Hi~", timestamp: "20230506 11:00:00", is_human: false, image: "https://xxxxxxxxxx.jpg" },
                    { uniqId: 13, idx: 2, name: "You", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true, image: "" },
                    { uniqId: 21, idx: 3, name: "AI", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true, image: "" }
                ],
                view_count: 0,
                like_count: 0,
                is_like: false
            }
        ]
    }
    ```

### 12.2 view chat memory
* Basic Information: 

| interface description | view chat memory  |
|----------------|--------------|
| URL | /character/memory/view  |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | N   | user id   |        |
| 2 | memory_id | number | Y   |           |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            memory_id: 1,
            title: "",
            character: {
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "Lily"
            },
            user: {
                avatar: "https://charactrxxxxxx/xxxxx.png",
                name: "username"
            },
            memories: [
                { uniqId: 11, idx: 1, name: "AI", content: "Hi~", timestamp: "20230506 11:00:00", is_human: false, image: "https://xxxxxxxxxx.jpg" },
                { uniqId: 13, idx: 2, name: "You", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true, image: "" },
                { uniqId: 21, idx: 3, name: "AI", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true, image: "" }
            ]
        }
    }
    ```


### 12.3 like/unlike chat memory
* Basic Information: 

| interface description | like/unlike chat memory  |
|----------------|--------------|
| URL | /character/memory/doLike  |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y   | user id   |        |
| 2 | memory_id | number | Y   |           |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            is_like: true // false
        }
    }
    ```

### 12.4 save chat memory
* Basic Information: 

| interface description | save chat memory  |
|----------------|--------------|
| URL | /character/memory/save  |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y   | user id   |        |
| 2 | title      | string | Y   |           |        |
| 3 | session_id | number | Y   |           |        |
| 4 | uniq_ids   | array  | Y   |           |        |
| 5 | memory_id  | number | N   | for edit  |        |
| 6 | type       | string | N   | chat/story  |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            memory_id: 1
        }
    }
    ```

### 12.5 release or unrelease chat memory
* Basic Information: 

| interface description | release or unrelease chat memory  |
|----------------|--------------|
| URL | /character/memory/release  |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y   | user id   |        |
| 2 | memory_id | number | Y   |           |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            is_released: true // false
        }
    }
    ```

### 12.6 get saveed chat memorios
* Basic Information: 

| interface description | get saveed chat memorios  |
|----------------|--------------|
| URL | /character/memory/getSaved |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y   | user id   |        |
| 2 | character_id | number | N |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                memory_id: 1,
                title: "",
                character: {
                    avatar: "https://charactrxxxxxx/xxxxx.png",
                    name: "Lily"
                },
                user: {
                    avatar: "https://charactrxxxxxx/xxxxx.png",
                    name: "username"
                },
                images: [
                    "https://charactrxxxxxx/xxxxx1.png",
                    "https://charactrxxxxxx/xxxxx2.png"
                ],
                memories: [
                    { uniqId: 11, idx: 1, name: "AI", content: "Hi~", timestamp: "20230506 11:00:00", is_human: false, image: "https://xxxxxxxxxx.jpg" },
                    { uniqId: 13, idx: 2, name: "You", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true, image: "" },
                    { uniqId: 21, idx: 3, name: "AI", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true, image: "" }
                ],
                view_count: 0,
                like_count: 0,
                is_like: false
            }
        ]
    }
    ```


### 12.7 set memory detail
* Basic Information: 

| interface description | set memory detail  |
|----------------|--------------|
| URL | /character/memory/set |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y   | user id   |        |
| 2 | memory_id | number | Y   |           |        |
| 3 | is_anonymity | bool | N  |           |        |
| 4 | is_publicize_image | bool | N  |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            memory_id: 1,
            is_anonymity: false,
            is_publicize_image: true
        }
    }
    ```


### 12.8 get liked memories
* Basic Information: 

| interface description | get liked memories  |
|----------------|--------------|
| URL | /character/memory/getLikedMemories |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y   | user id   |        |
| 2 | limit     | number | Y   |           |        |
| 3 | page_no   | number | Y   |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                memory_id: 1,
                title: "",
                character: {
                    avatar: "https://charactrxxxxxx/xxxxx.png",
                    name: "Lily"
                },
                user: {
                    avatar: "https://charactrxxxxxx/xxxxx.png",
                    name: "username"
                },
                images: [
                    "https://charactrxxxxxx/xxxxx1.png",
                    "https://charactrxxxxxx/xxxxx2.png"
                ],
                memories: [
                    { uniqId: 11, idx: 1, name: "AI", content: "Hi~", timestamp: "20230506 11:00:00", is_human: false, image: "https://xxxxxxxxxx.jpg" },
                    { uniqId: 13, idx: 2, name: "You", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true, image: "" },
                    { uniqId: 21, idx: 3, name: "AI", content: "Hello~", timestamp: "20230506 11:00:00", is_human: true, image: "" }
                ],
                view_count: 0,
                like_count: 0,
                is_like: true
            }
        ]
    }
    ```


### 12.9 remove chat memories
* Basic Information: 

| interface description | remove chat memories  |
|----------------|--------------|
| URL | /character/memory/remove |
| message format | JSON         |
| request method | POST         |


* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y   | user id   |        |
| 2 | memory_ids | array  | Y   |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```


## 13. story related interface
### 13.1 create story
* Basic Information: 

| interface description | create story  |
|----------------|--------------|
| URL | /character/story/create |
| message format | JSON         |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | N   | user id   |        |
| 2 | character_id   | number | Y   |           |        |
| 3 | title | string | Y   |           |        |
| 3 | cover | string | Y   |           |   url     |
| 3 | background | string | Y   |           |    url    |
| 3 | scene | string | Y   |           |        |
| 3 | greeting | string | Y   |           |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            story_id: 1
        }
    }
    ```

### 13.2 create story session / open story session by session_id
* Basic Information: 

| interface description | create story session / open story session by session_id  |
|----------------|--------------|
| URL | /character/story/session/open  |
| message format | JSON         |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y   | user id   |        |
| 2 | story_id | number | Y   |           |        |
| 3 | session_id | number | N  | session id     |        |
| 4 | from_app   | number | N  |                |        |
| 5 | limit     | number | Y   |           |        |
| 6 | page_no   | number | Y   |           |        |
| 7 | create   | number | N   |     0/1      |        |


* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 1,
            is_latest: true,
            custom_profile: {
                username: "user name",
                age: 18,
                sex: "Female"
            },
            context: [
                { idx: 1, name: "AI", content: "Hi~", timestamp: "20230506 11:00:00", target_message: "", target_lang: "", uniq_id: 123 },
            ],
            timestamp: "2023-05-05 11:00:00",
            is_generate: false
        }
    }
    ```

### 13.3 update session profile
* Basic Information: 

| interface description | update session profile |
|----------------|--------------|
| URL | /character/story/session/update |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id      |        |
| 2 | session_id   | number | Y | session id   |        |
| 3 | id           | number | Y | custom profile id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 13.4 generate story
* Basic Information: 

| interface description | generate story |
|----------------|--------------|
| URL | /character/story/generate      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | content     | string | N  |             |        |
| 4 | uniqId      | number | N  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"done":false,"content":"\n\n*msgs"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":false,"uniqId":12,"done":true,"content":"\n\n*msgs done*"}}
    ```

### 13.5 reGenerate story
* Basic Information: 

| interface description | reGenerate story |
|----------------|--------------|
| URL | /character/story/regenerate    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"done":false,""content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"done":false,""content":"\n\n*msgs"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"is_alternative":true,"uniqId":12,"done":true,"content":"\n\n*msgs done*"}}
    ```

### 13.6 generate story for user
* Basic Information: 

| interface description | generate story for user |
|----------------|--------------|
| URL | /character/story/generate/user  |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | batch_size  | number | Y  |             |        |

* Sample returned successfully( batch_size <= 1): 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"content":"\n\n*msgs"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":true,"content":"\n\n*msgs done*"}}
    ```

* Sample returned successfully( batch_size > 1): 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"contents":[{"content":"",target_message:"",target_lang:""}]}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"contents":[{"content":"\n\n*msgs",target_message:"",target_lang:""}]}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":true,"contents":[{"content":"\n\n*msgs",target_message:"",target_lang:""}]}}
    ```

### 13.7 get the last content
* Basic Information: 

| interface description | get the last dialog |
|----------------|--------------|
| URL | /character/story/latest/content |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y  | user id        |        |
| 2 | session_id    | number | Y  | session id     |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":false,"content":"\n\n"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"done":false,"content":"\n\n*msgs"}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"is_alternative":true,"uniqId":12,"done":true,"content":"\n\n*msgs done*"}}
    ```

### 13.8 can be summary
* Basic Information: 

| interface description | can be summary  |
|----------------|--------------|
| URL | /character/story/summary/status/get |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            to_summary: 0 // 1, 2
        }
    }
    ```

### 13.9 generate Summary
* Basic Information: 

| interface description | generate Summary  |
|----------------|--------------|
| URL | /character/story/summary/generate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"done":false,"timestamp":"20241101 11:11:11","summarys":[{"content":"",target_message:"",target_lang:"",summary_model_id:"",model_id:0}]}}
    {"code":0,"msg":"success","result":{"done":true,"timestamp":"20241101 11:11:11","summarys":[{"content":"xxx",target_message:"",target_lang:"",summary_model_id:"",model_id:0,uniq_id:123123}]}}
    ```

### 13.10 edit Summary
* Basic Information: 

| interface description | edit Summary  |
|----------------|--------------|
| URL | /character/story/summary/edit |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | uniq_id     | number | Y  |             |        |
| 4 | content     | string | N  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 13.11 delete content from idx
* Basic Information: 

| interface description | delete content from idx |
|----------------|--------------|
| URL | /character/story/content/delete    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | idx         | number | Y  | content idx |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 13.12 delete story
* Basic Information: 

| interface description | delete story |
|----------------|--------------|
| URL | /character/story/delete      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id     |        |
| 2 | story_id | number | Y |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 13.13 generate image/gif by dialog
* Basic Information: 

| interface description | generate image/gif by dialog |
|----------------|--------------|
| URL | /character/story/draw   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id    | number | Y  | user id        |        |
| 2 | session_id | number | Y  | session id     |        |
| 3 | is_gif     | number | Y  | 0/1   |        |
| 4 | from_app   | number | N  |       |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            create_id: "xxxxxxxxxxxxxxxxx"
        }
    }
    ```

### 13.14 generate audio
* Basic Information: 

| interface description | generate audio |
|----------------|--------------|
| URL | /character/story/audio/generate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | uniq_id     | number | Y  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            url: "https://xxxxxxxxxxxxxxxxx.wav",
            model_id: 10
        }
    }
    ```

### 13.15 list scene/greeting examples
* Basic Information: 

| interface description | list scene/greeting examples |
|----------------|--------------|
| URL | /character/story/example/scene |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y  | user id     |        |
| 2 | limit   | number | Y  |             |        |
| 3 | page_no | number | Y  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            total_count: 10,
            scenes: [
                { 
                    id: 1, 
                    scene: 'xxxxx', 
                    greetings: [
                        "greeting1",
                        "greeting2"
                    ] 
                }
            ]
        }
    }
    ```

### 13.16 list greeting examples        // deprecated
* Basic Information: 

| interface description | list greeting examples |
|----------------|--------------|
| URL | /character/story/example/greeting |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | id          | number | Y  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            "greeting1",
            "greeting2"
        ]
    }
    ```

## 14. group chat related interface
### 14.1 get group chat profile
* Basic Information: 

| interface description | get group chat profile  |
|----------------|--------------|
| URL | /character/group/profile |
| message format | JSON         |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |
| 2 | group_id | number | Y   |           |        |
| 3 | lang    | string | Y   |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            group_id: 1,
            title: "xxxx",
            cover_prompt: "xxxxxx",
            cover: "xxxxxx.jpg",
            background: "xxxxxx.jpg",
            scenario: "xxxx",
            characters: [
              { name: 'xxx', avatar: 'xxx.jpg', character_id: 12 }
            ],
            relationship: [
              { char1_id: 12, char2_id: 14, detail: "xxxx" }
            ],
            greetings: [
              { character_id: 12, greeting: "xxxx" }
            ]
        }
    }
    ```
### 14.2 create/edit group chat
* Basic Information: 

| interface description | create/edit group chat  |
|----------------|--------------|
| URL | /character/group/craft  |
| message format | JSON         |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number | Y   | user id   |        |
| 2 | group_id | number | N   |           |        |
| 3 | title | string | Y   |           |        |
| 3 | cover_prompt | string | Y   |           |       |
| 3 | cover | string | Y   |           |   url     |
| 3 | background | string | Y   |           |    url    |
| 3 | scenario | string | Y   |           |        |
| 3 | character_ids | array | Y   |   [ 1, 2, 34 ]        |        |
| 3 | relationship | array | Y   |   [ { char1_id: 12, char2_id: 14, detail: "xxxx" } ]        |        |
| 3 | greetings | array | Y   |   [ { character_id: 12, greeting: "xxxx" } ]        |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            group_id: 1
        }
    }
    ```
### 14.3 delete group
* Basic Information: 

| interface description | delete group |
|----------------|--------------|
| URL | /character/group/delete      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y | user id     |        |
| 2 | group_id | number | Y |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 14.4 create group session / open group session by session_id
* Basic Information: 

| interface description | create group session / open group session by session_id  |
|----------------|--------------|
| URL | /character/group/session/open  |
| message format | JSON         |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id  | number | Y   | user id   |        |
| 2 | group_id | number | Y   |           |        |
| 3 | session_id | number | N  | session id     |        |
| 4 | system   | string | Y  |                |        |
| 5 | limit     | number | Y   |           |        |
| 6 | page_no   | number | Y   |           |        |
| 7 | to_create | number | N   |     0/1      |        |
| 8 | personal_id | number | N   | 用于新建 session |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            session_id: 1,
            is_latest: true,
            custom_profile: {
                avatar: "xxxxx.jpg",
                username: "user name",
                age: 18,
                sex: "Female"
            },
            context: [
                {
                    "idx": 85,
                    "name": "AI_29_Claudia",
                    "timestamp": "2024-10-31T05:18:42.000Z",
                    "audio": "",
                    "image": null,
                    "image_from_app": null,
                    "target_message": "",
                    "target_lang": null,
                    "content": "*xxxx.*",
                    "character_id": "29",
                    "reply_id": "0",
                    "uniq_id": 826
                }
            ],
            extion: {
                "group_id": 3,
                "title": "Sister Alliance",
                "scenario": "A group of girls who love to lie",
                "relationship": [
                    {
                        "char1_id": 0,
                        "char2_id": 236,
                        "detail": "younger sister",
                        "id": "7390bdea-d9c4-4a9c-94d8-70c1f99f98e8"
                    }
                ],
                "character_ids": [
                    20,
                    29
                ],
                "tokens_scenario": 8,
                "tokens_relationship": 64,
                "characters": [
                    {
                        "character_id": 20,
                        "name": "Ava",
                        "avatar": "https://xxxxxxxxjpg",
                        "background": "",
                        "charge": 0,
                        "is_purchase": true,        // deprecated
                        "need_to_purchase": false
                    },
                    {
                        "character_id": 29,
                        "name": "Claudia",
                        "avatar": "https://xxxxxxx.jpg",
                        "background": "",
                        "charge": 0,
                        "is_purchase": true,
                        "need_to_purchase": false
                    }
                ],
                "background": ""
            },
            timestamp: "2023-05-05 11:00:00",
            is_generate: false
        }
    }
    ```
### 14.5 update session profile
* Basic Information: 

| interface description | update session profile |
|----------------|--------------|
| URL | /character/group/session/update |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id      |        |
| 2 | session_id   | number | Y | session id   |        |
| 3 | personal_id  | number | Y | personalid   |        |
| 4 | extion  | object | N | { title:'', scenario:'', relationship: [], character_ids: [] }   |        |
| 5 | lang    | string | N |    |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 14.6 commit user content
* Basic Information: 

| interface description | commit user content |
|----------------|--------------|
| URL | /character/group/user/commit |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id      |        |
| 2 | session_id   | number | Y | session id   |        |
| 3 | content     | string | N  |             |        |
| 4 | uniq_id     | number | N  |             |        |
| 5 | lang        | string | N  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            user_uniq_id: 123,
            idx: 2
        }
    }
    ```
### 14.7 group chat generate
* Basic Information: 

| interface description | group chat generate |
|----------------|--------------|
| URL | /character/group/generate/sse |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 4 | uniq_id     | number | N  |             |        |
| 5 | speaker     | string | N  | AI_$id/USER/NARRATOR | default: AI |
| 6 | batch_size  | number | N  |   only valid when speaker is 'USER' |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"done":false,"content":"xxx","target_message":"xxx","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"done":false,"content":"xxx","target_message":"xxx","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"done":true,"content":"xxx done","target_message":"xxx","target_lang":"","uniq_id":123}}
    ```

* Sample returned successfully ( speaker == 'USER' ): 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"contents":[{"content":"",target_message:"",target_lang:""}]}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"contents":[{"content":"\n\n*msgs",target_message:"",target_lang:""}]}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":true,"contents":[{"content":"\n\n*msgs",target_message:"",target_lang:""}]}}
    ```
### 14.8 group chat regenerate
* Basic Information: 

| interface description | group chat regenerate |
|----------------|--------------|
| URL | /character/group/regenerate/sse |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 2 | reply_id    | number | N  |             |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"done":false,"content":"xxx","target_message":"xxx","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"done":false,"content":"xxx","target_message":"xxx","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":2,"done":true,"content":"xxx done","target_message":"xxx","target_lang":"","uniq_id":123}}
    ```
### 14.9 get the last content
* Basic Information: 

| interface description | get the last dialog |
|----------------|--------------|
| URL | /character/group/latest/content/sse |
| message format | javascript   |
| request method | GET          |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id       | number | Y  | user id        |        |
| 2 | session_id    | number | Y  | session id     |        |

* Sample returned successfully: 

    ```text
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"content":"xxx","target_message":"xxx","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":false,"content":"xxx","target_message":"xxx","target_lang":""}}
    {"code":0,"msg":"success","result":{"session_id":1,"idx":0,"done":true,"content":"xxx done","target_message":"xxx","target_lang":"","uniq_id":123}}
    ```

### 14.10 edit AI content
* Basic Information: 

| interface description | edit AI content |
|----------------|--------------|
| URL | /character/group/chat/edit |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 2 | uniq_id  | number | Y  |             |        |
| 2 | content  | string | Y  |             |        |
| 2 | lang  | string | N  |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 14.11 delete content from idx
* Basic Information: 

| interface description | delete content from idx |
|----------------|--------------|
| URL | /character/group/content/delete    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id     | number | Y  | user id     |        |
| 2 | session_id  | number | Y  |             |        |
| 3 | idx         | number | Y  | content idx |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```
### 14.12 delete group's chat
* Basic Information: 

| interface description | delete group's chat |
|----------------|--------------|
| URL | /character/group/session/delete      |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id      | number | Y | user id     |        |
| 2 | group_id | number | N |             |        |
| 2 | session_id | number | N |             |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

### 14.13 list user's groups ( create/chatted )
* Basic Information: 

| interface description | list user's groups ( create/chatted ) |
|----------------|--------------|
| URL | /character/group/user/list    |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y  | user id     |        |
| 2 | type      | string | Y  | create/chatted |        |
| 2 | system    | string | Y  |           |        |
| 5 | limit     | number | Y  |           |        |
| 6 | page_no   | number | Y  |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            group_id: 1,
            title: 'xxxxxx',
            cover: 'xxxxx.jpg',
            is_released: 1,
            characterss: [],
            character_ids: [],
            review_level: 0
        ]
    }
    ```
  
### 14.14 release/unrelease group
* Basic Information: 

| interface description | release/unrelease group |
|----------------|--------------|
| URL | /character/group/release |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y  | user id     |        |
| 2 | group_id  | number | Y  |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```
  
### 14.15 get home page groups
* Basic Information: 

| interface description | get home page groups |
|----------------|--------------|
| URL | /character/group/list   |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y  | user id     |        |
| 2 | limit  | number | Y  |           |        |
| 2 | page_no  | number | Y  |           |        |
| 2 | system  | string | Y  |           |        |
| 2 | lang  | string | Y  |           |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: [
            {
                "group_id": 34,
                "creater_id": 944,
                "title": "1025",
                "cover": "https://xxxxxxxx.webp",
                "background": "xxxxxxx.jpg",
                "scenario": "xxxxxxxx",
                "gen_count": 3,
                "creater": "Anonymous",
                "characters": [
                    {
                        "character_id": 20,
                        "name": "Ava",
                        "avatar": "https://xxxxxxx/Ava.jpg"
                    },
                    {
                        "character_id": 29,
                        "name": "Claudia",
                        "avatar": "https://xxxxxxx/Claudia.jpg"
                    }
                ]
            }
        ]
    }
    ```

### 14.16 chat session migrate to gourp session
* Basic Information: 

| interface description | chat session migrate to gourp session |
|----------------|--------------|
| URL | /character/group/migrate |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y  | user id        |        |
| 2 | chat_session_id | number | Y  |    |        |
| 2 | character_ids | array | Y  |  at least one character_id   |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            group_id: 123,
            session_id: 456
        }
    }
    ```

### 14.17 report group
* Basic Information: 

| interface description | report group |
|----------------|--------------|
| URL | /character/group/report |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id   | number | Y  | user id        |        |
| 2 | group_id  | number | Y  |    |        |

* Sample returned successfully: 

    ```javascript
    {
        code: 0,
        msg: "success",
        result: {
            status: 0
        }
    }
    ```

## 15. nowpayments related interface
### 15.1 subscribe
 * Basic Information: 

| interface description | subscribe |
|----------------|--------------|
| URL | /api/nowpayments/subscribe |
| message format | javascript   |
| request method | POST         |

* Params: 

| # | Param  | Data type | Must | Explanation | Remark |
|---|--------|-----------|------|------------ |--------|
| 1 | user_id | number    |  Y   | user id |        |
| 2 | id | number    |  Y   |  |        |

* Sample returned successfully: 
    ```javascript
    {
        "code": 0,
        "msg": "success",
        "result": {
            "id": "xxxxxxxx",
            "url": "https://nowpayments.io/payment/?iid=xxxxxxxx"
        }
    }
    ```


## Description of returned data code

| # | Code | Description | Remark |
|---|------|-------------|--------|
|   |  0   | success state |      |
|   |  1   | internal server error |      |
|   |  2   | session missing |      |
|   |  3   | session expire  |   get token again    |
|   |  4   | session invalid |   get token again    |