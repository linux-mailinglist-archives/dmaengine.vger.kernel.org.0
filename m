Return-Path: <dmaengine+bounces-1854-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0008A7465
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 21:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77ABA282367
	for <lists+dmaengine@lfdr.de>; Tue, 16 Apr 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42A6137915;
	Tue, 16 Apr 2024 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uz67Q/fi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DE1C06;
	Tue, 16 Apr 2024 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294726; cv=none; b=CqVAelL4ji9X8vYwVk9YR0ifL84k6Lk+EdsfeUDgUwqgWCa+Yq+KhhlwR6WR3R0dY4he20xi2TDvQYa0xX5U313ebm8UDHcbhbO9bDD8FnYrVoh7BNqF8UvmfpVOjxjJF17LMAvJxm1/aUM3YDPjrLSwUnhqHptSzelrSZxhAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294726; c=relaxed/simple;
	bh=mZybZTymNAH3f/Y7Sm/uomKl1Kzz3zrHXsOi8TFOrSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0cWJhwpPJR4S8j5PqEGAY8i0Y4+5AcjG3L+RnR3PUuOX3xwlxij/ezWgx8NAAN6czXOdNu5B5mT2YiNduGF4plAx+9LHzNHKhg32Rt/qAGbT6OF3OLBKNAbRudULQVA9gvkonNQbgzpyKDKfW1KFOsa1kYtC5WczAS7Mdv0t9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uz67Q/fi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713294725; x=1744830725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mZybZTymNAH3f/Y7Sm/uomKl1Kzz3zrHXsOi8TFOrSg=;
  b=Uz67Q/fiXDSPTZui85Tad96vJh1rvGianWISmpgFNCKvzudbgo4qb16M
   LiKSdNR2qbneOocXiaH1NJDkOuYZXtNCm0j9zpqb6352MjGaxIa13jmwi
   H3gKV4lwq11EZjLpqbrCf3GyGZqo4uirCp+p5hNrCeD4cDeGCldMqR3B4
   hKUBw0ih8QFfuvyYdFKq2+QZK+KFD9tobNQMr5wt92jx3Q8oSaFukVKwt
   umSg7MaCaCNjeY491ny3c1HQZmXNxPJFSu4k6Aogq+5lR3s2zk7U82sXc
   HqVO9PT+h9fQ+LVDxN4bweXnnAjKxdiR6/xZLyETg1+HQst2UvI/4uOl1
   w==;
X-CSE-ConnectionGUID: Iew+M3R9ThW03IKiDGl5mg==
X-CSE-MsgGUID: U5z2Mt7iRkOrnUQ9bB+Azw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19361165"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="19361165"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:12:04 -0700
X-CSE-ConnectionGUID: 5DQQbClPQzqkC6bnxu5n2A==
X-CSE-MsgGUID: b5J4/MNyQ224oZL0/EWcyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22952611"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 12:12:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwoDn-00000004nfK-09tW;
	Tue, 16 Apr 2024 22:11:59 +0300
Date: Tue, 16 Apr 2024 22:11:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: dw: Simplify max-burst calculation
 procedure
Message-ID: <Zh7NfmffgSBSjVWv@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-5-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416162908.24180-5-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 07:28:58PM +0300, Serge Semin wrote:
> In order to have a more coherent DW AHB DMA slave configuration method
> let's simplify the source and destination channel max-burst calculation
> procedure:
> 
> 1. Create the max-burst verification method as it has been just done for
> the memory and peripheral address widths. Thus the DWC DMA slave config

dwc_config() method

?

> method will turn to a set of the verification methods execution.
> 
> 2. Since both the generic DW AHB DMA and Intel DMA32 engines support the

"i" in iDMA 32-bit stands for "integrated", so 'Intel iDMA 32-bit'

> power-of-2 bursts only, then the specified by the client driver max-burst
> values can be converted to being power-of-2 right in the max-burst
> verification method.
> 
> 3. Since max-burst encoded value is required on the CTL_LO fields
> calculation stage, the encode_maxburst() callback can be easily dropped
> from the dw_dma structure meanwhile the encoding procedure will be
> executed right in the CTL_LO register value calculation.
> 
> Thus the update will provide the next positive effects: the internal
> DMA-slave config structure will contain only the real DMA-transfer config
> value, which will be encoded to the DMA-controller register fields only
> when it's required on the buffer mapping; the redundant encode_maxburst()
> callback will be dropped simplifying the internal HW-abstraction API;
> DWC-config method will look more readable executing the verification

dwc_config() method

?

> functions one-by-one.

...

> +static void dwc_verify_maxburst(struct dma_chan *chan)

It's inconsistent to the rest of _verify methods. It doesn't verify as it
doesn't return anything. Make it int or rename the function.

> +{
> +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> +
> +	dwc->dma_sconfig.src_maxburst =
> +		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
> +	dwc->dma_sconfig.dst_maxburst =
> +		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
> +
> +	dwc->dma_sconfig.src_maxburst =
> +		rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
> +	dwc->dma_sconfig.dst_maxburst =
> +		rounddown_pow_of_two(dwc->dma_sconfig.dst_maxburst);
> +}

...

>  static int dwc_verify_p_buswidth(struct dma_chan *chan)
> -		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
> +		reg_burst = dwc->dma_sconfig.src_maxburst;

Seems you have a dependency, need a comment below that maxburst has to be
"verified" [whatever] first.

...

> +static inline u8 dw_dma_encode_maxburst(u32 maxburst)
> +{
> +	/*
> +	 * Fix burst size according to dw_dmac. We need to convert them as:
> +	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
> +	 */
> +	return maxburst > 1 ? fls(maxburst) - 2 : 0;
> +}

Split these moves to another preparatory patch.

-- 
With Best Regards,
Andy Shevchenko



