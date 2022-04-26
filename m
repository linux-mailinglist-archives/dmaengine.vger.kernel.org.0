Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453FD50ED1F
	for <lists+dmaengine@lfdr.de>; Tue, 26 Apr 2022 02:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbiDZAHj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 20:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiDZAHi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 20:07:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6597107723;
        Mon, 25 Apr 2022 17:04:32 -0700 (PDT)
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B112420E8CAC;
        Mon, 25 Apr 2022 17:04:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B112420E8CAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1650931472;
        bh=rKuOkio9gI+ognJQOktXvJGUxqRy2DVOygvVJnPJ9OA=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=ZFEmeFY1ma4wYHjB8BWkvmYl70O47TVONFvgQBXywk39QCYGWyi9F/KdrHxZdUauU
         UGiqJ2o1FCi1jul/8RNnpjdqqqj++yWaTm06Btb5MCRplZgJjOZSxugpQ1Phxpji1W
         /bjJXgoXYjph7wTx6aSH6N45xCVZukhZbFEcLnXE=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
Date:   Mon, 25 Apr 2022 17:04:31 -0700
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
        patrice.chotard@foss.st.com, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F7470CEE-48F0-4D25-92E2-295787EE6F12@linux.microsoft.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com>
 <353023ba-d506-5d45-be68-df2025074ed6@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
>=20
> Thank you for your patch. There is something to discuss/improve.
>=20
>> This patch replaces the tasklet usage in drivers/dma/* with a
>> simple work.
>=20
> Minor nits:
>=20
> 1. Don't use "this patch".
> =
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/subm=
itting-patches.rst#L95
> 2. Use subject prefix matching subsystem (git log --oneline)

 Thank you. Will have it updated.

>=20
>>=20
>> Github: https://github.com/KSPP/linux/issues/94
>=20
> 3. No external references to some issue management systems, change-ids
> etc. Lore link could work, but it's not relevant here, I guess.

We have had other tasks in the past which have carried the links. =
Ideally, I would like to=20
Keep it, I will leave it to the maintainers.=20

Thanks.=
