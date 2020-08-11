Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA685241770
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgHKHlF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:41:05 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:61166
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbgHKHlE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:41:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlcUogF2ULVe+FT+wBWEoi07i3hFDRWgioBXn9pB0/BEG1+4Je7E57xlNqhxQtcDNRoUyO1C4H0239IAa5qUiTCb+NhgO+k2uyEf4wI50nZTR0swi9iafYf6qEqXlRQskyQ08vqkZCJqrp/UieMwwKgmjjqMpN85p7Pfsg0rfdmNRaVROCAQaIDKNyh1fmrobtK3txFAiJd/0jzlDPd+X/+cv0EMsujMEw+IgbOen/lSnAJwc2Puk0OBddYYRks6E7T4Djxxj6lVvYkum6HmjTqg3EeGUnsoPXyB0Orz2TFznuV2jyYAJzi9zPS67XhduGgBLC/7NmanatWDsQPmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=NVB3Kus6RmGqx8I3czvBTt3N6/S5flAydrVmSTQb/0K2nKuv8Kt+iI6mxtMcMiNXhcUBJuYzmMSwz3WTKGaooMnsJejQtxsSD1WQYcpOIcAM199pXatVBJfGRfAgDL9Hp31Qxzmu6Dz0iQJObe2Uchc3ibl0L8gztBhM6EgCBYqimDbBDfY+GCEQitmuTmdmCcFtL7O3rsMY8EZ747ScXPChCwh3+ICprnsOUrsOg1pCmjY4oPalpwgkysJ5Aztc0u5lDwZ/QhxZ1ut4nKbXB4TZpBWlPZWLpCMHinpYQsVMnGCBmFyZ3Qi7pd4sWQGjki+w/jHSIu7hsePIhk7YYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=TnCg/XVkK/N0OLr9jwKrVMdb42rC5fZ8jWn5w7wwPKSHO3M24zme091VYU7f+afj4EIR0O2g+GQd3khKkW4oU+zCKlZibbz2yhpYSGxCz3AJKgm0KGrOKTq+tflSRkELQBXUQOKp8FDojiLiKy1nAwtE6mqAJs6OAv8TmZQzXWs=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR0402MB3464.eurprd04.prod.outlook.com (2603:10a6:209:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 07:40:57 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::c9b8:4020:7705:e3dd%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:40:57 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v12 11/12] dma: imx-sdma: add i.mx6ul compatible name
Date:   Tue, 11 Aug 2020 23:53:50 +0800
Message-Id: <1597161231-32303-12-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
References: <1597161231-32303-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3305.2 via Frontend Transport; Tue, 11 Aug 2020 07:40:50 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 146a83a8-1f73-4fc4-c4bf-08d83dc9e234
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3464:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34645A9B90FFFAA693A974F689450@AM6PR0402MB3464.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47vOQTx8monFTycyx1uHDoZGPRS0HJP10yGmGyaROLONfX5d2zXCIrfysMHAmbhXl3XUXisxlkjhbG7t22bpbNMFq2awFBZmvjrrG3hZG40z2FY/VURiQdS3wluOvhsCTz91XPUBLwRilurXOy3Ap2jd5AL1nO28qiRUZ1V/RLbrZrnI7QKMNGSPqSfeNh9dd9Xhm4Id3WPuxBbb3NhQcTi63Zy3ImJ8npFKHuJ+UCWr3yUdSKu2HQz2zXBTXXMG8NLeH685/SiuXnbsj68eJ+f38+VEr/x98F5RpWD3tlZotIBB8zxcMQmNzr1CmkEzinUGdmmdz1Isla9akHj3R+auHSxLF7YPP3lhHNhAyrg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(4326008)(5660300002)(52116002)(66476007)(66556008)(86362001)(956004)(66946007)(6486002)(2616005)(7416002)(316002)(36756003)(186003)(2906002)(8676002)(6506007)(6512007)(8936002)(26005)(478600001)(4744005)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G+DnW7Ka3xDCznKa5Ax04VPZ1YAX/6lpMEJXDmM3n9YR2pK47C9eCo6AUutOYBckfCIWPk/JCJsVX1pAKpzonwTnEfXrS70UHmcqnxURRXhhECdeUs9D8jFTixVtoaTKSN35/E1G93viPFl258PjEXkM17R7Dl7at+u93BNinB9mzLJhoVx8hZxM+5WWKf/x4F2uEKZ814uqMvIbp9XCog65xHepeBiJj3zvdekCe/BAmA0lKxtw5owtUTE4ZkEnWWt0DEMG4cbANZTpp0usMpxzaEwTeQaowX2fkRcOAeSkO4jKdZiWY7qIytTiArLRRCk+A7oOgudslxByLftE0ojgwkSsKSDlCUMdh9yELTEWJNh18v16Zr/7wqCLk+6kVb8KQxou+JAXkIiQRx0+JL+G/MS6Bm7y0Ucu8e8zW82jhGOQ46Qty7E/KGh0Wns30gsuTy+6cyB8hHVgrNcBDfFgBLUDaoBQwcHBvzouozmptqN1/wG4toCnsS3E1QkAC1t+vjyxPO3Ghn+Z33s3rj4xc9yL66wE9WIVluIJbJtEp6+D0hBrkW4ptyO/LEf+FNsHtTsoiZSzsen1884y2eB8hBo/gY2iyhQn+BQ4EEMCtG2GpgOQGLpI/oJRZYKsoMnM/jLJoIwVJxwSYaGWlQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146a83a8-1f73-4fc4-c4bf-08d83dc9e234
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:40:57.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8CbkbsIIeZW7UoDHS4NyGy5fpLQXjnmMIzGgOgz8YP1D7mX1aIb6HNhF7vcWNCawvn0qadesNmKeNsgZh3UpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3464
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

