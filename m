Return-Path: <dmaengine+bounces-516-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAC1811C73
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 19:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B935B1F218BC
	for <lists+dmaengine@lfdr.de>; Wed, 13 Dec 2023 18:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1459533;
	Wed, 13 Dec 2023 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6m+w4nQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9478DF2;
	Wed, 13 Dec 2023 10:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702492127; x=1734028127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Iixiy3lpwH6hkXLSCKzUJWx2sVNb5UeaxLaBRkE5tE=;
  b=P6m+w4nQyzFZSp8qWws6KpmkEcFJgmL1KRD1akY1zsKWL7+UevuGdvKl
   8qHU+zVZy349ZGgo8nhyyO2XvWl2ruLTCUsBEaTXSHQ9PDwBoB1tP91QH
   NM/Ktbgg3P88RSksI0ifr+hEgX0c13S/mKkrSfczZZ85IBdJgJ32fti0n
   lcqv14eNphljCTnptT11Jw4DZRMY7fMR4GC9TdIVhQakyt53/v6zUnWYl
   ZWX5Hsog9tSBJJkc/7zb61BK6Zf7W4s3cxzc7njqUiDU4CGLdGsgVPm0C
   ZD9GOLIENnqc7SuQze1l4aIdLqykm4JLgyeJmuDhWS7WczoyDKShbfsxx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13705869"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="13705869"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:28:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="839985114"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="839985114"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:28:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rDTyM-00000005blx-0oTq;
	Wed, 13 Dec 2023 20:28:42 +0200
Date: Wed, 13 Dec 2023 20:28:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 10/40] dma: cirrus: Convert to DT for Cirrus EP93xx
Message-ID: <ZXn32V0giIF754jR@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-10-c307b8ac9aa8@maquefel.me>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-10-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 12, 2023 at 11:20:27AM +0300, Nikita Shubin wrote:
> Convert Cirrus EP93xx DMA to device tree usage:
> 
> - add OF ID match table with data
> - add of_probe for device tree
> - add xlate for m2m/m2p
> - drop subsys_initcall code
> - drop platform probe
> - drop platform structs usage
> 
> >From now only it supports only device tree probing.

"From now on it only..." (and single "only" is enough).

...

> +		edmac->clk = devm_clk_get(dev, dma_clk_name);
>  		if (IS_ERR(edmac->clk)) {
> +			dev_warn(dev, "failed to get clock\n");
>  			continue;
>  		}

This is incorrect, it doesn't handle deferred probe in two aspects:
- spamming the logs;
- not really trying to reprobe.

...

> +static bool ep93xx_m2p_dma_filter(struct dma_chan *chan, void *filter_param)
> +{
> +	struct ep93xx_dma_chan *echan = to_ep93xx_dma_chan(chan);
> +	struct ep93xx_dma_chan_cfg *cfg = filter_param;
> +
> +	if (cfg->dir == ep93xx_dma_chan_direction(chan)) {
> +		echan->dma_cfg = *cfg;
> +		return true;
> +	}
> +
> +	return false;

Perhaps

	if (cfg->dir != ep93xx_dma_chan_direction(chan))
		return false;

	echan->dma_cfg = *cfg;
	return true;

> +}

...

> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +

One blank line is enough.

...

> +	switch (port) {
> +	case EP93XX_DMA_SSP:
> +	case EP93XX_DMA_IDE:
> +		break;
> +	default:
> +		return NULL;
> +	}

> +	if (!is_slave_direction(direction))
> +		return NULL;

This can be performed before switch, no?

...

> +#include <linux/device.h>
> +#include <linux/property.h>
> +#include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>

Perhaps make it a bit more ordered by squeezing to the (most) ordered parts?

-- 
With Best Regards,
Andy Shevchenko



