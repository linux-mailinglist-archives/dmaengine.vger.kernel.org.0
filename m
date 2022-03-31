Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30D4ED33B
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 07:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiCaF2F (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 01:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiCaF2E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 01:28:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BD53D1F7
        for <dmaengine@vger.kernel.org>; Wed, 30 Mar 2022 22:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F13F36152D
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 05:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF682C340EE;
        Thu, 31 Mar 2022 05:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648704374;
        bh=OcYuDJA5/eKT1FXz6dlrEwtPxABYoYB/hdBiQS6lC0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PflSaV5/YPo3OqmWGpA13oCAXVG1GvhlqrWu6Jln3ixAyrKKAhUbkCgei8AUzJ7aq
         NnirU4fBOT4o3TaPsyc/ZmSeKQ1Dj5FpJF7XRAm48KyCPZSPKWJC0YByL5P1z1SAng
         PLCkN74Dw6TjL7sfGPPx5O+BPj1i9rradr3ChK3sEe+I+McVxlm/jUR6atvzolxo0x
         MrSRDoESzWohqVwhW3RnXFSr3HGAWCedqET3e3l9O5/Cme9Pck1WuAh2PUJsUt4qlL
         ZWjsssDc13M+3fj11IbGkK5AN0Xq421B9dNAZWcS/X6Y2uL4BhKETR5hI+Oq7cosJr
         JWsicS3g+wE3w==
Date:   Thu, 31 Mar 2022 10:56:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>, kernel@pengutronix.de,
        NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 10/19] dma: imx-sdma: Add multi fifo support
Message-ID: <YkU7cYhZUuGyWbob@matsya>
References: <20220328112744.1575631-1-s.hauer@pengutronix.de>
 <20220328112744.1575631-11-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328112744.1575631-11-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-03-22, 13:27, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

it is dmaengine: xxx

Also is this patch dependent on rest of the series, if not consider
sending separately

> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 281adbb26e6bd..4a43a048e1b4d 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -39,6 +39,7 @@ enum sdma_peripheral_type {
>  	IMX_DMATYPE_SSI_DUAL,	/* SSI Dual FIFO */
>  	IMX_DMATYPE_ASRC_SP,	/* Shared ASRC */
>  	IMX_DMATYPE_SAI,	/* SAI */
> +	IMX_DMATYPE_MULTI_SAI,	/* MULTI FIFOs For Audio */
>  };
>  
>  enum imx_dma_prio {
> @@ -65,4 +66,10 @@ static inline int imx_dma_is_general_purpose(struct dma_chan *chan)
>  		!strcmp(chan->device->dev->driver->name, "imx-dma");
>  }
>  
> +struct sdma_peripheral_config {
> +	int n_fifos_src;
> +	int n_fifos_dst;
> +	bool sw_done;
> +};

Not more platform data :(

Can you explain this structure and why this is required? What do these
fields refer to..?

-- 
~Vinod
