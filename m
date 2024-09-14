Return-Path: <dmaengine+bounces-3161-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1D9979332
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 21:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4986B2282B
	for <lists+dmaengine@lfdr.de>; Sat, 14 Sep 2024 19:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B67D417;
	Sat, 14 Sep 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdeBC3gY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA505C2C8;
	Sat, 14 Sep 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726341161; cv=none; b=bqYzbDX5UQwWSiZqXprmWO8beAKXL7A5BgGqeubPdkFg1WF9L9ijErdnR+6xgtsjMrZgXxLyKAxOs4+48l8qSXpPugSlEd1Uh9gPhlDM6nbjjOBCeZeD66TdiqCnpsx6tCjWBi8yux1AMbEjf6d/Ns8jorAxIkBM3ekTL9GCk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726341161; c=relaxed/simple;
	bh=mcUQixhdnK2aPn9HVH6fLWBcBl50B4cNgoVwv6sKlf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td1bBrz8RUZBwdxfmrstURTKrrorY6LZyOFBMTJ2lvTSHTdKMiYkTJ6hIZwEDNSC8urxDiGTU5CJwYwg6gASfuuK2SeMPC11VNJiFK2P6srwQsfasEDJDflB7N95BbYCMiRe7t/FhNJglNvYZR2yeGDYgcHrgRm4ygqx+K6jIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdeBC3gY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726341160; x=1757877160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcUQixhdnK2aPn9HVH6fLWBcBl50B4cNgoVwv6sKlf0=;
  b=PdeBC3gY2Aw16luFrvx/WXQshzG2aA6vBiniW8R6Y89f+ngLd4RmCKom
   KFzqnR3xuyjB+QOJynvv8iBgi77I99EHH11K3nFD6wyeR0oOEVkU9Qgxg
   r7OyiD9vzDVnAmMo+fBxjmsDLrxzl+XMKb2rFW/L4XKRuha5f5ZR0A7Qs
   /UciWaqlKG1PX7cvOwWpzdvRPYi6TQw8Q8T365m8h3y8jSrx79Osp/7Jj
   2xpS7X5ggMvnN+zDr7v6CT7nz9g2a5Vmg9k0+dxHwuD7UdWUtmrlf0hEj
   Fb8OOOCHDCmXCi6KY50uMgU8oL1keKuGnYg27A0nTGvcXZnj1H5azr6E5
   Q==;
X-CSE-ConnectionGUID: 80CNMxQBQ7C9w2X+1ELzBQ==
X-CSE-MsgGUID: VkJE8ZapQn2LQ2SP3tX7Mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25320197"
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="25320197"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 12:12:39 -0700
X-CSE-ConnectionGUID: LIXJ9f+rTaWQxAbNOw8J/w==
X-CSE-MsgGUID: FkCOIfrrS3inh6xi629n0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,229,1719903600"; 
   d="scan'208";a="73049902"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 14 Sep 2024 12:12:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E249432A; Sat, 14 Sep 2024 22:12:35 +0300 (EEST)
Date: Sat, 14 Sep 2024 22:12:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/6] dmaengine: dw: Add peripheral bus width
 verification
Message-ID: <ZuXgI-VcHpMgbZ91@black.fi.intel.com>
References: <20240802075100.6475-1-fancer.lancer@gmail.com>
 <20240802075100.6475-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802075100.6475-2-fancer.lancer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 02, 2024 at 10:50:46AM +0300, Serge Semin wrote:
> Currently the src_addr_width and dst_addr_width fields of the
> dma_slave_config structure are mapped to the CTLx.SRC_TR_WIDTH and
> CTLx.DST_TR_WIDTH fields of the peripheral bus side in order to have the
> properly aligned data passed to the target device. It's done just by
> converting the passed peripheral bus width to the encoded value using the
> __ffs() function. This implementation has several problematic sides:
> 
> 1. __ffs() is undefined if no bit exist in the passed value. Thus if the
> specified addr-width is DMA_SLAVE_BUSWIDTH_UNDEFINED, __ffs() may return
> unexpected value depending on the platform-specific implementation.
> 
> 2. DW AHB DMA-engine permits having the power-of-2 transfer width limited
> by the DMAH_Mk_HDATA_WIDTH IP-core synthesize parameter. Specifying
> bus-width out of that constraints scope will definitely cause unexpected
> result since the destination reg will be only partly touched than the
> client driver implied.
> 
> Let's fix all of that by adding the peripheral bus width verification
> method and calling it in dwc_config() which is supposed to be executed
> before preparing any transfer. The new method will make sure that the
> passed source or destination address width is valid and if undefined then
> the driver will just fallback to the 1-byte width transfer.

This patch broke Intel Merrifield iDMA32 + SPI PXA2xx configuration to
me. Since it's first in the series and most likely the rest is
dependent and we are almost at the release date I propose to roll back
and start again after v6.12-rc1 will be out. Vinod, can we revert the
entire series, please?

-- 
With Best Regards,
Andy Shevchenko



