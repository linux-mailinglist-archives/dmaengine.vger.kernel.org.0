Return-Path: <dmaengine+bounces-3301-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 917E4995563
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 19:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0432A286180
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 17:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3091B1E1048;
	Tue,  8 Oct 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLQ1HcRY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678291E1A07;
	Tue,  8 Oct 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407542; cv=none; b=C2CDOWLZbMxtD6uNI3TE+p4cISpb2pEjmQcFD/PdxprRyW8hb3UDu0EnIDKeEAwMulCbGMcn0KiHQaXkKgWge1IXxT4GRlIftTkyJlO5S182p4i1W7I+9tFtBYRfonozoQpmL+RxZaIxgoCOiVFZ2CGnMYQXUWnHMg+DIOd5nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407542; c=relaxed/simple;
	bh=0fw1hymyyqi0Df5uzZWmYjSJPG0NJZJROfytNQQiCkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko5VFQBqHGLFaxML4MPNGcI2skpJNKQUseCLiJoo0CJ8Hv6dLMxR4+xTW0RT4pbXfCQETkld9YZDWVsKP5BOxYjMb8GKV1s3F05te4QKsCpm6JB4CpLvwUyyx6ZSXVZfQhE4DygkRVDQk6c0LY54t8Oan/8UFPGgXgr1y96mG6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLQ1HcRY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728407540; x=1759943540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0fw1hymyyqi0Df5uzZWmYjSJPG0NJZJROfytNQQiCkQ=;
  b=hLQ1HcRYAMSJu4+TUmWeHfAtqNdkPJgLFP+7wl2vR3mOXNKrcbZd3ToW
   ajGIUvUdm83gl5AQrrVD57ibNFVJRMsVp6U0+WsyZrmR8z7xF/n/ZQQIY
   hBs+u3W/JlI4od7bJShl91+rYwIDStFnZ5Kv2T1wzTqhoKxtvA3R6oP3d
   zqh5VCZaB3oOBqe39ioST6CGBmhCkmheS68E3IKntFJMUJzRN6mIO1bPg
   GBd5JrLau7DY/dA3fJy6lPvT6gnsDao+c+n8jGEHMKJdnU7/+44JftUAr
   STL2xmLKkV9ZSt76Whpw8onHz/QPzf1o3Emj35a0/YmXjYKmg3CIzMxb3
   A==;
X-CSE-ConnectionGUID: KScj36OUSbuMRcFyybz3fw==
X-CSE-MsgGUID: 9TC6PkIYTqOubskinyDk7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38988006"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="38988006"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:12:19 -0700
X-CSE-ConnectionGUID: KKRpSUlfRYCWaXPJjO7TZQ==
X-CSE-MsgGUID: EW0XMCXnSM6l8GusStFT+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="106668324"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 10:12:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 77AAC20F; Tue, 08 Oct 2024 20:12:15 +0300 (EEST)
Date: Tue, 8 Oct 2024 20:12:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 2/4] dmaengine: Use dma_request_channel() instead of
 __dma_request_channel()
Message-ID: <ZwVn7witZ3Bt8ktu@black.fi.intel.com>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
 <20241007150852.2183722-3-andriy.shevchenko@linux.intel.com>
 <ZwQF0skPo0zJ7Uzd@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQF0skPo0zJ7Uzd@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 07, 2024 at 12:01:22PM -0400, Frank Li wrote:
> On Mon, Oct 07, 2024 at 06:06:46PM +0300, Andy Shevchenko wrote:
> > Let's reduce the surface of the use of __dma_request_channel().
> > Hopefully we can make it internall to the DMA drivers or kill for good
> > completely.
> 
> Suggest:
> 
> Reduce use internal __dma_request_channel() function in public
> dmaengine.h

Okay.

> I think this change is okay, but I hope the following patches, which make
> __dma_request_channel() as internal only. otherwise, it looks not necessary.

As explained in the commit message it's the first baby step to this
direction. But sure, when I have more time I'll continue. In any case
I think this change is good on this own as it shows the use inside the
header.  The people who want to have an example of the use may wrongly
take the existing code as "good to go" and this even might pass the
review somewhere. That said, it's not only reducing the use, but has an
educational purpose as well.

-- 
With Best Regards,
Andy Shevchenko



