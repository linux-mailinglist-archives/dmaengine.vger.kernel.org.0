Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC122A2582
	for <lists+dmaengine@lfdr.de>; Mon,  2 Nov 2020 08:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgKBHpn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Nov 2020 02:45:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59160 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgKBHpn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 Nov 2020 02:45:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A27jeoa072868;
        Mon, 2 Nov 2020 01:45:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604303140;
        bh=bvTTRAAP9RQc259vTbJiO3bSZW1rYmd9CwlKoSzaKJw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BYcYXit935f9TFyZ/ciWNV/6Qfj1TQEpi4KepiGl07Wm4LwlQoCXVkv82ljmYvH2D
         w6luUIB2mCFCgl2DEtl+OaoJL8hIg0TmMjQ2/18JbXG8ZPBHbq/MPCJaUKq+WjHXw0
         2kPFqpN8ajb5y3w+I3egaSS2803NOSp4UFHE95qo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A27jexf111792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 01:45:40 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 01:45:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 01:45:40 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A27jcHQ046900;
        Mon, 2 Nov 2020 01:45:39 -0600
Subject: Re: [PATCH] dmaengine: ti: k3-udma-glue: move psi-l pairing in
 channel en/dis functions
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20201030203000.4281-1-grygorii.strashko@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <62a8dc0b-821d-c3a6-279c-97b3082b898c@ti.com>
Date:   Mon, 2 Nov 2020 09:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201030203000.4281-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 30/10/2020 22.30, Grygorii Strashko wrote:
> The NAVSS UDMA will stuck if target IP module is disabled by PM while PSI-L
> threads are paired UDMA<->IP and no further transfers is possible. This
> could be the case for IPs J721E Main CPSW (cpsw9g).
> 
> Hence, to avoid such situation do PSI-L threads pairing only when UDMA
> channel is going to be enabled as at this time DMA consumer module expected
> to be active already.

Is this patch on top of the AM64 (BCDMA/PKTDMA) series or not?
Will it cause any conflict?

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>


> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/dma/ti/k3-udma-glue.c | 64 +++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index a367584f0d7b..dfb65e382ab9 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -303,19 +303,6 @@ struct k3_udma_glue_tx_channel *k3_udma_glue_request_tx_chn(struct device *dev,
>  		goto err;
>  	}
>  
> -	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
> -				    tx_chn->common.src_thread,
> -				    tx_chn->common.dst_thread);
> -	if (ret) {
> -		dev_err(dev, "PSI-L request err %d\n", ret);
> -		goto err;
> -	}
> -
> -	tx_chn->psil_paired = true;
> -
> -	/* reset TX RT registers */
> -	k3_udma_glue_disable_tx_chn(tx_chn);
> -
>  	k3_udma_glue_dump_tx_chn(tx_chn);
>  
>  	return tx_chn;
> @@ -378,6 +365,18 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_pop_tx_chn);
>  
>  int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
>  {
> +	int ret;
> +
> +	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
> +				    tx_chn->common.src_thread,
> +				    tx_chn->common.dst_thread);
> +	if (ret) {
> +		dev_err(tx_chn->common.dev, "PSI-L request err %d\n", ret);
> +		return ret;
> +	}
> +
> +	tx_chn->psil_paired = true;
> +
>  	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
>  			    UDMA_PEER_RT_EN_ENABLE);
>  
> @@ -398,6 +397,13 @@ void k3_udma_glue_disable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
>  	xudma_tchanrt_write(tx_chn->udma_tchanx,
>  			    UDMA_CHAN_RT_PEER_RT_EN_REG, 0);
>  	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn dis2");
> +
> +	if (tx_chn->psil_paired) {
> +		xudma_navss_psil_unpair(tx_chn->common.udmax,
> +					tx_chn->common.src_thread,
> +					tx_chn->common.dst_thread);
> +		tx_chn->psil_paired = false;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(k3_udma_glue_disable_tx_chn);
>  
> @@ -815,19 +821,6 @@ k3_udma_glue_request_rx_chn_priv(struct device *dev, const char *name,
>  			goto err;
>  	}
>  
> -	ret = xudma_navss_psil_pair(rx_chn->common.udmax,
> -				    rx_chn->common.src_thread,
> -				    rx_chn->common.dst_thread);
> -	if (ret) {
> -		dev_err(dev, "PSI-L request err %d\n", ret);
> -		goto err;
> -	}
> -
> -	rx_chn->psil_paired = true;
> -
> -	/* reset RX RT registers */
> -	k3_udma_glue_disable_rx_chn(rx_chn);
> -
>  	k3_udma_glue_dump_rx_chn(rx_chn);
>  
>  	return rx_chn;
> @@ -1052,12 +1045,24 @@ EXPORT_SYMBOL_GPL(k3_udma_glue_rx_flow_disable);
>  
>  int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
>  {
> +	int ret;
> +
>  	if (rx_chn->remote)
>  		return -EINVAL;
>  
>  	if (rx_chn->flows_ready < rx_chn->flow_num)
>  		return -EINVAL;
>  
> +	ret = xudma_navss_psil_pair(rx_chn->common.udmax,
> +				    rx_chn->common.src_thread,
> +				    rx_chn->common.dst_thread);
> +	if (ret) {
> +		dev_err(rx_chn->common.dev, "PSI-L request err %d\n", ret);
> +		return ret;
> +	}
> +
> +	rx_chn->psil_paired = true;
> +
>  	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
>  			    UDMA_CHAN_RT_CTL_EN);
>  
> @@ -1078,6 +1083,13 @@ void k3_udma_glue_disable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
>  	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG, 0);
>  
>  	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt dis2");
> +
> +	if (rx_chn->psil_paired) {
> +		xudma_navss_psil_unpair(rx_chn->common.udmax,
> +					rx_chn->common.src_thread,
> +					rx_chn->common.dst_thread);
> +		rx_chn->psil_paired = false;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(k3_udma_glue_disable_rx_chn);
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
