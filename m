Return-Path: <dmaengine+bounces-1193-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D386CC25
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 15:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E61C22E50
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9949C1384AC;
	Thu, 29 Feb 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlslagbC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8381B137777;
	Thu, 29 Feb 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218439; cv=none; b=jiOGqZLoTWNYEpH99LFwaxF4hQOws74Cfk/BwO1a3333+9e9sAR40ZY5Cc80msZKrIf56AC8zG8YtwKDNsvF7aCrmRY6MGCPwm+Da3wHQari6meSr0OqpSBhpwSDUe148Uj0Ummn110W0eAgBkf9ZG5smvyY02XG3oGark0sd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218439; c=relaxed/simple;
	bh=H/xypjHg3RAGtOrdFLSQMFFbI9FZppPqPGCTlvgpMy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8PIyhS+Uqtv7g/yC69Pr3ZO6oTwiZG/ClI0Tnk/KksqtRkRGlgsJrAIW9BttMEfz0RaQFBJMygHZuaDkpZGf9+h34Qgk+7ILBx6ULsmpXwJtgt6ShpZ+jb+v4+xQCiGy5Z2S5KBnhxvCekVJa+OJu14zbBOgGkd0SvfdyFtLyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlslagbC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709218438; x=1740754438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H/xypjHg3RAGtOrdFLSQMFFbI9FZppPqPGCTlvgpMy8=;
  b=DlslagbCfXQK676474bV3pAjKHVKN+B6FAm5kPYwRIOIcOOKDcw81Q3O
   qfBYM7LSuTBWPSrrsusAMDihGCLPFK7IGKdkMX6nIX5D4rvMjdZ85Wrf2
   09vM1XfxWWJIBauatfLHd8e58v75Dh6TfjP6emtV4bZse3+Eik+rPysMC
   x1YhBrSwzHrumEj/XnK8wywfbxR6vdRkQKHbCHXKlk2P5LjM/sGwZIm9Q
   DGTOdxf3flKmTZaIGTdZxKmhi8x8oeRfmzfB1GAnCG58vzUYnlrup0qg7
   teMB8+cy8LOxH+sANI3RoC+H1hqylxURboVjDvXOIRpkQKlw+3n+1ddzx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7470968"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7470968"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913983848"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913983848"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:53:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfhnA-00000008hMb-38bp;
	Thu, 29 Feb 2024 16:53:48 +0200
Date: Thu, 29 Feb 2024 16:53:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
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
Subject: Re: [PATCH v4 8/8] dmaengine: ste_dma40: Use new helpers from
 overflow.h
Message-ID: <ZeCafPgtU1FeyzJG@smile.fi.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-9-andriy.shevchenko@linux.intel.com>
 <CACRpkdaEzexhCYFf-NKnbcagXc6Tqcn4J+sFWk94mbJG9LkpVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaEzexhCYFf-NKnbcagXc6Tqcn4J+sFWk94mbJG9LkpVw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 03:14:03PM +0100, Linus Walleij wrote:
> On Wed, Feb 28, 2024 at 9:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > We have two new helpers struct_size_with_data() and struct_data_pointer()
> > that we can utilize in d40_hw_detect_init(). Do it so.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Wow really neat! Much easier to read and understand the code like this.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, but Kees has seems even better suggestion.

-- 
With Best Regards,
Andy Shevchenko



