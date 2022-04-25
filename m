Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D8D50ED15
	for <lists+dmaengine@lfdr.de>; Tue, 26 Apr 2022 01:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiDZACz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 20:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbiDZACz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 20:02:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A57D7120119;
        Mon, 25 Apr 2022 16:59:48 -0700 (PDT)
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6EAA720E8CA3;
        Mon, 25 Apr 2022 16:59:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6EAA720E8CA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650931188;
        bh=SqaJwtu4nBGeVjj6Zn6hyoAbttxZDPfflYFC2W1PtJw=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=r0fG5JVPwUX7Lvt6Nsw6a+Mfx2XKy6yf1NK+ha+CYOWhXYm1+txuyWYwqA01HqaBB
         MICE9oBd1OTpFbqVtsLQB6//n8ZmxqEn2KUsK4sRd/yHAzaEKb2/p3eqh9ZgFhD9Pl
         k+gQf1uUVkFoFfbdX6VPnkan2kaKXykyiBm9G22I=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <CACRpkdZz_JGGCv74gQYKMq5fdHLo_6jFuJ2uh8N9Q1VG5+kCFw@mail.gmail.com>
Date:   Mon, 25 Apr 2022 16:59:46 -0700
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, vkoul@kernel.org,
        Kees Cook <keescook@chromium.org>,
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
        patrice.chotard@foss.st.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE645506-6E3B-4D4D-BD3A-835AF4559F52@linux.microsoft.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <CACRpkdZz_JGGCv74gQYKMq5fdHLo_6jFuJ2uh8N9Q1VG5+kCFw@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
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



> On 25-Apr-2022, at 8:06 AM, Linus Walleij <linus.walleij@linaro.org> =
wrote:
>=20
> On Tue, Apr 19, 2022 at 11:17 PM Allen Pais =
<apais@linux.microsoft.com> wrote:
>=20
>> The tasklet is an old API which will be deprecated, workqueue API
>> cab be used instead of them.
>>=20
>> This patch replaces the tasklet usage in drivers/dma/* with a
>> simple work.
>>=20
>> Github: https://github.com/KSPP/linux/issues/94
>>=20
>> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>=20
> Booted on:
>=20
>> drivers/dma/ste_dma40.c                       | 17 ++++-----
>=20
> This DMA-controller with no regressions:
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Also looks good so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

 Thanks for review and testing.

>=20
> Yours,
> Linus Walleij

