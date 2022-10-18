Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0388B602CAE
	for <lists+dmaengine@lfdr.de>; Tue, 18 Oct 2022 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiJRNRV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 09:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJRNRU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 09:17:20 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03796C8218;
        Tue, 18 Oct 2022 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666099029; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AuzvGkxBRGlNe+skx8V5SxAH7cA319eApJIB8CR8jKo=;
        b=Kq6rzy0LSeNBUURfbHC7uLjO6IrCshn7bM/dRQ12l4a2mn4m7rXjNmVdt4RkhTbJj8ku8h
        qAS3WcLXyWu6A8VQDdslhYNHNuxwx4NmWZkMRnCGD3E/QW1McL211B53dDgJJ9r/uCEjBo
        WoWaGD3IXcs6mJ8jAWCDLZvX5CQa3j8=
Date:   Tue, 18 Oct 2022 14:16:58 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/2] dmaengine: JZ4780: Add support for the JZ4755.
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <A8AYJR.RL4SZCGLT3BZ1@crapouillou.net>
In-Reply-To: <CAKNVLfY87P6jTG8g5L_S84MUXCfL1Z0GLgAdZqD4K6h6ubJb-Q@mail.gmail.com>
References: <20221016151256.3021729-1-lis8215@gmail.com>
        <20221016151256.3021729-3-lis8215@gmail.com>
        <895WJR.03DS0G5N9R0V1@crapouillou.net>
        <CAKNVLfY87P6jTG8g5L_S84MUXCfL1Z0GLgAdZqD4K6h6ubJb-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Le lun., oct. 17 2022 at 20:29:27 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D0=BF=D0=BD, 17 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 12:34, Paul Cerc=
ueil=20
> <paul@crapouillou.net>:
>>  Can you verify that?
>>=20
>>  It should be pretty simple, if it has the bug you'll see I/O errors=20
>> on
>>  the SD card.
>=20
> Well, the result is ambiguous:
>=20
> Without that 'broken' flag: mmc works poorly, but becomes more or less
> stable when MMC clock downs to 6MHz (90% boots without errors).
> On the 12MHz MMC clock the issue doesn't appear in 50-70% cases.
> On the 24MHz MMC clock the device never boots up.
>=20
> However with the flag: MMC works stable on 24MHz MMC clock
> (boot issue observed only once), but if I increase MMC clock speed=20
> even
> a bit the problem appears oftenly ( >70% of cases).
>=20
> So, that flag definitely helps a lot, but the nature of the problem=20
> might be
> different.

If the flag makes any difference then it's needed.

The controller should support up to 50 MHz, make sure that your "mmc"=20
clock is at 50 MHz otherwise changing the max-frequency DT property=20
won't do much.

Cheers,
-Paul


