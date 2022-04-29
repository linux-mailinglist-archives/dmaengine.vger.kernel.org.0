Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AB851547D
	for <lists+dmaengine@lfdr.de>; Fri, 29 Apr 2022 21:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377206AbiD2Tdf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Apr 2022 15:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357195AbiD2Tde (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Apr 2022 15:33:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B613D03;
        Fri, 29 Apr 2022 12:30:14 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c15so11650350ljr.9;
        Fri, 29 Apr 2022 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EpAcbnx+U/L1NwXa16pvqhPXcqBubVwUeHlDIja2sKs=;
        b=fVBaXJcaF9JmA9kT3gJGJ1d182xVAxExs/K2C2cpg9fOUq9K4LgvkN5/2cWKEV8XX1
         vdk0G98yxS2sLJ8zWaB7rhdyyJXKLgvzNqBV6A8afXlXuOH91elyLLmUDaTqdKe4V69x
         AAvZ50gl//UGXVXDm7KrqMLY7C8sZcSZWv2FS0leIXeR83qD9QrBN8p2fl+Pq8HASr1G
         TKXvllgu1hI2pYC43JwELnhiq4v7YL5/ugckF8nanpl/WTJIHkmE7zH4QJz9h7FqOUVT
         0Jz3z+e4DkBb7K3Koshx7MxQKB7Q04DFmhKx0W84Bksadz0n4fPxx9SVm6StU8NgbLlo
         18pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EpAcbnx+U/L1NwXa16pvqhPXcqBubVwUeHlDIja2sKs=;
        b=YWQMMlhm+0W5xptY+8dn4YRDAhByKq9NNVHmlyPkCq+u7EXiYpMOKFYEXe5TZDPfDU
         eUMwTSyOtHmO/b0CYvKRiqtB2fA8c3L8R3D9HOosOBQMyI4HDF/QsTZ5s8JZfyHF1vTx
         9/CTZUlsPs/zCsSw2vTPlsiZElWEl+awl3H/A+zmbE4vrtP+flpwoL5b2YMyiG1Co7JV
         yEG8HlDI4N0pc4Em/PMfBvQT8x2+6+VsVxnZP9DcLqyv2Lvcnxu1o+ox+XsPLUmpjpeu
         vGJdkXdUL/tQ7KDSAO2NIEAwU1RvSmeltOAenwdMYkAYCUJGxy4Bs4qoZ+1yBXsfwRRN
         JXJg==
X-Gm-Message-State: AOAM533USA4eG1AgtFaw+rBqJuEFEXmjN+teG8FKBlqJ9+lm+EQjKIr8
        tpGBLjIeP6fR2ybgroJzqm4=
X-Google-Smtp-Source: ABdhPJyG5g1UMJHbAE7oQdPUIBwsTGD8b2GZt4x0YMEODqQnagM+tQa4NgqWxwqwNFjLTVjBd5ZQlA==
X-Received: by 2002:a2e:8502:0:b0:24f:1036:b405 with SMTP id j2-20020a2e8502000000b0024f1036b405mr465514lji.220.1651260612572;
        Fri, 29 Apr 2022 12:30:12 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id d3-20020ac24c83000000b0047255d2115dsm5721lfl.140.2022.04.29.12.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 12:30:12 -0700 (PDT)
Message-ID: <7e47c5fa-4cff-b12f-20ce-2e62b62ec538@gmail.com>
Date:   Fri, 29 Apr 2022 22:36:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 22/41] ARM: omap1: move plat/dma.c to mach/omap-dma.c
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, linux-omap@vger.kernel.org,
        tony@atomide.com, aaro.koskinen@iki.fi, jmkrzyszt@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-23-arnd@kernel.org>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220419133723.1394715-23-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/19/22 16:37, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most of the interface functions in plat/dma.c are only used from the
> USB driver, which is practically OMAP1 specific, except for compile
> testing.
> 
> The omap_get_plat_info(), omap_request_dma() and omap_free_dma()
> functions are never called on omap2 because of runtime checks.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap1/Makefile                        | 2 +-
>  arch/arm/{plat-omap/dma.c => mach-omap1/omap-dma.c} | 0
>  arch/arm/plat-omap/Makefile                         | 2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename arch/arm/{plat-omap/dma.c => mach-omap1/omap-dma.c} (100%)
> 
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index 450bbf552b57..0615cb0ba580 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -5,7 +5,7 @@
>  
>  # Common support
>  obj-y := io.o id.o sram-init.o sram.o time.o irq.o mux.o flash.o \
> -	 serial.o devices.o dma.o fb.o
> +	 serial.o devices.o dma.o omap-dma.o fb.o
>  obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
>  
>  ifneq ($(CONFIG_SND_SOC_OMAP_MCBSP),)
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/mach-omap1/omap-dma.c
> similarity index 100%
> rename from arch/arm/plat-omap/dma.c
> rename to arch/arm/mach-omap1/omap-dma.c
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 68ccec9de106..5d55295a14ee 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -6,4 +6,4 @@
>  ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-omap/include
>  
>  # Common support
> -obj-y := sram.o dma.o
> +obj-y := sram.o

-- 
Péter
