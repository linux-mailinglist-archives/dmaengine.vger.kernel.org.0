Return-Path: <dmaengine+bounces-1794-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01DD89E2BF
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 20:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06824B22370
	for <lists+dmaengine@lfdr.de>; Tue,  9 Apr 2024 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E895B156F3F;
	Tue,  9 Apr 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Avj3WLlW"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04A15699A;
	Tue,  9 Apr 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712688875; cv=fail; b=ieD4qr5BPGPklgIJPwkgQC01WSrFj8qMbGkQlGAANFRRGgolhOJeQPGODzRY8KvrME3sl0f7b505WDeuQRoFQZDCeq1u27mCznh+aT/TKnCq1ko/y2NAFj73Fa5ScxjK+t3lynEfwnt6ghzCquPN/BTlUrJaDA7kvdfXbI62esA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712688875; c=relaxed/simple;
	bh=79lyNS3ci/t+H/rqhQ5okiAHzbqkT+xFcfP0/8kGJ70=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k22S7KYdNQ5J33YKnc3uGOQgfDoXdGd35TIcWgzHnLzrsu5GO1gKV++txKx6fS5eHzpQP+Poac/4AotIkCMZy7ihY4IKqS6MfUN7zIdgc9c3+kBfhnmbRYCD3cG406iV1OCdgT+dnOV/r3cqGRw5acxQDTOdEv+JuYKhXN4n4Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Avj3WLlW; arc=fail smtp.client-ip=40.107.20.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSQSndHr3ZsmTU2W/6po+3qsYBU8Z63ZozZ/JAdtdYFtfpAFTwcMuraA3JPhaxjynsbHXrH12a7cZwoN81LwvD0j33uf/dCrDGQxYOtsIaXidJ/HtkAxmm5vkwyuRpJUDN6su4oxSsF0FSxKSM7V+Brj4YYCJl6j3RGtrOuDzYA51QhlqJse/wo50cQFmHanY2G2xk4pj9mzEpjT32dMOIDWkBCkH2RcpRNoMwxNYy0xJBTn7GLzn/jCi+J59IeouHkNyRfSupdV4pbKVHzHe5MwvqCm2Knw8nUoCm+QR5V0csqAGqj95T5Lzlr6F6PVWVuLiTySNKNTh1VPuz6sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TcuymeBOUvbxg3qeFpQuyhvrHUg9/ZmWuSI9+B5ab8=;
 b=Y1Mu2+SAkKif8Q5FoDlS+2Cs1PhCD2/0DaHTY1PTZePV13aqA0/2PADX6Q21lYvulRQiptkCpkypdNAml9d09qBl1945k6EUZ2nf20EhoYwS1CLga/9rd3/exLZS/XtZAaVjUb734jIDmMAELW/Uh9+JcfwLFtCvugsA4Y7BFBqTRU7vALp4I3uVTgH5SZnlTC4QwsArEd0E+q0b1A6wBO7koP9hKsPc8Gw8CxygkJ3nL8NotGK5i+c1BZpYrQ2+zvxJB8GmqpoXGMd6AQzSd+TNDBcYj9p4uYlXRIsC5JpOMIR8f+xoo8jhQsARKT3CV0BEjR32w1uEAJXZyQkITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TcuymeBOUvbxg3qeFpQuyhvrHUg9/ZmWuSI9+B5ab8=;
 b=Avj3WLlWpGRVL2wwlk3m/A5tuoGPOxCIq+y8hV1i3TVP5DvMh4YBgTZ+VdpPHUEja2QKE6AL3dn+AFS2WcMq6QdZ/O3aSogwWQp2k0n5Cx1XxmEeEofzJQYsZZ8D5Feq/N9G1R32JhsxXBhxd4SmQc7bn1myci5JglxY2q3OYmU=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6998.eurprd04.prod.outlook.com (2603:10a6:20b:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 18:54:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 18:54:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh@kernel.org,
	vkoul@kernel.org
Subject: [PATCH v3 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from required
Date: Tue,  9 Apr 2024 14:54:15 -0400
Message-Id: <20240409185416.2224609-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:806:27::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6998:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+LFawA6WBgl31O2O1sPxyH5SKOlcBwBqIX4tGaaAtfGSAmGHtH0hTzoaCQJgQZDGBHL6Ftpl0Vvw2TzorDk6f/Xmt+ESjaL8+y8k1EbQBjzcbxcYLf/DAJwvX9C8ZZkgRNZqDh6cK/3FLAVPMpNigXwvMtEfhRh4pRI0Uoz6Hu0FrR7EDrV2RNDiGdB/JPixM1KCNlj6z9A2Za64Gk9Y+9AMcIeP4kwG0Trtdy5fRjp9zkdVulf5rhNkYgl2wCQLe8LgG1DoeRXDKzZVkLmVIYGB4qekcNhCEPdMiYekarQ22Khw8mAxCKU5ymp5+wex2f57y7Dzx9Ohbx/jujc/B1ZQ5HMIdiWanajf2RdPh2Ii3+8nVo/o1MWWuAiZUI1VNpAPcaikfffmAgMY2hX6S+JyP3TwdjXjUxW1NRl9qGyxQkWoaBL5KyJlA6d8PBunfn6FJ4gQF5EE/UVmwUT6hufOLp1yZnV4vIqzg7DewcfjRaDsbKU9bc7Ktf/abWfBCf+fI+C+vEwATDy23gho4VRKbjjDWDEmbL1HKV5adE9x/iw586P236I/J//BzlVdKx1Mx3yh10xUGGPVTfulUQ1m3GicT4bYJGnV0XE3uIG1jHRG+e5XUpzxRGLGqsA6CYjQGZvzja2LNrQg/5GO01rRLrjzG2BL4WbGAgxtiW9JV/ShpxEvDHu5jCb3WHoKlPuVP1u9nUT7JM7tqy1+1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3genjN9vhx6dkrHrjoOXsJ4CVSMsdcrkEL0wTXR4FpxTeCcCIyw5JjSfBwt?=
 =?us-ascii?Q?5MlDu54JHHKsD25Dy6e4hHceMdd7T2l2wBWQ30G+F04IGiSorhRKMm4AAoFr?=
 =?us-ascii?Q?rq/6hvjHxa2tXR9L2uGhNR9imkql64mDCoOAxkkdRA4w117vUxtjScnFMNIr?=
 =?us-ascii?Q?uuvbBIFtK3UFDPkpWNeyxpdCS7oVpaWALspWQseO2dmZH4Sko6UjZkhnOP6c?=
 =?us-ascii?Q?KMMvUK+Ju8NtQ2uHeCOdeqVH+V2V3FR+PM7GcEFIUTfyZaiHK5/kJr5wYbv4?=
 =?us-ascii?Q?Uh/Pt5e1Tr9SjrL44PBH0WHUeSfNTnTQnXducpAWZb3foMJs8zk3th830iyB?=
 =?us-ascii?Q?9oh7U8tppByhqOBXsQsdtUGGoeO6t2wXqi5V4y6qFnThEwJOYKa8QuQyCLQO?=
 =?us-ascii?Q?VPwqlVAcX+PjkUob6NNTeJvTYUvkLeVk8QaW/nivvj7LYyaBP4H+jyVddCeu?=
 =?us-ascii?Q?RI8rSr9SJLMCADNqjn3Z3EwqPDkoKc2IV4OJBMOxFb1YbYqeB+wBLZTJewDd?=
 =?us-ascii?Q?/z+qvZKuQuI3Jjq9XjtQuHbZ+UDhyCG9F8NGOKT04O/U2QkBiFZVcVcKUAc+?=
 =?us-ascii?Q?ro4+3WISa6bjTqkYvWfLP0r3bYi+rIN6BbIA5TNQZoTfKTE9nFlRV5zRi8T+?=
 =?us-ascii?Q?wyiTqqlhusZpZat7heiXuAkOUNEA9HY6x/CVDztXiaH8fSGfBFwtOXG0O5v5?=
 =?us-ascii?Q?M+OFwf2dKA4OO7PoUDySzrjUlhSRg1ALKFsME82vmDel9JoMBYxnYUgHEIDD?=
 =?us-ascii?Q?KrCApudpx+9owKKcSzAZZh7UQLp8D5fOGHK9SIw4vGPWufEphFcyBAtkEzqh?=
 =?us-ascii?Q?vgMCYcMAQwSd0AuqHxSY+4YxpH6qXFfFzwX11zu1y0PPqknnc+8DjohDjLlS?=
 =?us-ascii?Q?8ymGd9TsgwL7JGfy1qgN9XPe8j57bArGpt4bsrirIDIRsmEeOIVyY78+boet?=
 =?us-ascii?Q?l8IgsfWzJlHnBBIeg/0eJpIgOn9IYvHwUcfuvVZrNpABR3IFxNkmoqyEKMlI?=
 =?us-ascii?Q?qakERzWDKRLVahb/hBjmUQnNd8tt8iSyKhzDuaCbfmTEhlvwWp+fOJ57og82?=
 =?us-ascii?Q?EIvZbyXpZBNokt1kop7e2mg9tKalBRdD5Q8k9R1AJ2z8SYDw54grl3iNUKXJ?=
 =?us-ascii?Q?gfAdxnZ23IrduKyk/sRqEAV0yIiUUoRiA/JgGnI62MJOfnF68VM6ukgx7uIE?=
 =?us-ascii?Q?uaEo6D+a23VY2nNZYSmuCcZHRImlAIUZCgtRZKr13Mc3rE7y/baJOGeA7pzp?=
 =?us-ascii?Q?It0u2AuZW7pUNNI4zGXa5efBJj8Zg5KWM4iCpXICYGurXYMdFqJnW+QSDX2f?=
 =?us-ascii?Q?Gghbd64l9GfnoCyA0YkYj+KG3EyoFL5IbIUNZOmfIRrVdq8FPEhckD3CoyBu?=
 =?us-ascii?Q?yGhSQ1UiggYjqfqTgVl9agoWCrkAWRfMx2Zq89aVvSRWV15NCgPYn3RJ6cRv?=
 =?us-ascii?Q?diJMpFp1fcdZHICCjpnRdpdgEmLuA9my+fYezJwm4+EwSFJoXwoOxkliidKM?=
 =?us-ascii?Q?7llloqhm9uvPYx5VtzcWk88pmVYleqcaykYlQw21TGg0swj0NRRsD8WoB8XQ?=
 =?us-ascii?Q?gUQXBY2LYcr9msQQNcnQTnVGhkznuhmAE9QtYYnw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33df43e1-b2f8-4217-80b1-08dc58c67cdf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 18:54:30.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1jge9ODtpdIq/rPW9t3qebgDiXufluag/tzZ/RpLYMQfiOZ+c3ajBHx7woL9kTyd3MA2Q0nH5wF9sMhwhf86A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6998

fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
required and add 'if' block for other compatible string to keep the same
restrictions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
      - rebase to dmaengine/next
    Change from v1 to v2
      - add Krzysztof's ACK.

 .../devicetree/bindings/dma/fsl,edma.yaml       | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index 825f4715499e5..657a7d3ebf857 100644
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
+	  contains:
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


