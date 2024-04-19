Return-Path: <dmaengine+bounces-1904-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB50B8AAB52
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C51F2258D
	for <lists+dmaengine@lfdr.de>; Fri, 19 Apr 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B67580B;
	Fri, 19 Apr 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4jh+iEJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE02F9CD;
	Fri, 19 Apr 2024 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518395; cv=none; b=H5Sx31SeEU57WWf7P9EFK0sgEma5ykirj1ZNBchBP/B1fylHUlHvCs9k3mQHvWJMVF9rPIDpV4tBNA+3IhslTgwsJn1Ni7MBOPbk5tae22KDYSXerRXjeZnvYhw15JYeI1VBhB6JKpuObQOjfC82k1qc2oQWoAAiDY/Ix9ha7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518395; c=relaxed/simple;
	bh=KlXQuKvGJywU3LD2CUoRhMvX72mjF+L+3E8OH1+cRzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLA3fsch3ryudgoS6sIszr0G5vo+InTUakt8KJrVo5FuMTOymwF1igyOCUdp0wBX/B51yLIXdYCMqz7PpANDuCTBryYGYAFdg8JXR83wTSRD8KOmj+amgeW0fgjz33ZsGIukEM1ZtmWqraEviQVFnV4l4wc5rlGvqk0hutGJzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4jh+iEJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518f8a69f82so2178255e87.2;
        Fri, 19 Apr 2024 02:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713518391; x=1714123191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7uRz/nxbhPgcg3DGqznEbcQEDecYnCJi73IPin9pfrE=;
        b=B4jh+iEJHa4KbbBJTt41vTtc7Cf+rbHqSV8rhoEFCgSc+xT1ZL9GgX3U56rwNSq9l3
         l9y7DydEZFaofOLsCmkgG0VEmf5Bauuz8ZTOQMgQYBbchHDhtlWxUDEe1vnNXbtSHl/2
         +AqW5mwX2nuDexKYYIDjGiiAd+vP6Vm9HlySy7lYReyn2TWP4LwIkE1rF7ELdpXhNp/C
         blVKMym9gs7oZoWQ57H9O2dS8zEd1pjXXtmgsbrPOQJXSwQAYuXqWgoWNKRHWqTL6goa
         bbtPKRfXT653/ebf6OMqRdPhxocwVdvFQprM4Rytn9FYN2YmP1jiricjtMeJIYEG0B8p
         w/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518391; x=1714123191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uRz/nxbhPgcg3DGqznEbcQEDecYnCJi73IPin9pfrE=;
        b=aTIrauSN29zRxb3+NYNrgGP/WN6RZh2B36AKHjpIbohTvtb4nglDmgT25PnnZGE1Po
         WL2oXjFDPAnrti2q1Vuzh1HmEY16bY0eGMbea8BIAgAHJEs3uWebhO8OkdKIRCvUd9A1
         9/xkaeydiBh4R9lqGxy/i968m6Q8e3tPUSYqAGddxJbDGYlBbtUrPaU4vea9/ZPDB5Nn
         rHKV1P36+1HUf68z6Gf0VQE8ZDQPyiDczfahZltC0wq4NwQWRprGXmODoE2/i0YD+7JH
         us/d0o6Lkq/6Byvm7mKl+/bW0G+f6X+34U7bG5la54ry6ovn2SHWetLYZ28ej+L3S0a8
         I/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWx9FaKTeencCCRcecS6fUCBrmicC9Xtf47Ju1HHEhujZTFl9rhtq1/DCOiSFkAbIWrhKxDwDyRqoYPF1CckSOSue0QEq6TRC6YeQowqYC91IUsaQF/c8FZ3mQtwX8SEqiqWwBsFW6FRtL1fnbUx744dlE8jGLTWw6DqOCF+vuTvSSdeaSc
X-Gm-Message-State: AOJu0YxaGPrpKzpyk/EIaR9jAAUm1SGArMzGwtK7dhl3uVh++rG33FXj
	F3FvatAh1h/+jQGgS65KgyXjKk/l12CB3x6BxGNCVijRFdVbcUKjbra9hIXO
X-Google-Smtp-Source: AGHT+IEE+c8XToG2LkLPH2w60EnuzxV5zLxI6Q2u6Y+2UULExfGeij1aufjjl9uW3OpE6g7MOIyzRQ==
X-Received: by 2002:ac2:4e4a:0:b0:516:cc06:fa03 with SMTP id f10-20020ac24e4a000000b00516cc06fa03mr1033854lfr.56.1713518391302;
        Fri, 19 Apr 2024 02:19:51 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id p24-20020a056512329800b00519331d8b66sm626692lfe.110.2024.04.19.02.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 02:19:50 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:19:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw: Simplify prepare CTL_LO methods
Message-ID: <oqyz6fpdxzk5x4xr5rlqwnj3frakjnz24e6bx7mxngh5gm5jom@wsm7qvubqwn3>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-4-fancer.lancer@gmail.com>
 <Zh7LyszPd2sNfWRm@smile.fi.intel.com>
 <lzcgxh7trwoksd4bx2fsybellbngvpwhgq2a76ou2iufemockp@3dca4bfox2ps>
 <ZiEIRluj-50FMIgp@smile.fi.intel.com>
 <xfa7evanbrvdxdoq6473wpymvqogezspwkdoawu2dr6mnyxiwq@zx2schip66wj>
 <ZiGJ-DspJq5R6Dym@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiGJ-DspJq5R6Dym@smile.fi.intel.com>

On Fri, Apr 19, 2024 at 12:00:40AM +0300, Andy Shevchenko wrote:
> On Thu, Apr 18, 2024 at 10:00:02PM +0300, Serge Semin wrote:
> > On Thu, Apr 18, 2024 at 02:47:18PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 17, 2024 at 11:11:46PM +0300, Serge Semin wrote:
> > > > On Tue, Apr 16, 2024 at 10:04:42PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Apr 16, 2024 at 07:28:57PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > > > > +	if (dwc->direction == DMA_MEM_TO_DEV) {
> > > > > > +		sms = dwc->dws.m_master;
> > > > > > +		smsize = 0;
> > > > > > +		dms = dwc->dws.p_master;
> > > > > > +		dmsize = sconfig->dst_maxburst;
> > > > 
> > > > > I would group it differently, i.e.
> > > > > 
> > > > > 		sms = dwc->dws.m_master;
> > > > > 		dms = dwc->dws.p_master;
> > > > > 		smsize = 0;
> > > > > 		dmsize = sconfig->dst_maxburst;
> > > > 
> > > > Could you please clarify, why? From my point of view it was better to
> > > > group the source master ID and the source master burst size inits
> > > > together.
> > 
> > > Sure. The point here is that when you look at the DMA channel configuration
> > > usually you operate with the semantically tied fields for source and
> > > destination. At least this is my experience, I always check both sides
> > > of the transfer for the same field, e.g., master setting, hence I want to
> > > have them coupled.
> > 
> > Ok. I see. Thanks for clarification. I normally do that in another
> > order: group the functionally related fields together - all
> > source-related configs first, then all destination-related configs.
> > Honestly I don't have strong opinion about this part, it's just my
> > personal preference. Am I right to think that from your experience in
> > kernel it's normally done in the order you described?
> 

> In this driver I believe I have followed that one, yes.

Agreed then. I'll change the order to the way you ask.

-Serge(y)

> 
> > > > > > +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> > > > > > +		sms = dwc->dws.p_master;
> > > > > > +		smsize = sconfig->src_maxburst;
> > > > > > +		dms = dwc->dws.m_master;
> > > > > > +		dmsize = 0;
> > > > > > +	} else /* DMA_MEM_TO_MEM */ {
> > > > > > +		sms = dwc->dws.m_master;
> > > > > > +		smsize = 0;
> > > > > > +		dms = dwc->dws.m_master;
> > > > > > +		dmsize = 0;
> > > > > > +	}
> > > > > 
> > > > > Ditto for two above cases.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

