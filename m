Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B89E74D7DF
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jul 2023 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjGJNgt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 10 Jul 2023 09:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjGJNgp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jul 2023 09:36:45 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B040210D;
        Mon, 10 Jul 2023 06:36:41 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-579dd20b1c8so53838717b3.1;
        Mon, 10 Jul 2023 06:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688996200; x=1691588200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67pjtf+oRi7gdU8hjxfbQGBsCvxHiec9ZrtuJIuCImc=;
        b=fYgxnkEX+Kl2SGgEjiAH+faw2SEXMSjIcNpzpZattOBKnvrIUbdBlVPkbbwMsw1G1b
         hsnozsuys7fLs+925k7WQO+fa1QDNLd3ueAuvEThViszGttFX9/xWEPSQAD0mTch7/fD
         iBW64Q0K4MPIv3Zy/ngkYHhRyseB8pdjvbFmHKcVNzYNTi4NXgjllWnlL0n4T2tXJaGj
         P+BRgvObEIrbkUaVcVOPg9fhLREi4VsABZy/q3tXhk/sgrpuTvaQfDrYQMZJoXJwk1/7
         kVCYqBcjSZW5AuQkTSRNXe1jRaw5pkGISFGbOngWmmcWdgP9akrLyiYvKVkIIAQrxZov
         l4sg==
X-Gm-Message-State: ABy/qLZCG5JvPgQazAqFt8Jnp3HFGz69atbA4060wyPbMknn88UhjtOK
        zv6B0EOh/LqRUHv5GFdAUjMJbRONJuAhPg==
X-Google-Smtp-Source: APBJJlEiN6Y9bQztS8tqTFmJfPwdXRUUl123qxH5wmt/NhqX23H/xSb1/qNbPaj66o0gw7+i7tA0ow==
X-Received: by 2002:a0d:d1c3:0:b0:56c:fce5:ac2d with SMTP id t186-20020a0dd1c3000000b0056cfce5ac2dmr11706336ywd.39.1688996200240;
        Mon, 10 Jul 2023 06:36:40 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id z6-20020a818906000000b00576c727498dsm3071645ywf.92.2023.07.10.06.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 06:36:40 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-c5079a9f1c8so5368144276.0;
        Mon, 10 Jul 2023 06:36:39 -0700 (PDT)
X-Received: by 2002:a25:414c:0:b0:c68:5213:7537 with SMTP id
 o73-20020a25414c000000b00c6852137537mr10551556yba.55.1688996199750; Mon, 10
 Jul 2023 06:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230706112150.198941-1-biju.das.jz@bp.renesas.com> <20230706112150.198941-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230706112150.198941-3-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 15:36:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVA03t3qEiiO5JDSz0KG2mLHhYp9HdqM+Y1-BV3cXuN9Q@mail.gmail.com>
Message-ID: <CAMuHMdVA03t3qEiiO5JDSz0KG2mLHhYp9HdqM+Y1-BV3cXuN9Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dmaengine: sh: rz-dmac: Fix destination and source
 data size setting
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 6, 2023 at 1:22 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> From: Hien Huynh <hien.huynh.px@renesas.com>
>
> Before setting DDS and SDS values, we need to clear its value first
> otherwise, we get incorrect results when we change/update the DMA bus
> width several times due to the 'OR' expression.
>
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Cc: stable@kernel.org
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Added bitfield.h header file and replaced CHCFG_FILL_{SDS,DDS}
>    macros with FIELD_PREP.
>  * Updated commit header 'dma: rz-dmac'->'dmaengine: sh: rz-dmac'.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
