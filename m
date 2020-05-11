Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F65B1CD523
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 11:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgEKJdY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 05:33:24 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:53395
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729392AbgEKJdX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 11 May 2020 05:33:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8BI/Qfph5iq+Z4d40eXA2yc+Ne6E+RLaf/Kuu/Rw66jG3It/+QfPt7mp2dx01iBMmJCWg5RGYTNZqtHundin6yo0kcXTD4a1Lv+8YekiNzuHMMnI3XrOond+YuucLOCPOfhXIbADSf+KQrSF2KZQcaFlnF/KcMDIv7tia7NRcUrw1d9dO0iDza6rp7F3yA9QXHP0Q+kweRJjUUv9TgfKkqhfK3/Wh6NW2d9PETzHytsl0n5BSM91FUVx9KhgqCWvU01KUQ08RrBUBILBH2DsWdpqdQMLzRz+TAwPvU6r7391wtA+dN2zrvz9QbEev/9ZCC2Zt/t81D9nTnZXg9SAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=MFhtMWDIriw+35CSA35bcR7FhPpr4oJiajyD83UsYhXfs4jQ+X/q3++D2jClF+uTfAsGaedbz2OxdLi8YEtovwAK9eHUnO4Jwmh2K/16lThx4+wIOwdT9nHRgWBNnlJxmh8/hnXnm5XbMeZId8/PfMITpGubJhbVJvNqNg/cIUab1pyhc/2MgPAiAXcnvO1sCn4MBIoIJTgzfA5Z7c7SgNLTI7w3yEhWigYnwl9RM2uRCZehzks7mfI1H6d8jPQiTRAGB1pwa+MTxIQ3+OBiVOk0NgE9PAkpH+27q+npZWP5JMMLt7M21IsAsGZ3qii2ZMDT+dFmWilPNv6bhNeaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=oqcIn4rqsKCLvQVbzp43vGft0QkieyVm+CevKDGhUik/2uKT1d4Xx4QaXbYtwRshBnUZTHNujoJOLUakHfPTccRvBTqRBjxdwjop5Cl+DwM/1SXzi9OZ3v2RtbwS66B9EgDjZzvnLKoDzkpyeSOZMheUiU5aUPlYEJvyU04hvPE=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6733.eurprd04.prod.outlook.com (2603:10a6:803:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Mon, 11 May
 2020 09:33:19 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::d5f0:c948:6ab0:c2aa%4]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 09:33:19 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com, dan.j.williams@intel.com, mark.rutland@arm.com,
        catalin.marinas@arm.com
Cc:     will.deacon@arm.com, l.stach@pengutronix.de,
        martin.fuzzey@flowbird.group, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 RESEND 11/13] dma: imx-sdma: add i.mx6ul compatible name
Date:   Tue, 12 May 2020 01:32:34 +0800
Message-Id: <1589218356-17475-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
References: <1589218356-17475-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0141.apcprd06.prod.outlook.com
 (2603:1096:1:1f::19) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0141.apcprd06.prod.outlook.com (2603:1096:1:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2979.27 via Frontend Transport; Mon, 11 May 2020 09:33:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9992a1c-1a3e-4256-e88c-08d7f58e56e1
X-MS-TrafficTypeDiagnostic: VE1PR04MB6733:|VE1PR04MB6733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6733BAE0D05C77B86346C3FD89A10@VE1PR04MB6733.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxa8czbMVhOSy4zUSHk/G4NyVR+y16X3gg2hsY1J0sX2z7H6EI1G6j7IJYuDUSsThVdcAwZleLo6eOgyV8OOzn8lLDL6lVnD6kVDzfkuBhVXR47ckjsvcBNnfqC2QPptjWPD/u/0na/0AOUiG8M4nMjYuuRz7Ubu697frcSYv25k4dwS1/kPzvnn2nCFvBZJ5369Pjy0OZHZi4QyRRPzZxUUes5CHjksEy1+9mX6paKsrNypt5BzBxfsYXrFSsUqneUFGZ1iRWk7wKvCy+SCUrI1/OEjq1LdPS6pdiohydc5klGlzN2ngdQlHHGk0ATGMkPQzQeLE/AiPvXuqQWazJJYQ4z6wdS1OLDGKfwZ0bkd1CItVvuyC6ME9TnzOZtpFBMdFqyaZBlL3CuH2+NQZ9AmyO0GKvUosnyiJRFoTxel7CxLVj0b4A+lmhwUBWVBze3hdmxpN3c/Eo1DSz4Kr476ze9HbcY7rmWhWXtPSJCexeoDiq39ribQVbn74m4L7ibr4HWmJSwj9PelsJriYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(33430700001)(5660300002)(66556008)(956004)(2616005)(7416002)(4326008)(6666004)(52116002)(478600001)(8936002)(4744005)(86362001)(8676002)(26005)(33440700001)(66946007)(6486002)(6506007)(66476007)(36756003)(2906002)(316002)(6512007)(186003)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: m6Fne5r+0dj5euW9B1lXldAUed5BH8Qfxgeaj7f9lgZ5xmbABNZZnxekfYS2PqqGxNRWMdwhpdHoKAivhgFD92XiSnzo87oscxDyx4T1fd5BE/QxI+O1+5DneCbj7KjbFvCQatNWt2xc+NYYMinLmYaDJq9v86kCwRIpWoJhUsM5sIqDIHdVBWMKIy7cyt67Fju3B/D5SXE9+0C8J0FWBXcLCjaXNEdJnSLYCjx0IdbVMmmYe4jr2lKUUmo4VyN9EF7THBJz58TQW1icAHoVdVMEu3CcCXLwJTKS1bF1h+oSd9HRWpCI0bX7rKvw0zNYezVX1ZqYbqxRJ8w5dkqEtyPVnDSiqKLCons3n+SnhtuYHTT+a7x/wNbEnDQPiuKDk/QExupgUWJ06qv2bpxPcIg5/L8Uvf93uaflw2+vU+jXgtHkUSxEQ25dVbMBvLjjltL3klt0tOle//fiMp5Az366oH7q/2emR8kY7cRlW54=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9992a1c-1a3e-4256-e88c-08d7f58e56e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 09:33:19.0899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XI46rbyJgy7CReNYXb9vAEK7kDjNgg0iRCYMu7aT8L+fDrVReBVv/aAzzoqc/OVAS1/JCwYotTbGWY+E27RNQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6733
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add i.mx6ul compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
index c9e9740..12c316f 100644
--- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
@@ -9,6 +9,7 @@ Required properties:
       "fsl,imx53-sdma"
       "fsl,imx6q-sdma"
       "fsl,imx7d-sdma"
+      "fsl,imx6ul-sdma"
       "fsl,imx8mq-sdma"
       "fsl,imx8mm-sdma"
       "fsl,imx8mn-sdma"
-- 
2.7.4

