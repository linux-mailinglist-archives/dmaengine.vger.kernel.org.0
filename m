Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129D12574A4
	for <lists+dmaengine@lfdr.de>; Mon, 31 Aug 2020 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgHaHwX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Aug 2020 03:52:23 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:27033
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728033AbgHaHwN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Aug 2020 03:52:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp3ceqSN7NnHJf/TA/0AX98hcMReR1cRMoWxybVngKD2sbDE4fy8p7elptTckrgjTY+pe90TH8rDpUY1yVXfvsRa1M/+P8zoHmL7D/K2YPgnEZf+wVwjGPf9phKxHADXtZvQtjlWGWjpLoz3UE0U4MmrIfr0m+0mfbk8C4j6rjJg1L3DoriNLHmGpX5jiufRjYJZmSDF+RP0ekND0EqMvkGnwLcPnqPe9Ko/Gasjno4hn0otbhpKtrkFbSNHRwx6raqkv66iKTIAffK3j9dJYlxUNnW7COrpVVme3xTFDgBshWPrErZUdxYaH0r+hqt/0DZD3uz06RVmt8tCznHM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=BWs0hpALJidgRtRLInnSNBZ9pD0Yw25kK48miRjYwKP23DeF+xQdxTt7r31/1xyGtmBXqcx0wbL7OPmtRgSLaZu3zHbZwfDzDftcok1KzkDfXc5PjcnKp7jdsUQS1isoILGFsBfyJM82H18P3Pltf3+3E0alWHWVQc1FUeTMZbnTfdu/Vgd08UH3V0apd3fJxYhjcLrw8rJgizi1UpEXlR6BQxptz6v5MIhqojoR2P+oCduZl+RuoyhZ/FzHu9MJVME00IxgfGgb8bdcTIqCRXZGY9IqqILkCSen+XFXAHCKZe2UYDyj9bLV2GRT04c+69iheH00gpHHrQu817X8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZvU3VGhVcTeYxe4fB6geATT0prKN/x1vEpROhK8pVc=;
 b=dR/QKV75NkWmnF0aPoLPqC73WbIpaVRnBnc5HIDAP6rmoYMvHKNyzbw3FQlvPOiK306VloHMGWoyzk+rgqCxXzwUU6iaBnPuJiKL64h66Kj6MmX/ZaOFpAVdiORI+XPuvUzh++HUA8goLQ3Ijg9yS36LMwUelQQNAG0lZxHMcHQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB5694.eurprd04.prod.outlook.com (2603:10a6:803:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 07:51:36 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 07:51:36 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, r.schwebel@pengutronix.de,
        Benjamin.Bara@skidata.com, Richard.Leitner@skidata.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v13 10/12] dma: imx-sdma: add i.mx6ul compatible name
Date:   Tue,  1 Sep 2020 00:03:23 +0800
Message-Id: <1598889805-30399-11-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
References: <1598889805-30399-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.67) by SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.20 via Frontend Transport; Mon, 31 Aug 2020 07:51:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c599e7c-766d-411f-6563-08d84d82afa3
X-MS-TrafficTypeDiagnostic: VI1PR04MB5694:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5694AFB8F9A14000BD1CFFAF89510@VI1PR04MB5694.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7ynZfizdve848FODTiK6RMjEAdbq7QPBwAGdj5RN0Uu7EmTYKcY3qfeUXXl/F4HdtejYgAJkr4vtvgLnvG+2L9xGT9PDZoJ/oAZBMZpP+xtMe8MxpitlZ9d8lEluHA8/I2eu40lqCVtvHDPoefs8EFo4a1kcD2qXgIKmBRs/5Y4eaxrJpdNjssqDZAUWGPyA6osJZ/1O5oFYZySHIbwbw87WBflmsBXrxLJOaItGuiGDQsylknBSexqtu2pwuiHDoM51LJRba5VKAPIuxb7Cd5DdMH8MbT/L1x9CpgbgiaQx76ZdK+oPCWeieprbl5EjGNm4Q3de99EbJQxP0MRrFu9pxUqllUlM2oM0EQ/C04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8676002)(2616005)(2906002)(36756003)(8936002)(86362001)(5660300002)(956004)(316002)(26005)(6506007)(478600001)(6666004)(4744005)(6486002)(7416002)(66476007)(66946007)(66556008)(4326008)(186003)(16526019)(6512007)(52116002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hb69lz1rfNcnt6cXEZsR95AiE4QtlDfAeVxwV7rvL+cWQY9pzulNiO/8aCTc1w1fXibpD6hVEq/Rc8QEXWe9X56oShKCFbO2P+yXMipWILlGUdABgeQKAy3WOy9RxnaE+cqIakgCjek9DDThxvuCdUEGYDZi1sdvDCzaOAlhqjv3xXJyyGVp+OH/WzTfbzo3ep8CC5F1PY3FoiDSP4uQ5ycgW/rCFFTge7DAVPuwaJq5VgstTpWo7H+SKUFkBFdA6MBjYqbbXsBV5YPY+j+krdYoUWxurnGI/KBTwAru+yw7uuTMSzBuXMUC2GqwdDGmonMo+SsEWpEWY46VFiGIWMfYuy0vuPIdx6rT43fpi2/hU4zGiYKqeX1/kDtRZ4hUe0DzCfh+lIWJLBIe1XTpvN9IdnkYcSKQw0VJxgqPLPsxV0kTXTLFA5g7TaAYN2B1jkcmAoxzCGO8e4VNbvDFhUeYlEAKUwF3HqnkSDVLmh0DH3GD/r4s+vK2GQlE9QcSPUGaEj+p8nw3P39vNTCDfgz1KECd6oMKeOU/hlcQt4J4jwwNkgLMtoEzGdC2alpHtOe3Flucq3enx9yOg+LblU5OA+WBViz0bmLAmipWtuKCocI9/ENp9xL3B1jqd8ND3/sH+Tm2Z/jK2qTeBsOMOA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c599e7c-766d-411f-6563-08d84d82afa3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 07:51:36.4771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8KXToMgegLd5J72VvHAGUQ3+uss9JHNilEJDLB9pgur4GxkPzZ0BVyHsTeaSPr4T/BOLPYSKRELYPJp0jj2FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5694
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

