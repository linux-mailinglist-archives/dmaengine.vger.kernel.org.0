Return-Path: <dmaengine+bounces-993-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EFB84FD64
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 21:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941081C2129B
	for <lists+dmaengine@lfdr.de>; Fri,  9 Feb 2024 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E753F84A3D;
	Fri,  9 Feb 2024 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6RRmuXv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA580BFA;
	Fri,  9 Feb 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509851; cv=none; b=CAvAvdntK9NWTph6gwUHA2B6wQQzHRt3lxTNXqv/D8O6AaRLFh8bnyDuR//hm7h81nmWFaz2NMKliSOIjJPhcbUldjTBxKiwrDcy6xSH4PQdIK0V4sbyvCTScGUU7pnsmx//Vh/U+iatv8K80Q6TflvRLovOyKSektTfsu66I0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509851; c=relaxed/simple;
	bh=m4xOEA3wNI35EO0PmV1sH9LQsIloPJsMjTAyAAODgYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmSjhecjdQtrF5rnZOTIxWv9TEsJtuyUgT6Ppkr/nMkEIiEyN7DEc+0XiwhL0z3mu7Bn4CAdI6/uVLUxFHpeK4WEeL3wkk63f01BQDNaRKOmIuBIIkHVDV7YkdUq/XuKke1DUlVKCnKDqfFu7l5FLBq3iMWYPRhJbr4oa68SiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6RRmuXv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707509850; x=1739045850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m4xOEA3wNI35EO0PmV1sH9LQsIloPJsMjTAyAAODgYo=;
  b=E6RRmuXvgnOQOepwIN3pEhHeJOT9gXwGW/EesKD/HXei2GGLb9VYSZJC
   /y9ZQrJ5J2vB/oOICgTlS7bj+oTYw9Fm5m0f9kf0kACgQniSR1fdl3ZiT
   BqNfhJgJAtlydAwFsOzCNH09J8ba8j+ndEpcI8T5dLSJEuBNC2TEsVDA3
   cQ9XPjF/viao2P8Qh8/S64Z+ZbyE+UHOdJ/Dcz+B/uqaPojAWoro9r/cM
   EokqEc7WdTrA6alad8nRfUT5T9YxfnrMQawaw8JWC790me1+sKxO6L1SL
   tfo8bnuGNwMaMLPwRu075z8mDzpu+9eJVKpjD1ubJ8kJtrsZeimbET3DC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="19000632"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="19000632"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2327257"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.114]) ([10.246.112.114])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:17:29 -0800
Message-ID: <36895817-8f71-461a-93e0-5db1a39cd3c4@intel.com>
Date: Fri, 9 Feb 2024 13:17:27 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: idxd: Clear Event Log head in idxd upon
 completion of the Enable Device command
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Lingyan Guo <lingyan.guo@intel.com>
References: <20240209191851.1050501-1-fenghua.yu@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240209191851.1050501-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 12:18 PM, Fenghua Yu wrote:
> If Event Log is supported, upon completion of the Enable Device command,
> the Event Log head in the variable idxd->evl->head should be cleared to
> match the state of the EVLSTATUS register. But the variable is not reset
> currently, leading mismatch of the variable and the register state.
> The mismatch causes incorrect processing of Event Log entries.
> 
> Fix the issue by clearing the variable after completion of the command.

Should this be done in idxd_device_clear_state() instead?

> 
> Fixes: 2f431ba908d2 ("dmaengine: idxd: add interrupt handling for event log")
> Tested-by: Lingyan Guo <lingyan.guo@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/dma/idxd/device.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index ecfdf4a8f1f8..7c9fb9b3e110 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -546,6 +546,14 @@ int idxd_device_enable(struct idxd_device *idxd)
>  		return -ENXIO;
>  	}
>  
> +	/*
> +	 * If Event Log is supported, Event Log Status register was
> +	 * cleared after the Enable Device command. Clear Event Log
> +	 * head value that is stored in idxd to match the register state.
> +	 */
> +	if (idxd->evl)
> +		idxd->evl->head = 0;
> +
>  	idxd->state = IDXD_DEV_ENABLED;
>  	return 0;
>  }

