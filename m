Return-Path: <dmaengine+bounces-3196-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25E97D6D0
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 16:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769112842F9
	for <lists+dmaengine@lfdr.de>; Fri, 20 Sep 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3123817BB1C;
	Fri, 20 Sep 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HERsu5u0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1441E521;
	Fri, 20 Sep 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842285; cv=none; b=bAk7uFe/kZHiOhfZScT0s+FfUMgpXUexWiwwVfqGx/WLeVKydgVivQ215p7RroZzFRRHn0UNBQvlmsx2ONEQu1LcMlfDxSjaR8uuPzGRcuMPCF6OBESB4vdfOg2/hKc1oCv9Kkm7nWk2YQ3mZLaE9QmZFiEP81rYiBTzwNmt+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842285; c=relaxed/simple;
	bh=7lHYetbxEv/ox4moMs8N/M7ilUIFGhSO9n0VuyYeeic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdMvd/YI9dTZ/UXNGlLFlONtmOxS6giHV6bbTD9SBFERDKrbbU9MndVlPDatYJ3MWuD5U8WunQvrLK8TVTg8+G0/gxe17oi7soF840zGwG2wFQt2oCCtd81vGZQOvZfFh6RXwdNiLvSvWRB+zl2LD3O0H/XQKr/7Ne1vD5pZ3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HERsu5u0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726842283; x=1758378283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7lHYetbxEv/ox4moMs8N/M7ilUIFGhSO9n0VuyYeeic=;
  b=HERsu5u0OJrNUzKRXxfECPHRWqf6j3ANTKPnGJqy8h3V14PaBtE5sxrw
   XdyktHjZTUmlErnN8TUzo/kGRXgMJ6PY/hKkC7w6rBvQYb2y+GtmRTBjw
   FRIpCJ1bRVBrBYb7Yf3QSrGzDL+RcRTkmKcivxL/QQPFaqnXTQLE/By68
   VnAOlSBIxkYIJNer9P7SmPGOt7utY5uRPyfd/Yuf6sMuKXVzWXFpYUXYs
   Sn0FTTJwMqxu+y9MzddMrHGJiEDt8+kp41+Qs+kA3RnLG0sHGze7Mmvyp
   D3BSHKg+6Tg+2r7PCdoJB75rKOa4u4hYr4LjF3AR2tq86BcLG1D/0YXQY
   A==;
X-CSE-ConnectionGUID: UuOjKkuoT2qSmnIP+yaUsQ==
X-CSE-MsgGUID: VWK3IOGBT4SmgkBjwW+2Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25370719"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25370719"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:24:42 -0700
X-CSE-ConnectionGUID: fjL4BDtjQKykY9/UpUzXiw==
X-CSE-MsgGUID: xOkEKG7RRR2mBPssvPrctw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="75264282"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 07:24:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sreYn-0000000AwBN-16xI;
	Fri, 20 Sep 2024 17:24:37 +0300
Date: Fri, 20 Sep 2024 17:24:37 +0300
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
Message-ID: <Zu2FpaBQymPJSAY-@smile.fi.intel.com>
References: <20240911184710.4207-1-fancer.lancer@gmail.com>
 <ZugsFPWRZQnH9RaS@smile.fi.intel.com>
 <kpujn6pqnxerasd6zhkfgxrgyidb3tmxuoqgauheoosdhnwatr@spdtf46m7bnu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kpujn6pqnxerasd6zhkfgxrgyidb3tmxuoqgauheoosdhnwatr@spdtf46m7bnu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 20, 2024 at 12:33:51PM +0300, Serge Semin wrote:
> On Mon, Sep 16, 2024 at 04:01:08PM +0300, Andy Shevchenko wrote:
> > On Wed, Sep 11, 2024 at 09:46:08PM +0300, Serge Semin wrote:
> > > The main goal of the series is to fix the DW DMAC driver to be working
> > > better with the serial 8250 device driver implementation. In particular it
> > > was discovered that there is a random system freeze (caused by a
> > > deadlock) and an occasional "BUG: XFER bit set, but channel not idle"
> > > error printed to the log when the DW APB UART interface is used in
> > > conjunction with the DW DMA controller. Although I guess the problem can
> > > be found for any 8250 device using DW DMAC for the Tx/Rx-transfers
> > > execution. Anyway this short series contains two patches fixing these
> > > bugs. Please see the respective patches log for details.
> > > 
> > > Link: https://lore.kernel.org/dmaengine/20240802080756.7415-1-fancer.lancer@gmail.com/
> > > Changelog RFC:
> > > - Add a new patch:
> > >   [PATCH 2/2] dmaengine: dw: Fix XFER bit set, but channel not idle error
> > >   fixing the "XFER bit set, but channel not idle" error.
> > > - Instead of just dropping the dwc_scan_descriptors() method invocation
> > >   calculate the residue in the Tx-status getter.
> 
> > FWIW, this series does not regress on Intel Merrifield (SPI case),
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Great! Thanks.
> 
> > P.S.
> > However it might need an additional tests for the DW UART based platforms.
> > Cc'ed to Hans just in case (it might that he can add this to his repo for
> > testing on Bay Trail and Cherry Trail that may have use of DW UART for BT
> > operations).
> 
> It's not enough though. The DW UART controller must be connected to
> the DW DMAC handshaking interface on the platform. The kernel must be
> properly setup for that too. In that case the test would be done on
> a proper target. Do the Bay Trail and Cherry Trail chips support such
> HW-setup? If so the additional test would be very welcome.

I'm not sure I understand what HW setup you mean.

Bay Trail and Cherry Trail uses a shared DW DMA controller with number of
peripheral devices, HS UART (also DW) is one of them.

> Sometime ago you said that you seemed to meet a similar issue on older
> machines:
> https://lore.kernel.org/dmaengine/CAHp75VdXqS6xqdsQCyhaMNLvzwkFn9HU8k9SLcT=KSwF9QPN4Q@mail.gmail.com/
> If it's still possible could you please perform at least some smoke
> test on those devices?

That mainly was exactly about Bay Trail and Cherry Trail machines
(and may be Broadwell and Haswell, but the latter two is not so
 distributed nowadays).

> In case of my device this series and a previous one
> https://lore.kernel.org/dmaengine/20240802075100.6475-1-fancer.lancer@gmail.com/
> fixed all the critical issues for the DW UART + DW DMAC buddies:
> 1. Sudden data disappearing at the tail of the transfers (previous
> patch set).
> 2. Random system freeze (this patch set).
> 
> There is another problem caused by the too slow coherent memory IO on
> my device. Due to that the data gets to be copied too slow in the
> __dma_rx_complete()->tty_insert_flip_string() call. As a result a fast
> incoming traffic overflows the DW UART inbound FIFO. But that can be
> worked around by decreasing the Rx DMA-buffer size. (There are some
> more generic fixes possible, but they haven't shown to be as effective
> as the buffer size reduction.)

This sounds like a specific quirk for a specific platform. In case you
are going to address that make sure it does not come to be generic.

-- 
With Best Regards,
Andy Shevchenko



