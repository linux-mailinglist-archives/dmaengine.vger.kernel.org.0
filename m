Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D6253961E
	for <lists+dmaengine@lfdr.de>; Tue, 31 May 2022 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbiEaSUP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 May 2022 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346971AbiEaSTy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 May 2022 14:19:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 228B39CC9C;
        Tue, 31 May 2022 11:19:52 -0700 (PDT)
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7EECF20BE4FF;
        Tue, 31 May 2022 11:19:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EECF20BE4FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1654021191;
        bh=6tBRLXB2e8RGJAhBvRCWJggyD6cUh5gaL2NlANSFO3E=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=nnLnlFN18QpTmf2pxGdXKTd5CTRH+ISqH6g8Qx0KH4kWahuCrh9y6t6RO9R/vzWFH
         BjQ1ay5Vb/epIQW0KeVwjWHvTPZI97oyeDCRm0TRRWiDO4qlk9MdIQZfN5f/+tzfsl
         pScggM5IU9VolT+hDR97WnEeEPcKn+bpAt8jYoBo=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <CAK8P3a3vf_huJ5ysBvFDV=11E-=OxFGiDQ9ND04YKug8g6jV_A@mail.gmail.com>
Date:   Tue, 31 May 2022 11:19:49 -0700
Cc:     Vinod Koul <vkoul@kernel.org>,
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
        green.wan@sifive.com, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?utf-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <708F627F-0F7D-477F-BDF7-274424501DA0@linux.microsoft.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <CACRpkdZ2DFZRPHS1x0=M3_8zYvU-jpCG5Tm3863dXv51EhY+BA@mail.gmail.com>
 <CAK8P3a0j_rziihsgHnG5bHMxmPbOkAhT6_+CCE4iFZy7HzQrLw@mail.gmail.com>
 <YpCGePbo9B/Z7slV@matsya>
 <CAK8P3a2wD7=hgvqyS14X5p-eP+7Ajk4dFJOXgbOo8Z0r5UNYmg@mail.gmail.com>
 <YpW8J40hKwc7jwQh@matsya>
 <0A9EDEDC-9E6C-47F8-89C0-48DCDD3F9DE3@linux.microsoft.com>
 <CAK8P3a3vf_huJ5ysBvFDV=11E-=OxFGiDQ9ND04YKug8g6jV_A@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


>=20
> [note: something is wrong with your email client, your previous reply =
appears to
> be in HTML]
>=20
  Sorry, fixed it.

>>> That is a good idea, lot of drivers are waiting for completion which =
can
>>> be signalled from hardirq, this would also reduce the hops we have =
and
>>> help improve latency a bit. On the downside, some controllers =
provide
>>> error information, which would need to be dealt with.
>>=20
>>=20
>>   I am not an expert in dma subsystem, but by using completion from
>> Hardirq context be a concern? Especially with latency.
>=20
> I don't see how: to the task waiting for the completion, there should
> be no difference, and for the irq handler sending it, it just avoids
> a few cycles going into softirq context.

  Thanks for clarification.=20

  If I have understood it correctly, your suggestion is to move the =
current
Callback mechanism out to dmaengine as a generic helper function
And introduce completion in dma_async_tx_descriptor to handle what
Tasklets currently do.

Thanks.

>=20
>>> Yes that would be a very reasonable mechanism, thanks for the
>>> suggestions.
>>=20
>>  I have started working on the idea of global softirq. A RFC should =
be ready
>> For review soon.
>=20
> Ok, thanks!
>=20
>       Arnd

