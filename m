Return-Path: <dmaengine+bounces-1887-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC828A968A
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 11:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB9D1C21839
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBB615B0F5;
	Thu, 18 Apr 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljztmPpK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CB15B104;
	Thu, 18 Apr 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433473; cv=none; b=qVAJTFhJdb7P0OzvPqzf1HUyFsDAGhwOH95oqNOsyeO3sOoxbwX4hwa6LRETjUUd4JsYrkVDDWHEECtdJNba1AN0H22CoCFgHgl3kkEMYD42toxj5mJtzQLPw2kXdvNPICM8GRmwPwKNh9nUHIIr2FLapJ5ya/iMfsP3L6UuloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433473; c=relaxed/simple;
	bh=Almhm7EmJOze8Bt25QP+KeiGORDpSLyCg+DsR0jsOXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJjc4YHNnLXQHN0sncMiTuYkZRIsIJIYdG0gVV+gFGJ9IQyoi+XYzpPUIKKdTRKWWkanwII1131Agzu2A3zq4/DToLt8SE8GWsmPRgm9JOgOozZ1K6s2t2fWL0hLikBQm/sChIhejEbJbgFMq2ZBvAolLiL1jrugtdLjEdzvrXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljztmPpK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713433472; x=1744969472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Almhm7EmJOze8Bt25QP+KeiGORDpSLyCg+DsR0jsOXw=;
  b=ljztmPpKPOTdGVVwGfW4HxDj50VrCe+Vn+RzPE6j8CSwVb6SHFRPpq2l
   4olomKUNYDFYKmScXAyv1fF7ysEopwr6gdRK+98XHFmLN/d7rNCU5F3Ty
   IVGDtyy7Flw4hD2TqGbUIxCQHL5Kti0CK/XYW0lnl++/He0faVjfYadpo
   7Y+Vejnvb/B7/FsSwQqxJiWfHK7aoAerzQvFPEXQ6LQVxHbIJzqXpX3zC
   0r2UzvytcQIGxglo6nmA4gnp8RrxgRZ6GjkU9aeVF1mPmaWmSWdZFFuty
   o61izWeKoJAfrWnzrDCADV+78+sQZAJTmdQmHSnKWfVhe7c7sbSxmEJb6
   A==;
X-CSE-ConnectionGUID: aLFY8dS5RfK+xsDpCVD5NQ==
X-CSE-MsgGUID: RIoTKXEyQX67NYjsSdP8eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12754079"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="12754079"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:43:31 -0700
X-CSE-ConnectionGUID: FczCJVUoTgef2Wb+gIihNw==
X-CSE-MsgGUID: /TKLrt2sSbOsNLJb1Lqs7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="23356524"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:43:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxOIf-00000000HpB-2vZ4;
	Thu, 18 Apr 2024 12:43:25 +0300
Date: Thu, 18 Apr 2024 12:43:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: dw: Add peripheral bus width verification
Message-ID: <ZiDrPSb7YxeooHzC@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-2-fancer.lancer@gmail.com>
 <Zh680h4h6hURIb82@smile.fi.intel.com>
 <ut5notgwnjdj7ex3jeo7jnbdc2vhopebdg3miepto2wfrxti4b@b2xksvotrgph>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ut5notgwnjdj7ex3jeo7jnbdc2vhopebdg3miepto2wfrxti4b@b2xksvotrgph>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 10:54:42PM +0300, Serge Semin wrote:
> On Tue, Apr 16, 2024 at 09:00:50PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 16, 2024 at 07:28:55PM +0300, Serge Semin wrote:

...

> > > +	if (reg_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> > > +		reg_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > +	else if (!is_power_of_2(reg_width) || reg_width > max_width)
> > > +		return -EINVAL;
> > > +	else /* bus width is valid */
> > > +		return 0;
> > > +
> > > +	/* Update undefined addr width value */
> > > +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
> > > +		dwc->dma_sconfig.dst_addr_width = reg_width;
> > > +	else /* DMA_DEV_TO_MEM */
> > > +		dwc->dma_sconfig.src_addr_width = reg_width;
> > 
> 
> > So, can't you simply call clamp() for both fields in dwc_config()?
> 
> Alas I can't. Because the addr-width is the non-memory peripheral
> setting. We can't change it since the client drivers calculate it on
> the application-specific basis (CSR widths, transfer length, etc). So
> we must make sure that the specified value is supported.

What I meant is to convert this "update" part to the clamping, so
we will have the check as the above like

_verify_()
{
	if (reg_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
		return -E...;
	if (!is_power_of_2(reg_width) || reg_width > max_width)
		return -EINVAL;

	/* bus width is valid */
	return 0;
}

dwc_config()
{
	err = ...
	if (err = ...)
		clamp?
	else if (err)
		return err;
}

But it's up to you to choose the better variant. I just share the idea.

> > > +	return 0;
> > > +}

...

> > > +	int err;
> 
> > Hmm... we have two functions one of which is using different name for this.
> 
> Right, the driver uses both variants (see of.c, platform.c, pci.c too).
> 
> > Can we have a patch to convert to err the other one?
> 
> To be honest I'd prefer to use the "ret" name instead. It better
> describes the variable usage context (Although the statements like "if
> (err) ..." look a bit more readable). So I'd rather convert the "err"
> vars to "ret". What do you think?

I'm fine with any choice, just my point is to get it consistent across
the driver.

-- 
With Best Regards,
Andy Shevchenko



