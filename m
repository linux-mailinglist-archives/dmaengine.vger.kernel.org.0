Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D3850A305
	for <lists+dmaengine@lfdr.de>; Thu, 21 Apr 2022 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389173AbiDUOsb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Apr 2022 10:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356573AbiDUOsa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Apr 2022 10:48:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560AE0C5;
        Thu, 21 Apr 2022 07:45:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 48D5068B05; Thu, 21 Apr 2022 16:45:37 +0200 (CEST)
Date:   Thu, 21 Apr 2022 16:45:36 +0200
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
Message-ID: <20220421144536.GA23289@lst.de>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru> <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru> <0baff803-b0ea-529f-095a-897398b4f63f@arm.com> <20220417224427.drwy3rchwplthelh@mobilestation> <20220420071217.GA5152@lst.de> <20220420083207.pd3hxbwezrm2ud6x@mobilestation> <20220420084746.GA11606@lst.de> <20220420085538.imgibqcyupvvjpaj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420085538.imgibqcyupvvjpaj@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 20, 2022 at 11:55:38AM +0300, Serge Semin wrote:
> On Wed, Apr 20, 2022 at 10:47:46AM +0200, Christoph Hellwig wrote:
> > I can't really comment on the dma-ranges exlcusion for P2P mappings,
> > as that predates my involvedment, however:
> 
> My example wasn't specific to the PCIe P2P transfers, but about PCIe
> devices reaching some platform devices over the system interconnect
> bus.

So strike PCIe, but this our definition of Peer to Peer accesses.

> What if I get to have a physical address of a platform device and want
> have that device being accessed by a PCIe peripheral device? The
> dma_map_resource() seemed very much suitable for that. But considering
> what you say it isn't.

dma_map_resource is the right thing for that.  But the physical address
of MMIO ranges in the platform device should not have struct pages
allocated for it, and thus the other dma_map_* APIs should not work on
it to start with.
