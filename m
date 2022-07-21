Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6E57CBDC
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiGUN1S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 09:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUN1S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 09:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF374E3B;
        Thu, 21 Jul 2022 06:27:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8199D61B68;
        Thu, 21 Jul 2022 13:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C669C3411E;
        Thu, 21 Jul 2022 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658410034;
        bh=A8nBqzb4eEEoFA2fQbiMfx9rCqmlFqxYMpj/PjSnsJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXMrseRPGPXLVHyP3CxdFIHwqqGYMxzLMTygKpZ6Nk4X2P4tS2EAeCtr0ps/c8oxZ
         4nIRC/kVTv6u0jZQtu3pa2fFFVfp2eeqjR3hHJRtaChaL+4hq++C5yvRucO8HQipez
         niKPfmU0FGHA0vCYy6b4s/N9b+u8ZFU2hI8Jfekz353LUoN/6haMVPs2IwGNu0tnrl
         xuEyO0U5oCuXRDAVfW648Q/Hbmw97RVmZ4YGfe2e2P406mAbkJutq3BtKzajKckKjC
         xPNI1Nj+1XSATVUgtXUtVZ/A7YvdSOizkPuojIvplkoX9poH3puSiveu6ToAzxNVQR
         0pfJv8WLOP01Q==
Date:   Thu, 21 Jul 2022 18:57:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jie Hai <haijie1@huawei.com>
Cc:     wangzhou1@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dmaengine: hisilicon: Fix CQ head update
Message-ID: <YtlULeGbn+z5AVP+@matsya>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220629035549.44181-1-haijie1@huawei.com>
 <20220629035549.44181-3-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629035549.44181-3-haijie1@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-06-22, 11:55, Jie Hai wrote:
> After completion of data transfer of one or multiple descriptors,
> the completion status and the current head pointer to submission
> queue are written into the CQ and interrupt can be generated to
> inform the software. In interrupt process CQ is read and cq_head
> is updated.
> 
> hisi_dma_irq updates cq_head only when the completion status is
> success. When an abnormal interrupt reports, cq_head will not update
> which will cause subsequent interrupt processes read the error CQ
> and never report the correct status.
> 
> This patch updates cq_head whenever CQ is accessed.
> 
> Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  drivers/dma/hisi_dma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 98bc488893cc..7609e6e7eb37 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -436,12 +436,12 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
>  	desc = chan->desc;
>  	cqe = chan->cq + chan->cq_head;
>  	if (desc) {
> +		chan->cq_head = (chan->cq_head + 1) %
> +				hdma_dev->chan_depth;

This can look better with single line

> +		hisi_dma_chan_write(hdma_dev->base,
> +				    HISI_DMA_CQ_HEAD_PTR, chan->qp_num,
> +				    chan->cq_head);

maybe two lines?

>  		if (FIELD_GET(STATUS_MASK, cqe->w0) == STATUS_SUCC) {
> -			chan->cq_head = (chan->cq_head + 1) %
> -					hdma_dev->chan_depth;
> -			hisi_dma_chan_write(hdma_dev->base,
> -					    HISI_DMA_CQ_HEAD_PTR, chan->qp_num,
> -					    chan->cq_head);
>  			vchan_cookie_complete(&desc->vd);
>  		} else {
>  			dev_err(&hdma_dev->pdev->dev, "task error!\n");
> -- 
> 2.33.0

-- 
~Vinod
