Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D20535ECF
	for <lists+dmaengine@lfdr.de>; Fri, 27 May 2022 12:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350717AbiE0K7g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 May 2022 06:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350414AbiE0K7g (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 May 2022 06:59:36 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADB12E30F;
        Fri, 27 May 2022 03:59:34 -0700 (PDT)
Received: from mail-yb1-f170.google.com ([209.85.219.170]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxDck-1nagUG2Bui-00xdsr; Fri, 27 May 2022 12:59:32 +0200
Received: by mail-yb1-f170.google.com with SMTP id h75so1298847ybg.4;
        Fri, 27 May 2022 03:59:32 -0700 (PDT)
X-Gm-Message-State: AOAM530ThosBoAXjZMTkPJhZKMvYR+9cTw+Q2VrK51YA9X7ew3QblMrP
        79m/8lRD2Rhu1ujASVk3pKJFm9mDDp/A0cOTRTI=
X-Google-Smtp-Source: ABdhPJwJBQNIblI88S+eAxO/GdYbGBjYaYEn0zqYz6L8E/RzXhSPm0XJBTs9A9G4lFnnXcIXbRsjgtR+GiFws1I2RgI=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr39185871ybx.472.1653649171073; Fri, 27
 May 2022 03:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com> <YpCGePbo9B/Z7slV@matsya>
In-Reply-To: <YpCGePbo9B/Z7slV@matsya>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 27 May 2022 12:59:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2wD7=hgvqyS14X5p-eP+7Ajk4dFJOXgbOo8Z0r5UNYmg@mail.gmail.com>
Message-ID: <CAK8P3a2wD7=hgvqyS14X5p-eP+7Ajk4dFJOXgbOo8Z0r5UNYmg@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
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
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IrdVXaCr/iQtw8Mck98AsO+WGMa/ZodKqN96B4Fe1uabK65AnL7
 qYJYWPEtVpl71RH8M1VJTEepWOeuHOdLQTEccRWOScPR0b/K6grHXTstGWc0MJdhPmm5/iD
 RLmb2aBLaf6qFyAt/sFBLJUDTI0X7Ax3fY8B7emLb+jIZatyVJIDkSK9bLQeP+aTME7fVix
 8Q/2xDAhL8s26m5R1nxJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vfPV2nj/JfM=:fUkfskn5IOihfv8fgcki9k
 SOkN6pDqUGp5rpc6YmE1oMxJgrXlQB9h6YumlrlW2EF5PCcNkxPICw+FF1q58cURiaPdB+gko
 XBtzda1lOqZ5bgo5IwI7/0iCsDtsoWaoGDtiFsJGq3Kisyc12QzOwfLZhfpHkVebAGkO4iXzy
 mFWJ6VW7gaVK8AoDkpd+nf0dwM8t3N8qW2qriHxZI2qNkC5zyXQtN9nNRIrz6FcWxcB9r/8F9
 JKv5Kz3JkP/ly+nYznDw6RubyVfa7NRIYqVG/uZbvinKyLkSpq6gXJv5O0yc5oxrqWhmlvwGf
 dGhoTKaztcDUuvJH+141XAdZAJXYFdhp+TDmn+KzDwbpNRaF0hFmtbT8VRcYOEP1LbulIw4nW
 yOSBXLjj5dVAWuUqX3WfX7DUZvpK4pESfNTRkyKVLkGTiDnDX0zpkATX9x/shAOYDJ5Z6kIFp
 2kmuOR7yr3Zp+sGb0JK+lqmHkJ4rqOySQ7zOBsQz8tTo6Gjj1F2LA+4mz+YUTPP0MaKbGN84x
 0sbqszOiJqN8bj0ybzud225hlABU+aKnR6tuSYNoRt2YtaBe6aPou8rcA2dHcU/N/m7xnzGra
 VvlZqbXNGY4zKm6UtVprVGmnZFQCti/0EBbqxulQhzeHrZahDUqjnzHam2ZkO2pNUJvR0r3RX
 2yhd4hVQCgg2Hhdjzr0oHUQONwqdGifWTZuDvtjt6ZoaQdnxT6QgBOJLR7nbaZZnIbuLhGSGr
 4f8s+hd3ZhlZSkhJzHbbySABs5775zvSHG2oXA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, May 27, 2022 at 10:06 AM Vinod Koul <vkoul@kernel.org> wrote:
> On 25-05-22, 13:03, Arnd Bergmann wrote:
> > What might work better in the case of the dmaengine API would
> > be an approach like:
> >
> > 1. add helper functions to call the callback functions from a
> >     tasklet locally defined in drivers/dma/dmaengine.c to allow
> >     deferring it from hardirq context
> >
> > 2. Change all  tasklets that are not part of the callback
> >     mechanism to work queue functions, I only see
> >     xilinx_dpdma_chan_err_task in the patch, but there
> >     may be more
> >
> > 3. change all drivers to move their custom tasklets back into
> >     hardirq context and instead call the new helper for deferring
> >     the callback.
> >
> > 4. Extend the dmaengine callback API to let slave drivers
> >     pick hardirq, tasklet or task context for the callback.
> >     task context can mean either a workqueue, or a threaded
> >     IRQ here, with the default remaining the tasklet version.
>
> That does sound a good idea, but I dont know who will use the workqueue
> or a threaded context here, it might be that most would default to
> hardirq or tasklet context for obvious reasons...

If the idea is to remove tasklets from the kernel for good, then the
choice is only between workqueue and hardirq at this point. The
workqueue version is the one that would make sense for any driver
that just defers execution from the callback down into task context.
If that gets called in task context already, the driver can be simpler.

I took a brief look at the roughly 150 slave drivers, and it does
seem like very few of them actually want task context:

* Over Half the drivers just do a complete(), which could
  probably be pulled into the dmaengine layer and done from
  hardirq, avoiding the callback entirely

* A lot of the remaining drivers have interrupts disabled for
  the entire callback, which means they might as well use
  hardirqs, regardless of what they want

* drivers/crypto/* and drivers/mmc/* tend to call another tasklet
  to do the real work.

* drivers/ata/sata_dwc_460ex.c and drivers/ntb/ntb_transport.c
   probably want task context

* Some drivers like sound/soc/sh/siu_pcm.c start a new DMA
  from the callback. Is that allowed from hardirq?

If we do the first three steps above, and then add a 'struct
completion' pointer to dma_async_tx_descriptor as an alternative
to the callback, that would already reduce the number of drivers
that end up in a tasklet significantly and should be completely
safe.

Unfortunately we can't just move the rest into hardirq
context because that breaks anything using spin_lock_bh
to protect against concurrent execution of the tasklet.

A possible alternative might be to then replace the global
dmaengine tasklet with a custom softirq. Obviously those
are not so hot either,  but dmaengine could be considered
special enough to fit in the same category as net_rx/tx
and block with their global softirqs.

       Arnd
