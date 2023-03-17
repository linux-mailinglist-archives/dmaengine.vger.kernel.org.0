Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23C6BEFB6
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCQRbv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCQRbu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E1497FF;
        Fri, 17 Mar 2023 10:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DD8A60DD7;
        Fri, 17 Mar 2023 17:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11460C433D2;
        Fri, 17 Mar 2023 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074307;
        bh=PN3QZZsyf/Xo25dtyOqsrHcyc+O4s0z/dugNQ+Y9gac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZlM9yVQ4QZO/XX/qxoxEXD3tJ8KciWSTw98YGm4uxIFVgvwF2OEfLy17aKXpNAjh
         iqgGvQOnJEAgi1tUiJbVqTnsRRf9JXSRF70KkrqxvXThJ0fnL1JBu6sNAjZEmqZZ1L
         fpW1sr+b4WeDIQ723iOVgzxQabgFoliWpGItqeS/iHYE/0mSnlK4+Nmnm/JebAXkG4
         hMix2ppkKOb4SFUlHheYHpNv8XSF1G3tEMEhoCMWs6JJxxJZ8cdwZAyaQdO0SChGb7
         FsbOYC0DqEkfZhQJDwJetFaTEeAn/cP7ZaUdXyVwrE/dlOFK5PEzyk0R6eu3bdd31y
         A9+Qq2t8PU4rA==
Date:   Fri, 17 Mar 2023 23:01:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Kang Chen <void0red@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: add null check of devm_kasprintf in
 edma_probe and udma_probe
Message-ID: <ZBSj/0kIGVROIGi7@matsya>
References: <20230226094038.3227062-1-void0red@gmail.com>
 <c0a50add-5c76-8e16-f65b-803d4389b36f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0a50add-5c76-8e16-f65b-803d4389b36f@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-03-23, 22:01, Péter Ujfalusi wrote:
> Hi,
> 
> On 26/02/2023 11:40, Kang Chen wrote:
> > devm_kasprintf may fails, irq_name and uc->name might be null and wrong irq
> > name will be used in request.
> 
> In general, I would have preferred to have separate patches for the two
> drivers to make them easier to backport if one decides.

Right these should be separate

> 
> If you decide to resend, you can add my to them:
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> 
> > 
> > Signed-off-by: Kang Chen <void0red@gmail.com>
> > ---
> >   drivers/dma/ti/edma.c    | 8 ++++++++
> >   drivers/dma/ti/k3-udma.c | 2 ++
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> > index fa06d7e6d..85cd72b64 100644
> > --- a/drivers/dma/ti/edma.c
> > +++ b/drivers/dma/ti/edma.c
> > @@ -2413,6 +2413,10 @@ static int edma_probe(struct platform_device *pdev)
> >   	if (irq >= 0) {
> >   		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
> >   					  dev_name(dev));
> > +		if (!irq_name) {
> > +			ret = -ENOMEM;
> > +			goto err_disable_pm;
> > +		}
> >   		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
> >   				       ecc);
> >   		if (ret) {
> > @@ -2429,6 +2433,10 @@ static int edma_probe(struct platform_device *pdev)
> >   	if (irq >= 0) {
> >   		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
> >   					  dev_name(dev));
> > +		if (!irq_name) {
> > +			ret = -ENOMEM;
> > +			goto err_disable_pm;
> > +		}
> >   		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
> >   				       ecc);
> >   		if (ret) {
> > diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> > index 7e23a6fde..692d1d25c 100644
> > --- a/drivers/dma/ti/k3-udma.c
> > +++ b/drivers/dma/ti/k3-udma.c
> > @@ -5494,6 +5494,8 @@ static int udma_probe(struct platform_device *pdev)
> >   		uc->config.dir = DMA_MEM_TO_MEM;
> >   		uc->name = devm_kasprintf(dev, GFP_KERNEL, "%s chan%d",
> >   					  dev_name(dev), i);
> > +		if (!uc->name)
> > +			return -ENOMEM;
> >   		vchan_init(&uc->vc, &ud->ddev);
> >   		/* Use custom vchan completion handling */
> 
> -- 
> Péter

-- 
~Vinod
