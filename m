Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922705A0BC8
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiHYIos (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 04:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbiHYIor (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 04:44:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC5242;
        Thu, 25 Aug 2022 01:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 804B6B8279B;
        Thu, 25 Aug 2022 08:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D85C433C1;
        Thu, 25 Aug 2022 08:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661417082;
        bh=aCyaJKYxssGCUyveotG+dEi4n9B/PIjkg/NM6zSggNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEP6s4U1kw+CrErlJSp1KMONAbJU3r6e+Ir4J85Gf6FuumKdAjlQX1cJmOcQE3v8Y
         QcXAwy8q+EIRiO6gYN8jPr7uGsPKrSUZioZRNiFGyzkFNDmLDEHwlNo8GB4piYz/UD
         sCpOnPp9zfStnHEa6g9vOjYUEkZHSHQRSiCLQBY/XtM3keD0joDB1y4tizPMRhIadz
         SzECgBlX/ZpDpZmMqvBfOmUXQGOuvB/yxlIvn7b+Mj6dMR4eGuh3U2tFtnBlS9YK+d
         wqWC+9zwdqX4AGUx8UoEE8HkUFOH8ZOBq6PNR8gJ9xSmhCiVp4f5t6mLyTN4ILXA+q
         AMABAU8lkOXDw==
Date:   Thu, 25 Aug 2022 14:14:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <Ywc2dOk3ChH8M460@matsya>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220823154526.GB6371@thinkpad>
 <20220824140759.7gg7t53z2xi7jxaj@mobilestation>
 <Ywb9r3f+wSkpk7gY@matsya>
 <20220825050457.esxb4oc6yht5kw6o@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825050457.esxb4oc6yht5kw6o@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-08-22, 08:04, Serge Semin wrote:
> On Thu, Aug 25, 2022 at 10:12:23AM +0530, Vinod Koul wrote:
> > On 24-08-22, 17:07, Serge Semin wrote:
> > > On Tue, Aug 23, 2022 at 09:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Aug 22, 2022 at 09:53:08PM +0300, Serge Semin wrote:
> > 
> > > > I've tested this series on Qualcomm SM8450 SoC based dev board. So,
> > > > 
> > > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > 
> > > Thanks.
> > > 
> > > > Not sure what is the merging strategy for this one but this series should get
> > > > merged into a single tree. Since the PCI patch is touching the designware
> > > > driver, merging the series into dmaengine tree might result in conflict later.
> > > 
> > > Right, the series
> > > [PATCH v5 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
> > > is supposed to be merged in first. Then this one will get to be
> > > applied with no conflicts. That's what I imply in the head of the
> > > cover-letter.
> > 
> 
> > I dont see a dependency of dma patches with PCIe patches? I guess they
> > could go thru the respective trees now..?
> 
> There is a backward dependency: the PCIe patch in this series depends
> on the eDMA patches and the patches in the patchset #3. So should you

What is the dependency...? Looking at the patches there does not seem to
be one...

> merge the eDMA patches via your tree, the later patch in this series
> and the patchset #3 would have needed to be applied in there too. So
> the patches can't be split up between different branches. Seeing all
> the changes (including the DW eDMA part) concern the PCIe device (DW
> eDMA is a part of either DW PCIe End-point or Root Port) and we
> already agreed to merge all the changes via the PCIe tree, I would
> stick to the previous settled agreement.
> 
> -Sergey
> 
> > 
> > -- 
> > ~Vinod

-- 
~Vinod
