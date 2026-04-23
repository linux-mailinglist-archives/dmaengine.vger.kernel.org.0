Return-Path: <dmaengine+bounces-10089-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN96Hozh6WkamgIAu9opvQ
	(envelope-from <dmaengine+bounces-10089-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 11:08:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD53944F0B2
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 11:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4734C3036611
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE537189C;
	Thu, 23 Apr 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hP4NrEyH"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F536B040
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934923; cv=none; b=shqD7GNXC1xJvcbzAEo9+miEl6jP4e1Ylnqxs8ZVfslgXD4ZIgEm6dO4LlCPRx/9DQibdKEFcschqFnbLo5Brz8iVKhwXsvP+0SG1TwZ3Fg58AraCpbghS4FgUQ4pQW2vJxu/AEvP2Ee8MmsarNGcfBrEJG8OWuFMt0S5xt8rv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934923; c=relaxed/simple;
	bh=AByUV8UnoAvjWyomC1ud+fmjA8RcrlCl4KBDJk7aadA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElpSNEWvR2HZ1nmJgJu9gn9cC/2Uy5YqG2hm1E7xv1+Awi9RlLFvTBPJ0vsD/0warkp0GlvYLdWqqJJUsx/2Go24/nseU351DcPwEWlaojfK+cpKxXdXgyFH1yMKeLA50igzit5KxVxgccCkZ5Hr/kl8OR8bEyWVB3aOYFNSUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hP4NrEyH; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776934913; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BXuW0ORc5jYcY+AhCU/Ewix+AhRnbY1qRQHAsf2VAsM=;
	b=hP4NrEyHLVh/SEG4TfVEZd+CeBkK0Zts90zc60jBwZIZ1LwQCAz26JIYRixUg2Rm/sxcUxlCrnPlrkYYbkHc8WxfoM6ZfVtdf18mHGy75sbxA3jFXv/EbV4LkBAHUn2KWUhPcvhF3HU2m7JrV+oP5zWyFJfh18iAZhUrEXLVT2k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X1Z98ao_1776934912;
Received: from 30.178.82.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X1Z98ao_1776934912 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 17:01:53 +0800
Message-ID: <968e2a4f-7613-4ef2-8cf4-68710ec55163@linux.alibaba.com>
Date: Thu, 23 Apr 2026 17:01:51 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: idxd: Fix use-after-free of idxd_wq
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com
References: <20260415095030.42183-1-kanie@linux.alibaba.com>
 <177689364254.530433.11713441936347707463.b4-review@b4>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <177689364254.530433.11713441936347707463.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10089-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kanie@linux.alibaba.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,sashiko.dev:email,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: AD53944F0B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/4/23 05:34, Vinicius Costa Gomes 写道:
> On Wed, 15 Apr 2026 17:50:30 +0800, Guixin Liu <kanie@linux.alibaba.com> wrote:
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index fb80803d5b57..c3cfd96074c9 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -1293,13 +1293,30 @@ static void idxd_remove(struct pci_dev *pdev)
>> [ ... skip 14 lines ... ]
>> +	 *
>> +	 * Use device_release_driver() to only unbind the driver (triggering
>> +	 * idxd_device_drv_remove()) without touching sysfs. Then safely
>> +	 * unregister children before the parent.
>> +	 */
>> +	device_release_driver(idxd_confdev(idxd));
Thanks for the reply.
> Below are sashiko comments verbatim, some notes:
>
>   - I do believe the race condition that it points out is real (but
>     very narrow), but not sure that we don't have a similar one in
>     current code (i.e. it wasn't introduced by your patch);
>   - The possible wq leak was definitely not introduced by this patch;
>   - The question about what happens with the file references after a
>     device is removed is a separate issue;
>
> The patch looks good, not opposed to it at all, the only one I am a
> bit concerned, about this patch, to be sure, is the race condition,
> and the two "paths" to reach it. (the others we can fix separately)
>
> sashiko.dev <sashiko@sashiko.dev>:
>
> Does this introduce a race condition with sysfs?
>
> Since the driver's sysfs nodes remain active after device_release_driver()
> is called, a user with sysfs privileges could write to the bind attribute
> to re-probe the driver before the device unregistration completes.
>
> If idxd_device_drv_probe()->idxd_wqs_setup() runs concurrently with
> idxd_unregister_devices(), does it cause a use-after-free when it
> iterates over the idxd->wqs[] objects being freed, since
> suppress_bind_attrs is not set?
I think re-probe will call idxd_pci_probe() to allocate an new idxd device,
this avoids accessing stale data.
> Also, does this code leak the workqueue?
>
> The workqueue idxd->wq is dynamically allocated using create_workqueue()
> during device initialization, but destroy_workqueue(idxd->wq) does not
> appear to be called in idxd_remove() or the sysfs device release callback.
Looks like it's b7cb9a034305 ("dmaengine: idxd: Fix refcount underflow 
on module unload")
overlooked this, destory_workqueue(idxd->wq) is called in idxd_cleanup() 
-> idxd_cleanup_internals().

If so, I can send another patch to fix this.
>>   	idxd_unregister_devices(idxd);
> sashiko.dev <sashiko@sashiko.dev>:
>
> If idxd_unregister_devices() drops the last reference to the child wq
> objects and frees them, can idxd_shutdown() trigger a use-after-free
> when called shortly after?
>
> For example, if a hardware error interrupt fired during teardown,
> idxd_shutdown()->flush_workqueue() could execute an error handler that
> iterates over the freed idxd->wqs[] memory.
>
> Additionally, if the hardware is wedged,
> idxd_shutdown()->idxd_device_disable()->idxd_device_clear_state()
> iterates over idxd->wqs[] and attempts to acquire mutex_lock(&wq->wq_lock)
> on the freed memory.
I took a look — idxd_shutdown() is only invoked by idxd_remove() and 
during system shutdown/reboot.
Is idxd_shutdown() ever reached from the idxd hardware error interrupt path?
>
> Is there also a missing reference count for the cdev open path?
>
> Since idxd_unregister_devices() frees the wq structure, if user space
> holds an open file descriptor, cdev_device_del() won't revoke it.
> Can file operations like mmap or poll subsequently access the freed
> ctx->wq pointer? Should idxd_cdev_open() take a kobject reference on
> the parent wq device?
To be honest, I'm not very familiar with the idxd driver. At this point,
it looks like the idxd driver needs a state machine to ensure mutual 
exclusion
across the various concurrent paths.

Best Regards,
Guixin Liu
>
> via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
> via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
>
> via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
> via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
>


