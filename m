Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1EE583F2A
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbiG1Msi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 08:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiG1Msh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 08:48:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966232A735;
        Thu, 28 Jul 2022 05:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51BADB82444;
        Thu, 28 Jul 2022 12:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38116C433D6;
        Thu, 28 Jul 2022 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659012514;
        bh=GqVou8FJ9PvJ260MOYcAAAtI+MUkQSlq45F1U6gbAY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODU0OqvM3AR+wqq3g55htv08CeOrpl8Blt3t3Tyadr1BNcZXCFIZfsD002olR0Onn
         p1qTf/eljP+4xjyrGZ6tJ03kltSHGK8EntLejCOVpv0W+8Ye4rGsnRdsWvtV7MBfga
         kQIPjyjTKZ1TjEGBAVlQVljI2GA8CmDDZ1t72oTyyyza3BOSFZAwTm6nZVQXug/F4S
         FjmjnnFcaDPyKzYCBn5+d0hZEkFFRIWe0PC/CY+PuJBVmHPI9VfCqU5nSr+cwM99ar
         wUxvwm7AhBTdbx6jcRvLgy3P5BKCK92Qpy1ZYAM5TdtKJphcUkuf8kQZWUw9oMCm0b
         INHHJAkF0Ieng==
Date:   Thu, 28 Jul 2022 18:18:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <YuKFnjrxnyNa+98X@matsya>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
 <YtlDivjaXfSEK1Xg@matsya>
 <20220728113359.hs54apv22bo5bnyr@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728113359.hs54apv22bo5bnyr@mobilestation>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-07-22, 14:33, Serge Semin wrote:
> On Thu, Jul 21, 2022 at 05:46:10PM +0530, Vinod Koul wrote:
> > On 10-06-22, 12:14, Serge Semin wrote:
> > > This is a final patchset in the series created in the framework of
> > > my Baikal-T1 PCIe/eDMA-related work:
> > > 
> > > [1: In-progress v4] PCI: dwc: Various fixes and cleanups
> > > Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
> > > [2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
> > > Link: https://lore.kernel.org/linux-pci/20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru/
> > > [3: In-progress v3] PCI: dwc: Add generic resources and Baikal-T1 support
> > > Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> > > [4: In-progress v3] dmaengine: dw-edma: Add RP/EP local DMA support
> > > Link: ---you are looking at it---
> > > 
> > > Note it is very recommended to merge the patchsets in the same order as
> > > they are listed in the set above in order to have them applied smoothly.
> > > Nothing prevents them from being reviewed synchronously though.
> > > 
> > > Please note originally this series was self content, but due to Frank
> > > being a bit faster in his work submission I had to rebase my patchset onto
> > > his one. So now this patchset turns to be dependent on the Frank' work:
> > > 
> > > Link: https://lore.kernel.org/linux-pci/20220524152159.2370739-1-Frank.Li@nxp.com/
> > > 
> > > So please merge Frank' series first before applying this one.
> > > 
> > > Here is a short summary regarding this patchset. The series starts with
> > > fixes patches. We discovered that the dw-edma-pcie.c driver incorrectly
> > > initializes the LL/DT base addresses for the platforms with not matching
> > > CPU and PCIe memory spaces. It is fixed by using the pci_bus_address()
> > > method to get a correct base address. After that you can find a series of
> > > the interleaved xfers fixes. It turned out the interleaved transfers
> > > implementation didn't work quite correctly from the very beginning for
> > > instance missing src/dst addresses initialization, etc. In the framework
> > > of the next two patches we suggest to add a new platform-specific
> > > callback - pci_address() and use it to convert the CPU address to the PCIe
> > > space address. It is at least required for the DW eDMA remote End-point
> > > setup on the platforms with not-matching CPU/PCIe address spaces. In case
> > > of the DW eDMA local RP/EP setup the conversion will be done automatically
> > > by the outbound iATU (if no DMA-bypass flag is specified for the
> > > corresponding iATU window). Then we introduce a set of the patches to make
> > > the DebugFS part of the code supporting the multi-eDMA controllers
> > > platforms. It starts with several cleanup patches and is closed joining
> > > the Read/Write channels into a single DMA-device as they originally should
> > > have been. After that you can find the patches with adding the non-atomic
> > > io-64 methods usage, dropping DT-region descriptors allocation, replacing
> > > chip IDs with the device name. In addition to that in order to have the
> > > eDMA embedded into the DW PCIe RP/EP supported we need to bypass the
> > > dma-ranges-based memory ranges mapping since in case of the root port DT
> > > node it's applicable for the peripheral PCIe devices only. Finally at the
> > > series closure we introduce a generic DW eDMA controller support being
> > > available in the DW PCIe Root Port/Endpoint driver.
> > 
> 
> > Acked-By: Vinod Koul <vkoul@kernel.org>
> 
> Thanks, Vinod! The series will be merged in after the patchset
> [PATCH vX 00/17] PCI: dwc: Add generic resources and Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> is done with Rob' review (I failed to reach him with a few issues
> lately). I'll add your ab-tag to this one on the next patchset re-spin
> (rebase will be likely needed).

You can cc Krzysztof (cced him0, maybe he can help with review of DT
parts

thanks
-- 
~Vinod
