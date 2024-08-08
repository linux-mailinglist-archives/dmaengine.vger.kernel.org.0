Return-Path: <dmaengine+bounces-2825-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4CA94C5B7
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 22:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C65B23F26
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2024 20:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560A158D96;
	Thu,  8 Aug 2024 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXPweJ3p"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E49C7E1;
	Thu,  8 Aug 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148887; cv=none; b=WGVhBPTELYFv7gVCgL29cRi9qWaPZxFF0gDbCzcy1e/1he9GuA5hVKwM4BHi7wmm3c51NHgppZu2QchdwM9AnkI9eDiiujgVnFAz+VbrPoa/piaiRJNYV81s9mQBHXznxJ1R2vy0TY2ETr8fbFkNjYfjhKTjRwjBCP6Dt9CtnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148887; c=relaxed/simple;
	bh=luR+kUrPWlxUmYKCbA8iZ3L51l1iEb4oO4WjMPt0Bo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/P9m1TxuElBpknFa0P4M+Hs7sVPED646/zyT8MIrq3EEVDAg0jR09OGVgX248oXpUm3hmOIH9X3OGD4ckNllH5wBGDBSvc5DlesummKyGCSuT+xWDpScPfOBip7F+0lhPzrvx0a9tu2u7IbYKOBibTUJuS+D4+UFMjNWE9Wjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXPweJ3p; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efd8807aaso1615450e87.3;
        Thu, 08 Aug 2024 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723148883; x=1723753683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c80j+4TiY904umyDCcnZLR5uaPsGqlXuL9z9M9m3hw4=;
        b=gXPweJ3pw52OPhRP1Ui505pUhdMt6lNN5Es3G+UkPNsUhnp0B9MvOdP5vD4aFMcjiM
         tHvzx8BlM8O1SHx7UXZ4DLBBBHuemkdqiqHkW2NA+FuSI5A6KSGE0WXwJYAP+FbtGhIU
         +AGF6yEMNKQnCMqLRu4fMTonXfXeeqeZUGd0pFmuLEoPGmwZ2HEmG7YUhTTuaCzsObF5
         h6VbAEBv7IHhmZ7BpAHTWEj41mjcQR8ugZE7potM+EQwfry1AreNDN7q41cW527q7JnF
         3Ca7nqdn8mnjOTRgo/f255jxbUIskm2g+hBAao5UIXKkumrqimkwYUtSiAaqWzfYmBvC
         uq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148883; x=1723753683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c80j+4TiY904umyDCcnZLR5uaPsGqlXuL9z9M9m3hw4=;
        b=qZGZ4PY6Rx/wFUep/HQxb8bG2b7/SarzduBZzPY8xbW9M//1spnBG2c3ssD42Jy7+x
         ToLYpdue+p0eN1T4lpFDrjZa4ebiq/U3nDCJT9dnkKg6MTFdgpLUrehHMbpz6AgQiPjH
         Ku99LDwFqlFK4M/m8vxKfoJLTUs6HU60YPE9ibOuO8qmMoL77Ci+/TRuCwdHrK760CLT
         NxKv43uY52JO/FPzD78ZeucdsPNjPxpgidf7Oa9PunBYB2vsT9L20z3KKDRNMyU/ktxh
         pHgQzn9XO/7273c/aLthtq8D52G6s849DYldPxE1sgPyJvoCiR3duPKydG1gq83MNQq9
         gWbg==
X-Forwarded-Encrypted: i=1; AJvYcCX3lSFx1VKXXfVdGlMhq/xSwT8cPoJroQXtmyEOQLzwJJedQJ9egvsXQ72XhvGZYrkd6Omnrz0XvJunr7kogxAAAJ3l7wkdTBxExDNKd95R/QsIS14OnHBQVFUJvQWTKb0mMr2JmwDV7HnsoL7r6l6fQSvUgBG9hlGCMmAPnHKz
X-Gm-Message-State: AOJu0YwOnjVu2vSQWvUILEQY83g3UH7jU0aZ1SGPl4b9ZD0IiNdqzpcq
	6f8JijMU/MhPDIrDvnkZNl/7ync6X8dzg86aGZ9UNHOAufRB9ClxyLsHZQ==
X-Google-Smtp-Source: AGHT+IH8ZkJy2U5DH9ldfUkSLOGVb/+9yGdqvzJjDqqY7Krb2ZBUR9X328T65O7D6dCJvMwBd16kmg==
X-Received: by 2002:a05:6512:304f:b0:52f:6f49:3593 with SMTP id 2adb3069b0e04-530e588a9b3mr2000282e87.34.1723148882995;
        Thu, 08 Aug 2024 13:28:02 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de47a486sm751255e87.262.2024.08.08.13.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 13:28:02 -0700 (PDT)
Date: Thu, 8 Aug 2024 23:28:00 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	stable@vger.kernel.org, Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT
 interrupts for HDMA
Message-ID: <n6l5kuuyrmwe7n3ehelf45axhzxo7hfbpzbmjuua3rt2gibd7d@baxj3xxpykcu>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-2-git-send-email-quic_msarkar@quicinc.com>
 <dnvoktjxx2m5oy2m5ocrgyd4veypnjbjnth364hl32ou4gm3t2@tjxrsowsabgr>
 <6faa27be-54eb-ca00-f2a8-de3eb6fa7547@quicinc.com>
 <by7uqtmnx4jjxigbm3lrpp2b3eqcrq3byqrrmexmkkigtjxdir@o7ahdlhpgzjl>
 <b7fd3fac-77e4-7aad-e97a-c210aeb53773@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7fd3fac-77e4-7aad-e97a-c210aeb53773@quicinc.com>

On Wed, Aug 07, 2024 at 10:49:42PM +0530, Mrinmay Sarkar wrote:
> 
> On 8/7/2024 4:26 AM, Serge Semin wrote:
> > On Mon, Aug 05, 2024 at 07:30:14PM +0530, Mrinmay Sarkar wrote:
> > > On 8/2/2024 5:12 AM, Serge Semin wrote:
> > > > On Tue, Jul 23, 2024 at 06:49:31PM +0530, Mrinmay Sarkar wrote:
> > > > > The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
> > > > > bit. This is apparently masking those particular interrupts rather than
> > > > > unmasking the same. If the interrupts are masked, they would never get
> > > > > triggered.
> > > > > 
> > > > > So fix the issue by unmasking the STOP and ABORT interrupts properly.
> > > > > 
> > > > > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > > > > cc: stable@vger.kernel.org
> > > > > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > > > > ---
> > > > >    drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
> > > > >    1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > > > index 10e8f07..fa89b3a 100644
> > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > > > @@ -247,10 +247,11 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > > >    	if (first) {
> > > > >    		/* Enable engine */
> > > > >    		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> > > > > -		/* Interrupt enable&unmask - done, abort */
> > > > > -		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > > > > -		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
> > > > > -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > Just curious, if all the interrupts were actually masked, how has this
> > > > been even working?.. In other words if it affected both local and
> > > > remote interrupts, then the HDMA driver has never actually worked,
> > > > right?
> > > Agreed, it should not work as interrupts were masked.
> > > 
> > > But as we are enabling LIE/RIE bits (LWIE/RWIE) that eventually enabling
> > > watermark
> > > interrupt in HDMA case and somehow on device I could see interrupt was
> > > generating with watermark and stop bit set and it was working.
> > > Since we were not clearing watermark interrupt, it was also causing storm of
> > > interrupt.
> > Is it possible that the HDMA_V0_STOP_INT_MASK and
> > HDMA_V0_ABORT_INT_MASK masks affect the local IRQs only? If so than
> > that shall explain why for instance Kory hasn't met the problem.
> > 
> > Based on the "Interrupts and Error Handling" figures of the DW EDMA
> > databook the DMA_READ_INT_MASK_OFF/DMA_WRITE_INT_MASK_OFF CSRs mask of
> > the IRQ delivered via the edma_int[] wire. Meanwhile the IMWr TLPs
> > generation depend on the RIE/LLRAIE flags state only.
> Ideally HDMA_V0_STOP_INT_MASK and HDMA_V0_ABORT_INT_MASK masks affect
> both local and remote IRQs.
> 

> As per DW HDMA "Interrupts and Error Handling" figure
> HDMA_INT_SETUP_OFF_[WR|
> RD] mask of the IRQ delivered via the edma_int[] wire.

So it means they indeed affect the Local IRQs only, since the
edma_int[] wire is the line locally connected to the host IRQ
controller. From that perspective the semantics is the same as of
the DMA_READ_INT_MASK_OFF/DMA_WRITE_INT_MASK_OFF CSR masks.

Thanks for clarification.

> And IMWr TLPs generation depend on 3 flags i.e HDMA_INT_SETUP_OFF_[WR|
> RD].RSIE flag for stop IMWr, RWIE flag for watermark IMWr and
> HDMA_INT_SETUP_OFF_[WR|R
> D].RAIE flag for abort IMWr generation.
> 
> Thanks,
> Mrinmay
> > > > > +		/* Interrupt unmask - STOP, ABORT */
> > > > > +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
> > > > > +		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;
> > > > Please convert this to:
> > > > +		/* Interrupt unmask - stop, abort */
> > > > +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
> > > > +		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> > > > 
> > > > -Serge(y)
> > > Sure. Will do

I'll wait v3 to finish up the review.

-Serge(y)

> > Thanks.
> > 
> > -Serge(y)
> > 
> > > Thanks,
> > > Mrinmay
> > > 
> > > > > +		/* Interrupt enable - STOP, ABORT */
> > > > > +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > >    		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > >    			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
> > > > >    		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> > > > > -- 
> > > > > 2.7.4
> > > > > 

