Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB54FBA17
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiDKKxF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 06:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345871AbiDKKw4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 06:52:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496B4344EF;
        Mon, 11 Apr 2022 03:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBD8B61518;
        Mon, 11 Apr 2022 10:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02B4C385A4;
        Mon, 11 Apr 2022 10:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649674241;
        bh=1IMcTxu81IxoqmzEjcmyl7feWQexXcHs/UwdYnBHOFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cqgl2mpL76yJtKhrdpaYDXcA+jGcG01yXz0QdbQPK8HB2ktpjlOk+ogNXZGvBn7qP
         JgHv1ryfvV96ezP4U16OQ+auY2DgiTL2MZaBqwEKMAT6mOx0+yNDsDqfqRoDFGqCWQ
         zKXAGTxG8gt9S55xeKWrlveNI+4XskxU8nLZ8i4Tb3oM6r1iywFxGav7rfVgq2P3/3
         dCEWX2GyzHNCx0ib5sjyACW3MJ7bvrLFyMeo4jqcZ8iwIyEYi/zCeLMA+2nPDw2RzH
         4K01hJLSCvLq68YiZ0rU5fomUj0tPwbQmpXotjm9EtDR+JnIuvcdqzLrXqFMHaLhLf
         K7TM+6V4jM3EQ==
Date:   Mon, 11 Apr 2022 16:20:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     cgel.zte@gmail.com
Cc:     sean.wang@mediatek.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers: dma: using pm_runtime_resume_and_get instead of
 pm_runtime_get_sync
Message-ID: <YlQH/WjgLgD5uVsP@matsya>
References: <20220411013504.2517012-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411013504.2517012-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-22, 01:35, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>

subsystem tag is wrong, pls see gitlog to find the appropriate one

> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code

Can you explain why it is appropriate?

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/dma/mediatek/mtk-uart-apdma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
> index 375e7e647df6..64bad5681447 100644
> --- a/drivers/dma/mediatek/mtk-uart-apdma.c
> +++ b/drivers/dma/mediatek/mtk-uart-apdma.c
> @@ -274,11 +274,9 @@ static int mtk_uart_apdma_alloc_chan_resources(struct dma_chan *chan)
>  	unsigned int status;
>  	int ret;
>  
> -	ret = pm_runtime_get_sync(mtkd->ddev.dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(chan->device->dev);
> +	ret = pm_runtime_resume_and_get(mtkd->ddev.dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	mtk_uart_apdma_write(c, VFF_ADDR, 0);
>  	mtk_uart_apdma_write(c, VFF_THRE, 0);
> -- 
> 2.25.1

-- 
~Vinod
