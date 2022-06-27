Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662155E191
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiF0GNB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 02:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiF0GNA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 02:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E625587;
        Sun, 26 Jun 2022 23:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50386612A1;
        Mon, 27 Jun 2022 06:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2A2C341C8;
        Mon, 27 Jun 2022 06:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656310378;
        bh=XSfX3h8z/tYeCfqUd1/OjZf3oxJkcrxHEwFVPj5HSUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psFJnp/1+9cXrSMdsLkWLP7bNJgswfVe/IWPxsu+F+2CgKPMBVTropheV6/uMhoDP
         o5QiP5kBDaYc8arqOdhBIiNx/T9y7PxXGSpJV/UiwaMTl/uRTwdf/w+bcG5RVKyt5h
         az2m1bnyYkCMP91ErIwltt/nDZIsOku7C7R7CdSkEL5nowr+xPzUSRK3IvJthr0gZ4
         J3zIdPdSJRzj5gd5ZaC99KFxr6UJP1G6Gk9se0dg5DU1shHcSvK7TgXuiDoN8tLRec
         K7sE3qMXdZHrlgrJrkdbyJTB8BkjItexpRoGccipSkLvoVT/GANfedbG0vMd2GH4Fg
         gDKVLU4hF6+Ng==
Date:   Mon, 27 Jun 2022 11:42:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jie Hai <haijie1@huawei.com>
Cc:     wangzhou1@hisilicon.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update
Message-ID: <YrlKZgC999AYMvXY@matsya>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220625074422.3479591-3-haijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625074422.3479591-3-haijie1@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-06-22, 15:44, Jie Hai wrote:
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
> 

No need for blank line
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---
>  drivers/dma/hisi_dma.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> index 98bc488893cc..0a0f8a4d168a 100644
> --- a/drivers/dma/hisi_dma.c
> +++ b/drivers/dma/hisi_dma.c
> @@ -436,12 +436,11 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
>  	desc = chan->desc;
>  	cqe = chan->cq + chan->cq_head;
>  	if (desc) {
> +		chan->cq_head = (chan->cq_head + 1) %
> +				hdma_dev->chan_depth;
> +		hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_HEAD_PTR,

q_base?

-- 
~Vinod
