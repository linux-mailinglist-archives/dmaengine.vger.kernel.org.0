Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF0667820D
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jan 2023 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjAWQo1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Jan 2023 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjAWQoV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Jan 2023 11:44:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC614EB4;
        Mon, 23 Jan 2023 08:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D51B0B80BA2;
        Mon, 23 Jan 2023 16:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EF1C433D2;
        Mon, 23 Jan 2023 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674492221;
        bh=WqiKybcgqHZWpuB4CvE00HHXeoUcUZQ/JLOLaoCTkjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VMfiu99BCpzXWevJaNTFsM7TvomFshh155tDVnj617ku4vl+uGiV/afQxhpl51xYZ
         5/aKaa6OyNCwO6e9q1Vrp0kXheC3K/ETLPsFeLWBxiS76uDirPdh160vf5J6uYiz4s
         abPu/xzky904dYcqdiC27e2B/YUuSdYp0QkTDKD3s7TYgO1rVggtOtHeJJEICbtUqK
         wXB15hTfqe4/ZKJ4kmibkxznxf+m9eoUNboDd8ENZZhMWVzt6Z4m4AXWkVCeXy+OT+
         /RqlQf1xn6I79xpgZQ0hxAAQ2lauf9uN/3pFVTk/Vv2c6KA1atbyBUIH4Vj85Y3SnA
         pCFUI5I27C/uA==
Date:   Mon, 23 Jan 2023 10:43:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230123164339.GA892847@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122001116.jbhttuaed7zuls26@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jan 22, 2023 at 03:11:16AM +0300, Serge Semin wrote:
> On Fri, Jan 20, 2023 at 04:50:36PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 13, 2023 at 08:14:06PM +0300, Serge Semin wrote:
> > > Since the DW PCIe RP/EP driver is about to be updated to register the DW
> > > eDMA-based DMA-engine the drivers build modes must be synchronized.
> > > Currently the DW PCIe RP/EP driver is always built as a builtin module.
> > > Meanwhile the DW eDMA driver can be built as a loadable module. Thus in
> > > the later case the kernel with DW PCIe controllers support will fail to be
> > > linked due to lacking the DW eDMA probe/remove symbols. At the same time
> > > forcibly selecting the DW eDMA driver from the DW PCIe RP/EP kconfig will
> > > effectively eliminate the tristate type of the former driver fixing it to
> > > just the builtin kernel module.
> > > 
> > > Seeing the DW eDMA engine isn't that often met built into the DW PCIe
> > > Root-ports and End-points let's convert the DW eDMA driver config to being
> > > more flexible instead of just forcibly selecting the DW eDMA kconfig. In
> > > order to do that first the DW eDMA PCIe driver config should be converted
> > > to being depended from the DW eDMA core config instead of selecting the
> > > one. Second the DW eDMA probe and remove symbols should be referenced only
> > > if they are reachable by the caller. Thus the user will be able to build
> > > the DW eDMA core driver with any type, meanwhile the dependent code will
> > > be either restricted to the same build type (e.g. DW eDMA PCIe driver if
> > > DW eDMA driver is built as a loadable module) or just won't be able to use
> > > the eDMA engine registration/de-registration functionality (e.g. DW PCIe
> > > RP/EP driver if DW eDMA driver is built as a loadable module).
> > 
> > I'm trying to write the merge commit log, and I understand the linking
> > issue, but I'm having a hard time figuring out what the user-visible
> > scenarios are here.
> > 
> > I assume there's something that works when CONFIG_PCIE_DW=y and
> > CONFIG_DW_EDMA_PCIE=y but does *not* work when CONFIG_PCIE_DW=y and
> > CONFIG_DW_EDMA_PCIE=m?
> 
> No. The DW eDMA code availability (in other words the CONFIG_DW_EDMA
> config value) determines whether the corresponding driver (DW PCIe
> RP/EP or DW eDMA PCI) is capable to perform the eDMA engine probe
> procedure. Additionally both drivers has the opposite dependency from
> the DW eDMA code.
> |                |     DW PCIe RP/EP    |     DW eDMA PCIe     |
> | CONFIG_DW_EDMA +----------------------+----------------------+
> |                | Probe eDMA | KConfig | Probe eDMA | Kconfig |
> +----------------+------------+---------+------------+---------+
> |        y       |     YES    |   y,n   |     YES    |  y,m,n  |
> |        m       |     NO     |   y,n   |     YES    |    m,n  |
> |        n       |     NO     |   y,n   |     NO     |      n  |
> +--------------------------------------------------------------+
> 
> Basically it means the DW PCIe RP/EP driver will be able to probe the
> DW eDMA engine only if the corresponding driver is built into the
> kernel. At the same time the DW PCIe RP/EP driver doesn't depend on
> the DW eDMA core module config state. The DW eDMA PCIe driver in
> opposite depends on the DW eDMA code config state, but will always be
> able to probe the DW eDMA engine as long as the corresponding code is
> loaded as either a part of the kernel or as a loadable module.
> 
> > If both scenarios worked the same, I would think the existing
> > dw_edma_pcie_probe() would be enough, and you wouldn't need to call
> > dw_pcie_edma_detect() from dw_pcie_host_init() and dw_pcie_ep_init().
> 
> No. These methods have been implemented for the absolutely different
> drivers.
> dw_edma_pcie_probe() is called for an end-point PCIe-device found on a
> PCIe-bus.
> dw_pcie_host_init()/dw_pcie_ep_init() and dw_pcie_edma_detect() are
> called for a platform-device representing a DW PCIe RP/EP controller.
> In other words dw_pcie_edma_detect() and dw_edma_pcie_probe() are in
> no means interchangeable.

The question is what the user-visible difference between
CONFIG_DW_EDMA_PCIE=y and CONFIG_DW_EDMA_PCIE=m is.  If there were no
difference, dw_pcie_host_init() would not need to call
dw_pcie_edma_detect().

Can you give me a one- or two-sentence merge commit comment that
explains why we want to merge this?  "Relax driver config settings"
doesn't tell us that.

Bjorn
