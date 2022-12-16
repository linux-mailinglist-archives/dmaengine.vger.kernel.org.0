Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBB64E8DC
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiLPJuR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 04:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiLPJuQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 04:50:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77C47315;
        Fri, 16 Dec 2022 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2FEpUqFtUCg4BaQ5RPfVF2QeTfCFgqWEGQxWo8YHLz0=; b=GPins/Wsg8zG7IJAo0k2xmY5AD
        zzACZxOv8OWMsnL7Bsfugrya8kVziIavxbxzQlcCUURIygFTv0De4HsiWDRmVdasC22tzeIGYUbBr
        t9W78Xx/jVJ3abbvcZBsl7Xz47gWBiToenqtE4yfFSR7z2UTMH52E2IMt28z3Ccz/IPWHV4yi2Gvx
        ReBAnBjColH1viDVnYPnCvK+1lrLv9txoaxxfQqTxn67HA9bmkhGTmB29HvFToGV4i0w6WzMpfuzT
        7x4yjFEgClnOz/stdfCbk8TjbXJmvTrTPWPTuR/r2A8REfKSM+abn/4SzrU8r2mqzsY0La1vLXqS1
        yQCbumzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p67LW-00DuLl-Aa; Fri, 16 Dec 2022 09:49:38 +0000
Date:   Fri, 16 Dec 2022 01:49:38 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data
 allocation
Message-ID: <Y5w/MkA4N857+AWQ@infradead.org>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
 <Y5rJJfZeVqliA5Rg@infradead.org>
 <20221215092721.tvz3hpaql3kotgnu@mobilestation>
 <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
 <20221215235218.wsuwy5uckqfxjnb6@mobilestation>
 <Y5wgvdnMWQDxkUd+@infradead.org>
 <20221216093423.4bettdxisserdzsh@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216093423.4bettdxisserdzsh@mobilestation>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 16, 2022 at 12:34:23PM +0300, Serge Semin wrote:
> What about instead of save/restore pattern I'll just change the
> dma_set_mask_and_coherent() method with the dma_set_coherent_mask()
> function call? It seems cleaner. Like this:

> Thus the platform-specific streaming DMA mask would be preserved.
> Since it's PCIe then having the streaming DMA-mask less than 32-bits
> wide is very much improbable. Moreover DW PCIe AXI-interface can be
> synthesize only with one out of two address bus widths: 32 and 64.

Where platform-specific means the dwc subdriver?  Yes, that seems
to work.  Alternatively have a flag that says which streaming mask
to set.
