Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA39BC52C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395317AbfIXJt0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 05:49:26 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:38614
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392592AbfIXJtZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 05:49:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0txogB4rFx6NKY5ZqwmrVy9wSXOv/92LbnYBDhle+iPOMdvTXoV6WhvcW66QMZ/TNTnydddwZdKZL24LrZvC2Xzj+FwNVMtjwqGYc0sl7jjQllW3MyAc5PjtXh/OZU1sMMt5G6ouhXpl2KwgfMtPh+g+uBOYKm42tf2ODBcyk5XvyFtLIWDL9zQICG3DezuQVh/GhagXp2juLsESJ+RTaEyjFA7junyHNpbB2e8NIdS05ib6kOu9fg+lbbC3QXYcWSNFjYrYW7Hook6cPyRmgxgYA3X+IvMHHy3KZV7y8sNG4jWjDmVB69ggrkatyFoMeg6hDq6CCx/BtsfarbV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAPPSsCtAOwgKhNpbzg/xYaJiessAiZJO4uR8zuUmPU=;
 b=TWaPO5sbvO183pcXX6A+kZpGFpe/2RWRoYxEq7eKoFIpzyb8TXlmgCzPAK/URlmOl4nERPxsmhqU8deqM0wIKF5PGD3sYO99OG0UNZsmcTSuohBn712MM+FfdKoWJkfM7BOyBnnBNXLKah5Gcsi8I9cv0kBZIVoM3RWk54HD/d3wc32VtsCmZBxW2m5nKVPNeqfcQf1dTUaGRqzK1xkKAb1Lp2VlqWhWe4xeM+muOVb/wvnrc+9+sBEZtlSEkwN72vIXUvp8MPRc8ZaeW6cYlwTfsR3RKPgcx1ntf/IWRfMTsVanuIUV6qi2Swqfb9wSG+ycirZe8mS4FkfU63m7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAPPSsCtAOwgKhNpbzg/xYaJiessAiZJO4uR8zuUmPU=;
 b=YOArI7n5HtOHr9az3QrKGjx018ealUNoW35AAa+KKWmUbUckO+KTNHZUqwnaOP38LqHTGp5yZVox/hmBn6PVMkZa5yHqsOz1x/SI1LayvtLJ7dANQ4rydKy0Z+F8LQrDPbb795U303L47il032AYTDdr65yn6WpkaD15qkrDGeI=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6560.eurprd04.prod.outlook.com (20.179.234.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Tue, 24 Sep 2019 09:49:18 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::35d1:8d88:10f4:561%5]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 09:49:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "J.Lambrecht@TELEVIC.com" <J.Lambrecht@TELEVIC.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] dmaengine: imx-sdma: fix kernel hangs with SLUB slab
 allocator
Thread-Topic: [PATCH v1] dmaengine: imx-sdma: fix kernel hangs with SLUB slab
 allocator
Thread-Index: AQHVcr1VGWNo2EzDlEmVbBRWEyoOAw==
Date:   Tue, 24 Sep 2019 09:49:18 +0000
Message-ID: <1569347584-3478-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0045.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::33) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8483d06d-f9be-4148-f3d9-08d740d477b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6560;
x-ms-traffictypediagnostic: VE1PR04MB6560:|VE1PR04MB6560:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB65604C340BA36162D990FB8689840@VE1PR04MB6560.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(199004)(189003)(5660300002)(66476007)(110136005)(6486002)(36756003)(6306002)(86362001)(8676002)(486006)(66446008)(7416002)(26005)(81156014)(8936002)(966005)(4326008)(99286004)(2501003)(102836004)(6436002)(50226002)(256004)(14454004)(2201001)(3846002)(186003)(25786009)(478600001)(6116002)(66066001)(305945005)(71190400001)(81166006)(71200400001)(2906002)(14444005)(2616005)(54906003)(6506007)(316002)(386003)(7736002)(476003)(66556008)(66946007)(52116002)(64756008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6560;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XKKTYo4pPRs+46TEbEl/CXyJvGirY8qB3d2B5mnXzRuTH5ZXMl4zGYoj2eINSmK4QifxcqOp9wf+ury17Xx2k54qR+Kw0zIX+DhS2oPnfljLGMx5plMu804Abpf7Q/qdvgGY5cSJm+pfUN0FgQN4NWtIGuy58TFOI5Y4ki6xKclrfIBGbprDC0d0YfIpuHh+OaCLCLYaBsdt0MUMA09H910dLkJHjnNHht2jMPiQD7f9JkkdIDlZZbSOn723G69tgbJCpkTgfdP5b3q1YiMsdTAXAbvSeJwAM8/m4TeXXNPL8KnMLyvh8ERhjR/wBLe6Jl+CV6Tu0Anlqzm9VCxfrUWmoP/K4vy0Ft+eOZGmEspVYFmALtWQ3TDMubNulza170MrdNTqNWBmpWp1pmrYC6i+ANeYtTdODSJ32Y4eafeYOvr8lzM2yCvbYuH7rEhVLACgk3l954XkLw6ueBvI+w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8483d06d-f9be-4148-f3d9-08d740d477b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 09:49:18.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VmFAyFNomgWRXTTuRZ+WDUviwNOnSn7sTdmyJ2pZzRvzmUDjwt0fLSWSQmdntsDrOLfcqR0dV/fP94Cnv3FW5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6560
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Illegal memory will be touch if SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
(41) exceed the size of structure sdma_script_start_addrs(40),
thus cause memory corrupt such as slob block header so that kernel
trap into while() loop forever in slob_free(). Please refer to below
code piece in imx-sdma.c:
for (i =3D 0; i < sdma->script_number; i++)
	if (addr_arr[i] > 0)
		saddr_arr[i] =3D addr_arr[i]; /* memory corrupt here */
That issue was brought by commit a572460be9cf ("dmaengine: imx-sdma: Add
support for version 3 firmware") because SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3
(38->41 3 scripts added) not align with script number added in
sdma_script_start_addrs(2 scripts).

Fixes: a572460be9cf ("dmaengine: imx-sdma: Add support for version 3 firmwa=
re")
Cc: stable@vger.kernel
Link: https://www.spinics.net/lists/arm-kernel/msg754895.html
Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reported-by: Jurgen Lambrecht <J.Lambrecht@TELEVIC.com>
---
 drivers/dma/imx-sdma.c                     | 8 ++++++++
 include/linux/platform_data/dma-imx-sdma.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9ba74ab..c27e206 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1707,6 +1707,14 @@ static void sdma_add_scripts(struct sdma_engine *sdm=
a,
 	if (!sdma->script_number)
 		sdma->script_number =3D SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1;
=20
+	if (sdma->script_number > sizeof(struct sdma_script_start_addrs)
+				  / sizeof(s32)) {
+		dev_err(sdma->dev,
+			"SDMA script number %d not match with firmware.\n",
+			sdma->script_number);
+		return;
+	}
+
 	for (i =3D 0; i < sdma->script_number; i++)
 		if (addr_arr[i] > 0)
 			saddr_arr[i] =3D addr_arr[i];
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/pla=
tform_data/dma-imx-sdma.h
index 6eaa53c..30e676b 100644
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ b/include/linux/platform_data/dma-imx-sdma.h
@@ -51,7 +51,10 @@ struct sdma_script_start_addrs {
 	/* End of v2 array */
 	s32 zcanfd_2_mcu_addr;
 	s32 zqspi_2_mcu_addr;
+	s32 mcu_2_ecspi_addr;
 	/* End of v3 array */
+	s32 mcu_2_zqspi_addr;
+	/* End of v4 array */
 };
=20
 /**
--=20
2.7.4

