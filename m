Return-Path: <dmaengine+bounces-2814-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657B6949BA3
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 00:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9CF28152D
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2024 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEC2171E5F;
	Tue,  6 Aug 2024 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH8sXMPg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD677166315;
	Tue,  6 Aug 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984993; cv=none; b=Mu1pghu7GogmHZnDE652KOyycfHld7XcHs+s2dlex1LBJJp/SBDOKJh2VdLwpyac7K7Ba8BBHgt6ZeYckAFYExWVp17H+77PanUY3e9vjQMvCBX+qPrJSnrUemfC7x6aLU/j8/4IWFq6kuovvCghMML5GyYzPHo6XAWG+zD+c2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984993; c=relaxed/simple;
	bh=AGF8Wes+2S1ihcpoWimyzIb+9qvNM6v88Dn1x3my1m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEecwa5fFZICnfbpmTmlE+gWhPO/3D6uXw84+ZT97JWakvlAhGX7+0K6DOHWY//+GOsKwb0kAdUdo2hHAw7mB1n/qePEXOsuV0WTmy2VdrOoqUwF+kiz7M+xrFe0GUNXkg+QZsN19acbnN802DcbLM900dKKMpSewREo7kijSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH8sXMPg; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso12375371fa.3;
        Tue, 06 Aug 2024 15:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722984989; x=1723589789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrMXil5vw9+KgOvjWbDHQPOszbyqeeeid6Li13iymvw=;
        b=DH8sXMPgS41vMPrPF4Be8R5pVJzNkTntQWJcKQs+luGtXXtgxifH0h3nkMoreOysqU
         p2Lzn1abARY2G/Es/6o1sUGDNag8yzWG7eIROFWxDth+cgm/OYQQpiHPFe2U4FCH/7mt
         C/zWJ/q4vJPq+EpZiudWynbewt0+9t6ytfy7bYu7z0tYLW6Rd6zOv4oveXqU5Nri5yp9
         R5bphpIgVhtLA28Wp17VjHXDr6n5Jk5rn+s1A54Z9Svsh1A55kCc+my3rTOOptc8eHcj
         eaDDMMzBWx1vO/qXKRnyumP+kA9ijND+w0Qi4bYfNLrUKHNcofRIEr3OFsUYgAUd1VHs
         UMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722984989; x=1723589789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrMXil5vw9+KgOvjWbDHQPOszbyqeeeid6Li13iymvw=;
        b=AiG7eIEX7FVkDW6otP+14i8W9hlJS/YfCrNQ9nR66nItoTZG0+tcopwJL/wYTTdO6+
         A+FU8uFKKZIGt+Sq76XdeASc63tQ6qJaq2LJYccbaUUbUJ0bcUudOBDTgrPwSGsKPUaV
         zQNnvwmrl33dI2Tws4xBpyfqe0guamjGSVFaIJNQJHsWUiCc9dGeZm9OQgRTWkQIPAKo
         153knUd5YLwdK7EIg0xhSR60ZLg7I66+/nisk6Ac/HLro6PxUZW7Iq8rDpinv8nMW5iG
         M5qsg7iZS9HgDPmIKDhSe1RE6FkupMELSNR4JO6pKY1sWl/bdBQOb+L3UWuUDMiO72ZW
         ergQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW1S9UVMWAfaPgl6Ki4WiwMbGMt7b1iSkgblDdEZ3T9+b/2yH5HdoVFNvKaaDi+7hcQTXyJh91e5rMKy2jOk5x5tZ+QmfF+ZmyLfg5OS+q/QfT/vFESGC1YflSD/SgRwLx+MnVeAyS1Z3zwTCuhAoH8+16+EuSvnozcUPBPmf5
X-Gm-Message-State: AOJu0YxhTZ55B1WaSjOgnA6ze31mCgQHA+E+84SgmK59WaFb5cO/Bcy4
	AgzMf000co1gbHyJR1jGxj5Niyy98+COrsLnO0cL0/gOLeC2P0nv
X-Google-Smtp-Source: AGHT+IGLCXB4DRmami9ecPshLKGo/Uw8vS+h9gAE9JHhgtSfj6R8IJgvubljJDek2ZST1taDgx0+IA==
X-Received: by 2002:a2e:b170:0:b0:2ef:1bd5:bac3 with SMTP id 38308e7fff4ca-2f15ab419camr115890461fa.41.1722984988646;
        Tue, 06 Aug 2024 15:56:28 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e2600d2sm16142501fa.116.2024.08.06.15.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:56:28 -0700 (PDT)
Date: Wed, 7 Aug 2024 01:56:26 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	stable@vger.kernel.org, Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: dw-edma: Fix unmasking STOP and ABORT
 interrupts for HDMA
Message-ID: <by7uqtmnx4jjxigbm3lrpp2b3eqcrq3byqrrmexmkkigtjxdir@o7ahdlhpgzjl>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-2-git-send-email-quic_msarkar@quicinc.com>
 <dnvoktjxx2m5oy2m5ocrgyd4veypnjbjnth364hl32ou4gm3t2@tjxrsowsabgr>
 <6faa27be-54eb-ca00-f2a8-de3eb6fa7547@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6faa27be-54eb-ca00-f2a8-de3eb6fa7547@quicinc.com>

On Mon, Aug 05, 2024 at 07:30:14PM +0530, Mrinmay Sarkar wrote:
> 
> On 8/2/2024 5:12 AM, Serge Semin wrote:
> > On Tue, Jul 23, 2024 at 06:49:31PM +0530, Mrinmay Sarkar wrote:
> > > The current logic is enabling both STOP_INT_MASK and ABORT_INT_MASK
> > > bit. This is apparently masking those particular interrupts rather than
> > > unmasking the same. If the interrupts are masked, they would never get
> > > triggered.
> > > 
> > > So fix the issue by unmasking the STOP and ABORT interrupts properly.
> > > 
> > > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > > cc: stable@vger.kernel.org
> > > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > > ---
> > >   drivers/dma/dw-edma/dw-hdma-v0-core.c | 9 +++++----
> > >   1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index 10e8f07..fa89b3a 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -247,10 +247,11 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >   	if (first) {
> > >   		/* Enable engine */
> > >   		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> > > -		/* Interrupt enable&unmask - done, abort */
> > > -		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > > -		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
> > > -		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> > Just curious, if all the interrupts were actually masked, how has this
> > been even working?.. In other words if it affected both local and
> > remote interrupts, then the HDMA driver has never actually worked,
> > right?
> 

> Agreed, it should not work as interrupts were masked.
> 
> But as we are enabling LIE/RIE bits (LWIE/RWIE) that eventually enabling
> watermark
> interrupt in HDMA case and somehow on device I could see interrupt was
> generating with watermark and stop bit set and it was working.
> Since we were not clearing watermark interrupt, it was also causing storm of
> interrupt.

Is it possible that the HDMA_V0_STOP_INT_MASK and
HDMA_V0_ABORT_INT_MASK masks affect the local IRQs only? If so than
that shall explain why for instance Kory hasn't met the problem. 

Based on the "Interrupts and Error Handling" figures of the DW EDMA
databook the DMA_READ_INT_MASK_OFF/DMA_WRITE_INT_MASK_OFF CSRs mask of
the IRQ delivered via the edma_int[] wire. Meanwhile the IMWr TLPs
generation depend on the RIE/LLRAIE flags state only.

> 
> > > +		/* Interrupt unmask - STOP, ABORT */
> > > +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) &
> > > +		      ~HDMA_V0_STOP_INT_MASK & ~HDMA_V0_ABORT_INT_MASK;
> > Please convert this to:
> > +		/* Interrupt unmask - stop, abort */
> > +		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
> > +		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> > 
> > -Serge(y)
> 
> Sure. Will do

Thanks.

-Serge(y)

> 
> Thanks,
> Mrinmay
> 
> > > +		/* Interrupt enable - STOP, ABORT */
> > > +		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> > >   		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > >   			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
> > >   		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> > > -- 
> > > 2.7.4
> > > 

