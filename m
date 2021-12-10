Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD48470B84
	for <lists+dmaengine@lfdr.de>; Fri, 10 Dec 2021 21:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhLJUNT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Dec 2021 15:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344039AbhLJUNS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Dec 2021 15:13:18 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E28C061353;
        Fri, 10 Dec 2021 12:09:42 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b19so13509824ljr.12;
        Fri, 10 Dec 2021 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=xrpHd8kVftwQX0I0zoEuaQuKXl5F7Q3cALZMkQUcmHk=;
        b=aXwiv4aNsDR1u7FmPD3ogtTBd1tW5jfK7FKHdPgvVqaqMSVqfGMoYSitMAc4/pkwEu
         T9OmPgcq9eFNlQHpjtDz6oUKgvB+9jQ7yPR3rSmo0hjFy+gQdx7zthCW1xtFLdZTgPnG
         yMjFoDp0jScSI7gns058QlM+5gzaUTlSvny9Z29pTV0TMWppvisVWdS0eN9EUAw1W9or
         Br6QqU+eVeELvmhR5AmU/npFWpiIwizHVccIyU8FGliSSMXAd3wwK9LkRvgoQzyHNW52
         eFxv9AjRfSSjC7vhJuv7dOKw+fYh7061nK7xzJc5DXmWn6VTeQFV3wBcWWpgwND20/Jw
         BHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=xrpHd8kVftwQX0I0zoEuaQuKXl5F7Q3cALZMkQUcmHk=;
        b=KK/lacGlBhuOWYq4HAiJV6ba62M7WANKyIespEzL7tTKQskcFcbgdqmwSltuSEcHpg
         Mh1H+27NDm7Pg+K5lpVN8/a5yg8Vro7HExuwHC020+NxmnCrnwVkOTmPPjLVeApu9wuj
         NgFBf2VVKlOlR7BqsjhEwmdMjRVZqj/cxLzjNzqpSNxHuEkR0C+mJ2iX0bUG9lRJHwxT
         uQLRgdRN1BqZRUqZmcS3p10WxqUAN8HYf2Plx/Uy/S1zf8L2Gke3jiCss+dtu9nvh286
         metUuXpGwLwMNM86WV5L7M8+QXp+BHMmr3vm09vQVxk340122gPsCUE8mh4plDUF+rHe
         d7uA==
X-Gm-Message-State: AOAM5300RvPd45BPVV3/hUldM0B+Nj9yn3FyfWN1nzF4NgqT3H07HhJK
        kOyyF3XDgWQ8Y5t8ZYLYdlYR502yiz9d4g==
X-Google-Smtp-Source: ABdhPJzuxRBtHvLFDqkd06VF7tPxPunAxlfO0DpazAj61e+BCB/5DQqs51m47uJpIAwW58yZej2lxQ==
X-Received: by 2002:a05:651c:1036:: with SMTP id w22mr14122630ljm.356.1639166981113;
        Fri, 10 Dec 2021 12:09:41 -0800 (PST)
Received: from [10.0.0.115] (91-153-170-164.elisa-laajakaista.fi. [91.153.170.164])
        by smtp.gmail.com with ESMTPSA id v198sm402095lfa.89.2021.12.10.12.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 12:09:40 -0800 (PST)
Message-ID: <8ae3b70e-3697-2d3f-9a62-378f1a3748d7@gmail.com>
Date:   Fri, 10 Dec 2021 22:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Nishanth Menon <nm@ti.com>
References: <20211209180957.29036-1-vigneshr@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] dma: ti: k3-udma: Fix smatch warnings
In-Reply-To: <20211209180957.29036-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 09/12/2021 20:09, Vignesh Raghavendra wrote:
> Smatch reports below warnings [1] wrt dereferencing rm_res when it can
> potentially be ERR_PTR(). This is possible when entire range is
> allocated to Linux
> Fix this case by making sure, there is no deference of rm_res when its
> ERR_PTR().

Valid, early sysfs did not had rm ranges, thus we assumed all channels
are for Linux, then we got support for one range per channel type and
then the sets got introduced for supporting the differnt throughput
levels of channles in the types.
This surely got overlooked.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> [1]:
>  drivers/dma/ti/k3-udma.c:4524 udma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
>  drivers/dma/ti/k3-udma.c:4537 udma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
>  drivers/dma/ti/k3-udma.c:4681 bcdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
>  drivers/dma/ti/k3-udma.c:4696 bcdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
>  drivers/dma/ti/k3-udma.c:4711 bcdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
>  drivers/dma/ti/k3-udma.c:4848 pktdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
>  drivers/dma/ti/k3-udma.c:4861 pktdma_setup_resources() error: 'rm_res' dereferencing possible ERR_PTR()
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 157 ++++++++++++++++++++++++++-------------
>  1 file changed, 107 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 041d8e32d630..6e56d1cef5ee 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -4534,45 +4534,60 @@ static int udma_setup_resources(struct udma_dev *ud)
>  	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
>  	if (IS_ERR(rm_res)) {
>  		bitmap_zero(ud->tchan_map, ud->tchan_cnt);
> +		irq_res.sets = 1;
>  	} else {
>  		bitmap_fill(ud->tchan_map, ud->tchan_cnt);
>  		for (i = 0; i < rm_res->sets; i++)
>  			udma_mark_resource_ranges(ud, ud->tchan_map,
>  						  &rm_res->desc[i], "tchan");
> +		irq_res.sets = rm_res->sets;
>  	}
> -	irq_res.sets = rm_res->sets;
>  
>  	/* rchan and matching default flow ranges */
>  	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
>  	if (IS_ERR(rm_res)) {
>  		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
> +		irq_res.sets++;
>  	} else {
>  		bitmap_fill(ud->rchan_map, ud->rchan_cnt);
>  		for (i = 0; i < rm_res->sets; i++)
>  			udma_mark_resource_ranges(ud, ud->rchan_map,
>  						  &rm_res->desc[i], "rchan");
> +		irq_res.sets += rm_res->sets;
>  	}
>  
> -	irq_res.sets += rm_res->sets;
>  	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
> +	if (!irq_res.desc)
> +		return -ENOMEM;
>  	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
> -	for (i = 0; i < rm_res->sets; i++) {
> -		irq_res.desc[i].start = rm_res->desc[i].start;
> -		irq_res.desc[i].num = rm_res->desc[i].num;
> -		irq_res.desc[i].start_sec = rm_res->desc[i].start_sec;
> -		irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
> +	if (IS_ERR(rm_res)) {
> +		irq_res.desc[0].start = 0;
> +		irq_res.desc[0].num = ud->tchan_cnt;
> +		i = 1;
> +	} else {
> +		for (i = 0; i < rm_res->sets; i++) {
> +			irq_res.desc[i].start = rm_res->desc[i].start;
> +			irq_res.desc[i].num = rm_res->desc[i].num;
> +			irq_res.desc[i].start_sec = rm_res->desc[i].start_sec;
> +			irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
> +		}
>  	}
>  	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
> -	for (j = 0; j < rm_res->sets; j++, i++) {
> -		if (rm_res->desc[j].num) {
> -			irq_res.desc[i].start = rm_res->desc[j].start +
> -					ud->soc_data->oes.udma_rchan;
> -			irq_res.desc[i].num = rm_res->desc[j].num;
> -		}
> -		if (rm_res->desc[j].num_sec) {
> -			irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
> -					ud->soc_data->oes.udma_rchan;
> -			irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
> +	if (IS_ERR(rm_res)) {
> +		irq_res.desc[i].start = 0;
> +		irq_res.desc[i].num = ud->rchan_cnt;
> +	} else {
> +		for (j = 0; j < rm_res->sets; j++, i++) {
> +			if (rm_res->desc[j].num) {
> +				irq_res.desc[i].start = rm_res->desc[j].start +
> +						ud->soc_data->oes.udma_rchan;
> +				irq_res.desc[i].num = rm_res->desc[j].num;
> +			}
> +			if (rm_res->desc[j].num_sec) {
> +				irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
> +						ud->soc_data->oes.udma_rchan;
> +				irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
> +			}
>  		}
>  	}
>  	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
> @@ -4690,14 +4705,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>  		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
>  		if (IS_ERR(rm_res)) {
>  			bitmap_zero(ud->bchan_map, ud->bchan_cnt);
> +			irq_res.sets++;
>  		} else {
>  			bitmap_fill(ud->bchan_map, ud->bchan_cnt);
>  			for (i = 0; i < rm_res->sets; i++)
>  				udma_mark_resource_ranges(ud, ud->bchan_map,
>  							  &rm_res->desc[i],
>  							  "bchan");
> +			irq_res.sets += rm_res->sets;
>  		}
> -		irq_res.sets += rm_res->sets;
>  	}
>  
>  	/* tchan ranges */
> @@ -4705,14 +4721,15 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>  		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
>  		if (IS_ERR(rm_res)) {
>  			bitmap_zero(ud->tchan_map, ud->tchan_cnt);
> +			irq_res.sets += 2;
>  		} else {
>  			bitmap_fill(ud->tchan_map, ud->tchan_cnt);
>  			for (i = 0; i < rm_res->sets; i++)
>  				udma_mark_resource_ranges(ud, ud->tchan_map,
>  							  &rm_res->desc[i],
>  							  "tchan");
> +			irq_res.sets += rm_res->sets * 2;
>  		}
> -		irq_res.sets += rm_res->sets * 2;
>  	}
>  
>  	/* rchan ranges */
> @@ -4720,47 +4737,72 @@ static int bcdma_setup_resources(struct udma_dev *ud)
>  		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
>  		if (IS_ERR(rm_res)) {
>  			bitmap_zero(ud->rchan_map, ud->rchan_cnt);
> +			irq_res.sets += 2;
>  		} else {
>  			bitmap_fill(ud->rchan_map, ud->rchan_cnt);
>  			for (i = 0; i < rm_res->sets; i++)
>  				udma_mark_resource_ranges(ud, ud->rchan_map,
>  							  &rm_res->desc[i],
>  							  "rchan");
> +			irq_res.sets += rm_res->sets * 2;
>  		}
> -		irq_res.sets += rm_res->sets * 2;
>  	}
>  
>  	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
> +	if (!irq_res.desc)
> +		return -ENOMEM;
>  	if (ud->bchan_cnt) {
>  		rm_res = tisci_rm->rm_ranges[RM_RANGE_BCHAN];
> -		for (i = 0; i < rm_res->sets; i++) {
> -			irq_res.desc[i].start = rm_res->desc[i].start +
> -						oes->bcdma_bchan_ring;
> -			irq_res.desc[i].num = rm_res->desc[i].num;
> +		if (IS_ERR(rm_res)) {
> +			irq_res.desc[0].start = oes->bcdma_bchan_ring;
> +			irq_res.desc[0].num = ud->bchan_cnt;
> +			i = 1;
> +		} else {
> +			for (i = 0; i < rm_res->sets; i++) {
> +				irq_res.desc[i].start = rm_res->desc[i].start +
> +							oes->bcdma_bchan_ring;
> +				irq_res.desc[i].num = rm_res->desc[i].num;
> +			}
>  		}
>  	}
>  	if (ud->tchan_cnt) {
>  		rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
> -		for (j = 0; j < rm_res->sets; j++, i += 2) {
> -			irq_res.desc[i].start = rm_res->desc[j].start +
> -						oes->bcdma_tchan_data;
> -			irq_res.desc[i].num = rm_res->desc[j].num;
> -
> -			irq_res.desc[i + 1].start = rm_res->desc[j].start +
> -						oes->bcdma_tchan_ring;
> -			irq_res.desc[i + 1].num = rm_res->desc[j].num;
> +		if (IS_ERR(rm_res)) {
> +			irq_res.desc[i].start = oes->bcdma_tchan_data;
> +			irq_res.desc[i].num = ud->tchan_cnt;
> +			irq_res.desc[i + 1].start = oes->bcdma_tchan_ring;
> +			irq_res.desc[i + 1].num = ud->tchan_cnt;
> +			i += 2;
> +		} else {
> +			for (j = 0; j < rm_res->sets; j++, i += 2) {
> +				irq_res.desc[i].start = rm_res->desc[j].start +
> +							oes->bcdma_tchan_data;
> +				irq_res.desc[i].num = rm_res->desc[j].num;
> +
> +				irq_res.desc[i + 1].start = rm_res->desc[j].start +
> +							oes->bcdma_tchan_ring;
> +				irq_res.desc[i + 1].num = rm_res->desc[j].num;
> +			}
>  		}
>  	}
>  	if (ud->rchan_cnt) {
>  		rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
> -		for (j = 0; j < rm_res->sets; j++, i += 2) {
> -			irq_res.desc[i].start = rm_res->desc[j].start +
> -						oes->bcdma_rchan_data;
> -			irq_res.desc[i].num = rm_res->desc[j].num;
> -
> -			irq_res.desc[i + 1].start = rm_res->desc[j].start +
> -						oes->bcdma_rchan_ring;
> -			irq_res.desc[i + 1].num = rm_res->desc[j].num;
> +		if (IS_ERR(rm_res)) {
> +			irq_res.desc[i].start = oes->bcdma_rchan_data;
> +			irq_res.desc[i].num = ud->rchan_cnt;
> +			irq_res.desc[i + 1].start = oes->bcdma_rchan_ring;
> +			irq_res.desc[i + 1].num = ud->rchan_cnt;
> +			i += 2;
> +		} else {
> +			for (j = 0; j < rm_res->sets; j++, i += 2) {
> +				irq_res.desc[i].start = rm_res->desc[j].start +
> +							oes->bcdma_rchan_data;
> +				irq_res.desc[i].num = rm_res->desc[j].num;
> +
> +				irq_res.desc[i + 1].start = rm_res->desc[j].start +
> +							oes->bcdma_rchan_ring;
> +				irq_res.desc[i + 1].num = rm_res->desc[j].num;
> +			}
>  		}
>  	}
>  
> @@ -4858,39 +4900,54 @@ static int pktdma_setup_resources(struct udma_dev *ud)
>  	if (IS_ERR(rm_res)) {
>  		/* all rflows are assigned exclusively to Linux */
>  		bitmap_zero(ud->rflow_in_use, ud->rflow_cnt);
> +		irq_res.sets = 1;
>  	} else {
>  		bitmap_fill(ud->rflow_in_use, ud->rflow_cnt);
>  		for (i = 0; i < rm_res->sets; i++)
>  			udma_mark_resource_ranges(ud, ud->rflow_in_use,
>  						  &rm_res->desc[i], "rflow");
> +		irq_res.sets = rm_res->sets;
>  	}
> -	irq_res.sets = rm_res->sets;
>  
>  	/* tflow ranges */
>  	rm_res = tisci_rm->rm_ranges[RM_RANGE_TFLOW];
>  	if (IS_ERR(rm_res)) {
>  		/* all tflows are assigned exclusively to Linux */
>  		bitmap_zero(ud->tflow_map, ud->tflow_cnt);
> +		irq_res.sets++;
>  	} else {
>  		bitmap_fill(ud->tflow_map, ud->tflow_cnt);
>  		for (i = 0; i < rm_res->sets; i++)
>  			udma_mark_resource_ranges(ud, ud->tflow_map,
>  						  &rm_res->desc[i], "tflow");
> +		irq_res.sets += rm_res->sets;
>  	}
> -	irq_res.sets += rm_res->sets;
>  
>  	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
> +	if (!irq_res.desc)
> +		return -ENOMEM;
>  	rm_res = tisci_rm->rm_ranges[RM_RANGE_TFLOW];
> -	for (i = 0; i < rm_res->sets; i++) {
> -		irq_res.desc[i].start = rm_res->desc[i].start +
> -					oes->pktdma_tchan_flow;
> -		irq_res.desc[i].num = rm_res->desc[i].num;
> +	if (IS_ERR(rm_res)) {
> +		irq_res.desc[0].start = oes->pktdma_tchan_flow;
> +		irq_res.desc[0].num = ud->tflow_cnt;
> +		i = 1;
> +	} else {
> +		for (i = 0; i < rm_res->sets; i++) {
> +			irq_res.desc[i].start = rm_res->desc[i].start +
> +						oes->pktdma_tchan_flow;
> +			irq_res.desc[i].num = rm_res->desc[i].num;
> +		}
>  	}
>  	rm_res = tisci_rm->rm_ranges[RM_RANGE_RFLOW];
> -	for (j = 0; j < rm_res->sets; j++, i++) {
> -		irq_res.desc[i].start = rm_res->desc[j].start +
> -					oes->pktdma_rchan_flow;
> -		irq_res.desc[i].num = rm_res->desc[j].num;
> +	if (IS_ERR(rm_res)) {
> +		irq_res.desc[i].start = oes->pktdma_rchan_flow;
> +		irq_res.desc[i].num = ud->rflow_cnt;
> +	} else {
> +		for (j = 0; j < rm_res->sets; j++, i++) {
> +			irq_res.desc[i].start = rm_res->desc[j].start +
> +						oes->pktdma_rchan_flow;
> +			irq_res.desc[i].num = rm_res->desc[j].num;
> +		}
>  	}
>  	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
>  	kfree(irq_res.desc);
> 

-- 
Péter
