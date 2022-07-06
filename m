Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103F95680B6
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiGFIDh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 04:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiGFIDg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 04:03:36 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40607112D;
        Wed,  6 Jul 2022 01:03:35 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id z12so10495320qki.3;
        Wed, 06 Jul 2022 01:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm7RnST85MIDJNN+2iaSBOhoswr2qSrezycwHqjqOec=;
        b=fcrhL3OiHlR9dOFNNY+eaTjH8iKVfWBno9MkBZa32r/KMZsXIDfKlP9boKY2jdi7Gv
         Gil6sFKTWG1i8/lwgkkC2kHcEYeUoiuRwoS13+uEd0qskHPXPL0IjSSABGW8kdxUztkV
         /WLqRGSS5IW57IKFgPQJhnh9SnWGS1Q21zLLP+9sa4zkxc3w4eX4YwKsMtheqVGHzHLe
         eY+mK0bz6Gj3LnCWV4vpUk2cxiLF4kg7dz3/u+cigqRQZD7uRZQyq3KXRDnFRNSVnmpE
         Jyb4OKsfHX0QaX0mBP8OGVE5aXeOAfwrFcqg1oofn2yUYziJS1xQ8xI3FWf8EhfQROW3
         pA8g==
X-Gm-Message-State: AJIora8t7vTkN4slON78vOIDYUjt591WypbA75zmMQjapQStxaiqvU3K
        uSS1xqo3k7DFkFToZ2lYMlzL8yUvXDbYsQ==
X-Google-Smtp-Source: AGRyM1sZUa78MrahEXAR7bJTtWbKG5S3y9s8JnJHXQzOQ5pzAu2NlZr/77IrtSVFVjytfLtRBQlgaQ==
X-Received: by 2002:a05:620a:4055:b0:6b0:151f:7281 with SMTP id i21-20020a05620a405500b006b0151f7281mr25804652qko.601.1657094614268;
        Wed, 06 Jul 2022 01:03:34 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id t17-20020a05620a005100b006af20edff0csm22694447qkt.58.2022.07.06.01.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:03:33 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31c86fe1dddso84448447b3.1;
        Wed, 06 Jul 2022 01:03:33 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr9659273ywb.502.1657094613015; Wed, 06
 Jul 2022 01:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220705215213.1802496-1-mail@conchuod.ie>
In-Reply-To: <20220705215213.1802496-1-mail@conchuod.ie>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 10:03:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOK+iHeTfRLDeMF1mwZoeH1KH_GHuCY72YnhQibGqhwA@mail.gmail.com>
Message-ID: <CAMuHMdVOK+iHeTfRLDeMF1mwZoeH1KH_GHuCY72YnhQibGqhwA@mail.gmail.com>
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
> I *DO NOT* have any Canaan hardware so I have not tested any of this in
> action. Since I sent v1, I tried to buy some since it's cheap - but could
> out of the limited stockists none seemed to want to deliver to Ireland :(
> I based the series on next-20220617.

Digi-Key does not want to ship to IRL?
The plain MAiX BiT is out-of-stock, but the kit incl. a display is
available (97 in stock).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
