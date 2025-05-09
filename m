Return-Path: <dmaengine+bounces-5120-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA66AB06F4
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 02:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D53E1BC6B94
	for <lists+dmaengine@lfdr.de>; Fri,  9 May 2025 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D836D;
	Fri,  9 May 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLrag98s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2A2647;
	Fri,  9 May 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746749227; cv=none; b=BYYpzqRdcs/ghk9hn7fJvuAqAUBNJtncW6+qJyyNYcjsNJE9uashq5PvHgSbiOmgrB+b6Osdki0LjGm3KVz8jskRtldnbNQ9Q+4XTvurNVkY41NXG5/diaG3JV8QFlzvtSNhjv/qKKnRjGBLrk2XMTop2iCxCUUbvxhxR0BlZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746749227; c=relaxed/simple;
	bh=kc1Y6s/Ju4UDPwXHo/o7G+bO27dUPGilmlAMLVzzviE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8FhkuLXZmFrL/YLVJy+l4uuytpa798zcvQabMN32scXzmDfFCsyno6whTaP2C5ePoAdikUwrBTv+x15O3u6AJ7ek6X/azsFjwZq81pzYaXAsjdw24dN8okDTsq+gFXZ0WAUjQ5EX+dob9ANRnuFMxjpvk2Gh5Ot8IoZb1aqO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLrag98s; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746749225; x=1778285225;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kc1Y6s/Ju4UDPwXHo/o7G+bO27dUPGilmlAMLVzzviE=;
  b=dLrag98sdzRX1JPj48BlDdYXJRWhmM5O3Vihg7u9SOJD4iqO2Hg7egFB
   jAWG2s9SBlBozdQ7k7MDR5vME6ibu8hA3ggwKH5jHQd/rPsas+gYbo0u0
   5ih8iu9CuWolBwgTnoc0n5Du6+loDppyDRzUOaOMtXxXS+d//EnZAKEpR
   uNZXn8UQ3Kj/33C/BN6DSyCokN0ecwJEBMn9a89SWWM8H0qSF/HzRnag7
   JczmgeTnGCMKN35fPNULWeIbasrr9jI1holQD5udrNWdHuOjSnrblVMFn
   EGgxGw5SY7g66NXtzLbFfgy0h+aLmC866CoyWNB6AvXP7FltDc9/e7+Zn
   Q==;
X-CSE-ConnectionGUID: NckAT1o2QdiOouI0RWjQ7g==
X-CSE-MsgGUID: fL46eBBVRK2jQLbmxRZaGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59960314"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="59960314"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 17:07:04 -0700
X-CSE-ConnectionGUID: cxKra4vbQiGpj1ExdLFrpg==
X-CSE-MsgGUID: O9NtmCFiQaa+f7kTX63AHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="167522922"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.128]) ([10.125.108.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 17:07:04 -0700
Message-ID: <b54baf68-5c4e-4cad-93c8-560195d063e7@intel.com>
Date: Thu, 8 May 2025 17:07:02 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Check availability of workqueue
 allocated by idxd wq driver before using
To: Yi Sun <yi.sun@intel.com>, vinicius.gomes@intel.com,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: anil.s.keshavamurthy@intel.com, gordon.jin@intel.com
References: <20250509000304.1402863-1-yi.sun@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250509000304.1402863-1-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/25 5:03 PM, Yi Sun wrote:
> Running IDXD workloads in a container with the /dev directory mounted can
> trigger a call trace or even a kernel panic when the parent process of the
> container is terminated.
> 
> This issue occurs because, under certain configurations, Docker does not
> properly propagate the mount replica back to the original mount point.
> 
> In this case, when the user driver detaches, the WQ is destroyed but it

I would be more specific. wq->wq (workqueue) that is allocated by the cdev user driver during ->probe() is destroyed when the driver is unbound.

> still calls destroy_workqueue() attempting to completes all pending work.
> It's necessary to check wq->wq and skip the drain if it no longer exists.
> 
> Signed-off-by: Yi Sun <yi.sun@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index ff94ee892339..a202fe4937a7 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -349,7 +349,9 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
>  			set_bit(h, evl->bmap);
>  		h = (h + 1) % size;
>  	}
> -	drain_workqueue(wq->wq);
> +	if (wq->wq)
> +		drain_workqueue(wq->wq);
> +
>  	mutex_unlock(&evl->lock);
>  }
>  


