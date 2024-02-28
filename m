Return-Path: <dmaengine+bounces-1171-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7786BA37
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37320B23DA2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151547004F;
	Wed, 28 Feb 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6BSONfd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC595E09F;
	Wed, 28 Feb 2024 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157095; cv=none; b=AZTaZAGLt3UlODfOSdEj0lRQtRan1xPue7idnOXJmt1055u3RG98nbO+Y41ZJKS6t1Hk4U/vSBDg6D3pLukk2eOkzpLxnOWbFX5UMbfalG/WglU6NSz+ogNJNboaZRwSsXxDTf1y8CrTpnMjnr7Dzb+iembGy+DrIEEwmhRNqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157095; c=relaxed/simple;
	bh=cTXPciNmp57QN/LMHOfsPfOz4graJiRWh79HJ0KYXuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n09AcRZNN1sc2OvwFmUtuOgp/L0FahxgK8vR4pMODe5QUamFTnPe+hFTCzFeG80CEvFlnAPmzC7iZYCxaDYkzAtgOxgyo265vyT+yj6eXsQm+DRip8AMZ9mjszBdGIE+f4OOCbRiNlCaTO60E4iBY2uu+ZbEIJmu97ocNFdYYmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6BSONfd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709157093; x=1740693093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTXPciNmp57QN/LMHOfsPfOz4graJiRWh79HJ0KYXuk=;
  b=e6BSONfdONVOSvm4MAPjg8bB0h05vwmBA9KcI30G5fTyf43XvRvrF/hN
   CTVEQe8XQtJ9jSqzfCF+1/zRvOI5ng2+P57KxiOFbDcmldBTmDtEsHwEm
   nfGCo2xhkb6/KLAF22njjyFJv19nkI8zxT0wzqu1Pa7x29yZWZNpycWrD
   JWT/4gwA9d341aoAAkr3vh1lFTWv5UQ4RKrAgBY5x8cssaLWUkICQvR71
   ljhjGDFttMDC7SknI1UeidPEWR2giR3HSxBTf+liUfoMXC0ZtaEaGQ+oD
   At+n6vT9yV+GoLdJClnQSv1yukbaBNmAorvHjYsnXOnYT8Gwt+kCvurBF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7373182"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7373182"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913962180"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913962180"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:51:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfRpk-00000008VoK-0C32;
	Wed, 28 Feb 2024 23:51:24 +0200
Date: Wed, 28 Feb 2024 23:51:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
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
Subject: Re: [PATCH v4 2/8] overflow: Add struct_size_with_data() and
 struct_data_pointer() helpers
Message-ID: <Zd-q20FkC_3DQ14i@smile.fi.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-3-andriy.shevchenko@linux.intel.com>
 <202402281334.876DC89@keescook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402281334.876DC89@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 01:37:36PM -0800, Kees Cook wrote:
> On Wed, Feb 28, 2024 at 10:41:32PM +0200, Andy Shevchenko wrote:

...

> > +#define struct_data_pointer(p, a)	PTR_ALIGN((void *)((p) + 1), (a))
> 
> I'm not super excited about propagating the "p + 1" code pattern to find
> things after an allocation. This leads to the compiler either being
> blind to accesses beyond an allocation, or being too conservative about
> accesses beyond an object. Instead of these helpers I would much prefer
> that data structures that use this code pattern be converted to using
> trailing flexible arrays, at which point the compiler is in a much
> better position to reason about sizes.

There is nothing about flexible arrays in this.
Maybe you have been confused by my choice for name of the macros.
In that case I also can argue that current struct_size() is a good one.
(something like struct_size_with_flex_array() can be more specific)

-- 
With Best Regards,
Andy Shevchenko



