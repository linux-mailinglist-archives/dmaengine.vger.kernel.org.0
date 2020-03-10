Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E6817F228
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCJInR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 04:43:17 -0400
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:11517
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbgCJInQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Mar 2020 04:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haHVO2di8NNLviFOo/SUP4qe830pgrhALXNyZUpkIfm0fksNNhxuSvOLWXLywtNxdPw38vXmRYyBE8UTY/0/30Wr8PmpLfNR2aVhueakFNcj3246S1ugGPPY8KK8Fog3pjIMmTeq+nIwG1NdTW9H3LosOFfrSzasyOc/hNJd6nDf6URIkGHx+Jfn4KvP8Ej/g1x0MU4R9oKMv9gtRL4SyEsj4UZHcwponNjqPO9jXGYmXktKplDUdYRPTAv9UqvuNqrR08nBt4RXPliheSaMtC46cyUgAoYmIhuSyajaCYC0QzQ3GvxrZGMQzinjImK1U/Mrafw9EeFbp9QiF5CLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnfkJ/k4wd00NZOVQx8YQu1E7BMnrnwcruoNVQQZJZY=;
 b=IaXAtkG5rAaXqzDPWQ7pbZDMLhhe2Xn8wbR776830FsfwbjY4mrokt3LoaEu78DSyaT2AoiQOvLcgIIb5qsyGvyEvHb2ZOljng9LestH92A/pFY77MAer0qsNp0sdmSFzVNUmg+gmo/7/o5JKHnW0Ucnc8IILNbzcKnRp/3WhSiFQ/ZrViqGhyxQwlYhxEiadEM3rhHCHQKdUSEb3A7w5laM5ycmZvxMqVoZH6p9mk9TfkOBpSdKOcwXRqBxnmYBXyKex2DqzgNYUjX2/gG1rJpK2ywr08Yb8aMUlA5aXGEHsDyC1S5A+t8dX8DWARhhrC8r/ZKIxDmvqSFyg9Ju3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnfkJ/k4wd00NZOVQx8YQu1E7BMnrnwcruoNVQQZJZY=;
 b=ienBFuE/FLne81Z+fRSHMgQ3n9Krd5ZXMjx3VoRXDtd+frNitNQTMlnvb3tOU7HFtqMJQN9VmbrA1X9AUXPH/lEZrolnoU2Ie8zUdaMIuP6jB3tXrax/hJyPtXxWosCbp/pOCQVf13oLNI2du/bpwH5FNzrd9ky+xT9joyt+XOY=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6557.eurprd04.prod.outlook.com (10.255.118.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16; Tue, 10 Mar 2020 08:43:10 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 08:43:10 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RESEND v6  07/13] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Thread-Topic: [RESEND v6  07/13] spi: imx: remove ERR009165 workaround on
 i.mx6ul
Thread-Index: AQHV9oxbuHZ2XTzKaki/DoqL8Pfb26hBd3KAgAAG/XA=
Date:   Tue, 10 Mar 2020 08:43:10 +0000
Message-ID: <VE1PR04MB66384342F94C7B789C980F7A89FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-8-git-send-email-yibin.gong@nxp.com>
 <20200310080240.GS3335@pengutronix.de>
In-Reply-To: <20200310080240.GS3335@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ffb03ec-75d1-4e46-b110-08d7c4cf106d
x-ms-traffictypediagnostic: VE1PR04MB6557:|VE1PR04MB6557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6557128EB05EF1307B00E38689FF0@VE1PR04MB6557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(66476007)(66446008)(64756008)(66556008)(76116006)(52536014)(71200400001)(966005)(4326008)(478600001)(45080400002)(55016002)(33656002)(81156014)(81166006)(8676002)(6916009)(26005)(186003)(5660300002)(8936002)(7696005)(9686003)(66946007)(2906002)(6506007)(86362001)(316002)(54906003)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6557;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KAzY0N/PnvGehHrVUWf/7HAGmq44LEGa8icUGBqbQ26G2Vq5Kl7TGFXURfxIbK5nrMpwTKspSeT5gmT50WsJLWkR2dxIgcsdXKso/sa5fi+rxk+cFEKvKZlDsHvDmnzI71Pg5Xv52TqMHs38B2pSHr7YEW8TYwnNz0xTOxA38AuIDgqxgihbldKqqewDqD0IoGIbzUEDbHmxwvL0UL9ZRCVtmRVq4AWBkK4CBT4egj3C8iAOavsNUqiqQ3aojIoWc0CgMrk6I+3oUCfdnvXjr1nna4nrSwVBd4u94fDj5DpjLZ4PJiXJis+kzjDNCSctJf3VJ1F61XviA7mQxRXToG7wvxoBKdR8zEB/63PEbtfZoFwFNq0n0t6iAoVEZpClaYOetczLS3vY1uM6LuBCFXDOv3pSTTvUfMlyCMKz70OjglOgx4sF3s/FeR15Ux4tWVqQTTWAnjeOz34b2lXMej121cSZG6JE20vKPxp8TUa+E1lGVHyGLtQFQeVxbmu64PK+tveddzpiEEC2C182KQ==
x-ms-exchange-antispam-messagedata: qsHgGtntmm4vaFNAPyIlCPsyORvqoRl2HW8SkUsmfPDZa7umhX0EwN3Mga8ypgtfMjVL8ygwSI2/EAZXLs7Inp5S0etyxM1VYDSJc7zMFBhzDZs6C9UohCw+4B0N1LKjMz+2JVMdn+ntRDhuIHB2Yw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffb03ec-75d1-4e46-b110-08d7c4cf106d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 08:43:10.6164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2W28q8n/ADKJe9OtRwJAg7ptaP6U5HJ/pdPphHk0PKi2zx/8FgonQc9ElJkQCor0vZkNAOlmJTdM0ZCBKeUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6557
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Mar 10, 2020 at 07:31:56PM +0800, Robin Gong wrote:
> > ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and i.mx8m/8mm
> > still need this errata. Please refer to nxp official errata document
> > from
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.n=
x
> p.com%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7Cf73bfc11a68c4
> 2f5f6d308d7c4c96efa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C
> 637194241755109112&amp;sdata=3DxzIUP8qZkrlDXX0yjTcUNZB6zDrevTdHFg1o4
> PZZd8E%3D&amp;reserved=3D0 .
> >
> > For removing workaround on those chips. Add new i.mx6ul type.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > ---
> >  drivers/spi/spi-imx.c | 50
> > +++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 45 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > 842a86e..f7ee2ec 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -57,6 +57,7 @@ enum spi_imx_devtype {
> >  	IMX35_CSPI,	/* CSPI on all i.mx except above */
> >  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
> >  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> > +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
> >  };
> >
> >  struct spi_imx_data;
> > @@ -75,6 +76,11 @@ struct spi_imx_devtype_data {
> >  	bool has_slavemode;
> >  	unsigned int fifo_size;
> >  	bool dynamic_burst;
> > +	/*
> > +	 * ERR009165 fixed or not:
> > +	 *
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.n=
x
> p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7Cyi
> bin.gong%40nxp.com%7Cf73bfc11a68c42f5f6d308d7c4c96efa%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C1%7C637194241755109112&amp;sdata=3Dm
> uw4HL5nMDjREJwVd885Wrxka0moMaaZ%2BhJgsAgY3eo%3D&amp;reserved=3D
> 0
> > +	 */
> > +	bool tx_glitch_fixed;
> >  	enum spi_imx_devtype devtype;
> >  };
> >
> > @@ -128,7 +134,8 @@ static inline int is_imx35_cspi(struct
> > spi_imx_data *d)
> >
> >  static inline int is_imx51_ecspi(struct spi_imx_data *d)  {
> > -	return d->devtype_data->devtype =3D=3D IMX51_ECSPI;
> > +	return d->devtype_data->devtype =3D=3D IMX51_ECSPI ||
> > +	       d->devtype_data->devtype =3D=3D IMX6UL_ECSPI;
> >  }
>=20
> Erm, no. A i.MX51 ECSPI is a i.MX51 ECSPI and not a i.MX6UL ECSPI. If you=
 want
> to handle them equally somewhere then explicitly test for i.MX6ul *and*
> i.MX51 there.
But all i.mx6 chips including i.MX53 ECSPI are almost same as i.MX51 ECSPI,=
 and ERR00915 is fixed from i.mx6ul....
>=20
> >
> >  static inline int is_imx53_ecspi(struct spi_imx_data *d) @@ -585,9
> > +592,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data
> *spi_imx,
> >  	ctrl |=3D mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
> >  	spi_imx->spi_bus_clk =3D clk;
> >
> > -	/* ERR009165: work in XHC mode as PIO */
> > -	if (spi_imx->usedma)
> > -		ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
> > +	/*
> > +	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
> > +	 * before i.mx6ul.
> > +	 */
> > +	if (spi_imx->usedma) {
> > +		if (spi_imx->devtype_data->tx_glitch_fixed)
> > +			ctrl |=3D MX51_ECSPI_CTRL_SMC;
> > +		else
> > +			ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
> > +	}
>=20
> Changed again, but the PIO case still not honoured. This should look like
> 	if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
> 		ctrl |=3D MX51_ECSPI_CTRL_SMC;
> 	else
> 		ctrl &=3D ~MX51_ECSPI_CTRL_SMC;
>=20
Okay, will fix in v7.
> >
> >  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
> >
> > @@ -615,6 +629,8 @@ static void mx51_setup_wml(struct spi_imx_data
> > *spi_imx)  {
> >  	u32 tx_wml =3D 0;
> >
> > +	if (spi_imx->devtype_data->tx_glitch_fixed)
> > +		tx_wml =3D spi_imx->wml;
>=20
> That explains the variable introduced in the last patch, ok.
>=20
> I have the impression that splitting up 06/13 and 07/13 into two patches
> doesn't make it easier to review.
But 06 is a errata for all i.mx6 legacy chips, while 07 is for i.mx6ul and =
newer chips which have been already fixed the HW issue. I think two patches=
 are better. =20
>=20
> Sascha
>=20
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7Cf73bfc11
> a68c42f5f6d308d7c4c96efa%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C1%7C637194241755114106&amp;sdata=3DDKe%2B2SynMv%2Be3rMBrO79ou6
> 5ADTwO03KRT%2FqsDbCWjc%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
