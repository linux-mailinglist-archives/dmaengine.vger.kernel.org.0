Return-Path: <dmaengine+bounces-5303-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08123ACEB00
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 09:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB76E172BDD
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250901E6DC5;
	Thu,  5 Jun 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c818Xxqk"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889D1FC0E2;
	Thu,  5 Jun 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109231; cv=none; b=iSaSbWD7QCbAhNb57fKCNBBZLSE1dmHYIOLjq2sKx/hAXVaSRgMWrNhz1nn4oGxC9X3u0xyTNJyTeo50HngUlWOqlpK4wwfsmgNOlYh2d/JU8uuNvj5FC1cMmoH4X4OJRdKV54RjKYUE9BwpcSOMHtommTnzidYTC6IC2WZ9XtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109231; c=relaxed/simple;
	bh=05Jc9u4Bexu8GoY7o9uhByRATP/Px7knFLc8/E2cspU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLfaVR0zsSC7+GOaIX0d0Yf180F2Rq9MNhRby0J3qgpoYmlUR3katsOd5QafjAw770Y1F+yQHaBvjId5IxMPovGlM7rWSs7P2a+HWg+zsFJxOsDmE7OmbUDLo7y8Laq9rXPk7yIUlZX0QoSSOcxwchbO4GzpRBdpHTzypNQlF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c818Xxqk; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749109218; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kWz5KHsxBrz6YOL3qgX9LCCiLt6LGCV7LicdRW9KMKk=;
	b=c818XxqkiQ61QjSsry2Zaw6gUjeGXfPaGbpRildinUIT5tJWAJhIdt3+cwkD4FkSxzCnbeIndzJLLd/oGHBCAxPDYYykbKg/23geyeVg2R0Tqj/VgMPxzOKyYrSf0IxOxJY9wFDZEp7iSftflOV9EDcPCGTciwn1lDVkwc2Xkyk=
Received: from 30.246.160.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wd7FGGt_1749109216 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Jun 2025 15:40:17 +0800
Message-ID: <97e52eb0-d531-4464-bbb7-1dffa5d8d74e@linux.alibaba.com>
Date: Thu, 5 Jun 2025 15:40:15 +0800
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
 <22b3a299-b148-46ec-804e-2f6cbb3d5de1@linux.alibaba.com>
 <343f6719-598a-453b-9903-21632bc6b623@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <343f6719-598a-453b-9903-21632bc6b623@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/4 22:19, Dave Jiang 写道:
> 
> 
> On 6/4/25 1:55 AM, Shuai Xue wrote:
>>
>>
>> 在 2025/6/3 22:32, Dave Jiang 写道:
>>>
>>>
>>> On 5/27/25 7:21 PM, Vinicius Costa Gomes wrote:
>>>> Shuai Xue <xueshuai@linux.alibaba.com> writes:
>>>>
>>>>> 在 2025/5/23 22:54, Dave Jiang 写道:
>>>>>>
>>>>>>
>>>>>> On 5/22/25 10:20 PM, Shuai Xue wrote:
>>>>>>>
>>>>>>>
>>>>>>> 在 2025/5/22 22:55, Dave Jiang 写道:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 5/21/25 11:33 PM, Shuai Xue wrote:
>>>>>>>>> A device reset command disables all WQs in hardware. If issued while a WQ
>>>>>>>>> is being enabled, it can cause a mismatch between the software and hardware
>>>>>>>>> states.
>>>>>>>>>
>>>>>>>>> When a hardware error occurs, the IDXD driver calls idxd_device_reset() to
>>>>>>>>> send a reset command and clear the state (wq->state) of all WQs. It then
>>>>>>>>> uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them and
>>>>>>>>> ensure consistency between the software and hardware states.
>>>>>>>>>
>>>>>>>>> However, a race condition exists between the WQ enable path and the
>>>>>>>>> reset/recovery path. For example:
>>>>>>>>>
>>>>>>>>> A: WQ enable path                   B: Reset and recovery path
>>>>>>>>> ------------------                 ------------------------
>>>>>>>>> a1. issue IDXD_CMD_ENABLE_WQ
>>>>>>>>>                                        b1. issue IDXD_CMD_RESET_DEVICE
>>>>>>>>>                                        b2. clear wq->state
>>>>>>>>>                                        b3. check wq_enable_map bit, not set
>>>>>>>>> a2. set wq->state = IDXD_WQ_ENABLED
>>>>>>>>> a3. set wq_enable_map
>>>>>>>>>
>>>>>>>>> In this case, b1 issues a reset command that disables all WQs in hardware.
>>>>>>>>> Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
>>>>>>>>> leading to an inconsistency between wq->state (software) and the actual
>>>>>>>>> hardware state (IDXD_WQ_DISABLED).
>>>>>>>>
>>>>>>>>
>>>>>>>> Would it lessen the complication to just have wq enable path grab the device lock before proceeding?
>>>>>>>>
>>>>>>>> DJ
>>>>>>>
>>>>>>> Yep, how about add a spin lock to enable wq and reset device path.
>>>>>>>
>>>>>>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>>>>>>> index 38633ec5b60e..c0dc904b2a94 100644
>>>>>>> --- a/drivers/dma/idxd/device.c
>>>>>>> +++ b/drivers/dma/idxd/device.c
>>>>>>> @@ -203,6 +203,29 @@ int idxd_wq_enable(struct idxd_wq *wq)
>>>>>>>     }
>>>>>>>     EXPORT_SYMBOL_GPL(idxd_wq_enable);
>>>>>>>     +/*
>>>>>>> + * This function enables a WQ in hareware and updates the driver maintained
>>>>>>> + * wq->state to IDXD_WQ_ENABLED. It should be called with the dev_lock held
>>>>>>> + * to prevent race conditions with IDXD_CMD_RESET_DEVICE, which could
>>>>>>> + * otherwise disable the WQ without the driver's state being properly
>>>>>>> + * updated.
>>>>>>> + *
>>>>>>> + * For IDXD_CMD_DISABLE_DEVICE, this function is safe because it is only
>>>>>>> + * called after the WQ has been explicitly disabled, so no concurrency
>>>>>>> + * issues arise.
>>>>>>> + */
>>>>>>> +int idxd_wq_enable_locked(struct idxd_wq *wq)
>>>>>>> +{
>>>>>>> +       struct idxd_device *idxd = wq->idxd;
>>>>>>> +       int ret;
>>>>>>> +
>>>>>>> +       spin_lock(&idxd->dev_lock);
>>>>>>
>>>>>> Let's start using the new cleanup macro going forward:
>>>>>> guard(spinlock)(&idxd->dev_lock);
>>>>>>
>>>>>> On a side note, there's been a cleanup on my mind WRT this driver's locking. I think we can replace idxd->dev_lock with idxd_confdev(idxd) device lock. You can end up just do:
>>>>>> guard(device)(idxd_confdev(idxd));
>>>>>
>>>>> Then we need to replace the lock from spinlock to mutex lock?
>>>>
>>>> We still need a (spin) lock that we could hold in interrupt contexts.
>>>>
>>>>>
>>>>>>
>>>>>> And also drop the wq->wq_lock and replace with wq_confdev(wq) device lock:
>>>>>> guard(device)(wq_confdev(wq));
>>>>>>
>>>>>> If you are up for it that is.
>>>>>
>>>>> We creates a hierarchy: pdev -> idxd device -> wq device.
>>>>> idxd_confdev(idxd) is the parent of wq_confdev(wq) because:
>>>>>
>>>>>        (wq_confdev(wq))->parent = idxd_confdev(idxd);
>>>>>
>>>>> Is it safe to grap lock of idxd_confdev(idxd) under hold
>>>>> lock of wq_confdev(wq)?
>>>>>
>>>>> We have mounts of code use spinlock of idxd->dev_lock under
>>>>> hold of wq->wq_lock.
>>>>>
>>>>
>>>> I agree with Dave that the locking could be simplified, but I don't
>>>> think that we should hold this series because of that. That
>>>> simplification can be done later.
>>>
>>> I agree. Just passing musing on the current code.
>>
>> Got it, do I need to send a separate patch for Patch 2?
> 
> Not sure what you mean. Do you mean if you need to send patch 2 again?

Yep, the locking issue is more complicate and can be done later.
(I could split patch 2 from this patch set if you prefer a new patch.)

>>
>> Thanks.
>> Shuai


