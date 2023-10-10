Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4297E7BFFDF
	for <lists+dmaengine@lfdr.de>; Tue, 10 Oct 2023 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjJJPAj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Oct 2023 11:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjJJPAi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Oct 2023 11:00:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46213AC;
        Tue, 10 Oct 2023 08:00:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E7AC433C7;
        Tue, 10 Oct 2023 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696950035;
        bh=8XxPnVDAlUJrH1PKK69qfWPgf4kWCU+iIBO+HjlBnjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CC2kdWe0H2Mb+QzsYE3fmeZ8l8pLrsTgdR3fz+LWTflLfsnfTO/vjg+SnyjG5rPNG
         /mcfI5IUgRhf0j1kTTTR8oNb0l+dmZULKr0dxeE0AqnAm4g9Iu70dIBtyWPGPArL+N
         dslSZOz9XmL7yT+/OVk/+RRXf0LdY0aQDKPeO+q1V2a2XLfHU30g/fO2Xpr7xkr5PN
         3cpehrRoxSLiB7YFxNnFuhB99uWblCs8kPV0A4U+jWmP1uf9LvSN9soeYGP2wyZpcB
         B37kP6PX7hzvyywQH4KJuYIfeDRlnEXNWXTEMPKXe1TBXb8BhnDSkfyoyf58eTyAHn
         vSREfAQgGOVDA==
Date:   Tue, 10 Oct 2023 20:30:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 3/5] dmaengine: dw-edma: Add HDMA remote interrupt
 configuration
Message-ID: <20231010150022.GM4884@thinkpad>
References: <20231002131749.2977952-1-kory.maincent@bootlin.com>
 <20231002131749.2977952-4-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002131749.2977952-4-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 02, 2023 at 03:17:47PM +0200, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Only the local interruption was configured, remote interrupt was left
> behind. This patch fix it by setting stop and abort remote interrupts when
> the DW_EDMA_CHIP_LOCAL flag is not set.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 0afafc683a9e..0cce1880cfdc 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -236,6 +236,8 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
>  		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
>  		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> +		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
>  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
>  		/* Channel control */
>  		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
