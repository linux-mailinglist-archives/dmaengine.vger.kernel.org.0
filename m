Return-Path: <dmaengine+bounces-1889-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526A8A98E7
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 13:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9C5B24000
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 11:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6332C15E80D;
	Thu, 18 Apr 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHJlH71O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B2156894;
	Thu, 18 Apr 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440846; cv=none; b=Jx0uL+/avC1ItB3w3B1mRhwn30Cfcvogr39VUFwM3dtfkJyp+rwM7naJbsAdqeJlCdpfFciAWtrPpbKky/gP1wY+hcc7ewDKD2wJfkd4wCs6Ug0BSVuVVgAgnsudcqODk4IjrA8R2k3Zqku9ty/OHQmcwscJ9r0si45+YeayXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440846; c=relaxed/simple;
	bh=1dF/QvVZQ4hPyEOJfKhcAxHXy2CpSDIxFNK2gxe1ep4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0itZA0bq4z2hXR2lV6fcoVYEqm/7r7vpoYl8/8NgBTa8VRxUME5cLtQMCTF9UCEdMthr8ezpFnSkjFTH0y/auw/Q8oylaIUHqXahrk4sK83SnnvxaIbz6SGN5eZYs0pyYRvFnItmbTmGOYHky+X4OG5THLDdL+Da+ZPaJeZY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHJlH71O; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440846; x=1744976846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1dF/QvVZQ4hPyEOJfKhcAxHXy2CpSDIxFNK2gxe1ep4=;
  b=EHJlH71OAKyQgzoDrMFG7XxvW14XfIjS3jUbvSKs6OrsNi36s4TZ+ZpV
   +oVtnaVReA00aOmS2k34+hRYj4MRo1ha+WYzsbrrq1to+nLr9YkRzu626
   /Mum/VDAlO0zuXQiOSTgUMRXIBd7/QObQgadY+XW93J+zs2f2f+8/ruxo
   5a97YxVx2hn3xUYXX53uHtWNzYOClZ1S3rPs9p1Qd9UDih0IieBImGrLX
   Bm2Tm7kGRkRamPZN2UypwS5qCKjmI6alXy4m+/toHF+IbBpctH6vt/Xvk
   ejY0WGCXwpr/3zRcQaZ7yrHvCY24nEgA2bynQ8V4TcUVkUR2OjVNuDs1t
   A==;
X-CSE-ConnectionGUID: 6ClMJ9LeRiG6/ktxTXYqPg==
X-CSE-MsgGUID: YIXUrNufTtijMEmMPsco5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20127184"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20127184"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:47:25 -0700
X-CSE-ConnectionGUID: mxlbQUyKRoa2OHsQZaugmQ==
X-CSE-MsgGUID: o5wD/FQnTyuCjLCYW+sgZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23392192"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:47:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxQEZ-00000000JV7-1B5d;
	Thu, 18 Apr 2024 14:47:19 +0300
Date: Thu, 18 Apr 2024 14:47:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw: Simplify prepare CTL_LO methods
Message-ID: <ZiEIRluj-50FMIgp@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-4-fancer.lancer@gmail.com>
 <Zh7LyszPd2sNfWRm@smile.fi.intel.com>
 <lzcgxh7trwoksd4bx2fsybellbngvpwhgq2a76ou2iufemockp@3dca4bfox2ps>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lzcgxh7trwoksd4bx2fsybellbngvpwhgq2a76ou2iufemockp@3dca4bfox2ps>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 11:11:46PM +0300, Serge Semin wrote:
> On Tue, Apr 16, 2024 at 10:04:42PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 16, 2024 at 07:28:57PM +0300, Serge Semin wrote:

...

> > > +	if (dwc->direction == DMA_MEM_TO_DEV) {
> > > +		sms = dwc->dws.m_master;
> > > +		smsize = 0;
> > > +		dms = dwc->dws.p_master;
> > > +		dmsize = sconfig->dst_maxburst;
> > 
> 
> > I would group it differently, i.e.
> > 
> > 		sms = dwc->dws.m_master;
> > 		dms = dwc->dws.p_master;
> > 		smsize = 0;
> > 		dmsize = sconfig->dst_maxburst;
> 
> Could you please clarify, why? From my point of view it was better to
> group the source master ID and the source master burst size inits
> together.

Sure. The point here is that when you look at the DMA channel configuration
usually you operate with the semantically tied fields for source and
destination. At least this is my experience, I always check both sides
of the transfer for the same field, e.g., master setting, hence I want to
have them coupled.

> > > +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> > > +		sms = dwc->dws.p_master;
> > > +		smsize = sconfig->src_maxburst;
> > > +		dms = dwc->dws.m_master;
> > > +		dmsize = 0;
> > > +	} else /* DMA_MEM_TO_MEM */ {
> > > +		sms = dwc->dws.m_master;
> > > +		smsize = 0;
> > > +		dms = dwc->dws.m_master;
> > > +		dmsize = 0;
> > > +	}
> > 
> > Ditto for two above cases.

...

> > >  static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
> > >  {
> > >  	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
> > > -	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
> > > -	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;

> > > +	u8 smsize, dmsize;
> > > +
> > > +	if (dwc->direction == DMA_MEM_TO_DEV) {
> > > +		smsize = 0;
> > > +		dmsize = sconfig->dst_maxburst;
> > > +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> > > +		smsize = sconfig->src_maxburst;
> > > +		dmsize = 0;
> > > +	} else /* DMA_MEM_TO_MEM */ {
> > > +		smsize = 0;
> > > +		dmsize = 0;
> > > +	}
> > 
> > 	u8 smsize = 0, dmsize = 0;
> > 
> > 	if (dwc->direction == DMA_MEM_TO_DEV)
> > 		dmsize = sconfig->dst_maxburst;
> > 	else if (dwc->direction == DMA_DEV_TO_MEM)
> > 		smsize = sconfig->src_maxburst;
> > 
> > ?
> > 
> > Something similar also can be done in the Synopsys case above, no?
> 
> As in case of the patch #1 the if-else statement here was designed
> like that intentionally: to signify that the else clause implies the
> DMA_MEM_TO_MEM transfer. Any other one (like DMA_DEV_TO_DEV) would
> need to have the statement alteration.

My version as I read it:
- for M2D the dmsize is important
- for D2M the smsize is important
- for anything else use defaults (which are 0)

> Moreover even though your
> version looks smaller, but it causes one redundant store operation.

Most likely not. Any assembler here? I can check on x86_64, but I believe it
simply assigns 0 for both u8 at once using xor r16,r16 or so.

Maybe ARM or MIPS (what do you use?) sucks? :-)

> Do you think it still would be better to use your version despite of
> my reasoning?

-- 
With Best Regards,
Andy Shevchenko



