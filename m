Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DBE3C9E91
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 14:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhGOM2Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 08:28:16 -0400
Received: from mail-eopbgr1400127.outbound.protection.outlook.com ([40.107.140.127]:33307
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237199AbhGOM2P (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 08:28:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiAr4eiln7MFaVXb3uDaQx98gPM+E4y3anW/lnH+4Lqsma/JNp5J4pUqCVfZgK1eb1oxQ7QldBfmSzDsWN+lE/NlITqTWgIls/kj76dSYIG2/iVEXotPBTpQyKcE0uzYZeK9ijhfJm1nBoeOmqILhptcWkstepdPWWjcfRPK9rofG/4KWtCrSIEBHWOLDUkBnFD7N2ganOtEq3ZkO8C4kwWE6P4L5eSCtMq0Yz/OgJ5j0iZ5eJpNME2PRDNQLFancei2wBRLqW8P+WS4eHhXU6+SFlntRz5ObUAiyDuoUoiVGAMcyCZb4EUmchxEo4+NfMmKglZHbwzaejR7dwhpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmdNApXMTo80BBBlG+5XKpwblq4JtwB9BqfUUu7Tv1A=;
 b=BBQqAxZRqx0dQ/nH1Kwq7nqd/PmdW9ZDRKhYzeGvkPxeXz1JHjWTIHJ9rrUzA+jPUYEwhWREzYBMDSngH/645IhzFWM3cYD0iupjLFH25HNCIdvxrbbUnMyf9TzMpEnJnpc5Vt8BMAelJf9M9pL4KQF/vJ4xLArc477Jr7IBjeTHUlQqhafO9N1qjzn3FHgQb7Kl/8S9khEf24F+FwygWGYaVEi3UNhezAhX5NYvLUbX5Fe5cQQ9AO7x0mF9Waq4g+nnBehkvWwSGSyu6FNi76OEGt/kc8Bx+m+B9GaP3aY7f3oEKJs7fjKUYEuZmOm05BsSebSW2hdoYWy8/eCJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmdNApXMTo80BBBlG+5XKpwblq4JtwB9BqfUUu7Tv1A=;
 b=STygFak1IbQ7WJwPEyEdH2j6FhcqxLCTLTuWTuhrg41nNCRADQOWqD/aGSUCQjB670lC5cimRFDZB5RVaqnUiZL5t8sPeclgJ3TH5K6gquFOSn8un4uul3VDHHtglaDgyLLLkN7ij6xsEorQYSpjLTjpaS2SUqVVw1HAEzrUDnQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB4871.jpnprd01.prod.outlook.com (2603:1096:604:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 12:25:14 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%9]) with mapi id 15.20.4331.021; Thu, 15 Jul 2021
 12:25:14 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Topic: [PATCH v3 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Index: AQHXbynVYmsBZxQS4EiRHSpVqA5Gl6tCEOEAgAH2YOA=
Date:   Thu, 15 Jul 2021 12:25:14 +0000
Message-ID: <OS0PR01MB59227F9B95B131F656842AAB86129@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210702100527.28251-1-biju.das.jz@bp.renesas.com>
 <20210702100527.28251-3-biju.das.jz@bp.renesas.com> <YO6A8KXRSvqUN6pL@matsya>
In-Reply-To: <YO6A8KXRSvqUN6pL@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69f3ef79-908c-427b-df00-08d9478b98fa
x-ms-traffictypediagnostic: OSBPR01MB4871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB4871935A33B6939842117BFE86129@OSBPR01MB4871.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iszjSiPWrJg9l4WELa35ksYwCZ/6KF82/RJvVNmYIN7TO/0i41iwkl20op9N4lXjFapT0zJ7VZHSq/eJZbfEXcMgo3WXcxPB86U6xWgBP4J73fw4WNsNrIFM3baL8q4FQTNR6LLzM/Jirj4USd4WFC6/5jbCfriqkR9CRCqgOy+JttCeqSiqzIB3T/UiEkzVdYheykjEDLgTbFSB+piF5Tueb3XKKRUi82Dna8GRZIE9zRqSC0elIO53SHl7i1qsdjWM7ovENhgIEiocOB7NszMKV9GR8PO+pAsyPzROXQS/D66sZO/Er4QVWKoVsurrkQB0TihdnfDgnz3N5l6a73ucGkq2djKwwh/ElW2j9PbK3GNLxqSkAars6TfjrZuqTAd71uuoeXhxqeV28Z3tCK+lPZHljh7esTzjtgKsL/QOA46eNbQ+qivxL3cNxEfw0qO/8yN+5XtnAauVN4JAZvkqvuvYdoTTrO/7A3f+LJspgWWTIskxrbgSKIaOquz9zezMT77Zj9f2UuLLOg5jCDZxXpkP7g/tJ4P74aGtHW+Rk6B3VGt4Z9HfVQYd6QdFMO4zz0ab6fLFOo7Ikt7B9/VYevyTDJp/qeTrv6iisk5tgTyPv4VAx/ZF85xQqqhhEUKH08IQrLCjjQ/M8d3ViU0aIUsnwzQOFCLzmAnfDc2Fd0ZQrAQWJw1y+DX3JMY2wwAlpQF5cuv+QJLrJvLj+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(66946007)(64756008)(66446008)(66476007)(66556008)(55016002)(478600001)(38100700002)(8676002)(2906002)(316002)(54906003)(76116006)(122000001)(6916009)(7696005)(9686003)(52536014)(83380400001)(186003)(53546011)(6506007)(71200400001)(8936002)(4326008)(33656002)(86362001)(5660300002)(26005)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p88z1dAMBjmtLxT1mjS1k4fytJCwwRSOpaQ0TYXaoagKw5TC1XuA4QAyq0oX?=
 =?us-ascii?Q?DeQNwg1tHtV6Lcp37lQUELAM7qb3bne3AylBmIjjeq5ODpjSS/xb2OdSqf0/?=
 =?us-ascii?Q?g30GziDSyqwVa9d1fJbPR4yzRFmMBrI1qy8X+rd2fpV/ZzbmdEpgpl+7vKn1?=
 =?us-ascii?Q?aEwKTaFckUMXeRD4UfAOh7SznGLPegrZLhsg6AycQLCIAx9aDrEAYsZGujUz?=
 =?us-ascii?Q?WdXwBozuXE3/2DlT/oFkXVPv0i8bLk5mWZfYtA2EVJRkoXtahqgPdnF0JW+b?=
 =?us-ascii?Q?wS/OHaf7PBK2GfJ+87d5F7R6A6myXD12UV27BeeF4fjv3FcN/UqT2IN/jelp?=
 =?us-ascii?Q?9zG+Nm7SLNKqJn7jugBy1N5jU2nQPEcUSom4lmbNTo8+WnwnkZDevRLH/gTA?=
 =?us-ascii?Q?b5fEKq4jc0SNuiZ7mr26tqxw39nD0H54gE7zCJXHEj21Id9X75BIlyk2ZD/U?=
 =?us-ascii?Q?++y9DYt7IPUGCVnWwDVoLkY9f90pkkluffMKJOyFYCAGtUiFSfOg/OddLLA3?=
 =?us-ascii?Q?pG4KvL/uOhooMo2nvAkbm7APgxI3Yxb4I0SsXB+iUoAKCg8MAPThmJyjwiI+?=
 =?us-ascii?Q?17cnZML10X8w+3nzB4hbR+Jbn9wDzRbgi25QYbDsACEPE8ODPkONOCFtXHJG?=
 =?us-ascii?Q?55nrRmtNtjepZ7wIvkIVlGPG/wEFjYx32GfXzl6HB+p/mOPMAOa0BvY90pJt?=
 =?us-ascii?Q?Wcu+i3PLbqypPdAGyNY0Fq7UlQ+Qd+bInznD3Y2JkuG0C3qVxHbei15CrTml?=
 =?us-ascii?Q?2eFGANccRMi5qzVx4Ehwo5YJsBwHVtE4JPLK1rO19eiIQ2X8E6XyLqUSjlah?=
 =?us-ascii?Q?Bl491bwrqb7QhskENN4MXqf7JtULT8RxzM783t30mYnsJ+B8hmq+iSKakQNS?=
 =?us-ascii?Q?TEPW4um9+HdW1SUtYcijP7kEtcmczlH1Xq0kP8JnGhUcOto2eUmcZLf7ynDC?=
 =?us-ascii?Q?tsXIf7qy+Lhog25Xjobfl8OMkSANlfawmmLYMiTEIM6Irwt8DRpr3GrClAKG?=
 =?us-ascii?Q?oQrnQrkUr3J4F8iduRhpCUZaKIIyQlOirzQ1km9JoMBWC1KzVpuQOGuyxOQU?=
 =?us-ascii?Q?OaXdqJ5GI3lGnvPikLKsJp+iq+83lPI0p1V2R/VAbNacEKeZ+Zhn59hmBzY5?=
 =?us-ascii?Q?bbF4VOiOq3q/53+2d34bZdFKLLdvocHoG1TqcmTICoq8jJYht3ysg/oHFZRo?=
 =?us-ascii?Q?z3Q09KeZv1pV0rWG1Xd2wfSTSzXucXhHnF7NoRQSix+TBP16FmseKH1ppU9I?=
 =?us-ascii?Q?uYeMuFo2enl9kdGOjQhO0zzHyMVDkkBJQtpTT6xCia0PYMHyFCwMkjEDPkvQ?=
 =?us-ascii?Q?x5/I0UbOdeYeuLupxhr+gmLF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f3ef79-908c-427b-df00-08d9478b98fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 12:25:14.1015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgBXokf7Exyd3JThu4upXPLwfcfMWyoLlc2ycoFizxm2UAQ5iSL1yR9gw2zWhY7LLwpE1vl2uixjSmAGezAWjr8uQ2z++UrOvvhAaol0ZYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4871
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the feedback.

> Subject: Re: [PATCH v3 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L
> SoC
>=20
> On 02-07-21, 11:05, Biju Das wrote:
>=20
> > +static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr,
> > +				       u32 dmars)
> > +{
> > +	u32 dmars_offset =3D (nr / 2) * 4;
> > +	u32 dmars32;
> > +
> > +	dmars32 =3D rz_dmac_ext_readl(dmac, dmars_offset);
> > +	if (nr % 2) {
> > +		dmars32 &=3D 0x0000ffff;
> > +		dmars32 |=3D dmars << 16;
> > +	} else {
> > +		dmars32 &=3D 0xffff0000;
> > +		dmars32 |=3D dmars;
> > +	}
>=20
> how about using upper_16_bits() and lower_16_bits() for extracting above?

OK Good point. Geert suggested a logic for this and looks fine.

>=20
> > +static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan
> > +*channel) {
> > +	struct dma_chan *chan =3D &channel->vc.chan;
> > +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> > +	struct rz_lmdesc *lmdesc =3D channel->lmdesc.base;
> > +	struct rz_dmac_desc *d =3D channel->desc;
> > +	u32 chcfg =3D CHCFG_MEM_COPY;
> > +	u32 dmars =3D 0;
> > +
> > +	lmdesc =3D channel->lmdesc.tail;
> > +
> > +	/* prepare descriptor */
> > +	lmdesc->sa =3D d->src;
> > +	lmdesc->da =3D d->dest;
> > +	lmdesc->tb =3D d->len;
> > +	lmdesc->chcfg =3D chcfg;
> > +	lmdesc->chitvl =3D 0;
> > +	lmdesc->chext =3D 0;
> > +	lmdesc->header =3D HEADER_LV;
> > +
> > +	rz_dmac_set_dmars_register(dmac, channel->index, dmars);
>=20
> why not pass 0 as last arg and remove dmars?

OK.

>=20
> > +static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
> > +					 dma_cookie_t cookie,
> > +					 struct dma_tx_state *txstate)
> > +{
> > +	return dma_cookie_status(chan, cookie, txstate); }
>=20
> why not assign status as dma_cookie_status and remove
> rz_dmac_tx_status()

OK. will remove rz_dmac_tx_status

>=20
> > +static int rz_dmac_config(struct dma_chan *chan,
> > +			  struct dma_slave_config *config) {
> > +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > +	u32 *ch_cfg;
> > +	u32 val;
> > +
> > +	if (config->direction =3D=3D DMA_DEV_TO_MEM) {
>=20
> config->direction is deprecated, pls save the dma_slave_config here and
> then use based on txn direction...

OK, will do.

>=20
> > +static bool rz_dmac_chan_filter(struct dma_chan *chan, void *arg) {
> > +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > +	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
> > +	struct of_phandle_args *dma_spec =3D arg;
> > +
> > +	if (chan->device->device_config !=3D rz_dmac_config)
> > +		return false;
>=20
> which cases would this be false?

OK. Will remove this as it not needed.
>=20
> > +
> > +	channel->mid_rid =3D dma_spec->args[0];
> > +
> > +	return !test_and_set_bit(dma_spec->args[0], dmac->modules); }
> > +
> > +static struct dma_chan *rz_dmac_of_xlate(struct of_phandle_args
> *dma_spec,
> > +					 struct of_dma *ofdma)
> > +{
> > +	dma_cap_mask_t mask;
> > +
> > +	if (dma_spec->args_count !=3D 1)
> > +		return NULL;
> > +
> > +	/* Only slave DMA channels can be allocated via DT */
> > +	dma_cap_zero(mask);
> > +	dma_cap_set(DMA_SLAVE, mask);
> > +
> > +	return dma_request_channel(mask, rz_dmac_chan_filter, dma_spec); }
> > +
> > +/*
> > +---------------------------------------------------------------------
> > +--------
> > + * Probe and remove
> > + */
>=20
> we use
> /*
>  * this style
>  * multi-line comments
>  */

Will change multiline comments like this.

Regards,
Biju

