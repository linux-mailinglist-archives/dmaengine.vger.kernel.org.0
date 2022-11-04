Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13048619A42
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiKDOkH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiKDOjo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:39:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EE13120E;
        Fri,  4 Nov 2022 07:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FEEAB82C13;
        Fri,  4 Nov 2022 14:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D77C433D7;
        Fri,  4 Nov 2022 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667572654;
        bh=mjEOutRuNE9+6UZp3LCAy5GbktpZ9JkgrgOZNHqtcIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2do/PUx6HiYACXLaoZ5xOXQazDfGfDcddbpWhNHJuae9B+WUj/Xonur64ac57UoR
         +4yBmAFCoSlqVmHaqmHe49Srs/PGK/pnRH/PcCm9HbFoo7IY1rjcRy52gOS3kkdtH0
         7pJJEBGPMOfvZ2kiF4FAR8TsmVrJ8C0MZxgVGxXVYnYplDrWBBfVs9BMdHFpyldV0V
         RCYSePM2UaF1X+0xbr5bldegwtjhThYEmWxoTGaLFu9CEFHXXQ9XVyXoP2usPBNjrd
         JNNcOGihCKzMTO8gYNrhDNF5h1r+h6zicMkJdNf2BRG3sDsL+m9swu9YCxtmOhmK/r
         I92QcKs5BhokQ==
Date:   Fri, 4 Nov 2022 20:07:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andrew Chernyakov <acherniakov@astralinux.ru>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] dmaengine: fsl-edma: fix potential NULL pointer
 dereference in fsl_edma_tx_status()
Message-ID: <Y2UjqrTVMKm1QGmD@matsya>
References: <20221026101841.35305-1-acherniakov@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026101841.35305-1-acherniakov@astralinux.ru>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-10-22, 13:18, Andrew Chernyakov wrote:
> fsl_edma_desc_residue() dereferences fsl_chan->edesc, but it is checked
> for NULL only in one of two places where fsl_edma_desc_residue() is
> called from fsl_edma_tx_status().

Patch subject should be the change it introduces, pls revise

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Andrew Chernyakov <acherniakov@astralinux.ru>
> ---
>  drivers/dma/fsl-edma-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index a06a1575a2a5..fb712d85d556 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -330,7 +330,7 @@ enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
>  	if (fsl_chan->edesc && cookie == fsl_chan->edesc->vdesc.tx.cookie)
>  		txstate->residue =
>  			fsl_edma_desc_residue(fsl_chan, vdesc, true);
> -	else if (vdesc)
> +	else if (fsl_chan->edesc && vdesc)
>  		txstate->residue =
>  			fsl_edma_desc_residue(fsl_chan, vdesc, false);
>  	else
> -- 
> 2.35.1

-- 
~Vinod
