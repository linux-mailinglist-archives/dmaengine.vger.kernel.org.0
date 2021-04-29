Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C936E460
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 07:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhD2FDl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 01:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2FDl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Apr 2021 01:03:41 -0400
X-Greylist: delayed 83060 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Apr 2021 22:02:55 PDT
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D0FC06138B;
        Wed, 28 Apr 2021 22:02:55 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4FW3KS5JnrzQjgN;
        Thu, 29 Apr 2021 07:02:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id e9jBU4Mh4T8p; Thu, 29 Apr 2021 07:02:49 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] drivers: dma: altera-msgdma: add OF support
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YIn02rUOMrDoBTHx@orolia.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <ce40085b-1956-63eb-c339-3020e710863a@denx.de>
Date:   Thu, 29 Apr 2021 07:02:48 +0200
MIME-Version: 1.0
In-Reply-To: <YIn02rUOMrDoBTHx@orolia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.09 / 15.00 / 15.00
X-Rspamd-Queue-Id: A824617CF
X-Rspamd-UID: 513208
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29.04.21 01:50, Olivier Dautricourt wrote:
> This driver had no device tree support.
> 
> - add compatible field "altr,msgdma"
> - define msgdma_of_xlate, with no argument
> - register dma controller with of_dma_controller_register
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> ---
>   drivers/dma/altera-msgdma.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 9a841ce5f0c5..2b062d5aa636 100644
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
> @@ -784,6 +785,16 @@ static int request_and_map(struct platform_device *pdev, const char *name,
>   	return 0;
>   }
> 
> +#ifdef CONFIG_OF
> +static struct dma_chan *msgdma_of_xlate(struct of_phandle_args *dma_spec,
> +					struct of_dma *ofdma)
> +{
> +	struct msgdma_device *d = ofdma->of_dma_data;
> +
> +	return dma_get_any_slave_channel(&d->dmadev);
> +}
> +#endif

To avoid the ugly #ifdef's, could you add this function unconditionally
and ...

> +
>   /**
>    * msgdma_probe - Driver probe function
>    * @pdev: Pointer to the platform_device structure
> @@ -888,6 +899,14 @@ static int msgdma_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto fail;
> 
> +#ifdef CONFIG_OF
> +	ret = of_dma_controller_register(pdev->dev.of_node, msgdma_of_xlate,
> +					 mdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to register dma controller");
> +		goto fail;
> +	}
> +#endif

... use:

	if (IS_ENABLED(CONFIG_OF)) {
		ret = of_dma_controller_register(pdev->dev.of_node,
		...

here?

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

I think this also can be included unconditionally.

Thanks,
Stefan

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
