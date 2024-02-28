Return-Path: <dmaengine+bounces-1165-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7415286B9D2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 22:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA351F22D85
	for <lists+dmaengine@lfdr.de>; Wed, 28 Feb 2024 21:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810515E06C;
	Wed, 28 Feb 2024 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qKDqZw58"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32C86250;
	Wed, 28 Feb 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155608; cv=fail; b=VBW5ZP313+IOF+hlgxJp9c/D++J8/u/eZArcOZ4PphnPYrldy79uEaMFXQ32O2pyVGqecxwAq/C/1mX/msjI+AkzveL61Z3uEEm2NJuM33YpV670dttJkp5GuLmCeQJz4SRXwqE1Oq1dTso4ieZSgvYIZWN8LnGPg9V6yvtY6fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155608; c=relaxed/simple;
	bh=dtMfYTrhtUQx9nbBFLXtv00BoeeLbdXlJlS9tiLQvjc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=maWkHn8NPxH+mC/YizdWpojY/pvHovz88WvM6jJeD7q2BKEnpANkHE/VtGRza7vid25TnikDJ0P5WMNZfTv0STn883wEgxvOpZL81JImBJo7Y0PAs3VmALWB00+8aMVDTHYsYmwAtPw7W9pljbh0fYgXQUuL+lacbtgQZfvGfJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qKDqZw58; arc=fail smtp.client-ip=40.107.15.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd/h5+A4NbUaIa/nfhm+2pjzc/K3P/HPIVlP0no+MGXHCouzKWJIqFUmfBj5ywaIF7QTHZrbY+wWgPKh6ZJWxN+LZgIK05DC0Y3e0SeetSGxpd7lLmT5p4WmAotxnnTiFBZO7hAdioYv+fPWHqYH1vsKK9ryZ0sAfQG2XdWryHH1lGtzCKxhBvYHaDFChN/nvdaVwhP+P3pukPdWubCMQBFej2YbDnhcb6XVbInwDGLCtpg63Lxt2ivA+M4sodQN+PRQZ7LZxWRsFYYiNmX5E8BqCQsOcCM0XykaJxeEwAOp/++PCG1vH88vNWv84Sza7Y3uokHmq1Tc1C0ssY/yrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd3fLmc8l9wBg5YQWoK5xWb4WdWE90YNPQuPuIiGehA=;
 b=cCZOgSdd7JW6mtkwctjX4wmLnBRNg8qwr2PaB6yMgUpthIgIOVYBdLUPegxjlYnQMJataYTIO4JA5y7oD9O9IWAYHc0iYNFz1EDRN0HFqErw1jbJ7TQq2LIQ1ugtG4yFJAZDZOD7Vt6ORxza398YT0jZOYiIhLmI5jK4HiPbs9NjfEsv4qXOyhfwik/3h5oGgo5ReXwmd9CSXsXo1i1odhgeQ/CuhuTSC62hombtI59LE1Z09RtZTyNLhB2yYecyydIcFyDNQCPaZVl3zt+Dq6DqYP+33F7A2JJS8ThPRqbkI9muUlxXS3hkn85uKVhHJfVgzDk8w82LS8iDVg5cmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd3fLmc8l9wBg5YQWoK5xWb4WdWE90YNPQuPuIiGehA=;
 b=qKDqZw58viaMTx8cZpWB2L9Tg8qd36fWZSh7aLGvxwYcYxkJw7K8RuimqKkq+VAlSckVLwVolrfLpIx9vjO0TOk376xNv1HqvLIFazUCCeWpFUP+fw38Xzg4P3JcN02XncRnyTVXDq4rTKdOGd75dPWPq7ijZB+4JeBrRVpKyUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 21:26:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 21:26:43 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev (open list:FREESCALE eDMA DRIVER),
	dmaengine@vger.kernel.org (open list:FREESCALE eDMA DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-bindings: dma: fsl-edma: remove 'clocks' from required
Date: Wed, 28 Feb 2024 16:26:25 -0500
Message-Id: <20240228212627.629608-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e1ff45-e03a-4936-3f0f-08dc38a3f58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/wUw2LoayKZO11v+JcQLqqfXTrilPEyCnzYXqfPWZ3y32av5/9z922gDTvAaNHwMwO64ELtZES0+Y2ShmhrAFzcs8SdfMzFuNY2iAsClERtDIBx2d5N9cWhOqJEoGcNbw2DqKXxOwKoFtPk9oeiPaCL51yc9DLXDip8nBKg3NlVJLqOYPpRjGq7nN3EcB4CtF5fi5DqQyeuStz/Q9qvsrB5XmxlOYYfI4Vaobas9q5bgI1Qju8OnGutEo6u+8M3xo/DphufkyDMdS6yJO6lTfk4RNQoU/PZNmJbeWzvo33hU8fIO8mqpL8RKwEKWBADs35EfuteXbIYJc2Z6egp3aYvzf2TQfN3qc8wpHqhAQPaenApBvFmV3gcUqgcRYklefcuKy2fFTrekwcS8JXCwLk9Nz6i50m4tfKGADsR5W5YmguRxzJv/JGvVe2qhiCTZpByaGzDKFbvfxPTuAVZ4irVRmpnrRH0xiAm0y0Hj/ee3APMHukqqjueOMW2dgrMkU0sz6Qqm37NyuRZhv/Y4qNqrPHO5kFMrIDmBJtDycG4ChyNuHx2xzc/KpqLXUKQiUPKEqtBKxeGS8nhnl+T7UtmDwwQB6m7GJ95sjV3IZ5hSBcECUXhNLO2l+sWZ7x7w5RM02+ww0NckRGOH1GVAQiic66NfdTdA//eukZMY3n3ZuFYzi5NzCF56hqpnDZ/0b7qLUx8oksQiU7R20vlj7QPE2wXk1HhiNzglGRLnX84=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ULumnA5kdS/ZBTMFhouhxyyvIzhJiNhr7wG/ECZyzV8PchGRE8M6JOqVzkJ?=
 =?us-ascii?Q?hPqDAKHt/eKNYqFt/J6IYCg2bSEwdR0PDP7nYAMYKhQqXIeEieWsSSCxW6qs?=
 =?us-ascii?Q?RCNmZIMI53iN8f31VmfRZOmrxRwaOlZzJq+7N01mpIG02o/662fccew9BB0i?=
 =?us-ascii?Q?oZhW8QepEZoGchjRUj7apHMCOeCWUmE/evWU9XY/dIsa2r5jIT2zUd+sqZqI?=
 =?us-ascii?Q?qYaqC8Ila9QqXO/leeTNxVVAUEqf9lRxqSgJ4BEP55m/HmcSAWaCXoCpShaG?=
 =?us-ascii?Q?20S72+33njI6HmX3WvDQp8SJw93iBiEoZeBOwaktccsojRg12j4NoI4G3u0T?=
 =?us-ascii?Q?RHQWpSXpLAkunSr8q53Auxl2KiKjQl4eJ7087Ug2QC4D/pWzV2SfBvj1cRus?=
 =?us-ascii?Q?Brd6DRC4Ke5YeeZrHMbx7yLcqWbL4LXSuEC82AJW45KxC3HV+tSM7eQNgJQ2?=
 =?us-ascii?Q?29c13MvboqGUN5xJPvmwohNQ0fS0a+8hqnnnFn4wi4iVtFPvrsifO6Tvncou?=
 =?us-ascii?Q?VfoTYdMCL1GZ10hbFq7YxWL2DgKKYtRGXl3Z3V2Af78rPVmMx5uDNvxrTQ8Z?=
 =?us-ascii?Q?fZoICwtJBZTCb/WGAdlp9Ny8Lnu5Loaq8o/Fip6ctKGnbBkaBVsdMftJBb7k?=
 =?us-ascii?Q?m9kAghERNinw5+v8yxZZSYht5mzN6uHM0lBlrrqlA0zjPOW+QuzzV8C80m/4?=
 =?us-ascii?Q?znPVnoIoymErAFhIuo20gWVlM14STWcUbso3PkTxVvRr0do3hUYt+6kNF8eR?=
 =?us-ascii?Q?2PrAgGQ6lqfp9zTzWMyNE+bC/9lHilHS31IYkvJOXDfD+7r12oI+MDTtvJ80?=
 =?us-ascii?Q?Bel2+5TOFOqmoomeplmEQU30SFmeGwyIGv625ZJDprVb9IvFgzEz2ABPbtHG?=
 =?us-ascii?Q?/+AYiGrINbDivmfDtFlTN12FI2kTXu0SwmI/HMJnSxJCQFF5RD+yKm5NWStR?=
 =?us-ascii?Q?jJ1Y4hQ4SJYho90TQ31AZ5Iu2Znin+I8G1mlvscXkPwBPvP7oUhh+zqv4Hg6?=
 =?us-ascii?Q?h+f5TkWHSZKvhDWzgqLcESXqwyz6/ULCqFusVQpdFf4UCY0WZW4lHO5mcbjB?=
 =?us-ascii?Q?e2GVTbKhdhz7QAynUYXMkOQYOE5mBUS4jc4+7P8X3PAkMOaKsvaj+Euetgps?=
 =?us-ascii?Q?NcCgMiVXXzLLYXemOEG+Gg+fJmFtLz56b3gmCf2ai/S3dF/Rag/fyL/6/xX7?=
 =?us-ascii?Q?depG/DHX+pRmUTCjB936ACekJvI0LGDOuxqCwqb1pw6WvPRFcRIux6RPKvWf?=
 =?us-ascii?Q?+D2uC9WgZW1z6AfZsIXa6awCuxU+hqKRJXZGlu4rlUju8mpv6eO4bjt2XuBP?=
 =?us-ascii?Q?vAk/+1y9U1AN4MlNfhXvCwgWaAy3zogKjQiIf7G738kO+GhkMjGGV1nPVD4A?=
 =?us-ascii?Q?tr4gzmh68O7TdsM0lllvwIi7HgioVJc3OwrBlMqerD2MaB/M0m3oyi+dHmWE?=
 =?us-ascii?Q?MHSXWMaFHHWPTKIbH7UKWzDeCIGqUqIOm0t0UXD5VbQsaDyZ0V+lIPBq0bpt?=
 =?us-ascii?Q?1UP+sOYBJLepl8nqiNdGwy2MfYIA9zPmM7vIbd6aNvvD7R+PLY7y/vXDVRqs?=
 =?us-ascii?Q?RIf9atcfJwbDCKPAlGI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e1ff45-e03a-4936-3f0f-08dc38a3f58d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:26:43.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBHAuvZjDDWkrn9PRFo/TLxiViym7zmIdTrPJ2lkjtFGshJZYteaSCuYS9SVHbgGFe2ycf66vdhPXqhlR/u6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435

fsl,imx8qm-adma and fsl,imx8qm-edma don't require 'clocks'. Remove it from
required and add 'if' block for other compatible string to keep the same
restrictions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml        | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index aa51d278cb67b..cf0aa8e6b9ec3 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -70,7 +70,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
   - dma-channels
 
 allOf:
@@ -151,6 +150,21 @@ allOf:
         dma-channels:
           const: 32
 
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
+              - fsl,ls1028a-edma
+    then:
+      required:
+        - clocks
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


