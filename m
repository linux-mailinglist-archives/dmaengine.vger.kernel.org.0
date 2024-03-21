Return-Path: <dmaengine+bounces-1467-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61DE8858BB
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 13:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E874B21FEA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Mar 2024 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17AE5A4D4;
	Thu, 21 Mar 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b82PzcF+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E456B68;
	Thu, 21 Mar 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022557; cv=none; b=O0sAZVp+ZIWZ0ye5q87dQ9RnSZOLmayBFSmtVOmrxAJMSDyBUOOgZXfbe90KZYzrBsAJfKtUUxxwyrqy4xIB4xaN3nr2zMX/6cTDOmvmSuKumUOpGmGFCLxJR++gkqJJgxbNlGZaOQWdrpoJewJ/eqdIAElMTSEoZub+BTPY/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022557; c=relaxed/simple;
	bh=iwWWW8H/SAintyrpfKjskBVksuWsRgX06QwbncYB/GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhwt+tQ3YUIps87ShTl2Hd1Xprn0Sb57YleWDGJ3+UPM9bqNTiZFjx/F6BH5HET2zqn87G7TxJ/ZQxZpkGDB7YzZ1Gf4VxQkrUB7597MpT0XfoEJw2/GAEp6BDf3RJURq0X1BhrkjmuvvBQVfoezsxglyZa7veRL+Ue8eSyy1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b82PzcF+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711022556; x=1742558556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iwWWW8H/SAintyrpfKjskBVksuWsRgX06QwbncYB/GI=;
  b=b82PzcF+BdPKoJQMTlyAlTYSn5Y3mw9hKdBTwbSzv6bWfv5N6zApmojE
   Y/N3V6d6Wr85lGKdaiEms4l8fh4YCzoGWdLyqLaVZi+KeqLmmJnW/l9gb
   9EvAhwYQTula49lQsNrUlWZ6b0PPIig7+bIVf1sNWA2WHElDFPetzbAEG
   5iy57m5D+FZy7k89duuM5Hwb4MkfETw5Z501W4rFVbDBqBp2wvgbv/6OX
   jGCUa8OhmF9hI0Mm+7skfxYXHl59SIWp49slik1EMF3H/mFXqBbxyLY6Y
   hPpGw3vP1+GtMhs6xqnQtS+RJOFkVyiKteu0CJZXYsC5NHqRIy2jfRFqg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="17402452"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="17402452"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 05:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="914705165"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="914705165"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 05:02:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rnH7u-0000000ErNL-47sC;
	Thu, 21 Mar 2024 14:02:30 +0200
Date: Thu, 21 Mar 2024 14:02:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1 1/1] idma64: Don't try to serve interrupts when device
 is powered off
Message-ID: <Zfwh1kte7kAiHD-f@smile.fi.intel.com>
References: <20240320163210.1153679-1-andriy.shevchenko@linux.intel.com>
 <5bf33366-c376-4b9e-a280-071b98fbdad5@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf33366-c376-4b9e-a280-071b98fbdad5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 21, 2024 at 12:49:20PM +0100, Heiner Kallweit wrote:
> On 20.03.2024 17:32, Andy Shevchenko wrote:

...

> >  	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);
> >  
> > +	/* Since IRQ may be shared, check if DMA controller is powered on */
> > +	if (status == GENMASK(31, 0))
> > +		return IRQ_NONE;
> > +
> >  	/* Check if we have any interrupt from the DMA controller */
> >  	if (!status)
> >  		return IRQ_NONE;
> > -- 2.43.0.rc1.1.gbec44491f096
> 
> Tested-by: Heiner Kallweit <hkallweit1@gmail.com>

Thank you! I think I'll move the test to be before the debug message as it
makes no sense to print when we have powered off device.
Nevertheless, I'll take your tag if no objections for v2.

-- 
With Best Regards,
Andy Shevchenko



