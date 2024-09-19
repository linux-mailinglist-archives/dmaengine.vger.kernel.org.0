Return-Path: <dmaengine+bounces-3193-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC5897CE60
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 22:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C679DB22934
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6106313FD72;
	Thu, 19 Sep 2024 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYv5l73F"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A63A1AC;
	Thu, 19 Sep 2024 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726776391; cv=none; b=J+u1IcR4+WP5EQ/Ycb9mVGsh1TSt2tse9VvMt+QRWCn5XkFdngxtC1jpPjlWXlHATqg2AgJo9KxVmBIzuIM/nkbWTDJNfwLR1SWS8/mzIa9N2HB4HrsPLa46JgBuxGx3nSFnBjO+NHXBnuMQeAZ7o7ymaQs+fzqYHGJhSHTksT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726776391; c=relaxed/simple;
	bh=XjN0oSMKjxqwxkOHJOTdBU2OHtVCEa6+hxnDLEA3Nrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4JC9s3x0uJMgB7/s7omht8ubgFqhVKVNjII/FSVp4+qnPhwMa7cXA0QJKwLBw5NjFMRVnzEKeaW4m969GmR4Ti0krSziSTrwpBreR84rjxSS1XCkFQEheJUu26o+H5K3xt+zh9jD4ZoazM4xR8Hzxw2tDBOK61RTqWUTAyHxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYv5l73F; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726776390; x=1758312390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XjN0oSMKjxqwxkOHJOTdBU2OHtVCEa6+hxnDLEA3Nrk=;
  b=hYv5l73FcFRY/QcaDAzRwbG+FrcPqervXhfRh1DBEgmXzlWaU0bllBwh
   QdbgsV3Us79GMNHaATlZm7fZH9LMoixqUTK2kmxeGGHSzCD8Hz0jf2r+F
   HREkMH61uxnAYCcBTiEwymeGHXxQk7lej5aYxyZbRcwvsiXb7GjaCkNUP
   md/F6IQCtx3cjYnGQ83MXtDkuEirdn+G3eAW6EcfCnWuvApiOVe4w0Sr6
   27KVoQyK4MG+TMmidjHdkX2t7nStESK9Uu7CoAme19d0KQ0ZfEaNPB1RD
   0LRRYaiepKfxPTbPSCUPJoHK4gqzKJtuWiZmC6skHEJPaxKOHPmYFeGck
   g==;
X-CSE-ConnectionGUID: SzKBei91SkiSx4y5keDw4g==
X-CSE-MsgGUID: f6bGWtf3R+qvH3WkfUydbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25289362"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25289362"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:06:29 -0700
X-CSE-ConnectionGUID: x9OG1XstSeeGeCAcRv8Eqw==
X-CSE-MsgGUID: PM6gh1Q7SmugdCKrnPa6NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="74167365"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:06:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srNQ0-0000000AgQy-25PB;
	Thu, 19 Sep 2024 23:06:24 +0300
Date: Thu, 19 Sep 2024 23:06:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ferry Toth <fntoth@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ferry Toth <ftoth@exalondelft.nl>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: dw: Select only supported masters for ACPI
 devices
Message-ID: <ZuyEQOIztvUrO0gO@smile.fi.intel.com>
References: <20240919135854.16124-1-fancer.lancer@gmail.com>
 <20240919185151.7331-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919185151.7331-1-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 19, 2024 at 09:51:48PM +0300, Serge Semin wrote:
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

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Seems this fixes the bug I have seen.
Ferry, can you confirm?

-- 
With Best Regards,
Andy Shevchenko



