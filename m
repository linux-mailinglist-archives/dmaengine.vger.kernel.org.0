Return-Path: <dmaengine+bounces-1949-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEFA8B023E
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 08:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39F31C2280A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 06:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EFA158A1B;
	Wed, 24 Apr 2024 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wzikfp4l"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB15158A1A;
	Wed, 24 Apr 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940654; cv=fail; b=iRlAymflZvXbUK5P7S3xgee2Fwxac4SUxve1wWc/IWhWKB0h4kq9WpE5/1fyaKXQsSocAFQr3hfrHek44e5m0fE/JQmXygU+nJdugqfBBScJIPXia+loEBVnsDW4E6RfgutwfddFOB3m6ZzA0GCMCqkRpbIKrnU/gJGovRcaM0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940654; c=relaxed/simple;
	bh=7AsuDZ/vIjFWiTFvuIecxe0fayPLd39SCh6/LzoBBuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KplKgdU+yE3SpZceiJw9XYbP4hf+GKx3asc35iqWKueQ1JnTdLN5LpWAsUtDtf56mn3vgb/edbyH9y+6BHN7GnveLhsFaNYN32EMo0XgyB9zkJKAHLBsWmoT+5X/j+yCY5fz9HNYz4PyMtwPGincEHQ1+6fTFRQ1UgwWdVNKvmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wzikfp4l; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPmkJKaV3Z8oF6JS1czYE8sXlur8qEhMOkjX5UQIIcqq+TzZl+Zq/K/rcl8WIAMAKCO9/zl4SwJk3LU+Ad5peh5qeF9INXBmZzPC+8pJsgjd11d6rz8+DTVuukxgy4etgJYsK1KaYtuTbt6xXytV1BrdZMdGnndZ5aD2VH6lWVpCQ6eLvaMbYaZbmb7ovRMg2dCisW2KXEeAx2SidE/0Yf3CsUCTHmct/hWiezsphkK3YryXPT14Sk96aGlMH+jrU+0wJpiXwmrpdqm+deDmZp6C5fKSbX7AVQHhkqCv4wez1LZLNNKTbtDXX2LRV/qVwmZx8dzfaJU/s4FwfzD4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gbpqd1TU+G8DzlFBZQWHzzYVRzf3TIcLuTscqZQe/QA=;
 b=LTwRR9AApngbrTwf3VnWYjGm6wz3hv2JS/BLKxtCSEKl8XnbVBKac3PWVLwAdYGKTWmtGAVxega6kd0QtaDROy+E06+k5qKHJxCCcD3+jy/s5S5q+A7Hwn/Ab9a3/ejMS2CAGQEeep5UJhcNUjJWx8npd7wEF92UZXE8x7hDuVNhQI94nVorpZSo4pcq5E0pu8x+0xM8IIfiXxqwZTVr8Yswl+/jzmDH6mZkE/hDDlOPv41Rp+TmJK0GGGQpsn0G8xwaz/i6iLdglCh8r/u3wodfpdyFfnPiTpgFasynPESC2hxvjpQufuame/SeVMYE+Rbs4k/pL4eE4Jdk/qC62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gbpqd1TU+G8DzlFBZQWHzzYVRzf3TIcLuTscqZQe/QA=;
 b=Wzikfp4lKpvDdrNk30BPKcP/3AC7E6waCZayyaln4hHdnvE1eD8wuhnLRbr7OGVGeycwyRd6XJK8QUyf6hH8rGRHIGmZ14AJnzfddsn4F6yVydOxwptNqJhcMtCizUuzmjGkqDlEwOAAvXrIeviZfBP4jmjZwmVryjR64uQpyqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS4PR04MB9483.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 06:37:28 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 06:37:28 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] dt-bindings: fsl-dma: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible string
Date: Wed, 24 Apr 2024 14:45:08 +0800
Message-Id: <20240424064508.1886764-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240424064508.1886764-1-joy.zou@nxp.com>
References: <20240424064508.1886764-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS4PR04MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: ac651b8e-73da-48f9-03e3-08dc642902de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?We82lh6UD8+Axu5V+u8zNLNe/Tn6nz7ZFjdts89u8VKGFf11FmPfmiy0KgZH?=
 =?us-ascii?Q?MADV7xR6KtDcAzVrqXTXP3JyGcqbU3nL68EgKzmnuQAUQhDhcORVFRG8c4Tn?=
 =?us-ascii?Q?8zqLK1DgSYAqF5/0PycLkCJN/s2Nl67i8AlZyY5rSyiukVNuM2U+fm2OxCDF?=
 =?us-ascii?Q?XNQgcLu4R8f9o+MZZLw+CwpCmRhNUOUmB0VhUN1HCdPDeOVIYseWuonO1PjL?=
 =?us-ascii?Q?4rElq1yr2M7Am6AkqTpeaDqEorPgHGtOh5zJn4eXKhKA/bo33ImlbRipTmZz?=
 =?us-ascii?Q?Yg/78lrSOMRHGZBY2uYVZRpsHGcITUdbGr/wziLOw75gATWO9JstkAejTVl2?=
 =?us-ascii?Q?l/7m6xCWv2Dn/qJ1LjgtoNaATQKQexZcnkYD5t578kj+0tf+Twq73A8p+sXM?=
 =?us-ascii?Q?ABbInc1xKcu4SRrKfzIwccdWf+lm7TLx5lamZI1ywGVvSyEPLQxgt+8xd94h?=
 =?us-ascii?Q?ygiR/NqaQKQpS8hIyf18vaR4m1Ab+R0aX5gL/00oJHydWV55TFNBvpwZR5Qq?=
 =?us-ascii?Q?5TCCW0X8viNzaYYXgx7mBmYZdGIw/eAGJ+0P959S7vDd+EWTs+RCMDwoVmIP?=
 =?us-ascii?Q?6qqoHUK2DSjf05dTtqelr0Wwt9oRcfXUGhpVCTttt1AdKJFrzpeto42v19kZ?=
 =?us-ascii?Q?aORzbRqHk8U3URXajxa6/Y3eyLaibgn8MQKoge/s9CqCT5oDwZQlUGlXGAuc?=
 =?us-ascii?Q?r0NGQntrpfQm6j8Mlv2WyumiSYDga9lK8d2N2H8Gbr0zPDlJ5Tv0PycEFcjV?=
 =?us-ascii?Q?CubkoVWKA/7ZVUZvcor0vOu6aou38kj4ctjWF9HPUmvIKPEttS6/H2oaeoIR?=
 =?us-ascii?Q?VMw20VSRR7aOdWgnhS8nWmEIRZG69PwfeL5PaH44co3/TRFaHztjd7N4mFWx?=
 =?us-ascii?Q?HCRd+s1BQAxjDuQcRFDgMf85tB3eHUQR9G61r5HhzjrTrgiDNWHhuvNtzMHj?=
 =?us-ascii?Q?ipcQn4yZ2kPiKNaP/qIzupI0Wg2niNxE4uGGEW3MTvHS56Rq9DIxpEuh0Ryf?=
 =?us-ascii?Q?AmCkiy4GV0pooMa3SIwkHQu1MVyhFHZTQ/n08cpGYa0XgRWg2JeeGe9IXYQI?=
 =?us-ascii?Q?TKDI7lZQwEg7Iu/1i+nbzunVaqllb6Ji1nOk8J9Ubqf2fjFb1Ke5oJb6p3yL?=
 =?us-ascii?Q?MIKqtllYlx+U4gIUzpxcywt8eF4b3b1zNZ73mAtZMUlWTBvc5PNeLEDBkniA?=
 =?us-ascii?Q?IE5pLDfjk4iWrUy+1A1jPYTTKiBDumysO8CxpYtqJw8+/VPtq7knHjvfd77B?=
 =?us-ascii?Q?MWcsykycV6cPnuQEagdrpum6vKIFuvtKc0zHuYkoLGCY/aFzA3Qu+N1oSIK3?=
 =?us-ascii?Q?FPXKufZK00rjOKQLh9+I1Qy7/qlyGH8LvdnIH352tUXYUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WCUzfqFkmTjaMmTO1sOhS45L/zNmwFwIoaUa0z3F9MGBjDjaDBeGsVyD/yZK?=
 =?us-ascii?Q?o3U983cZS8RS6JghV5CnlEk3Jle6pm74LzZss6b7432YM39QlnbfBoH8N6KP?=
 =?us-ascii?Q?qBT1uSg6Ip35/cdXovGckzBl4J4nwg6e8ZPwov0XuDDXiU+LnsQlhB0ilx8O?=
 =?us-ascii?Q?TiYewRxBeWhQxK0zYlRwlW4GBq76cbMjBM5CAaAYJidzy6lhwCk88TqF4FxR?=
 =?us-ascii?Q?8lAb28g9E5JHksM7y82hizovBwScYMhqRU4NWFwhPpZJ+bMEuweZz2dObovI?=
 =?us-ascii?Q?I1WQB6Uqk0ebdHzDU5RZMhUjLpta6EjkJke6pHSYRmi6YV/HPareJBwFzkM1?=
 =?us-ascii?Q?noYsliU3WMAPPoNTbkdjtVovGh88Qin2qwEiXgJ/ml61gkkUXsnVF5M/3Yh+?=
 =?us-ascii?Q?EqKulBUbR2i4BIXwVKZHTsRuVHzk9RlUd30iHCwq9NKOIJ0GpN4/a2FNKRrO?=
 =?us-ascii?Q?fTMhT7tLFvWUUoVDe7ysKS46LlWmpa+dZt8eqLPuh+8QVZ0l8B3cdHfQFXYs?=
 =?us-ascii?Q?THD8aTiO66GbQNuu2/s+DkvhPD/wtoTc8YEb29rAB/xFw0IgpFHCXvA0oKh0?=
 =?us-ascii?Q?LtJ2o39FGNw+ljk7/RLX0BCl3UaxCYpczgrZ/tzjnwLsiSlEYXZ8H9PHOPT0?=
 =?us-ascii?Q?PGueZ5HMB9+p566MKENeZFKCun7Fgi4vcrDzXGvs6kKlRZZ798dYWn6qXm5Y?=
 =?us-ascii?Q?wNusxF5xCGvu1ipFuHiegx4qRf5wpp2GH4F9Ffg4Uk60T6ahE0VK7laJizu4?=
 =?us-ascii?Q?OONHvZNn1tl1aHaLbll1LaVJ3Ye5NFqKHzj3NvWXKRLENpfOwmmNmX3weECr?=
 =?us-ascii?Q?jKX0F2AaNOuSEMYbvyMqq/CMryq9rBClwaAKmcollx0f9QRBMMRjxDP/uIkB?=
 =?us-ascii?Q?6yhBoPKLy7bFaoADwGLccWmUvDn52aEqfk0ye3g43MP8qTqMZpHHRjSJb8yb?=
 =?us-ascii?Q?yWFyig1QDusel5k2Q8iQQxT8+Keyo0XjzwuYXD5P8P0mt6//Ozl5WqewZCC1?=
 =?us-ascii?Q?6+uuwaOAfI0+HB/N6LO5wpdZZbtXYtYD2B0lIcqzfEljxPprlTIp4y920Fl0?=
 =?us-ascii?Q?dwT0g7E+4P9PQEobMGPoEQBfvrFfDa2TDt4a+jGy8iViwgMd3yyr4A1EqLqm?=
 =?us-ascii?Q?2X0o/TD2bJGLHEWuTjXahazACHjnDzpAI4Bnyl1jiyUU6u0Xyunxxjnh+r/W?=
 =?us-ascii?Q?Qshrad4VqKS3hzUi4krXrtP5WAMmo9LqNehggmwP+9BnDDp59yNjVaA0otYq?=
 =?us-ascii?Q?xBEB9BFSq3nzhi1jAVg+Ps4YJgvZjD3lOlwV9eonujxzbLXv0npCMxTipOZX?=
 =?us-ascii?Q?RQ6pDGlad1bqatEsHpQR1gOP7vFGoZi6d4KiZYnK6r/onmmjy3Z09Zk372kt?=
 =?us-ascii?Q?Oz2Td4c+PKRdILrfJGBI7SYPTPI143dNvXBu55F/QIfmcLhUzLWyTS4ird3l?=
 =?us-ascii?Q?WDeF+TcplTJsGod0E/8sBAbAB4FBPvHYwZ2Dl7BRfONxb0W3ODzD4Q9zbn52?=
 =?us-ascii?Q?vablBh9QjZ5aMRHAwVbjwjMJuQCbkwrPmdCo9awlaRb7kJxeSKP5JYPJZ27k?=
 =?us-ascii?Q?9SFivcI6Vko75osZwOsQDmVnhrq3IX0RR0aiQ3P4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac651b8e-73da-48f9-03e3-08dc642902de
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 06:37:28.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqQ97xcO8hHjYzseHoQ9apu4TFG4Bh5Dokq2lFe1JERoL+j8JDjIuAWnwtX9lvDv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9483

The eDMA hardware issue only exist imx8QM A0. A0 never mass production.
The compatible string "fsl,imx8qm-adma" is unused. So remove it safely.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes for v5:
1. modify the commit message.
2. add review tag.

Changes for v4:
1. adjust the subject to keep consistent with existing patches.

Changes for v3:
1. modify the commit message.
2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.
---
 Documentation/devicetree/bindings/dma/fsl,edma.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 825f4715499e..cf97ea86a7a2 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -21,7 +21,6 @@ properties:
       - enum:
           - fsl,vf610-edma
           - fsl,imx7ulp-edma
-          - fsl,imx8qm-adma
           - fsl,imx8qm-edma
           - fsl,imx8ulp-edma
           - fsl,imx93-edma3
@@ -92,7 +91,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - fsl,imx8qm-adma
               - fsl,imx8qm-edma
               - fsl,imx93-edma3
               - fsl,imx93-edma4
-- 
2.37.1


