Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730E31082C
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2019 15:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEANNi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 May 2019 09:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfEANNi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 1 May 2019 09:13:38 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7728E2085A;
        Wed,  1 May 2019 13:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556716417;
        bh=3NwS6fJJakUxorL1dAmtWzw6EJNrxfzP+xwhOT4N6E4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9Lr0JumZTcevwco8fzNMYOD0MACe1C4uTi7H92oxHpEgkK3F++H+YyCC9K/SH/K8
         SCZExk9yVBYSGWIXv+Ng5sez2i704z5JqkItOvQWLNax25/SOYEKQ4UcqBYtoW2Zgt
         Rzs2L4hFSOKfipLorLsclH16LH50GfdpMEV4QgCY=
Date:   Wed, 1 May 2019 18:43:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk,
        Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: tegra: add accurate reporting of dma state
Message-ID: <20190501131327.GX3845@vkoul-mobl.Dlink>
References: <20190424162348.23692-1-ben.dooks@codethink.co.uk>
 <71198258-40b8-3f7f-1401-58513bfaaab5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71198258-40b8-3f7f-1401-58513bfaaab5@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01-05-19, 09:33, Jon Hunter wrote:

> > @@ -1444,12 +1529,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
> >  		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> >  		BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> >  	tdma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > -	/*
> > -	 * XXX The hardware appears to support
> > -	 * DMA_RESIDUE_GRANULARITY_BURST-level reporting, but it's
> > -	 * only used by this driver during tegra_dma_terminate_all()
> > -	 */
> > -	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> > +	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> >  	tdma->dma_dev.device_config = tegra_dma_slave_config;
> >  	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
> >  	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
> 
> In addition to Dmitry's comments, can you please make sure you run this
> through checkpatch.pl?

And use correct subsystem name !

-- 
~Vinod
