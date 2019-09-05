Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81385A9C80
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 10:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfIEICU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 04:02:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49952 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbfIEICU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Sep 2019 04:02:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x85827F9038119;
        Thu, 5 Sep 2019 03:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567670527;
        bh=rsuS3KW8iGDkRX2+94qPa4U+P9JzBJ56k0nHSuoZiok=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aVYVkfqvx5jR+TjZksNEc96NMbpPQDsvRIT6QtkQYrFzwcyVtfMwxnoxp2CNh2jqv
         nINlDgU/8IYGMe7eOB6NBwOPO2Cop25MJbEpDQVTb6pf4mTLY1nuwbb2i/jMwUsNXZ
         o/L3jpP2qOA+qNXuK4yGTNfBpghWSmhuWa3BAHBY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x85827O5062575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Sep 2019 03:02:07 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 5 Sep
 2019 03:02:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 5 Sep 2019 03:02:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x85824RT111065;
        Thu, 5 Sep 2019 03:02:05 -0500
Subject: Re: [PATCH -next] dmaengine: ti: edma: remove unused code
To:     YueHaibing <yuehaibing@huawei.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>, <arnd@arndb.de>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190905060249.23928-1-yuehaibing@huawei.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <fb0b8690-e8c7-549c-b966-66d278dbe68a@ti.com>
Date:   Thu, 5 Sep 2019 11:02:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905060249.23928-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 05/09/2019 9.02, YueHaibing wrote:
> drivers/dma/ti/edma.c: In function edma_probe:
> drivers/dma/ti/edma.c:2252:11: warning:
>  variable off set but not used [-Wunused-but-set-variable]
> 
> 'off' is not used now, so remove it.

This reminds me that this whole in EDMA driver xbar handling is mostly
broken...

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/dma/ti/edma.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index ba7c4f0..54fd981 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2249,10 +2249,8 @@ static int edma_probe(struct platform_device *pdev)
>  {
>  	struct edma_soc_info	*info = pdev->dev.platform_data;
>  	s8			(*queue_priority_mapping)[2];
> -	int			i, off;
>  	const s16		(*rsv_slots)[2];
> -	const s16		(*xbar_chans)[2];
> -	int			irq;
> +	int			i, irq;
>  	char			*irq_name;
>  	struct resource		*mem;
>  	struct device_node	*node = pdev->dev.of_node;
> @@ -2349,14 +2347,6 @@ static int edma_probe(struct platform_device *pdev)
>  			edma_write_slot(ecc, i, &dummy_paramset);
>  	}
>  
> -	/* Clear the xbar mapped channels in unused list */
> -	xbar_chans = info->xbar_chans;
> -	if (xbar_chans) {
> -		for (i = 0; xbar_chans[i][1] != -1; i++) {
> -			off = xbar_chans[i][1];

originally we had
			clear_bits(off, 1, ecc->channel_unused);
here, but I have removed it for some reason with
1be5336bc7ba050ee07d352643bf4c01c513553c


> -		}
> -	}
> -
>  	irq = platform_get_irq_byname(pdev, "edma3_ccint");
>  	if (irq < 0 && node)
>  		irq = irq_of_parse_and_map(node, 0);
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
