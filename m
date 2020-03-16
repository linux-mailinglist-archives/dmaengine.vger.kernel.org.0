Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23779186584
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2020 08:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgCPHUr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Mar 2020 03:20:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33044 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgCPHUr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Mar 2020 03:20:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02G7KhLg012845;
        Mon, 16 Mar 2020 02:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584343243;
        bh=Yisa4qZBXogsjsu0UBUCrwgSHPoybqOn38y9aI+oMAQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cThaAheyHJ+EAotUZu9KeHnIO+DWyRdUTC6rVjqSrE+ScMlFRGn3F4x2XRkXJQABq
         EdHCiLd6GigEA84MMDEwswrCIaWRitdgsaOB6XsqE7qmDBa/ImOgzwqQvR06O8HnwY
         SR65BEC+q7sTETLFTR+Q66jbuoYtIDZed9oT9RE0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02G7KhTi112724
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Mar 2020 02:20:43 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 02:20:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 02:20:42 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02G7KepR117384;
        Mon, 16 Mar 2020 02:20:41 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Fix an error handling path in
 'k3_udma_glue_cfg_rx_flow()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <grygorii.strashko@ti.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20200315155015.27303-1-christophe.jaillet@wanadoo.fr>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <49a35126-3cc6-0cbb-e632-42a237ef353e@ti.com>
Date:   Mon, 16 Mar 2020 09:20:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200315155015.27303-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Christophe,

On 15/03/2020 17.50, Christophe JAILLET wrote:
> All but one error handling paths in the 'k3_udma_glue_cfg_rx_flow()'
> function 'goto err' and call 'k3_udma_glue_release_rx_flow()'.
> 
> This not correct because this function has a 'channel->flows_ready--;' at
> the end, but 'flows_ready' has not been incremented here, when we branch to
> the error handling path.
> 
> In order to keep a correct value in 'flows_ready', un-roll
> 'k3_udma_glue_release_rx_flow()', simplify it, add some labels and branch
> at the correct places when an error is detected.

Good catch!

> Doing so, we also NULLify 'flow->udma_rflow' in a path that was lacking it.

Even better catch ;)

> Fixes: d70241913413 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine user")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure that the last point of the description is correct. Maybe, the
> 'xudma_rflow_put / return -ENODEV;' should be kept in order not to
> override 'flow->udma_rflow'.
> ---
>  drivers/dma/ti/k3-udma-glue.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index dbccdc7c0ed5..890573eb1625 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -578,12 +578,12 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  	if (IS_ERR(flow->udma_rflow)) {
>  		ret = PTR_ERR(flow->udma_rflow);
>  		dev_err(dev, "UDMAX rflow get err %d\n", ret);
> -		goto err;
> +		goto err_return;

return err; ?

>  	}

Optionally you could have moved the
	rx_chn->flows_ready++;
here and

>  
>  	if (flow->udma_rflow_id != xudma_rflow_get_id(flow->udma_rflow)) {
> -		xudma_rflow_put(rx_chn->common.udmax, flow->udma_rflow);
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_rflow_put;

goto err;

>  	}
>  
>  	/* request and cfg rings */
> @@ -592,7 +592,7 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  	if (!flow->ringrx) {
>  		ret = -ENODEV;
>  		dev_err(dev, "Failed to get RX ring\n");
> -		goto err;
> +		goto err_rflow_put;
>  	}
>  
>  	flow->ringrxfdq = k3_ringacc_request_ring(rx_chn->common.ringacc,
> @@ -600,19 +600,19 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  	if (!flow->ringrxfdq) {
>  		ret = -ENODEV;
>  		dev_err(dev, "Failed to get RXFDQ ring\n");
> -		goto err;
> +		goto err_ringrx_free;
>  	}
>  
>  	ret = k3_ringacc_ring_cfg(flow->ringrx, &flow_cfg->rx_cfg);
>  	if (ret) {
>  		dev_err(dev, "Failed to cfg ringrx %d\n", ret);
> -		goto err;
> +		goto err_ringrxfdq_free;
>  	}
>  
>  	ret = k3_ringacc_ring_cfg(flow->ringrxfdq, &flow_cfg->rxfdq_cfg);
>  	if (ret) {
>  		dev_err(dev, "Failed to cfg ringrxfdq %d\n", ret);
> -		goto err;
> +		goto err_ringrxfdq_free;
>  	}
>  
>  	if (rx_chn->remote) {
> @@ -662,7 +662,7 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  	if (ret) {
>  		dev_err(dev, "flow%d config failed: %d\n", flow->udma_rflow_id,
>  			ret);
> -		goto err;
> +		goto err_ringrxfdq_free;
>  	}
>  
>  	rx_chn->flows_ready++;
> @@ -670,8 +670,18 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
>  		flow->udma_rflow_id, rx_chn->flows_ready);
>  
>  	return 0;
> -err:
> -	k3_udma_glue_release_rx_flow(rx_chn, flow_idx);
> +
> +err_ringrxfdq_free:
> +	k3_ringacc_ring_free(flow->ringrxfdq);
> +
> +err_ringrx_free:
> +	k3_ringacc_ring_free(flow->ringrx);
> +
> +err_rflow_put:
> +	xudma_rflow_put(rx_chn->common.udmax, flow->udma_rflow);
> +	flow->udma_rflow = NULL;
> +
> +err_return:

You could have kept the single err label and just copy the
release_rx_flow() without the rx_chn->flows_ready--;

I don't have anything against multiple labels as such, but a single one
might be easier to follow?

and you don't need the err_return, just return in place when you would
jump to it.

>  	return ret;
>  }
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
