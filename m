Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39DA611A59F
	for <lists+dmaengine@lfdr.de>; Wed, 11 Dec 2019 09:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfLKIJm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 03:09:42 -0500
Received: from mail-eopbgr10044.outbound.protection.outlook.com ([40.107.1.44]:32051
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfLKIJm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 03:09:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhfKxSKaBCL7oTe5WS0EOrzd46MqLnrFz4mmKZrWoyWEvSn6/VgYWXixy3RWBZmrjnfvR/iW+zRw7KeNgbQ0FviWBbdUThskxSAH/Fc7db9QD5XmYFrDk3wqhYehNDYtOdfIZnTgexyFFaSLb4b03rt2It3toMZTF0+9YJfhqoMkVn5tQJ0Ibn/qQBmoeUvsGdd4j4l6f97cHrxqHKu7/InZo4o9OWLgVHctBAIbBzAIs0/LOV51+ylM9qvN7/V8UkMAEGG9qKdxUjl+S1/83whbMnPGZ9MZiq3Mc4LUAvUWV4K6rQLfSl58JiDq9MsUwuhHWH0knRq90AnVTf5XQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY43+1YJu09T2gmZkR/fFiUsp4P9KFzFb9FUwGAZieQ=;
 b=RdinnvKyBDMcRd5yHGwMGZtvwHXlQaK74MGbCvxAmSwPdLC60ozmfLnHAfM0Qb4W96Y9bK11+AvtbgmENXQmIMf1ZW3hbPRfWwEIB5ZC/RY3iUvkI130cGOuPBs//6cgk8iKz2yRMo2JKxSN8am29W/5CEZacxecUNx9eEeiFQL+sxfqx/uMxRkxZAAPv+PhWmHcX9zerhHrzQUvOJfTJxHgQm4t91PAgTGbZmH5dzROKRwI5kd5f89iDkPBNUfZZNqq/QPRTRLzkF15uDzrWFafZBgS/gknb30/xwqmbUvd+0Fin6ugiqQi3NkgTn8L7cIkyBTFayhqfamvG3xNAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY43+1YJu09T2gmZkR/fFiUsp4P9KFzFb9FUwGAZieQ=;
 b=hy8zA17VWK3OrP0u96sUXg7IThjqK+mkG1f+phNWi2yQ0YmGHGpB5Do0vO7ZuFI9/zUVzBMjozEwsDi/H8/dO7spZdYbhDOl+MM/UrwT/Mkvnj4y871WS6s3NuifE4O+6L+eOpvqcRIYEINUpWEwJ/UipCtjXiBIFdM5D5xbALE=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB6222.eurprd04.prod.outlook.com (20.179.24.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 08:09:39 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::c947:5ae7:2a68:a4f2%3]) with mapi id 15.20.2516.019; Wed, 11 Dec 2019
 08:09:39 +0000
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
Subject: [v4 2/2] arm64: dts: ls1028a: Update edma compatible to fit eDMA
 driver
Thread-Topic: [v4 2/2] arm64: dts: ls1028a: Update edma compatible to fit eDMA
 driver
Thread-Index: AQHVr/pVLFcNUBU5x0yRpJwDJ3vngA==
Date:   Wed, 11 Dec 2019 08:09:39 +0000
Message-ID: <20191211080749.30751-2-peng.ma@nxp.com>
References: <20191211080749.30751-1-peng.ma@nxp.com>
In-Reply-To: <20191211080749.30751-1-peng.ma@nxp.com>
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
x-ms-office365-filtering-correlation-id: 0d902cc3-ebce-48ff-61eb-08d77e117818
x-ms-traffictypediagnostic: VI1PR04MB6222:|VI1PR04MB6222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6222DCC4B6E4C60DDD61CA93ED5A0@VI1PR04MB6222.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(8936002)(8676002)(6506007)(5660300002)(44832011)(6512007)(4326008)(2906002)(36756003)(6636002)(66446008)(71200400001)(186003)(81166006)(26005)(2616005)(52116002)(64756008)(110136005)(66556008)(1076003)(66476007)(6486002)(81156014)(478600001)(54906003)(86362001)(316002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6222;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsx34WGeCfk63oNUUfhMXqojF7xilNN+fBswtDpBC6EbpLlE0J0dYX3HGQAXEkQbLZodtPbZzcOeTLJi1hqEFiodsab41TUclIxYkurq0l1eF9rZReXneFt/aU7GENg4DTynacQOM2EJRGrtI8eoAUtKGAx2OFPa1HY5zpDClOXDg69F7WhCEMdlhqVhINZvPGcK5MjsmWhxzq1/IPmTToa4HbWxW2o8k/rSxO6H3HRrZj+7CL4mnged4HvHX5beS8WLP2JpTSdgTQIW92jQpLE2oHxoDL08FmZK7vskxL0+NEjk0UrbU1s/G2DWGS3A0TDKI1d1wIHRTwBLyh9QceOgIltpXwOCm+pF7yPRLU2RDi0phPZPHh9pma84d9NVyI1JYPAYBut9AidG6GjbjOa7TuY2lzANnXnM8HROJZEQ6YjSyfG3VmPo7GVel3Ad
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d902cc3-ebce-48ff-61eb-08d77e117818
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 08:09:39.3070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qKfU6odnM+cRP4zHfEBmD+6wPo1I2vZ4ftqUJrxVnAb1uasLGwYhSMJx/KVLvDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6222
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The eDMA of LS1028A soc has a little bit different from others, So we
should distinguish them in driver by compatible.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
Changed for v4
	- Add new change patch

 Documentation/devicetree/bindings/dma/fsl-edma.txt | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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

