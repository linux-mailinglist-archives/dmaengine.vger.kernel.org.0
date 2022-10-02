Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4FC5F242B
	for <lists+dmaengine@lfdr.de>; Sun,  2 Oct 2022 18:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJBQx4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 2 Oct 2022 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJBQx4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 2 Oct 2022 12:53:56 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718483CBEA;
        Sun,  2 Oct 2022 09:53:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 138so6636747iou.9;
        Sun, 02 Oct 2022 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ubQjNTuesFewVeey+udg8F7CqkMS4n6rohRkhXXEiNo=;
        b=gobyR88qKFcMBijBTqmIcGqK75+JwLdIY2Odmy3jKbIJiRH4x+GXpTNwuGyjntZIm+
         F7C11fyKIbmBHWwKKEiiT9AKRvajGshQClVCPNn4expJIz1Osd1iqBzstmCX6hZ1Qixj
         ducGiPdpp+0JyObN9teowoD9HifPIirnqOfRFa+4nMUvB/Ll4/wqkaDTLak+EZwZcbTf
         ssvPW1Rf+V1ec0k7rGQ2TeGPZ60gUyPnS1uqm6tnjjv0EII0UIe5nY+4sI1ExGmDQhtl
         bU/RV3PO3qX0fNG1gwWmmY2xI804pn3mP7QBzVqt8XPPOyuL8w4DTLZ3Rn72+IdeAi8I
         q3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ubQjNTuesFewVeey+udg8F7CqkMS4n6rohRkhXXEiNo=;
        b=RJei+V/qWjHwTlLnPl6E9yDMpLds6Is3RFPd/GSDSjPZqfDjbo/U+r+g4dmJTYc9Mp
         ThpVHAkH8DNnA40NMoZpEz/ncJNPcxyfwLC4AOjUxMXAZfTdy3AQ6gpKNXzrAXdwYLRN
         LezcHU8sTJ2QsDHo6L6pnfyUheNeKlvxYsrryg3sJ+ZOZHqeSAG0oXmUI48k3ibVHMUP
         LHYgWt+pDLstLPKotrg1AbCw4HhITNoFklGGm4Punk6cdAIOIq0FfzDojcKfJZgmq17A
         er/sDmUgqm30tTcz63KlbL4zsxRIWrhltDSrNty88wpvE6KtoRE0vXZ0ME9SSKtWuKbO
         ZplA==
X-Gm-Message-State: ACrzQf1AFNKJLmHIgub/j6HXvYGl6/6ubFKUu6yP+bIdJG8/UG9CmbxJ
        DhXWLu3Mi2KgBY0bus7WN6VPxdc5Q/2BP/H3twEtsuhOaWyQiA==
X-Google-Smtp-Source: AMsMyM7+Ydg7AeXoWzXbb8RtVOLygGx2R/Q1FKzWSh4fKBXJ+4EndGP/EQhq9VIi8vzseO8uPpQssRfHudTz+k2h0uQ=
X-Received: by 2002:a05:6638:160e:b0:35a:5882:db1b with SMTP id
 x14-20020a056638160e00b0035a5882db1bmr8981747jas.299.1664729634875; Sun, 02
 Oct 2022 09:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220930055331.138868-1-gengcixi@gmail.com> <bd3ce49b-f887-1021-f21f-4e57ade1ba25@linux.alibaba.com>
In-Reply-To: <bd3ce49b-f887-1021-f21f-4e57ade1ba25@linux.alibaba.com>
From:   Cixi Geng <gengcixi@gmail.com>
Date:   Mon, 3 Oct 2022 00:53:18 +0800
Message-ID: <CAF12kFuXV+9=vQjce44a8CBMtC0=DP+wv0BZ5UjkZOBX3p0=yA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sprd: Support two-stage dma interrupt
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     vkoul@kernel.org, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Baolin Wang <baolin.wang@linux.alibaba.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=
=8830=E6=97=A5=E5=91=A8=E4=BA=94 14:42=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Cixi,
>
> On 9/30/2022 1:53 PM, Cixi Geng wrote:
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Audio need to request Audio CP global dma interrupt, so Audio CP
> > DMA should support two-stage interrupt to adapte it.
> > It will occur interrupt when two-stage dma channel transfer done.
>
> If the AP does not want the interrupt, why not just set SPRD_DMA_NO_INT?
>
> I am struggling to understand the whole requirement, could you elaborate?
>
The AP should deal with the interrupt. I wrote the wrong conditions.
AP handle different interrupts about the 2-stage dma channel.
> >
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> > ---
> >   drivers/dma/sprd-dma.c       |  8 ++++----
> >   include/linux/dma/sprd-dma.h | 12 ++++++++++++
> >   2 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > index 474d3ba8ec9f..7a9ade422a00 100644
> > --- a/drivers/dma/sprd-dma.c
> > +++ b/drivers/dma/sprd-dma.c
> > @@ -441,7 +441,7 @@ static int sprd_dma_set_2stage_config(struct sprd_d=
ma_chn *schan)
> >               val =3D chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> >               val |=3D BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFF=
SET;
> >               val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > -             if (schan->int_type !=3D SPRD_DMA_NO_INT)
> > +             if (schan->int_type !=3D SPRD_DMA_SRC_CHN0_INT)
> >                       val |=3D SPRD_DMA_GLB_SRC_INT;
>
> That does not make sense to me. If user configues the interrupt type as
> SPRD_DMA_NO_INT, the code will still enable the source interrupt.
>
> If user configures the interrupt type as SPRD_DMA_SRC_CHN0_INT, you will
> disable the source interrupt? Confusing...
Sorry, the condition should be  (schan->int_type & SPRD_DMA_SRC_CHN0_INT)
I will fixed it next vesion.
>
> >               sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, =
val);
> > @@ -451,7 +451,7 @@ static int sprd_dma_set_2stage_config(struct sprd_d=
ma_chn *schan)
> >               val =3D chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> >               val |=3D BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFF=
SET;
> >               val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > -             if (schan->int_type !=3D SPRD_DMA_NO_INT)
> > +             if (schan->int_type !=3D SPRD_DMA_SRC_CHN1_INT)
> >                       val |=3D SPRD_DMA_GLB_SRC_INT;
> >
> >               sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, =
val);
> > @@ -461,7 +461,7 @@ static int sprd_dma_set_2stage_config(struct sprd_d=
ma_chn *schan)
> >               val =3D (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> >                       SPRD_DMA_GLB_DEST_CHN_MASK;
> >               val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > -             if (schan->int_type !=3D SPRD_DMA_NO_INT)
> > +             if (schan->int_type !=3D SPRD_DMA_DST_CHN0_INT)
> >                       val |=3D SPRD_DMA_GLB_DEST_INT;
> >
> >               sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, =
val);
> > @@ -471,7 +471,7 @@ static int sprd_dma_set_2stage_config(struct sprd_d=
ma_chn *schan)
> >               val =3D (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> >                       SPRD_DMA_GLB_DEST_CHN_MASK;
> >               val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > -             if (schan->int_type !=3D SPRD_DMA_NO_INT)
> > +             if (schan->int_type !=3D SPRD_DMA_DST_CHN1_INT)
> >                       val |=3D SPRD_DMA_GLB_DEST_INT;
> >
> >               sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, =
val);
> > diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.=
h
> > index d09c6f6f6da5..26de41d6d915 100644
> > --- a/include/linux/dma/sprd-dma.h
> > +++ b/include/linux/dma/sprd-dma.h
> > @@ -101,6 +101,14 @@ enum sprd_dma_req_mode {
> >    * is done.
> >    * @SPRD_DMA_CFGERR_INT: configure error interrupt when configuration=
 is
> >    * incorrect.
> > + * @SPRD_DMA_SRC_CHN0_INT: interrupt occurred when source channel0
> > + * transfer is done.
> > + * @SPRD_DMA_SRC_CHN1_INT: interrupt occurred when source channel1
> > + * transfer is done.
> > + * @SPRD_DMA_DST_CHN0_INT: interrupt occurred when destination channel=
0
> > + * transfer is done.
> > + * @SPRD_DMA_DST_CHN1_INT: interrupt occurred when destination channel=
1
> > + * transfer is done.
> >    */
> >   enum sprd_dma_int_type {
> >       SPRD_DMA_NO_INT,
> > @@ -112,6 +120,10 @@ enum sprd_dma_int_type {
> >       SPRD_DMA_TRANS_BLK_INT,
> >       SPRD_DMA_LIST_INT,
> >       SPRD_DMA_CFGERR_INT,
> > +     SPRD_DMA_SRC_CHN0_INT,
> > +     SPRD_DMA_SRC_CHN1_INT,
> > +     SPRD_DMA_DST_CHN0_INT,
> > +     SPRD_DMA_DST_CHN1_INT,
> >   };
> >
> >   /*
