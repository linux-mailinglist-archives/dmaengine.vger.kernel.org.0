Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D7B509189
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382231AbiDTUrr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 16:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382203AbiDTUrc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 16:47:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4CD42ED0;
        Wed, 20 Apr 2022 13:44:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b7so2892694plh.2;
        Wed, 20 Apr 2022 13:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xImE356a59BZUnW4Cic4JbWC5DVqpMAKjv6nwKPx9DI=;
        b=OL+QXVJEpjV7Z4HuC//q37HqEuUht5h1CcpKGCCRPAuSYfx2YaqLCPrvEiiO6kkGQk
         ggnMOq4NmaIE9B/cPhZqsf2wZexOSYOkZPiDlrJdAHQqubU8MJXkS448ovjQVaRnX2e5
         LgEycZiGsVjUMCg/zKHNyTA3QJf2e1fWo5sPcrVoK5ceeKR5+XlHe/v27vaSfj2kNKZm
         Lme5O2auyyEXGSeMUH5F9xazkNNEa6Oq/msiVIUxgriDElUFLOTt3BxB9fFZuOIoJPDR
         AGZh/1BBFqOc7WG1aCYUXuhGLOOD5R0CwNE7wt0mGMLXgsVtmHrbHmdtHto+xpq+O7Qx
         +r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xImE356a59BZUnW4Cic4JbWC5DVqpMAKjv6nwKPx9DI=;
        b=7oTS/NFWLqgwlxt+NIUgSjYOxGC1+Iu641FBCkRZGj6s8U7/NFFW5Usz++cDxCl/nm
         nWHn1CfAnUx9YXTcLXUaL/197bdUasS/JWDSNtyiDvmR/213RtApqGAMBYDIbgdynOfy
         O1mNmga4nX28c75x4rsQfcKC9T68gpkGxje51+gJwPMD7+ZBJPfzhYS66bUl9E0P3938
         lS0bUw8XqOc8aQkxob/28PEcoTfEKQhu4sXYj4nRLPK9tJKRpl1Gvm0v65bOO/HoVlat
         qUvvVQvQbvjCS9/Gj2Qcr2sobe2XQxwMPB/ZoLqwitA7iv9Pr+NQFrO6AgVvVpA0S7Ug
         rCQg==
X-Gm-Message-State: AOAM533tiOVRRfHxHStVccgU9/sW6sa9awwCaDegtXontXcQOm4hmT6T
        JEYmEDytcwiSMBAKVdLTa5o=
X-Google-Smtp-Source: ABdhPJyBl+Q5YR9vFVRt1kP8/H8gZas/M80UgmaibWxL0BJyPvZZ1qF4/ahkBpyves1PD3Tl2tbTiQ==
X-Received: by 2002:a17:902:b48a:b0:158:e38d:ca23 with SMTP id y10-20020a170902b48a00b00158e38dca23mr21918715plr.115.1650487484960;
        Wed, 20 Apr 2022 13:44:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:fe4b:9301:599b:d734])
        by smtp.gmail.com with ESMTPSA id l25-20020a635719000000b0039da6cdf82dsm20914985pgb.83.2022.04.20.13.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:44:43 -0700 (PDT)
Date:   Wed, 20 Apr 2022 13:44:40 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
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
Subject: Re: [PATCH 15/41] input: omap: void using mach/*.h headers
Message-ID: <YmBwuBc9UVH6MK+M@google.com>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-16-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419133723.1394715-16-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 19, 2022 at 03:36:57PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The omap-keypad driver currently relies on including mach/memory.h
> implicitly, but that won't happen once omap1 is converted to
> CONFIG_ARCH_MULTIPLATFORM. Include the required header
> explicitly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/keyboard/omap-keypad.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
> index eb3a687796e7..57447d6c9007 100644
> --- a/drivers/input/keyboard/omap-keypad.c
> +++ b/drivers/input/keyboard/omap-keypad.c
> @@ -24,6 +24,7 @@
>  #include <linux/gpio.h>
>  #include <linux/platform_data/gpio-omap.h>
>  #include <linux/platform_data/keypad-omap.h>
> +#include <linux/soc/ti/omap1-io.h>
>  
>  #undef NEW_BOARD_LEARNING_MODE
>  
> -- 
> 2.29.2
> 

-- 
Dmitry
