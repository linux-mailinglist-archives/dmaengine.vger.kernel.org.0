Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47362508402
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 10:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376931AbiDTIuk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 04:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376917AbiDTIuh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 04:50:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44FE1A38F;
        Wed, 20 Apr 2022 01:47:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA3C368AFE; Wed, 20 Apr 2022 10:47:46 +0200 (CEST)
Date:   Wed, 20 Apr 2022 10:47:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220420084746.GA11606@lst.de>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru> <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru> <0baff803-b0ea-529f-095a-897398b4f63f@arm.com> <20220417224427.drwy3rchwplthelh@mobilestation> <20220420071217.GA5152@lst.de> <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I can't really comment on the dma-ranges exlcusion for P2P mappings,
as that predates my involvedment, however:

On Wed, Apr 20, 2022 at 11:32:07AM +0300, Serge Semin wrote:
> See, if I get to map a virtual memory address to be accessible by any
> PCIe peripheral device, then the dma_map_sg/dma_map_page/etc
> procedures will take the PCIe host controller dma-ranges into account.
> It will work as expected and the PCIe devices will see the memory what
> I specified. But if I get to pass the physical address of the same
> page or a physical address of some device of the DEVs space to the
> dma_map_resource(), then the PCIe dma-ranges won't be taken into
> account, and the result mapping will be incorrect. That's why the
> current dma_map_resource() implementation seems very confusing to me.
> As I see it phys_addr_t is the type of the Interconnect address space,
> meanwhile dma_addr_t describes the PCIe, DEVs address spaces.
> 
> Based on what I said here and in my previous email could you explain
> what do I get wrong?

You simply must not use dma_map_resource for normal kernel memory.
So while the exclusion might be somewhat confusing, that confusion
really should not matter for any proper use of the API.
