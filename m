Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D080C59FFA1
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 18:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiHXQjV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 12:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiHXQjU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 12:39:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A19C506;
        Wed, 24 Aug 2022 09:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F03761A39;
        Wed, 24 Aug 2022 16:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEF0C433B5;
        Wed, 24 Aug 2022 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661359158;
        bh=P9NJxmLjZQ10oJJJpdAAG7ttOIVT5PbWRk2gfsQM17s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kVQFbC3ee769vaKefbEA8RdkpMhpWOTPVOcfXC4a24isFzPJw8YEEm8p/HWns9aNb
         klLRBSIhXK1c5shCjD5CqliS0TL+Q8RA4GTuUArWCtYsUb433hUAaX1Zg3OxoWiFBt
         yv9ZcjCHaRSw3OBgwzNHs0ZP0kv1h01kS9DDTWLPhWeBYMPq1djcd+lD6ohpsFqbVL
         +dQqwPt1avhWGgSfjBpXyv0ft8xf1HGJ5xMuMkXG6Al/WSSqZ7UlvF1zsKlkP16Eim
         GGEDytLxPfFrJ1+8RL/mE2Uxh/MGlQB22Idph8sLRTnBK5Spw11sHCuzswvid9ZAAi
         ZjtgTvm061hYQ==
Date:   Wed, 24 Aug 2022 11:39:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220824163916.GA2784109@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 22, 2022 at 09:53:08PM +0300, Serge Semin wrote:
> This is a final patchset in the series created in the framework of
> my Baikal-T1 PCIe/eDMA-related work:
> 
> [1: Done v5] PCI: dwc: Various fixes and cleanups
> Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> Merged: kernel 6.0-rc1
> [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
> Merged: kernel 6.0-rc1
> [3: In-review v5] PCI: dwc: Add generic resources and Baikal-T1 support
> Link: https://lore.kernel.org/linux-pci/20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru/
> [4: Done v5] dmaengine: dw-edma: Add RP/EP local DMA support
> Link: ---you are looking at it---
> ...

> Please note originally this series was self content, but due to Frank
> being a bit faster in his work submission I had to rebase my patchset onto
> his one. So now this patchset turns to be dependent on the Frank' work:
> 
> Link: https://lore.kernel.org/linux-pci/20220524152159.2370739-1-Frank.Li@nxp.com/

I think this paragraph is obsolete, since the "Enable designware PCI
EP EDMA locally" series you reference is already upstream:
https://git.kernel.org/linus/94d13317bef3

What remains are items 3 and 4.

3 is mostly drivers/pci/ and DT bindings (Lorenzo).  4 is mostly
drivers/dma/dw-edma/ stuff (Gustavo).  I guess Lorenzo and Gustavo can
figure out where it makes the most sense to merge it.

Bjorn
