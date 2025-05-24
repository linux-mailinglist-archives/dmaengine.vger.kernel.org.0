Return-Path: <dmaengine+bounces-5257-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C4AAC2D97
	for <lists+dmaengine@lfdr.de>; Sat, 24 May 2025 07:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D33A4A34BE
	for <lists+dmaengine@lfdr.de>; Sat, 24 May 2025 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E261D1ACEB0;
	Sat, 24 May 2025 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZV2LjEXe"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EA1156F5D;
	Sat, 24 May 2025 05:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748065218; cv=none; b=VyMTHrL9XzbuaNs4yQOOryd1Kp6a3Gx+nw1DFoxQCt8iTzyuxJOHvASGARK/R4muAprkR2xBeVTId2ydF1S+Am0VSDjPVihA2p/3ZIvF8ebzyYwjyhSSiLmTag47hUUci7IssaWsQVDgaaDS88u5+fcJ5fhCN+eH3TY6d4PkrpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748065218; c=relaxed/simple;
	bh=14/2ip35FeywfWYzsVvpZkM3FiQyxMuIi4NDdHLXrTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drch746+v995nJblmdLit1/o1WY2LLd3v3Cmpnt9FPxuY5RpcZtGvMj+niTQZUkY3gpxVFwMJ9bBrr1zxYbxf7MS3vlW/o0rIRHDr9OeeVkeK6r05DBOyLjOEsakfonO/VUN0aYzPABCpD2p2xUgMV/YtcgcvRdbP8p7DdegOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZV2LjEXe; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748065210; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Vb/+YVmUsnGKgeF1YClxfgtT9PLmvgySvb+sSDF/9tU=;
	b=ZV2LjEXepZbaEjRV05Tv4wkieJocWk5Pk1wrNjX5WoSwhmMMCL2toNQs4gowxWRrV95aHp/XHbhKhl1n9ewO+vVqkrjX0trsTjGnmVLpOzVrY7Da/zZ/gIFI11Qmle13bGPKYlWfAXSNcwYeC78KSoQxcf0n3kBRR/Q71GDywxw=
Received: from 30.246.160.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wbd3RrH_1748065209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 May 2025 13:40:10 +0800
Message-ID: <87234fab-081e-4e2e-9ef1-0414b23601ce@linux.alibaba.com>
Date: Sat, 24 May 2025 13:40:08 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Fix race condition between WQ
 enable and reset paths
To: Dave Jiang <dave.jiang@intel.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, colin.i.king@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
 <20250522063329.51156-2-xueshuai@linux.alibaba.com>
 <a03e4f97-2289-4af7-8bfc-ad2d38ec8677@intel.com>
 <b2153756-a57e-4054-bde2-deb8865c9e59@linux.alibaba.com>
 <4cd53b91-bd20-46a1-854c-9bf0950ea496@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <4cd53b91-bd20-46a1-854c-9bf0950ea496@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/23 22:54, Dave Jiang 写道:
> 
> 
> On 5/22/25 10:20 PM, Shuai Xue wrote:
>>
>>
>> 在 2025/5/22 22:55, Dave Jiang 写道:
>>>
>>>
>>> On 5/21/25 11:33 PM, Shuai Xue wrote:
>>>> A device reset command disables all WQs in hardware. If issued while a WQ
>>>> is being enabled, it can cause a mismatch between the software and hardware
>>>> states.
>>>>
>>>> When a hardware error occurs, the IDXD driver calls idxd_device_reset() to
>>>> send a reset command and clear the state (wq->state) of all WQs. It then
>>>> uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them and
>>>> ensure consistency between the software and hardware states.
>>>>
>>>> However, a race condition exists between the WQ enable path and the
>>>> reset/recovery path. For example:
>>>>
>>>> A: WQ enable path                   B: Reset and recovery path
>>>> ------------------                 ------------------------
>>>> a1. issue IDXD_CMD_ENABLE_WQ
>>>>                                      b1. issue IDXD_CMD_RESET_DEVICE
>>>>                                      b2. clear wq->state
>>>>                                      b3. check wq_enable_map bit, not set
>>>> a2. set wq->state = IDXD_WQ_ENABLED
>>>> a3. set wq_enable_map
>>>>
>>>> In this case, b1 issues a reset command that disables all WQs in hardware.
>>>> Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
>>>> leading to an inconsistency between wq->state (software) and the actual
>>>> hardware state (IDXD_WQ_DISABLED).
>>>
>>>
>>> Would it lessen the complication to just have wq enable path grab the device lock before proceeding?
>>>
>>> DJ
>>
>> Yep, how about add a spin lock to enable wq and reset device path.
>>
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 38633ec5b60e..c0dc904b2a94 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -203,6 +203,29 @@ int idxd_wq_enable(struct idxd_wq *wq)
>>   }
>>   EXPORT_SYMBOL_GPL(idxd_wq_enable);
>>   
>> +/*
>> + * This function enables a WQ in hareware and updates the driver maintained
>> + * wq->state to IDXD_WQ_ENABLED. It should be called with the dev_lock held
>> + * to prevent race conditions with IDXD_CMD_RESET_DEVICE, which could
>> + * otherwise disable the WQ without the driver's state being properly
>> + * updated.
>> + *
>> + * For IDXD_CMD_DISABLE_DEVICE, this function is safe because it is only
>> + * called after the WQ has been explicitly disabled, so no concurrency
>> + * issues arise.
>> + */
>> +int idxd_wq_enable_locked(struct idxd_wq *wq)
>> +{
>> +       struct idxd_device *idxd = wq->idxd;
>> +       int ret;
>> +
>> +       spin_lock(&idxd->dev_lock);
> 
> Let's start using the new cleanup macro going forward:
> guard(spinlock)(&idxd->dev_lock);
> 
> On a side note, there's been a cleanup on my mind WRT this driver's locking. I think we can replace idxd->dev_lock with idxd_confdev(idxd) device lock. You can end up just do:
> guard(device)(idxd_confdev(idxd));

Then we need to replace the lock from spinlock to mutex lock?

> 
> And also drop the wq->wq_lock and replace with wq_confdev(wq) device lock:
> guard(device)(wq_confdev(wq));
> 
> If you are up for it that is.

We creates a hierarchy: pdev -> idxd device -> wq device.
idxd_confdev(idxd) is the parent of wq_confdev(wq) because:

     (wq_confdev(wq))->parent = idxd_confdev(idxd);

Is it safe to grap lock of idxd_confdev(idxd) under hold
lock of wq_confdev(wq)?

We have mounts of code use spinlock of idxd->dev_lock under
hold of wq->wq_lock.

> 
> 
>> +       ret = idxd_wq_enable_locked(wq);
>> +       spin_unlock(&idxd->dev_lock);
>> +
>> +       return ret;
>> +}
>> +
>>   int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
>>   {
>>          struct idxd_device *idxd = wq->idxd;
>> @@ -330,7 +353,7 @@ int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
>>   
>>          __idxd_wq_set_pasid_locked(wq, pasid);
>>   
>> -       rc = idxd_wq_enable(wq);
>> +       rc = idxd_wq_enable_locked(wq);
>>          if (rc < 0)
>>                  return rc;
>>   
>> @@ -380,7 +403,7 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
>>          iowrite32(wqcfg.bits[WQCFG_PASID_IDX], idxd->reg_base + offset);
>>          spin_unlock(&idxd->dev_lock);
>>   
>> -       rc = idxd_wq_enable(wq);
>> +       rc = idxd_wq_enable_locked(wq);
>>          if (rc < 0)
>>                  return rc;
>>   
>> @@ -644,7 +667,11 @@ int idxd_device_disable(struct idxd_device *idxd)
>>   
>>   void idxd_device_reset(struct idxd_device *idxd)
>>   {
>> +
>> +       spin_lock(&idxd->dev_lock);
>>          idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
>> +       spin_unlock(&idxd->dev_lock);
>> +
>>
> 
> I think you just need the wq_enable locked and also in idxd_device_clear_state(), extend the lock to the whole function. Locking the reset function around just the command execute won't protect the wq enable path against the changing of the software states on the reset side.

Quite agreed.

> 
> DJ
> 
>> (The dev_lock should also apply to idxd_wq_enable(), I did not paste here)
>>
>> Also, I found a new bug that idxd_device_config() is called without
>> hold idxd->dev_lock.
>>> idxd_device_config() explictly asserts the hold of idxd->dev_lock.
>>
>> +++ b/drivers/dma/idxd/irq.c
>> @@ -33,12 +33,17 @@ static void idxd_device_reinit(struct work_struct *work)
>>   {
>>          struct idxd_device *idxd = container_of(work, struct idxd_device, work);
>>          struct device *dev = &idxd->pdev->dev;
>> -       int rc, i;
>> +       int rc = 0, i;
>>   
>>          idxd_device_reset(idxd);
>> -       rc = idxd_device_config(idxd);
>> -       if (rc < 0)
>> +       spin_lock(&idxd->dev_lock);
> I wonder if you should also just lock the idxd_device_reset() and the idxd_device_enable() as well in this case as you don't anything to interfere with the entire reinit path.

During reset, any operation to enable wq should indeed be avoided,
but there isn't a suitable lock currently. idxd->dev_lock is a
lightweight lock, only used when updating the device state, and
it's used while holding wq->wq_lock. Therefore, holding idxd->dev_lock
currently cannot form mutual exclusion with wq->wq_lock.

And the sub caller of idxd_device_reset(), e.g. idxd_device_clear_state()
also spins to hold idxd->dev_lock.

A hack way it to grab wq_lock of all wqs before before reinit, but
this is hardly elegant (:

Thanks.
Have a nice holiday!

Best regards,
Shuai


