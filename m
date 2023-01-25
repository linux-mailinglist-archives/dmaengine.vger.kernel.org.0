Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43F867C0C1
	for <lists+dmaengine@lfdr.de>; Thu, 26 Jan 2023 00:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjAYXYB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Jan 2023 18:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAYXYA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Jan 2023 18:24:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C0EB43;
        Wed, 25 Jan 2023 15:23:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D8DB616CE;
        Wed, 25 Jan 2023 23:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8608FC433D2;
        Wed, 25 Jan 2023 23:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674689038;
        bh=6tp3KFSKFoIv/jRWP2Z/IaFhlmFsfDDgU2jQuLsJlU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MtvI5k1cB8TRIDlKapI26zKGmQhW9SmsveHd7/meKchg+mfAo2HdD6ov3q+R6USmM
         szRTMyUR99Xupj2DSPBGFp+l0++uRXKhpCOqeQp0sbM0kYxO93vgGh1AQeb9B4QjJB
         qAWQjg62p4PuTlDwxEgO2+qTm23mV9WekMR2KxeCqY+SGjYheA0cZFJLyd/VzNXYKR
         oyWdpc4Zq3dnQY4BySNPdCbgNcdJHnENvqBiS2v5A8YhNmqwDngRRSyX4dMnnnf1Yy
         kyBNSgN/3/IaPFLleUevo66VxSsHrAJzKs+2524Ta/QZt2RxLq9OX1ko2MdCemHJ8F
         Vi458E4fxWSEg==
Date:   Wed, 25 Jan 2023 17:23:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230125232357.GA1176625@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125144019.sn7kliw3qlwgtwzs@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 25, 2023 at 05:40:19PM +0300, Serge Semin wrote:
> On Tue, Jan 24, 2023 at 05:47:44PM -0600, Bjorn Helgaas wrote:

> > In the commit log, I think "forcibly selecting the DW eDMA driver from
> > the DW PCIe RP/EP kconfig" actually refers to just the "DW eDMA PCIe"
> > driver" not the "DW PCIe RP/EP driver," right?
> 
> Right.

Good.  I think it's worth updating the commit log to clear this up
because there are several things with very similar names, so it's
confusing enough already ;)

> > The undefined reference to dw_edma_probe() doesn't actually happen
> > unless we merge 27/27 without *this* patch, right? 
> 
> Right.

Thanks, I got unreasonably focused on the "fix 'undefined reference'
error" comment, wondering if we needed to identify a Fixes: commit, so
this clears that up, too.

> > I would use "depends on
> >      DW_EDMA" instead of adding if/endif around DW_EDMA_PCIE.
> 
> Could you explain why is the "depends on" operator more preferable
> than if/endif? In this case since we have a single core kconfig from
> which all the eDMA LLDD config(s) (except PCIE_DW for the reason
> previously described) will surely depend on, using if/endif would
> cause the possible new eDMA-capable LLDD(s) adding their kconfig
> entries within the if-endif clause without need to copy the same
> "depends on DW_EDMA" pattern over and over. That seems to look a bit
> more maintainable than the alternative you suggest. Do you think
> otherwise?

Only that "depends on" is much more common and I always try to avoid
unusual constructs.  But I wasn't looking into the future and
imagining several LLDDs with similar uses of "depends on DW_EDMA".
Thanks for that perspective; with it, I think it's OK either way.

> > What do you think? 
> 
> What you described was the second option I had in mind for the update
> to look like, but after all I decided to take a shorter path and
> combine the modifications into a single patch. If you think that
> splitting it up would make the update looking simpler then I'll do as
> you suggest. But in that case Lorenzo will need to re-merge the
> updated patchset v10.

It's a pretty trivial update, so I just did it myself.  The result is
at https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/ctrl/dwc&id=ecadcaed4ef7

I split this patch and tweaked some commit messages for consistency
(including the "DW eDMA PCIe driver" change above).  "git diff -b"
with Lorenzo's current branch (95624672bb3e ("PCI: dwc: Add DW eDMA
engine support")) is empty except for a minor comment change.  

Bjorn
