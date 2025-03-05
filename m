Return-Path: <dmaengine+bounces-4651-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21795A53E43
	for <lists+dmaengine@lfdr.de>; Thu,  6 Mar 2025 00:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9B43A3E45
	for <lists+dmaengine@lfdr.de>; Wed,  5 Mar 2025 23:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5C920767E;
	Wed,  5 Mar 2025 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PQEfA9cG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963820765F;
	Wed,  5 Mar 2025 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216460; cv=none; b=onzhBFVFFiPWsPbTCZfchl5XWBW24VEfb+aJuPBhGn53nvc63uttis9SNW8b07qMVhUWEktC/Hq4j54ZkQ9rf1rF44e1bGaWAp8bc3nCTcbfq2ZpephYm/6u87Y8P0HXVMD4B2b5DkeDWKGfidAc4+i/19bm2pfhCUPomPy29YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216460; c=relaxed/simple;
	bh=v+2doInhu++HPJbVs0+/6707C/+cBpinH/glcBW/Xpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vvwe/uLaY1X1AY9m7fNqrfzEMgxXcH24NiiVYIvSyKy9wCFImjNqPjIYPoavcFKIVtnvzUNI2AU6qfhPnaUlFDX23WIIOWVHn5C1z35YXMyY8g6fF25A3MXj0nC9TmSDxLdAkPAzVKwlRwcwyEP7M43OdQK06nzrC5kwl8wn7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PQEfA9cG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741216459; x=1772752459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v+2doInhu++HPJbVs0+/6707C/+cBpinH/glcBW/Xpw=;
  b=PQEfA9cGI1n0xHodVXGDR9BudrTgOoNdZ1l9tv184BRXToH4dzyDp9kG
   8YVS3Htg4g39mX/CRe33tRrYFhc9Bx/KkCKh3esAv2508tbPeSVrY/gfp
   mPWOvJlZirl9msB2KtI8umZ7Dml78RxesonPpUZxcWxVSqLE0Vp2vNz++
   c34VCx5+c9wtEtsA4+oxQulHptcDtVLpDqFutN+puNesGR6bQvpUb0NXh
   BT2FIKPAYbRKMHNBpkpRvZHrR7dhJARM1Kf658PDBomgf2nMmqUU/1/fL
   lto7gX1xriM+ENTdha1znp2tAfVJrK8HfVhGLO2walJRd7LEuiYzi5KYv
   g==;
X-CSE-ConnectionGUID: bonqQkpnQ1masub2wn4h3w==
X-CSE-MsgGUID: GABeWXiDQHy6LSyPavAbrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41382366"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="41382366"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:14:18 -0800
X-CSE-ConnectionGUID: WKoPl6eHRuWNIBQ3a2yk5w==
X-CSE-MsgGUID: xwxzjjBCRjO+dQCcZ5gLvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123423305"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.222]) ([10.125.109.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 15:14:18 -0800
Message-ID: <3dc1c3cb-b19a-4fa5-86b9-0862a96418d1@intel.com>
Date: Wed, 5 Mar 2025 16:14:15 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dmaengine: dmatest: Fix dmatest waiting less when
 interrupted
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kristen.c.accardi@intel.com, kernel test robot <oliver.sang@intel.com>
References: <20250305230007.590178-1-vinicius.gomes@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250305230007.590178-1-vinicius.gomes@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/25 4:00 PM, Vinicius Costa Gomes wrote:
> Change the "wait for operation finish" logic to take interrupts into
> account.
> 
> When using dmatest with idxd DMA engine, it's possible that during
> longer tests, the interrupt notifying the finish of an operation
> happens during wait_event_freezable_timeout(), which causes dmatest to
> cleanup all the resources, some of which might still be in use.
> 
> This fix ensures that the wait logic correctly handles interrupts,
> preventing premature cleanup of resources.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202502171134.8c403348-lkp@intel.com
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/dmatest.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index 91b2fbc0b864..d891dfca358e 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -841,9 +841,9 @@ static int dmatest_func(void *data)
>  		} else {
>  			dma_async_issue_pending(chan);
>  
> -			wait_event_freezable_timeout(thread->done_wait,
> -					done->done,
> -					msecs_to_jiffies(params->timeout));
> +			wait_event_timeout(thread->done_wait,
> +					   done->done,
> +					   msecs_to_jiffies(params->timeout));
>  
>  			status = dma_async_is_tx_complete(chan, cookie, NULL,
>  							  NULL);


