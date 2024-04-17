Return-Path: <dmaengine+bounces-1878-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162C58A8C57
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 21:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352301C221FD
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 19:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8702C68A;
	Wed, 17 Apr 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5PAOtio"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6328DD5;
	Wed, 17 Apr 2024 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713383688; cv=none; b=N0f+02KP1MtOPaB241ShtgzKh6mrMxTw93gq57jhU+GRuXuCmlQEUU09GE8wrg2jqlRd2+5EHMMgctj0emsCN97CoDzH3IBC3WYMuZcj3lycGzqmIErXzlnOuQ4bgfQ5oSVlTzbo8zdrGvYM6qxjQNQdXilBLkNbyrgKcRksHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713383688; c=relaxed/simple;
	bh=Zf/OMyMDhlIYfCAkZI3UPMiUTOJQR+SmhpgNPSXKDpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X16pVfwPBqszUl1BQvWdx3Y0tKWDhTw7cqnFrRKefp9xleIGTY89YPPEnE4D42DyfO0MwKWDdfeE91hpTMjtt4cYOaFH5ZZE1ZZ6xwlrGh2MEhIhaCHKw+bKROGrd0m5eQe4D19y6JFtISNIBIJc26PLl25dSxC03wVNw+v6ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5PAOtio; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so1966061fa.2;
        Wed, 17 Apr 2024 12:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713383685; x=1713988485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36yFaWb1Z3OgIPBn349UV5rtPMU6W5yanAqR4oXTBMg=;
        b=f5PAOtiokFvyqxXzb4yaq111H9jwj/GCZN7Z6CVCitr7FzaKeJNV36MlcSOx1iSIAq
         koPbOLvICM2HHR/BqidxCGcv8g+5zhKCq6ngHtHNn0RmUCkWWBPaWxxGQdyw5tliDM5V
         9IuqgWFYKnz+0uKc44BpRZfTjTINR1J2qAZb1B6wUljXhCPR/+qbhgN2+5uYGvsw5OPC
         vqagjm63zJR62Vl13UiOi28YjBUcwD4nM8Kgf69Xa98ueNuXeLLRvzCxKJTkGPGqF9df
         Q5Syr690e8A9geqOi80fSKmEdGzPOjnAYFPh5TyLyLBHXMYzm4ro71LF6SatEgAo6rsn
         KvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713383685; x=1713988485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36yFaWb1Z3OgIPBn349UV5rtPMU6W5yanAqR4oXTBMg=;
        b=S8N6kTEey9+4SRBcww5wfMDkC1F79ieqwY9IUuNOl8tfGqNHxNtDODGTgDgsIjdTbJ
         jw5OoTZArh/RmiLalmbcpm+oQssAT13aQm6benV8F4WADqSGFAFmoJ/BgOXSmdUXftK2
         rjfDNAYBajisLu6E4SCZoLwYvTz02hgYwcEhq73hO8kec2a9ic+qN2kFvEJuiajZVKdI
         GwnkM2+K+kxITDpTGn25VwfnnMw0zR73ia+JTqh/KQMZTEL7Z0+bmU2bdKPWXUVd8yNY
         z6urIZqSBlWl4fztPShI2FfAYjL2YsuO95R+9fcEUZeLKqb1O1YCKNHoiWnZYGP7s7dj
         yivw==
X-Forwarded-Encrypted: i=1; AJvYcCU63xdxKV05tZeCLoUpHvCbE9Bf7KCy/xjjZZ6x7/lJZd/+Q7A3+ZTESLGHulq4MoYfM9Hn/A9ydPD17Ka4778u3UICEWlDp9diyDrn8dMImD2Pu4o40gEkGKq6GwobIpY637lHL3kPKGN0Qle5CCKe5TijjNupRol7lp0SLAnR2yzzfbav
X-Gm-Message-State: AOJu0Yy+GyjqEeNIGiMW897nLoGnrGK3s7fDHchgShqW6SPUpKPIVU4W
	pxHg/38mu5TYXuompE6sY4RSf7SSomP9OlH2nAaCdBnRdxWR6KliQK82oxAr
X-Google-Smtp-Source: AGHT+IHwkYbHUCRTNdHCafOnJ+v5cGpOTEYWAc8fzpKrdrcvjqn/iqabdLsEaqWzQ7Kdzmx/G05Yxw==
X-Received: by 2002:a2e:900e:0:b0:2d8:3dc7:e302 with SMTP id h14-20020a2e900e000000b002d83dc7e302mr201574ljg.2.1713383684666;
        Wed, 17 Apr 2024 12:54:44 -0700 (PDT)
Received: from mobilestation.baikal.int (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id y1-20020a2e95c1000000b002d2d1c11703sm1965709ljh.76.2024.04.17.12.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 12:54:44 -0700 (PDT)
Date: Wed, 17 Apr 2024 22:54:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: dw: Add peripheral bus width verification
Message-ID: <ut5notgwnjdj7ex3jeo7jnbdc2vhopebdg3miepto2wfrxti4b@b2xksvotrgph>
References: <20240416162908.24180-1-fancer.lancer@gmail.com>
 <20240416162908.24180-2-fancer.lancer@gmail.com>
 <Zh680h4h6hURIb82@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh680h4h6hURIb82@smile.fi.intel.com>

On Tue, Apr 16, 2024 at 09:00:50PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 16, 2024 at 07:28:55PM +0300, Serge Semin wrote:
> > Currently the src_addr_width and dst_addr_width fields of the
> > dma_slave_config structure are mapped to the CTLx.SRC_TR_WIDTH and
> > CTLx.DST_TR_WIDTH fields of the peripheral bus side in order to have the
> > properly aligned data passed to the target device. It's done just by
> > converting the passed peripheral bus width to the encoded value using the
> > __ffs() function. This implementation has several problematic sides:
> > 
> > 1. __ffs() is undefined if no bit exist in the passed value. Thus if the
> > specified addr-width is DMA_SLAVE_BUSWIDTH_UNDEFINED, __ffs() may return
> > unexpected value depending on the platform-specific implementation.
> > 
> > 2. DW AHB DMA-engine permits having the power-of-2 transfer width limited
> > by the DMAH_Mk_HDATA_WIDTH IP-core synthesize parameter. Specifying
> > bus-width out of that constraints scope will definitely cause unexpected
> > result since the destination reg will be only partly touched than the
> > client driver implied.
> > 
> > Let's fix all of that by adding the peripheral bus width verification
> > method which would make sure that the passed source or destination address
> > width is valid and if undefined then the driver will just fallback to the
> > 1-byte width transfer.
> 

> Please, add a word that you apply the check in the dwc_config() which is
> supposed to be called before preparing any transfer?

Ok.

> 
> ...
> 
> > +static int dwc_verify_p_buswidth(struct dma_chan *chan)
> > +{
> > +	struct dw_dma_chan *dwc = to_dw_dma_chan(chan);
> > +	struct dw_dma *dw = to_dw_dma(chan->device);
> > +	u32 reg_width, max_width;
> > +
> > +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
> > +		reg_width = dwc->dma_sconfig.dst_addr_width;
> > +	else if (dwc->dma_sconfig.direction == DMA_DEV_TO_MEM)
> > +		reg_width = dwc->dma_sconfig.src_addr_width;
> 
> > +	else /* DMA_MEM_TO_MEM */
> 

> Actually not only this direction,

DW DMAC driver supports only three directions:
	dw->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
			     BIT(DMA_MEM_TO_MEM);
so in this case the else-clause is intended to be taken for the
DMA_MEM_TO_MEM transfers only.

> but TBH I do not see value in these comments.

Value is in signifying that DMA_MEM_TO_MEM is implied by the else
clause. If in some future point we have DMA_DEV_TO_DEV support added
to the driver, then the if-else statement must be aligned
respectively.

> 
> > +		return 0;
> > +
> > +	max_width = dw->pdata->data_width[dwc->dws.p_master];
> > +
> > +	/* Fall-back to 1byte transfer width if undefined */
> 

> 1-byte
> (as you even used in the commit message correctly)

Ok.

> 
> > +	if (reg_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
> > +		reg_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
> > +	else if (!is_power_of_2(reg_width) || reg_width > max_width)
> > +		return -EINVAL;
> > +	else /* bus width is valid */
> > +		return 0;
> > +
> > +	/* Update undefined addr width value */
> > +	if (dwc->dma_sconfig.direction == DMA_MEM_TO_DEV)
> > +		dwc->dma_sconfig.dst_addr_width = reg_width;
> > +	else /* DMA_DEV_TO_MEM */
> > +		dwc->dma_sconfig.src_addr_width = reg_width;
> 

> So, can't you simply call clamp() for both fields in dwc_config()?

Alas I can't. Because the addr-width is the non-memory peripheral
setting. We can't change it since the client drivers calculate it on
the application-specific basis (CSR widths, transfer length, etc). So
we must make sure that the specified value is supported.

> 
> > +	return 0;
> > +}
> 
> ...
> 
> > +	int err;
> 

> Hmm... we have two functions one of which is using different name for this.

Right, the driver uses both variants (see of.c, platform.c, pci.c too).

> Can we have a patch to convert to err the other one?

To be honest I'd prefer to use the "ret" name instead. It better
describes the variable usage context (Although the statements like "if
(err) ..." look a bit more readable). So I'd rather convert the "err"
vars to "ret". What do you think?

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

