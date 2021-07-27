Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31C93D770C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Jul 2021 15:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhG0NpO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Jul 2021 09:45:14 -0400
Received: from mail-eopbgr1400090.outbound.protection.outlook.com ([40.107.140.90]:31003
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232313AbhG0NpO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 27 Jul 2021 09:45:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7rIcLjHGfjW5UKiLpVGzyP/aC7FmEEwnQJ2eUXKc53Cv/i/N+fSO+HT//oSC7Z7zQ95Lh2UlhsLBh0uFQaZixQB5Ss+D4Ye+XdL1S2MXwB76jn1sPAw4fNP/M5BUTSlznm3mYhpWbmc/lSNGI4IRtoy3FccrY3pA3oL5fcMEHVxP+sd1p741tRebYKLZDp+8TNTlSg8W+IamuWXjdtJyXnDE9h3ExTTduSuWsCCX/dtGiAdHQT4bUYmu3C3L7Wr1XAZLIA3o0X8VbnLaORPwhGqSlWYtgeUrjH2LoQzB0Y+G4LKRYeLZC8PwJyiEOWGADW1NNtShzdH6Ppew8rhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNEjATEAYqbWJlOeQUuNf2Lk1Fkl92VG/SPZjVsSOcE=;
 b=KAE6FbLanBkqCG01Byms3ZFcf+gVPidmaKK+7cXsM3s+jXFjTuy0z6fAqFG5L5vRR5G6Xg0PxSkIOJY4l+ImVxPSH0lkxwJRR+LrCbXNtfNZfR9H8JGD0AftYBDE9h+NU1Wj4M33eAowtwBK9g8JhaiE5oxSWP7e6dfe6iONU6hGGWHEzRnJn7Zi5DaIe1i69PjwhCQhKiTvtGui5Ui8Fr1mFhzyFz3gvuCtJZYfaX7iyBprEuquq7fxgWvcw9Yo/LU0hmHwTY1htRh/5mi3L/bQ8drbWP3tDoBX2aETOpQ5yDYvYfe6WwntgAqYQG41mb9V/4zBFpCgEXC3y3/3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNEjATEAYqbWJlOeQUuNf2Lk1Fkl92VG/SPZjVsSOcE=;
 b=QPuGP/hJ4xbb27mNXVBuKHUCiKXVqImFRqpRiDitTH5lKb/f0NnC1JoTLITlkE/lTvfb2QGVXWiMy2S3IE5zfNlbRXgmPpdI9Jm4rwvYpAqOEBuQxknPh2ND+ULnKsaU24WuRWiW/LipwNd3dFciSnWVPJOBwSOUhLffc4txs4U=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS0PR01MB5842.jpnprd01.prod.outlook.com (2603:1096:604:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 13:45:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c6f:e31f:eaa9:60fe%9]) with mapi id 15.20.4352.032; Tue, 27 Jul 2021
 13:45:11 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Topic: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L SoC
Thread-Index: AQHXfIANJc0R/9gnn0any8kXgzWfvKtW0BiAgAAIXJA=
Date:   Tue, 27 Jul 2021 13:45:11 +0000
Message-ID: <OS0PR01MB59224844C17A1EE620E2D18786E99@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20210719092535.4474-1-biju.das.jz@bp.renesas.com>
 <20210719092535.4474-3-biju.das.jz@bp.renesas.com> <YP/+r4HzCaAZbUWh@matsya>
In-Reply-To: <YP/+r4HzCaAZbUWh@matsya>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24c40490-9e05-4e38-a897-08d95104c18d
x-ms-traffictypediagnostic: OS0PR01MB5842:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB58422C4E759426B68F36708786E99@OS0PR01MB5842.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbPyA+Dif2DNhEbNf36xwm7G/rZz08xaqMq2+UxA2X/wdh6TyqjlgLnvQ6OL8WXYRXqPl32FqnPjkUX7o6j/+GQjMP7kpxMUVjsnN4Ao/MAhmjwzEp2HO82EugUu6NKdheOuy2peFbxjQb6ISVC3XTPEfFxq3PgU8jiRtugrmQueQhMh/X0LbHvrFc6UkwGyxycyek0tPTomZblb6uWnu3p9k2vXy5fuApueU2srMYah1Tfzm7h2MYFj4KWFNf5SniSa9sag5Ta7tJf8wZuQXz0sGop8bXKjjilJibw2UcfplD7VjFOqlkbgblOTxAY5eRwbdyh71zPlhU20UJmNAQGx+1PiEc67SPWNb/D/r0gjh05v3PZZmbL0A3sASAyVvUcBl/NP8ImXyGDihByFlJJsUMK2OHnaVDi15HbvTQ62avekifyNxuPdp+S0lVWlLEqkwgDTD53bnF4Sa5ySBstN/YMp054hjtXT2phoQlkeJIUsepAyLieBAg+/Ia45e+n9z08rAd5eO2qQJ2uqFsOgxBMg5eMO7EstKaxIYukNvE/4C2/mzlYBppE5JYvvT99hnMJXYefJt9avYQHAgIT+BsvDhIICL0VbCXG3dtRpVc5AnlLOl/EL+hkbWY5RAWOhR+5iez1Ol4u1UT8olks8CQNObwIiANjZRgNOb7pjetm95vBbZP2lMLIYnJUFJYKs/tMMGn6id+RUF6cumKZMBP4VknSKD2d4552rslgdKMwYrWWM68F6scszYrUF+FmZyylQbdd0Ya073gb+H6h7nAgTGvWmvKA2peJpzu8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(122000001)(83380400001)(86362001)(5660300002)(38100700002)(71200400001)(7696005)(26005)(6506007)(53546011)(52536014)(2906002)(4326008)(8676002)(186003)(54906003)(66446008)(66946007)(66476007)(64756008)(33656002)(66556008)(76116006)(478600001)(55016002)(9686003)(8936002)(6916009)(316002)(966005)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bnEVo0WJR6C3f4ZwSWnf01nqLKPdQe6nsrc1DR5+OZeAoqVNbjqLupHybrZX?=
 =?us-ascii?Q?Qf2ppFVUgEDKTj9uZZDj+bgErO1AiPBkV/oemj4GgrdSYcmJcPTwTwgLd/k8?=
 =?us-ascii?Q?u2LftHMl5JU5iQR7eAWN10N939ZI8RRM6ynYzSgcNih1sSDu5frZUSKGEno6?=
 =?us-ascii?Q?aLyviPG6ZrQvDWzLE8RP8IGJDZ1FyqMA6PL3T1DY/MYUhsKQEv6TOZZCUdzI?=
 =?us-ascii?Q?HvcoyRCTrdVe769cQbwed0zhaubPnAkAJWJmQ0O3P30BTmATXtG9b1xPO2fW?=
 =?us-ascii?Q?SpoxGJ3GIRyABluwYMMfoxPLBDvbub8FmjI0UMyB1UTEXEzo5k+n7gTzyY9f?=
 =?us-ascii?Q?mGKHpauuklTGA+GaLPTCXrklT/Zgb1+M020X0x6hlC/Vpacoh91/RsIsGDA4?=
 =?us-ascii?Q?u5QPXJgC6zOQSg6PPOil+rDCivM6V0BWlPAM1E9zeMrKqSn0teOKCXWjSi6a?=
 =?us-ascii?Q?HN9QRh4gnU3Ee74jcF1qj3tAYt3OH8GOtVcGrP18OVj376blErXs7Yuj+DkY?=
 =?us-ascii?Q?rlKqqisrGp/A/xcKuONgTtWoh9VnFc8Adc0CP8kJf3WlyJb9io4OH/HVpHw5?=
 =?us-ascii?Q?/+RH74vFF/+Mg7N13w8LD/KELcSurpdEE+qB8sRzhxVQRQ3xrExlmrtCqK5F?=
 =?us-ascii?Q?sua9CVKymFRzPSy5zvsVWzZLKs8D7PGUd0bYyQH5h8+uXN2n10dhpMUvA+Lt?=
 =?us-ascii?Q?fnHGZ1eE/YIuMdA0D28kHZou5KEymYC8toFY9zl33FlK7iYSyN+L6D6p4KJ7?=
 =?us-ascii?Q?CijptALSr7nkNcAV769/T/U+KHwL+XDN9V+lMBuN59szJ2ZoMJDjUyKlMaZ3?=
 =?us-ascii?Q?8GJsPtSrF3RxhmRWrWjuTJfIYx7enUl8RbJc9azjID1H4d4Lo9HagjZZ+sCo?=
 =?us-ascii?Q?48UkxEghz1MlSdxhdLnBvK4eRdphih3NCRilFPYuYKey2A1OFcJ7SsorNtqp?=
 =?us-ascii?Q?S8eV6/rQyM3C+fKOzXS0ElgivLWLjFjLJvePB4hoaZCuuzs1431a0aQ0FHlY?=
 =?us-ascii?Q?eEq/pSDrGf7pJt0Gkl0Yy0L/sDuh7SyYZWk5083AnKPZhTKuhtARnJdkzkfd?=
 =?us-ascii?Q?TIEwUVWSA8IHhBlhfDDN7k4RpKbEsUs0rkJGI2I1YZ7r7LzGy9bQylULjZZ6?=
 =?us-ascii?Q?HgdeLheOrF1kBjQuIwte0tSG+LdHXT5nETi2SCTgetUhOVdlt8FFSeamgG9M?=
 =?us-ascii?Q?BC9sIY+mhlegtgNGASkXlDk5dsWQy6+lbSybqwOHzWJy2gGxX5cE7eMjQmxX?=
 =?us-ascii?Q?/OZ2fFJB5Lr15wSGP9YuXDDIGhD6oQ3hd06f4mqazvHxMCF+XNgFdLXaDU6Q?=
 =?us-ascii?Q?BqjndLqOS2i109igT/BURj+F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c40490-9e05-4e38-a897-08d95104c18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 13:45:11.7536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0PzbTQAONzyheOn0vR5HmNEc34MwpJCIsI7w008la/9gmdh+eBJG9HH34TFAAFqyKlrR4AJ3Dfd3SEsXludFUyQp8AKP+CzvvbN7a6W5Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5842
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

Thanks for the feedback.

> Subject: Re: [PATCH v4 2/4] drivers: dma: sh: Add DMAC driver for RZ/G2L
> SoC
>=20
> On 19-07-21, 10:25, Biju Das wrote:
>=20
> > +struct rz_dmac_chan {
> > +	struct virt_dma_chan vc;
> > +	void __iomem *ch_base;
> > +	void __iomem *ch_cmn_base;
> > +	unsigned int index;
> > +	int irq;
> > +	struct rz_dmac_desc *desc;
> > +	int descs_allocated;
> > +
> > +	enum dma_slave_buswidth src_word_size;
> > +	enum dma_slave_buswidth dst_word_size;
> > +	dma_addr_t src_per_address;
> > +	dma_addr_t dst_per_address;
> > +
> > +	u32 chcfg;
> > +	u32 chctrl;
> > +	int mid_rid;
> > +
> > +	struct list_head ld_free;
> > +	struct list_head ld_queue;
> > +	struct list_head ld_active;
> > +
> > +	struct {
> > +		struct rz_lmdesc *base;
> > +		struct rz_lmdesc *head;
> > +		struct rz_lmdesc *tail;
> > +		int valid;
> > +		dma_addr_t base_dma;
> > +	} lmdesc;
>=20
> should this be not part of rz_dmac_desc than channel?

No. It is channel specific. A channel has 64 HW legacy descriptors(see rz_d=
mac_chan_probe function) and 16 rz_dmac_desc( see rz_dmac_chan_resources fu=
nction)

> > +static int rz_dmac_config(struct dma_chan *chan,
> > +			  struct dma_slave_config *config) {
> > +	struct rz_dmac_chan *channel =3D to_rz_dmac_chan(chan);
> > +	u32 *ch_cfg;
> > +
> > +	channel->src_per_address =3D config->src_addr;
> > +	channel->src_word_size =3D config->src_addr_width;
> > +	channel->dst_per_address =3D config->dst_addr;
> > +	channel->dst_word_size =3D config->dst_addr_width;
> > +
> > +	if (config->peripheral_config) {
> > +		ch_cfg =3D config->peripheral_config;
> > +		channel->chcfg =3D *ch_cfg;
> > +	}
>=20
> can you explain what this the ch_cfg here and what does it represent?

It is a 32 bit value represent channel config value which supplied by each =
client driver during slave config.
It contains information like transfer mode,src/destination data size, Ack m=
ode, Level type, DMA request on rising edge or falling
Edge, request direction etc...

For eg:- The channel config for SSI tx is (0x11228).
An example usage can be found here [1]

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2021071913=
4040.7964-8-biju.das.jz@bp.renesas.com/

Regards,
Biju


>=20
> --
> ~Vinod
