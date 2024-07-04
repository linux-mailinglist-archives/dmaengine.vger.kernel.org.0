Return-Path: <dmaengine+bounces-2621-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C7E926D53
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 04:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7AE51C213A3
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jul 2024 02:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30459DF51;
	Thu,  4 Jul 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LgOBIoZw"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E932101DB;
	Thu,  4 Jul 2024 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720058905; cv=fail; b=Qx0BpKcn1DDSbf/qAXf6wKCE1vbrSD2aw9PVNt1I7D4B6jE/j9N3ZuuzLWmpa4DHsJaYxcamKpLotITGqnIoNGvJNOZdp7p5tPYGwuVZ/NH8jE5DtcV8Xz42/woX1S1KvSpcHlGoMv/+1559lNlnLiT81Q0HRiASCtFOEwj0zoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720058905; c=relaxed/simple;
	bh=mUOUwhe75ADDUvYY9g7kz2TMf7OUukBzX/sy+MgOJHY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Kr0gRCm/AYQ1+Aa1RFY8neXueL9DIRx5rjGVAgNzqZLo8pFFfkqxrEUbvgFcNrp30CMcyvoPydH5KOPuKiu/noTstE7bzwG8xU3MBGm/6h8UkKUPoLXCFH76ep3kdKgAktdJb0UKZwIAt7d60X8x0y9eV8G2myJYAUrA6AYXhwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LgOBIoZw; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JO6bZ1id+h0Qg6hkI3ejTxLgr4w3HbZ5Cd09b/zyjFyaNG7Nh43gkTAc1PqLPvw7hqk07SYSIwPytNyb1DiHEh8qXYgo9jeI5f1r8W9wNOy7Mc5cI9DR7TYYBikrKQiImGPEISYe0F5i0pSnXCHfdv/qg6y7kMlW20htLByiJB8qOUv4qny4Ulx3BY43SdMAClQRgMQUlPrm1rXsQzMgEa0V1ciCX1RKlKUYlKVG+tFp/D0xiIDIkk1xlfTNT4FnP49oEtLMbph2EsAydXA8OBt/DS9D1njcGRXS8DwQuYz03/AApNf+KjGDgzfRl61+jYrfneVKYNyA6pkCMs9iTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCRHS+OmBGjtPYubtfOtwgGD7Nw2l0V8+iqwHeXENwY=;
 b=FK6Y9mr315s/oNMblisvpOv2sxswVK/TyfgCO2xTLl3FVFbyNkT/V6Dv+YAe/t09NHkHltwgqgtAJEj8KinPRpgmasT8LJX7iTOksWHj9x9uzRBwYL16MiJQiWZ0lMrEKPdvks9PjZ6eM5E3jiS1vaHd05lwK39CW7jiKQGwcr2bbOmeafcHb2oIAg++L1/UtRnq1zUe05+oiCM0Fah/SLsLyOw+aK/0VG/mtfIwRwDCCqHzzAGPeHZXBgu0BVEcoRcJ8ZDAc+ADpd/tg56c8inhpdCa4DgKCvIxEYl+3YQc84iHH4tK9lP1i0JrgRy9VZAiojtYupZ5SBmo/AVVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCRHS+OmBGjtPYubtfOtwgGD7Nw2l0V8+iqwHeXENwY=;
 b=LgOBIoZwbBg3siTGv2+2Zv5MoT8FZan0JxtcMyGigPvy9DegiyJW+LifkaTPkdpIzJ0zFuodMMFbDLrFWINaBL8SGYj/uIkEh3O9nixbk80zJcoJd2doHiDzIKMvKdW7VvvmNzxPzJnWLOS3laAhu9jRc9A9fzAESeboX1zMIWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 02:08:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 02:08:19 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: fsl-qdma: allow compatible string fallback to fsl,ls1021a-qdma
Date: Wed,  3 Jul 2024 22:08:02 -0400
Message-Id: <20240704020802.3371203-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: aefb0427-043d-4391-2762-08dc9bce2c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xtp5oeRvHh6Ao0pu+LXl8X2K4FdbzM5S86OYhh+CI/Mmw66e6ujhDMpAbB8c?=
 =?us-ascii?Q?+RohS3nuyR5HC5kirzUS9FkOJYAA0QDSZq+8KaU47jFcvDp8aMIzxHb89HFS?=
 =?us-ascii?Q?VrMT9phSAOTqIJ+Qweb4yUfZmj2Gx1ERMO39A580ncvWC0D8IUQ7+Aywl4zi?=
 =?us-ascii?Q?zSsr+08tasTGbf2seRcyM8R+O2JxHwAftRVbBhk21nSjC73fwOSJQ2AWa0gg?=
 =?us-ascii?Q?PLUqVraQndmf6KMvS6doXWA78+PKELT/l8oR4izfWTrG4LQ9Km3cDiNolL65?=
 =?us-ascii?Q?R6kUSy4r//w7g44qKruimVXkRDdas+Y+hnfC78Xap7tiAUinbZmgfXvodA+0?=
 =?us-ascii?Q?/CEL/FuwoMz27hddSlouIwMpDxqFRMLkunjtXnDEja1tyyFjr0W6W/sNJsXo?=
 =?us-ascii?Q?42WjayZriBW1T5zjbnK7rxBpl40+AmIgWDhDaDufLlZ3WRVIK2M+nha+inRW?=
 =?us-ascii?Q?1v/jCNUOq7wS+vFKbD+bO8ruyF16P1Yud15m+eEVGEP+NfZ6u26oTU3zw1vT?=
 =?us-ascii?Q?AM3dVW81t5zwzBQ4QBX7m51LyFo4EHUpHd5ohYTHURW8xLG36jNEzrFZWN8m?=
 =?us-ascii?Q?LUyphXoMeuKgfWL2f132tutBtHbqj1MEFcQFr743/Kzfj4lJBJh4xpTtgdNk?=
 =?us-ascii?Q?d/9JAjgqrU6qjfvEPeLuvC388+t1PhgWGTuE8vVMqI5cZk8jppIqsqR5DwF+?=
 =?us-ascii?Q?+5/eUy84MRtdt8QtQXeeP0wWdIS3AJbI34UCk3+U+qtC+yetE+wXUxhyvNFe?=
 =?us-ascii?Q?+xp9J+ChjJlS3hvirodjgETWnB4zD6ZvukOj0yKyLN9MROEJor90qPR+2m7M?=
 =?us-ascii?Q?uPF2MSCsV+q6sdBxMTzrQ0zRoAuXxtQIPMwd/E0YQxvPqpjq+5+ErSDXbhOm?=
 =?us-ascii?Q?dX3hPSofRouAI2P9+8olZ9XYUKlFZFYpMwu9UP8KbVdSS2gWaMHrqE80faog?=
 =?us-ascii?Q?Ki6Scx0FLwK9w6Y6+thndonn5CD7HwkN/N7YFpafVFo+hyaX7sPSUcNcGCob?=
 =?us-ascii?Q?zDroq2XI9GZLNtXHH1SNq2G1NHig2dRjrPFE0anYB2JzNTQpltBNHNHINhxA?=
 =?us-ascii?Q?E2cel81dUZ5PfYJoPUQQXiYjUVc/IPedMvA5T6k//8S65W672Chs4QdYcSf5?=
 =?us-ascii?Q?YExtrPeMP6HeRdWoKN2D7UrzukWlFX3J/OiS3tOTWpgZ1XzmBSrzP9yqlwdF?=
 =?us-ascii?Q?t+KKC4f0t3yscG/mxa1/MUaHqwoebDlO90nJboRR5vCUw4/yCZ4xRSngLsH0?=
 =?us-ascii?Q?T1hVB1DU+l60GbI5nK1Bi1Ac4gZuvD1My2VjYUx84LISVzhAuvxgkAFABzIi?=
 =?us-ascii?Q?NJWtmD5cFwOp4ckqf9EB24OenfRqh3QObOm4qy1xCGZELzoxrn3QUHPHPnsU?=
 =?us-ascii?Q?s9NAbyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c9qYIuEKlmij4HEbgn2dnMldPOBP/ID7QLAVB344YFxhUzhLBT+zdpqBF466?=
 =?us-ascii?Q?OU2qz2Dn19xbDvaOP/OzP3rQOkeD4Fc8cjBuMzix7rnQARD629i5JtFLlZYT?=
 =?us-ascii?Q?5Fmamg5V5wUVI1dNg1ZdGmXMseVScnrotZHXRh6BAnW5W7YeiW27CHH7zFNf?=
 =?us-ascii?Q?b71IfZBim9Ky54ms/FuxlU7l8eICDrS481ZKCox4M1LUfajmtZmc0vRVel3N?=
 =?us-ascii?Q?hFgrqixhbCkZKTpQOoiiKZ9PihccELLnIbL6hhqg1xNSiSm5Iub3UA84PUko?=
 =?us-ascii?Q?YMaS5y0S7kAn8NNh2XnsV1ZevDqdBlECbHA8fwKvbI6xEPP3R/1FFxfrj1N6?=
 =?us-ascii?Q?gZ2pgRdmWqBASyEG22V1PL7Z3xuV3d3wwQTQqmnlCe8pvBJLIjcoGNsHzQJc?=
 =?us-ascii?Q?OxeaoTDPjlTvVcE7nku0uEkbTipDek0g+RQv2MOcyWTHDzgunFRzRZKgH4AO?=
 =?us-ascii?Q?41tJc8y6UR6l4GmvP9NWoJyiKQapP3e2f9M6ZhiudPpH53Sy/rM3/ktwGNVc?=
 =?us-ascii?Q?u7qVmj37L9IVkb/tjAJCYsfOvji8l9BLw/EbuQOXTv53YqYMCaZ4nWT4Mzz7?=
 =?us-ascii?Q?4p+ya1un7iRlAgPDHNxkV3undD+5kb8LnD2h5+1/1+11a9q8uqYMNKkwy0hQ?=
 =?us-ascii?Q?AgTlfRRttUTNR9+4Ykorz+ay5zPebQJjlhy1eGQBSpBGHBUV8hz6lwfvzdeW?=
 =?us-ascii?Q?py7t/m4UVu4lMQOh1QLgvxH8TDFE9qKxCCJyDbWgrksjHOVAdAzHy8ZMescI?=
 =?us-ascii?Q?/v2HKU3zC3x6/wXfe7ylh8EC8QUNRwMGzANpntn+5IJDbUJC4LWC4W/+mYpS?=
 =?us-ascii?Q?Q8CMgL2pXx2x7s6acqa14xIt/j8SVMJXkGgQK7BImX+6Zwt6YTrFcrXaWgN9?=
 =?us-ascii?Q?ttg7vAhMuS8Sx2wDAK0ieIXm7Z+3pSlschnosdcAeBaBtc6A+o1FoXdlRPYX?=
 =?us-ascii?Q?7hNhB1jR2omW4yItR9eJp8sE4JUEf16LGljd3fMOaTn9WOhdqkSk1oUDz9Pt?=
 =?us-ascii?Q?3AKOep6l6H6OaBcXVFWac5oMwkwQ5pzkvtjR0syICqy5sBixhF5WimkHUCgI?=
 =?us-ascii?Q?t9CgzzstdDjqaJTeZp3wCOWtgnQW2KHS4exP0uAnoIZdsB8M0nkCu3X/fWSO?=
 =?us-ascii?Q?hvyCaC+ytcY0SpoaXdlCLrp3nVkay9me28ETDTE2Cz5ToSx4ilQn6ijjm2p8?=
 =?us-ascii?Q?6neOo/E7KuC4MlWUC4K0xXixwgM0bbpU/8s7DD+vzcHzSNLf0I00U7ET3RzD?=
 =?us-ascii?Q?bwVB72vW3H2x2A25WoL/lc47tiQC9BNMkRU6mT1eDRNguPnjMTwKzHZKif6m?=
 =?us-ascii?Q?Or686g9jVfYfJMCXpefRBRGGhB4GIOW0tm8Bc5zMm+s81zI2z0VfMfxXdUyo?=
 =?us-ascii?Q?cJlm/l/RkzKeznarTrGD2llQbQ/WG9YaSFaXP576XPZNPsgaJVBcCpEGvOxQ?=
 =?us-ascii?Q?4Zp/sD20Tca0EP1UaTHZOpRmuKWR0E8HEghX34ZeTI/OJ2qLeQutgk/ZeEDu?=
 =?us-ascii?Q?i6paDDaFmnL5OLFQjeUTrPFwJDRBrlNYmXBn6sC5kr3UtfaqO1g5/lPlEWVD?=
 =?us-ascii?Q?nK/+KOGMq7K5KvO0qMQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefb0427-043d-4391-2762-08dc9bce2c5b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 02:08:19.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJhlymODq82ztxE3+o1ZzQrrMGKi33Bs16Z8idM+4YqqMT2ZXaAo8zv2gB5zzrEufZ9qgMsdemzWd01XKvsKEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619

The IP of QDMA ls1028/ls1043/ls1046/ is same as ls1021. So allow compatible
string fallback to fsl,ls1021a-qdma.

The difference is that ls1021a-qdma have 3 irqs, and other have 5 irqs.

Fix below CHECK_DTB warning.
arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: dma-controller@8380000: compatible: ['fsl,ls1046a-qdma', 'fsl,ls1021a-qdma'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- previous patch missed a dependent change.
 https://lore.kernel.org/imx/20240701195717.1843041-1-Frank.Li@nxp.com/T/#u
- Combine depedent change to one patch.

Change from v1 to v2
- Change  maxItems: 5 to minItems: 5. because maxItems: 5 already restrict
at top

interrupts:
    minItems: 2
    maxItems: 5
---
---
 .../devicetree/bindings/dma/fsl-qdma.yaml     | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
index 1b689a2529c87..9401b1f6300d4 100644
--- a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
@@ -11,11 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1021a-qdma
-      - fsl,ls1028a-qdma
-      - fsl,ls1043a-qdma
-      - fsl,ls1046a-qdma
+    oneOf:
+      - const: fsl,ls1021a-qdma
+      - items:
+          - enum:
+              - fsl,ls1028a-qdma
+              - fsl,ls1043a-qdma
+              - fsl,ls1046a-qdma
+          - const: fsl,ls1021a-qdma
 
   reg:
     items:
@@ -89,8 +92,16 @@ allOf:
         compatible:
           contains:
             enum:
-              - fsl,ls1021a-qdma
+              - fsl,ls1028a-qdma
+              - fsl,ls1043a-qdma
+              - fsl,ls1046a-qdma
     then:
+      properties:
+        interrupts:
+          minItems: 5
+        interrupt-names:
+          minItems: 5
+    else:
       properties:
         interrupts:
           maxItems: 3
-- 
2.34.1


