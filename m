Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64EA4F7254
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 04:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiDGCzL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 22:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiDGCzK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 22:55:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D83B022;
        Wed,  6 Apr 2022 19:53:12 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f38so7346958ybi.3;
        Wed, 06 Apr 2022 19:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOqVy6gRmDIPKGJRDzX2KezvYez3k9c+5+AVEHVzz40=;
        b=P+y3+ScFd24nfq3pBIZYA+8O6FxPw+aM0oWT3No1p4/eJWXp4tSN7e7pplFy2odInW
         k+Y2CG87GauHiaQn82wzVPVzC8JhMnCTn/Rhwfyf1Eu2E3i91TOlHB75JZw3Gho3aGRI
         FWFTneC/EN+zh2FWeG2rXGRHUvg+rKk11H+iThCnjEvk24X/tPXdpimt3x3qRQgGVeEZ
         WwF9R/lV3Fkn1DkohWLc6zI9S9LjiK3uaZvwsL9GhdSQ0QlZMRDemK/kfDSiABkldMGm
         FnIFehGAF/fwgBt2JjT+Yu8pJ/KXBS4aGrD9nYE5s4xU+70XAEnUq2RzN3XPfKNyhcO1
         rcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOqVy6gRmDIPKGJRDzX2KezvYez3k9c+5+AVEHVzz40=;
        b=d+2Dn3JFyblJRaZ2RGp+mCetmulz/+5QyMypcbL0MncLpRJAV7NZA6CGjL56jNX73W
         MbE3JNRLtv1wKLdFBMBhF7woQH3/WI9IBxhtdFERav6C3uQ1qdnZX02d1jF/HdFxg3y9
         0A3Tc0PO94WOKLqBh2dr38pViAyHTziFkI5XRVF5QD+SSOBVan+hWJiUE3PG7r63AKf+
         LxiG7zoVlYH2ZUeIEP2b39xdVh56vpccNXI/fyH7I1hS98qGOPNpjU6exwWj9GuAv9Q9
         nxSs/PNXQps+YF5c1RaQxzvOGgaChEr2o6X9ZyR0iHVYPg1h74dPE6uzkerFWV0AJgS3
         S3CA==
X-Gm-Message-State: AOAM533bEJriNnZ33s1bmGhR/eYJduPYUvSIKGlOnsdo+XbdRN8sDgcP
        TdCQiSz0xaDZ4iLlxUPpbbliDQjOWs21BBWzIpI=
X-Google-Smtp-Source: ABdhPJyfmfZEIsyG6RM9aPwpCdyCsqYhqtBZg/XU9g0EImsIbaZJa4T9PtaA/s6KvzGLSkuXzN89+rCyWiE2pyGr4Fo=
X-Received: by 2002:a25:e0d3:0:b0:63d:c615:afb8 with SMTP id
 x202-20020a25e0d3000000b0063dc615afb8mr8436525ybg.182.1649299991734; Wed, 06
 Apr 2022 19:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220404155557.27316-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220404155557.27316-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 7 Apr 2022 03:52:45 +0100
Message-ID: <CA+V-a8tM3EiZkNSCG+CtrOnfGBc5WSaac__FBsRn72zrsjQ2ew@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] dmaengine: Use platform_get_irq*() variants to
 fetch IRQ's
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On Mon, Apr 4, 2022 at 4:56 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Hi All,
>
> This patch series aims to drop using platform_get_resource() for IRQ types
> in preparation for removal of static setup of IRQ resource from DT core
> code.
>
Fyi.. the OF core changes have landed into -next [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220406&id=a1a2b7125e1079cfcc13a116aa3af3df2f9e002b

Cheers,
Prabhakar

> Dropping usage of platform_get_resource() was agreed based on
> the discussion [0].
>
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Changes for v3:
> * Included Ack from Andy.
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (3):
>   dmaengine: nbpfaxi: Use platform_get_irq_optional() to get the
>     interrupt
>   dmaengine: mediatek: mtk-hsdma: Use platform_get_irq() to get the
>     interrupt
>   dmaengine: mediatek-cqdma: Use platform_get_irq() to get the interrupt
>
>  drivers/dma/mediatek/mtk-cqdma.c | 12 ++++--------
>  drivers/dma/mediatek/mtk-hsdma.c | 11 ++++-------
>  drivers/dma/nbpfaxi.c            | 14 ++++++--------
>  3 files changed, 14 insertions(+), 23 deletions(-)
>
> --
> 2.17.1
>
