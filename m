Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A35EB087
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 20:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIZSux (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 14:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiIZSuw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 14:50:52 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2614E7549A
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:50:50 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso7852712pjd.1
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 11:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date;
        bh=lRlQkEGyVotDOVgVJrH2x+4l2jryHK0GCkRlRhyLnhU=;
        b=wNQjmt87soT1/9iOavumcWhdxLJRmPMW/Ex1HSaDbDYmyFFKqLTbfk3MxMIVF3/h+2
         6r+N+caO4DyzpBpMl0zcVzBLaCM+NmRuuqmipB3zKX5h088QcM6jqUHIcSqjA0vaTR2h
         yPW5ooz9pjoc++gBhvJLObhUxv08wgY7qtiUMkr19WxtHQeXrCFiYHx3851B/1P5AdoQ
         kHoVB1XRCiiSj/Y6vwFavbjyY192VXrpUynzhzx48CitCJ/9OpuhPZMQjEfipvXDYujP
         KeJ2ALh31b/acF7AG6nuE3h7z/8ecfUtN5UM0oVrY2Nb6BsyHeO5rKaiijcKmrgaCyeC
         hwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lRlQkEGyVotDOVgVJrH2x+4l2jryHK0GCkRlRhyLnhU=;
        b=wW36t7fj4OBK8HonGkVqiN1yXVWb7JqbtSnOCHdbNYYw+gzo/lJ9J+lVJHSSaWiZlk
         nQODulvINUC/6JfJE3PYVacekkwk7IVCjFiYLe4SiWNH6nmW/PetBdjGqQhywr5fPMjQ
         jkz28zwzoEQrPqyhyItr+r8Jkzt9NhFDZPBL+ZEI79FnQcubaDgsNDIJVdSJpw21EYEk
         bkaTivjvEo56P6e0YbtYl6qtAUfKUQo0amyyk+1nPtYrJ/WimIAZIP9uTp8xHJ+idxLc
         2NeaY005572Y9GW7wyL9lNg6Owwf57G1g8Ktft5NH8EtlstTp3qt1sLdvkDc/mZh9zkv
         OzhA==
X-Gm-Message-State: ACrzQf0n9MqOPzc9MZnC3UzOPFnVTp1A4aQ392L88WmQOR2B4RRt5gxA
        x60fi43nRDXbAY/DUva/Zr5RXQ==
X-Google-Smtp-Source: AMsMyM6J++Jq/n6Tnfq8CzvGKz64B+KbXGB62f9OfjkL7sI9zcmjBW7e/aO/O6KZ5Zz+zGyVI86+Kw==
X-Received: by 2002:a17:902:da8f:b0:178:399b:89bb with SMTP id j15-20020a170902da8f00b00178399b89bbmr23612803plx.57.1664218249640;
        Mon, 26 Sep 2022 11:50:49 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b00439d071c110sm11083443pgs.43.2022.09.26.11.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:50:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     =?utf-8?Q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH 3/3] dma/ti: convert PSIL to be buildable as module
In-Reply-To: <4c9f0284-f8d0-75e5-8bc9-944b040f9edb@gmail.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <20220926181848.2917639-4-khilman@baylibre.com>
 <4c9f0284-f8d0-75e5-8bc9-944b040f9edb@gmail.com>
Date:   Mon, 26 Sep 2022 11:50:46 -0700
Message-ID: <7hfsgeezqx.fsf@baylibre.com>
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

P=C3=A9ter Ujfalusi <peter.ujfalusi@gmail.com> writes:

> Hi Kevin,
>
> On 9/26/22 21:18, Kevin Hilman wrote:
>> map symbols need EXPORT_SYMBOL and files need MODULE_LICENSE.
>>=20
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  drivers/dma/ti/Kconfig          | 3 ++-
>>  drivers/dma/ti/k3-psil-am62.c   | 4 ++++
>>  drivers/dma/ti/k3-psil-am64.c   | 4 ++++
>>  drivers/dma/ti/k3-psil-am654.c  | 4 ++++
>>  drivers/dma/ti/k3-psil-j7200.c  | 4 ++++
>>  drivers/dma/ti/k3-psil-j721e.c  | 4 ++++
>>  drivers/dma/ti/k3-psil-j721s2.c | 4 ++++
>>  drivers/dma/ti/k3-psil.c        | 2 ++
>>  8 files changed, 28 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
>> index f196be3b222f..2adc2cca10e9 100644
>> --- a/drivers/dma/ti/Kconfig
>> +++ b/drivers/dma/ti/Kconfig
>> @@ -56,7 +56,8 @@ config TI_K3_UDMA_GLUE_LAYER
>>  	  If unsure, say N.
>>=20=20
>>  config TI_K3_PSIL
>> -	bool
>> +       tristate
>> +       default TI_K3_UDMA
>>=20=20
>>  config TI_DMA_CROSSBAR
>>  	bool
>> diff --git a/drivers/dma/ti/k3-psil-am62.c b/drivers/dma/ti/k3-psil-am62=
.c
>> index 2b6fd6e37c61..7c4ca85f68b1 100644
>> --- a/drivers/dma/ti/k3-psil-am62.c
>> +++ b/drivers/dma/ti/k3-psil-am62.c
>> @@ -4,6 +4,7 @@
>>   */
>>=20=20
>>  #include <linux/kernel.h>
>> +#include <linux/module.h>
>>=20=20
>>  #include "k3-psil-priv.h"
>>=20=20
>> @@ -184,3 +185,6 @@ struct psil_ep_map am62_ep_map =3D {
>>  	.dst =3D am62_dst_ep_map,
>>  	.dst_count =3D ARRAY_SIZE(am62_dst_ep_map),
>>  };
>> +EXPORT_SYMBOL_GPL(am62_ep_map);
>
> Wouldn't it be better to build one module (k3-psil.ko) and link all the
> platform libs into that?
> They are unconditionally built in all cases anyways and makes the lsmod
> under control.
> And no need to export these maps at all is a plus.

I guess that's one option, but seems to be to be the wrong direction for
a modular kernel.  To me, it seems like the next step would be to make
it so only the SoC specific module is loaded instead of always loading
them all.

Kevin
