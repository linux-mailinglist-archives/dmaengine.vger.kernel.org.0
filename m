Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236B65081C6
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiDTHPJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 03:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiDTHPI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 03:15:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBD936B55;
        Wed, 20 Apr 2022 00:12:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40C0768B05; Wed, 20 Apr 2022 09:12:18 +0200 (CEST)
Date:   Wed, 20 Apr 2022 09:12:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20220420071217.GA5152@lst.de>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru> <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru> <0baff803-b0ea-529f-095a-897398b4f63f@arm.com> <20220417224427.drwy3rchwplthelh@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417224427.drwy3rchwplthelh@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 18, 2022 at 01:44:27AM +0300, Serge Semin wrote:
> > but a DMA controller might also want to access something in the MMIO range
> > 0x0-0x7fffffff, of which it still has an identical non-offset view. If a
> > driver was previously using dma_map_resource() for that, it would now start
> > getting DMA_MAPPING_ERROR because the dma_range_map exists but doesn't
> > describe the MMIO region. I agree that in hindsight it's not an ideal
> > situation, but it's how things have ended up, so at this point I'm wary of
> > making potentially-breaking changes.
> 
> Hmm, what if the driver was previously using for instance the
> dma_direct_map_sg() method for it?

dma_map_resource is for mapping MMIO space, and must not be called on
memory in the kernel map.  For dma_map_sg (or all the other dma_map_*
interface except for dma_map_resource), the reverse is true.
