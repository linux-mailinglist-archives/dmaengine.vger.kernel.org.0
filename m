Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D316DFCCE
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDLRgY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 13:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLRgX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 13:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CAC19A;
        Wed, 12 Apr 2023 10:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 138BF60DFF;
        Wed, 12 Apr 2023 17:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF18DC433EF;
        Wed, 12 Apr 2023 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681320981;
        bh=cwA5mDATUrWUOIHmMShcnvV2YZwtg3kK0oI17Yr76c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7woPOBOVDLPqw3LpeawiOYdFdLuYG5K6/T5rFy5aO/NJ5oYswbk+2qrUHHATLSPy
         Uk/7Rk51AAw+Tu6GFMKZpBHW5cYkrdkG/lKEhTi2TefeHWlwDK8kjzNPtZnf1ngHoD
         WAOguyA9ZDWaZF1uGbSc1hX5N6ULU6GtY9v+8Zl9kxb7keiHy+NX6Ioq/yR/yNf+sz
         exEXCGBhl8Fwz6Ne9dGMch0ViwNAUtjmp6BtKB2O3Jo6vjheNbZavD7yh02VSdOYL0
         fBRg2ndB6wiyJyVZ0dY19Hsbovc1PmzkTwOavIzfOh5z1n3sA4GHH8CzP05yvuxWkY
         H/TSd1RYBvotQ==
Date:   Wed, 12 Apr 2023 23:06:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] dmaengine: dw-axi-dmac: remove redudant
 axi_dma_disable() calling
Message-ID: <ZDbsEX/98i30p88k@matsya>
References: <20230313170450.897-1-jszhang@kernel.org>
 <20230313170450.897-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313170450.897-5-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-03-23, 01:04, Jisheng Zhang wrote:
> axi_dma_suspend() will soon call axi_dma_disable(), remove the redudant

s/redudant/redundant

> axi_dma_disable() callin.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 891776528619..410222e7224c 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1535,7 +1535,6 @@ static int dw_remove(struct platform_device *pdev)
>  		axi_chan_disable(&chip->dw->chan[i]);
>  		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
>  	}
> -	axi_dma_disable(chip);
>  
>  	pm_runtime_disable(chip->dev);
>  	axi_dma_suspend(chip);
> -- 
> 2.39.2

-- 
~Vinod
