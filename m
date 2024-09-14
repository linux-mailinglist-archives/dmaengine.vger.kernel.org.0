Return-Path: <dmaengine+bounces-3158-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1373979304
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 20:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8482282EE9
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BE71D1312;
	Sat, 14 Sep 2024 18:50:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E01CF5D2;
	Sat, 14 Sep 2024 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726339854; cv=none; b=aT9ARfNZKtWvVdHvYmzhw6i7KGJnhHm46G0qbupd476buKbbtMk5JU7CBHUK7AXxKZDtCvGZ8bn5LkckqE+ETlrVyXctGqky6W7bfjVv0VK4qFJhoi7BIZtAMSx5l1L3lzofRKlpaP9wp/gn/1LUb8C9uDCfvTOD40arFpAq5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726339854; c=relaxed/simple;
	bh=1+0i56bgZWFuRczRUSZOUy6y6O3IBgMKZJEbVdhGTMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1T3gQeUU9KsvsVW2Lv1y3ZzEF+n4lC/FDDq24gy+U5XusyReUDFkfKF2yLF7dkZkh5m2yKaKKUjeJPSkeoblEYs3Q0+FBzjnvPWpL8TRqQ0M23RQxuoqaolrwprWnrqLcLRnVpT1ppV8LcuIM5OddBEwLlXI1JYS1LICnMaFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: JcQCkXBnQWGIpL2noeEPJg==
X-CSE-MsgGUID: wj9o/3EVQu2+GpsGYgv90Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="35807446"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="35807446"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 11:50:52 -0700
X-CSE-ConnectionGUID: Yw+FtJ8qTrqIUtQscRy50Q==
X-CSE-MsgGUID: pgMcnzDpR7qiQnIVDNhQjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="68954373"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 14 Sep 2024 11:50:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B444032A; Sat, 14 Sep 2024 21:50:48 +0300 (EEST)
Date: Sat, 14 Sep 2024 21:50:48 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/6] dmaengine: dw: Fix src/dst addr width
 misconfig
Message-ID: <ZuXbCKUs1iOqFu51@black.fi.intel.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <CAHp75VcnfrOOC610JxAdTwJv8j1i_Abo72E0h1aqRbrYOWRrZw@mail.gmail.com>
 <rsy7z45nhl74nzvq5a2ij4eeqgzu3htje2xpparxgam7jowo6a@6l75wjh2dqll>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rsy7z45nhl74nzvq5a2ij4eeqgzu3htje2xpparxgam7jowo6a@6l75wjh2dqll>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 05, 2024 at 03:25:35PM +0300, Serge Semin wrote:
> On Sat, Aug 03, 2024 at 09:29:54PM +0200, Andy Shevchenko wrote:
> > On Fri, Aug 2, 2024 at 9:51 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> > >
> > > The main goal of this series is to fix the data disappearance in case of
> > > the DW UART handled by the DW AHB DMA engine. The problem happens on a
> > > portion of the data received when the pre-initialized DEV_TO_MEM
> > > DMA-transfer is paused and then disabled. The data just hangs up in the
> > > DMA-engine FIFO and isn't flushed out to the memory on the DMA-channel
> > > suspension (see the second commit log for details). On a way to find the
> > > denoted problem fix it was discovered that the driver doesn't verify the
> > > peripheral device address width specified by a client driver, which in its
> > > turn if unsupported or undefined value passed may cause DMA-transfer being
> > > misconfigured. It's fixed in the first patch of the series.
> > >
> > > In addition to that three cleanup patches follow the fixes described above
> > > in order to make the DWC-engine configuration procedure more coherent.
> > > First one simplifies the CTL_LO register setup methods. Second and third
> > > patches simplify the max-burst calculation procedure and unify it with the
> > > rest of the verification methods. Please see the patches log for more
> > > details.
> > >
> > > Final patch is another cleanup which unifies the status variables naming
> > > in the driver.
> > 
> > Acked-by: Andy Shevchenko <andy@kernel.org>
> 
> Awesome! Thanks.

Not really :-)
This series broke iDMA32 + SPI PXA2xx on Intel Merrifield. I haven't
had time to investigate further, but rolling back all patches helps.

+Cc: Ferry who might also test and maybe investigate as he reported the
issue to me initially.

-- 
With Best Regards,
Andy Shevchenko



