Return-Path: <dmaengine+bounces-10572-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIJKMzY5DmpC8gUAu9opvQ
	(envelope-from <dmaengine+bounces-10572-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:44:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684A59C386
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 00:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D6033147760
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733C35F170;
	Wed, 20 May 2026 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lBlHVFgt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC583603D9
	for <dmaengine@vger.kernel.org>; Wed, 20 May 2026 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307195; cv=none; b=lxwNi8hxwNHKi1lKkSfh9Z4Up41qC9YGZ7hwfEwsSBitFZcFde3mpQ6C4g/kihzNwDSbb8KlbRX6vl83Jyt6Rsw8TBqs0Z5iU4BmOgTzM3St0C2AJW7U10bJX9Mb6FkcBxB6sWNLeQ5Sk8ZQJ+YvcwagHDgj5QTkQe2t7bicQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307195; c=relaxed/simple;
	bh=hD5Dr5eqzKey7AKxPUWEaRtLcPVqQpTHkkibqELo2tA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z14QRBl7rXgy2f8qjt//ORi5N3KVoxIV4tNwFWwAHB2Qd7VkZ8dN85t8WYj/oZRvGMoyDuXVr1Bp8hNU1wd3ErhY/qV0wQvkIzFtfMCfCZaZQ8huHOs7EIanVEA14aLCF2YfxhnWeUEKLtJhXOyz6tUM8nVcoSGs4bTDZSfKn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lBlHVFgt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779307192; x=1810843192;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=hD5Dr5eqzKey7AKxPUWEaRtLcPVqQpTHkkibqELo2tA=;
  b=lBlHVFgtxwTjfCfidlxYgCUsNJIGvdzEifjh6E5hxP2hHE3eL5CERmNV
   A0H/T1nw6aqXy4tNe3MRmd2WH1Jz2OlOaEWRRoUk74Fm6MgiF8aPKizCP
   XK899NthKP5a3pa1yEQYX1XUxsCBkwx5ZkdMhuymLe48w+AJBnZcNUNkW
   t3eMy2ywNPcU1hLJHvJGdBokT0yLE/rILyr3/1EsOXOIbi5RkCrf2oRD8
   TuftOYuVwNM57fDMgQMlU3T5g0TZnN+K3I5z5ewvXssxr+9Q3cKNmgRc3
   9MMw7sVCO6Wddz+JZoxWTVOqRMKoazKWqb026kCsNF6pApern0ZQOc2/r
   A==;
X-CSE-ConnectionGUID: na3cne+xRP6uDqkL6E5Rog==
X-CSE-MsgGUID: obF6ahN8R76ewf6xTAjS9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90795424"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90795424"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 12:59:48 -0700
X-CSE-ConnectionGUID: xDbbpzKqTvecgnBpyYzrvQ==
X-CSE-MsgGUID: q+z53QS0S3uFWqnsmnLuSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240534803"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 12:59:46 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: sashiko-reviews@lists.linux.dev, Steve Wahl <steve.wahl@hpe.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix problems on initialization error
 path.
In-Reply-To: <20260520152050.8BFA01F000E9@smtp.kernel.org>
References: <20260520143732.119407-1-steve.wahl@hpe.com>
 <20260520152050.8BFA01F000E9@smtp.kernel.org>
Date: Wed, 20 May 2026 12:59:45 -0700
Message-ID: <87h5o1ua1a.fsf@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10572-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,hpe.com:email]
X-Rspamd-Queue-Id: 2684A59C386
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Incomplete Fix / Double Free & Double Destroy
> - [High] Immediate Double Free in child device cleanup functions
> - [High] Use-After-Free and Double Free due to dangling pointers in regis=
tration rollback
> --
>
> commit 36d73f2b6ed131031e13332b322a76ce56830ad7
> Author: Steve Wahl <steve.wahl@hpe.com>
> Subject: dmaengine: idxd: fix problems on initialization error path.
>
> This patch fixes double frees and NULL pointer dereferences in the IDXD
> initialization error paths by ensuring allocations are freed only once
> during the device release callback, and checking if the workqueue exists
> before destroying it.
>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index f1cfc7790d950..227e323cc5a0b 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>
> [ ... ]
>
>> @@ -649,8 +646,13 @@ static struct idxd_device *idxd_alloc(struct pci_de=
v *pdev, struct idxd_driver_d
>>  	return idxd;
>>=20=20
>>  err_name:
>> +	/*
>> +	 * once device_initialize(conf_dev) is called,
>> +	 * put_device(conf_dev) will end up calling
>> +	 * idxd_conf_device_release() which will free the rest.
>> +	 */
>>  	put_device(conf_dev);
>
> [Severity: High]
> This is a pre-existing issue, but does a similar pattern cause immediate =
double
> frees in the child device cleanup functions?
>
> In functions like idxd_clean_wqs(), idxd_clean_groups(), and
> idxd_clean_engines() (as well as their setup error paths), cleanup is per=
formed
> by calling put_device() on the child kobjects.
>
> This drops the reference count to 0 and synchronously invokes the sysfs r=
elease
> callback (e.g., idxd_conf_wq_release(), idxd_conf_group_release()), which=
 safely
> frees the structure (kfree(wq)) and its internal allocations.
>
> However, immediately after put_device() returns, these cleanup functions
> explicitly call kfree() on the exact same device structure (and inner poi=
nters
> like wq->wqcfg). Will this result in immediate double frees when unloadin=
g the
> driver or failing initialization?
>

I believe this patch already solves this issue:

https://lore.kernel.org/dmaengine/20260415205452.67155-1-dbgh9129@gmail.com/

>
> [Severity: High]
> This isn't a bug introduced by this patch, but are there dangling pointer=
s in
> the registration rollback that cause a use-after-free?
>
> If idxd_register_wq_devices() (or equivalent engine/group registration
> functions) fails, its error rollback drops references to all child device=
s via
> put_device() or device_unregister(), which invokes their release callback=
s and
> frees them.
>
> It does not remove the dangling pointers from the idxd->wqs (or groups/en=
gines)
> arrays.
>
> The error then bubbles up to idxd_pci_probe_alloc(), which jumps to
> err_dev_register and calls idxd_cleanup(). This eventually calls
> idxd_clean_wqs(), which iterates over the full idxd->wqs array and
> unconditionally calls put_device() and kfree() on the already-freed point=
ers.
>

That patch from Yuho Choi may also fix this.

>> +	return NULL;
>>  err_opcap:
>>  	ida_free(&idxd_ida, idxd->id);
>>  err_ida:
>
> [ ... ]
>
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 6d251095c350f..d5ffc641c8567 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device=
 *dev)
>>  {
>>  	struct idxd_device *idxd =3D confdev_to_idxd(dev);
>>=20=20
>> -	destroy_workqueue(idxd->wq);
>> +	if (idxd->wq)
>> +		destroy_workqueue(idxd->wq);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but do the error paths from
> idxd_probe() still cause a double free and double destroy?
>
> If an error occurs in idxd_probe() (e.g., idxd_device_load_config() fails=
),
> idxd_cleanup_internals() or idxd_setup_internals() error paths are invoke=
d.
> These functions manually free arrays (idxd->groups, idxd->wqs, idxd->engi=
nes)
> and destroy the workqueue (destroy_workqueue(idxd->wq)) but leave the poi=
nters
> non-NULL.
>
> When the error propagates up to idxd_pci_probe_alloc(), it calls idxd_fre=
e()
> which calls put_device(). This triggers idxd_conf_device_release().
>
> Because the pointers are still non-NULL, idxd_conf_device_release()
> unconditionally calls kfree() on the arrays a second time and executes
> destroy_workqueue(idxd->wq) again on the already-destroyed workqueue.
>
>>  	kfree(idxd->groups);
>>  	bitmap_free(idxd->wq_enable_map);
>>  	kfree(idxd->wqs);
>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520143732.11=
9407-1-steve.wahl@hpe.com?part=3D1

--=20
Vinicius

