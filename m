Return-Path: <dmaengine+bounces-1879-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE358A8CCC
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 22:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A3D281005
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F4364AE;
	Wed, 17 Apr 2024 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCK+0+hT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B19922324;
	Wed, 17 Apr 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384712; cv=none; b=WgG5hc/R2ylEcbTuuSxujfXCXO8uBeMS6zOhEfzMFVIJ7oKNNAYsIZMd00s8XDLF4ghaQfIN+jz+KrhznkUi0KRSSFP6lOLrmy+UHDHHJdaDh2qq5mAUzqmMiYy8mg37KqUJC7G2b0qwpVbGM1LXiW/hclBo+ZJVezdap59GjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384712; c=relaxed/simple;
	bh=XD0lQbHLXLAn/+S5GwtU0Lbsu1BpfgFic/mCjoxxyow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY2l62J0N+z9TZaY80SI4+C40KV6Rmiv2mhGXub5uf56HSNF1UWqMi5q8Xm28mlby7Z39WEXHL9LCuPeDphR81mAC8JCGIE8/Zm4qkSyYb3FTEw2Ym4DbghvNB4Pa5+/KH8K7x32vN2C3TJp7ZEXieqOtGcTDg7zP/+wa1sSrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCK+0+hT; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d1c8dc79so82036e87.1;
        Wed, 17 Apr 2024 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713384709; x=1713989509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkXJYCCAFQIB+kTCCd8sU0ZfFeu7ir+DVLkLbSTNUGY=;
        b=VCK+0+hTk4ttiQy2uXosmIuQli97FvL98EsWs4h/SY30apA76b+in+4DERUK6jRt0A
         jqFVZ/4X3P0brxpZWRTnGNwUwz1kmlW0JbmRxUzdMgQVNfMql5qSvupBJ37fWCX4F1KD
         /PPPPkWNGWgEEZ4UbleWCyDOMrK/3tTOvpuQQjvBzhKFbqUeGNXKO73GuHOwc0s6q9ia
         Q69of+BelUK8r2mwtvxQd40hoPhLIHR8H7GBfikNoDYOGmOj2webpmOkyQiwFv1teGxv
         wVRvzoUl0/jNwbtiUFoM1tcUM79tgU6F1LBgisJM7J8julYl9RD+r4AGlpyI8xopc3yQ
         7nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384709; x=1713989509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkXJYCCAFQIB+kTCCd8sU0ZfFeu7ir+DVLkLbSTNUGY=;
        b=AIwdpkamBIsJPjEw07XuEegm/NPNa38NlAnV18uEoVsOsEX5E6GXcfVcNR1f+mLmYW
         AkP4rWnk0/mGDYh0rJo7m/OT+j7iycLLrZ7Go+zCMtAAZ9WQOr/3ZekCLOyTVWRatZmO
         RF/sKzqIjJ5IqO59GSXdO7mbmfDOYMjuRNYHaCCM4VU4bfIJK232cjxiyacNrBS41+mH
         zoIKjUXsfh3SRRWQppics4G4EdyqasFPSnaX3Ny/3B86fUra8PCZGVw3bUanFmj4wein
         5AfQLAEz3Sf6Rvwu1mjGXzRK1EsBhTwmwH5XqGEj6mDM7nWEdvr62roIj/eEdKKiKTxp
         1RiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdQZOTb29YtvLVvTIybplabM1ZxlWZJbM86Et94w2tfUYLMl0FMnQpw7YkxnVA6IHzuEdSPrDohxh6doh/8hFJNihkmeVfsD/vVCpxbhZwU/rywm0nb7VB2hD6rrdXlSsQve/a6Bs242P+Bah1ffmEoxYT0xp9F2OmooVR4gQuI9CDEaIq
X-Gm-Message-State: AOJu0Yzqf3GY6GF+5zCELSO7gryLNiPsvs1urxsZtjcguIo/5j1IKrQ/
	SGxT+juVFz6Bb1gLcAbvnqobYvbx6EdaktyA7m+gqvZD0XE7hKcwIhSdaGbr
X-Google-Smtp-Source: AGHT+IEimNL9Jzkg+4WuFGUWNsLVtlVgbYacCQGaS4hEtgXZrKILR+Dv3UKvX+SXrk3ibvZAdcxVBg==
X-Received: by 2002:ac2:4424:0:b0:518:9952:2740 with SMTP id w4-20020ac24424000000b0051899522740mr173861lfl.41.1713384708981;
        Wed, 17 Apr 2024 13:11:48 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id bp32-20020a05651215a000b00518f6b9a5d7sm971036lfb.137.2024.04.17.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:11:48 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:11:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw: Simplify prepare CTL_LO methods
Message-ID: <lzcgxh7trwoksd4bx2fsybellbngvpwhgq2a76ou2iufemockp@3dca4bfox2ps>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-4-fancer.lancer@gmail.com>
 <Zh7LyszPd2sNfWRm@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh7LyszPd2sNfWRm@smile.fi.intel.com>

On Tue, Apr 16, 2024 at 10:04:42PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 16, 2024 at 07:28:57PM +0300, Serge Semin wrote:
> > Currently the CTL LO fields are calculated on the platform-specific basis.
> > It's implemented by means of the prepare_ctllo() callbacks using the
> > ternary operator within the local variables init block at the beginning of
> > the block scope. The functions code currently is relatively hard to
> > comprehend and isn't that optimal since implies four conditional
> > statements executed and two additional local variables defined. Let's
> > simplify the DW AHB DMA prepare_ctllo() method by unrolling the ternary
> > operators into the normal if-else statement, dropping redundant
> > master-interface ID variables and initializing the local variables based
> > on the singly evaluated DMA-transfer direction check. Thus the method will
> > look much more readable since now the fields content can be easily
> > inferred right from the if-else branch. Provide the same update in the
> > Intel DMA32 core driver for sake of the driver code unification.
> > 
> > Note besides of the effects described above this update is basically a
> > preparation before dropping the max burst encoding callback. It will
> > require calling the burst fields calculation methods right in the
> > prepare_ctllo() callbacks, which would have made the later function code
> > even more complex.
> 
> Yeah, this is inherited from the original driver where it used to be a macro.
> 
> ...
> 
> > +	if (dwc->direction == DMA_MEM_TO_DEV) {
> > +		sms = dwc->dws.m_master;
> > +		smsize = 0;
> > +		dms = dwc->dws.p_master;
> > +		dmsize = sconfig->dst_maxburst;
> 

> I would group it differently, i.e.
> 
> 		sms = dwc->dws.m_master;
> 		dms = dwc->dws.p_master;
> 		smsize = 0;
> 		dmsize = sconfig->dst_maxburst;

Could you please clarify, why? From my point of view it was better to
group the source master ID and the source master burst size inits
together.

> 
> > +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> > +		sms = dwc->dws.p_master;
> > +		smsize = sconfig->src_maxburst;
> > +		dms = dwc->dws.m_master;
> > +		dmsize = 0;
> > +	} else /* DMA_MEM_TO_MEM */ {
> > +		sms = dwc->dws.m_master;
> > +		smsize = 0;
> > +		dms = dwc->dws.m_master;
> > +		dmsize = 0;
> > +	}
> 
> Ditto for two above cases.
> 
> >  static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
> >  {
> >  	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
> > -	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
> > -	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;

> > +	u8 smsize, dmsize;
> > +
> > +	if (dwc->direction == DMA_MEM_TO_DEV) {
> > +		smsize = 0;
> > +		dmsize = sconfig->dst_maxburst;
> > +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> > +		smsize = sconfig->src_maxburst;
> > +		dmsize = 0;
> > +	} else /* DMA_MEM_TO_MEM */ {
> > +		smsize = 0;
> > +		dmsize = 0;
> > +	}
> 
> 	u8 smsize = 0, dmsize = 0;
> 
> 	if (dwc->direction == DMA_MEM_TO_DEV)
> 		dmsize = sconfig->dst_maxburst;
> 	else if (dwc->direction == DMA_DEV_TO_MEM)
> 		smsize = sconfig->src_maxburst;
> 
> ?
> 
> Something similar also can be done in the Synopsys case above, no?

As in case of the patch #1 the if-else statement here was designed
like that intentionally: to signify that the else clause implies the
DMA_MEM_TO_MEM transfer. Any other one (like DMA_DEV_TO_DEV) would
need to have the statement alteration. Moreover even though your
version looks smaller, but it causes one redundant store operation.
Do you think it still would be better to use your version despite of
my reasoning? 

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

