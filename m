Return-Path: <dmaengine+bounces-1899-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E808AA25F
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 21:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD19DB21FDC
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 19:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C05517AD80;
	Thu, 18 Apr 2024 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+6hq8S/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95BE177980;
	Thu, 18 Apr 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713466808; cv=none; b=Xd21iQRrR2trLmpzIiwcwNWlKlULzmLyA950q42NazB89nU6/t3Oi67W+8EDXCySSBjs19c/xS6EXsmhJqkHQi511bj1CUxEuh+eKzw06UTllCvHB3SgLkh8kp+JGBMb20oRPCOvQNQe20Vn9A7nWu8nHItEdhse9QoMRQDZczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713466808; c=relaxed/simple;
	bh=DtNB2uwV6hdLHUzoTUuKKanWjIIY04kFcUi2VeS4yxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn38gaUanAzYD/j3zvUgGwamAm5FttrE5+5NZaPEfjolKXVeTcZCxrAfYDEzQNuvMYxevkITeZcF0LsXHEPCdG1p9KDXQupDIwwfPkHGdO9v+nFAngGbxXgm0DE1N0d9ir/9MLliJj7IUDGd4TZokvIu1EH+Y4dyva3ecEsAebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+6hq8S/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d8b194341eso12053361fa.3;
        Thu, 18 Apr 2024 12:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713466805; x=1714071605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/1ZUQVywqBQMj10OM00Y6p3sF/smVF9hYZ25aGm7pE=;
        b=B+6hq8S/peAedzdq23LZQ09KT12WjeDaqmnP9gbHCT5gkAVkekjAP6Bwi/Uedg3oEu
         pwyJ3G1ROPHB+VS+7FYyC3M9a3hMysdf+AY51tkmPm36TePHszM8flkFNexZ7HocJSRA
         oHgLI7DKM122NqJWUh2nS3VfSSRfbErSnHbkDF7u6I53MMTYas+YnFG+xvi8pIpAwTfM
         rQhD8do1tkvuNSWFUWWjMDDHnYGlwUV0ziVtLcok5XH2cCgAM+qWrTkqsFYiJqcyzBJY
         XmrHEk8I5tkaAOrEz9jvlCTeTPFPudxHko9FvZ49fFsCM13WayIJlNDchKQEUZ6Y43OO
         zVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713466805; x=1714071605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/1ZUQVywqBQMj10OM00Y6p3sF/smVF9hYZ25aGm7pE=;
        b=J+TCmEl/9+E9JJ2kiYsJagQxCLt5/thEyNMYRUDfxd71PDMdIWH90E/6P4AmgjVF21
         v8xL5IPGm7vy90/3VnmDfxYsj1DPQi24LjjVp9Slas4cuHSW2crKJed+cict3orRufUo
         E+qDj96FX8hjAniMstoKbCOrOj/tCVCby5dONKbZqLxadjBDmbMZ3+xvxDTzq62VEX2V
         9zkjbH2ls6nZqE90FDmfFUJ8Qxy7Jbg+fTBXapZyXF9Yudd0e06VHhqwZFtDq4r73Lx/
         GlcgD7OHF0SdgSrtiU4CE0w4OrYv64/ieGK1zvPBvjJ9mip+ikaRBGBNsFfnS9QG1c5W
         AtmA==
X-Forwarded-Encrypted: i=1; AJvYcCVAuA6cquzK7FKAmW/bpG4wTuj1eoOqAXDLaMnl8a1KwBbzXqpcni1Ig+xalx0cQ5zBv/pxmxpfX9zJH5fEgJbbO24pQv8XvZASIUIxnWDzeftDZhn6TuuxbgzdTYhjsDtE/FC8ZwDSoqkUxehUr05euqEEJKl0ccN8sMYk8762D98kbO4l
X-Gm-Message-State: AOJu0Yx5m3gmXhPnN6efBUpthCkIZz7WesHJrKoG37EnFHeoQfiW20S0
	Aap3+ayQdsjV8BI1rH96lgjF1LXvWoAkJTtXW6P5VhYVVpe7Iyg09I77a8Un
X-Google-Smtp-Source: AGHT+IGXwZs8WOAgzHyky2KaxTrnx0nCRMwId+2ubPwIhwW0csx5LhLO2/vZ7Pe2jmUQIxYZC2tAdg==
X-Received: by 2002:a2e:8519:0:b0:2d8:180d:a62a with SMTP id j25-20020a2e8519000000b002d8180da62amr2054653lji.25.1713466804650;
        Thu, 18 Apr 2024 12:00:04 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e9843000000b002d8a3121b0asm289457ljj.36.2024.04.18.12.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 12:00:04 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:00:02 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw: Simplify prepare CTL_LO methods
Message-ID: <xfa7evanbrvdxdoq6473wpymvqogezspwkdoawu2dr6mnyxiwq@zx2schip66wj>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-4-fancer.lancer@gmail.com>
 <Zh7LyszPd2sNfWRm@smile.fi.intel.com>
 <lzcgxh7trwoksd4bx2fsybellbngvpwhgq2a76ou2iufemockp@3dca4bfox2ps>
 <ZiEIRluj-50FMIgp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEIRluj-50FMIgp@smile.fi.intel.com>

On Thu, Apr 18, 2024 at 02:47:18PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 17, 2024 at 11:11:46PM +0300, Serge Semin wrote:
> > On Tue, Apr 16, 2024 at 10:04:42PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 16, 2024 at 07:28:57PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > > +	if (dwc->direction == DMA_MEM_TO_DEV) {
> > > > +		sms = dwc->dws.m_master;
> > > > +		smsize = 0;
> > > > +		dms = dwc->dws.p_master;
> > > > +		dmsize = sconfig->dst_maxburst;
> > > 
> > 
> > > I would group it differently, i.e.
> > > 
> > > 		sms = dwc->dws.m_master;
> > > 		dms = dwc->dws.p_master;
> > > 		smsize = 0;
> > > 		dmsize = sconfig->dst_maxburst;
> > 
> > Could you please clarify, why? From my point of view it was better to
> > group the source master ID and the source master burst size inits
> > together.
> 

> Sure. The point here is that when you look at the DMA channel configuration
> usually you operate with the semantically tied fields for source and
> destination. At least this is my experience, I always check both sides
> of the transfer for the same field, e.g., master setting, hence I want to
> have them coupled.

Ok. I see. Thanks for clarification. I normally do that in another
order: group the functionally related fields together - all
source-related configs first, then all destination-related configs.
Honestly I don't have strong opinion about this part, it's just my
personal preference. Am I right to think that from your experience in
kernel it's normally done in the order you described?

> 
> > > > +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> > > > +		sms = dwc->dws.p_master;
> > > > +		smsize = sconfig->src_maxburst;
> > > > +		dms = dwc->dws.m_master;
> > > > +		dmsize = 0;
> > > > +	} else /* DMA_MEM_TO_MEM */ {
> > > > +		sms = dwc->dws.m_master;
> > > > +		smsize = 0;
> > > > +		dms = dwc->dws.m_master;
> > > > +		dmsize = 0;
> > > > +	}
> > > 
> > > Ditto for two above cases.
> 
> ...
> 
> > > >  static u32 idma32_prepare_ctllo(struct dw_dma_chan *dwc)
> > > >  {
> > > >  	struct dma_slave_config	*sconfig = &dwc->dma_sconfig;
> > > > -	u8 smsize = (dwc->direction == DMA_DEV_TO_MEM) ? sconfig->src_maxburst : 0;
> > > > -	u8 dmsize = (dwc->direction == DMA_MEM_TO_DEV) ? sconfig->dst_maxburst : 0;
> 
> > > > +	u8 smsize, dmsize;
> > > > +
> > > > +	if (dwc->direction == DMA_MEM_TO_DEV) {
> > > > +		smsize = 0;
> > > > +		dmsize = sconfig->dst_maxburst;
> > > > +	} else if (dwc->direction == DMA_DEV_TO_MEM) {
> > > > +		smsize = sconfig->src_maxburst;
> > > > +		dmsize = 0;
> > > > +	} else /* DMA_MEM_TO_MEM */ {
> > > > +		smsize = 0;
> > > > +		dmsize = 0;
> > > > +	}
> > > 
> > > 	u8 smsize = 0, dmsize = 0;
> > > 
> > > 	if (dwc->direction == DMA_MEM_TO_DEV)
> > > 		dmsize = sconfig->dst_maxburst;
> > > 	else if (dwc->direction == DMA_DEV_TO_MEM)
> > > 		smsize = sconfig->src_maxburst;
> > > 
> > > ?
> > > 
> > > Something similar also can be done in the Synopsys case above, no?
> > 
> > As in case of the patch #1 the if-else statement here was designed
> > like that intentionally: to signify that the else clause implies the
> > DMA_MEM_TO_MEM transfer. Any other one (like DMA_DEV_TO_DEV) would
> > need to have the statement alteration.
> 

> My version as I read it:
> - for M2D the dmsize is important
> - for D2M the smsize is important
> - for anything else use defaults (which are 0)
> 

Ok. Let's follow your way in this case. After your how-to-read-it
comment your version no longer look less readable than what is
implemented by me. Thanks for clarification.

> > Moreover even though your
> > version looks smaller, but it causes one redundant store operation.
> 
> Most likely not. Any assembler here? I can check on x86_64, but I believe it
> simply assigns 0 for both u8 at once using xor r16,r16 or so.
> 
> Maybe ARM or MIPS (what do you use?) sucks? :-)

Interestingly, but asm-code in both cases match.) So the redundant
store operation in your C-code gets to be optimized away.

-Serge(y)

> 
> > Do you think it still would be better to use your version despite of
> > my reasoning?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

