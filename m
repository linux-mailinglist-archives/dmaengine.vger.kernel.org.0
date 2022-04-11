Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5814FBA36
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 12:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiDKK5b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbiDKK5Y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 06:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2DB3AA4A;
        Mon, 11 Apr 2022 03:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F40B16154D;
        Mon, 11 Apr 2022 10:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B519DC385A4;
        Mon, 11 Apr 2022 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649674504;
        bh=hbx/XGTbrjcsRQNZgsAlyhPIQMpDC7dZXrygkXiztaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBClJTLOwY1dVFIYHwAm3fVjA0YvYq/mVBBpApMC+GVkCQ5nPdgD/nWfkZ1aQEwDL
         aJ8MKdjzhsdtFawTQ5xlCH5dBPoThFeeFk5GVcea0YKCXkiNjLOlAyW9AkjhMZQM8G
         wKExElFoc7dJTCnvxCXoEOlpYq+c3rKkJL1dw+qVV3Z9LffszEVfHC2pRiLUM95JZT
         ycLejppG5RhSdFcGvUaZzfIoMHKX6v65R/8nz/mvbUjUH1GWjKf6wZOUhEgF9GaGJx
         h4OWh2s0YXSchwn2lKmNFrsAktqHe2ui2BMxXVZNCU4g6aM/tuMoQ+vO/FvcJkL6ro
         C7VVzNjhloktg==
Date:   Mon, 11 Apr 2022 16:25:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Colin Ian King <colin.king@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: sh: rz-dmac: Set DMA transfer parameters
 based on the direction
Message-ID: <YlQJBPmECe2AkpOJ@matsya>
References: <20220409165348.46080-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409165348.46080-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-04-22, 17:53, Biju Das wrote:
> Client drivers configure DMA transfer parameters based on the DMA
> transfer direction.
> 
> This patch sets corresponding parameters in rz_dmac_config() based
> on the DMA transfer direction.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
>  * Updated commit description
> ---
>  drivers/dma/sh/rz-dmac.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index ee2872e7d64c..de57ae006879 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -597,24 +597,24 @@ static int rz_dmac_config(struct dma_chan *chan,
>  			  struct dma_slave_config *config)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> -	u32 val;
> +	u32 val, data_sz;
>  
> -	channel->src_per_address = config->src_addr;
> -	channel->src_word_size = config->src_addr_width;
> -	channel->dst_per_address = config->dst_addr;
> -	channel->dst_word_size = config->dst_addr_width;
> -
> -	val = rz_dmac_ds_to_val_mapping(config->dst_addr_width);
> -	if (val == CHCFG_DS_INVALID)
> -		return -EINVAL;
> -
> -	channel->chcfg |= CHCFG_FILL_DDS(val);
> +	if (config->direction == DMA_DEV_TO_MEM) {

This is a deprecated field, pls do not use this... 

Above code is correct and then based on direction of the descriptor you
would use either src or dstn parameters

-- 
~Vinod
