Return-Path: <dmaengine+bounces-929-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A53A846E37
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D611F2A605
	for <lists+dmaengine@lfdr.de>; Fri,  2 Feb 2024 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAB713D51C;
	Fri,  2 Feb 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtJFIRor"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9913D4FB;
	Fri,  2 Feb 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870865; cv=none; b=TDsLxyX50SfPezYjnPVvTgUM/jbEQ/HJW7y18IkhF2GPd06JpprdYG5jbwS4M18SUZmi/hbEymX6/9QapeQoueRzdlQG/2j7blSdSJ0EtxfYtVIkzKNiCkJHFDT0lTPnnUkDdiSyfNYjC3/P2i7CaAI/sR0W4e8kux+GRyPVK1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870865; c=relaxed/simple;
	bh=Xt2M8HRs7SN4laOAJeIgS9tMuog2lLj8YJwaT2VLCpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJrfGgpdKjArthfmNjLXproEdilmRr1IlEB8KRUNDLGqTRtZLbHy+D6/+Y3MHYpnqh6/OA8jItgDN8pvXhTCxZJ789lLWKqhKhGC1NHehXAQlRTwLtv5OoC97V7MVyohyXTL8aBJ9MLembZ7aObyI6gBtRz1pAENp9IA82WnjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtJFIRor; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf5917f049so23270771fa.2;
        Fri, 02 Feb 2024 02:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706870862; x=1707475662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZgnYAXpWAFiqkpCspnUr87mQXP6L2kKrtXFLuLkvSw=;
        b=ZtJFIRorjHDkG7SyC5G6Lf65Lto6vRncLmrTQSXy6v2bD7UK1SLkVse8mQMAqxNwWT
         rcqLg6w87hTjjIQGHzBRl5RCbI0l+aCe8QEWRj6FCEWKTw0N/HLKSPDcvVMLmzrtlHoZ
         6aJhLAp+bAFR7U9p/sBwsjAkjlkGPVudObDdCX6ObEmO/LMBa5bm+RCxcGpqO6SX7vRS
         E8KJ7ZUmiJH8lyh9n62mP1tWXf4nov5fhlfA9I6hzqccsy56/psQfl53hhyqLj2150Ys
         taRmPSmF+3MxUHTaKiC9/t0AwHrC9Rhbefwf0JEprnH6MM6FBtFrcXqJYum66MCMUqmm
         r7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870862; x=1707475662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZgnYAXpWAFiqkpCspnUr87mQXP6L2kKrtXFLuLkvSw=;
        b=uqomT32zMKfQU4YgZ2puLpyqiagcdr/L0SxbOY+3qAOlspvv+COXHQhZvYjq8AW5iF
         o+Beasbib2idcxVOn5Xcm1l9cbRCSdKm6JF4k0IuQ6hjkUp4+6wcqOg7RmE0UiHmHg64
         wWP+3wLw+4rSdM3DvWJyKXqwKWdQsDleAU1kW6FXRuVnPGLXhfJTQSktWsIlow1ovndL
         DT1Jdt5j/y7OweoaJbCD+KACZd2/HbD+jRDRIMe/eTOoFG3Hf8pZgOPRT8RUChl1UDFc
         HPl+buznw3UQavPLtaYMYLTPsZec0aaU2RwuvzKlF1AyzlzTsGGgDmAJ9CpWmNKw2mQC
         eWrg==
X-Gm-Message-State: AOJu0YwCFQ+330D0ATvYoDa/SDpql512LNpe9FPt4JWm9ETTivLKw2LJ
	WMLXaDlCc3K82Oy2RhOr3JSutK/nDFL1F2lQ71HkXD3AZYtmhW5o
X-Google-Smtp-Source: AGHT+IEbwjkbpK9Xuml1Y77SKru5bILD7sva7aCjmFi0vC3jKu4Fbqk4CltwUykk2Lw/tPel9KHrkA==
X-Received: by 2002:a2e:9b87:0:b0:2d0:7aa5:583c with SMTP id z7-20020a2e9b87000000b002d07aa5583cmr3152488lji.39.1706870861541;
        Fri, 02 Feb 2024 02:47:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX3dEegt/O88JfWAjSzBp+Ni5hOFkgeNxEqiwAlwSr2bQvnUmy4oME/UXe/Zt7cS+FORlGWXfB3hr3vqXrxGHLNJPDyGAVB143mMX8WdBwR4QRo1IfBybrZoDZjcyluHQyT5J4/fJHuvpjKxFsgF1deQUcaPst3sLQOulMZjtbxXxbE9E7CojloHlygPfXv4ypy2N0zMymcIXBl6JzU3XiNAKrtzxOMV8jYW4S+FwZS6l6D1AUXMCktmeVhgunyO6X4RRIkGJHnSp07L3mFRExxNQwfaClrQxw4e8SLNX36vpX/2B3iKDktAHpVjflKI+kBKzUYvXGsFcAqS9MEECRe1TX/ZZDWdOge1ElvbkEYaYXnUZYIUw8fuNU6bIQcjnlX2bEH+SXW4qj/XX3jnSCdE/H61L4yBQCcz2YILnEdiDVSzLVXfmo6sl3rfUUCKn1KyuNGoypKjJiwQAryidzISZmCvg8ZDvf0WmYdfamy6irVgLhmHmrC28MN5PzAwRQLhMDyIqS8yEmOWRp/GPKYWwhdotCVczpQ1otTSHroxZYLuNOW7dXPdPLRgPSh91QV/1Fsfyqw7TJF3m394uPgigpVRbFI1YYu+ycdEbyfmfuQWBpd/q+Zkn/c25uSI+ABS974DGmmt8fuChAdnfYgJGD5Vh1jBdVmoaN56EHhT4eMFIj9PGqkeOT9fnHuyV6qzRVFxiYJUC3xrbeCROVFO/dlj3CBalvu35h63RQSkdua30jyqaOznpNY8UcxENQ7yigPX33fzArcfYf8FNugdbQBnEqTd3gSZ1X2cocIOTgq40DgQqn3wDN+qEp/Qgifi4P65uefgjI/0K7/9kR+clJQ3MHiQcHbxnr4uElONDl2MOgpKd1fkLHDJiVXV/NoBPAVxuvgF0BZmjeoFRjF3yY0eQFd6RRp
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j13-20020a2e850d000000b002d0406b4c9fsm239639lji.48.2024.02.02.02.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:47:41 -0800 (PST)
Date: Fri, 2 Feb 2024 13:47:37 +0300
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
Subject: Re: [PATCH v1 4/6] dmaengine: dw-edma: Move HDMA_V0_MAX_NR_CH
 definition to edma.h
Message-ID: <qfdsnz7louqdrs6mhz72o6mzjo66kw63vtlhgpz6hgqfyyzyhq@tge3r7mvwtw3>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-5-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705669223-5655-5-git-send-email-quic_msarkar@quicinc.com>

Hi Mrinmay

On Fri, Jan 19, 2024 at 06:30:20PM +0530, Mrinmay Sarkar wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> To maintain uniformity with eDMA, let's move the HDMA max channel
> definition to edma.h. While at it, let's also rename it to HDMA_MAX_NR_CH.

First of all include/linux/dma/edma.h already contains the common DW
EDMA and _HDMA_ settings/entities including the number of channels.
Both of these IP-cores have the same constraints on the max amount of
channels. Moreover the EDMA_MAX_WR_CH/EDMA_MAX_RD_CH macros are
already utilized in the common dw_edma_probe() method. So to speak you
can freely use these macros for HDMA too. Thus this change is
redundant. So is the patches 1/6 and 2/6.

Note currently all the common DW EDMA driver code uses the EDMA_/edma_
prefixes. HDMA_/hdma_ prefixes are utilized in the Native
HDMA-specific module only. So if you wished to provide some IP-core
specific settings utilized in the common part of the driver, then the
best approach would be to provide a change for the entire driver
interface (for instance first convert it to having a neutral prefixes,
like xdma_/etc, and then use the IP-core specific ones). So please
just use the EDMA_MAX_WR_CH and EDMA_MAX_RD_CH macros and drop the
patches 1, 2, and 4.

-Serge(y)

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 4 ++--
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h | 3 +--
>  include/linux/dma/edma.h              | 1 +
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 1f4cb7d..819ef1f 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -54,7 +54,7 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
>  {
>  	int id;
>  
> -	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
> +	for (id = 0; id < HDMA_MAX_NR_CH; id++) {
>  		SET_BOTH_CH_32(dw, id, int_setup,
>  			       HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
>  		SET_BOTH_CH_32(dw, id, int_clear,
> @@ -70,7 +70,7 @@ static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
>  	 * available, we set it to maximum channels and let the platform
>  	 * set the right number of channels.
>  	 */
> -	return HDMA_V0_MAX_NR_CH;
> +	return HDMA_MAX_NR_CH;
>  }
>  
>  static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index a974abd..cd7eab2 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -11,7 +11,6 @@
>  
>  #include <linux/dmaengine.h>
>  
> -#define HDMA_V0_MAX_NR_CH			8
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> @@ -92,7 +91,7 @@ struct dw_hdma_v0_ch {
>  } __packed;
>  
>  struct dw_hdma_v0_regs {
> -	struct dw_hdma_v0_ch ch[HDMA_V0_MAX_NR_CH];	/* 0x0000..0x0fa8 */
> +	struct dw_hdma_v0_ch ch[HDMA_MAX_NR_CH];	/* 0x0000..0x0fa8 */
>  } __packed;
>  
>  struct dw_hdma_v0_lli {
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 550f6a4..2cdf249a 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -14,6 +14,7 @@
>  
>  #define EDMA_MAX_WR_CH                                  8
>  #define EDMA_MAX_RD_CH                                  8
> +#define HDMA_MAX_NR_CH					8
>  
>  struct dw_edma;
>  struct dw_edma_chip;
> -- 
> 2.7.4
> 

