Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD693531905
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiEWS2B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245692AbiEWS1P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 14:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE143132A21;
        Mon, 23 May 2022 11:02:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C088D614C2;
        Mon, 23 May 2022 18:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54EAC385A9;
        Mon, 23 May 2022 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653328942;
        bh=QEl52dvCC8QaJVDSZmkaFchJfe6XIe/vEqrYqi/jpWY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mqro+aXCOktBy5CLViVFAwUnSQ7mo3ctkBqilYmJ6jxH3bPPg8KovJoDYGmVzGXnb
         08fa0r6se2o9ktLoXhMpWMiMWx7u8xwkfYfNAWPsFQLjZJyjSdaZJH72t4E5LdoT7h
         lHS8hWsyHTvalveCg66zW5BRj2zb1e8WgfT7fUAVOcqF9sIWtWA4FjhuPhK02aeOdp
         XOfNY2+nBcOBDoNaWuKes02szxQe0IM7Cf0WEFZ7+LbKmHi0NieJs1GO933pCL/nPf
         cToPRn65st7nM2gfz5cmuEBYP+xnOo/+9oNs+aPi9Zyrt/1ODP4FwWXabnwehV3L75
         tCsEHAyujJs0g==
Date:   Mon, 23 May 2022 13:02:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org, Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v11 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220523180219.GA168248@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523110647.ndhijpwgtaf2rkar@mobilestation>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 23, 2022 at 02:06:47PM +0300, Serge Semin wrote:
> Hello Vinod,
> 
> On Tue, May 17, 2022 at 10:19:07AM -0500, Frank Li wrote:
> > Default Designware EDMA just probe remotely at host side.
> > This patch allow EDMA driver can probe at EP side.
> > 
> > 1. Clean up patch
> >    dmaengine: dw-edma: Detach the private data and chip info structures
> >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > 
> > 2. Enhance EDMA driver to allow prode eDMA at EP side
> >    dmaengine: dw-edma: Add support for chip specific flags
> >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > flags (this patch removed at v11 because dma tree already have fixed
> > patch)
> > 
> > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > ep
> >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > 
> > 4. change pci-epf-test to use EDMA driver to transfer data.
> >    PCI: endpoint: Add embedded DMA controller test
> > 
> > 5. Using imx8dxl to do test, but some EP functions still have not
> > upstream yet. So below patch show how probe eDMA driver at EP
> > controller driver.
> > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> 
> The series has been hanging out on review for over three months now.
> It has got to v11 and has been tested on at least two platforms. The
> original driver maintainer has been silent for all that time (most
> likely Gustavo dropped the driver maintaining role). Could you please
> merge it in seeing no comments have been posted for the last several
> weeks? The PCI Host/EP controller drivers maintainer suggested to get
> this series via the DMA-engine tree:
> https://lore.kernel.org/linux-pci/YnqlRShJzvma2SKM@lpieralisi/
> which is obviously right seeing it mainly concerns the DW eDMA driver.
> Though after that Lorenzo disappeared as quickly as popped up.)
> 
> There is one more series depending on the changes in this
> patchset:
> https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
> Me and Frank already settled all the conflicts and inter-dependencies,
> so at least his series is more than ready to be merged in into the
> kernel repo. It would be very good to get it accepted on this merge
> window so to have the kernel v5.19 with all this changes available.

Since the v5.19 merge window is already open, it seems doubtful that
anybody would merge this so late in the cycle.

If Gustavo isn't available or willing to merge it, it looks like Vinod
(maintainer of drivers/dma) would be the next logical candidate.

I suspect Vinod would appreciate an ack or reviewed-by from Kishon for 
the last patch because he maintains pci-epf-test.c.

I have a couple trivial comments on the pci-epf-test.c (I'll respond
there), but I'm not qualified to ack it.

Bjorn
