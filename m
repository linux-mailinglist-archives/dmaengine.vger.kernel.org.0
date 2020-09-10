Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2832926461E
	for <lists+dmaengine@lfdr.de>; Thu, 10 Sep 2020 14:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgIJMfQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Sep 2020 08:35:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43390 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbgIJMdL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Sep 2020 08:33:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08ACX7Eq023252;
        Thu, 10 Sep 2020 07:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599741187;
        bh=9MfYfkkDqOw/trWck0yzA/hd6grSgCWN8JA+FBuRH3I=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=AFLnWfAhSK5UtAC/1ofsRVTJlstRnJRQsEwqMtD4iXsBZmziEwCZUAuxhky9Up1pb
         f5roRuurQ1OEuIsU2a8Xxd8h/49cllRNVVBqX7ty4VAIPTFGK7b1LChxEZT/EUis/v
         u+uo+YbPLndDzIekaZPDSBZIw70Q4uMgw7XdwoqU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08ACX7NU045957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 07:33:07 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 07:33:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 07:33:07 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ACX56O010384;
        Thu, 10 Sep 2020 07:33:06 -0500
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Use soc_device_match() for SoC
 dependent parameters
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <lokeshvutla@ti.com>, <nm@ti.com>
References: <20200904120009.30941-1-peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <34734bc8-6013-cbed-4f20-b7c19146fadd@ti.com>
Date:   Thu, 10 Sep 2020 15:33:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200904120009.30941-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 04/09/2020 15.00, Peter Ujfalusi wrote:
> Use separate data for SoC dependent parameters. These parameters depend=
s
> on the DMA integration (either in HW or in SYSFW), the DMA controller
> itself remains compatible with either the am654 or j721e variant.
>=20
> j7200 have the same DMA as j721e with different number of channels, whi=
ch
> can be queried from HW, but SYSFW defines different rchan_oes_offset
> number for j7200 (0x80) compared to j721e (0x400).
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Vinod,
>=20
> this patch is going to be needed when the j7200 support is upstream (we=
 already
> have the psil map in dmaengine/next for the UDMA).
>=20
> Since the hardware itself is the same (but different number of channels=
) I
> wanted to avoid a new set of compatible just becase STSFW is not using =
the same
> rchan_oes_offset value for j7200 and j721e.
>=20
> Vinod: this patch will not apply cleanly on dmaengine/next because it i=
s on top
> of dmaengine/next + the dmaengine/fixes. This might cause issues.
>=20
> "dmaengine: ti: k3-udma: Update rchan_oes_offset for am654 SYSFW ABI 3.=
0" in
> fixes changes the rchan_oes_offset for am654 from 0x2000 to 0x200 and t=
his patch
> assumes 0x200...
>=20
> is there anything I can do to make it easier for you?
>=20
> Regards,
> Peter
>=20
>  drivers/dma/ti/k3-udma.c | 42 +++++++++++++++++++++++++++++++++-------=

>  1 file changed, 35 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 9a7048bcf0f1..ec7c5f320f7f 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/sys_soc.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
>  #include <linux/of_device.h>
> @@ -91,6 +92,9 @@ struct udma_match_data {
>  	bool enable_memcpy_support;
>  	u32 flags;
>  	u32 statictr_z_mask;
> +};
> +
> +struct udma_soc_data {
>  	u32 rchan_oes_offset;
>  };
> =20
> @@ -117,6 +121,7 @@ struct udma_dev {
>  	struct device *dev;
>  	void __iomem *mmrs[MMR_LAST];
>  	const struct udma_match_data *match_data;
> +	const struct udma_soc_data *soc_data;
> =20
>  	u8 tpl_levels;
>  	u32 tpl_start_idx[3];
> @@ -1679,7 +1684,7 @@ static int udma_alloc_chan_resources(struct dma_c=
han *chan)
>  {
>  	struct udma_chan *uc =3D to_udma_chan(chan);
>  	struct udma_dev *ud =3D to_udma_dev(chan->device);
> -	const struct udma_match_data *match_data =3D ud->match_data;
> +	const struct udma_soc_data *soc_data =3D ud->soc_data;
>  	struct k3_ring *irq_ring;
>  	u32 irq_udma_idx;
>  	int ret;
> @@ -1779,7 +1784,7 @@ static int udma_alloc_chan_resources(struct dma_c=
han *chan)
>  					K3_PSIL_DST_THREAD_ID_OFFSET;
> =20
>  		irq_ring =3D uc->rflow->r_ring;
> -		irq_udma_idx =3D match_data->rchan_oes_offset + uc->rchan->id;
> +		irq_udma_idx =3D soc_data->rchan_oes_offset + uc->rchan->id;
> =20
>  		ret =3D udma_tisci_rx_channel_config(uc);
>  		break;
> @@ -3091,14 +3096,12 @@ static struct udma_match_data am654_main_data =3D=
 {
>  	.psil_base =3D 0x1000,
>  	.enable_memcpy_support =3D true,
>  	.statictr_z_mask =3D GENMASK(11, 0),
> -	.rchan_oes_offset =3D 0x200,
>  };
> =20
>  static struct udma_match_data am654_mcu_data =3D {
>  	.psil_base =3D 0x6000,
>  	.enable_memcpy_support =3D false,
>  	.statictr_z_mask =3D GENMASK(11, 0),
> -	.rchan_oes_offset =3D 0x200,
>  };
> =20
>  static struct udma_match_data j721e_main_data =3D {
> @@ -3106,7 +3109,6 @@ static struct udma_match_data j721e_main_data =3D=
 {
>  	.enable_memcpy_support =3D true,
>  	.flags =3D UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
>  	.statictr_z_mask =3D GENMASK(23, 0),
> -	.rchan_oes_offset =3D 0x400,
>  };
> =20
>  static struct udma_match_data j721e_mcu_data =3D {
> @@ -3114,7 +3116,6 @@ static struct udma_match_data j721e_mcu_data =3D =
{
>  	.enable_memcpy_support =3D false, /* MEM_TO_MEM is slow via MCU UDMA =
*/
>  	.flags =3D UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
>  	.statictr_z_mask =3D GENMASK(23, 0),
> -	.rchan_oes_offset =3D 0x400,
>  };
> =20
>  static const struct of_device_id udma_of_match[] =3D {
> @@ -3135,6 +3136,25 @@ static const struct of_device_id udma_of_match[]=
 =3D {
>  	{ /* Sentinel */ },
>  };
> =20
> +struct udma_soc_data am654_soc_data =3D {
> +	.rchan_oes_offset =3D 0x200,
> +};
> +
> +struct udma_soc_data j721e_soc_data =3D {
> +	.rchan_oes_offset =3D 0x400,
> +};
> +
> +struct udma_soc_data j7200_soc_data =3D {
> +	.rchan_oes_offset =3D 0x80,
> +};

These should have been marked as static, I'll send a v2

> +
> +static const struct soc_device_attribute k3_soc_devices[] =3D {
> +	{ .family =3D "AM65X", .data =3D &am654_soc_data },
> +	{ .family =3D "J721E", .data =3D &j721e_soc_data },
> +	{ .family =3D "J7200", .data =3D &j7200_soc_data },
> +	{ /* sentinel */ }
> +};
> +
>  static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev=
 *ud)
>  {
>  	struct resource *res;
> @@ -3277,7 +3297,7 @@ static int udma_setup_resources(struct udma_dev *=
ud)
>  	rm_res =3D tisci_rm->rm_ranges[RM_RANGE_RCHAN];
>  	for (j =3D 0; j < rm_res->sets; j++, i++) {
>  		irq_res.desc[i].start =3D rm_res->desc[j].start +
> -					ud->match_data->rchan_oes_offset;
> +					ud->soc_data->rchan_oes_offset;
>  		irq_res.desc[i].num =3D rm_res->desc[j].num;
>  	}
>  	ret =3D ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
> @@ -3487,6 +3507,7 @@ static void udma_dbg_summary_show(struct seq_file=
 *s,
>  static int udma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *navss_node =3D pdev->dev.parent->of_node;
> +	const struct soc_device_attribute *soc;
>  	struct device *dev =3D &pdev->dev;
>  	struct udma_dev *ud;
>  	const struct of_device_id *match;
> @@ -3551,6 +3572,13 @@ static int udma_probe(struct platform_device *pd=
ev)
>  	}
>  	ud->match_data =3D match->data;
> =20
> +	soc =3D soc_device_match(k3_soc_devices);
> +	if (!soc) {
> +		dev_err(dev, "No compatible SoC found\n");
> +		return -ENODEV;
> +	}
> +	ud->soc_data =3D soc->data;
> +
>  	dma_cap_set(DMA_SLAVE, ud->ddev.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, ud->ddev.cap_mask);
> =20
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

