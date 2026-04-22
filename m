Return-Path: <dmaengine+bounces-10083-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I9/OOg+6WmEWQIAu9opvQ
	(envelope-from <dmaengine+bounces-10083-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 23:34:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C7E44AF85
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 23:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6F07300B469
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2026 21:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB4367F25;
	Wed, 22 Apr 2026 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CnJoIEIJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F537755D
	for <dmaengine@vger.kernel.org>; Wed, 22 Apr 2026 21:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893665; cv=none; b=QgoG9cSxJMuGO7UNEDbtOa90JZlQy9OG6pbLSXxzoAyj1Z2NE5iq8hfNF9zqEc9ufs7h/SJuBgLeq+8sPJIbOtuSyI34QQvVYN14U/46GBoMNTvjzIHEYf2qUp446KYqax+kdSpIJONlcXo1vHpBquCBtCKMeShFZZVPu6S/2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893665; c=relaxed/simple;
	bh=j4ep7JtWvE+eBsS70irzVasiY7GmSSDWHVOd1jxQZlM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=VnFrPWcctvyG98yXlBm5ctq7kkDfHXJ026SuaMf8dQoGEh19JZ4e9yIWgIb7JvV3cBJbRQmpnZR5VGElP0Ve0PWfinkRZzcD8Jw0V7BXASlp+AjtFeCnoEGhE3t2VhV6s4qIvYmqTpSUyy0DFg6Y0OsJ9cYoHRaF6xV5fwOttdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CnJoIEIJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776893664; x=1808429664;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=j4ep7JtWvE+eBsS70irzVasiY7GmSSDWHVOd1jxQZlM=;
  b=CnJoIEIJBYZajqfGZxHxfsDHX0zmzDNtRBH/DGwqMqToe/+u/Q5cabjA
   sWtkPIH6AsFULIjQlVu58CwMD7Df42mvc8icwHpgH/uYq4YU7wq6EK+tl
   wBvAhGzbHS7Ac9SSChxA8lRhPQ3qzlW5ETn8jFG439zYVWxsrVn2PRYT8
   yLFhwwwwMQpV5AnPGf4CIStOXey1FKmjLeRQTIEp4bXkHlPda+8oyN4YG
   xzgTVv4yJt/JJe4kpqN6MqPz2lTBcpyWFL6/iTGjWnl7f+4pi7L8JRnNy
   NMRhqaC4CsbpjNkyaRUdGd5pUWHcYd9TIocrWV0Z20jZZ2RvR9lxm5nsp
   Q==;
X-CSE-ConnectionGUID: CQilvuIJSfmogZz79ZS7Lg==
X-CSE-MsgGUID: Vo7vsBA5TuCWPGTip84Q4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77022754"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="77022754"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 14:34:22 -0700
X-CSE-ConnectionGUID: R2cf4Fx7Qh2jdr1bAq9HvQ==
X-CSE-MsgGUID: IbP59mzmTtqfYY2O9GqHlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="237524927"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 14:34:23 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] dmaengine: idxd: Fix use-after-free of idxd_wq
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
 Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com
In-Reply-To: <20260415095030.42183-1-kanie@linux.alibaba.com>
References: <20260415095030.42183-1-kanie@linux.alibaba.com>
Date: Wed, 22 Apr 2026 14:34:02 -0700
Message-Id: <177689364254.530433.11713441936347707463.b4-review@b4>
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776893662; l=3426;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=j4ep7JtWvE+eBsS70irzVasiY7GmSSDWHVOd1jxQZlM=;
 b=SUhh6wMRkQX1FURJ7Ut2vlWhoZ2EdO4FecOe6/eA51XJTioDfeqrlOHJK4pTpi3woJjUlIw+Z
 qSaTZ95fg1sArmW3Zc/vptr9eiRwwTJKpTnCIKV7JDPpa9yhbAjl843
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10083-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: E0C7E44AF85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 17:50:30 +0800, Guixin Liu <kanie@linux.alibaba.com> wrote:
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index fb80803d5b57..c3cfd96074c9 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -1293,13 +1293,30 @@ static void idxd_remove(struct pci_dev *pdev)
> [ ... skip 14 lines ... ]
> +	 *
> +	 * Use device_release_driver() to only unbind the driver (triggering
> +	 * idxd_device_drv_remove()) without touching sysfs. Then safely
> +	 * unregister children before the parent.
> +	 */
> +	device_release_driver(idxd_confdev(idxd));

Below are sashiko comments verbatim, some notes:

 - I do believe the race condition that it points out is real (but
   very narrow), but not sure that we don't have a similar one in
   current code (i.e. it wasn't introduced by your patch);
 - The possible wq leak was definitely not introduced by this patch;
 - The question about what happens with the file references after a
   device is removed is a separate issue;

The patch looks good, not opposed to it at all, the only one I am a
bit concerned, about this patch, to be sure, is the race condition,
and the two "paths" to reach it. (the others we can fix separately)

sashiko.dev <sashiko@sashiko.dev>:

Does this introduce a race condition with sysfs?

Since the driver's sysfs nodes remain active after device_release_driver()
is called, a user with sysfs privileges could write to the bind attribute
to re-probe the driver before the device unregistration completes.

If idxd_device_drv_probe()->idxd_wqs_setup() runs concurrently with
idxd_unregister_devices(), does it cause a use-after-free when it
iterates over the idxd->wqs[] objects being freed, since
suppress_bind_attrs is not set?

Also, does this code leak the workqueue?

The workqueue idxd->wq is dynamically allocated using create_workqueue()
during device initialization, but destroy_workqueue(idxd->wq) does not
appear to be called in idxd_remove() or the sysfs device release callback.

>  	idxd_unregister_devices(idxd);

sashiko.dev <sashiko@sashiko.dev>:

If idxd_unregister_devices() drops the last reference to the child wq
objects and frees them, can idxd_shutdown() trigger a use-after-free
when called shortly after?

For example, if a hardware error interrupt fired during teardown,
idxd_shutdown()->flush_workqueue() could execute an error handler that
iterates over the freed idxd->wqs[] memory.

Additionally, if the hardware is wedged,
idxd_shutdown()->idxd_device_disable()->idxd_device_clear_state()
iterates over idxd->wqs[] and attempts to acquire mutex_lock(&wq->wq_lock)
on the freed memory.

Is there also a missing reference count for the cdev open path?

Since idxd_unregister_devices() frees the wq structure, if user space
holds an open file descriptor, cdev_device_del() won't revoke it.
Can file operations like mmap or poll subsequently access the freed
ctx->wq pointer? Should idxd_cdev_open() take a kobject reference on
the parent wq device?

via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com

via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com
via: https://sashiko.dev/#/message/20260415095030.42183-1-kanie@linux.alibaba.com

-- 
Vinicius


