Return-Path: <dmaengine+bounces-1863-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E415E8A8780
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1307A1C20FAF
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3C1474A9;
	Wed, 17 Apr 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D0oT0b38"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04B13A265;
	Wed, 17 Apr 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367520; cv=fail; b=j4nIljReLt87gNDgGetqvZuO2Mi/YeiLcj6INkXDROokjoJVPqXOMVQEuvL7fJLBPy/uedv+3TjnFeUu8LrVkZJOOhNEjb1kzAK6ZXef6Qf44NkMQ8w3zMDmmxTVdOarFZW878Up8PK8QFXQo2YtzMQvRp73bGqZRbf8za9gUnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367520; c=relaxed/simple;
	bh=p0tuB29l43UnDFrU7x82XJkVCW1guFDbJyCfkc+L5jc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BYA4Vldx0yT0VHVkTYBoUy2aNBXhUuKv2yVekLyAMADh64nYHunNmTHLtuTdkb6E/xBBqiyLVrJMbug4UpIHZGp1l5tJpT243mlaWBMWtSwbxkhNlwoJjrc1JZ6s4TLy14vjfSuMBvcNnJi1gg6GiBR4wW3o9HuIzUZUL4COzrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D0oT0b38; arc=fail smtp.client-ip=40.107.14.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJOOB2T7qSUG22aHJVQ/G4vYrnoijIdqBL1AP/zj34efBlfcapbR6ZKHqRLofxadcYhKcN7thhNxxg0Qv5Y+beQYA1UVevLlVCKQKCY149RaDW/IPQWkb3XamomiMvfO+KL7JBHMRt5JQyT+/qDnxFAuUdkqWb9MWBJLYjW4b8mGhQBsE9iquoIzNhyBe2x5Tkvjb5hJnPG0RSOjK3QjMTYOAzQIP1yT8gCdpJ71NcDcojsEli0fzGiaow8dzun2yfPInBTQ3cCZemHsAByHa4YsrekScoAOvXEgZ8fvGHN0L4zJQ+dzyP1jrs0a7U/kVX6V58ED3wHlNXQEd503Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmManNmiFHxoJNh3InF3oqp5UBNN4qoYJhc8FHHjGNc=;
 b=hGbVHKR9PSjFL1RKQE9i5RmmpyfQAqfrsKdM8HHudIKOVrSFHJcMFSCATEkRLXHkw4bNehMiX4N6M1kLCGO0qJKGw9cueIN59BwqE/orfOVajReMs8urIpWfxAnyMNCiCzjVEGt1FJOxvAyHtg5BvfZLCwmK8kXoqHhAephk71n3BxkFhAt62v1NdqjeuEonsgmzf3mdegxGGDeMx6Eu6nwnYW9nYgFgnm+pDddiW2haRMB6KX+5I1wfsfjlAEELXlmDDrhfTTSnvOP/6nqHfyejxR8GGMIUDAn3XJd+feBd2ZmNy7UXzbvEuNOLwGP4ms3IIeULBbUXyLGg7WhhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmManNmiFHxoJNh3InF3oqp5UBNN4qoYJhc8FHHjGNc=;
 b=D0oT0b38kHGOIraaiwPz8x1Nu3PDQq6ECRO4ALo5plqZ9ulF/VxnEF4mFPZCHHbdjdC19p4FhwWWjWZa8Ht1Z06oA8lfts+VcDaULAVV7SY1goVZeHoCjFet01ZqXLQ1bBHHihp4Vyr2RCztQwezx2mkNbSSnGQE8kNWg/9+JnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10108.eurprd04.prod.outlook.com (2603:10a6:150:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 17 Apr
 2024 15:25:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 15:25:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org
Cc: 20240409185416.2224609-1-Frank.Li@nxp.com,
	Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	krzk@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	pankaj.gupta@nxp.com,
	peng.fan@nxp.com,
	shengjiu.wang@nxp.com,
	shenwei.wang@nxp.com,
	vkoul@kernel.org,
	xu.yang_2@nxp.com
Subject: [PATCH v5 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from required
Date: Wed, 17 Apr 2024 11:24:56 -0400
Message-Id: <20240417152457.361340-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10108:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ede08e8-0818-464f-5d2d-08dc5ef294b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IWLtOg22N0cdUR7apiujaVdIKJYWaOKCsH0kzpSHPmPnVsOuMdd4P4urM7/MoLe2M+cUws+oGgSEBZpqxEJvbyNm4U1MSyGr4jIjTxstn2d8pRXgojAIzqN97E2maT8YdyYHzzjxjzl2tlX6q5WHjINc+fqrdcaOGkZ2uKlob3Jh63XJ/r76M4bLoxcw0glwQ3dMHn5YhaMaQ2Nik1byKf9ycnOUphu0dBMc2yCf3kpGbMXfeyA0H79kQS7b3z90oZo5/POMcmRG53rxWuYlZoZ5E5qgmNhWb61DBC5+8EpndibncW+Eu4SNOD9ee7eLcP6mP6tjGfYOZ3rciKRvwWxPj7gQQ06tHDlKOTelopwkQ4pTbF206mAqf1TxNMcD9ACRhpjwzMW8+mUbJYJbBsrL/MoZbgHvpS5nMfMEsGHERu8AiDmlIVc570eZsDKwH4yzoVvXOHeksc7mGBstGjH5+Ts2s+iyPFDMoULTVND0CEIy+GiRar6F4SD184blTRS0DNX7oyRKG5lAJPJtViv/XxVpnaBj7hjAJupUWKQoeD43K4qAPzoJbF2GZjFcK+nrBLQaOqeDhWpVbbdMo19AQt1k+RLsQ/I+UzheOJSKmZRaWxIZl4TPzxwhCn621XWGpoU0tD3bKLnYn0+lFc00q++3znl2d+GNKHqQ4mWts58SK7HQJQ2WaVE0tUTDvc5PgXSWnLrbxFlctg7f+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74o28CTUD9063mzuXKnhGzex63X6f60UeDoySJ+Wo/6BZ+QvCNT9qa12NWh/?=
 =?us-ascii?Q?SNQThSJYPWtAkHSte1xy5gVXHk9PW7pLw6R0ZD4jFX82xrrcP9XyiNqm+Qne?=
 =?us-ascii?Q?zAxWM30vcZUzo0nlEiBJ0e+uuOq3UibaP8Btz5W9L9FZMnzk+QGd6NpUEq90?=
 =?us-ascii?Q?S3cdjFhl0a5FpAmM20btyDMJ3grjSS2sBzm4RUqOK6aFY+K6+XYuwnU5/nyj?=
 =?us-ascii?Q?5YRV21LfrIKD9kjnKv15uQJuZZhJNGcT6Kv7HYvkZk1R1dk+ueW7+KuhsAAu?=
 =?us-ascii?Q?bEIAem1n3QvTjSzl/E/2rTpbllr1LO67CEYgqb/B7hLFhOWo3DO1jGCIrcxJ?=
 =?us-ascii?Q?EM6JPkh44/wBdXidTVDErfv/btm7p9mGuFx8YGPF3ZG7UQ+XTnPpL9jVZ3ty?=
 =?us-ascii?Q?de1fhDq1H/vS3dFH64vNCAufFLrcMJCZ5/ySJK+K4/FiQsE/39yTtpiEV5iu?=
 =?us-ascii?Q?vco+9PWaq0NiQHjXWLAFffRE7Vurp1Q0mkSea5FrWk9aDxxrYGX7ZFZB5848?=
 =?us-ascii?Q?w06uJ/JIc0+dq4n9GQ9h9bjANs8uqcOdp3UB0ehdfM570RW3kSoRistZiQ3u?=
 =?us-ascii?Q?vSFZmozx4PuztfYFrIhK/fTsBmZSdlal4C+8QhSGaI1ICRhpFWwCmPeJWW5z?=
 =?us-ascii?Q?urS9pc5UQtEYuSsdtrdk1HPRpref3ariUIuSJjBYgwidZES/nqlsBFdSKska?=
 =?us-ascii?Q?E5vzpdGnfFAoN4l1u0mzQ6RmFKQ3sR4mIP9Z8WQVRij3HPgWpxvk1g8anLLI?=
 =?us-ascii?Q?HCLBZDa2H4UDUT0KV3AyDNJIIZLg2h8UfIS7E8oKkFQK7i16kSi8SsHFpA76?=
 =?us-ascii?Q?Ej6wx2Ws5vzJO4L7hdgIuYK8MElGaMsTdBVrwgehK/ZQD/NFccsr9HB8soZG?=
 =?us-ascii?Q?gihwkSypj8QrRxnvTw3ABfEv3u7pK+ICCUefSQYM7taa9Tzt+mQhIXgl/iV3?=
 =?us-ascii?Q?1NaDw6Gad7kLFtP5367PvGAPRFSHoLIVLLTrMe2/NwS89Tld3xed2cqODk7c?=
 =?us-ascii?Q?d+3ostV2pq7cEjtPccRQ9oOQdPxdUAyKFuCE6IXwZUCs2m7vhqoTv3f7OW8w?=
 =?us-ascii?Q?FkV/eEPjmMTMmF3YtdOrdF+j57em6sLdlkSY2KdFfYVSzq9dvOvdyDcyPnQK?=
 =?us-ascii?Q?Fb9yGe1LiLPTNqMiVXRThJVHqB7PZA4aGLM18ccK7MgKKBKYriF2eUnIkS89?=
 =?us-ascii?Q?uKpMgc8RFUKVR6DKpwFpDxaw5F5LGE91fYkOm9HaGlMj58tsCX3BMabioEWp?=
 =?us-ascii?Q?HUK/sVTjhVnJb9/EUVxYJ1v3UnyZ2Q6c0Ze/ZUBy+agFRt/O8olnMU2+fG0a?=
 =?us-ascii?Q?DT15Fvh/GiQt/rx+I0ZXkoK3Lb64V7JgPy7TxaCJ+v9fhyfsY49+8FDn/4sA?=
 =?us-ascii?Q?BFSpd+iFQGRgtb3sl6S2DxWcqsTArTQolFz6FQzLA/6fF3K58BXnZDkoGHCC?=
 =?us-ascii?Q?t/Z16ceCsXJjj/GQYEihYK5YAqB8+11q+OKlv8hmWNpAKC0OMBF+vi8ALnSN?=
 =?us-ascii?Q?rzRRVD/5R8CGelywEDPmb+WjUmTzHKhac2e04r59i1hncGB6BsPw7iNyR54a?=
 =?us-ascii?Q?tBb0JGdnvaAWTXkXt8zGpG+nw8MKdTK+GJXS6cXR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ede08e8-0818-464f-5d2d-08dc5ef294b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 15:25:15.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KLiN4raznWejnHc5hq20qIEM6ZK6qG5Bhl5iK5sqB4aolHw7wqj/cdZp3ZmKrt7o4Wyg3hUNkWLMJklglhDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10108

fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
required and add 'if' block for other compatible string to keep the same
restrictions.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
      - none
    
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


