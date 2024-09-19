Return-Path: <dmaengine+bounces-3190-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D927E97CB7A
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4DB286370
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09281A0733;
	Thu, 19 Sep 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJUGnVw6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA491DDC9;
	Thu, 19 Sep 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758890; cv=none; b=gZwZ82VULaAIgakp8LDif/NZu3I/54X5alSLrxKIlem50jX4oGZpbOBE7CtKV1WiksMvnC692w9IS5fFETsfb9UvzsSQ7HN9x0jox5KEPsInENw91Ux4WnGqV93j8853R9O5VeAvZ3lmOdkFi+jm4SJB2RO/11Rh6eaZxFX9C74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758890; c=relaxed/simple;
	bh=bs/WrVjBQrZpossCbAukjZW6SEcrlcT90cEERdte3RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTL4C7phfwX9LnG+u2vCN+OlYUHeeQwdsx4NuT24kHMuVXJYO60cnOac//95yK4lKpbyc2KJdTVfwaSKbwgv9FJP1O0a9LYSxHBNKx2J3fStWZLCD3glE9oJVNnblbYfhonv6T9M2viMcP2VuAwsmXkGr/4m/c2CekbHHP5O6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJUGnVw6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726758853; x=1758294853;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bs/WrVjBQrZpossCbAukjZW6SEcrlcT90cEERdte3RA=;
  b=aJUGnVw6VPJWaF7gQFzc+2q/zJa5zBGPv4PLpPzRrg7+7VjcMEBDpQEE
   Pd+PNw+/OQzAHeFweJtxyXKEbr1Y21yodkPJyONXFHHSQ0p1D9ivClaLk
   ho/JTv6a+qDKy4Zw17vleNqThFEb6r9hjIvUlYSpJvq941u3rauJCZ6U1
   SPXx0Ar1hPJulZ5izCV7PCbymiOX2lUFo4MLH4BTq7mLU5VAThSN94occ
   bdmVqfgMxpTbxeJ03RUsV8kJcuzM0/B5wWKaF068ZzF9JapG6ffBcE7wL
   bRteINIJmwW1dQweyeQibiZ3XzNmeFZbkoSEad3tLSUwLIMHKi60+QcPe
   Q==;
X-CSE-ConnectionGUID: QvchbXdWTjS2ckPH+CpzKQ==
X-CSE-MsgGUID: 2mqlaZFPS7uCdwI+9rJLtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="13593856"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="13593856"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 08:14:11 -0700
X-CSE-ConnectionGUID: LTcZlT2rRB6VDUUi6LdloQ==
X-CSE-MsgGUID: Rb9g5FT1SbWSKfDr5Mpv8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="100799247"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 08:14:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srIr9-0000000AZL5-0Bnp;
	Thu, 19 Sep 2024 18:14:07 +0300
Date: Thu, 19 Sep 2024 18:14:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ferry Toth <fntoth@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw: Select only supported masters for ACPI
 devices
Message-ID: <Zuw_vllDMRKD-sC8@smile.fi.intel.com>
References: <20240919135854.16124-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240919135854.16124-1-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 19, 2024 at 04:58:14PM +0300, Serge Semin wrote:
> The recently submitted fix-commit revealed a problem in the iDMA32
> platform code. Even though the controller supported only a single master
> the dw_dma_acpi_filter() method hard-coded two master interfaces with IDs
> 0 and 1. As a result the sanity check implemented in the commit
> b336268dde75 ("dmaengine: dw: Add peripheral bus width verification") got
> incorrect interface data width and thus prevented the client drivers
> from configuring the DMA-channel with the EINVAL error returned. E.g. the
> next error was printed for the PXA2xx SPI controller driver trying to
> configure the requested channels:
> 
> > [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
> > [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
> > [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16
> 
> The problem would have been spotted much earlier if the iDMA32 controller
> supported more than one master interfaces. But since it supports just a
> single master and the iDMA32-specific code just ignores the master IDs in
> the CTLLO preparation method, the issue has been gone unnoticed so far.
> 
> Fix the problem by specifying a single master ID for both memory and
> peripheral devices on the ACPI-based platforms if there is only one master
> available on the controller. Thus the issue noticed for the iDMA32
> controllers will be eliminated and the ACPI-probed DW DMA controllers will
> be configured with the correct master ID by default.

...

>  static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
>  {
> +	struct dw_dma *dw = to_dw_dma(chan->device);
>  	struct acpi_dma_spec *dma_spec = param;
>  	struct dw_dma_slave slave = {
>  		.dma_dev = dma_spec->dev,
>  		.src_id = dma_spec->slave_id,
>  		.dst_id = dma_spec->slave_id,
>  		.m_master = 0,
> -		.p_master = 1,

I would leave this line as is and it makes more consistent in my opinion with
the below comments which starts with the words "Fallback to...".

>  	};
>  
> +	/*
> +	 * Fallback to using a single interface for both memory and peripheral
> +	 * device if there is only one master I/F supported (e.g. iDMA32)
> +	 */
> +	if (dw->pdata->nr_masters == 0)

Why '== 0' and not '== 1'? Or '>= 2' if you wish to be on the save side (however,
that '== 0' case is not obvious to me — do we really have that IRL?).

> +		slave.p_master = 0;
> +	else
> +		slave.p_master = 1;

> +
> +

One blank line is enough.

>  	return dw_dma_filter(chan, &slave);
>  }

...

P.S. I'll test it later this or next week, if Ferry wouldn't beat me up to it.

-- 
With Best Regards,
Andy Shevchenko



