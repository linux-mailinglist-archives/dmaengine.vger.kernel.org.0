Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0606B74D793
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jul 2023 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGJNbI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 10 Jul 2023 09:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGJNbH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Jul 2023 09:31:07 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E60FE;
        Mon, 10 Jul 2023 06:31:06 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57012b2973eso58153067b3.2;
        Mon, 10 Jul 2023 06:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688995865; x=1691587865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q6Lo61y1jQ/sgP6ZwyTsq6Mh3odLPyFaxqgPmDQa08=;
        b=Oli8ch3HwPDf4+7vN8K797hcRnX/Vk3vepVZ0xQHUiRJSuG0H5KOJ4CkHy2h2hscK3
         UCo8e54Vn2OQKz2upVSHwcF9VoPemM8OlwvhsrQ/Iqws6pRRdOUVnCsJluVcudoy6pjs
         RCSm0t+ItJPcC7Y85plNWInWsOQSlBxnIK6xgYP9HV6Jgq2XQ35v+hA0ucHR+8wf+7zI
         xXODkSBZBFiAdDywOSJT55ZhiamgZW5SVvXSU/sON0y4SFL7a5uKROuGvddv1sAhbcl1
         lfSzREPyFAmNHsXesV0O4ZvkqPdD2Ic/PtICT58h1T/EkIgnG49m9kiLgAUdAFiucP5k
         AO9g==
X-Gm-Message-State: ABy/qLY0FzYMe7TYABCU+wVj/SQf73KY9/Rn8m+itaHRdLsj4YWOcXhF
        ZJeXMVFCopeh0yBhQc0XpsUGwG6vfELEQg==
X-Google-Smtp-Source: APBJJlHvaEbBNdUiX8d+QRJtDtpPoxPg3U51TpaweBCsVvtmHHx/lBUzGqcges7eJJMGXxYF+XgF7Q==
X-Received: by 2002:a81:4642:0:b0:561:d1b0:3f7e with SMTP id t63-20020a814642000000b00561d1b03f7emr11750631ywa.44.1688995865505;
        Mon, 10 Jul 2023 06:31:05 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id t185-20020a0deac2000000b005772e9388cdsm3011166ywe.62.2023.07.10.06.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 06:31:05 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c7a5600d04dso2569237276.3;
        Mon, 10 Jul 2023 06:31:05 -0700 (PDT)
X-Received: by 2002:a25:1456:0:b0:c39:9e09:2c71 with SMTP id
 83-20020a251456000000b00c399e092c71mr8797872ybu.41.1688995865146; Mon, 10 Jul
 2023 06:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230706112150.198941-1-biju.das.jz@bp.renesas.com> <20230706112150.198941-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230706112150.198941-2-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 15:30:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWFZzVSm-6cPyGHQr9dbYpTB-qDg=na=cnQFKDPHqf16g@mail.gmail.com>
Message-ID: <CAMuHMdWFZzVSm-6cPyGHQr9dbYpTB-qDg=na=cnQFKDPHqf16g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hien Huynh <hien.huynh.px@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 6, 2023 at 1:22 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> We usually do cleanup in reverse order of init. Currently, in the
> case of error, this is not followed in rz_dmac_probe(), and similar
> case for remove().
>
> This patch improves error handling in probe() and cleanup in
> reverse order of init in the remove().
>
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  No change.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
