Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1095342A4
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 20:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343621AbiEYSEQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 14:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343622AbiEYSEP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 14:04:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33E279CF43;
        Wed, 25 May 2022 11:04:14 -0700 (PDT)
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 676BE20B71D5;
        Wed, 25 May 2022 11:04:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 676BE20B71D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1653501853;
        bh=AIZAMiCEajIHhQ0xzFaRPG9svaWeXfFXVXfyfZDYgF8=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=qkPq7ZxKLUX+Js2XTpprB3QG78Q+FVPrOwQe4D4uDbsxi4xBnu1SohxxB30+ZmQYa
         vH5+kwVx+y32vqBI4OjdS/hhilI25YmpsA3nweMp+1Tl2JQcYd/mpLkjV/QuvUwFGz
         yBllJU5p5jUsgst9RiU/mkvW0F4DnJwkJyQrECg0=
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <CAK8P3a0mOEMW3N7HB7zTAbqKJMu_RusivjxwuU7_E+O1vGHOEw@mail.gmail.com>
Date:   Wed, 25 May 2022 11:04:11 -0700
Cc:     David Laight <David.Laight@aculab.com>,
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
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
        =?utf-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <45597969-0419-4CEE-B80C-4D2917943837@linux.microsoft.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
 <9947cfa64667406996de191f07b9e8b9@AcuMS.aculab.com>
 <6E248F41-6687-4F2B-B847-DB5459BA1344@linux.microsoft.com>
 <CAK8P3a0mOEMW3N7HB7zTAbqKJMu_RusivjxwuU7_E+O1vGHOEw@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


>>=20
>> Thank you Linus, Arnd, Vincent and David for the feedback.
>>=20
>> This is a lot more than a just conversion of API=E2=80=99s. I am in =
the process
>> Of replacing tasklets with threaded irq=E2=80=99s and hopefully that =
should be
>> A better solution than using workqueues.
>=20
> I don't think that is much better for the case of the DMA engine
> callbacks than the work queue, the problem I pointed out here
> is scheduling into task context, which may be too expensive
> in some cases, but whether it is or not depends on the slave
> driver, not the dmaengine driver.

Fair point. Deferring all callbacks to task context is not the ideal
Way forward. I will work on the approach you shared,


>1. add helper functions to call the callback functions from a
>tasklet locally defined in drivers/dma/dmaengine.c to allow
>deferring it from hardirq context

>2. Change all tasklets that are not part of the callback
>mechanism to work queue functions, I only see
>xilinx_dpdma_chan_err_task in the patch, but there
>may be more

>3. change all drivers to move their custom tasklets back into
>hardirq context and instead call the new helper for deferring
>the callback.

>4. Extend the dmaengine callback API to let slave drivers
>pick hardirq, tasklet or task context for the callback.
>task context can mean either a workqueue, or a threaded
>IRQ here, with the default remaining the tasklet version.

>5. Change slave drivers to pick either hardirq or task context
>depending on their requirements

>6. Remove the tasklet version.

Thanks.

>=20
> Even if all the slave drivers are better off using task context
> (threaded irq or workqueue), you need to look at the slave
> drivers first before you can convert the dmaengine drivers.
>=20



