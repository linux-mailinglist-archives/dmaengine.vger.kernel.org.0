Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A30B36F76D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Apr 2021 10:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhD3I46 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Apr 2021 04:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhD3I45 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Apr 2021 04:56:57 -0400
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A80C06174A;
        Fri, 30 Apr 2021 01:56:09 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4FWmS75rt0zQjwd;
        Fri, 30 Apr 2021 10:56:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 9F8beDW6lYQs; Fri, 30 Apr 2021 10:56:04 +0200 (CEST)
Subject: Re: [PATCH v4 2/2] drivers: dma: altera-msgdma: add OF support
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YIrAJce3Ej8hNbkA@orolia.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <5377361b-5602-1c03-04be-384f06150240@denx.de>
Date:   Fri, 30 Apr 2021 10:56:04 +0200
MIME-Version: 1.0
In-Reply-To: <YIrAJce3Ej8hNbkA@orolia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -5.03 / 15.00 / 15.00
X-Rspamd-Queue-Id: CAD9E1857
X-Rspamd-UID: f04d74
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29.04.21 16:18, Olivier Dautricourt wrote:
> This driver had no device tree support.
> 
> - add compatible field "altr,msgdma"
> - define msgdma_of_xlate, with no argument
> - register dma controller with of_dma_controller_register
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
> Notes:
>      Changes in v2:
>      	none
> 
>      Changes from v2 to v3:
>      	Removed CONFIG_OF #ifdef's and use if (IS_ENABLED(CONFIG_OF))
>      	only once.
> 
>      Changes from v3 to v4
>      	Reintroduce #ifdef CONFIG_OF for msgdma_match
>      	as it produces a unused variable warning
> 
>   drivers/dma/altera-msgdma.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 9a841ce5f0c5..7e58385facef 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -19,6 +19,7 @@
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
> +#include <linux/of_dma.h>
> 
>   #include "dmaengine.h"
> 
> @@ -784,6 +785,14 @@ static int request_and_map(struct platform_device *pdev, const char *name,
>   	return 0;
>   }
> 
> +static struct dma_chan *msgdma_of_xlate(struct of_phandle_args *dma_spec,
> +					struct of_dma *ofdma)
> +{
> +	struct msgdma_device *d = ofdma->of_dma_data;
> +
> +	return dma_get_any_slave_channel(&d->dmadev);
> +}
> +
>   /**
>    * msgdma_probe - Driver probe function
>    * @pdev: Pointer to the platform_device structure
> @@ -888,6 +897,16 @@ static int msgdma_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto fail;
> 
> +	if (IS_ENABLED(CONFIG_OF)) {
> +		ret = of_dma_controller_register(pdev->dev.of_node,
> +						 msgdma_of_xlate, mdev);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"failed to register dma controller");
> +			goto fail;
> +		}
> +	}
> +
>   	dev_notice(&pdev->dev, "Altera mSGDMA driver probe success\n");
> 
>   	return 0;
> @@ -916,9 +935,19 @@ static int msgdma_remove(struct platform_device *pdev)
>   	return 0;
>   }
> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id msgdma_match[] = {
> +	{ .compatible = "altr,msgdma",},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, msgdma_match);
> +#endif
> +
>   static struct platform_driver msgdma_driver = {
>   	.driver = {
>   		.name = "altera-msgdma",
> +		.of_match_table = of_match_ptr(msgdma_match),
>   	},
>   	.probe = msgdma_probe,
>   	.remove = msgdma_remove,
> --
> 2.31.0.rc2
> 


Viele Grüße,
Stefan

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
