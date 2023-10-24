Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76A67D5972
	for <lists+dmaengine@lfdr.de>; Tue, 24 Oct 2023 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343756AbjJXRKC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Oct 2023 13:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjJXRKB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Oct 2023 13:10:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D19123;
        Tue, 24 Oct 2023 10:09:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso32495995ad.0;
        Tue, 24 Oct 2023 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698167398; x=1698772198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yraf/r3LgDKdGU7IC1yuKox4vPTdXOKCfqDIp0Hoc9U=;
        b=msv7jzFiXNlvpJq0dwB94dNzYFPVLDM5N2J4eAKC8w0/v1rjRor6PTCB+B0SqumpG8
         51aT8klFWazz6CJFoWG7MTYTaavrlQilQp7S3zuMUk7uTqLzpmOwBoDYEpWVlVC4gTCT
         pGIaoPWph6vgUvv3QojMx2QaHD2I/CWfcKa+i02bdew13wwfnAhcV6ZKfGXJwrVm4uEF
         ny6DYQgkbALBrxFgZ7mKY8RiDJbrjMBt5XlWROhJOiojq2Q1JcXvFvt8QEtf+WAxtF46
         HUmVKWdushVC3TsK3m/v1Qx586eKOWxvd8btcKd+xrz5I6IwdfPRxsG3LtX02qSiWPvV
         A7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698167399; x=1698772199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yraf/r3LgDKdGU7IC1yuKox4vPTdXOKCfqDIp0Hoc9U=;
        b=qmVbED7F5X2AmBupkKMmetGCQWqiM6Y05BrzSpmpiCSasGm2l05qez8tRcIFBnS2hp
         wN0c4yqA/edrz1G3bHbLSGosfYYSlDieL2o3dawSSIZKFyTfbjReeMuPlcdU1xQeBK9E
         l8pmdvjLeTomdCVYzxrrPIdgwvxn2REiKwQH2bunKnUfSLeYcGOHTe7COm3ygZVW5Iyn
         n4D822RUVT44LOL1W19HVtP2y4rMg2qDfInnE5ttzTgBJViKPFHEiYzusX1t6iKKsiwB
         Qjh3EJsjjqcyfPcwX2o+3QePCCTki113ROJYUAR/1mSDukmcb1jGSi+9l1H+OxkGsZpC
         t2qA==
X-Gm-Message-State: AOJu0Yzjtr5V463JMRwDiCSTOXT6JSufLe4t+hY5VMJjoY1O8+EeKPWd
        jNsd++VAxVyylzFZfCUbjJ0=
X-Google-Smtp-Source: AGHT+IFyPec7EkH/coBE09bGlow88NxS7rRVAeU6Ib9G7osqptxCOIliV/Q8kkLiE5rAFNr1JXhC4Q==
X-Received: by 2002:a17:903:280b:b0:1ca:86b:7ed3 with SMTP id kp11-20020a170903280b00b001ca086b7ed3mr8839119plb.40.1698167398559;
        Tue, 24 Oct 2023 10:09:58 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001c5076ae6absm7643471plg.126.2023.10.24.10.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 10:09:57 -0700 (PDT)
Message-ID: <cbe14e3a-11c7-4da5-b125-5801244e27f2@gmail.com>
Date:   Wed, 25 Oct 2023 01:09:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] scsi: scsi_debug: fix some bugs in
 sdebug_error_write()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        dmaengine@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <96d50cf7-afec-46af-9d98-08099f8dc76e@moroto.mountain>
 <CAOptpSMTgGwyFkn8o6qAEnUKXh+_mOr8dQKAZUWfM_4QEnxzxw@mail.gmail.com>
 <44b0eca3-57c1-4edd-ab35-c389dc976273@kadam.mountain>
From:   Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <44b0eca3-57c1-4edd-ab35-c389dc976273@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10/23/23 9:39 PM, Dan Carpenter wrote:
> On Sat, Oct 21, 2023 at 06:10:44PM +0800, Wenchao Hao wrote:
>> On Fri, Oct 20, 2023 at 10:15 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>>
>>> There are two bug in this code:
>>
>> Thanks for your fix, some different points of view as follows.
>>
>>> 1) If count is zero, then it will lead to a NULL dereference.  The
>>> kmalloc() will successfully allocate zero bytes and the test for
>>> "if (buf[0] == '-')" will read beyond the end of the zero size buffer
>>> and Oops.
>>
>> This sysfs interface is usually used by cmdline, mostly, "echo" is used
>> to write it and "echo" always writes with '\n' terminated, which would
>> not cause a write with count=0.
>>
> 
> You are saying "sysfs" but this is debugfs.  Sysfs is completely
> different.  Also saying that 'and "echo" always writes with '\n'
> terminated' is not true either even in sysfs...
> 
>> While in terms of security, we should add a check for count==0
>> condition and return EINVAL.
> 
> Checking for zero is a valid approach.  I considered that but my way
> was cleaner.
> 
>>
>>> 2) The code does not ensure that the user's string is properly NUL
>>> terminated which could lead to a read overflow.
>>>
>>
>> I don't think so, the copy_from_user() would limit the accessed length
>> to count, so no read overflow would happen.
>>
>> Userspace's write would allocate a buffer larger than it actually
>> needed(usually 4K), but the buffer would not be cleared, so some
>> dirty data would be passed to the kernel space.
>>
>> We might have following pairs of parameters for sdebug_error_write:
>>
>> ubuf: "0 -10 0x12\n0 0 0x2 0x6 0x4 0x2"
>> count=11
>>
>> the valid data in ubuf is "0 -10 -x12\n", others are dirty data.
>> strndup_user() would return EINVAL for this pair which caused
>> a correct write to fail.
>>
>> You can recurrent the above error with my script attached.
> 
> You're looking for the buffer overflow in the wrong place.
> 
> drivers/scsi/scsi_debug.c
>   1026          if (copy_from_user(buf, ubuf, count)) {
>                                    ^^^
> We copy data from the user but it is not NUL terminated.
> 
>   1027                  kfree(buf);
>   1028                  return -EFAULT;
>   1029          }
>   1030  
>   1031          if (buf[0] == '-')
>   1032                  return sdebug_err_remove(sdev, buf, count);
>   1033  
>   1034          if (sscanf(buf, "%d", &inject_type) != 1) {
>                            ^^^
> This will read beyond the end of the buffer.  sscanf() relies on a NUL
> terminator to know when then end of the string is.
> 
>   1035                  kfree(buf);
>   1036                  return -EINVAL;
>   1037          }
> 
> Obviously the user in this situation is like a hacker who wants to do
> something bad, not a normal users.  For a normal user this code is fine
> as you say.
> 
> You will need to test this with .c code instead of shell if you want to
> see the bug.
> 
> regards,
> dan carpenter
> 

Yes, there is bug here if write with .c code. Because your change to use
strndup_user() would make write with dirty data appended to "ubuf" failed,
can we fix it with following change:

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 67922e2c4c19..0e8ct724463f 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1019,7 +1019,7 @@ static seize_t sdebug_error_write(struct file *file, const char __user *ubuf,
        struct sdebug_err_inject *inject;
        struct scsi_device *sdev = (struct scsi_device *)file->f_inode->i_private;
 
-       buf = kmalloc(count, GFP_KERNEL);
+       buf = kzalloc(count + 1, GFP_KERNEL);
        if (!buf)
                return -ENOMEM;

Or is there other kernel lib function which can address this issue?

Thanks.
