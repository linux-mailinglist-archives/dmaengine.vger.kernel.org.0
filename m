Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B68A17F281
	for <lists+dmaengine@lfdr.de>; Tue, 10 Mar 2020 09:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgCJI7K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Mar 2020 04:59:10 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:33184
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgCJI7K (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 10 Mar 2020 04:59:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e96rwsfPqrOD1urrUD3KaHVj31wkCsfELC6xpTpT4pvkbtmKD9U/2pC0ac+TjpZ0EoxZE02heUkPmLiuxr9/0bNlBgoUhW7+g6LQKSpONQUxVdCNDC5GxSb+hIhKay8tqCjK4co+Zm8elRATCwegU3hMgY6n+uimXk/2+r9zXbKSPF03OiLlnYK8kAK/DuLELsPAs9VT2MTtKIEDZuLTNgI+ayDEfMU0Iyosnng4oGiQhJDXPrRduHMSES/YXSKGRldDizJndvxJ3WejK7Ph3sTVbA9Cml4/1Lk+mHFj5kIT9owDLggcSsKRIlWwsb4x9ACrkOVNzNO9hIYCfcQ8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugHTLhGlBTEfeaP/oV0xlnhckQhEFqENdUJ9010PM5k=;
 b=YVi7Ge/auli/++oZPVYdqiZRN6YLm+gXQfPgNPQesgooNUu4l+IyBvuG49Zr6UccKGljmOgyA9xyYdE3mjYVhzoBKu9WLTlSmdBXJ6dQmygKyA5EDFDtO6F/ue3SUm6ErqOxsyCJkb3sUVqURLtKutWloIzNX/RUM2soxmNv4y49bsz3wPGobvENXbfsJMeEvE/JekSJ/3cxsoMzsCVm1P6WRck07KCoYxzvLFuuBC6oiYDT+RL5X//VpXmOwPkfBOU0HAvBWFhoJnV27Gtk34qMzKeNc9BgP5jgfknztff6nOCy+c8MZrOYr9gggUqaIWOqhZib02M7zfZLBMGx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugHTLhGlBTEfeaP/oV0xlnhckQhEFqENdUJ9010PM5k=;
 b=AdC43ylwGcEZwQeniVK3KzmiOMhPYufnO6n0ojyw26PRWgXHVBZ2V3BxJ5cAi4BFZuG4fQ3ka2hywkjSaFAwaV/Sd8Iy85EWGZtp0pmuNMYPTi/xqwm71Su8JrJ1FC40xJaiec/vCyDhoJNiCb8O/YuVYXgy3ifmGsXDCQI6kbQ=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6749.eurprd04.prod.outlook.com (10.255.118.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 08:59:03 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 08:59:03 +0000
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
Thread-Index: AQHV9oxi9deJ9GVPPUGUNCzRt8EnOKhBfB+AgAAGp2A=
Date:   Tue, 10 Mar 2020 08:59:03 +0000
Message-ID: <VE1PR04MB6638029458AFDE3005C6E4A489FF0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-10-git-send-email-yibin.gong@nxp.com>
 <20200310081925.GT3335@pengutronix.de>
In-Reply-To: <20200310081925.GT3335@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 653da096-f08a-461d-76b2-08d7c4d14819
x-ms-traffictypediagnostic: VE1PR04MB6749:|VE1PR04MB6749:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB67498569032F3046013F363D89FF0@VE1PR04MB6749.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 033857D0BD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(81156014)(66476007)(8936002)(64756008)(66556008)(66446008)(76116006)(66946007)(8676002)(54906003)(186003)(71200400001)(26005)(7696005)(316002)(81166006)(6506007)(4326008)(7416002)(478600001)(966005)(45080400002)(2906002)(6916009)(33656002)(52536014)(5660300002)(86362001)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6749;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8v00ssN6BGfgXaoMy/LkN4iLJAJ7eTYJPBa/pVT2ysS643zFvbYNyV1BpEBWRDQ17ioRhpLd8SgbZdHPz3mkz0chvXSJSU51NReCpuI6cgruiMX92u7SUrKq1/0pPJUDs2LD+q65S3o4Kbm/bdMLiwLqW0Dcz9ugdBWIMwwmvQ+agzwCk95hq+UylIVzST4guMXnnbLEsJ8LdhVT5dBrxqmWmnTmBhOgQMlH7dgXvWQVDsrhADcMgPA9FJOXZtHLCtpX05CYYNO/4K18gpGbmtNmKppQAL8dk4TpiYsTvY327qtO7dNxSVbH87rpFS4mOJ0TowHytXZucAwwXU+1lV55oD32JDnSPExjzzSUZOeVW0v1q4rfJhuTE1HqUqLcbHr+Q/J+YFjZ1LdoE0jpb5P9MbbeYJ61a+VcxMh5aodQczl/jyfXqGjbtEaW7oeb2EettrActHH0li+jFUaJaK029Yfh+JiVN1dXFufabVv4bpPoj5ggqgfWWMmwxpNwv+f0/T71HAILMhjB048fA==
x-ms-exchange-antispam-messagedata: oa4NusZbqKQqRKRiKVKnOJUIr8hrTHn/lhgPBmfpKAp4OOx3iBvAvDMAlTZ16I0Q6iWgwO+GSGarXxdV+410VxJzvvKTa1fMh6f78bEAVyCUfhgn8LyNuMWnVvXsU2pZlOBEJibE/wsXnHCt+YAqfQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653da096-f08a-461d-76b2-08d7c4d14819
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2020 08:59:03.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNv+FCPOiz243tzKQ5R1APxgg6RTfGjZUfAe0hGK6xwiOZOEy0Jewquz7vp72LsN5NIeg23PuaNfkMSwyhMiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6749
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/03/10 Sascha Hauer <s.hauer@pengutronix.de> wrote:=20
> On Tue, Mar 10, 2020 at 07:31:58PM +0800, Robin Gong wrote:
> > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > ERR009165 anymore on those chips such as i.mx8mq. Add i.mx6sx from
> > where i.mx6ul source.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/imx-sdma.c | 51
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > 56288d8..5ae7237 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -419,6 +419,13 @@ struct sdma_driver_data {
> >  	int num_events;
> >  	struct sdma_script_start_addrs	*script_addrs;
> >  	bool check_ratio;
> > +	/*
> > +	 * ecspi ERR009165 fixed should be done in sdma script
> > +	 * and it has been fixed in soc from i.mx6ul.
> > +	 * please get more information from the below link:
> > +	 *
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.n=
x
> p.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01%7Cyi
> bin.gong%40nxp.com%7C91d42046e6894501d48508d7c4cbcae2%7C686ea1d3
> bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637194251876090170&amp;sdata=3D
> T6LA4xz9CUFlNpnyjHSThEQb8i1rhbY9e1nUyxIGD5Q%3D&amp;reserved=3D0
> > +	 */
> > +	bool ecspi_fixed;
> >  };
> >
> >  struct sdma_engine {
> > @@ -539,6 +546,31 @@ static struct sdma_driver_data sdma_imx6q =3D {
> >  	.script_addrs =3D &sdma_script_imx6q,
> >  };
> >
> > +static struct sdma_script_start_addrs sdma_script_imx6sx =3D {
> > +	.ap_2_ap_addr =3D 642,
> > +	.uart_2_mcu_addr =3D 817,
> > +	.mcu_2_app_addr =3D 747,
> > +	.uartsh_2_mcu_addr =3D 1032,
> > +	.mcu_2_shp_addr =3D 960,
> > +	.app_2_mcu_addr =3D 683,
> > +	.shp_2_mcu_addr =3D 891,
> > +	.spdif_2_mcu_addr =3D 1100,
> > +	.mcu_2_spdif_addr =3D 1134,
> > +};
> > +
> > +static struct sdma_driver_data sdma_imx6sx =3D {
> > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > +	.num_events =3D 48,
> > +	.script_addrs =3D &sdma_script_imx6sx, };
> > +
> > +static struct sdma_driver_data sdma_imx6ul =3D {
> > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > +	.num_events =3D 48,
> > +	.script_addrs =3D &sdma_script_imx6sx,
> > +	.ecspi_fixed =3D true,
> > +};
> > +
> >  static struct sdma_script_start_addrs sdma_script_imx7d =3D {
> >  	.ap_2_ap_addr =3D 644,
> >  	.uart_2_mcu_addr =3D 819,
> > @@ -584,9 +616,15 @@ static const struct platform_device_id
> sdma_devtypes[] =3D {
> >  		.name =3D "imx6q-sdma",
> >  		.driver_data =3D (unsigned long)&sdma_imx6q,
> >  	}, {
> > +		.name =3D "imx6sx-sdma",
> > +		.driver_data =3D (unsigned long)&sdma_imx6sx,
> > +	}, {
>=20
> Now the i.MX6sx uses a new sdma_script_start_addrs entry which is the sam=
e
> as the i.MX6q one we used before with one exception: it lacks the
> per_2_per_addr =3D 6331 entry. This is only used for IMX_DMATYPE_ASRC and
Totally same script for i.mx6 chips whatever i.MX6sx, i.MX6q or i.MX6ul.=20
> IMX_DMATYPE_ASRC_SP, both are entirely unused in the mainline kernel. So
> why must the i.MX6sx changed here and what has this to do with ECSPI?
i.MX6ul is based on i.MX6sx, so adding i.MX6sx could keep good shape on our=
 i.MX family evolution.
>=20
> Sascha
>=20
> >  		.name =3D "imx7d-sdma",
> >  		.driver_data =3D (unsigned long)&sdma_imx7d,
> >  	}, {
> > +		.name =3D "imx6ul-sdma",
> > +		.driver_data =3D (unsigned long)&sdma_imx6ul,
> > +	}, {
> >  		.name =3D "imx8mq-sdma",
> >  		.driver_data =3D (unsigned long)&sdma_imx8mq,
> >  	}, {
> > @@ -602,7 +640,9 @@ static const struct of_device_id sdma_dt_ids[] =3D =
{
> >  	{ .compatible =3D "fsl,imx35-sdma", .data =3D &sdma_imx35, },
> >  	{ .compatible =3D "fsl,imx31-sdma", .data =3D &sdma_imx31, },
> >  	{ .compatible =3D "fsl,imx25-sdma", .data =3D &sdma_imx25, },
> > +	{ .compatible =3D "fsl,imx6sx-sdma", .data =3D &sdma_imx6sx, },
> >  	{ .compatible =3D "fsl,imx7d-sdma", .data =3D &sdma_imx7d, },
> > +	{ .compatible =3D "fsl,imx6ul-sdma", .data =3D &sdma_imx6ul, },
> >  	{ .compatible =3D "fsl,imx8mq-sdma", .data =3D &sdma_imx8mq, },
> >  	{ /* sentinel */ }
> >  };
> > @@ -1169,8 +1209,17 @@ static int sdma_config_channel(struct dma_chan
> *chan)
> >  			if (sdmac->peripheral_type =3D=3D IMX_DMATYPE_ASRC_SP ||
> >  			    sdmac->peripheral_type =3D=3D IMX_DMATYPE_ASRC)
> >  				sdma_set_watermarklevel_for_p2p(sdmac);
> > -		} else
> > +		} else {
> > +			/*
> > +			 * ERR009165 fixed from i.mx6ul, no errata need,
> > +			 * set bit31 to let sdma script skip the errata.
> > +			 */
> > +			if (sdmac->peripheral_type =3D=3D IMX_DMATYPE_CSPI &&
> > +			    sdmac->direction =3D=3D DMA_MEM_TO_DEV &&
> > +			    sdmac->sdma->drvdata->ecspi_fixed)
> > +				__set_bit(31, &sdmac->watermark_level);
> >  			__set_bit(sdmac->event_id0, sdmac->event_mask);
> > +		}
> >
> >  		/* Address */
> >  		sdmac->shp_addr =3D sdmac->per_address;
> > --
> > 2.7.4
> >
> >
>=20
> --
> Pengutronix e.K.                           |
> |
> Steuerwalder Str. 21                       |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.pe
> ngutronix.de%2F&amp;data=3D02%7C01%7Cyibin.gong%40nxp.com%7C91d4204
> 6e6894501d48508d7c4cbcae2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C1%7C637194251876090170&amp;sdata=3Dd0X1DBm%2Fc0lwcHVUtTW0ITw
> o5qW3SKtVd5Va0EVVw3E%3D&amp;reserved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |
