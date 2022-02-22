Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388E64C01EF
	for <lists+dmaengine@lfdr.de>; Tue, 22 Feb 2022 20:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiBVTVj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 14:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiBVTVi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 14:21:38 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6734BD2F4;
        Tue, 22 Feb 2022 11:21:12 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id g15so279508ual.11;
        Tue, 22 Feb 2022 11:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBvMIb8OT5TkXgxu8ndJKb1NeTk3l6YrJ/QsnvHZQzk=;
        b=il/63vAG+7Hf0WVicAPjbJM4zGY9oaY2SMBi2rBfvBMiOr/s4W0yj6XqtRGsCaMJUK
         3oBW/f02kXXbiw8puf7LVSAxx5e0JRU/0rHVg+O9T2WNCTKlY/kWDpRNW82pa9v4iy5B
         cdnvsmkuIQOKbU0cc8iprOhvf6d4BQ+dUEyFezEpBy+Yvpyfad4+Wx+2jW7mSwKgMvjS
         QUlmttxbgyMncWGO8buySj9tteV5iubEnBFmlxI49745JYyL2Z6b3mkAwYvqD0TtKDs9
         ZZA/Ncm17rc5bSOx955NT2FCYrM6bltHVv5L3c3XMJ5W2M7sSf5/143ggp28xfKz+47z
         EZnA==
X-Gm-Message-State: AOAM530EzDQxqpEv1Tu83JRBRELZUEf1ZN6eaFU1igQFib4TiIOPIF1X
        NzRLmjUJ6vwdXq6iI6zXBl7OtHzhZWhTLw==
X-Google-Smtp-Source: ABdhPJxVkvPlAa7PgZh5bknmQbr+RahIdrUjggtcS0vhrzlUMbgfdqbk5eJ+QREdibvJO+gaU8fkeQ==
X-Received: by 2002:a9f:3dc7:0:b0:33d:1812:15ac with SMTP id e7-20020a9f3dc7000000b0033d181215acmr10754473uaj.79.1645557671838;
        Tue, 22 Feb 2022 11:21:11 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id v128sm1095757vkv.2.2022.02.22.11.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 11:21:11 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id g20so668759vsb.9;
        Tue, 22 Feb 2022 11:21:11 -0800 (PST)
X-Received: by 2002:a67:e10e:0:b0:31b:956b:70cf with SMTP id
 d14-20020a67e10e000000b0031b956b70cfmr10507511vsl.77.1645557670916; Tue, 22
 Feb 2022 11:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20220222090435.62571-1-tsbogend@alpha.franken.de>
In-Reply-To: <20220222090435.62571-1-tsbogend@alpha.franken.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Feb 2022 20:20:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWRHm8B8KdkgVyqrUqn3q=-8VUpikR0eZBFQD46X7YBVg@mail.gmail.com>
Message-ID: <CAMuHMdWRHm8B8KdkgVyqrUqn3q=-8VUpikR0eZBFQD46X7YBVg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Remove TX39XX support
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 22, 2022 at 10:50 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> No (active) developer owns this hardware, so let's remove Linux support.
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

My rbt4927 still works fine, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
