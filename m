Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBE963358F
	for <lists+dmaengine@lfdr.de>; Tue, 22 Nov 2022 07:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiKVG7i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Nov 2022 01:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVG7i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Nov 2022 01:59:38 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07542F3B9;
        Mon, 21 Nov 2022 22:59:36 -0800 (PST)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8559B1BF208;
        Tue, 22 Nov 2022 06:59:33 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1oxNFk-00H6YC-EK; Tue, 22 Nov 2022 07:59:32 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: xilinx_dma: call of_node_put() when breaking
 out of for_each_child_of_node()
References: <20221122021612.1908866-1-liushixin2@huawei.com>
Date:   Tue, 22 Nov 2022 07:59:32 +0100
In-Reply-To: <20221122021612.1908866-1-liushixin2@huawei.com> (Liu Shixin's
        message of "Tue, 22 Nov 2022 10:16:12 +0800")
Message-ID: <8735ab5vaj.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>>>>> "Liu" == Liu Shixin <liushixin2@huawei.com> writes:

 > Since for_each_child_of_node() will increase the refcount of node, we need
 > to call of_node_put() manually when breaking out of the iteration.

 > Fixes: 9cd4360de609 ("dma: Add Xilinx AXI Video Direct Memory Access Engine driver support")
 > Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

> ---
 >  drivers/dma/xilinx/xilinx_dma.c | 4 +++-
 >  1 file changed, 3 insertions(+), 1 deletion(-)

 > diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
 > index 8cd4e69dc7b4..766017570488 100644
 > --- a/drivers/dma/xilinx/xilinx_dma.c
 > +++ b/drivers/dma/xilinx/xilinx_dma.c
 > @@ -3141,8 +3141,10 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 >  	/* Initialize the channels */
 >  	for_each_child_of_node(node, child) {
 >  		err = xilinx_dma_child_probe(xdev, child);
 > -		if (err < 0)
 > +		if (err < 0) {
 > +			of_node_put(child);
 >  			goto error;
 > +		}
 >  	}
 
 >  	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 > -- 

 > 2.25.1


-- 
Bye, Peter Korsgaard
