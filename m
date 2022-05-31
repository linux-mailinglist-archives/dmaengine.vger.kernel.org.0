Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0045395CE
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 20:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbiEaSCg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiEaSCf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 14:02:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BBA50E06;
        Tue, 31 May 2022 11:02:33 -0700 (PDT)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MyK5K-1nbFSO0mbc-00yjob; Tue, 31 May 2022 20:02:32 +0200
Received: by mail-yb1-f176.google.com with SMTP id p13so13702398ybm.1;
        Tue, 31 May 2022 11:02:31 -0700 (PDT)
X-Gm-Message-State: AOAM530eRoinXj/sLkSXe86Nv9+bOvHZoCGwK+0RiPasmo/lNI+5uWvN
        woZMlAkRUC9hIyIx6TvvlfFJD5IDADXr6LC4EmY=
X-Google-Smtp-Source: ABdhPJwmlIPCmhVaQV5Dv+KE6cBzd1ctI3OGOfbpvy1/ZbbEzjQyU6zzQG2uDs+UAOlk9ynawe6ny7TI68QJmuINvY0=
X-Received: by 2002:a25:db8a:0:b0:65c:b04a:f612 with SMTP id
 g132-20020a25db8a000000b0065cb04af612mr16322691ybf.106.1654020150830; Tue, 31
 May 2022 11:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
 <YpCGePbo9B/Z7slV@matsya> <CAK8P3a2wD7=hgvqyS14X5p-eP+7Ajk4dFJOXgbOo8Z0r5UNYmg@mail.gmail.com>
 <YpW8J40hKwc7jwQh@matsya> <0A9EDEDC-9E6C-47F8-89C0-48DCDD3F9DE3@linux.microsoft.com>
In-Reply-To: <0A9EDEDC-9E6C-47F8-89C0-48DCDD3F9DE3@linux.microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 May 2022 20:02:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3vf_huJ5ysBvFDV=11E-=OxFGiDQ9ND04YKug8g6jV_A@mail.gmail.com>
Message-ID: <CAK8P3a3vf_huJ5ysBvFDV=11E-=OxFGiDQ9ND04YKug8g6jV_A@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
X-Provags-ID: V03:K1:IJ1K80200rib6/6tXN6GT3BD3Ebp7d57MAQTsQcwUCpfBNwo2d/
 fViC3OY5YCcQMBkzLw7M1TKpbj6dzjDkxUKRcuQb1MEGxJe8t3kJ4JeuTpckPfAPuXUbxLV
 8zHpjLgX7mwTVDMA0TH9eeBaOcD3ThFsE1kqy1FzkfkpBIc55dnTdn+ojJw71nWTnGaP3MA
 LoSOMACAbTAiDJSeZwBwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R7kKsU5Hx9A=:CDBT6FMK4FPGF9yi+gPs4H
 Z4EJ9ks9vUQwUiSDw96wrUj+cl0cTbF3wnT5Zb7rG7IP/5ZOh/pHDFoCsMOziJZwVtRG/IARt
 0mX0fhVYtd1pdNb5zC2R9mrqTo0VbzwhDpP4swGe9+pUiYN2Zmu9w8ZBN2Jdwe4IVHTMqcPiY
 xOb1T2eq+EIm9hordaxfufTFpcSHtJ9rhYfTXirK1VqejeAeL/00HQm8itbGgcOEDwn4vgXc8
 57jz4zJA8aluQ+r5UxmxYD3jDYGQ7przn8BUBrZSoMpmkncbuwdHI1SJlQPmdGSxFWHIGNeOB
 F3y397a3x9KDsOYA58+td/05cGuTFSc0y2LuNMwPJudD+CqkQxn1TIVW15zz5BdLfl/esk9fA
 v/nkQM/QwBqpJMgqpj0Ahuk9EmOq5z6GqcMYdZT2scUy7lYbOMrF+cHfAhHp9fIOZID4h+u9M
 Pcq7G2k8pSywYW0bEzirvfxZ/RmdyAm1eFa2O9dE4X2BcFTVcXf8pjNo/uGOt1wHVGBBkf/Qu
 7IqB5i7vC7hRi1WInV9fy5qZi5r/AiDCnx9+3tkpGQWzJKSgVfwlUD7rRm5fG3x/YiAg4/ObU
 zW0hc68UUf5uFeSJUEJGo5RznJie2TddJIoZQnfYcMXEHHAdndVkKo8LTHpzt4s0qTgua1OC7
 7FwWudxQ7njaii8LynC7usRFB+jL3oMdqA9wbUKPP0EnVy2Yl+HUjI+GfLTK3KhW3fyFSbpB3
 nCMgC9LpL+nguWeMeX5w980Eel1QYHqnpV3lpQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 31, 2022 at 7:02 PM Allen Pais <apais@linux.microsoft.com> wrote:

[note: something is wrong with your email client, your previous reply appears to
be in HTML]

> > That is a good idea, lot of drivers are waiting for completion which can
> > be signalled from hardirq, this would also reduce the hops we have and
> > help improve latency a bit. On the downside, some controllers provide
> > error information, which would need to be dealt with.
>
>
>    I am not an expert in dma subsystem, but by using completion from
> Hardirq context be a concern? Especially with latency.

I don't see how: to the task waiting for the completion, there should
be no difference, and for the irq handler sending it, it just avoids
a few cycles going into softirq context.

> > Yes that would be a very reasonable mechanism, thanks for the
> > suggestions.
>
>   I have started working on the idea of global softirq. A RFC should be ready
> For review soon.

Ok, thanks!

       Arnd
