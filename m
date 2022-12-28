Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BD7657592
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 12:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiL1LDR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 06:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiL1LDC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 06:03:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8AEFCC9;
        Wed, 28 Dec 2022 03:03:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ADAFB8120C;
        Wed, 28 Dec 2022 11:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98D5C433EF;
        Wed, 28 Dec 2022 11:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672225378;
        bh=Jbc8fHFUzvmzYj/mYnldsorEIWVL9g9+hlCte94smN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0IS6MWadTuC2MA6rSteotPG1AULwI6VcUsBisG+qQTyV6/rIYIX02b9alcQnXZLW
         Je1qhgxeWinPGk3b558tpXDZr8BjSGDFSfHEFnvfH2/q3PmgW8Z+s72woJ3X8m3zTa
         14Mb6vII8Sp67bCOoNBxFx0v5lzCcKqKGxfuawkx6T832KC3R8SiS+Nu/RJYSAaGtp
         Z+cZR/OI25ecfp27cLAu3FfwazbECMBI2TZN/S0GzRNXDw9VQVZf1MAHr36ssWJGNR
         RMCIKVT0drtc5Zg579GLT7ct6W26nRmUz3rm0oRUnWrp7cZ6PKyJyQ5y/UY4W54tLJ
         yHmKvGI+jlYzg==
Date:   Wed, 28 Dec 2022 16:32:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Jayesh Choudhary <j-choudhary@ti.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-udma: drop loglevel for non-fatal
 probe deferral log
Message-ID: <Y6wiXlZh1MUL2WrF@matsya>
References: <20221128101334.512816-1-j-choudhary@ti.com>
 <f954e71b-043c-43bc-a692-530497de2d0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f954e71b-043c-43bc-a692-530497de2d0b@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-11-22, 18:28, Péter Ujfalusi wrote:
> 
> 
> On 28/11/2022 12:13, Jayesh Choudhary wrote:
> > Change the log level from dev_err() to dev_dbg() for non-fatal probe
> > deferral log for getting MSI domain.
> > This makes the kernel log clean and we do not get recurring logs
> > stating: "Failed to get MSI domain".
> 
> Or not print at all?

that would be better one :-)

> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> 
> > 
> > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > ---
> >   drivers/dma/ti/k3-udma.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> > index ce8b80bb34d7..e540166cf4c7 100644
> > --- a/drivers/dma/ti/k3-udma.c
> > +++ b/drivers/dma/ti/k3-udma.c
> > @@ -5344,7 +5344,7 @@ static int udma_probe(struct platform_device *pdev)
> >   	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
> >   					    DOMAIN_BUS_TI_SCI_INTA_MSI);
> >   	if (!dev->msi.domain) {
> > -		dev_err(dev, "Failed to get MSI domain\n");
> > +		dev_dbg(dev, "Failed to get MSI domain\n");
> >   		return -EPROBE_DEFER;
> >   	}
> 
> -- 
> Péter

-- 
~Vinod
