Return-Path: <dmaengine+bounces-931-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00C846E4A
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 11:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EA9299003
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F7D13B7B4;
	Fri,  2 Feb 2024 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvo8XzHi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6C22067;
	Fri,  2 Feb 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871077; cv=none; b=AcMcGPkfCJ86RSlKWZylAgl9xvqzKOq+W4tKI6wR+KrNE8BBbaKf+WNKxAnkU6RywGzdvF/d2Di1GF89UNbJERcSUR8ogYRyqqt06QNJH4DJBrtkyAzI3apUmXxHNaXMx4xxF0K3N3RCg+ivh7acvb676AQamyKL/xiyqlYMTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871077; c=relaxed/simple;
	bh=IOY6464NxNU4brqTtjjX6NWMS6Lq4bFk/LCbg383F2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUIKcJAaZQZwuLrrfYHEKbPgyd8c91jGfJZzC6YzNEkvyV219IuL78XJH4mNO9ZZGQcuiVLG1/GSC+gl+tqC/JbgrgkviNoBgFMCEln0rSZKNeAjp7DUXf8NlIRJYVMLF7l3+/AW8ANQ9S1PcBV/plnGnWJ325ZtP+hwAUtJ0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dvo8XzHi; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d05b06b5f9so22743181fa.3;
        Fri, 02 Feb 2024 02:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706871073; x=1707475873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kx4mIgU1jBfilctvZhlH5DYX3FWSs/9dFiVk8rkOVB0=;
        b=Dvo8XzHiGKjF4p0kxiOA6W1fyeSj2rWZfQPo3i0fIUKa2vWaPtxWLQuSgjKFoqdIPP
         p9tTYQ022FUr/9VRdxbWLnOs5CaTfvXPS8XgIZkqh5I9xQlddvJ9nuVMAj762UT4Hn13
         nd2rfqDj7usjSCoPq0VcpqNAW7h96alzRGni2iFFkFT/43dkHLFsa1OuHgSPAY/49zqa
         Yr+1KBcH12dcaRtsz7D8Fse+x/B8glXG1XjJ529UVwuMj6XqrGUq9nVlBouzYPQ/XyM6
         LtJuCK0V0dXX80pBTzKGRjqUBZho2qizSjZhM7iK2P4VcnP5avwFUGkckoXa7lFwMfwP
         GN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871073; x=1707475873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx4mIgU1jBfilctvZhlH5DYX3FWSs/9dFiVk8rkOVB0=;
        b=UIkxNWPZV06r0AIWLXCi0Z1ZJ/M1OurysbNS9nOnFhK7X9SP4lInsKbfZR+ZYeN76n
         /ABomRVV3t6/q+eM0YgNgXVQj/fS2QXqHa+AEx2FOc5R3sRDnp2VpHUIX6r96AbxzCQb
         nuBBypfrwnsRieVlEAkzVHHd3pdhJavjsHJsr8/0H1gS/xd7efoVpEGXxN4y62cjNZov
         KBir15Ui1IcHpEjHxUV9GocJJazP3q0olBPxiUHiKgC4vNUeWfZAw6IHsZxAkAgJBZzJ
         plKBanJm5/ScTMvaYl8HeICYXkKlgqNE7fw19m3W1Ks4WllNmQNGjTrc5Di3pKzRCH2t
         IheA==
X-Gm-Message-State: AOJu0Yxu+/QGv3h9vSAtjFYQQRuvQ6PtV14Tw3XFfzXklbcxzWur78pu
	MR2RXmR3+9N8/3QFdYz/chq/6pp0RSDplwekNoH5pS137Zlf43ox
X-Google-Smtp-Source: AGHT+IFBBAv4djkjIr64uSUqBaRgzJgTXmTCYRnLptqsty5wsmiMjBqHWBJy6fRmQbvifnYBus9v4Q==
X-Received: by 2002:a2e:3c0f:0:b0:2d0:54ac:35a with SMTP id j15-20020a2e3c0f000000b002d054ac035amr990510lja.4.1706871073157;
        Fri, 02 Feb 2024 02:51:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVHq+TVXuo5qAsWn2M07nkxLeFNz1PodEBo1sRZRYCLFTYpE77y15gWwkSE+lEJSNnsEz8coRLdXJ0rsUXI23QOOGaSE7TstJYQEssCaZCzD7BUaNHwBb4ziHp0BAKjLFKcuaZrIri7O/HWr7uHzLPxiNanY44oaCb+y9oCorn/VH1KFT/8PUCL5mm5q7A4BZR7aF0iXlnwmKlGElSdpwA8IvZltIj/CmBwcraguqkv4JWvzLa7daY4pmn9Aa2tyTEudKY5CsuK3RFE0KMQQXYx6Kid0jBaNRi7hzgiy6M3eRT6CF5ib9cI6Nd9G4ho8CTIXZODz6dyyzn/wLecTxt9tAe1fhnufBaMta04dEWL3BNhLa+E85Svbx3INGbslJNrQWK+JkdW/YKDSN9Kw5tAEYaU3Z7cJE13TgF1+1OVYC3VKcnPePhSjFPin/4szTTFLOIEqLGn/WUqjefN3R84AzA3VKP25fb7xAoK8QvPdF734i6yKutr9d2zhNOo5w+gfomo8GmdD+DZGcpgM7OxMEEb1T0nKNdp537/YSVomy/mkXFj1bNSC/dL44l1ffnWfZIUvkm4WQEq5RQPtsesZYfoGgv8FN5ozrguaVWsT3KG5oe6hi9641BykkJcAAbtfzaLF6DiKChg7hKLQPT5nupdw60gZUvEIKJY+DfGXg4OdeZf/TZ+YLs9Nif/c1tlQ50O8wJRFldJMnHWzze8rSmRN2B/aAyUM+k/mkHKfbG3CfHbAv9UMjwe5ZK9rDlpx2HvvaFF5a+t86lv47WVGibUCy3eFcLeSLXygnj/dCBlnFKQVFKurWYC9XtWn9C2Yn8uurLdZc+3grv1HGMII4tjfEk7YTZ3mXjgmg86MOc14fxUNdFAdwzI7RwkooVuqVXkWE3lTAtu3V0lwWYz9mGwoXI+iLvx
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id bx30-20020a05651c199e00b002d0511e7420sm241007ljb.6.2024.02.02.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:51:12 -0800 (PST)
Date: Fri, 2 Feb 2024 13:51:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org, robh+dt@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com, 
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com, quic_schintav@quicinc.com, 
	quic_shijjose@quicinc.com, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v1 2/6] dmaengine: dw-edma: Introduce helpers for getting
 the eDMA/HDMA max channel count
Message-ID: <yaf4wvjqy27whulyppep5qvw3cabfcvaoyxfn3p2i7khc3deyv@42pjna2sfmzr>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-3-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705669223-5655-3-git-send-email-quic_msarkar@quicinc.com>

On Fri, Jan 19, 2024 at 06:30:18PM +0530, Mrinmay Sarkar wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Add common helpers for getting the eDMA/HDMA max channel count.

See my comment to the patch 4:
https://lore.kernel.org/linux-pci/qfdsnz7louqdrs6mhz72o6mzjo66kw63vtlhgpz6hgqfyyzyhq@tge3r7mvwtw3/

-Serge(y)

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c           | 18 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.c |  6 +++---
>  include/linux/dma/edma.h                     | 14 ++++++++++++++
>  3 files changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 7fe1c19..2bd6e43 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -902,6 +902,24 @@ static int dw_edma_irq_request(struct dw_edma *dw,
>  	return err;
>  }
>  
> +static u32 dw_edma_get_max_ch(enum dw_edma_map_format mf, enum dw_edma_dir dir)
> +{
> +	if (mf == EDMA_MF_HDMA_NATIVE)
> +		return HDMA_MAX_NR_CH;
> +
> +	return dir == EDMA_DIR_WRITE ? EDMA_MAX_WR_CH : EDMA_MAX_RD_CH;
> +}
> +
> +u32 dw_edma_get_max_rd_ch(enum dw_edma_map_format mf)
> +{
> +	return dw_edma_get_max_ch(mf, EDMA_DIR_READ);
> +}
> +
> +u32 dw_edma_get_max_wr_ch(enum dw_edma_map_format mf)
> +{
> +	return dw_edma_get_max_ch(mf, EDMA_DIR_WRITE);
> +}
> +
>  int dw_edma_probe(struct dw_edma_chip *chip)
>  {
>  	struct device *dev;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index eca047a..96575b8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -864,7 +864,7 @@ static int dw_pcie_edma_irq_vector(struct dw_edma_chip *edma, unsigned int nr)
>  	char name[6];
>  	int ret;
>  
> -	if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
> +	if (nr >= dw_edma_get_max_rd_ch(edma->mf) + dw_edma_get_max_wr_ch(edma->mf))
>  		return -EINVAL;
>  
>  	ret = platform_get_irq_byname_optional(pdev, "dma");
> @@ -923,8 +923,8 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
>  
>  	/* Sanity check the channels count if the mapping was incorrect */
> -	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> -	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
> +	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > dw_edma_get_max_wr_ch(pci->edma.mf) ||
> +	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > dw_edma_get_max_rd_ch(pci->edma.mf))
>  		return -EINVAL;
>  
>  	return 0;
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 7197a58..550f6a4 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -106,6 +106,9 @@ struct dw_edma_chip {
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
> +
> +u32 dw_edma_get_max_rd_ch(enum dw_edma_map_format mf);
> +u32 dw_edma_get_max_wr_ch(enum dw_edma_map_format mf);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -116,6 +119,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	return 0;
>  }
> +
> +static inline u32 dw_edma_get_max_rd_ch(enum dw_edma_map_format mf)
> +{
> +	return 0;
> +}
> +
> +static inline u32 dw_edma_get_max_wr_ch(enum dw_edma_map_format mf)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_DW_EDMA */
>  
>  #endif /* _DW_EDMA_H */
> -- 
> 2.7.4
> 

