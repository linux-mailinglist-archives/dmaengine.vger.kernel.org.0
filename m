Return-Path: <dmaengine+bounces-9129-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hy2HuEBoGmBfQQAu9opvQ
	(envelope-from <dmaengine+bounces-9129-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 09:18:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF71A269A
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 09:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31733301B791
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE783815E1;
	Thu, 26 Feb 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTlEx/3H"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983703115BC
	for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 08:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093917; cv=none; b=QgBm/uTj3AqollLV0kbzi3zbU2n4UsZ3KoJC65kZfSKk65Q2weDYwy3KpZXpTPL/vH4E8DJIeNqJtsZ6CKcthhM4hrRvfAoSezV9QdhfYlBD99yHOoBK3KxZ6NeAQfLtfcwc1BhqdA5N5jBZXXO0EZe+bCC4m7ikrJbIzhePyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093917; c=relaxed/simple;
	bh=5zVye/GndptANk1AakkXOj/Vbc+VoAATog75It51PEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMSXj6U/lTse1PE70GmdZgRaglChoZ6CXD/ughSSoUXNYPzMyifj2is/qdR4T3UEx74SS7wLBU47XR4CC5QkDFXeD+RRvStyJE3OrPKeVyAIzyGmC3z8Y8hD0E5dCgo5SgNK47N98AlkvNgypcOxAbLnZOYAYzijBW2OcwtEyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTlEx/3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F882C19422
	for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 08:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772093917;
	bh=5zVye/GndptANk1AakkXOj/Vbc+VoAATog75It51PEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CTlEx/3HSRQDoVm4gpC0+gcje0+9yW7Q3B6tj2QD2tz+jKgT5KCCt13jHQABA5fp0
	 i0SIaHRGjdtSLfmQPqJ0tVpPfpCvt2oUvKEIC+7CeT92ztDLolYMc7uaJe9MCZZ/6W
	 5zf0Ld4NU25pITI66mlamBE4HSU/y5aRqcXknRudGWDt0fXi4ZlIw2z8Yx8cL4lm4n
	 0HseZZ0Od/oyBh4gFjihdgGhuqcdPQRYOWu9FEWqkrLcZUlPrNw0JPWYs0/FNBpYYF
	 yk+44F4S+0ij4swUyzOVt9QYjW+cdcAd10ckdZckzcvheEUEtOerTI69K6cuif/Jcj
	 Oj0FL0EgaqP9w==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so88835666b.2
        for <dmaengine@vger.kernel.org>; Thu, 26 Feb 2026 00:18:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNUMyNUAwrmxPdo/6KCLQpqOeK+dEc9L0duSWsd5Z+l/xLmjy33k5Mfe4QCF7bB9h1Qed0oQFA83s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxamatEO7XI/OFzD5O8aZH1uP4NByRIVmcxsMNvWG0Npsj5+o
	9LhtDUPshaH+cBcK+JcPp/zsuTDzgHEZkmMC7+/oJbr0d3Wrp9vNILpoPhjsKrKbJRMd4OdAzJ3
	ZJ7w+iaTfcNRwa9seWFYeEW1vmAAtLtk=
X-Received: by 2002:a17:906:f59a:b0:b8f:8660:3caf with SMTP id
 a640c23a62f3a-b935b4a4f6dmr91218166b.5.1772093915571; Thu, 26 Feb 2026
 00:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1771989595.git.zhoubinbin@loongson.cn> <408551399f089d10e2ebc2c0add5ba58d659a1b9.1771989596.git.zhoubinbin@loongson.cn>
In-Reply-To: <408551399f089d10e2ebc2c0add5ba58d659a1b9.1771989596.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Feb 2026 16:18:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6G6Zb7P8OpoM78FkfSW2HeLt+9xfbJyU21tdbUa8A=Ww@mail.gmail.com>
X-Gm-Features: AaiRm51_gg9K5ARD0rTDrhgpF1C8d7J0ntxYYnEWeKw_zXxkMC3XbohS-WQL_gk
Message-ID: <CAAhV-H6G6Zb7P8OpoM78FkfSW2HeLt+9xfbJyU21tdbUa8A=Ww@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	Keguang Zhang <keguang.zhang@gmail.com>, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9129-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1DAF71A269A
X-Rspamd-Action: no action

Hi, Binbin,

On Wed, Feb 25, 2026 at 3:41=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> This DMA controller appears in Loongson-2K0300 and Loongson-2K3000.
>
> It is a chain multi-channel controller that enables data transfers from
> memory to memory, device to memory, and memory to device, as well as
> channel prioritization configurable through the channel configuration
> registers.
>
> In addition, there are slight differences between Loongson-2K0300 and
> Loongson-2K3000, such as channel register offsets and the number of
> channels.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/dma/loongson/Kconfig                 |  10 +
>  drivers/dma/loongson/Makefile                |   1 +
>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 729 +++++++++++++++++++
>  4 files changed, 741 insertions(+)
>  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aea29c28d865..af9fbb3b43e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14954,6 +14954,7 @@ L:      dmaengine@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
>  F:     Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> +F:     drivers/dma/loongson/loongson2-apb-cmc-dma.c
>  F:     drivers/dma/loongson/loongson2-apb-dma.c
>
>  LOONGSON LS2X I2C DRIVER
> diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> index 9dbdaef5a59f..4278fbbe8096 100644
> --- a/drivers/dma/loongson/Kconfig
> +++ b/drivers/dma/loongson/Kconfig
> @@ -12,6 +12,16 @@ config LOONGSON1_APB_DMA
>           This selects support for the APB DMA controller in Loongson1 So=
Cs,
>           which is required by Loongson1 NAND and audio support.
>
> +config LOONGSON2_APB_CMC_DMA
> +       tristate "Loongson2 Chain Multi-Channel DMA support"
> +       select DMA_ENGINE
> +       select DMA_VIRTUAL_CHANNELS
> +       help
> +         Support for the Loongson Chain Multi-Channel DMA controller dri=
ver.
> +         It is discovered on the Loongson-2K chip (Loongson-2K0300/Loong=
son-2K3000),
> +         which has 4/8 channels internally, enabling bidirectional data =
transfer
> +         between devices and memory.
Moving this to after LOONGSON2_APB_DMA is a little better.

> +
>  config LOONGSON2_APB_DMA
>         tristate "Loongson2 APB DMA support"
>         select DMA_ENGINE
> diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefil=
e
> index 6cdd08065e92..9abe75b91e17 100644
> --- a/drivers/dma/loongson/Makefile
> +++ b/drivers/dma/loongson/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_LOONGSON1_APB_DMA) +=3D loongson1-apb-dma.o
> +obj-$(CONFIG_LOONGSON2_APB_CMC_DMA) +=3D loongson2-apb-cmc-dma.o
>  obj-$(CONFIG_LOONGSON2_APB_DMA) +=3D loongson2-apb-dma.o
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/l=
oongson/loongson2-apb-cmc-dma.c
> new file mode 100644
> index 000000000000..6aa064cb5da4
> --- /dev/null
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -0,0 +1,729 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Looongson-2 Chain Multi-Channel DMA Controller driver
> + *
> + * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_dma.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +
> +#define LOONGSON2_CMCDMA_ISR           0x0     /* DMA Interrupt Status R=
egister */
> +#define LOONGSON2_CMCDMA_IFCR          0x4     /* DMA Interrupt Flag Cle=
ar Register */
> +#define LOONGSON2_CMCDMA_CCR           0x8     /* DMA Channel Configurat=
ion Register */
> +#define LOONGSON2_CMCDMA_CNDTR         0xc     /* DMA Channel Transmit C=
ount Register */
> +#define LOONGSON2_CMCDMA_CPAR          0x10    /* DMA Channel Peripheral=
 Address Register */
> +#define LOONGSON2_CMCDMA_CMAR          0x14    /* DMA Channel Memory Add=
ress Register */
> +
> +/* Bitfields of DMA interrupt status register */
> +#define LOONGSON2_CMCDMA_TCI           BIT(1) /* Transfer Complete Inter=
rupt */
> +#define LOONGSON2_CMCDMA_HTI           BIT(2) /* Half Transfer Interrupt=
 */
> +#define LOONGSON2_CMCDMA_TEI           BIT(3) /* Transfer Error Interrup=
t */
> +
> +#define LOONGSON2_CMCDMA_MASKI         \
> +       (LOONGSON2_CMCDMA_TCI | LOONGSON2_CMCDMA_HTI | LOONGSON2_CMCDMA_T=
EI)
> +
> +/* Bitfields of DMA channel x Configuration Register */
> +#define LOONGSON2_CMCDMA_CCR_EN                BIT(0) /* Stream Enable *=
/
> +#define LOONGSON2_CMCDMA_CCR_TCIE      BIT(1) /* Transfer Complete Inter=
rupt Enable */
> +#define LOONGSON2_CMCDMA_CCR_HTIE      BIT(2) /* Half Transfer Complete =
Interrupt Enable */
> +#define LOONGSON2_CMCDMA_CCR_TEIE      BIT(3) /* Transfer Error Interrup=
t Enable */
> +#define LOONGSON2_CMCDMA_CCR_DIR       BIT(4) /* Data Transfer Direction=
 */
> +#define LOONGSON2_CMCDMA_CCR_CIRC      BIT(5) /* Circular mode */
> +#define LOONGSON2_CMCDMA_CCR_PINC      BIT(6) /* Peripheral increment mo=
de */
> +#define LOONGSON2_CMCDMA_CCR_MINC      BIT(7) /* Memory increment mode *=
/
> +#define LOONGSON2_CMCDMA_CCR_PSIZE_MASK        GENMASK(9, 8)
> +#define LOONGSON2_CMCDMA_CCR_MSIZE_MASK        GENMASK(11, 10)
> +#define LOONGSON2_CMCDMA_CCR_PL_MASK   GENMASK(13, 12)
> +#define LOONGSON2_CMCDMA_CCR_M2M       BIT(14)
> +
> +#define LOONGSON2_CMCDMA_CCR_CFG_MASK  \
> +       (LOONGSON2_CMCDMA_CCR_PINC | LOONGSON2_CMCDMA_CCR_MINC | LOONGSON=
2_CMCDMA_CCR_PL_MASK)
> +
> +#define LOONGSON2_CMCDMA_CCR_IRQ_MASK  \
> +       (LOONGSON2_CMCDMA_CCR_TCIE | LOONGSON2_CMCDMA_CCR_HTIE | LOONGSON=
2_CMCDMA_CCR_TEIE)
> +
> +#define LOONGSON2_CMCDMA_STREAM_MASK   \
> +       (LOONGSON2_CMCDMA_CCR_CFG_MASK | LOONGSON2_CMCDMA_CCR_IRQ_MASK)
> +
> +#define LOONGSON2_CMCDMA_BUSWIDTHS     (BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |=
 \
> +                                        BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) =
| \
> +                                        BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
> +
> +#define LOONSON2_CMCDMA_MAX_DATA_ITEMS SZ_64K
> +
> +struct loongson2_cmc_dma_chan_reg {
> +       u32 ccr;
> +       u32 cndtr;
> +       u32 cpar;
> +       u32 cmar;
> +};
> +
> +struct loongson2_cmc_dma_sg_req {
> +       u32 len;
> +       struct loongson2_cmc_dma_chan_reg chan_reg;
> +};
> +
> +struct loongson2_cmc_dma_desc {
> +       struct virt_dma_desc vdesc;
> +       bool cyclic;
> +       u32 num_sgs;
> +       struct loongson2_cmc_dma_sg_req sg_req[] __counted_by(num_sgs);
> +};
> +
> +struct loongson2_cmc_dma_chan {
> +       struct virt_dma_chan vchan;
> +       struct dma_slave_config dma_sconfig;
> +       struct loongson2_cmc_dma_desc *desc;
> +       u32 id;
> +       u32 irq;
> +       u32 next_sg;
> +       struct loongson2_cmc_dma_chan_reg chan_reg;
> +};
> +
> +struct loongson2_cmc_dma_config {
> +       u32 max_channels;
> +       u32 chan_reg_offset;
> +};
Moving loongson2_cmc_dma_config to after loongson2_cmc_dma_dev is a
little better, because it will close to its users.

Huacai

> +
> +struct loongson2_cmc_dma_dev {
> +       struct dma_device ddev;
> +       struct clk *dma_clk;
> +       void __iomem *base;
> +       u32 nr_channels;
> +       u32 chan_reg_offset;
> +       struct loongson2_cmc_dma_chan chan[] __counted_by(nr_channels);
> +};
> +
> +static const struct loongson2_cmc_dma_config ls2k0300_cmc_dma_config =3D=
 {
> +       .max_channels =3D 8,
> +       .chan_reg_offset =3D 0x14,
> +};
> +
> +static const struct loongson2_cmc_dma_config ls2k3000_cmc_dma_config =3D=
 {
> +       .max_channels =3D 4,
> +       .chan_reg_offset =3D 0x18,
> +};
> +
> +static struct loongson2_cmc_dma_dev *lmdma_get_dev(struct loongson2_cmc_=
dma_chan *lchan)
> +{
> +       return container_of(lchan->vchan.chan.device, struct loongson2_cm=
c_dma_dev, ddev);
> +}
> +
> +static struct loongson2_cmc_dma_chan *to_lmdma_chan(struct dma_chan *cha=
n)
> +{
> +       return container_of(chan, struct loongson2_cmc_dma_chan, vchan.ch=
an);
> +}
> +
> +static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_dma_desc=
 *vdesc)
> +{
> +       return container_of(vdesc, struct loongson2_cmc_dma_desc, vdesc);
> +}
> +
> +static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
> +{
> +       return &lchan->vchan.chan.dev->device;
> +}
> +
> +static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *lddev, u=
32 reg, u32 id)
> +{
> +       return readl(lddev->base + (reg + lddev->chan_reg_offset * id));
> +}
> +
> +static void loongson2_cmc_dma_write(struct loongson2_cmc_dma_dev *lddev,=
 u32 reg, u32 id, u32 val)
> +{
> +       writel(val, lddev->base + (reg + lddev->chan_reg_offset * id));
> +}
> +
> +static int loongson2_cmc_dma_get_width(enum dma_slave_buswidth width)
> +{
> +       switch (width) {
> +       case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +       case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +       case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +               return ffs(width) - 1;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int loongson2_cmc_dma_slave_config(struct dma_chan *chan, struct =
dma_slave_config *config)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> +
> +       memcpy(&lchan->dma_sconfig, config, sizeof(*config));
> +
> +       return 0;
> +}
> +
> +static void loongson2_cmc_dma_irq_clear(struct loongson2_cmc_dma_chan *l=
chan, u32 flags)
> +{
> +       struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> +       u32 ifcr;
> +
> +       ifcr =3D flags << (4 * lchan->id);
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_IFCR, 0, ifcr);
> +}
> +
> +static void loongson2_cmc_dma_stop(struct loongson2_cmc_dma_chan *lchan)
> +{
> +       struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> +       u32 ccr;
> +
> +       ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan=
->id);
> +       ccr &=3D ~(LOONGSON2_CMCDMA_CCR_IRQ_MASK | LOONGSON2_CMCDMA_CCR_E=
N);
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, c=
cr);
> +
> +       loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_MASKI);
> +}
> +
> +static int loongson2_cmc_dma_terminate_all(struct dma_chan *chan)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> +
> +       LIST_HEAD(head);
> +
> +       scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
> +               if (lchan->desc) {
> +                       vchan_terminate_vdesc(&lchan->desc->vdesc);
> +                       loongson2_cmc_dma_stop(lchan);
> +                       lchan->desc =3D NULL;
> +               }
> +               vchan_get_all_descriptors(&lchan->vchan, &head);
> +       }
> +
> +       vchan_dma_desc_free_list(&lchan->vchan, &head);
> +
> +       return 0;
> +}
> +
> +static void loongson2_cmc_dma_synchronize(struct dma_chan *chan)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> +
> +       vchan_synchronize(&lchan->vchan);
> +}
> +
> +static void loongson2_cmc_dma_start_transfer(struct loongson2_cmc_dma_ch=
an *lchan)
> +{
> +       struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> +       struct loongson2_cmc_dma_sg_req *sg_req;
> +       struct loongson2_cmc_dma_chan_reg *reg;
> +       struct virt_dma_desc *vdesc;
> +
> +       loongson2_cmc_dma_stop(lchan);
> +
> +       if (!lchan->desc) {
> +               vdesc =3D vchan_next_desc(&lchan->vchan);
> +               if (!vdesc)
> +                       return;
> +
> +               list_del(&vdesc->node);
> +               lchan->desc =3D to_lmdma_desc(vdesc);
> +               lchan->next_sg =3D 0;
> +       }
> +
> +       if (lchan->next_sg =3D=3D lchan->desc->num_sgs)
> +               lchan->next_sg =3D 0;
> +
> +       sg_req =3D &lchan->desc->sg_req[lchan->next_sg];
> +       reg =3D &sg_req->chan_reg;
> +
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, r=
eg->ccr);
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id,=
 reg->cndtr);
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CPAR, lchan->id, =
reg->cpar);
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, lchan->id, =
reg->cmar);
> +
> +       lchan->next_sg++;
> +
> +       /* Start DMA */
> +       reg->ccr |=3D LOONGSON2_CMCDMA_CCR_EN;
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, r=
eg->ccr);
> +}
> +
> +static void loongson2_cmc_dma_configure_next_sg(struct loongson2_cmc_dma=
_chan *lchan)
> +{
> +       struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> +       struct loongson2_cmc_dma_sg_req *sg_req;
> +       u32 ccr, id =3D lchan->id;
> +
> +       if (lchan->next_sg =3D=3D lchan->desc->num_sgs)
> +               lchan->next_sg =3D 0;
> +
> +       /* Stop to update mem addr */
> +       ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, id);
> +       ccr &=3D ~LOONGSON2_CMCDMA_CCR_EN;
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
> +
> +       sg_req =3D &lchan->desc->sg_req[lchan->next_sg];
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req-=
>chan_reg.cmar);
> +
> +       /* Start transition */
> +       ccr |=3D LOONGSON2_CMCDMA_CCR_EN;
> +       loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
> +}
> +
> +static void loongson2_cmc_dma_handle_chan_done(struct loongson2_cmc_dma_=
chan *lchan)
> +{
> +       if (!lchan->desc)
> +               return;
> +
> +       if (lchan->desc->cyclic) {
> +               vchan_cyclic_callback(&lchan->desc->vdesc);
> +               /* LOONGSON2_CMCDMA_CCR_CIRC mode don't need update regis=
ter */
> +               if (lchan->desc->num_sgs =3D=3D 1)
> +                       return;
> +               loongson2_cmc_dma_configure_next_sg(lchan);
> +               lchan->next_sg++;
> +       } else {
> +               if (lchan->next_sg =3D=3D lchan->desc->num_sgs) {
> +                       vchan_cookie_complete(&lchan->desc->vdesc);
> +                       lchan->desc =3D NULL;
> +               }
> +               loongson2_cmc_dma_start_transfer(lchan);
> +       }
> +}
> +
> +static irqreturn_t loongson2_cmc_dma_chan_irq(int irq, void *devid)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D devid;
> +       struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> +       struct device *dev =3D chan2dev(lchan);
> +       u32 ists, status, ccr;
> +
> +       scoped_guard(spinlock, &lchan->vchan.lock) {
> +               ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CC=
R, lchan->id);
> +               ists =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_I=
SR, 0);
> +               status =3D (ists >> (4 * lchan->id)) & LOONGSON2_CMCDMA_M=
ASKI;
> +
> +               loongson2_cmc_dma_irq_clear(lchan, status);
> +
> +               if (status & LOONGSON2_CMCDMA_TCI) {
> +                       loongson2_cmc_dma_handle_chan_done(lchan);
> +                       status &=3D ~LOONGSON2_CMCDMA_TCI;
> +               }
> +
> +               if (status & LOONGSON2_CMCDMA_HTI)
> +                       status &=3D ~LOONGSON2_CMCDMA_HTI;
> +
> +               if (status & LOONGSON2_CMCDMA_TEI) {
> +                       dev_err(dev, "DMA Transform Error.\n");
> +                       if (!(ccr & LOONGSON2_CMCDMA_CCR_EN))
> +                               dev_err(dev, "Channel disabled by HW.\n")=
;
> +               }
> +       }
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void loongson2_cmc_dma_issue_pending(struct dma_chan *chan)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> +
> +       guard(spinlock_irqsave)(&lchan->vchan.lock);
> +
> +       if (vchan_issue_pending(&lchan->vchan) && !lchan->desc) {
> +               dev_dbg(chan2dev(lchan), "vchan %pK: issued\n", &lchan->v=
chan);
> +               loongson2_cmc_dma_start_transfer(lchan);
> +       }
> +}
> +
> +static int loongson2_cmc_dma_set_xfer_param(struct loongson2_cmc_dma_cha=
n *lchan,
> +                                           enum dma_transfer_direction d=
irection,
> +                                           enum dma_slave_buswidth *busw=
idth, u32 buf_len)
> +{
> +       struct dma_slave_config sconfig =3D lchan->dma_sconfig;
> +       struct device *dev =3D chan2dev(lchan);
> +       int dev_width;
> +       u32 ccr;
> +
> +       switch (direction) {
> +       case DMA_MEM_TO_DEV:
> +               dev_width =3D loongson2_cmc_dma_get_width(sconfig.dst_add=
r_width);
> +               if (dev_width < 0) {
> +                       dev_err(dev, "DMA_MEM_TO_DEV bus width not suppor=
ted\n");
> +                       return dev_width;
> +               }
> +               lchan->chan_reg.cpar =3D sconfig.dst_addr;
> +               ccr =3D LOONGSON2_CMCDMA_CCR_DIR;
> +               *buswidth =3D sconfig.dst_addr_width;
> +               break;
> +       case DMA_DEV_TO_MEM:
> +               dev_width =3D loongson2_cmc_dma_get_width(sconfig.src_add=
r_width);
> +               if (dev_width < 0) {
> +                       dev_err(dev, "DMA_DEV_TO_MEM bus width not suppor=
ted\n");
> +                       return dev_width;
> +               }
> +               lchan->chan_reg.cpar =3D sconfig.src_addr;
> +               ccr =3D LOONGSON2_CMCDMA_CCR_MINC;
> +               *buswidth =3D sconfig.src_addr_width;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ccr |=3D FIELD_PREP(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, dev_width) |
> +              FIELD_PREP(LOONGSON2_CMCDMA_CCR_MSIZE_MASK, dev_width);
> +
> +       /* Set DMA control register */
> +       lchan->chan_reg.ccr &=3D ~(LOONGSON2_CMCDMA_CCR_PSIZE_MASK | LOON=
GSON2_CMCDMA_CCR_MSIZE_MASK);
> +       lchan->chan_reg.ccr |=3D ccr;
> +
> +       return 0;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlis=
t *sgl, u32 sg_len,
> +                               enum dma_transfer_direction direction,
> +                               unsigned long flags, void *context)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> +       struct loongson2_cmc_dma_desc *desc;
> +       enum dma_slave_buswidth buswidth;
> +       struct scatterlist *sg;
> +       u32 num_items, i;
> +       int ret;
> +
> +       desc =3D kzalloc_flex(*desc, sg_req, sg_len, GFP_NOWAIT);
> +       if (!desc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for_each_sg(sgl, sg, sg_len, i) {
> +               ret =3D loongson2_cmc_dma_set_xfer_param(lchan, direction=
, &buswidth, sg_dma_len(sg));
> +               if (ret)
> +                       return ERR_PTR(ret);
> +
> +               num_items =3D DIV_ROUND_UP(sg_dma_len(sg), buswidth);
> +               if (num_items >=3D LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
> +                       dev_err(chan2dev(lchan), "Number of items not sup=
ported\n");
> +                       kfree(desc);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +
> +               desc->sg_req[i].len =3D sg_dma_len(sg);
> +               desc->sg_req[i].chan_reg.ccr =3D lchan->chan_reg.ccr;
> +               desc->sg_req[i].chan_reg.cpar =3D lchan->chan_reg.cpar;
> +               desc->sg_req[i].chan_reg.cmar =3D sg_dma_address(sg);
> +               desc->sg_req[i].chan_reg.cndtr =3D num_items;
> +       }
> +
> +       desc->num_sgs =3D sg_len;
> +       desc->cyclic =3D false;
> +
> +       return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_=
addr, size_t buf_len,
> +                                 size_t period_len, enum dma_transfer_di=
rection direction,
> +                                 unsigned long flags)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> +       struct loongson2_cmc_dma_desc *desc;
> +       enum dma_slave_buswidth buswidth;
> +       u32 num_periods, num_items, i;
> +       int ret;
> +
> +       if (unlikely(buf_len % period_len))
> +               return ERR_PTR(-EINVAL);
> +
> +       ret =3D loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswi=
dth, period_len);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       num_items =3D DIV_ROUND_UP(period_len, buswidth);
> +       if (num_items >=3D LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
> +               dev_err(chan2dev(lchan), "Number of items not supported\n=
");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       /* Enable Circular mode */
> +       if (buf_len =3D=3D period_len)
> +               lchan->chan_reg.ccr |=3D LOONGSON2_CMCDMA_CCR_CIRC;
> +
> +       num_periods =3D DIV_ROUND_UP(buf_len, period_len);
> +       desc =3D kzalloc_flex(*desc, sg_req, num_periods, GFP_NOWAIT);
> +       if (!desc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i =3D 0; i < num_periods; i++) {
> +               desc->sg_req[i].len =3D period_len;
> +               desc->sg_req[i].chan_reg.ccr =3D lchan->chan_reg.ccr;
> +               desc->sg_req[i].chan_reg.cpar =3D lchan->chan_reg.cpar;
> +               desc->sg_req[i].chan_reg.cmar =3D buf_addr;
> +               desc->sg_req[i].chan_reg.cndtr =3D num_items;
> +               buf_addr +=3D period_len;
> +       }
> +
> +       desc->num_sgs =3D num_periods;
> +       desc->cyclic =3D true;
> +
> +       return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> +}
> +
> +static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_ch=
an *lchan,
> +                                            struct loongson2_cmc_dma_des=
c *desc, u32 next_sg)
> +{
> +       struct loongson2_cmc_dma_dev *lddev =3D lmdma_get_dev(lchan);
> +       u32 residue, width, ndtr, ccr, i;
> +
> +       ccr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan=
->id);
> +       width =3D FIELD_GET(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, ccr);
> +
> +       ndtr =3D loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lc=
han->id);
> +       residue =3D ndtr << width;
> +
> +       if (lchan->desc->cyclic && next_sg =3D=3D 0)
> +               return residue;
> +
> +       for (i =3D next_sg; i < desc->num_sgs; i++)
> +               residue +=3D desc->sg_req[i].len;
> +
> +       return residue;
> +}
> +
> +static enum dma_status loongson2_cmc_dma_tx_status(struct dma_chan *chan=
, dma_cookie_t cookie,
> +                                                  struct dma_tx_state *s=
tate)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> +       struct virt_dma_desc *vdesc;
> +       enum dma_status status;
> +
> +       status =3D dma_cookie_status(chan, cookie, state);
> +       if (status =3D=3D DMA_COMPLETE || !state)
> +               return status;
> +
> +       scoped_guard(spinlock_irqsave, &lchan->vchan.lock) {
> +               vdesc =3D vchan_find_desc(&lchan->vchan, cookie);
> +               if (lchan->desc && cookie =3D=3D lchan->desc->vdesc.tx.co=
okie)
> +                       state->residue =3D loongson2_cmc_dma_desc_residue=
(lchan, lchan->desc,
> +                                                                       l=
chan->next_sg);
> +               else if (vdesc)
> +                       state->residue =3D loongson2_cmc_dma_desc_residue=
(lchan,
> +                                                                       t=
o_lmdma_desc(vdesc), 0);
> +       }
> +
> +       return status;
> +}
> +
> +static void loongson2_cmc_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +       vchan_free_chan_resources(to_virt_chan(chan));
> +}
> +
> +static void loongson2_cmc_dma_desc_free(struct virt_dma_desc *vdesc)
> +{
> +       kfree(to_lmdma_desc(vdesc));
> +}
> +
> +static bool loongson2_cmc_dma_acpi_filter(struct dma_chan *chan, void *p=
aram)
> +{
> +       struct loongson2_cmc_dma_chan *lchan =3D to_lmdma_chan(chan);
> +       struct acpi_dma_spec *dma_spec =3D param;
> +
> +       memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_=
reg));
> +       lchan->chan_reg.ccr =3D dma_spec->chan_id & LOONGSON2_CMCDMA_STRE=
AM_MASK;
> +
> +       return true;
> +}
> +
> +static int loongson2_cmc_dma_acpi_controller_register(struct loongson2_c=
mc_dma_dev *lddev)
> +{
> +       struct device *dev =3D lddev->ddev.dev;
> +       struct acpi_dma_filter_info *info;
> +
> +       if (!is_acpi_node(dev_fwnode(dev)))
> +               return 0;
> +
> +       info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       dma_cap_zero(info->dma_cap);
> +       info->dma_cap =3D lddev->ddev.cap_mask;
> +       info->filter_fn =3D loongson2_cmc_dma_acpi_filter;
> +
> +       return devm_acpi_dma_controller_register(dev, acpi_dma_simple_xla=
te, info);
> +}
> +
> +static struct dma_chan *loongson2_cmc_dma_of_xlate(struct of_phandle_arg=
s *dma_spec,
> +                                                  struct of_dma *ofdma)
> +{
> +       struct loongson2_cmc_dma_dev *lddev =3D ofdma->of_dma_data;
> +       struct device *dev =3D lddev->ddev.dev;
> +       struct loongson2_cmc_dma_chan *lchan;
> +       struct dma_chan *chan;
> +
> +       if (dma_spec->args_count < 2)
> +               return ERR_PTR(-EINVAL);
> +
> +       if (dma_spec->args[0] >=3D lddev->nr_channels) {
> +               dev_err(dev, "Invalid channel id.\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       lchan =3D &lddev->chan[dma_spec->args[0]];
> +       chan =3D dma_get_slave_channel(&lchan->vchan.chan);
> +       if (!chan) {
> +               dev_err(dev, "No more channels available.\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_=
reg));
> +       lchan->chan_reg.ccr =3D dma_spec->args[1] & LOONGSON2_CMCDMA_STRE=
AM_MASK;
> +
> +       return chan;
> +}
> +
> +static int loongson2_cmc_dma_of_controller_register(struct loongson2_cmc=
_dma_dev *lddev)
> +{
> +       struct device *dev =3D lddev->ddev.dev;
> +
> +       if (!is_of_node(dev_fwnode(dev)))
> +               return 0;
> +
> +       return of_dma_controller_register(dev->of_node, loongson2_cmc_dma=
_of_xlate, lddev);
> +}
> +
> +static int loongson2_cmc_dma_probe(struct platform_device *pdev)
> +{
> +       const struct loongson2_cmc_dma_config *config;
> +       struct loongson2_cmc_dma_chan *lchan;
> +       struct loongson2_cmc_dma_dev *lddev;
> +       struct device *dev =3D &pdev->dev;
> +       struct dma_device *ddev;
> +       u32 nr_chans, i;
> +       int ret;
> +
> +       config =3D (const struct loongson2_cmc_dma_config *)device_get_ma=
tch_data(dev);
> +       if (!config)
> +               return -EINVAL;
> +
> +       ret =3D device_property_read_u32(dev, "dma-channels", &nr_chans);
> +       if (ret || nr_chans > config->max_channels) {
> +               dev_err(dev, "missing or invalid dma-channels property\n"=
);
> +               nr_chans =3D config->max_channels;
> +       }
> +
> +       lddev =3D devm_kzalloc(dev, struct_size(lddev, chan, nr_chans), G=
FP_KERNEL);
> +       if (!lddev)
> +               return -ENOMEM;
> +
> +       lddev->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(lddev->base))
> +               return PTR_ERR(lddev->base);
> +
> +       platform_set_drvdata(pdev, lddev);
> +       lddev->nr_channels =3D nr_chans;
> +       lddev->chan_reg_offset =3D config->chan_reg_offset;
> +
> +       lddev->dma_clk =3D devm_clk_get_optional_enabled(dev, NULL);
> +       if (IS_ERR(lddev->dma_clk))
> +               return dev_err_probe(dev, PTR_ERR(lddev->dma_clk), "Faile=
d to get dma clock\n");
> +
> +       ddev =3D &lddev->ddev;
> +       ddev->dev =3D dev;
> +
> +       dma_cap_zero(ddev->cap_mask);
> +       dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> +       dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> +       dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> +
> +       ddev->device_free_chan_resources =3D loongson2_cmc_dma_free_chan_=
resources;
> +       ddev->device_config =3D loongson2_cmc_dma_slave_config;
> +       ddev->device_prep_slave_sg =3D loongson2_cmc_dma_prep_slave_sg;
> +       ddev->device_prep_dma_cyclic =3D loongson2_cmc_dma_prep_dma_cycli=
c;
> +       ddev->device_issue_pending =3D loongson2_cmc_dma_issue_pending;
> +       ddev->device_synchronize =3D loongson2_cmc_dma_synchronize;
> +       ddev->device_tx_status =3D loongson2_cmc_dma_tx_status;
> +       ddev->device_terminate_all =3D loongson2_cmc_dma_terminate_all;
> +
> +       ddev->src_addr_widths =3D LOONGSON2_CMCDMA_BUSWIDTHS;
> +       ddev->dst_addr_widths =3D LOONGSON2_CMCDMA_BUSWIDTHS;
> +       ddev->directions =3D BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +       INIT_LIST_HEAD(&ddev->channels);
> +
> +       for (i =3D 0; i < nr_chans; i++) {
> +               lchan =3D &lddev->chan[i];
> +
> +               lchan->id =3D i;
> +               lchan->vchan.desc_free =3D loongson2_cmc_dma_desc_free;
> +               vchan_init(&lchan->vchan, ddev);
> +       }
> +
> +       ret =3D dmaenginem_async_device_register(ddev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register DMA en=
gine device.\n");
> +
> +       for (i =3D 0; i < nr_chans; i++) {
> +               lchan =3D &lddev->chan[i];
> +
> +               lchan->irq =3D platform_get_irq(pdev, i);
> +               if (lchan->irq < 0)
> +                       return lchan->irq;
> +
> +               ret =3D devm_request_irq(dev, lchan->irq, loongson2_cmc_d=
ma_chan_irq, IRQF_SHARED,
> +                                      dev_name(chan2dev(lchan)), lchan);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret =3D loongson2_cmc_dma_acpi_controller_register(lddev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register dma co=
ntroller with ACPI.\n");
> +
> +       ret =3D loongson2_cmc_dma_of_controller_register(lddev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to register dma co=
ntroller with FDT.\n");
> +
> +       dev_info(dev, "Loongson-2 Multi-Channel DMA Controller registered=
 successfully.\n");
> +
> +       return 0;
> +}
> +
> +static void loongson2_cmc_dma_remove(struct platform_device *pdev)
> +{
> +       of_dma_controller_free(pdev->dev.of_node);
> +}
> +
> +static const struct of_device_id loongson2_cmc_dma_of_match[] =3D {
> +       { .compatible =3D "loongson,ls2k0300-dma", .data =3D &ls2k0300_cm=
c_dma_config },
> +       { .compatible =3D "loongson,ls2k3000-dma", .data =3D &ls2k3000_cm=
c_dma_config },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, loongson2_cmc_dma_of_match);
> +
> +static const struct acpi_device_id loongson2_cmc_dma_acpi_match[] =3D {
> +       { "LOON0014", .driver_data =3D (kernel_ulong_t)&ls2k3000_cmc_dma_=
config },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson2_cmc_dma_acpi_match);
> +
> +static struct platform_driver loongson2_cmc_dma_driver =3D {
> +       .driver =3D {
> +               .name =3D "loongson2-apb-cmc-dma",
> +               .of_match_table =3D loongson2_cmc_dma_of_match,
> +               .acpi_match_table =3D loongson2_cmc_dma_acpi_match,
> +       },
> +       .probe =3D loongson2_cmc_dma_probe,
> +       .remove =3D loongson2_cmc_dma_remove,
> +};
> +module_platform_driver(loongson2_cmc_dma_driver);
> +
> +MODULE_DESCRIPTION("Looongson-2 Chain Multi-Channel DMA Controller drive=
r");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_LICENSE("GPL");
> --
> 2.52.0
>

