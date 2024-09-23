Return-Path: <dmaengine+bounces-3209-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 957B197EBF7
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 15:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEEE1F21FE5
	for <lists+dmaengine@lfdr.de>; Mon, 23 Sep 2024 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EED8198A05;
	Mon, 23 Sep 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1zGM78N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F4198A10;
	Mon, 23 Sep 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096544; cv=none; b=p5NlGXp3S0Mud+iJkfnuE1AMQBY0uaSv14Ti1pH4XdyI6NZp1qcSnCyJaQuejPtPgW1sRPXMuLbZ6KaCj/D45R5hid2qgl8pV9ZUjDTy1kh0LIkI1G53/7wDRkBGHfd+pliGiLUdrIcQv3qJz4VacBI1Rdk5S0DZxMaZiAAespE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096544; c=relaxed/simple;
	bh=g66APNyY+apsUeoTdGyh09zrCNpmxNDntcexfqQ7y88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK0aNyqLbr14Tf2c90mmXzn3dTl0+u/meuqwhkyTQ+QSYKs3pqKZrJBaAZOoji4Wv3A1vRdvH8P4/cBWnEtBgf/b8CAGuaDZsoAOAofm4sCbCQUOOWWom809n4bFWEuFd/rn5TlVjMZNxwX+1VOSikH0AEBLCsaxeSJa0H3c650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1zGM78N; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727096542; x=1758632542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g66APNyY+apsUeoTdGyh09zrCNpmxNDntcexfqQ7y88=;
  b=H1zGM78NIm4afY/SSYkKoeSWvR8SVIjP9NcDmG8m2pSA/zGI+CEqvXm4
   15jXRYQy8bkIwYPwDGhpS8F9exescqzYSs4zwGDGJXRg06th34f7ctKSt
   WxESOSkha5JCkJIN6YXSEiDukL24NQLpk+gaWZ0lvfYNLdiKx2hc4o7sE
   lJeQeZ2qM5V4Je1fqPzy6Bmkmx0q220PJZam69Uovrx4JDrg50TteKnlv
   J1xdS2KaGotOQMKXHxPCRsW4s3gOdv9/JMTo00PCQac+MCsPLq/YuJrAJ
   atnq/yDIjhq35E5dj9BoeWQg2tAdGgp3P883Nja9N9TRu5WqnBvSGwMiQ
   A==;
X-CSE-ConnectionGUID: fCXQrHVaRhO/MTb/S2DDuQ==
X-CSE-MsgGUID: pEf0syRQRwaP4Ni2aPi1Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29827100"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="29827100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:02:22 -0700
X-CSE-ConnectionGUID: 45rcmCbpRAmjR69Hr55KTw==
X-CSE-MsgGUID: uASOnsfySV+hHK6rrUSe0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="75832396"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 06:02:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ssihl-0000000BzyR-39VX;
	Mon, 23 Sep 2024 16:02:17 +0300
Date: Mon, 23 Sep 2024 16:02:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	stable@vger.kernel.org, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v3 1/1] dmaengine: dw: Select only supported masters for
 ACPI devices
Message-ID: <ZvFm2TOGGPa7W4rF@smile.fi.intel.com>
References: <20240920155820.3340081-1-andriy.shevchenko@linux.intel.com>
 <ajcqxw6in7364m6bp2wncym65mlqf57fxr6pc4aor3xbokx2cu@2wve6fdtu3vz>
 <ZvElEesYTX-89u_g@smile.fi.intel.com>
 <7cy2ho5lysh4tqk3vqz6rv67dadsi33bszx234vpu7bvslnddp@ed6zxezx7nwf>
 <ZvFecC6u0rFczFR9@smile.fi.intel.com>
 <onfkegjjn7psbhc44fhjmp5ttbuthiscpccywaxxwabalpmudo@xhfdlxi762o6>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <onfkegjjn7psbhc44fhjmp5ttbuthiscpccywaxxwabalpmudo@xhfdlxi762o6>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 03:46:04PM +0300, Serge Semin wrote:
> On Mon, Sep 23, 2024 at 03:26:24PM +0300, Andy Shevchenko wrote:
> > On Mon, Sep 23, 2024 at 02:57:27PM +0300, Serge Semin wrote:
> > > On Mon, Sep 23, 2024 at 11:21:37AM +0300, Andy Shevchenko wrote:
> > > > On Mon, Sep 23, 2024 at 01:01:08AM +0300, Serge Semin wrote:
> > > > > On Fri, Sep 20, 2024 at 06:56:17PM +0300, Andy Shevchenko wrote:

...


> > Yes, I still prefer mine.
> > 
> > > But, again IMO, it seems to be
> > > better to add the default_{m,p}_master/d{p,m}_master/etc fields to the
> > > dw_dma_platform_data structure since the platform-specific controller
> > > settings have been consolidated in there. The dw_dma_chip_pdata
> > > structure looks as more like generic driver data storage.
> > 
> > I don't think that is correct place for it. The platform data is specific
> > to the DMA controller as a whole and having there the master configuration
> > will mean to have the arrays of them. This OTOH will break the OF setup
> > where this comes from the slave descriptions and may not be provided with
> > DMA controller, making it imbalanced. Yes, I may agree with you that chip data
> > is not a good place either, but at least it isolates the case to PCI + ACPI /
> > pure ACPI devices (and in particular we won't need to alter Intel Quark case).
> 
> > Ideally, we should parse the additional properties from ACPI for this kind
> > of DMA controllers to get this from the _slave_ resources. Currently this is
> > not done, but anyone may propose a such
> 
> I guess it would also mean to fix all the firmware as well, wouldn't it?

Nope, legacy will use current defaults. Only new will be more flexible.

> Do the Intel/AMD/etc ACPI firmware currently provide such a data?

I can't tell for AMD for sure, neither for Intel as a whole (not
a product related engineer). I can tell only for my experience and
I haven't known any of Intel devices with such IP that has it different.

> In anyway it would be inapplicable for the legacy hardware anyway.

Exactly!

> > (would you like to volunteer?).
> 
> not really.) Maybe in some long-distance future when I get to meet a
> device on the ACPI-based platform with the DW DMAC + some peripheral
> experiencing the denoted problem, I'll think about implementing what
> we've discussed here.

Something is telling me that this will never be needed IRL.

...

> > TL;DR: If you are okay with your authorship in v3, I prefer it over other
> > versions with the explanations given in this email thread.
> 
> Ok. Let's leave it as of your preference.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



