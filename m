Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A386F5396FC
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346538AbiEaT16 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 15:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiEaT15 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 15:27:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F077548E4A;
        Tue, 31 May 2022 12:27:55 -0700 (PDT)
Received: from mail-yb1-f174.google.com ([209.85.219.174]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWzXd-1oKV5n0CHh-00XJVd; Tue, 31 May 2022 21:27:54 +0200
Received: by mail-yb1-f174.google.com with SMTP id p13so14076781ybm.1;
        Tue, 31 May 2022 12:27:53 -0700 (PDT)
X-Gm-Message-State: AOAM532f4dg8HULohbX6nQcM4xAEDG8av11mec3SxxLIq1EMnmBgGVrh
        SKJI7TDrIIrP+5s+889lTGQuaJ0ndxxsZQupSUA=
X-Google-Smtp-Source: ABdhPJxyk421E9RkuQAkYxSldlpP0Sx5xvw/SZmoip5B1Zf2Fbf21hH68zXh6tR8O7vabTnD3t2ya1dr8dbyv7ZmpwY=
X-Received: by 2002:a25:1209:0:b0:65d:63f9:e10a with SMTP id
 9-20020a251209000000b0065d63f9e10amr2750286ybs.480.1654025272658; Tue, 31 May
 2022 12:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
 <YpCGePbo9B/Z7slV@matsya> <CAK8P3a2wD7=hgvqyS14X5p-eP+7Ajk4dFJOXgbOo8Z0r5UNYmg@mail.gmail.com>
 <YpW8J40hKwc7jwQh@matsya> <0A9EDEDC-9E6C-47F8-89C0-48DCDD3F9DE3@linux.microsoft.com>
 <CAK8P3a3vf_huJ5ysBvFDV=11E-=OxFGiDQ9ND04YKug8g6jV_A@mail.gmail.com> <708F627F-0F7D-477F-BDF7-274424501DA0@linux.microsoft.com>
In-Reply-To: <708F627F-0F7D-477F-BDF7-274424501DA0@linux.microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 May 2022 21:27:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a314SxhTNy6psYr_MzarOPmkjv1_KKGdeVUPpBjVkC5nA@mail.gmail.com>
Message-ID: <CAK8P3a314SxhTNy6psYr_MzarOPmkjv1_KKGdeVUPpBjVkC5nA@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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
X-Provags-ID: V03:K1:B22oMGCygCRXUXUiRid2wa6+BPuoeRZrXYWJD0/ExzKDN6lwySO
 xH8HbHRxnH1IlxNnE6ciDtBoQgfNtFTTGS72Pk666yGlIvC/wTZZXUc88QAqizrZ+9YsB+N
 1D+8hYbJxL7Umn93m51z6RurGdsgjA55XZcdFezzKurxbCBhT3/YRvHY2ku35E8C4tyhspf
 FiDbX0/aJOhDOtD8eom5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aDK9dosKDUI=:qDjs0bR0Xz30Gn2NaW7Yrc
 CW9vStNFFTN452LbNgA88uS2TixpgufC4Lvc421s0a/s1PM85Ba0a/eRunYQHQ56cuudv2qDK
 MxkS1qqGUEyee/oBkXRYTSgM/A7CNVJgrUELiAR9hm8OW8fthTq8LqlqVR4i+yEhL1wR2M/G0
 TaiYXU6PpLKkRBFFegR1fvNVI9mtrhkFs2+F8Sckeh/sT/25BR/uGMEVpIYCzTwidf++pHO8U
 XnjKdgZMkLg7Fdmf5BgT2+WC7gdBuC4IIypurcdqx+rjJdeQ4Ho02hO+dVlKQmFbjfG7OSbIb
 PDms623pJzX70HggVXajBASwiNMGktAbJjt2kvFalOLm1k7rCno77UnKY68zg/HL9q76GYD+j
 Up5tYU6pUx1z/cuYMnTEO8Uigp2K6zS7HxgeuMojl7yKs3REqWws5nxY+tAj5IjYyfv0160xs
 u/DbAdxY8MpXeKNKE6g6JPpk8qFPGk7uDkETHGA7NK0FdrOLalYp0gdczaW8zCTMQGb1W4Nji
 RsqDvZmEaCPO2TusMI9bMNvkW77+O6qn3zY9oQvWAeygooAiQu4s0i3H6gt6GzNNiSu+K3bcF
 nQ1xnGB3Jd43MTOKKxV5S92Yqp3vTccBCh8i2esC7Jo8ni4FbALwdXn3gCdYjNHmDBLDMJsYR
 MLS301I8EFrAletx0HLKpf8ARqMIc31nT4kYaaheFZrPMhQKAVh8/Gh0bVUi4I4fEC7FvnQnB
 ZNsJ9Plr8/S9uB6k4sfR6jiFOmt7njjUQJUwqKd7c8BK9S85XZ+OdxG+14yQguAo9G3kFFqhz
 oD91QO6zS4Ln7SUpp9XTEiFxjDtrSZNUMwWJjnM/XJRT7V4t0ZG4GDKywjqJocQRtPb1NGp/O
 08/AR1B0XHi7XYPnGrsQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 31, 2022 at 8:19 PM Allen Pais <apais@linux.microsoft.com> wrote:
> >>> That is a good idea, lot of drivers are waiting for completion which can
> >>> be signalled from hardirq, this would also reduce the hops we have and
> >>> help improve latency a bit. On the downside, some controllers provide
> >>> error information, which would need to be dealt with.
> >>
> >>
> >>   I am not an expert in dma subsystem, but by using completion from
> >> Hardirq context be a concern? Especially with latency.
> >
> > I don't see how: to the task waiting for the completion, there should
> > be no difference, and for the irq handler sending it, it just avoids
> > a few cycles going into softirq context.
>
>   Thanks for clarification.
>
>   If I have understood it correctly, your suggestion is to move the current
> Callback mechanism out to dmaengine as a generic helper function
> And introduce completion in dma_async_tx_descriptor to handle what
> Tasklets currently do.

Right: around half the callbacks are a trivial version that does nothing
other than calling complete(), so these will benefit from skipping the
softirq, while the others still need the callback.

       Arnd
