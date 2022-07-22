Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C133D57DD00
	for <lists+dmaengine@lfdr.de>; Fri, 22 Jul 2022 10:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiGVI51 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Jul 2022 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbiGVI50 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Jul 2022 04:57:26 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC19FE39;
        Fri, 22 Jul 2022 01:57:26 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id y18so3020639qvo.11;
        Fri, 22 Jul 2022 01:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5JWR9fHVimN8Zv1r2sla8cY+tZDC78z+3g8TQgGYJY=;
        b=4/teMxLUSrYEwaMlZAibjrLEyVL6HrovZd5NRFnhBKb34mJy7VAsxSsuDaIaaVG/w9
         pkVNkCLACoiJhZMfVuMjSxAOXGsrWX2X0ThbsPQp7SiPTeCHBsbnyq9elVWZrUfN+C8T
         Q4MKM1vT4yWNPDI2Hx+DTpSoiSUKNUIV7y3bOEPxrYIysLoP+iST3xNjnj3HkBoWmqa5
         ra6JREDOZsAlJz+ZWo04BST9UTYeoe/HfHzR0lHZk1oUOLijuRS1JHraF6tTv+031bCR
         D3Z6SzSRGLzo5vKKPG6hfr8shKYaN3fEzPKaj2e+X/6Qn+e0hEvHIGoieDh+RihVDGrD
         bIQA==
X-Gm-Message-State: AJIora83/xgDfwhGJCmoxcFxt2oachpBX1z8q8M6vxhLPcGmGXyIq//w
        3uVvkt9aHOG7BQYiG3KsMFowyz+r3NHGiA==
X-Google-Smtp-Source: AGRyM1vzEqiZL3/3y49RVeDLM+CrmfgDg5jsLmCR8pztzfsVAZ4cRsfpNGn+XVRlIjcGRndCPosA1Q==
X-Received: by 2002:a05:6214:21e1:b0:473:8a50:349e with SMTP id p1-20020a05621421e100b004738a50349emr1956712qvj.3.1658480245253;
        Fri, 22 Jul 2022 01:57:25 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006b5d2f6f372sm3236612qki.132.2022.07.22.01.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 01:57:24 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id i206so6991798ybc.5;
        Fri, 22 Jul 2022 01:57:24 -0700 (PDT)
X-Received: by 2002:a25:aacc:0:b0:66f:f1ca:409c with SMTP id
 t70-20020a25aacc000000b0066ff1ca409cmr2204295ybi.36.1658480243986; Fri, 22
 Jul 2022 01:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220722084430.969333-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220722084430.969333-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jul 2022 10:57:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsDxPpx7jqcBwYLiv-d9EB=tP4mXaLmzG5Ein1FATjkQ@mail.gmail.com>
Message-ID: <CAMuHMdVsDxPpx7jqcBwYLiv-d9EB=tP4mXaLmzG5Ein1FATjkQ@mail.gmail.com>
Subject: Re: [PATCH v4] dmaengine: sh: rz-dmac: Add device_synchronize callback
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
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

On Fri, Jul 22, 2022 at 10:44 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Some on-chip peripheral modules(for eg:- rspi) on RZ/G2L SoC
> use the same signal for both interrupt and DMA transfer requests.
> The signal works as a DMA transfer request signal by setting
> DMARS, and subsequent interrupt requests to the interrupt controller
> are masked.
>
> We can re-enable the interrupt by clearing the DMARS.
>
> This patch adds device_synchronize callback for clearing
> DMARS and thereby allowing DMA consumers to switch to
> interrupt mode.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Increased delay_us 10->100us and timeout_us 1ms->100ms.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
