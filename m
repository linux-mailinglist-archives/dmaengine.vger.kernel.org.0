Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01A713507
	for <lists+dmaengine@lfdr.de>; Sat, 27 May 2023 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjE0Ndj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 May 2023 09:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjE0Ndf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 May 2023 09:33:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FAEC7
        for <dmaengine@vger.kernel.org>; Sat, 27 May 2023 06:33:33 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2u30qrIVmzb8g2u30qXXuD; Sat, 27 May 2023 15:33:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685194411;
        bh=ZekJBpLbvRDV+pupe8smicp3xo3j37TDAGexIIAQHTg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dcYQhOtVKX/FRn30RGF2cfSk5cbQx1Oq+kHdAMB6A/IsrfrWhXIsHmMNjNwANLzsA
         XTxD3NB2MLqw5Xk3MouDwaMPpuHPWHbVC8x4qtFR+awceiFpiwnlWLTws91FDe+ILR
         A5GcwJh2PDDPFjhTRku3Uh41MNvxxtJTOAHj2Wd4vzqS5uLxA4N29ymnFPofOEz7zI
         RjS9kMPIw1kzGDkTHPQST3YTfnt7+qQD5eRQyDlKJ+0O5Zw8qd31/JSi0P/RoMWxH/
         JkkTC88rMSeqmxUbyhOGx1go1uFpy7gremjpn7qSfsWiGuz6AUURPcW0ZaxqExhhvR
         AmhNAfNPAIO0g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 May 2023 15:33:31 +0200
X-ME-IP: 86.243.2.178
Message-ID: <41f58a00-1ab5-3eae-0e32-0f6e05282cf1@wanadoo.fr>
Date:   Sat, 27 May 2023 15:33:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V1 QDMA 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
Content-Language: fr
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nishad Saraf <nishads@amd.com>, max.zhen@amd.com,
        sonal.santan@amd.com, nishad.saraf@amd.com
References: <1685119795-11729-1-git-send-email-lizhi.hou@amd.com>
 <1685119795-11729-2-git-send-email-lizhi.hou@amd.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1685119795-11729-2-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 26/05/2023 à 18:49, Lizhi Hou a écrit :
> From: Nishad Saraf <nishads@amd.com>
> 
> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
> Accelerator devices.
>      https://www.xilinx.com/applications/data-center/v70.html
> 
> The primary mechanism to transfer data using the QDMA is for the QDMA
> engine to operate on instructions (descriptors) provided by the host
> operating system. Using the descriptors, the QDMA can move data in both
> the Host to Card (H2C) direction, or the Card to Host (C2H) direction.
> The QDMA provides a per-queue basis option whether DMA traffic goes
> to an AXI4 memory map (MM) interface or to an AXI4-Stream interface.
> 
> The hardware detail is provided by
>      https://docs.xilinx.com/r/en-US/pg302-qdma
> 
> Implements dmaengine APIs to support MM DMA transfers.
> - probe the available DMA channels
> - use dma_slave_map for channel lookup
> - use virtual channel to manage dmaengine tx descriptors
> - implement device_prep_slave_sg callback to handle host scatter gather
>    list
> - implement descriptor metadata operations to set device address for DMA
>    transfer
> 
> Signed-off-by: Nishad Saraf <nishads@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---

[...]

> +/**
> + * qdma_alloc_queue_resources() - Allocate queue resources
> + * @chan: DMA channel
> + */
> +static int qdma_alloc_queue_resources(struct dma_chan *chan)
> +{
> +	struct qdma_queue *queue = to_qdma_queue(chan);
> +	struct qdma_device *qdev = queue->qdev;
> +	struct qdma_ctxt_sw_desc desc;
> +	size_t size;
> +	int ret;
> +
> +	ret = qdma_clear_queue_context(queue);
> +	if (ret)
> +		return ret;
> +
> +	size = queue->ring_size * QDMA_MM_DESC_SIZE;
> +	queue->desc_base = dma_alloc_coherent(qdev->dma_dev.dev, size,
> +					      &queue->dma_desc_base,
> +					      GFP_KERNEL | __GFP_ZERO);

Nit: Useless (but harmless).
AFAIK, dma_alloc_coherent() always returned some zeroed memory.
(should you remove the __GFP_ZERO, there is another usage below)

> +	if (!queue->desc_base) {
> +		qdma_err(qdev, "Failed to allocate descriptor ring");
> +		return -ENOMEM;
> +	}
> +

[...]

> +/**
> + * struct qdma_platdata - Platform specific data for QDMA engine
> + * @max_mm_channels: Maximum number of MM DMA channels in each direction
> + * @device_map: DMA slave map
> + * @irq_index: The index of first IRQ
> + */
> +struct qdma_platdata {
> +	u32			max_mm_channels;
> +	struct dma_slave_map	*device_map;
> +	u32			irq_index;
> +};

Noob question: this struct is only retrieved from dev_get_platdata(), 
but there is no dev_set_platdata().
How the link is done? How this structure is filled?


Should it mater, keeping the 2 u32 one after the other, would avoid a hole.

CJ

> +
> +#endif /* _PLATDATA_AMD_QDMA_H */

