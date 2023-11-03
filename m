Return-Path: <dmaengine+bounces-46-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBB7E07F3
	for <lists+dmaengine@lfdr.de>; Fri,  3 Nov 2023 19:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3881FB21127
	for <lists+dmaengine@lfdr.de>; Fri,  3 Nov 2023 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6E21342;
	Fri,  3 Nov 2023 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMml1wvv"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2402110E;
	Fri,  3 Nov 2023 18:13:52 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D191B9;
	Fri,  3 Nov 2023 11:13:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so2560901b3a.2;
        Fri, 03 Nov 2023 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699035230; x=1699640030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5ZnjWKSoiMOAK2jbFfNe1Me4iRaL9wQ2N2O/tccwS4=;
        b=aMml1wvvaUor0XY6ZGLOt+TFedk0riwyQRyi3gqEIIU8Z9PS4Xtpo5rf60P7ETaYkg
         16NPYN6Xdh4SyebTxHssnmiEmr9FRMtZ7w/LRD7wF/hqNxgPe83pselwxQtWcbOWgOA/
         61xx22MZYVnmWkPnJKFDqd81xrHWoOeQSzCu0zBljGplkZvGSdwdgnLCus6aibqEvYig
         /3p9bUUzkzvGg4WS7FBuLX6VkdjH6FNYUAYfsw3fa9pJ9/zrGRy+dZJv9lle+wzAFnp6
         J62JMA9+/Sxk+wIemX/PU3zVb1IYi/0fWUR0DpYwjivuSAYkjjIjSZ1q3X5qi6NNNNuO
         Kyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699035230; x=1699640030;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5ZnjWKSoiMOAK2jbFfNe1Me4iRaL9wQ2N2O/tccwS4=;
        b=WTWzy8mX25H9uBpkPo7zLWyQ0phGrG0tN98I79hMMV3L8x4B0XQTjVTaOGjVWy9/Ji
         eRTFmRSWgTIozmXNAqzvp9fhdJMGSpKQbx8koC3ZjfUq9AB65gotesZDYlSFCo9cE7nt
         zvdOH6hZ+iXRAd8y2P72SpJeazVn7E5SV5myD6tT6hTJvtPyKqDYDdFl0YDMc2dykyRm
         hFchYHuFynOhcj+dFQLqpxYReklSkqEXfzhrAvTL6HYaNA8pkCUupYIWFF1pi97l/zFv
         LnLquMq7Q0NB8M1lGxc+wIdt7ysyQvMzYbydYnRTPz0BoiZ0SS8Ydw/aFEzPHjn6GZkg
         9pnA==
X-Gm-Message-State: AOJu0YwyhkwHeVzJ9xyZAEguheEtBrwRNWP7whqrFizl7Zd5LpcHvo9s
	ubvO6Nnw9k13Rr+8PXnsruQ=
X-Google-Smtp-Source: AGHT+IE56uqaTF3MK5DiKKk4e0nwx7GpxfySMShdMT+6YdhW/dFXID0cDhOCALRrH5esACzz2EryWQ==
X-Received: by 2002:a05:6a21:3e02:b0:17f:d42e:201f with SMTP id bk2-20020a056a213e0200b0017fd42e201fmr2817727pzc.15.1699035230338;
        Fri, 03 Nov 2023 11:13:50 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id ff24-20020a056a002f5800b0069337938be8sm1710924pfb.110.2023.11.03.11.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 11:13:49 -0700 (PDT)
Message-ID: <95cdcdf4-eb20-4e0a-8313-86ba0a0d7004@gmail.com>
Date: Sat, 4 Nov 2023 02:13:38 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: scsi_debug: fix some bugs in
 sdebug_error_write()
Content-Language: en-US
From: Wenchao Hao <haowenchao22@gmail.com>
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
 <65b8f53d-4956-4440-bd4c-66475015aaff@gmail.com>
In-Reply-To: <65b8f53d-4956-4440-bd4c-66475015aaff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/23 2:00 AM, Wenchao Hao wrote:
> On 10/25/23 3:07 PM, Dan Carpenter wrote:
>> On Wed, Oct 25, 2023 at 02:10:41PM +0800, Wenchao Hao wrote:
>>> On 2023/10/25 12:11, Dan Carpenter wrote:
>>>> On Wed, Oct 25, 2023 at 01:09:34AM +0800, Wenchao Hao wrote:
>>>>> Yes, there is bug here if write with .c code. Because your change to use
>>>>> strndup_user() would make write with dirty data appended to "ubuf" failed,
>>>>
>>>> I don't understand this sentence.  What is "dirty" data in this context?
>>>>
>>>
>>> This is what I posted in previous reply:
>>>
>>> We might have following pairs of parameters for sdebug_error_write:
>>>
>>> ubuf: "0 -10 0x12\n0 0 0x2 0x6 0x4 0x2"
>>> count=11
>>>
>>> the valid data in ubuf is "0 -10 -x12\n", others are dirty data.
>>> strndup_user() would return EINVAL for this pair which caused
>>> a correct write to fail.
>>
>> I mean, I could just tell you that your kzalloc(count + 1, GFP_KERNEL)
>> fix will work.  It does work.
>>
>> But how is passing "dirty data" a "correct write"?  I feel like it
>> should be treated as incorrect and returning -EINVAL is the correct
>> behavior.  I'm so confused.  Why are users doing that?
>>
>> I have looked at the code and it just doesn't seem that complicated.
>> They shouldn't be passing messed up strings and expect the kernel to
>> allow it.
>>
> 
> First, echo command would call write() system call with string which is
> terminated with '\n'. (I come to this conclusion with strace, but did not
> check the source code of echo). So when we input echo "0 -10 0x12" > $error,
> following pairs would be passed to sdebug_error_write:
> 
> ubuf: "0 -10 0x12\n"
> count: 11
> 
> Second, it seems shell sh would not clean the dirty of previous execution.
> For example, dirty data is passed to sdebug_error_write with following steps. 
> 
> echo "2 -10 0x1b 0 0 0x2 0x6 0x4 0x2" > /sys/kernel/debug/scsi_debug/3:0:0:0/error
> echo "0 -10 0x1b" > /sys/kernel/debug/scsi_debug/3:0:0:0/error
> 
> I trace the parameters of sdebug_error_write with probe, following log is printed
> when executing above two echo commands:
> 
> trace log:
> 
> # tracer: nop
> #
> # entries-in-buffer/entries-written: 2/2   #P:8
> #
> #                                _-----=> irqs-off/BH-disabled
> #                               / _----=> need-resched
> #                              | / _---=> hardirq/softirq
> #                              || / _--=> preempt-depth
> #                              ||| / _-=> migrate-disable
> #                              |||| /     delay
> #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> #              | |         |   |||||     |         |
>               sh-13912   [007] ..... 482676.030303: sdebug_error_write: (sdebug_error_write+0x0/0x321 [scsi_debug]) comm="sh" count=31 ubuf="2 -10 0x1b 0 0 0x2 0x6 0x4 0x2
> "
>               sh-13912   [007] ..... 482676.030525: sdebug_error_write: (sdebug_error_write+0x0/0x321 [scsi_debug]) comm="sh" count=11 ubuf="0 -10 0x1b
> 0 0 0x2 0x6 0x4 0x2
> "
> 
> Here is command to add kprobe trace:
> echo 'p:sdebug_error_write sdebug_error_write comm=$comm count=$arg3:u64 ubuf=+0($arg2):ustring' >> /sys/kernel/debug/tracing/kprobe_events
> 
> It is proved that dirty data does exist, so I think we should now use strndup_user() here.

Sorry, its "should not use strndup_user()".

Thanks.

> 
> Thanks.
> 
>> regards,
>> dan carpenter
>>
> 


