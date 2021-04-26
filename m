Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2934336AA13
	for <lists+dmaengine@lfdr.de>; Mon, 26 Apr 2021 02:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhDZAnK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 25 Apr 2021 20:43:10 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:8966
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231247AbhDZAnK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 25 Apr 2021 20:43:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JspAZGgVAbFvzbU7k/WDnkGM2134y6jwN4F5S+6+g5laLWAZNQauQJBEjVxEKiwo/U4U8GBhNJMQRygw/9DXZQgdCbUITxSK16yTYOAddLzU4ikxT+Gv+LRQbxTZq6TLz3aZkAhwgvSuuEhpVFhtb78BOXnp8crlZckzEKogQpcLwhBsPR7z0dOI/JmPLcbq51dmfZ9R811OL8fR70mVDM9YqHXncMfDcncRWUnaMhoVmEN9wf7NUGjWdqLt2IZetgA14r1L2FCDWeUrxq+RIu4vgYR/qfEu/uwXv0MN19w+RVY0nzzE0VoN2FnCn0V8G7ArSIEXs1onfX7tf+JMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4LdOPIl1PUS0rxM50ZTegvXlIOoxQAblNi0t6Hgdcc=;
 b=Wiy04hbT+aXQTqPVx95a0iYRl8srh/Y2By0S4bIrEdzdo55lmwfrLVixwzIpaC5V38Hkt66ppl+nsgji3HdBu9NgqaHokH2xMgLcKaJsT47K4hMPP3XPqjsYK2VEZeCiH6GRFKMDdYEJaYgtTFBxcgvIZpqyixojHsls/l74A1Dmoc2pijL9cv82is1cJLjwOTDGDC8k/r+m03wSa37feXaAPcWzcFQDnRyzdyw+06uuLMBjfWOh+g5AI/a4U9beC6bo4W9ko8pozCbgbZTYcx42AtqDIucXM8ITu5tY2BLqnDGbvphPNJXHrZLM4HXUR7rDhtIaQDzz4nEk+HL5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4LdOPIl1PUS0rxM50ZTegvXlIOoxQAblNi0t6Hgdcc=;
 b=KyD/IqmxjIL9hjcqGBCRWm1TxiFSoWoSdTPV101VmQIdkj/xD5JJ7ENYexSn9iY3LJEWntXqpWk8rEPYt3kc2x1S86IhoIkATGPGF3hWw9qXpeNbYWcRYUKEmzioibD8dF3vxeX+dV5ymuW7I5HllPwdQ9qDC0brO6YqY70hVW0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com (2603:10a6:803:127::25)
 by VI1PR04MB4734.eurprd04.prod.outlook.com (2603:10a6:803:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 00:42:27 +0000
Received: from VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca]) by VE1PR04MB6688.eurprd04.prod.outlook.com
 ([fe80::de2:8b2:852b:6eca%7]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 00:42:26 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] dmaengine: fsl-qdma: check dma_set_mask return value
Date:   Mon, 26 Apr 2021 16:59:09 +0800
Message-Id: <1619427549-20498-1-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by HK2PR06CA0024.apcprd06.prod.outlook.com (2603:1096:202:2e::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4065.22 via Frontend Transport; Mon, 26 Apr 2021 00:42:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1bfaf6c-4f89-4402-cdc2-08d9084c2a06
X-MS-TrafficTypeDiagnostic: VI1PR04MB4734:
X-Microsoft-Antispam-PRVS: <VI1PR04MB47348EE8D8C59323C304B27489429@VI1PR04MB4734.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dZhCOanEfQHZDw9/BtwCMuM1t899bZHi7jpHTa4+mwGbUQmyKH50eOT/IILV7MLEmlUBLsv96MVMr6CRnVAkOD+xuBm/o9GpoJtftAuFoxzlBOhCSodl6ZGjaYr4Nnfmpx9ciY896fto8DMoxd9hlXtyZL54xgimXIyJRVxbzf9CbvnfuO5xRvhwelDz//+NZw3rWd7v6HoSfzmmwVqRhu5ST6A7J7fmGpbWtfPUzxaaTvIFjjaXNU+Zu+qihj5q+EXs7k1BojMKYSYP/Obh3Ejqbq5sYhv4bcUr4M6Go8hoAxesDPp7n8eYjZTci1KbZvWZydCufpWaZd5rhmsjlXT/0+7kzxSzt1WpjhoIAlA/OL94p73nXY9UIKRh68GDcE+DsBs11zSsDT6J9q80TZu47VXdbBui0oqVjKlL8LSsJIf0ALTbJCSXXJM2DdQKcbv0R/XFQ86VZ/gTjoS9pS9NgjcZ2CMwAFBm9dT9ehDD+M+8dhfhTkHppK7UXvQadquK1oY8dO5BHrwBHw4heTa6iy456igSVIOxe6GGtPCTHkq8owUXk98ZjBLN/ihj6+sOL4E/FJo1IGQXYVDbWD14Wxs06p3NDoh1/AAuC6qCoZcO0mGOMqlFifbXKlMmmBq2XukwSkQ0zxdJXfeteQSd8Ex/YCaS+cUnAl/yqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(26005)(83380400001)(16526019)(6512007)(186003)(86362001)(38100700002)(4326008)(6506007)(2906002)(38350700002)(52116002)(2616005)(956004)(6666004)(4744005)(316002)(6486002)(6916009)(478600001)(66556008)(36756003)(66946007)(5660300002)(66476007)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XcckdPORhgt3bZCuOrqpSKKMTpmStXob2WhyNTtyZO5YxOqpb0bVSx7ZA0rB?=
 =?us-ascii?Q?zMoLFZAaGwe16qao+v/DUaRP6MRGDzXNVQfse1umlBExw6vDet1WugflUKCg?=
 =?us-ascii?Q?JsTf5cTPbB/lobgIxMZp9aIFjsvljofe7jFCILnRw7zu8tgYKI9gw/RHOY3r?=
 =?us-ascii?Q?hcJ7UcStOSzqjX6W92y9/PGsKQqMOX2MN5HCFvk7kCTWjg8btsIzlR19hPap?=
 =?us-ascii?Q?Zgzv22Bx4SwLcp1pSToEHvVXL9uxziq7Nng4zhyfU/EZR+O8Cu5CnwYqQtH3?=
 =?us-ascii?Q?AdI2BC/4r1n0WOt2aX9ZxxpkSTbBCpXrNBrfuuwdiEnwgBgCYpPBfzqZdeDp?=
 =?us-ascii?Q?RS9AslLniEsjSYboarnTTF+Q012z9PS7/mWbwA1S/7fW/UC02hckg55OWkEf?=
 =?us-ascii?Q?w7OD//jbJE1OKGZl0BFzmr6sftbiyKHrDqixIyyXN7PCxSpYwIUNq9z8/UH2?=
 =?us-ascii?Q?yTfrZICCRQ1bgBRGoizJ7DJ5CPOt46//YAhEZnR7PJts+OrNTOkhPRExc043?=
 =?us-ascii?Q?EGPj3SPjbTO8bVJpO81UPcNfX/k4CyoEYx2ZQ3mGB8g58yKZjlYTtcUWW7I+?=
 =?us-ascii?Q?A26aZtCS4BhIs+5ITCy8VVzf6XJJyCUEFkkOgRG+pBOZhvrdccNqUiWWGdQB?=
 =?us-ascii?Q?O0dRD7JEe/9H8XWkfSaFGwCuQlF59F9tsBRQsIYl5miDrzrLJZoc+wU0ZW6A?=
 =?us-ascii?Q?az7pAsaBu9RDpJwmarjetC1Xeu3I2XurskPVAvmcsfZAcvpEfUUSM9UvS+J8?=
 =?us-ascii?Q?LSIRBRcXm3FU8TG8s9VY9rVTv/ASH27cAwRB54aYH59buvQZ5JITmewFquJn?=
 =?us-ascii?Q?eS2VFiFJiNnqq10zgBDd1if23lV49/eS2gV0IVsyN1qCsypwoIe583VXVIyx?=
 =?us-ascii?Q?at73JtX8wkpgotk52KC+cd8xdtsnprUYfVWZKda3mUdzAPh5G1ShfPuLRgzW?=
 =?us-ascii?Q?wUlXxKwyleT5g4+GlbJ8G+aX4Tbqqg7OaleHl8JlXciHCN3A829urX/TdSxz?=
 =?us-ascii?Q?K2EHe4lv9QdO9LTAoMlhn77taX0VfSKz1xt3S9Y2B4lQaF3ZrkvtSwxe1k5J?=
 =?us-ascii?Q?aDJ+5OUaIwcSvdhv62qCGZX/tTPSa5I64ArVFg+RV83d1jgL3pWjt+g7m879?=
 =?us-ascii?Q?EPdA2tzHitYszg1o2iWNfPtlhbtI0dFMK1NHvEMkTpAvqjpIPLNp/eBqAlsh?=
 =?us-ascii?Q?5Ox4U/8HGHCSjKg2wKsSGJEa3Ku0lcqG3Pb0EC1w4kMM4sP5DOP4c0xaaxdQ?=
 =?us-ascii?Q?S7DaDhD+xsB5P/lmMxG4VFsgW2cW1Vkwyud228c0bJP+30TAQ4shdAORqkp8?=
 =?us-ascii?Q?HTLsCdA5FMXWOE4pETeBBg3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bfaf6c-4f89-4402-cdc2-08d9084c2a06
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 00:42:26.8639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OspdSutsbaIP0ujFPLAPlR5jlvEajIXgL00H1aFCBCinWVsGRHMlcWw+Y0icu18RgnQYWOHec5AepQlSCKDjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4734
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For fix below warning reported by static code analysis tool like Coverity
from Synopsys:

'CID 12285639 (#1 of 2): Unchecked return value (CHECKED_RETURN)'

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/dma/fsl-qdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index ed2ab46..045ead4 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -1235,7 +1235,11 @@ static int fsl_qdma_probe(struct platform_device *pdev)
 	fsl_qdma->dma_dev.device_synchronize = fsl_qdma_synchronize;
 	fsl_qdma->dma_dev.device_terminate_all = fsl_qdma_terminate_all;
 
-	dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+	if (ret) {
+		dev_err(&pdev->dev, "dma_set_mask failure.\n");
+		return ret;
+	}
 
 	platform_set_drvdata(pdev, fsl_qdma);
 
-- 
2.7.4

