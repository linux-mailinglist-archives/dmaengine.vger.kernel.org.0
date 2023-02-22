Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE77169F8D6
	for <lists+dmaengine@lfdr.de>; Wed, 22 Feb 2023 17:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjBVQRE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Feb 2023 11:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjBVQRE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Feb 2023 11:17:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E563D92D;
        Wed, 22 Feb 2023 08:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BC30B815FE;
        Wed, 22 Feb 2023 16:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F13C4339B;
        Wed, 22 Feb 2023 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677082599;
        bh=oSY7Y9Zfx4h7Oesy7kW3oqZLMo+eNjfwJ8NKRdJV7P8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rgt10Cg3vw91PKKDI8NVq1IUBtcIwA4nFqncr6kVdagud6EGFgXr8SREpdFYxKwXW
         QvSy9okHFWIIj4P3TnGT1Kqlm8mE+pXi53LYDimtAIfq1ctqXwDumvS339Dg9MSrFj
         Gg0CYteekRxFGmVux453qmLav9Ccwpr8dxJbnpRTYijjToVcozliL01mZPOokvlWue
         VfriYexDmJILzCE0kxwq/Zo9VO3bvRfJgkdP0j5bkNRoGCW3N23FDWUhbwlySznhOx
         Xlt46N3FreZ4eMBjP9TB13wLJFQ5BARH73eC/+bZOxHWpb54SbGrFSfaMBtKKcW792
         K9N/nWVOl+05Q==
Date:   Wed, 22 Feb 2023 21:46:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v9 23/27] dmaengine: dw-edma: Add mem-mapped LL-entries
 support
Message-ID: <Y/Y/48E/8lYFTo2D@matsya>
References: <20230113171409.30470-24-Sergey.Semin@baikalelectronics.ru>
 <20230221230054.GA3736402@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221230054.GA3736402@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-02-23, 17:00, Bjorn Helgaas wrote:
> On Fri, Jan 13, 2023 at 08:14:05PM +0300, Serge Semin wrote:
> > Currently the DW eDMA driver only supports the linked lists memory
> > allocated locally with respect to the remote eDMA engine setup. It means
> > the linked lists will be accessible by the CPU via the MMIO space only. If
> > eDMA is embedded into the DW PCIe Root Ports or local End-points (which
> > support will be added in one of the following up commits) the linked lists
> > are supposed to be allocated in the CPU memory. In that case the
> > LL-entries can be directly accessed meanwhile the former case implies
> > using the MMIO-accessors for that.
> > 
> > In order to have both cases supported by the driver the dw_edma_region
> > descriptor should be fixed to contain the MMIO-backed and just
> > memory-based virtual addresses. The linked lists initialization procedure
> > will use one of them depending on the eDMA device nature. If the eDMA
> > engine is embedded into the local DW PCIe RP/EP controllers then the list
> > entries will be directly accessed by referencing the corresponding
> > structure fields.  Otherwise the MMIO accessors usage will be preserved.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Hi Vinod, I just realized that I didn't solicit your ack for this
> patch and the following one (which I ended up splitting into two), and
> I hate to ask Linus to pull them without your OK.
> 
> Here are the current versions in the PCI tree:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=b47364a83054
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=157ce95927c1
>   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=536e6529e975
> 
> If you ack them, I will update them to reflect that.

Thanks for letting me know:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
