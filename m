Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E691971A0B1
	for <lists+dmaengine@lfdr.de>; Thu,  1 Jun 2023 16:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjFAOnu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Jun 2023 10:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjFAOnt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 1 Jun 2023 10:43:49 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2066.outbound.protection.outlook.com [40.107.247.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACBCE69;
        Thu,  1 Jun 2023 07:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjHF3pkxJjjFXUwlqB3mtrKj7zPwfrbIFRxiod5mNT5dDI80ga2Dkjt2tY36yp6Z1+O/tEOGNf1D1bwSg4f6tE15NsbQQKIsZY4JvDbLFuStmMWcuFfuMG5kRsR++HgrxO2FtEiEZcv+l/1XkLo1/LFyT/4g5Y9Cqudq6uUjz6EO4HJvPgaUP7bB9DmLj8DsQNda+JQnN8jZI+XhfRrHhwB9ceMO8qDz8k8Ufn2PpKALhtvC1S6biObLOIOgBjppCfZvVm3M+9jlvSbgtNNQ6Kvjov5yg737amiryVYnAZ1cqWZMR/9KbtRU4BZl9Blpoxv2VfkQ5Zp6ptTWWOd3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aexRpy1zCiiR3f+59/SC3MzOraIeaGk0ihwt86WSIcs=;
 b=ahQM+2UftlkPtQR/++hmneBlB1Eu+Xx/9RARtNq9KMhK/5CjpExQEJDnqHXNQLZBaS10IRI57Dot/Foe7P6tv7plHPZYNkexeIx4UbvJXtTyNgU+3PjYkRAC9SZ8YxHZiTdSJvD1yiiI8i6rfxF3rMXcjvF/gXSYQqWIY+AwMpaAaSGkCzBYz2026ANKIqDC7k/kNUKE2FxO1iSQuiYJcwzYFblqV8lHQf46PEpL49oOk68Y760dtQTNeWmNszlGvRGRYVJtR1kfxMbqW26MQyuZnKWTWdsJjGitV2AH2U1Wp1e6YGj4GZPo+efO5K9uCi0J7bLgkf5nWLQlBzhzsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aexRpy1zCiiR3f+59/SC3MzOraIeaGk0ihwt86WSIcs=;
 b=V0TBWnaAW9fxAc2JpmOxr/VYIK4BDPvpHqCM8tObkExAErQ5hll6ClF7j11oyIbn19kZgLpp4OtpOyyN4bijpnWOTrKJUjgvxMgc2/UcAoRX4WGOq1Vd86AnFK6s6yK4P0NBLtd3iycpCd0gPMiBZJYzIsNF3RqmkgS13qEi5Mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 14:42:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 14:42:01 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v3 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Thu,  1 Jun 2023 10:41:07 -0400
Message-Id: <20230601144107.1636833-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601144107.1636833-1-Frank.Li@nxp.com>
References: <20230601144107.1636833-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|VI1PR04MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d118bb7-75c3-40d2-d290-08db62ae5c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lFZnhMsm2V9eDvW3rcyb57J2mNaGOm9T2SVn8Fr+w4aB1+AQ1NvaqrHlIdXhqIxHMCosAgUJmy1L/V6a5XCmiJZqYzdf1OJafsKjbbRimR1aGZxsBbhN6+FqVTj+IRjEe1cih7zRL/FKGmM7LKpVrRMpkUtR29x61VQSvLvlBxbX0Rx2kD1icPDcgjBTYUVxE0gZmCai7hX74qEg333wxlbMdHuYoaun5CZuju6lwfL70XF0uu9dqAd5GaFrVlEEp6kvI9VToz1wPZNBffF8hUzAFYMTyLBEXRTJH5LGi4+RxLe/dKJ5VcImO5aVCdPVRJ3n9jBtvCc3UWtCtvGr4YMs2D4OlLhbU0HHrveKLnnewBSwDvtAEWU5Bj14AmJ0/PlYxALsU8R1tGIbhsDsp9iOiPY3POA6GHq1y0CePXWu6+AD50z6eXwwAwHJT52uSfMKa+1eZnVBEp6XLKb3h+gNyevsFT+MCLQ4JtRWFzkEcEQPQRJyLjo5vVFdA7ggJahyGrOV1jbhCayLAT8GSkx48K0DI2y5JLSMxF4TbinO6/YfY0Zpz8UGN9x6qyYjQ8tF4gn8+30KujG+2zMIrUJBmqu6Gjsrdnfnm43iYuTAJZW48mWUnDNAeTiAKADI70ZNMkkW0cbNWT9sedTQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(8936002)(83380400001)(2616005)(186003)(66476007)(316002)(52116002)(6486002)(66946007)(478600001)(66556008)(1076003)(6512007)(26005)(6506007)(5660300002)(8676002)(41300700001)(2906002)(921005)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MIDdam+q76H03la6vpJwHjzi3nQ+W5Sg7ZS4h5bS9xPpZ36mJRL9Tgh3/z0e?=
 =?us-ascii?Q?2P8DRJt47nfytuWBe5p3PmLC+oXsk3x3Gmgfr3G1N+qtlGLoSTI5bMw/DZNY?=
 =?us-ascii?Q?qNfs8/nlktirPYfD5C58dVMQ8Uy7tChIboucStw2nx2lDqeYp7ocalEAbyoC?=
 =?us-ascii?Q?Wb79EEFhUDAfl9lROwAk48GvuOvNWIddFzqHQVJUx9USezEjH9IMuX1Kq83O?=
 =?us-ascii?Q?u0HZmvlPDoOJz0aZshWxJ+M74Khl7ZDPEdhe2uOBC11c0UF9ForHnvYK1uJv?=
 =?us-ascii?Q?0mzfmD0HigvPLWjGypldJv+B836iGmUGpEuGN3AGYXyC9+AoYPbTRsiBx3ZU?=
 =?us-ascii?Q?1wm1cxUipDCUCUXkgo3Fa2MI86jHTZwPuiZVeODBQRWHNH8f5E5reCNJnxIu?=
 =?us-ascii?Q?xxX3udnm0Og48qosNdrzARYxdDHG2e6peZY1gO/HfqfOUlZ5c31Ovyp+gixM?=
 =?us-ascii?Q?KeHcP2syxVjWZbeXXda7XqHXpBxll2Vj7813CItt2/xh7R9S74+eLfZ2yq3Y?=
 =?us-ascii?Q?/Xdc6TtGsF1Jo0PRerGLxnxR6FW0PdczYFeznrqpdFH5jVp9S6j6mzXYMXMH?=
 =?us-ascii?Q?XZ0Awf5vy4iepcVAwhm/yHQKVMsWNLIIVEzTzaidSvq5SQQeMcR80+ZkTJdj?=
 =?us-ascii?Q?rhm49Cl+JeLCcmo5/IIUZUKplDVoj33IgItS0dC4mi+iCUJIXJAccTMIlZ1E?=
 =?us-ascii?Q?iHCZp23zmnV/qX02N54Nv3MLE4jjjZyKgp9hXQm5+gFA7vvOu+ZkFkjIpc+T?=
 =?us-ascii?Q?UjB3zN13akoRnVoIse90sj2Ec/leFYYijpavnpLoPrkdDaNAPxNol1GNDsbe?=
 =?us-ascii?Q?QD0VzmYLWm/gUoCfSvK3T0nBOm3PC69yflqd44qoQnAYW+lA/TnAu0wuYc/Z?=
 =?us-ascii?Q?+dY+Lob2uOfdSAO6NAdjQgpeRAwFK8tVnfE4s2lRxQHgVG7KX6iAkFiB57No?=
 =?us-ascii?Q?I5S2GyPPam3/OpK6Y2fezlbtUF+3YeTkt1m5yQzMdpT9XPRbdD4uzDi+EL2o?=
 =?us-ascii?Q?FcZfdXQv8H/xKWVMxkaaLHaioZ+tVefLyoeaCpthO1b7PrYnIi8SvqJHy90e?=
 =?us-ascii?Q?oEBQoam3xB+FvMuZstoWuKQ8GgM6gSZangC96SMTex3NHWUYHiJHwy9iakhc?=
 =?us-ascii?Q?y6aBwTrZSN4kj4SNFbSzJrrHbGoDSOeHKbkcG/fs0uNRBeRPxmL4JfzGrrff?=
 =?us-ascii?Q?10HicDq1EWNN40osIbANbYKM5xE5dZv1kntjQtWyVk5Eg9SfSYlr92hiOotB?=
 =?us-ascii?Q?I6TxO46g3/A+n63VWAdLmIsDK1ThwtOmw9zezj1/UCoVVjoIBseOjFIrFg9L?=
 =?us-ascii?Q?8oIqDM/v3Z5Lre62URtd8STgELkI3QKF7VcclwTgxbYXGNte5ZYODMvrqpp8?=
 =?us-ascii?Q?ycy5eV/6N6q2Pxk2JgD2rFhqmJWUd/yOwQNRgPI2QHhgP9Tz5gu9xNBog5uk?=
 =?us-ascii?Q?NW93wwZOPVA1SSVijEWYIDBUFCEYdDeehZ3Ks4QaUFXSlgRAngfCJz5UaJH9?=
 =?us-ascii?Q?2FjkQl1DemjUUARjgfvLL1Awk/u1gv9F274mkhPP+q8moh+1qhZr+nOxg1wu?=
 =?us-ascii?Q?Vc59pMfS/z7TMBSPFaplAei4lfSTu4mXNh9+iDZ6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d118bb7-75c3-40d2-d290-08db62ae5c32
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:42:01.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXBPf3oA9b6qCYiEsArpNjOZlP0tgHPvWrmyYpcx52dRY4zjp/83uVp/h1da5y/bavlkZ8wynwW1kHDsemPFRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend Freescale eDMA driver bindings to support eDMA3 IP blocks in
i.MX8QM and i.MX8QXP SoCs. In i.MX93, both eDMA3 and eDMA4 are now.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 5fd8fc604261..ec0fe8735ec7 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -21,6 +21,10 @@ properties:
       - enum:
           - fsl,vf610-edma
           - fsl,imx7ulp-edma
+          - fsl,imx8qm-edma
+          - fsl,imx8qm-adma
+          - fsl,imx93-edma3
+          - fsl,imx93-edma4
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
@@ -49,6 +53,10 @@ properties:
   clock-names:
     maxItems: 2
 
+  fsl,channel-mask:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description: A bitmask lets you skip certain channel.
+
   big-endian:
     description: |
       If present registers and hardware scatter/gather descriptors of the
@@ -101,6 +109,26 @@ allOf:
         reg:
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: fsl,imx8qm-edma
+              - const: fsl,imx8qm-adma
+              - const: fsl,imx93-edma3
+              - const: fsl,imx93-edma4
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        interrupts:
+          minItems: 1
+          maxItems: 64
+        interrupt-names:
+          minItems: 1
+          maxItems: 64
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1

