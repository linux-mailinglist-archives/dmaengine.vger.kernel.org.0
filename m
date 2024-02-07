Return-Path: <dmaengine+bounces-977-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199B784CF60
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8254F1F267FB
	for <lists+dmaengine@lfdr.de>; Wed,  7 Feb 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79655823CA;
	Wed,  7 Feb 2024 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q56gRimA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD490823A9
	for <dmaengine@vger.kernel.org>; Wed,  7 Feb 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325615; cv=none; b=hO2Ej+SmfawzfRyqwQUPWUwc+u3GGcWzRCjFzLApfsnnoVqVLTB7voU7PCm+t0X58nDgtmwBPeUYYdBzEy78+dBRC3blIWZrJ/gV0IhTGm3mXTNm/ohJtaRQULycFdnJgxxdVfpeByru4pIDM8evPFvs5c18J5VlnNw23ZXM9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325615; c=relaxed/simple;
	bh=9+miouTdjV1+IgsXHPhHteirAYajy4X/FxC/F7ZIWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umk4P14g8UsGz/NY7w6NigyEIZEjgtl7OHGbcatkCxCp5XZm75wWmBOy28uNhgP08lznTxbC8YqjER3Gd+kuE+oNNJljjtsj9jVEuiR1xGXVhnQNlA6V+GJ0IYPwlVd213RvWfKKacy/Ag8LZ4tuMzblC9zk2bxqwzOvO6xV7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q56gRimA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d7354ba334so7245245ad.1
        for <dmaengine@vger.kernel.org>; Wed, 07 Feb 2024 09:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707325611; x=1707930411; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bKDHUslKzdvhUhhB50w4kPmOpgUHDxR4dIY+jK4c9U0=;
        b=Q56gRimAHPvfbx4aOlGuZRxnjX5yVXqS1R0fPgxmITUQbwXnfa5MAOw8RRhedqEt+R
         8Us/4+AG8bPpe5gmjPE7El/4OvB5ND1hDhZmOTFUm3LVemWQdDDH0+FNc+l5/ZB0/BGK
         6EoBTSDuclH8k2U85UV59vtRgY7EY5lqxxiGPTT1pA2Z0YEVkJr/Jw/yfxp3PCnYHln/
         JhcmqABJIC8LTICOa+wwDrxODK8gPD4Bc/k9N/D7FZYzMQVFJdygOlrrlOueeDj+S63w
         hpCUC3iPMZGMxUpsnaEOXhZp2ZmLSu3VjERrJyPYI4UFS+xoAJiuQgoaTQ2T/CN7iJLb
         9CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325611; x=1707930411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKDHUslKzdvhUhhB50w4kPmOpgUHDxR4dIY+jK4c9U0=;
        b=Fjn4Cz+G2ccV7yet5pwZdQd/8yH2ZsBCifIht0H6CMNVcVFhXsaILGdy2r66ILF/Bm
         j0ENUiUDH16WlAv2hKq4eK0/WnhhmnwZLjw8eD9uAlvDbAhxgVlHoQCFMcJLT3OddSRp
         OB25DLbLo1y5RuX6wXKMyBfvsHtbNTaEMqE6Mcw4+5xMNipQXfsPDeTUQn3X/f9Ybv9Q
         FqLY2t9CJEmkLpdX1EpUmeq/IK2zbhZdyOqF1jx6JU6l6LJ6ye5DeOgDNC4ivaiEzUos
         0s7/754gp8nSdBuTEqS5ZZxnAylz6qWOogsC9uPASIGPkbw7XIYNH2V0BGLVfXKTNOrm
         7nJg==
X-Forwarded-Encrypted: i=1; AJvYcCWaBRmZ3+/18ql4sqZwgMoDlLwpwPOoIgvp74Ck7YQa8dWvpErwggltMSQC0R04RWtKW5TZpbedsWczDdjDKxCjDl6m6tYICsc4
X-Gm-Message-State: AOJu0YzSSsujcg/VOInCl1jVSKR3r75r5xHpTHEq8Tbeht14rIGSlhpM
	AKWKnlbneyJZTi6kjcMtE8mlApjmvy4mEAMpf6mpsUs6qVmpRfQcrEADa8CNCg==
X-Google-Smtp-Source: AGHT+IHxJGBCpooPGATB4pZJz3yUlioAZzxypcp9DyblhNVqSHylAfe+j0QFdOXSISOCchwTCMW0fg==
X-Received: by 2002:a17:903:443:b0:1d9:ee5f:a975 with SMTP id iw3-20020a170903044300b001d9ee5fa975mr2121914plb.25.1707325611093;
        Wed, 07 Feb 2024 09:06:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfNbwwtypVGuqpks0zX94XabZ0cLdTspiSIqZVR8bOrRWg2osGUSgu5aAiC9zQx5A42rQSvwRbTytp+AaTqTespi8IebOVJC3Gv505/jaq7V7OGXC6x9McNm1gFM3x7i1sdeieAUlhs55Wlzvx+zTml1icQcUnsSC5coNI2c3EoKKDEXITaFCCbEfufUnB4jJITZp6ohNcnoOHBMkDvukRHJ8W8PBsO5DqcqV6ADqEL1U9flhkKcq/wKjKIBE3aBfMGD3rrwoEJ0tKuhd+1sdutB/dGfAYekHz4T83l2Nsn6xxa8uFZdczuQsmc2PNcsimnx0GEyM2PMQg9bslPjgnR0a9ezYVTVSrS07KyjUXjcKN1FFkD7xPg7gM2u/HfqhpU/l6+FA8ANoZzG94HyjbOnt4SqR10sQVIh0aLMW4NpajLgbfLs4Vo8BkPfNMA9AFS6IKDcCt04px9CsTMxrkOZKh2kNr3OD+hZdA+IRV4SxBH8iV5/OqRywPQhHRB7x44lXoV0vyuyaIiXklN72HYJZ6c1dWLY1GI6GXBvkNz8ttn5bqbidvPEbP07a9x0BvKd6f9mI0H7P9oEwhTkd5TGIHbpZSIDqsO0xorWIBv/UxLH7tG3w1fu03ICBhJna4LA7DDS96Sb9v5E2L6KaZbdi7PlUYUfR8kLDib0KnmgfbqSh5LRMy4mT6E26w7U70tpSF3RD0XyRDnK/wcwYHSXeuk95OfTeNpDafiX+sVycwiZvIPpoJBBFmfbf2zdGAyACSsp1BWIS6Qgzp38ljyTiZ019qmfnAmAQLROjCkYSsE4cbZCylToDRR4WzR36E+q0zSC2C0X1NWh76uGCJWQzVgWL3jH86aliPYhfSuvxmlDngNOUCrQXOOuCc8gJCyHP1OZVmMzw=
Received: from thinkpad ([103.246.195.126])
        by smtp.gmail.com with ESMTPSA id kz16-20020a170902f9d000b001d987592c6asm1669415plb.232.2024.02.07.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:06:50 -0800 (PST)
Date: Wed, 7 Feb 2024 22:36:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>, vkoul@kernel.org,
	jingoohan1@gmail.com, conor+dt@kernel.org, konrad.dybcio@linaro.org,
	robh+dt@kernel.org, quic_shazhuss@quicinc.com,
	quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_parass@quicinc.com, quic_schintav@quicinc.com,
	quic_shijjose@quicinc.com,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v1 3/6] PCI: dwc: Add HDMA support
Message-ID: <20240207170642.GA3934@thinkpad>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-4-git-send-email-quic_msarkar@quicinc.com>
 <oa76ts3zqud7mtkpilbo4uub7gazqncnbh6rma26kaz6wt6fch@ufv672fgrcgj>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oa76ts3zqud7mtkpilbo4uub7gazqncnbh6rma26kaz6wt6fch@ufv672fgrcgj>

On Sat, Feb 03, 2024 at 12:40:39AM +0300, Serge Semin wrote:
> On Fri, Jan 19, 2024 at 06:30:19PM +0530, Mrinmay Sarkar wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
> > Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only the
> > unrolled mapping format. So the platform drivers need to provide a valid
> > base address of the CSRs. Also, there is no standard way to auto detect
> > the number of available read/write channels in a platform. So the platform
> > drivers has to provide that information as well.
> > 
> > For adding HDMA support, the mapping format set by the platform drivers is
> > used to detect whether eDMA or HDMA is being used, since we cannot auto
> > detect it in a sane way.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 55 ++++++++++++++++++++++++----
> >  1 file changed, 47 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 96575b8..07a1f2d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -880,7 +880,29 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
> >  	.irq_vector = dw_pcie_edma_irq_vector,
> >  };
> >  
> > -static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > +static int dw_pcie_find_hdma(struct dw_pcie *pci)
> > +{
> > +	/*
> > +	 * Since HDMA supports only unrolled mapping, platform drivers need to
> > +	 * provide a valid base address.
> > +	 */
> > +	if (!pci->edma.reg_base)
> > +		return -ENODEV;
> > +
> > +	/*
> > +	 * Since there is no standard way to detect the number of read/write
> > +	 * HDMA channels, platform drivers are expected to provide the channel
> > +	 * count. Let's also do a sanity check of them to make sure that the
> > +	 * counts are within the limit specified by the spec.
> > +	 */
> > +	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > dw_edma_get_max_wr_ch(pci->edma.mf) ||
> > +	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > dw_edma_get_max_rd_ch(pci->edma.mf))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int dw_pcie_find_edma(struct dw_pcie *pci)
> >  {
> >  	u32 val;
> >  
> > @@ -912,13 +934,6 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> >  		return -ENODEV;
> >  	}
> >  
> > -	pci->edma.dev = pci->dev;
> > -
> > -	if (!pci->edma.ops)
> > -		pci->edma.ops = &dw_pcie_edma_ops;
> > -
> > -	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> > -
> >  	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> >  	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> >  
> > @@ -930,6 +945,30 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> >  	return 0;
> >  }
> >  
> > +static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > +{
> > +	int ret;
> > +
> 
> > +	if (pci->edma.mf == EDMA_MF_HDMA_NATIVE) {
> > +		ret = dw_pcie_find_hdma(pci);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		ret = dw_pcie_find_edma(pci);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> Basically this change defines two versions of the eDMA info
> initialization procedure:
> 1. use pre-defined CSRs mapping format and amount of channels,
> 2. auto-detect CSRs mapping and the amount of channels.
> The second version also supports the optional CSRs mapping format
> detection procedure by means of the DW_PCIE_CAP_EDMA_UNROLL flag
> semantics. Thus should this patch is accepted there will be the
> functionality duplication. I suggest to make things a bit more
> flexible than that. Instead of creating the two types of the
> init-methods selectable based on the mapping format, let's split up
> the already available DW eDMA engine detection procedure into the next
> three stages:
> 1. initialize DW eDMA data,
> 2. auto-detect the CSRs mapping format,
> 3. auto-detect the amount of channels.
> and convert the later two to being optional. They will be skipped in case
> if the mapping format or the amount of channels have been pre-defined
> by the platform drivers. Thus we can keep the eDMA data init procedure
> more linear thus easier to read, drop redundant DW_PCIE_CAP_EDMA_UNROLL flag
> and use the new functionality for the Renesas R-Car S4-8's PCIe
> controller (for which the auto-detection didn't work), for HDMA with compat
> and _native_ CSRs mapping. See the attached patches for details:
> 

Above approach sounds good to me, thanks!

Mrinmay, please integrate Sergey's patches and drop this one. I'll do a review
in v2.

- Mani

> 0001-PCI-dwc-Fix-eDMA-mapping-info-string.patch
> +- Just the eDMA log-message fix which will be useful in any case.
> 
> 0002-PCI-dwc-Split-up-eDMA-parameters-auto-detection-proc.patch
> +-> Split up the dw_pcie_edma_find_chip() method into three ones
> described above.
> 
> 0003-PCI-dwc-Convert-eDMA-mapping-detection-to-being-full.patch
> +-> Skip the second stage the mapping format has been specified.
> 
> 0004-PCI-dwc-Convert-eDMA-channels-detection-to-being-opt.patch
> +-> Skip the amount of channels auto-detection if the amount has
> already been specified.
> 
> 0005-PCI-dwc-Drop-DW_PCIE_CAP_EDMA_UNROLL-flag.patch
> +-> Drop the no longer needed DW_PCIE_CAP_EDMA_UNROLL flag.
> 
> After these patches are applied AFAICS the patches 5/6 and 6/6 of this
> series shall work with no additional modification.
> 
> * Note I only build-tested the attached patches. So even though they
> * aren't that much invasive please be read for a bit debugging.
> 
> -Serge(y)
> 
> > +
> > +	pci->edma.dev = pci->dev;
> > +
> > +	if (!pci->edma.ops)
> > +		pci->edma.ops = &dw_pcie_edma_ops;
> > +
> > +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> > +
> > +	return 0;
> > +}
> > +
> >  static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
> >  {
> >  	struct platform_device *pdev = to_platform_device(pci->dev);
> > -- 
> > 2.7.4
> > 

> From 9b600c17aa56b3949a040055cf82222c48b60bf3 Mon Sep 17 00:00:00 2001
> From: Serge Semin <fancer.lancer@gmail.com>
> Date: Fri, 2 Feb 2024 18:01:31 +0300
> Subject: [PATCH 1/5] PCI: dwc: Fix eDMA mapping info string
> 
> DW PCIe controller can be equipped with the next types of DMA controllers:
> 1. eDMA controller with viewport-based CSRs access (so called legacy),
> 2. eDMA controller with unrolled CSRs mapping,
> 3. HDMA controller compatible with the eDMA unrolled CSRs mapping,
> 4. HDMA controller with native CSRs mapping.
> The later three types imply having the DMA-engine CSRs _unrolled_ mapping.
> Let's fix the info-message printed in the DW PCIe eDMA controller
> detection procedure to comply with that.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 7551e0fea5e9..454ea32ee70b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1018,7 +1018,7 @@ int dw_pcie_edma_detect(struct dw_pcie *pci)
>  	}
>  
>  	dev_info(pci->dev, "eDMA: unroll %s, %hu wr, %hu rd\n",
> -		 pci->edma.mf == EDMA_MF_EDMA_UNROLL ? "T" : "F",
> +		 pci->edma.mf != EDMA_MF_EDMA_LEGACY ? "T" : "F",
>  		 pci->edma.ll_wr_cnt, pci->edma.ll_rd_cnt);
>  
>  	return 0;
> -- 
> 2.43.0
> 

> From ca70e7dd9b84c9dd01124a13f624441c01f7c09d Mon Sep 17 00:00:00 2001
> From: Serge Semin <fancer.lancer@gmail.com>
> Date: Fri, 2 Feb 2024 18:18:39 +0300
> Subject: [PATCH 2/5] PCI: dwc: Split up eDMA parameters auto-detection
>  procedure
> 
> It turns out the DW HDMA controller parameters can't be auto-detected in
> the same way as it's done for DW eDMA: HDMA has only the unrolled CSRs
> mapping and has no way to find out the amount of the channels. For that
> case the best choice would be to have the HDMA controller parameters
> pre-defined by the platform drivers and to convert the implemented
> auto-detection procedure to being optionally executed if no DMA-controller
> parameters specified. As a preparation step before that let's split the
> eDMA auto-detection into three stages:
> 1. initialize DW eDMA data,
> 2. auto-detect the CSRs mapping format,
> 3. auto-detect the amount of channels.
> 
> Note this commit doesn't imply the eDMA detection procedure semantics
> change.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 33 +++++++++++++++-----
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 454ea32ee70b..149c7a2a12f2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -878,7 +878,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
>  	.irq_vector = dw_pcie_edma_irq_vector,
>  };
>  
> -static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +static void dw_pcie_edma_init_data(struct dw_pcie *pci)
> +{
> +	pci->edma.dev = pci->dev;
> +
> +	if (!pci->edma.ops)
> +		pci->edma.ops = &dw_pcie_edma_ops;
> +
> +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +}
> +
> +static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> @@ -900,8 +910,6 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  
>  	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
>  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> -
> -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  	} else if (val != 0xFFFFFFFF) {
>  		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
>  
> @@ -910,12 +918,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  		return -ENODEV;
>  	}
>  
> -	pci->edma.dev = pci->dev;
> +	return 0;
> +}
>  
> -	if (!pci->edma.ops)
> -		pci->edma.ops = &dw_pcie_edma_ops;
> +static int dw_pcie_edma_find_chan(struct dw_pcie *pci)
> +{
> +	u32 val;
>  
> -	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +	val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  
>  	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
>  	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> @@ -992,8 +1002,15 @@ int dw_pcie_edma_detect(struct dw_pcie *pci)
>  {
>  	int ret;
>  
> +	dw_pcie_edma_init_data(pci);
> +
>  	/* Don't fail if no eDMA was found (for the backward compatibility) */
> -	ret = dw_pcie_edma_find_chip(pci);
> +	ret = dw_pcie_edma_find_mf(pci);
> +	if (ret)
> +		return 0;
> +
> +	/* Don't fail if no valid channels detected (for the backward compatibility) */
> +	ret = dw_pcie_edma_find_chan(pci);
>  	if (ret)
>  		return 0;
>  
> -- 
> 2.43.0
> 

> From f5149d0827d9d8b0ccaaaeb6309b1a86832cdddc Mon Sep 17 00:00:00 2001
> From: Serge Semin <fancer.lancer@gmail.com>
> Date: Fri, 2 Feb 2024 19:02:35 +0300
> Subject: [PATCH 3/5] PCI: dwc: Convert eDMA mapping detection to being fully
>  optional
> 
> The DW eDMA CSRs mapping detection procedure doesn't work for the DW HDMA
> controller. Moreover it isn't that easy to distinguish HDMA from eDMA if
> the former controller available in place of the later one. Thus seeing DW
> HDMA controller has the unrolled CSRs mapping only there is no better
> choice but to rely on the HDMA-capable platform drivers having the
> DMA-engine mapping format specified. In order to permit that let's convert
> the eDMA mapping format auto-detection to being fully optional: execute
> the DMA Ctrl-based CSRs mapping auto-detection only if no mapping format
> was specific.
> 
> Note the DW_PCIE_CAP_EDMA_UNROLL flag semantics also imply the mapping
> auto-detection optionality. But it doesn't indicate the type of the
> controller. It's merely a fixup for the DW PCIe eDMA controllers which for
> some reason don't support the DMA Ctrl-based CSRs mapping auto-detection
> procedure (see note regarding the Renesas R-Car S4-8's PCIe). So it can't
> be utilized for DW HDMA auto-detection. But after this change is applied
> the flag will get to be redundant and will be subject for removal in one
> of the subsequent commit.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 149c7a2a12f2..2243ffeb95b5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -892,6 +892,14 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> +	/*
> +	 * The platform drivers can pre-define the DMA controller mapping
> +	 * format especially if the auto-detection procedure doesn't work for
> +	 * them. In that case the CSRs base must be specified too.
> +	 */
> +	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
> +		return pci->edma.reg_base ? 0 : -EINVAL;
> +
>  	/*
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
> -- 
> 2.43.0
> 

> From 4f9668ad9e741b501476cd4457cf9ca9013ee6e3 Mon Sep 17 00:00:00 2001
> From: Serge Semin <fancer.lancer@gmail.com>
> Date: Fri, 2 Feb 2024 20:12:46 +0300
> Subject: [PATCH 4/5] PCI: dwc: Convert eDMA channels detection to being
>  optional
> 
> DW HDMA controller channels can't be auto-detected. Thus there is no way
> but to rely on the HDMA-capable platform drivers having the number of
> channels specified. In order to permit that convert the
> dw_pcie_edma_find_chan() method to executing the DMA Ctrl CSR-based number
> of channels detection procedure only if no channels amount was specified,
> otherwise just sanity check the specified values.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 2243ffeb95b5..4d53a71ab1b4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -933,12 +933,20 @@ static int dw_pcie_edma_find_chan(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> -	val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> +	if (!pci->edma.ll_wr_cnt && !pci->edma.ll_rd_cnt) {
> +		if (pci->edma.mf == EDMA_MF_HDMA_NATIVE)
> +			return -EINVAL;
> +
> +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  
> -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> +		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> +		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> +	}
>  
> -	/* Sanity check the channels count if the mapping was incorrect */
> +	/*
> +	 * Sanity check the channels count in case if the mapping was
> +	 * incorrectly detected/specified by the glue-driver.
> +	 */
>  	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
>  	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
>  		return -EINVAL;
> -- 
> 2.43.0
> 

> From 9590af6f5114b07e4073083ecde9e563cc920410 Mon Sep 17 00:00:00 2001
> From: Serge Semin <fancer.lancer@gmail.com>
> Date: Fri, 2 Feb 2024 23:45:00 +0300
> Subject: [PATCH 5/5] PCI: dwc: Drop DW_PCIE_CAP_EDMA_UNROLL flag
> 
> That flag was introduced in order to bypass the DW eDMA mapping format
> auto-detection procedure and force the unrolled eDMA CSRs mapping
> procedure. Since the same can be now reached just by pre-defining the
> required mapping format, drop the flag and convert the Renesas R-Car S4-8
> glue-driver to using the new approach.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 13 +++++--------
>  drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
>  3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4d53a71ab1b4..a49de18c9836 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -895,7 +895,10 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  	/*
>  	 * The platform drivers can pre-define the DMA controller mapping
>  	 * format especially if the auto-detection procedure doesn't work for
> -	 * them. In that case the CSRs base must be specified too.
> +	 * them (e.g. Renesas R-Car S4-8's PCIe controllers for unknown reason
> +	 * have zeros in the eDMA CTRL register even though the HW-manual
> +	 * explicitly states there must be FFs if the unrolled mapping is
> +	 * enabled). In that case the CSRs base must be specified too.
>  	 */
>  	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
>  		return pci->edma.reg_base ? 0 : -EINVAL;
> @@ -904,14 +907,8 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
>  	 * former DMA CTRL register is no longer fixed to FFs.
> -	 *
> -	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
> -	 * have zeros in the eDMA CTRL register even though the HW-manual
> -	 * explicitly states there must FFs if the unrolled mapping is enabled.
> -	 * For such cases the low-level drivers are supposed to manually
> -	 * activate the unrolled mapping to bypass the auto-detection procedure.
>  	 */
> -	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
> +	if (dw_pcie_ver_is_ge(pci, 540A))
>  		val = 0xFFFFFFFF;
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 035df6bc7606..a666190e8b1b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -54,9 +54,8 @@
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -#define DW_PCIE_CAP_EDMA_UNROLL		1
> -#define DW_PCIE_CAP_IATU_UNROLL		2
> -#define DW_PCIE_CAP_CDM_CHECK		3
> +#define DW_PCIE_CAP_IATU_UNROLL		1
> +#define DW_PCIE_CAP_CDM_CHECK		2
>  
>  #define dw_pcie_cap_is(_pci, _cap) \
>  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 3bc45e513b3d..5678d69c413a 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -255,7 +255,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
>  	rcar->dw.ops = &dw_pcie_ops;
>  	rcar->dw.dev = dev;
>  	rcar->pdev = pdev;
> -	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> +	rcar->dw.edma.mf = EDMA_MF_EDMA_UNROLL;
>  	dw_pcie_cap_set(&rcar->dw, REQ_RES);
>  	platform_set_drvdata(pdev, rcar);
>  
> -- 
> 2.43.0
> 


-- 
மணிவண்ணன் சதாசிவம்

