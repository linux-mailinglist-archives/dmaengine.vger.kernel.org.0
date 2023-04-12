Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722BC6DFC01
	for <lists+dmaengine@lfdr.de>; Wed, 12 Apr 2023 18:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDLQ6a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Apr 2023 12:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDLQ63 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Apr 2023 12:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB11D9EC3;
        Wed, 12 Apr 2023 09:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65E6561169;
        Wed, 12 Apr 2023 16:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F623C4339B;
        Wed, 12 Apr 2023 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681318689;
        bh=mvIllIwwL0a3N/4obdyiGIoypl2z7EHLEGkWiecz4W4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=If4vMZlVFmDy4ncqrtHqk9rr1iXk9l3r/MmO2bK2bDYqMNXk42gBYefyiSPPm71d3
         Gw5GkARm8UyQLJdPj5rbPqtENXbffZCHV6Kar2gKsdaeNb4/0/iXjovTfQJRYlmd+P
         qJy3mZ7KE5j5jxZAaVgvKtGwb7HH/ulLTCaKAHwqbi/m2oLmZYvDQO6GtJA0Ijbp7Q
         7afHh3B4zLBvzNQE0MCn0ilUbSCI+eaoE557JjBhG5lFr4SN11yItMQgPuDI8HeUXS
         hL4dcLIcqMBmAsk1OKYKqNBbAmB7p4j+9daLFIVl7HhYAnNpD5S5RD8QrJ5GouW7/3
         V29DR5/yTbwbA==
Date:   Wed, 12 Apr 2023 22:28:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 00/10] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <ZDbjHTenZMxfziZD@matsya>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411110240.GB5333@thinkpad>
 <20230411165924.4zfwhwxacxxeg7rk@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411165924.4zfwhwxacxxeg7rk@mobilestation>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-04-23, 19:59, Serge Semin wrote:
> On Tue, Apr 11, 2023 at 04:32:40PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Apr 11, 2023 at 06:39:18AM +0300, Serge Semin wrote:
> > > It turns out the recent DW PCIe-related patchset was merged in with
> > > several relatively trivial issues left unsettled (noted by Bjorn and
> > > Manivannan). All of these lefovers have been fixed in this patchset.
> > > Namely the series starts with two bug-fixes. The first one concerns the
> > > improper link-mode initialization in case if the CDM-check is enabled. The
> > > second unfortunate mistake I made in the IP-core version type helper. In
> > > particular instead of testing the IP-core version type the macro function
> > > referred to the just IP-core version which obviously wasn't what I
> > > intended.
> > > 
> > > Afterwards two @Mani-noted fixes follow. Firstly the dma-ranges related warning
> > > message is fixed to start with "DMA-ranges" word instead of "Dma-ranges".
> > > Secondly the Baikal-T1 PCIe Host driver is converted to perform the
> > > asynchronous probe type which saved us of about 15% of bootup time if no any
> > > PCIe peripheral device attached to the port.
> > > 
> > > Then the patchset contains the Baikal-T1 PCIe driver fix. The
> > > corresponding patch removes the false error message printed during the
> > > controller probe procedure. I accidentally added the unconditional
> > > dev_err_probe() method invocation. It was obviously wrong.
> > > 
> > > Then two trivial cleanups are introduced. The first one concerns the
> > > duplicated fast-link-mode flag unsetting. The second one implies
> > > dropping a redundant empty line from the dw_pcie_link_set_max_speed()
> > > function.
> > > 
> > > The series continues with a patch inspired by the last @Bjorn note
> > > regarding the generic resources request interface. As @Bjorn correctly
> > > said it would be nice to have the new interface used wider in the DW PCIe
> > > subsystem. Aside with the Baikal-T1 PCIe Host driver the Toshiba Visconti
> > > PCIe driver can be easily converted to using the generic clock names.
> > > That's what is done in the noted patch.
> > > 
> > > The patchset is closed with a series of MAINTAINERS-list related patches.
> > > Firstly after getting the DW PCIe RP/EP DT-schemas refactored I forgot to
> > > update the MAINTAINER-list with the new files added in the framework of
> > > that procedure. All the snps,dw-pcie* schemas shall be maintained by the
> > > DW PCIe core driver maintainers. Secondly seeing how long it took for my
> > > patchsets to review and not having any comments from the original driver
> > > maintainers I'd suggest to add myself as the reviewer to the DW PCIe and
> > > eDMA drivers. Thus hopefully the new updates review process will be
> > > performed with much less latencies. For the same reason I would also like
> > > to suggest to add @Manivannan as the DW PCIe/eDMA drivers maintainer if
> > > he isn't against that idea. What do you think about the last suggestion?
> > > 
> > 
> > I'm willing to co-maintain the drivers.
> 
> Awesome! @Bjorn, @Lorenzo, @Vinod what do you think about this? If you
> are ok with that shall I resubmit the series with @Mani added to the
> DW PCIe/eDMA maintainers list or will you create the respective
> patches yourself?

Pls send the patch, that is preferred.

-- 
~Vinod
