Return-Path: <dmaengine+bounces-3302-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB299556F
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 19:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3561C20840
	for <lists+dmaengine@lfdr.de>; Tue,  8 Oct 2024 17:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02221F12EA;
	Tue,  8 Oct 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEHcL+U6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1C1EF947;
	Tue,  8 Oct 2024 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407778; cv=none; b=t3zAVvhGu+IEzQ88t5d3jY5J+J6RWhBKyKcZud4bjx+tI3PTsxi9kR1SjajzGIIgs0RFmpo90NXdK2f3O4fBsDPy0ztumTBd0Qiwyb/QYf2hubidrLKFgz8zFe5/uQRVLYhaDUMYJ9zro1WnCkgcTyhcB6epHEb+pLh0bkXzft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407778; c=relaxed/simple;
	bh=HiDTiaw0GrTH+FU7jhEUSpJUXkK0emE/bQNQSR8MGes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqscFgVXOCv5xg1d12MQSaCKW72K8JrLQZ2Htx/vTy/OGkyVpk5PwYChoaKyBBK3fHDk/AoqwMHq1AjF6nwT3lLe5MJiQEf7Uq/fMyxUorv6tq5a38zBweCFlwO5oYBRCTZsxFbI9MSq4LdQpON88UjXbJJjOl3E/4GqbHfcr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEHcL+U6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728407778; x=1759943778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HiDTiaw0GrTH+FU7jhEUSpJUXkK0emE/bQNQSR8MGes=;
  b=XEHcL+U6s4vvaEZvPiYVzuhZKPPFDC9UudqUtGWoA/H386GJOc6rGZ3G
   3paF8DpltLal02A0IeaF6+gyWfsDgO+VTbdqm3lJHrHuWY/eOhessI3wT
   XwAYM1xFzXAmkSGL/t6IGFoRgWmTNRc6TFyH0u54WnI7ai/Hzk4ISmaWT
   FsANrUCJbJaNlUYaLGS4N7Q7J5PomVEUmZR8lu0JnFeVDHk5KhY1pO9sn
   OftEd0gb8qryASr8i0nR/rh1DGrz3Q0gmuiUztY/6Bg4Q69bBzzprOqqP
   tGxxLFAfS8ve6odZI0VxAcCzcwyjsfTD9ACSLq2Ab/kLey4NGBTD2A3JY
   A==;
X-CSE-ConnectionGUID: UN7S7CvlTrqzD5CojppVPw==
X-CSE-MsgGUID: sNNN85gbQQSbXk5D4C1MWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27787909"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="27787909"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 10:16:17 -0700
X-CSE-ConnectionGUID: RQU2oqNyRc6cROB7iTkWgQ==
X-CSE-MsgGUID: O9dU591mQnmuqiPzI8fttA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75591497"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 08 Oct 2024 10:16:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DDA0C20F; Tue, 08 Oct 2024 20:16:12 +0300 (EEST)
Date: Tue, 8 Oct 2024 20:16:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 3/4] dmaengine: Add a comment on why it's okay when
 kasprintf() fails
Message-ID: <ZwVo3AfFlAAuoTQF@black.fi.intel.com>
References: <20241007150852.2183722-1-andriy.shevchenko@linux.intel.com>
 <20241007150852.2183722-4-andriy.shevchenko@linux.intel.com>
 <ZwQDcrJuW+DXMBD+@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQDcrJuW+DXMBD+@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 07, 2024 at 11:51:14AM -0400, Frank Li wrote:
> On Mon, Oct 07, 2024 at 06:06:47PM +0300, Andy Shevchenko wrote:
> > In dma_request_chan() one of the kasprintf() call is not checked
> > against NULL. This is completely fine right now, but make others
> > aware of this aspect by adding a comment.
> 
> suggest:
> 
> Add comment in dma_request_chan() to clarify kasprintf() missing return
> value check and it is correct funcationaly.

Sure, thanks.

...

> >  #ifdef CONFIG_DEBUG_FS
> > -	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev),
> > -					  name);
> > +	chan->dbg_client_name = kasprintf(GFP_KERNEL, "%s:%s", dev_name(dev), name);
> > +	/* No functional issue if it fails, users are supposed to test before use */
> 
> comments should above chan->dbg_client_name ...

It's placed exactly there on purpose. Because it explains 

> No funcational issue if it is NULL because user always test it before use.

I think my is better because it reveals the actual issue, ideally users
must not rely on that and the code here should assign a valid pointer.
The problem is that the code paths are a bit twisted and I only can come
up with this comment _for now_. Semantically this change is a band-aid
(and not good), but at least it describes current (broken) desing.

-- 
With Best Regards,
Andy Shevchenko



