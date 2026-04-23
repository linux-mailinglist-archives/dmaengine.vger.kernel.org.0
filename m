Return-Path: <dmaengine+bounces-10096-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPB1EVFr6mmhzAIAu9opvQ
	(envelope-from <dmaengine+bounces-10096-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 20:56:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 740A3456406
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 20:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5C13008794
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 18:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E13A9623;
	Thu, 23 Apr 2026 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/0jr5VV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917942DC32C
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970454; cv=none; b=L+r375Edq2N9ybHWLM47GDXCAA5jZ25QoWPlI5eoFKGHLIq2iNmIwKc2Dk5DC9zhVLgnk1swOBNuknkAhKDy++EuSmWoAUiJjebvjzNkvOZowxe1w2KkIdNXQ8+NaX9de4ZUOGVBL5a+bMCulCHjraJyXSDKp2Lq+a+wEvU08to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970454; c=relaxed/simple;
	bh=sKb9NLzlHD5ZSdkhaSF5XhwDy4irF74LWug465aALjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q5jx8nI0/ogve0xFLs57GdtjdtlCwDXRWLfxxVc1zpwUAiyKPXBel5GXw7qyfNBj5pIF4NeVKEPP3FYRJo/QaBGng7QErie6hMFLi2No3fmQQTe0VFEkzMdF6+KuFfvd2LsqyJAf7TyXonV7aJ+JS2bZ8nu+INabNJD0SCTa0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/0jr5VV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776970453; x=1808506453;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=sKb9NLzlHD5ZSdkhaSF5XhwDy4irF74LWug465aALjY=;
  b=O/0jr5VVz46nVlILOVtpg/e2bkE+2/EcjCwtm+ShBnTrkYEmo/rOzzHZ
   G6XB1emA2+jariTX4wKqaUoeVQyefVkCxwoMPoQvedC0IGosF8aZba438
   h2DPOevYQSJPC3uI5W9aSzSg7dBCI/IGY2aP5sbDi//adlN0jthE2513o
   GEXSsHDn18klgbDA3BTNiuVbQaYrttMmurQOZh8iQnF556K/cDE0wtljZ
   J513GmW/BMIgtHuIufMe5+SK4qtwTVMk9kg1hgN0mCXR+I9NQVLS3jC3x
   krV1wkO3/oEDR30l4jOm3DfFoUmwd+EwVzjXWbCHqX1i6gwl1PB7QH/Fa
   w==;
X-CSE-ConnectionGUID: W0HfWlP1RGus+0kECgU1zw==
X-CSE-MsgGUID: 885qlOW1RkCkGXEN8q7s6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="78011025"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="78011025"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 11:54:12 -0700
X-CSE-ConnectionGUID: r58BSC89TzCsR/jjFZR4bw==
X-CSE-MsgGUID: p9mcOeBuRn6aRxwwxEv5og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="256240977"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 11:54:12 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Frank
 Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, Xunlei Pang
 <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v2] dmaengine: idxd: Fix use-after-free of idxd_wq
In-Reply-To: <968e2a4f-7613-4ef2-8cf4-68710ec55163@linux.alibaba.com>
References: <20260415095030.42183-1-kanie@linux.alibaba.com>
 <177689364254.530433.11713441936347707463.b4-review@b4>
 <968e2a4f-7613-4ef2-8cf4-68710ec55163@linux.alibaba.com>
Date: Thu, 23 Apr 2026 11:54:11 -0700
Message-ID: <87cxzp1p9o.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10096-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,intel.com:dkim,intel.com:mid,sashiko.dev:url,sashiko.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 740A3456406
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guixin Liu <kanie@linux.alibaba.com> writes:

> =E5=9C=A8 2026/4/23 05:34, Vinicius Costa Gomes =E5=86=99=E9=81=93:
>> On Wed, 15 Apr 2026 17:50:30 +0800, Guixin Liu <kanie@linux.alibaba.com>=
 wrote:
>>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>>> index fb80803d5b57..c3cfd96074c9 100644
>>> --- a/drivers/dma/idxd/init.c
>>> +++ b/drivers/dma/idxd/init.c
>>> @@ -1293,13 +1293,30 @@ static void idxd_remove(struct pci_dev *pdev)
>>> [ ... skip 14 lines ... ]
>>> +	 *
>>> +	 * Use device_release_driver() to only unbind the driver (triggering
>>> +	 * idxd_device_drv_remove()) without touching sysfs. Then safely
>>> +	 * unregister children before the parent.
>>> +	 */
>>> +	device_release_driver(idxd_confdev(idxd));
> Thanks for the reply.
>> Below are sashiko comments verbatim, some notes:
>>
>>   - I do believe the race condition that it points out is real (but
>>     very narrow), but not sure that we don't have a similar one in
>>     current code (i.e. it wasn't introduced by your patch);
>>   - The possible wq leak was definitely not introduced by this patch;
>>   - The question about what happens with the file references after a
>>     device is removed is a separate issue;
>>
>> The patch looks good, not opposed to it at all, the only one I am a
>> bit concerned, about this patch, to be sure, is the race condition,
>> and the two "paths" to reach it. (the others we can fix separately)
>>
>> sashiko.dev <sashiko@sashiko.dev>:
>>
>> Does this introduce a race condition with sysfs?
>>
>> Since the driver's sysfs nodes remain active after device_release_driver=
()
>> is called, a user with sysfs privileges could write to the bind attribute
>> to re-probe the driver before the device unregistration completes.
>>
>> If idxd_device_drv_probe()->idxd_wqs_setup() runs concurrently with
>> idxd_unregister_devices(), does it cause a use-after-free when it
>> iterates over the idxd->wqs[] objects being freed, since
>> suppress_bind_attrs is not set?
> I think re-probe will call idxd_pci_probe() to allocate an new idxd devic=
e,
> this avoids accessing stale data.

Yeah, I missed the (now obvious) that a new 'probe' also means a new
device. So this "path" is not valid. Thank you.

>> Also, does this code leak the workqueue?
>>
>> The workqueue idxd->wq is dynamically allocated using create_workqueue()
>> during device initialization, but destroy_workqueue(idxd->wq) does not
>> appear to be called in idxd_remove() or the sysfs device release callbac=
k.
> Looks like it's b7cb9a034305 ("dmaengine: idxd: Fix refcount underflow=20
> on module unload")
> overlooked this, destory_workqueue(idxd->wq) is called in idxd_cleanup()=
=20
> -> idxd_cleanup_internals().
>
> If so, I can send another patch to fix this.

Yes, please do.

>>>   	idxd_unregister_devices(idxd);
>> sashiko.dev <sashiko@sashiko.dev>:
>>
>> If idxd_unregister_devices() drops the last reference to the child wq
>> objects and frees them, can idxd_shutdown() trigger a use-after-free
>> when called shortly after?
>>
>> For example, if a hardware error interrupt fired during teardown,
>> idxd_shutdown()->flush_workqueue() could execute an error handler that
>> iterates over the freed idxd->wqs[] memory.
>>
>> Additionally, if the hardware is wedged,
>> idxd_shutdown()->idxd_device_disable()->idxd_device_clear_state()
>> iterates over idxd->wqs[] and attempts to acquire mutex_lock(&wq->wq_loc=
k)
>> on the freed memory.
> I took a look =E2=80=94 idxd_shutdown() is only invoked by idxd_remove() =
and=20
> during system shutdown/reboot.
> Is idxd_shutdown() ever reached from the idxd hardware error interrupt
> path?

The bot's suggestion that this code path could be hit by a hardware
error is false, but the shutdown path (like the user pressing a button)
could be valid.

A crash during that could cause the machine to not poweroff, which is
not good. Worth thinking about this, if there's something we could do
while we are here.

>>
>> Is there also a missing reference count for the cdev open path?
>>
>> Since idxd_unregister_devices() frees the wq structure, if user space
>> holds an open file descriptor, cdev_device_del() won't revoke it.
>> Can file operations like mmap or poll subsequently access the freed
>> ctx->wq pointer? Should idxd_cdev_open() take a kobject reference on
>> the parent wq device?
> To be honest, I'm not very familiar with the idxd driver. At this point,
> it looks like the idxd driver needs a state machine to ensure mutual=20
> exclusion
> across the various concurrent paths.

Don't worry about this one, it's a separate issue.

>
> Best Regards,
> Guixin Liu
>>
>> via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.al=
ibaba.com
>> via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.al=
ibaba.com
>>
>> via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.al=
ibaba.com
>> via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.al=
ibaba.com
>>
>


Cheers,
--=20
Vinicius

