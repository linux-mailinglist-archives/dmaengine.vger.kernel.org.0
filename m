Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0BDF7C3
	for <lists+dmaengine@lfdr.de>; Mon, 21 Oct 2019 23:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfJUVyZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Oct 2019 17:54:25 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:58129
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbfJUVyZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 21 Oct 2019 17:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLAFaPX4fhel71jh9BmlQ9OW+JF9XYiqezi7OY2jhELjwNoknTqulHQ4S2N8qteo9+Bu0pE/YeKq9LzbZbWR4ii+xSXAUPmbi6GwJqSX8cvnWIt+Z8gzFiTTPd/BmakC6HBtcFqxOXkqdPfiXo751GZs5VqLvXFj8RgpZQaSz1o4s+VwQstK1Rw8/n8+r4OvzT7zTumuQgwuo1cJ4ux+cgiQ/ZTEvFI6Gm4K4pY7mTH271aPzo59vWHTLHkF46KFEHl6o4Y1txNUtaBQm32GQ1S8zmlBdV1YcVI38vfd/OaFadBgAXvrcFa9LbA7SHmy7p/CCZsLiwrn8bG1INQVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyQ0R2rdlwSb3iGBmLqWNvQnwQ4DFn4UX93iKcJe4kA=;
 b=fA8CufobXttEo9QyeP/xuAkttoASsQBsKg8p/12vT/DH8PbOQM44h5CStK9x5WbK4LnmRgBi8MMuaTd87aaPkeuUv52asEzIv18tyuiHSepqq+PILMFe0iVvlP7FOoaMuMZ+ftS2f2TkM/PVV8b2AV1dz9Jji4p7gOxrCqikKqYbarBY2sjQEOtbwPETVlubdTYcn9vvNdmX2MOJdtgXKaZEm/HQ8iI2FBOvfRN9TCDFgZRVc2o3vcgxdsTYQ1skUsXrHK9nMd8CA0RDN/H0YEFn/9nzLDb6Pmzvq3TD5TIcjY6wSkEG+lEs81uAfesHp39Ws0qxuh7cPdCtFrGL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyQ0R2rdlwSb3iGBmLqWNvQnwQ4DFn4UX93iKcJe4kA=;
 b=f5gfUdjhkRkswUbRYNYqf/RL6o5cUU4geWAxQ9slw35uvfBrcKtyZP5xmJ4ZASznx6+0ugDmc/EhrE3Kmu5CV6NsuNrdkyc3dP8z4jynLYssXpa7l5/RcWKS9Jx8UynPZo7YuvLgi6H9xli49dsPsuDYShT1/WT08xcWIhOQmAg=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6766.eurprd04.prod.outlook.com (20.179.235.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 21 Oct 2019 21:54:19 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::c93:c279:545b:b6b6]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::c93:c279:545b:b6b6%3]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 21:54:19 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Peng Ma <peng.ma@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "k.kozlowski.k@gmail.com" <k.kozlowski.k@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Ma <peng.ma@nxp.com>
Subject: RE: [V2] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Topic: [V2] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Index: AQHVh7fW3WtYHJewrkWzp6KKJUvHnqdlnHdg
Date:   Mon, 21 Oct 2019 21:54:19 +0000
Message-ID: <VE1PR04MB66879FD43E7E7E8A9C157F5D8F690@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20191021022149.37112-1-peng.ma@nxp.com>
In-Reply-To: <20191021022149.37112-1-peng.ma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 703b991c-f674-4c44-1887-08d7567139a6
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VE1PR04MB6766:|VE1PR04MB6766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6766D756527095400DE920C98F690@VE1PR04MB6766.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(13464003)(66446008)(8676002)(66946007)(476003)(81166006)(446003)(11346002)(55016002)(5660300002)(478600001)(14454004)(26005)(25786009)(81156014)(66556008)(66066001)(186003)(9686003)(53546011)(6436002)(486006)(76116006)(102836004)(66476007)(6506007)(52536014)(86362001)(64756008)(6636002)(2501003)(76176011)(6246003)(316002)(33656002)(4326008)(8936002)(7696005)(6116002)(229853002)(7736002)(99286004)(74316002)(2906002)(3846002)(71200400001)(71190400001)(256004)(14444005)(110136005)(54906003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6766;H:VE1PR04MB6687.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZS4jewgwEvXTUfa231d4KcXmcNLL1B9wCSJ81T3FGVr+0M/rbLjzIiHbY/ITQP1zrEatK+YCPdQENe8AauqQmrY5Q/ZcC9lWDgCUujd+cHFwvR/Jp5rmUTt3W7et5DvD5WHa+KMqUlLRkoWqtuaCAQ0ljpLM714FIg8PTMY727zNIV7sQ+UZ55sORQLozvcdfK/si+CM7D6U2aiyVd0U9Em305zfyfEXwgZ6EmlFjghrNCzmoqVcC1Kmz2wUPxDze8wvI3K7Q6vzzTmGNshbG4YHZqmPIkaPhnvmPolhj8nny3r/DLqxccqGFM4q+3W0oOiSSrR4Fp0wSs8xTsSTi15R+cNC83/9co3CR+QrsP2uM0dPAAepbG8tyj8vmH+4XeO9A1sWZ1ti3OanvVFyDdIcA3ZTXulgQmnsdfLW24=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b991c-f674-4c44-1887-08d7567139a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 21:54:19.3734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JkaM1WocWiHD5LUhPBLOzCE4OTwBglqQHHD4DT9/N/1rl1gpFwGuTRJHSiA+lGiBqTSTUky/P2sXoqd+vRy4mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6766
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



> -----Original Message-----
> From: Peng Ma <peng.ma@nxp.com>
> Sent: Sunday, October 20, 2019 9:22 PM
> To: vkoul@kernel.org
> Cc: dan.j.williams@intel.com; Leo Li <leoyang.li@nxp.com>;
> k.kozlowski.k@gmail.com; Fabio Estevam <fabio.estevam@nxp.com>;
> dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org; Peng Ma
> <peng.ma@nxp.com>
> Subject: [V2] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
> platform
>=20
> Our platforms(such as LS1021A, LS1012A, LS1043A, LS1046A, LS1028A) with
> below

You only covered QorIQ SoCs, how about the situation for IMX SoCs?

> registers(CHCFG0 - CHCFG15) of eDMA as follows:
> *-----------------------------------------------------------*
> |     Offset   |	OTHERS      |		LS1028A	    |
> |--------------|--------------------|-----------------------|
> |     0x0      |        CHCFG0      |           CHCFG3      |
> |--------------|--------------------|-----------------------|
> |     0x1      |        CHCFG1      |           CHCFG2      |
> |--------------|--------------------|-----------------------|
> |     0x2      |        CHCFG2      |           CHCFG1      |
> |--------------|--------------------|-----------------------|
> |     0x3      |        CHCFG3      |           CHCFG0      |
> |--------------|--------------------|-----------------------|
> |     ...      |        ......      |           ......      |
> |--------------|--------------------|-----------------------|
> |     0xC      |        CHCFG12     |           CHCFG15     |
> |--------------|--------------------|-----------------------|
> |     0xD      |        CHCFG13     |           CHCFG14     |
> |--------------|--------------------|-----------------------|
> |     0xE      |        CHCFG14     |           CHCFG13     |
> |--------------|--------------------|-----------------------|
> |     0xF      |        CHCFG15     |           CHCFG12     |
> *-----------------------------------------------------------*
>=20
> This patch is to improve edma driver to fit LS1028A platform.
>=20
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> Changed for V2:
> 	- Explaining what's the "Our platforms"
>=20
>  drivers/dma/fsl-edma-common.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-
> common.c index b1a7ca9..611186b 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/sys_soc.h>
>=20
>  #include "fsl-edma-common.h"
>=20
> @@ -42,6 +43,11 @@
>=20
>  #define EDMA_TCD		0x1000
>=20
> +static struct soc_device_attribute soc_fixup_tuning[] =3D {
> +	{ .family =3D "QorIQ LS1028A"},
> +	{ },
> +};
> +
>  static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)  {
>  	struct edma_regs *regs =3D &fsl_chan->edma->regs; @@ -109,10
> +115,16 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
>  	u32 ch =3D fsl_chan->vchan.chan.chan_id;
>  	void __iomem *muxaddr;
>  	unsigned int chans_per_mux, ch_off;
> +	int endian_diff[4] =3D {3, 1, -1, -3};
>  	u32 dmamux_nr =3D fsl_chan->edma->drvdata->dmamuxs;
>=20
>  	chans_per_mux =3D fsl_chan->edma->n_chans / dmamux_nr;
>  	ch_off =3D fsl_chan->vchan.chan.chan_id % chans_per_mux;
> +
> +	if (!fsl_chan->edma->big_endian &&
> +	    soc_device_match(soc_fixup_tuning))
> +		ch_off +=3D endian_diff[ch_off % 4];
> +

This probably is not the best fix now.  There is a new mux_configure32() AP=
I added but it doesn't consider endianness.  How about making it properly t=
aken care of endianness?  And use it to set these registers?

>  	muxaddr =3D fsl_chan->edma->muxbase[ch / chans_per_mux];
>  	slot =3D EDMAMUX_CHCFG_SOURCE(slot);
>=20
> --
> 2.9.5

