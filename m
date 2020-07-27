Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7687122E886
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgG0JHW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 05:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgG0JHP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 05:07:15 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E7220714;
        Mon, 27 Jul 2020 09:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595840835;
        bh=K6RQC+ajywY34zdeP2+jgr6UKjQUY6swoVf9n8j35Jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UB3qgBOwuPNQb27NTD9csVxte0kbDywOrkYLfeUMb+NbFLJJdE2blymLmEEIbwOiC
         Jd1mGs50efeCkFDwi/DCs3QMUo5p1tm/fVmeEjEyKwrR12thToifCOeb1IQ1qkm5x/
         UkJaINx4C0vZieTb8EPplP3DpcdfvUunkcvKtcJw=
Date:   Mon, 27 Jul 2020 14:37:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rajesh Gumasta <rgumasta@nvidia.com>
Cc:     ldewangan@nvidia.com, jonathanh@nvidia.com,
        dan.j.williams@intel.com, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyarlagadda@nvidia.com, Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Re: [Patch v1 2/4] dma: tegra: Adding Tegra GPC DMA controller driver
Message-ID: <20200727090711.GN12965@vkoul-mobl>
References: <1595226856-19241-1-git-send-email-rgumasta@nvidia.com>
 <1595226856-19241-3-git-send-email-rgumasta@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595226856-19241-3-git-send-email-rgumasta@nvidia.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-20, 12:04, Rajesh Gumasta wrote:
> v4 changes: Removed pending dma desc list and other unused
> data structures
> 
> v3 changes: Removed free list for dma_desc and sg

This is v1 patch and we have v3/v4 stuff! Anyway this can go after the
marker succeeding sob line or cover!

> 
> Adding GPC DMA controller driver for Tegra186 and Tegra194. The driver
> supports dma transfers between memory to memory, IO to memory and
> memory to IO.

This is dmaengine subsystem, so please tag to appropriately

> +/* MMIO sequence register */
> +#define TEGRA_GPCDMA_CHAN_MMIOSEQ		0x01c
> +#define TEGRA_GPCDMA_MMIOSEQ_DBL_BUF		BIT(31)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_8	(0 << 28)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_16	(1 << 28)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_32	(2 << 28)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_64	(3 << 28)
> +#define TEGRA_GPCDMA_MMIOSEQ_BUS_WIDTH_128	(4 << 28)

GENMASK for these please

> +static int tegra_dma_slave_config(struct dma_chan *dc,
> +		struct dma_slave_config *sconfig)
> +{
> +	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> +
> +	if (!list_empty(&tdc->pending_sg_req)) {
> +		dev_err(tdc2dev(tdc), "Configuration not allowed\n");

why is that?

Also run checkpatch --strict on this before sending.

Thanks
-- 
~Vinod
