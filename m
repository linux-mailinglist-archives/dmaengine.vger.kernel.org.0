Return-Path: <dmaengine+bounces-7572-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7447BCB661D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 16:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FF3E30047AA
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 15:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E133126CD;
	Thu, 11 Dec 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYDta1db"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50725156C6A
	for <dmaengine@vger.kernel.org>; Thu, 11 Dec 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468382; cv=none; b=kBQnbv9GQBFvDP2c0uUIIkW6wdKqPqvoIXwPvOOIk6JScVa6500hdCUkcBeSWwSFmUEGC2lDFZ/w4hMC4R/9mF2xZvPoSrYaqkYxaU0RUZRRH9qPnwNZnVISMGiUxMejQ4kBNT83Af4nUemMDRByvwo45oOp9q8YOKVyPh/6EOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468382; c=relaxed/simple;
	bh=43oQHhviobLbuJzUeQNXIA1N7DVa5CO6dZDCJTWeLFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaaNgAGkOfu++txfsBn2u+R3QVFsv845HN50CYoNoqlnf0bBZOJCqrj7yR3p3AoiB76xTx8uzN2OApuEUz3DLSHLhUGMIE6mM9VZhDrQqVq4x62KlItbKVNlCIB5K6CAhm46EYbT8xiefuXE7Sn2GYgW2u3BsZ6XC3jlVvHLXtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYDta1db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3014AC4CEFB
	for <dmaengine@vger.kernel.org>; Thu, 11 Dec 2025 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765468382;
	bh=43oQHhviobLbuJzUeQNXIA1N7DVa5CO6dZDCJTWeLFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TYDta1db9NQ5Jq3HgvyxVjw/cRx/kANLLXqIx9PZxriLb6/yTNd1OYUpirI446V/M
	 /VBZTMQKc1QB4KD/eLgjd8ahDO4+o//4T04ZJGVbI7ElF+MG7slVQX64TAzOOoSyrL
	 /8GZspzCEnGhRJBHZP2XxrEaaSb/YMs2x+5C165o7gXlYWJzOt8Gb5PbBAmrPlnRuS
	 oIViPqbt8ljCdHL/eZtf4S7B2yFo6dDSpOTv7ci6Di+hkeCxODrOXi6S3GwFnJ6lyI
	 0KI3ZfVXJHY+Tbp7NuacCLYPqORzHeWNyp4hMHwrEWF0hqxCN0+F9astULXWwCFYue
	 eAm0ODhlOTXig==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b736d883ac4so49047066b.2
        for <dmaengine@vger.kernel.org>; Thu, 11 Dec 2025 07:53:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhj5Y+Fj7ddwao5YN7t+XTXQVynkqL4FJ5QFmUaBwLwmszLknhtcJdXZKSobUL9KJXUQDHtRSaN78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbltgU++ixYUqjCidC57Dv7olK6oykxzpilCInjRb43PmrIjH
	ICLv0W6PuPbKdrcAbJOhSRmxcA3GlP4qQ/8LXNTnTUGXe3Odmt8hNDvd9HtUm3/spHmXU+vDuyx
	4NeMwEolGEE4VSWWDpYdA8lKaZ90gjw==
X-Google-Smtp-Source: AGHT+IFJ3g666htWqEndKctbrWpy/01G3SdXysFNEVv2nDCyXoKOSlxH2PYVjhC2GpLkUL5rwqP0HWeU398qZ0IAq0A=
X-Received: by 2002:a17:907:7f87:b0:b79:f965:1cd4 with SMTP id
 a640c23a62f3a-b7ce849cddbmr697773166b.55.1765468380661; Thu, 11 Dec 2025
 07:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
 <646113c742278626c8796d8553cdb251a4daf737.1765425415.git.khairul.anuar.romli@altera.com>
 <20251211154524.GA1464056-robh@kernel.org>
In-Reply-To: <20251211154524.GA1464056-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Dec 2025 09:52:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKPVdUzytrVKs5q5JfPnxLdz-UdN5K-cJUVQ_uWM5azLA@mail.gmail.com>
X-Gm-Features: AQt7F2qrs-yisR7VWXX9c31neaBZK_0G7Wogq5M9310Wh9UV5qyN0yFCeMgQdPI
Message-ID: <CAL_JsqKPVdUzytrVKs5q5JfPnxLdz-UdN5K-cJUVQ_uWM5azLA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 9:45=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Dec 11, 2025 at 12:40:38PM +0800, Khairul Anuar Romli wrote:
> > Add device tree compatible string support for the Altera Agilex5 AXI DM=
A
> > controller.
> >
> > Introduces logic to parse the "dma-ranges" property and calculate the
> > actual number of addressable bits (bus width) for the DMA engine. This
> > calculated value is then used to set the coherent mask via
> > 'dma_set_mask_and_coherent()', allowing the driver to correctly handle
> > devices with bus widths less than 64 bits. The addressable bits default=
 to
> > 64 if 'dma-ranges' is not specified or cannot be parsed.
> >
> > Introduce 'addressable_bits' to 'struct axi_dma_chip' to store this val=
ue.
> >
> > Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > ---
> > Changes in v3:
> >       - Refactor the code to align with dma controller device node move
> >         to 1 level down.
> > Changes in v2:
> >       - Add driver implementation to set the DMA BIT MAST to 40 based o=
n
> >         dma-ranges defined in DT.
> >       - Add glue for driver and DT.
> > ---
> >  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 69 ++++++++++++++++++-
> >  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
> >  2 files changed, 69 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/d=
ma/dw-axi-dmac/dw-axi-dmac-platform.c
> > index b23536645ff7..96b0a0842ff5 100644
> > --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> > @@ -271,7 +271,9 @@ static void axi_dma_hw_init(struct axi_dma_chip *ch=
ip)
> >               axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_AL=
L);
> >               axi_chan_disable(&chip->dw->chan[i]);
> >       }
> > -     ret =3D dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
> > +
> > +     dev_dbg(chip->dev, "Adressable bus width: %u\n", chip->addressabl=
e_bits);
> > +     ret =3D dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(chip->a=
ddressable_bits));
> >       if (ret)
> >               dev_warn(chip->dev, "Unable to set coherent mask\n");
> >  }
> > @@ -1461,13 +1463,24 @@ static int axi_req_irqs(struct platform_device =
*pdev, struct axi_dma_chip *chip)
> >       return 0;
> >  }
> >
> > +/* Forward declaration (no size required) */
> > +static const struct of_device_id dw_dma_of_id_table[];
> > +
> >  static int dw_probe(struct platform_device *pdev)
> >  {
> >       struct axi_dma_chip *chip;
> >       struct dw_axi_dma *dw;
> >       struct dw_axi_dma_hcfg *hdata;
> >       struct reset_control *resets;
> > +     struct device_node *parent;
> > +     const struct of_device_id *match;
> >       unsigned int flags;
> > +     unsigned int addressable_bits =3D 64;
> > +     unsigned int len_bytes;
> > +     unsigned int num_cells;
> > +     const __be32 *prop;
> > +     u64 bus_width;
> > +     u32 *cells;
> >       u32 i;
> >       int ret;
> >
> > @@ -1483,9 +1496,61 @@ static int dw_probe(struct platform_device *pdev=
)
> >       if (!hdata)
> >               return -ENOMEM;
> >
> > +     match =3D of_match_node(dw_dma_of_id_table, pdev->dev.of_node);
> > +     if (!match) {
> > +             dev_err(&pdev->dev, "Unsupported AXI DMA device\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     parent =3D of_get_parent(pdev->dev.of_node);
> > +     if (parent) {
> > +             prop =3D of_get_property(parent, "dma-ranges", &len_bytes=
);
> > +             if (prop) {
> > +                     num_cells =3D len_bytes / sizeof(__be32);
> > +                     cells =3D kcalloc(num_cells, sizeof(*cells), GFP_=
KERNEL);
> > +                     if (!cells)
> > +                             return -ENOMEM;
> > +
> > +                     ret =3D of_property_read_u32(parent, "#address-ce=
lls", &i);
> > +                     if (ret) {
> > +                             dev_err(&pdev->dev, "missing #address-cel=
ls property\n");
> > +                             return ret;
> > +                     }
> > +
> > +                     ret =3D of_property_read_u32(parent, "#size-cells=
", &i);
> > +                     if (ret) {
> > +                             dev_err(&pdev->dev, "missing #size-cells =
property\n");
> > +                             return ret;
> > +                     }
> > +
> > +                     if (!of_property_read_u32_array(parent, "dma-rang=
es",
> > +                                                     cells, num_cells)=
) {
>
> We have common code to parse dma-ranges. Use it and don't implement your
> own.

Actually, the driver and DT core should take care of all this for you
and there's nothing to do in the driver. A driver only needs to set
the mask for the IP itself and only when >32 bits. The core takes care
of any additional restrictions in the bus.

Rob

