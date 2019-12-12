Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B644111C3DE
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 04:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLLDiR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 22:38:17 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:46658
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfLLDiR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 22:38:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkxJLvbgjtQNLDUDplYczhWugTGHsKWC2JGo928ssxoQQz1zuwFk4rGj3SMN7UKXkNKxJ2pY3ez8sPPKJ71vHUa9i+Lr1CZRtuxYUqmjOn1HcszTaJYl4Q5RcjPnUA1RX/oJHeH6tL1fjKm6mEHFmyaZ+J+CYCvGNf4XF4pJ4YNkfH9RNb25fJs7cDmqYjwAWGeDmPG3IfcLNtsGuyY+JloE+2DmVE8SnZgSqXRp1oskyFH/CoHk3CULpOohbWuPwatkQgI99gox7t+H0oqSQcx6gavsjd3j/6NA+bSQMdZ2lmpjhaYFC+yhm9ky61Rq/tcUHL6e7ChUNtxsj9/7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbqbW4O3jFEWvf9ZNMWPcspqJahUbVt/YsmLXBXU7xA=;
 b=F2WENGj9pi0nIttks6XaKnfC8ywK4+vjUtGuJ5fMhelmc4MTsZ3WShXQi87Ken7bl3H2qgrFoEHfIjCcEt7WfWBuCVX8z05kZUmpTpm44N8Si+z2K9qpeD0NoQ0vg71sp/5yN2E0Y2sf23LAh/L2x3wlI78FHCn7wPrSlmsdtjRYv/BNOezT/AFUsFG9Pg9JHXEGNnKqeo368iCnyB81g2EKEko2LTP+S6vUbO6wtfB2gNvKUSNZBAbcF6HoZkVlItc2vcfd5/LAQP0eRg1njdYtFxD3bNNU/YaQfXPivNPMnyZoQXlCM/1FxbJgGg3Gex4evZTFBs2FXjqR2jChMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbqbW4O3jFEWvf9ZNMWPcspqJahUbVt/YsmLXBXU7xA=;
 b=iRvtoDSX+8tYChRgpKx5ZGvoWZhXWLramdRRCmJLW5V2Hq5kF2NzbRIfww2inM4925JeQof1+zbyphyPpkOAiI+U+ACwnvlOkvSQu3iROcAoUGNezaS7ZwXfLv5vCRCcRL6X6UzhewAsTY0lLyGm1sForZGDU7YAA+XjM20qwhY=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB3181.eurprd04.prod.outlook.com (10.170.229.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 03:38:11 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2%3]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 03:38:11 +0000
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
Subject: [v5 1/3] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Topic: [v5 1/3] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Index: AQHVsJ2TZ/jVyH6lNkyvcDWZa1lfcQ==
Date:   Thu, 12 Dec 2019 03:38:10 +0000
Message-ID: <20191212033714.4090-1-peng.ma@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR04CA0049.apcprd04.prod.outlook.com
 (2603:1096:202:14::17) To VI1PR04MB4431.eurprd04.prod.outlook.com
 (2603:10a6:803:6f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1ec1328-c2ad-4fbf-a6ce-08d77eb4b5e2
x-ms-traffictypediagnostic: VI1PR04MB3181:|VI1PR04MB3181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB31811653E53F9D51770EE031ED550@VI1PR04MB3181.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(1076003)(6512007)(5660300002)(478600001)(6486002)(26005)(71200400001)(6506007)(2906002)(316002)(52116002)(4326008)(186003)(66476007)(110136005)(66946007)(64756008)(66446008)(6636002)(54906003)(8936002)(8676002)(81166006)(81156014)(86362001)(2616005)(44832011)(36756003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3181;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8+03pK9gKt8/YukHwnf1qt18f8UZ3DSsT7i48Pdaj4bOA2CyrFSwRUYOgC32H+dmJX80UJZsyDXkchqcmPELnAcRKkBbqAwNCFUk091jYxM8pxincqaTUnarLBeb5BVV8l1lMa7wsnN0U67L3cnGLWBnJHK7+z2yWvx5t7ZXaeGMVhSMEEnE2sO6gVvUSVeL9gEXYn7EfiwHrsJ8rzs3/JWLEWrVpUDQi0+2BV3GxrONCoViYZ9b8vJHXdDZ2nJr+VxHd3jth+1kYYgNs6EU8agl6YVa48YESUtub0Lg7OfAElEU3haetnFZztrLdd5t4fGipwS67ka8DwLQbUaGEdJJ4y0YACuB8M+IXKGaPaptAKz/jtbsvp05g7tZCqlOk367C3PZpgIdG8KZ62VPiLQGuO1P5Ll5qYFrnSD/kkAy+sLPnhhAzfa/34fPpQ2
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ec1328-c2ad-4fbf-a6ce-08d77eb4b5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 03:38:10.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhJDnp/KF+JZTjcKNGktoWjJp/41wi5g5ns9kSez2EoH32E2e9wQMeC+0AbKF9jH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3181
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Our platforms(such as LS1021A, LS1012A, LS1043A, LS1046A, LS1028A) with
below registers(CHCFG0 - CHCFG15) of eDMA as follows:
*-----------------------------------------------------------*
|     Offset   |	OTHERS			|		LS1028A			|
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
Reviewed-by: Robin Gong <yibin.gong@nxp.com>
---
Changed for v5:
	- no changes

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

