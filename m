Return-Path: <dmaengine+bounces-4572-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D909EA4205E
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 14:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479733A8DAD
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2025 13:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208A323BD0D;
	Mon, 24 Feb 2025 13:20:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87F23BD03;
	Mon, 24 Feb 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403214; cv=none; b=mjLQN7mT6zbzr1oNNRPhpqzl6DMGyA4TGSAi0ShZA4BuoH28c5+cU114GTbNcaGMayb/UBFbYVavLrqoISnqyNuVnh4X4tPIUerUUnRN0tSlYcOKY3iwBQ6qx64WqoYfRRqTwmms3PzzvxyQyhMT0pA34daiUVV3GT2Hqc/T8uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403214; c=relaxed/simple;
	bh=aLCdhKEzZDltFZCrzQHKoH9i+UYaIYqlxzH+pCGUy7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BidHKnefrDFWATvdMVFgbZTalH/NSqZN8a8ws6xiSX81QkvP4phF1Rklm5RKkUR8j4iI0sGhkT61SvKStsuQb+VZpk6/okX5/JkIzoifX+T7bTT3Gw4yaZF3L4jygyz/r6BWUKy7pBIpuJxrecBqvbfaYhu42PlGgYWIcU6ocQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52086f114b4so972098e0c.2;
        Mon, 24 Feb 2025 05:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403209; x=1741008009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAQ2sBpUx9WOZ+0ijnBFOHuMBriJ9iyCaNDQTFea6gc=;
        b=bMc82eT4gHzFEIK4iPO+IoE5vTo7KoLaDPH2MCZ9DiZOs6YHSDazTXpOvMr3ZFsNUO
         EBEmRkQL/kic9nGB4ipZWdAMimbJJTyGkfjT4Bgu9cAErS54QklzGyUJW8/Xb/A3ONak
         K1uUPwS4BgpnSTqWH4yiwwY4C9Q9vfkIBsIyVsoXCqGs3UQcIzqy6kh+w7JUal4+2N95
         xoV4lLUk/JabHwUwqnY+xpCcPcAPSgSRXAqyPo+OxVz6Rh0bpOaErQj+FhVV4oWezpzj
         rvkUvkEu8IffBuSNlW2z8r/sK0GYdtqulkpnUUIdHY4uWXaJUsErGgUvzdWanNrGIWC5
         maFg==
X-Forwarded-Encrypted: i=1; AJvYcCU1ivrqnPyyao//YU3qtBx5q6ZTcAajgbS3Oj8e8ZHZdY88PkwEuz7MFATvc4UlhD3NeqoxrJhRQhqF5By+@vger.kernel.org, AJvYcCVNTUjRD6Zc+Xrvyf2XZ5Z8hoovTB78n9Z3hY8kA3QmHwvwGo7ReJmubqMsdjyjUSq52LGVdfxfiBeFe3mKFvMHn1Y=@vger.kernel.org, AJvYcCVYltM6RYDKJMfgh2lw1GIhSBHyTp/h31wLVOiWZ1mcFaMv4+mmWf3xF7/IBWLcJTPdJMJVwbPQJMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjddIEQnrYTyObilMYNca360qqrMi4LB/qNprfeXllniJ+fZHV
	3dbq22bvO7bh7X47WIkP3XOpCxZGuCKi+h8S50rZd72szwYruFKvyCGWyUlKSY8=
X-Gm-Gg: ASbGncvQK0aoGshx41J3MKULPAaL1kCa7ycQR7VgkGwakiXrvNOJu4Grs/J+B5VdTFf
	Lru/HjbWEunMiPV/AOu96w3ei8tzTUi16Dzw8tlmN/3g/aReLLPqt+/78Kx32fVT1tOAn67njsv
	tmolcW8OIY9yfV1EOi2d+hzAAOSWhFUqJjz3EML2eeR4tk2kRpZi0uHTc/dYjbannW5z9LNDchV
	lw2LRsB2Mz3I2XaeCbIiuewuKf1uswOBu8kTSFHvc1uwBtcyPJDaAq3uTNIqgeOQWI5vvqyjcDC
	OVLe7tJSCN0GEnTgwG03FBQTIhbYGewsf3Zw88F52Rhh4QFRegGkI3Hrhtt6eRxg
X-Google-Smtp-Source: AGHT+IEGigo/hU2nVdF41+1Ls5kl88dk8tC92KtbOQkCdbRoYTNFTXq05XSahKZszja+AlwQipKVdA==
X-Received: by 2002:a05:6122:4007:b0:520:5185:1c77 with SMTP id 71dfb90a1353d-521ee4202c8mr5974593e0c.7.1740403209004;
        Mon, 24 Feb 2025 05:20:09 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520d028985csm2962055e0c.12.2025.02.24.05.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 05:20:07 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4bd367926easo1362048137.3;
        Mon, 24 Feb 2025 05:20:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKDb7Qnpn+swiEFTVvdElNJAy2ncInPtzh6wGGVon3KVn07vT/wgRWy9AcmOQRAt/A28qep892XlOROri2@vger.kernel.org, AJvYcCVFbJj5neYeyL/n6SutKDKB0Fp1/w34uz0+XgPoocYat4hO/4EeCzOHPWQI3t3DW27mpTWomc5IBhSqsLkNq9KwThQ=@vger.kernel.org, AJvYcCWLRBALnTYel5jm+Lyb3mci4j3gtGo0uQ8S8wFEksQyTJtCQVAPOgbwgnmZAbwyDlPbB7Xw5eqbUs0=@vger.kernel.org
X-Received: by 2002:a05:6102:1613:b0:4bc:ad3:a697 with SMTP id
 ada2fe7eead31-4bfc0278a60mr6429693137.23.1740403207233; Mon, 24 Feb 2025
 05:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com> <20250220150110.738619-7-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250220150110.738619-7-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 14:19:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXBjd5FxNkYbpoFD6buN04KfUz7A1djSnXZhLPSwMMhRg@mail.gmail.com>
X-Gm-Features: AWEUYZmYkdX0j-XuBUbBc36B2r0gm8c9uhQzb42-8S2WB1kwzKKtf6TQFxOltU0
Message-ID: <CAMuHMdXBjd5FxNkYbpoFD6buN04KfUz7A1djSnXZhLPSwMMhRg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Fabrizio,

On Thu, 20 Feb 2025 at 16:01, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
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

Thanks for your patch!

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

Please add comments (with/without ICU), so the casual reader knows
the meaning of the union.
Note that I am no longer convinced we need a union, as REQ_NO seems
to be just the new name for MID/RID.


>  };
>
>  #define to_rz_dmac_chan(c)     container_of(c, struct rz_dmac_chan, vc.chan)
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

FTR, this is identical to MID_RID_MASK.

> +#define RZV2H_ACK_NO_MASK              GENMASK(16, 10)

This is a new field.

> +#define RZV2H_HIEN_MASK                        BIT(17)
> +#define RZV2H_LVL_MASK                 BIT(18)
> +#define RZV2H_AM_MASK                  GENMASK(21, 19)
> +#define RZV2H_TM_MASK                  BIT(22)
> +#define RZV2H_EXTRACT_REQ_NO(x)                FIELD_GET(RZV2H_REQ_NO_MASK, (x))
> +#define RZV2H_EXTRACT_ACK_NO(x)                FIELD_GET(RZV2H_ACK_NO_MASK, (x))
> +#define RZVH2_EXTRACT_CHCFG(x)         ((FIELD_GET(RZV2H_HIEN_MASK, (x)) << 5) | \
> +                                        (FIELD_GET(RZV2H_LVL_MASK, (x))  << 6) | \
> +                                        (FIELD_GET(RZV2H_AM_MASK, (x))   << 8) | \
> +                                        (FIELD_GET(RZV2H_TM_MASK, (x))   << 22))

If the new field would be moved up in the configuration word,
the above would become identical to the existing CHCFG handling.

> +
> +#define RZV2H_MAX_DMAC_INDEX           4
> +#define RZV2H_ICU_PROPERTY             "renesas,icu"

Please don't obfuscate DT property handling, and drop this define.

> +
>  /*
>   * -----------------------------------------------------------------------------
>   * Device access
> @@ -324,7 +357,15 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>         lmdesc->chext = 0;
>         lmdesc->header = HEADER_LV;
>
> -       rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       if (!dmac->has_icu) {
> +               rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       } else {
> +               rzv2h_icu_register_dma_req_ack(dmac->icu.pdev,
> +                                              dmac->icu.dmac_index,
> +                                              channel->index,
> +                                              RZV2H_ICU_DMAC_REQ_NO_DEFAULT,
> +                                              RZV2H_ICU_DMAC_ACK_NO_DEFAULT);
> +       }

If you do have both branches of an if-statement, please drop the
negation from the test to improve readability (everywhere):

    if (dmac->has_icu) {
            ...
    } else {
            ...
    }

>
>         channel->chcfg = chcfg;
>         channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;

> @@ -452,9 +501,15 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
>         list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>         list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
>
> -       if (channel->mid_rid >= 0) {
> -               clear_bit(channel->mid_rid, dmac->modules);
> -               channel->mid_rid = -EINVAL;
> +       if (!dmac->has_icu) {
> +               if (channel->mid_rid >= 0) {
> +                       clear_bit(channel->mid_rid, dmac->modules);
> +                       channel->mid_rid = -EINVAL;
> +               }
> +       } else {
> +               clear_bit(channel->req_no, dmac->modules);
> +               channel->req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
> +               channel->ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
>         }

Without a union, both branches would be almost the same...

>
>         spin_unlock_irqrestore(&channel->vc.lock, flags);

> @@ -727,13 +790,30 @@ static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg)
>         struct rz_dmac *dmac = to_rz_dmac(chan->device);
>         struct of_phandle_args *dma_spec = arg;
>         u32 ch_cfg;
> +       u16 req_no;
> +
> +       if (!dmac->has_icu) {
> +               channel->mid_rid = dma_spec->args[0] & MID_RID_MASK;

So mid_rid would fit in a short, just like req_no (ignoring the latter
is unsigned, which could be changed).

> +               ch_cfg = (dma_spec->args[0] & CHCFG_MASK) >> 10;
> +               channel->chcfg = CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
> +                                CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
> +
> +               return !test_and_set_bit(channel->mid_rid, dmac->modules);

Please don't return early, but use an else branch for the ICU case,
to show symmetry.

> +       }
> +
> +       req_no = RZV2H_EXTRACT_REQ_NO(dma_spec->args[0]);
> +       if (req_no >= RZV2H_ICU_DMAC_REQ_NO_MIN_FIX_OUTPUT)
> +               return false;

Do you need this check?

> +
> +       channel->req_no = req_no;
> +
> +       channel->ack_no = RZV2H_EXTRACT_ACK_NO(dma_spec->args[0]);
> +       if (channel->ack_no >= RZV2H_ICU_DMAC_ACK_NO_MIN_FIX_OUTPUT)
> +               channel->ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT;

Do you need this check?

> -       channel->mid_rid = dma_spec->args[0] & MID_RID_MASK;
> -       ch_cfg = (dma_spec->args[0] & CHCFG_MASK) >> 10;
> -       channel->chcfg = CHCFG_FILL_TM(ch_cfg) | CHCFG_FILL_AM(ch_cfg) |
> -                        CHCFG_FILL_LVL(ch_cfg) | CHCFG_FILL_HIEN(ch_cfg);
> +       channel->chcfg = RZVH2_EXTRACT_CHCFG(dma_spec->args[0]);
>
> -       return !test_and_set_bit(channel->mid_rid, dmac->modules);
> +       return !test_and_set_bit(channel->req_no, dmac->modules);

Without a union, both branches would be almost the same...

>  }
>
>  static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args *dma_spec,
> @@ -768,7 +848,12 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>         int ret;
>
>         channel->index = index;
> -       channel->mid_rid = -EINVAL;
> +       if (!dmac->has_icu) {
> +               channel->mid_rid = -EINVAL;
> +       } else {
> +               channel->req_no = RZV2H_ICU_DMAC_REQ_NO_DEFAULT;
> +               channel->ack_no = RZV2H_ICU_DMAC_ACK_NO_DEFAULT;
> +       }

Without a union, both branches would be almost the same...

>
>         /* Request the channel interrupt. */
>         scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
> @@ -824,6 +909,41 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>         return 0;
>  }
>
> +static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
> +{
> +       struct device_node *icu_np, *np = dev->of_node;
> +       struct of_phandle_args args;
> +       uint32_t dmac_index;
> +       int ret;
> +
> +       ret = of_parse_phandle_with_fixed_args(np, RZV2H_ICU_PROPERTY, 1, 0, &args);
> +       if (ret)
> +               return ret;
> +
> +       icu_np = args.np;
> +       dmac_index = args.args[0];
> +
> +       if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
> +               dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
> +               ret = -EINVAL;
> +               goto free_icu_np;
> +       }
> +
> +       dmac->icu.pdev = of_find_device_by_node(icu_np);
> +       if (!dmac->icu.pdev) {
> +               dev_err(dev, "ICU device not found.\n");
> +               ret = -ENODEV;
> +               goto free_icu_np;
> +       }
> +
> +       dmac->icu.dmac_index = dmac_index;
> +
> +free_icu_np:
> +       of_node_put(icu_np);
> +
> +       return ret;
> +}
> +
>  static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
>  {
>         struct device_node *np = dev->of_node;
> @@ -840,6 +960,10 @@ static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
>                 return -EINVAL;
>         }
>
> +       dmac->has_icu = of_property_present(np, RZV2H_ICU_PROPERTY);

Doesn't of_parse_phandle_with_fixed_args() in rz_dmac_parse_of_icu()
return -ENOENT if the property is not present, so you don't have to
check for presence here?

> +       if (dmac->has_icu)
> +               return rz_dmac_parse_of_icu(dev, dmac);
> +
>         return 0;
>  }
>

> @@ -991,9 +1117,13 @@ static void rz_dmac_remove(struct platform_device *pdev)
>         reset_control_assert(dmac->rstc);
>         pm_runtime_put(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> +
> +       if (dmac->has_icu)

No need to check for a NULL pointer.

> +               platform_device_put(dmac->icu.pdev);
>  }
>
>  static const struct of_device_id of_rz_dmac_match[] = {
> +       { .compatible = "renesas,r9a09g057-dmac", },
>         { .compatible = "renesas,rz-dmac", },
>         { /* Sentinel */ }
>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

