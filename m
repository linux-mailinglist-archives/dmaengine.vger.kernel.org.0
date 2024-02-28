Return-Path: <dmaengine+bounces-1172-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7992B86BA3F
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE7B1C221DE
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB4D7005B;
	Wed, 28 Feb 2024 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwyEWm8N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C3270020;
	Wed, 28 Feb 2024 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157209; cv=none; b=Rkt7pVaf54h21GmIgjd+ZgTZpBN/5cQpqAYR75uS4hl1yeX5oBhoyw5hxCBXfxWsrv7kwbLrqFYuyXwR/0AK9F5QWCL2EQgv4NFd1u8d8QKQF844M1XJjkIgZfzd88C1Oq3De3DkhfTSXPtWQjMOZQXzW/rQ3fHINQiCNFrEcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157209; c=relaxed/simple;
	bh=DXAncb5M5L0FxykniOApRquIQ7d0QWI8AZKaQoqhSto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYZ7FHq008iEHwvP9VXvNCUPaXAfl7ru91BSpET/lTMVIcPviNCBexuKgTSKiUPETGfB0rwZVZE3oKiNpb38SziLqjMDmbpqGnFO4WYTPkvzJa1FwUj9g7kN2JbAq+JFzw3I7ZTYtoKbC6HCUZdc8p6V4oMVSyZbGqReCI/CQvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwyEWm8N; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709157207; x=1740693207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DXAncb5M5L0FxykniOApRquIQ7d0QWI8AZKaQoqhSto=;
  b=FwyEWm8NnFZq9TCcGO+GXkLBsqwe/ihXTjdDYgmFZnZB3PUlAPaRXo19
   6zo2UDl/a2MtYnzaxPJGsZFH6f7sIrFkYEZ335IvHaTVdobP+gSqVhu8i
   2OZE6y8DGqMF0Bye80GmncJtewe6LayRAf6TC3ViSTdijb2S+jf/rT8f/
   X0ehQBv3HB4qhMKnAMnPuYlEnZ7TiBzrF22c/sx65LdEV+q2NUFaDsy0L
   C9C3C+Qh3tx4Q2argv/s9KBQwV1wShPeE/p8uQnzd99mFT2rJ5CVKy+NM
   o76GO69MCxzvO0jDQSI0tJNQpY4Zir7LSmKlVjgUxvLgXOtmVDYPaZwUj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7373409"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7373409"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:53:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913962225"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913962225"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:53:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfRrZ-00000008Vpz-48uU;
	Wed, 28 Feb 2024 23:53:17 +0200
Date: Wed, 28 Feb 2024 23:53:17 +0200
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
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <Zd-rTRidOqOd4Gr7@smile.fi.intel.com>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402281341.AC67EB6E35@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 01:46:10PM -0800, Kees Cook wrote:
> On Wed, Feb 28, 2024 at 10:41:37PM +0200, Andy Shevchenko wrote:

...

> >  static inline void *netdev_priv(const struct net_device *dev)
> >  {
> > -	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> > +	return struct_data_pointer(dev, NETDEV_ALIGN);
> >  }
> 
> I really don't like hiding these trailing allocations from the compiler.
> Why can't something like this be done (totally untested):

Below is interesting idea, now at least I started understanding your previous
comments.

-- 
With Best Regards,
Andy Shevchenko



