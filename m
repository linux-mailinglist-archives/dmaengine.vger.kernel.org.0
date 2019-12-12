Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5525711C3DF
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 04:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLLDiU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 22:38:20 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:46658
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfLLDiU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 22:38:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAxvvefK3dZ2ORw2wblir4IUhllKzqQ7iXRHxP9EwQElUZ0HuVFfyXxEEC2MKBok9NUPEuzO4lLMuZNy9a2Rfyi5s9NJR1woJIl4ov/sPAKdjApHIgkQpKxClDJVigGyPYWyp3dUvSQh7RgdenqQS2myvDNarxec8olOJZcwVcg67K3HDzKhyueS2PwXUNpSTwsQzYeX/VrHkwxj/58lfbiiOscgbybmLHdVdBw75BOpkS5YwqFdvDW3K/2aPmJTitXAAcqENxqqln/aEUnzS1SusVugYhltEHxVa9gKvwTMma0MEJF0EBMaGKYQHNUJfbS9TWC84UjO8ECbdor4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWsVfGK0bxOq9PMELOpWmkTzoCr1WxMplfvHsXJk09Q=;
 b=Nop6VO6PAxxzRSVXWAMO1HvvPJ1aLVQFvAj3LqNXtg9HhLetF8bE01SxRFFJ55gDQ6/njTgNIhah51mGszTpZVgac5WWmNGw1a2pGPtDV1L+a9ldLhtWhphFgbvWaNy4PpP5Sj0297sq6YrgQ+SLoIALST888rU1STedjlwGQvUXy+RwyZ4Q3W97iP7W77/1bdhseJWHGOZDtlgFick0KnV3IN4Uya2likebRFtqlmRAAdebxorhKyNxeSfW0MZb2Ix7rx/p0iWC+jKrGOta6bf5FjNjbHCJjihE3pvecS26ELfBOJhesaZHZk3U9SVg0AA7roAsuzhHgd8p9D3QgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWsVfGK0bxOq9PMELOpWmkTzoCr1WxMplfvHsXJk09Q=;
 b=BLgl426o29BvZhZNWa/2mrn0Ca4ABRC+SRANQsmgdIlViXHfDJqCvhN5+pGOfjvZ3Wa0JJOT2sGb6JaiAnKoE7rkoJ5YwP1gIoSTO296jlAVRZipFm9NT3gCJ1kIDeb+g8h++lGitG6kbF8ZQ6vtWinygfn+2hu4Zd6dMoos/V0=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB3181.eurprd04.prod.outlook.com (10.170.229.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 03:38:15 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2%3]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 03:38:15 +0000
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
Subject: [v5 2/3] arm64: dts: ls1028a: Update edma compatible to fit eDMA
 driver
Thread-Topic: [v5 2/3] arm64: dts: ls1028a: Update edma compatible to fit eDMA
 driver
Thread-Index: AQHVsJ2W8RhfCx/dzkymv4+bZg9BTw==
Date:   Thu, 12 Dec 2019 03:38:15 +0000
Message-ID: <20191212033714.4090-2-peng.ma@nxp.com>
References: <20191212033714.4090-1-peng.ma@nxp.com>
In-Reply-To: <20191212033714.4090-1-peng.ma@nxp.com>
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
x-ms-office365-filtering-correlation-id: 45b9fab4-c4f8-4c77-d335-08d77eb4b864
x-ms-traffictypediagnostic: VI1PR04MB3181:|VI1PR04MB3181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3181E8B91DA73A467A29E753ED550@VI1PR04MB3181.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(1076003)(6512007)(5660300002)(4744005)(478600001)(6486002)(26005)(71200400001)(6506007)(2906002)(316002)(52116002)(4326008)(186003)(66476007)(110136005)(66946007)(64756008)(66446008)(6636002)(54906003)(8936002)(8676002)(81166006)(81156014)(86362001)(2616005)(44832011)(36756003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3181;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zV1zD7gUbIyY2hNJ2ETLTt35jIPLzWX6kZmBupbTGbptQkCEXpWn0PEyyOCUXUBZntULb8aasPn10his/OuahmjIunajXHfEJN6KjVfPClvfXbAFeDtzRSBebdKzd2bL9pMNb44xIGZnjZHBKur9+ZbxP6ZwdCSQ2FusN+M2LY/ftVvOP36T26rvdmerxPd6PKJnEjeVWD5qTlEpFgbhZfy3niUqgR/v/RENEzIbobMtzY7oepOrrtyHW2+Gtr2a9xN9tR8hCC1dluVfaD0f9YOwBCnfxJlapylGyiqNYnv3z73R53Gmb/kcHTyo1h//UhSeOKGB4COBqxwEXxkgtPtKUl2U/ClWOme+7nTYEDNvtgmYo+e44OU3rSuwyTIr3WKgViyu2B8/SHTsAgwHbEQPxXC77A3ZRv8nVcLHDuaafKYbPlNSoYwIK1+37g2U
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b9fab4-c4f8-4c77-d335-08d77eb4b864
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 03:38:15.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0O33lbdFjR8ACrm49JolU3Hie2fUz53kT69zptJy3Op4orIEHJ+PndEyMXEhPjV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3181
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The eDMA of LS1028A soc has a little bit different from others, So we
should distinguish them in driver by compatible.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
Changed for v5:
	- separate dts and binding

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-ls1028a.dtsi
index 8e8a77eb596a..b3716a89fa0d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -316,7 +316,7 @@
=20
 		edma0: dma-controller@22c0000 {
 			#dma-cells =3D <2>;
-			compatible =3D "fsl,vf610-edma";
+			compatible =3D "fsl,ls1028a-edma";
 			reg =3D <0x0 0x22c0000 0x0 0x10000>,
 			      <0x0 0x22d0000 0x0 0x10000>,
 			      <0x0 0x22e0000 0x0 0x10000>;
--=20
2.17.1

