Return-Path: <dmaengine+bounces-4561-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ED0A4023E
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 22:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4662019E21CD
	for <lists+dmaengine@lfdr.de>; Fri, 21 Feb 2025 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12D253F19;
	Fri, 21 Feb 2025 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etvIm0k9"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38746253B6D;
	Fri, 21 Feb 2025 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174307; cv=none; b=WoFmK3yKAyDKZwrC2EaQWn96mCdVB3WXSpUAEi3SAUUN3YULGZ/XEdOaPjC7P2ak7dehF83aniH1vTiNO0KAn1k3JCzBOOOyHVCzBfLKogU0ntkmTYaScHa50TLOh51vMCG3umWmBdf30Fnq+r3ylFjKfpyS1zuXLlGM/BhlQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174307; c=relaxed/simple;
	bh=akL3wz4iSsmuIym6C3jmwUvL382rmjozb5r5ySspU/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVaB/LP3DlGl0m2BX/fscoiorMoqE1jIqqVeNo24xqwSmUUN5hRYrMt9DpZFPjfbIWkv3NOda727kkq9WytfTgcsS+4bdH0ERhtCQdkaKyzBquXRJKLBQU6fDd2RaayhEpXBigsH6N+4DkHczwJyVjyyS4az86d3s0LsAialSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etvIm0k9; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-520a473d2adso1621442e0c.2;
        Fri, 21 Feb 2025 13:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740174304; x=1740779104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbaVcy7j3epysvmklNCr1jWVpTTlg9OXKRTflj3uvhw=;
        b=etvIm0k9lmUECXx8baSihH1twumUHnY3y+E8k7u8ThNHiAh1c6/JOYDT8fgk7aEGso
         fxDZydAMBXRQgzxHNoIkUzqC0bq2G9vo8eTkEF/KV4BY+cR6TM9P8PAN7xStLTSkrMfT
         ldHhPCBiCcjlNTkRxuZMVtRYoq8ZEIGOvFT7uLdhFyYdKIFCWE22iLv3XOcpw6VGurFl
         yfnpb1531ykQ3xpPI3snro6bdwQ7StgHyCk9PYC8MHsNvq1t3CIpf2SS3PrlszT12RZi
         5ocHyYXnj2Va4DZbN01yQ/x6ZwK/y5lNvMjMeLz5MZZW8aWzoN3To13tXhAjy7OGx/EU
         TB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740174304; x=1740779104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbaVcy7j3epysvmklNCr1jWVpTTlg9OXKRTflj3uvhw=;
        b=ArS54GumeRhM34hp9auZuvlLymXvPlEGhPgj6Xnfqum3Ez6DhYUJUMkrAwcwqfe+Yf
         VXAkyA/OWK07bb2tj99cMZ+cYSUe+jbTxUha5Sh/S7yOmpdnLX9AKPAZijaDz8Wehc0g
         akcIyU29tbXAg+cgPXrWhSeMtH8omZnCmev+lHw3mHEKpNWPtkXOG5nIxDYDigHNG/C+
         5O4Be5UP8PFO00HdY1A6rL3JV/gG410LNOmswoROgS3FPWBmKqKcxxQDtxp1aUmz1P+9
         n+uqoNDfvQxeH8Q3MvCArMQPGzFBQ+nTXdjbXMtyNqrZ/U54dATb0O1bh28SU9/MHmCZ
         uvsw==
X-Forwarded-Encrypted: i=1; AJvYcCUid+Y9OMt/6X1yjBpqrQm+XN4zwdGeoDLQm2xlZeY7m7L7P7wz2XIE37y0ViPuAjHz2eUQmx3vUKsvV9/k@vger.kernel.org, AJvYcCXeI1pdYQZ8BCUYgrOO9wLzYalL6kNZjK75pg1RxvfKlbZGoQAQTh2H8HIlQAoSKLWMjIt1t2Md9hE=@vger.kernel.org, AJvYcCXpDHlwvDc2sqbPX/Q/L+XTfKXOZY1B+HnXpySo5m6GzWJdD5b3otNl0VF8z5jddH+t6SSuyOy+0uGsoyM78AO/3Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bzvsvoT6kgL/prlYOaFRYx1+/SFSBk3cQ2GsSj3jKVmkLk7q
	C2WZu8sErIVWFWqgjMThMHivbjoXuMXChacz4cLEhFwL8qpP18mL/PY81siC99LHl4GKJGiNdGp
	TorLDXBMlcs3VdhKWhVmw8WAwMlc=
X-Gm-Gg: ASbGncvMWCJCVeDPLFNNhy4cEwvYmQWzDl5cRJi2OONm4P2x2i12inROUeN12IJy1Ko
	NYZ7zQ5QCBApGisVwz5Jx6Yxf94Hc3C5pYA+xcTXoO2Tr7U7Gj7msLFoYmUsLdqDZQBriGtPEFc
	BqsXqMsM4SLp6KkSwK613xowOuCtMHjgtAN7vax4K3
X-Google-Smtp-Source: AGHT+IE4mW4uPyXhgol+20kQPcGrRo6Bg4NZZxZnicw81q7CGIt39IiGmtbvKXmb3nKTWfI8GRqsAU1UfEqP7rGt8Uo=
X-Received: by 2002:a05:6122:2007:b0:520:5a87:66f0 with SMTP id
 71dfb90a1353d-521edfcdee8mr3039060e0c.0.1740174303984; Fri, 21 Feb 2025
 13:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com> <20250220150110.738619-7-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-7-fabrizio.castro.jz@renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Feb 2025 21:44:36 +0000
X-Gm-Features: AWEUYZkCwV9d_yxzn1XGCVaGAzNTbxEGYpleA9f5JQYHXn3kGpHrClnTyzIvA1c
Message-ID: <CA+V-a8vUFKPyXkDFsLKrg1xDrJrU_D6cQmxz+mnxqab+61dLDw@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:07=E2=80=AFPM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> similar to the version found on the Renesas RZ/G2L family of
> SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ NO/ACK NO
> * It is connected to the Interrupt Control Unit (ICU)
> * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
>
> Add specific support for the Renesas RZ/V2H(P) family of SoC by
> tackling the aforementioned differences.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v3->v4:
> * Fixed an issue with mid_rid/req_no/ack_no initialization
> v2->v3:
> * Dropped change to Kconfig.
> * Replaced rz_dmac_type with has_icu flag.
> * Put req_no and ack_no in an anonymous struct, nested under an
>   anonymous union with mid_rid.
> * Dropped data field of_rz_dmac_match[], and added logic to determine
>   value of has_icu flag from DT parsing.
> v1->v2:
> * Switched to new macros for minimum values.
> ---
>  drivers/dma/sh/rz-dmac.c | 162 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 146 insertions(+), 16 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d7a4ce28040b..57a1fdeed734 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -14,6 +14,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> +#include <linux/irqchip/irq-renesas-rzv2h.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -73,7 +74,6 @@ struct rz_dmac_chan {
>
>         u32 chcfg;
>         u32 chctrl;
> -       int mid_rid;
>
>         struct list_head ld_free;
>         struct list_head ld_queue;
> @@ -85,20 +85,36 @@ struct rz_dmac_chan {
>                 struct rz_lmdesc *tail;
>                 dma_addr_t base_dma;
>         } lmdesc;
> +
> +       union {
> +               int mid_rid;
> +               struct {
> +                       u16 req_no;
> +                       u8 ack_no;
> +               };
> +       };
>  };
>
>  #define to_rz_dmac_chan(c)     container_of(c, struct rz_dmac_chan, vc.c=
han)
>
> +struct rz_dmac_icu {
> +       struct platform_device *pdev;
> +       u8 dmac_index;
> +};
> +
>  struct rz_dmac {
>         struct dma_device engine;
>         struct device *dev;
>         struct reset_control *rstc;
> +       struct rz_dmac_icu icu;
>         void __iomem *base;
>         void __iomem *ext_base;
>
>         unsigned int n_channels;
>         struct rz_dmac_chan *channels;
>
> +       bool has_icu;
> +
>         DECLARE_BITMAP(modules, 1024);
>  };
>
> @@ -167,6 +183,23 @@ struct rz_dmac {
>  #define RZ_DMAC_MAX_CHANNELS           16
>  #define DMAC_NR_LMDESC                 64
>
> +/* RZ/V2H ICU related */
> +#define RZV2H_REQ_NO_MASK              GENMASK(9, 0)
> +#define RZV2H_ACK_NO_MASK              GENMASK(16, 10)
> +#define RZV2H_HIEN_MASK                        BIT(17)
> +#define RZV2H_LVL_MASK                 BIT(18)
> +#define RZV2H_AM_MASK                  GENMASK(21, 19)
> +#define RZV2H_TM_MASK                  BIT(22)
> +#define RZV2H_EXTRACT_REQ_NO(x)                FIELD_GET(RZV2H_REQ_NO_MA=
SK, (x))
> +#define RZV2H_EXTRACT_ACK_NO(x)                FIELD_GET(RZV2H_ACK_NO_MA=
SK, (x))
> +#define RZVH2_EXTRACT_CHCFG(x)         ((FIELD_GET(RZV2H_HIEN_MASK, (x))=
 << 5) | \
> +                                        (FIELD_GET(RZV2H_LVL_MASK, (x)) =
 << 6) | \
> +                                        (FIELD_GET(RZV2H_AM_MASK, (x))  =
 << 8) | \
> +                                        (FIELD_GET(RZV2H_TM_MASK, (x))  =
 << 22))
> +
> +#define RZV2H_MAX_DMAC_INDEX           4
> +#define RZV2H_ICU_PROPERTY             "renesas,icu"
> +
>  /*
>   * ---------------------------------------------------------------------=
--------
>   * Device access
> @@ -324,7 +357,15 @@ static void rz_dmac_prepare_desc_for_memcpy(struct r=
z_dmac_chan *channel)
>         lmdesc->chext =3D 0;
>         lmdesc->header =3D HEADER_LV;
>
> -       rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       if (!dmac->has_icu) {
> +               rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       } else {
> +               rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> +                                              dmac->icu.dmac_index,
> +                                              channel->index,
> +                                              RZV2H_ICU_DMAC_REQ_NO_DEFA=
ULT,
> +                                              RZV2H_ICU_DMAC_ACK_NO_DEFA=
ULT);
> +       }
>
>         channel->chcfg =3D chcfg;
>         channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN;
> @@ -375,7 +416,15 @@ static void rz_dmac_prepare_descs_for_slave_sg(struc=
t rz_dmac_chan *channel)
>
>         channel->lmdesc.tail =3D lmdesc;
>
> -       rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid=
);
> +       if (!dmac->has_icu) {
> +               rz_dmac_set_dmars_register(dmac, channel->index, channel-=
>mid_rid);
> +       } else {
> +               rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> +                                              dmac->icu.dmac_index,
> +                                              channel->index, channel->r=
eq_no,
> +                                              channel->ack_no);
> +       }
> +
>         channel->chctrl =3D CHCTRL_SETEN;
>  }
>
> @@ -452,9 +501,15 @@ static void rz_dmac_free_chan_resources(struct dma_c=
han *chan)
>         list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>         list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
>
> -       if (channel->mid_rid >=3D 0) {
> -               clear_bit(channel->mid_rid, dmac->modules);
> -               channel->mid_rid =3D -EINVAL;
> +       if (!dmac->has_icu) {
> +               if (channel->mid_rid >=3D 0) {
> +                       clear_bit(channel->mid_rid, dmac->modules);
> +                       channel->mid_rid =3D -EINVAL;
> +               }
> +       } else {
> +               clear_bit(channel->req_no, dmac->modules);
> +               channel->req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
> +               channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
>         }
>
>         spin_unlock_irqrestore(&channel->vc.lock, flags);
> @@ -647,7 +702,15 @@ static void rz_dmac_device_synchronize(struct dma_ch=
an *chan)
>         if (ret < 0)
>                 dev_warn(dmac->dev, "DMA Timeout");
>
> -       rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       if (!dmac->has_icu) {
> +               rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       } else {
> +               rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> +                                              dmac->icu.dmac_index,
> +                                              channel->index,
> +                                              RZV2H_ICU_DMAC_REQ_NO_DEFA=
ULT,
> +                                              RZV2H_ICU_DMAC_ACK_NO_DEFA=
ULT);
> +       }
>  }
>
>  /*
> @@ -727,13 +790,30 @@ static bool rz_dmac_chan_filter(struct dma_chan *ch=
an, void *arg)
>         struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
>         struct of_phandle_args *dma_spec =3D arg;
>         u32 ch_cfg;
> +       u16 req_no;
> +
> +       if (!dmac->has_icu) {
> +               channel->mid_rid =3D dma_spec->args[0] & MID_RID_MASK;
> +               ch_cfg =3D (dma_spec->args[0] & CHCFG_MASK) >> 10;
> +               channel->chcfg =3D CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(=
ch_cfg) |
> +                                CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN=
(ch_cfg);
> +
> +               return !test_and_set_bit(channel->mid_rid, dmac->modules)=
;
> +       }
> +
> +       req_no =3D RZV2H_EXTRACT_REQ_NO(dma_spec->args[0]);
> +       if (req_no >=3D RZV2H_ICU_DMAC_REQ_NO_MIN_FIX_OUTPUT)
> +               return false;
> +
> +       channel->req_no =3D req_no;
> +
> +       channel->ack_no =3D RZV2H_EXTRACT_ACK_NO(dma_spec->args[0]);
> +       if (channel->ack_no >=3D RZV2H_ICU_DMAC_ACK_NO_MIN_FIX_OUTPUT)
> +               channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
>
> -       channel->mid_rid =3D dma_spec->args[0] & MID_RID_MASK;
> -       ch_cfg =3D (dma_spec->args[0] & CHCFG_MASK) >> 10;
> -       channel->chcfg =3D CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) =
|
> -                        CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg)=
;
> +       channel->chcfg =3D RZVH2_EXTRACT_CHCFG(dma_spec->args[0]);
>
> -       return !test_and_set_bit(channel->mid_rid, dmac->modules);
> +       return !test_and_set_bit(channel->req_no, dmac->modules);
>  }
>
>  static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spe=
c,
> @@ -768,7 +848,12 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>         int ret;
>
>         channel->index =3D index;
> -       channel->mid_rid =3D -EINVAL;
> +       if (!dmac->has_icu) {
> +               channel->mid_rid =3D -EINVAL;
> +       } else {
> +               channel->req_no =3D RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
> +               channel->ack_no =3D RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
> +       }
>
>         /* Request the channel interrupt. */
>         scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> @@ -824,6 +909,41 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>         return 0;
>  }
>
> +static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac=
)
> +{
> +       struct device_node *icu_np, *np =3D dev->of_node;
> +       struct of_phandle_args args;
> +       uint32_t dmac_index;
> +       int ret;
> +
> +       ret =3D of_parse_phandle_with_fixed_args(np, RZV2H_ICU_PROPERTY, =
1, 0, &args);
> +       if (ret)
> +               return ret;
> +
> +       icu_np =3D args.np;
> +       dmac_index =3D args.args[0];
> +
> +       if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
> +               dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
> +               ret =3D -EINVAL;
> +               goto free_icu_np;
> +       }
> +
> +       dmac->icu.pdev =3D of_find_device_by_node(icu_np);
> +       if (!dmac->icu.pdev) {
> +               dev_err(dev, "ICU device not found.\n");
> +               ret =3D -ENODEV;
> +               goto free_icu_np;
> +       }
> +
> +       dmac->icu.dmac_index =3D dmac_index;
> +
> +free_icu_np:
> +       of_node_put(icu_np);
> +
> +       return ret;
> +}
> +
>  static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
>  {
>         struct device_node *np =3D dev->of_node;
> @@ -840,6 +960,10 @@ static int rz_dmac_parse_of(struct device *dev, stru=
ct rz_dmac *dmac)
>                 return -EINVAL;
>         }
>
> +       dmac->has_icu =3D of_property_present(np, RZV2H_ICU_PROPERTY);
> +       if (dmac->has_icu)
> +               return rz_dmac_parse_of_icu(dev, dmac);
> +
>         return 0;
>  }
>
> @@ -874,9 +998,11 @@ static int rz_dmac_probe(struct platform_device *pde=
v)
>         if (IS_ERR(dmac->base))
>                 return PTR_ERR(dmac->base);
>
> -       dmac->ext_base =3D devm_platform_ioremap_resource(pdev, 1);
> -       if (IS_ERR(dmac->ext_base))
> -               return PTR_ERR(dmac->ext_base);
> +       if (!dmac->has_icu) {
> +               dmac->ext_base =3D devm_platform_ioremap_resource(pdev, 1=
);
> +               if (IS_ERR(dmac->ext_base))
> +                       return PTR_ERR(dmac->ext_base);
> +       }
>
>         /* Register interrupt handler for error */
>         irq =3D platform_get_irq_byname(pdev, irqname);
> @@ -991,9 +1117,13 @@ static void rz_dmac_remove(struct platform_device *=
pdev)
>         reset_control_assert(dmac->rstc);
>         pm_runtime_put(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> +
> +       if (dmac->has_icu)
> +               platform_device_put(dmac->icu.pdev);
>  }
>
>  static const struct of_device_id of_rz_dmac_match[] =3D {
> +       { .compatible =3D "renesas,r9a09g057-dmac", },
>         { .compatible =3D "renesas,rz-dmac", },
>         { /* Sentinel */ }
>  };
> --
> 2.34.1
>
>

