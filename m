Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6850BD7F
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449839AbiDVQvz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386269AbiDVQvy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 12:51:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D444F5F8D1;
        Fri, 22 Apr 2022 09:49:00 -0700 (PDT)
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id A379620E65D6;
        Fri, 22 Apr 2022 09:48:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A379620E65D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650646140;
        bh=OLe0JPo5zoHc/exu12PHa4ag/S13XMhItTudk6eCymw=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=KJERGAV9DfTL+ebJU6/C40/SgLOm0dGzX8kKykGOu09kEq1+wVze2ZP6m9ZRTj69R
         QDyg2fYM/zLHYbWeLyY8KoZjyrgECu5HC13wjXZxob4dIrZ8dRKc+GpPKZ/wCS0G2q
         cJxQ/UdYg1qeE/btSvBGs+LmyEfGFuPP5AkYXE6w=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <202204191929.B475B3426@keescook>
Date:   Fri, 22 Apr 2022 09:48:58 -0700
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org,
        linux-hardening@vger.kernel.org, ludovic.desroches@microchip.com,
        tudor.ambarus@microchip.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <59CED9B1-03A4-4A71-9340-575F737037F5@linux.microsoft.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <202204191929.B475B3426@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


>> The tasklet is an old API which will be deprecated, workqueue API
>> cab be used instead of them.
>>=20
>> This patch replaces the tasklet usage in drivers/dma/* with a
>> simple work.
>=20
> Thanks for working on this! Can you describe the process for the
> replacement? For example, was it a 1:1 replacement from one set of
> functions to another, or something more nuanced? Did you do this by =
hand,
> or with the help of something like Coccinelle?

 For this series, I did the work manually as certain had the potential =
to be improved.
Also, there are drivers which use queue_work() instead of =
schedule_work().=20

> Including these details will help maintainers with review, and will =
help
> others do other conversions in the future.
>=20

 I will wait for a couple of more days and send out the rest of the =
series with
More details.

Thanks.

> Thanks!
>=20
> -Kees
>=20
> --=20
> Kees Cook

