Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8917F5A013D
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiHXSSB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 14:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbiHXSSA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 14:18:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF179602;
        Wed, 24 Aug 2022 11:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB148B8260B;
        Wed, 24 Aug 2022 18:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C62C433C1;
        Wed, 24 Aug 2022 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661365075;
        bh=RNsalPlTzQYBjHmw/uAg0XtIxYyRx8+8Tf4jNcwZmbc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AUVlNz6bFTYbTExPwXIb22BpOPcIpxZ9oThZup19z5RH2Q/GLfbxGxx1JUGVuC57n
         kZjin4mY2yZPgod6VdGpVQ5nRnCFYM7v5PZo1UkCA6o6N3PXZb/449RMaRZKayjWET
         TbhLPsaoAg023EohoRkf79OEkE75Yca/lH+ttWC2NbTqFfQdKqb3WyRznpPvLDT4fl
         cK/uvhpmRn2dyaVqYQ8bBclyNmIsOkVF3hAxypBXKNM6SMQkONQIcx/59ZPAJnQO9I
         zBAmy0dJV07eLbGub1aTZAY77UxD+7aL56P7f8VxGgoc3zW8UdLGrBO2asAmvhhH+v
         ypXaYz+W0l+sw==
Date:   Wed, 24 Aug 2022 13:17:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 24/24] PCI: dwc: Add DW eDMA engine support
Message-ID: <20220824181754.GA2794837@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824181319.wkj4256a5jp2xjlp@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 24, 2022 at 09:13:19PM +0300, Serge Semin wrote:
> On Wed, Aug 24, 2022 at 11:51:18AM -0500, Bjorn Helgaas wrote:
> > On Mon, Aug 22, 2022 at 09:53:32PM +0300, Serge Semin wrote:

> > > +	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > +	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > +
> > > +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > +	} else if (val != 0xFFFFFFFF) {
> > 
> 
> > Consider PCI_POSSIBLE_ERROR() as an annotation about the meaning of
> > 0xFFFFFFFF and something to grep for.
> 
> In this case FFs don't mean an error but a special value, which
> indicates that the eDMA is mapped via the unrolled CSRs space. The
> similar approach has been implemented for the iATU legacy/unroll setup
> auto-detection. So I don't see much reasons to have it grepped, so as
> to have a macro-based parametrization since the special value will
> unluckily change while having the explicit literal utilized gives a
> better understanding of the way the algorithm works.

If 0xFFFFFFFF is the result of a successful PCIe Memory Read, and not
something synthesized by the host bridge when it handles an
Unsupported Request completion, I'm fine with keeping it as is.
