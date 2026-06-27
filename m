Return-Path: <dmaengine+bounces-11824-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SCx+LxIgP2odPAkAu9opvQ
	(envelope-from <dmaengine+bounces-11824-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 02:57:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FADD6D0A7C
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 02:57:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=PRgkwBJb;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11824-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11824-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3724301ABB0
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 00:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9A1EEA54;
	Sat, 27 Jun 2026 00:57:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0591DE8AD;
	Sat, 27 Jun 2026 00:57:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521871; cv=none; b=GAnnfO6GGyhpCa8t9GBfONFlQ6lRb8wQsPpQL/B2EeHifquxWlkYQQSGilNKsm1Ocx4dCjFNv7GabOz0w2TB8euDnSI2W2YhLMLPmqtTLqQv9X5fi45XS75tHwbCWHLWbMrSI3YBm+QLg/q6zDqJCbBG5Wt6MhkMC+MPRYv+w1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521871; c=relaxed/simple;
	bh=X4iuvFpq5z42/rH50xNB+2lcqc4IB6GNJqHdDwAC7cU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KJFbaVNmpE7w3y9X+HE5nTomsgRTbTKOPmBtW7Fze3+yHR9KLN4c6mRAt5NSSqrfL3LDiUlA7+UWdWpC7LBVX03qiAWKIPUkA8i2Dbf4vyG7Ji+y0YKRIY9RqlIRIKwWVaOLe7bqhRcf//cz+VREPyhwDBligGu5LkU6p8PamsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRgkwBJb; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782521870; x=1814057870;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=X4iuvFpq5z42/rH50xNB+2lcqc4IB6GNJqHdDwAC7cU=;
  b=PRgkwBJbeeRywDCXY6JWZdY2Zhp5JVf+gCyM+8xnfZghg6i/RiKuQxUY
   8fM3zkpATuehuYvJWn7XUmcyMKVYh6wtfvlMNGyQeBkNPoCyfqtig2BF8
   oNJnBpcsPfX/bzLISN9CftYX4weKwPFEHu6xpdx7t1vL/Y0BJfY+n9Ink
   0/L8njnNNmEySjAWjhZUFYDgyP6GyiFxbxg4eVT5CVRzscmtRRyeKwLrS
   hhS+QGiveEGFc3ENHoNczZQPaSzvsIJBpLBYy4oPqqy/E4IsraNDunBNa
   L9jPr7GJdywKcTd8Z6JOhtjsz06d3Omn9mAL0qFm51fwzI6Ani5bT0tVm
   Q==;
X-CSE-ConnectionGUID: SkPpW17aShasmAI6AL4l8Q==
X-CSE-MsgGUID: 4257HjbLQpmNtg0ItZ5QSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="83512021"
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; 
   d="scan'208";a="83512021"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 17:57:49 -0700
X-CSE-ConnectionGUID: fvwmoNZ1S4Saf9XAEQ+r2A==
X-CSE-MsgGUID: 4r2AbiKnSpOnkS/0YHVT3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; 
   d="scan'208";a="246992150"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 17:57:48 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Steve Wahl <steve.wahl@hpe.com>, Steve Wahl <steve.wahl@hpe.com>, Dave
 Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, Frank Li
 <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
 bogdan.codres@windriver.com
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: fix duplicate memory frees on
 initialization error path.
In-Reply-To: <20260522203414.336549-2-steve.wahl@hpe.com>
References: <20260522203414.336549-1-steve.wahl@hpe.com>
 <20260522203414.336549-2-steve.wahl@hpe.com>
Date: Fri, 26 Jun 2026 17:57:48 -0700
Message-ID: <87echsiyur.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11824-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:steve.wahl@hpe.com,m:dave.jiang@intel.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rja@hpe.com,m:sivanich@hpe.com,m:bogdan.codres@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,hpe.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FADD6D0A7C

Steve Wahl <steve.wahl@hpe.com> writes:

> Error paths within idxd_pci_probe_alloc and related functions end up
> attempting to free memory already freed from idxd_conf_device_release
> via put_device.
>
> This was encountered running in a kexec'd kdump kernel with reduced
> resources, causing the "Device is HALTED!" branch in
> idxd_device_init_reset to be taken.
>
> In idxd_free and idxd_alloc, do not attempt to free allocations that
> will already have been freed.
>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---

Bogdan Codres series (but submitted a bit later), tries to fix this
issue, has a better splat and a reproducer, I think it makes sense to
add the splat and reproducer here, and add Bogdan as Reported-by (if
agreed, of course).

I am wondering about adding a third patch for the dangling ->wq pointer, as
reported by Sashiko would make sense.

Something like this might do the job (totally untested):

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index f1cfc7790d95..0a74018f31a8 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -415,6 +415,7 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
 	idxd_clean_engines(idxd);
 	idxd_clean_wqs(idxd);
 	destroy_workqueue(idxd->wq);
+	idxd->wq = NULL;
 }

How does it sound?

> v2: split into two patches as requested by Vinicius Costa
>
>  drivers/dma/idxd/init.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index f1cfc7790d95..227e323cc5a0 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -607,9 +607,6 @@ static void idxd_free(struct idxd_device *idxd)
>  		return;
>  
>  	put_device(idxd_confdev(idxd));
> -	bitmap_free(idxd->opcap_bmap);
> -	ida_free(&idxd_ida, idxd->id);
> -	kfree(idxd);
>  }
>  
>  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
> @@ -649,8 +646,13 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
>  	return idxd;
>  
>  err_name:
> +	/*
> +	 * once device_initialize(conf_dev) is called,
> +	 * put_device(conf_dev) will end up calling
> +	 * idxd_conf_device_release() which will free the rest.
> +	 */
>  	put_device(conf_dev);
> -	bitmap_free(idxd->opcap_bmap);
> +	return NULL;
>  err_opcap:
>  	ida_free(&idxd_ida, idxd->id);
>  err_ida:
> -- 
> 2.51.0
>

-- 
Vinicius

