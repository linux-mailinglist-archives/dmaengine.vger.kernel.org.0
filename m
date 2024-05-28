Return-Path: <dmaengine+bounces-2197-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B369C8D213E
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4641C23514
	for <lists+dmaengine@lfdr.de>; Tue, 28 May 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3E6171E6C;
	Tue, 28 May 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbYIw3zi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F532C60;
	Tue, 28 May 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912510; cv=none; b=nwEFIh9zWiMctRGrwxoOn0COii8hP5sDO1jAlAfreWozQ8RIaXpcz5ly/LygMKDTsSjw0MSV9YNF4nyDd6f1NXn7bdV1ObYsaBi7V0j1OEebCr6q2kImeL/88ap5KCFe7qL+AwfVFdydPrQ9p0g3DedYWZGsyy5M01VzYRRICVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912510; c=relaxed/simple;
	bh=sy28UyA1Z9nAsKXnFVtW4DjGYuNsglWfo2Z5ihJ2kko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4kuCRUec+xf44St901kaY6wTKwAjTplyNl6U5MimK+xeFH1Al/FaqPdKXLkL4DzbvTAh398kYeUmpGEDVuCLC9L1LJ9oI6QUkcmENzckzQ56fUkXzwefoiIqnxwPt7/0kBmJ4+t44t1rGsxGmJDJbnudNn11TlokyeYSgGhfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbYIw3zi; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716912509; x=1748448509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sy28UyA1Z9nAsKXnFVtW4DjGYuNsglWfo2Z5ihJ2kko=;
  b=jbYIw3zinoKjz4Nr3uXisRD4s7jjASzYX6o/hd3x+XKANbuC2lPw1N3j
   mxsIbRKZEAC+HUOP5A0A6vG2Z4MioK656glnMTZubdvcDfp1hxfrFtDKI
   iSc1FCzpsIM36AOKDIlA95AwmwDJscFBufpY5zCifV3B2tMQiLZykOlTo
   JuOyTjbjcfs9VGKynIdbVqWZtQFus7GaIRpc/LfQ0ekhwhLQHmFbvhVlb
   orUtNc8eO03iE3+VZoi6l2PMOsxmPo52AoZmMLWjpJhdp6sPIyY6z42Fo
   WDsz4W5IujVtGB6HITHW0LEOSvSliszI89pFEYFnIfU3zE7zZVyYDVvrn
   Q==;
X-CSE-ConnectionGUID: I7GEJfr1QhWdknWotClIew==
X-CSE-MsgGUID: D9lZsJF2RGG6p1YTCuFPlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24397439"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="24397439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 09:08:28 -0700
X-CSE-ConnectionGUID: 6buhvu1HQtmmxZ4l/ht5Wg==
X-CSE-MsgGUID: mJA3CBa+QfCI9+JfLKAp0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35067472"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.9]) ([10.125.111.9])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 09:08:29 -0700
Message-ID: <e3ec5070-abb7-4adc-9cd1-c459ca27b531@intel.com>
Date: Tue, 28 May 2024 09:08:09 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dmaengine: ioatdma: Fix mem leakage series
To: n.shubin@yadro.com, Vinod Koul <vkoul@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Nikita Shubin <nikita.shubin@maquefel.me>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@yadro.com
References: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240528-ioatdma-fixes-v2-0-a9f2fbe26ab1@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/27/24 11:09 PM, Nikita Shubin via B4 Relay wrote:
> Started with observing leakage in patch 3, investigating revealed much
> more problems in probing error path.
> 
> Andy you are always welcome to review if you have a spare time.
> 
> Thank you Andy and Markus for your comments.
> 
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> Changes in v2:
> - dmaengine: ioatdma: Fix error path in ioat3_dma_probe():
>   Markus:
>     - fix typo
> 
> - dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
>   Andy:
>     - s/int/unsigned int/
>     - fix spelling errors
>     - trimmed kmemleak reports
> 
> - Link to v1: https://lore.kernel.org/r/20240524-ioatdma-fixes-v1-0-b785f1f7accc@yadro.com
> 
> ---
> Nikita Shubin (3):
>       dmaengine: ioatdma: Fix leaking on version mismatch
>       dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
>       dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
> 
>  drivers/dma/ioat/init.c | 54 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
> ---
> base-commit: 6d69b6c12fce479fde7bc06f686212451688a102
> change-id: 20240524-ioatdma-fixes-a8fccda9bd79

Thanks for the fixes. 

Reviewed-by: Dave Jiang <dave.jiang@intel.com> for the series

Would be nice if someone wants to move everything to the devm_* management APIs. Would make this a lot less messy. Probably not worth the effort though given how old the driver is and no more devices are being created to use this driver. 

> 
> Best regards,

