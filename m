Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408B364D715
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 08:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiLOHOx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Dec 2022 02:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiLOHOa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Dec 2022 02:14:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C47BFDE;
        Wed, 14 Dec 2022 23:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U8tiGOfY6tAEqkhf0Y4a1OMzKNKXbK0qcbstpXtXJU8=; b=IRd0ZBfgjRkEwZY14DhynFGEJb
        /oQ48+Kfonp6Aj7wCCYVfibQFitoCpd//3njKcUK0cu1syKJnknoJ4KlEFOZoBDCZPdbm9TgPMD0I
        g5BhgFpVVo0GFYKBOZwudfPaiMJJz+iRBKRnf/FROAmtVfh8hVH8LKSs/yDzIBcK6pkOSYoW9oaz5
        jXhyv7RPdQZv45FPRBfunJstNQoohURGKEXmNCMIeiOx7mfUGORb9dvzy7LmQUKzo1C++jOzxIfNm
        K4ZlxIno5EHzLPIqR78fZ6Be1KLhLWtvTB6dRe+Gg54+2V4nIjA/QZLotQDxNXljtFuSPMc0VQ3Ji
        M9DXIShQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5iR3-0077h5-9t; Thu, 15 Dec 2022 07:13:41 +0000
Date:   Wed, 14 Dec 2022 23:13:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data
 allocation
Message-ID: <Y5rJJfZeVqliA5Rg@infradead.org>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Dec 15, 2022 at 02:53:03AM +0300, Serge Semin wrote:
> DW PCIe Root Ports and End-points can be equipped with the DW eDMA engine.
> In that case it is critical to have the platform device pre-initialized
> with a valid DMA-mask so the drivers using the eDMA-engine would be able
> to allocate the DMA-able buffers. The MSI-capable data requires to be
> allocated from the lowest 4GB region. Since that procedure implies the
> DMA-mask change we need to restore the mask set by the low-level drivers
> after the MSI-data allocation is done.

You can't change the DMA mask when there are existing allocations.
