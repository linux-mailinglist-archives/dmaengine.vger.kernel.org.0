Return-Path: <dmaengine+bounces-8540-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GI6MSnleGlvtwEAu9opvQ
	(envelope-from <dmaengine+bounces-8540-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 17:17:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 408689799C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 17:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ACF3303EFBC
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jan 2026 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185EE2D9488;
	Tue, 27 Jan 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJYXO/EM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731D301474;
	Tue, 27 Jan 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530551; cv=none; b=fYi/Dnn47zG3el87FTu0iFhmMDgm+ggvywDqrTfjnecP8Ncv8eLGViSKzbrY9gCj8ZfO9neNIpScjImECUQRQ8uYWvWWDoVx3tDG8skNFicQsC6yCtAWO5mOqyFTB4nyHgaTYK43ScOg+MgEa28Om/wDw/QpyDvYq4qPnXG9W0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530551; c=relaxed/simple;
	bh=1Fhr+xG2Bpyacm5LgDYQWqyl/48UFNX/NQUncNfDDso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJVv8xW+9O0jxzvtutVxabmN33mK1Cpncv4XWjbjKCvLd18bK+Wg/ZPOL3Ie0xZwHe/Z4kFjU649o7MlGAZA7EVyyGhoTDUYdC24DTWRzz2QTbpHaiZ2orEeWIxMZ4Zl+1YxnBQyykdkY95P7IrOQ71qRqffeffZD8e3SH0gVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJYXO/EM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769530550; x=1801066550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Fhr+xG2Bpyacm5LgDYQWqyl/48UFNX/NQUncNfDDso=;
  b=JJYXO/EMqZJ7RW9AL+HBBlrDoT8TDhZGt6yHMklygZ2dGkyeOKWh6diw
   aFDDRLH2pGlAeO9AT1W8E2B0yoJQatiURNq1kOm/dlBYXKJ0Jw7sEYrhj
   h/W6Jq8G+MpOawuePYjWpHAAP7kOCNKCNKzVeVn5aJK7N3LK5nEDd+L3f
   hflbknyhicEKkEPHtg0iPxqX3pXrjsyfmGD50yG1cmd7hHx9YU3qTXFIx
   4ZuHHLBzTDihm4ELCjzYmvYi7/sQEdI2/P0cJ26/tFOy7t23uVqCBnqT6
   26lvhkwTei9bm67SrjZcPfxfHzkTyV3wSlNC+y0ZCscpDc7qNEKFkulCE
   g==;
X-CSE-ConnectionGUID: lHz+QzbuQLKMiHDV29kJQw==
X-CSE-MsgGUID: mS2v0myrQW2KDXZB0oubSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81035750"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81035750"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:15:49 -0800
X-CSE-ConnectionGUID: Owdcim2mRx63sNv9qy1kLQ==
X-CSE-MsgGUID: c/Bj04rGSFaEVUa4Eg8vOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="230961620"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.136]) ([10.125.109.136])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 08:15:44 -0800
Message-ID: <0053d757-9426-4c40-8ff5-8ddf7ab6d838@intel.com>
Date: Tue, 27 Jan 2026 09:15:43 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] idxd: Fix Intel Data Streaming Accelerator double-free on
 error path
To: Daniel J Blueman <daniel@quora.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Scott Hamilton <scott.hamilton@eviden.com>, stable@vger.kernel.org
References: <20260127075210.3584849-1-daniel@quora.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260127075210.3584849-1-daniel@quora.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8540-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 408689799C
X-Rspamd-Action: no action



On 1/27/26 12:52 AM, Daniel J Blueman wrote:
> During IDXD driver probe unwind from an earlier resource allocation
> failure, multiple use-after-free codepaths are taken leading to attempted
> double-free of ID allocator entries and memory allocations, eg:
> 
> ida_free called for id=64 which is not allocated.
> WARNING: lib/idr.c:594 at ida_free+0x1af/0x1f4, CPU#900: kworker/900:1/11863
> ...
> Call Trace:
> <TASK>
> ? ida_destroy+0x258/0x258
> idxd_pci_probe_alloc+0x342e/0x348c
> ? multi_u64_to_bmap+0xc9/0xc9
> ? queued_read_unlock+0x1e/0x1e
> ? __schedule+0x2e43/0x2ee6
> ? idxd_reset_done+0x12ca/0x12ca
> idxd_pci_probe+0x15/0x17
> ...
> 
> Fix this by releasing these allocations only after use and once.
> 
> Validated on 8 socket and 16 socket (XNC node controller) Intel Saphire
> Rapids XCC systems with no KASAN, Kmemleak or lockdep reports.
> 
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Cc: stable@vger.kernel.org
> 

Can you provide a Fixes tag please?

DJ

> ---
>  drivers/dma/idxd/init.c  | 21 +--------------------
>  drivers/dma/idxd/sysfs.c |  1 -
>  2 files changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 2acc34b3daff..5d2b869df745 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -167,13 +167,9 @@ static void idxd_clean_wqs(struct idxd_device *idxd)
>  		wq = idxd->wqs[i];
>  		if (idxd->hw.wq_cap.op_config)
>  			bitmap_free(wq->opcap_bmap);
> -		kfree(wq->wqcfg);
>  		conf_dev = wq_confdev(wq);
>  		put_device(conf_dev);
> -		kfree(wq);
>  	}
> -	bitmap_free(idxd->wq_enable_map);
> -	kfree(idxd->wqs);
>  }
>  
>  static int idxd_setup_wqs(struct idxd_device *idxd)
> @@ -277,9 +273,7 @@ static void idxd_clean_engines(struct idxd_device *idxd)
>  		engine = idxd->engines[i];
>  		conf_dev = engine_confdev(engine);
>  		put_device(conf_dev);
> -		kfree(engine);
>  	}
> -	kfree(idxd->engines);
>  }
>  
>  static int idxd_setup_engines(struct idxd_device *idxd)
> @@ -341,9 +335,7 @@ static void idxd_clean_groups(struct idxd_device *idxd)
>  	for (i = 0; i < idxd->max_groups; i++) {
>  		group = idxd->groups[i];
>  		put_device(group_confdev(group));
> -		kfree(group);
>  	}
> -	kfree(idxd->groups);
>  }
>  
>  static int idxd_setup_groups(struct idxd_device *idxd)
> @@ -590,17 +582,6 @@ static void idxd_read_caps(struct idxd_device *idxd)
>  		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
>  }
>  
> -static void idxd_free(struct idxd_device *idxd)
> -{
> -	if (!idxd)
> -		return;
> -
> -	put_device(idxd_confdev(idxd));
> -	bitmap_free(idxd->opcap_bmap);
> -	ida_free(&idxd_ida, idxd->id);
> -	kfree(idxd);
> -}
> -
>  static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1239,7 +1220,7 @@ int idxd_pci_probe_alloc(struct idxd_device *idxd, struct pci_dev *pdev,
>   err:
>  	pci_iounmap(pdev, idxd->reg_base);
>   err_iomap:
> -	idxd_free(idxd);
> +	put_device(idxd_confdev(idxd));
>   err_idxd_alloc:
>  	pci_disable_device(pdev);
>  	return rc;
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 9f0701021af0..819f2024ba0b 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1818,7 +1818,6 @@ static void idxd_conf_device_release(struct device *dev)
>  	kfree(idxd->engines);
>  	kfree(idxd->evl);
>  	kmem_cache_destroy(idxd->evl_cache);
> -	ida_free(&idxd_ida, idxd->id);
>  	bitmap_free(idxd->opcap_bmap);
>  	kfree(idxd);
>  }


