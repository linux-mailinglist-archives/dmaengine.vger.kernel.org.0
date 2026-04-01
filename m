Return-Path: <dmaengine+bounces-9817-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N3SA96nzWmvfgYAu9opvQ
	(envelope-from <dmaengine+bounces-9817-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 01:18:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1344B3819D4
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 01:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21F5F30055D2
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 23:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA5344040;
	Wed,  1 Apr 2026 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLTSpUZ/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C540DFB5;
	Wed,  1 Apr 2026 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775085528; cv=none; b=nFtudMjmqliVkmG4O8zDkB6X/rZhFu3bGLMXR7u5+wmE4LFZJE4+9b1YVSv34adjRTuKGcE9GwMONxDcfzTd3SVZpVeAYwQHCs7sSB1TIF5P9XsnBStD6ha5gqDV6WL7KhW2irLIztHVcalGqvNwWQddTnZGVThJj1160LZQqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775085528; c=relaxed/simple;
	bh=kvt2sqnU/6PMMzxpzpUg6H7JdDD4ue7qX4Re9/WX4oI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rURDk8yTGIbIbokarn2icm+TLYnh/fbgzOiA/X0ToSYws8ihAtOW+SbZ/S4a2Xa7u4/zlCbHp5RMl0bHIr7MXz5YYyOAN+Qru1BZA7SIvBDaUcAfFgVq5fMH6mPzDNYUe0l86wNG8VMxNPhfmgV3wryTg5U0BMrjpjOHFsFO7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLTSpUZ/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775085527; x=1806621527;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kvt2sqnU/6PMMzxpzpUg6H7JdDD4ue7qX4Re9/WX4oI=;
  b=WLTSpUZ/YFDmpMOOa1yWG4PQlB1DyhGOoA8Xa4VPmKpEQWAccySxRygx
   knMC+9RiGFtSvMCW9m3EoGJNFEmYHdpVebVgNWXBYNBqlYJl1HHkqUzSb
   yWZjBN1TdK565wFYg3pxiEo+QYcKDnB50iLJunZ3BGv8zvdgRF1fGoM3b
   WCPWtdiTh1+I/PSA/LaI3JcMzrbaEeg4Zyi1g3m0tSOxx4maQTxTelk/Z
   eeAvc1gI4s4MIWVHD89R++nl9edccxZzZUIcFPlNqSKVLaZ2WqsfBtp4B
   XAO83ayJ/DKoEZlLuVedfAgHT+lA7NmMSPv6yYQnUhH8njTmH1WsEgUDo
   w==;
X-CSE-ConnectionGUID: gEm8SxP6QWG2Yz+hvAKr/w==
X-CSE-MsgGUID: fLXhtXngT/62K8JgsJ4KWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="101588379"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="101588379"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:18:47 -0700
X-CSE-ConnectionGUID: acjplolbQiGcSoX73bvGPg==
X-CSE-MsgGUID: RusK7QhDQt+sMzQq7E2H1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="250022714"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:18:46 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Dave Jiang
 <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Shuai Xue
 <xueshuai@linux.alibaba.com>, Fenghua Yu <fenghuay@nvidia.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix double free in idxd_alloc() error
 path
In-Reply-To: <20260401094003.1482794-1-lgs201920130244@gmail.com>
References: <20260401094003.1482794-1-lgs201920130244@gmail.com>
Date: Wed, 01 Apr 2026 16:18:45 -0700
Message-ID: <87h5puxoa2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9817-lists,dmaengine=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com,kernel.org,linux.alibaba.com,nvidia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 1344B3819D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Guangshuo Li <lgs201920130244@gmail.com> writes:

> When dev_set_name() fails after device_initialize(), idxd_alloc()
> calls put_device(conf_dev).
>
> For these devices, conf_dev->type is set from idxd->data->dev_type,
> which resolves to dsa_device_type or iax_device_type, and both use
> idxd_conf_device_release() as their release callback.
>
> That release callback frees idxd, idxd->opcap_bmap, and releases
> idxd->id, but the current error path then frees those resources again
> directly, causing a double free.
>
> Keep the cleanup in idxd_conf_device_release() after put_device() and
> avoid freeing idxd-managed resources again in idxd_alloc().
>
> Fixes: 46a5cca76c76 ("dmaengine: idxd: fix memory leak in error handling path of idxd_alloc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

My preference is for the maintainer making the pull request to decide if
something should be sent to stable or not.

I was trying some AI review bot, I hope you don't mind, and got these
comments, went through them and they seemed good (including that these
patches should be sent as a series, that there are some more work to do
while you are cleaning the error paths), including it verbatim here:

This patch removes bitmap_free(idxd->opcap_bmap) after put_device()
in idxd_alloc()'s err_name path and adds a return NULL to prevent
falling through to the err_opcap and err_ida labels, avoiding
double-frees of opcap_bmap, ida, and idxd itself.

> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 4eff74182225..94ce52565e7a 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -635,7 +635,7 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>
>  err_name:
>  	put_device(conf_dev);
> -	bitmap_free(idxd->opcap_bmap);
> +	return NULL;
>  err_opcap:
>  	ida_free(&idxd_ida, idxd->id);
>  err_ida:

The double-free analysis is correct, but does the put_device() above
actually work here?

put_device(conf_dev) drops the refcount from 1 to 0 (no device_add()
was called, so nobody else holds a reference) and triggers the release
callback idxd_conf_device_release(), which does:

  idxd_conf_device_release() {
      destroy_workqueue(idxd->wq);
      ...
  }

At this point in idxd_alloc(), idxd->wq is still NULL -- the
workqueue is created much later in idxd_setup_internals():

  idxd_setup_internals() {
      ...
      idxd->wq = create_workqueue(dev_name(dev));
      ...
  }

destroy_workqueue() does not handle a NULL argument -- it immediately
dereferences the pointer:

  destroy_workqueue(wq) {
      workqueue_sysfs_unregister(wq);
      mutex_lock(&wq->mutex);          <-- NULL dereference
      ...
  }

So put_device() here will oops before the double-free is even
reached. This is a pre-existing issue (the old code has the same
put_device call), but relying on idxd_conf_device_release() as the
cleanup path for a partially-initialized idxd_device doesn't work.

Would it make sense to skip put_device() and instead free only
what was allocated, similar to the err_opcap and err_ida labels?

Two more things worth noting about this series:

Patch 3 (idxd_setup_engines) includes hunks that remove blank lines
from idxd_setup_groups() -- lines that only exist after Patch 2 is
applied. These four patches should probably be sent as a numbered
series with an explicit ordering rather than as independent patches.

The same put_device()-then-kfree() pattern also exists in
idxd_clean_wqs(), idxd_clean_engines(), idxd_clean_groups(), and
idxd_free(), which are not addressed by this series. It might be
worth fixing all of them together.


Cheers,
-- 
Vinicius

