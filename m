Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347C25680E3
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGFIQD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGFIQB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 04:16:01 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D701DA6D;
        Wed,  6 Jul 2022 01:16:00 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id o185so1866456vsc.7;
        Wed, 06 Jul 2022 01:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNNZ2G3zXs1oo3JcBfsTX3whovGatUAPfm1YVK9uZPI=;
        b=oldjN0zReoqhuAgGlziquy7fZz+ZOD7S1CBQq9AJHwlq/vBMztVIggYJT/Vknzpert
         Tp2JhRo2kDjKe4sQ5AIaHfDo0AiW+ngvBa8G/yZ8wuurOK1/pJ8XxBMMtmo7P2Y4xQCD
         ZHHdeUN27Vgmi0nmirrJjHcAytCJIVuIfGtJzx/9WCMv38f3H071fEmD1GGo4cbMXGB+
         S84FmnrvosZsG/tkRnL9SGmzRZa0tdzZ/QM+llZowljOql8qK9rVl6QfwtUgOOFY8gdb
         8aB+dFFpP9RkdEglH70rWiPinbWZ+OCybmMgKX1Zr1QPoqfAEegg3Aiw0LmH1H/fSoxB
         vIkg==
X-Gm-Message-State: AJIora91RCx/UZVOcj7mWGchHZ+M8d263JpjSqUaNb+ijVDuT25MZRBT
        AGxwuRv60/4K8kWBScwns9zwwiI/TjAJ0A==
X-Google-Smtp-Source: AGRyM1uVzuPT53m8JitCqfLOzvOk/8XU7TAOhKz3cNKhgvVKMBZTFBqWrSAu5c3cJkQHBbfm2wk2wQ==
X-Received: by 2002:a05:6102:23f1:b0:356:97b0:29bf with SMTP id p17-20020a05610223f100b0035697b029bfmr14487158vsc.87.1657095359702;
        Wed, 06 Jul 2022 01:15:59 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id s7-20020a1f4507000000b0036bf47b519asm9587768vka.54.2022.07.06.01.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:15:59 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id n3so2926546uak.13;
        Wed, 06 Jul 2022 01:15:59 -0700 (PDT)
X-Received: by 2002:a25:be49:0:b0:64a:2089:f487 with SMTP id
 d9-20020a25be49000000b0064a2089f487mr27921915ybm.202.1657094998024; Wed, 06
 Jul 2022 01:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220705215213.1802496-1-mail@conchuod.ie>
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 10:09:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrVsvYRth+edCs6_bdDTWDacxegMDmgy9HeaKPRaWfkg@mail.gmail.com>
Message-ID: <CAMuHMdXrVsvYRth+edCs6_bdDTWDacxegMDmgy9HeaKPRaWfkg@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] Canaan devicetree fixes
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

Hi Conor,

On Tue, Jul 5, 2022 at 11:52 PM Conor Dooley <mail@conchuod.ie> wrote:
> This series should rid us of dtbs_check errors for the RISC-V Canaan k210
> based boards. To make keeping it that way a little easier, I changed the
> Canaan devicetree Makefile so that it would build all of the devicetrees
> in the directory if SOC_CANAAN.
>
> I *DO NOT* have any Canaan hardware so I have not tested any of this in
> action. Since I sent v1, I tried to buy some since it's cheap - but could
> out of the limited stockists none seemed to want to deliver to Ireland :(
> I based the series on next-20220617.

Boots fine on SiPEED MAiX BiT, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
