Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D00951168D0
	for <lists+dmaengine@lfdr.de>; Mon,  9 Dec 2019 10:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLIJCe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Dec 2019 04:02:34 -0500
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:20357
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbfLIJCd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Dec 2019 04:02:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoEs9Jt3Z+AuMzmCfzitoefu6UQJhlUrDxnqbJayoXEPdvspb4QESIxmzItbRV8rW8JRkVp7KtgH+i5MxFQoHHqh3d1Zl8rZdlipvKa2JdrpH6uHLinRTlKLQ7gvYKHwpIiJyiRBGHUhU6bJqy2WED8i/qCbNDI8KE2GL1BCXYMftgjKwDlTipSV2dK2Mue8K6VNp3GZQfYWh2y4r+P1ILoukH4FipXYNH0y4wTgkSp8jDZkfJfAIJslsRjbbTbZ0LpVtmFFgaCOp1DrpayVdqEBgyyHHWL7hvMIQzT0k6U4b6Wy5tjvKjCj2OEko7g5UFZYzdkpwgnbSPbDUHc/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaB5Xr33ALFA9e1KVRVeWhMR1ihMSlqDp1l0Qgz0QOM=;
 b=ZodgxTaKBCVG+IIJPls/JJ/lSBVotpIcBwSo/f2Ep+sadyqlZFxhp6ohRau7Ooa5Yo3UzVYzhFhbbD5cl3nLprOKhW97ltKT8EYutx/QEpPWxUsZBws3UAcq8D7+wS5OlIV9bwhvgsiTLRasuCbzh6dBtMHB+TzHURBK+KumW6s2RK/2S6LlL7lwxFdG/0sJXIsHs4KG1ttK1sViD5jV1KuDeTWlM6kFIr3XJqC1Hjs5U8nNbBv1DOWvA+ir97fsBNPowxmwa7x6etyDEtBuicJsD9nDOw/sJCYpyi6dnnvfcL3VuC3SX0XDNFE6ASuAnNb9SNGvn23pkVqf17cHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaB5Xr33ALFA9e1KVRVeWhMR1ihMSlqDp1l0Qgz0QOM=;
 b=QyaISGGFTuRnqF5puMessZsw5oJIDAsUJp27yNgj6GkawxL6lOb0ljKKry4ezuBwIOjH8eqGsrWvegD6mNh0bucE5XQNEnhkO7Z7lCEfQ5Ve2OHFR3sH8VlNt3CDDVEMyCvMLfll0cROPZGzOCaOi6EBvhoiXZYp35EO9Cs5pfw=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB7151.eurprd04.prod.outlook.com (10.186.158.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 09:02:30 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2%3]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 09:02:30 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>, Robin Gong <yibin.gong@nxp.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Ma <peng.ma@nxp.com>
Subject: [v3] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A platform
Thread-Topic: [v3] dmaengine: fsl-edma: Add eDMA support for QorIQ LS1028A
 platform
Thread-Index: AQHVrm9ixVNwnMvsy0G4gu21x4yF3A==
Date:   Mon, 9 Dec 2019 09:02:30 +0000
Message-ID: <20191209090110.20240-1-peng.ma@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:202:2e::24) To VI1PR04MB4431.eurprd04.prod.outlook.com
 (2603:10a6:803:6f::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f279f4f1-e09f-42e6-2820-08d77c868556
x-ms-traffictypediagnostic: VI1PR04MB7151:|VI1PR04MB7151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB715100EAD89F24F8B30362BDED580@VI1PR04MB7151.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 02462830BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(199004)(189003)(305945005)(2616005)(81166006)(81156014)(71200400001)(71190400001)(66946007)(36756003)(8936002)(5660300002)(66476007)(186003)(64756008)(6636002)(26005)(66556008)(66446008)(6506007)(102836004)(86362001)(54906003)(110136005)(316002)(1076003)(8676002)(52116002)(99286004)(478600001)(6512007)(6486002)(44832011)(4326008)(50226002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB7151;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOzISLLA8bfO/q0cyjY8vVJa2n4WvmJ0DVJmkT24J9oOiNfUwq4uZv3tWrt5OtjciMsGFBZbgmZ2Mnb9YZG1kJPkUEiBxe8Y0A0IPF0YgfweULlKcJ5+QDZRutsiFO3Xeri2RaeRoJil9xgkCUQFL79flAvjUYE3REgRf1wFSdbk50BM4ZjP779GsvoAYcf5JEwn6N+piaLAWlglz9FnnMbbySEWbVHnVCnnLlg52TKyBnxsh0ajdRVlrWmNfz8mmCoKyDJO3M31KPhdOyTpU67M+JGUUyD/IUIxZnkCP4KQjfvhjcX+3itzE4+LktkyC9pQu/aWXnDvmZ0BP7zs59ZIleHMejJqr+WkL0N/wvcsAfiEwqcX3o+bw259cgJC0mCSfWhiHeULYTou5lqJP5WWyvnXETEp0HECjxb7fQQjrYPX98G42k67I8N1yhRd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f279f4f1-e09f-42e6-2820-08d77c868556
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 09:02:30.3031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVk479WAyDrEqaZiRRRhHjxlP6RI/rT1UmVW08Ztt6gJk3d+VH7e4w6cJZ5czdxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7151
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
Changed for v3:
	- Rename struct soc_device_attribute

 drivers/dma/fsl-edma-common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b1a7ca9..10234e1 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
+#include <linux/sys_soc.h>
=20
 #include "fsl-edma-common.h"
=20
@@ -42,6 +43,11 @@
=20
 #define EDMA_TCD		0x1000
=20
+static struct soc_device_attribute mux_byte_swap_quirk[] =3D {
+	{ .family =3D "QorIQ LS1028A"},
+	{ },
+};
+
 static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
 {
 	struct edma_regs *regs =3D &fsl_chan->edma->regs;
@@ -109,10 +115,16 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan=
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
+	if (!fsl_chan->edma->big_endian &&
+	    soc_device_match(mux_byte_swap_quirk))
+		ch_off +=3D endian_diff[ch_off % 4];
+
 	muxaddr =3D fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot =3D EDMAMUX_CHCFG_SOURCE(slot);
=20
--=20
2.9.5

