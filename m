Return-Path: <dmaengine+bounces-1189-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8486C797
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3DD289686
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176E7A730;
	Thu, 29 Feb 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APKkcurN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF67A709;
	Thu, 29 Feb 2024 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204370; cv=none; b=imxLY4Jdt//eAnrW8cMoyvmsag/9lPaZialhVANaG6Oui1yacoNuEeaZWNpcFToXJwIjATqZj0h8QvfA0OTE2NNaZ56A4bauxstNeaqXP3BCT0mpzMlgOmXEh78+6/OU3Anhyc86zsikUyQaTxSgPOj6K9Hjo6/GV2FnCFGSuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204370; c=relaxed/simple;
	bh=YjdLAAQGiT0XCs7CLBYxxn9xZUUhhDnrttXTbBDNBak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAc+eK5Rz7DJuzQ7PeP+vIj95cFvofQbEBj2GhLihxLVuA1enKe2tQJ6N3nxbMY7f1o9kMAAH4jKrQuPe4QCqhOZ77x2O7I5K4QnBJlMCft4dAGjf5c0Eaun4dENmjxHfALhipvpnOFHO8ewrNCNgU3LkjGxUzEzbabHyAwL4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APKkcurN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709204369; x=1740740369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YjdLAAQGiT0XCs7CLBYxxn9xZUUhhDnrttXTbBDNBak=;
  b=APKkcurN3+rRf5am4IzJ/iuALooDcsFYrV2MKB6E7CsuGKDLo5nSkcAh
   ejyqCM6Y6TL4nO/6Ef24JPVNA9AgTUXax0UVbQkaPjZHSwB8gBciT3b7e
   SUvHf+Vi6zGNFw5JTbbAYXkFiIuRI9Gt7+vVnYZvLzVAxx0lrPOOMCl5a
   +jncWVsi8dph5W2b16vAwKrtr95E/o3xVL3IgJsI03Gu/hXbQZsWJ12f1
   wqgbbWy3ZhdJITGF4++itCz0X4H4uaU7n7AMBQmd3LeraqvifgDfcfUGt
   ZcFB3iRpwgo0yafETqMJjYZ7gKz5EHN17KgrmekalAqRz1IDehYWTp4BI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3789951"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3789951"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913979088"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913979088"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:59:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfe8G-00000008eD8-3SLO;
	Thu, 29 Feb 2024 12:59:20 +0200
Date: Thu, 29 Feb 2024 12:59:20 +0200
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
Subject: Re: [PATCH v4 1/8] overflow: Use POD in check_shl_overflow()
Message-ID: <ZeBjiEboNKqcZskG@smile.fi.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-2-andriy.shevchenko@linux.intel.com>
 <202402281332.9B2F13570@keescook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402281332.9B2F13570@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 01:33:15PM -0800, Kees Cook wrote:
> On Wed, Feb 28, 2024 at 10:41:31PM +0200, Andy Shevchenko wrote:
> > The check_shl_overflow() uses u64 type that is defined in types.h.
> > Instead of including that header, just switch to use POD type
> > directly.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Kees Cook <keescook@chromium.org>

Based on the further discussion this seems pretty independent. Can you take it
through your tree?

-- 
With Best Regards,
Andy Shevchenko



