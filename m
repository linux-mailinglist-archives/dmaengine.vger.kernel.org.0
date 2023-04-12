Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38E76DFCD3
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDLRiX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLRiW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D72661A7;
        Wed, 12 Apr 2023 10:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB80061211;
        Wed, 12 Apr 2023 17:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D56AC4339B;
        Wed, 12 Apr 2023 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681321100;
        bh=miIa6O6SRrXDO1s0bg/11woX2MfnWMrq1J8t/II2bug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LrKFwBBq065+JyxoVnIPRqV5EDxxLnRrsj8KEzsJ+OIhSoS9Y+B+1ITcCp7ALaADX
         3/OnDF+PRubS4Kek+9toR0NM1u9tMak+iAvCCnCHBo7v9B3rpP5y59OBwMT4k7riP6
         RmObeNDSlA1PZg+Jdu6veW7RlQr71Sq87oYbXcmbI/mC/txDeml8Dr2AAZ77kM4SIf
         iUTK24pIuxpMfwjZGVhds/qV7/jm/lmDgZ/tqYNo4JLwbQCNir/iu5fE79GCpGgtDG
         LwFu355pP6HxKaRVdNKbIjVQcddeLKbVmKVfoHA88uEji5t04Kma/uaFKmIB0Ifhvn
         sUkfhOUxPR1vA==
Date:   Wed, 12 Apr 2023 23:08:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] dmaengine: dw-axi-dmac: remove unnecessary
 devm_free_irq() calling
Message-ID: <ZDbsiKV2nOUhrRiU@matsya>
References: <20230313170450.897-1-jszhang@kernel.org>
 <20230313170450.897-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313170450.897-3-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-03-23, 01:04, Jisheng Zhang wrote:
> In dw_remove(), We have disabled the irq from the dw-axi-dma side, so
> we are safe against the case "The irq is still ON when devices remove
> is executed and irq should be quiesced before remove is completed."

what about the interrupts which might fire spuriously after this? I
prefer to keep this explicitly here
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 23a10dbdecb7..56f12dfa410d 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1542,8 +1542,6 @@ static int dw_remove(struct platform_device *pdev)
>  	pm_runtime_disable(chip->dev);
>  	axi_dma_suspend(chip);
>  
> -	devm_free_irq(chip->dev, chip->irq, chip);
> -
>  	of_dma_controller_free(chip->dev->of_node);
>  
>  	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
> -- 
> 2.39.2

-- 
~Vinod
