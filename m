Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA913A9899
	for <lists+dmaengine@lfdr.de>; Wed, 16 Jun 2021 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhFPLEq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Jun 2021 07:04:46 -0400
Received: from mail-eopbgr1300101.outbound.protection.outlook.com ([40.107.130.101]:65326
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232588AbhFPLEP (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Jun 2021 07:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJZEm2Mhj188srShPmVi9BvTZuHEHC0eQUHHZ+AcVHLz4qjFKWJgrOxOXC6qZ2/UaWAhZuZ9UFwa5ldjYVoHXodPAAha4X38FvS+oKDjhY/GPCtUvbHU3FspAbSl4nIzqNX+xp52bKCjABC0OERvTxz4Eg/Y3u6d4qEIhjU5HPNGdW8m7kQqVNbvU1hVSYg/M0w+FwZkx68FJJBz794AAOtLUTzPg5IiKWmDdhfP8cJp7oseUegcKi2VCz7AZWASTzl7OWLjImUcBLOGzupOHA94fgNK+FtYi9mFrnO1geBUPJ2oYWAl7imufQDq2yb79dxBoPGhyWd7uaWqHNaZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2OjlyBGXyva3fRxmKYTzXxQuvOFvDOwNeBc+CNvpcs=;
 b=XX7SY7RzWYKMBIDzcbH0Pod/luPmjZrdxDBGBvB0ThpyyJZ2hN2N1ctM5zIs3HZZjqo5vRDh6cyt7oBYovFphgQYu30Y6ehK62L0ReKKZjXuTYaM1jAPyV5I0fPmMMv1mKQkSgAitz2jswsJTDcU1OVrH7LvURsrsSWmgUz+jJAJaha3v8C0Y4qcCQaHbw9TuWBDEAJonyblr5i5WMxseKyqarkWl9xDDlG7q+S9VKIzsp4sbNbwRbbzFeQRI51hu9GUiQ/bT2jLtgt4CrfFHS9O9drfi/Yq02GXIILzatD/kAuCprAf+t63Wwvy3aovYRlaBO/LxpEZ1qy2qTqMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2OjlyBGXyva3fRxmKYTzXxQuvOFvDOwNeBc+CNvpcs=;
 b=ECJSxaw2TGrInsk77/HcEGprcW4M8ofwIlKqQ/BGMxMd8iNux7bjxyucL2IAHoSGJiPPCIGTEYRDN5O4gfTICEDZD/LmjqsJlAA6JE1OR6zMk9NZAQIfUxWNWsPSuTrITx53KJHhqgmHRmovz7njJl2Dvd7of5eZxVMrPGdSI28=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TY2PR01MB5114.jpnprd01.prod.outlook.com (2603:1096:404:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Wed, 16 Jun
 2021 11:02:05 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::d47c:6365:dc20:bb]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::d47c:6365:dc20:bb%3]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 11:02:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 3/5] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Topic: [PATCH 3/5] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Index: AQHXXrYVURtnQoU0uUSdOpSN7/Ob2asWd/oAgAAFnNA=
Date:   Wed, 16 Jun 2021 11:02:04 +0000
Message-ID: <TYCPR01MB5933B0499A530051F9B127EB860F9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20210611113642.18457-1-biju.das.jz@bp.renesas.com>
 <20210611113642.18457-4-biju.das.jz@bp.renesas.com>
 <YMnS5AdR8PL0hKuC@vkoul-mobl>
In-Reply-To: <YMnS5AdR8PL0hKuC@vkoul-mobl>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-originating-ip: [193.141.219.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0524488-db8f-4a22-3173-08d930b62d61
x-ms-traffictypediagnostic: TY2PR01MB5114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB511482C418103C26B2E9393D860F9@TY2PR01MB5114.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YS+j9VLPjNffqqbrN+olkR4D0zmw42VsxE6xkIl9Ks/rKJMt8WQdVgfFHUDS8fIcyLNWBMrFzeIMjgMkdXfmFHQzh07fKlUfZe+CHVzf84ox+Cl5JZh0qXk0kwkrU0zJ9xTjudVbemq8sI+Ad+OWyIEaKj7S1iCltf/Xyru1LXZs+6x9dOtgLHjQcmV395F7ZUgXWorLWwa0n9pbqSfHP+TEhfqsCtbYicFH5RzG29ISmRVd6HKbLpgj1V8+KIe1XES6US7g0lGaaUbrvZZH1cqp1ZWsLcdoj5fOHzTxVWGQkPZDrp9zzwxBzCD4KEuOUziQ65DuVQC1wBbJopVBlbUGHWCrLQDM76YJhRA04I7UKpV2XzaYreOZvfvGPeFPSLt8Jt/U3894hBl753Podib+VI7ovMlXTH4szXm+I8LvmSLDPCOOS7CYILYuZur3z9m2R5mZPkHDmAmsvuE32na8UiVjnjc+bRLNFlHfHe7H9HdkGJuqnzXtw+lkC9KwtvZA6UpkKQAadKlzxCDjJLsXDS+UQaToWKnTOpCdypf2r+2GsQPI2t049Of+0s6Wduswx6vZtUaoWYFKodN+8qFR+0rZAmjh/v+0LLD33PY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(9686003)(6916009)(83380400001)(8936002)(4326008)(52536014)(5660300002)(478600001)(8676002)(55016002)(64756008)(26005)(86362001)(53546011)(66946007)(66476007)(38100700002)(54906003)(76116006)(71200400001)(316002)(6506007)(66556008)(122000001)(7696005)(2906002)(66446008)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EcowDgil78K0ThcUpDkhnXSN36AzGaWMuZZBHE7WN9c1QKG8AWH5ZoAQNGKb?=
 =?us-ascii?Q?PgocwY+IkoBufr3Q28HuPgxf/sqyyyGQf3r+7BxyvFjIroa8RBLN5B5+fy1/?=
 =?us-ascii?Q?ELycx33fUgYc/haf3DuYupOvZ56u1xyjzfO0QUQyaPgjfBEXy5bcFdOWOU7Q?=
 =?us-ascii?Q?xTPacbv8DU5zx3GTk6/3Ts0sEN+bHhF/Gw6H2WPKxgXm1GYSjEsJTqJmlemL?=
 =?us-ascii?Q?KAKavPdYR81+I5mwro7QBCFoPvjzpgcF3+TDzX+P692IqoakvJGCO7vC5o1b?=
 =?us-ascii?Q?iNetTMVcfCBR/3UZkRRLRrXdQ+Jw6w4VCq4UtVPh31X7xIQfW8sSUZfrFmBF?=
 =?us-ascii?Q?j3sFGvP7VFQvl2xmI7XPKBs17bKxRYcy8jZgzrS2IutjJ0P6UdCKVLC1uL5S?=
 =?us-ascii?Q?TxPnot4zpvHRgJK/aMrnSg4Ol4junsidGF9YLcYtAovht438IWbCv3EECGfn?=
 =?us-ascii?Q?Lp8VLhj07gEofASu1UqGjlaiWKXpMM7lU8v/dOid2JXRjLj9F/VDNfz9YM8E?=
 =?us-ascii?Q?lTlkeZrrHBdweHTz2+WXyJb8KFm9JQs2g2IE9Rj/bTxaEukBpZQiJFMeQnJg?=
 =?us-ascii?Q?ifwcCsGR/P+FcPy7W26iSl0+LxSEcAJ2nucbpTkKNA8MLZO6ISRDdkBundsC?=
 =?us-ascii?Q?G9LRrkX3grZ5AAdHseY9qFfl3VrW+1rUlygScyIvMbQHjLiAPMtDOLdKnBFC?=
 =?us-ascii?Q?HZ+Rhcvr+y6iyCoAsbF7/r5GUtCMUqB66ARE55ln0o2Qsy63A2sfhCevwwL3?=
 =?us-ascii?Q?joC7ktgejgmD6aYzb5AVoJj3r3aOVCDS8BcaOlJY+9uasUMC0p+wuvp/Ut4X?=
 =?us-ascii?Q?POqgxjVL+RHOadKRJ8o6/J5VxTYiWa4pLxeOdyA1lapuT63/kCUG/Xib2KTp?=
 =?us-ascii?Q?fpm01cqWbhL/I9B7ht2vWSXZMrEvzLv/PocmTZdxIOoXa9d5zbVVXf407vLN?=
 =?us-ascii?Q?S8mA37lm9z02iHpJ1862dC8eSq+U0EI/g+3nyt675NbKtaAFw7Pun12oTc7j?=
 =?us-ascii?Q?TL62fkWOp+lcxPYYO/KZmekWffPUK1vpTaJSWwYgDiIEqtxnD/APgRhd1KSB?=
 =?us-ascii?Q?e0bFOqhJKplHEl7m2D2KAqwFEThm4YJDzXtLSJVPjtov9wAuoXGeYUqDKq/d?=
 =?us-ascii?Q?LfAYKWDsDGgCGt59eZXcXHMWoQBB9lrQfRtvl6c46hROO8H6vHYtmZbOJZXi?=
 =?us-ascii?Q?l0BIEC9qN4753nMwXEFzeNk0gA8/VvM6pUk9BThFyfQg/wh/Ws2Iuggm3Clu?=
 =?us-ascii?Q?pQdhAR47LAC+6RPAcqUz5uXF/mQ6w4Y0k4CAYKaAqKcpl2binD/BhSL+B9Ci?=
 =?us-ascii?Q?+CyJJnXXZlj3aY39GZale8wE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0524488-db8f-4a22-3173-08d930b62d61
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 11:02:04.9138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17lmXOwCCB6DFwvVu2j0ylk5KgkqxnZiAHJ2ICzXeNDfDLygB0meHZaXDbOLgqtm3tyFsDJTGJSr0m0K1BTPr7i34dnhOzE0ocSaAexOV5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5114
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the feedback.

> Subject: Re: [PATCH 3/5] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
>=20
> On 11-06-21, 12:36, Biju Das wrote:
> > Add DMA Controller driver for RZ/G2L SoC.
> >
> > Based on the work done by Chris Brandt for RZ/A DMA driver.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/dma/sh/Kconfig   |    8 +
> >  drivers/dma/sh/Makefile  |    1 +
> >  drivers/dma/sh/rz-dmac.c | 1050
> > ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1059 insertions(+)
> >  create mode 100644 drivers/dma/sh/rz-dmac.c
> >
> > diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig index
> > 13437323a85b..280a6d359e36 100644
> > --- a/drivers/dma/sh/Kconfig
> > +++ b/drivers/dma/sh/Kconfig
> > @@ -47,3 +47,11 @@ config RENESAS_USB_DMAC
> >  	help
> >  	  This driver supports the USB-DMA controller found in the Renesas
> >  	  SoCs.
> > +
> > +config RZ_DMAC
> > +	tristate "Renesas RZ/G2L Controller"
> > +	depends on ARCH_R9A07G044 || COMPILE_TEST
> > +	select RENESAS_DMA
> > +	help
> > +	  This driver supports the general purpose DMA controller found in
> the
> > +	  Renesas RZ/G2L SoC variants.
> > diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile index
> > 112fbd22bb3f..9b2927f543bf 100644
> > --- a/drivers/dma/sh/Makefile
> > +++ b/drivers/dma/sh/Makefile
> > @@ -15,3 +15,4 @@ obj-$(CONFIG_SH_DMAE) +=3D shdma.o
> >
> >  obj-$(CONFIG_RCAR_DMAC) +=3D rcar-dmac.o
> >  obj-$(CONFIG_RENESAS_USB_DMAC) +=3D usb-dmac.o
> > +obj-$(CONFIG_RZ_DMAC) +=3D rz-dmac.o
> > diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c new
> > file mode 100644 index 000000000000..87a902ba3cfa
> > --- /dev/null
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -0,0 +1,1050 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L Controller Driver
> > + *
> > + * Based on imx-dma.c
> > + *
> > + * Copyright (C) 2021 Renesas Electronics Corp.
> > + * Copyright 2010 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
> > + * Copyright 2012 Javier Martin, Vista Silicon
> > +<javier.martin@vista-silicon.com>  */
> > +
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_dma.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "../dmaengine.h"
> > +
> > +struct rz_dmac_slave_config {
> > +	u32 mid_rid;
> > +	dma_addr_t addr;
> > +	u32 chcfg;
> > +};
>=20
> why not use dma_slave_config()

OK, will use dma_slav_config and remove this structure.

>=20
> > +
> > +enum  rz_dmac_prep_type {
> > +	RZ_DMAC_DESC_MEMCPY,
> > +	RZ_DMAC_DESC_SLAVE_SG,
> > +};
> > +
> > +struct rz_lmdesc {
> > +	u32 header;
> > +	u32 sa;
> > +	u32 da;
> > +	u32 tb;
> > +	u32 chcfg;
> > +	u32 chitvl;
> > +	u32 chext;
> > +	u32 nxla;
> > +};
> > +
> > +struct rz_dmac_desc {
> > +	struct list_head node;
>=20
> what is this list node for?

This node is for managing list descriptors.

>=20
> > +	struct dma_async_tx_descriptor desc;
> > +	enum dma_status status;
> > +	dma_addr_t src;
> > +	dma_addr_t dest;
> > +	size_t len;
> > +	enum dma_transfer_direction direction;
> > +	enum rz_dmac_prep_type type;
> > +	/* For memcpy */
> > +	unsigned int config_port;
> > +	unsigned int config_mem;
> > +	/* For slave sg */
> > +	struct scatterlist *sg;
> > +	unsigned int sgcount;
> > +};
>=20
> why not use virt_dma_desc ?

OK. Will check with virt_dma_desc.

> > +
> > +struct rz_dmac_channel {
> > +	struct rz_dmac_engine *rzdma;
> > +	unsigned int index;
> > +	int irq;
> > +
> > +	spinlock_t lock;
> > +	struct list_head ld_free;
> > +	struct list_head ld_queue;
> > +	struct list_head ld_active;
>=20
> why not use virt_dma_chan() ?

OK. Will check with virt_dma_chan

>=20
> > +
> > +	int descs_allocated;
> > +	enum dma_slave_buswidth word_size;
> > +	dma_addr_t per_address;
> > +	struct dma_chan chan;
> > +	struct dma_async_tx_descriptor desc;
> > +	enum dma_status status;
>=20
> Both desc and chan need status?

This status is unused. Will take it out.

>=20
> > +	const struct rz_dmac_slave_config *slave;
> > +	void __iomem *ch_base;
> > +	void __iomem *ch_cmn_base;
> > +
> > +	struct {
> > +		struct rz_lmdesc *base;
> > +		struct rz_lmdesc *head;
> > +		struct rz_lmdesc *tail;
> > +		int valid;
> > +		dma_addr_t base_dma;
> > +	} lmdesc;
> > +
> > +	u32 chcfg;
> > +	u32 chctrl;
> > +
> > +	struct {
> > +		int issue;
> > +		int prep_slave_sg;
> > +	} stat;
> > +};
>=20
> I have glanced at the rest of the driver, looks mostly okay but please
> move this to use virt_dma_chan and virt_dma_desc that would ease a lot of
> code from driver

OK, will check with virt_dma_chan and virt_dma_desc.

Regards,
Biju
