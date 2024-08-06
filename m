Return-Path: <dmaengine+bounces-2813-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA05949B58
	for <lists+dmaengine@lfdr.de>; Wed,  7 Aug 2024 00:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC661C217B8
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2024 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6BA16EC0B;
	Tue,  6 Aug 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTxaBvJe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7011C77F08;
	Tue,  6 Aug 2024 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983751; cv=none; b=AvZtCew7gM0WgocBkty3w2tYjPeDPG8/AI4LNMUqRdPbYtxVlCpdLX3Skh0oGjOBVkxcDtMmlik3Z1FRwYwfbIuYcJWskvM+YO9i/xuDHhwNFuvzBUjyNOb5984aO16e2794VIja7UkTArlDGHE1pJq9Qi8DwLTGBSAQtlF7V5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983751; c=relaxed/simple;
	bh=QjeG6XSx6npl766/YfctUO/Xh6ulJejrxrM8T8aXNQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr3fxxRZx0QkCAOkgTaLLjpSSZAjceUJo/jrOU3ZKORjJGj14ZGpFBe1CUZZh+jDknAd7GYM2CDHnCHSQ6ci5svPhIopvGBWBNGOnPcHKl7EWNkp8j+FffaaHz9SThGiTc9HQnJrGVNSjLZPzVeWHWTw3P5pgkfbKBy0xhuFbY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTxaBvJe; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f00ad303aso1872004e87.2;
        Tue, 06 Aug 2024 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722983747; x=1723588547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztVUW8Hx+ysmnFD5rRoNBk5NimiGhPqZjA6lkU0QWRA=;
        b=kTxaBvJeeHDa5vw9XO3foWThlrhNj4dy7DYTiSZT3nNgeI5jA3NwtotIQdc3T/CcnD
         pWr8OHJpYme9jP/oG5yg4Bb4/EhDVDw7S8Xz2G5RF+5gS1K4qFuPIdknfH7ZOOH6vG1P
         wdjXAGTRa6glBc4SXcCv4nou7eVTnxVEZ+RQ+qwgpWBOaxVpMfvnoxVpA7Iq9+31TbkJ
         B0HZXmYbLK4kEIdYuuHMp5xJnEMTohSpfAP7+AK5JRawc62i33igHm/5Tp5yTW3XBNgj
         yiNk/pwhcsaNhNJiJhgzO9JywKTREiPp+zr1aGPwoC7rI2g4aeYxNn3eGcCon06uFZQW
         Dr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722983747; x=1723588547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztVUW8Hx+ysmnFD5rRoNBk5NimiGhPqZjA6lkU0QWRA=;
        b=pDBTBZqV5VoILeuhTYfziXdV58wVkmgEuYbUNV3kppAtH7jLvkVD0Ykq8HEAXoplYB
         Te9oBUM9cntQ95Q5U6KCiZudqUKcjz6B9HFh1PamQ8ro6VDlNtsRn2+X069f1R+bSBB3
         o4zWKAUZAN58JwAR9MMP7i6d+McZHtiEgO70jQyVnYZP8MusZBaXTbjY9RZE6y338Ni5
         G7lRFE2qEkyPtoBmR+XCXF8SNjue7izZT/AsaBz6wPNk9yZYQE9gaR+5LjkDCwZQlgZV
         SmT0R5FvMGtFYCGlHCDJ40f99zaComk/ewTJ5zGU2np92IwJJ/n3wQtXYO71LyT/kAvL
         WV7g==
X-Forwarded-Encrypted: i=1; AJvYcCXvWgvFjlpsxzDu4wPuc3D9Ibz+zYZ0z2ElPfrpSrFPk91xrilsUIoTzi0eTDz3RCWugmb+4KtvMr9m39KsimSJ6AkBEwNT8guwlq2J5OIxd4Qls24Z1tWznnk3IFTodyqLxeIJSOMTmgkH0YSjnVJjRHgcIGYBEpEHnqZ5dlAl
X-Gm-Message-State: AOJu0YxY6FZROaWzCED8d5BieEfqoXp3uBeItuhsZWLPYwiPkv91qIQ0
	/Eicqgp6r2iPluGdkJM7rB2j0gHlBFjo/+X9ebUhYORyU4OH8KiEV8oydK7g
X-Google-Smtp-Source: AGHT+IFWmSJ5aLjCVBnRqlMlFllTBp/TP3Np9PbdA8V7YKFIHEIoh4lFSa4u9vijBo//5jW7I8ZsQA==
X-Received: by 2002:a05:6512:2808:b0:52e:be30:7e7 with SMTP id 2adb3069b0e04-530bb39297dmr10209251e87.1.1722983747009;
        Tue, 06 Aug 2024 15:35:47 -0700 (PDT)
Received: from mobilestation ([95.79.225.241])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de3e2fbdsm9145e87.20.2024.08.06.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 15:35:46 -0700 (PDT)
Date: Wed, 7 Aug 2024 01:35:44 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	stable@vger.kernel.org, Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: dw-edma: Do not enable watermark
 interrupts for HDMA
Message-ID: <2cz6ue6bxrpaccwt6o6rxvcybnftfruzrweb7j6b7gfchiszoh@sjibygsahdmu>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-3-git-send-email-quic_msarkar@quicinc.com>
 <mhfcw7yuv55me2d7kf6jh3eggzebq6riv5im4nbvx6qrzsg2mr@xpq3srpzemkb>
 <4f7dafa5-ba2a-f06f-0fff-8251969b283a@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f7dafa5-ba2a-f06f-0fff-8251969b283a@quicinc.com>

On Mon, Aug 05, 2024 at 07:34:46PM +0530, Mrinmay Sarkar wrote:
> 
> On 8/2/2024 6:04 AM, Serge Semin wrote:
> > On Tue, Jul 23, 2024 at 06:49:32PM +0530, Mrinmay Sarkar wrote:
> > > DW_HDMA_V0_LIE and DW_HDMA_V0_RIE are initialized as BIT(3) and BIT(4)
> > > respectively in dw_hdma_control enum. But as per HDMA register these
> > > bits are corresponds to LWIE and RWIE bit i.e local watermark interrupt
> > > enable and remote watermarek interrupt enable. In linked list mode LWIE
> > > and RWIE bits only enable the local and remote watermark interrupt.
> > > 
> > > Since the watermark interrupts are not used but enabled, this leads to
> > > spurious interrupts getting generated. So remove the code that enables
> > > them to avoid generating spurious watermark interrupts.
> > > 
> > > And also rename DW_HDMA_V0_LIE to DW_HDMA_V0_LWIE and DW_HDMA_V0_RIE to
> > > DW_HDMA_V0_RWIE as there is no LIE and RIE bits in HDMA and those bits
> > > are corresponds to LWIE and RWIE bits.
> > > 
> > > Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> > > cc: stable@vger.kernel.org
> > > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > > ---
> > >   drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++--------------
> > >   1 file changed, 3 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index fa89b3a..9ad2e28 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > @@ -17,8 +17,8 @@ enum dw_hdma_control {
> > >   	DW_HDMA_V0_CB					= BIT(0),
> > >   	DW_HDMA_V0_TCB					= BIT(1),
> > >   	DW_HDMA_V0_LLP					= BIT(2),
> > > -	DW_HDMA_V0_LIE					= BIT(3),
> > > -	DW_HDMA_V0_RIE					= BIT(4),
> > > +	DW_HDMA_V0_LWIE					= BIT(3),
> > > +	DW_HDMA_V0_RWIE					= BIT(4),
> > >   	DW_HDMA_V0_CCS					= BIT(8),
> > >   	DW_HDMA_V0_LLE					= BIT(9),
> > >   };
> > > @@ -195,25 +195,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
> > >   static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > >   {
> > >   	struct dw_edma_burst *child;
> > > -	struct dw_edma_chan *chan = chunk->chan;
> > >   	u32 control = 0, i = 0;
> > > -	int j;
> > >   	if (chunk->cb)
> > >   		control = DW_HDMA_V0_CB;
> > > -	j = chunk->bursts_alloc;
> > > -	list_for_each_entry(child, &chunk->burst->list, list) {
> > > -		j--;
> > > -		if (!j) {
> > > -			control |= DW_HDMA_V0_LIE;
> > > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > > -				control |= DW_HDMA_V0_RIE;
> > > -		}
> > > -
> > > +	list_for_each_entry(child, &chunk->burst->list, list)
> > >   		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
> > >   					 child->sar, child->dar);
> > > -	}
> > Hm, in case of DW EDMA the LIE/RIE flags of the LL entries gets to be
> > moved to the LIE/RIE flags of the channel context register by the
> > DMA-engine. In its turn the context register LIE/RIE flags determine
> > whether the Local and Remote Done/Abort IRQs being raised. So without
> > the LIE/RIE flags being set in the LL-entries the IRQs won't be raised
> > and the whole procedure won't work. I have doubts it works differently
> > in case of HDMA because changing the semantics would cause
> > implementing additional logic in the DW HDMA RTL-model. Seeing the DW
> > HDMA IP-core supports the eDMA compatibility mode it would needlessly
> > expand the controller size. What are the rest of the CONTROL1 register
> > fields? There must be LIE/RIE flags someplace there for the non-LL
> > transfers and to preserve the values retrieved from the LL-entries.
> > 
> > Moreover the DW eDMA HW manual has a dedicated chapter called
> > "Interrupts and Error Handling" with a very demonstrative figures
> > describing the way the flags work. Does the DW HDMA databook have
> > something like that?
> > 
> > Please also note, the DW _EDMA_ LIE and RIE flags can be also utilized
> > for the intermediate IRQ raising, to implement the runtime LL-entries
> > recycling pattern. The IRQ in that case is called as "watermark" IRQ
> > in the DW EDMA HW databook, but the flags are still called as just
> > LIE/RIE.
> > 
> > -Serge(y)
> Yes, you are right LIE/RIE flags need to be set without that the IRQs
> won't be raised in case of DW EDMA.
> But in DW HDMA case there in no such LIE/RIE flags and these particular
> bits has been mapped to LWIE and RWIE flags and these are used to enable
> watermark interrupt only.
> There is no LIE/RIE fields in HDMA_CONTROL1_OFF_WRCH register fields
> the same is present in EDMA CONTROL1 register.
> 
> DW HDMA has INT_SETUP register and it has LSIE/RSIE, LAIE/RAIE fields
> those are enabling Local and Remote Stop/Abort IRQs in LL mode.
> 
> yes DW HDMA data book also have figures in "Interrupts and Error Handling"
> section and there is no LIE/RIE flags and it is replaced with LWIE/RWIE
> flags
> as I mentioned above.

Got it. Thanks for clarification. No more notes in this regard.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Thanks,
> Mrinmay
> 
> > >   	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
> > >   	if (!chunk->cb)
> > > -- 
> > > 2.7.4
> > > 

