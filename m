Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74B03AC2FA
	for <lists+dmaengine@lfdr.de>; Fri, 18 Jun 2021 07:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhFRF4u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Jun 2021 01:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbhFRF4u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Jun 2021 01:56:50 -0400
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEB8C061574;
        Thu, 17 Jun 2021 22:54:41 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4G5p673DZ7zQjgl;
        Fri, 18 Jun 2021 07:54:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id oASSPaYrde_i; Fri, 18 Jun 2021 07:54:35 +0200 (CEST)
Subject: Re: [PATCH 2/2] dmaengine: altera-msgdma: make response port optional
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1623898678.git.olivier.dautricourt@orolia.com>
 <8220756f2191ca08cb21702252d1f2d4f753a7f5.1623898678.git.olivier.dautricourt@orolia.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <b0218fe4-d2e8-40ab-88e8-5f44ec4ce8da@denx.de>
Date:   Fri, 18 Jun 2021 07:54:35 +0200
MIME-Version: 1.0
In-Reply-To: <8220756f2191ca08cb21702252d1f2d4f753a7f5.1623898678.git.olivier.dautricourt@orolia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.87 / 15.00 / 15.00
X-Rspamd-Queue-Id: 2A33317E8
X-Rspamd-UID: be2e0c
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17.06.21 21:53, Olivier Dautricourt wrote:
> The response slave port can be disabled in some configuration [1] and
> csr + MSGDMA_CSR_RESP_FILL_LEVEL will be 0 even if transfer has suceeded.
> We have to only rely on the interrupts in that scenario.
> This was tested on cyclone V with the controller resp port disabled.
> 
> [1] https://www.intel.com/content/www/us/en/programmable/documentation/sfo1400787952932.html
> 30.3.1.2
> 30.3.1.3
> 30.5.5
> 
> Fixes:
> https://forum.rocketboards.org/t/ip-msgdma-linux-driver/1919
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/dma/altera-msgdma.c | 37 ++++++++++++++++++++++++++-----------
>   1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index 0fe0676f8e1d..5a2c7573b692 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -691,10 +691,14 @@ static void msgdma_tasklet(struct tasklet_struct *t)
> 
>   	spin_lock_irqsave(&mdev->lock, flags);
> 
> -	/* Read number of responses that are available */
> -	count = ioread32(mdev->csr + MSGDMA_CSR_RESP_FILL_LEVEL);
> -	dev_dbg(mdev->dev, "%s (%d): response count=%d\n",
> -		__func__, __LINE__, count);
> +	if (mdev->resp) {
> +		/* Read number of responses that are available */
> +		count = ioread32(mdev->csr + MSGDMA_CSR_RESP_FILL_LEVEL);
> +		dev_dbg(mdev->dev, "%s (%d): response count=%d\n",
> +			__func__, __LINE__, count);
> +	} else {
> +		count = 1;
> +	}
> 
>   	while (count--) {
>   		/*
> @@ -703,8 +707,12 @@ static void msgdma_tasklet(struct tasklet_struct *t)
>   		 * have any real values, like transferred bytes or error
>   		 * bits. So we need to just drop these values.
>   		 */
> -		size = ioread32(mdev->resp + MSGDMA_RESP_BYTES_TRANSFERRED);
> -		status = ioread32(mdev->resp + MSGDMA_RESP_STATUS);
> +		if (mdev->resp) {
> +			size = ioread32(mdev->resp +
> +					MSGDMA_RESP_BYTES_TRANSFERRED);
> +			status = ioread32(mdev->resp +
> +					MSGDMA_RESP_STATUS);
> +		}
> 
>   		msgdma_complete_descriptor(mdev);
>   		msgdma_chan_desc_cleanup(mdev);
> @@ -757,14 +765,21 @@ static void msgdma_dev_remove(struct msgdma_device *mdev)
>   }
> 
>   static int request_and_map(struct platform_device *pdev, const char *name,
> -			   struct resource **res, void __iomem **ptr)
> +			   struct resource **res, void __iomem **ptr,
> +			   bool optional)
>   {
>   	struct resource *region;
>   	struct device *device = &pdev->dev;
> 
>   	*res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
>   	if (*res == NULL) {
> -		dev_err(device, "resource %s not defined\n", name);
> +		if (optional) {
> +			*ptr = NULL;
> +			dev_info(device, "optional resource %s not defined\n",
> +				 name);
> +			return 0;
> +		}
> +		dev_err(device, "mandatory resource %s not defined\n", name);
>   		return -ENODEV;
>   	}
> 
> @@ -805,17 +820,17 @@ static int msgdma_probe(struct platform_device *pdev)
>   	mdev->dev = &pdev->dev;
> 
>   	/* Map CSR space */
> -	ret = request_and_map(pdev, "csr", &dma_res, &mdev->csr);
> +	ret = request_and_map(pdev, "csr", &dma_res, &mdev->csr, false);
>   	if (ret)
>   		return ret;
> 
>   	/* Map (extended) descriptor space */
> -	ret = request_and_map(pdev, "desc", &dma_res, &mdev->desc);
> +	ret = request_and_map(pdev, "desc", &dma_res, &mdev->desc, false);
>   	if (ret)
>   		return ret;
> 
>   	/* Map response space */
> -	ret = request_and_map(pdev, "resp", &dma_res, &mdev->resp);
> +	ret = request_and_map(pdev, "resp", &dma_res, &mdev->resp, true);
>   	if (ret)
>   		return ret;
> 
> --
> 2.31.0.rc2
> 


Viele Grüße,
Stefan

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
