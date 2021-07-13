Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980133C6CFD
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhGMJP3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 05:15:29 -0400
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:40272
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234397AbhGMJP3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 05:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHrnbj50rzq9+giu1eiWGMOAB1l8J7mP2Np28mnmf7+k7oWjHBTCOXa6BUZCZ3C8dvk4Mim9iASJ1K25/hQ2LzIN5NA146cEvlzV/HUgAfo2KlsC/X46yVQDNrvWE4Rm2pQWX4l7b3AkftS4HPd34IObe1c2QWvbK9ArOYpyBS00NGn56dqiRjQbMJVfFglV42MpumjrN1diRo/LG/7HtdH2w87jsnA4us/NhMV1fbKQZPJUko0GtofyFi/uh7vZVeDpjgSfVTv1iiuH0UAp+0lDvkie9Vy4VItR+sRBHUPbn7RkraZbf0IOMoDZhd9z+gWDwxk8/gd3BU6F8/Q8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=298wsyePyTswRo1CYoBZa7dKKYkFTI/PXewir46n6mc=;
 b=bYEQL+YxhGlqD4beYhO0at4sVOo2iBrPZy2BHPXlvZzaKn2qIH/IkCqh0DRowcZwS8USr5hU83ff4yrjb+huRhoSDMb6mr8PuJAW+pl5ljjH9cllgH3ie7VzoPTXGFrHLIVQ9QJRqZYx80cyTh99faEqabkU56MoDm2fEuRN99m+KVbEy9FolryQJu78pqmPlrzCrwFgqquK8K5t2dnN6FrE8dqz8gVB1tjsyrBL/IgEtUYbYkq/CeZv67X2X2QqX7/cdCQzbMi0+5fBYonZdJD8Jj46RGVfkPilwtTiijhJ6atQitATk+PoFPvfcMhjOLXNfXdm01I7olM5mvAxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=298wsyePyTswRo1CYoBZa7dKKYkFTI/PXewir46n6mc=;
 b=LXaH+djb2fFgjD2YGm3TSt4fj0C5+NRYqycsp0fPF3XQAIKxDbHbq8le9U66rP8ZEK3itqGvvKWKEUJY7HU7PL+42u+D0hu2SYxA+PFjivLW3VSHqqiez8QyGAfzJRNcN5wlTXw9wcFFzmY+NI64HfpCQzcXCvyj21eCSNzWHq8=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0402MB2781.eurprd04.prod.outlook.com (2603:10a6:800:ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 09:12:36 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 09:12:36 +0000
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
Thread-Index: AQHXK33qCfWwNw4/xUOO1TZAKTLOhKs69jqAgAROBnCAAGYBAIAAAl1w
Date:   Tue, 13 Jul 2021 09:12:35 +0000
Message-ID: <VE1PR04MB66889D0BC546DE2580BF614089149@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-9-git-send-email-yibin.gong@nxp.com>
         <dfa12f89f112966197518aa8df25cb47d69b30f7.camel@pengutronix.de>
         <VE1PR04MB668852203A2920C6C9E9E3CF89159@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <7ca4554c58908618705768e01239409d19f83d17.camel@pengutronix.de>
In-Reply-To: <7ca4554c58908618705768e01239409d19f83d17.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ceac95d-f94d-483e-74c6-08d945de5afc
x-ms-traffictypediagnostic: VI1PR0402MB2781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2781CA5A5286E279F0DBD8E589149@VI1PR0402MB2781.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ke/DWHNuJ56zkofXvbSiIcJujAuyzt4zWbf9Df1X14sIk8AStGfpkoNwwKdhB+f+J0PAoW4Mwm7YECjrMco/L/vIdTR9zKom0b45FuZjTMavXXIqJO8z3YyQl9Dn57Hi9BjjIvC3786KsPfl8MuEOonVdpc2z+WKteDSyJbZpaKJuaE6b0LyVj0yWmQjVNwk5h9GYHQHjib0Vg5G84zrPZmXa0/NebpN3jPQ4bPdrVthQotNMmg3J4fa5UGpNIOmu++jwSvqpdomKF5nvVuyEAZJrhEqXh904ZwGRYytYWL0e+lNGs0UkPruicc0iU7fysvWtS3LlfEY4wv3c+jLCyKf1Or3IGm+4Hoxwrru82eThHyrav9gtGyJ07wEaEveFyssx0a1DLU64F/ShM6bVBMrj4P4xNNPneSc0c+C2hSL1Fj+ukt5W2V9KY0S0m+MHeF4UcZkAFbuiMghmi1u1+WWrV+c+apxU/kvGj6u/i/pjMHCslIMxD3Qpev1h7+daM13d+WF1LbxgbACVJl+qYG8nCd3jKIXwKBeRQ5rdWPBhLg3xoouMKDvTlLiUocvU1F7AV/6+x37GEriE194tF+9cMesZPZVvjUT6oFl4PZfVmv/qGQQsUxJsgcVM3e31tCdxgRiFOiJ4orYzRysQ7xmiHOqE5WpBn7USR9M0L3q4kzXx7LA/pO1+21m3hpaGcs8yUTYIRwHCXJRl0lv1Ayv/7I/7vwasAZOB+c4B44WZQQbLtTDmEJWRcjXNfVp/25bpoyZAr/QaJtdC2XF9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(66446008)(7696005)(83380400001)(66946007)(9686003)(55016002)(54906003)(966005)(122000001)(76116006)(71200400001)(5660300002)(7416002)(478600001)(45080400002)(52536014)(64756008)(66476007)(66556008)(2906002)(38100700002)(86362001)(53546011)(110136005)(8936002)(6506007)(33656002)(921005)(26005)(316002)(6636002)(186003)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MSJCCdQpsXq1lR5pWr6NFQ/kUNmlQPhST/X0sZ4aIF/tkYevEk7dS7xdPAjg?=
 =?us-ascii?Q?27eIJCB4Sukuqmuznt9fSk8JEk9dAxYtjYo+EGtDMYNhxsgdoqimtEYrk710?=
 =?us-ascii?Q?wM1cQ03KBLd4UsqYERj+Q6tqN1Q1qdzkhaSimr1AW72rwwd1rw4y9LzM/z7g?=
 =?us-ascii?Q?XSGVyVH+NzIU9plK7putAgseMy65X4cC1320ERz3xQCSL6NnZ4xWEKI8tAMX?=
 =?us-ascii?Q?2QdV6u9cuLFja5FvAolp5JH6GGKuLluw9yDOHZqUWjd2m/heuFwdIHvNQYjS?=
 =?us-ascii?Q?Q1rSiBQoTKj/tozjp18gaNyzylGenZTe5RlgnEkn3vUUacfft2e+nwi+oO3h?=
 =?us-ascii?Q?JFSjHfZz0arFU++oCMn/2F1AQi1HeqxaE0rKfwsOLFBE7ylT3+n3mzEEvAYl?=
 =?us-ascii?Q?y0Kp6txKdEXmUi8wS0WXGwUFOZvHE/MB05bex8Hi1MVp4sOF8ugeHsmUVHTk?=
 =?us-ascii?Q?T5xn409EyEnZMcXaPmjprxj6KnwJsM2UF78vAxu8Qu/VMWG1pmKXZb6rv7hS?=
 =?us-ascii?Q?RD2KFZgCdb9h1m3XE+rGD0PZeCHuVnjx7NR4TdBKBHDDye/L9CgCjAWPQHlW?=
 =?us-ascii?Q?Ss8LW0K+A5+sGPWoXVXvLgEFhddzKkOWBB5zNz5u0p3Nuh3WIQruxpQM4XzN?=
 =?us-ascii?Q?X/YiNQxa/uwa870cs4t4TAk2P5+Z8ALX0zaNkESOFMArEATTfKN0FGrUazcs?=
 =?us-ascii?Q?gFZWbJSetogrhR8jBZ97G68jO3CMkQzElFioBuj68PvEgmPjYyjd8p9kBa4U?=
 =?us-ascii?Q?dC9PRarzxIMCha4Qu5RvCBxRH3ZXNnca07cP0jeLjsFnrScTbiVRr784lm+u?=
 =?us-ascii?Q?BcOdSxCEUKlGFZS8dXLPuEYjRMaaE+WrL1a1FDrpyje7RCMm/XgUo48gbCHf?=
 =?us-ascii?Q?Z8xfHcNdDKxdSut9p57u7ZjkUCqtRi45ctIlg+fFTUswIP7CaCnlTtoXDJ97?=
 =?us-ascii?Q?2N3Mu1CksDKdu4HXG+7y4EDP5po9clNCXl3NldoZNDDEWcN/BlIVnM9/vyiH?=
 =?us-ascii?Q?6q6EMgql3OZYMh57Q86PV8EXWC+teP+tI/2IYVielnwKXxuu/rPeueeXA9oQ?=
 =?us-ascii?Q?GJtq2Uprqp4r3ZnvrTEKbMsiNTLF50EIKiuufPZxSGAIyDI14mxufRTYwgui?=
 =?us-ascii?Q?DezLN8+BmmT7+Fr6dgpirWiK7CRjFT2As2jGo6woad48huJLNVyI/eHSsbGM?=
 =?us-ascii?Q?UQJR1OhNSDYp7At9J7dm03f1AWVLOudu5FkkMdPVn6aEju4raa9rh6ma+HQc?=
 =?us-ascii?Q?7d13vO0aXm2IntzPUbdF8qnA1+YN9/f3saQ0ZsjRt6JRiioCtpsao5GbJpIa?=
 =?us-ascii?Q?lwA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ceac95d-f94d-483e-74c6-08d945de5afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 09:12:35.9657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwaqhK+HbLKoBdQrZEruijOnBqPvj2IZmBtSdxGHQRIm5lKylZw0kn0qkD54WSkBh7bMoXMJkc39uIWgcSxfZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2781
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/07/21 17:31 Lucas Stach <l.stach@pengutronix.de> wrote:=20
> Am Montag, dem 12.07.2021 um 03:48 +0000 schrieb Robin Gong:
> > On 09/07/21 17:42 Lucas Stach <l.stach@pengutronix.de> wrote:
> > > Am Mittwoch, dem 07.04.2021 um 23:30 +0800 schrieb Robin Gong:
> > > > ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
> > > > i.mx8m/8mm still need this errata. Please refer to nxp official
> > > > errata document from
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
w
> > > w.n
> xp.com%2F&amp;data=3D04%7C01%7Cyibin.gong%40nxp.com%7C48156bc93d
> > >
> c84ac26e9d08d942bdc0ac%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> > >
> 7C1%7C637614205017900475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > >
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
> > >
> mp;sdata=3DkeYQubzt1jWrKhaxXr40RL41vzFuIn7x1Sasa3p%2F9Xo%3D&amp;res
> > > erved=3D0 .
> > > >
> > > > For removing workaround on those chips. Add new i.mx6ul type.
> > > >
> > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > > Acked-by: Mark Brown <broonie@kernel.org>
> > > > ---
> > > >  drivers/spi/spi-imx.c | 47
> > > > +++++++++++++++++++++++++++++++++++++++++++----
> > > >  1 file changed, 43 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > > > cf235b9..d18ee25 100644
> > > > --- a/drivers/spi/spi-imx.c
> > > > +++ b/drivers/spi/spi-imx.c
> > > > @@ -59,6 +59,7 @@ enum spi_imx_devtype {
> > > >  	IMX35_CSPI,	/* CSPI on all i.mx except above */
> > > >  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
> > > >  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> > > > +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
> > >
> > > This patch could be a lot smaller if you didn't introduce a new
> > > devtype. You could just use the IMX51_ECSPI in
> > > imx6ul_ecspi_devtype_data, as all you care about as a relevant
> > > difference is the tx_glitch_fixed property, which isn't tied to the d=
evtype.
> > I knew tx_glitch_fixed was enough but I still prefer to add new
> > 'IMX6UL_ECSPI' because we can clearly choose the right IP which has
> > fix the issue while legacy IMX51 if it's not fixed by dts.
> >
> Sorry, I don't follow this reasoning. You are not using the new IMX6UL_EC=
SPI
> devtype in any way in this patch, other than a single location, where you=
 just
> handle it the same as the IMX51_ECSPI devtype.
Okay, will reuse IMX51_ECSPI as devtype, but will still keep "fsl,imx6ul-ec=
spi".

>=20
> >
> >
> > > >  };
> > > >
> > > >  struct spi_imx_data;
> > > > @@ -78,6 +79,11 @@ struct spi_imx_devtype_data {
> > > >  	bool has_slavemode;
> > > >  	unsigned int fifo_size;
> > > >  	bool dynamic_burst;
> > > > +	/*
> > > > +	 * ERR009165 fixed or not:
> > > > +	 *
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
w
> > > w.n
> xp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D04%7C01%7C
> > >
> yibin.gong%40nxp.com%7C48156bc93dc84ac26e9d08d942bdc0ac%7C686ea
> > >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637614205017900475%7CU
> > >
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJ9iZb93uN1VEriN%2F2GAE
> > > TWxdv4n%2FD6ZXteMCFkB8KHM%3D&amp;reserved=3D0
> > > > +	 */
> > > > +	bool tx_glitch_fixed;
> > > >  	enum spi_imx_devtype devtype;
> > > >  };
> > > >
> > > > @@ -134,6 +140,11 @@ static inline int is_imx51_ecspi(struct
> > > > spi_imx_data
> > > *d)
> > > >  	return d->devtype_data->devtype =3D=3D IMX51_ECSPI;  }
> > > >
> > > > +static inline int is_imx6ul_ecspi(struct spi_imx_data *d) {
> > > > +	return d->devtype_data->devtype =3D=3D IMX6UL_ECSPI; }
> > > > +
> > > >  static inline int is_imx53_ecspi(struct spi_imx_data *d)  {
> > > >  	return d->devtype_data->devtype =3D=3D IMX53_ECSPI; @@ -593,8
> > > > +604,14
> > > @@
> > > > static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx=
,
> > > >  	ctrl |=3D mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
> > > >  	spi_imx->spi_bus_clk =3D clk;
> > > >
> > > > -	/* ERR009165: work in XHC mode as PIO */
> > > > -	ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
> > > > +	/*
> > > > +	 * ERR009165: work in XHC mode instead of SMC as PIO on the
> chips
> > > > +	 * before i.mx6ul.
> > > > +	 */
> > > > +	if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
> > > > +		ctrl |=3D MX51_ECSPI_CTRL_SMC;
> > > > +	else
> > > > +		ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
> > > >
> > > >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> > > >
> > > > @@ -620,12 +637,16 @@ static int
> > > > mx51_ecspi_prepare_transfer(struct
> > > > spi_imx_data *spi_imx,
> > > >
> > > >  static void mx51_setup_wml(struct spi_imx_data *spi_imx)  {
> > > > +	u32 tx_wml =3D 0;
> > > > +
> > > > +	if (spi_imx->devtype_data->tx_glitch_fixed)
> > > > +		tx_wml =3D spi_imx->wml;
> > > >  	/*
> > > >  	 * Configure the DMA register: setup the watermark
> > > >  	 * and enable DMA request.
> > > >  	 */
> > > >  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> > > > -		MX51_ECSPI_DMA_TX_WML(0) |
> > > > +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
> > > >  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
> > > >  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
> > > >  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base +
> MX51_ECSPI_DMA);
> > > @@ -1019,6
> > > > +1040,23 @@ static struct spi_imx_devtype_data
> > > imx53_ecspi_devtype_data =3D {
> > > >  	.devtype =3D IMX53_ECSPI,
> > > >  };
> > > >
> > > > +static struct spi_imx_devtype_data imx6ul_ecspi_devtype_data =3D {
> > > > +	.intctrl =3D mx51_ecspi_intctrl,
> > > > +	.prepare_message =3D mx51_ecspi_prepare_message,
> > > > +	.prepare_transfer =3D mx51_ecspi_prepare_transfer,
> > > > +	.trigger =3D mx51_ecspi_trigger,
> > > > +	.rx_available =3D mx51_ecspi_rx_available,
> > > > +	.reset =3D mx51_ecspi_reset,
> > > > +	.setup_wml =3D mx51_setup_wml,
> > > > +	.fifo_size =3D 64,
> > > > +	.has_dmamode =3D true,
> > > > +	.dynamic_burst =3D true,
> > > > +	.has_slavemode =3D true,
> > > > +	.tx_glitch_fixed =3D true,
> > > > +	.disable =3D mx51_ecspi_disable,
> > > > +	.devtype =3D IMX6UL_ECSPI,
> > > > +};
> > > > +
> > > >  static const struct of_device_id spi_imx_dt_ids[] =3D {
> > > >  	{ .compatible =3D "fsl,imx1-cspi", .data =3D &imx1_cspi_devtype_d=
ata, },
> > > >  	{ .compatible =3D "fsl,imx21-cspi", .data =3D
> > > > &imx21_cspi_devtype_data, }, @@ -1027,6 +1065,7 @@ static const
> > > > struct of_device_id spi_imx_dt_ids[]
> > > =3D {
> > > >  	{ .compatible =3D "fsl,imx35-cspi", .data =3D
> &imx35_cspi_devtype_data, },
> > > >  	{ .compatible =3D "fsl,imx51-ecspi", .data =3D
> &imx51_ecspi_devtype_data, },
> > > >  	{ .compatible =3D "fsl,imx53-ecspi", .data =3D
> > > > &imx53_ecspi_devtype_data, },
> > > > +	{ .compatible =3D "fsl,imx6ul-ecspi", .data =3D
> > > > +&imx6ul_ecspi_devtype_data, },
> > > >  	{ /* sentinel */ }
> > > >  };
> > > >  MODULE_DEVICE_TABLE(of, spi_imx_dt_ids); @@ -1604,7 +1643,7
> @@
> > > static
> > > > int spi_imx_probe(struct platform_device *pdev)
> > > >  	spi_imx->bitbang.master->mode_bits =3D SPI_CPOL | SPI_CPHA |
> > > SPI_CS_HIGH \
> > > >  					     | SPI_NO_CS;
> > > >  	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
> > > > -	    is_imx53_ecspi(spi_imx))
> > > > +	    is_imx53_ecspi(spi_imx) || is_imx6ul_ecspi(spi_imx))
> > > >  		spi_imx->bitbang.master->mode_bits |=3D SPI_LOOP |
> SPI_READY;
> > > >
> > > >  	spi_imx->spi_drctl =3D spi_drctl;
> > >
> >
>=20

