Return-Path: <dmaengine+bounces-3203-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB097E772
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 10:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D488281899
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058DB19340F;
	Mon, 23 Sep 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+u9hkm8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C626101E6;
	Mon, 23 Sep 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079704; cv=none; b=sa/LzlkimKTJJ6p0OQ+uRikdfa1QVdsj0VuOMoY/LU2CO0ssBdlhNemWTDy76golBqd7lVt9btTda+0CinvLUuCqHzBuDfzeBFRbDSiaqsGNIDhwswKdfSQL5rwbZfrjXxvKMo8LgCUOVGzMvhxvlEUbataGNLvPFGgKv6m0lm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079704; c=relaxed/simple;
	bh=AhBArCA00fHDd85KD8nAgXjfaoO4k8Sawy/JQYap8f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBnLORqZgxSWB2wEUHf/OiGtskMaQawonJ4z0lwHfbxgwhxOXzqcDGfUOqJVFrmVncmoBVffBJ+LTrKPpllj+AMkk4mVlbPIWqukBc04szDHUJeE5EipFF/+uGJsOkRUeaoLRDZteIq5LKCHEFDtpBr00X/4gPgl6SOHX6uzlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+u9hkm8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727079703; x=1758615703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhBArCA00fHDd85KD8nAgXjfaoO4k8Sawy/JQYap8f0=;
  b=Y+u9hkm8ug9rvoFIfBi7OdViKk/gi7pnYCXzjCDirzUe/vd5lWHtB0TK
   aobs2efrQa+3lVRjomSiRsIKodyF7oEvOqLfr8Qls6PC1jSXXHSfW6uCp
   eWRYLgqTNYFNe+KoQkUHYCSqltKvdW+426s+cQz815X5kCceZBeh/ZG5x
   GzGinrxjnMRhUQ+yxpLBWSqMfivPYVC7Zl0jFy67m8BqUypa62vW1q9DC
   WCllZ8Vouk+5EDa0ntXrO/s3BZvE8QLdXoNXhn1381gy0Xy7GUKppAktV
   0/KCZ5UO6/4a6IEiYPy5jIb7pAFdqFzT535VySo0eJaImoRc5u1r3Jdqi
   A==;
X-CSE-ConnectionGUID: 8xiqCuKFTAayNZGcySTCaQ==
X-CSE-MsgGUID: bpDB/AuiRmuFlPo/vuVX4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36680228"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="36680228"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:21:42 -0700
X-CSE-ConnectionGUID: 6uBB5GAnQeqQ+IU64FDK+g==
X-CSE-MsgGUID: H/KDjnfpRy+R0NV1dhzzjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71303187"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:21:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sseKA-0000000BtFM-0AKM;
	Mon, 23 Sep 2024 11:21:38 +0300
Date: Mon, 23 Sep 2024 11:21:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	stable@vger.kernel.org, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for
 ACPI devices
Message-ID: <ZvElEesYTX-89u_g@smile.fi.intel.com>
References: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
 <ajcqxw6in7364m6bp2wncym65mlqf57fxr6pc4aor3xbokx2cu@2wve6fdtu3vz>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajcqxw6in7364m6bp2wncym65mlqf57fxr6pc4aor3xbokx2cu@2wve6fdtu3vz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 01:01:08AM +0300, Serge Semin wrote:
> On Fri, Sep 20, 2024 at 06:56:17PM +0300, Andy Shevchenko wrote:

...

> > Fix the problem by specifying the default master ID for both memory
> > and peripheral devices in the driver data. Thus the issue noticed for
> > the iDMA 32-bit controllers will be eliminated and the ACPI-probed
> > DW DMA controllers will be configured with the correct master ID by
> > default.

> > ---
> > v3: rewrote to use driver_data
> > v2: https://lore.kernel.org/r/20240919185151.7331-1-fancer.lancer@gmail.com
> 
> IMO v2 looked better for me.

I disagree, obviously, since I sent a v3.
(I can drop your authorship and tags in v4)

> I am sure you know, but Master IDs is a
> platform-specific thing specific for each slave/peripheral device
> connected to the DMA controller. Depending on the chip design one
> peripheral device can be accessed over the one master IDs, another
> device/memory may have another master connected (can be up to four
> master IDs in general). That's why the master IDs have been declared
> in the dw_dma_slave structure.

Correct.

> So adding them to struct
> dw_dma_chip_pdata doesn't seem like a good idea seeing it contains the
> generic DW DMA controller info.

So far there is no evidence that the channels are integrated differently on
the same DMA controller over all hardware that uses this IP.

> On the contrary my implementation
> seems a bit more coherent since it just changes the default slave IDs
> defined in the dw_dma_acpi_filter() method and initialized in the
> dw_dma_slave instance without adding slave-specific fields to the
> generic controller data.

The default enumeration for PCI + ACPI or pure ACPI devices is not
changed with my patch, but actually makes it better (increases granularity).
The defaults are platform specific and that's what driver_data is for.

While you like your solution, the problem with it that it doesn't cover
different orders, so it's half-baked solution, I think. Mine doesn't
change the status quo about integration (see above) and has better approach
regarding different ordering. Both implementations have a flaw regarding per-channel master configuration.

> What seems like a much better alternative to the both approaches, is
> to use the dw_dma_slave instance defined in the mrfld_spi_setup()
> method for the Intel Merrifield SPI PXA2xx DMA-interface in
> drivers/spi/spi-pxa2xx-pci.c. But AFAICT that data is left unused
> since the DMA-engine handle and connection parameters are determined
> by the channel name. Right? Is it possible to make use of the
> filter-function specified to the dma_request_slave_channel_compat()
> method?

Unfortunately no, in ACPI case the only data we use is the name (index) of
the channel in the respective resources. Everything else is done automatically.

-- 
With Best Regards,
Andy Shevchenko



