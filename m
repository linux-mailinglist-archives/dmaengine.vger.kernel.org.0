Return-Path: <dmaengine+bounces-4864-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47453A822AC
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 12:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B84C4A6958
	for <lists+dmaengine@lfdr.de>; Wed,  9 Apr 2025 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336D825D8EC;
	Wed,  9 Apr 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET9WNO1q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F092459E8;
	Wed,  9 Apr 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195783; cv=none; b=bFee0bM9o8cPhMolesewIEp5MxO39MJOhjw24BPsosAGd9CXJadaCFvIumhbE/JF4eZmVH6pNXQQwe6iQdrgRCcDYO85EXzJYb1DMYd0m/IeYRUsZ8TAnar0c+RbsGVi3NlzXMFK3C9/XJzo2WI6xTyJXJYcYcgBaI4EJb/L9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195783; c=relaxed/simple;
	bh=w32SsEaKlEQpm6UMGftuPul+F8Oi53F9xCFCLV0Dw1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLI7J2A1iBbusNLo0oJSLJSg+plf4+5k2X0WPA/0Gu/hlgThatpFJNJLiNvNBlNtl0xvBgbaVMp1Vu5RhbrH9Ls4xix9b7GbMxUesEeqLbmpCATT2FIqljl6DcsxXDHiMsXuxvbia5c/85+j1XrqFkciCrABPI/2i14VYnYZUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET9WNO1q; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523de538206so2921864e0c.2;
        Wed, 09 Apr 2025 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744195780; x=1744800580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNGvRaAZMVr4T3k6hFZv4PdckrXPBaij0SOEf1k4UB4=;
        b=ET9WNO1q/o6o5Bm3RFS+EWOTGBpYKpjmDEaS8lrgf8M5N34g2r8VXcO93cG2aRJchh
         WzZLnAMq3x/6hNzkmaVUQkJh4+vE5rFVZeU8pIGfef2EYRkhBtDB9K2+zdDWOyWWYUth
         u1L9Y0nAedR5QUA5e3OVDqxgdzu/LwzUGlmYpnfvtbzTQvc1Pb9nWMrUS5qFamlX4qbb
         wKYMSJiis9Ouk+c9F9n15KN0ity/s1u7/5qcpdSlMI53LfRMEYwTugQOg4l9nOy8FD8X
         eOEyTS6h3WNf1Y9JeR/xNFL+G2NfxoOskagXL/lcC9MF++DxJIsvQs8UT33gIb5nskkv
         abGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195780; x=1744800580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNGvRaAZMVr4T3k6hFZv4PdckrXPBaij0SOEf1k4UB4=;
        b=foWZzBtSJVoZirubgPQavbSlTUVOxTGf/kUKWhyb6gNmECCzE8tV8EdukzZAJbyF/N
         WFJG88vYNSWbbjkmPq7Yx+ngf3kNctaJQE8WiqtDnXhbGAUH9v2Xd47h8GAQ1QMi6d+Q
         gJr33u051OeulU5iet/X4G+r3XBiXI6lQSbJEs+HMV0QWGxtQodU4krns/S9HrB5cwbj
         BsDSCG/hnQef4yjzlXx9zygj75XN7/VUgbLB36YoaOCw93WIW5AS7ZWhCYqqC1wu9B4A
         oyV7WOhXj1vt+bIwQKmxavZ1l7GuPeLHZJtJ+dT9xdmqhMGwr0C/RN0ELvWAljyutzTr
         SbuA==
X-Forwarded-Encrypted: i=1; AJvYcCUj6VuVit9a9fEpIumFjwoK9pM+b6m+pESb19VOW/AjNjqNf4XYvIsNV9kofSDF3/CBv4QEHfX30nFNKwu2@vger.kernel.org, AJvYcCVEEHX81SOUVwYvw30gWq9RDstgHra2y4pIx6oc0BN9KFYvBbSByv8I07jqqrfdwffPMbcv8I8KEizJ0Eo6fPuv+JY=@vger.kernel.org, AJvYcCWIZ7dsCSW/B597ovISHGgoAx0jHLO5XxOhfmXAFTzrgK+qkw9OkM/0KB2ypM0LgvK40iBxE4IG2g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5alft12BXUFKCsuX4UvWkdL423qk6RWTxUbeCxycnUGHB378
	jZHXxoqbTuia65cPgfPjZTNkVTxjWfjtuA4BeLIpeE6UF3/KYwX2IHmjmnpvpw8PzYtcsdkQWhG
	KSyHfPDYXE0dSTyvQFJ87jUgAiCM=
X-Gm-Gg: ASbGncuhvtPO/iu+2rcfbKy8RKpz8iATVcCDgTf+uLocN0qt2H3s0ncgFxNkMQM3CTL
	NwtfD3GhZPHheYoXnWqgbsc2evjInJS8C5T5KsB4/4Vh19w6J7qieYy4fT7Dli5Is+nB7qgUPqj
	5j0X/Sffrg9VjLYMlhFpiJEcoWAaaM63amg0/zywGrKejGhF0vYr+5ugc=
X-Google-Smtp-Source: AGHT+IE2tClcPTkBEdbETFB4rwFWJhoUpMUywIKdSu05hnStxOtkbA7VwxBMST8iE92G2v0/D+AGMRPtN0RCJ2ZVcY0=
X-Received: by 2002:a05:6122:a20:b0:523:7316:7f31 with SMTP id
 71dfb90a1353d-527a9d08806mr953133e0c.5.1744195780186; Wed, 09 Apr 2025
 03:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305002112.5289-1-fabrizio.castro.jz@renesas.com> <20250305002112.5289-6-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250305002112.5289-6-fabrizio.castro.jz@renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 9 Apr 2025 11:49:13 +0100
X-Gm-Features: ATxdqUEjKSnKp5Gtgir4z-Z4Hk-t1cbZXAGS1p85gZQ-VNEwPKl2R6cPZnLloKU
Message-ID: <CA+V-a8vjONgKaWuaN7whQOcr0Rk3FVkyz=FKEwZ_Uep3vMvUpA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] dmaengine: sh: rz-dmac: Add RZ/V2H(P) support
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 12:33=E2=80=AFAM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> The DMAC IP found on the Renesas RZ/V2H(P) family of SoCs is
> similar to the version found on the Renesas RZ/G2L family of
> SoCs, but there are some differences:
> * It only uses one register area
> * It only uses one clock
> * It only uses one reset
> * Instead of using MID/IRD it uses REQ No
> * It is connected to the Interrupt Control Unit (ICU)
> * On the RZ/G2L there is only 1 DMAC, on the RZ/V2H(P) there are 5
>
> Add specific support for the Renesas RZ/V2H(P) family of SoC by
> tackling the aforementioned differences.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v4->v5:
> * Reused RZ/G2L cell specification (with REQ No in place of MID/RID).
> * Dropped ACK No.
> * Removed mid_rid/req_no/ack_no union and reused mid_rid for REQ No.
> * Other small improvements.
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
>  drivers/dma/sh/rz-dmac.c | 81 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 7 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index d7a4ce28040b..1f687b08d6b8 100644
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
> @@ -89,8 +90,14 @@ struct rz_dmac_chan {
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
> +       struct rz_dmac_icu icu;
>         struct device *dev;
>         struct reset_control *rstc;
>         void __iomem *base;
> @@ -99,6 +106,8 @@ struct rz_dmac {
>         unsigned int n_channels;
>         struct rz_dmac_chan *channels;
>
> +       bool has_icu;
> +
>         DECLARE_BITMAP(modules, 1024);
>  };
>
> @@ -167,6 +176,9 @@ struct rz_dmac {
>  #define RZ_DMAC_MAX_CHANNELS           16
>  #define DMAC_NR_LMDESC                 64
>
> +/* RZ/V2H ICU related */
> +#define RZV2H_MAX_DMAC_INDEX           4
> +
>  /*
>   * ---------------------------------------------------------------------=
--------
>   * Device access
> @@ -324,7 +336,13 @@ static void rz_dmac_prepare_desc_for_memcpy(struct r=
z_dmac_chan *channel)
>         lmdesc->chext =3D 0;
>         lmdesc->header =3D HEADER_LV;
>
> -       rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       if (dmac->has_icu) {
> +               rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac=
_index,
> +                                          channel->index,
> +                                          RZV2H_ICU_DMAC_REQ_NO_DEFAULT)=
;
> +       } else {
> +               rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       }
>
>         channel->chcfg =3D chcfg;
>         channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN;
> @@ -375,7 +393,13 @@ static void rz_dmac_prepare_descs_for_slave_sg(struc=
t rz_dmac_chan *channel)
>
>         channel->lmdesc.tail =3D lmdesc;
>
> -       rz_dmac_set_dmars_register(dmac, channel->index, channel->mid_rid=
);
> +       if (dmac->has_icu) {
> +               rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac=
_index,
> +                                          channel->index, channel->mid_r=
id);
> +       } else {
> +               rz_dmac_set_dmars_register(dmac, channel->index, channel-=
>mid_rid);
> +       }
> +
>         channel->chctrl =3D CHCTRL_SETEN;
>  }
>
> @@ -647,7 +671,13 @@ static void rz_dmac_device_synchronize(struct dma_ch=
an *chan)
>         if (ret < 0)
>                 dev_warn(dmac->dev, "DMA Timeout");
>
> -       rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       if (dmac->has_icu) {
> +               rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac=
_index,
> +                                          channel->index,
> +                                          RZV2H_ICU_DMAC_REQ_NO_DEFAULT)=
;
> +       } else {
> +               rz_dmac_set_dmars_register(dmac, channel->index, 0);
> +       }
>  }
>
>  /*
> @@ -824,6 +854,38 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
>         return 0;
>  }
>
> +static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac=
)
> +{
> +       struct device_node *np =3D dev->of_node;
> +       struct of_phandle_args args;
> +       uint32_t dmac_index;
> +       int ret;
> +
> +       ret =3D of_parse_phandle_with_fixed_args(np, "renesas,icu", 1, 0,=
 &args);
> +       if (ret =3D=3D -ENOENT)
> +               return 0;
> +       if (ret)
> +               return ret;
> +
> +       dmac->has_icu =3D true;
> +
> +       dmac->icu.pdev =3D of_find_device_by_node(args.np);
> +       of_node_put(args.np);
> +       if (!dmac->icu.pdev) {
> +               dev_err(dev, "ICU device not found.\n");
> +               return -ENODEV;
> +       }
> +
> +       dmac_index =3D args.args[0];
> +       if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
> +               dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
> +               return -EINVAL;
> +       }
> +       dmac->icu.dmac_index =3D dmac_index;
> +
> +       return 0;
> +}
> +
>  static int rz_dmac_parse_of(struct device *dev, struct rz_dmac *dmac)
>  {
>         struct device_node *np =3D dev->of_node;
> @@ -840,7 +902,7 @@ static int rz_dmac_parse_of(struct device *dev, struc=
t rz_dmac *dmac)
>                 return -EINVAL;
>         }
>
> -       return 0;
> +       return rz_dmac_parse_of_icu(dev, dmac);
>  }
>
>  static int rz_dmac_probe(struct platform_device *pdev)
> @@ -874,9 +936,11 @@ static int rz_dmac_probe(struct platform_device *pde=
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
> @@ -991,9 +1055,12 @@ static void rz_dmac_remove(struct platform_device *=
pdev)
>         reset_control_assert(dmac->rstc);
>         pm_runtime_put(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> +
> +       platform_device_put(dmac->icu.pdev);
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

