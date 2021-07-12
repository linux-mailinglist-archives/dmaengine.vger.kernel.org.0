Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359FD3C423E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jul 2021 05:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhGLDvn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 11 Jul 2021 23:51:43 -0400
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:64681
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229998AbhGLDvn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 11 Jul 2021 23:51:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UugDV6gCZtXZP5pi7BoAbvgOaJFMC0PuWlQpcRt8GKLNxFvqvXIeDai/i/xy0PPhalbFmtHm2dvBJg+rcLPI8lV15A2IgefagkpJFGO5XolMkKc4cQyMmhpmWncWJ94md6qLBsL+CLzQicPtD+WZgzwdR/rIPoM5oKUnXwyuLENsdewm7mqcQHkutDfIms+kKp2wvQtWXsXjxx+dniuPxJrSbb/lAnj8blOph/MADwIvaSm8XfMGrKTSW9VS/eAfTveWuLunnhNguYxegvJBSA5wFvHE3qnfiPkTFI+Vh7dV7kRoUMX6w8wo529+N2WbKCfskVcioGUpeaLOuyPJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2iXaKYcpojwnrJEWOnSSW7ZnRKOikzEu5I9prHAEvI=;
 b=TP8AYbPv7M/xnpMqQGbAlZlBhWOwmC2yGG3A6hwgiLM3eEh9vMxWLlyFJhb3MfbIh5JunYvesoKkrnqpumTSQLg/q6lAHxcK/p0r3VfANlqEUAnDtyu4UdfjyMpW5FLPI/k5m0jsFKDNPAgqmlNrCPdH12Xeuj3jUe3C8DjXFU09UY1pmLqjf+HL0ATM7gEIbCJUNgdevBnY20CdwTp8TKC4HUkMplfMb/5dnchKVAvahXd36Njnw+jLVSNxXSYQhNuIy+Ff1VIfg51CchLTcSD8GdjsDX7VLNvGStK6a0yCi5IpAAgFRoqGtemNuYC+L9alJDuYunSpvcCEQ6CDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2iXaKYcpojwnrJEWOnSSW7ZnRKOikzEu5I9prHAEvI=;
 b=XlCekHb8gJhlw4OUBGBgKOBkankcMizOcpeW40uR812LonD8HOtZtNVicre95Or1ShrA6XvZ0I+8bjrY9gxzZou4UXZZSG3Sk8pX04Zj9MGAy5Sqr5XXr/cEEpHDeLi8XaRj9C8JKl939vHAkFdelmVYb4GfPG/9I/DG0iJ8AOw=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB5775.eurprd04.prod.outlook.com (2603:10a6:803:e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 03:48:52 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 03:48:52 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Clark Wang <xiaoning.wang@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v14 08/12] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Thread-Topic: [PATCH v14 08/12] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Thread-Index: AQHXK33qCfWwNw4/xUOO1TZAKTLOhKs69jqAgAROBnA=
Date:   Mon, 12 Jul 2021 03:48:52 +0000
Message-ID: <VE1PR04MB668852203A2920C6C9E9E3CF89159@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-9-git-send-email-yibin.gong@nxp.com>
 <dfa12f89f112966197518aa8df25cb47d69b30f7.camel@pengutronix.de>
In-Reply-To: <dfa12f89f112966197518aa8df25cb47d69b30f7.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce3b9bfb-66b6-4492-6c0e-08d944e7f729
x-ms-traffictypediagnostic: VI1PR04MB5775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5775E0D64E5B766BBD15C59C89159@VI1PR04MB5775.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7HJuorwXJ5v6SUOPcFxJf3HJyu03QIT8/L+suDRBYXly8cjg5CfLyRFZy7EAxo7pdPHNjA31jRBhu5rAQF1KjZLi2ozqoSFqmEXw5rSpUctSMnncIArp+yvZGHPQMK1K1DC84eM/aTFRp4EDazKb+QHChTxrcx4/aw1K3I2GR8Jmdk1hR0UKh8Ld7angxXosV3Yw9x32zqd5sOWdYwxqw64w6z3pB8IRkldaBBnQZLz1CgnF3P4ujRFY0Z0CXrv2opWKwIiq/NoF8u1s7/OmLfTl3K3Ea2pa6rdHQLLf2J/1yqpiNKTGl4XMkXMZnutPeBJDckYXxv9kvNttTQQgjs72foRsqc/DDGeqTgWVnGOTcmHmPCbvD18QcRDi//yMWcW7iFt354CM5c8D3jz4PkOktpKww8FwJrL5ORcUzt6UT2S/YOnjSNXOQeZ0TX7C4SYyqhpBx9Lp0m4VvafplWBdcPdWwAnPEuoVL4QZ2MrFssFeV+I8iJOxssZjie7g7PCd3OajsEHc77t8xKPOrNpAad+bAZ2XtlSXBXyCWBqujooIF9XERmPbU4C2HkgBi5dt4QCMm+VP/hieScIhU1lrej+BEJOGphba9B5vu+V7oi/dmiolAGSjYXgDKyT1sa7Jpj1VOcQvsEez7VcgI1OWN2y5LVdH3IQ+yJbaI2SMpkc9+svr4A+vkBKKt+FarIGBkED0cq9WTDzKyyeNzi6NmBUt6+jxm468SSo4KZr7PN3yazvSHY0YDktfux4y1jj7DPaHblhSohoSoS8CHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(66446008)(26005)(921005)(478600001)(122000001)(76116006)(64756008)(86362001)(8676002)(6636002)(66556008)(66476007)(5660300002)(7416002)(55016002)(966005)(45080400002)(110136005)(4326008)(2906002)(83380400001)(71200400001)(8936002)(53546011)(66946007)(52536014)(7696005)(316002)(38100700002)(54906003)(186003)(9686003)(33656002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KUtXEDZuovOIwvuETkDTX8TAhqAVf20DmDG/WswNizyWUTm9kUGp1o3+q5xn?=
 =?us-ascii?Q?zaA98gOs7slFQQxgrVXWQkBw+/0Cwiqcp5Ud0wZ3ZULIdeTuJhHBvM03tkiw?=
 =?us-ascii?Q?lENUii+FZp07B0+6VqB6Am8LYZ8bSw52dF14GabUnYDMx24qtqhmsCTEcK9l?=
 =?us-ascii?Q?VvDJNEmu9czBUolt+Lj2Q+wemJL8DCb3N7v4hkvM1t/wyHDE6hjGNQ2j2IzL?=
 =?us-ascii?Q?eAJaQSJd7St6Zw/5P+6EISJ3aEiKKOJnIVx/6/Wya3KSnCQei4DtEXF908/K?=
 =?us-ascii?Q?TvFHTpAH5kqbh/pBYrtD1JkhAR1pGNpDYZ85dlYN+2e8HogxoBLJaYQJ+X5Y?=
 =?us-ascii?Q?jU6CeZ+v9awU+jZwnnQJ6iNpB8wB1h/L/lVR5XK0q/lXaKtT3cZCN7+lYtEU?=
 =?us-ascii?Q?/CEwTmOQ8tG57jOl80mEnM+pG3x/YmuIcjUNYSerIP8bO0VJmbW7AHQjasEJ?=
 =?us-ascii?Q?KqUkbUwUUanbRgb84utR9w0hPdkmh+rnx+d8R1n5SCRiN6itAfWOpyihEg52?=
 =?us-ascii?Q?8fH3SXL9Q6x2oF1xXQ6vKWjdkr2BTgLyuiY3QZRwA0+dImPc5ubab7R+PNJp?=
 =?us-ascii?Q?P6wvfDHz9vliU4gT9Ku/YykOYcQCYl1Y8AeBtWi8hnak0iV33zkXeFPQPzNJ?=
 =?us-ascii?Q?u1gvEo1pR7QxnQFb5P1AW/Dpec+lnmAdFHll71UY6orhUglf3JnNmtDce7Jd?=
 =?us-ascii?Q?TlKDDO4BhqoD1jPvNYk/xGrWuS9wa2i7u7jGyYKSe2QDwFuRLWZtt+6orqBT?=
 =?us-ascii?Q?rDPImwempX9lud2Cc1oYz61oTpnLITeo42LW4TPNMdmV3ziqCBZsKH8xETw6?=
 =?us-ascii?Q?hw/v0ijllnPLoQJnAL11paS+alhs0wKMdNTKEAzDqpCUpI/FVeTZ0D9ERKWH?=
 =?us-ascii?Q?tlU/GHVEa4YzYU+4uqUDU8i8bYoFpH3u0++YOkdM2EW+G3MdzrepPJaZbACf?=
 =?us-ascii?Q?QXQuEdDdNpft2LuuthDAaHI//K46ZOZhO64vIXKg3YgqYYWkjF1hllOtl7H6?=
 =?us-ascii?Q?ngNcsQb7GbGQqa4QsDBbe1QFWnepHjfsPV6FaeDWIaBmTpFeBUPlU1lq3XHl?=
 =?us-ascii?Q?AoXJpXtKh0LM36bOyvlNN7J8mkbD7am2SkniUf60bxcmSHwsCUux6FAc4WJl?=
 =?us-ascii?Q?rHanRQBKy1RluPRG7N3vA+94xdYKYclfEy/Zr5Efbrx6hHpwVd47iJblVR+y?=
 =?us-ascii?Q?sx2okL8zETsc9G2OdWNjm7uNzReHWPZjGZgV4/EuSKq26X4uhUyQ6p7NtBIE?=
 =?us-ascii?Q?7tB6vxGQg1FrYmB94xqMJE8gUI8A7Oqn0IOTWeBXyBoLxiPv00YA+M8GcKSn?=
 =?us-ascii?Q?2od0wMbuL5FiNV/nQK3aDrfj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3b9bfb-66b6-4492-6c0e-08d944e7f729
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 03:48:52.2618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jOgX96XGyw/XatAixKj6tyKwai8M8RcXBjN/R6N9RQ5tkXz1ormbbVpFkWHdRRQr6nAOriUJRjHPEuwMuJ9kbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5775
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 09/07/21 17:42 Lucas Stach <l.stach@pengutronix.de> wrote:=20
> Am Mittwoch, dem 07.04.2021 um 23:30 +0800 schrieb Robin Gong:
> > ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and i.mx8m/8mm
> > still need this errata. Please refer to nxp official errata document
> > from
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.n
> xp.com%2F&amp;data=3D04%7C01%7Cyibin.gong%40nxp.com%7C48156bc93d
> c84ac26e9d08d942bdc0ac%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C1%7C637614205017900475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
> mp;sdata=3DkeYQubzt1jWrKhaxXr40RL41vzFuIn7x1Sasa3p%2F9Xo%3D&amp;res
> erved=3D0 .
> >
> > For removing workaround on those chips. Add new i.mx6ul type.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > ---
> >  drivers/spi/spi-imx.c | 47
> > +++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 43 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > cf235b9..d18ee25 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -59,6 +59,7 @@ enum spi_imx_devtype {
> >  	IMX35_CSPI,	/* CSPI on all i.mx except above */
> >  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
> >  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> > +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
>=20
> This patch could be a lot smaller if you didn't introduce a new devtype. =
You
> could just use the IMX51_ECSPI in imx6ul_ecspi_devtype_data, as all you c=
are
> about as a relevant difference is the tx_glitch_fixed property, which isn=
't tied
> to the devtype.
I knew tx_glitch_fixed was enough but I still prefer to add new 'IMX6UL_ECS=
PI' because
we can clearly choose the right IP which has fix the issue while legacy IMX=
51 if it's not
fixed by dts.=20

> >  };
> >
> >  struct spi_imx_data;
> > @@ -78,6 +79,11 @@ struct spi_imx_devtype_data {
> >  	bool has_slavemode;
> >  	unsigned int fifo_size;
> >  	bool dynamic_burst;
> > +	/*
> > +	 * ERR009165 fixed or not:
> > +	 *
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.n
> xp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D04%7C01%7C
> yibin.gong%40nxp.com%7C48156bc93dc84ac26e9d08d942bdc0ac%7C686ea
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637614205017900475%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJ9iZb93uN1VEriN%2F2GAE
> TWxdv4n%2FD6ZXteMCFkB8KHM%3D&amp;reserved=3D0
> > +	 */
> > +	bool tx_glitch_fixed;
> >  	enum spi_imx_devtype devtype;
> >  };
> >
> > @@ -134,6 +140,11 @@ static inline int is_imx51_ecspi(struct spi_imx_da=
ta
> *d)
> >  	return d->devtype_data->devtype =3D=3D IMX51_ECSPI;  }
> >
> > +static inline int is_imx6ul_ecspi(struct spi_imx_data *d) {
> > +	return d->devtype_data->devtype =3D=3D IMX6UL_ECSPI; }
> > +
> >  static inline int is_imx53_ecspi(struct spi_imx_data *d)  {
> >  	return d->devtype_data->devtype =3D=3D IMX53_ECSPI; @@ -593,8 +604,14
> @@
> > static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
> >  	ctrl |=3D mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
> >  	spi_imx->spi_bus_clk =3D clk;
> >
> > -	/* ERR009165: work in XHC mode as PIO */
> > -	ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
> > +	/*
> > +	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
> > +	 * before i.mx6ul.
> > +	 */
> > +	if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
> > +		ctrl |=3D MX51_ECSPI_CTRL_SMC;
> > +	else
> > +		ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
> >
> >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> >
> > @@ -620,12 +637,16 @@ static int mx51_ecspi_prepare_transfer(struct
> > spi_imx_data *spi_imx,
> >
> >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)  {
> > +	u32 tx_wml =3D 0;
> > +
> > +	if (spi_imx->devtype_data->tx_glitch_fixed)
> > +		tx_wml =3D spi_imx->wml;
> >  	/*
> >  	 * Configure the DMA register: setup the watermark
> >  	 * and enable DMA request.
> >  	 */
> >  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> > -		MX51_ECSPI_DMA_TX_WML(0) |
> > +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
> >  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
> >  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
> >  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
> @@ -1019,6
> > +1040,23 @@ static struct spi_imx_devtype_data
> imx53_ecspi_devtype_data =3D {
> >  	.devtype =3D IMX53_ECSPI,
> >  };
> >
> > +static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data =3D {
> > +	.intctrl =3D mx51_ecspi_intctrl,
> > +	.prepare_message =3D mx51_ecspi_prepare_message,
> > +	.prepare_transfer =3D mx51_ecspi_prepare_transfer,
> > +	.trigger =3D mx51_ecspi_trigger,
> > +	.rx_available =3D mx51_ecspi_rx_available,
> > +	.reset =3D mx51_ecspi_reset,
> > +	.setup_wml =3D mx51_setup_wml,
> > +	.fifo_size =3D 64,
> > +	.has_dmamode =3D true,
> > +	.dynamic_burst =3D true,
> > +	.has_slavemode =3D true,
> > +	.tx_glitch_fixed =3D true,
> > +	.disable =3D mx51_ecspi_disable,
> > +	.devtype =3D IMX6UL_ECSPI,
> > +};
> > +
> >  static const struct of_device_id spi_imx_dt_ids[] =3D {
> >  	{ .compatible =3D "fsl,imx1-cspi", .data =3D &imx1_cspi_devtype_data,=
 },
> >  	{ .compatible =3D "fsl,imx21-cspi", .data =3D &imx21_cspi_devtype_dat=
a,
> > }, @@ -1027,6 +1065,7 @@ static const struct of_device_id spi_imx_dt_id=
s[]
> =3D {
> >  	{ .compatible =3D "fsl,imx35-cspi", .data =3D &imx35_cspi_devtype_dat=
a, },
> >  	{ .compatible =3D "fsl,imx51-ecspi", .data =3D &imx51_ecspi_devtype_d=
ata, },
> >  	{ .compatible =3D "fsl,imx53-ecspi", .data =3D
> > &imx53_ecspi_devtype_data, },
> > +	{ .compatible =3D "fsl,imx6ul-ecspi", .data =3D
> > +&imx6ul_ecspi_devtype_data, },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, spi_imx_dt_ids); @@ -1604,7 +1643,7 @@
> static
> > int spi_imx_probe(struct platform_device *pdev)
> >  	spi_imx->bitbang.master->mode_bits =3D SPI_CPOL | SPI_CPHA |
> SPI_CS_HIGH \
> >  					     | SPI_NO_CS;
> >  	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
> > -	    is_imx53_ecspi(spi_imx))
> > +	    is_imx53_ecspi(spi_imx) || is_imx6ul_ecspi(spi_imx))
> >  		spi_imx->bitbang.master->mode_bits |=3D SPI_LOOP | SPI_READY;
> >
> >  	spi_imx->spi_drctl =3D spi_drctl;
>=20

