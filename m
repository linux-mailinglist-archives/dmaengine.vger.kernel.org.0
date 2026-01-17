Return-Path: <dmaengine+bounces-8315-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D8D38ABA
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 01:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988193070FE3
	for <lists+dmaengine@lfdr.de>; Sat, 17 Jan 2026 00:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7D153598;
	Sat, 17 Jan 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/qkuCRj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B84F881
	for <dmaengine@vger.kernel.org>; Sat, 17 Jan 2026 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768609865; cv=none; b=i3gVIu0ud9ryu32DAusRJk7MJayMYpzoAgIlz4giTDAfvlN6bMkW8/vaoxu2uaiDrjLdDJ73r1jNqs8DQsZjOYiYwsuXNPVWbKpSaFmt6ESmadhiPhPkuClF5rPXDO3EyQ7Wuo+A7THN6H+8lDGi3hl7XetljG9GkQ4XiRAYCy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768609865; c=relaxed/simple;
	bh=xtCiJPz16IqeiDeaS2jZcY9Mb9ZGX+uLSmlEP9iSmoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVepZiM7Mx2Qops+IpVBHbcCaLENOvJdNH52FGsjjL0suGcBJvGJATTjveEhYv/wSe0yn8gubg/6qbISHtJCN+2riXIpFCefZOc7Sej7u4MKtg64B/OUPEjfAUAPsofSI4Xz/B2dpYEDlM/SuXtmM2M+WRqKN8xtw9yHapq/zMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/qkuCRj; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6c6f89f23so1007185eec.1
        for <dmaengine@vger.kernel.org>; Fri, 16 Jan 2026 16:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768609863; x=1769214663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5JNJOduP9VrN/mhp5Hk2Svxk9TX1DeMUnmLosBKrvU=;
        b=L/qkuCRj1RQD6TKTNSpaDOrmCbk326TBhw4G/rmnnwG8ddFBJxUc0VtZueD6Yr+9gQ
         Zk6oU4RWeRJ97orL8hBALfPKxMHo16XJrNpS3EkC5AgrilbxT+5vYI2PdMB3keBRzwbx
         ALfyluXLw36+HdplnFtOHTXgLRCPpyLyku8BZZKypDSIMc4DRIqhDJveviUEg92YcXYN
         V+XApcnWtjT+Zr8zzMPmNaL9KKyE3dSB0UOfgncB06c+mUB+q0HHA5H2QECyV8pArROe
         IyGTkSaQSeC5dECFYV4rzi6ONMu8R4V9NAHaIAfDgha9pyrBBPo2EVrxrB1JLCG9laJ7
         1uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768609863; x=1769214663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5JNJOduP9VrN/mhp5Hk2Svxk9TX1DeMUnmLosBKrvU=;
        b=d7UBhiGUH8LGyY95Yt9LhVQiv7qRc0G+l2zNujZg8RPcUBofsY1C3595YjSpXFq1A1
         zoKugh8zNFox70j72JrRdtQF/U8/8y8soqEcmW+AotnmXxEoidkA5OycQz2Z4KZL/aNc
         vckvM21y6p/TMXIrv5vEnUtMYujsm4mo0+bsUAhiz3TWIsNk6mVoLXwBuiZCRyIK8tdy
         Dup9kvsN0640icpKntTHKaBcXGoU0g9XyI/ekajtEtZuAtiSTDD95LMfyJjOvzWJi0/b
         pfptZ1A0CGJo/d017eIWuaYqqdTEuMMsEeJkUtU9FgQTGMzTMMNZF9VpgZSCupsKXUas
         ttdw==
X-Forwarded-Encrypted: i=1; AJvYcCVYFJgo0CFo4+DXZ3m/XInweb5Uo+fbA3RPSQmxMEakXop5VLCXxTYUBwpYhgKCTP8Wd5YOBPsVJ10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2yW/ZS9cv/PUqZcQsQA4ax8KUfqOYll8IBQG3VAU2ypIbzJxr
	RodP/+B1hmkQbFMYCYA9bW78jBOFdJ1jb47CS/N2mptEIDSO9gYx1N3z
X-Gm-Gg: AY/fxX4l9zJTUapwbPFDNy1fAcVhDjG3L8R8X7lrda3F/okt+tKcS+rVThIFHukcaKF
	mV9dex1Xw0hmCpe259Y9ycpL5YwPkfZUOjOesAlcWH2uCyr5AUsY6b62uQCN6DsRJhSUTfr8lLf
	FBykmB9I0ZW0c05uoXLj3k0uKCWhAkA4F+SoqcYifxoEH4KT93RlwHjfsIv3LOXpSrBrh44hkGn
	jcZ1l1GxNqBL9ozDrDzz30Mnb9/02NCeiLv21MnlIUYdMuGzjTM1I4LuUcjnxOCYVHyrFrLeyoC
	XdktP8jqQpca+Ejhf5/x1s20iPZNBCgUqWdF13RnvaWHam5y9fEStk07EkHcTss9/HxVU83HEMI
	QBzkMffCnAPX7zVCkXE9NANOxBK8apcGeL/LTlvsGXq/n2EYcRdr5InCRq5VmlLdUx2qqsK6aUE
	897ClFOQHpug==
X-Received: by 2002:a05:7300:ed0f:b0:2ae:5245:d4f6 with SMTP id 5a478bee46e88-2b6b3f1c8f1mr4513348eec.16.1768609863057;
        Fri, 16 Jan 2026 16:31:03 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a7bsm3938806eec.19.2026.01.16.16.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 16:31:02 -0800 (PST)
Date: Sat, 17 Jan 2026 08:30:57 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Frank Li <Frank.li@nxp.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Chen Wang <unicorn_wang@outlook.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>, 
	"Anton D . Stavinskii" <stavinsky@gmail.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
	Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 2/3] dmaengine: dw-axi-dmac: Add support for CV1800B
 DMA
Message-ID: <aWrYMHdpSs4_kRCs@inochi.infowork>
References: <20251214224601.598358-1-inochiama@gmail.com>
 <20251214224601.598358-3-inochiama@gmail.com>
 <aWpdEKVBjbq7Lrqv@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWpdEKVBjbq7Lrqv@lizhi-Precision-Tower-5810>

On Fri, Jan 16, 2026 at 10:45:20AM -0500, Frank Li wrote:
> On Mon, Dec 15, 2025 at 06:45:59AM +0800, Inochi Amaoto wrote:
> > As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> > the SoC provides a dma multiplexer to reuse the DMA channel. However,
> > the dma multiplexer also controls the DMA interrupt multiplexer, which
> > means that the dma multiplexer needs to know the channel number.
> >
> > Allow the driver to use DMA phandle args as the channel number, so the
> > DMA multiplexer can route the DMA interrupt correctly.
> >
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 26 ++++++++++++++++---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
> >  2 files changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index b23536645ff7..829aa6c05b5c 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -7,6 +7,7 @@
> >   * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> >   */
> >
> > +#include "linux/stddef.h"
> >  #include <linux/bitops.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > @@ -50,6 +51,7 @@
> >  #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
> >  #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
> >  #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
> > +#define AXI_DMA_FLAG_HANDSHAKE_AS_CHAN	BIT(3)
> 
> Look like ARG0_AS_CHAN is easy understand
> 

Good name!

> Frank
> >
> >  static inline void
> >  axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
> > @@ -1360,16 +1362,27 @@ static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
> >  static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
> >  					    struct of_dma *ofdma)
> >  {
> > +	unsigned int handshake = dma_spec->args[0];
> >  	struct dw_axi_dma *dw = ofdma->of_dma_data;
> > -	struct axi_dma_chan *chan;
> > +	struct axi_dma_chan *chan = NULL;
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
> > +		chan = dchan_to_axi_dma_chan(dchan);
> > +	chan->hw_handshake_num = handshake;
> >  	return dchan;
> >  }
> >
> > @@ -1508,6 +1521,8 @@ static int dw_probe(struct platform_device *pdev)
> >  			return ret;
> >  	}
> >
> > +	chip->dw->hdata->use_handshake_as_channel_number = !!(flags & AXI_DMA_FLAG_HANDSHAKE_AS_CHAN);
> > +
> >  	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
> >
> >  	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
> > @@ -1663,6 +1678,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
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

