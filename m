Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF022C359
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jul 2020 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgGXKiI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jul 2020 06:38:08 -0400
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:43040
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgGXKiF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jul 2020 06:38:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmtYcIS7vuwckIDTIv/cm6pGCXy4tGN7lGoXrtfej3jVB0kWAPHkvdzoLEAABGlOquwlwonJQ2h7UDJpqihf0CYrZRjq+gzkgKu3oQYqzpgS9dvSwBunRuYHzJSyVGFTCyU3ECZiIyj1cke7YMXvPTw4D0TMkr/r+WLK4QQx2zk87vsToDiRjqpNYzaRfdns6Ing+vjEuDSwCdbA7A78YTAg58zeLndm70LmHpycscm78xfsT8vWl/SNxNjAUuCd0U9p3UEEk0xiLE5KKt0VZTlUls9SA8jbO2/44SV+MHR9IPgxSFLwyx+MboJnYgEM5NyVYJEtUwv8k2QaJzrvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=aKwueF9pKwSeTDiMRszGlUM5AX5gDBQKqEnVy3PkxcygJg/Lo2D4TVMFKgT5js5m2r8iXGtJRQLTG4VAqZOapnMsXCpDv7oAF6ocJ5ImYGrWyvXIeL0b2ykXKAl5OiRLto8oygtN45Ykcl5O7KRQPAGmGV8jTAwaWWZbdQhtkYUh/XoURRmSoFMJKhL/dUEwKgErVhHjvAu5LzrDF0Diiagbp1f9nbwOEhokLJnHl69POjjFQCS5PJVfG3uZor0GDaXbVYKtlYYSmW3Yj6mjhhTKWo22qExfpql2s8D0iX+iFotRlPJn1MJ1V2ON9ku3WVGjuPhVa7LPTWF2Bra5/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=h1iuMYx4o5K/wSMzSMrhx56bQtq34xuwWbUbUvJycdmxmhmZuS0zeNISCEC0Zm9dWMxiWzOaUTvZF9GwOse0iQzqSKE6QkKxgHqohFL9WAQdfaL4C5elJBrFfrImZPX/R4wgj0/f4Ab5QA1qat69kzcGD3rwqp28VXaEqSdjvsQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB3710.eurprd04.prod.outlook.com (2603:10a6:803:25::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:38:02 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3195.028; Fri, 24 Jul 2020
 10:38:02 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v11 09/12] spi: imx: add new i.mx6ul compatible name in binding doc
Date:   Sat, 25 Jul 2020 02:51:22 +0800
Message-Id: <1595616685-9987-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:3:18::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3216.20 via Frontend Transport; Fri, 24 Jul 2020 10:37:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68b3ede5-2c55-4563-cc1c-08d82fbda3ea
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3710:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB37106BBDE7047B2203D628F289770@VI1PR0402MB3710.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhi5bks/3eYhSIO7gqEMhsO8PN22ZvqykxLH4O3rcz4YXdMQFmAD/ZCHKUnhszikKb1BG3vzPxQp7/NTiI1qMnJ7iv0WmDPEfFzXHTZqmAp3EK46WKpIZyDMFCYSmToKGhjAn7fiCc8kddLopK9QOeBaP59sY9kmnQPSO/6oGklCwdnL0vBiD6HVDoN99TUbbWvz+sFh8TaoW9GZPyMmbj19O9b0HrlBk0QoJ8M860pNVKlVKA2Ukinqgio2Iln+yI2KzGuvlHOIp+BzeLwL4FAtkwCEFkyR/iUodga5QVNirPDR16UZ4lrUzP30RoSyQAFr42qip5Q4OiwowDa5OKlWdyGzcsGiVFjshc6H2ttnndk6Owzgh0VsOWPnoeyd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(16526019)(186003)(66476007)(2906002)(8936002)(66556008)(478600001)(5660300002)(7416002)(52116002)(6512007)(36756003)(316002)(2616005)(6486002)(8676002)(26005)(6666004)(86362001)(4326008)(66946007)(956004)(6506007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GE90Q4JivHq58MK8uTolV9PKBY49+ypSI7FNE1+TWOCo/QkxDuqiIMZVT4NXaQCJEojzuqNlTw3DEZRq2SStkTeVpRs9A7EULd9BD4IAljY1gfVgU/xZVC1zKYopl8svbKMHFavnCZP5AQRQzRvnqmMlZPWccJIB7a242HtQH00O1n8DXD9ephlq9CS6FxptJvKAlAk0ElOXK1gqXQu1T0F9cH3G24l445Rg+JWcUH4WNe1rZ0I0pFP268GwPE0SgTmxXD9x19F14ue4pOVE1UiOycKjtdrse9JW0cPt4RrsDxI2pDdb7L8rdc4HymfJ8D6W6Yn8fj6O/4rEtir81opi4w1/xpJaH4lwdRjcDsOXmJthjTrb4O/0oJoo50aFb0GgCUh2XGD7WFpQ0dBCfahhikT4YkyFxIAYtS2zl574X64+YUJaarnkSmKAtymHH60zGJmVvK3eTIIHvUuBlbwXfunT5MtbceKP7AAEMqE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b3ede5-2c55-4563-cc1c-08d82fbda3ea
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:38:02.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQexJS8eK11zeRehthypu8CnP4x/9F1Iq7IgP66wXrpaAQYwNsXAwg8lwR8Tw8wP9/b5T2CpvnGImuI8W7gIpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3710
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

