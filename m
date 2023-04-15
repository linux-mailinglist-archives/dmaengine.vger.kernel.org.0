Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E720C6E3081
	for <lists+dmaengine@lfdr.de>; Sat, 15 Apr 2023 12:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjDOKOY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 15 Apr 2023 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDOKOY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 15 Apr 2023 06:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1455B9;
        Sat, 15 Apr 2023 03:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0290160A06;
        Sat, 15 Apr 2023 10:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7B8C433EF;
        Sat, 15 Apr 2023 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681553662;
        bh=0oNOegTSY6ZATo0hB6OS4cyxUB5rZP4EyyM7funkiGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nBhRWISsdh9uRVMsMedPH5tWOzkj8K8cvaj0F69slnttlblPZFN5twenJ4u9qeL8n
         Fz7n/OadfpLBN7WrkNtuXAoFQ3ZXQmY6D1/kGmVONbeQg6UIgMbNlm8T5kpQzbruRe
         nf/b87MJKkB17FSTlXU1TS+IgtNLX2RJS4id3ZmRM1zhRqQWErQP5Ko5Mhh7Ex0tEg
         hCHhX8wnIqGTA9RDaRE7ZVEn6495a8iUafCtCrTJPTi9AnwYPA++r22llfMV7Ta7Ci
         X75BIVt4mrzU9AuGbqclap/Q63TgTAO5CT6EdHehQFKTROqNwGLEQ4no4DNkg4a6QO
         55H4jYkHKZWUA==
Date:   Sat, 15 Apr 2023 18:03:27 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] dmaengine: dw-axi-dmac: remove unnecessary
 devm_free_irq() calling
Message-ID: <ZDp2b4M4z0/1a153@xhacker>
References: <20230313170450.897-1-jszhang@kernel.org>
 <20230313170450.897-3-jszhang@kernel.org>
 <ZDbsiKV2nOUhrRiU@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDbsiKV2nOUhrRiU@matsya>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 12, 2023 at 11:08:16PM +0530, Vinod Koul wrote:
> On 14-03-23, 01:04, Jisheng Zhang wrote:
> > In dw_remove(), We have disabled the irq from the dw-axi-dma side, so
> > we are safe against the case "The irq is still ON when devices remove
> > is executed and irq should be quiesced before remove is completed."
> 
> what about the interrupts which might fire spuriously after this? I

This is impossible becuase the irq has been disabled from the dw-axi-dma
side.

> prefer to keep this explicitly here
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index 23a10dbdecb7..56f12dfa410d 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -1542,8 +1542,6 @@ static int dw_remove(struct platform_device *pdev)
> >  	pm_runtime_disable(chip->dev);
> >  	axi_dma_suspend(chip);
> >  
> > -	devm_free_irq(chip->dev, chip->irq, chip);
> > -
> >  	of_dma_controller_free(chip->dev->of_node);
> >  
> >  	list_for_each_entry_safe(chan, _chan, &dw->dma.channels,
> > -- 
> > 2.39.2
> 
> -- 
> ~Vinod
