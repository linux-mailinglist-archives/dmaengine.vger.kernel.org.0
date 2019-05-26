Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49ED2ABCA
	for <lists+dmaengine@lfdr.de>; Sun, 26 May 2019 21:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfEZTMt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 26 May 2019 15:12:49 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42255 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfEZTMt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 26 May 2019 15:12:49 -0400
Received: by mail-yb1-f195.google.com with SMTP id a21so5768315ybg.9;
        Sun, 26 May 2019 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3qfwkMk3jqUycxqYw8c0sLECnRBzwPP2sK1DjD5g7pM=;
        b=nkH3ufJ7uMj10iENbT39YlCH+iUTC+YBXyf6Ig5HTiaxvN6alZi1tRnWnVANOxsQVj
         FnW2AKt0BjYU3eu87fmmDxie6cg4tcd6TPrSYU72zA2Clpov7Tj1YIsEwvu4vE7qROs7
         UfgXpVAtM0b6mhPJlKS6HOOflmc8rt7Y+K9xF5a89adRMnzrEXJ8Yp6eF6nWOWFiJwxv
         sIEcSZoLpTKxpkxHajCLwOr2zhw/EDuqc8gPI/rTz9CoyF1GDXp9kMQkKrDUo+7pnwGv
         CbY0cnX5+rydeOWg3waohBLkFZni4Qzs3Knb98FUu5W7jAJVqnDTlnAfl8kys1zZiNY5
         s2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3qfwkMk3jqUycxqYw8c0sLECnRBzwPP2sK1DjD5g7pM=;
        b=Op3DZMgF+PLqT2W7ENjKEoyBvD+/+vAK5Nqqx/K/mo1EixE365gtqEGv1UPXnC2LGX
         pc0MLoviJHqAqmOMQh1Z3ZsETGmWH8ULyfbTJHaPF+BHjda0XSDj0Ymtipz9fYM1Fe5T
         zQzCkF+EcYI2j65bhua8f1n1TXSbfXzOZTnwVWujJwKzbu6xPoFf6u0n+O0iDX7TgCEL
         VfRegTEObW6y++2eSi29bCIksTdyFJxXU5jQoxID5W5B7JdXgQhPikhyvH5/32g8zrAj
         qtXG3ZYTKjjcZDhj9/8AzY71AwKlgONQHkhFArUVmGS/ikWe89wEkVgpldu2E+aPAwWT
         o0zg==
X-Gm-Message-State: APjAAAVr71X8o/hkqaC4adETByeBIwBKu6Ho50Mdy2wUqt8PdCLZqoSq
        P4KNAGD7Ibt91l3nmuaqSVO+BkfgkS3P+cuQRx0=
X-Google-Smtp-Source: APXvYqzrtpZcSrZuQRqwCwZ6caVJMS0tu3mLbwnZtrsAf+VmyJuuEGHn5L+hB9h5GZOF5b3IoegKPZ3NkGJPQPxAMYU=
X-Received: by 2002:a25:cecd:: with SMTP id x196mr6392089ybe.203.1558897967849;
 Sun, 26 May 2019 12:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190525163819.21055-1-peron.clem@gmail.com> <20190525163819.21055-6-peron.clem@gmail.com>
 <20190526183425.nbhrk5pa264p7tdy@flea>
In-Reply-To: <20190526183425.nbhrk5pa264p7tdy@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 26 May 2019 21:12:36 +0200
Message-ID: <CAJiuCcfe7LHehZTzGvW+0LzqvDRs4dSjmGhRxkDHgbHrD2+MKA@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] dmaengine: sun6i: Add support for H6 DMA
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Maxime,

On Sun, 26 May 2019 at 20:34, Maxime Ripard <maxime.ripard@bootlin.com> wro=
te:
>
> On Sat, May 25, 2019 at 06:38:17PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 DMA has more than 32 supported DRQs, which means that configuration
> > register is slightly rearranged. It also needs additional clock to be
> > enabled.
> >
> > Add support for it.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  drivers/dma/sun6i-dma.c | 44 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 42 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index f5cb5e89bf7b..8d44ddae926a 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -69,14 +69,19 @@
> >
> >  #define DMA_CHAN_CUR_CFG     0x0c
> >  #define DMA_CHAN_MAX_DRQ_A31         0x1f
> > +#define DMA_CHAN_MAX_DRQ_H6          0x3f
> >  #define DMA_CHAN_CFG_SRC_DRQ_A31(x)  ((x) & DMA_CHAN_MAX_DRQ_A31)
> > +#define DMA_CHAN_CFG_SRC_DRQ_H6(x)   ((x) & DMA_CHAN_MAX_DRQ_H6)
> >  #define DMA_CHAN_CFG_SRC_MODE_A31(x) (((x) & 0x1) << 5)
> > +#define DMA_CHAN_CFG_SRC_MODE_H6(x)  (((x) & 0x1) << 8)
> >  #define DMA_CHAN_CFG_SRC_BURST_A31(x)        (((x) & 0x3) << 7)
> >  #define DMA_CHAN_CFG_SRC_BURST_H3(x) (((x) & 0x3) << 6)
> >  #define DMA_CHAN_CFG_SRC_WIDTH(x)    (((x) & 0x3) << 9)
> >
> >  #define DMA_CHAN_CFG_DST_DRQ_A31(x)  (DMA_CHAN_CFG_SRC_DRQ_A31(x) << 1=
6)
> > +#define DMA_CHAN_CFG_DST_DRQ_H6(x)   (DMA_CHAN_CFG_SRC_DRQ_H6(x) << 16=
)
> >  #define DMA_CHAN_CFG_DST_MODE_A31(x) (DMA_CHAN_CFG_SRC_MODE_A31(x) << =
16)
> > +#define DMA_CHAN_CFG_DST_MODE_H6(x)  (DMA_CHAN_CFG_SRC_MODE_H6(x) << 1=
6)
> >  #define DMA_CHAN_CFG_DST_BURST_A31(x)        (DMA_CHAN_CFG_SRC_BURST_A=
31(x) << 16)
> >  #define DMA_CHAN_CFG_DST_BURST_H3(x) (DMA_CHAN_CFG_SRC_BURST_H3(x) << =
16)
> >  #define DMA_CHAN_CFG_DST_WIDTH(x)    (DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
> > @@ -319,12 +324,24 @@ static void sun6i_set_drq_a31(u32 *p_cfg, s8 src_=
drq, s8 dst_drq)
> >                 DMA_CHAN_CFG_DST_DRQ_A31(dst_drq);
> >  }
> >
> > +static void sun6i_set_drq_h6(u32 *p_cfg, s8 src_drq, s8 dst_drq)
> > +{
> > +     *p_cfg |=3D DMA_CHAN_CFG_SRC_DRQ_H6(src_drq) |
> > +               DMA_CHAN_CFG_DST_DRQ_H6(dst_drq);
> > +}
> > +
> >  static void sun6i_set_mode_a31(u32 *p_cfg, s8 src_mode, s8 dst_mode)
> >  {
> >       *p_cfg |=3D DMA_CHAN_CFG_SRC_MODE_A31(src_mode) |
> >                 DMA_CHAN_CFG_DST_MODE_A31(dst_mode);
> >  }
> >
> > +static void sun6i_set_mode_h6(u32 *p_cfg, s8 src_mode, s8 dst_mode)
> > +{
> > +     *p_cfg |=3D DMA_CHAN_CFG_SRC_MODE_H6(src_mode) |
> > +               DMA_CHAN_CFG_DST_MODE_H6(dst_mode);
> > +}
> > +
> >  static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
> >  {
> >       struct sun6i_desc *txd =3D pchan->desc;
> > @@ -1160,6 +1177,28 @@ static struct sun6i_dma_config sun50i_a64_dma_cf=
g =3D {
> >                            BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> >  };
> >
> > +/*
> > + * The H6 binding uses the number of dma channels from the
> > + * device tree node.
> > + */
> > +static struct sun6i_dma_config sun50i_h6_dma_cfg =3D {
> > +     .clock_autogate_enable =3D sun6i_enable_clock_autogate_h3,
> > +     .set_burst_length =3D sun6i_set_burst_length_h3,
> > +     .set_drq          =3D sun6i_set_drq_h6,
> > +     .set_mode         =3D sun6i_set_mode_h6,
> > +     .src_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
> > +     .dst_burst_lengths =3D BIT(1) | BIT(4) | BIT(8) | BIT(16),
> > +     .src_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > +                          BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > +                          BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > +                          BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> > +     .dst_addr_widths   =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > +                          BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > +                          BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > +                          BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> > +     .has_mbus_clk =3D true,
> > +};
> > +
> >  /*
> >   * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
> >   * and a total of 24 usable source and destination endpoints.
> > @@ -1190,6 +1229,7 @@ static const struct of_device_id sun6i_dma_match[=
] =3D {
> >       { .compatible =3D "allwinner,sun8i-h3-dma", .data =3D &sun8i_h3_d=
ma_cfg },
> >       { .compatible =3D "allwinner,sun8i-v3s-dma", .data =3D &sun8i_v3s=
_dma_cfg },
> >       { .compatible =3D "allwinner,sun50i-a64-dma", .data =3D &sun50i_a=
64_dma_cfg },
> > +     { .compatible =3D "allwinner,sun50i-h6-dma", .data =3D &sun50i_h6=
_dma_cfg },
> >       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, sun6i_dma_match);
> > @@ -1288,8 +1328,8 @@ static int sun6i_dma_probe(struct platform_device=
 *pdev)
> >       ret =3D of_property_read_u32(np, "dma-requests", &sdc->max_reques=
t);
> >       if (ret && !sdc->max_request) {
> >               dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
> > -                      DMA_CHAN_MAX_DRQ_A31);
> > -             sdc->max_request =3D DMA_CHAN_MAX_DRQ_A31;
> > +                      DMA_CHAN_MAX_DRQ_H6);
> > +             sdc->max_request =3D DMA_CHAN_MAX_DRQ_H6;
>
> This is changing the binding though, since we're changing the
> default. This should be reflected in the binding, and we should keep
> the same default in the device tree binding.

Agree, H6 device-tree will have the "dma-request" property.
As this modification is not mandatory, we can drop it to avoid
bindings modification.

What do you think?

Thanks for your review,
Cl=C3=A9ment

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
