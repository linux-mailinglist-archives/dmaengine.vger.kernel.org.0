Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909DC534266
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiEYRs7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Wed, 25 May 2022 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245754AbiEYRs6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 13:48:58 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED4743EDE;
        Wed, 25 May 2022 10:48:56 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M2fM1-1nqKtN3I7j-004Dtu; Wed, 25 May 2022 19:48:55 +0200
Received: by mail-yb1-f171.google.com with SMTP id x2so37194248ybi.8;
        Wed, 25 May 2022 10:48:54 -0700 (PDT)
X-Gm-Message-State: AOAM532z4B2YsGkU8NqMTxoEHFwQiwnHVwNZYXi3Ob308zaQ5j+FnF0w
        jni83HTZDNvGbs4RAq2ICINuaLpPa14NdBma8vI=
X-Google-Smtp-Source: ABdhPJzuiHSmZ8nVYKAXx5dLxFxpNAHZXgLqBiamodT4boGdrCuJxzCCcnQVNo+mB/7OjTNGg0DOAvLa5X1IWqszNVY=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr32038430ybx.472.1653500933346; Wed, 25
 May 2022 10:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
 <9947cfa64667406996de191f07b9e8b9@AcuMS.aculab.com> <6E248F41-6687-4F2B-B847-DB5459BA1344@linux.microsoft.com>
In-Reply-To: <6E248F41-6687-4F2B-B847-DB5459BA1344@linux.microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 25 May 2022 19:48:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0mOEMW3N7HB7zTAbqKJMu_RusivjxwuU7_E+O1vGHOEw@mail.gmail.com>
Message-ID: <CAK8P3a0mOEMW3N7HB7zTAbqKJMu_RusivjxwuU7_E+O1vGHOEw@mail.gmail.com>
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
To:     Allen Pais <apais@linux.microsoft.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "olivier.dautricourt@orolia.com" <olivier.dautricourt@orolia.com>,
        Stefan Roese <sr@denx.de>, Vinod Koul <vkoul@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "zw@zh-kernel.org" <zw@zh-kernel.org>,
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
        "green.wan@sifive.com" <green.wan@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:0oNKE+aYHXzvIhZnI05JLdbh19bMeWgQr7g/ZSVtzRDQ0Xy/8ho
 UrKFc8cz+xgeYHXnF1gl1iiybnsWi0QqL/iQBfx7lhklR1sawXLchnDW+IMAnSffs4gBf3o
 Uo6FCKD5LxF3o9guwwJ2lgZrkJMQcw2+hD/Y+EpCyymeLzupaaEdOmH2B/q7mf6ixsOsmtA
 +vD8UYwxw9lqQe/GqUIKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rmvH/JoWJlA=:kUTYk+HrtMJMhbxax9LfL4
 R4J+6jT3qQGVQRXv8YhKYIFA/pIfPn80fhaxobBKSKJtsCyunsNESdo+P0plc0e8Yp7zmctTf
 QY3xVFRPOAb6jL09p5vOxZAMF0gXsm/Pg+Y5tfhn0lHvWDgLAtMcW2Gc4RvAKrtaaoNaZQ2wq
 Sm0O+NSbO/uEfjRsBM06JxeFWehWXRylGD7MGF6+9OJDxg94C548F2F9EcVsO+yaPwEpdwa73
 S/C99mW0h9Slaa/aDosOhWFBX/G1WpHuvV4Pg5jRe08UOmgC9eI6bf/ryE164p5SFtlU/hnIX
 VwCP85wPNyMArDO50QYOsZR/wyU8jIOhoLkCys0VVNkVmMOBiRL3Um0aVs2vzAuj5JxLlvHJo
 NxVbkdp1kcv2wy1niWJrMLX0E8otYhhpXmo3DD2LV+8vjK8hlV7dCkCHQi2ByOk3dD2c/RaK7
 XinJkm61E5JNPpBs1lKmpaCEUfX6dVsoRLia3KSpMMtyEZkXH+uKmST7ywyxVtngIOHT3YLvo
 26PWqxyzPGlGqhhtG/XpmG1nXNE5HoD/rNSkRZF0Ibd+yCyR93rcBbtuqF43iMsG1a366LMAd
 qRlyY66mmhdXvd2h2dWuj8kgDaUmyC3VjVJac6QaOL61MzSCSpD1KPvVeIz6+xKE6ma35O6z1
 iTUGHkNIxw8TanpGDxbv6RwPyopwX0Rp6EsAwybTRgqWUOZyF5W9RWmfzpsDjeynB9NEyrmVz
 8Ir77Lg3Hh0oArE/epwry+GI3bDWl4rFtGzm4uNy7NQbwgxr5wcnd1+RNgkBO4ZMcNgq7HOTx
 Gp/a84DbgEMF/TRGogdido+ObB6tSesdcyYLUBa4VW+lGUtvtjGqLBAmLoAW9lPdLXhgPho+Z
 v4rP1Jf+ynDUBxrD5BRQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 25, 2022 at 6:56 PM Allen Pais <apais@linux.microsoft.com> wrote:
>
> Thank you Linus, Arnd, Vincent and David for the feedback.
>
> This is a lot more than a just conversion of API’s. I am in the process
> Of replacing tasklets with threaded irq’s and hopefully that should be
> A better solution than using workqueues.

I don't think that is much better for the case of the DMA engine
callbacks than the work queue, the problem I pointed out here
is scheduling into task context, which may be too expensive
in some cases, but whether it is or not depends on the slave
driver, not the dmaengine driver.

Even if all the slave drivers are better off using task context
(threaded irq or workqueue), you need to look at the slave
drivers first before you can convert the dmaengine drivers.

        Arnd
