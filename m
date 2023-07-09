Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B574C1F3
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jul 2023 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGIKqY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Jul 2023 06:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjGIKqX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Jul 2023 06:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BFC115;
        Sun,  9 Jul 2023 03:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4A560BC1;
        Sun,  9 Jul 2023 10:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081FDC433C8;
        Sun,  9 Jul 2023 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688899580;
        bh=MFSm4hfkC4hsq6p/NQ8yKPw77r5Iebg5JnxW264clgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aq+XhyMl++xTDOAJC8f8Dj1ndI5RjxdmqfBl5+8yjTu/1mhBHpbnHtDwFAvBgmgDg
         9swwGinlU2if86dP3VzIR5zlhCEzco/URwgFO4Yz4WSgW6YLv1XHqyvwXtu6Qzzlwi
         LXt+zTElSywFKnR/rtyGUYPsxMgiWghOCYaDhn22ya1AjygWj4Aq1Y4kG+EXXYTGPO
         t33RpNrqh8czezbJSrFArQ9hx5/ekeLh8uFSUX6ooXAfzAz4fJ9SmlbTMOD9aUmaSy
         /2UH6Yn+/mYroYmA5Xqo7eBISaUncDbwgyE7hM7YXVPK2sjvHJllQCXZ1qpbPD/Hog
         WLqM9GjPhi5wg==
Date:   Sun, 9 Jul 2023 16:16:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, joy.zou@nxp.com,
        shenwei.wang@nxp.com, imx@lists.linux.dev
Subject: Re: [PATCH v9 12/13] dmaengine: fsl-edma: integrate v3 support
Message-ID: <ZKqP+BNhFPswyXkB@matsya>
References: <20230620201221.2580428-1-Frank.Li@nxp.com>
 <20230620201221.2580428-13-Frank.Li@nxp.com>
 <ZKemOm9OfQK8NkpL@matsya>
 <ZKg7b/RJyCrmsQQ7@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKg7b/RJyCrmsQQ7@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-07-23, 12:21, Frank Li wrote:
> On Fri, Jul 07, 2023 at 11:14:26AM +0530, Vinod Koul wrote:
> > On 20-06-23, 16:12, Frank Li wrote:
> > > +		}
> > > +
> > > +		fsl_chan->pd_dev = pd_chan;
> > > +
> > > +		pm_runtime_use_autosuspend(fsl_chan->pd_dev);
> > > +		pm_runtime_set_autosuspend_delay(fsl_chan->pd_dev, 200);
> > > +		pm_runtime_set_active(fsl_chan->pd_dev);
> > > +		//pm_runtime_put_sync_suspend(fsl_chan->pd_dev);
> > 
> > Ouch!
> > 
> > Always remember to run checkpatch on your code before sending!
> > 
> 
> ./scripts/checkpatch.pl v9-0012-dmaengine-fsl-edma-integrate-v3-support.patch
> total: 0 errors, 0 warnings, 769 lines checked

This should have been caught, strange..
Run with --strict option?

> 
> v9-0012-dmaengine-fsl-edma-integrate-v3-support.patch has no obvious style problems and is ready for submission.
> 
> anyway, I will fix this.
> 
> Frank
> 
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int fsl_edma_probe(struct platform_device *pdev)
> > >  {
> > >  	const struct of_device_id *of_id =
> > > @@ -234,6 +412,7 @@ static int fsl_edma_probe(struct platform_device *pdev)
> > >  	struct fsl_edma_engine *fsl_edma;
> > >  	const struct fsl_edma_drvdata *drvdata = NULL;
> > >  	struct fsl_edma_chan *fsl_chan;
> > > +	u32 chan_mask[2] = {0, 0};
> > >  	struct edma_regs *regs;
> > >  	int len, chans;
> > >  	int ret, i;
> > > @@ -264,8 +443,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
> > >  	if (IS_ERR(fsl_edma->membase))
> > >  		return PTR_ERR(fsl_edma->membase);
> > >  
> > > -	fsl_edma_setup_regs(fsl_edma);
> > > -	regs = &fsl_edma->regs;
> > > +	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)) {
> > > +		fsl_edma_setup_regs(fsl_edma);
> > > +		regs = &fsl_edma->regs;
> > > +	}
> > >  
> > >  	if (drvdata->flags & FSL_EDMA_DRV_HAS_DMACLK) {
> > >  		fsl_edma->dmaclk = devm_clk_get_enabled(&pdev->dev, "dma");
> > > @@ -275,9 +456,29 @@ static int fsl_edma_probe(struct platform_device *pdev)
> > >  		}
> > >  	}
> > >  
> > > +	if (drvdata->flags & FSL_EDMA_DRV_HAS_CHCLK) {
> > > +		fsl_edma->chclk = devm_clk_get_enabled(&pdev->dev, "mp");
> > > +		if (IS_ERR(fsl_edma->chclk)) {
> > > +			dev_err(&pdev->dev, "Missing MP block clock.\n");
> > > +			return PTR_ERR(fsl_edma->chclk);
> > > +		}
> > > +	}
> > > +
> > > +	ret = of_property_read_variable_u32_array(np, "dma-channel-mask", chan_mask, 1, 2);
> > > +
> > > +	if (ret > 0) {
> > > +		fsl_edma->chan_masked = chan_mask[1];
> > > +		fsl_edma->chan_masked <<= 32;
> > > +		fsl_edma->chan_masked |= chan_mask[0];
> > > +	}
> > > +
> > >  	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
> > >  		char clkname[32];
> > >  
> > > +		/* eDMAv3 mux register move to TCD area if ch_mux exist */
> > > +		if (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG)
> > > +			break;
> > > +
> > >  		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
> > >  								      1 + i);
> > >  		if (IS_ERR(fsl_edma->muxbase[i])) {
> > > @@ -297,9 +498,18 @@ static int fsl_edma_probe(struct platform_device *pdev)
> > >  
> > >  	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");
> > >  
> > > +	if (drvdata->flags & FSL_EDMA_DRV_HAS_PD) {
> > > +		ret = fsl_edma3_attach_pd(pdev, fsl_edma);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > >  	INIT_LIST_HEAD(&fsl_edma->dma_dev.channels);
> > >  	for (i = 0; i < fsl_edma->n_chans; i++) {
> > > -		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
> > > +		fsl_chan = &fsl_edma->chans[i];
> > > +
> > > +		if (fsl_edma->chan_masked & BIT(i))
> > > +			continue;
> > >  
> > >  		snprintf(fsl_chan->chan_name, sizeof(fsl_chan->chan_name), "%s-CH%02d",
> > >  							   dev_name(&pdev->dev), i);
> > > @@ -310,8 +520,13 @@ static int fsl_edma_probe(struct platform_device *pdev)
> > >  		fsl_chan->idle = true;
> > >  		fsl_chan->dma_dir = DMA_NONE;
> > >  		fsl_chan->vchan.desc_free = fsl_edma_free_desc;
> > > -		fsl_chan->tcd = fsl_edma->membase + EDMA_TCD
> > > -				+ i * sizeof(struct fsl_edma_hw_tcd);
> > > +
> > > +		len = (drvdata->flags & FSL_EDMA_DRV_SPLIT_REG) ?
> > > +				offsetof(struct fsl_edma3_ch_reg, tcd) : 0;
> > > +		fsl_chan->tcd = fsl_edma->membase
> > > +				+ i * drvdata->chreg_space_sz + drvdata->chreg_off + len;
> > > +
> > > +		fsl_chan->pdev = pdev;
> > >  		vchan_init(&fsl_chan->vchan, &fsl_edma->dma_dev);
> > >  
> > >  		edma_write_tcdreg(fsl_chan, 0, csr);
> > > @@ -345,12 +560,25 @@ static int fsl_edma_probe(struct platform_device *pdev)
> > >  
> > >  	fsl_edma->dma_dev.src_addr_widths = FSL_EDMA_BUSWIDTHS;
> > >  	fsl_edma->dma_dev.dst_addr_widths = FSL_EDMA_BUSWIDTHS;
> > > +
> > > +	if (drvdata->flags & FSL_EDMA_DRV_BUS_8BYTE) {
> > > +		fsl_edma->dma_dev.src_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > +		fsl_edma->dma_dev.dst_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > > +	}
> > > +
> > >  	fsl_edma->dma_dev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > > +	if (drvdata->flags & FSL_EDMA_DRV_DEV_TO_DEV)
> > > +		fsl_edma->dma_dev.directions |= BIT(DMA_DEV_TO_DEV);
> > > +
> > > +	fsl_edma->dma_dev.copy_align = drvdata->flags & FSL_EDMA_DRV_ALIGN_64BYTE ?
> > > +					DMAENGINE_ALIGN_64_BYTES :
> > > +					DMAENGINE_ALIGN_32_BYTES;
> > >  
> > > -	fsl_edma->dma_dev.copy_align = DMAENGINE_ALIGN_32_BYTES;
> > >  	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
> > >  	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
> > >  
> > > +	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> > > +
> > >  	platform_set_drvdata(pdev, fsl_edma);
> > >  
> > >  	ret = dma_async_device_register(&fsl_edma->dma_dev);
> > > @@ -360,7 +588,9 @@ static int fsl_edma_probe(struct platform_device *pdev)
> > >  		return ret;
> > >  	}
> > >  
> > > -	ret = of_dma_controller_register(np, fsl_edma_xlate, fsl_edma);
> > > +	ret = of_dma_controller_register(np,
> > > +			drvdata->flags & FSL_EDMA_DRV_SPLIT_REG ? fsl_edma3_xlate : fsl_edma_xlate,
> > > +			fsl_edma);
> > >  	if (ret) {
> > >  		dev_err(&pdev->dev,
> > >  			"Can't register Freescale eDMA of_dma. (%d)\n", ret);
> > > @@ -369,7 +599,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
> > >  	}
> > >  
> > >  	/* enable round robin arbitration */
> > > -	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
> > > +	if (!(drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
> > > +		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
> > >  
> > >  	return 0;
> > >  }
> > > -- 
> > > 2.34.1
> > 
> > -- 
> > ~Vinod

-- 
~Vinod
