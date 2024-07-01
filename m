Return-Path: <dmaengine+bounces-2615-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25491E8FA
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 21:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12050284141
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2024 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994F16FF48;
	Mon,  1 Jul 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BaJV/ehs"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79816D9D4;
	Mon,  1 Jul 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863858; cv=fail; b=FWaGzX2XxhAdofnZhNx0WXu+om7RU8ozjpzbkVV6y5c22z/eM1kxHZSWvDPDODCcFdYmBxzUGhWljDvY+r8U9a8gsjbd0FLvcuMnROkg2ZaxkVW/Zfguu6LTcUoXwe6h6oB6hmYb52lIiAGNCJKQ022r7FbCcWLf55baLxXmWh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863858; c=relaxed/simple;
	bh=BkY3v8Mjqk0xAq4kX8yHzOxXCNRKHLN1VGKPdDDKWbo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kKij+9R9MuJiaQ5M/cpwEQR0TQo7U37SY1ylPLIYXIUfscfkAMmIEUAPsCl6K0oOwruk8ehzEYKWOnq66RO4gW+2BrOTsayrWJOKxg00r154gLQTRhybyy3QzNimKad+34kd4GKppZ/NPNf68sSQVoIY6TUp47LMgwqTxMIuDW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BaJV/ehs; arc=fail smtp.client-ip=40.107.249.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2k7juwPEkdorlBIJ24kCekwS1jJW3hIqwONLMFgFhJhcYi3r2HMJ7LuicRbGYTgCQ5Tw+1hWRzWZu57X8tTFcuajyzRiTbIadH5bBhZV430YjujrbCYo/9shsjK3dvkzHVEYzSsNEaEhyJdlqnQaG6OrrEGwPth1gNPkyZTr9vnKYRzpncJF2xL0KX0cM5tTX2HoZOPrbY9+7lZUuzAe3PUg9LuUyJQVgmAg9kyZSLkZA6C9dRPq88CNGCVduKdt9TPdVIjLwXuZr8393tPRdgJ9r5VBiQYjMKPktTrIR16tzyE78JS+HV+7RHFHWcU/P2jwGOdY86KT5NOIorWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmU2p1BJYQXbep9eLAXy/pkLHbg3WzQEoEMDJamsuLA=;
 b=ZdxyTe9J5PGuLRL1WBi7yM5NcZ8BuPB7xxstoIr2tv8fHy1dJcG7wV2DqIMAxQCW2PpMkEcXJqRYpo3fG9P4DQk0bVTzi8CzzrhXbhaOpUEighR0tU1+u8iXF1qYuzQSkbF3pR3ss7Hb9QzAHyryf9O8Y4r0kL+m7VH0/AVrz7GH3bE7QnIxC7ULVKVz7G4hfVrqsyKnirLLeZZ8Xde5uY1SC8V4pylNq5IHrUJKfz9p9HDGurakxgsC3bRLIQLhfUTkex0MrLQi2bnUzrCGGNMFSZXwuLi7n5eK+BqpncyD+fV00TiLSvb9FrTjFDmjaAjec/KXXJcpAhrN5VEv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmU2p1BJYQXbep9eLAXy/pkLHbg3WzQEoEMDJamsuLA=;
 b=BaJV/ehsVoApmy+Wol4Ne0SDCfSQ2EZtEPoSyKl4AFvlojG0xgnaIu3tfBshbqIjSDe1bCv/tEb7bfg9m2UUoz2J7dHnxxnWz/7GQxdhdaZ+7kPdPX5Kx/S3aSrvtd6zbuMv+cYkptUQ1gyUOrvIV1e6pdfNw3g0Qw8tGWvVNL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 19:57:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 19:57:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: fsl-qdma: fix interrupts 'if' check logic
Date: Mon,  1 Jul 2024 15:57:16 -0400
Message-Id: <20240701195717.1843041-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 9718d037-80af-4cea-e58b-08dc9a080c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kh9Yd4HSbjHAwnhmeBomeLExxwRJP7U7c3WHiIiOOfxzpCtPqcx9bFnOzj9r?=
 =?us-ascii?Q?WDAakj40VpoLxfCOQlG83aSFxsuVL/QCYl0FeZrK3mnYCzDp4ILzR6bGrlIv?=
 =?us-ascii?Q?Fu6cQYk63XhNRgfEy/CwyCx5QJF9IT+Or9KtBGVvZ/Qeb08oRoERnXfBnKFz?=
 =?us-ascii?Q?XzBE9vKVOOIbXIGykgR3aEYGLO6Bv8dS21ZnhacV9r56/XabR8Pj4w3CMmrj?=
 =?us-ascii?Q?hCptRKKMsqIc2pk+RTeivNMzhZeHewc5tN7HZ9sNQ7NQM/uKvM1c5OtCRlpI?=
 =?us-ascii?Q?AjVTOT2assa3vM4AE7++3kKPbctKS9G4R/iwHDMCMh/NNayYVCwjOqiPflR7?=
 =?us-ascii?Q?cAs//0gqjf5hFOms0+ru0jVEdGY5q51kJStnX/3YRJ3PCx036Q5aahGsmm88?=
 =?us-ascii?Q?UKswuUT+n6dUdC9IuYJh1tTzhjhZGoaQcOww8Bdu1/BwlLmFKSizwdOBsIHm?=
 =?us-ascii?Q?Nlol+VNAgApiWf64JXIOGzMIINVSQXZF/hMignl66wI7OGMZ5gpxHRsq0udM?=
 =?us-ascii?Q?4AR3U2AqgupvPhp8RsXVLr0IqzWWKGjxV33sw3XpgULbBVBcqjGW/EejpgXW?=
 =?us-ascii?Q?7thQ9qjx6LDGt2Wou1kmZA7uGcbWr9Q8fxgQQTIDqgd3INXwm16XbJ42btcG?=
 =?us-ascii?Q?uXWKBAQWtoNtkqDbgVOBDE9nSUPPR09wT3ryYkQMWkA4fvSPkjykGQWhir2Y?=
 =?us-ascii?Q?WLaxldcZpdEDG034ch1SJQtGBJyXENZenROdbO5mPmmLW6ngvmgCTB7CvClT?=
 =?us-ascii?Q?qoKILm2MOCgxkUco0+IZ02d+RrUhnK9onNxGzhO1Nrybt/v47fDtgFyjSY4K?=
 =?us-ascii?Q?vQaaUX/T5IgsNdKNru5i5zWQeUQ1mnS6OdlDXyZYZ+ABtNWfUetLw96sS7hm?=
 =?us-ascii?Q?ACt90lo213572Y2XEdDfZ115Tg8+WbC/agag2hsjFPUby5ys9jv9OQgp4RRP?=
 =?us-ascii?Q?6SfjauyO4QZNj/ndsc2NZjmugeMASVquAbgm+ao7+Tk7aJUXAfD5bbSp2VQs?=
 =?us-ascii?Q?j4XgCergdYYLBxV/ikyB8QyYCiYVnRuE14gDiubQAaTxK9BfUbCgQ3v8gYyu?=
 =?us-ascii?Q?/rHmhUnEhR0F5wiMoW9wVLyKnsLfUW129PUma78Rjl64k/4qFQYu9gBXIkjA?=
 =?us-ascii?Q?7lffs+U0Cz/a5kF4mNhn5rM5YMRg61iiKTF/+4n6rIssMfHFrBJBjiiS+w4Y?=
 =?us-ascii?Q?Nw2vFdqhTwqqErLoxuB/yeLOsXhJdqOuWZ/0TBUeVsfgA9gsmPcHrWh+/2yr?=
 =?us-ascii?Q?BJqVrvClGoTi8L9mg40liKEH4BM1rp+rb0j7dcTok58jiNwIDle8vFkCDerL?=
 =?us-ascii?Q?jA+UMj8Gle49S0yjnUAbsRtxUA2FGQYNuOggnEiJxDGA53JbOl7fxAqQe+Qy?=
 =?us-ascii?Q?NMSuoez9nu3/UogBsW19aM0qjH3C0QREqb1x3Ez3/RxmGwTjMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GSKQTRGsNuupKnFimOqUDCEyQ+azxVtgOD9Kk0/nYiAV9jw0MIl1NaRdO3Io?=
 =?us-ascii?Q?X50GAHyM7HKFwzY14geGjWC37kT3cprZ3BWRTcK7sp5ohnu6mT9hjioOaDxo?=
 =?us-ascii?Q?adMvUlSw5fQJEMWsKaHb4aylae3zbFQehsJE+CmLXyqRpqaq+2L5mtX3lwjX?=
 =?us-ascii?Q?TLzscVuNpY1DubHMpIDba7eIkjBbBT+EEyHcZ/4EaizftyxdH0y3tS4LJbxY?=
 =?us-ascii?Q?dIqTEGptlcJ6r4iG9FxfJnhjbGnJTMikUlPzZJjnltkZhUmaQSrPTfDrbRiY?=
 =?us-ascii?Q?L8VmWeyleZL5yN46k+RyHvA7/680S8DY4b8Mib8l+pqIl/Pdu53Y04QUsb2Z?=
 =?us-ascii?Q?4ROAw9YIQlCRkxMuczDa6M79sSjtb+XwqI25ye23TcRrM1pKtEWUGkkh46BX?=
 =?us-ascii?Q?9UkQPLB5JLdQ97aNnrDLTYXypAXJdiioQyOylP/Ru1b7Hb7kvuH0nH8I22W5?=
 =?us-ascii?Q?EAf1BHDpAPb/WKCTMMFxFYycDdrRbLXoNnIKX/qlaCch0BOm33ZDbjFBhweT?=
 =?us-ascii?Q?CD/82bh46kQilIaN9qWe6YW3zHzEfkaSCEe0MavmOxETo5UJWqSRptecoHPC?=
 =?us-ascii?Q?BEIiKEa/DsybSy2449Sqa5n4bT1pxm/7kq1zfKHBGHd9CvzYN58EHm/uZr06?=
 =?us-ascii?Q?h2HqdNvGj6W5hpww8VP21+XorehvBeE6lUSavO6NrN1iO03InlkVQY8GN1yU?=
 =?us-ascii?Q?h5nF50tohawwfV6dhW36Bp2Kxxbavf5U+Z4SLlxKYRKCXdHm5G2X2ONHoRVl?=
 =?us-ascii?Q?1az06XSvkH9kWwlDMt8omF09bKP0n29zo8/+bL9cujtzftle/v8bLlV/tYmD?=
 =?us-ascii?Q?tl5YGO4NRd5NmuMIquZTElXOadyvNOqEfxlv7QkYQVjVO88VrDK31PbWFw7J?=
 =?us-ascii?Q?Ktg226EYvxsPYmaeAazl8T3WA9QzdPn3+FKkAdPsHFAzzxwD2/+3bccD0fPQ?=
 =?us-ascii?Q?ljv5F7mq+iw5lUaor5O8s+Shj3VWRGsmqOT3xBMhht8CTBbR/886FfBRqOkO?=
 =?us-ascii?Q?lkZkGSxT4LSBCEdxHv+Iu1M+XX2PeGgzOYyfa/vRm237EslbOXydJEUi9TWe?=
 =?us-ascii?Q?ctIqhVQ+L/PPqy3wHPDdat0Hpcc0mUZpQHeJdcXUq4yVAtpJhmZ5PfGNBzfJ?=
 =?us-ascii?Q?qrCDv9K+7l4n/DgKx/tHmPyW52rGo7i4ZxlmLfBANyfAG6ETd0g+kffMnJ6X?=
 =?us-ascii?Q?GV3Ykk+U+aD/ed+MoGAU4qTUTvhQvpvYbC9bvR+r9LyBmy81nnze+GFIGIgL?=
 =?us-ascii?Q?ybQf+SiExMFLA3V3PdN/1dVV2PS9Az6p8isM8YNElC88iyopB2S4Yi+BPIem?=
 =?us-ascii?Q?z+9mlmWKnql//sMmAitAGTs4dvt7a9LMwWVaQ/T1mPLo3aP1x+Ep9W/3wU53?=
 =?us-ascii?Q?eNu1q6FBgxoeO3Rw6/MB8PiqKRSSGYQbDlH12kv7TDQxHsoWY+QiNf1SG6OD?=
 =?us-ascii?Q?E55k+ZuaN2V8l1hEHUyl5GqnDZObkMAhUuRqrcEonQlyBPExT069cXFT/wZj?=
 =?us-ascii?Q?8pUbflK1PKU9YT8qzr4Ss/vwzJ2K43SFuLEoQk/1IwyJ8Z1tnPCqrCqpRrP0?=
 =?us-ascii?Q?/lzIl81SFvcUhYcnHVc7HDl/p0umDikyWAXdDkFS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9718d037-80af-4cea-e58b-08dc9a080c8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 19:57:34.2289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnWEAJsMtNni7CgGWrhTnlAFcO3tn4Ig4Dgs53n69jJ3UzwxceiiHAfSuyshqA8wG23UrdoOw4cQb5m4juH0Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

All compatible string include 'fsl,ls1021a-qdma'. Previous if check are
always true.

if:
  properties:
    compatible:
      contains:
       enum:
         - fsl,ls1021a-qdma

Change to check other compatible strings to get correct logic and fix
below CHECK_DTB warnings.

arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dtb:
dma-controller@8380000: interrupts: [[0, 43, 4], [0, 251, 4], [0, 252, 4], [0, 253, 4], [0, 254, 4]] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Change  maxItems: 5 to minItems: 5. because maxItems: 5 already restrict
at top

interrupts:
    minItems: 2
    maxItems: 5
---
 Documentation/devicetree/bindings/dma/fsl-qdma.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
index 25e410a149fce..9401b1f6300d4 100644
--- a/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl-qdma.yaml
@@ -92,8 +92,16 @@ allOf:
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


