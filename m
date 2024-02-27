Return-Path: <dmaengine+bounces-1138-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAC2869DB7
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A8CB2EF93
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17C114F992;
	Tue, 27 Feb 2024 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B7RgPyPB"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1314F96B;
	Tue, 27 Feb 2024 17:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054548; cv=fail; b=uurc8rd11ln+nVkpq7soOOnwdvoI+0MTXnmxJ/KDZa9p1ST6jPPqyZfIzfqsyObIaVZ95TTbXgCpGhoPCvhnVKwbx/1iuS6Y3NlUmoM1sB4aoloup7eTFoQKjN/Lt7d83MUFNTqBDQ/+tFidNavZTM3b2QlQcZqsbW/Fhwfc1ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054548; c=relaxed/simple;
	bh=zLHJgKGxu9Dd0LQIch4VyD83KuBDmBwhI/g6Gh9w5ZY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JupcE+WQLGyQAH0QcM32ZG2R6saGWC5s8Oi0FkmAP7UVIzFOq1FTbV4yhrVCbM/fn8EP52tiscdiBwWdYUh/JmPAbweZ8A0ynAeAzRReGJ3fImicFTiO+iCn5ePxJRLU9/6rFlZ2Iju8CiJD1GEUiuIydxgqtOStdC9XQK5Gx5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B7RgPyPB; arc=fail smtp.client-ip=40.107.6.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QelHv5rBPil1bvz+7TL9gGr9XoDVbz/94Z+qrXTFIeAiFCpQgLCdCzekcUVt90h+gtqqVPCMZ+o5mIOTdqPIcD5Hwwc1w40l30NMmq9sM68FY5lDXuYMp2WN1iux70V4ALazXKe3DHk6eO4h15ceajvcHrZun+25VUFGw08IfAttZe8o1U1MK4zyL9CLxAph1p5jDAoFhQwwE052pse+yhbcuDqVrYLu2aR0M/5HVJbXte1DKKtDtWEMOu0dNu/WiF0kh64KnbmndiRs0G0E2kBD6D2Ru9i0Xgcm7jOc2kddbhZv4NhAei29ky8cSb5HJbjAEv7rvzpLuDJXhZP+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Oienn+MSbSrCphiXgPWUGnaou44oVPo8joKzJ6z/6s=;
 b=Oy1YeEZuIupQRJSVQ9e4aNJMqJzwaLDqVcTi+doBzAxEl5RQQCtOPj621qNfmvV+XDaB5WR9JAjLY84IRaMobwTSQSGU8IKGEGzsuWkeJ+cCiVEO5ejXLxaJohg3wMJWMxfiEX77BQL+e9RFTGLCVtXJ3Ge+IbuUc+U0vXXvgDEMjBTK/lHFRUr0z8kYngZX83E0j0zhqMhY+v/T5QATehwmxC70hP5a1QDtaUjHkYl7hRvbsU91vnX51wld1LfALvNx7yea6111+CIsTWujSnve+l6k6tbZsWQTJ9TXVnYIcQwTjIAD9IzWRx1+QA5e/Db1Xsx5sLc8qGdcfMpBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Oienn+MSbSrCphiXgPWUGnaou44oVPo8joKzJ6z/6s=;
 b=B7RgPyPBVuplSbvRtP/Dx26M1wD/Wz/TAu9BRTLL/xERZ68bC1v3UsPU+1uAPQeqLFgX3L/7vPqoLH9Es9aMv5RdKv5PqSkXii7xQQBPXhovfE3eNIIfuepZ7+asQfnWcaRqE/w+xSIr6A2yDHEGfMzPhLT9n409mTaJ/AwfUV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 17:22:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 17:22:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 12:21:56 -0500
Subject: [PATCH 4/5] dt-bindings: fsl-dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-8ulp_edma-v1-4-7fcfe1e265c2@nxp.com>
References: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
In-Reply-To: <20240227-8ulp_edma-v1-0-7fcfe1e265c2@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709054529; l=1639;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/ayZNWifeByzbocFCHfeq4diylFnWb7v4U7hUf6Aoow=;
 b=BeBV2TBdB/ZN36u9SjL4QlUf3wgv1+9fwfA4+f2hbGk9Xly2LOj6pcKIus5oB+mr6C/TMdJ3n
 SUsy3I/RpASDaKDXnoBLfToJA+r4u7yECksv4xgkfqhfEnnevyL+FiZ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a46e96-0c99-401e-df5c-08dc37b8a942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LltPaoaGE8mSb7usfLc2SdR8ynul/a7yH+zaNk9+fAC845NXUPOUkGogr92qn9BONK9Kvp1ZTXPQe6TCkiyDDlK0PHIFEBTrqSsMq8/csnMogp3gGlDMNRsjE78RgLvDXvEoTGBabwWJBpDBjO+m1VgumkYVrh3pL/V55ZFiZRW/EPkPDSn8tSnPO7UOfsu7uUpVX3XImuJ0mUKKTEAgI6I3T/PpdQtikjgDgndRhC+Yr9gTTMv0RpQ66jCzT8Q+ix5oKwTFO/3tVJzdqewUeJa3hQMmNeYsCOxbEGg6dthFEeHnmPIRL7oTrqd9wmZEcfdSKGecmNgcEYq+0cdMbLN49Ytzzvi2pwaAc4xfVjCvn+qm9VyA5pzfr2ZnpmF2xp2e2+/H0pYPqYKtb542As/14c5MfbbZtsFhH5IvhB2aqJNAnau8TSGMtlfyS+oCED1Keqr0++VwQ63sR90f8l8QaN9c5spTG4nakObGsPX8rsQih/Mbiiv9KCehbhUpphYYZafIpjUPPOtXqE9eKVycNeTNFerU8Ya9+CAVIvQLl0MWNicqEl7F2kai3B9npF+97ylQI4NVwqH95I6SE7JlPhs6i4jCSz1R08ZNAgviMjWLIzQF2BQ07t1dVMHTf1N+/GK6/9xtMjeMnltoQ+LZl26mHIxMxjeKby+IF+Rsis6JCqkyKpA+o11OihZwBcZPg3C9BIczgqbKHAeHyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGpJYzFRQnc5aldrWmlBQmVpOU9DZzMzV1pjU3BDYkFZRUNKTGtWS3ZhV2ZX?=
 =?utf-8?B?SGE4anBxRzd0UDBTSHZ5YVBRTVZvVkhaNHppR3QwRmI3NkRPUkY0QUUwSTlw?=
 =?utf-8?B?cVk1aEdPV3ZFdnVDRjVDenl3RnlmTWxEK2VETkdFQVJ4YmExK2tuWXZiQ0Z2?=
 =?utf-8?B?WUZmMjg2T0ZDV0lWbGd0NmtvSTBBbi9XY3doaEI1WGIrRjZxeEhlK1ZBZG1z?=
 =?utf-8?B?MWxpcVplRytQanR4bVBmbWJZckZJOEFZcWI0Q2RTR0tKVnhWb1JGcnI4ZFhJ?=
 =?utf-8?B?WDg0RkRRZmZXZlA3Mm5zQ2EveExodDZ6RWNTVURpRHY5cUtaTm9QV1ZCWjVl?=
 =?utf-8?B?WmZxU0phMzFhZG5FUVN1VStzUjVLcTkxV3NXWUFXTnF3R0VId2RUQzJMcFJD?=
 =?utf-8?B?M3l0djR4SWNOQ2xDeUtzQ05BS3RUVmRQNzZNQUxjcDhSanU5aC9NeTJ2NXBw?=
 =?utf-8?B?bys1OVRFVFNzSHQxbDNGUHJ1T2dIZEUreGUyTUJaZlArWVpra09HMW5sSG1Q?=
 =?utf-8?B?VWo3QmNIeXRyZmpJQ1lrTklaNEtBWmtjejhuZzlIdzUvUkR0UnM0Kzc3SHlR?=
 =?utf-8?B?cUtQSklodlVWa3ZVYTM0ZTFYSXRuWUpKTEx1Y3BqQTQ2MXZodmtoOThoV2pG?=
 =?utf-8?B?Rm53SHB1MUQ0Q0pEZEFoUkFMNkJXOHQrUXFNY0JTSXRwZTR3U0NFMVhoNVJE?=
 =?utf-8?B?ZzBCdzMxZ1dVYVhneTNWQzVsMkV2NHNxbWJzdW1LK3NlVWRtQXJJRkJpTHVO?=
 =?utf-8?B?c2tDOURKbTNmckpBenR2dmxWYjd2UHZxR0NPT1NKWk1vazk5WkVyKzk1QTgz?=
 =?utf-8?B?eExGUzFpb2hXMkRhV0E4WElNTVBDZzNwNFBpZENBQUw3NXBDamJkL2lYU241?=
 =?utf-8?B?T0NEd1pSMVpndWJDdCt6Q1ZSYVRVN1RWMkFoYTE3dWlpbW12OGVuazhvcHNo?=
 =?utf-8?B?cTBwejdncCtDalRZRDF1ZlVqV1ZDR1FWOGdnQXdWL0wwK1NzOHJERDV3U1ky?=
 =?utf-8?B?TnB3Qk10ejhOWUZVYnBWU2Y3c0VmQmh2d05tWnJ6NkRhSE05YlJsTVJsbnlk?=
 =?utf-8?B?bm1Ec3hKbUI0NzZueUZYL09rbytQZ3FQczRvYUtySmNvV0JRNjVhYTM1Sk0r?=
 =?utf-8?B?emFTcW5LTVlSWnVLdVFUVDRQNHpDTlQyL1lQTHZUSVVwN2V5UVQ1SEZEMFU3?=
 =?utf-8?B?WVVlT21pQXBhOHljQjRoTXhVdndyUDNsZkQ0ZXFDNy9mSXVQb3lPancrSVQv?=
 =?utf-8?B?VnNlOTB4RzVpSDQ5Mm5qL3FCRklwb3BHaHBYYTFrTDQzakdLOUJlNGhEMUN5?=
 =?utf-8?B?Y1RPdVhuZUdiVFJhRGEvNnlDNEgrMzV0YXQzcFdsQzk2OVFiaytiY210ci9w?=
 =?utf-8?B?Q3EvdW53dllmNU9MSytGUjNKYzNsS2dEUUR4aG1sMjF0b0YwVm01M3pQelN3?=
 =?utf-8?B?MzkzZ0pmaTZocU5XUFhVa3hySG00VmpNaHlTODZnRVVYb2VVWnRxcXZLa2ZC?=
 =?utf-8?B?V2dkTkFsbk82cEtuSkdKbXVCa1NsbTdtbHdFejV5RmxBWDVhbE02OXhIa1h1?=
 =?utf-8?B?ZzRKYkx0Z1I2UGZqQi9qOFBiRzVTbStwK2N1YnRSV3J2aVNYbEdrclFudEUz?=
 =?utf-8?B?YWNKN2NRREU4bFdEMm1xNmNpMHR5aHdXb2pSUFA0eUwxbnRZbHVYYjFTa2Nj?=
 =?utf-8?B?emNlZkplN2hwMUtWelplcTFLaWthVDd6S1hJd1NDMkNaQ0cra2tYdFhJa2ZF?=
 =?utf-8?B?QXZZUnF0SW95SVBLYWd4enNOTkV4MDIwdXZja1I1UENZVWE3bXcyK3BqbGxy?=
 =?utf-8?B?NUl1UzVaRXh6ZGxJZ3dGeldzVVd5NU1WV1ZCY0gyTFRzalF6bm9kNW1LSit5?=
 =?utf-8?B?clpRYkE0clNTVGtvSGlPalByczhncytlbDRJcVFSaUxuODFQQTllYm1Ock9a?=
 =?utf-8?B?ZTdFbWhOblNPb0c4VjVoNUlYNzJNUFZMdkVzWUFLZUlxd1RCczJMbjJJSy9o?=
 =?utf-8?B?R1o5WTJOOHV1MWc4cnNES2pZTUJsclVWTll5c2pCN3NsQ09UU1AzQnpFSk5x?=
 =?utf-8?B?WVNld0FmRUNZaWpSWURSWU54VlpZNCtmQnRIRzBpaUpQdVozWGVBVmwwb1Uz?=
 =?utf-8?Q?zH/w5MmU5hpAd7ao8PB8MHLfp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a46e96-0c99-401e-df5c-08dc37b8a942
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:22:23.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXlhquGBXFDyL4tQYr/93xst6EkVgfFgBRFuVgqMY9gkLvPI7ecuSo2sUaxklaWARbnXCPzgxTRgQ4AWy5TGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408

From: Joy Zou <joy.zou@nxp.com>

Add the compatible string 'fsl,imx8ulp-edma' to support the i.MX8ulp's
eDMA, and modify the clock number.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml          | 24 ++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index aa51d278cb67b..6c04303dbe453 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -23,6 +23,7 @@ properties:
           - fsl,imx7ulp-edma
           - fsl,imx8qm-adma
           - fsl,imx8qm-edma
+          - fsl,imx8ulp-edma
           - fsl,imx93-edma3
           - fsl,imx93-edma4
           - fsl,imx95-edma5
@@ -53,11 +54,11 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 33
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 33
 
   big-endian:
     description: |
@@ -151,6 +152,25 @@ allOf:
         dma-channels:
           const: 32
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8ulp-edma
+    then:
+      properties:
+        clock:
+          maxItems: 33
+        clock-names:
+          items:
+            - const: dma
+            - pattern: "^CH[0-31]-clk$"
+        interrupt-names: false
+        interrupts:
+          maxItems: 32
+        "#dma-cells":
+          const: 3
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1


