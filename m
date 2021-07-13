Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A53F3C6D08
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jul 2021 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhGMJRe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Jul 2021 05:17:34 -0400
Received: from mail-vi1eur05on2072.outbound.protection.outlook.com ([40.107.21.72]:24568
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234397AbhGMJRe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 13 Jul 2021 05:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6vCyE1Iv6M7kGl9YdQ0rPjF64lx/sBb9ZXJ5uJS9gtI4aUv4+z0zxzArYVlblRqL56iw5CLIscSV+LCGnamBm8ow5ZB3B259pc/EhqEctD9qEZjmSamcfri15nh2rHs6L843PXbFICt1nYBYvezvC9LYd13RFVQtbH6dPsxX6Fljs6rPpQaeqFYhBaIX91Jm6WkKBxhUdcwwSnEUwlf0PIpuk0efEkJmK4pwyKOHhmQrqwYNoy7d2sCRRLQagK6fTa2TAXbQV3lDqhEgHqGSB46PEnS6OcoWiTMyiJTf9RPMiZklo0nMW/f3ywurqcZaF0nWElpWWpqQCVeq4OSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWwALsKoASwPDz5Hd+Xp8ESxAnYKy+LPo89v4QH2/8k=;
 b=Pp42FyUj+xRPzuWUAHkMI9kzAXLSSbUKf737zKEJp3Caho8vVlL5ylewpXQeNJh0VlErQEulpJasoAXR7YpUUv/Uii/ZWf7Heuck/n+zMwVhnzxtmrKpQ7K9rW7PGK5gENSVFM87ETFRLfYu1Mhuc1cAIbA5/QRCcMw6ZVdz24kUntww1K/k5mSpKuhHPxh6TeZeYeyvIA+bOroX9WD/ck/GtzYxUO7mDWuzVmdVW42XK8aDnQVcVq647x5/NFc0Rri7UGPq+PsmM2l7tTZ4cpLGB8jmPXnBor80O29mOjmkuqPnLfAXGdFmELnOUx+37V06bWe8DQxQ0W0N5Tk1hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWwALsKoASwPDz5Hd+Xp8ESxAnYKy+LPo89v4QH2/8k=;
 b=Us+9WxA9a8Q34yXCOdVpaeZODHhK0XRfRVZwoKABk0bzYRcfp1SsvYos4nYOT3Xqw+h7pAyASuSO6WLfEb/HwqEDx/P0gHP8GezrlWGyjwhUrURKBO5baA0NAKkNXyKc8fqD9UHmI7ahoLO9xFPhADJR0fdTtjNRxyQ6MwWAGew=
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR0401MB2669.eurprd04.prod.outlook.com (2603:10a6:800:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 09:14:42 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::a978:6f38:2bce:9076%5]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 09:14:42 +0000
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
Thread-Index: AQHXK33uJvhJxunKh0O/L1opU5bMLas69yaAgARURRCAAF97AIABjJIA
Date:   Tue, 13 Jul 2021 09:14:42 +0000
Message-ID: <VE1PR04MB6688E4BEA6B45A40C46DDEC689149@VE1PR04MB6688.eurprd04.prod.outlook.com>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
         <1617809456-17693-10-git-send-email-yibin.gong@nxp.com>
         <3ade0741d94e53eb2bca86743ad11e55899381d7.camel@pengutronix.de>
         <VE1PR04MB6688F74F67882E3DC26495E489159@VE1PR04MB6688.eurprd04.prod.outlook.com>
 <1159a6b7f30402b07aaa5654bd98bfaa95457960.camel@pengutronix.de>
In-Reply-To: <1159a6b7f30402b07aaa5654bd98bfaa95457960.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5494965f-4b8d-4b76-e685-08d945dea61c
x-ms-traffictypediagnostic: VI1PR0401MB2669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB266931D88433249D5DE42F8F89149@VI1PR0401MB2669.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfOs3j+NF4zXJxkRPLwhRqDF+f3SkMum9yPqYKkqwhM9NdV06gyP/j7oJbU5jbBv6JuZaO2b6MY0pQMU7tY6gLxRG5CtySogUnLFjMjH0F1yN02wTMX9FPUTfJgOayDKBq14Vxi/GNjkjvbmdhXGJObjvrrKdM6MkdV74QLcV4i32HDnWKBn6kxHpKOWYcH1U/LPOlah9AN6FeVBBYxzGa5Izh9xfSaqSRHox1GSTQH5hZupyA+KdXmw+YUtN1tpfxNyJi8hw/2/ihT245qzxqJFzrababa/rjQqP2S9rxV4zpSKeGt6yV8KAzFjx2MUaR8NTHDLJAKbsVGeypjsh4N9fpJPbRDA3pQmr9prQlEUYFjxCmaOL2UB/fHOe/lBuo0KNbMb7QTQEQVWF7gbJtoiESFrl+OWndCP5lfmXofKaI49g2h9TvbubDj1OURswRdsWJxaD9pZPrCgKZBK7SdpnU/XxthbeFt02HHAPF7Am+aJyndCLxLRMGG26AoR4dA4UCqarZe0LQXLjJqz9X+vnYBkZ4RPZkzmVii/KctXyeT5NB1rw9QT83iqzeRldrlIXB8vlLiVMMhhZ1xB5iQluy4qw22It0X+ds98oHPhPztNPaChNwFOTTbTHo/ZKOecmrQL/dSeTwuRkvP/DidKz1e7ntC+CLKOKYX1SyM5x8DlGpg7Z17JtrcDIARgc6Sk1NRDK5gXxxWkN23KW7PYmIY87hj0OY9UzzGJGq5UTV2xqPp+cHOhJ7o2p/LW4JB75xe6aEz1GueUkbbjUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(122000001)(38100700002)(26005)(478600001)(71200400001)(966005)(66946007)(921005)(66446008)(76116006)(66476007)(64756008)(45080400002)(8936002)(83380400001)(2906002)(110136005)(54906003)(53546011)(9686003)(6636002)(186003)(5660300002)(8676002)(7416002)(55016002)(4326008)(6506007)(52536014)(316002)(86362001)(7696005)(66556008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gzH7QkwUS20Urlvp0dhaFu8KLHzH6tV+uOcugMFLkOAmdxOV8shyFZX1TZEt?=
 =?us-ascii?Q?+T8DIkxkhnjA2qTpyBK/73DuzS9LNno8OTSj/JDx0CVgUg5pNs/HZlMopy6q?=
 =?us-ascii?Q?1q33oBMgBbLu5YHuYErG5ZYZFzWDY5G2x3pZTS5OAJkSmA5zEtgIKASG11AE?=
 =?us-ascii?Q?hkqm66Lh4OqxSQp+ckZl4sTnWJYx544ZNicQ3K+6mNTrnfs/7EV9BJHC94SB?=
 =?us-ascii?Q?QxTGm5gSTvM46e5aPHpcuebt6ez3Tt0mqw93OnMjh74d4CnPw3JzY7Ob6LqS?=
 =?us-ascii?Q?PsigTaYRaFK5FI4OAs+fpxaH05XPSnfNdRXC8020d2wrEnX8bHtqEWBQMXVF?=
 =?us-ascii?Q?G3mSAjF5H4SY4nf55YwLvY+Y0fBLR1dSEzQsO1OZPpCQg/v6ncALoOKr7Yqu?=
 =?us-ascii?Q?Ok37sWAkYBPe/LQCrbnxxLfbo87FKkafm1UQgsG8/bTCl9xI7H3wR+P5ilWp?=
 =?us-ascii?Q?1H7llh9MBgLyBZuw3F+drfmzsS2nP7LhrpNlL8XkgS+TBeF92EnUXYRZxrie?=
 =?us-ascii?Q?xL2ryDaU1vfCD7pZMOJAp4OV2PnFIG1iGaJF+tFLK4NMQFNLUyGwZ3zAWi+k?=
 =?us-ascii?Q?mB9UiesTE+n683kxdf1TQA1/ONxqkRZjI575HLcDZE9tXp58tFP1dit2ypZZ?=
 =?us-ascii?Q?UGxR0XWRAOiQfQy8UhSLAUpxbyfizTMM3sPtex+EghhLh9Uvkin19VoKYtAg?=
 =?us-ascii?Q?S5NOlwhSDhlIXNJ3/Fs6zQ+dGHgk+QE5YP58YbCE5Ko54SdmYx2zhbuUvmBE?=
 =?us-ascii?Q?Sdj0tCh+fMJLxV1qZ6Xcm7O6UfooLoYytIar8Z80NG2oXE1Om00dmsUjR/5J?=
 =?us-ascii?Q?xBPJtcG+HGeGUHL5Oj6g5W2jv+Icvlyv/15kX/SnyQPRcXpDEhU72tgboE1e?=
 =?us-ascii?Q?Xz24CF3dL8L8G7u38Ie2HRKIyg6/O4ll47o+CegKby09zrK9vVElsFIk1fDP?=
 =?us-ascii?Q?Tx8ww5a6y7Mx5J0qSMdsui0ljc7o21hWqxEnrtoethQ1IAzOWF/b5Cc4TKiD?=
 =?us-ascii?Q?ghjOBAfrN4xe8nSA6mtUHbxK5r4+UD0S9xFKCemmq9pV/sxGnEjSuiXUPo69?=
 =?us-ascii?Q?Guoc+X/etyTGjBNXHeGjFuVc9e8yZc5VMgdlGwHT+qr0TLGwah34zSLvbuR1?=
 =?us-ascii?Q?OcSMYuqxtA3HuzUzvo9eMjY8L9/rlF20TcszW1qP7R2XRRnIRBStf0s1K6+k?=
 =?us-ascii?Q?UgMqW1oXgKa495+K8Ba08UlXC2GqJvknEjr4N7SLtxm8LD2RNEzu9w1ijPH1?=
 =?us-ascii?Q?i5f2eDQCYceojZoEK90BZazMBrA+Yb66uP+dGN58gablQMvMdGdc3qVOFXAP?=
 =?us-ascii?Q?s8uHLAsQSPe8i8+CdZH10Rxn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5494965f-4b8d-4b76-e685-08d945dea61c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 09:14:42.1054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYzUnLHqE1xL1zSrOKrpS8wOlEmrDyouZHRjkaIYabw6SQrONmyriNciOLuGywgW0KB9EOngX1REYjGtI9eQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2669
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12/07/21 17:33 Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Montag, dem 12.07.2021 um 04:03 +0000 schrieb Robin Gong:
> > On 09/07/21 17:45 Lucas Stach <l.stach@pengutronix.de> wrote:
> > > Am Mittwoch, dem 07.04.2021 um 23:30 +0800 schrieb Robin Gong:
> > > > ECSPI issue fixed from i.mx6ul at hardware level, no need
> > > > ERR009165 anymore on those chips such as i.mx8mq.
> > > >
> > > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > > ---
> > > >  drivers/dma/imx-sdma.c | 26 +++++++++++++++++++++++++-
> > > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
> > > > 86bd383..af85116 100644
> > > > --- a/drivers/dma/imx-sdma.c
> > > > +++ b/drivers/dma/imx-sdma.c
> > > > @@ -422,6 +422,13 @@ struct sdma_driver_data {
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
> > > w.n
> xp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D04%7C01%7C
> > >
> yibin.gong%40nxp.com%7Cc950b1bdb6544eda369408d942be35d9%7C686ea
> > >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637614206980361737%7CU
> > >
> nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3D6iT6%2FbzJHyWnkhkDynY
> > > wmK9nn2hgCDy1GyzELeEk9K8%3D&amp;reserved=3D0
> > > > +	 */
> > > > +	bool ecspi_fixed;
> > > >  };
> > > >
> > > >  struct sdma_engine {
> > > > @@ -542,6 +549,13 @@ static struct sdma_driver_data sdma_imx6q =3D =
{
> > > >  	.script_addrs =3D &sdma_script_imx6q,  };
> > > >
> > > > +static struct sdma_driver_data sdma_imx6ul =3D {
> > > > +	.chnenbl0 =3D SDMA_CHNENBL0_IMX35,
> > > > +	.num_events =3D 48,
> > > > +	.script_addrs =3D &sdma_script_imx6q,
> > > > +	.ecspi_fixed =3D true,
> > > > +};
> > > > +
> > > >  static struct sdma_script_start_addrs sdma_script_imx7d =3D {
> > > >  	.ap_2_ap_addr =3D 644,
> > > >  	.uart_2_mcu_addr =3D 819,
> > > > @@ -575,6 +589,7 @@ static const struct of_device_id sdma_dt_ids[] =
=3D {
> > > >  	{ .compatible =3D "fsl,imx31-sdma", .data =3D &sdma_imx31, },
> > > >  	{ .compatible =3D "fsl,imx25-sdma", .data =3D &sdma_imx25, },
> > > >  	{ .compatible =3D "fsl,imx7d-sdma", .data =3D &sdma_imx7d, },
> > > > +	{ .compatible =3D "fsl,imx6ul-sdma", .data =3D &sdma_imx6ul, },
> > > >  	{ .compatible =3D "fsl,imx8mq-sdma", .data =3D &sdma_imx8mq, },
> > > >  	{ /* sentinel */ }
> > > >  };
> > > > @@ -1144,8 +1159,17 @@ static int sdma_config_channel(struct
> > > > dma_chan
> > > *chan)
> > > >  			if (sdmac->peripheral_type =3D=3D IMX_DMATYPE_ASRC_SP ||
> > > >  			    sdmac->peripheral_type =3D=3D IMX_DMATYPE_ASRC)
> > > >  				sdma_set_watermarklevel_for_p2p(sdmac);
> > > > -		} else
> > > > +		} else {
> > > > +			/*
> > > > +			 * ERR009165 fixed from i.mx6ul, no errata need,
> > > > +			 * set bit31 to let sdma script skip the errata.
> > > > +			 */
> > > > +			if (sdmac->peripheral_type =3D=3D IMX_DMATYPE_CSPI &&
> > > > +			    sdmac->direction =3D=3D DMA_MEM_TO_DEV &&
> > > > +			    sdmac->sdma->drvdata->ecspi_fixed)
> > > > +				__set_bit(31, &sdmac->watermark_level);
> > >
> > > Hm, I don't care much either way, but couldn't we just return the
> > > regular mcu_2_app script in sdma_get_pc when ecspi_fixed =3D=3D true?
> > > Seems like this would be a simpler and more targeted code change.
> > Yes, return mcu_2_app if ecspi_fixed =3D=3D true also works, but since
> > sdma firmware have already been here to fix ERR009165 on most of
> > legacy i.mx6/7/8 chips, so choosing firmware/ram script to do like
> > ROM/mcu_2_app is okay too since both ram script and rom script in case =
of
> ecspi_fixed are almost same.
> >
> Actually, while thinking some more about this: it is preferable to return
> mcu_2_app in the ecspi_fixed case, as this allows proper DMA support on t=
he
> fixed SoCs without loading the firmware. The way you do it here still req=
uires
> the RAM firmware to be loaded in order to get DMA support at all.
Okay, will change to mcu_2_app v15.

>=20
>=20
> > >
> > > >  			__set_bit(sdmac->event_id0, sdmac->event_mask);
> > > > +		}
> > > >
> > > >  		/* Address */
> > > >  		sdmac->shp_addr =3D sdmac->per_address;
> > >
> >
>=20

