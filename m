Return-Path: <dmaengine+bounces-5302-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A7ACE01F
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jun 2025 16:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD55F16F07F
	for <lists+dmaengine@lfdr.de>; Wed,  4 Jun 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E3290DA0;
	Wed,  4 Jun 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaDhrEXP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73567290BDA;
	Wed,  4 Jun 2025 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046770; cv=none; b=XevIiDokJXoLxtHc8TkVAUOdzId03ubrW+/fBRPpyF2kC+zDaR/dFhqzUNhtHimMsK1NpUrBPFqZyiGY2nSeUjer1RibM4gQ79R6ot0zBhh5y8KWr7/nuVMOWs3VFR2UGIcFFIR2J4jP/z0Th3T2tnBu69xp3O65dIZTbb0K6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046770; c=relaxed/simple;
	bh=nvCdP0Vwqyv1w/nWeuE741pzwxdxLERa4Y/vBATrZhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9phpO1SpFhGATgoeaQH7VyumznrkgpuFv0u3ZEPdapL6jTQc+YO3BseZFXkBF4a/zk9sHkHDoIgLl8e4J8eXixkdOZKg1nNozsMgf9H3aOQC/k3nLTyBPGT0FShhG1qFItE7hYD8pZI19LP3znpiFq7xeOTakZT9TvNFF0BOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaDhrEXP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749046768; x=1780582768;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nvCdP0Vwqyv1w/nWeuE741pzwxdxLERa4Y/vBATrZhI=;
  b=MaDhrEXPpCq2+0VtQ52F34rES13HIvrNq8abAj0kytD0TkmozLNl7kIJ
   w7eHYDucxLb6eq4g3JMZmzfQEdvqauJsCn69ukGZAbeOO2RvrSLo2ZiJv
   KRkJ4Lq8uvJ0IrcL1J7Bq/bziLaPcP/wrtMLJQfqDWw7WjdM4iayLesK4
   ZMIE35nl4t84pvzAlUiXSRDhfhF8fOrznA6FrJoqv6gwJQ27cBZZi7CvJ
   oM9y205tnaItKgm5WUP5FIeoHVWG8hCkjNY4sv1qOiBawzUwJt6VdSyRl
   IuCc7Phy1dA/gaLG03B6BZ8Eb2kYKpz2YeT5TkBCtKKzZHbbPgP5jspQT
   Q==;
X-CSE-ConnectionGUID: u8wYudwCTuyByGe1L7imHQ==
X-CSE-MsgGUID: krjGmWmxQfSMpP41mxlQBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="62489553"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="62489553"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:19:27 -0700
X-CSE-ConnectionGUID: gpf1jbhDR02P7Vc1SsI37g==
X-CSE-MsgGUID: HaGLvCGpTPyRlTH47RR87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="150363145"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.110.233]) ([10.125.110.233])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 07:19:25 -0700
Message-ID: <343f6719-598a-453b-9903-21632bc6b623@intel.com>
Date: Wed, 4 Jun 2025 07:19:26 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Fix race condition between WQ
 enable and reset paths
To: Shuai Xue <xueshuai@linux.alibaba.com>,
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <22b3a299-b148-46ec-804e-2f6cbb3d5de1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/25 1:55 AM, Shuai Xue wrote:
> 
> 
> 在 2025/6/3 22:32, Dave Jiang 写道:
>>
>>
>> On 5/27/25 7:21 PM, Vinicius Costa Gomes wrote:
>>> Shuai Xue <xueshuai@linux.alibaba.com> writes:
>>>
>>>> 在 2025/5/23 22:54, Dave Jiang 写道:
>>>>>
>>>>>
>>>>> On 5/22/25 10:20 PM, Shuai Xue wrote:
>>>>>>
>>>>>>
>>>>>> 在 2025/5/22 22:55, Dave Jiang 写道:
>>>>>>>
>>>>>>>
>>>>>>> On 5/21/25 11:33 PM, Shuai Xue wrote:
>>>>>>>> A device reset command disables all WQs in hardware. If issued while a WQ
>>>>>>>> is being enabled, it can cause a mismatch between the software and hardware
>>>>>>>> states.
>>>>>>>>
>>>>>>>> When a hardware error occurs, the IDXD driver calls idxd_device_reset() to
>>>>>>>> send a reset command and clear the state (wq->state) of all WQs. It then
>>>>>>>> uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them and
>>>>>>>> ensure consistency between the software and hardware states.
>>>>>>>>
>>>>>>>> However, a race condition exists between the WQ enable path and the
>>>>>>>> reset/recovery path. For example:
>>>>>>>>
>>>>>>>> A: WQ enable path                   B: Reset and recovery path
>>>>>>>> ------------------                 ------------------------
>>>>>>>> a1. issue IDXD_CMD_ENABLE_WQ
>>>>>>>>                                       b1. issue IDXD_CMD_RESET_DEVICE
>>>>>>>>                                       b2. clear wq->state
>>>>>>>>                                       b3. check wq_enable_map bit, not set
>>>>>>>> a2. set wq->state = IDXD_WQ_ENABLED
>>>>>>>> a3. set wq_enable_map
>>>>>>>>
>>>>>>>> In this case, b1 issues a reset command that disables all WQs in hardware.
>>>>>>>> Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
>>>>>>>> leading to an inconsistency between wq->state (software) and the actual
>>>>>>>> hardware state (IDXD_WQ_DISABLED).
>>>>>>>
>>>>>>>
>>>>>>> Would it lessen the complication to just have wq enable path grab the device lock before proceeding?
>>>>>>>
>>>>>>> DJ
>>>>>>
>>>>>> Yep, how about add a spin lock to enable wq and reset device path.
>>>>>>
>>>>>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>>>>>> index 38633ec5b60e..c0dc904b2a94 100644
>>>>>> --- a/drivers/dma/idxd/device.c
>>>>>> +++ b/drivers/dma/idxd/device.c
>>>>>> @@ -203,6 +203,29 @@ int idxd_wq_enable(struct idxd_wq *wq)
>>>>>>    }
>>>>>>    EXPORT_SYMBOL_GPL(idxd_wq_enable);
>>>>>>    +/*
>>>>>> + * This function enables a WQ in hareware and updates the driver maintained
>>>>>> + * wq->state to IDXD_WQ_ENABLED. It should be called with the dev_lock held
>>>>>> + * to prevent race conditions with IDXD_CMD_RESET_DEVICE, which could
>>>>>> + * otherwise disable the WQ without the driver's state being properly
>>>>>> + * updated.
>>>>>> + *
>>>>>> + * For IDXD_CMD_DISABLE_DEVICE, this function is safe because it is only
>>>>>> + * called after the WQ has been explicitly disabled, so no concurrency
>>>>>> + * issues arise.
>>>>>> + */
>>>>>> +int idxd_wq_enable_locked(struct idxd_wq *wq)
>>>>>> +{
>>>>>> +       struct idxd_device *idxd = wq->idxd;
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       spin_lock(&idxd->dev_lock);
>>>>>
>>>>> Let's start using the new cleanup macro going forward:
>>>>> guard(spinlock)(&idxd->dev_lock);
>>>>>
>>>>> On a side note, there's been a cleanup on my mind WRT this driver's locking. I think we can replace idxd->dev_lock with idxd_confdev(idxd) device lock. You can end up just do:
>>>>> guard(device)(idxd_confdev(idxd));
>>>>
>>>> Then we need to replace the lock from spinlock to mutex lock?
>>>
>>> We still need a (spin) lock that we could hold in interrupt contexts.
>>>
>>>>
>>>>>
>>>>> And also drop the wq->wq_lock and replace with wq_confdev(wq) device lock:
>>>>> guard(device)(wq_confdev(wq));
>>>>>
>>>>> If you are up for it that is.
>>>>
>>>> We creates a hierarchy: pdev -> idxd device -> wq device.
>>>> idxd_confdev(idxd) is the parent of wq_confdev(wq) because:
>>>>
>>>>       (wq_confdev(wq))->parent = idxd_confdev(idxd);
>>>>
>>>> Is it safe to grap lock of idxd_confdev(idxd) under hold
>>>> lock of wq_confdev(wq)?
>>>>
>>>> We have mounts of code use spinlock of idxd->dev_lock under
>>>> hold of wq->wq_lock.
>>>>
>>>
>>> I agree with Dave that the locking could be simplified, but I don't
>>> think that we should hold this series because of that. That
>>> simplification can be done later.
>>
>> I agree. Just passing musing on the current code.
> 
> Got it, do I need to send a separate patch for Patch 2?

Not sure what you mean. Do you mean if you need to send patch 2 again?
> 
> Thanks.
> Shuai


