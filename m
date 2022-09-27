Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1922F5ED08F
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 00:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiI0W4g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Sep 2022 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI0W4d (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Sep 2022 18:56:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEAC7C33A
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 15:56:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f23so10350896plr.6
        for <dmaengine@vger.kernel.org>; Tue, 27 Sep 2022 15:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date;
        bh=EqsA45vArW1jYc6Dv+3e8MlzVLIM63c0M/moa9HScAs=;
        b=JZOfY0lOjazdIP0MDuNJHVFccA9b0/il8AAhKDa27ZEIeDaH+9fTz8BEbVHlkwP2kw
         i3S62LkMEK6O6WxnnnXpl3/aTYuQ5FlkPakGBWGhrOfxOQ+ob1rK0v0SBITdUpzB5n+b
         /llmHiT+TNGjyMipQxiWMcyZbYpg85i/CX8twNJWGJ/CdzIaV+FqnV+HG/KRWqEd2cvQ
         R3RWKacXTP5r2MmYbWiIAyaYubOyTxRziz+M7APUI5hNlCoMKikX3p0p8lX+lCdh9l55
         y8Ct87c2+vApFfVG7xeNPVKSCsTj3tB4rpQLDs04OBlAUiq3rrs1zuWwIKfiZzhbIYGa
         volQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EqsA45vArW1jYc6Dv+3e8MlzVLIM63c0M/moa9HScAs=;
        b=Ms9UT4oEuBQSdc9fgjLwAE/CsI+LghYUjVoYJ+csWfeyJt10WdgGaM0sqFukWwyRTZ
         oePm89xy7HvNuxEwjrDdliVJv8uhQJYZZ0EF7kt1OzlYkjACdM2lhm6sKINVMl4yfEHs
         /n45NIskAHVCOIWs/dUpINrbpmklIxCcKtd0D2J8xG9Cp4laqPDb7JMFn8/oVNDz+D1D
         S/8Te8ylPXfHQN+BoLyZEUz0wU+bLDRN0aKYzytBg7HalsIzpiUHw7aUrtp5g4RrT6Mu
         QBDnxLBS8cXHHoGsgQ+yKlhy6/G+VdKdJ5kmdRYMMByTkl8Htn4Fl5Rrfqz7v698FjCG
         ZgGg==
X-Gm-Message-State: ACrzQf3qKXiYH2bTF/V7W+KYEPbYSZFWq3mHaOJ+F9QxGwXytCW5VMZ8
        8x8ls2kxeItcft8wdMy0nvoy01xzlmnvALQO
X-Google-Smtp-Source: AMsMyM5t1JhreBtatSfnKTTKPGS84TrGl9GhuTEiy60uIooQuvggjqh5URIINlBdoD2aFCHbQSXkCA==
X-Received: by 2002:a17:902:db12:b0:178:1f91:74e6 with SMTP id m18-20020a170902db1200b001781f9174e6mr29787222plx.100.1664319388738;
        Tue, 27 Sep 2022 15:56:28 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id p125-20020a625b83000000b0052d432b4cc0sm2359967pfb.33.2022.09.27.15.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:56:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     =?utf-8?Q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH 3/3] dma/ti: convert PSIL to be buildable as module
In-Reply-To: <390efbdd-6bb2-b1bb-7c4f-9c6f9032876a@gmail.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <20220926181848.2917639-4-khilman@baylibre.com>
 <4c9f0284-f8d0-75e5-8bc9-944b040f9edb@gmail.com>
 <7hfsgeezqx.fsf@baylibre.com>
 <390efbdd-6bb2-b1bb-7c4f-9c6f9032876a@gmail.com>
Date:   Tue, 27 Sep 2022 15:56:27 -0700
Message-ID: <7hmtakxw84.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi P=C3=A9ter

P=C3=A9ter Ujfalusi <peter.ujfalusi@gmail.com> writes:

> On 26/09/2022 21:50, Kevin Hilman wrote:
>> P=C3=A9ter Ujfalusi <peter.ujfalusi@gmail.com> writes:
>>=20
>>> Hi Kevin,
>>>
>>> On 9/26/22 21:18, Kevin Hilman wrote:
>>>> map symbols need EXPORT_SYMBOL and files need MODULE_LICENSE.
>>>>
>>>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>>>> ---
>>>>   drivers/dma/ti/Kconfig          | 3 ++-
>>>>   drivers/dma/ti/k3-psil-am62.c   | 4 ++++
>>>>   drivers/dma/ti/k3-psil-am64.c   | 4 ++++
>>>>   drivers/dma/ti/k3-psil-am654.c  | 4 ++++
>>>>   drivers/dma/ti/k3-psil-j7200.c  | 4 ++++
>>>>   drivers/dma/ti/k3-psil-j721e.c  | 4 ++++
>>>>   drivers/dma/ti/k3-psil-j721s2.c | 4 ++++
>>>>   drivers/dma/ti/k3-psil.c        | 2 ++
>>>>   8 files changed, 28 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
>>>> index f196be3b222f..2adc2cca10e9 100644
>>>> --- a/drivers/dma/ti/Kconfig
>>>> +++ b/drivers/dma/ti/Kconfig
>>>> @@ -56,7 +56,8 @@ config TI_K3_UDMA_GLUE_LAYER
>>>>   	  If unsure, say N.
>>>>=20=20=20
>>>>   config TI_K3_PSIL
>>>> -	bool
>>>> +       tristate
>>>> +       default TI_K3_UDMA
>>>>=20=20=20
>>>>   config TI_DMA_CROSSBAR
>>>>   	bool
>>>> diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am=
62.c
>>>> index 2b6fd6e37c61..7c4ca85f68b1 100644
>>>> --- a/drivers/dma/ti/k3-psil-am62.c
>>>> +++ b/drivers/dma/ti/k3-psil-am62.c
>>>> @@ -4,6 +4,7 @@
>>>>    */
>>>>=20=20=20
>>>>   #include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>>=20=20=20
>>>>   #include "k3-psil-priv.h"
>>>>=20=20=20
>>>> @@ -184,3 +185,6 @@ struct psil_ep_map am62_ep_map =3D {
>>>>   	.dst =3D am62_dst_ep_map,
>>>>   	.dst_count =3D ARRAY_SIZE(am62_dst_ep_map),
>>>>   };
>>>> +EXPORT_SYMBOL_GPL(am62_ep_map);
>>>
>>> Wouldn't it be better to build one module (k3-psil.ko) and link all the
>>> platform libs into that?
>>> They are unconditionally built in all cases anyways and makes the lsmod
>>> under control.
>>> And no need to export these maps at all is a plus.
>>=20
>> I guess that's one option, but seems to be to be the wrong direction for
>> a modular kernel.  To me, it seems like the next step would be to make
>> it so only the SoC specific module is loaded instead of always loading
>> them all.
>
> The PSI-L map is a library atm and exporting all the maps outside of the=
=20
> PSI-L library is wrong. We shall have fixed API to look up (and update)=20
> a PSI-L endpoint configuration and only that API shall be allowed.
>
> I prefer to have a single .ko binary for the PSI-L library/database for=20
> now. Optionally the individual SoC maps could be marked as init data and=
=20
> we could make a copy of the one that is needed on the booted device.
>
> For SoC only loading this whole library way must be reworked to a=20
> platform or a bus driver (the bus description via DT was shot down=20
> during the initial UDMA submission, fyi). So you need to find a 'device'=
=20
> which would probe the PSI-L map and only load the map that is needed.
>
> Furthermore: having the individual maps as separate .ko objects does not=
=20
> make much sense as none of them can be removed runtime, the symbols are=20
> used in the 'core' library.

OK, I understand.  I'll send a v2 with everything built into a single
.ko (but I'll leave the initdata stuff for an optional follow-up series,
since I don't fully understand how/when all these maps are used.)

Thanks for your detailed review & suggestions,

Kevin
