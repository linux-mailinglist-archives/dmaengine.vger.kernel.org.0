Return-Path: <dmaengine+bounces-1886-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3048A9650
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 11:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920F2B23094
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134515ADB7;
	Thu, 18 Apr 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5t0i7wA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C44F15AAD9;
	Thu, 18 Apr 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433036; cv=none; b=EUg9CFljpfyFWu6RdkAFuuvcE/qQYh0s3EW6/XaA5HXw/9p3V2rVOwn7W82bWwwP9tyJeN8CRrRj+FvqTWBYh6rlzJgEW1j522v8JcAQqRagg1rByrjEEFsAnOE0RORBVSucIfxenMq4vnV8q3w5RzAyGBJ76jHp2l0gx5OCfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433036; c=relaxed/simple;
	bh=oGYvt4iKMHHWhGz5AK/8DOoOoy2yJB9YCvtzW26d0Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k71v7luL+vtvbi5SdH2uuJZwrGPwy+lAC7wupQrQgxPW7aQdMU6pgwkdMBCVw/0boY0kR6j6SpWkZ7IXGVo4VuzRPFsb+qCxuzLdLXrvk5iubuCex1caaAbTR46dBgj83NZMgbQa88RMlMZSz5JlB/x9xqZLIbda6lKTzy4CUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5t0i7wA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713433036; x=1744969036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oGYvt4iKMHHWhGz5AK/8DOoOoy2yJB9YCvtzW26d0Ds=;
  b=G5t0i7wA4XvHrJYtnrbsvyEVvSMzzGUTiOhXAfLocK2PWQSE3dVsb+c6
   HwU6HUyiSP8IIdEdGQN5c2nRlf7v9O772dt79VOG88spXHiZl9xP1AQ0L
   jXmB2B2kmtClhlT/ajvvwtJKJEETaGuBs8LxxcGbQCZRCsegCf8no1jMK
   KhKSb93pNb4g7dfUtpXoVKJbO8+PWEHgTeK8muaVo2ZEY8ZCqHyECRKiA
   PJr7yfKjevOb290pHEhOyypZfqfOM8wk9xnqiv5NkwC1OGjCNeh4Ihwyc
   iEPeZ1q8BYzrqF6hKiU/+Ti7mL5gZG8oxr27ZTIz8uSgcKvWZqVtdftaH
   g==;
X-CSE-ConnectionGUID: 3kKKTdjQQDWvgcA4tG5DwA==
X-CSE-MsgGUID: MiuPENkeSn6e+duh/XMP/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20114225"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="20114225"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:37:15 -0700
X-CSE-ConnectionGUID: TJ+NKD5eTfi9RFMXbh3Fvw==
X-CSE-MsgGUID: J6qdL3rrSyO1+VGtr5HN/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27699688"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:37:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxOCb-00000000Hkt-3eLe;
	Thu, 18 Apr 2024 12:37:09 +0300
Date: Thu, 18 Apr 2024 12:37:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] dmaengine: dw: Add memory bus width verification
Message-ID: <ZiDpxb-diEt91My4@smile.fi.intel.com>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-3-fancer.lancer@gmail.com>
 <Zh7Hpuo-TzSmlz69@smile.fi.intel.com>
 <lzipslbrr4fkpqc3plfllltls2sy2mrlentp7clpjoppvgscoi@zlmysqym2kyb>
 <ZiAGpsldQMB-dKkn@smile.fi.intel.com>
 <nroj7c7hvo5ao5gfuububc2zqj7z4rpkoji5flhbrie3xrmgwg@6rhzllxwgj4w>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nroj7c7hvo5ao5gfuububc2zqj7z4rpkoji5flhbrie3xrmgwg@6rhzllxwgj4w>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 09:52:42PM +0300, Serge Semin wrote:
> On Wed, Apr 17, 2024 at 08:28:06PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 17, 2024 at 08:13:59PM +0300, Serge Semin wrote:

...

> > Got it. Maybe a little summary in the code to explain all this magic?
> 
> Will it be enough to add something like this:
> /*
>  * It's possible to have a data portion locked in the DMA FIFO in case
>  * of the channel suspension. Subsequent channel disabling will cause
>  * that data silent loss. In order to prevent that maintain the src
>  * and dst transfer widths coherency by means of the relation:
>  * (CTLx.SRC_TR_WIDTH * CTLx.SRC_MSIZE >= CTLx.DST_TR_WIDTH)
>  */

Yes, and you may add something like
"Look for the details in the commit message that brings this change."
at the end of it.

-- 
With Best Regards,
Andy Shevchenko



