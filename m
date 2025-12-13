Return-Path: <dmaengine+bounces-7609-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D60BDCBA828
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 11:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4283E30A6016
	for <lists+dmaengine@lfdr.de>; Sat, 13 Dec 2025 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9326D2FB601;
	Sat, 13 Dec 2025 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU2gPfMt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA962FB098
	for <dmaengine@vger.kernel.org>; Sat, 13 Dec 2025 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765621658; cv=none; b=Nexu28I0d+V5ePnuCck0+Bgv6cSRDNnA3vTYKgBmDM9eNo9K1j+NSGDsa314x0FHAcmu2B0iEwk/iqcv9SqxZfp6ZuVXUzoN8WKfH2P3S3bBGYpMtWE3VrLheYjOhPqWdhoxjG+x56s5Cax7J42YMNcFX3XOPL0B1rHJiweB8Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765621658; c=relaxed/simple;
	bh=Ga+OtgLv4XXqLeYthfHmQsxLqCuqOInMrZnoEq37VXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7zS13xq4jd1AwWq46Z85//hWesIdmFP1i4VDzXKme8xUv2Tl7t+Yt8YkUBTL12ycUhESprWQA5WJXggl7JN+15yUAHgpC+FbNcZaMLX32nlTZzZyme0YLBPjaTcKrTrYhPkN+hipKNdWWUtg0fDBEVXz4OTWv30C8pB1tPDAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU2gPfMt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34abc7da414so1240530a91.0
        for <dmaengine@vger.kernel.org>; Sat, 13 Dec 2025 02:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765621656; x=1766226456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZe6fXEstv7pAYGHzZssYL65WuRCRc7rX2Oo6ReALjM=;
        b=CU2gPfMtApkCCGGnWYS5ucB5yVbH400i9b0jQGu0v81FTXUYF14guwqYY/TKJGBfGD
         MwzjGjOpI7EqpcL1xGAiFGWTPAjUpRLbl9XkWE/Ehk3PZGnNCOXW67BS3FqSs2Q9s5Dq
         kYRXF39HLagcNchDkfjLSyo5ClyntPo480GXBgUYmNmq0DuNhPKDDMIciOSa4h9NN6mJ
         4lzcEEF3YnA9wk/TE3MLHs0gSKyCnJk0D0FElKqC9VPa40ZN+1KMHtlPKKt/X7uVp6B0
         Sc/Ruau0iygD2vk3zOxOqBIUYGYukNHgArlKiVe1QkWK9zb1T09M6gw3+yuCSq8wsvs6
         Mz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765621656; x=1766226456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZe6fXEstv7pAYGHzZssYL65WuRCRc7rX2Oo6ReALjM=;
        b=hOYdBV3RCY0vX7kFS2lWRz4edpAD1Jne8CAjIiJR8IFCWPCR/9/e/dEy98KqioZh59
         Wz0wBEYy9XRH+N6uJA0pv+rn8vJ+Xgsl/l6gmIae4vuX5AzU/zZMldcf8v70VmudbFp2
         nvcM5QAZMWPQTw8BcP9Rk3RDLXWoZRnszjVLX6NGiQitBJ4lFRoTG9/rMmb701JdQI3M
         u0CNS5PWyDDfPfGtDf4tPzvw7gBq72bAwkdVvCMTJFu9Xs+1LMtC0lBqrTtVsWXhVaiE
         nbOgzZSiJM/kU15pYCvng/pmVAr7AXvcAN4kf01iBoUqnYRCxTUJ9KOtJOamDHudd81g
         gVaw==
X-Forwarded-Encrypted: i=1; AJvYcCWS7tgVLXfHc5kRbAClQgf04hW7dWmLYyiKFCXyRMHaT5TH3MsDls4OqGJUY7c8zYtXG6lznxgMvzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo0mC4rvyHWkU7znbNKgkWo2SzbvH2vprHo9n/HN0apGM4+FOE
	img4PVK/9xcBpfchd3ir8S24sjqbvu4r+iP4AkevEzQX8NJwgWr6Qlwu
X-Gm-Gg: AY/fxX6obvrUySBLb+hHj8NywpPFWULPkLJvaTglSwnWbrLCpyUHDPyCC+PdnIPi34M
	88WWvjh6/X3Z7TLo8+u+R7Y7D3hsRAvsYUINSM7w1SHZZZKu+3MFKFrxzw3YAKJFVQ5xyQQ2nXm
	cnV9YHExWPRxqzbF8ZWsoNnTM23WxsGVZysQcFodceTpDASKjpjD+9S/CjSdxbSjfn31JmTV+J2
	fDSIxKZiai/Ki1PWHhr8WrWTNlLuXCP6cg7D+ZTiYxkN2ATv3pcI9OaM18CdkNIshPwFdtHzhNU
	KgYEOJ8ooj9ObcHyBA0lXRp6afXbD1XX9nTdechGdP4OBr+hbu8La/lpwKXwBxvBldMGLcTzuPU
	yaHDGWy7dSOnbZB1TZfgIRCK4z6g9ZxxMc5KhkzqgESls8uZW3Xi6twCAZHds/hVkqOa0CBZgAR
	/2VESzypn/TA==
X-Google-Smtp-Source: AGHT+IEgdWNaLErL+Bv/4TEGb6my3L3COg4e3V2Q69toNrJl2ns4dPdMhDJIDV+5TWNQeiqW0B6fPQ==
X-Received: by 2002:a05:7023:a8e:b0:11b:c0db:a5ea with SMTP id a92af1059eb24-11f34c4ef0cmr3404454c88.26.1765621655966;
        Sat, 13 Dec 2025 02:27:35 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2ff624sm26725752c88.12.2025.12.13.02.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Dec 2025 02:27:35 -0800 (PST)
Date: Sat, 13 Dec 2025 18:26:35 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Samuel Holland <samuel.holland@sifive.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: "Anton D . Stavinskii" <stavinsky@gmail.com>, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Chen Wang <unicorn_wang@outlook.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Longbin Li <looong.bin@gmail.com>, Yixun Lan <dlan@gentoo.org>, Ze Huang <huangze@whut.edu.cn>
Subject: Re: [PATCH 2/3] dmaengine: dw-axi-dmac: Add support for CV1800B DMA
Message-ID: <aT0_KFNqDraRodyG@inochi.infowork>
References: <20251212020504.915616-1-inochiama@gmail.com>
 <20251212020504.915616-3-inochiama@gmail.com>
 <8a3d3db6-6614-42f7-a271-e6188391daf6@sifive.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a3d3db6-6614-42f7-a271-e6188391daf6@sifive.com>

On Sat, Dec 13, 2025 at 04:55:06PM +0900, Samuel Holland wrote:
> Hi Inochi,
> 
> On 2025-12-12 11:05 AM, Inochi Amaoto wrote:
> > As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> > the SoC provides a dma multiplexer to reuse the DMA channel. However,
> > the dma multiplexer also controlls the DMA interrupt multiplexer, which
> 
> typo: controls
> 

Thanks.

> > means that the dma multiplexer needs to know the channel number.
> > 
> > Allow the driver to use DMA phandle args as the channel number, so the
> > DMA multiplexer can route the DMA interrupt correctly.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 23 ++++++++++++++++---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index b23536645ff7..62bf0d0dc354 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -50,6 +50,7 @@
> >  #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
> >  #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
> >  #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
> > +#define AXI_DMA_FLAG_HANDSHAKE_AS_CHAN	BIT(3)
> > 
> >  static inline void
> >  axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
> > @@ -1361,15 +1362,26 @@ static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
> >  					    struct of_dma *ofdma)
> >  {
> >  	struct dw_axi_dma *dw = ofdma->of_dma_data;
> > +	unsigned int handshake = dma_spec->args[0];
> >  	struct axi_dma_chan *chan;
> >  	struct dma_chan *dchan;
> > 
> > -	dchan = dma_get_any_slave_channel(&dw->dma);
> > +	if (dw->hdata->use_handshake_as_channel_number) {
> > +		if (handshake >= dw->hdata->nr_channels)
> > +			return NULL;
> > +
> > +		chan = &dw->chan[handshake];
> > +		dchan = dma_get_slave_channel(&chan->vc.chan);
> > +	} else {
> > +		dchan = dma_get_any_slave_channel(&dw->dma);
> > +	}
> > +
> >  	if (!dchan)
> >  		return NULL;
> > 
> > -	chan = dchan_to_axi_dma_chan(dchan);
> > -	chan->hw_handshake_num = dma_spec->args[0];
> > +	if (!chan)
> 
> When use_handshake_as_channel_number is false, chan is uninitialized here.
> 
> Regards,
> Samuel
> 

Thanks, I also noticed this, will fixed in the V2.

Regards,
Inochi

> > +		chan = dchan_to_axi_dma_chan(dchan);
> > +	chan->hw_handshake_num = handshake;
> >  	return dchan;
> >  }
> > 
> > @@ -1508,6 +1520,8 @@ static int dw_probe(struct platform_device *pdev)
> >  			return ret;
> >  	}
> > 
> > +	chip->dw->hdata->use_handshake_as_channel_number = !!(flags & AXI_DMA_FLAG_HANDSHAKE_AS_CHAN);
> > +
> >  	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
> > 
> >  	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
> > @@ -1663,6 +1677,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
> >  	}, {
> >  		.compatible = "intel,kmb-axi-dma",
> >  		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
> > +	}, {
> > +		.compatible = "sophgo,cv1800b-axi-dma",
> > +		.data = (void *)AXI_DMA_FLAG_HANDSHAKE_AS_CHAN,
> >  	}, {
> >  		.compatible = "starfive,jh7110-axi-dma",
> >  		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > index b842e6a8d90d..67cc199e24d1 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> > @@ -34,6 +34,7 @@ struct dw_axi_dma_hcfg {
> >  	bool	reg_map_8_channels;
> >  	bool	restrict_axi_burst_len;
> >  	bool	use_cfg2;
> > +	bool	use_handshake_as_channel_number;
> >  };
> > 
> >  struct axi_dma_chan {
> > --
> > 2.52.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

