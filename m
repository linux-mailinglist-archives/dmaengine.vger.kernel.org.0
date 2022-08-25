Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6F35A0826
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 06:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiHYEmd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 00:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiHYEmd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 00:42:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8ED5FF67;
        Wed, 24 Aug 2022 21:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8E515CE2559;
        Thu, 25 Aug 2022 04:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6DFC433D6;
        Thu, 25 Aug 2022 04:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661402547;
        bh=kGVOafTn4BYjj+Dr0qwWXYlZ51IOL7f4Vih1PbsJz18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xoca/bGr96ctW2HWL/rqFKWreWdUQdBQies1rxYDxLlFJpIGsmWnRB8tB7vEZVXaH
         H7HuOfaNvirmbxlyxK2pyKZEifykOgDU8J8bMphy6OMwyUMVd3P8BelbtONjGMkgqv
         h2gZzITV1ewCU1xFC+H2QM1/RV8Q+j7ofjEZVRO0pKoixU/SxVcV6e1L/wcMHHUNS7
         pbRd/85B3FL41Y97GRE1z9JrmTJ5seTa6UHl/1TaJcmYDWXvUz/a2fHgIV9c2mMhAX
         vogioATq301BmE7W8lNUNnAgxlyoVfP/26BR8kRe8sB1GDYzrATAJUyfV1f3S5XCC3
         tWKadi22FKgzA==
Date:   Thu, 25 Aug 2022 10:12:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <Ywb9r3f+wSkpk7gY@matsya>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220823154526.GB6371@thinkpad>
 <20220824140759.7gg7t53z2xi7jxaj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824140759.7gg7t53z2xi7jxaj@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-08-22, 17:07, Serge Semin wrote:
> On Tue, Aug 23, 2022 at 09:15:26PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Aug 22, 2022 at 09:53:08PM +0300, Serge Semin wrote:

> > I've tested this series on Qualcomm SM8450 SoC based dev board. So,
> > 
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> 
> Thanks.
> 
> > Not sure what is the merging strategy for this one but this series should get
> > merged into a single tree. Since the PCI patch is touching the designware
> > driver, merging the series into dmaengine tree might result in conflict later.
> 
> Right, the series
> [PATCH v5 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
> is supposed to be merged in first. Then this one will get to be
> applied with no conflicts. That's what I imply in the head of the
> cover-letter.

I dont see a dependency of dma patches with PCIe patches? I guess they
could go thru the respective trees now..?

-- 
~Vinod
