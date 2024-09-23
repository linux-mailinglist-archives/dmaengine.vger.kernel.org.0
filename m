Return-Path: <dmaengine+bounces-3207-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049897EB7F
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137E51C20305
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03268198836;
	Mon, 23 Sep 2024 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mntMiE4x"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E33433D6;
	Mon, 23 Sep 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727094397; cv=none; b=UdNnV0Jxd0OqtcLf1Ol3YXu4ZtCzreS6KebZVwgWFvgVTUSJH4uXq1JslnPWvqaLkJMaoOT1le7ZUaMdivbMfJH560Lqr01GJF/14qDAux/d6WSNJE2uFLz6ZP3oiX6o0GECxXZOXNkWlPmgExdw1NYt7eF1bw4K9X4O9VTaHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727094397; c=relaxed/simple;
	bh=0+rHveRIzeX/k1EnmHO4P7BXvM8+tKhGRjZgSAf/ASw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7JbquNgwz36144lJKbCdeBxdrlL6GRpXkHzgWAoTwQoHAmcaFJ//LJE3FSMo42SjJ7O2pTZ9jrhYg+RCYTZhM2sweyNf9j3J73CTpMq1WWoM5+yn6/Jb8vG98bOQOL31y25Gi9hBX6Pl3VAAwCZ3F5QxpOViLijBIQm+bDGXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mntMiE4x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727094396; x=1758630396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+rHveRIzeX/k1EnmHO4P7BXvM8+tKhGRjZgSAf/ASw=;
  b=mntMiE4xRxWsr3oWRkZ4qhiTyFGqtGDcYcRpUebLiNdjiqE9y9T9D/Yp
   BoPC0wOU13A9/QW9LgckbnOZ0/wznRJURG9NuZ8M3vIr9KF5oSAtTKJzB
   0hJq5OKjIlQsEcAis3+ogNCGe1BjEjCFizYUd5tFyMM6N8orNxVTLjVzW
   K7QY6U+04TZG4uFHzDlQT4Ad9DTNHw2p2MoYFtibbZ/zNTNcgWULIcRj4
   piXwnedTnm45PmIAjbNeeTk4ArCkAdfRApw9fn4dmZpIsaHn9dFGX7Bap
   F8TffwtBU+pImCE72UM+hV/g8yDFsmhXHjC8smHdmkQONQOYuMmprzahF
   A==;
X-CSE-ConnectionGUID: nzSV0/ptRXyCl3rpIe7QKg==
X-CSE-MsgGUID: XLRitA9FT7C5fhAMiDxOIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="51455648"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="51455648"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 05:26:29 -0700
X-CSE-ConnectionGUID: b7iqpQ3lR4y3Ebju69WcTQ==
X-CSE-MsgGUID: oJQiPuevRvKsjCiiOn7adw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71046093"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 05:26:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ssi92-0000000BzCk-4Ato;
	Mon, 23 Sep 2024 15:26:24 +0300
Date: Mon, 23 Sep 2024 15:26:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	stable@vger.kernel.org, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for
 ACPI devices
Message-ID: <ZvFecC6u0rFczFR9@smile.fi.intel.com>
References: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
 <ajcqxw6in7364m6bp2wncym65mlqf57fxr6pc4aor3xbokx2cu@2wve6fdtu3vz>
 <ZvElEesYTX-89u_g@smile.fi.intel.com>
 <7cy2ho5lysh4tqk3vqz6rv67dadsi33bszx234vpu7bvslnddp@ed6zxezx7nwf>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cy2ho5lysh4tqk3vqz6rv67dadsi33bszx234vpu7bvslnddp@ed6zxezx7nwf>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 02:57:27PM +0300, Serge Semin wrote:
> On Mon, Sep 23, 2024 at 11:21:37AM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 23, 2024 at 01:01:08AM +0300, Serge Semin wrote:
> > > On Fri, Sep 20, 2024 at 06:56:17PM +0300, Andy Shevchenko wrote:

...

> > > So adding them to struct
> > > dw_dma_chip_pdata doesn't seem like a good idea seeing it contains the
> > > generic DW DMA controller info.
> > 
> > So far there is no evidence that the channels are integrated differently on
> > the same DMA controller over all hardware that uses this IP.
> 
> I've got one device (which currently isn't supported by the vanilla
> kernel) which DW DMA-controller have a weird feature of being able to
> communicate with one of the peripherals via both available masters.)
> So the master IDs order can differ from what is currently set by
> default (for ACPI).
> 
> Anyway regarding the amount of the master I/F-es, yes, I failed to
> find any platform with more than two masters synthesized in. But based
> on the DW DMAC IP-core databook there can be up to four of them (see
> the DMAH_NUM_MASTER_INT parameter).

Not sure about weirdness, but IIRC those Intel ones should support that
configuration as well, as the peripheral and memory busses are the same
at the end.

> > > On the contrary my implementation
> > > seems a bit more coherent since it just changes the default slave IDs
> > > defined in the dw_dma_acpi_filter() method and initialized in the
> > > dw_dma_slave instance without adding slave-specific fields to the
> > > generic controller data.
> 
> > The default enumeration for PCI + ACPI or pure ACPI devices is not
> > changed with my patch, but actually makes it better (increases granularity).
> > The defaults are platform specific and that's what driver_data is for.
> 
> Since it's a default setting for the particular controller then it
> seems it would be better to signify that semantic in the fields name.
> Moreover seeing it's a per-platform setup I would recomment to move
> these fields to the dw_dma_platform_data structure instead.
> (Please see my last comment regarding this.)
> 
> > While you like your solution, the problem with it that it doesn't cover
> > different orders, so it's half-baked solution, I think. Mine doesn't
> > change the status quo about integration (see above) and has better approach
> > regarding different ordering.
> 
> Well, your solution doesn't cover the different order of the master
> IDs either,

Correct, I explicitly mentioned that that neither of proposed solutions cover
this right now.

> because the IDs order is still fixed but on the per-controller
> basis. Yes, in that regard your approach is bit more comprehensive,
> but it still remains half-baked since, as you said yourself further,
> it doesn't cover the cases of the non-default master IDs combination.

Right. And I propose to follow this way as long as we have no other devices
in the wild. I.o.w. let's solve the problem when it appears.

> My solution doesn't change the status quo either, but merely fixes the
> case which is currently incorrectly handled in the
> dw_dma_acpi_filter() method. The rest remains the same.
> (See further before responding to this comment.)
> 
> > Both implementations have a flaw regarding per-channel master configuration.
> 
> Right, none of our approaches provide a complete solution of the
> problem with a per-peripheral device master IDs setup. Based on this and
> what was said in the previous comments chunk, I would normally prefer to
> choose a simpler, more localised, less invasive fix, which is provided
> in my version of the change. That's why I started the discussion
> in the first place.


> (Please see my last comment before answering to this one.)

> > > What seems like a much better alternative to the both approaches, is
> > > to use the dw_dma_slave instance defined in the mrfld_spi_setup()
> > > method for the Intel Merrifield SPI PXA2xx DMA-interface in
> > > drivers/spi/spi-pxa2xx-pci.c. But AFAICT that data is left unused
> > > since the DMA-engine handle and connection parameters are determined
> > > by the channel name. Right? Is it possible to make use of the
> > > filter-function specified to the dma_request_slave_channel_compat()
> > > method?
> 
> > Unfortunately no, in ACPI case the only data we use is the name (index) of
> > the channel in the respective resources. Everything else is done automatically.
> 
> Right, but AFAICS ACPI doesn't provide the complete settings in this
> case.

I would even say in many sophisticated DMA controller cases... :-(

> I thought about some combined solution: retrieve the DMAC
> channel via the standard name/index-based approach and then pass the
> dw_dma_slave settings via the custom filter method specified by the
> client driver, thus making use of what is implemented in the
> Merrifield SPI PXA2xx driver. Alas implementing this approach would
> require to alter the generic DMA-engine core somehow.(

This sounds way too far from KISS.

> In anyway if you prefer your version of the fix, fine by me. I've
> provided my reasoning above. If it wasn't enough to persuade you I
> won't be insisting on my change anymore especially seeing its your and
> Varesh duty to maintain the driver.

Yes, I still prefer mine.

> But, again IMO, it seems to be
> better to add the default_{m,p}_master/d{p,m}_master/etc fields to the
> dw_dma_platform_data structure since the platform-specific controller
> settings have been consolidated in there. The dw_dma_chip_pdata
> structure looks as more like generic driver data storage.

I don't think that is correct place for it. The platform data is specific
to the DMA controller as a whole and having there the master configuration
will mean to have the arrays of them. This OTOH will break the OF setup
where this comes from the slave descriptions and may not be provided with
DMA controller, making it imbalanced. Yes, I may agree with you that chip data
is not a good place either, but at least it isolates the case to PCI + ACPI /
pure ACPI devices (and in particular we won't need to alter Intel Quark case).

Ideally, we should parse the additional properties from ACPI for this kind
of DMA controllers to get this from the _slave_ resources. Currently this is
not done, but anyone may propose a such (would you like to volunteer?).

...

TL;DR: If you are okay with your authorship in v3, I prefer it over other
versions with the explanations given in this email thread.

-- 
With Best Regards,
Andy Shevchenko



