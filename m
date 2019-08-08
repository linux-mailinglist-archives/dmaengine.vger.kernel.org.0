Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02C6861EB
	for <lists+dmaengine@lfdr.de>; Thu,  8 Aug 2019 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389950AbfHHMcu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 8 Aug 2019 08:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389844AbfHHMcu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 8 Aug 2019 08:32:50 -0400
Received: from localhost (unknown [122.178.245.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9807221882;
        Thu,  8 Aug 2019 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565267569;
        bh=BNYxO+QGsOJmepIZyTEOnjzDC3EiMvMVzQq44qehEVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwP4LnsKpnODzxFJI5W8gMNPUYVVAHmK2a+qDOEL0MMUWkhqdzEIyclw23+Avwjaa
         vZe/i+sH9fz2vsssosT1WxoIbC6o0u8XjZYxlWXNwHvbd3rcfVW/0ta1IBE7t2JF3U
         bhwUgD3phwq+WdDQPN+uTW2RNjMNUQeIWj8/8vbY=
Date:   Thu, 8 Aug 2019 18:01:37 +0530
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
Subject: Re: [PATCH 08/10] dmaengine: bcm2835: Document struct bcm2835_dmadev
Message-ID: <20190808123137.GV12733@vkoul-mobl.Dlink>
References: <cover.1564825752.git.lukas@wunner.de>
 <f2a812b579c0b99d7fadf61a30a6263a9cc19bc4.1564825752.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2a812b579c0b99d7fadf61a30a6263a9cc19bc4.1564825752.git.lukas@wunner.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-19, 12:10, Lukas Wunner wrote:
> Document the BCM2835 DMA driver's device data structure so that upcoming
> commits may add further members with proper kerneldoc.

Acked-by: Vinod Koul <vkoul@kernel.org>

> 
> Tested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Martin Sperl <kernel@martin.sperl.org>
> Cc: Florian Kauer <florian.kauer@koalo.de>
> ---
>  drivers/dma/bcm2835-dma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index a65514fcb7f2..14358faf3bff 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -37,6 +37,12 @@
>  #define BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED 14
>  #define BCM2835_DMA_CHAN_NAME_SIZE 8
>  
> +/**
> + * struct bcm2835_dmadev - BCM2835 DMA controller
> + * @ddev: DMA device
> + * @base: base address of register map
> + * @dma_parms: DMA parameters (to convey 1 GByte max segment size to clients)
> + */
>  struct bcm2835_dmadev {
>  	struct dma_device ddev;
>  	void __iomem *base;
> -- 
> 2.20.1

-- 
~Vinod
