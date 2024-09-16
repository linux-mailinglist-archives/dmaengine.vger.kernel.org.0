Return-Path: <dmaengine+bounces-3168-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E380997A078
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 13:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8981CB2119F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD8C154429;
	Mon, 16 Sep 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ee8aATic"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89A1459F6;
	Mon, 16 Sep 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487036; cv=none; b=TVQAtGD/jV8UPSjvXJdDv/UqHyuLl/Sv56YyARk12dX9+iJW7oIhtecPAIPctSGeM27zZFph5QytWEhrtZBecwJo2tIJZSDQ4BAA8J7uNWA6j204qvW80MKbTjsJCH3rJ1sojd3qfY1kFDJYiym0Js/2ZPKDT+KgK3kiQUORpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487036; c=relaxed/simple;
	bh=fTBWQpQonoZif64C+Yn11CfNLH8wo1kb433Z6N+a6f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPLtEIf1Vd9D2Ch+ZwK9BcbXQDjXDdKmt0WyPguY3oIQ6VjUO31sU1mZZJil1FJFOg0M3MnneE62Vk/CrdzjlxeY4xhzyPc2KA0trumuqjnhpErTPulR7oY0/upFidE425boaqUGbDhKIChIG9nPHXLpTIDLP5EINJSanl6yHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ee8aATic; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726487035; x=1758023035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTBWQpQonoZif64C+Yn11CfNLH8wo1kb433Z6N+a6f0=;
  b=ee8aATic4Xkyl/Em6UoLAtvUbh9ZlMENT5Sco03f7P1b1tR8JRkXz6iK
   treQ3/ZqtvlsrT6xRWBNDNdVRIWz7xaVEtVovZckw6Ngak1Tow9tkJF4d
   ENkTOgY9oFizB5fma56IB652QIteFmtUyC/g0dvz/E+jM7KbUSFSFVUrB
   /X3CfRDcNr+5ayuodPNi0Lqp2/Tj8nflYC+YxavgZ1S66UoRZEEeeoWNL
   K0K5rOPRVeqxxHl3OP2UVVEdRCk2vRzqrv7LkNJSV1tKrf1Qw8XkbFH5m
   q7y9+cbhsm+xDw2f4CciIo0GjjQ30MUMgcDeZ9sCbWS8bkqJxiV8l8WPF
   A==;
X-CSE-ConnectionGUID: +IEQKhDPQl6k8rK3VFZerg==
X-CSE-MsgGUID: MDjT7w1+S9KZ2b4TBQGxxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25465721"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25465721"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 04:43:54 -0700
X-CSE-ConnectionGUID: bl0TYplWSTiCiUkPmcFA1w==
X-CSE-MsgGUID: 3P5gtRviRMiSiaZPy6LJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="73613656"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 04:43:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sqA8y-00000009RVu-2rYV;
	Mon, 16 Sep 2024 14:43:48 +0300
Date: Mon, 16 Sep 2024 14:43:48 +0300
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
Message-ID: <ZugZ9NcnPMNTH_ZQ@smile.fi.intel.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <20240802075100.6475-2-fancer.lancer@gmail.com>
 <ZuXgI-VcHpMgbZ91@black.fi.intel.com>
 <wghwkx6xbkwxff5wbi2erdl2z3fmjdl54qqb3rfty7oiabvk7h@3vpzlkjataor>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wghwkx6xbkwxff5wbi2erdl2z3fmjdl54qqb3rfty7oiabvk7h@3vpzlkjataor>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Sep 14, 2024 at 10:22:22PM +0300, Serge Semin wrote:
> On Sat, Sep 14, 2024 at 10:12:35PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 02, 2024 at 10:50:46AM +0300, Serge Semin wrote:
> > > Currently the src_addr_width and dst_addr_width fields of the
> > > dma_slave_config structure are mapped to the CTLx.SRC_TR_WIDTH and
> > > CTLx.DST_TR_WIDTH fields of the peripheral bus side in order to have the
> > > properly aligned data passed to the target device. It's done just by
> > > converting the passed peripheral bus width to the encoded value using the
> > > __ffs() function. This implementation has several problematic sides:
> > > 
> > > 1. __ffs() is undefined if no bit exist in the passed value. Thus if the
> > > specified addr-width is DMA_SLAVE_BUSWIDTH_UNDEFINED, __ffs() may return
> > > unexpected value depending on the platform-specific implementation.
> > > 
> > > 2. DW AHB DMA-engine permits having the power-of-2 transfer width limited
> > > by the DMAH_Mk_HDATA_WIDTH IP-core synthesize parameter. Specifying
> > > bus-width out of that constraints scope will definitely cause unexpected
> > > result since the destination reg will be only partly touched than the
> > > client driver implied.
> > > 
> > > Let's fix all of that by adding the peripheral bus width verification
> > > method and calling it in dwc_config() which is supposed to be executed
> > > before preparing any transfer. The new method will make sure that the
> > > passed source or destination address width is valid and if undefined then
> > > the driver will just fallback to the 1-byte width transfer.
> > 
> > This patch broke Intel Merrifield iDMA32 + SPI PXA2xx configuration to
> > me. Since it's first in the series and most likely the rest is
> > dependent and we are almost at the release date I propose to roll back
> > and start again after v6.12-rc1 will be out. Vinod, can we revert the
> > entire series, please?
> 
> I guess it's not the best option, since the patch has already been
> backported to the stable kernels anyway. Rolling back it from all of
> them seems tiresome. Let's at least try to fix the just discovered
> problem?

Please, provide one we can test!

> Could you please provide more details about what exactly happening?

Sure. AFAICT the only problematic line is this:

        else if (!is_power_of_2(reg_width) || reg_width > max_width)

in your patch, and it may trigger, for example, when max_width == 0.
This, in accordance with my brief investigation, happens due to the following.

The DMA slave configuration is being copied twice in DW DMA code:
1) when respective filter function triggers (see acpi/of glue code);
2) when the channel is about to be allocated.

The iDMA32 has only a single master, and hence m_master == p_master,
BUT the filter function in the acpi code is universal and it copies
the wrong (from the iDMA32 perspective) value to p_master.
As the result, when you retrieve the max_width, it takes the value from
p_master, which is defined to 1 (sic!), and hence assigns it to 0.

I don't know how to quickfix this as the proper fix seems to provide
the correct data in the first place.

Any ideas, patches we may test?

-- 
With Best Regards,
Andy Shevchenko



