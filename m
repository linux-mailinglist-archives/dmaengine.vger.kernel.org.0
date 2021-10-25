Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD2438EFC
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJYFv2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:51:28 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:60542
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229702AbhJYFv0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TInkIymzfotJwvEeTlEWYeNdoeIWI/swVIVoOH515c2HHzHAYN9C3DXnZm8PtTvkrg5IYMNOtl9VZ4OJENfB88zwQIRP+WmEXN1sMen6WzMrwj9v+OEt4SPV+tX4xWbpPzA3G1exI9IDnI+m3Pkcvih2aMcSwD4gBbYzzTuyJ4r6qvUkieVzHlVYVLZnwYFbPhY29e8qLESnxq/aHV8y14gH3jE1/tehB5ogTAnpRjJF+yF4xfhnClswYs6ZIPsUuTgkoeEL3Nke/AAvWR7Va6ornFUpCP4wlw8za+twUCjNzP2xO6OziIP4zyPyqkvt8whXYbqYBSmGrKqrL1+6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81cfgAep2iSiylXhWzPwnpdVpBf6L4B8jX5F2Jp3JbE=;
 b=V5w3ggEmiSyRbHRRt1Pe97s3A4Uj+NwjKBgg63U+zhp5YR5G86aKRyms3qQXVRXRJvHboHueVRLHcri7KtdO7p8YP/n3k85gxjHlnMXlkpr3BfklOHpQIaj9sqFNl+rH1qJ5JWI6l10eO8h9/Fix/N+0g6yfYwauWKRUJyGPZHDqDm9xPXqm362+G/6ZAXuUZ3b5eyef7evOAXfWT7kE0T63Ti4djGcmVW+EiRMbrU04Ny73LWbgsWzblb4K470qMBA7sHH35uWBVvceMdpC7wPYHzlOAI1vstdPv9wzmFBgDXMVjP67EuozNK9L3EP73Jwii40ZLOUTKQuBY9xawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81cfgAep2iSiylXhWzPwnpdVpBf6L4B8jX5F2Jp3JbE=;
 b=ay9kyZS/8aaRJcR5+Gjp9bxxoDYKnyKLKgBt/WTVL8vPRrYtAjgKqNpkiLwZYJ8U8TRdf6Hzikbyx8lVQjZqq7kzZt+QJGiCJiNawi//lo0nIyX+ws/gSdqmL0UbPjcqOWpFAFykpU3k++vVMo3NBDi2d+8bbZimt+mlCJVwGkw=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0402MB3646.eurprd04.prod.outlook.com (2603:10a6:803:1a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 05:49:02 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::5901:3a55:84d6:d0fb]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::5901:3a55:84d6:d0fb%7]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 05:49:01 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Joy Zou <joy.zou@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 1/1] dmaengine: fsl-edma: support edma memcpy
Thread-Topic: [PATCH V3 1/1] dmaengine: fsl-edma: support edma memcpy
Thread-Index: AQHXxLJFKAxsk/q3rkGpE2fHWdlBqKvjPPzg
Date:   Mon, 25 Oct 2021 05:49:01 +0000
Message-ID: <VE1PR04MB66889D2AD3FE1324BD9D28EC89839@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <20211019062537.1209683-1-joy.zou@nxp.com>
In-Reply-To: <20211019062537.1209683-1-joy.zou@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4e717ed-a552-4ca1-ee48-08d9977b25a7
x-ms-traffictypediagnostic: VI1PR0402MB3646:
x-microsoft-antispam-prvs: <VI1PR0402MB3646F43CCB293B5E544217AA89839@VI1PR0402MB3646.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SmbLzm5DqYAwb4xfYk4cmWXx2TxnIvrcSIKay5RAw7a5XiuVn/BxDqVd65N1GGU9U4QWb2qnCjXpxQeeF2RFYlHBNKL8WNj94owKfButdza6vTG30RFcOMOIiwXin6OYOQ3QOzfcI6TRsVO+sagpEl0Ni2TjQFtmUX0qHKulAwVRwUPvtz+WkF5YPK1d4UdPxdAM1XAilp8LSdxfhJtcokdSaco/uiqX41mIxQhawd5sWdPjl9ggqfQnrf5rn49BrP7NsgpRkWiLO6sRKYmvj1p7Y9sGOh4qk4qjUBTJ+sk1eTM0BmVBm1LN7s0kQu2niepOKtCEDi7VKfNz0WD7IEthX5Sob3WrgvYQp3Eyt7Crpk/xEKDlGshA34WCg81aUOjDz4LZvD44JoxFiT0Iszu7V+92Y5FlYR2HRQKt9Bqp7UByu/BvHf9is882M2DmRZ8XodfNgv7Awtv4MeC7b5BDPgglIl/kcwZv+2qpaQhGtQ+NIft3isaYJ/31fJOhSF0Widy3Snf7gERdTF1Hz9t57ZCt+tmtt0a4ftTMZM9varSjIVxJmotEx1bwCxQLVeHmzevF1VT94PpyuCMFzfA59a2GGTbem3ffm8LZhxRqycOomqWbZwELuXo3Erv0bykQhX7/ZSDVftIxQWcf0ckGYelypZ6vU7uA94fn7v2/gOiGANYaxjvFn+sY6CDV+B0ZHau6wC0eZ3Ra9ZFURA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(5660300002)(33656002)(2906002)(53546011)(86362001)(122000001)(38100700002)(66946007)(26005)(76116006)(186003)(110136005)(83380400001)(4326008)(508600001)(52536014)(71200400001)(55016002)(38070700005)(9686003)(8936002)(6506007)(316002)(66476007)(64756008)(54906003)(66556008)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Yz2kNtvaocNQ5PFnb7hTyrFYj9ggaKNpH9GPj8eRzw7R3ltXXp6igRNhCel?=
 =?us-ascii?Q?tQfYz5pLxZ9LCc697PFzm4omYw+s8AisO7tulp5/gOVOcArak2Xq/SAbq3VU?=
 =?us-ascii?Q?cy+3Qgo6FiamL3DHFfpNt9ic8qfJiDGuwGtLDNPNyCgbG06uifMegDEgi0NB?=
 =?us-ascii?Q?s+bbNPC4SOqh9Qojqk8JzSNq6U0eDDWCQ5YukBj83gkX/ha2QONJUNnybXGg?=
 =?us-ascii?Q?g+O/pnL4kRra/mVT13Kq/dE8gsgzRfZEM0XTiP+C/tAX/pf5Q99HPosEHp2M?=
 =?us-ascii?Q?qX1fMJ03rqZc11spyA5FBpCbNGAJMy/ufj8zs9BtZ3aSKHgluLajSUxgUdC3?=
 =?us-ascii?Q?3y+XLZg2IvOr06HGMTsSy0oc4WHhBmvGfy3p7Ufa8+YfXN8tamu1DaH2jv7j?=
 =?us-ascii?Q?Lfzp5jJUnqh6xR9PZu45NvDYTN/Vdqh114LNAl25AR/rOxTfzkVsobxCfyi4?=
 =?us-ascii?Q?3mua0CEtGUdclfROi9hK+2R1zJNs6Q9wQyelLRKv15Jx5KqqJevcyAn8HLfH?=
 =?us-ascii?Q?h6E5X1lXVWKsidokqFh6KMb+h9Mk5sZQe3c9sz5tX/a+jQwOuaIX+olpUp+j?=
 =?us-ascii?Q?K00HwwtcRsOHvEaRyPNs1Mr97ZLnHAg/3DFVhrD9j0pDYwQo9LZoiY+ZhkVk?=
 =?us-ascii?Q?gKb5GMyY3Ty9r76Pg9TlFTijIyB+pZfeyZg+g3ypky8IUzA8Ty876hnO9o/k?=
 =?us-ascii?Q?Vl4jCwIEthrNKBsHUoFLx2grrUC8gsEwsFceZPHcWFyaQ/aj0s53PXGjfubt?=
 =?us-ascii?Q?uTQg/ypjQfdOy0MX4ADuXNQJS+rDzNf6qmUjzjNi0SO4G9Vu3FgiphCBQtJn?=
 =?us-ascii?Q?EI+E/Mx3NPXnifmXoYTzZ5fihncsafbqeTRtIkVLdouneLEdnJCQhya1LnDo?=
 =?us-ascii?Q?qvCxc9pte6TK3gOmM68IlArT14zWOveeMhHHrMs2CsMoCRPNEXElVXGem05R?=
 =?us-ascii?Q?HQTEfwBNvY9uIbNo0WqDxRqPN/sAfxWp9B+rYdCz4tAYrYJvtUtBsi9cCbGL?=
 =?us-ascii?Q?2GI4WCxlNiSXf6zk8DGfjfqbushtDb9nW+21dnJT8p2hyBQaNBrAs91Ww+tp?=
 =?us-ascii?Q?2f27hGhPCeJuRf2AMGyoBGRwNZ6S/PFR/uD+ZzuzVNUQnqsPG+E8N7asgFRO?=
 =?us-ascii?Q?29ZCpk6ONPWYSrhifRiVkKAyaAm/b3NX2RUaTK61rRm9KAqvR1Ylcpa7RNb0?=
 =?us-ascii?Q?xbSGEIhsOsSaNDGnviUwL+Z8Qhm3cnZxMWZanc3W2ym87Co7bFZKHobzSeHp?=
 =?us-ascii?Q?xQFp1EMRRAH/8GqUft44nkA+1MQ/2ifBEGSzIAX8Tt3Dp+gn+9o6P8h2KZNK?=
 =?us-ascii?Q?sLhIdvhpIzfJLoXU/rfDGUb4QHQR94CZA3KANNpIs99OXabFhhuXXLxQw7fQ?=
 =?us-ascii?Q?5oiRetznIHVVjGLIFWNzyRKTXA5gRye6adoBaFvI7MhPHJ2qU7CpzbFAvYjz?=
 =?us-ascii?Q?kZMNc5YfGJSmetPnH7thPvciQlHuqS0BRSwdjDH60KSt5+/QDNXNv/x38mYV?=
 =?us-ascii?Q?xjR05V3a2zeTIsgBy8G5QjuF3HaYEdFr1TzBUZk8c0Sd1H7Qj4SWZ9le+wC2?=
 =?us-ascii?Q?wgoX/PgSf3ex1dgf3T0Ru9XfJtkjY+boN2cZC5+yNPtNHs67FHsk5w/E7ZxZ?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e717ed-a552-4ca1-ee48-08d9977b25a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 05:49:01.7100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3wXfA4GSB9VidHw4yttwhQUSuaquZIkGbfnEsiACBaho81sRQHCF/CyPO5GOqzjoyn827G/vYoiy8/77pMxzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3646
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2021/10/19 14:26 Joy Zou <joy.zou@nxp.com> wrote:
> Add memcpy in edma. The edma has the capability to transfer data by
> software trigger so that it could be used for memory copy. Enable MEMCPY =
for
> edma driver and it could be test directly by dmatest.
>=20
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes since (implicit) v2:
> Remove 'Reported-by' tag in v3.
> Robot report sparse warning on v1, fixed it in v2.
> Add blank line in v3.
> Add commit message in v3.
> ---
>  drivers/dma/fsl-edma-common.c | 34 ++++++++++++++++++++++++++++++++--
>  drivers/dma/fsl-edma-common.h |  4 ++++
>  drivers/dma/fsl-edma.c        |  7 +++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/fsl-edma-common.c
> b/drivers/dma/fsl-edma-common.c index 930ae268c497..3f7c9faa8c9a
> 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -343,11 +343,11 @@ enum dma_status fsl_edma_tx_status(struct
> dma_chan *chan,  EXPORT_SYMBOL_GPL(fsl_edma_tx_status);
>=20
>  static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
> -				  struct fsl_edma_hw_tcd *tcd)
> -{
> +				  struct fsl_edma_hw_tcd *tcd){
Seems no any change here, please ensure no any code difference accordingly.

>  	struct fsl_edma_engine *edma =3D fsl_chan->edma;
>  	struct edma_regs *regs =3D &fsl_chan->edma->regs;
>  	u32 ch =3D fsl_chan->vchan.chan.chan_id;
> +	u16 csr =3D 0;
>=20
>  	/*
>  	 * TCD parameters are stored in struct fsl_edma_hw_tcd in little @@
> -373,6 +373,12 @@ static void fsl_edma_set_tcd_regs(struct fsl_edma_chan
> *fsl_chan,
>  	edma_writel(edma, (s32)tcd->dlast_sga,
>  			&regs->tcd[ch].dlast_sga);
>=20
> +	if (fsl_chan->is_sw) {
> +		csr =3D le16_to_cpu(tcd->csr);
> +		csr |=3D EDMA_TCD_CSR_START;
> +		tcd->csr =3D cpu_to_le16(csr);
> +	}
> +
>  	edma_writew(edma, (s16)tcd->csr, &regs->tcd[ch].csr);  }
>=20
> @@ -587,6 +593,29 @@ struct dma_async_tx_descriptor
> *fsl_edma_prep_slave_sg(  }
> EXPORT_SYMBOL_GPL(fsl_edma_prep_slave_sg);
>=20
> +struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
> +		struct dma_chan *chan, dma_addr_t dma_dst,
> +		dma_addr_t dma_src, size_t len, unsigned long flags) {
> +	struct fsl_edma_chan *fsl_chan =3D to_fsl_edma_chan(chan);
> +	struct fsl_edma_desc *fsl_desc;
> +
> +	fsl_desc =3D fsl_edma_alloc_desc(fsl_chan, 1);
> +	if (!fsl_desc)
> +		return NULL;
> +	fsl_desc->iscyclic =3D false;
> +
> +	fsl_chan->is_sw =3D true;
> +
> +	/* To match with copy_align and max_seg_size so 1 tcd is enough */
> +	fsl_edma_fill_tcd(fsl_desc->tcd[0].vtcd, dma_src, dma_dst,
> +			EDMA_TCD_ATTR_SSIZE_32BYTE |
> EDMA_TCD_ATTR_DSIZE_32BYTE,
> +			32, len, 0, 1, 1, 32, 0, true, true, false);
> +
> +	return vchan_tx_prep(&fsl_chan->vchan, &fsl_desc->vdesc, flags); }
> +EXPORT_SYMBOL_GPL(fsl_edma_prep_memcpy);
> +
>  void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)  {
>  	struct virt_dma_desc *vdesc;
> @@ -652,6 +681,7 @@ void fsl_edma_free_chan_resources(struct dma_chan
> *chan)
>  	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>  	dma_pool_destroy(fsl_chan->tcd_pool);
>  	fsl_chan->tcd_pool =3D NULL;
> +	fsl_chan->is_sw =3D false;
>  }
>  EXPORT_SYMBOL_GPL(fsl_edma_free_chan_resources);
>=20
> diff --git a/drivers/dma/fsl-edma-common.h
> b/drivers/dma/fsl-edma-common.h index ec1169741de1..004ec4a6bc86
> 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -121,6 +121,7 @@ struct fsl_edma_chan {
>  	struct fsl_edma_desc		*edesc;
>  	struct dma_slave_config		cfg;
>  	u32				attr;
> +	bool                            is_sw;
>  	struct dma_pool			*tcd_pool;
>  	dma_addr_t			dma_dev_addr;
>  	u32				dma_dev_size;
> @@ -240,6 +241,9 @@ struct dma_async_tx_descriptor
> *fsl_edma_prep_slave_sg(
>  		struct dma_chan *chan, struct scatterlist *sgl,
>  		unsigned int sg_len, enum dma_transfer_direction direction,
>  		unsigned long flags, void *context);
> +struct dma_async_tx_descriptor *fsl_edma_prep_memcpy(
> +		struct dma_chan *chan, dma_addr_t dma_dst, dma_addr_t dma_src,
> +		size_t len, unsigned long flags);
>  void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan);  void
> fsl_edma_issue_pending(struct dma_chan *chan);  int
> fsl_edma_alloc_chan_resources(struct dma_chan *chan); diff --git
> a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c index
> 90bb72af306c..76cbf54aec58 100644
> --- a/drivers/dma/fsl-edma.c
> +++ b/drivers/dma/fsl-edma.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_dma.h>
> +#include <linux/dma-mapping.h>
>=20
>  #include "fsl-edma-common.h"
>=20
> @@ -372,6 +373,7 @@ static int fsl_edma_probe(struct platform_device
> *pdev)
>  	dma_cap_set(DMA_PRIVATE, fsl_edma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_SLAVE, fsl_edma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, fsl_edma->dma_dev.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, fsl_edma->dma_dev.cap_mask);
>=20
>  	fsl_edma->dma_dev.dev =3D &pdev->dev;
>  	fsl_edma->dma_dev.device_alloc_chan_resources
> @@ -381,6 +383,7 @@ static int fsl_edma_probe(struct platform_device
> *pdev)
>  	fsl_edma->dma_dev.device_tx_status =3D fsl_edma_tx_status;
>  	fsl_edma->dma_dev.device_prep_slave_sg =3D fsl_edma_prep_slave_sg;
>  	fsl_edma->dma_dev.device_prep_dma_cyclic =3D
> fsl_edma_prep_dma_cyclic;
> +	fsl_edma->dma_dev.device_prep_dma_memcpy =3D
> fsl_edma_prep_memcpy;
>  	fsl_edma->dma_dev.device_config =3D fsl_edma_slave_config;
>  	fsl_edma->dma_dev.device_pause =3D fsl_edma_pause;
>  	fsl_edma->dma_dev.device_resume =3D fsl_edma_resume; @@ -392,6
> +395,10 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	fsl_edma->dma_dev.dst_addr_widths =3D FSL_EDMA_BUSWIDTHS;
>  	fsl_edma->dma_dev.directions =3D BIT(DMA_DEV_TO_MEM) |
> BIT(DMA_MEM_TO_DEV);
>=20
> +	fsl_edma->dma_dev.copy_align =3D DMAENGINE_ALIGN_32_BYTES;
> +	/* Per worst case 'nbytes =3D 1' take CITER as the max_seg_size */
> +	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
> +
>  	platform_set_drvdata(pdev, fsl_edma);
>=20
>  	ret =3D dma_async_device_register(&fsl_edma->dma_dev);
> --
> 2.25.1

