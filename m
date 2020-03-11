Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B142818133A
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 09:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgCKIgK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 04:36:10 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:44737
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728255AbgCKIgK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 04:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn+X8QHlzcTMs725QEX4VsziyPUCL8ymDw84D/s/Ra5b532fg9SuCuJS/livp0ZFNVEm6usQZexIjuFRsStrm6mm2vvpDCfxPHMkzUbsTOcffv4yfRd1wZWBlsTV70xtQZ4eSn4r8EW5o4wsp41Bu8hoLnWZavoOOVLz+hx681rh2jXbLOLp7XGa7XaOuBgxsHnkizKfI82G0Z+XTJhQqYI11FJzJvXjlTt/R6W1y5yqJXsq8nVO6jQkyplVAlST8BSf7ME1kZ7t/+pDmr1S/x7Vb3MsNKFxl+on4eFmmDibOZtpyZLtjxjlAC7Cx2QgL3XSihuDlS7LWlAEs/KBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=gzhzs+c5E4uwySFfk+kEyom9+8FQmwEOR9H39dPZkDKEPbzW7RvdvP5/RcGIaICFMrQ3m4ys5+79u0p7uyb25oDeGIQxIwV09ffzPkvKhikLYK1XxfGfNiWpY816ZMMggbVH8nmAv7xKhJwB3/923qm77p/bUc7qBCvQTu1lbY5y5dzHHZqjapWen2trw+vyVFlkZnO4mVKZp4HGxP4jzmeql3pizL7CbDs73JKDd0+BUJfbsmuj2QIJS31Khti+XOkT2xKk5ITcdyzam84MX57L1r4chRszBY/FORXEYDhiQOR7OyI53ZlpxtXQIRf5ztKVe2TzJC6Z0bcxwKWWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=KW2db28YnfXqA3nnd8OBOGiHMrXaLobqCMmoXlRzI2oJc2/ol3INdsX1/uO17sXTfbUyyaDjPaFNYiimH0GTxSX0J7zZjvuksVpE2v3HKGFYF2miy+StVOKHpsbQiDxb1EwTF55s4LX7gh6dd0xZmnXvjU+8jAoTX2CGbnksNFU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6462.eurprd04.prod.outlook.com (20.179.232.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Wed, 11 Mar 2020 08:36:07 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 08:36:07 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 09/13] spi: imx: add new i.mx6ul compatible name in binding doc
Date:   Thu, 12 Mar 2020 00:36:32 +0800
Message-Id: <1583944596-23410-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Wed, 11 Mar 2020 08:36:01 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6a05e07-c512-4f8e-a138-08d7c5973de9
X-MS-TrafficTypeDiagnostic: VE1PR04MB6462:|VE1PR04MB6462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB64621EF3289A096383B3573E89FC0@VE1PR04MB6462.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(199004)(52116002)(7416002)(36756003)(5660300002)(6506007)(8936002)(478600001)(66556008)(66476007)(66946007)(6666004)(316002)(2906002)(86362001)(2616005)(956004)(6486002)(81166006)(16526019)(186003)(81156014)(8676002)(6512007)(26005)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6462;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCNxtxeD98WbXbnn960p0paes+4HVsYLxhI5cQ6tEC6KbxyjltBHZk4THPL+gaRxHgvRsxATBSc6Qbyxkp22wMHa1+rmd5lw1mOer+g72AolhjlsMWL1tIYW08Ht/JBMbNgyKJTLqleYJPKFB3AxyCzGNWx8lOwcdEI/X5wSruTPZRHfBD1di0MQ4b1h1bLxpiLfIB8A37IV4HB40I121YMuLN6RTCvOJ3NBIS949bYEdrAkDfZxCD96wLvhhV72CpGQ5PWnPSa+O8Qc/K+lYqMZrC2TSr4Rixl1du7xQMSueksoO7KZp3WSVAiBFrro01cYI8/rJTxB/AfXRVZHmCstpYnAfa+M1MraqiQAivyHkHtTKGLnqlH04Jgoz3n0PCP6OWldTHh5ROzCoxmD9syt4zQUwRGbexMqruD4X1nouPiS98t/gOH/ccdL1ZKrQ65MiFLlj5oFnC9BjSG8on74tFODeSjlR7ji/JVIbTVeEkIuBsTRsKvfkD4uJo+j
X-MS-Exchange-AntiSpam-MessageData: hl71z+TArBURQneG9e7fx45bDomQpjjEKuo0Y1M5qSye+WgJZX4GJmZJVt99ng1f0xukS3cafNZHb7ERw53/fVjww38pqZz/ZTIEZkZQkMTGTcTR6AEjA7vhhhQIig/MdCU1y941mpNKl1zmL5tqcw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a05e07-c512-4f8e-a138-08d7c5973de9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 08:36:06.8817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0rC4ZLoNgEs9MAuA/P4+vFBnR0q4TY0UboXm1F5vfcOxny/k+yRYPQSBJXNb3cTnUUctKmYxg5jSpsyff06Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6462
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ERR009165 fixed from i.mx6ul, add its compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 33bc58f..0a529ba 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -10,6 +10,7 @@ Required properties:
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
+  - "fsl,imx6ul-ecspi" for SPI compatible with the one integrated on i.MX6UL and later Soc
   - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
   - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
   - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
-- 
2.7.4

