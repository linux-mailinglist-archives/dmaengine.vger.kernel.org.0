Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2954E36C
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiFPOa1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiFPOa1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4EE12D37;
        Thu, 16 Jun 2022 07:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F234F61DBE;
        Thu, 16 Jun 2022 14:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5B3C3411A;
        Thu, 16 Jun 2022 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655389824;
        bh=A/lQ0Yx89n2HEiSHLL64szIEZKxnSxO5J1hh1VcewWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/0NoEAIMqEP258x0JsV14Qoz9E7J5Ugw0wvyqQ04+O8HVJvCFrLxMlJju1Laq82n
         epUQ1jjXVhiLAWKr0oP+D7zn+lOj0Lg3L8muhazoHbjRHoTlfNTQS//VhZBncQguvE
         rcxQ9fzSjfWORtWm8xYc77w21q+gg7zWzsupIxlhq8gCgtErWgdilLwoOubx0jeX05
         nQiOb8M8gLJ1D4rpJ7gKD2c4Ix16tOUttY3y46oi02jWPWvI+NC0I4LCKdQFhy01gW
         Qq5MMzWBHC2Fw77Rm75mji/OSr66zfLy2itWb+MzupoJ+PtFGYdzXGDlzlZ8EjrsQS
         UbX/upVXO0Hng==
Date:   Thu, 16 Jun 2022 07:30:23 -0700
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Message-ID: <Yqs+f7siPc5hJRm5@matsya>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
 <Yqs1e4RMpc6ynVDN@matsya>
 <20220616135413.a4jmljwgzgpkp2uc@mobilestation>
 <20220616140157.dghcapsf7i7ccyo2@mobilestation>
 <20220616140314.nyr4owq2m2z4xtcm@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616140314.nyr4owq2m2z4xtcm@mobilestation>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-06-22, 17:03, Serge Semin wrote:
> On Thu, Jun 16, 2022 at 05:02:00PM +0300, Serge Semin wrote:
> > On Thu, Jun 16, 2022 at 04:54:13PM +0300, Serge Semin wrote:
> > > On Thu, Jun 16, 2022 at 06:51:55AM -0700, Vinod Koul wrote:
> > > > On 24-05-22, 10:21, Frank Li wrote:
> > > > > Default Designware EDMA just probe remotely at host side.
> > > > > This patch allow EDMA driver can probe at EP side.
> > > > > 
> > > > > 1. Clean up patch
> > > > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > > > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > > > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > > > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > > > 
> > > > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > > > >    dmaengine: dw-edma: Add support for chip specific flags
> > > > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > > > flags (this patch removed at v11 because dma tree already have fixed
> > > > > patch)
> > > > > 
> > > > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > > > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > > > ep
> > > > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > > > > 
> > > > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > > > >    PCI: endpoint: Add embedded DMA controller test
> > > > > 
> > > > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > > > upstream yet. So below patch show how probe eDMA driver at EP
> > > > > controller driver.
> > > > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > > > 
> > > 
> > > > Applied to dmaengine-next, thanks
> > > 
> > 
> > > Vinod, this was supposed to be merged in through PCIe repo.( I asked
> > > many times of that. Bjorn also agreed to merge it in. Could drop it
> > > from yout repo?
> > 
> 
> > I asked it several time including in the framework of this thread:
> > https://lore.kernel.org/dmaengine/20220525092306.wuansog6fe2ika3b@mobilestation/
> > There are dependencies of my patchsets from this one. Please consider
> > dropping it from your dmaengine-next repo while it's still possible
> > since taking DW eDMA and PCie patches through the PCie repo would be
> > more natural.
> 
> The only thing we were waiting for was you ack tag...

Is there any dependency, since this has many dmaengine patches and one
pcie patch which was acked by Kishon, so can go thru dmaengine tree...

I can drop if that suits all...

-- 
~Vinod
