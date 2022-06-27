Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64155C630
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiF0Rin (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jun 2022 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiF0Rim (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jun 2022 13:38:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C87BC26;
        Mon, 27 Jun 2022 10:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC086CE1C11;
        Mon, 27 Jun 2022 17:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68482C3411D;
        Mon, 27 Jun 2022 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656351518;
        bh=hfCfNTzc7JZtxou2jxZhmy+oXmDlCgxHOD/5k/M2B+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YE5NQe9CzyTAASVfUPLi4dW00FrNxSGcSXhdSR3rD3D5qUqx2B+1/+D6QgmXrmJXC
         pQb7cpX8LXO0qZUjXDGFC/wV79fO/NFT30sUo/IBfN500jGLjDrvPDxu8sexMFWF1Q
         pTZ/nJs+3kUizBXrP37ZP19MKAGPFzc8zQJVo6vpqpu3pOERX37n2Iw2JlZ5WW8ICc
         +i4W2OyNDS81WrzRse0jcYFQnucpcqWpp9HaY0V/Rzs1oqU0S2WmZgf1NqvXxSAcrW
         gJBUNQpFAFP0kfj66X6H6fhwf5yApDbuxnRhlQJr620bzGtV+TksKiHLHSTVuyZAuk
         OxW1QVJzvyqqA==
Date:   Mon, 27 Jun 2022 23:08:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     haijie <haijie1@huawei.com>
Cc:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update
Message-ID: <YrnrGfIAk7wCnEY2@matsya>
References: <20220625074422.3479591-1-haijie1@huawei.com>
 <20220625074422.3479591-3-haijie1@huawei.com>
 <YrlKZgC999AYMvXY@matsya>
 <494c689c9141429caae0285a9e778c3b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494c689c9141429caae0285a9e778c3b@huawei.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-06-22, 07:01, haijie wrote:
> Hi, Vinod,
> 
> This happens bacause I rearranged this patch without checking, it will be corrected in v2.

Please _do_ _not_ top post and reply inline to the queries. Otherwise it
is very difficult to understand...

> 
> Thanks.
> 
> -----Original Message-----
> From: Vinod Koul [mailto:vkoul@kernel.org] 
> Sent: Monday, June 27, 2022 2:13 PM
> To: haijie <haijie1@huawei.com>
> Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/8] dmaengine: hisilicon: Fix CQ head update
> 
> On 25-06-22, 15:44, Jie Hai wrote:
> > After completion of data transfer of one or multiple descriptors, the 
> > completion status and the current head pointer to submission queue are 
> > written into the CQ and interrupt can be generated to inform the 
> > software. In interrupt process CQ is read and cq_head is updated.
> > 
> > hisi_dma_irq updates cq_head only when the completion status is 
> > success. When an abnormal interrupt reports, cq_head will not update 
> > which will cause subsequent interrupt processes read the error CQ and 
> > never report the correct status.
> > 
> > This patch updates cq_head whenever CQ is accessed.
> > 
> > Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine 
> > support")
> > 
> 
> No need for blank line
> > Signed-off-by: Jie Hai <haijie1@huawei.com>
> > ---
> >  drivers/dma/hisi_dma.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c index 
> > 98bc488893cc..0a0f8a4d168a 100644
> > --- a/drivers/dma/hisi_dma.c
> > +++ b/drivers/dma/hisi_dma.c
> > @@ -436,12 +436,11 @@ static irqreturn_t hisi_dma_irq(int irq, void *data)
> >  	desc = chan->desc;
> >  	cqe = chan->cq + chan->cq_head;
> >  	if (desc) {
> > +		chan->cq_head = (chan->cq_head + 1) %
> > +				hdma_dev->chan_depth;
> > +		hisi_dma_chan_write(q_base, HISI_DMA_Q_CQ_HEAD_PTR,
> 
> q_base?
> 
> --
> ~Vinod

-- 
~Vinod
