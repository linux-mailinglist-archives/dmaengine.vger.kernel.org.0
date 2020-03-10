Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459CE17F3CB
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 10:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgCJJfq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 05:35:46 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:21852
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbgCJJfq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Mar 2020 05:35:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzVfako77uqb1HuH4c9OE2wEthMx73zeu5g63jyn9wptzvrqOPYvPTTR7R8K/SxdVC3qFQ173uX9SMjT4d8aTWzvkazehYFKt5GW4IB8SWGriWOqEPMq/FgQwgm8KqqHINfSuuBYJIGOKFyHOxh06jCY43VQy79fDGudJhmJEhUcJOKn3YQEg8QejKdGkstcTBHqQ6BRzaZdFtmPb0mA6P7WzXkNP8T+lBSprfk+YkUO4yHNbei/gHFInG5IUr3DkFU3yB08sMYyTSjQiDFpZMaRaX1BsEe1NWYdEpQnnSB8+qFURJMVzcls1kerkei60F8oaJ8xPxjYR9xo/ZEVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhmorSx/erpe5aXotBne0VkfIw2hsIV92G/Vp0qZ7mY=;
 b=g3k2uYaSHN0uVfwg0+KhNCye6CZ+CixXTi5o9LVdScobAnVtTwkUVXS1aKwMe7dqPe4mNU0g2by7pVLFw4BlyQUhvARX5TKnydincq9OQVHkfj8NuEoJiT1593VfTIbwwotFlvHn9r7aQ7YjpDEFSPG1HLMo9a3AhjlUOm4yZOtJoSsV5l9H5ulMLzkrbawbkvzgkQSNMUjt+B2qp3jsyQ5vyvXd3aXQNZKDGePDnGrbYy9mO7CNbNkoAeVHFiiN1oVHPTLUFSNTeRLVdMIJrx959xi1QfHhGAh+j1rOQrbmIdY8/4PKRUdnJWAab/8lwAm9AekkYcsppKy8wgRgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhmorSx/erpe5aXotBne0VkfIw2hsIV92G/Vp0qZ7mY=;
 b=PbD6WlosiKl+UUZYcAD/V5p4E0tBTOlQ1t2SuHhgNTeZIr+v0PGTw5pt6riW21p/+tnwCDNVNk0XhJ/xMZMdKDN5kgj4DCKzFjAXLTORnsrIl8SPV0H1jYzYpus4Bt+S9Zi1GKOJWi0QI41QDCGCxlt4mBN0w7y3mkluLpdxMYc=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6431.eurprd04.prod.outlook.com (10.255.118.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 09:35:40 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 09:35:40 +0000
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
Subject: RE: [RESEND v6  09/13] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Thread-Topic: [RESEND v6  09/13] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Thread-Index: AQHV9oxi9deJ9GVPPUGUNCzRt8EnOKhBfB+AgAAGp2CAAAyGgIAAAbGQ
Date:   Tue, 10 Mar 2020 09:35:40 +0000
Message-ID: <VE1PR04MB66388CC09E1D3AD956AF94CC89FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
 <20200310081925.GT3335@pengutronix.de>
 <VE1PR04MB6638029458AFDE3005C6E4A489FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200310092803.GW3335@pengutronix.de>
In-Reply-To: <20200310092803.GW3335@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a6f9f2d-f2c2-4102-3b37-08d7c4d665d6
x-ms-traffictypediagnostic: VE1PR04MB6431:|VE1PR04MB6431:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6431589F9F6366F3B1E7C19C89FF0@VE1PR04MB6431.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(478600001)(9686003)(45080400002)(64756008)(86362001)(76116006)(4326008)(66476007)(66946007)(2906002)(66446008)(8676002)(66556008)(6506007)(7696005)(71200400001)(186003)(966005)(55016002)(5660300002)(7416002)(6916009)(33656002)(54906003)(52536014)(26005)(81166006)(8936002)(81156014)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6431;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I/IoROG8ussx14TNZJWgEVQyY5sPhGvIszFcks272q3oc/KYud2MRgqmgrRKq8ZK2Yl/Xe8s03nBMA/TuZYhDRPfnD4OlWWhKzoWj/CyJfSjM0H78HrJcwkp91yXs/uL7Amb/fmGZos5bjyK+/dy+HtgUbFvil85NeebEc3txD8knpHatv32WY9UVQ69/HDWEn/wMwSFCD481sm3wRDZ0+v5KrPy04Vne4BN1pLR36ZiZGiV3VjZcuBi5H0zAMfNCOT9m8QSOURGpuAt9wpQifWXD2dEc6MWi5OduX248CfRo7fzKXa95jlDwarW5szEuWBKFaX4pwY2rjouK1TztE90iqLo/OGTIU1ZgM/r4arRsnOYQqD+k3PlkvsOXrIRkYu6BxmmDzn8fQ6rPUpJ5UZeACCeGzUgkYB3EyQNXV7R/okJi8Z0no6Basj9kUrTCkFBFnYTZeDOZmYTI85JtLBFmyyI8RyC0w4DESXRJN/2LFOF0zox4CtP5lk+BRNvXqeGTeEu9JPFdZtWul9KYbn/KuGOGbf5WK7qye3+bdaBb7ofXoXoTU6kACfzklzWEVl4PqRj6t1577w9bGp1S8mjfE6WSLNWmt3keKVtYYiUsJvI7MR/3mRKzdCOV0Z1
x-ms-exchange-antispam-messagedata: bMScxs1Cgus6uuyAIHEirnPBEXR661geVuDPjxVffYjq9jfqOBNLYELkaqxUAFLyBAuncgowdXADKRssxma5iSm8tTaHfv3HIepSDr3uE9VAZjP4jE+0/HlYDIFJz1oz+uu+HkKEIDlaE8uFgJiQVQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6f9f2d-f2c2-4102-3b37-08d7c4d665d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 09:35:40.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96pBSrYFQ3XRdbaFrrQo2lit20MsizORAz0paNEEugM7tbz6ja07rgwxXDZVGpQ4CYKZQfSIapYCEBCqcDEziQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6431
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Mar 10, 2020 at 08:59:03AM +0000, Robin Gong wrote:
> > On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > On Tue, Mar 10, 2020 at 07:31:58PM +0800, Robin Gong wrote:
> > > > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > > > ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx from
> > > > where i.mx6ul source.
> > > >
> > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > >  drivers/dma/imx-sdma.c | 51
> > > > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 50 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > > > 56288d8..5ae7237 100644
> > > > --- a/drivers/dma/imx-sdma.c
> > > > +++ b/drivers/dma/imx-sdma.c
> > > > @@ -419,6 +419,13 @@ struct sdma_driver_data {
> > > >  	int num_events;
> > > >  	struct sdma_script_start_addrs	*script_addrs;
> > > >  	bool check_ratio;
> > > > +	/*
> > > > +	 * ecspi ERR009165 fixed should be done in sdma script
> > > > +	 * and it has been fixed in soc from i.mx6ul.
> > > > +	 * please get more information from the below link:
> > > > +	 *
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fw=
w
> > > w.nx
> p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7Cyi
> > >
> bin.gong%40nxp.com%7C91d42046e6894501d48508d7c4cbcae2%7C686ea1d3
> > >
> bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637194251876090170&amp;sdata=3D
> > > T6LA4xz9CUFlNpnyjHSThEQb8i1rhbY9e1nUyxIGD5Q%3D&amp;reserved=3D0
> > > > +	 */
> > > > +	bool ecspi_fixed;
> > > >  };
> > > >
> > > >  struct sdma_engine {
> > > > @@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q =3D =
{
> > > >  	.script_addrs =3D &sdma_script_imx6q,  };
> > > >
> > > > +static struct sdma_script_start_addrs sdma_script_imx6sx =3D {
> > > > +	.ap_2_ap_addr =3D 642,
> > > > +	.uart_2_mcu_addr =3D 817,
> > > > +	.mcu_2_app_addr =3D 747,
> > > > +	.uartsh_2_mcu_addr =3D 1032,
> > > > +	.mcu_2_shp_addr =3D 960,
> > > > +	.app_2_mcu_addr =3D 683,
> > > > +	.shp_2_mcu_addr =3D 891,
> > > > +	.spdif_2_mcu_addr =3D 1100,
> > > > +	.mcu_2_spdif_addr =3D 1134,
> > > > +};
> > > > +
> > > > +static struct sdma_driver_data sdma_imx6sx =3D {
> > > > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > > > +	.num_events =3D 48,
> > > > +	.script_addrs =3D &sdma_script_imx6sx, };
> > > > +
> > > > +static struct sdma_driver_data sdma_imx6ul =3D {
> > > > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > > > +	.num_events =3D 48,
> > > > +	.script_addrs =3D &sdma_script_imx6sx,
> > > > +	.ecspi_fixed =3D true,
> > > > +};
> > > > +
> > > >  static struct sdma_script_start_addrs sdma_script_imx7d =3D {
> > > >  	.ap_2_ap_addr =3D 644,
> > > >  	.uart_2_mcu_addr =3D 819,
> > > > @@ -584,9 +616,15 @@ static const struct platform_device_id
> > > sdma_devtypes[] =3D {
> > > >  		.name =3D "imx6q-sdma",
> > > >  		.driver_data =3D (unsigned long)&sdma_imx6q,
> > > >  	}, {
> > > > +		.name =3D "imx6sx-sdma",
> > > > +		.driver_data =3D (unsigned long)&sdma_imx6sx,
> > > > +	}, {
> > >
> > > Now the i.MX6sx uses a new sdma_script_start_addrs entry which is
> > > the same as the i.MX6q one we used before with one exception: it
> > > lacks the per_2_per_addr =3D 6331 entry. This is only used for
> > > IMX_DMATYPE_ASRC and
> > Totally same script for i.mx6 chips whatever i.MX6sx, i.MX6q or i.MX6ul=
.
>=20
> When it's the same then use it.
>=20
> > > IMX_DMATYPE_ASRC_SP, both are entirely unused in the mainline
> > > kernel. So why must the i.MX6sx changed here and what has this to do =
with
> ECSPI?
> > i.MX6ul is based on i.MX6sx, so adding i.MX6sx could keep good shape on=
 our
> i.MX family evolution.
>=20
> My point is that there is no difference between i.MX6q and i.MX6sx here, =
so do
> not artificially introduce i.MX6sx support when all you do is copying the=
 i.MX6q
> support.
Okay, will remove i.MX6sx now.
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C02af95d
> 81bf745b7b2cc08d7c4d55ed2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C637194293001547060&amp;sdata=3DcN13LuC6Bgs1m9W6oKc2q03j5rf
> KvsMbonpd1JALA%2Fk%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
