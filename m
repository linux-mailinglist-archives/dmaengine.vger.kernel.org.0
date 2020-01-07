Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B94132579
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jan 2020 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgAGL7j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Jan 2020 06:59:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54754 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGL7j (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Jan 2020 06:59:39 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 007BxVZp039432;
        Tue, 7 Jan 2020 05:59:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578398371;
        bh=9f+EURYDVK8DvqsdPDWz6PKR3Gmyc0NgzwaKz2rZZqc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k7CraodJJAgLom/FV7vcp7q6wpkNFj4haAqS6Aj+H4+UHXCCjQ6Dbs7VT9TN+kmQn
         ueQv0e9MhunDK9gaFN8FeYTsGOScPbkpggjcV75oMVKaxctL37GVb9/VR4e2m50jgx
         fjk655GpjMOkec1DpOi3dzhA1aSfaUtffuFHmsgo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 007BxVTD124337
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 05:59:31 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 05:59:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 05:59:30 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 007BxSIe032947;
        Tue, 7 Jan 2020 05:59:29 -0600
Subject: Re: [PATCH][next] dmaengine: ti: omap-dma: don't allow a null
 od->plat pointer to be dereferenced
To:     Colin King <colin.king@canonical.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <dmaengine@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200106122325.39121-1-colin.king@canonical.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b7200998-c8e7-0841-ce91-ad3834c63cae@ti.com>
Date:   Tue, 7 Jan 2020 13:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106122325.39121-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Colin,

On 06/01/2020 14.23, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to dev_get_platdata returns null the driver issues
> a warning and then later dereferences the null pointer.  Avoid this issue
> by returning -EPROBE_DEFER errror rather when the platform data is null.

Thank you for noticing it!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Addresses-Coverity: ("Dereference after null check")
> Fixes: 211010aeb097 ("dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/dma/ti/omap-dma.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index fc8f7b2fc7b3..335c3fa7a3b1 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1658,8 +1658,10 @@ static int omap_dma_probe(struct platform_device *pdev)
>  	if (conf) {
>  		od->cfg = conf;
>  		od->plat = dev_get_platdata(&pdev->dev);
> -		if (!od->plat)
> +		if (!od->plat) {
>  			dev_warn(&pdev->dev, "no sdma auxdata needed?\n");
> +			return -EPROBE_DEFER;
> +		}
>  	} else {
>  		od->cfg = &default_cfg;
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
