Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD37A11A59C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfLKIJj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 03:09:39 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:21311
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfLKIJi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 03:09:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2pMaFTbIWRvTPgu/ZPc+LT2cw2I8otwm22uiFr8knbHWHkE8zuBqHKw4CUPxwdG9F9qLozEIIGGNy9Ui6l9KpQ9qameU9iPRX1VBkx0pmw4bBMoT9nQsknGKhqeDkL6bw8Bc+LikJPnkASzAPeVQDYk6zh/4rzhPMNdNxLl01Wan48gW1Q+ca4KhYrjPCpePNRp3YZyZ1bvanKnCq+cNvcjPxI89JquvIMb7XJqVw5+wqGFA34lppGrEXxevu7lCxMOC+aaPn/1q/WkZPHKmpds6/1o2goMFW82AP8+haMSGm6l34BVui+o3e7gUGMqkWhTY8XbO5ax27HMRCHOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HXgO/NeU86Z5++FlIRrrd4KkfTwl4CAt6P4DvCLqbA=;
 b=JXFB88dmUKUX3Q3H11xZu2L5HKPZClr9tX9USfI4p8a2WbvwUA0yBaTvvVdz72IN1VkzbnDREQ85CnCNIQuEBcvptI8Vy3ZoWtAS9z8L0DM0GmyA4XviVNw98+gGjkea6ZMCVYqMLC776MsMi72+hotSmFCXPEvh7GmY4vitACpw2M03vzokSM2WQbKjrEbNKGVygihcIHad/E5LRXFmJ0a56xbQt5ZV2UYyMnW/gJ9dvi/CGAYpozSQjS1t9AGVDffY0od8XZISymACvpDv4iBiHlAJZsqgkPScMk8Nc6FF4Y5OGcloDSMpxhhig3PvVDVIwWu3j2fNZIbLTnFlIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HXgO/NeU86Z5++FlIRrrd4KkfTwl4CAt6P4DvCLqbA=;
 b=TZDqWDbYXITmBzl4K24niqVfzB0AX9axnpkym09pZHA5cePxzkudwO3dJ2X8c3zT7y/qmUf3uYAKFo7IC9pKpJ2vnPw/G+zHZj/71XIa3lGTRh2vjP5JQeXj7VsM7N8Jt/UlipUK4L/nTnURtwQDbbBGDwPiwAZJv53ovGAOIk0=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB6222.eurprd04.prod.outlook.com (20.179.24.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 08:09:33 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2%3]) with mapi id 15.20.2516.019; Wed, 11 Dec 2019
 08:09:33 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Peng Ma <peng.ma@nxp.com>
Subject: [v4 1/2] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Topic: [v4 1/2] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Index: AQHVr/pSW2nKczVFpUqjkN1Zue3zHg==
Date:   Wed, 11 Dec 2019 08:09:33 +0000
Message-ID: <20191211080749.30751-1-peng.ma@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To VI1PR04MB4431.eurprd04.prod.outlook.com (2603:10a6:803:6f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d4db88c-7196-4a3b-7831-08d77e11746f
x-ms-traffictypediagnostic: VI1PR04MB6222:|VI1PR04MB6222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6222190C33C0AADB71249910ED5A0@VI1PR04MB6222.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(8676002)(6506007)(5660300002)(44832011)(6512007)(4326008)(2906002)(36756003)(6636002)(66446008)(71200400001)(186003)(81166006)(26005)(2616005)(52116002)(64756008)(110136005)(66556008)(1076003)(66476007)(6486002)(81156014)(478600001)(54906003)(86362001)(316002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6222;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKsdX3hAj+YUjiHKlBLwESyjfUQj45ltvuBmPBB637OqQgkLQpTiYknIdbH53lj7BWwzH6w2MsMxu7kIV9XO8aPrVBsBEaA9bTOVXuSHlbclH04OKBgGz17kyBgPz0Z0SOuBwtZjJ+4mUBLwzds363jVb3Bd9lXgX0FAvEcsVGEz2Wpyy5mHEeEsi1tmIJ77IrIP9lrzKPA5zTkgg4pHRvngzQdhJPq/9sawj0rMnf0V6R7b+IWWY3+zYsB++kjfCalVrILH7TASX61VOLMxWpc1cbaVD1+jIUQkxrHmJJdslpgWobMYTDc2bHqi9L6NtAxj6pvnIhz11QsxecYksZDIt0KON6v1XMs2GyMXalgPcc31hW6yDIs0J23CVz0w8svPnX02s2mnam2uTJyt8XDDrgyhnVTPFOVwOBnMqFYbtTb3AKyzVDNGG5CYDEJo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4db88c-7196-4a3b-7831-08d77e11746f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 08:09:33.4147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vLJLfhhloru0exSH+8j2B0YEF2nQXbuBGMqPscxYi9DmWfNeURHmBHfLSWgCx5G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6222
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Our platforms(such as LS1021A, LS1012A, LS1043A, LS1046A, LS1028A) with
below registers(CHCFG0 - CHCFG15) of eDMA as follows:
*-----------------------------------------------------------*
|     Offset   |	OTHERS      |		LS1028A	    |
|--------------|--------------------|-----------------------|
|     0x0      |        CHCFG0      |           CHCFG3      |
|--------------|--------------------|-----------------------|
|     0x1      |        CHCFG1      |           CHCFG2      |
|--------------|--------------------|-----------------------|
|     0x2      |        CHCFG2      |           CHCFG1      |
|--------------|--------------------|-----------------------|
|     0x3      |        CHCFG3      |           CHCFG0      |
|--------------|--------------------|-----------------------|
|     ...      |        ......      |           ......      |
|--------------|--------------------|-----------------------|
|     0xC      |        CHCFG12     |           CHCFG15     |
|--------------|--------------------|-----------------------|
|     0xD      |        CHCFG13     |           CHCFG14     |
|--------------|--------------------|-----------------------|
|     0xE      |        CHCFG14     |           CHCFG13     |
|--------------|--------------------|-----------------------|
|     0xF      |        CHCFG15     |           CHCFG12     |
*-----------------------------------------------------------*

This patch is to improve edma driver to fit LS1028A platform.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
Changed for v4:
	- Add 'mux_swap' into 'struct fsl_edma_drvdata'
	- Remove soc match function =20

 drivers/dma/fsl-edma-common.c | 5 +++++
 drivers/dma/fsl-edma-common.h | 1 +
 drivers/dma/fsl-edma.c        | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b1a7ca91701a..5697c3622699 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -109,10 +109,15 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan=
,
 	u32 ch =3D fsl_chan->vchan.chan.chan_id;
 	void __iomem *muxaddr;
 	unsigned int chans_per_mux, ch_off;
+	int endian_diff[4] =3D {3, 1, -1, -3};
 	u32 dmamux_nr =3D fsl_chan->edma->drvdata->dmamuxs;
=20
 	chans_per_mux =3D fsl_chan->edma->n_chans / dmamux_nr;
 	ch_off =3D fsl_chan->vchan.chan.chan_id % chans_per_mux;
+
+	if (fsl_chan->edma->drvdata->mux_swap)
+		ch_off +=3D endian_diff[ch_off % 4];
+
 	muxaddr =3D fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot =3D EDMAMUX_CHCFG_SOURCE(slot);
=20
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 5eaa2902ed39..67e422590c9a 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -147,6 +147,7 @@ struct fsl_edma_drvdata {
 	enum edma_version	version;
 	u32			dmamuxs;
 	bool			has_dmaclk;
+	bool			mux_swap;
 	int			(*setup_irq)(struct platform_device *pdev,
 					     struct fsl_edma_engine *fsl_edma);
 };
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index b626c06ac2e0..eff7ebd8cf35 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -233,6 +233,13 @@ static struct fsl_edma_drvdata vf610_data =3D {
 	.setup_irq =3D fsl_edma_irq_init,
 };
=20
+static struct fsl_edma_drvdata ls1028a_data =3D {
+	.version =3D v1,
+	.dmamuxs =3D DMAMUX_NR,
+	.mux_swap =3D true,
+	.setup_irq =3D fsl_edma_irq_init,
+};
+
 static struct fsl_edma_drvdata imx7ulp_data =3D {
 	.version =3D v3,
 	.dmamuxs =3D 1,
@@ -242,6 +249,7 @@ static struct fsl_edma_drvdata imx7ulp_data =3D {
=20
 static const struct of_device_id fsl_edma_dt_ids[] =3D {
 	{ .compatible =3D "fsl,vf610-edma", .data =3D &vf610_data},
+	{ .compatible =3D "fsl,ls1028a-edma", .data =3D &ls1028a_data},
 	{ .compatible =3D "fsl,imx7ulp-edma", .data =3D &imx7ulp_data},
 	{ /* sentinel */ }
 };
--=20
2.17.1

