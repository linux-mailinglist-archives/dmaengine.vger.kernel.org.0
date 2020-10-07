Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99422858CE
	for <lists+dmaengine@lfdr.de>; Wed,  7 Oct 2020 08:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgJGGxL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 7 Oct 2020 02:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJGGxK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 7 Oct 2020 02:53:10 -0400
Received: from localhost (unknown [122.171.222.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E2E20797;
        Wed,  7 Oct 2020 06:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602053589;
        bh=WnCyc7OlZxbrj4ooSfvmm2cyBE+u5+4ecYnYdEioJ5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jH04N95LiL9SC7lL5ocCE3Bv68tKklB00kTumCRPl6x4PHGbNv+acOvCODjj8bdq8
         Oimv2htRf8ZyrnCaad5EdTMVAQpy8YfbiUc5R/4IkVsfYJZr1PbktQUVy+W3Rf7GG7
         y5LMeKN+Ymqnz90N7EjPMJh++fkupnSRc5WvJ4a4=
Date:   Wed, 7 Oct 2020 12:23:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     nm@ti.com, ssantosh@kernel.org, robh+dt@kernel.org,
        vigneshr@ti.com, dan.j.williams@intel.com, t-kristo@ti.com,
        lokeshvutla@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 07/18] dmaengine: ti: k3-udma-glue: Add function to get
 device pointer for DMA API
Message-ID: <20201007065305.GS2968@vkoul-mobl>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
 <20200930091412.8020-8-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930091412.8020-8-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-09-20, 12:14, Peter Ujfalusi wrote:
> Glue layer users should use the device of the DMA for DMA mapping and
> allocations as it is the DMA which accesses to descriptors and buffers,
> not the clients
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/k3-udma-glue.c    | 14 ++++++++++++++
>  drivers/dma/ti/k3-udma-private.c |  6 ++++++
>  drivers/dma/ti/k3-udma.h         |  1 +
>  include/linux/dma/k3-udma-glue.h |  4 ++++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
> index a367584f0d7b..a53bc4707ae8 100644
> --- a/drivers/dma/ti/k3-udma-glue.c
> +++ b/drivers/dma/ti/k3-udma-glue.c
> @@ -487,6 +487,13 @@ int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn)
>  }
>  EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_irq);
>  
> +struct device *
> +	k3_udma_glue_tx_get_dma_device(struct k3_udma_glue_tx_channel *tx_chn)

How about..

struct device *
k3_udma_glue_tx_get_dma_device(struct k3_udma_glue_tx_channel *tx_chn)

> +{
> +	return xudma_get_device(tx_chn->common.udmax);
> +}
> +EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_dma_device);

Hmm why would you need to export this device.. Can you please outline
all the devices involved here... why not use dmaI_dev->dev or chan->dev?

-- 
~Vinod
