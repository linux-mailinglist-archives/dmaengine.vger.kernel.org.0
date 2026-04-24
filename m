Return-Path: <dmaengine+bounces-10098-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HUtHzcG62kFHgAAu9opvQ
	(envelope-from <dmaengine+bounces-10098-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 07:57:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78C45A158
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 07:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB892300EAAE
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15C340282;
	Fri, 24 Apr 2026 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hRNGHMed"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49B1FF7C8
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777010228; cv=none; b=sQdrBxYXha6kpBJQIAXfp9Vb3OyNBhkBXwxz4K8B3/zx1rih/Uap6VQYPs56TJuSaunIqAAbv/jnaZGsEupt+3dgrJAlOxsCCwmnlnQTjyz2E+gmn3MafWUBNB47Cv/njXQMMq1XJBrArdxdfST+C4hLfXURh8fNJtNnRIvQibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777010228; c=relaxed/simple;
	bh=yDOGpiIAEXFkPtg7R2CrjT64RsPMeFZEjFMxwgIvhS0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RmmxgqYib1GYA7Or1GHTcS2caqnJ7XFiTRwH3IOlwob0DbSLH6lBhepY2wqMHGVn/W+vPhYIARIn9Gv7BoKv8e4PpLSNBS+KbLydEa6jY6teNqM1/cJulamrArDHImpD0aG8TzQvKAs+qliOTMVh0tGVl/b3bFPJWhryfpb82ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hRNGHMed; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777010212; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=t4KwzDc+LzT8WbIyCmSIRus/6I530z/unHWf9vaxdyc=;
	b=hRNGHMedSp/xrltIlQ/oG+17+7hVLVMyRvaY4SXNfC82BCLgUZUOi1TFx2TviFlU5IJz+T1vp4lSGQmvGmirEEiIvjn2pQ26yhVwd44HG9Tv7ou7VnJiv+gqKrpWQsBRHPoiEwjGT22KW1DI1snOvTH0uIM7xfAGNt6dGjrPotc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X1bYVIq_1777010211;
Received: from 30.178.82.182(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X1bYVIq_1777010211 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Apr 2026 13:56:51 +0800
Message-ID: <3847a039-bdab-478d-be57-c46c7665f92c@linux.alibaba.com>
Date: Fri, 24 Apr 2026 13:56:50 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: idxd: Fix use-after-free of idxd_wq
From: Guixin Liu <kanie@linux.alibaba.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com
References: <20260415095030.42183-1-kanie@linux.alibaba.com>
 <177689364254.530433.11713441936347707463.b4-review@b4>
 <968e2a4f-7613-4ef2-8cf4-68710ec55163@linux.alibaba.com>
 <87cxzp1p9o.fsf@intel.com>
 <d8d91f16-4323-4c66-85cf-10fbc6a99ebc@linux.alibaba.com>
In-Reply-To: <d8d91f16-4323-4c66-85cf-10fbc6a99ebc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE78C45A158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10098-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kanie@linux.alibaba.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,sashiko.dev:url,sashiko.dev:email]



在 2026/4/24 13:43, Guixin Liu 写道:
>
>
> 在 2026/4/24 02:54, Vinicius Costa Gomes 写道:
>> Guixin Liu <kanie@linux.alibaba.com> writes:
>>
>>> 在 2026/4/23 05:34, Vinicius Costa Gomes 写道:
>>>> On Wed, 15 Apr 2026 17:50:30 +0800, Guixin Liu 
>>>> <kanie@linux.alibaba.com> wrote:
>>>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>>>> index fb80803d5b57..c3cfd96074c9 100644
>>>>> --- a/drivers/dma/idxd/init.c
>>>>> +++ b/drivers/dma/idxd/init.c
>>>>> @@ -1293,13 +1293,30 @@ static void idxd_remove(struct pci_dev *pdev)
>>>>> [ ... skip 14 lines ... ]
>>>>> +     *
>>>>> +     * Use device_release_driver() to only unbind the driver 
>>>>> (triggering
>>>>> +     * idxd_device_drv_remove()) without touching sysfs. Then safely
>>>>> +     * unregister children before the parent.
>>>>> +     */
>>>>> +    device_release_driver(idxd_confdev(idxd));
>>> Thanks for the reply.
>>>> Below are sashiko comments verbatim, some notes:
>>>>
>>>>    - I do believe the race condition that it points out is real (but
>>>>      very narrow), but not sure that we don't have a similar one in
>>>>      current code (i.e. it wasn't introduced by your patch);
>>>>    - The possible wq leak was definitely not introduced by this patch;
>>>>    - The question about what happens with the file references after a
>>>>      device is removed is a separate issue;
>>>>
>>>> The patch looks good, not opposed to it at all, the only one I am a
>>>> bit concerned, about this patch, to be sure, is the race condition,
>>>> and the two "paths" to reach it. (the others we can fix separately)
>>>>
>>>> sashiko.dev <sashiko@sashiko.dev>:
>>>>
>>>> Does this introduce a race condition with sysfs?
>>>>
>>>> Since the driver's sysfs nodes remain active after 
>>>> device_release_driver()
>>>> is called, a user with sysfs privileges could write to the bind 
>>>> attribute
>>>> to re-probe the driver before the device unregistration completes.
>>>>
>>>> If idxd_device_drv_probe()->idxd_wqs_setup() runs concurrently with
>>>> idxd_unregister_devices(), does it cause a use-after-free when it
>>>> iterates over the idxd->wqs[] objects being freed, since
>>>> suppress_bind_attrs is not set?
>>> I think re-probe will call idxd_pci_probe() to allocate an new idxd 
>>> device,
>>> this avoids accessing stale data.
>> Yeah, I missed the (now obvious) that a new 'probe' also means a new
>> device. So this "path" is not valid. Thank you.
>>
>>>> Also, does this code leak the workqueue?
>>>>
>>>> The workqueue idxd->wq is dynamically allocated using 
>>>> create_workqueue()
>>>> during device initialization, but destroy_workqueue(idxd->wq) does not
>>>> appear to be called in idxd_remove() or the sysfs device release 
>>>> callback.
>>> Looks like it's b7cb9a034305 ("dmaengine: idxd: Fix refcount underflow
>>> on module unload")
>>> overlooked this, destory_workqueue(idxd->wq) is called in 
>>> idxd_cleanup()
>>> -> idxd_cleanup_internals().
>>>
>>> If so, I can send another patch to fix this.
>> Yes, please do.
> Will be added in v3.
Well, the idxd->wq is freed in idxd_conf_device_release(), so there is no
problem, no need to fix.
>>>>> idxd_unregister_devices(idxd);
>>>> sashiko.dev <sashiko@sashiko.dev>:
>>>>
>>>> If idxd_unregister_devices() drops the last reference to the child wq
>>>> objects and frees them, can idxd_shutdown() trigger a use-after-free
>>>> when called shortly after?
>>>>
>>>> For example, if a hardware error interrupt fired during teardown,
>>>> idxd_shutdown()->flush_workqueue() could execute an error handler that
>>>> iterates over the freed idxd->wqs[] memory.
>>>>
>>>> Additionally, if the hardware is wedged,
>>>> idxd_shutdown()->idxd_device_disable()->idxd_device_clear_state()
>>>> iterates over idxd->wqs[] and attempts to acquire 
>>>> mutex_lock(&wq->wq_lock)
>>>> on the freed memory.
>>> I took a look — idxd_shutdown() is only invoked by idxd_remove() and
>>> during system shutdown/reboot.
>>> Is idxd_shutdown() ever reached from the idxd hardware error interrupt
>>> path?
>> The bot's suggestion that this code path could be hit by a hardware
>> error is false, but the shutdown path (like the user pressing a button)
>> could be valid.
>>
>> A crash during that could cause the machine to not poweroff, which is
>> not good. Worth thinking about this, if there's something we could do
>> while we are here.
>
> Both idxd_remove() and idxd_shutdown() are called under 
> device_lock(dev) —
> the lock is acquired by the driver core before invoking any bus callback:
>
> 1.
>
>    Remove path: device_release_driver_internal() →
>    __device_driver_lock(dev, parent) → device_lock(dev) → ... →
>    pci_device_remove() → idxd_remove()
>
> 2.
>
>    Shutdown path: device_shutdown() → device_lock(dev) →
>    dev->bus->shutdown(dev) → pci_device_shutdown() → idxd_shutdown()
>
> Since both paths acquire the same dev->mutex on the same PCI device,
>
> idxd_remove() and idxd_shutdown() are mutually exclusive.
>
> Best Regards,
>
> Guixin Liu
>
>>>> Is there also a missing reference count for the cdev open path?
>>>>
>>>> Since idxd_unregister_devices() frees the wq structure, if user space
>>>> holds an open file descriptor, cdev_device_del() won't revoke it.
>>>> Can file operations like mmap or poll subsequently access the freed
>>>> ctx->wq pointer? Should idxd_cdev_open() take a kobject reference on
>>>> the parent wq device?
>>> To be honest, I'm not very familiar with the idxd driver. At this 
>>> point,
>>> it looks like the idxd driver needs a state machine to ensure mutual
>>> exclusion
>>> across the various concurrent paths.
>> Don't worry about this one, it's a separate issue.
>>
>>> Best Regards,
>>> Guixin Liu
>>>> via: 
>>>> https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
>>>> via: 
>>>> https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
>>>>
>>>> via: 
>>>> https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
>>>> via: 
>>>> https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
>>>>
>>
>> Cheers,
>


