Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF48538BA0
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244355AbiEaG4q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 02:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiEaG4q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 02:56:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDAF10FDE;
        Mon, 30 May 2022 23:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F8D9611EA;
        Tue, 31 May 2022 06:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29ACC3411D;
        Tue, 31 May 2022 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653980203;
        bh=2UQ3qgaNPc369GMhUN6AfskhbVIaavXK++b0jOePdlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LhWWZIm9XMv1vuCvkIGBV0DV7cR+pkMSRulKThrzkuWQ1Sxm8tfQ0w0nvYVYAuYD5
         Y09diPZ2qPlRPyV6noGyHR03G11+FhLdySnGMFTcl0PPvtW8zoytLWxwFpG/3HsRZA
         JF2vxluM0PV/KGPpArPYJ1oxhKiq0AVkvtSfeletmpLehx+tfFgQ+jD5wspqIEvPNY
         l/QU+acm0n85/wPBGhRlvRLbuxvhZECNli/2unqW4AE05jJ4nfR5X3DGBo7wCKWCdx
         SnzHNTbXgnpSIA63+5M6zypPBdATj4ALy2gZQdIXQWNBZF/3kkhBFIJcAPtaNWkPbS
         iftq7/oqZtInA==
Date:   Tue, 31 May 2022 12:26:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        olivier.dautricourt@orolia.com, Stefan Roese <sr@denx.de>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Eugeniy.Paltsev@synopsys.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leo Li <leoyang.li@nxp.com>, zw@zh-kernel.org,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        green.wan@sifive.com, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Message-ID: <YpW8J40hKwc7jwQh@matsya>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
 <YpCGePbo9B/Z7slV@matsya>
 <CAK8P3a2wD7=hgvqyS14X5p-eP+7Ajk4dFJOXgbOo8Z0r5UNYmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2wD7=hgvqyS14X5p-eP+7Ajk4dFJOXgbOo8Z0r5UNYmg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-05-22, 12:59, Arnd Bergmann wrote:
> On Fri, May 27, 2022 at 10:06 AM Vinod Koul <vkoul@kernel.org> wrote:
> > On 25-05-22, 13:03, Arnd Bergmann wrote:
> > > What might work better in the case of the dmaengine API would
> > > be an approach like:
> > >
> > > 1. add helper functions to call the callback functions from a
> > >     tasklet locally defined in drivers/dma/dmaengine.c to allow
> > >     deferring it from hardirq context
> > >
> > > 2. Change all  tasklets that are not part of the callback
> > >     mechanism to work queue functions, I only see
> > >     xilinx_dpdma_chan_err_task in the patch, but there
> > >     may be more
> > >
> > > 3. change all drivers to move their custom tasklets back into
> > >     hardirq context and instead call the new helper for deferring
> > >     the callback.
> > >
> > > 4. Extend the dmaengine callback API to let slave drivers
> > >     pick hardirq, tasklet or task context for the callback.
> > >     task context can mean either a workqueue, or a threaded
> > >     IRQ here, with the default remaining the tasklet version.
> >
> > That does sound a good idea, but I dont know who will use the workqueue
> > or a threaded context here, it might be that most would default to
> > hardirq or tasklet context for obvious reasons...
> 
> If the idea is to remove tasklets from the kernel for good, then the
> choice is only between workqueue and hardirq at this point. The
> workqueue version is the one that would make sense for any driver
> that just defers execution from the callback down into task context.
> If that gets called in task context already, the driver can be simpler.
> 
> I took a brief look at the roughly 150 slave drivers, and it does
> seem like very few of them actually want task context:
> 
> * Over Half the drivers just do a complete(), which could
>   probably be pulled into the dmaengine layer and done from
>   hardirq, avoiding the callback entirely
> 
> * A lot of the remaining drivers have interrupts disabled for
>   the entire callback, which means they might as well use
>   hardirqs, regardless of what they want
> 
> * drivers/crypto/* and drivers/mmc/* tend to call another tasklet
>   to do the real work.
> 
> * drivers/ata/sata_dwc_460ex.c and drivers/ntb/ntb_transport.c
>    probably want task context
> 
> * Some drivers like sound/soc/sh/siu_pcm.c start a new DMA
>   from the callback. Is that allowed from hardirq?
> 
> If we do the first three steps above, and then add a 'struct
> completion' pointer to dma_async_tx_descriptor as an alternative
> to the callback, that would already reduce the number of drivers
> that end up in a tasklet significantly and should be completely
> safe.

That is a good idea, lot of drivers are waiting for completion which can
be signalled from hardirq, this would also reduce the hops we have and
help improve latency a bit. On the downside, some controllers provide
error information, which would need to be dealt with.

I will prototype this on Qcom boards I have...

> 
> Unfortunately we can't just move the rest into hardirq
> context because that breaks anything using spin_lock_bh
> to protect against concurrent execution of the tasklet.
> 
> A possible alternative might be to then replace the global
> dmaengine tasklet with a custom softirq. Obviously those
> are not so hot either,  but dmaengine could be considered
> special enough to fit in the same category as net_rx/tx
> and block with their global softirqs.

Yes that would be a very reasonable mechanism, thanks for the
suggestions.

-- 
~Vinod
