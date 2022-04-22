Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7329B50B041
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 08:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiDVGNt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 02:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444317AbiDVGNK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 02:13:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B2289BE;
        Thu, 21 Apr 2022 23:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84834B82A81;
        Fri, 22 Apr 2022 06:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0649C385A4;
        Fri, 22 Apr 2022 06:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650607815;
        bh=MJyZJeaFrRIgBTeVkPLy57xZQnMw1BKj1OB3B3uCgf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IY4Fg2MiVAFQ098Mu1llqTZ4El90rKHVtoud/3uo5fa+pG5bP87H73olcGwr3WFtF
         1FU2wR5WKdvEN9R73qU3Ij08EmCCrmXWnjEwgsJrjQG5bMLCPaChY6xJr21X9+Byb/
         Tv1RxitzFRmAEXjnHwoduy8rzzvgFusWrCFW23pnDVTAu7lKt6lhSTAE2CDAerbonA
         0QrzmAO/1j7Eb6HK22cXP01WfVo3Du9QiG1hIPexRUU0PTPHLwMOaaEJbRQONsXuoh
         eydAWkbLCPxwN+ONB8ue9y0GQQBk7nU+ydcWpWJnJwxuRfWnI4nUz7vNosfVu3t0m2
         xCyjRGxgT75+w==
Date:   Fri, 22 Apr 2022 11:40:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: imx-sdma: Remove useless null check before
 call of_node_put()
Message-ID: <YmJGw84by8eczx/u@matsya>
References: <1650509390-26877-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650509390-26877-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-04-22, 10:49, Haowen Bai wrote:
> No need to add null check before call of_node_put(), since the
> implementation of of_node_put() has done it.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/dma/imx-sdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 6196a7b3956b..b8a1299b93f0 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1933,8 +1933,7 @@ static int sdma_event_remap(struct sdma_engine *sdma)
>  	}
>  
>  out:
> -	if (gpr_np)
> -		of_node_put(gpr_np);
> +	of_node_put(gpr_np);

this is incorrect as it is called on error case


-- 
~Vinod
