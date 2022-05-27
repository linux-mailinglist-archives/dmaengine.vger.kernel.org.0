Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3B8535B25
	for <lists+dmaengine@lfdr.de>; Fri, 27 May 2022 10:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348969AbiE0IHK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 May 2022 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349627AbiE0IGi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 May 2022 04:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC8AF315;
        Fri, 27 May 2022 01:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8786A61C01;
        Fri, 27 May 2022 08:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998CAC34119;
        Fri, 27 May 2022 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653638780;
        bh=bExDxURONoYyEyd2zIv+DcSXNxKTDMG5tYNYaUYxBJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnUb/Iotj6TLwlrFaZEv5Mj1e2uWOatVHI1xeiSd6YPEBYzPq1CPU6lowYeMJ66Xa
         ED3/aVsH5VNu3w1153cjLlkDukyW2Esl4jKOPSJqIK9236GmTJveEIeOPDbjmsFrt6
         AronjEdLvrWRBdHmFJIerwC2Kz9GaftGPDDqNQ006N23oST9E4Wl9TJu+/YInV20JL
         r2Uf2Z9gKCYnKNIIVlSv/FwGFN4Q0ALDwXrRaWJHrImdAcrzKQgqpAxx3PzjBIekbK
         BQtbM4vc4MQJ+7uF/PUaKHkszShaU/wvTxSwoFHc1b5vJR0P7Yr816NWTr7EeyNcdP
         mDN1TcO4tL21g==
Date:   Fri, 27 May 2022 13:36:16 +0530
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
Message-ID: <YpCGePbo9B/Z7slV@matsya>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-05-22, 13:03, Arnd Bergmann wrote:
> On Wed, May 25, 2022 at 11:24 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Apr 19, 2022 at 11:17 PM Allen Pais <apais@linux.microsoft.com> wrote:
> >
> > > The tasklet is an old API which will be deprecated, workqueue API
> > > cab be used instead of them.
> > >
> > > This patch replaces the tasklet usage in drivers/dma/* with a
> > > simple work.
> > >
> > > Github: https://github.com/KSPP/linux/issues/94
> > >
> > > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> >
> > Paging Vincent Guittot and Arnd Bergmann on the following question
> > on this patch set:
> >
> > - Will replacing tasklets with workque like this negatively impact the
> >   performance on DMA engine bottom halves?
> 
> I think it will in some cases but not others. The problem I see is that
> the short patch description makes it sound like a trivial conversion of a
> single subsystem, but in reality this interacts with all the drivers using
> DMA engines, including tty/serial, sound, mmc and spi.
> 
> In many cases, the change is an improvement, but I can see a number
> of ways this might go wrong:
> 
> - for audio, waiting to schedule the workqueue task may add enough
>   latency to lead to audible skips
> 
> - for serial, transferring a few characters through DMA is probably
>   more expensive now than using MMIO, which might mean that
>   there may no longer be a point in using DMA in the first place.
> 
> - Some drivers such as dw_mmc schedule another tasklet from the
>   callback. If the tasklet is turned into a workqueue, this becomes
>   a bit pointless unless we change the called drivers first.

Yes and there are assumptions in the peripheral drivers about the
context of callback which right now is tasklet, that needs to be updated
as well..

> What might work better in the case of the dmaengine API would
> be an approach like:
> 
> 1. add helper functions to call the callback functions from a
>     tasklet locally defined in drivers/dma/dmaengine.c to allow
>     deferring it from hardirq context
> 
> 2. Change all  tasklets that are not part of the callback
>     mechanism to work queue functions, I only see
>     xilinx_dpdma_chan_err_task in the patch, but there
>     may be more
> 
> 3. change all drivers to move their custom tasklets back into
>     hardirq context and instead call the new helper for deferring
>     the callback.
> 
> 4. Extend the dmaengine callback API to let slave drivers
>     pick hardirq, tasklet or task context for the callback.
>     task context can mean either a workqueue, or a threaded
>     IRQ here, with the default remaining the tasklet version.

That does sound a good idea, but I dont know who will use the workqueue
or a threaded context here, it might be that most would default to
hardirq or tasklet context for obvious reasons...

> 
> 5. Change slave drivers to pick either hardirq or task context
>     depending on their requirements
> 
> 6. Remove the tasklet version.
> 
> This is of course a lot more complicated than Allen's
> approach, but I think the end result would be much better.
> 
>          Arnd

-- 
~Vinod
