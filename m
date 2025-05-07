Return-Path: <dmaengine+bounces-5091-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304AAAD368
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 04:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F136250485E
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 02:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB919AD5C;
	Wed,  7 May 2025 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AraOZxcW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67D1E884;
	Wed,  7 May 2025 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585644; cv=none; b=Y5tU/vibV6dHCUI2lRG16lLm9wCf5qiin0Mo/WLTNBB8PAAup5Rr74+5vowJphIRQaMH1Ugxm0u9715YdFnjdRjud+0VVxX9wsZecCgouqlq8rE54UFNNERoQ2jst7xmbzHmUt5QSdFL5CW+IZq6PS+2iA/7vo9+jbeX60y03h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585644; c=relaxed/simple;
	bh=vX2Sybd9nMIeRRLXHlUE1/EciwbFwJqaadiN/zlroEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWzOQDIYk/hZBCUQiGN/dgA0E9nMNzhX0DIux34TO99Pm8PwP0RLvQ1KD9uYgJsTMi39HjXoxQlHmXjEtM4NQJg1YwnNCL6RmEPLChTRj3BTpfKG1iPjxwbHEIzbsZ9v5OcOjTrdAibBUdbr9NL7OfDcEz9jePuC6sMDqA+wREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AraOZxcW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746585643; x=1778121643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vX2Sybd9nMIeRRLXHlUE1/EciwbFwJqaadiN/zlroEc=;
  b=AraOZxcWpDHXxM4XxkfnMQOlPr3o4Y209MZrLCOuq4Q8W4zcbJyMjdfu
   hoRTm/L2taMimybhKQzboFlVbThMWiAS6Xz5b2ExXr46LkQ0OGQTf/21X
   ZTcvjXaSefstGYzIoxL/dQm2LFZjIj4xlool2Ebag1MHBuqit71BqDGW7
   n4JIm8RpPSlGOUJhu/dFYvt9ws7QLoJxFJwx5Ic67jH4VLp70ZF7PgxBB
   AOW8Etg5orXCVwLwOO687itNWan3Fi7OKAVdA/Dl+QdDmR1qNXb2TQokR
   B7RxdPCOQp27Ub/ibJ7BsUBZ/kyQeYathd5NfpDldgRW76uRP2PKxlhv9
   Q==;
X-CSE-ConnectionGUID: cL1NKU/1TSOGS/iMgxpP/g==
X-CSE-MsgGUID: 8F0SfwA+SamoyvtXukzIDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="59279744"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="59279744"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 19:40:39 -0700
X-CSE-ConnectionGUID: WToWiXUKRsCixUbf6ZG9SA==
X-CSE-MsgGUID: ugdGx6viS4q54g2OqEmvKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="136332970"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 06 May 2025 19:40:34 -0700
Date: Wed, 7 May 2025 10:35:21 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?utf-8?B?U8Oh?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	nuno.sa@analog.com, linux-clk@vger.kernel.org,
	linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v4 3/7] include: linux: move adi-axi-common.h out of fpga
Message-ID: <aBrG6cVNwvar8fAz@yilunxu-OptiPlex-7050>
References: <20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com>
 <20250505-dev-axi-clkgen-limits-v4-3-3ad5124e19e1@analog.com>
 <20250505193001.1183e7cc@jic23-huawei>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505193001.1183e7cc@jic23-huawei>

On Mon, May 05, 2025 at 07:30:01PM +0100, Jonathan Cameron wrote:
> On Mon, 05 May 2025 17:41:34 +0100
> Nuno Sá via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
> 
> > From: Nuno Sá <nuno.sa@analog.com>
> > 
> > The adi-axi-common.h header has some common defines used in various ADI
> > IPs. However they are not specific for any fpga manager so it's
> > questionable for the header to live under include/linux/fpga. Hence
> > let's just move one directory up and update all users.
> > 
> > Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO

Acked-by: Xu Yilun <yilun.xu@intel.com>

> 
> > ---
> >  drivers/clk/clk-axi-clkgen.c              | 2 ++
> >  drivers/dma/dma-axi-dmac.c                | 2 +-
> >  drivers/hwmon/axi-fan-control.c           | 2 +-
> >  drivers/iio/adc/adi-axi-adc.c             | 3 +--
> >  drivers/iio/dac/adi-axi-dac.c             | 2 +-
> >  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
> >  drivers/spi/spi-axi-spi-engine.c          | 2 +-
> >  include/linux/{fpga => }/adi-axi-common.h | 0
> >  8 files changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> > index 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a0c91a648005b3e6 100644
> > --- a/drivers/clk/clk-axi-clkgen.c
> > +++ b/drivers/clk/clk-axi-clkgen.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/err.h>
> >  
> > +#include <linux/adi-axi-common.h>
> > +
> >  #define AXI_CLKGEN_V2_REG_RESET		0x40
> >  #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
> >  #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > index 36943b0c6d603cbe38606b0d7bde02535f529a9a..5b06b0dc67ee12017c165bf815fb7c0e1bf5abd8 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -6,6 +6,7 @@
> >   *  Author: Lars-Peter Clausen <lars@metafoo.de>
> >   */
> >  
> > +#include <linux/adi-axi-common.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/device.h>
> > @@ -22,7 +23,6 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> > -#include <linux/fpga/adi-axi-common.h>
> >  
> >  #include <dt-bindings/dma/axi-dmac.h>
> >  
> > diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
> > index 35c862eb158b0909dac64c2e9f51f0f9f0e8bf72..b7bb325c3ad966ed2a93be4dfbf4e20661568509 100644
> > --- a/drivers/hwmon/axi-fan-control.c
> > +++ b/drivers/hwmon/axi-fan-control.c
> > @@ -4,9 +4,9 @@
> >   *
> >   * Copyright 2019 Analog Devices Inc.
> >   */
> > +#include <linux/adi-axi-common.h>
> >  #include <linux/bits.h>
> >  #include <linux/clk.h>
> > -#include <linux/fpga/adi-axi-common.h>
> >  #include <linux/hwmon.h>
> >  #include <linux/hwmon-sysfs.h>
> >  #include <linux/interrupt.h>
> > diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> > index c7357601f0f869e57636f00bb1e26c059c3ab15c..87fa18f1ec96782556bdfad08bedb5e7549fb93d 100644
> > --- a/drivers/iio/adc/adi-axi-adc.c
> > +++ b/drivers/iio/adc/adi-axi-adc.c
> > @@ -6,6 +6,7 @@
> >   * Copyright 2012-2020 Analog Devices Inc.
> >   */
> >  
> > +#include <linux/adi-axi-common.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/clk.h>
> > @@ -20,8 +21,6 @@
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  
> > -#include <linux/fpga/adi-axi-common.h>
> > -
> >  #include <linux/iio/backend.h>
> >  #include <linux/iio/buffer-dmaengine.h>
> >  #include <linux/iio/buffer.h>
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> > index b143f7ed6847277aeb49094627d90e5d95eed71c..581a2fe55a7fb35f1a03f96f3a0e95421d1583e7 100644
> > --- a/drivers/iio/dac/adi-axi-dac.c
> > +++ b/drivers/iio/dac/adi-axi-dac.c
> > @@ -5,6 +5,7 @@
> >   *
> >   * Copyright 2016-2024 Analog Devices Inc.
> >   */
> > +#include <linux/adi-axi-common.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/bits.h>
> >  #include <linux/cleanup.h>
> > @@ -23,7 +24,6 @@
> >  #include <linux/regmap.h>
> >  #include <linux/units.h>
> >  
> > -#include <linux/fpga/adi-axi-common.h>
> >  #include <linux/iio/backend.h>
> >  #include <linux/iio/buffer-dmaengine.h>
> >  #include <linux/iio/buffer.h>
> > diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> > index 4259a0db9ff45808eecae28680473292d165d1f6..e720191e74558d15f1b04fa18cf2984299f88809 100644
> > --- a/drivers/pwm/pwm-axi-pwmgen.c
> > +++ b/drivers/pwm/pwm-axi-pwmgen.c
> > @@ -18,10 +18,10 @@
> >   * - Supports normal polarity. Does not support changing polarity.
> >   * - On disable, the PWM output becomes low (inactive).
> >   */
> > +#include <linux/adi-axi-common.h>
> >  #include <linux/bits.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > -#include <linux/fpga/adi-axi-common.h>
> >  #include <linux/io.h>
> >  #include <linux/minmax.h>
> >  #include <linux/module.h>
> > diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> > index 7c252126b33ea83fe6a6e80c6cb87499243069f5..d498132f1ff6adf20639bf4a21f1687903934bec 100644
> > --- a/drivers/spi/spi-axi-spi-engine.c
> > +++ b/drivers/spi/spi-axi-spi-engine.c
> > @@ -5,9 +5,9 @@
> >   *  Author: Lars-Peter Clausen <lars@metafoo.de>
> >   */
> >  
> > +#include <linux/adi-axi-common.h>
> >  #include <linux/clk.h>
> >  #include <linux/completion.h>
> > -#include <linux/fpga/adi-axi-common.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/of.h>
> > diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/adi-axi-common.h
> > similarity index 100%
> > rename from include/linux/fpga/adi-axi-common.h
> > rename to include/linux/adi-axi-common.h
> > 
> 

