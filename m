Return-Path: <dmaengine+bounces-45-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D067C7E07E3
	for <lists+dmaengine@lfdr.de>; Fri,  3 Nov 2023 19:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60388B20AFF
	for <lists+dmaengine@lfdr.de>; Fri,  3 Nov 2023 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50C210FF;
	Fri,  3 Nov 2023 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMe0wpwo"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BD18626;
	Fri,  3 Nov 2023 18:00:35 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143B2D44;
	Fri,  3 Nov 2023 11:00:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so2443637a12.0;
        Fri, 03 Nov 2023 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699034429; x=1699639229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXd01u8s8gECIb4ZeeRSiRqCzypgHIXS8Szs1ZiS6Tg=;
        b=mMe0wpwoaenKQRKqLik3z8E3NQcMpsUMRYc5LmMPBjfKUfSzxFVxsnjqzxrl2TMuUI
         SGmKJfZRx9JWIEBL+R4okHEFydjwyoqFycYLpYCku7WQqhXZmUbIig9f6b/g8bcpfNzh
         FB9eT09suV9aVI8jy16Zaay0wdhMJqgVuXcPc6668wTq3DFsTjjkuEw7UwlRhhDBf5gb
         PQCVSHwmCy2GWcBcBqeVNNFkZmsSY7HQoIKlEy2AEcbcwDgteCVpbpQ8vf7jfPb+/ivA
         xCxj4mxYMFN3Neg2Zlz1N2WGh5YUEBtY7CpJaGHd1pV4M8bBdWMAlsrLvygl5MEFVf6v
         bftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699034429; x=1699639229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXd01u8s8gECIb4ZeeRSiRqCzypgHIXS8Szs1ZiS6Tg=;
        b=oWfrjLihfb1x1q+fPKmeQlJBQfuLjMGIB2h2AF7CemW8hrmFd/EtP9y0gSrVKpv2k7
         BKaZ/dl3NjZ2kJTGmszLbSaW+juNUg52cTXDRW5DVSzxnHC6Wkn3tgYa7iAc3Q/Lspb6
         dNjAHNCpfqfa0NZeYgBCXKVjPtG2qoBOifzwE981NH8tuhoHObv5UP3wUe/Lt3EJ/Udi
         3omCNrI9jRIzgdoKOG3pvWB620i0EgRBDAk+eS020Qo1gLAJlDiWrkSeAWttY4NsDD/G
         H70w3TQkCKTVP+C3oTHUD6acjq9N9HmnG2wgD6L4LGsWBtuXaqz+vx2R3pWBRjzxN71q
         LKvg==
X-Gm-Message-State: AOJu0YwG7xrXSObakxFsVrJr0IWZ48/l5CvLXTBCffnXREzUQn20bk38
	bNdrdc1171cUDWxjKEj4jfQ=
X-Google-Smtp-Source: AGHT+IHau5+/xuZkna2xIUKpz5ip5IOq2QpswpbkcBgn7DiL9/8AqeAoQEArRWer89/aSBY1gk5Y1Q==
X-Received: by 2002:a05:6a20:8f1c:b0:174:7f7:d049 with SMTP id b28-20020a056a208f1c00b0017407f7d049mr23962196pzk.9.1699034429414;
        Fri, 03 Nov 2023 11:00:29 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709026e1600b001b9c5e07bc3sm1699596plk.238.2023.11.03.11.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 11:00:28 -0700 (PDT)
Message-ID: <65b8f53d-4956-4440-bd4c-66475015aaff@gmail.com>
Date: Sat, 4 Nov 2023 02:00:11 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: scsi_debug: fix some bugs in
 sdebug_error_write()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Wenchao Hao <haowenchao2@huawei.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Vinod Koul <vkoul@kernel.org>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Douglas Gilbert <dgilbert@interlog.com>, dmaengine@vger.kernel.org,
 linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <96d50cf7-afec-46af-9d98-08099f8dc76e@moroto.mountain>
 <CAOptpSMTgGwyFkn8o6qAEnUKXh+_mOr8dQKAZUWfM_4QEnxzxw@mail.gmail.com>
 <44b0eca3-57c1-4edd-ab35-c389dc976273@kadam.mountain>
 <cbe14e3a-11c7-4da5-b125-5801244e27f2@gmail.com>
 <9767953c-480d-4ad9-a553-a45ae80c572b@kadam.mountain>
 <afe1eca8-cdf8-612b-867e-4fef50ad423f@huawei.com>
 <9207ed62-4e41-4b8c-8aee-5143c1a71bf8@kadam.mountain>
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <9207ed62-4e41-4b8c-8aee-5143c1a71bf8@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/23 3:07 PM, Dan Carpenter wrote:
> On Wed, Oct 25, 2023 at 02:10:41PM +0800, Wenchao Hao wrote:
>> On 2023/10/25 12:11, Dan Carpenter wrote:
>>> On Wed, Oct 25, 2023 at 01:09:34AM +0800, Wenchao Hao wrote:
>>>> Yes, there is bug here if write with .c code. Because your change to use
>>>> strndup_user() would make write with dirty data appended to "ubuf" failed,
>>>
>>> I don't understand this sentence.  What is "dirty" data in this context?
>>>
>>
>> This is what I posted in previous reply:
>>
>> We might have following pairs of parameters for sdebug_error_write:
>>
>> ubuf: "0 -10 0x12\n0 0 0x2 0x6 0x4 0x2"
>> count=11
>>
>> the valid data in ubuf is "0 -10 -x12\n", others are dirty data.
>> strndup_user() would return EINVAL for this pair which caused
>> a correct write to fail.
> 
> I mean, I could just tell you that your kzalloc(count + 1, GFP_KERNEL)
> fix will work.  It does work.
> 
> But how is passing "dirty data" a "correct write"?  I feel like it
> should be treated as incorrect and returning -EINVAL is the correct
> behavior.  I'm so confused.  Why are users doing that?
> 
> I have looked at the code and it just doesn't seem that complicated.
> They shouldn't be passing messed up strings and expect the kernel to
> allow it.
> 

First, echo command would call write() system call with string which is
terminated with '\n'. (I come to this conclusion with strace, but did not
check the source code of echo). So when we input echo "0 -10 0x12" > $error,
following pairs would be passed to sdebug_error_write:

ubuf: "0 -10 0x12\n"
count: 11

Second, it seems shell sh would not clean the dirty of previous execution.
For example, dirty data is passed to sdebug_error_write with following steps. 

echo "2 -10 0x1b 0 0 0x2 0x6 0x4 0x2" > /sys/kernel/debug/scsi_debug/3:0:0:0/error
echo "0 -10 0x1b" > /sys/kernel/debug/scsi_debug/3:0:0:0/error

I trace the parameters of sdebug_error_write with probe, following log is printed
when executing above two echo commands:

trace log:

# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
              sh-13912   [007] ..... 482676.030303: sdebug_error_write: (sdebug_error_write+0x0/0x321 [scsi_debug]) comm="sh" count=31 ubuf="2 -10 0x1b 0 0 0x2 0x6 0x4 0x2
"
              sh-13912   [007] ..... 482676.030525: sdebug_error_write: (sdebug_error_write+0x0/0x321 [scsi_debug]) comm="sh" count=11 ubuf="0 -10 0x1b
0 0 0x2 0x6 0x4 0x2
"

Here is command to add kprobe trace:
echo 'p:sdebug_error_write sdebug_error_write comm=$comm count=$arg3:u64 ubuf=+0($arg2):ustring' >> /sys/kernel/debug/tracing/kprobe_events

It is proved that dirty data does exist, so I think we should now use strndup_user() here.

Thanks.

> regards,
> dan carpenter
> 


