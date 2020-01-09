Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC394135CD7
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jan 2020 16:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgAIPdG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jan 2020 10:33:06 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59228 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgAIPdG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jan 2020 10:33:06 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 009FWboh087565;
        Thu, 9 Jan 2020 09:32:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578583957;
        bh=h79SPesTP89Bd/9Wxuz3O1MvY9E6XrP9j9+XkSkOLpo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AbN/cbVRmNYp+RfnvbDdjxg5AA0oVtQQFTzNuadNepLb9E03N9H+1MBPMb+MKRgY4
         bWJRJD9I0JNswiRHZ1xFKvGf45YqEUvNCYVydDnENoMzl/QFlJtwEm5iBV46wEgPv8
         NONZkGcXPu5IeGSKd+aqn/wjiu3Q2ESu3m0saufM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 009FWbdE128208
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Jan 2020 09:32:37 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Jan
 2020 09:32:37 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Jan 2020 09:32:37 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 009FWZQP062444;
        Thu, 9 Jan 2020 09:32:35 -0600
Subject: Re: [PATCH][next][V2] dmaengine: ti: omap-dma: don't allow a null
 od->plat pointer to be dereferenced
To:     Colin King <colin.king@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Lindgren <tony@atomide.com>, <dmaengine@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200109131953.157154-1-colin.king@canonical.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7e396a66-41d0-ace8-41b5-1018e6d9d095@ti.com>
Date:   Thu, 9 Jan 2020 17:33:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109131953.157154-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Colin,

On 09/01/2020 15.19, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the call to dev_get_platdata returns null the driver issues
> a warning and then later dereferences the null pointer.  Avoid this issue
> by returning -ENODEV errror rather when the platform data is null and
> change the warning to an appropriate error message.

Thank you for the update!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Addresses-Coverity: ("Dereference after null check")
> Fixes: 211010aeb097 ("dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: return -ENODEV and change warning to an error message as suggested by
>     Peter Ujfalusi.
> ---
>  drivers/dma/ti/omap-dma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index fc8f7b2fc7b3..a93515015dce 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1658,8 +1658,10 @@ static int omap_dma_probe(struct platform_device *pdev)
>  	if (conf) {
>  		od->cfg = conf;
>  		od->plat = dev_get_platdata(&pdev->dev);
> -		if (!od->plat)
> -			dev_warn(&pdev->dev, "no sdma auxdata needed?\n");
> +		if (!od->plat) {
> +			dev_err(&pdev->dev, "omap_system_dma_plat_info is missing");
> +			return -ENODEV;
> +		}
>  	} else {
>  		od->cfg = &default_cfg;
>  
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
