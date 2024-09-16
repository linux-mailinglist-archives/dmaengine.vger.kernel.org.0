Return-Path: <dmaengine+bounces-3169-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A048297A07D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 13:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2197C1F22BF8
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F47156861;
	Mon, 16 Sep 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1oOAFJs"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4D155CB3;
	Mon, 16 Sep 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487150; cv=none; b=WI9W8G59rDawXMBF34UbHkcJdGEHd1eVnCB56DWzN4T9BXlrfxMlm73XA1NQZHV86mTIia0f6x+io0a/WGJ2lFNnHwnnSflHLhK1XzHvvE3VqbtZsLOPQ+wHNmO/ViQ4S3NV1Ojegnwdy/j+2Jhc8VjUhZMYIbQrF2Qf3p05RQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487150; c=relaxed/simple;
	bh=CYYX9hhNqo9jzs81OXJ6/MzvvlcaDJ3F5mh1yoXF5Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c16LWEki0mIbTsAojRDqnq9yPRjckZpQMBnVLboXo0MPUAwCcq7kZk481EOkQ/BgxYpIChbz7QzXaBFhouQAz26s5Jq5j1OsdvMpQucHLDKjnbo/AVoeJuOGLrX/IColKA8SndIz5D2ibTiS7deMdnib4ghpa5x+QlttGasUBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1oOAFJs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726487149; x=1758023149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYYX9hhNqo9jzs81OXJ6/MzvvlcaDJ3F5mh1yoXF5Pk=;
  b=g1oOAFJsvbeslVo31v1/dvMI1UXS0c/0/ondxQs6i3rZOlOZ0qLefZvZ
   6yuyjl/xfu18XzSkKAnVchwRHE//UvzTNsUKXGfA6x3/COKE4whyGJZYH
   Ll0Wr1DqjcIkkTl6Mb6uVbudKpStDVJXJ7ZQnHmCpoV4HHZ2jy3Gxqeg6
   rCMW0WkYXY0oumRXNVkR2xHCNuYbHYle+lph7qOGa46p445S5B0/Y155g
   AweioBHnmUCPx0NKEnu3kN5fAJE1//MGcTQQ2q8nBVv86ulqhd8khMyIa
   iFXjeEvvHWHxDQ/abN3Mfwm3Wgq2KXO6uNOYsaqqC5DIt1I8TmAY7+P9D
   w==;
X-CSE-ConnectionGUID: JQVDP58FQKWlU+3LEIUCPw==
X-CSE-MsgGUID: 8lvgA7mLTC+rUigur1JBTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="36442079"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="36442079"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 04:45:47 -0700
X-CSE-ConnectionGUID: /NP8C+OJS2+eqddsddhAHg==
X-CSE-MsgGUID: 0uSTNtsoRCupqBZhoMe0Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="69154009"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 04:45:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqAAn-00000009RYg-2iuI;
	Mon, 16 Sep 2024 14:45:41 +0300
Date: Mon, 16 Sep 2024 14:45:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Ferry Toth <ftoth@exalondelft.nl>, Viresh Kumar <vireshk@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/6] dmaengine: dw: Add peripheral bus width
 verification
Message-ID: <ZugaZbSIFqUujD5r@smile.fi.intel.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <20240802075100.6475-2-fancer.lancer@gmail.com>
 <ZuXgI-VcHpMgbZ91@black.fi.intel.com>
 <wghwkx6xbkwxff5wbi2erdl2z3fmjdl54qqb3rfty7oiabvk7h@3vpzlkjataor>
 <ZugZ9NcnPMNTH_ZQ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZugZ9NcnPMNTH_ZQ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 16, 2024 at 02:43:48PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 14, 2024 at 10:22:22PM +0300, Serge Semin wrote:
> > On Sat, Sep 14, 2024 at 10:12:35PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 02, 2024 at 10:50:46AM +0300, Serge Semin wrote:
> > > > Currently the src_addr_width and dst_addr_width fields of the
> > > > dma_slave_config structure are mapped to the CTLx.SRC_TR_WIDTH and
> > > > CTLx.DST_TR_WIDTH fields of the peripheral bus side in order to have the
> > > > properly aligned data passed to the target device. It's done just by
> > > > converting the passed peripheral bus width to the encoded value using the
> > > > __ffs() function. This implementation has several problematic sides:
> > > > 
> > > > 1. __ffs() is undefined if no bit exist in the passed value. Thus if the
> > > > specified addr-width is DMA_SLAVE_BUSWIDTH_UNDEFINED, __ffs() may return
> > > > unexpected value depending on the platform-specific implementation.
> > > > 
> > > > 2. DW AHB DMA-engine permits having the power-of-2 transfer width limited
> > > > by the DMAH_Mk_HDATA_WIDTH IP-core synthesize parameter. Specifying
> > > > bus-width out of that constraints scope will definitely cause unexpected
> > > > result since the destination reg will be only partly touched than the
> > > > client driver implied.
> > > > 
> > > > Let's fix all of that by adding the peripheral bus width verification
> > > > method and calling it in dwc_config() which is supposed to be executed
> > > > before preparing any transfer. The new method will make sure that the
> > > > passed source or destination address width is valid and if undefined then
> > > > the driver will just fallback to the 1-byte width transfer.
> > > 
> > > This patch broke Intel Merrifield iDMA32 + SPI PXA2xx configuration to
> > > me. Since it's first in the series and most likely the rest is
> > > dependent and we are almost at the release date I propose to roll back
> > > and start again after v6.12-rc1 will be out. Vinod, can we revert the
> > > entire series, please?
> > 
> > I guess it's not the best option, since the patch has already been
> > backported to the stable kernels anyway. Rolling back it from all of
> > them seems tiresome. Let's at least try to fix the just discovered
> > problem?
> 
> Please, provide one we can test!
> 
> > Could you please provide more details about what exactly happening?
> 
> Sure. AFAICT the only problematic line is this:
> 
>         else if (!is_power_of_2(reg_width) || reg_width > max_width)
> 
> in your patch, and it may trigger, for example, when max_width == 0.
> This, in accordance with my brief investigation, happens due to the following.
> 
> The DMA slave configuration is being copied twice in DW DMA code:
> 1) when respective filter function triggers (see acpi/of glue code);
> 2) when the channel is about to be allocated.
> 
> The iDMA32 has only a single master, and hence m_master == p_master,
> BUT the filter function in the acpi code is universal and it copies
> the wrong (from the iDMA32 perspective) value to p_master.
> As the result, when you retrieve the max_width, it takes the value from
> p_master, which is defined to 1 (sic!), and hence assigns it to 0.
> 
> I don't know how to quickfix this as the proper fix seems to provide
> the correct data in the first place.
> 
> Any ideas, patches we may test?

P.S. for your advocacy it seems that your change actually revealed an
inconsistency in the existing code. But still, it made a regression.

-- 
With Best Regards,
Andy Shevchenko



