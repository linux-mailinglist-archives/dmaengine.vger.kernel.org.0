Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5985EDE2E
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiI1NxN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 09:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiI1NxM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 09:53:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F683062;
        Wed, 28 Sep 2022 06:53:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a3so20427546lfk.9;
        Wed, 28 Sep 2022 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yBiN95FwXRcgfqH7XG/uqubJ1q9Z8t5K+fsUnYyXFIk=;
        b=ENjf752b9fFgA9usSparRmdSBfWBFzJc8yFOGpCdx+SQgL9fwTlDLHYguW3fAom/E2
         etuJIZtAPLEc7pHLUYwtVUWAJxZgdNI/bAXEqxDfMaYGopNmU8UVocqUWvsISjdTLRqU
         JODX4DhpOVyLFNiCjcKyuIJWiVd4ZwEDdGhVd7FKyjPSfH/rKc5xblVt7MzRDuHb7q6l
         TljJoRcclQPPpRgI2g0UyXIRfo5rMMFOVfXJTIobsmFFR/6at1PySrL8kPtfmzOOytCw
         +S0pRovvBx1F3h5iLRrFns3ffcbOfXQjprTHKlyZcAfMLhWasyRT3QiVu4Bjv+bgMTVR
         oKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yBiN95FwXRcgfqH7XG/uqubJ1q9Z8t5K+fsUnYyXFIk=;
        b=jKFyG3NCxtKoSUnkjW6LxJ8VmrN+GkCZqbfGjvoEyN+kPTjpkFLwW65ogsADKqBy+Q
         vMGDZdD7VkxZxCAz2jDX/BU3uA3qBlbmNAWiip8nth3f3KY4mWu53uytu5J2oPog6I4N
         IX5275A36d37dJzlQZFhCXlokdj+InyHLfwNSZWxWpAZKCV1067S/MJH3XCpU773R+79
         NuAcrsR+Yszjc7iE5X3cNnZEM1pLN3uQ7WqCLVgaOELc4bWa/4kW6G+2f4DTwVtYIFD0
         yHMKG3iQZw2HV0RMN9ikSmw29bUV5Onmyg3IWT+GqTBV9K6ZTceuLM+jEi6TC3EM9Kqe
         Ah9A==
X-Gm-Message-State: ACrzQf2HMVEL3qP4Hf2xE/E3WX6d15zwyLFkwciQfaG+jpZA9uphrcKy
        xmJeyLOcjJ6kMDSPd0qQi7E=
X-Google-Smtp-Source: AMsMyM4PrduexhWMJN2qzdPe5tnerRxzUuCeMIbhv4g8ynQZyAWHUFk4rWTvuD0KvdIn0bqxVNimEg==
X-Received: by 2002:a05:6512:2621:b0:491:10ba:321a with SMTP id bt33-20020a056512262100b0049110ba321amr12449601lfb.187.1664373188837;
        Wed, 28 Sep 2022 06:53:08 -0700 (PDT)
Received: from ?IPV6:2001:999:270:b554:a1b6:ee54:d32:c388? ([2001:999:270:b554:a1b6:ee54:d32:c388])
        by smtp.gmail.com with ESMTPSA id f26-20020a05651c02da00b00268b85321eesm442108ljo.113.2022.09.28.06.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 06:53:07 -0700 (PDT)
Message-ID: <9e628dc7-6453-7a96-87ca-9f1efa8bedc7@gmail.com>
Date:   Wed, 28 Sep 2022 16:53:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 3/3] dma/ti: convert PSIL to be buildable as module
To:     Kevin Hilman <khilman@baylibre.com>, dmaengine@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Frayer <nfrayer@baylibre.com>
References: <20220927230804.4085579-1-khilman@baylibre.com>
 <20220927230804.4085579-4-khilman@baylibre.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220927230804.4085579-4-khilman@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kevin,

On 28/09/2022 02:08, Kevin Hilman wrote:
> Combine all the SoC specific files into a single lib that can be
> built-in or built as a module.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>   drivers/dma/ti/Kconfig   |  3 ++-
>   drivers/dma/ti/Makefile  | 15 ++++++++-------
>   drivers/dma/ti/k3-psil.c |  2 ++
>   3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index f196be3b222f..2adc2cca10e9 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -56,7 +56,8 @@ config TI_K3_UDMA_GLUE_LAYER
>   	  If unsure, say N.
>   
>   config TI_K3_PSIL
> -	bool
> +       tristate
> +       default TI_K3_UDMA
>   
>   config TI_DMA_CROSSBAR
>   	bool
> diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
> index d3a303f0d7c6..383bbd6d12b9 100644
> --- a/drivers/dma/ti/Makefile
> +++ b/drivers/dma/ti/Makefile
> @@ -4,11 +4,12 @@ obj-$(CONFIG_TI_EDMA) += edma.o
>   obj-$(CONFIG_DMA_OMAP) += omap-dma.o
>   obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
>   obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
> -obj-$(CONFIG_TI_K3_PSIL) += k3-psil.o \
> -			    k3-psil-am654.o \
> -			    k3-psil-j721e.o \
> -			    k3-psil-j7200.o \
> -			    k3-psil-am64.o \
> -			    k3-psil-j721s2.o \
> -			    k3-psil-am62.o
> +obj-$(CONFIG_TI_K3_PSIL) += k3-psil-lib.o
> +k3-psil-lib-objs := k3-psil.o \
> +		    k3-psil-am654.o \
> +		    k3-psil-j721e.o \
> +		    k3-psil-j7200.o \
> +		    k3-psil-am64.o \
> +		    k3-psil-j721s2.o \
> +		    k3-psil-am62.o

Can you reverse the order? First declare the objects needed for k3-psil-lib.
It is more natural and easier to read.

With that change you can add my:
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>


>   obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
> diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
> index 761a384093d2..8b6533a1eeeb 100644
> --- a/drivers/dma/ti/k3-psil.c
> +++ b/drivers/dma/ti/k3-psil.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/kernel.h>
> +#include <linux/module.h>
>   #include <linux/device.h>
>   #include <linux/init.h>
>   #include <linux/mutex.h>
> @@ -101,3 +102,4 @@ int psil_set_new_ep_config(struct device *dev, const char *name,
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(psil_set_new_ep_config);
> +MODULE_LICENSE("GPL v2");

-- 
Péter
