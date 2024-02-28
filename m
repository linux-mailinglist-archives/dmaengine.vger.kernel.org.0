Return-Path: <dmaengine+bounces-1168-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EFD86BA0D
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE5528B493
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F0570040;
	Wed, 28 Feb 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eL65Ly63"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1270030;
	Wed, 28 Feb 2024 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156214; cv=none; b=eicFbG1g870D99iA6ULZoLEPzfdnKdGhkGM6Ku6bG6GdYOdRYm6y8r60uvrmCMX2FsY1rVc5jLCxOF+dJg7xZDabo+nniBcMsfDcwDs9Xda/OcPxfngYwJ3pyN4vJF4RBS6RbBUdnwLObiKY0UyWh95sOt6hcCZrLB4GtDZo/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156214; c=relaxed/simple;
	bh=8PJmKytlSsprccUo0R3nWiiL/iIqexJcXLdDR7loiNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ee1Bviaoz55ZgkSzfH1SWipSZPh4ypAr4UFn6T8ITL0UGB5or04ElE6X0dlLhHQruqH1MK3fo8SrSptL2Ye3sQsOW8HNUPjBI/mCDN+F+RZPN0zjDdnBTRNaWqs2v7eQXx3AHcM0kSaajYg1QkGFdld6bqQTNVamFNYOmWmbXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eL65Ly63; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709156213; x=1740692213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8PJmKytlSsprccUo0R3nWiiL/iIqexJcXLdDR7loiNY=;
  b=eL65Ly63fx4Yl7pAF6PDLA0r3v1SN7MARruIYDQxEuGA2tsDyCYr42pJ
   ndzqbPuKWn3U0YlbauAg5MZoYGa900F2biTgNljy8yRETFnkjEfaQf8M5
   olX2HEpAer7d7B0XBrNueOTYfJ0WnVZRzPdD3uyID+GovZswZJhL/BRyF
   A03OTuXnWwyVTX4LT59KMrWEHToQaUOgtS/RuhIatRoop5pvmPzpU7nhP
   DGvfn1PeC9e/H8A9+8odx3vWM4lmtE0W53X5oPJ6DdMDSKdZck+r4VKkc
   k7FCdcat+UAe3ty2YmtOWJZo3K1mL/kvhvwseiimZ8twYgBnu9MJaLjTw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7371106"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7371106"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:36:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913961929"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913961929"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:36:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfRbX-00000008VcR-2Fpg;
	Wed, 28 Feb 2024 23:36:43 +0200
Date: Wed, 28 Feb 2024 23:36:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 3/8] iio: core: NULLify private pointer when there is
 no private data
Message-ID: <Zd-na3oVV4Chl4Ft@smile.fi.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-4-andriy.shevchenko@linux.intel.com>
 <CAMknhBFbQ2BmGd18wC0odO-b_bWvJEO3FCYEtpvhB1fF+MEFgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBFbQ2BmGd18wC0odO-b_bWvJEO3FCYEtpvhB1fF+MEFgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 03:06:42PM -0600, David Lechner wrote:
> On Wed, Feb 28, 2024 at 2:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > -       indio_dev->priv = (char *)iio_dev_opaque +
> > -               ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
> > +
> > +       if (sizeof_priv)
> > +               indio_dev->priv = (char *)iio_dev_opaque +
> > +                       ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
> > +       else
> > +               indio_dev->priv = NULL;
> 
> Do we actually need the else branch here since we use kzalloc() and
> therefore indio_dev->priv should already be NULL?

This is more robust, but I'm okay to drop this. Up to Jonathan.

-- 
With Best Regards,
Andy Shevchenko



