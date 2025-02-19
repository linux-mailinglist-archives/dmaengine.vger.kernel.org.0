Return-Path: <dmaengine+bounces-4531-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57CBA3BC67
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 12:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700EB7A15F6
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 11:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689371DDC11;
	Wed, 19 Feb 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y57cSCdA"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16081D0F5A;
	Wed, 19 Feb 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963215; cv=none; b=coyxCRYEcGCtoyqzvauWdBtRI4pcNXJ8AKn/LyCH6GEMFVi2zZ/e02Xgq7LB2IyigSLySBl1W232NSAMksXOsoFhtgcIi/d69BKbP2y2xwr6veLqV78FvCOtY3fJo4OFG5PmEYvnt8VKVhENePqfbjUvCbmkvwqOK9vz/7pjD/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963215; c=relaxed/simple;
	bh=ZjlQ5Y52N4jkWfrklIZGjG0Za/o7lSsCXqAaLOnqJ0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=go11A1OMXPXR69ZsLTxTqTj/aGsssB6pU2PtTdU4t0GVY2ES1STeBi7RVl9LU/a9mdXjY7Q+/wR/w/KFLM94qtZme/G3jWMaTFD0D7tvXqJrb6gJ4+xmcZa0l3fyFvfx56WMtWrKaP7vyX+zaHzYsumVxA9sqQesfaWcnOdMvco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y57cSCdA; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739963207; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qaxsf0+7cd0xDTE8Ao8aNHOMzKhSEIOlJKgHocnKTqM=;
	b=Y57cSCdAAEZxF0ODL3udnFbaGJ9TJtt8HH/iBCol1QjpOJAn4NDA3xSEmxKc83v0BtPnIkQO7/+B/mO/8m0pK03TtkikA1USYWJwrLRyTtx6voJx59P0yAmLlLy405i3+snUBOvTCh2YJydonT4iBUXfz+UXgrox488T5z+j7Zw=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPp68E4_1739963206 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 19:06:46 +0800
Message-ID: <17390c79-faea-497b-90a7-7572db7671e2@linux.alibaba.com>
Date: Wed, 19 Feb 2025 19:06:45 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_groups
To: Fenghua Yu <fenghuay@nvidia.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-4-xueshuai@linux.alibaba.com>
 <693fe8b5-ff99-4363-8c9d-9641ad24ba10@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <693fe8b5-ff99-4363-8c9d-9641ad24ba10@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/19 04:20, Fenghua Yu 写道:
> Hi, Shuai,
> 
> On 2/14/25 21:44, Shuai Xue wrote:
>> Memory allocated for groups is not freed if an error occurs during
>> idxd_setup_groups(). To fix it, free the allocated memory in the reverse
>> order of allocation before exiting the function in case of an error.
>>
>> Fixes: defe49f96012 ("dmaengine: idxd: fix group conf_dev lifetime")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/init.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 4e47075c5bef..a2da68e6144d 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -328,6 +328,7 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>>           rc = dev_set_name(conf_dev, "group%d.%d", idxd->id, group->id);
>>           if (rc < 0) {
>>               put_device(conf_dev);
>> +            kfree(group);
>>               goto err;
>>           }
>> @@ -352,7 +353,10 @@ static int idxd_setup_groups(struct idxd_device *idxd)
>>       while (--i >= 0) {
>>           group = idxd->groups[i];
>>           put_device(group_confdev(group));
>> +        kfree(group);
>>       }
>> +    kfree(idxd->groups);
>> +
> 
> What happens to the memory areas previously allocated for wqs and engines after idxd_setup_groups() fails? They need to be freed as well, but currently they are not.
> 
> Maybe a separate patch cleans up the previously allocated mem areas for wqs/engines/groups if there is any failure after the allocations?
> 

Agreed, will add a new patch to fix it.

Thanks
Shuai


