Return-Path: <dmaengine+bounces-3198-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F15197D73D
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 17:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EDD1F22810
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 15:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3AC17BEB9;
	Fri, 20 Sep 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijRkfpFC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCA178CC5;
	Fri, 20 Sep 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844656; cv=none; b=kIC76XIwG0IitQb20eFuXaE93hjoagK4DmS01fMMGtqoc6hrQoYb/cRz+kip3Du0406SxRI0Ewk/Y+fwmQSstX3fkRmrT3dYZlTIGBH2PdZwDW/KKfBCpHrtINkamOh0aluPJKpEYXv9EYsOjdWtVx/ku3Qp+JBP2P/jgr4ja24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844656; c=relaxed/simple;
	bh=YGshjomfJAQzfeWG34of48+m39QEodXmkWvzkLGXTR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIU8p/0cRd9mCGT5C3OC094m7KYPjtFRuoJvkUROT2bxhbQjFaknPPuv1B6QmX/1uUB+RQEyVttqzy9eJHCYYtG59OqmWeuk882d4ZJhFsI9BSGPjwDXvpNZRVdM1JzfSqL6VHpASGqbSHOtHB4ybYxRGEfwf62pOYi3haz557w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijRkfpFC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726844656; x=1758380656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YGshjomfJAQzfeWG34of48+m39QEodXmkWvzkLGXTR8=;
  b=ijRkfpFCOODqeDvxIL2QCKKuKEaR/T+7UkjupjAu4qS8Sf01YI7DMpoW
   ovIMbHKABTkDT2NtIwnVYNZ8y+AC++CzHbKwKL3Wiq3wcjpBh7bXPYUZg
   9B/1S1Ct2sqb8vG5LkAdhFNxkFEqj2ktq1O64SNsDgMkHfvEMjHK41+qm
   f+z2Xl6H3HmX9HdMgBS7F/wCHe0TpeSPkGJ2q/K1ImV69wQvvUoFi11+w
   m858VzjFQRLLyB/hm9hb2DiNMX5C4zmIDufTaXe+5fjWnRWrWSLCfFUEf
   OGVjX/eJMefRPeW1GWc1mMioXvpsewTk6vKGSCJctkk98bbtbzSm/3L9q
   A==;
X-CSE-ConnectionGUID: XECC/SWOQmKxvYlCjRogcw==
X-CSE-MsgGUID: p+17LwTeRxipC2t29nHXRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="26006235"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="26006235"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:04:15 -0700
X-CSE-ConnectionGUID: 9wipslfVTCqHkF39VFJwEQ==
X-CSE-MsgGUID: DuTCFx9YSTqNigaOY+peRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70635137"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 08:04:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1srfB1-0000000AwvL-23Zr;
	Fri, 20 Sep 2024 18:04:07 +0300
Date: Fri, 20 Sep 2024 18:04:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: dw: Fix sys freeze and XFER-bit set error
 for UARTs
Message-ID: <Zu2O5wWGyhRFkBnO@smile.fi.intel.com>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
 <ZugsFPWRZQnH9RaS@smile.fi.intel.com>
 <kpujn6pqnxerasd6zhkfgxrgyidb3tmxuoqgauheoosdhnwatr@spdtf46m7bnu>
 <Zu2FpaBQymPJSAY-@smile.fi.intel.com>
 <3zoeze233vpxoet2tpqayxq4z2covha2p5ymio5lxrbvmp54fs@lqo4ix3hr6gy>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3zoeze233vpxoet2tpqayxq4z2covha2p5ymio5lxrbvmp54fs@lqo4ix3hr6gy>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 05:56:23PM +0300, Serge Semin wrote:
> On Fri, Sep 20, 2024 at 05:24:37PM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 20, 2024 at 12:33:51PM +0300, Serge Semin wrote:
> > > On Mon, Sep 16, 2024 at 04:01:08PM +0300, Andy Shevchenko wrote:

...

> > > There is another problem caused by the too slow coherent memory IO on
> > > my device. Due to that the data gets to be copied too slow in the
> > > __dma_rx_complete()->tty_insert_flip_string() call. As a result a fast
> > > incoming traffic overflows the DW UART inbound FIFO. But that can be
> > > worked around by decreasing the Rx DMA-buffer size. (There are some
> > > more generic fixes possible, but they haven't shown to be as effective
> > > as the buffer size reduction.)
> 
> > This sounds like a specific quirk for a specific platform. In case you
> > are going to address that make sure it does not come to be generic.
> 
> Of course reducing the buffer size is the platform-specific quirk.
> 
> A more generic fix could be to convert the DMA-buffer to being
> allocated from the DMA-noncoherent memory _if_ the DMA performed by
> the DW DMA-device is non-coherent anyway. In that case the
> DMA-coherent memory buffer is normally allocated from the
> non-cacheable memory pool, access to which is very-very slow even on
> the Intel/AMD devices.  So using the cacheable buffer for DMA, then
> manually invalidating the cache for it before DMA IOs and prefetching
> the data afterwards seemed as a more universal solution. But my tests
> showed that such approach doesn't fully solve the problem on my
> device. That said that approach permitted to execute data-safe UART
> transfers for up to 460Kbit/s, meanwhile just reducing the buffer from
> 16K to 512b - for up to 2.0Mbaud/s. It's still not enough since the
> device is capable to work on the speed 3Mbit/s, but it's better than
> 460Kbaud/s.

Ah, interesting issue.  Good lick with solving it the best way you can.
Any yes, you're right that 2M support is better than 0.5M.

-- 
With Best Regards,
Andy Shevchenko



