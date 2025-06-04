Return-Path: <dmaengine+bounces-5301-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FB2ACDA58
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jun 2025 10:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D291743D1
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jun 2025 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041E31DED6D;
	Wed,  4 Jun 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GOnowtxm"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F0779F2;
	Wed,  4 Jun 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027338; cv=none; b=nvWF8tzT6V8s6huirZzJMFRmBH/mIX1lrTjK1EYlO5v19AvrxG0UmNmZTN9tkijeO9ECTKjDlV6X0AdXlOhePSYPTnaLg/Q5i+G+bdqyo/rGyxuscBV1DU2c7SsEBFIF+JsuqVk9orXza3zKCxA7yFAFCptPbZCZ2Tuj+QBUq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027338; c=relaxed/simple;
	bh=M2eroH/EanGDU+uButZJmOE/AZ7YGxC5tOaqpyqs3hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSpWSRq/rADAVNlKDnXDS5dy0afrwOAuBfwquKsZxbFROmLRKVQ05L6GLL4obYsmSky16x/HSq5bNg3X/wbsWVipkzk4Ps7t43cgNfJfKKWwZFBSOI4N0omjLR2G4Gndirv3fgMxQlKfhMaJIuG1g1Lp1JSUEH3HK6y6JeCgbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GOnowtxm; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749027327; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=I6plCDd0PtEKYAK7XU1ocWnzvfgBCeiJIYFym8cuaoE=;
	b=GOnowtxmJpgfqWI/U3Eqd2RWeapsvfQ5Vtesy8rol01ajew5bStCl1zLtqVXrSTvZPbAYxEPn4B2DGTftOLdYBCJxQX2JBHOeN+uEWrn6RiZhyPnF74Ahn9xe3NAn2JYsH2PDsE/aBBfDSTsVL2DP/qtVW+tQOesAlKnb9/EGAg=
Received: from 30.246.160.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wd3pyvU_1749027325 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Jun 2025 16:55:26 +0800
Message-ID: <22b3a299-b148-46ec-804e-2f6cbb3d5de1@linux.alibaba.com>
Date: Wed, 4 Jun 2025 16:55:25 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Fix race condition between WQ
 enable and reset paths
To: Dave Jiang <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, fenghuay@nvidia.com,
 vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, colin.i.king@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
 <20250522063329.51156-2-xueshuai@linux.alibaba.com>
 <a03e4f97-2289-4af7-8bfc-ad2d38ec8677@intel.com>
 <b2153756-a57e-4054-bde2-deb8865c9e59@linux.alibaba.com>
 <4cd53b91-bd20-46a1-854c-9bf0950ea496@intel.com>
 <87234fab-081e-4e2e-9ef1-0414b23601ce@linux.alibaba.com>
 <874ix5bhkz.fsf@intel.com> <226ecbd8-af44-49e8-9d4c-1f2294832897@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <226ecbd8-af44-49e8-9d4c-1f2294832897@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/3 22:32, Dave Jiang 写道:
> 
> 
> On 5/27/25 7:21 PM, Vinicius Costa Gomes wrote:
>> Shuai Xue <xueshuai@linux.alibaba.com> writes:
>>
>>> 在 2025/5/23 22:54, Dave Jiang 写道:
>>>>
>>>>
>>>> On 5/22/25 10:20 PM, Shuai Xue wrote:
>>>>>
>>>>>
>>>>> 在 2025/5/22 22:55, Dave Jiang 写道:
>>>>>>
>>>>>>
>>>>>> On 5/21/25 11:33 PM, Shuai Xue wrote:
>>>>>>> A device reset command disables all WQs in hardware. If issued while a WQ
>>>>>>> is being enabled, it can cause a mismatch between the software and hardware
>>>>>>> states.
>>>>>>>
>>>>>>> When a hardware error occurs, the IDXD driver calls idxd_device_reset() to
>>>>>>> send a reset command and clear the state (wq->state) of all WQs. It then
>>>>>>> uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them and
>>>>>>> ensure consistency between the software and hardware states.
>>>>>>>
>>>>>>> However, a race condition exists between the WQ enable path and the
>>>>>>> reset/recovery path. For example:
>>>>>>>
>>>>>>> A: WQ enable path                   B: Reset and recovery path
>>>>>>> ------------------                 ------------------------
>>>>>>> a1. issue IDXD_CMD_ENABLE_WQ
>>>>>>>                                       b1. issue IDXD_CMD_RESET_DEVICE
>>>>>>>                                       b2. clear wq->state
>>>>>>>                                       b3. check wq_enable_map bit, not set
>>>>>>> a2. set wq->state = IDXD_WQ_ENABLED
>>>>>>> a3. set wq_enable_map
>>>>>>>
>>>>>>> In this case, b1 issues a reset command that disables all WQs in hardware.
>>>>>>> Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
>>>>>>> leading to an inconsistency between wq->state (software) and the actual
>>>>>>> hardware state (IDXD_WQ_DISABLED).
>>>>>>
>>>>>>
>>>>>> Would it lessen the complication to just have wq enable path grab the device lock before proceeding?
>>>>>>
>>>>>> DJ
>>>>>
>>>>> Yep, how about add a spin lock to enable wq and reset device path.
>>>>>
>>>>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>>>>> index 38633ec5b60e..c0dc904b2a94 100644
>>>>> --- a/drivers/dma/idxd/device.c
>>>>> +++ b/drivers/dma/idxd/device.c
>>>>> @@ -203,6 +203,29 @@ int idxd_wq_enable(struct idxd_wq *wq)
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(idxd_wq_enable);
>>>>>    
>>>>> +/*
>>>>> + * This function enables a WQ in hareware and updates the driver maintained
>>>>> + * wq->state to IDXD_WQ_ENABLED. It should be called with the dev_lock held
>>>>> + * to prevent race conditions with IDXD_CMD_RESET_DEVICE, which could
>>>>> + * otherwise disable the WQ without the driver's state being properly
>>>>> + * updated.
>>>>> + *
>>>>> + * For IDXD_CMD_DISABLE_DEVICE, this function is safe because it is only
>>>>> + * called after the WQ has been explicitly disabled, so no concurrency
>>>>> + * issues arise.
>>>>> + */
>>>>> +int idxd_wq_enable_locked(struct idxd_wq *wq)
>>>>> +{
>>>>> +       struct idxd_device *idxd = wq->idxd;
>>>>> +       int ret;
>>>>> +
>>>>> +       spin_lock(&idxd->dev_lock);
>>>>
>>>> Let's start using the new cleanup macro going forward:
>>>> guard(spinlock)(&idxd->dev_lock);
>>>>
>>>> On a side note, there's been a cleanup on my mind WRT this driver's locking. I think we can replace idxd->dev_lock with idxd_confdev(idxd) device lock. You can end up just do:
>>>> guard(device)(idxd_confdev(idxd));
>>>
>>> Then we need to replace the lock from spinlock to mutex lock?
>>
>> We still need a (spin) lock that we could hold in interrupt contexts.
>>
>>>
>>>>
>>>> And also drop the wq->wq_lock and replace with wq_confdev(wq) device lock:
>>>> guard(device)(wq_confdev(wq));
>>>>
>>>> If you are up for it that is.
>>>
>>> We creates a hierarchy: pdev -> idxd device -> wq device.
>>> idxd_confdev(idxd) is the parent of wq_confdev(wq) because:
>>>
>>>       (wq_confdev(wq))->parent = idxd_confdev(idxd);
>>>
>>> Is it safe to grap lock of idxd_confdev(idxd) under hold
>>> lock of wq_confdev(wq)?
>>>
>>> We have mounts of code use spinlock of idxd->dev_lock under
>>> hold of wq->wq_lock.
>>>
>>
>> I agree with Dave that the locking could be simplified, but I don't
>> think that we should hold this series because of that. That
>> simplification can be done later.
> 
> I agree. Just passing musing on the current code.

Got it, do I need to send a separate patch for Patch 2?

Thanks.
Shuai

