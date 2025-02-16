Return-Path: <dmaengine+bounces-4499-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEFDA3730F
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C513A80AE
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0E317BED0;
	Sun, 16 Feb 2025 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kBGtwZjM"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFB23BB;
	Sun, 16 Feb 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739697912; cv=none; b=SNzPxyKl4ZwAgVEK3+NBnV7sVm6h+PeZcNzpEjoya1EqzCAzZvl9weUy+SE3Rcu8UBg2pQ3j/WYXesG5FHko+WUYZtlC34v/UqtbScrMJggHwPM0lhIcuoetB60/m/NuIpu13ij3tOoLxM7YDF0uaRxpNI0Pq02miwiDKuWjpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739697912; c=relaxed/simple;
	bh=CKHMz7EJa7GotRQwz4YOFeVoitR8jrEg260qTPDo84Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLINpsacG+YwdA0+VfNN9u2TjlIwynmDyGwwLZUawVwrv/xEhUvFY3h9+CAVd3RgmYTHHXkzbelldWtF+w4134u+hDkSEaRz7LRvW5JvvL4AZEAg2D1u2rlsPJBCuJ5bBC9Gl0rFeWd/YFcfxqSIGPPJz1BQYZ1J/a5RigxEpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kBGtwZjM; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739697899; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qeHPYXoLTBSg8F8l1iBZr2XOfg0E8EOnMsxri1fETvQ=;
	b=kBGtwZjMYmrpn/6mFLgojCnabywBse0Sb+dqPViUdZ5g5rpDI9JpC9bHfcZxqzrhE2QzeO8SUsrFn9KzVZwSyhzrct4cuJA5oC2pGavx6ZoS5GjG8+irOhotYj+1aPL1MFDmafQlNKUoG06viUsHjYt3eadXYYY7IgP/MRZRGxY=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPWHKN9_1739697898 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Feb 2025 17:24:58 +0800
Message-ID: <4128c7ad-a191-4c37-a6ba-47b06324a8b5@linux.alibaba.com>
Date: Sun, 16 Feb 2025 17:24:56 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs()
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Nikhil Rao <nikhil.rao@intel.com>
References: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
 <98327a4d-7684-4908-9d67-5dfcaa229ae1@web.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <98327a4d-7684-4908-9d67-5dfcaa229ae1@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/15 19:00, Markus Elfring 写道:
>> Memory allocated for wqs is not freed if an error occurs during
>> idxd_setup_wqs(). To fix it, free the allocated memory in the reverse
>> order of allocation before exiting the function in case of an error.
>>
>> Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bitmap_parse() input")
> …
> 
> Will a “stable tag” become relevant also for this patch series?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v6.14-rc2#n3
> 

I don't know if this is a real serious issue for stable kernel.
But I would like to add stable tag if the mantainer @Vinicius and @Dave ask.

> 
>> +++ b/drivers/dma/idxd/init.c
>> @@ -169,8 +169,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
> …
>> @@ -204,6 +205,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>   		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>>   		if (!wq->wqcfg) {
>>   			put_device(conf_dev);
>> +			kfree(wq);
>>   			rc = -ENOMEM;
>>   			goto err;
>>   		}
> …
> 
> I got the impression that more common exception handling code could be moved
> to additional jump targets at the end of such function implementations.
> Will further adjustment opportunities be taken into account for
> the affected resource management?

Sure, I will move them to the jump targets.

> 
> Regards,
> Markus

Thanks for valuable comments.
Shuai

