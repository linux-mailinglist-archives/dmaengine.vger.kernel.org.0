Return-Path: <dmaengine+bounces-7233-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B934BC657F8
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 18:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D9F43A0222
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED717306D5F;
	Mon, 17 Nov 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZu4/Xeq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E396257AEC;
	Mon, 17 Nov 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399153; cv=none; b=FMB9taMqxBN/vKsn0e30EhctWNRn7mNHD7/pilJzGHsrF31KgQabPoFOf4M8NfeOAg93iv17IcaCIRQ+6wIgBxb3CjbnNn257ExVBe86ffCoqoiMd5qD8ZKjTdGTKkW0QRBEmTR4HgXF5rpw6I5lSbjiuUOsQsn97xwBYAZ79G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399153; c=relaxed/simple;
	bh=DW7iOnljyYkbqTKlwa33/VbgEj6oPP1CWbEhzObBsXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flG6Km5m21rvhU69bYQVcAX1Z1MCghle6gg9aEXixxyuu1adJSIgAA0ssGsAUEiBWpv7NuizpNTU1hYQkYi04nCPeon8HKIsFMBsiPLpiwonnsfLkb9OvAC9ax1NhVaVjoVOZBERVJqK9TMKSD8D/ajaNXDveA4FSx/IX6A7TPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZu4/Xeq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763399152; x=1794935152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DW7iOnljyYkbqTKlwa33/VbgEj6oPP1CWbEhzObBsXc=;
  b=YZu4/Xeq9BaO85fNoSbOCQbTZ4PCcbTXF9r1ZFPrBmu+GZpTdc5Vsqnc
   3pMbZV2gy/B1YbteIg5Vv5sasoCYe7ryIjEnxBml6HC6rIhAlYNmYAQwi
   D8XVLvZLXG78vvUwwsybEyzJKYpjawxv0XKCXhT8cNguDVqcY6FJgSzdd
   qXFfYlaE117eYlpXnqiI5L119kaBfJZkCGtzlxGrn/DeXQBBen60SZFjZ
   paXzOSX78ivz4VqinVyCLpHqt2bQhGNoDnUlgAIQzfZOfBVL2Ax13YWiw
   AigUDjlb/qviEbylNcWKlDhaes/trXTuAQuzDwlGduFZhqNkw+S16UPPO
   w==;
X-CSE-ConnectionGUID: +exPuRqmSvCLf45Z6SoFqw==
X-CSE-MsgGUID: 2gkV8T9pQSiqz+ShTlVznA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65340685"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="65340685"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:05:52 -0800
X-CSE-ConnectionGUID: ROs6gZk+TG6RiG6eKeZEiw==
X-CSE-MsgGUID: KIco31o0QSKRXkO77XTL5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="190524483"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 17 Nov 2025 09:05:48 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2684C96; Mon, 17 Nov 2025 18:05:47 +0100 (CET)
Date: Mon, 17 Nov 2025 18:05:47 +0100
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 04/15] dmaengine: dw: dmamux: fix OF node leak on route
 allocation failure
Message-ID: <aRtV69UcldVcYiKR@black.igk.intel.com>
References: <20251117161258.10679-1-johan@kernel.org>
 <20251117161258.10679-6-johan@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117161258.10679-6-johan@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 17, 2025 at 05:12:47PM +0100, Johan Hovold wrote:
> Make sure to drop the reference taken to the DMA master OF node also on
> late route allocation failures.

...

> +put_dma_spec_np:
> +	of_node_put(dma_spec->np);

Can we use __free() instead?

(Just in case you are going to question the appearance of cleanup.h and the
 respective class in of.h, it's available in the closest stable, i.e.
 v6.1.108 onwards).

-- 
With Best Regards,
Andy Shevchenko



