Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96CD8FC31
	for <lists+dmaengine@lfdr.de>; Fri, 16 Aug 2019 09:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfHPHW7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Aug 2019 03:22:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40028 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPHWw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Aug 2019 03:22:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7G7MSq6069050;
        Fri, 16 Aug 2019 02:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565940148;
        bh=769mRvMaqWMjfKMLHVtt3D58PyPf5Cng9PJibBI4dM0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=G99W94Vl1w/nHqfCTX0vhXvYYoW53uNvyequAqaj4LTkAI9PY32LtQ1oRzyxlUqg9
         7rsPmWGIDlXNyeZdKKYdCl8Ukzq1VAB0D390zO4afh3OlkjANUBQnpjaDagsTGW//s
         kdOQRCRyAcLv3KrertPLr8V1NSKSqdHS/bepCHRo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7G7MRGh090486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Aug 2019 02:22:28 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 16
 Aug 2019 02:22:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 16 Aug 2019 02:22:26 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7G7MO3s104401;
        Fri, 16 Aug 2019 02:22:24 -0500
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Add cleanup in omap_dma_probe()
To:     Wenwen Wang <wenwen@cs.uga.edu>
CC:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1565938570-7528-1-git-send-email-wenwen@cs.uga.edu>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2e9382ff-1940-2247-4335-a5c1229d2cee@ti.com>
Date:   Fri, 16 Aug 2019 10:22:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565938570-7528-1-git-send-email-wenwen@cs.uga.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 16/08/2019 9.56, Wenwen Wang wrote:
> If devm_request_irq() fails to disable all interrupts, no cleanup is
> performed before retuning the error. To fix this issue, invoke
> omap_dma_free() to do the cleanup.

Thank you,
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/dma/ti/omap-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index ba2489d..5158b58 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1540,8 +1540,10 @@ static int omap_dma_probe(struct platform_device *pdev)
>  
>  		rc = devm_request_irq(&pdev->dev, irq, omap_dma_irq,
>  				      IRQF_SHARED, "omap-dma-engine", od);
> -		if (rc)
> +		if (rc) {
> +			omap_dma_free(od);
>  			return rc;
> +		}
>  	}
>  
>  	if (omap_dma_glbl_read(od, CAPS_0) & CAPS_0_SUPPORT_LL123)
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
