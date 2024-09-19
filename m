Return-Path: <dmaengine+bounces-3191-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5597CC11
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BDB28563C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Sep 2024 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790C1A01BA;
	Thu, 19 Sep 2024 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ2JGhzq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EB81A00D4;
	Thu, 19 Sep 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762251; cv=none; b=JYj6bGvgJeRSx6mefgCi8vBZe/YpezUY7QNX7HblN0fi7lAM8mjWFde+snzDT2XTVmO0+8RGKKowOmuxO4MDP0/+NkeO7nKlFJGzS1+d27ZO1z6KdH885lVf/gsLuYpSEncoQfoODOvoQjj4Tm/aK3p27nBu3FdCwG9tgCD6Okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762251; c=relaxed/simple;
	bh=vNXh72NTzQafdXnO9HV0cLFQHRsid5cgIk5gtFlFcX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq2F209CwHz4bN8Rphay0p0+STDwRhN7Iz34rRKkSxVdE3/DlWtXeDKZ9C4+4EaLDVwElX9UkGA9z28eEwpXjGNqnRyZFmbKKnE3G4Fh1ncIwfnM6DyokE3JJt9rQ1rqaDTFu9VEI9u39vTqrxzpRAU4QEdPK+6aondshO6yiy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZ2JGhzq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso14349031fa.0;
        Thu, 19 Sep 2024 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726762248; x=1727367048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g78NkNPBDQYIbieK2QsYn6ajxDOxDEcElZjpXoVH0Yc=;
        b=KZ2JGhzqcT9EWZ5lp6mWWlPfc3WISmXy4uKPJ9YqnEaVqI2nDpYoUHN+xkSFyhfxoI
         gevMuWBpFu2apGCHVu6TBxl/CQGhhciLLmmqznO9s24OUI/5RrKXIxqQr869HjL6jqcO
         n9chSgQR7tiJOTkUY8K28C/1YhVNCwAcYxFFf1M7n37PrLWNn8EDpnZWsfA4ZqCmDVuu
         5M5e6c1e1QisDQxBQUkPUCGGmulqYaJfDbU8pRhKyOVRAB/722ZCSa7d41oD8irfU/oK
         ZxiRb4qZtdfxXqripIiHRPK0J1K6yiYN0xvs9jk5vWdJiFPmlHdsJCusu94LFblZsMAJ
         vWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726762248; x=1727367048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g78NkNPBDQYIbieK2QsYn6ajxDOxDEcElZjpXoVH0Yc=;
        b=AnAHQXG27KAFiu38lyNLcz3lfDBvsZ265Dx48t71tDvrj5G5ali5+44MFfh/x8UKVI
         XPU18LSUFT0qe9bRiu5bu4BfsURsvNsJ5AzLjX7FDROrzmM7fceo5lGS1XxRmLubOAtO
         am1HXJEsbM+CI534aDSyB/836jiyADf93Om/k6BuzRVUFgNYdDieOkciTz0zkIhrLufO
         zAevts0V4p6qOL648tDlYy9OvlkhlDo7C4rftpKimZCouyvpTJ0/Kc0X0+ZA14I3twTq
         g9o6ZDdgRYTeVCCaAFAvdhJBiLIuL9pfvDvAMeLARR42XHsrOa114AJy0FAC3a1Kv98b
         tRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLkpNcsTWhWmAaUbbcJeltQwcFXtS/IGbtdv5KYRQL/TKvHFvtVsjjT1mHI/ceHxFTQ+NXttwd@vger.kernel.org, AJvYcCVfWaZNEFTBJv/e7r1yp1SKP9VNcd4ueYd3d4DQ6wmO4sl7kPcpSfKX96bx7/QyaNGI7bni/P0rmL/nZoaF@vger.kernel.org, AJvYcCWQmHGGj4ty+TapEamLQG6f2w349RgDP73mzXPTEpAtrxe2qc1AuzQNgKhykPcjT35kz2sZD6cTG+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9uWJs/1ASnt53yoeJEn+DmTnNJ+9dOC4WSVhRnW87+eU2I/y4
	eOGNI81CspGvJ4qo0aUJ16XBMvSzpTbahneAua2YU7P0tj5RFYjLyj4nLQ==
X-Google-Smtp-Source: AGHT+IEwyKiN46zAOVee1Mo60AKnWlY43Ul7al/bHcmwpfMcFv0b/g60GWa61kMrCAqA/keiD4fQdQ==
X-Received: by 2002:a05:6512:33ca:b0:535:3d15:e709 with SMTP id 2adb3069b0e04-53678fb1d20mr14932693e87.12.1726762247644;
        Thu, 19 Sep 2024 09:10:47 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870969bfsm1862540e87.157.2024.09.19.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 09:10:46 -0700 (PDT)
Date: Thu, 19 Sep 2024 19:10:44 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Ferry Toth <fntoth@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw: Select only supported masters for ACPI
 devices
Message-ID: <otjmputocysfzhnowwqa5trusbuyw4zfm27prknk2h2lzk3tzy@3eopxiwemvgb>
References: <20240919135854.16124-1-fancer.lancer@gmail.com>
 <Zuw_vllDMRKD-sC8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zuw_vllDMRKD-sC8@smile.fi.intel.com>

On Thu, Sep 19, 2024 at 06:14:06PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 19, 2024 at 04:58:14PM +0300, Serge Semin wrote:
> > The recently submitted fix-commit revealed a problem in the iDMA32
> > platform code. Even though the controller supported only a single master
> > the dw_dma_acpi_filter() method hard-coded two master interfaces with IDs
> > 0 and 1. As a result the sanity check implemented in the commit
> > b336268dde75 ("dmaengine: dw: Add peripheral bus width verification") got
> > incorrect interface data width and thus prevented the client drivers
> > from configuring the DMA-channel with the EINVAL error returned. E.g. the
> > next error was printed for the PXA2xx SPI controller driver trying to
> > configure the requested channels:
> > 
> > > [  164.525604] pxa2xx_spi_pci 0000:00:07.1: DMA slave config failed
> > > [  164.536105] pxa2xx_spi_pci 0000:00:07.1: failed to get DMA TX descriptor
> > > [  164.543213] spidev spi-SPT0001:00: SPI transfer failed: -16
> > 
> > The problem would have been spotted much earlier if the iDMA32 controller
> > supported more than one master interfaces. But since it supports just a
> > single master and the iDMA32-specific code just ignores the master IDs in
> > the CTLLO preparation method, the issue has been gone unnoticed so far.
> > 
> > Fix the problem by specifying a single master ID for both memory and
> > peripheral devices on the ACPI-based platforms if there is only one master
> > available on the controller. Thus the issue noticed for the iDMA32
> > controllers will be eliminated and the ACPI-probed DW DMA controllers will
> > be configured with the correct master ID by default.
> 
> ...
> 
> >  static bool dw_dma_acpi_filter(struct dma_chan *chan, void *param)
> >  {
> > +	struct dw_dma *dw = to_dw_dma(chan->device);
> >  	struct acpi_dma_spec *dma_spec = param;
> >  	struct dw_dma_slave slave = {
> >  		.dma_dev = dma_spec->dev,
> >  		.src_id = dma_spec->slave_id,
> >  		.dst_id = dma_spec->slave_id,
> >  		.m_master = 0,
> > -		.p_master = 1,
> 

> I would leave this line as is and it makes more consistent in my opinion with
> the below comments which starts with the words "Fallback to...".

Ok.

> 
> >  	};
> >  
> > +	/*
> > +	 * Fallback to using a single interface for both memory and peripheral
> > +	 * device if there is only one master I/F supported (e.g. iDMA32)
> > +	 */
> > +	if (dw->pdata->nr_masters == 0)
> 

> Why '== 0' and not '== 1'? Or '>= 2' if you wish to be on the save side (however,
> that '== 0' case is not obvious to me — do we really have that IRL?).

I several times checked the patch and never noticed this obvious typo.
Indeed nr_masters is the actual number of masters. So the statement should
have been '== 1'.

> 
> > +		slave.p_master = 0;
> > +	else
> > +		slave.p_master = 1;
> 
> > +
> > +
> 

> One blank line is enough.

Fully agreed.

I guess I was too hurrying to submit the fix so missed two stupid
mistakes in just 7-lines patch. "Nice" anti-record for me. Sorry about
that and much appreciated for reviewing the bit. I'll resubmit v2
shortly.

-Serge(y)

> 
> >  	return dw_dma_filter(chan, &slave);
> >  }
> 
> ...
> 
> P.S. I'll test it later this or next week, if Ferry wouldn't beat me up to it.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

