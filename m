Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5F270432
	for <lists+dmaengine@lfdr.de>; Fri, 18 Sep 2020 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIRSj1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Sep 2020 14:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRSj1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Sep 2020 14:39:27 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A69AC0613CF;
        Fri, 18 Sep 2020 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
        :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wBs2XakhO2bKgWJ7UG5nJK64qnPI9aNOtXXnkZJGonM=; b=aRAPwiwZFtVlEL6VaLzZcZzbS4
        0nMZsnWHLNFYzhb1CQVmdbM+FCYzKGRxkG+DkmKysnictu9BCTTzVixvUkon/PNlqQVgK7jywV/WO
        Hi5YSe7bt8zG1xHBK52sjPEFRlaHvjKSxBHa/DFwXMGyqojRYpZEuxvLchxJR3oWpboqrvPfdoIbO
        e4x+sxPSoi7RZ+0EPWOBobZGxG3bL20bwZYyWGxNRvx8fReFsNgBzNHkdKuef3IPvNia3cm2DYjmY
        yRfOl1YPRQQLvUlOBqito+9QT5yBsvT2K19YAO2s38w0WGG2cn/WIcbYu4T3g4odV91NLMqGBmafd
        Fpi5SZ2A==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1kJLHz-0005Ha-Ja; Fri, 18 Sep 2020 19:39:19 +0100
Date:   Fri, 18 Sep 2020 19:39:19 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Pedersen <twp@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: Add ADM driver
Message-ID: <20200918183919.GQ3411@earth.li>
References: <20200916064326.GA13963@earth.li>
 <20200918113443.GN2968@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918113443.GN2968@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Sep 18, 2020 at 05:04:43PM +0530, Vinod Koul wrote:
> Hello Jonathan
> 
> On 16-09-20, 07:43, Jonathan McDowell wrote:
> > From: Andy Gross <agross@codeaurora.org>
> > 
> > (I'm not sure how best to attribute this. It's originally from Andy
> > Gross, the version I picked up was a later version from Thomas Pedersen,
> > and I can't find clear indication of why the latest version wasn't
> > applied. The device tree details were added back in September 2014. The
> > driver is the missing piece in mainline for IPQ8064 NAND support and
> > I've been using it successfully with my RB3011 device on 5.8+)
> 
> Yeah not sure why the driver was missed :(
> Btw this note is helpful but not great for log, you should add it after
> sob lines.

Noted, I'll move it for v2.

> > diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
> > index 3bcb689162c6..75ee112ccea9 100644
> > --- a/drivers/dma/qcom/Kconfig
> > +++ b/drivers/dma/qcom/Kconfig
> > @@ -28,3 +28,13 @@ config QCOM_HIDMA
> >  	  (user to kernel, kernel to kernel, etc.).  It only supports
> >  	  memcpy interface. The core is not intended for general
> >  	  purpose slave DMA.
> > +
> > +config QCOM_ADM
> 
> alphabetical sort please

Ok.

> > +	tristate "Qualcomm ADM support"
> > +	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)
> 
> Why COMPILE_TEST && OF? just COMPILE_TEST should be fine

Turns out (ARCH_QCOM || COMPILE_TEST) && !64BIT is sufficient.

> > +	select DMA_ENGINE
> > +	select DMA_VIRTUAL_CHANNELS
> > +	---help---
> > +	  Enable support for the Qualcomm ADM DMA controller.  This controller
> > +	  provides DMA capabilities for both general purpose and on-chip
> > +	  peripheral devices.
> > diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
> > index 1ae92da88b0c..98a021fc6fe5 100644
> > --- a/drivers/dma/qcom/Makefile
> > +++ b/drivers/dma/qcom/Makefile
> > @@ -4,3 +4,4 @@ obj-$(CONFIG_QCOM_HIDMA_MGMT) += hdma_mgmt.o
> >  hdma_mgmt-objs	 := hidma_mgmt.o hidma_mgmt_sys.o
> >  obj-$(CONFIG_QCOM_HIDMA) +=  hdma.o
> >  hdma-objs        := hidma_ll.o hidma.o hidma_dbg.o
> > +obj-$(CONFIG_QCOM_ADM) += qcom_adm.o
> 
> alphabetical sort please

Ok.

> > +/* channel conf */
> > +#define ADM_CH_CONF_SHADOW_EN		BIT(12)
> > +#define ADM_CH_CONF_MPU_DISABLE		BIT(11)
> > +#define ADM_CH_CONF_PERM_MPU_CONF	BIT(9)
> > +#define ADM_CH_CONF_FORCE_RSLT_EN	BIT(7)
> > +#define ADM_CH_CONF_SEC_DOMAIN(ee)	(((ee & 0x3) << 4) | ((ee & 0x4) << 11))
> 
> USE FIELD_PREP for this?

I can't see a way to neatly use FIELD_PREP for a split field; am I
missing something?

(other pieces fixed up for v2 as well; I'd run checkpatch but not with
--strict. Will post once I've actually tested it.)

J.

-- 
 Minorities are the foundation of  |  .''`.  Debian GNU/Linux Developer
             society.              | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.
