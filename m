Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABA6BEFEB
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCQRjm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCQRja (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA51AE394;
        Fri, 17 Mar 2023 10:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5BEA60F37;
        Fri, 17 Mar 2023 17:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8ACC433A0;
        Fri, 17 Mar 2023 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074755;
        bh=fQhztykTbvG44/m8npYHjnnMg6cEalBp0Xpsis3PrSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJUvtiQpdkk1XcDg5c7Jz/A/1L1OlYogM5EUBazvpUKdz64sBO0+N0ZTl8fGbP8vC
         EqvU3Nd/pBUHvbPMhMGxdjlgSNzl7lvMZykOkgZkcD7rRR+0g4NeLorPCo6EiwzMzK
         J+YXqoWssr6Bqg8YW+Tyz4hrGwxUrBIPDzFTESmk4OiXwwyPixsySeCVWzJaLF3Ghe
         I6ebDiCXuy5Eyp+0fdSdqN0KwXgdwBXmVlB8oOM7Wqz7kLWrgZrUH8h73TbEhiLUrF
         LuMYajWEOf1YSOKOH/u5t4aSkX3bbx25hsFom530Kqasotay84oRyTWDuacvdBwmbQ
         ManNJuzCADYiA==
Date:   Fri, 17 Mar 2023 23:09:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/5] dmaengine: dw-axi-dmac: Don't set chancnt
Message-ID: <ZBSlvrDmKGjwWBa7@matsya>
References: <20230313170250.815-1-jszhang@kernel.org>
 <20230313170250.815-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313170250.815-2-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-03-23, 01:02, Jisheng Zhang wrote:
> The dma framework will calculate the dma channels chancnt, setting it

The dmaengine framework...

> outself is wrong.

s/outself/ourself

Looks this this is needed for all the patches

> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4169e1d7d5ca..7f3a60e28e38 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1445,7 +1445,6 @@ static int dw_probe(struct platform_device *pdev)
>  	dma_cap_set(DMA_CYCLIC, dw->dma.cap_mask);
>  
>  	/* DMA capabilities */
> -	dw->dma.chancnt = hdata->nr_channels;
>  	dw->dma.max_burst = hdata->axi_rw_burst_len;
>  	dw->dma.src_addr_widths = AXI_DMA_BUSWIDTHS;
>  	dw->dma.dst_addr_widths = AXI_DMA_BUSWIDTHS;
> -- 
> 2.39.2

-- 
~Vinod
