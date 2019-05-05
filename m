Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3590E13E7B
	for <lists+dmaengine@lfdr.de>; Sun,  5 May 2019 10:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfEEIr2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 May 2019 04:47:28 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:2373
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfEEIr2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 5 May 2019 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNiPbiKvG7sc8mfwtkCxIBS/s1hGV/4jVXQOz6oGqwM=;
 b=vd2uRRSbbKu6m0HvyK39sUDYrErM9mZF/PVDvlw9CGiUT1GCwLXmn0tScr5x4E8QEaQKQA/lQRwAsGK5iDzSeslJVpdUSMyg42SzIfqkufnY08jcNkfp1UlqsU5Ec5vh8sPQS3B/r96EsSW0AIqGoyQjseM6zhed3VZxrc24C20=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Sun, 5 May 2019 08:47:21 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1856.012; Sun, 5 May 2019
 08:47:21 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to
 state errata fixed
Thread-Topic: [EXT] Re: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to
 state errata fixed
Thread-Index: AQHU/AbdFQmcRuAKXkaLI1VIJjs4JKZXcSqAgATPDJA=
Date:   Sun, 5 May 2019 08:47:21 +0000
Message-ID: <VI1PR04MB45436B23E821F02C43502D6489370@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
 <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
 <20190502065939.nyejomrsowhy6xox@pengutronix.de>
In-Reply-To: <20190502065939.nyejomrsowhy6xox@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02b9b252-5656-4069-7b6a-08d6d13649d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5726;
x-ms-traffictypediagnostic: VI1PR04MB5726:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB5726228FDED2E3FD4AA2318D89370@VI1PR04MB5726.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00286C0CA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(66476007)(26005)(966005)(86362001)(76176011)(33656002)(71200400001)(53936002)(7696005)(99286004)(54906003)(110136005)(316002)(76116006)(66446008)(3846002)(6116002)(14454004)(2906002)(71190400001)(102836004)(486006)(256004)(478600001)(6506007)(186003)(45080400002)(11346002)(476003)(446003)(6246003)(7416002)(305945005)(66066001)(66556008)(73956011)(66946007)(7736002)(64756008)(81156014)(8676002)(8936002)(81166006)(66574012)(6436002)(5660300002)(229853002)(68736007)(25786009)(52536014)(74316002)(6306002)(55016002)(9686003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5726;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ghO9q0RUs6b75rFcaautwLcgop2NAXoYbsrt0+S2R5pA/Vu9nCjaykMTWs8dPpMUszXegteHkXuQTefN26guBLDgSa6z2VLfPr+twMgTKGZwJ5h2RZIIK7wTs3Mh6XlSVuPa66nI917T6AW5ptk5qPBFukDwOnfJzPIaPcIbYEUCtz3jYue1uPuMxhMkak/3fQQQL1Qav9nZN2yDg0tuFI5mV89D4Ih5cLmDB351mIlBeZB1N0sKjnOwUNyBwrpn5dCAOhKFbBFt4G5kJEtlDjNw2Awm/tqd1wL5l7tg/KchDYotQrCjPIVWYBA+r5FU7koT+MK4R4zkr7pmsavBIzfijEyFgesEjthEWIi8mKiRnc8Mu8YYGSs0MVXFJWeCOseeFGGy6EVp3lxKcm4qSuNnA8Bi48iaFEeXLEbVWhU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b9b252-5656-4069-7b6a-08d6d13649d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2019 08:47:21.5242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5726
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> On Fri, Apr 26, 2019 at 08:05:51AM +0000, Robin Gong wrote:
> > ERR009165 fixed from i.mx6ul, add it to show the errata fixed.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > index 2d32641..32c4263d 100644
> > --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > @@ -10,6 +10,8 @@ Required properties:
> >    - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.M=
X35
> >    - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.=
MX51
> >    - "fsl,imx53-ecspi" for SPI compatible with the one integrated on
> > i.MX53 and later Soc
> > +  - "fsl,imx6ul-ecspi" ERR009165 fixed on i.MX6UL and later Soc
> > +
> > + (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
w
> > +
> ww.nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01
> %7Cyi
> > +
> bin.gong%40nxp.com%7Cc36708a8219843ffe1d308d6cecbc512%7C686ea1d
> 3bc2b
> > +
> 4c6fa92cd99c5c301635%7C0%7C1%7C636923771907346428&amp;sdata=3D9e
> 8c8GK2
> > + hSE90rzyArm8elog9dwNqn4Jeoeff79XwI4%3D&amp;reserved=3D0)
>=20
> I wouldn't mention this errata in the binding documentation. Just state t=
hat
> fsl,imx6ul-ecspi is designed to be used on i.MX6UL. And that it might als=
o be
> used on later SoCs as a "fallback compatible" is a detail that is so comm=
on that
Eh...Maybe add one flag member in 'struct spi_imx_devtype_data' to state er=
rata fixed
is better?=20
> I would expect it not being worth mentioning. So for me it would also be =
OK to
> drop "fsl,imx53-ecspi" from the list as this is only used like:
>=20
>         compatible =3D "fsl,imx53-ecspi", "fsl,imx51-ecspi";

>=20
> (But note that I have no authority here.)
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7Cc36708
> a8219843ffe1d308d6cecbc512%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C1%7C636923771907346428&amp;sdata=3DMcF9ueExCPpCq5Nxa6iJ9h53
> 9d9fO4DIW2IaS90ZdpQ%3D&amp;reserved=3D0  |
