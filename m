Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5831550B166
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353497AbiDVH24 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 03:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444764AbiDVH2z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 03:28:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F74150E34;
        Fri, 22 Apr 2022 00:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 153B6B82A89;
        Fri, 22 Apr 2022 07:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F228EC385A0;
        Fri, 22 Apr 2022 07:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650612360;
        bh=mYeiytpIltFGmZW/tp87NqZS9F4Ype3FGfPzGUsDDss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnEVtZOfMmKrCviCbqUuAOOEvj/hXBTES+6Pq5FS2j5XJ8qZpOiY0TX6n39bjQoRv
         p6dIzNiU9Og8hMdrhDh8n/cJsJmcKcCy2Hh2SwT0MY2cfYwue1PY4Htz38hZ+sBvhe
         cGTGOQFIPDhobjlg4+q2Hn8kcF0ijxWGwWdb7kG6hXXurXVkGda+agXz/QolW6vLwM
         F2/73gJ/JfRngYmXA09Bd7OIdc7oJPegCvxp6xro1kocnnUsqw8LNIuByZXjKI56JC
         cy0gkYNimtS4f9rhscKXovdZsq4eJ0xEWOWdqfBlOylJewRjkvg/bX7dNvX9YsgN2O
         Bu2DT44sYIdtA==
Date:   Fri, 22 Apr 2022 12:55:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        p.zabel@pengutronix.de, rgumasta@nvidia.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, nathan@kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] dmaengine: tegra: Fix uninitialized variable usage
Message-ID: <YmJYhDmGyrwr7ZYT@matsya>
References: <20220420132239.27775-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420132239.27775-1-akhilrajeev@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-04-22, 18:52, Akhil R wrote:
> Initialize slave_bw and remove unused switch case in
> get_transfer_param()

Two patches please, unused patch can go to next while fix goes to fixes

> 
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index f12327732041..6b8d34165176 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -830,10 +830,6 @@ static int get_transfer_param(struct tegra_dma_channel *tdc,
>  		*slave_bw = tdc->dma_sconfig.src_addr_width;
>  		*csr = TEGRA_GPCDMA_CSR_DMA_IO2MEM_FC;
>  		return 0;
> -	case DMA_MEM_TO_MEM:
> -		*burst_size = tdc->dma_sconfig.src_addr_width;
> -		*csr = TEGRA_GPCDMA_CSR_DMA_MEM2MEM;
> -		return 0;
>  	default:
>  		dev_err(tdc2dev(tdc), "DMA direction is not supported\n");
>  	}
> @@ -985,8 +981,8 @@ tegra_dma_prep_slave_sg(struct dma_chan *dc, struct scatterlist *sgl,
>  {
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	unsigned int max_dma_count = tdc->tdma->chip_data->max_dma_count;
> +	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
>  	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0;
> -	enum dma_slave_buswidth slave_bw;
>  	struct tegra_dma_sg_req *sg_req;
>  	struct tegra_dma_desc *dma_desc;
>  	struct scatterlist *sg;
> @@ -1103,12 +1099,12 @@ tegra_dma_prep_dma_cyclic(struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_l
>  			  size_t period_len, enum dma_transfer_direction direction,
>  			  unsigned long flags)
>  {
> +	enum dma_slave_buswidth slave_bw = DMA_SLAVE_BUSWIDTH_UNDEFINED;
> +	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
> +	unsigned int max_dma_count, len, period_count, i;
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	struct tegra_dma_desc *dma_desc;
>  	struct tegra_dma_sg_req *sg_req;
> -	enum dma_slave_buswidth slave_bw;
> -	u32 csr, mc_seq, apb_ptr = 0, mmio_seq = 0, burst_size;
> -	unsigned int max_dma_count, len, period_count, i;
>  	dma_addr_t mem = buf_addr;
>  	int ret;
>  
> -- 
> 2.17.1

-- 
~Vinod
