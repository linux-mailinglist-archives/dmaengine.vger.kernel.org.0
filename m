Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916C12AC48C
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 20:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgKITEY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 14:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgKITEY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 14:04:24 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFB7C0613CF;
        Mon,  9 Nov 2020 11:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TFKGo0xpBOEg+T74W7oI6xqQWy9esM9XTIUlQGEd/Mk=; b=wALVIypO2VnSRap5o/l6oiHbAt
        AWYe1Cr7+RyhGemq7Gt6n3sNZczEifqAsATj0BcxYu1Ha7VMZIdEnvTtT3Tl4/nDo3HiJhgoaY9pm
        WK6v4K0BPkNIeJn5Yp9ldU/hcCz3HPNAZ24HsMMJ7ppWj7NmuhlqE4hOuCXGjnlfzoMnPL/PpMYSW
        dtbhiMVZ2jLxl7tQOqo/+gyunJyP92tp2me0rwINApgdyFeoegQczdTY2K8/An2UKoBcDXOKpBmah
        L0VyEre/Wh+XvUAy54r4q7R7w/SVKjj42E3N87BoDHEvJn6WPod7+lL9qfdOciKXHMDF4E24ioclD
        eY1N8PsQ==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1kcCSe-0002ic-8z; Mon, 09 Nov 2020 19:04:16 +0000
Date:   Mon, 9 Nov 2020 19:04:16 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Pedersen <twp@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: qcom: Add ADM driver
Message-ID: <20201109190416.GF32650@earth.li>
References: <20200916064326.GA13963@earth.li>
 <20200919185739.GS3411@earth.li>
 <20200920181204.GT3411@earth.li>
 <20200923194056.GY3411@earth.li>
 <20201109114121.GG3171@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109114121.GG3171@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Nov 09, 2020 at 05:11:21PM +0530, Vinod Koul wrote:
> HI Jonathan,
> 
> On 23-09-20, 20:40, Jonathan McDowell wrote:
> > Add the DMA engine driver for the QCOM Application Data Mover (ADM) DMA
> > controller found in the MSM8x60 and IPQ/APQ8064 platforms.
> 
> Mostly it looks good, some nitpicks
> 
> > The ADM supports both memory to memory transactions and memory
> > to/from peripheral device transactions.  The controller also provides
> > flow control capabilities for transactions to/from peripheral devices.
> > 
> > The initial release of this driver supports slave transfers to/from
> > peripherals and also incorporates CRCI (client rate control interface)
> > flow control.
> 
> Can you also convert the binding from txt to yaml?

Seems like that can be a separate patch, but sure, I'll give it a whirl.

> > diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
> > index 3bcb689162c6..0389d60d2604 100644
> > --- a/drivers/dma/qcom/Kconfig
> > +++ b/drivers/dma/qcom/Kconfig
> > @@ -1,4 +1,15 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +config QCOM_ADM
> > +	tristate "Qualcomm ADM support"
> > +	depends on (ARCH_QCOM || COMPILE_TEST) && !PHYS_ADDR_T_64BIT
> 
> why !PHYS_ADDR_T_64BIT ..?

The hardware only supports a 32 bit physical address, so specifying
!PHYS_ADDR_T_64BIT gives maximum COMPILE_TEST coverage without having to
spend effort on kludging things in the code that will never actually be
needed on real hardware.

> > +	select DMA_ENGINE
> > +	select DMA_VIRTUAL_CHANNELS
> > +	help
> > +	  Enable support for the Qualcomm Application Data Mover (ADM) DMA
> > +	  controller, as present on MSM8x60, APQ8064, and IPQ8064 devices.
> > +	  This controller provides DMA capabilities for both general purpose
> > +	  and on-chip peripheral devices.
> 
> > +static const struct of_device_id adm_of_match[] = {
> > +	{ .compatible = "qcom,adm", },
> 
> I know we have merged the binding, but should we not have a soc specific
> compatible?

Which soc? Looking at the other QCOM DMA drivers they mostly have
versioned compatibles and I can't find any indication there are multiple
variants of this block out there.

J.

-- 
Web [ Every program is either trivial or it contains at least one  ]
site: https:// [                   bug.                   ]      Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.24
