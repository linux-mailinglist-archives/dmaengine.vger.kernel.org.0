Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4541D7D6175
	for <lists+dmaengine@lfdr.de>; Wed, 25 Oct 2023 08:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjJYGKt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Oct 2023 02:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYGKs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Oct 2023 02:10:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E58A6;
        Tue, 24 Oct 2023 23:10:45 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SFdjm5TFjzVlKJ;
        Wed, 25 Oct 2023 14:06:52 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 25 Oct 2023 14:10:42 +0800
Message-ID: <afe1eca8-cdf8-612b-867e-4fef50ad423f@huawei.com>
Date:   Wed, 25 Oct 2023 14:10:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] scsi: scsi_debug: fix some bugs in
 sdebug_error_write()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Wenchao Hao <haowenchao22@gmail.com>
CC:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <dmaengine@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <96d50cf7-afec-46af-9d98-08099f8dc76e@moroto.mountain>
 <CAOptpSMTgGwyFkn8o6qAEnUKXh+_mOr8dQKAZUWfM_4QEnxzxw@mail.gmail.com>
 <44b0eca3-57c1-4edd-ab35-c389dc976273@kadam.mountain>
 <cbe14e3a-11c7-4da5-b125-5801244e27f2@gmail.com>
 <9767953c-480d-4ad9-a553-a45ae80c572b@kadam.mountain>
Content-Language: en-US
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <9767953c-480d-4ad9-a553-a45ae80c572b@kadam.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2023/10/25 12:11, Dan Carpenter wrote:
> On Wed, Oct 25, 2023 at 01:09:34AM +0800, Wenchao Hao wrote:
>> Yes, there is bug here if write with .c code. Because your change to use
>> strndup_user() would make write with dirty data appended to "ubuf" failed,
> 
> I don't understand this sentence.  What is "dirty" data in this context?
> 

This is what I posted in previous reply:

We might have following pairs of parameters for sdebug_error_write:

ubuf: "0 -10 0x12\n0 0 0x2 0x6 0x4 0x2"
count=11

the valid data in ubuf is "0 -10 -x12\n", others are dirty data.
strndup_user() would return EINVAL for this pair which caused
a correct write to fail.

>> can we fix it with following change:
>>
>> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
>> index 67922e2c4c19..0e8ct724463f 100644
>> --- a/drivers/scsi/scsi_debug.c
>> +++ b/drivers/scsi/scsi_debug.c
>> @@ -1019,7 +1019,7 @@ static seize_t sdebug_error_write(struct file *file, const char __user *ubuf,
>>          struct sdebug_err_inject *inject;
>>          struct scsi_device *sdev = (struct scsi_device *)file->f_inode->i_private;
>>   
>> -       buf = kmalloc(count, GFP_KERNEL);
>> +       buf = kzalloc(count + 1, GFP_KERNEL);
> 
> That would also fix the bug.
> 
>>          if (!buf)
>>                  return -ENOMEM;
>>
>> Or is there other kernel lib function which can address this issue?
> 
> I don't understand the issue.
> 

I mean the bug you mentioned.

Thanks.

> regards,
> dan carpenter
> 
> 

