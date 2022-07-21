Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0457C7FA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jul 2022 11:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiGUJr0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 21 Jul 2022 05:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiGUJrZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 21 Jul 2022 05:47:25 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4E814B1;
        Thu, 21 Jul 2022 02:47:24 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id kh20so766910qvb.5;
        Thu, 21 Jul 2022 02:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3wtCY2UdDrAmfUxJWtOXRl69vAa9dOwm/Ds2/ADh7g=;
        b=wWOqW9DItmtl+Vfzs4eAHE6Xnt0NYIsG5R3gYoCZ5lEkHQmaWMb0cgs5h3cTsnbtpf
         eW4Gf5bAtdSCbr8AOKwe38csBhDwAve6ut3EnKt2tfJ9ZqpxLUnvsuCHjP0GibMVCsLJ
         CfpINhAOoHnWqI49x2VkEI9S3tSyNpbSP0UliFZnnWhU0D7JhniiKKklQvMZvC4u2I90
         PR1V7rzIXBhSjJ2Sv0wyfgFcVhXugVJYarjavhJ13vMXfyqnvKqae1dVsJBrgMhSdhdv
         HZSv79UqZPi/KpGYrcgs60PmOwpndvFI1I6F0WGI4eO1sPtEb/dGgMSuBlcziCS3i9ud
         D8+w==
X-Gm-Message-State: AJIora+Rse3uzi15iXL3DtMDOMH2HjDE4Ud9NftLpeCjyVrGFFunZjGN
        5Isnsxd+igMqQqJGXJWQWk7yi1whlNPBNg==
X-Google-Smtp-Source: AGRyM1sIM2KBuYC6hb+ceSg+5ngJF01wSPIBaKf28KWZmLl/PkxSRtSOwRFL9uz27zma8Hs8fcVu4A==
X-Received: by 2002:ad4:5c62:0:b0:474:1267:14fd with SMTP id i2-20020ad45c62000000b00474126714fdmr581052qvh.68.1658396843201;
        Thu, 21 Jul 2022 02:47:23 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm1085515qtk.52.2022.07.21.02.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:47:22 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 75so1893808ybf.4;
        Thu, 21 Jul 2022 02:47:22 -0700 (PDT)
X-Received: by 2002:a25:f06:0:b0:670:1685:d31d with SMTP id
 6-20020a250f06000000b006701685d31dmr22225909ybp.380.1658396841904; Thu, 21
 Jul 2022 02:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220719150000.383722-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220719150000.383722-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 11:47:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVoU4LHiZmxM_DsGz5kMFAbRzvwJwtkcgCKp3SBtYW6ww@mail.gmail.com>
Message-ID: <CAMuHMdVoU4LHiZmxM_DsGz5kMFAbRzvwJwtkcgCKp3SBtYW6ww@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dmaengine: sh: rz-dmac: Add device_synchronize callback
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jul 19, 2022 at 5:00 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Some on-chip peripheral modules(for eg:- rspi) on RZ/G2L SoC
> use the same signal for both interrupt and DMA transfer requests.
> The signal works as a DMA transfer request signal by setting
> DMARS, and subsequent interrupt requests to the interrupt controller
> are masked.
>
> We can enable the interrupt by clearing the DMARS.

re-enable?

>
> This patch adds device_synchronize callback for clearing
> DMARS and thereby allowing DMA consumers to switch to
> DMA mode.

interrupt mode

>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * No change

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
