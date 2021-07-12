Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5E53C428C
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jul 2021 06:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGLEFz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jul 2021 00:05:55 -0400
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:7651
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230102AbhGLEFz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 12 Jul 2021 00:05:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Niom5LxwhmKC23iYHPE2c603Ciqk+z//G+fYft2OI3O7sBoEUfYW0tKzv0fNSLa/xCOSJXyZLwIfapGzZ2p2c2jt9AcTVKdrEdTdhpDOecp/jHEcee6tuCHcIdGmqFfgobiP0GVu6BsCxqiHpSlJw6Grs14VdeJhlNYEqbSLwTEahfvYMsn96G8jU7pfBvXis4jmnrtiidt/SF/+UgkQksVB4EJcoVd86hMpFQPn/61KzZgSOE8rK1ghDYaKXlWWXW8BCWsCB2qL1eU++3l9iLuwV64mysrv9egTgcHdAQ3tcCNkMdrBROC2EwaeumDhw0sSywkC5OhFfZOF63snVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y6gzaPpowcqra/l40dTtOJQoO3GIh3cu0YUg+ssL+A=;
 b=aPsPKsE2Qe3gI/+TWVe5+zTfUtWmoLcg265e4pKEdo5UIPZ9xnGcB5P9BLFztYMqzA6nPxTxTm1RFYHhKDrEEe7yFj/7s8Z81DAuKp0fsZm82YGKUdP/fUyn1AJqctM+y8HYcbAXmrahcjBHwI7yq42ImGhSXZbevpWz3PJRUEBWfG5N6ZmCGKllrOtpcjCSFcorEGlsYZSzETBKyw6cVAjDHZAKwTQuTHHPws6iIpvphuTR1sgIXtMH2RrWaOnL41CMPK27NYIo122qUCX3ZeRPybRTX/RspgjKFpHxLCYCMUn6PeTxQNjkdxlymYDXmyGSO1c3R/2mi36kuEYYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y6gzaPpowcqra/l40dTtOJQoO3GIh3cu0YUg+ssL+A=;
 b=ZTrwZ7he61z7O+cLeC3fhY/yTwIA3ySB2CZzWvqGaJ2lGB+50PVES3k+hWTmNpcIAfKHFAAC7TjKYwq6a0qKCSN+fwPTAE+z/Y9Hy0TdON2uuqmymjWgS7/LZcPNMYymkf6pdAxsOjKkCDDs7d8jbQ9Wwn/fKu+PWZBKqfr0PsI=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2670.eurprd04.prod.outlook.com (2603:10a6:800:54::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Mon, 12 Jul
 2021 04:03:03 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 04:03:03 +0000
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
Subject: RE: [PATCH v14 09/12] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Thread-Topic: [PATCH v14 09/12] dmaengine: imx-sdma: remove ERR009165 on
 i.mx6ul
Thread-Index: AQHXK33uJvhJxunKh0O/L1opU5bMLas69yaAgARURRA=
Date:   Mon, 12 Jul 2021 04:03:03 +0000
Message-ID: <VE1PR04MB6688F74F67882E3DC26495E489159@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-10-git-send-email-yibin.gong@nxp.com>
 <3ade0741d94e53eb2bca86743ad11e55899381d7.camel@pengutronix.de>
In-Reply-To: <3ade0741d94e53eb2bca86743ad11e55899381d7.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7020ea24-a85c-48f9-6c7a-08d944e9f278
x-ms-traffictypediagnostic: VI1PR0401MB2670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB267009A4DD2E6470679FE8D289159@VI1PR0401MB2670.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IoZ9uAB0JT+CrRasQ+/ToHgq8HNxY176LSUDXPnwF6hYFitCXPRXAkQQilf8YkDpS0hKxP2yQJcx6JothOgamiLdCCegMSIrH+oTWda9YBFLXlnAbX6UDL+VZNxqrrKEY38B+0rb+COgXdg6JmjJNNfiY754oQ4hZoTVoPso+geijFcjsp2H3HDyNwpXHHtY706TukrLMOTetPClRHPl27zLJfZuKMC8pD/E1IqAnKkr2FQMZSGUrNq9mZ7xZLaqfSn2uqloO7ScuniW5dZIb/J1MV/6bTnds8CQXGzBUuNCqyCU6MwdnXzIuIE1GDnPdD2dZus8Q6wZriPOORm8s/ZpyaH4PIxwus5USKKztf7BQWKQvIg6lzgxPWf9pfLpa+22UDlXgz86+7tW5ZKNCM57IEnhn+DyaITLcSeBxVR34LApsnCcVfs1u+219TR/ntO2hnged30kj+/lVcSMXSxOCCmC4rC1Ni3h8YobVMQPg5spWWokKHXo5++XX/iwzU/zrmXDK0kLd9OAQiQ3X6pMW1CRv2i/cvtAUKI11pQe0w8+aqQ4xh/8+UARyeVWD0u1sMF7fL0/baowmRyncbkTS8KFDK36fNyWA16pUPU+3TE+BkhMzjGPcgCNsW9EXsyMnuR/JxqjEu+NdnaY6MU7/P7e4nf2CKe27ndzKWyXmAqWEBqYV2HmxfF9pj0FMNpNVVVNuhjnIB+voqlMR1QKzGPlxMIvNTZc4qI7E12pwY/+m742nr9Vocuzlkzs/hTxPwOZlADIcneG+96grg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(66476007)(64756008)(66446008)(4326008)(2906002)(26005)(7416002)(33656002)(76116006)(53546011)(6636002)(54906003)(52536014)(9686003)(6506007)(316002)(55016002)(71200400001)(110136005)(8936002)(8676002)(5660300002)(66556008)(478600001)(45080400002)(66946007)(7696005)(122000001)(86362001)(186003)(83380400001)(921005)(966005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XgfR5w7BoZEDAd54+dH3/THIRiu7V+drHk6/Qx3DKD/WidU7HgrC/I9yi21m?=
 =?us-ascii?Q?O77PrK/hHLL3I6I+BbNK8auHkxLJaRbm3pFIbagfABSjed9Pbs7UQmgQFaYV?=
 =?us-ascii?Q?yYgWOTU0HY2A9b9bA8ZZntsNuypbKnYsTTp2Hd0iTZNfVDtmJVxDNeujmJRQ?=
 =?us-ascii?Q?I04amUxjijK0BjIEEdlJNMwNXI5fH+edudE3cfs4uTjJchkTYRLwc2FZaSGv?=
 =?us-ascii?Q?VPYVAskOMs0I1umgXdzRWVqxhk3SFqUOyQrgvYLHoowv//vz9+li6GcEr1Cd?=
 =?us-ascii?Q?yuhqhWrZwbQglp6CTQWVAVia8UsLE7XThd5u9y2/HdwdmuFvRKqjSkk4ck5w?=
 =?us-ascii?Q?n8RB/OVZlkCnCKiBXMv5ASOHmJgcofqjgScpclr3cZdksSx57XqfOt+Cas0V?=
 =?us-ascii?Q?P7BRJluY1eyz3lZEqyhjuf9IzzLxAZAihwM0xQhm/4d5JSwdHV+YyqVJ6v/R?=
 =?us-ascii?Q?yqaq7zaPLSd1Xism5PW6R7ju6h6rJ3YIgwwK3Zkkm5MPrAnMNx4i8FLzwoTk?=
 =?us-ascii?Q?Z0ZmgaM5ZGk2RyARP9oFrzdihvIaF7BjLaaWfFAFJs1r2l8YGre3kmmQVe0S?=
 =?us-ascii?Q?qpxAO5Kzxk4D71BmrIEg42CMSdT1Bdi32Q0AQ5Qpgx8mBieKXFFITrBRYsXB?=
 =?us-ascii?Q?Y4i3lYvJpVv5OlwiyLDGSLLBVjI39rV7IgyE8iW9hXyurZ2rVSFgmKL+Cvka?=
 =?us-ascii?Q?jfQqiY4bKwwepkBncwFpAKbn4W8tydD/aJ5B7OUS8sxrVrpHKBUioPnofA9g?=
 =?us-ascii?Q?9TZQHeowNfHbv3EtSgqnu6V4FIaEYiH3V9FvyPtWygaFwv93Hy5XVru0qYnM?=
 =?us-ascii?Q?VsN1RuSKn2Nq6CD0pmiORzAQv3Qebr/PQUE9+mjpTKerMujGAfolSaC0SZNL?=
 =?us-ascii?Q?UjKwLDDgJbKfbhNjr1PvZeWrl9RVRbOp5WSVcJnjplayiTRcbwPFP4307h6W?=
 =?us-ascii?Q?MUZP94zF9WbmOUy9tnXVeHFYYHoWGruzr8xAT2jbbTBMDyNPeuwUibB3thiv?=
 =?us-ascii?Q?/o8jsQeHoroyZwfEX5DDVSwIGVM5UWBvOwYtJvhTPkN9kAKn0lno46z90IFu?=
 =?us-ascii?Q?8KLTZnKWfh1/sYck/nm/mWu2aF4HTsoBKrCXfidj7WVNlQvmpCA8rvGCLzYy?=
 =?us-ascii?Q?NLq0IoZoYZ+8dXHrraV6vrS42NKRt+8gtl6vv8Iber0WfyX77UBNmf89BedV?=
 =?us-ascii?Q?75QogG4zlC+kxL2PBm7gGfQGpMtGXdQuSJYZFKsj35o/hVTTLepf1Jm0Zx7t?=
 =?us-ascii?Q?sOcVeWWECq5/+epCAswdDpKrJKgyutUrFQVtLQACxdYssBmWaMh5g9eCbEEw?=
 =?us-ascii?Q?yqZMNXOwBNyGxSnCHDBUu53O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7020ea24-a85c-48f9-6c7a-08d944e9f278
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 04:03:03.4573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlW0+lHqk/YHD6ACBoMXMAXIrLJnFIbzcbOsZ16qFWM6fZzwz8hFgpbbAbHjgD/nNcpVx587//NvIiAJ4JQc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2670
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09/07/21 17:45 Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Mittwoch, dem 07.04.2021 um 23:30 +0800 schrieb Robin Gong:
> > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > ERR009165 anymore on those chips such as i.mx8mq.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/imx-sdma.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > 86bd383..af85116 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -422,6 +422,13 @@ struct sdma_driver_data {
> >  	int num_events;
> >  	struct sdma_script_start_addrs	*script_addrs;
> >  	bool check_ratio;
> > +	/*
> > +	 * ecspi ERR009165 fixed should be done in sdma script
> > +	 * and it has been fixed in soc from i.mx6ul.
> > +	 * please get more information from the below link:
> > +	 *
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.n
> xp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D04%7C01%7C
> yibin.gong%40nxp.com%7Cc950b1bdb6544eda369408d942be35d9%7C686ea
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637614206980361737%7CU
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3D6iT6%2FbzJHyWnkhkDynY
> wmK9nn2hgCDy1GyzELeEk9K8%3D&amp;reserved=3D0
> > +	 */
> > +	bool ecspi_fixed;
> >  };
> >
> >  struct sdma_engine {
> > @@ -542,6 +549,13 @@ static struct sdma_driver_data sdma_imx6q =3D {
> >  	.script_addrs =3D &sdma_script_imx6q,
> >  };
> >
> > +static struct sdma_driver_data sdma_imx6ul =3D {
> > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > +	.num_events =3D 48,
> > +	.script_addrs =3D &sdma_script_imx6q,
> > +	.ecspi_fixed =3D true,
> > +};
> > +
> >  static struct sdma_script_start_addrs sdma_script_imx7d =3D {
> >  	.ap_2_ap_addr =3D 644,
> >  	.uart_2_mcu_addr =3D 819,
> > @@ -575,6 +589,7 @@ static const struct of_device_id sdma_dt_ids[] =3D =
{
> >  	{ .compatible =3D "fsl,imx31-sdma", .data =3D &sdma_imx31, },
> >  	{ .compatible =3D "fsl,imx25-sdma", .data =3D &sdma_imx25, },
> >  	{ .compatible =3D "fsl,imx7d-sdma", .data =3D &sdma_imx7d, },
> > +	{ .compatible =3D "fsl,imx6ul-sdma", .data =3D &sdma_imx6ul, },
> >  	{ .compatible =3D "fsl,imx8mq-sdma", .data =3D &sdma_imx8mq, },
> >  	{ /* sentinel */ }
> >  };
> > @@ -1144,8 +1159,17 @@ static int sdma_config_channel(struct dma_chan
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
>=20
> Hm, I don't care much either way, but couldn't we just return the regular
> mcu_2_app script in sdma_get_pc when ecspi_fixed =3D=3D true? Seems like =
this
> would be a simpler and more targeted code change.
Yes, return mcu_2_app if ecspi_fixed =3D=3D true also works, but since sdma=
 firmware
have already been here to fix ERR009165 on most of legacy i.mx6/7/8 chips, =
so choosing
firmware/ram script to do like ROM/mcu_2_app is okay too since both ram scr=
ipt and rom
script in case of ecspi_fixed are almost same.

>=20
> >  			__set_bit(sdmac->event_id0, sdmac->event_mask);
> > +		}
> >
> >  		/* Address */
> >  		sdmac->shp_addr =3D sdmac->per_address;
>=20

