Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB589AF1
	for <lists+dmaengine@lfdr.de>; Mon, 12 Aug 2019 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfHLKKE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Aug 2019 06:10:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48496 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfHLKKE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Aug 2019 06:10:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7CA9rhU091302;
        Mon, 12 Aug 2019 05:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565604593;
        bh=UZRnkM5LvmQhJ973nCFgnIBPPkZUhy0vG2BKjcSREDU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OFqI8123VtOzyplXQHgfAaDINyZGQx4DKU5ymPOs5iKWU9CWweRQ3lx4iK/hJFvmj
         2lImSblZMp3Bs2oJbi2NRTR6RNNW8wko8EQ6l3cWCbZl9/4YBhusR3Xe60liZ4KCzU
         APpkW/AEHGXGSNqLl0kAjLQQhc4bAtrF1FlMjco4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7CA9rBb127011
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Aug 2019 05:09:53 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 12
 Aug 2019 05:09:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 12 Aug 2019 05:09:52 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7CA9pfA058659;
        Mon, 12 Aug 2019 05:09:51 -0500
Subject: Re: [PATCH] dma: ti: unexport filter functions
To:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190812093623.992757-1-arnd@arndb.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <650d280a-a13e-ffa3-9c55-d235ed6c0b16@ti.com>
Date:   Mon, 12 Aug 2019 13:10:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812093623.992757-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 12/08/2019 12.36, Arnd Bergmann wrote:
> The two filter functions are now marked stable, but still exported,
> which triggers a coming build-time check:
> 
> WARNING: "omap_dma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL_GPL
> WARNING: "edma_filter_fn" [vmlinux] is a static EXPORT_SYMBOL
> 
> Remove the unneeded exports as well, as originally intended.
> 
> Fixes: 9c71b9eb3cb2 ("dmaengine: omap-dma: make omap_dma_filter_fn private")
> Fixes: d2bfe7b5d182 ("dmaengine: edma: make edma_filter_fn private")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  drivers/dma/ti/edma.c     | 1 -
>  drivers/dma/ti/omap-dma.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index f2549ee3fb49..ea028388451a 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2540,7 +2540,6 @@ static bool edma_filter_fn(struct dma_chan *chan, void *param)
>  	}
>  	return match;
>  }
> -EXPORT_SYMBOL(edma_filter_fn);
>  
>  static int edma_init(void)
>  {
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index 49da402a1927..98b39bcb7b37 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1652,7 +1652,6 @@ static bool omap_dma_filter_fn(struct dma_chan *chan, void *param)
>  	}
>  	return false;
>  }
> -EXPORT_SYMBOL_GPL(omap_dma_filter_fn);
>  
>  static int omap_dma_init(void)
>  {
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
