Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F49861D2
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbfHHMbu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 08:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388074AbfHHMbu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 08:31:50 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4412A2171F;
        Thu,  8 Aug 2019 12:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267509;
        bh=no8Z2TWvxtdO0AkNksYnl5gAnrXUzVQmXM/gE+1GRwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njrxibfmaFyoHPFw13lO9rW/RGnZdFvabBF+68purdAvtGTbYMVK6MpIm8XsN6nBM
         Q+zbVkAlKsYlfMwrwI1Kv93EI0rQh+blw69rPTQyEI2vk1yPMjgji6VTdlc8E06jzd
         GA+GCz2RTR+B8zmlh9R86HZdZgqNbpPfkkjLHVgk=
Date:   Thu, 8 Aug 2019 18:00:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
        linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Noralf Tronnes <noralf@tronnes.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 01/10] dmaengine: bcm2835: Allow reusable descriptors
Message-ID: <20190808123036.GT12733@vkoul-mobl.Dlink>
References: <cover.1564825752.git.lukas@wunner.de>
 <7b67f8d95154d25b3a360f580f1ca61f83f79a6f.1564825752.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b67f8d95154d25b3a360f580f1ca61f83f79a6f.1564825752.git.lukas@wunner.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-19, 12:10, Lukas Wunner wrote:
> The DMA engine API requires DMA drivers to explicitly allow that
> descriptors are prepared once and reused multiple times. Only a
> single driver makes use of this functionality so far (pxa_dma.c,
> to speed up pxa_camera.c).
> 
> We're about to add another use case for reusable descriptors in
> the BCM2835 SPI driver, so allow that in the BCM2835 DMA driver.

Acked-by: Vinod Koul <vkoul@kernel.org>

> 
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Martin Sperl <kernel@martin.sperl.org>
> Cc: Florian Kauer <florian.kauer@koalo.de>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  drivers/dma/bcm2835-dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 8101ff2f05c1..523c507ad69e 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -907,6 +907,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>  	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
>  			      BIT(DMA_MEM_TO_MEM);
>  	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> +	od->ddev.descriptor_reuse = true;
>  	od->ddev.dev = &pdev->dev;
>  	INIT_LIST_HEAD(&od->ddev.channels);
>  
> -- 
> 2.20.1

-- 
~Vinod
