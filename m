Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE972D0A9
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 22:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbjFLUgL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjFLUfv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 16:35:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD77110C9;
        Mon, 12 Jun 2023 13:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABmMXSxgJYVJHKz1gCGwSbxegbydzXfZZZ0bYjEAgMUpvtlkMFtsb1ZQel1sn4KIwKCwnCQt9KEEeXWrsOFDusWA4nXeLvzHL9OvJHP8qS9cD6Jxz2tBtBt+tRhHR9QM+WjnUNz4EQhcXxJfBwOkN9Mx8eLXSUUzmK36YVh4IsyKP3Z45g49CoXmaPPE4slEyOo4f0w96yACoWAIQ0sxdvxNd5g36L4AA2lnaUoCaLrZlWLqYdy6L4zmiMS2UmRcXbx8la2j//0ifkRUmp0Njtyv/HiyOrvqqCWe6fpZBF9B6SYev9K0Ud0Y6lWLs2H+phLoqkIvfXFhcfl5mzP+mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YUtCt2NXQUa21be/5g3CxLSwJ5IiHqX81mEMIh1qcQ=;
 b=WtIPYdD7bUe9Oohqe6vzplSeWTmbJzH7Va3BFslQo9bv4rLTN595D+FJrru4ndxxOGcHA3V+/rXWKcd2UGWm47iYra6N7i8BvRHg7ryC4VGqXYwYL4EDNnZnDsM0qVJwCZs5eLROG1VHIxN1zpFbiRoMesg4l6Ygd4X1RND40KiIEztAsxMYvVCEJwBq6A7u2krkhlcztCRgwXRQk+AqHLPeMTP0mg+zPiEpyaJL2ei33pwRde3rUilPFUoBUE2R1fcuesDnSgzy7SPOYgCDYa+InpOcwbqjSWQ/F/0TInBDeHz/YTbsh1X3ykQYmmtOAQ68xU0TxXEqzRVljG757Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YUtCt2NXQUa21be/5g3CxLSwJ5IiHqX81mEMIh1qcQ=;
 b=KdXfe2Gy/5H9zJssbmDRSAbBGf4/DqpuKq2lCX41pl0BVftrJk5fHJXcwCPvl+6MK5yRmlEFb7PMIH6uARHxV0WjK2bcj1fhInfmxvHwJG5jjwAcT1guLLFYGtrI11lyDClFpzE+I1yXjkySn7+sKwXkPGYWlf63eLj8Lt1VwH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Mon, 12 Jun
 2023 20:35:13 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::602f:42ad:882a:5ca7%3]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 20:35:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        peng.fan@nxp.com, joy.zou@nxp.com, shenwei.wang@nxp.com,
        imx@lists.linux.dev
Subject: [PATCH v4 12/12] dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
Date:   Mon, 12 Jun 2023 16:34:18 -0400
Message-Id: <20230612203418.2017769-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612203418.2017769-1-Frank.Li@nxp.com>
References: <20230612203418.2017769-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9e8a85-9d4a-480a-eb8e-08db6b848634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CR4dwtrJHp2y+MSBvpTxfUqA0w4TQgtYwF+rtG3AQD63eV7Zwq6MIJ4k25rqEf6QSmTmJjla7i1OvPp9VyqQhJO6Vvlu/j4NwXD7FKrUQdiK8MFAHlrEcPvB5eHIlzYsbx1qDkCc+v8OhOOLenScAKc99oQiZj0Z74pV+rQqxmnzU7WxIE8swG+njCron/eMPDDMFaGNdvH6oJM40tb0pbZG4GYTdsDDEEIp5IBi1roi57aNBBJFQiMbvoKnyGVyTAJiJCh9G+8Xy9vzhV1FLGXj4AYn33x3hhLEeciO0nhvclLQdoD3yBGQIrIFR70kzDU6IjS1hdGy9N2slLjqwsKr4k6++XGQVqG+kZ5qOdyRoI1NmBlEG+JgVP2uRGeBTpLKloSRQJAq9lAeQvUqacdUZVlEESoZEjdYYhrS6eus9BGKG3PxLLug3lBroYE11eIX/mFG1cMpp5iEUqndJo9zejzcFXSsyjtrRVD6mM6WJ/ALjRjZxE7opqHBd/sPVStDlQS6toEzB13QqYl3PnUTV2V60wXYMt82dE63mTpTOsy45kNuWFli4BYXbHSkm1okmlR53x+bWYh00CyErUn9bPUnHIGtyUx+L1gTK0kYJ7KWSg25cBr/iX2ek3tn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(36756003)(1076003)(26005)(6512007)(186003)(5660300002)(41300700001)(6506007)(478600001)(8676002)(2616005)(66556008)(66946007)(83380400001)(66476007)(8936002)(2906002)(6486002)(38350700002)(38100700002)(316002)(86362001)(52116002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?umhrPbfitj6gzVV4+hbrQPZSAlSx3yzMgBWCaqbk55qpW8fmYk6uY9XF3SXZ?=
 =?us-ascii?Q?aDjdN1I754Jaw/LCBJcX23mqCLthpqsKyS3kQetvaeA1IwegWhZiX1js7wXt?=
 =?us-ascii?Q?zRHlg9814cKZTLynQ3qThsFHeqvZ3OlKvXyzQIIf4+/a2HHzVi2x56+Oo1Hw?=
 =?us-ascii?Q?4jLqaXa0DPiSEVT2V6jpM/x499z5vAOj+bMmuHO3lZUTr4oS/UHMTLvCMiRf?=
 =?us-ascii?Q?0Bm6ln79Rxg+NoYX7kF6ccWCT5s5A2JJ35nCp7VG2sP1bMrihakfjPievSJA?=
 =?us-ascii?Q?GpHMVKtKw/eb22oHDEZhAdotrLeDQ7uDBzI049eIZ/E/+SMRUJvXxuFto9Si?=
 =?us-ascii?Q?KWdwpKK4IQW5EtL1utId4u/3VJITQQZOH2vU380QJQ/4l4KhgkcaWB9XLgEq?=
 =?us-ascii?Q?S5PLZxxxEux8kP5RzGg5EJ/XJwUXBFIRTUlxczqNw8cJfmtlnjSJ6Abpqhuv?=
 =?us-ascii?Q?o4pp+vm8posmNfEln01+7mhRpb8fh34FlDNC+rkdRTDMiLsG6vKNLC2px8BH?=
 =?us-ascii?Q?jKgeMtQd1zAO3zHBEetES7YjdAkL6gKMxfV8aQ0l+/qaR0+sOTrLw9DZOfPL?=
 =?us-ascii?Q?JbkDZEd8oT52ljrULQ0HuJ5zvhFmBBOE/bC4RG+LEia0yuljJ7iHLnMV194I?=
 =?us-ascii?Q?KBgY3rGyw/igzWU5HlwTFUQbeItoe4eb6zGRkK7PYgIU9GywtV+0hXlEqaZX?=
 =?us-ascii?Q?kv5vNGVfIVwvBXaz4ZxCOhZf0I4CF2h/bzYT4cguVk/ftL6y1ear8TSqbruq?=
 =?us-ascii?Q?7JbRUTg5rL6Z/8wk1bPqgJ4EzoHI+D5kTJ3d9DKIGG7Pgv0gqHPgIxxYV9Go?=
 =?us-ascii?Q?YLCc2lr30ET/8E4z9eVU+PVVCcWAB2xhixfDOy0OU1/stsr0LgHYybCRIjJi?=
 =?us-ascii?Q?PogobCVJF+mEIGRTYt4Xm7Y0ZorJlzac3DeqBd4wnod+tY8BmIrVaBr930JP?=
 =?us-ascii?Q?v+tnwbwUXPdr/ZaRborZVKLmuSELmlyqm9jZoM5awW0bTaCO+Xibf8534Ner?=
 =?us-ascii?Q?79Lt/6N2ufbPjU6+ltzMdUwLBQgd+6VvHOaZjLYiG3IRG1CKV9AdRX3c9DKm?=
 =?us-ascii?Q?1mngPHag0sBnXIDZ7ta995+LQMM2WaHFgW/LiFeCKjsG26FKQMC9zIlZ1y4W?=
 =?us-ascii?Q?vF/k+xtggmWL/foMMkVkO6xTXxsIzOj5fdvRiQ7W9zNXqexcv357Z6fD9uIw?=
 =?us-ascii?Q?rgt6PEMlntoGjR2kHe0/e9vjz71oCJpgsGAZq4Z+XVyhSOCJO8oxjPCLgnDt?=
 =?us-ascii?Q?Hhkt9oiFxNcpXZrcPocN09x60qMePZwC0uV4wzKewAPi/OJl5e2rVyErc0SV?=
 =?us-ascii?Q?tvMbZWzHVvT5XWNk0Pp45RynDjipKtOHpIhBc3efIFCjnEl9/yqFK0wMwQ3D?=
 =?us-ascii?Q?jIXo56h69eG1QpeXKYJGPiunDcOrrKYSbM5yI8h22OeqJoWtHoUtlutiP9BC?=
 =?us-ascii?Q?lnD/WZm0kaCBl4/f1/GrilKPBgS2ApQ/LJ0AwzVoNCNGcMllnyoqmHM+x1rl?=
 =?us-ascii?Q?phJCjxflEjDHCzpBQZfyxWMA5Q7bF49DJ21XNrIpXWuHZWdepflxiX72HaL5?=
 =?us-ascii?Q?lQsu+tuL/6+vHMCvDvHiU5dYUFIFqt6MM/SnpJzY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9e8a85-9d4a-480a-eb8e-08db6b848634
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:35:13.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHFNYSUdF/hqP5e3jIG3nvF3rwBE2sorlCNhwQEI3xtS39bY0R51NkH0Fb36UgVMwitG+x7cR4Z/YbpmBs228g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
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
 .../devicetree/bindings/dma/fsl,edma.yaml     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 5fd8fc604261..14cea8a3f442 100644
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
@@ -101,6 +105,26 @@ allOf:
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

