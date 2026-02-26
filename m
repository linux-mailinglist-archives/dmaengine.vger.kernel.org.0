Return-Path: <dmaengine+bounces-9134-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDsTMQOjoGkvlQQAu9opvQ
	(envelope-from <dmaengine+bounces-9134-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 20:46:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C21AE9EE
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 20:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DDBD318126B
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2745349E;
	Thu, 26 Feb 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhpY2xEj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963B451061
	for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134705; cv=none; b=aSMbBNeG5tez6JQILBR/1b3L5oWagmx/r7hd/MmMIGzfwRka4kzuOgFEM+Xru+jaH4EnNBOC+G3Luz5IwMHJjhM1VeyLS5b4PZliGoK4MlsbL1yferfLlSi2yFtrdrhtC3QHhAcvfYragxnta2F2SDV9SRzcLV+8Ct9fWUurs2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134705; c=relaxed/simple;
	bh=fjUa9EDlU3GuO7EKIKyPeJZwolOxnfN83FgyVCqmeVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqGczwmpRhFYrCv+xM4+YdzG/d6kMffrGmjAoy3bChzbHbCqbZWV3AbN02QMY7ncFbon8C+DTIekmwc1kij1srYbGOrVj9gBuYM9aDnX5djyjhpT2PyLHJ76jxl4gQY5KWwIPnCk4WiR/5WP13uCT+3aSh/xL6TClgICeXVW2FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhpY2xEj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a1045e228fso1506506e87.3
        for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 11:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134699; x=1772739499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ln/7jOAd0mq+qmA6pTYKQmtpks7jHYiU+Gg/M2EOX0w=;
        b=LhpY2xEjunMdiD8x4ZDEuYb6eeMwyfs5e12o1qb2oU1pcokbHExraBJz33cqs9qeN8
         mhK3W6Omkzsj1LU+jjojq/UF/71xCsBgIbbeTqkxvBd4L6aBE8kbpZzHbjrk0x7QQU9s
         k4zguCTzi3qXLA3N1WMjZ04QcbblCxNSKQr+8DF5T7LrxHBfAwGEP9hojBUWWa9sLlQ7
         tq7HdBlfv0DoIaJeu+mNsYfdKAxC1A8ObfMaublDd+1+vqax1IRnMXq7dvGeNrB5PPQZ
         XBk5IypMDaNPEUUDiHdkaVsv1kvVu3emHg1He5l5s8/ETfPq0lnE9E5kgkJZ3Gh7pmSI
         YPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134699; x=1772739499;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln/7jOAd0mq+qmA6pTYKQmtpks7jHYiU+Gg/M2EOX0w=;
        b=ct5guloZsBFkBnrAIDYXeGNYMCme9h8Uc7iPqMWJxdVh1c9RQwhjOBEOgPNsma3xad
         Rwqv5Rbd61yEBkmfwQ9dEvwGHg3VOwOzG0seTGIR2ESjLXSjMLhymO5JwJ/85ieJyZk6
         ZjurnoAhTsCDJgNas2WkoLp0wspMUnPdHsnXsZ58VNsgECHlo3E7VevfrsLSXsbgFfmR
         B3WPmdnp5pI3KUPvBC3xeCT1Q17NW//v3RpDRTg9m5q/ablN6cgZtPFKBNnbugnYZPjr
         pLC2mCsQeBE3Bp2JxZ4vZI5iKB7LNyvGpb5JM5DAW7sqp0ue/8sMz9TluBwBdmPTWYpu
         f2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCX0LXGrc71hBhOjuKce/HWO7Um+XIyniQgh88tx2LTKzA/TawZTtWr0W5fGVxsyUGFPoplqajJy0c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7aNocxvE+q4J0Ypc6i9b0giFY2/VymtaCs/0FeF4yss4lBUfS
	At2aPLNAM/0VyrX8bxxsPPyW+Lry0wtOCL/5/6d/NT7EPLGJEVc/ReNg
X-Gm-Gg: ATEYQzxQW7FOtjw7uvzwvt7CzGot7HnlGmI1Ydj/OS2XdCnhJNUfZwlRnPvT3oX4zNS
	IVhsWlHQrN03c60+bqmcmlGuh69BnsDvLjQH6dlczTwghauqr1IMgS8KkvYXt0ci2HCjnBDkzr4
	fzBHHGl/TOe41iDhE6q39xcwUKz2Z+KNSR9yCVf97H072JVrTfZRf/EblJoQJYUBhkA5+NLThAN
	efYQQcekfsXOUyOjUC3KXTbyRC4z95cdKjreLUiY4CgJO8fMmjFfWrUk2jJ9A9WOp7ZrspBdOsc
	Gq9ZkaqObV3hKo6T0lgMJzS8NCBZvK0inVi+pPiFp1bjBTTlz7b/3g1b9pI1r53bpeIC2IJFqD+
	onvQW91RYz4JYP+uuHwJ7MOs1cNoAJx9FMNmaOb8MWdZV8yZDBMJMZJK6LdQuYeyXWBuT3NBM07
	B4iWaId0ka+7kPC2ACQTUOGlOAloPlKBFLSFMKn2nHqOqhnqQLVGbmeFIuQ5gmD/CUNEfemdQ=
X-Received: by 2002:ac2:4f0d:0:b0:59e:5fc4:26b2 with SMTP id 2adb3069b0e04-5a10ff299f2mr101372e87.0.1772134698984;
        Thu, 26 Feb 2026 11:38:18 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-74-59.kaisa-laajakaista.fi. [185.69.74.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a10ff4341asm122617e87.39.2026.02.26.11.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 11:38:17 -0800 (PST)
Message-ID: <5c70a8d7-9215-46d3-bcd4-0837597fdda7@gmail.com>
Date: Thu, 26 Feb 2026 21:39:44 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] dmaengine: ti: k3-udma-v2: New driver for K3
 BCDMA_V2
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, vkoul@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
 ssantosh@kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 vigneshr@ti.com, Frank.li@nxp.com
Cc: r-sharma3@ti.com, gehariprasath@ti.com
References: <20260218095243.2832115-1-s-adivi@ti.com>
 <20260218095243.2832115-16-s-adivi@ti.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20260218095243.2832115-16-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9134-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterujfalusi@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 374C21AE9EE
X-Rspamd-Action: no action



On 18/02/2026 11:52, Sai Sree Kartheek Adivi wrote:
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
> - Unified Channel Space: Tx and Rx channels share a single register
>   space. Each channel index is specifically fixed in hardware as either
>   Tx or Rx in an interleaved manner.
> 
> Also, since a version member is introduced in the match_data, Add
> version v1 in match_data of SoCs using v1 DMA.
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/dma/ti/Kconfig            |   14 +-
>  drivers/dma/ti/Makefile           |    1 +
>  drivers/dma/ti/k3-udma-common.c   |   86 +-
>  drivers/dma/ti/k3-udma-v2.c       | 1283 +++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.c          |    9 +
>  drivers/dma/ti/k3-udma.h          |  121 +--
>  include/linux/soc/ti/k3-ringacc.h |    3 +
>  7 files changed, 1446 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/dma/ti/k3-udma-v2.c
> 
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index 712e456015459..40713bd1e8e9b 100644
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
> @@ -63,7 +75,7 @@ config TI_K3_UDMA_GLUE_LAYER
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
> index 0ffc6becc402e..ff2b0353515ee 100644
> --- a/drivers/dma/ti/k3-udma-common.c
> +++ b/drivers/dma/ti/k3-udma-common.c
> @@ -171,8 +171,13 @@ bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
>  	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
>  		return true;
>  
> -	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
> -	bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +	if (uc->ud->match_data->version == K3_UDMA_V2) {

Consider to start with V1? V3 might be similar to V2 and you save on
churn in the future?

Same comment for other version checks.

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
>  	u64 asel;
>  
>  	/* estimate the number of TRs we will need */
> @@ -342,6 +348,11 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  	else
>  		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
>  
> +	if (uc->ud->match_data->type == DMA_TYPE_BCDMA &&
> +	    uc->ud->match_data->version == K3_UDMA_V2 &&
> +	    dir == DMA_MEM_TO_DEV)
> +		extra_flags = CPPI5_TR_CSF_EOP;
> +
>  	tr_req = d->hwdesc[0].tr_req_base;
>  	for_each_sg(sgl, sgent, sglen, i) {
>  		dma_addr_t sg_addr = sg_dma_address(sgent);
> @@ -358,7 +369,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  
>  		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
>  			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT | extra_flags);
>  
>  		sg_addr |= asel;
>  		tr_req[tr_idx].addr = sg_addr;
> @@ -372,7 +383,7 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>  				      false, false,
>  				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
>  			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> +					 CPPI5_TR_CSF_SUPR_EVT | extra_flags);
>  
>  			tr_req[tr_idx].addr = sg_addr + tr0_cnt1 * tr0_cnt0;
>  			tr_req[tr_idx].icnt0 = tr1_cnt0;
> @@ -2052,6 +2063,8 @@ int udma_get_tchan(struct udma_chan *uc)
>  		uc->tchan = NULL;
>  		return ret;
>  	}
> +	if (ud->match_data->version == K3_UDMA_V2)
> +		uc->chan = uc->tchan;
>  
>  	if (ud->tflow_cnt) {
>  		int tflow_id;
> @@ -2102,6 +2115,8 @@ int udma_get_rchan(struct udma_chan *uc)
>  		uc->rchan = NULL;
>  		return ret;
>  	}
> +	if (ud->match_data->version == K3_UDMA_V2)
> +		uc->chan = uc->rchan;
>  
>  	return 0;
>  }
> @@ -2379,16 +2394,26 @@ int bcdma_setup_resources(struct udma_dev *ud)
>  
>  	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
>  					   sizeof(unsigned long), GFP_KERNEL);
> +	bitmap_zero(ud->bchan_map, ud->bchan_cnt);
>  	ud->bchans = devm_kcalloc(dev, ud->bchan_cnt, sizeof(*ud->bchans),
>  				  GFP_KERNEL);
>  	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
>  					   sizeof(unsigned long), GFP_KERNEL);
> +	bitmap_zero(ud->tchan_map, ud->tchan_cnt);
>  	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
>  				  GFP_KERNEL);
> -	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
> -					   sizeof(unsigned long), GFP_KERNEL);
> -	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
> -				  GFP_KERNEL);
> +	if (ud->match_data->version == K3_UDMA_V2) {
> +		ud->rchan_map = ud->tchan_map;
> +		ud->rchans = ud->tchans;
> +		ud->chan_map = ud->tchan_map;
> +		ud->chans = ud->tchans;
> +	} else {
> +		ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
> +						   sizeof(unsigned long), GFP_KERNEL);
> +		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
> +		ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
> +					  GFP_KERNEL);
> +	}
>  	/* BCDMA do not really have flows, but the driver expect it */
>  	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rchan_cnt),
>  					sizeof(unsigned long),
> @@ -2484,11 +2509,18 @@ int setup_resources(struct udma_dev *ud)
>  	if (ret)
>  		return ret;
>  
> -	ch_count  = ud->bchan_cnt + ud->tchan_cnt + ud->rchan_cnt;
> -	if (ud->bchan_cnt)
> -		ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
> -	ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
> -	ch_count -= bitmap_weight(ud->rchan_map, ud->rchan_cnt);
> +	if (ud->match_data->version == K3_UDMA_V2) {

I would probbaly check for V1 and leave the V2 as simple else - trusting
that v3 will likely be closer to it than v1?

> +		ch_count = ud->bchan_cnt + ud->tchan_cnt;
> +		if (ud->bchan_cnt)
> +			ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
> +		ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
> +	} else {
> +		ch_count  = ud->bchan_cnt + ud->tchan_cnt + ud->rchan_cnt;
> +		if (ud->bchan_cnt)
> +			ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
> +		ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
> +		ch_count -= bitmap_weight(ud->rchan_map, ud->rchan_cnt);
> +	}
>  	if (!ch_count)
>  		return -ENODEV;
>  
> @@ -2510,15 +2542,25 @@ int setup_resources(struct udma_dev *ud)
>  						       ud->rflow_cnt));
>  		break;
>  	case DMA_TYPE_BCDMA:
> -		dev_info(dev,
> -			 "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
> -			 ch_count,
> -			 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
> -						       ud->bchan_cnt),
> -			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
> -						       ud->tchan_cnt),
> -			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
> -						       ud->rchan_cnt));
> +		if (ud->match_data->version == K3_UDMA_V1) {
> +			dev_info(dev,
> +				 "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
> +				 ch_count,
> +				 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
> +							       ud->bchan_cnt),
> +				 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
> +							       ud->tchan_cnt),
> +				 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
> +							       ud->rchan_cnt));
> +		} else if (ud->match_data->version == K3_UDMA_V2) {
> +			dev_info(dev,
> +				 "Channels: %d (bchan: %u, chan: %u)\n",
> +				 ch_count,
> +				 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
> +							       ud->bchan_cnt),
> +				 ud->chan_cnt - bitmap_weight(ud->chan_map,
> +							      ud->chan_cnt));
> +		}

if you have else if {} you do want to have plain else {} to handle cases
when neither.
CHeck for V1 and leave V2 for a plain else branch?

Optionally if indentation is geting tight, just create a helper function
to print this info.

>  		break;
>  	case DMA_TYPE_PKTDMA:
>  		dev_info(dev,

I think this and the series looks good, the only thing I would consider
is to revers the V1/2 checks when it makes sense - future incarnations
of UDMA might be closer to V2 than V1 and you save on maintanance headache.

-- 
Péter


