Return-Path: <dmaengine+bounces-4816-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77000A7BBC2
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 13:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3623E17ACE4
	for <lists+dmaengine@lfdr.de>; Fri,  4 Apr 2025 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6E1DF721;
	Fri,  4 Apr 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xf8Q6A0D"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B051C5A;
	Fri,  4 Apr 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743767590; cv=none; b=qsIuW+zSs6NWSqJzwdrwO6JSv02ftAcjClQHmxN1QIKcLe0Zg8lmK0x86tNBn81F4jNdlPAwxkbr8h8N7F7ecHWgNkEF82azAgHMMf3dg1epfwAmpewcBlT7sNBChouy71pTO7nqXfmbxBT1VcAYrPzxPNUiWDijN0/NUQOROpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743767590; c=relaxed/simple;
	bh=enShrMQhzHuV2QFUuVSEFAnA+ItTuEMOfv17cqnkY3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJ3iihWcYoEu08nUZ59EY1xTG52rbzcleHja85/19OVKgWcjbxrOBTDauz8/Qgh6pm6Xz2l23BbZZABQ07+oa5/3LgWddmnOHytZJ4L2YvteE8RelQTb1HTAlFvDL8eMTVzwxJxx3t43OvYUSGQgrB/Z6K0tnqu9j1ceKpI2//A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xf8Q6A0D; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743767579; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hDt6lANfWbz9SDk6CjGNO07bg5Gs/3uMX+AENgcIecM=;
	b=xf8Q6A0D2ny8/rKQXohst8rBbLm9dYfk7v7hsJ5nL2P+RvwPratWvmUh2+SMhSITMf4a3mo3Siv7M+I5VzZXRIZX0PJm/BoyJs1OEH35f67F6yqCB4xxnXN2OFvPgX2dtJw4opBjDCynmGYx29ZapH2j7Btceppj6FZhiFCJa/k=
Received: from 30.246.161.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WUz6I16_1743767259 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Apr 2025 19:47:40 +0800
Message-ID: <ab0facc9-f7f1-4ba2-b56c-868d2f8e6807@linux.alibaba.com>
Date: Fri, 4 Apr 2025 19:47:39 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] dmaengine: idxd: Add missing cleanup for early
 error out in idxd_setup_internals
To: Fenghua Yu <fenghuay@nvidia.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, Markus.Elfring@web.de, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-5-xueshuai@linux.alibaba.com>
 <22b63198-2aab-481c-a4cd-74c3349e22f8@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <22b63198-2aab-481c-a4cd-74c3349e22f8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/3 07:26, Fenghua Yu 写道:
> 
> On 3/8/25 22:20, Shuai Xue wrote:
>> The idxd_setup_internals() is missing some cleanup when things fail in
>> the middle.
>>
>> Add the appropriate cleanup routines:
>>
>> - cleanup groups
>> - cleanup enginces
>> - cleanup wqs
>>
>> to make sure it exits gracefully.
>>
>> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/dma/idxd/init.c | 59 ++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 52 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index fe4a14813bba..7334085939dc 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -155,6 +155,26 @@ static void idxd_cleanup_interrupts(struct idxd_device *idxd)
>>       pci_free_irq_vectors(pdev);
>>   }
>> +static void idxd_clean_wqs(struct idxd_device *idxd)
>> +{
>> +    struct idxd_wq *wq;
>> +    struct device *conf_dev;
>> +    int i;
>> +
>> +    for (i = 0; i < idxd->max_wqs; i++) {
>> +        wq = idxd->wqs[i];
>> +        if (idxd->hw.wq_cap.op_config)
>> +            bitmap_free(wq->opcap_bmap);
>> +        kfree(wq->wqcfg);
>> +        conf_dev = wq_confdev(wq);
>> +        put_device(conf_dev);
>> +        kfree(wq);
>> +
> Please remove this blank line here, warned by checkpatch.

I checked with checkpatch, but it does not warn (:

./scripts/checkpatch.pl idxd-fix-v3/0004-dmaengine-idxd-Add-missing-cleanup-for-early-error-o.patch
total: 0 errors, 0 warnings, 91 lines checked

idxd-fix-v3/0004-dmaengine-idxd-Add-missing-cleanup-for-early-error-o.patch has no obvious style problems and is ready for submission.


Will send a new version to fix it and collect all you reviewed-by tag,
Thanks.

>> +    }
>> +    bitmap_free(idxd->wq_enable_map);
>> +    kfree(idxd->wqs);
>> +}
>> +
>>   static int idxd_setup_wqs(struct idxd_device *idxd)
>>   {
>>       struct device *dev = &idxd->pdev->dev;
>> @@ -245,6 +265,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>       return rc;
>>   }
>> +static void idxd_clean_engines(struct idxd_device *idxd)
>> +{
>> +    struct idxd_engine *engine;
>> +    struct device *conf_dev;
>> +    int i;
>> +
>> +    for (i = 0; i < idxd->max_engines; i++) {
>> +        engine = idxd->engines[i];
>> +        conf_dev = engine_confdev(engine);
>> +        put_device(conf_dev);
>> +        kfree(engine);
>> +    }
>> +    kfree(idxd->engines);
>> +}
>> +
>>   static int idxd_setup_engines(struct idxd_device *idxd)
>>   {
>>       struct idxd_engine *engine;
>> @@ -296,6 +331,19 @@ static int idxd_setup_engines(struct idxd_device *idxd)
>>       return rc;
>>   }
>> +static void idxd_clean_groups(struct idxd_device *idxd)
>> +{
>> +    struct idxd_group *group;
>> +    int i;
>> +
>> +    for (i = 0; i < idxd->max_groups; i++) {
>> +        group = idxd->groups[i];
>> +        put_device(group_confdev(group));
>> +        kfree(group);
>> +    }
>> +    kfree(idxd->groups);
>> +}
>> +
>>   static int idxd_setup_groups(struct idxd_device *idxd)
>>   {
>>       struct device *dev = &idxd->pdev->dev;
>> @@ -410,7 +458,7 @@ static int idxd_init_evl(struct idxd_device *idxd)
>>   static int idxd_setup_internals(struct idxd_device *idxd)
>>   {
>>       struct device *dev = &idxd->pdev->dev;
>> -    int rc, i;
>> +    int rc;
>>       init_waitqueue_head(&idxd->cmd_waitq);
>> @@ -441,14 +489,11 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>>    err_evl:
>>       destroy_workqueue(idxd->wq);
>>    err_wkq_create:
>> -    for (i = 0; i < idxd->max_groups; i++)
>> -        put_device(group_confdev(idxd->groups[i]));
>> +    idxd_clean_groups(idxd);
>>    err_group:
>> -    for (i = 0; i < idxd->max_engines; i++)
>> -        put_device(engine_confdev(idxd->engines[i]));
>> +    idxd_clean_engines(idxd);
>>    err_engine:
>> -    for (i = 0; i < idxd->max_wqs; i++)
>> -        put_device(wq_confdev(idxd->wqs[i]));
>> +    idxd_clean_wqs(idxd);
>>    err_wqs:
>>       return rc;
>>   }
> 
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> 
> Thanks.
> 
> -Fenghua


Thanks.

Cheers,
Shuai


