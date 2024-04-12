Return-Path: <dmaengine+bounces-1834-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA548A32BC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14FD928982B
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AD61487E7;
	Fri, 12 Apr 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OwLGrGHl"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796185278;
	Fri, 12 Apr 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936547; cv=fail; b=acoBavTPksEn415rX4JjdmKUPXrqxc1T9/DlMv3/rQOUUMIs+ZPIPzRf0/VrKGoRA0h4/LWrpUqQz9jzhJ2dKt4Rki3oE1ZF/UxjWpQObh3ulstMWkZMNVG3pjT+PGw6YqsZFdoYcmIQJ4HzK5WfeZbTZvVgSw+ZOADsOuMaNY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936547; c=relaxed/simple;
	bh=yyf7E23kyl4Pej0xMuMGYELVU6tH14PmlIKdxstwdtA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fTble1FfTG0Ph19XAYu23c+WQiHY5+/RSR2rSwNJaXJ1M0v2xF1D1DIOj7Uj/33IX5ZWa09hD4pK8VLTcmJwMubyV/U/dXUyD2vhu27sx/nnWqnJ9FtBmQpe5rvqad3iua92uh7YAc+pK3Hx2y3QoCjirKLlSc50zC2I29/y+Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OwLGrGHl; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idbMd4lbxDlcyeS1Ze8oFproo08o+uQNBq4yPbn9bFUVik4z67BpDImi6xPnABLX2wmiAi7BkcnwE6iOAqvL3Zv/ozQfBDEYNAJ6T7+vio+wO6Z9QU/vU0B9Mn/j8dr++vS+DfrujR3z4njzoKQAi1LZj6i4NkgmGeSRW0ZA8Q5dwsBfgyp+836qhfLTB1gnXVfS/OtTpFSkh5yHc7fA2q1XJZQ7vfe3Rol2Rk7oOg+9rWjmPRRoCxENmanb4H3rzKmb3X0AXp/5mTfstG28nf4CGfgsZ5MLFKNk5voNnAPOJFhu79rhLPePXosLAYl9vv2TeHbfgOYiUjnPAWYVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8fg33KXaUIdHAFL3YvObLB+raTXbBVJgCMWg7y4Ws4=;
 b=Gj93oDzbV7xXEIf284zCkIR9geEr3/fqY3afvgjHIy5ObF/3d9Yvau7nBfC8OEbl+17r6HOw+3GHeF1Rew2uuvUuHNbMTVsz2pJxUl4JzK4Ht3uX0tT5Qm8d7pTZKIml/D5978fphTWmomCy8AgiUw0ti+oiXuZFivxzGgBjIGssOOXy0ZgyDU4IQKowv65V2QDkLfUfoTjBPBCvPmFsogbrrM+ggoKhZJn0CHHSrwB6M7g3VhwPhW9ULYlur4kCdBQogRFI+TFdyNN2a+mzDQYpg0auxbu7RPcY1flEpu/tqielLJSFj979PqvdKPx4i8N+std8xHRRoIrZ7GivNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8fg33KXaUIdHAFL3YvObLB+raTXbBVJgCMWg7y4Ws4=;
 b=OwLGrGHl0Q7L6lHkBpXuKvaIdAZIZRoW3ncnLb9CDdThCCOuZVpOaISbR+N5oEhBYzhPV1dIMv9AR+MunZKArknbAeNxc7dyL3eSwMzXT560tZ2BcRevTr66QrB/3e5Vkm6FZKbwBJMNvgrbdP9xdBZy/OKsBGeEwbzOu1ckIFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 15:42:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 15:42:23 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: 20240409185416.2224609-1-Frank.Li@nxp.com,
	Frank.li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	pankaj.gupta@nxp.com,
	peng.fan@nxp.com,
	robh@kernel.org,
	shengjiu.wang@nxp.com,
	shenwei.wang@nxp.com,
	vkoul@kernel.org,
	xu.yang_2@nxp.com
Subject: [PATCH v4 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from required
Date: Fri, 12 Apr 2024 11:42:07 -0400
Message-Id: <20240412154208.881836-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:805:f2::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 2502bddb-0b05-4460-71f4-08dc5b072569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/lQCwQatTqETreen7C2DQ0bm9TIgQB6OeaOi5mrTRFWeoEyXUUWMxLNNV4oAQHt411bY9ak1z3TDIEVgVFi3aC/eLdE15SiMcofYmMFaEgIaCnJ3TyPUzGtRo56UPbFPuf9W2dU1Eyg3gORmOPw7tlhjJblpxSlzmuWLoFiFSpeOy2nKIL3Sx1FKkNnB/eWtaL3ksP1/t1SY4BXlQClepgie3VVtTUyDnBUkhN3zpAAsNJocDXIuEpXUOSdVL7AWbuAS9tp/SqCao/L5TxV4FfiZ1Cac7IiwRDiaD3GMK96y+teWonN+txLE6pQ56pu3OqUDno2BJtFLl6lfnMo1MvnJRV9zt3gcaWvpbLD7a3oxFSOEDeGBWqEJRlsVVZS2l8qlWf36KQTFJlEuRy/zklCQsF1f8h9yPT4l9++fZj9mca41+a7UkTzjRHpMgwm8k1wW6NNUJBMfVixToIw+l84Khs0G09fCai7ab8vk/MkdNxfaUQhQxRaNFKe7iX7ZNiVhO6Kw8lY8UgheIHda7HUDPyWbWQJ39DArKZX407AGX2pUMDK3Q0ZpOBsl5EOpI/Uju1pD8oLynUCxf5IlCbJqrauhZuffQqfg4BfBU4fQqFKhGUOzH/NEyWXYmhJnvKejtkhR6c1mkVd8XWr6DQSDrAwEGanYmQ+3aVXB5tqd7vpQwUycC1HV+HqUL1xn4ByjoD/Fh6ziVWkqHU0ucA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1zsFMrDBaXInRaldeAd85OMvTvBngIk9ySoGvFuqYVN7DeEKSdQ9GR5uS9g?=
 =?us-ascii?Q?6X+swpFqzH1fTID2NXN7kJuV9XN54AwvdkgqMqQzbtKrwkaAGEuPU7dHpf7g?=
 =?us-ascii?Q?3NFwCCfq//uawOUQF2wMaGvoCr8SJcirXXlyLrOk13MzRe2p0TTNKwu+YH5r?=
 =?us-ascii?Q?H8PCkuO+9sawD7jsOUsBBBog3fokQbpJZYJmLUIxG/mi1FULCXDSTrb8P+AH?=
 =?us-ascii?Q?XRc5EbXY5AGorbYI2nsswOTYBKC+fcMMmVx0pgmtMwI311NcRnYZBvgM71A/?=
 =?us-ascii?Q?m1b5ZjkTIayOJIR/X1+3X3TnKOoc9i7cJk+Uf7J0jNIVKS7cnPHPHnTVcoIk?=
 =?us-ascii?Q?RZ3LWgLY6kRe3nvJkruPFIMoRQ49bHXzvFYePYlWMJcJS03riL4iH0o6QDOL?=
 =?us-ascii?Q?xe0qpCYSjo5unMyCthU8tHKNRabzh1qdLxeraaOUKBABEN1Ot0yB343V1bu+?=
 =?us-ascii?Q?dxONx0pye3pkqigGDouF1u3O2tbQK388iOg5RBUTzPuuLOJ1pdL1EaUr8nck?=
 =?us-ascii?Q?B1YlvTIoB14lx6kJnGEVT8tUlXfbNfNxzfV1tDEd5uKb4NWirUQn3uMnRyv7?=
 =?us-ascii?Q?YYNwBwLqgD4M9wPenYe5wjkraK0gkoQLOqdOoGXZPSexKxhQf5E+THgKUwYo?=
 =?us-ascii?Q?mMLudLYMpssQjeUsRecsuBNjh2TvTulkDtZ1efAo1/yQuL12jAzxfWyaXRP5?=
 =?us-ascii?Q?pZNrn3YVDzN7wZkEXBV3Gcn6ZpETOSYvOdwlLxWZyaVjGXAdOewARh162xPJ?=
 =?us-ascii?Q?VSzD0ofAYmrAk9R6wvTBjptis6jx7VD2AySSibvOpaJC3Rz8oHyOxVgmDGz9?=
 =?us-ascii?Q?VFjo8DkXtoEeA2UNMw4bild3EPm8J3+uEqldGgQBXlJMac3H0qtdfqmriDuX?=
 =?us-ascii?Q?BJpTwQXxEZOjYRH0lEMozf9iqLulwctIP/brP3tocBfR0EtZZZ4dGuhRly58?=
 =?us-ascii?Q?X9UtjuBqeJRxI2CvSiJr1EZ4HrnptzP+vIaUbrbLuLbxxl4/LizqAckfi8E2?=
 =?us-ascii?Q?ZNQLNcVBSOnzdAbIhChuTEI7mujDrsqyiUQGFIOHFXzg4HYbabHbkW0pgvOd?=
 =?us-ascii?Q?KVL5S0XXRsdg/aojs4OoT7oGaJmg830Oy2dv4hWFjY8pe56XdRr2SBeELlv2?=
 =?us-ascii?Q?vUThNYmcmkvz8AC22rA885HlsGtB1Y519ouJ4IfgeBnWXBcBNLVRJkiMtedP?=
 =?us-ascii?Q?kXY4Jf50az/AhS3rP6zou+mb7oqoACHU0GKcUWrR80L2NF7NnHv6qCyIEZuF?=
 =?us-ascii?Q?RfUCuxAlGP/UclJZHJbfosTje0I6wG3Azh5741J7oahqYuOj3kyXvQ0EO0Kz?=
 =?us-ascii?Q?yygfd2MAYT+lx87+tFFM6ycilcHtNuJZwoE93am7CCu0SlbCCOBXxXycMj2U?=
 =?us-ascii?Q?SLbRzw5OiVAw17iP4tNYKfGucHhLfqyicIpdMgiDaZkR+oJdZfWdHZVNoYNX?=
 =?us-ascii?Q?TGU9H2tAUujq6Y50VX7hsgMMRSgFl17CUnHo79PHEBSPW2E6meU4uKNGPemI?=
 =?us-ascii?Q?C21n9tWOS20tM7V/46bxCXB4J9NOXL/FzVQsGc/5ylkuML7NJ5VwVVIAyQBv?=
 =?us-ascii?Q?9neWBh8mKq+SjoDl+BAo7edszsz+RjNbz2Yxmf4Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2502bddb-0b05-4460-71f4-08dc5b072569
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 15:42:23.1890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAPozN74e7yxq8cf20wOEF3hII6m5Y4pvmgz6wxltb9PihGb3l+CdO+XQ0F1MsCw5TPIFT89H6dYgeTtlvFwgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934

fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
required and add 'if' block for other compatible string to keep the same
restrictions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
      - fixed '\t' during fix conflicts.
    
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,edma.yaml
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/dma/fsl,edma.example.dts
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC_CHK Documentation/devicetree/bindings/dma/fsl,edma.example.dtb
    
    Change from v2 to v3
      - rebase to dmaengine/next, fixed conflicts
    Change from v1 to v2
      - add Krzysztof's ACK.

 .../devicetree/bindings/dma/fsl,edma.yaml       | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 825f4715499e5..fb5fbe4b9f9d4 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -82,7 +82,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
   - dma-channels
 
 allOf:
@@ -187,6 +186,22 @@ allOf:
         "#dma-cells":
           const: 3
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,vf610-edma
+              - fsl,imx7ulp-edma
+              - fsl,imx93-edma3
+              - fsl,imx93-edma4
+              - fsl,imx95-edma5
+              - fsl,imx8ulp-edma
+              - fsl,ls1028a-edma
+    then:
+      required:
+        - clocks
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


