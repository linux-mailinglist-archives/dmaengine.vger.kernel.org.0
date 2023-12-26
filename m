Return-Path: <dmaengine+bounces-660-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760481E4AF
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 04:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4A0B21AE0
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709B71078E;
	Tue, 26 Dec 2023 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUIqIvv5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2B107A2;
	Tue, 26 Dec 2023 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-28c179bf45cso2017352a91.1;
        Mon, 25 Dec 2023 19:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703560824; x=1704165624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YQDNpHRUTDgWIg5rNQu7vQTv9wa4oPQdE9W9rMQEhs=;
        b=bUIqIvv5CkM4VbmGKtJhC2WxGgwo+CXKKjjdl5DOOF/mVmbxIsPK+8UJfUwRtel9sT
         gFQF+3zzCmazKq/h4EIRa6HOa0ymLp1g76yygWcXTaBjU9H2QHk/3ZXm1uOBjaD71I7n
         6mCxiO5Dn2SQ8Jh65VT3/+Vn3LxU6X0krBv0CfOR6Tyw0zHQ2cw9eTazGIBufG5Vo7k5
         B8A+x0fOQjPYo1opib+RiR9TTCQmCwdl+dO6poraiUQjBtse2WbLa1kASws2Q6CoZi6A
         Bg1aJG2DYInJY7CpHQUAUc0+RfmJyzb6k646Rc6Xs6d2Y2Ls2IgCXjP1XBA74L4FJRLv
         m93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703560824; x=1704165624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YQDNpHRUTDgWIg5rNQu7vQTv9wa4oPQdE9W9rMQEhs=;
        b=drgWdWD2et8MW56rqHUxjH4bZfM7FENEFXZOlHCGL5/N1zISbrODbfcYiEIqBxXyYI
         lcolGlqQyY4y0IR8rXYTk7o4VWsElD1HRd7C5eqpwDHsDBymYOxWCssK7vuSth7qDgfQ
         V1nzdUIPv2mE1FG6hlkbCOaPfhHTNZ4qFsT5cgqKd4Cf2lZ6HlE2Z7dh0fuSUQY4+7jL
         boeFnScIM9kh9aXUjH2j4bWwvsIp6iX1sVMZ/K9oG0/bU3C6pG+pgR5jWGq0FtufJMC5
         tP+f8rhJ+iprmBoxwnQk3XwVoPTaBEfQdq/NTLaaJ1Y3LgqtnKmvSbvlMnwI81Rq5KxV
         tY4w==
X-Gm-Message-State: AOJu0YyXDcjMSr7xlYT0eckTSvwL2OyPTAMvLoXU0GqdnC70wurCbxpa
	ch4z8a/FZDNvLAjzFcI3fS+azZ2+f+K0hYb20OGXXhOVojKqwUHA
X-Google-Smtp-Source: AGHT+IHf+nTGxCDn+wyqCtVeGroIyvkCY43yp0Je0U18u93Fn4hhP8mDh8r3Oj0C7nI9/Q1mPtCB31fzIxcgpwkenh8=
X-Received: by 2002:a17:902:f68b:b0:1d4:39d5:8edc with SMTP id
 l11-20020a170902f68b00b001d439d58edcmr5993360plg.41.1703560823969; Mon, 25
 Dec 2023 19:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222112746.9720-1-kaiwei.liu@unisoc.com> <6e0a104a-1f99-4686-ba76-99ef631b0d25@linux.alibaba.com>
In-Reply-To: <6e0a104a-1f99-4686-ba76-99ef631b0d25@linux.alibaba.com>
From: liu kaiwei <liukaiwei086@gmail.com>
Date: Tue, 26 Dec 2023 11:20:13 +0800
Message-ID: <CAOgAA6H9KnOr+U-uWZsy2Ljo9-ncrRWaoyrJG79ZbH8ahUhQfA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] dmaengine: sprd: optimize two stage transfer function
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wenming Wu <wenming.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 3:05=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 12/22/2023 7:27 PM, Kaiwei Liu wrote:
> > From: "kaiwei.liu" <kaiwei.liu@unisoc.com>
> >
> > For SPRD DMA, it provides a function that one channel can start
> > the second channel after completing the transmission, which we
> > call two stage transfer mode. You can choose which channel can
> > generate interrupt when finished. It can support up to two sets
> > of such patterns.
> > When configuring registers for two stage transfer mode, we need
> > to set the mask bit to ensure that the setting are accurate. And
> > we should clear the two stage transfer configuration when release
> > DMA channel.
> > The two stage transfer function is mainly used by SPRD audio, and
> > now audio also requires that the data need to be accessed on the
> > device side. So here use the src_port_window_size and dst_port_win-
> > dow_size in the struct of dma_slave_config.
> >
> > Signed-off-by: kaiwei.liu <kaiwei.liu@unisoc.com>
>
> It seems you ignored my previous comments[1], please make sure they are
> addressed firstly.

Hi, the patch we sended before has been updated and I will explain the ques=
tion
base on this latest one.
>
> [1]
> https://lore.kernel.org/all/522e9d29-fab2-5bb0-c2d3-9cf908007000@linux.al=
ibaba.com/
>
> > ---
> > Change in V2
> > -change because [PATCH 1/2]
> > ---
> >   drivers/dma/sprd-dma.c | 116 ++++++++++++++++++++++++----------------=
-
> >   1 file changed, 69 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > index cb48731d70b2..e9e113142fd2 100644
> > --- a/drivers/dma/sprd-dma.c
> > +++ b/drivers/dma/sprd-dma.c
> > @@ -68,6 +68,7 @@
> >   #define SPRD_DMA_GLB_TRANS_DONE_TRG BIT(18)
> >   #define SPRD_DMA_GLB_BLOCK_DONE_TRG BIT(17)
> >   #define SPRD_DMA_GLB_FRAG_DONE_TRG  BIT(16)
> > +#define SPRD_DMA_GLB_TRG_MASK                GENMASK(19, 16)
> >   #define SPRD_DMA_GLB_TRG_OFFSET             16
> >   #define SPRD_DMA_GLB_DEST_CHN_MASK  GENMASK(13, 8)
> >   #define SPRD_DMA_GLB_DEST_CHN_OFFSET        8
> > @@ -155,6 +156,13 @@
> >
> >   #define SPRD_DMA_SOFTWARE_UID               0
> >
> > +#define SPRD_DMA_SRC_CHN0_INT                9
> > +#define SPRD_DMA_SRC_CHN1_INT                10
> > +#define SPRD_DMA_DST_CHN0_INT                11
> > +#define SPRD_DMA_DST_CHN1_INT                12
> > +#define SPRD_DMA_2STAGE_SET          1
> > +#define SPRD_DMA_2STAGE_CLEAR                0
> > +
> >   /* dma data width values */
> >   enum sprd_dma_datawidth {
> >       SPRD_DMA_DATAWIDTH_1_BYTE,
> > @@ -431,53 +439,57 @@ static enum sprd_dma_req_mode sprd_dma_get_req_ty=
pe(struct sprd_dma_chn *schan)
> >       return (frag_reg >> SPRD_DMA_REQ_MODE_OFFSET) & SPRD_DMA_REQ_MODE=
_MASK;
> >   }
> >
> > -static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> > +static void sprd_dma_2stage_write(struct sprd_dma_chn *schan,
> > +                               u32 config_type, u32 grp_offset)

> Why change the function name? 'config_type' should be boolean.

To clear the dma config when free dma channel after finished transmission, =
we
add a clear 2stage config interface. And to simplify code, we combine
two interfaces
into one, and use config_type to judge whether set or clear.

> >   {
> >       struct sprd_dma_dev *sdev =3D to_sprd_dma_dev(&schan->vc.chan);
> > -     u32 val, chn =3D schan->chn_num + 1;
> > -
> > -     switch (schan->chn_mode) {
> > -     case SPRD_DMA_SRC_CHN0:
> > -             val =3D chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> > -             val |=3D BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFF=
SET;
> > -             val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > -             if (schan->int_type !=3D SPRD_DMA_NO_INT)
> > -                     val |=3D SPRD_DMA_GLB_SRC_INT;
> > -
> > -             sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, =
val);
> > -             break;
> > -
> > -     case SPRD_DMA_SRC_CHN1:
> > -             val =3D chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> > -             val |=3D BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFF=
SET;
> > -             val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > -             if (schan->int_type !=3D SPRD_DMA_NO_INT)
> > -                     val |=3D SPRD_DMA_GLB_SRC_INT;
> > -
> > -             sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, =
val);
> > -             break;
> > -
> > -     case SPRD_DMA_DST_CHN0:
> > -             val =3D (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> > -                     SPRD_DMA_GLB_DEST_CHN_MASK;
> > -             val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > -             if (schan->int_type !=3D SPRD_DMA_NO_INT)
> > -                     val |=3D SPRD_DMA_GLB_DEST_INT;
> > -
> > -             sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP1, val, =
val);
> > -             break;
> > -
> > -     case SPRD_DMA_DST_CHN1:
> > -             val =3D (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> > -                     SPRD_DMA_GLB_DEST_CHN_MASK;
> > -             val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > -             if (schan->int_type !=3D SPRD_DMA_NO_INT)
> > -                     val |=3D SPRD_DMA_GLB_DEST_INT;
> > -
> > -             sprd_dma_glb_update(sdev, SPRD_DMA_GLB_2STAGE_GRP2, val, =
val);
> > -             break;
> > +     u32 mask_val;
> > +     u32 chn =3D schan->chn_num + 1;
> > +     u32 val =3D 0;
> > +
> > +     if (config_type =3D=3D SPRD_DMA_2STAGE_SET) {
> > +             if (schan->chn_mode =3D=3D SPRD_DMA_SRC_CHN0 ||
> > +                 schan->chn_mode =3D=3D SPRD_DMA_SRC_CHN1) {
> > +                     val =3D chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> > +                     val |=3D BIT(schan->trg_mode - 1) << SPRD_DMA_GLB=
_TRG_OFFSET;
> > +                     val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > +                     if (schan->int_type & SPRD_DMA_SRC_CHN0_INT ||
> > +                         schan->int_type & SPRD_DMA_SRC_CHN1_INT)

> can you explain why change the interrupt validation? ignore other
interrupt type?

Because if we were to use those interrupt type except SPRD_DMA_NO_INT befor=
e,
the result is the same: an interrupt will be triggered after the
completion of 2stage
transmission. Now we can choose whether to trigger the interrupt in
the first or second
stage randomly and the previous interrupt type is no longer applicable.

> How to ensure backward compatibility with previous SPRD DMA IP?

This DMA driver no longer supports the previous SPRD DMA IP and all SPRD DM=
A IP
using this driver currently support these features.

> > +                             val |=3D SPRD_DMA_GLB_SRC_INT;
> > +                     mask_val =3D SPRD_DMA_GLB_SRC_INT | SPRD_DMA_GLB_=
TRG_MASK |
> > +                                SPRD_DMA_GLB_SRC_CHN_MASK;
> > +             } else {
> > +                     val =3D (chn << SPRD_DMA_GLB_DEST_CHN_OFFSET) &
> > +                            SPRD_DMA_GLB_DEST_CHN_MASK;
> > +                     val |=3D SPRD_DMA_GLB_2STAGE_EN;
> > +                     if (schan->int_type & SPRD_DMA_DST_CHN0_INT ||
> > +                         schan->int_type & SPRD_DMA_DST_CHN1_INT)
> > +                             val |=3D SPRD_DMA_GLB_DEST_INT;
> > +                     mask_val =3D SPRD_DMA_GLB_DEST_INT | SPRD_DMA_GLB=
_DEST_CHN_MASK;
> > +             }
> > +     } else {
> > +             if (schan->chn_mode =3D=3D SPRD_DMA_SRC_CHN0 ||
> > +                 schan->chn_mode =3D=3D SPRD_DMA_SRC_CHN1)
> > +                     mask_val =3D SPRD_DMA_GLB_SRC_INT | SPRD_DMA_GLB_=
TRG_MASK |
> > +                                SPRD_DMA_GLB_2STAGE_EN | SPRD_DMA_GLB_=
SRC_CHN_MASK;
> > +             else
> > +                     mask_val =3D SPRD_DMA_GLB_DEST_INT | SPRD_DMA_GLB=
_2STAGE_EN |
> > +                                SPRD_DMA_GLB_DEST_CHN_MASK;
> > +     }
> > +     sprd_dma_glb_update(sdev, grp_offset, mask_val, val);
> > +}
> >
> > -     default:
> > +static int sprd_dma_2stage_config(struct sprd_dma_chn *schan, u32 conf=
ig_type)
> > +{
> > +     struct sprd_dma_dev *sdev =3D to_sprd_dma_dev(&schan->vc.chan);
> > +
> > +     if (schan->chn_mode =3D=3D SPRD_DMA_SRC_CHN0 ||
> > +         schan->chn_mode =3D=3D SPRD_DMA_DST_CHN0)
> > +             sprd_dma_2stage_write(schan, config_type, SPRD_DMA_GLB_2S=
TAGE_GRP1);
> > +     else if (schan->chn_mode =3D=3D SPRD_DMA_SRC_CHN1 ||
> > +              schan->chn_mode =3D=3D SPRD_DMA_DST_CHN1)
> > +             sprd_dma_2stage_write(schan, config_type, SPRD_DMA_GLB_2S=
TAGE_GRP2);
> > +     else {
> >               dev_err(sdev->dma_dev.dev, "invalid channel mode setting =
%d\n",
> >                       schan->chn_mode);
> >               return -EINVAL;
> > @@ -545,7 +557,7 @@ static void sprd_dma_start(struct sprd_dma_chn *sch=
an)
> >        * Set 2-stage configuration if the channel starts one 2-stage
> >        * transfer.
> >        */
> > -     if (schan->chn_mode && sprd_dma_set_2stage_config(schan))
> > +     if (schan->chn_mode && sprd_dma_2stage_config(schan, SPRD_DMA_2ST=
AGE_SET))
> >               return;
> >
> >       /*
> > @@ -569,6 +581,12 @@ static void sprd_dma_stop(struct sprd_dma_chn *sch=
an)
> >       sprd_dma_set_pending(schan, false);
> >       sprd_dma_unset_uid(schan);
> >       sprd_dma_clear_int(schan);
> > +     /*
> > +      * If 2-stage transfer is used, the configuration must be clear
> > +      * when release DMA channel.
> > +      */
> > +     if (schan->chn_mode)
> > +             sprd_dma_2stage_config(schan, SPRD_DMA_2STAGE_CLEAR);
> >       schan->cur_desc =3D NULL;
> >   }
> >
> > @@ -757,7 +775,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan=
,
> >       phys_addr_t llist_ptr;
> >
> >       if (dir =3D=3D DMA_MEM_TO_DEV) {
> > -             src_step =3D sprd_dma_get_step(slave_cfg->src_addr_width)=
;
> > +             src_step =3D slave_cfg->src_port_window_size ?
> > +                        slave_cfg->src_port_window_size :
> > +                        sprd_dma_get_step(slave_cfg->src_addr_width);

> Please also explain why.

In general, the src_step is equal to the src_addr_width. As the usage
scenarios become
more complex, for some scenarios the data is discontinuous, with a
port window size
interval between each group of data. When dma finished current data
transmission,
the src_step should be set to the port window size to transfer the
next group of data
correctly. The same goes for dst_step.

> >               if (src_step < 0) {
> >                       dev_err(sdev->dma_dev.dev, "invalid source step\n=
");
> >                       return src_step;
> > @@ -773,7 +793,9 @@ static int sprd_dma_fill_desc(struct dma_chan *chan=
,
> >               else
> >                       dst_step =3D SPRD_DMA_NONE_STEP;
> >       } else {
> > -             dst_step =3D sprd_dma_get_step(slave_cfg->dst_addr_width)=
;
> > +             dst_step =3D slave_cfg->dst_port_window_size ?
> > +                        slave_cfg->dst_port_window_size :
> > +                        sprd_dma_get_step(slave_cfg->dst_addr_width);
> >               if (dst_step < 0) {
> >                       dev_err(sdev->dma_dev.dev, "invalid destination s=
tep\n");
> >                       return dst_step;

