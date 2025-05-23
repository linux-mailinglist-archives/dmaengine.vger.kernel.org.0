Return-Path: <dmaengine+bounces-5254-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C00EAC25B0
	for <lists+dmaengine@lfdr.de>; Fri, 23 May 2025 16:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA3BA4614F
	for <lists+dmaengine@lfdr.de>; Fri, 23 May 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9766295DBF;
	Fri, 23 May 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmB9wuhJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20E295D85;
	Fri, 23 May 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012048; cv=none; b=j3/huaLXAA0K1U1yJO70e3o/Vx5H9dQYiI95aw7bl4/3Ea1V4smAPchvoIBJ5Nt14D+J06FfXJ72vmsvrYPdEV9wQU3A+HtU4+fdO0UcqM7d36xKTfvzGBqFjGKm8CC5LFOYbDjFOGInI1lGJUDv+hhCJixITrqIIqJ0TtVMZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012048; c=relaxed/simple;
	bh=YzVl8PZzTDuCZm13dI24/plI8CcTo2Vu0J/1b3vu3Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZPYKegXpcxUJCmxIRn1vN4nqCqG21HvYbhp+4becTrL4dRt2Yfkao9JzdM8oEJsxwJdoiFCCO4zjrUbARXaRd1xb12xiMag9fwTPwedpkJFu30iy9m6lTKj/iTInkpeys55YcIfLcJnLUZjxOu9F7U2J/gbaokJL0myV8vDgMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmB9wuhJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748012046; x=1779548046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YzVl8PZzTDuCZm13dI24/plI8CcTo2Vu0J/1b3vu3Mo=;
  b=cmB9wuhJc+XynH3R2alF3o/js3NP9lzKTowsaWR3VkvPMArYaHY9x4kj
   RvWHzur4fSF48l4ZDVz9yL8NHgi5ZKDXWyZooHkqwSKWErdYzheMy7Rvv
   vqX4YJpyIUP99av57VfaKIajUig9TB4b7uH/s5m2w5M3fVHYaAvYrFA1x
   rBC5DTLEQSgbnsX7w+FIgf5TQIGSOy3q5+wl7TOP6zunCaud+dGJH8pJg
   bfLWC5nX7RKxmPYnD5iIt1cMo3CVLHTWC2nlmDNkZOScu7M2PKbHyjmFd
   h2Kz6yQEto2ZIYnhS5Azd2YS+VXi3YiaD5clnPPPQUEA71NqrBIdVI/Ci
   g==;
X-CSE-ConnectionGUID: 7TftL93dQgKhDO0+hAK8mw==
X-CSE-MsgGUID: vSUuoMQCRRqDTdgZ6e4cag==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49963289"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="49963289"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 07:54:05 -0700
X-CSE-ConnectionGUID: wyoBHfSmTYKV3jHBryS0ow==
X-CSE-MsgGUID: +PYphXlKRyyiRBdjGmPjMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141058583"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.152]) ([10.125.109.152])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 07:54:05 -0700
Message-ID: <4cd53b91-bd20-46a1-854c-9bf0950ea496@intel.com>
Date: Fri, 23 May 2025 07:54:04 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Fix race condition between WQ
 enable and reset paths
To: Shuai Xue <xueshuai@linux.alibaba.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, colin.i.king@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
 <20250522063329.51156-2-xueshuai@linux.alibaba.com>
 <a03e4f97-2289-4af7-8bfc-ad2d38ec8677@intel.com>
 <b2153756-a57e-4054-bde2-deb8865c9e59@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <b2153756-a57e-4054-bde2-deb8865c9e59@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/22/25 10:20 PM, Shuai Xue wrote:
> 
> 
> 在 2025/5/22 22:55, Dave Jiang 写道:
>>
>>
>> On 5/21/25 11:33 PM, Shuai Xue wrote:
>>> A device reset command disables all WQs in hardware. If issued while a WQ
>>> is being enabled, it can cause a mismatch between the software and hardware
>>> states.
>>>
>>> When a hardware error occurs, the IDXD driver calls idxd_device_reset() to
>>> send a reset command and clear the state (wq->state) of all WQs. It then
>>> uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them and
>>> ensure consistency between the software and hardware states.
>>>
>>> However, a race condition exists between the WQ enable path and the
>>> reset/recovery path. For example:
>>>
>>> A: WQ enable path                   B: Reset and recovery path
>>> ------------------                 ------------------------
>>> a1. issue IDXD_CMD_ENABLE_WQ
>>>                                     b1. issue IDXD_CMD_RESET_DEVICE
>>>                                     b2. clear wq->state
>>>                                     b3. check wq_enable_map bit, not set
>>> a2. set wq->state = IDXD_WQ_ENABLED
>>> a3. set wq_enable_map
>>>
>>> In this case, b1 issues a reset command that disables all WQs in hardware.
>>> Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
>>> leading to an inconsistency between wq->state (software) and the actual
>>> hardware state (IDXD_WQ_DISABLED).
>>
>>
>> Would it lessen the complication to just have wq enable path grab the device lock before proceeding?
>>
>> DJ
> 
> Yep, how about add a spin lock to enable wq and reset device path.
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 38633ec5b60e..c0dc904b2a94 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -203,6 +203,29 @@ int idxd_wq_enable(struct idxd_wq *wq)
>  }
>  EXPORT_SYMBOL_GPL(idxd_wq_enable);
>  
> +/*
> + * This function enables a WQ in hareware and updates the driver maintained
> + * wq->state to IDXD_WQ_ENABLED. It should be called with the dev_lock held
> + * to prevent race conditions with IDXD_CMD_RESET_DEVICE, which could
> + * otherwise disable the WQ without the driver's state being properly
> + * updated.
> + *
> + * For IDXD_CMD_DISABLE_DEVICE, this function is safe because it is only
> + * called after the WQ has been explicitly disabled, so no concurrency
> + * issues arise.
> + */
> +int idxd_wq_enable_locked(struct idxd_wq *wq)
> +{
> +       struct idxd_device *idxd = wq->idxd;
> +       int ret;
> +
> +       spin_lock(&idxd->dev_lock);

Let's start using the new cleanup macro going forward:
guard(spinlock)(&idxd->dev_lock);

On a side note, there's been a cleanup on my mind WRT this driver's locking. I think we can replace idxd->dev_lock with idxd_confdev(idxd) device lock. You can end up just do:
guard(device)(idxd_confdev(idxd));

And also drop the wq->wq_lock and replace with wq_confdev(wq) device lock:
guard(device)(wq_confdev(wq));

If you are up for it that is. 


> +       ret = idxd_wq_enable_locked(wq);
> +       spin_unlock(&idxd->dev_lock);
> +
> +       return ret;
> +}
> +
>  int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
>  {
>         struct idxd_device *idxd = wq->idxd;
> @@ -330,7 +353,7 @@ int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
>  
>         __idxd_wq_set_pasid_locked(wq, pasid);
>  
> -       rc = idxd_wq_enable(wq);
> +       rc = idxd_wq_enable_locked(wq);
>         if (rc < 0)
>                 return rc;
>  
> @@ -380,7 +403,7 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
>         iowrite32(wqcfg.bits[WQCFG_PASID_IDX], idxd->reg_base + offset);
>         spin_unlock(&idxd->dev_lock);
>  
> -       rc = idxd_wq_enable(wq);
> +       rc = idxd_wq_enable_locked(wq);
>         if (rc < 0)
>                 return rc;
>  
> @@ -644,7 +667,11 @@ int idxd_device_disable(struct idxd_device *idxd)
>  
>  void idxd_device_reset(struct idxd_device *idxd)
>  {
> +
> +       spin_lock(&idxd->dev_lock);
>         idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
> +       spin_unlock(&idxd->dev_lock);
> +
> 

I think you just need the wq_enable locked and also in idxd_device_clear_state(), extend the lock to the whole function. Locking the reset function around just the command execute won't protect the wq enable path against the changing of the software states on the reset side. 

DJ

> (The dev_lock should also apply to idxd_wq_enable(), I did not paste here)
> 
> Also, I found a new bug that idxd_device_config() is called without
> hold idxd->dev_lock.
> > idxd_device_config() explictly asserts the hold of idxd->dev_lock.
> 
> +++ b/drivers/dma/idxd/irq.c
> @@ -33,12 +33,17 @@ static void idxd_device_reinit(struct work_struct *work)
>  {
>         struct idxd_device *idxd = container_of(work, struct idxd_device, work);
>         struct device *dev = &idxd->pdev->dev;
> -       int rc, i;
> +       int rc = 0, i;
>  
>         idxd_device_reset(idxd);
> -       rc = idxd_device_config(idxd);
> -       if (rc < 0)
> +       spin_lock(&idxd->dev_lock);
I wonder if you should also just lock the idxd_device_reset() and the idxd_device_enable() as well in this case as you don't anything to interfere with the entire reinit path. 

> +       if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
> +               rc = idxd_device_config(idxd);
> +       spin_unlock(&idxd->dev_lock);
> +       if (rc < 0) {
> +               dev_err(dev, "Reinit: %s config fails\n", dev_name(idxd_confdev(idxd)));
>                 goto out;
> +       }
>  
>         rc = idxd_device_enable(idxd);
>         if (rc < 0)
> 
> Please correct me if I missed anything.
> 
> Thanks.
> Shuai
> 


