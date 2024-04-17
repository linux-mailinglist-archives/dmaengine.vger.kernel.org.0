Return-Path: <dmaengine+bounces-1880-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B588A8D08
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 22:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF17B2423D
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E173D0C6;
	Wed, 17 Apr 2024 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVesQ+Zh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E7B22324;
	Wed, 17 Apr 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386145; cv=none; b=Vxz+b73Zhnhdii2WxJmaRFWjzjsPRzviLP6+V0A+jCX7W1lBUQCuhYTnaRmCz6rY9n3HdI9gyqW/P0BL8eyAVQtLoEcwNtL9byV9UuCoLkrD8cyEnffqNdl/FMHbzuUVumx/SRPQj4nXskPMCMkvVTlbi3kDLUs3KPa2nlBOJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386145; c=relaxed/simple;
	bh=I6EJ1mP91iVz//8c5ia8HdkNztwtT3dmN/fNeMRppuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBgnekPicobWahSMr11geql/xWKQWrzYl3P5LXwsPJ9pvR/RzFaYrzdgN6TI53sRdgS0U5ua3DiDOxHnxE1Ew8mJ+ewq0uUrX/FdGRcUqSkr9YSYtL/CG0JNIw9/MBz4jzKiQcivSeYk6x4EbFaZllxMpOSERmonsiF4yVVVVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVesQ+Zh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d4d80d00so115906e87.0;
        Wed, 17 Apr 2024 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713386142; x=1713990942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R38L2lZrS+14WeM7ceh5Hp6+XyP4h36lYdwyJTOLv3o=;
        b=XVesQ+Zhs/VE2C1W/74tIZerg5ra8xzGQlkZZUZt9vFyGHpz2IjUfU7ys5suniB99a
         T/X+jX3t2dpduabwYEAgQxDRR56cNFcNs2Bzn9twcSxmOyduLcnNH76VGfXPv38+yssv
         b6/W2ZMWu5e5OMyWzqeqfYiPP124Bw8lwPMb382kBoJe2t2fLNafD0sWG2KNb+O80+t3
         JzoAWrHXjpwpyjxlz5fPQouBp07bI44oAMMerW7i6wSFMp6OwP1SGDfN0+EFGg5Cxp2j
         tLBqDYOrjal32/l/OorWoDt5RTsi/TRTGELpXEYEZd2QInsjqfjujxvC1RLBBl7QC6rE
         DB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713386142; x=1713990942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R38L2lZrS+14WeM7ceh5Hp6+XyP4h36lYdwyJTOLv3o=;
        b=CTVtrCFj+H3O9Hgu4n/nXQEeMu9eAnuKrvWVHwMZpXsu2jCjSadcHVz8hmWPtV+F4q
         uRgDmoVi2UvMRY7jeDmLsK9950Bvtq5Rr1wYB65DSXe7wG4k8rsqcKq/dtRivDxX64ga
         W2PIYbdz3yPCYEVxXCBsquRT1iG8ZMm3w91/ul0WOBNP47iTQp0vAzksR1vsoU4QwF00
         I4bedHUBCJ3Dm8z1U0gKSL0tyAgBRj2MtyKElrOJSX7BvviRCCCcQDrZ11QL7IYZbIpN
         CxHoe36bLsShuxJHqJQUqzyiBiUvgIn0NrPOJGFRooDtrk+O0X554OiV39IgwD3PjRq5
         IbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtdEg9drOqnKQ4QKIFkB5TXu1F6pJDqrbX9do2HR5sp+Wy7mvhIbDhW4eqW3egZLux0DQG6YLVieoGkUx1lWRVdF10ZqjW/VRhIhVFh4OWWJpZW25/mXCNKRY/6PsfWW7AybaXZzz3l0jUK5tnbXhCe5LZYeccXll7lDePIgZXlO0TmobA
X-Gm-Message-State: AOJu0YzraD+PLP1py/m0Y+T6NENP5sH3iIat9duB9/iibsAWR6oBc/Je
	nd76XPNMd+2GBRBICB0vU3b5bD1IjaqHBXwECuWQk/1DQi5sJV0Y9BzFd/jX
X-Google-Smtp-Source: AGHT+IFzQCpXyGVXKC8TGbH66IqAoulsoDP52wOdk6FAg211hiRNAveryXSiQmrNmpifkseQiOOn9A==
X-Received: by 2002:ac2:456c:0:b0:515:d038:5548 with SMTP id k12-20020ac2456c000000b00515d0385548mr224508lfm.31.1713386141501;
        Wed, 17 Apr 2024 13:35:41 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id q13-20020ac2514d000000b00515d1dfab34sm2056041lfd.81.2024.04.17.13.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:35:41 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:35:39 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: dw: Simplify max-burst calculation
 procedure
Message-ID: <tez5uqt4lg2qf5nooxuqo2rqhkqzzzbpeysdcbljokznbztkhj@j5t7cy4gd4pd>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-5-fancer.lancer@gmail.com>
 <Zh7NfmffgSBSjVWv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh7NfmffgSBSjVWv@smile.fi.intel.com>

On Tue, Apr 16, 2024 at 10:11:58PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 16, 2024 at 07:28:58PM +0300, Serge Semin wrote:
> > In order to have a more coherent DW AHB DMA slave configuration method
> > let's simplify the source and destination channel max-burst calculation
> > procedure:
> > 
> > 1. Create the max-burst verification method as it has been just done for
> > the memory and peripheral address widths. Thus the DWC DMA slave config
> 

> dwc_config() method
> 
> ?

Right. I'll just directly refer to the dwc_config() method here.

> 
> > method will turn to a set of the verification methods execution.
> > 
> > 2. Since both the generic DW AHB DMA and Intel DMA32 engines support the
> 

> "i" in iDMA 32-bit stands for "integrated", so 'Intel iDMA 32-bit'

Ok. Thanks for clarification.

> 
> > power-of-2 bursts only, then the specified by the client driver max-burst
> > values can be converted to being power-of-2 right in the max-burst
> > verification method.
> > 
> > 3. Since max-burst encoded value is required on the CTL_LO fields
> > calculation stage, the encode_maxburst() callback can be easily dropped
> > from the dw_dma structure meanwhile the encoding procedure will be
> > executed right in the CTL_LO register value calculation.
> > 
> > Thus the update will provide the next positive effects: the internal
> > DMA-slave config structure will contain only the real DMA-transfer config
> > value, which will be encoded to the DMA-controller register fields only
> > when it's required on the buffer mapping; the redundant encode_maxburst()
> > callback will be dropped simplifying the internal HW-abstraction API;
> > DWC-config method will look more readable executing the verification
> 

> dwc_config() method
> 
> ?

Ok.

> 
> > functions one-by-one.
> 
> ...
> 
> > +static void dwc_verify_maxburst(struct dma_chan *chan)
> 

> It's inconsistent to the rest of _verify methods. It doesn't verify as it
> doesn't return anything. Make it int or rename the function.

Making it int won't make much sense since currently the method doesn't
imply returning an error status. IMO using "verify" was ok, but since
you don't see it suitable please suggest a better alternative. mend,
fix, align?

> 
> > +{
> > +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> > +
> > +	dwc->dma_sconfig.src_maxburst =
> > +		clamp(dwc->dma_sconfig.src_maxburst, 1U, dwc->max_burst);
> > +	dwc->dma_sconfig.dst_maxburst =
> > +		clamp(dwc->dma_sconfig.dst_maxburst, 1U, dwc->max_burst);
> > +
> > +	dwc->dma_sconfig.src_maxburst =
> > +		rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
> > +	dwc->dma_sconfig.dst_maxburst =
> > +		rounddown_pow_of_two(dwc->dma_sconfig.dst_maxburst);
> > +}
> 
> ...
> 
> >  static int dwc_verify_p_buswidth(struct dma_chan *chan)
> > -		reg_burst = rounddown_pow_of_two(dwc->dma_sconfig.src_maxburst);
> > +		reg_burst = dwc->dma_sconfig.src_maxburst;
> 

> Seems you have a dependency, need a comment below that maxburst has to be
> "verified" [whatever] first.

Ok.

> 
> ...
> 
> > +static inline u8 dw_dma_encode_maxburst(u32 maxburst)
> > +{
> > +	/*
> > +	 * Fix burst size according to dw_dmac. We need to convert them as:
> > +	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3.
> > +	 */
> > +	return maxburst > 1 ? fls(maxburst) - 2 : 0;
> > +}
> 

> Split these moves to another preparatory patch.

Ok.

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

