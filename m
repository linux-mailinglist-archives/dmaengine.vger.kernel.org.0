Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A24B6A89
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 12:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiBOLUO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 06:20:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiBOLUN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 06:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F343B107D0A;
        Tue, 15 Feb 2022 03:20:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F703B81865;
        Tue, 15 Feb 2022 11:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FD0C340EB;
        Tue, 15 Feb 2022 11:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644924000;
        bh=aFIOgqLZexary/dFYQLCQIRP60BMTQuD0XQjNtS918k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nY5S7C8Em5JwPpJdw+HLrhkCwl3MdommenOASOzImKjq7UnilvDkiWK73086l6mAd
         r4qzanzxmkSOfvI98f+loqTgREQCw5bP302lqD7/gcM3bBNxhHS1NjjY1p6APCgij3
         CW3sIVpe4x4QdmtxmjQhpn3Yi3oPkr33GRTziUm2pgS4EQnjER5p+gPYoNI/mX9TWB
         6AyJ95O5dM4YQTCRJ6mVRdWEARaNj9lzf30qntEXB8gUxDhSkBNtXO9mII0kK1om4u
         LB0C3ObekuqFldLcwNDw5K6XhBqpjxbxKgmoKFSNx7Gjg6bY2Mq8lYid0yguF9e++6
         wW7ey/AhNH0Vw==
Date:   Tue, 15 Feb 2022 16:49:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Wunner <lukas@wunner.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 10/11] dmaengine: bcm2835: add BCM2711 40-bit DMA
 support
Message-ID: <YguMW8n1q0ZV5tKH@matsya>
References: <1640606812-11110-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640606812-11110-1-git-send-email-stefan.wahren@i2se.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-12-21, 13:06, Stefan Wahren wrote:
> BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
> to access the full 4GB of memory on a Pi 4. Assume every channel is capable
> of 40-bit address range.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/dma/bcm2835-dma.c | 243 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 243 insertions(+)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 7159fa2..83343f9 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -36,6 +36,7 @@
>  
>  #define BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED 14
>  #define BCM2835_DMA_CHAN_NAME_SIZE 8
> +#define BCM2711_DMA40_PHYS_ADDR 0x400000000ULL
>  
>  /**
>   * struct bcm2835_dmadev - BCM2835 DMA controller
> @@ -65,6 +66,17 @@ struct bcm2835_dma_cb {
>  	uint32_t pad[2];
>  };
>  
> +struct bcm2711_dma40_scb {
> +	uint32_t ti;
> +	uint32_t src;
> +	uint32_t srci;
> +	uint32_t dst;
> +	uint32_t dsti;
> +	uint32_t len;
> +	uint32_t next_cb;
> +	uint32_t rsvd;
> +};
> +
>  struct bcm2835_cb_entry {
>  	struct bcm_dma_cb *cb;
>  	dma_addr_t paddr;
> @@ -205,6 +217,49 @@ struct bcm2835_desc {
>  #define BCM2835_DMA_CHAN(n)	((n) << 8) /* Base address */
>  #define BCM2835_DMA_CHANIO(base, n) ((base) + BCM2835_DMA_CHAN(n))
>  
> +/* 40-bit DMA support */
> +#define BCM2711_DMA40_CS	0x00
> +#define BCM2711_DMA40_CB	0x04
> +#define BCM2711_DMA40_DEBUG	0x0c
> +#define BCM2711_DMA40_TI	0x10
> +#define BCM2711_DMA40_SRC	0x14
> +#define BCM2711_DMA40_SRCI	0x18
> +#define BCM2711_DMA40_DEST	0x1c
> +#define BCM2711_DMA40_DESTI	0x20
> +#define BCM2711_DMA40_LEN	0x24
> +#define BCM2711_DMA40_NEXT_CB	0x28
> +#define BCM2711_DMA40_DEBUG2	0x2c
> +
> +#define BCM2711_DMA40_ACTIVE		BIT(0)
> +#define BCM2711_DMA40_END		BIT(1)
> +#define BCM2711_DMA40_INT		BIT(2)
> +#define BCM2711_DMA40_DREQ		BIT(3)  /* DREQ state */
> +#define BCM2711_DMA40_RD_PAUSED		BIT(4)  /* Reading is paused */
> +#define BCM2711_DMA40_WR_PAUSED		BIT(5)  /* Writing is paused */
> +#define BCM2711_DMA40_DREQ_PAUSED	BIT(6)  /* Is paused by DREQ flow control */
> +#define BCM2711_DMA40_WAITING_FOR_WRITES BIT(7)  /* Waiting for last write */
> +#define BCM2711_DMA40_ERR		BIT(10)
> +#define BCM2711_DMA40_QOS(x)		(((x) & 0x1f) << 16)
> +#define BCM2711_DMA40_PANIC_QOS(x)	(((x) & 0x1f) << 20)

Use FIELD_PREP() for this ?

> +#define BCM2711_DMA40_WAIT_FOR_WRITES	BIT(28)
> +#define BCM2711_DMA40_DISDEBUG		BIT(29)
> +#define BCM2711_DMA40_ABORT		BIT(30)
> +#define BCM2711_DMA40_HALT		BIT(31)
> +
> +/* Transfer information bits */
> +#define BCM2711_DMA40_INTEN		BIT(0)
> +#define BCM2711_DMA40_TDMODE		BIT(1) /* 2D-Mode */
> +#define BCM2711_DMA40_WAIT_RESP		BIT(2) /* wait for AXI write to be acked */
> +#define BCM2711_DMA40_WAIT_RD_RESP	BIT(3) /* wait for AXI read to complete */
> +#define BCM2711_DMA40_PER_MAP(x)	((x & 31) << 9) /* REQ source */
> +#define BCM2711_DMA40_S_DREQ		BIT(14) /* enable SREQ for source */
> +#define BCM2711_DMA40_D_DREQ		BIT(15) /* enable DREQ for destination */
> +#define BCM2711_DMA40_S_WAIT(x)		((x & 0xff) << 16) /* add DMA read-wait cycles */
> +#define BCM2711_DMA40_D_WAIT(x)		((x & 0xff) << 24) /* add DMA write-wait cycles */

Use FIELD_PREP() for this ?

> +
> +#define BCM2711_DMA40_INC		BIT(12)
> +#define BCM2711_DMA40_IGNORE		BIT(15)
> +
>  /* the max dma length for different channels */
>  #define MAX_DMA_LEN SZ_1G
>  #define MAX_LITE_DMA_LEN (SZ_64K - 4)
> @@ -297,6 +352,53 @@ static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
>  	return result;
>  }
>  
> +static u32 bcm2711_dma_prepare_cb_info(struct bcm2835_chan *c,
> +				       enum dma_transfer_direction direction,
> +				       bool zero_page)
> +{
> +	u32 result;
> +
> +	if (direction == DMA_MEM_TO_MEM)
> +		return 0;
> +
> +	result = BCM2711_DMA40_WAIT_RESP;
> +
> +	/* Setup DREQ channel */
> +	if (c->dreq != 0)
> +		result |= BCM2711_DMA40_PER_MAP(c->dreq);
> +
> +	if (direction == DMA_DEV_TO_MEM) {
> +		result |= BCM2711_DMA40_S_DREQ | BCM2711_DMA40_WAIT_RD_RESP;
> +	} else {
> +		result |= BCM2711_DMA40_D_DREQ;
> +	}
> +
> +	return result;
> +}
> +
> +static u32 bcm2711_dma_prepare_cb_extra(struct bcm2835_chan *c,
> +					enum dma_transfer_direction direction,
> +					bool cyclic, bool final,
> +					unsigned long flags)
> +{
> +	u32 result = 0;
> +
> +	if (cyclic) {
> +		if (flags & DMA_PREP_INTERRUPT)
> +			result |= BCM2711_DMA40_INTEN;
> +	} else {
> +		if (!final)
> +			return 0;
> +
> +		result |= BCM2711_DMA40_INTEN;
> +
> +		if (direction == DMA_MEM_TO_MEM)
> +			result |= BCM2711_DMA40_WAIT_RESP;
> +	}
> +
> +	return result;
> +}
> +
>  static inline bool need_src_incr(enum dma_transfer_direction direction)
>  {
>  	return direction != DMA_DEV_TO_MEM;
> @@ -413,6 +515,120 @@ static dma_addr_t bcm2835_dma_read_addr(struct bcm2835_chan *c,
>  	return 0;
>  }
>  
> +static inline u32 bcm2711_dma_cb_get_length(void *data)
> +{
> +	struct bcm2711_dma40_scb *scb = data;
> +
> +	return scb->len;
> +}
> +
> +static inline dma_addr_t
> +bcm2711_dma_cb_get_addr(void *data, enum dma_transfer_direction direction)
> +{
> +	struct bcm2711_dma40_scb *scb = data;
> +
> +	if (direction == DMA_DEV_TO_MEM)
> +		return scb->dst + ((scb->dsti & 0xff) << 8);
> +
> +	return scb->src + ((scb->srci & 0xff) << 8);
> +}
> +
> +static inline void
> +bcm2711_dma_cb_init(void *data, struct bcm2835_chan *c,
> +		    enum dma_transfer_direction direction, u32 src, u32 dst,
> +		    bool zero_page)
> +{
> +	struct bcm2711_dma40_scb *scb = data;
> +
> +	scb->ti = bcm2711_dma_prepare_cb_info(c, direction, zero_page);
> +	scb->src = lower_32_bits(src);
> +	scb->srci = upper_32_bits(src);
> +
> +	if (need_src_incr(direction))
> +		scb->srci |= BCM2711_DMA40_INC;
> +
> +	scb->dst = lower_32_bits(dst);
> +	scb->dsti = upper_32_bits(dst);
> +
> +	if (need_dst_incr(direction))
> +		scb->dsti |= BCM2711_DMA40_INC;
> +
> +	scb->next_cb = 0;
> +}
> +
> +static inline void
> +bcm2711_dma_cb_set_src(void *data, enum dma_transfer_direction direction,
> +		       u32 src)
> +{
> +	struct bcm2711_dma40_scb *scb = data;
> +
> +	scb->src = lower_32_bits(src);
> +	scb->srci = upper_32_bits(src);
> +
> +	if (need_src_incr(direction))
> +		scb->srci |= BCM2711_DMA40_INC;
> +}
> +
> +static inline void
> +bcm2711_dma_cb_set_dst(void *data, enum dma_transfer_direction direction,
> +		       u32 dst)
> +{
> +	struct bcm2711_dma40_scb *scb = data;
> +
> +	scb->dst = lower_32_bits(dst);
> +	scb->dsti = upper_32_bits(dst);
> +
> +	if (need_dst_incr(direction))
> +		scb->dsti |= BCM2711_DMA40_INC;
> +}
> +
> +static inline void bcm2711_dma_cb_set_next(void *data, u32 next)
> +{
> +	struct bcm2711_dma40_scb *scb = data;
> +
> +	scb->next_cb = next;
> +}
> +
> +static inline void bcm2711_dma_cb_set_length(void *data, u32 length)
> +{
> +	struct bcm2711_dma40_scb *scb = data;
> +
> +	scb->len = length;
> +}
> +
> +static inline void
> +bcm2711_dma_cb_append_extra(void *data, struct bcm2835_chan *c,
> +			    enum dma_transfer_direction direction,
> +			    bool cyclic, bool final, unsigned long flags)
> +{
> +	struct bcm2711_dma40_scb *scb = data;
> +
> +	scb->ti |= bcm2711_dma_prepare_cb_extra(c, direction, cyclic, final,
> +						flags);
> +}

this helper is just a wrapper over bcm2711_dma_prepare_cb_extra() do
consider getting rid of extra layer...

> +
> +static inline dma_addr_t bcm2711_dma_to_cb_addr(dma_addr_t addr)
> +{
> +	return (addr >> 5);
> +}
> +
> +static void bcm2711_dma_chan_plat_init(struct bcm2835_chan *c)
> +{
> +}
> +
> +static dma_addr_t bcm2711_dma_read_addr(struct bcm2835_chan *c,
> +					enum dma_transfer_direction direction)
> +{
> +	if (direction == DMA_MEM_TO_DEV)
> +		return readl(c->chan_base + BCM2711_DMA40_SRC) +
> +			((readl(c->chan_base + BCM2711_DMA40_SRCI) & 0xff) << 8);
> +	else if (direction == DMA_DEV_TO_MEM)
> +		return readl(c->chan_base + BCM2711_DMA40_DEST) +
> +			((readl(c->chan_base + BCM2711_DMA40_DESTI) & 0xff) << 8);
> +
> +	return 0;
> +}
> +
>  static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
>  {
>  	size_t i;
> @@ -1070,8 +1286,35 @@ static const struct bcm2835_dma_cfg bcm2835_data = {
>  	.read_addr = bcm2835_dma_read_addr,
>  };
>  
> +static const struct bcm2835_dma_cfg bcm2711_data = {
> +	.addr_offset = BCM2711_DMA40_PHYS_ADDR,
> +
> +	.cs_reg = BCM2711_DMA40_CS,
> +	.cb_reg = BCM2711_DMA40_CB,
> +
> +	.wait_mask = BCM2711_DMA40_WAITING_FOR_WRITES,
> +	.reset_mask = BCM2711_DMA40_HALT,
> +	.int_mask = BCM2711_DMA40_INTEN,
> +	.active_mask = BCM2711_DMA40_ACTIVE,
> +
> +	.cb_get_length = bcm2711_dma_cb_get_length,
> +	.cb_get_addr = bcm2711_dma_cb_get_addr,
> +	.cb_init = bcm2711_dma_cb_init,
> +	.cb_set_src = bcm2711_dma_cb_set_src,
> +	.cb_set_dst = bcm2711_dma_cb_set_dst,
> +	.cb_set_next = bcm2711_dma_cb_set_next,
> +	.cb_set_length = bcm2711_dma_cb_set_length,
> +	.cb_append_extra = bcm2711_dma_cb_append_extra,
> +
> +	.to_cb_addr = bcm2711_dma_to_cb_addr,
> +
> +	.chan_plat_init = bcm2711_dma_chan_plat_init,
> +	.read_addr = bcm2711_dma_read_addr,
> +};
> +
>  static const struct of_device_id bcm2835_dma_of_match[] = {
>  	{ .compatible = "brcm,bcm2835-dma", .data = &bcm2835_data },
> +	{ .compatible = "brcm,bcm2711-dma", .data = &bcm2711_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, bcm2835_dma_of_match);
> -- 
> 2.7.4

-- 
~Vinod
