Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7609620ED81
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 07:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgF3FZf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 01:25:35 -0400
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:63552
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728232AbgF3FZd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 01:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh4VfNVDH6cj47CrwOETcrKGuOJEdxecRURp/EW5ZDEQKuwRt1qkXWnPGsUhCLt508GJBAGX1qtTfetQz0jQBX7BA1vSb+0aMN3EUBNEroIoSV0PRfPiY7M04Ptmv5dzNCwAp0J+Q+LPDhLgd5oj5tTf+Xq9vgJ7Lv5gc6pJSkRLBguRwceRktimad0Iyup0hpjg25UwoLlxVqv0GqOGqG3lU35hpLkEwZ85X+i41E2k1nF7LGq/ITXS0Qvhx4fOWNYxudDEou/IMG3Gi6xhaudNnj6SG30AldYPwOs+IE24yEWbf4v6NUpFcdub0kmNzzofiWNtdL7CxBarWYb4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=Y/Yv5DWfu6vDHa5fd1LGnCgJdMrFXlYO+UA/ZjM17PSQd1xEEGEz1PEOIslCFosOtUDpgrAQlG838I1gWkUtnXEyrhYGT2pdHmJNJEwGuMdMIje1OTCmS8OPlI3TFsHhhbe/8H3bDjZAZmZ2CjQWdM3vApU5mEZbpJW3VC3aLMyEJdeF4Tb1f5tzpfMGnDPuo+hqVPi77MuOuLz/vPoM9VTRvnr32f1bPGnUvYBLl+W2Ih/XmbiVYWta1x4B5JbD66R/2KqR5vkiWd+grQCgbsbyrrnSZWjF89phzUN/koYaYCaHzTT26yEe2bSzgP4RI1+Xdxa5l57CVpdQ8E1E8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=JEO2UxQECnJG10kdZVoFHI5t5em8Fodb+wGgkdA8lPImMGfkrTbnH0y7+OchNbBFPffjTyUwVybGA/oZk8zD+U+xRE2RrLoF/aL+KtW4DbdiGkxbNLg67Pyp8uRfgA6yRuPjBZHrK2zfY6slSkYww7IFhmm0OrOf3F+V7f6/9qA=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6640.eurprd04.prod.outlook.com (2603:10a6:803:122::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Tue, 30 Jun
 2020 05:25:30 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 05:25:30 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 11/12] dma: imx-sdma: add i.mx6ul compatible name
Date:   Tue, 30 Jun 2020 21:31:15 +0800
Message-Id: <1593523876-22387-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0132.apcprd06.prod.outlook.com
 (2603:1096:1:1d::34) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR06CA0132.apcprd06.prod.outlook.com (2603:1096:1:1d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 05:25:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c8c5074-2364-42b6-412f-08d81cb600ee
X-MS-TrafficTypeDiagnostic: VE1PR04MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB664026FF2C4A33F284E19610896F0@VE1PR04MB6640.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy7o8BJ8Dt9vPt50iqpYin06ZuhcVtAZOImSa8O4tVXX/voBRPdqtX/vf2B6dH1nxlYU39T0pL1KLNjaHZEGzjG8cFh345aDyrlGmsP16rc41d6njKlWlH8kHgbV61Sz/da/vqthURA9i5U4EzdVm63WnO0PPxNVuHkT/yJKoJXw4iYrXIE9vKQcSGTZp/7PZaA05sQQub/cmFc2r3/iorX3sKma6mGMGnUwAsYZK5AaXEXaB+GXfXw3FNML2D/RKxY5KzitWQz8BiQDRob7vbhn7kBxB0e7+YyUuxcifCiD6LU/vI5TcQFm91Mk1dNcKhSIIrNM5j77nsxnGYBLe7hooi7hZKjPVw8R0aHnTEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(86362001)(956004)(6666004)(2616005)(52116002)(7416002)(4326008)(6506007)(6486002)(2906002)(4744005)(5660300002)(186003)(26005)(36756003)(16526019)(8676002)(478600001)(316002)(66946007)(66476007)(6512007)(8936002)(66556008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lkaRUIEjyN+NIPv8GJstx8h/Av70SMu7oI0CGC9iRfO9gC2NUlYRF47VhnZTf97Qv6zxZoY1AukxYju5Q1B/DqrDqjZovrXaVosFS4aMYQWZbHLuzRvxquU1AY9opCfc2qnpyeVwoCqLQ4g+zw11dwCIO4UkPHAwx5sxKbWoDWvlXw/gv3ywGe3l4Lzms9Aon9CllusuDV6vtQRdK5P6q6OkTB/ImMkeETzLc+HOok0BgudDvqGfr3c+gc1ANBbc/lnr+14LsPa74XtLeyv7rOPGNi55Hg6HDJZR0CmMHp4kZrawmx52Pzk2somdK0fYNscLFrXxDpXuKlTJS3/QNG0DSBBsvuwIwkznWYMoVI4FZiuh1gcWmuToTN5xsva5vTU5yZex6+SyAW33ybPsVX29XprH9MveQkwl8tqi2sK706IXByHsJ0TAc6jZVsEs0ivn+p7GoTXs3ttBm0LHmxxFpM0W6SUIltr1YiozqA4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8c5074-2364-42b6-412f-08d81cb600ee
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 05:25:30.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdQO2ZXve7Yn7lX38UrKB53cTHHrHEcyQ4AYNNjNciAEh+6WYw884r2wXrjqTn8E6qSZXEfsMfEsdpPvlOh1lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6640
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

