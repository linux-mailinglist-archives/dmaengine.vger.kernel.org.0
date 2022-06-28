Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4F55D19D
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jun 2022 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbiF1HR5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jun 2022 03:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241457AbiF1HRE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Jun 2022 03:17:04 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2152CC9D;
        Tue, 28 Jun 2022 00:17:03 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id k10so8963910qke.9;
        Tue, 28 Jun 2022 00:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lScN3gMa3B+jKKFR5EiTq6EuQY+/4GeckwwsLv10h1E=;
        b=QE0pc2zeChfEDxVnKRkJBjz3VZ7bWY9LydtaozYealGUU2ymtweq0I8hlSjlLeL3Q2
         WxHH5inHFEfBBc2miduLiK1ghpIuVCLTWVYb9uSqvXH0zAYxqr3Nq56MJWRV1dfmYdpV
         dBBST/FIIVs6Xb60EVBL5Dast+42AyrsecLGdJm7YTEiGr96rFpOQMkr+eo8ZiJbcsAy
         3aeP/kEhnDnLEC5UKOQCNNClTOV0nJGW7NmeBFbtLjfCaAYNvnZzHTYfygVwH6QzzHHB
         Uruq4L+4i3dvPAMDCO+ET9YhNR1JzAqMBxJ/3HS744eBA7Bc/kQg77dQJ/8e2kWDSECc
         sCug==
X-Gm-Message-State: AJIora+Q8XXFQhxUsE+B6B8JM2eGJZGkba6JSEtBn8TcsewmDekhJwi0
        q3/SHyoiHQeH+FbAw4YYx5e7yDFFV7C4YQ==
X-Google-Smtp-Source: AGRyM1vF9difKlJTm7QB8p8O2XdAcXWEMOXqFF2o8I0962X2xe3E65lJZXb36CLa77C9j0zxGkEXwA==
X-Received: by 2002:a05:620a:2901:b0:6af:ca8:3f9f with SMTP id m1-20020a05620a290100b006af0ca83f9fmr10171411qkp.578.1656400622300;
        Tue, 28 Jun 2022 00:17:02 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id t12-20020a05620a450c00b006a746826feesm11112486qkp.120.2022.06.28.00.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 00:17:02 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id i15so20788017ybp.1;
        Tue, 28 Jun 2022 00:17:01 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr17966996ybu.604.1656400124939; Tue, 28
 Jun 2022 00:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220618123035.563070-1-mail@conchuod.ie> <20220618123035.563070-5-mail@conchuod.ie>
 <20220627232919.GA3158390-robh@kernel.org> <40d76866-34e3-baef-c3fe-8836cd2430f6@microchip.com>
In-Reply-To: <40d76866-34e3-baef-c3fe-8836cd2430f6@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 09:08:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXjXGBi8S+bTG105q63zZw2ScQb9nXBSp2baiLNWKQAkg@mail.gmail.com>
Message-ID: <CAMuHMdXjXGBi8S+bTG105q63zZw2ScQb9nXBSp2baiLNWKQAkg@mail.gmail.com>
Subject: Re: [PATCH 04/14] dt-bindings: dma: add Canaan k210 to Synopsys
 DesignWare DMA
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Rob Herring <robh@kernel.org>, Conor Dooley <mail@conchuod.ie>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Heng Sia <jee.heng.sia@intel.com>,
        Jose Abreu <joabreu@synopsys.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linux-spi <linux-spi@vger.kernel.org>,
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

On Tue, Jun 28, 2022 at 8:30 AM <Conor.Dooley@microchip.com> wrote:
> On 28/06/2022 00:29, Rob Herring wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Sat, Jun 18, 2022 at 01:30:26PM +0100, Conor Dooley wrote:
> >> From: Conor Dooley <conor.dooley@microchip.com>
> >>
> >> The Canaan k210 apparently has a Sysnopsys Designware AXI DMA
> >> controller, but according to the documentation & devicetree it has 6
> >> interrupts rather than the standard one. Add a custom compatible that
> >> supports the 6 interrupt configuration which falls back to the standard
> >> binding which is currently the one in use in the devicetree entry.
> >
> > But it works with only 1 interrupt?
>
> Seemingly...

The Linux driver uses the only first interrupt.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
