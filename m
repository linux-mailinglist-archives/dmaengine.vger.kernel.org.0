Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7AC567DA2
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiGFFRU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGFFRT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:17:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808A1F632;
        Tue,  5 Jul 2022 22:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A615B818BD;
        Wed,  6 Jul 2022 05:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA6EC3411C;
        Wed,  6 Jul 2022 05:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657084635;
        bh=OFpHh/l0JfYEWjjOkBu7G0I8TgRj2RIKDJ6hwTnDB4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mb9WgisFnRbb27wZ++aPJVbXMd1ftcbhxbI0V/J4diGfrf/TguPxSYm4QeUDOHpRr
         jQsxMmbbr5cf54KvfOk1Fks992+OaK1F9C0VmpLkDUZ6b5B+ZxXXz+gk/xb9D+UAIr
         RuDDWt7+NFdl1RWcPdH5LfITDJyZGFi0BkVdDamvViZ4+j0r5iXIMXrVSmCOv89cJJ
         lx5S7rdmEwanFxjqQZNwXKExqUmwPrBFeB45oEegaoSgnhvs6ZVMUjm3BSY4E7Fh5z
         C3IhCKJzyVSaWwRLtswTsvdAPb7gMfvTBaDnkDxba1TQHCorvXsH44zlReFZ7jnNtm
         J6YOI0lh0kRVw==
Date:   Wed, 6 Jul 2022 10:47:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: Fix compile warning 'Function
 parameter not described'
Message-ID: <YsUa1qwIb2LzrUjW@matsya>
References: <1652858507-12628-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652858507-12628-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-05-22, 15:21, Shengjiu Wang wrote:
> Fix compile warning that 'Function parameter or member not described'
> with 'W=1' option:
> 
> There is no description for struct sdma_script_start_addrs, so use /*
> instead of /**
> 
> Add missed description for struct sdma_desc

Patch title should describe the change, so add struct documentation etc
would be apt. Pls revise

> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 95367a8a81a5..111beb7138e0 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -188,7 +188,7 @@
>  #define SDMA_DONE0_CONFIG_DONE_SEL	BIT(7)
>  #define SDMA_DONE0_CONFIG_DONE_DIS	BIT(6)
>  
> -/**
> +/*
>   * struct sdma_script_start_addrs - SDMA script start pointers
>   *
>   * start addresses of the different functions in the physical
> @@ -424,6 +424,11 @@ struct sdma_desc {
>   * @data:		specific sdma interface structure
>   * @bd_pool:		dma_pool for bd
>   * @terminate_worker:	used to call back into terminate work function
> + * @terminated:		terminated list
> + * @is_ram_script:	flag for script in ram
> + * @n_fifos_src:	number of source device fifos
> + * @n_fifos_dst:	number of destination device fifos
> + * @sw_done:		software done flag
>   */
>  struct sdma_channel {
>  	struct virt_dma_chan		vc;
> -- 
> 2.17.1

-- 
~Vinod
