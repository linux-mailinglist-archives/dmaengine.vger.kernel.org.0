Return-Path: <dmaengine+bounces-1164-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD386B9A7
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76AF1C24DAF
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CB8626B;
	Wed, 28 Feb 2024 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CX3aAczP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8458624E;
	Wed, 28 Feb 2024 21:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154556; cv=none; b=IkGxPkKMzfNKy6ipKB4wr8LDLyBQgIKwD11JK+DWXHFmodrevvfaZkp1vlcGgOQYCYvmHvZnuf9dtqXocXP/oRu3aMfkjJxQBqD6fy+eftNwtFn7yjEqYv/GLNa0+zLB0xhB64M1DJdYVzs8QOK82+s5Ga1AUYahbPLtwAcFnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154556; c=relaxed/simple;
	bh=G8Wmbr6m2QvldTWEZEftdo6cYDTEwDtBJvSgnK5xsZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sx1O2ts0EQ903tdCJpJkq9nnh4dY4yKr+DhMHgtclaY+OMdn35jVAPufXmE/MK5/6/oYsV4KBdY29bovZM1r1t5BwVNvJbgprU8xfaNRD9tJC3ivUOHIK8QhRGCftXROw7FCXOBDHcMa9KE30ZWi9eUZ9UZBv56wkkEF7D5Qxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CX3aAczP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709154554; x=1740690554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G8Wmbr6m2QvldTWEZEftdo6cYDTEwDtBJvSgnK5xsZc=;
  b=CX3aAczPGXUlZjWItWyTQT+95gdt6txRD8rUO1fcUK8vc5z/wuZuCxgz
   hhAWV9Dk6Wu4L6Bp3AdUo3lRWKuHE43HBxbgFmYGxUslXtoMw/LN/TBco
   kAe3sPDbQIg3jXhqGtjrQvYwAEM6YOOtjIBUkz7ll2hFW/Bjs8CeaH1i3
   cYc8EhWYRGH+fWEVKLj6CLKOfkRMVRgAcKEBTU049EyQO3qVqxo/sv6SO
   heKF4D9SYTxj8zBG0N5n/apPyDa6NyN027ba/OE0+bh5znJbgqxob+svJ
   hE2dvIQObLEnA02tgLw+2U6Viy/bmuRJnjLbhHIVBd2FT3JB23GMUmJcp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3466664"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3466664"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:09:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913961424"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913961424"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:09:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfRAl-00000008V6C-2fJo;
	Wed, 28 Feb 2024 23:09:03 +0200
Date: Wed, 28 Feb 2024 23:09:03 +0200
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
Subject: Re: [PATCH v4 4/8] iio: core: Calculate alloc_size only once in
 iio_device_alloc()
Message-ID: <Zd-g7_Cl__Z291CQ@smile.fi.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-5-andriy.shevchenko@linux.intel.com>
 <CAMknhBGj_+hw0F-g3R6iY0HEooGH1a8gfj1hYx_Laj93OQbQwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBGj_+hw0F-g3R6iY0HEooGH1a8gfj1hYx_Laj93OQbQwQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 02:57:36PM -0600, David Lechner wrote:
> On Wed, Feb 28, 2024 at 2:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > -       alloc_size = sizeof(struct iio_dev_opaque);
> > -       if (sizeof_priv) {
> > -               alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN);
> > -               alloc_size += sizeof_priv;
> > -       }
> > +       if (sizeof_priv)
> > +               alloc_size = ALIGN(alloc_size, IIO_DMA_MINALIGN) + sizeof_priv;
> 
> Isn't this using alloc_size before it is assigned? Perhaps you meant this:
> 
>     alloc_size = ALIGN(sizeof(struct iio_dev_opaque),
> IIO_DMA_MINALIGN) + sizeof_priv;

However the end result of the series is correct, this is a good catch!
Thanks!

> > +       else
> > +               alloc_size = sizeof(struct iio_dev_opaque);

-- 
With Best Regards,
Andy Shevchenko



