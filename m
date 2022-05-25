Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A8533B47
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 13:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiEYLJI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 07:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiEYLJH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 07:09:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CF4B1CE;
        Wed, 25 May 2022 04:09:04 -0700 (PDT)
Received: from mail-yb1-f169.google.com ([209.85.219.169]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmlfS-1nRwNd1dw6-00jup3; Wed, 25 May 2022 13:03:59 +0200
Received: by mail-yb1-f169.google.com with SMTP id s14so8286681ybc.10;
        Wed, 25 May 2022 04:03:59 -0700 (PDT)
X-Gm-Message-State: AOAM530rmeqk08WjlN/QYC+WZuXpvM7ioxV96Ps+P10BEN4XaNoCxpPg
        tzi129E65eoTjSXGI1o88lqPdydVXe/0hMUrZdg=
X-Google-Smtp-Source: ABdhPJz1e+LfMuPz0MS9sNMc0xEtyj2vb1IvtyZSxvk0REhKPHlgJ8aBK7ZaMaZoGJN/t/2EL3imcUVYNZICVyESX2c=
X-Received: by 2002:a25:9b89:0:b0:655:8454:dc92 with SMTP id
 v9-20020a259b89000000b006558454dc92mr3917386ybo.550.1653476637990; Wed, 25
 May 2022 04:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
In-Reply-To: <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 25 May 2022 13:03:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
Message-ID: <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Allen Pais <apais@linux.microsoft.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, olivier.dautricourt@orolia.com,
        Stefan Roese <sr@denx.de>, Vinod Koul <vkoul@kernel.org>,
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
X-Provags-ID: V03:K1:f/6k2PCsIE8z9nVIcZyFl7FQM76NaSb/7sgHOxM2nu/nvieFW5T
 iWAJyvMLPoTlX5/UMfaYOUfCK3rlzw0wg3KHxasWD0dv00v0UVwJoiFG51yrVU5XSQhDLvH
 H/45U5SOj90pRYFmRgUXqlTYtUldRhVTOPzs75PlT6jhXCzj+i4ggaZjYT1o2p89Bq7LeR1
 SJRII9RZBL7zF+8VRnHhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vAWSt4/6Mzo=:dVQVOYp3ErokFgL6PgU6Le
 DIVX82jZfj7TFfkBwmSpvYtFk7yDRssUEkj5KaMwYGbscdcqRPtuhTXpgenwrHapb6prMiqeA
 eG7MjIO58GlMUOuu6IECsFNhZLP38r6PPuModfjhHhxe+3qtRS9+V8MVJ+1opcGgS6pn8XThK
 T8KfdIs3eZwS/XbKErZeT/isjuKS8yA3/0NwsgZt1UXxlKT3PkbF78xoVa9rZ2ozWhdzcMKQy
 uXHG9aMHsaLdaPCayCWa8bDDVfsvZ5cH/Kbf01uIZkkUWfLLF0U/viNfN7C/2HtvnyVGb1S+D
 uYT0rcZWn2/omsVbL5ShE5qfswMYGctv1BcWEnx1xCFVuy0wB3EwEF+yyh3yWI7eboiBjxbZi
 YbaowDmeexg2N6mDM8LV3Jhx4JbKujXyP+EKEj21c0rnCi6j8y9W87vrfDUJXdtpZYqcyhpd3
 hjp9Zt3z4iEMtxzX/ZJ4j2yjGKt6dQ6OFdro/DjFINeIkkNErne2x9SE3zMpjaAKeCT7DJi1v
 VdpYCYLqLR3kjV9QlqZQ1cTxH3EKQI3N+bL9bZuqEKA8DllMaC4y8tkkxqGERa+/qmVS25DjF
 BLFYX4+evjBzpC/tHzMCcaeaZbQTRA1iqbtAKk2Lf25VjollbFDrV4CdTZYyTQsvbGmUaiUgI
 4pDrxHTsjBtBOtND+E+BQmF2K3FBCwfVp91ad6e6jPTk1Zhu6nGwqweOOr3kKngceBrYWmvlR
 U36MUcbOiqCjxbKqNfQtWrmwEfgvsSkFe2Lb34PSR367TGqchO/7cktGock4ka/5zqE9RbpEc
 7QiHrIQ/R+iRuY1wGpJfqr5zG/sHLSrKaTcqEpm3kUlZpiiVy+Vexhj636eT8oV4AcBP6JjWE
 YnNg7L69pOttvhimJJeg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 25, 2022 at 11:24 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Apr 19, 2022 at 11:17 PM Allen Pais <apais@linux.microsoft.com> wrote:
>
> > The tasklet is an old API which will be deprecated, workqueue API
> > cab be used instead of them.
> >
> > This patch replaces the tasklet usage in drivers/dma/* with a
> > simple work.
> >
> > Github: https://github.com/KSPP/linux/issues/94
> >
> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>
> Paging Vincent Guittot and Arnd Bergmann on the following question
> on this patch set:
>
> - Will replacing tasklets with workque like this negatively impact the
>   performance on DMA engine bottom halves?

I think it will in some cases but not others. The problem I see is that
the short patch description makes it sound like a trivial conversion of a
single subsystem, but in reality this interacts with all the drivers using
DMA engines, including tty/serial, sound, mmc and spi.

In many cases, the change is an improvement, but I can see a number
of ways this might go wrong:

- for audio, waiting to schedule the workqueue task may add enough
  latency to lead to audible skips

- for serial, transferring a few characters through DMA is probably
  more expensive now than using MMIO, which might mean that
  there may no longer be a point in using DMA in the first place.

- Some drivers such as dw_mmc schedule another tasklet from the
  callback. If the tasklet is turned into a workqueue, this becomes
  a bit pointless unless we change the called drivers first.

What might work better in the case of the dmaengine API would
be an approach like:

1. add helper functions to call the callback functions from a
    tasklet locally defined in drivers/dma/dmaengine.c to allow
    deferring it from hardirq context

2. Change all  tasklets that are not part of the callback
    mechanism to work queue functions, I only see
    xilinx_dpdma_chan_err_task in the patch, but there
    may be more

3. change all drivers to move their custom tasklets back into
    hardirq context and instead call the new helper for deferring
    the callback.

4. Extend the dmaengine callback API to let slave drivers
    pick hardirq, tasklet or task context for the callback.
    task context can mean either a workqueue, or a threaded
    IRQ here, with the default remaining the tasklet version.

5. Change slave drivers to pick either hardirq or task context
    depending on their requirements

6. Remove the tasklet version.

This is of course a lot more complicated than Allen's
approach, but I think the end result would be much better.

         Arnd
