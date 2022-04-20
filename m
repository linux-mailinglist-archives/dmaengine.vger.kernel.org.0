Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2810D508373
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 10:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiDTIe6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 04:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiDTIe6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 04:34:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF5DF5B;
        Wed, 20 Apr 2022 01:32:12 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x17so1503445lfa.10;
        Wed, 20 Apr 2022 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GPxsA15dgGFa86oqnVuniKPo2oEPXdNE69XGNs7GEZ4=;
        b=biTEx2Cij71YqsgTogTpKJ8RDg3A4KiMWrobTDx7XvAfIcXCkppoYtn+feizM0q9bN
         qHO57uy1m2cSKYzDI5swmGJKnDovfPekAfPti7mvLhItxH6otCLSJPr4QLXicY4A6xDH
         RA0K6hcuvmlowJsHqtKzeRXi8AOtCaC1wPOtyEO0s2TTTLa6xVkzSOf1iHgDAfrLNwSC
         j+6be8/t8BQfIuOrjfRiJ9ctDYQtCIjd3KMngyqzwwCAlBQJrol4lwCPWdW+tbS7dJjW
         dmtEUBnSJBc3pqPyfGW+ijjDecQ6/FNNxHCkY2vW14FDi1gdpG6EhyRfJhrpzC4o+7tm
         p/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GPxsA15dgGFa86oqnVuniKPo2oEPXdNE69XGNs7GEZ4=;
        b=wOtPLpBYhbzayfu+I/dY0b/NGqbweXK2cIfcPWVnBOA34XEIH11wGwTYZjwKTnK/mm
         33QHyrdSGl5NiigICFKBA8JrLEbkldPktikC+PsuKYlnGdk32v63/I/KDn2zRs74SqsD
         q+EaLbauGuvFaYBTaQHxjogIC4aPjmul4Dlru9N7Y/cUrvhbmPvMCIJGw0HS616vaUao
         BICZ/YcN5pTZwmXalluLfit4n9nqSoDOjhIKLnicETrzk/YW17zaf8tb8OhKL1yA9u+D
         9+X6BBJbloyjZUQniRplPH7NiucRctlYiL9OyaulY9tXyPU02uzi70e+LUo4QLHPmDI5
         wZCA==
X-Gm-Message-State: AOAM531hjppwuGHSKxhPbletwSMnamVCs8AvZ7qwU0pc5vB+p9H1MLgR
        pAX/uxSx73db4Qm3KtSsX/s=
X-Google-Smtp-Source: ABdhPJztYLKaiAxqjABpHrtgdItpQMSKM4Eb7T9hX03BL4ZnheHxygmEy6brIUNd9V0l6eu8Ju2c+w==
X-Received: by 2002:ac2:4e66:0:b0:46b:c3d3:e203 with SMTP id y6-20020ac24e66000000b0046bc3d3e203mr14527874lfs.380.1650443530951;
        Wed, 20 Apr 2022 01:32:10 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id bu20-20020a056512169400b0043eaf37af75sm1755570lfb.199.2022.04.20.01.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:32:10 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:32:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420071217.GA5152@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 20, 2022 at 09:12:17AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 18, 2022 at 01:44:27AM +0300, Serge Semin wrote:
> > > but a DMA controller might also want to access something in the MMIO range
> > > 0x0-0x7fffffff, of which it still has an identical non-offset view. If a
> > > driver was previously using dma_map_resource() for that, it would now start
> > > getting DMA_MAPPING_ERROR because the dma_range_map exists but doesn't
> > > describe the MMIO region. I agree that in hindsight it's not an ideal
> > > situation, but it's how things have ended up, so at this point I'm wary of
> > > making potentially-breaking changes.
> > 
> > Hmm, what if the driver was previously using for instance the
> > dma_direct_map_sg() method for it?
> 

> dma_map_resource is for mapping MMIO space, and must not be called on
> memory in the kernel map.  For dma_map_sg (or all the other dma_map_*
> interface except for dma_map_resource), the reverse is true.

I've got it from the Robin comment. Exactly that part seems very much
confusing to me, because what you say doesn't cohere with the passed
address type. If the passed address belongs to the MMIO space and is a
part of the CPU physical address space, then it is supposed to be
visible by the CPU as is (see the very first diagram in [1]). So the
mapping performed in the dma_map_resource() and dma_map_sg() methods
is supposed to match. Otherwise the spaces you are talking about are
different and as such need to be described by different types. Since
what you are talking about more seem like a DMA address space, then the
dma_map_resource() address needs to have the dma_addr_t type instead
of the phys_addr_t.

BTW here is a brightest example of a system, which contradicts the
MMIO-specific mapping semantics you are talking about (it actually
matches to what we've got except some interconnect implementation
peculiarities):

              +-----+
              | DDR |
              +--+--+
                 |
  +-----+ +------+-------+ +---------+
  | CPU +-+ Interconnect +-+ DEVs... |
  +-----+ +-----^-+------+ +---------+
     dma-ranges-| |-ranges
              +-+-v-+
              | PCI |
              +-----+

See, if I get to map a virtual memory address to be accessible by any
PCIe peripheral device, then the dma_map_sg/dma_map_page/etc
procedures will take the PCIe host controller dma-ranges into account.
It will work as expected and the PCIe devices will see the memory what
I specified. But if I get to pass the physical address of the same
page or a physical address of some device of the DEVs space to the
dma_map_resource(), then the PCIe dma-ranges won't be taken into
account, and the result mapping will be incorrect. That's why the
current dma_map_resource() implementation seems very confusing to me.
As I see it phys_addr_t is the type of the Interconnect address space,
meanwhile dma_addr_t describes the PCIe, DEVs address spaces.

Based on what I said here and in my previous email could you explain
what do I get wrong?

[1] Documentation/core-api/dma-api-howto.rst

-Sergey

