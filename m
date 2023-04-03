Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD946D52A1
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 22:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjDCUjF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjDCUjE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 16:39:04 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06E1BE1
        for <dmaengine@vger.kernel.org>; Mon,  3 Apr 2023 13:39:02 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jQl2pODDfvQQZjQl2pwJMT; Mon, 03 Apr 2023 22:26:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1680553590;
        bh=i7Lyw2OrRszW29de0LtEKwp3rNTIdn65NavbOlZqjGI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ZnpuwGd7BBB5gPAgJ1Tqd2mAyIHerqjV+3Qib1/HF89S8O+iksWI+cPO+kHb3uSQa
         svJRWuuDinFIFgWNhgX3aZzfQ6HckzEzQZa4R2N+DVI5DAX2dd3csvRfFR2CN0lDFm
         3NseoekMVMrx0x5aBT95aVckSL8oA9r19/Fysn7bHhZwLxkhaELTEcvuBP+6yLDEzf
         Xz++3R0LXVPSeDXVIJ3x7Wka78JLoiwdxx/cGTgVJGZLk6NB/y5jEfn4DjbZpR6rqR
         nkj8o9JJuHDMksJmFOycVB2J7VWT5HeZpZ7akXRuya8ZO5m5p0fgiOWH94YiRh9EGG
         SpQkRrVqoUaoA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Apr 2023 22:26:30 +0200
X-ME-IP: 86.243.2.178
Message-ID: <83cb23dd-9c42-b7fe-c859-c453556d1a27@wanadoo.fr>
Date:   Mon, 3 Apr 2023 22:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Content-Language: fr
To:     Kelvin Cao <kelvin.cao@microchip.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     logang@deltatee.com, george.ge@microchip.com
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
 <20230403180630.4186061-2-kelvin.cao@microchip.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230403180630.4186061-2-kelvin.cao@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 03/04/2023 à 20:06, Kelvin Cao a écrit :
> Some Switchtec Switches can expose DMA engines via extra PCI functions
> on the upstream ports. At most one such function can be supported on
> each upstream port. Each function can have one or more DMA channels.
> 
> Implement core PCI driver skeleton and register DMA engine callbacks.
> 
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> ---
>   MAINTAINERS                 |    5 +
>   drivers/dma/Kconfig         |    9 +
>   drivers/dma/Makefile        |    1 +
>   drivers/dma/switchtec_dma.c | 1734 +++++++++++++++++++++++++++++++++++
>   4 files changed, 1749 insertions(+)
>   create mode 100644 drivers/dma/switchtec_dma.c
> 

Hi,
just a few nit, should you find them useful.

[...]

> +static void switchtec_dma_process_desc(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct device *chan_dev = to_chan_dev(swdma_chan);
> +	struct dmaengine_result res;
> +	struct switchtec_dma_desc *desc;
> +	struct switchtec_dma_hw_ce *ce;
> +	__le16 phase_tag;
> +	int tail;
> +	int cid;
> +	int se_idx;
> +	u32 sts_code;
> +	int i = 0;

No need to init.

[...]

> +static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +	struct pci_dev *pdev;
> +	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
> +	size_t size;
> +	struct switchtec_dma_desc *desc;
> +	int rc;
> +	int i;
> +
> +	swdma_chan->head = swdma_chan->tail = 0;
> +	swdma_chan->cq_tail = 0;
> +
> +	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
> +	swdma_chan->hw_sq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_sq,
> +					       GFP_KERNEL);
> +	if (!swdma_chan->hw_sq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
> +	swdma_chan->hw_cq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_cq,
> +					       GFP_KERNEL);
> +	if (!swdma_chan->hw_cq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	memset(swdma_chan->hw_cq, 0, size);

The memory allocated with dma_alloc_coherent() is already zeroed.

> +
> +	/* reset host phase tag */
> +	swdma_chan->phase_tag = 0;
> +
> +	size = sizeof(*swdma_chan->desc_ring);
> +	swdma_chan->desc_ring = kcalloc(SWITCHTEC_DMA_RING_SIZE, size,
> +					GFP_KERNEL);
> +	if (!swdma_chan->desc_ring) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	memset(swdma_chan->desc_ring, 0, SWITCHTEC_DMA_RING_SIZE * size);

This is already kcalloc()'ed.

CJ
