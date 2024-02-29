Return-Path: <dmaengine+bounces-1188-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0588E86C775
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 11:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AB21C2322C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061D7A706;
	Thu, 29 Feb 2024 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWVZ0rdQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622046351C;
	Thu, 29 Feb 2024 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204081; cv=none; b=ueukYRqLzXuUDLTyfAC2KPtv2XlmXThvFaKBFpcRrmY+ccjtD0fT1uGp8tS+H1aeG3c38BQPxfn5TNnsm8IwXdnlID80EK2yay9seGsw/IXajCfDBsKpPyUd/aQ95p+XLfU9CI1LObNOvdNSJsHq4OoF2Uj/jEN6OAt6/Ik4CVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204081; c=relaxed/simple;
	bh=SxVA8/lAGPXj7aJ44Uc6WXqxSXmTeZTF1kbZzTL+u+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS5AGxik6qVQDELx2dwlrEgzEJpws+gYIkolw2pZnjrg2/24k9mS2euJ5zz4hAwAHWK1dnaUPqP/9woqa1DDKjUgqegyW0rAq95I8irRcgWk3R4ioNK8PdcEDk/l1ARcnuWGwSpTR2shoTNvmUHPcq+CgZBwAhQfAJ+WJDNvJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWVZ0rdQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709204081; x=1740740081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SxVA8/lAGPXj7aJ44Uc6WXqxSXmTeZTF1kbZzTL+u+8=;
  b=jWVZ0rdQt5go+ZpxRpiDtn6ggJHBJsD42o6n+qWqRJsoH7DO2KLPZQQY
   qRUZ9t3s9H5wuMKbcn3j78vTeEjRkv2SGzZJvlComnEOHIsZMcyLcUz/6
   Ohothe0O1oSRRDkUxrYeZV4xWAwXHFT6SM/Gm5enrQUZCokdhtJD7Ib2Q
   zpvzwjI17Lda0OEQIuW0v6FClOi6pyRUuJ87p1I0X8brVlh4oOF3DdE1L
   CTHmkRmak51Hedc0QV7xaEe2IhsZP1Jn7dhxzPokMjLHlXS1csClwskgI
   bXsRzJYjQ3vitpBII1MrMCGoLUqlh7o2uzKAs1XoUgOQpnn8iVdDM664k
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21122607"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21122607"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913978961"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913978961"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:54:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfe3b-00000008e8j-2Ooc;
	Thu, 29 Feb 2024 12:54:31 +0200
Date: Thu, 29 Feb 2024 12:54:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <ZeBiZ_aulsAqP83c@smile.fi.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook>
 <20240228144148.5c227487@kernel.org>
 <202402281554.C1CEEF744@keescook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402281554.C1CEEF744@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 04:01:49PM -0800, Kees Cook wrote:
> On Wed, Feb 28, 2024 at 02:41:48PM -0800, Jakub Kicinski wrote:
> > On Wed, 28 Feb 2024 13:46:10 -0800 Kees Cook wrote:

...

> But I still like the idea -- Gustavo has been solving these cases with
> having two structs, e.g.:
> 
> struct net_device {
> 	...unchanged...
> };
> 
> struct net_device_alloc {
> 	struct net_device	dev;
> 	u32			priv_size;
> 	u8			priv_data[] __counted_by(priv_size) __aligned(NETDEV_ALIGN);
> };
> 
> And internals can use struct net_device_alloc...

I just realized that I made same approach in 

f6d7f050e258 ("spi: Don't use flexible array in struct spi_message definition")
75e308ffc4f0 ("spi: Use struct_size() helper")


-- 
With Best Regards,
Andy Shevchenko



