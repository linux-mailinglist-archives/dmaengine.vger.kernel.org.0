Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6723211C3E2
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 04:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLLDiZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 22:38:25 -0500
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:46000
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfLLDiZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 22:38:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsbV6CqJ5Xz8kmDgPlmTuJ9ThsghR5dhU09wEgXOPNOZ0EtM91Qvhp/cG7DB16b0unOj+2mnBv8QbTUGn0fNOU21ABrjgD5LDKx63vgl9YdqTWhpA6eW9yQQ+TOi2CJ2Wl/NnGLiyVc3TN1K83mEBlXo6vUWdqmPNoAvwKZY+5wkhWbqCBedoIac60f4nes2hVAUZ4EfSbqotQHce7Ht4LvFCIpoDjCz8IcTJ6YNH7LNofMSqsW+rc2jXYPQN1qiKMZvBhz+ytgJO6w1Pu7jlf2idzwONlIgcjXJbZTzBDSPwFJ9jibwZfag9oL4gHD4T53cnna2fjU54d3BzjQI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKrX6ryfsoHTWteG4YWcHdXIXAEYymq1bqNyglJ7oXo=;
 b=EuJvxwfE7aQUDE0qZV+chzTOM19FDYveKeCL1b9ElXlwGJH8Crvb7ckX7Q1PRcZO2onZaBOu2gL6pPXw1WQfoL4KTfOTDvOgjutWZI0HhFEg4fbLcj15dFI/BYZuyFt37tQ+VvN2uWMuL5P7XmEPGxg6w7OJYlywVg9QBPgqyyI5GLkoDOoBTdZ/6vmjm3puYJ6+NO7QL3E8OqnPg0Yvyf5sJHxDX304yjjkac6XkTYZXKsPmNofQmX3Bd36kCfYgUg1tUWe6u8+cK3G9WCtcogLazfIbBKY2F1vT8ukowzW92QTrqrLz+L4ikS9t+VYHF+78ZlLckaE+EujYINwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKrX6ryfsoHTWteG4YWcHdXIXAEYymq1bqNyglJ7oXo=;
 b=krUCc7g32i8hZ/9TCTC+5EBdixek/92lSRvBQNRltFJAu3kIgCpjeeHJL35Kwx6UYNDaaEBEdRQIRY0tM1PI7U/de3+uHT5sOC+GjaU2bz6MN6iwfO1Hh3fyEg3IGZQBoUQ4wmQfsahKwb5mBekJpOC8seRYCq1ibETDwf2WsUM=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB3181.eurprd04.prod.outlook.com (10.170.229.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Thu, 12 Dec 2019 03:38:19 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2%3]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 03:38:19 +0000
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
Subject: [v5 3/3] dt-bindings: dma: fsl-edma: add new fsl,fsl,ls1028a-edma
Thread-Topic: [v5 3/3] dt-bindings: dma: fsl-edma: add new
 fsl,fsl,ls1028a-edma
Thread-Index: AQHVsJ2Y3HluABJs6U+dHTTAWS2VzA==
Date:   Thu, 12 Dec 2019 03:38:19 +0000
Message-ID: <20191212033714.4090-3-peng.ma@nxp.com>
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
x-ms-office365-filtering-correlation-id: 268bf6c8-a945-4f3c-80ce-08d77eb4baf9
x-ms-traffictypediagnostic: VI1PR04MB3181:|VI1PR04MB3181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3181B07DF42EBBD15073185AED550@VI1PR04MB3181.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(1076003)(6512007)(5660300002)(478600001)(6486002)(26005)(71200400001)(6506007)(2906002)(316002)(52116002)(4326008)(186003)(66476007)(110136005)(66946007)(64756008)(66446008)(6636002)(54906003)(8936002)(8676002)(81166006)(81156014)(86362001)(2616005)(44832011)(36756003)(66556008)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3181;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NApVTTCYqkocNgogXz/mPLE4VRbd5fIc715b90n5GfBbHWffJUMtrwdjJHGBVbfa0Vq1SCbYXutB8o0qfXaf9Ef6hUNu1feHJR1+10tbI7uAMngcCW6mXWcQHCTLsYmSuM7yeth2thFMcEuUaUGXKJINn8Z2KVz4zYiBE4caqDbWrk84UWtwh/zCOZkMYPyPKza/x+YM/IOIdgIGjLvXMKmtdfK+JYSa6hF9Okv79PMUD8ofCl0/uCwleYsqPKQ5pKg0DhHNL1MiBv3iZsmS+AFEgmnG7v30ehaAEMoks1DADypKW5YXyAOJjHLZnVYPQlJdh23Az7i9/fUelPzshbX7HfPt/EzBBDTLy5/R+fZalopQGB15hyg75sL0gWCr74MOJt6xR26S0vQvAVHujTQQ5qPkHYAYCWE38jq2NyYssIKSwB4F+O+mj6ctrT72GbZ812nIo8iHftCwbUfBEXMHCSWEreTYgwuQDCGyRFVa8yMMfElD3//5hXWnAn2C
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268bf6c8-a945-4f3c-80ce-08d77eb4baf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 03:38:19.7261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFbyO9MlOWMSuAQmaxYNqlxCeLGUmVOllqSNuQsV6jml5UAUX7Sxc9YTBIkgBYZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3181
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QORIQ LS1028A soc used fsl,vf610-edma, but it has a little bit different
from others, so add new compatible to distinguish them.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
Changed for v5:
	- add new patch=20

 Documentation/devicetree/bindings/dma/fsl-edma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-edma.txt b/Documenta=
tion/devicetree/bindings/dma/fsl-edma.txt
index 29dd3ccb1235..e77b08ebcd06 100644
--- a/Documentation/devicetree/bindings/dma/fsl-edma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-edma.txt
@@ -10,6 +10,7 @@ Required properties:
 - compatible :
 	- "fsl,vf610-edma" for eDMA used similar to that on Vybrid vf610 SoC
 	- "fsl,imx7ulp-edma" for eDMA2 used similar to that on i.mx7ulp
+	- "fsl,fsl,ls1028a-edma" for eDMA used similar to that on Vybrid vf610 So=
C
 - reg : Specifies base physical address(s) and size of the eDMA registers.
 	The 1st region is eDMA control register's address and size.
 	The 2nd and the 3rd regions are programmable channel multiplexing
--=20
2.17.1

