Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9291F2ACEA9
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 05:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgKJEyK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 23:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbgKJEyK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 23:54:10 -0500
Received: from localhost (unknown [122.179.121.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6643C206D8;
        Tue, 10 Nov 2020 04:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604984049;
        bh=L7LJEeDj/UFpunPZD6f0tbSvytpg5gu8KTCCVrRrV8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=togUYxvmaizJLL2oqHWZk4B85aDVYa4/hX2kxMY+xZV3+Nd/VlqHziEVqq2BGnui/
         WMIrK6Ccy9v1nOJ9aAYGfecl3YGN28LuF+qbfK5TpmmTrvzp47uTJP9+J7EbOQMrje
         2gIG+eNvggY+n0DBexQdA3XoX4ENmyuXP+b1dER4=
Date:   Tue, 10 Nov 2020 10:24:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Pedersen <twp@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: qcom: Add ADM driver
Message-ID: <20201110045402.GR3171@vkoul-mobl>
References: <20200916064326.GA13963@earth.li>
 <20200919185739.GS3411@earth.li>
 <20200920181204.GT3411@earth.li>
 <20200923194056.GY3411@earth.li>
 <20201109114121.GG3171@vkoul-mobl>
 <20201109190416.GF32650@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109190416.GF32650@earth.li>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-11-20, 19:04, Jonathan McDowell wrote:
> On Mon, Nov 09, 2020 at 05:11:21PM +0530, Vinod Koul wrote:
> > HI Jonathan,
> > 
> > On 23-09-20, 20:40, Jonathan McDowell wrote:
> > > Add the DMA engine driver for the QCOM Application Data Mover (ADM) DMA
> > > controller found in the MSM8x60 and IPQ/APQ8064 platforms.
> > 
> > Mostly it looks good, some nitpicks
> > 
> > > The ADM supports both memory to memory transactions and memory
> > > to/from peripheral device transactions.  The controller also provides
> > > flow control capabilities for transactions to/from peripheral devices.
> > > 
> > > The initial release of this driver supports slave transfers to/from
> > > peripherals and also incorporates CRCI (client rate control interface)
> > > flow control.
> > 
> > Can you also convert the binding from txt to yaml?
> 
> Seems like that can be a separate patch, but sure, I'll give it a whirl.

Yup a different patch, thanks for looking into that

> > > diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
> > > index 3bcb689162c6..0389d60d2604 100644
> > > --- a/drivers/dma/qcom/Kconfig
> > > +++ b/drivers/dma/qcom/Kconfig
> > > @@ -1,4 +1,15 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > > +config QCOM_ADM
> > > +	tristate "Qualcomm ADM support"
> > > +	depends on (ARCH_QCOM || COMPILE_TEST) && !PHYS_ADDR_T_64BIT
> > 
> > why !PHYS_ADDR_T_64BIT ..?
> 
> The hardware only supports a 32 bit physical address, so specifying
> !PHYS_ADDR_T_64BIT gives maximum COMPILE_TEST coverage without having to
> spend effort on kludging things in the code that will never actually be
> needed on real hardware.

Can we mention that in the log please

> 
> > > +	select DMA_ENGINE
> > > +	select DMA_VIRTUAL_CHANNELS
> > > +	help
> > > +	  Enable support for the Qualcomm Application Data Mover (ADM) DMA
> > > +	  controller, as present on MSM8x60, APQ8064, and IPQ8064 devices.
> > > +	  This controller provides DMA capabilities for both general purpose
> > > +	  and on-chip peripheral devices.
> > 
> > > +static const struct of_device_id adm_of_match[] = {
> > > +	{ .compatible = "qcom,adm", },
> > 
> > I know we have merged the binding, but should we not have a soc specific
> > compatible?
> 
> Which soc? Looking at the other QCOM DMA drivers they mostly have
> versioned compatibles and I can't find any indication there are multiple
> variants of this block out there.

So even though ip block can remain same for few versions, we should
trust hw folks enough to give us spicy flavours in next revs :-) so
adding a compatible here like qcom,msm8x60-adm would help us.

BUT, looking at the QC documentation I dont see it being used in recent
chips so ok to go with qcom,adm

Thanks
-- 
~Vinod
