Return-Path: <dmaengine+bounces-8678-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGWWNsuagWl/HAMAu9opvQ
	(envelope-from <dmaengine+bounces-8678-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 07:50:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12831D5763
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 07:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5FAC300B520
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 06:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580A37AA80;
	Tue,  3 Feb 2026 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGEnkydS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA853793D7
	for <dmaengine@vger.kernel.org>; Tue,  3 Feb 2026 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770100581; cv=none; b=dt++zDQHF5TtoxAfSAeG3KI5ZS21dyTywKxukRp+UtwCqXgSIyK4An33P5UUf8dVYYkrl/BKSUSlejSZatJGGlNGPhYWJzsITiLBndOtr2SLrOdPcvwv080gSCmvk12P8QaiT4mfDruR6GXT8ayDjPnk5WN/XT0Gf/yJuV8GBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770100581; c=relaxed/simple;
	bh=WIOfbh0WJE+TekDH/9Lq1OM/hLN3hJjCAli1fyDbuXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGBjRHqznZmV8vksbWDUDty9ZyKDotnaLrTmBZqPDSA0nS8B96PIc9g7Y6H5U8jj9BRzB9q4Jm2sGC0D6wvmOVIF31R0uCPfUU7Fz4wUKyHvyvX9ER9gAGzroAYG3DCeUI1FqVZWJ97aEOMYTVmk02879GYVQ5iTLRqVUjSCK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGEnkydS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59de38466c2so6575763e87.0
        for <dmaengine@vger.kernel.org>; Mon, 02 Feb 2026 22:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770100578; x=1770705378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8GrinKDGOqbbFlvjaosDEAsZcli0GS5u0koOnCbV+4=;
        b=NGEnkydSeoBde0mzHhv1AMuCA73LYd/rBaz0aNflZ5f7G9qYFhwPXggQswWhXuVzum
         G65wrLXisy5nTiiFlyKKBIiElLPwO7QTQlXUoDyPUI1LdzXrDgCVB2ytRtr0jQSEgFxl
         qOEvXbm6nsNFLgepifmpj54bAQWKEwYqd02bNmIrYa4LsNanapFw3FuLQcf/eU4FOnqD
         7ouk0hduslZOFUnFPC0uIbjsvWuZmUIVHZ63/aHk9/x8cfPozJydaXIMTLflLUhNTOs4
         ZdZqjE5tw0u+usnnYMvDyeAJoMWwlqqtxluxLn3V/bYrDAjzkcsswOSKLRd1FSsshzhz
         ct6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770100578; x=1770705378;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8GrinKDGOqbbFlvjaosDEAsZcli0GS5u0koOnCbV+4=;
        b=rGbtpc5Bvz5/g8SRGNnByr3FNX3Rsn1IDY4mWzv/ajb0VGTf6VdcS7bEuDGpmifOr+
         cADEvgOiMcO1bDuid9iX0cINX5M1R30yIDdPtGh7ClhUQ3ua6fDi5V2WNWU+D6FW97Hf
         XlFe10omWYLzwF+7m9sYDKidRvKfE0GNaZjZ7aHrNrP7PoSRELniEAGKuMUJo12+FhzF
         OzZ47PkTIGXVjJL2k2clPY+TD9E+6UsYEL36HVemIdgn90QNYs+zM9KGHrbvul+HoIUj
         DFmmGsuh55eeLYIjbG3s6EZcvWiKyV1apZmenuPR0j3V9XAH7FY6UHPbepMsAEsTGpN4
         p62g==
X-Forwarded-Encrypted: i=1; AJvYcCXG7lD1amw8f7B6ql/U9BvWok4sswdACgCgIIb3zzt4AANAoM73PSoG6HRJWx6eaNz1CyZ2Rk6Bgk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFG/cahADTHMC5LUJUSGGsh5Z840138bH1fAoVmG02KfbwMxv
	KgavOQNzGFpwkJI/isNwk2hk0FsQ0yVEyQTZRJLGqFxSEh/9mfRGI43f
X-Gm-Gg: AZuq6aIo88Mr5SFho5WxUy+NKPaVTeHHEonA11sRRHjfd/gabbcuA1PxRjOXV7N9gdx
	kvTUZnxVL3qNdIXsDwZuSmhEtUB57ScDyO1mn74n5V3hpWhAFQRERTMbJWREqK4ak51kYrz6Af8
	5A36ixfcpfC3AM5x/Ud+KKyRX40oeuxm2wyFSQzEyK6ZrzMeIWeyunfRG8LWPy3h3SDFyzQ5AzE
	rlVxlzAzQ8b9EY7NUPPInVON1pdcvI1lQVoB3Oz+WSbwU7XycJ9Ap0+lD6HeuDhoJImF8TwohFW
	knUIdX01oNo1IwVWA+Bj28LxrpUNtNCeM0NwttA4cBCnljI6OBCFBa8ofXMCoOx6l+P7WDqNo+k
	PXlqpiHqCx+qzeQape3dp9QXzHTFE8XWpv98mFDIQreNas0VtAwsRm6qOpK6KEC71RrmlDClY4l
	6O2iJXP1Qvqf3Zu0ICcjnh1MFNCcRC4wGhMF5u2ktRjpTsjkmUTAz+FheBwCBAH9q+3Kk8BQ==
X-Received: by 2002:ac2:4e01:0:b0:59c:bfeb:cc2d with SMTP id 2adb3069b0e04-59e163f5918mr4193887e87.2.1770100577863;
        Mon, 02 Feb 2026 22:36:17 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-74-59.kaisa-laajakaista.fi. [185.69.74.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e08e7e0d6sm3844554e87.62.2026.02.02.22.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 22:36:17 -0800 (PST)
Message-ID: <98c254c5-94c1-49b0-b361-617639b781d8@gmail.com>
Date: Tue, 3 Feb 2026 08:37:29 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/19] dmaengine: ti: k3-udma-v2: New driver for K3
 BCDMA_V2
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com
Cc: r-sharma3@ti.com, gehariprasath@ti.com
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-16-s-adivi@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20260130110159.359501-16-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8678-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterujfalusi@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12831D5763
X-Rspamd-Action: no action



On 30/01/2026 13:01, Sai Sree Kartheek Adivi wrote:
> Add support for BCDMA_V2.
> 
> The BCDMA_V2 is different than the existing BCDMA supported by the
> k3-udma driver.
> 
> The changes in BCDMA_V2 are:
> - Autopair: There is no longer a need for PSIL pair and AUTOPAIR bit
>   needs to set in the RT_CTL register.
> - Static channel mapping: Each channel is mapped to a single peripheral.
> - Direct IRQs: There is no INT-A and interrupt lines from DMA are
>   directly connected to GIC.
> - Remote side configuration handled by DMA. So no need to write to PEER
>   registers to START / STOP / PAUSE / TEARDOWN.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/dma/ti/Kconfig            |   16 +-
>  drivers/dma/ti/Makefile           |    1 +
>  drivers/dma/ti/k3-udma-common.c   |   75 +-
>  drivers/dma/ti/k3-udma-v2.c       | 1283 +++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.h          |  117 +--
>  include/linux/soc/ti/k3-ringacc.h |    3 +
>  6 files changed, 1429 insertions(+), 66 deletions(-)
>  create mode 100644 drivers/dma/ti/k3-udma-v2.c
> 
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index 712e456015459..ada2ea8aca4b0 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -49,6 +49,18 @@ config TI_K3_UDMA
>  	  Enable support for the TI UDMA (Unified DMA) controller. This
>  	  DMA engine is used in AM65x and j721e.
>  
> +config TI_K3_UDMA_V2
> +	tristate "Texas Instruments K3 UDMA v2 support"
> +	depends on ARCH_K3
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	select TI_K3_UDMA_COMMON
> +	select TI_K3_RINGACC
> +	select TI_K3_PSIL
> +        help
> +	  Enable support for the TI UDMA (Unified DMA) v2 controller. This
> +	  DMA engine is used in AM62L.
> +
>  config TI_K3_UDMA_COMMON
>  	tristate
>  	default n
> @@ -56,14 +68,14 @@ config TI_K3_UDMA_COMMON
>  config TI_K3_UDMA_GLUE_LAYER
>  	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
>  	depends on ARCH_K3 || COMPILE_TEST
> -	depends on TI_K3_UDMA
> +	depends on TI_K3_UDMA || TI_K3_UDMA_V2

At this point the glue layer should not have dependency on UDMA_V2 as it
only receives BCDMA support, which is not used by the glue?

>  	help
>  	  Say y here to support the K3 NAVSS DMA glue interface
>  	  If unsure, say N.
>  
>  config TI_K3_PSIL
>         tristate
> -       default TI_K3_UDMA
> +       default TI_K3_UDMA || TI_K3_UDMA_V2
>  
>  config TI_DMA_CROSSBAR
>  	bool
> diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
> index 41bfba944dc6c..296aa3421e71b 100644
> --- a/drivers/dma/ti/Makefile
> +++ b/drivers/dma/ti/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_TI_CPPI41) += cppi41.o
>  obj-$(CONFIG_TI_EDMA) += edma.o
>  obj-$(CONFIG_DMA_OMAP) += omap-dma.o
>  obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
> +obj-$(CONFIG_TI_K3_UDMA_V2) += k3-udma-v2.o
>  obj-$(CONFIG_TI_K3_UDMA_COMMON) += k3-udma-common.o
>  obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
>  k3-psil-lib-objs := k3-psil.o \
> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
> index 0ffc6becc402e..ba0fc048234ac 100644
> --- a/drivers/dma/ti/k3-udma-common.c
> +++ b/drivers/dma/ti/k3-udma-common.c
> @@ -171,8 +171,13 @@ bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>  	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
>  		return true;
>  
> -	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
> -	bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +	if (uc->ud->match_data->type >= DMA_TYPE_BCDMA_V2) {
> +		peer_bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_PERIPH_BCNT_REG);
> +		bcnt = udma_chanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +	} else {
> +		peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
> +		bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +	}
>  
>  	/* Transfer is incomplete, store current residue and time stamp */
>  	if (peer_bcnt < bcnt) {
> @@ -319,6 +324,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  	size_t tr_size;
>  	int num_tr = 0;
>  	int tr_idx = 0;
> +	u32 extra_flags = 0;

nitpick: reverse christmas tree order

>  	u64 asel;
>  
>  	/* estimate the number of TRs we will need */
> @@ -342,6 +348,9 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  	else
>  		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
>  
> +	if (dir == DMA_MEM_TO_DEV && uc->ud->match_data->type == DMA_TYPE_BCDMA_V2)

I would add the evaluation order in reverse to skip checking direction
for UDMA_V1.

> +		extra_flags = CPPI5_TR_CSF_EOP;
> +
>  	tr_req = d->hwdesc[0].tr_req_base;
>  	for_each_sg(sgl, sgent, sglen, i) {
>  		dma_addr_t sg_addr = sg_dma_address(sgent);
> @@ -358,7 +367,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  
>  		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
>  			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT | extra_flags);
>  
>  		sg_addr |= asel;
>  		tr_req[tr_idx].addr = sg_addr;
> @@ -372,7 +381,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  				      false, false,
>  				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
>  			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +					 CPPI5_TR_CSF_SUPR_EVT | extra_flags);
>  
>  			tr_req[tr_idx].addr = sg_addr + tr0_cnt1 * tr0_cnt0;
>  			tr_req[tr_idx].icnt0 = tr1_cnt0;
> @@ -632,7 +641,8 @@ int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
>  			d->static_tr.bstcnt = d->residue / d->sglen / div;
>  		else
>  			d->static_tr.bstcnt = d->residue / div;
> -	} else if (uc->ud->match_data->type == DMA_TYPE_BCDMA &&
> +	} else if ((uc->ud->match_data->type == DMA_TYPE_BCDMA ||
> +		   uc->ud->match_data->type == DMA_TYPE_BCDMA_V2) &&

Have you thought of adding a version member to struct udma_match_data
and use that instead of distinct different types for BCDMA/PKTDMA?

Here for example you would not need any change as the code is common for
both v1 and v2.

>  		   uc->config.dir == DMA_DEV_TO_MEM &&
>  		   uc->cyclic) {
>  		/*
...

> diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
> new file mode 100644
> index 0000000000000..af06d25fd598b
> --- /dev/null
> +++ b/drivers/dma/ti/k3-udma-v2.c

...

> +static bool udma_v2_dma_filter_fn(struct dma_chan *chan, void *param)
> +{
> +	struct udma_chan_config *ucc;
> +	struct psil_endpoint_config *ep_config;
> +	struct udma_v2_filter_param *filter_param;
> +	struct udma_chan *uc;
> +	struct udma_dev *ud;

nitpick: reverse christmas tree order
also in few other places.

-- 
Péter


