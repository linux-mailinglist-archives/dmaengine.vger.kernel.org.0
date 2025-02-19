Return-Path: <dmaengine+bounces-4529-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70BDA3B7DD
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 10:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389DB1881619
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 09:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2811A1DE8B4;
	Wed, 19 Feb 2025 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cRtniLhk"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EFD1DE88A;
	Wed, 19 Feb 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956156; cv=none; b=FSa+HWpQU6NmXIcjQbP/HD+V5bWXkiqL5+dJgO5ERPQwijLZAdUXaRQsVeO92RxHsbdLxVqmLrAbKXjzpUSuVPJbyd5Ge9C4AYaXuVnkdQSLnAygKZzI86XugASI03IbOVHaaokJwbqND07kNxuqAPDv+SBrX5iCd3A6DSt1g3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956156; c=relaxed/simple;
	bh=9vk7x8p7OZ+QywMaVdmYFW4mZywPyCxbk61u3m25ECI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRl/xvgEJ2ZW8tXLrCsPnLxy9veoEGI/1R/MynifA8wC3VP8ODZx57ZVlkmivlbc0SIEqUzWHSO3qH17WcOyuFpeTZUUEN95ApBiLOmTo1BoGu/NcVCgQbRq9Cvo+hmsfixPYuLKQWl4IsJpodyjWEhaoIkWhTl7P5hOGUcUQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cRtniLhk; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739956143; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ftZU+5bMAOO43RWbn35YZbsoovI4IiODb5WpQejCd88=;
	b=cRtniLhkv3wjY2JOwtfP02DcJvl+1vJFgEDet0Wh1fCOq0GJZP1FgNuczHLGUF54NNRJ9x9oHzRjr7sP4By5oVuY6fqbKEV1vs4g3KiYe951kQ04Vj8bATqR2M1ufAFjuQScbpfB+kmSELcXiVBmKOryMjkSMI4hTrUlV7ga0lo=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPonrx6_1739956141 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 17:09:02 +0800
Message-ID: <eb44baac-f212-4b25-bbbf-6f0c498f2c5c@linux.alibaba.com>
Date: Wed, 19 Feb 2025 17:08:54 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs
To: Fenghua Yu <fenghuay@nvidia.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-2-xueshuai@linux.alibaba.com>
 <f44a4303-d106-408c-ba59-911fe7b9a290@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <f44a4303-d106-408c-ba59-911fe7b9a290@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/19 00:32, Fenghua Yu 写道:
> Hi, Shuai,
> 
> On 2/14/25 21:44, Shuai Xue wrote:
>> Memory allocated for wqs is not freed if an error occurs during
>> idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
>> order of allocation before exiting the function in case of an error.
>>
>> Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bitmap_parse() input")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/init.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index b946f78f85e1..b85736fd25bd 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -169,8 +169,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>       idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
>>       if (!idxd->wq_enable_map) {
>> -        kfree(idxd->wqs);
>> -        return -ENOMEM;
>> +        rc = -ENOMEM;
>> +        goto err_bitmap;
>>       }
>>       for (i = 0; i < idxd->max_wqs; i++) {
>> @@ -191,6 +191,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>           rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
>>           if (rc < 0) {
>>               put_device(conf_dev);
>> +            kfree(wq);
>>               goto err;
>>           }
>> @@ -204,6 +205,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>           wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>>           if (!wq->wqcfg) {
>>               put_device(conf_dev);
>> +            kfree(wq);
>>               rc = -ENOMEM;
>>               goto err;
>>           }
>> @@ -211,7 +213,9 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>           if (idxd->hw.wq_cap.op_config) {
>>               wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
>>               if (!wq->opcap_bmap) {
>> +                kfree(wq->wqcfg);
>>                   put_device(conf_dev);
>> +                kfree(wq);
>>                   rc = -ENOMEM;
>>                   goto err;
>>               }
>> @@ -225,11 +229,21 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>       return 0;
>>    err:
>> -    while (--i >= 0) {
>> +    while (i-- > 0) {
> 
> Why changed to "i-- > 0" here? Before coming to here, the mem areas allocated for wqs[i] are freed already and there is not need to free them again here, right? 

Yes.

> And if i>1, mem areas for wqs[0] won't be freed and will leak, right?

No, the two ways of writing are equivalent.

#include <stdio.h>

int main()
{
     int i = 1;
     while (i-- > 0)
         printf("freeing i %d\n", i);

     return 0;
}

// console output
// freeing i 0

I will drop this line to avoid confusion.

Thanks.
Shuai


