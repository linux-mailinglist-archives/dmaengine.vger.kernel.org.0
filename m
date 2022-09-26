Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689B75EB2F4
	for <lists+dmaengine@lfdr.de>; Mon, 26 Sep 2022 23:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiIZVRp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiIZVRo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 17:17:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B30D8169D
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 14:17:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so8220781pjk.2
        for <dmaengine@vger.kernel.org>; Mon, 26 Sep 2022 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date;
        bh=kmdrunDnLmESbEAIw7duvGisQC3NuIpiA59yQbUiXIc=;
        b=wiOrL9A1thkmxJu1zoWAhRS+bj0hy8y2efKqsGC0WePwZmYMQ1DD/itU0j2sAGgpS/
         P1S8/1wV0n7YY/bU5ENfC9Wf5wNhgV1036FycYoN9oP/UEkg+PbDO3NNiVxpg6YTxM8j
         bBtI5Q3HSGtpa0ZyWlHSCCn+R4ZNJDTn69z+RlB84kOdHXPnl9FoqipBX9zNnrH5yBL3
         YMywXLnDnBbdcELBxCEjrPlXjrU6ITU1KN4vk7mNprzR0gSziQKNshgF9T7geOc/odDA
         YoY35ALc6V3DCwsLnoMTsfH3plVwJvuUtxxPMh3Y/82lr7M2COsktRqt9FQMS24HlTv1
         U/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kmdrunDnLmESbEAIw7duvGisQC3NuIpiA59yQbUiXIc=;
        b=1ZWUNSbMSPvtKRehZMR2yMPoqcxmbLD7kTTL4DLlM8VH/zJL2b40C/qlyiHbZlahr6
         yL5mvxdFIhQz+Crl7s5M0XBzS5RL24O+hJye8gEKiS+i0L/QkT2jeZawPmfhdOPGUeKF
         JJIrl34CtjQ9cyqQgR4BkUqNlHBDDCoGU1XgtwGTbcO/569s/F1y3n9HSZl5f7GufQqw
         o6sRjraxURedA6MfD8g4tjinpOzxPnXjOs7QD2nY1o6mx46JR60mHhR0f18jZgTf44mf
         rXIy4AjZhB2pqZniuK1jTH20XKxLCx+pIe5c5cQheTlB8ajoOeliBbmKZcIcuXP1QWez
         661w==
X-Gm-Message-State: ACrzQf3IfqaGMhfDbdEbWDuL0E0w7tReg7N6vXUu3NdFk2Cd7kWB0YBF
        dMujOCnSQ/Q5AQ9bjD6gEQFfbw==
X-Google-Smtp-Source: AMsMyM4ylTVOCXrE0LWpNmCRA7TY3lxZQplOCS6+aDNLtMZ9CKffh7pxyW7sdNBYVusKpqrZqIwTFQ==
X-Received: by 2002:a17:90b:1941:b0:202:5715:2180 with SMTP id nk1-20020a17090b194100b0020257152180mr763629pjb.23.1664227061577;
        Mon, 26 Sep 2022 14:17:41 -0700 (PDT)
Received: from localhost ([76.146.1.42])
        by smtp.gmail.com with ESMTPSA id e128-20020a621e86000000b0053e669cc845sm12655682pfe.190.2022.09.26.14.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:17:40 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     =?utf-8?Q?P=C3=A9ter?= Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
Subject: Re: [PATCH 2/3] dma/ti: convert k3-udma to module
In-Reply-To: <11cf284c-d0d6-0687-b70b-2245ff8d6fcd@gmail.com>
References: <20220926181848.2917639-1-khilman@baylibre.com>
 <20220926181848.2917639-3-khilman@baylibre.com>
 <11cf284c-d0d6-0687-b70b-2245ff8d6fcd@gmail.com>
Date:   Mon, 26 Sep 2022 14:17:40 -0700
Message-ID: <7hczbhg7ij.fsf@baylibre.com>
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

> On 9/26/22 21:18, Kevin Hilman wrote:
>> Currently k3-udma driver is built as separate platform drivers with a
>> shared probe and identical code path, just differnet platform data.
>>=20
>> To enable to build as module, convert the separate platform driver
>> into a single module_platform_driver with the data selection done via
>> compatible string and of_match.  The separate of_match tables are also
>> combined into a single table to avoid the multiple calls to
>> of_match_node()
>>=20
>> Since all modern TI platforms using this are DT enabled, the removal
>> of separate platform_drivers shoul should nave no functional change.
>>=20
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>>  drivers/dma/ti/Kconfig        |  4 ++--
>>  drivers/dma/ti/k3-udma-glue.c |  5 ++++-
>>  drivers/dma/ti/k3-udma.c      | 40 +++++------------------------------
>>  3 files changed, 11 insertions(+), 38 deletions(-)
>>=20
>> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
>> index 79618fac119a..f196be3b222f 100644
>> --- a/drivers/dma/ti/Kconfig
>> +++ b/drivers/dma/ti/Kconfig
>> @@ -35,7 +35,7 @@ config DMA_OMAP
>>  	  DMA engine is found on OMAP and DRA7xx parts.
>>=20=20
>>  config TI_K3_UDMA
>> -	bool "Texas Instruments UDMA support"
>> +	tristate "Texas Instruments UDMA support"
>>  	depends on ARCH_K3
>>  	depends on TI_SCI_PROTOCOL
>>  	depends on TI_SCI_INTA_IRQCHIP
>> @@ -48,7 +48,7 @@ config TI_K3_UDMA
>>  	  DMA engine is used in AM65x and j721e.
>>=20=20
>>  config TI_K3_UDMA_GLUE_LAYER
>> -	bool "Texas Instruments UDMA Glue layer for non DMAengine users"
>> +	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
>>  	depends on ARCH_K3
>>  	depends on TI_K3_UDMA
>>  	help
>> diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue=
.c
>> index 4fdd9f06b723..c29de4695ae7 100644
>> --- a/drivers/dma/ti/k3-udma-glue.c
>> +++ b/drivers/dma/ti/k3-udma-glue.c
>> @@ -6,6 +6,7 @@
>>   *
>>   */
>>=20=20
>> +#include <linux/module.h>
>>  #include <linux/atomic.h>
>>  #include <linux/delay.h>
>>  #include <linux/dma-mapping.h>
>> @@ -1433,4 +1434,6 @@ static int __init k3_udma_glue_class_init(void)
>>  {
>>  	return class_register(&k3_udma_glue_devclass);
>>  }
>> -arch_initcall(k3_udma_glue_class_init);
>> +
>> +module_init(k3_udma_glue_class_init);
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
>> index 2f0d2c68c93c..7239ff31c8c5 100644
>> --- a/drivers/dma/ti/k3-udma.c
>> +++ b/drivers/dma/ti/k3-udma.c
>> @@ -5,6 +5,7 @@
>>   */
>>=20=20
>>  #include <linux/kernel.h>
>> +#include <linux/module.h>
>>  #include <linux/delay.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/dma-mapping.h>
>> @@ -4318,18 +4319,10 @@ static const struct of_device_id udma_of_match[]=
 =3D {
>>  		.compatible =3D "ti,j721e-navss-mcu-udmap",
>>  		.data =3D &j721e_mcu_data,
>>  	},
>> -	{ /* Sentinel */ },
>> -};
>> -
>> -static const struct of_device_id bcdma_of_match[] =3D {
>>  	{
>>  		.compatible =3D "ti,am64-dmss-bcdma",
>>  		.data =3D &am64_bcdma_data,
>>  	},
>> -	{ /* Sentinel */ },
>> -};
>> -
>> -static const struct of_device_id pktdma_of_match[] =3D {
>>  	{
>>  		.compatible =3D "ti,am64-dmss-pktdma",
>>  		.data =3D &am64_pktdma_data,
>> @@ -5254,14 +5247,9 @@ static int udma_probe(struct platform_device *pde=
v)
>>  		return -ENOMEM;
>>=20=20
>>  	match =3D of_match_node(udma_of_match, dev->of_node);
>> -	if (!match)
>> -		match =3D of_match_node(bcdma_of_match, dev->of_node);
>>  	if (!match) {
>> -		match =3D of_match_node(pktdma_of_match, dev->of_node);
>> -		if (!match) {
>> -			dev_err(dev, "No compatible match found\n");
>> -			return -ENODEV;
>> -		}
>> +		dev_err(dev, "No compatible match found\n");
>> +		return -ENODEV;
>>  	}
>>  	ud->match_data =3D match->data;
>>=20=20
>> @@ -5494,27 +5482,9 @@ static struct platform_driver udma_driver =3D {
>>  	},
>>  	.probe		=3D udma_probe,
>>  };
>> -builtin_platform_driver(udma_driver);
>>=20=20
>> -static struct platform_driver bcdma_driver =3D {
>> -	.driver =3D {
>> -		.name	=3D "ti-bcdma",
>> -		.of_match_table =3D bcdma_of_match,
>> -		.suppress_bind_attrs =3D true,
>> -	},
>> -	.probe		=3D udma_probe,
>> -};
>> -builtin_platform_driver(bcdma_driver);
>> -
>> -static struct platform_driver pktdma_driver =3D {
>> -	.driver =3D {
>> -		.name	=3D "ti-pktdma",
>> -		.of_match_table =3D pktdma_of_match,
>> -		.suppress_bind_attrs =3D true,
>> -	},
>> -	.probe		=3D udma_probe,
>> -};
>> -builtin_platform_driver(pktdma_driver);
>> +module_platform_driver(udma_driver);

> I did liked the 'hack' that the dev_* prints contained the actual type
> of the DMA (udma/bcdma/pktdma), but it is not working via modules,
> unless the driver init parts are split out and the bulk is kept as a
> library.
>
> I had this half way implemented in my wip, but never got the chance to
> finalize it.

I guess that could always be done as a second path if needed, but I
wanted to keep this module conversion as simple as possible at first.

> But, one can get the info via the address, so...

Shall I take this "so..." as an acked-by?  ;)

Kevin


