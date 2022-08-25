Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752055A1650
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbiHYQEz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiHYQEy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 12:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D61F600;
        Thu, 25 Aug 2022 09:04:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2025E61B95;
        Thu, 25 Aug 2022 16:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62F8C433D6;
        Thu, 25 Aug 2022 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661443492;
        bh=O0BnzaPjcOf8VQ7QriQaGUwPP2OlVk6+QnLO3EHZZlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cdtqKDzFlvkB6++IJWR2enAQZB3BUuhPQ8FEeJ+YSgCC/MJBqDjCZSIGqi08V++ox
         MOlvQU0ylYBtQbvvbtF+lw90Zqz3924Qpw3jfnmrzZoeKPEqBvwRe316cQ39WIrEL2
         LGNTwQaWdfgIAwL6+tVyRmOhoy6ZvDtjIS0cOy6ZVsfo/0Mo3IIn5d89mvcuDhLwPe
         6uIVb3aqMIYmLhP8aYH18XwuRdVfvhdhM7qCjeUj5uv74+xheG8HoxFH3X06FWwpmG
         dseDBO5LQ5q9JRXFtMTKKmqeQ6Wu9m7efKhtxu74DxEKI/HPtaTY061iLo9aFnS8Sz
         BoHY6LkRWqdeA==
Date:   Thu, 25 Aug 2022 11:04:43 -0500
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
Message-ID: <20220825160443.GA2854084@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825051614.kfify5fbqlhurvdn@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 25, 2022 at 08:16:14AM +0300, Serge Semin wrote:
> On Wed, Aug 24, 2022 at 01:17:54PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 24, 2022 at 09:13:19PM +0300, Serge Semin wrote:
> > > On Wed, Aug 24, 2022 at 11:51:18AM -0500, Bjorn Helgaas wrote:
> > > > On Mon, Aug 22, 2022 at 09:53:32PM +0300, Serge Semin wrote:
> > 
> > > > > +	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > > > +	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > > > > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > > > +
> > > > > +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > > > +	} else if (val != 0xFFFFFFFF) {
> > > > 
> > > 
> > > > Consider PCI_POSSIBLE_ERROR() as an annotation about the meaning of
> > > > 0xFFFFFFFF and something to grep for.
> > > 
> > > In this case FFs don't mean an error but a special value, which
> > > indicates that the eDMA is mapped via the unrolled CSRs space. The
> > > similar approach has been implemented for the iATU legacy/unroll setup
> > > auto-detection. So I don't see much reasons to have it grepped, so as
> > > to have a macro-based parametrization since the special value will
> > > unluckily change while having the explicit literal utilized gives a
> > > better understanding of the way the algorithm works.
> 
> > If 0xFFFFFFFF is the result of a successful PCIe Memory Read,
> 
> Right. It is.
> 
> > and not
> > something synthesized by the host bridge when it handles an
> > Unsupported Request completion,
> 
> No it isn't. To be clear 0xFFs don't indicate some PCIe bus/controller
> malfunction, but they are a result of reading the
> DMA_CTRL_VIEWPORT_OFF register which doesn't exist. The manual
> explicitly says: "Note - When register does not exist, value is fixed
> to 32'hFFFF_FFFF". The register doesn't exist if either eDMA is
> unavailable or the eDMA CSRs are mapped via the unrolled state.

OK.  I don't think that's worded very well in the manual.  A register
that does not exist does not have a value, and attempts to read it
should fail.  If they want to say the register always exists and
contains 0xFFFFFFFF for versions earlier than X, that would make
sense.  Wouldn't be the first time a manual is ambiguous ;)

If the device itself, i.e., not the Root Complex, is fabricating this
0xFFFFFFFF value, reading it should not cause any AER or other error
status bits to be set.

If the Root Complex fabricates 0xFFFFFFFF upon receipt of a Completion
with Unsupported Request status, I would expect bits like Received
Master Abort to be set in the Root Port's Secondary Status register.
