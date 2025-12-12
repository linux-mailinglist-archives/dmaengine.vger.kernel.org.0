Return-Path: <dmaengine+bounces-7587-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77705CB8E24
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18B2A305116B
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F71621FF35;
	Fri, 12 Dec 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQiTLARM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E61DDC35
	for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765545603; cv=none; b=Yo7Is7LiMjX3xVpneeuzJsuMpB5uqNNvHkcyZlh5lnFQ7eA7BTry1nMd9a9uX4nMe+6LDuKSUwremygXt9aWwfqOdU6OyVHhL0gW/HRf4mhIDZQhURK4go84Rm/yAx3Ky8kd99ggHod/scn/Nc/Cq4amX5fgSOlgQbKIdNodd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765545603; c=relaxed/simple;
	bh=y/n2HpEJXEeD2OUCVwpAOVpXqQe23MBCeXUtceU56aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYJOJ7EXwwb137cglZbyzRc1wXn6WNIi2KmRLMA4G6R12I2Rm7/ZmxP/iSzN/UJnBNUwO7wa5L8VCaMxMZz3cHRTi8pF/EANZ0GoEXr2KlOESV1lEGe7E4KQyohgh7Y9CFeapRzu99kFY3oLE0AYzWNNASB53MhmVNszHUXInLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQiTLARM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E571EC19425
	for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765545602;
	bh=y/n2HpEJXEeD2OUCVwpAOVpXqQe23MBCeXUtceU56aE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PQiTLARM1UgaA3lrisoVcXjE3DMZqjgPT9rgGqrKhXLzbJ487bGm5ZWjG5mN6lWHO
	 utAuUwuA3JihOAE+acgRTR6bltWI/3BN/sjzhC7Qw2WQFh7zmFgedj2sWwV5hZ9475
	 XHd8QC5dGiwxLx1yoFpbTvBTmdgaGb5ZicWBwaZg7BB4MeB29ySZTIVzEvO1HV4z6D
	 bvQkR8snFjblurZLhvP1W7S02P+wC7yVjASefkKGS47QfcH7/pJcljGhDc3KNejFdi
	 GhCJOJ342KC5bjEYKCdI01uog1ZJWukstOwwTq4Dm16ZMzEwn5tKCxDwq7vwp2vjAU
	 2J3SodHc4/lag==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso1841677a12.1
        for <dmaengine@vger.kernel.org>; Fri, 12 Dec 2025 05:20:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXpxjSCYflvMvrzHvnz4C+4BKKzAKUWNota+GBYexVELL+nAkcdXF8JaFySperBs3NYJdUtEHiBZU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweznuL4mOj636iys2aS56aKHL0B8wuRvnQv5mdNaEl/MezEnum
	QXfulq6ZN12o4Mec/oHsUN/vdxeAe8ON6nZqK3Ga2KIRxmVua1ov3vCXU+SWQiyveDMpOp3MaVV
	sJ9yI2SrRvzfdj/ZlrVBIfKz24FQZTA==
X-Google-Smtp-Source: AGHT+IH5efhgSFOPqgOiwqHuVybcB1pM+vtgMykwpJv7zU5eTdlwMKKp3N9YCPgC8H309zIrc1SLEg1Gef91bpLp6oE=
X-Received: by 2002:a05:6402:5194:b0:647:8d63:d8b4 with SMTP id
 4fb4d7f45d1cf-6499b10ffd2mr2004220a12.6.1765545601392; Fri, 12 Dec 2025
 05:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
 <646113c742278626c8796d8553cdb251a4daf737.1765425415.git.khairul.anuar.romli@altera.com>
 <20251211154524.GA1464056-robh@kernel.org> <CAL_JsqKPVdUzytrVKs5q5JfPnxLdz-UdN5K-cJUVQ_uWM5azLA@mail.gmail.com>
 <b4e36cd5-959b-4758-8c52-6dad7e6f17f0@altera.com>
In-Reply-To: <b4e36cd5-959b-4758-8c52-6dad7e6f17f0@altera.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 12 Dec 2025 07:19:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5yLyQ2_MEGorETtqz_EEZDRy_b+9PtBcV5ZVFG25qyg@mail.gmail.com>
X-Gm-Features: AQt7F2p6jIbY7t1hLFi5XdgYG8BFlHa57zPqUcXer1tzcZ3WhU6A9lFxHU3oiao
Message-ID: <CAL_JsqL5yLyQ2_MEGorETtqz_EEZDRy_b+9PtBcV5ZVFG25qyg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
To: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Vinod Koul <vkoul@kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 6:46=E2=80=AFPM Romli, Khairul Anuar
<khairul.anuar.romli@altera.com> wrote:
>
> On 11/12/2025 11:52 pm, Rob Herring wrote:
> > On Thu, Dec 11, 2025 at 9:45=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> >>
> >> On Thu, Dec 11, 2025 at 12:40:38PM +0800, Khairul Anuar Romli wrote:
> >>> Add device tree compatible string support for the Altera Agilex5 AXI =
DMA
> >>> controller.
> >>>
> >>> Introduces logic to parse the "dma-ranges" property and calculate the
> >>> actual number of addressable bits (bus width) for the DMA engine. Thi=
s
> >>> calculated value is then used to set the coherent mask via
> >>> 'dma_set_mask_and_coherent()', allowing the driver to correctly handl=
e
> >>> devices with bus widths less than 64 bits. The addressable bits defau=
lt to
> >>> 64 if 'dma-ranges' is not specified or cannot be parsed.
> >>>
> >>> Introduce 'addressable_bits' to 'struct axi_dma_chip' to store this v=
alue.
> >>>
> >>> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> >>> ---
> >>> Changes in v3:
> >>>        - Refactor the code to align with dma controller device node m=
ove
> >>>          to 1 level down.
> >>> Changes in v2:
> >>>        - Add driver implementation to set the DMA BIT MAST to 40 base=
d on
> >>>          dma-ranges defined in DT.
> >>>        - Add glue for driver and DT.
> >>> ---
> >>>   .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 69 ++++++++++++++++=
++-
> >>>   drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
> >>>   2 files changed, 69 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers=
/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> >>> index b23536645ff7..96b0a0842ff5 100644
> >>> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> >>> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> >>> @@ -271,7 +271,9 @@ static void axi_dma_hw_init(struct axi_dma_chip *=
chip)
> >>>                axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ=
_ALL);
> >>>                axi_chan_disable(&chip->dw->chan[i]);
> >>>        }
> >>> -     ret =3D dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
> >>> +
> >>> +     dev_dbg(chip->dev, "Adressable bus width: %u\n", chip->addressa=
ble_bits);
> >>> +     ret =3D dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(chip-=
>addressable_bits));
> >>>        if (ret)
> >>>                dev_warn(chip->dev, "Unable to set coherent mask\n");
> >>>   }
> >>> @@ -1461,13 +1463,24 @@ static int axi_req_irqs(struct platform_devic=
e *pdev, struct axi_dma_chip *chip)
> >>>        return 0;
> >>>   }
> >>>
> >>> +/* Forward declaration (no size required) */
> >>> +static const struct of_device_id dw_dma_of_id_table[];
> >>> +
> >>>   static int dw_probe(struct platform_device *pdev)
> >>>   {
> >>>        struct axi_dma_chip *chip;
> >>>        struct dw_axi_dma *dw;
> >>>        struct dw_axi_dma_hcfg *hdata;
> >>>        struct reset_control *resets;
> >>> +     struct device_node *parent;
> >>> +     const struct of_device_id *match;
> >>>        unsigned int flags;
> >>> +     unsigned int addressable_bits =3D 64;
> >>> +     unsigned int len_bytes;
> >>> +     unsigned int num_cells;
> >>> +     const __be32 *prop;
> >>> +     u64 bus_width;
> >>> +     u32 *cells;
> >>>        u32 i;
> >>>        int ret;
> >>>
> >>> @@ -1483,9 +1496,61 @@ static int dw_probe(struct platform_device *pd=
ev)
> >>>        if (!hdata)
> >>>                return -ENOMEM;
> >>>
> >>> +     match =3D of_match_node(dw_dma_of_id_table, pdev->dev.of_node);
> >>> +     if (!match) {
> >>> +             dev_err(&pdev->dev, "Unsupported AXI DMA device\n");
> >>> +             return -ENODEV;
> >>> +     }
> >>> +
> >>> +     parent =3D of_get_parent(pdev->dev.of_node);
> >>> +     if (parent) {
> >>> +             prop =3D of_get_property(parent, "dma-ranges", &len_byt=
es);
> >>> +             if (prop) {
> >>> +                     num_cells =3D len_bytes / sizeof(__be32);
> >>> +                     cells =3D kcalloc(num_cells, sizeof(*cells), GF=
P_KERNEL);
> >>> +                     if (!cells)
> >>> +                             return -ENOMEM;
> >>> +
> >>> +                     ret =3D of_property_read_u32(parent, "#address-=
cells", &i);
> >>> +                     if (ret) {
> >>> +                             dev_err(&pdev->dev, "missing #address-c=
ells property\n");
> >>> +                             return ret;
> >>> +                     }
> >>> +
> >>> +                     ret =3D of_property_read_u32(parent, "#size-cel=
ls", &i);
> >>> +                     if (ret) {
> >>> +                             dev_err(&pdev->dev, "missing #size-cell=
s property\n");
> >>> +                             return ret;
> >>> +                     }
> >>> +
> >>> +                     if (!of_property_read_u32_array(parent, "dma-ra=
nges",
> >>> +                                                     cells, num_cell=
s)) {
> >>
> >> We have common code to parse dma-ranges. Use it and don't implement yo=
ur
> >> own.
> >
> > Actually, the driver and DT core should take care of all this for you
> > and there's nothing to do in the driver. A driver only needs to set
> > the mask for the IP itself and only when >32 bits. The core takes care
> > of any additional restrictions in the bus.
> >
> > Rob
>
> The current implementation explicitly set the mask to 64.
>
> -     ret =3D dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
>
> Will the core re-set the mask based on the dma-ranges on DT?

I don't think it changes the mask, but there's also bus ranges which
get factored in. See struct device.bus_dma_limit and dma_range_map.

Rob

