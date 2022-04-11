Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3D64FBFE6
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244413AbiDKPMU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbiDKPMS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 11:12:18 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038DF2FE5F;
        Mon, 11 Apr 2022 08:10:02 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id z14so2298159qto.5;
        Mon, 11 Apr 2022 08:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upNIJzGRSw+uwckmTerdXsmNODqFik3Po2f0Zu+5l4I=;
        b=MbkyVl2HWGuSXX7xxFNskpZ0PRHPlDO7ePB6BzSIYsntwG54Yxhj2HzR7E92wkjq/C
         GFksJUXgXxd43cStOBtoPIguuHhrx9e5eY/2nKOV2vmv5QAfTxzayI84NCH4NT5jtRUX
         q3ONIs0AxaZvREYQX4jgX467eEGVzidzAE2rcUiyExnW9qaloCkJv4t2vLwrWuTJ7UqE
         vS/fdrJ4RTB40J3qSPPp6SnU3OtikVYvtjljj1yTuaGGZhfSWmo2QFIZNXnPLJjtzoqB
         d4iPX4mlMQlrnBDP1U6+IdFDkSyB+jpFdVbjMYu1meufDDyIv1ISQ1pMp1kh1EIz02mS
         tAFg==
X-Gm-Message-State: AOAM532eItcTyJs/yS7qgCU6jao28H4vBxq9/lt71GAur4IRYR7QEuii
        K2Jv2eKIbjhcEJqdnhY+AX9spkQPzNjhFQ==
X-Google-Smtp-Source: ABdhPJwGCcDbHF/Rl1pKqHT6ULSQw3M2eH8ZM/PZXtxZ68xg/sK+AePoOw7bCBMvNkKVAXEP5XWWpg==
X-Received: by 2002:a05:622a:8e:b0:2e1:fee4:8ca2 with SMTP id o14-20020a05622a008e00b002e1fee48ca2mr26015011qtw.431.1649689801698;
        Mon, 11 Apr 2022 08:10:01 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id j19-20020a05622a039300b002ecc2ebfd87sm8438929qtx.32.2022.04.11.08.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 08:10:01 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2eafabbc80aso168490327b3.11;
        Mon, 11 Apr 2022 08:10:01 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr25978028ywi.449.1649689801114; Mon, 11
 Apr 2022 08:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
 <20220407004511.3A6D1C385A3@smtp.kernel.org> <20220407101605.7d2a17cc@xps13>
In-Reply-To: <20220407101605.7d2a17cc@xps13>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 17:09:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com>
Message-ID: <CAMuHMdUZFTm+0NFLUFoXT7ujtxDot_Y+gya9ETK1FOai2MXfvA@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] RZN1 DMA support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Hi Miquel,

On Thu, Apr 7, 2022 at 10:16 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> sboyd@kernel.org wrote on Wed, 06 Apr 2022 17:45:09 -0700:
> > Quoting Miquel Raynal (2022-04-06 09:18:47)
> > > Here is a first series bringing DMA support to RZN1 platforms. Soon a
> > > second series will come with changes made to the UART controller
> > > driver, in order to interact with the RZN1 DMA controller.
> > >
> > > Stephen acked the sysctrl patch (in the clk driver) but somehow I feel
> > > like it would be good to have this patch applied on both sides
> > > (dmaengine and clk) because more changes will depend on the addition of
> > > this helper, that are not related to DMA at all. I'll let you folks
> > > figure out what is best.
> >
> > Are you sending more patches in the next 7 weeks or so that will touch
> > the same area? If so, then it sounds like I'll need to take the clk
> > patch through clk tree. I don't know what is best because I don't have
> > the information about what everyone plans to do in that file.
>
> This series brings DMA support and needs to access the dmamux registers
> that are in the sysctrl area.
>
> I've sent an RTC series which needs to access this area as well, but
> it is not fully ready yet as it was advised to go for a reset
> controller in this case. The reset controller would be registered by
> the clock driver, so yes it would touch the same file.
>
> Finally, there is an USB series that is coming soon, I don't know if
> it will be ready for merge for 5.19, but it needs to access a specific
> register in this area as well (h2mode).
>
> So provided that we are able to contribute this reset driver quickly
> enough, I would argue that it is safer to merge the clk changes in the
> clk tree.

The clk tree or the renesas-clk tree? ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
