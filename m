Return-Path: <dmaengine+bounces-4630-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47EA4B5EE
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 03:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA4C189049D
	for <lists+dmaengine@lfdr.de>; Mon,  3 Mar 2025 02:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619E7082D;
	Mon,  3 Mar 2025 02:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QHU3h0LK"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428D11CA9;
	Mon,  3 Mar 2025 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967322; cv=none; b=Yg2E9HUiAvSN6DRtrujI5v4ID2YPag2u++pApK4rvujAB3/QtqR22f4lXzFluL73C97Q+1xVcnK/kQRYVAyR+r0JRnuM1cUn7rN3fvH3UB/mIcmww44m1usG/KftlTKmZjyuh+2CBeFtU0FKpZLmyH5ZhzzeEY10ydc1doh73Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967322; c=relaxed/simple;
	bh=Lg4HoXy6iEDWr69K/FVya5ESd1zRKYThdMvhH6NXTvY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uzbfyVV5RIn3PBfJMsCxVuTvxbX6FsaWvd23ozfOg3GFvcKS87gK4GFoI/rlhcCPZiHd06OARKJtsDlcW+tCE6SmIdm8OG8xCOIaKIWwKNaIEKRxHoThWnJ+D7mQyn5Vnc2WiMNDezma+/Hp41Ykze1j9AGr4l+6N46dUz5JAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QHU3h0LK; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740967308; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=tAsmzUbsScf+J7KRZDBMIB9hwRSOJTlpY6FjWudl2NE=;
	b=QHU3h0LKMdduTkjzJBLVD147zrrYDrdHQraaww7/rcXr+FPGjZVLevlNpKa854BgtxpxtTRmM7IFB1YIPf0ts7m0Y/qCmXIX+JAJkcapw5iAsljanAfgUftBsWWtkv8DGBG7zlBpUzUn8UkEfXLPP1zJWuXle+Cick0fq8OMv0M=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQWe4vV_1740967306 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 10:01:47 +0800
Message-ID: <8133d4d3-abe0-4039-b209-4c08cebbbc5f@linux.alibaba.com>
Date: Mon, 3 Mar 2025 10:01:45 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] dmaengine: idxd: Refactor remove call with
 idxd_cleanup() helper
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Fenghua Yu <fenghuay@nvidia.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: nikhil.rao@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-8-xueshuai@linux.alibaba.com>
 <4b5b45b3-76a1-4850-aeba-ff4d6777e97c@nvidia.com>
 <5dfdb75c-e532-4a5e-8098-7650c6494d78@linux.alibaba.com>
In-Reply-To: <5dfdb75c-e532-4a5e-8098-7650c6494d78@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/19 21:28, Shuai Xue 写道:
> 
> 
> 在 2025/2/19 05:01, Fenghua Yu 写道:
>> Hi, Shuai,
>>
>> On 2/14/25 21:44, Shuai Xue wrote:
>>> The idxd_cleanup() helper clean up perfmon, interrupts, internals and so
>>
>> s/clean/cleans/
>>
>>
>>> on. Refactor remove call with idxd_cleanup() helper to avoid code
>> s/idxd_cleanup()/the idxd_cleanup()/
>>> duplication. Note, this also fixes the missing put_device() for idxd
>>> groups, enginces and wqs.
>>>
>>> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
>>> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>> ---
>>>   drivers/dma/idxd/init.c | 13 ++-----------
>>>   1 file changed, 2 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>> index f40f1c44a302..0fbfbe024c29 100644
>>> --- a/drivers/dma/idxd/init.c
>>> +++ b/drivers/dma/idxd/init.c
>>> @@ -1282,20 +1282,11 @@ static void idxd_remove(struct pci_dev *pdev)
>>>       get_device(idxd_confdev(idxd));
>> get_device() is called here.
>>>       device_unregister(idxd_confdev(idxd));
>>>       idxd_shutdown(pdev);
>>> -    if (device_pasid_enabled(idxd))
>>> -        idxd_disable_system_pasid(idxd);
>>>       idxd_device_remove_debugfs(idxd);
>>> -
>>> -    irq_entry = idxd_get_ie(idxd, 0);
>>> -    free_irq(irq_entry->vector, irq_entry);
>>> -    pci_free_irq_vectors(pdev);
>>> +    idxd_cleanup(idxd);
>>>       pci_iounmap(pdev, idxd->reg_base);
>>> -    if (device_user_pasid_enabled(idxd))
>>> -        idxd_disable_sva(pdev);
>>> -    pci_disable_device(pdev);
>>> -    destroy_workqueue(idxd->wq);
>>> -    perfmon_pmu_remove(idxd);
>>>       idxd_free(idxd);
>>
>> put_device() is called inside idxd_free(). Seems not easy to read code to match the pair.
> 
> IMHO, idxd_free() is paired with idxd_alloc() which grap a reference count by
> device_initialize(). So, we should match that right pair.
> 
>> * When ->release() is called for the idxd->conf_dev, it frees all the memory related
>> * to the idxd context.
> 
> I did not figure out why you explictly grab reference count of
> idxd_confdev(idxd).
> 
> idxd_unregister_devices() is paired with idxd_register_devices(), it only
> decrease reference through wqs, engines, and groups. So a refcnt of
> idxd->conf_dev is still hold by idxd_alloc().
> 
> Please correct me, if I missed anything.
> 
>>
>> Plus idxd_free() is called only in non FLR case.
>>
>> Maybe it's better to change this code to:
>>
>> 1. call put_device() outside idxd_free() so that it's easy to match the get_device() and put_deivce in the same level of function.
> 
> See my comments above.
>>
>> 2. idxd_free() called here is OK because this is not in FLR handler. But only call it in non FLR path in idxd_pci_probe_alloc()
>>
> 
> Exactly, so, shoud I add a protection in idxd_free() in a fact that non FLR case will not call it.
> 
> Thanks.
> Shuai

Hi, all，

Any feedback?

Thanks.
Shuai

