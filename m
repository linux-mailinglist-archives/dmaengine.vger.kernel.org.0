Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3784F3D7531
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jul 2021 14:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhG0Mk0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jul 2021 08:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhG0MkZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Jul 2021 08:40:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFE9B60F51;
        Tue, 27 Jul 2021 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627389625;
        bh=cs1P7QYHMXxjFhBfy1/cTmV1phkVINKGVLWVmSZuRpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBjP0UvqyYynltaRiKHIllpn+RrOFO5TigeyTKc2RaPkewG8CwuaoEpZqggEpyS/+
         nJ/3HN8Fk4o8h92qpTk2ICDleTrOUjmrQmG6Zk9+deVmAO2+aIqH0KbDVbSYkVHyi0
         UR5j+u2JV7d3cK0JQ6LMqYuydq/Gep870QOTvgxf21XqhnlOwO1TnJujmXtsmSkTR+
         zETGytGplBTE9PLq8jnRaqhZhMjm3Pe9tln9syfbcJYFCOzwk383kt5RJHtc7pGxD4
         qVDJ03NprA/chddn5pq9t31Bir3zFT73WevblBodq/EzHBE8iz4i2rtiJgbZt/ojwA
         qrq+AXHB/6pKw==
Date:   Tue, 27 Jul 2021 18:10:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Message-ID: <YP/+r4HzCaAZbUWh@matsya>
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719092535.4474-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-07-21, 10:25, Biju Das wrote:

> +struct rz_dmac_chan {
> +	struct virt_dma_chan vc;
> +	void __iomem *ch_base;
> +	void __iomem *ch_cmn_base;
> +	unsigned int index;
> +	int irq;
> +	struct rz_dmac_desc *desc;
> +	int descs_allocated;
> +
> +	enum dma_slave_buswidth src_word_size;
> +	enum dma_slave_buswidth dst_word_size;
> +	dma_addr_t src_per_address;
> +	dma_addr_t dst_per_address;
> +
> +	u32 chcfg;
> +	u32 chctrl;
> +	int mid_rid;
> +
> +	struct list_head ld_free;
> +	struct list_head ld_queue;
> +	struct list_head ld_active;
> +
> +	struct {
> +		struct rz_lmdesc *base;
> +		struct rz_lmdesc *head;
> +		struct rz_lmdesc *tail;
> +		int valid;
> +		dma_addr_t base_dma;
> +	} lmdesc;

should this be not part of rz_dmac_desc than channel?

> +static int rz_dmac_config(struct dma_chan *chan,
> +			  struct dma_slave_config *config)
> +{
> +	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	u32 *ch_cfg;
> +
> +	channel->src_per_address = config->src_addr;
> +	channel->src_word_size = config->src_addr_width;
> +	channel->dst_per_address = config->dst_addr;
> +	channel->dst_word_size = config->dst_addr_width;
> +
> +	if (config->peripheral_config) {
> +		ch_cfg = config->peripheral_config;
> +		channel->chcfg = *ch_cfg;
> +	}

can you explain what this the ch_cfg here and what does it represent?

-- 
~Vinod
