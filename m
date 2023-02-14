Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE16695ECB
	for <lists+dmaengine@lfdr.de>; Tue, 14 Feb 2023 10:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjBNJTt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Feb 2023 04:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBNJTV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Feb 2023 04:19:21 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5F7ECE;
        Tue, 14 Feb 2023 01:19:16 -0800 (PST)
Received: (Authenticated sender: peter@korsgaard.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B9B04E0010;
        Tue, 14 Feb 2023 09:19:10 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1pRrSv-003Ap1-G5; Tue, 14 Feb 2023 10:19:09 +0100
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     vkoul@kernel.org, michal.simek@xilinx.com, lizhi.hou@amd.com,
        brian.xu@amd.com, raj.kumar.rampelli@amd.com,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] dmaengine: xilinx: xdma: Fix some kernel-doc
 comments
References: <20230214010344.5354-1-yang.lee@linux.alibaba.com>
Date:   Tue, 14 Feb 2023 10:19:09 +0100
In-Reply-To: <20230214010344.5354-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Tue, 14 Feb 2023 09:03:44 +0800")
Message-ID: <87lel0a9ki.fsf@dell.be.48ers.dk>
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

>>>>> "Yang" == Yang Li <yang.lee@linux.alibaba.com> writes:

 > Make the description of @xdma_chan to @xchan to silence the warnings:
 > drivers/dma/xilinx/xdma.c:283: warning: Function parameter or member 'xchan' not described in 'xdma_xfer_start'
 > drivers/dma/xilinx/xdma.c:283: warning: Excess function parameter 'xdma_chan' description in 'xdma_xfer_start'

 > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
 > Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4051
 > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Peter Korsgaard <peter@korsgaard.com>

> ---
 >  drivers/dma/xilinx/xdma.c | 2 +-
 >  1 file changed, 1 insertion(+), 1 deletion(-)

 > diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
 > index 462109c61653..93ee298d52b8 100644
 > --- a/drivers/dma/xilinx/xdma.c
 > +++ b/drivers/dma/xilinx/xdma.c
 > @@ -277,7 +277,7 @@ xdma_alloc_desc(struct xdma_chan *chan, u32 desc_num)
 
 >  /**
 >   * xdma_xfer_start - Start DMA transfer
 > - * @xdma_chan: DMA channel pointer
 > + * @xchan: DMA channel pointer
 >   */
 >  static int xdma_xfer_start(struct xdma_chan *xchan)
 >  {
 > -- 

 > 2.20.1.7.g153144c


-- 
Bye, Peter Korsgaard
