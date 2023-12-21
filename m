Return-Path: <dmaengine+bounces-607-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F62381BAF0
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D11289F45
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8205823D;
	Thu, 21 Dec 2023 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pOiAOko+"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD458214;
	Thu, 21 Dec 2023 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMByfT8vEpPvWudza43vihUEikLtokMxlnnukNgprc2GfPnQog6Gj7eOs2qMvPKProzSay5mMJSdAn0uiVDFnfmGeHGz1AmXXgwaD+foAFIp0Yux47kg+s6AGSeLyWTf9qvT9pFQOsDgQNDxNb0Le67mlFTZ23A3NbQc2nIF0WctsbXN/ayhJ8hKLgKZ7lS+4wZ1HNLmchDk9CwuAcIBO9vQGot02uUQch4rIVAZR0uH+9lLz6n1u35CqH/IsK0wZ3frHTVzYHvyBWEoPmxFrqOceC5tFs1rahlyQPvmJt4mP25Evob+qZ/r866hMKOHjl27kvcAE9D+uLLLUjupFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvWEH8TpUyOz5PnKH9wjxMICSByFjoiIVqDIjBVbGnE=;
 b=KKkol/Eh/cVCi8NL2tj0TSgSDSBX/sJQb0krQkoco0o6e/KHtTntJLeas8EvsIgEjXG2XPHvKJBJzAfGNnOYYjE7aiWyl5HFUAqT8gYqMAMxwX9Nz0frGgOK9e+lL9M0ZbWI8SrfelnYqaiIyJJRbQFjZ1Cl0phypcrIgMXx/nGEoEIRE3gGQTxtvZbWvArHOqRYnxsH7K1wqRYKpjCYqqtUA5eV1U92/VCcscfJJU532F1qoy7tl9N5GOMA8YzcmtLCsx8KYwsYqN9YTZf3pCRSiNlSPR5oeFMPx2clavk4qTQXQCyUXuBDYP+Qlqdsv4UYdzxPrsT98QE43+Btng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvWEH8TpUyOz5PnKH9wjxMICSByFjoiIVqDIjBVbGnE=;
 b=pOiAOko+27hDz2d6IH4WVtGgfaN3AODhWE6d5/S3++Q9VhQ8lymPigs+HuvkirqKlPMhKIgQqn4jx1DYyZ6n0sMsqz6QXUmigcTNiV4fIkGKRESX9lHKb8sQiLBjTct12OuQL1c8cEFYY45s2ZqcgfPCwg2vc6gxRqrYf1Wb0v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 15:36:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:36:01 +0000
From: Frank Li <Frank.Li@nxp.com>
To: joy.zou@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v4 5/6] dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
Date: Thu, 21 Dec 2023 10:35:27 -0500
Message-Id: <20231221153528.1588049-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221153528.1588049-1-Frank.Li@nxp.com>
References: <20231221153528.1588049-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: b073c1bb-04f1-4867-407c-08dc023a890a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cjZcC2rQagqS4VMIHLJ5Lq7UITgFTuTO7a1Nt7aAbygXoOsme8OTnxpwWL6EUo+C4GRpjfjvQ4HF/m3brVmOvkd3fmIV9P/wvGASrWsnYIWNU/b3Zr8VyiBTg787sJXVS+yPKT7N6rdWGHug0Iuj7Sk429VPIuDEkHfNYbqiWuMA3Vm//x/BpuuB2ZDaTFCw9XKKezJOtyYaSiZOXGrACV5jSebh+Vs5UufW46Tm7n9EHKf36zHaPPBBYMCEiPZEynBzQ+XcuUz7PTCgIF7Kw4cEWEeE/Xmcm/+KbL5CUtYyCQ1957CV1NF6Uks8FRmZRqT1LC4gNtKoMxl9Z094y37uV9EN0t/tKmrH2UqKpIeE03FXZHrTva+LRzvFaGARR7Fir3oB2a0HqBCwKbVvi+Pth/TXDhVfH2eczvEhYHa5ZgcTifS6moGkuXhwH60GjQ01LDey/HC23p0FDxiZRI0vDsfN7ZQMuiAiblmEEN2KehvlyAa/PbiJ0A6QkQeHs2POJOm0Mi4qYZ6R56rBSmHSjb+aBLdjxM52atZ9NluqrIG6tgDDrAZhZI4yKZHl2lMXD7XPZuNNE4Sq4Jn61IHFpDiLNkO/tIu6zDLFKGfxa4+GZRRqSD4CFuHea2Uv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(1076003)(2616005)(26005)(6666004)(52116002)(4326008)(8676002)(8936002)(41300700001)(2906002)(4744005)(6486002)(478600001)(316002)(5660300002)(66946007)(66556008)(66476007)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dS1gZoBKB6MuVGi02sNXG83CLvuCw1mItHOC+ANiipQM9lR/WCYhOazfMlm1?=
 =?us-ascii?Q?MDS+jG09rJoRkwFSTUTSpYO1ZfEOrIUFI6BoeQLrG7OdBsBmX9wn2pFvHanw?=
 =?us-ascii?Q?g7iZmXA0FYNxZr9u0HnGWDTTpeo5pYXZjKrkHrRckSGbi/wPPmnDwtYDay7z?=
 =?us-ascii?Q?erc2OGeAcWtcYCe/appFaLO+jthp9j1fmPSf9cOpUcLx71Y/64iIvSYXuqNC?=
 =?us-ascii?Q?3pXST922gBNF0w0Q0Rf+83yT2ieUaw4WpAcuV6j1mVCK0H7tzHweW9svs6qY?=
 =?us-ascii?Q?uPHkBoO0vneafazpCVof9CXLGII1BRxWuRQbFzAw0xo1+0013iTD5WpftrBN?=
 =?us-ascii?Q?381DjXweYfcJymIwvSYQ2tRL06K3oiuaESGVLg4+xUHBDkoLRY3UreLQElr+?=
 =?us-ascii?Q?NLCwDDCF3k5G8nZYg5hjeI2M9yAmcR5GJK7kT3X6tN90Z1EiWg8cYr2KSoVF?=
 =?us-ascii?Q?Ng5sS+hFX4oNz0P9yIYJ+TK8sLrM30ETpheW7DvHPpcTP6AsCT4DEsHaFIIQ?=
 =?us-ascii?Q?CSOFddJRtvnexTeapvfRsrVS5MtPKrGiMXaTGaDkmdO+A3uKC9qSQYkgMSlx?=
 =?us-ascii?Q?ea4JIjDl/+VwNb6wK9urbLAjQuDhBQBslDQ8YFPKbmL9Mj8aT0LU842vzHuf?=
 =?us-ascii?Q?mzCWFyan5EFxfBLDmo40edim+YpWuYMmNBlKzOasWExHri0/+eYcd5eFzITj?=
 =?us-ascii?Q?wJd0ClvUJ/GrVdqKedj1Z1QMt4gR7fRNiMY6klbTnJ5c32dEBK+Z6/vpUhxF?=
 =?us-ascii?Q?fnlo+Tnu3BUB1l238IHTbhka64LVaE+aMdtdiTe/3fj//5luKkXo+t+2veH+?=
 =?us-ascii?Q?hYmeygh/+gT+Rx830ycRrzhpdkqrGi52cyqnN3y6YFnxCGxXgskMRuZ9f+1W?=
 =?us-ascii?Q?1Xd7ve5aIsynMudh/nfN0UlBZAv9D2xss7/pccKOPu3a06WFhVVok4W2ZWxz?=
 =?us-ascii?Q?3Ebax9ABzud+7QsLI0oAdnhIuFHsVpko6K10HNsUirgbIkJ1vz8Hb/v3VkKc?=
 =?us-ascii?Q?qaCBGvxb0TkULV+p9HijH3XUVu+UMUXD8zdCxmpaky1vBvuoiX+1jHVi5XUK?=
 =?us-ascii?Q?RWAPBePo3MO3l799mVw7a6QwIpXWHXpbJ1LWmh7srcY560IvCrVw7ixwvm1m?=
 =?us-ascii?Q?+KcFkH2GdeYVXo01h0RWVQjHTGUDGt0Q+C8QMpQAxvY1fuBuOMNa+J+wRQH9?=
 =?us-ascii?Q?74nlRKw2ha4ahqDXXkVerUdDGQRRah8wN4dOTcOopBsbqQKSpipFLWpD8wFV?=
 =?us-ascii?Q?9IBLU86PT5U9RqcmOEkp9gLoq7NgI1p0zHITQglN7iB5iQVOJ2zHjYQtMrTT?=
 =?us-ascii?Q?KqoppXlo3uUmnBuMYVNiArjAJEboQULMBNEjnol3y+r6p+6kWFMBgSqcWZkw?=
 =?us-ascii?Q?mtJA6+U/3g1HGb4vwYFu9XJiDkpI02jlvFNciGQgiS26M9NTLzmg5nYqxTQw?=
 =?us-ascii?Q?QWH28rTR0Y+MVoXEB6IYgbwLRDlYWR9eporMP38oKCyHrlmJgUACaFBwYYAN?=
 =?us-ascii?Q?fIaZ+B6Oxwi4LXcsZ/Z349sRjrBaBVe1ckR+tX9jpNR/AAmZF/N/TX8vRjL8?=
 =?us-ascii?Q?xFe2h+6Gz0pSTzFIJoRpdmSx/IhzO9O3O9wn4NBk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b073c1bb-04f1-4867-407c-08dc023a890a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:36:01.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7bQ7TWnqLm36wzSOF8vYtRq01jQ7YUXezfRG2zEmBqAyWBwBK/dJeWkxNCIUQwsl5+cpUerPGGg82Ors1yFLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8194

Add the compatible string 'fsl,imx95-edma5' to support the i.MX95's eDMA,
which features 64-bit physical address support.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 437db0c62339f..aa51d278cb67b 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -25,6 +25,7 @@ properties:
           - fsl,imx8qm-edma
           - fsl,imx93-edma3
           - fsl,imx93-edma4
+          - fsl,imx95-edma5
       - items:
           - const: fsl,ls1028a-edma
           - const: fsl,vf610-edma
@@ -83,6 +84,7 @@ allOf:
               - fsl,imx8qm-edma
               - fsl,imx93-edma3
               - fsl,imx93-edma4
+              - fsl,imx95-edma5
     then:
       properties:
         "#dma-cells":
-- 
2.34.1


