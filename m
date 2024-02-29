Return-Path: <dmaengine+bounces-1209-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70FA86D5CD
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 22:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4B928E9AB
	for <lists+dmaengine@lfdr.de>; Thu, 29 Feb 2024 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B47157AD9;
	Thu, 29 Feb 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tv5e32nb"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A6156D39;
	Thu, 29 Feb 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240350; cv=fail; b=q/SwXXPtF0sMtfSbPKn5AImKjbGtj810NGArF/Ln/+aLOj/IGVe5JvoIiarXzPG3Lm5OT79helM2MZsGNVpSUaQ9YxsRX9DFjjcpSAlO2OAY/WcFn5bo0YMaru9tn4WPqYW+Q6kCn3684LYiNvgBzAtT4Izl1E1LXjYoPcJvusk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240350; c=relaxed/simple;
	bh=umk7tiQl3nFvqCLcx+eoIhCPoTuTuXM5stO3RDtH2kI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K3VupOB0TvukovGVdPUy2ChyuE0Nugl+0ZiimmLX7tBqXMuVs+MjjK9MC2HSXBYcDlzS8Uq2xnk62Q6ZxmT+0c4B6DJS9+a5nf79jgYwboFi1MmaohTXwjlIgfn7uylnLJrhZ3jWttwdNXBFNMEES/EKQVN/u1K+4VS03eRv70o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tv5e32nb; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4ku0rE388/mlOfYzEnlOA10054geGmsFq1V8syvdT+KphTgTuCP6Gx+JcCTC+oOBFl7fpNYWX4/wOBS4kpUSiQUUbjac3ytHQcL6V0fIpDgbfAvCNtyX7qzlBedPjmJUXG9ORyRveInM8xKG58uiKPWdDrvyoRNV0EokmR3GpYb+8mz6kewWC1w0WWZjnWp+AVB2Yy+l9AOLCnnTeQmkC2IaXWF5SMtQ7ynn3GjfWqBUObnboa8ZE5bjANFf6qbcCsdKn4rhgZPFFVioj7Mre5j08LEZGsdL7QOjKe68oaXfius5u8Z6EZ1O1MF7pyex1hJkWWobkIfEf+Ab8qzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fkn+KGYliN63GmoL24vAX7pv+43UCQRk1NQj84R0U8g=;
 b=Ur9sk08EekBUljDSImrMcmEQl0kCNtKGx1rva5kBPqTclIV05TY8AQJS44UBe5UH7389Z9/XIUpz5+CN7+h+uyTjjSlc65WziQY4Z+eI47rLtjXY4jeo1KBSFQuQTvxXYna7L22roqM541EIfdnjyX8qjG0fumqu9GRp4VcuXhE0wLNcTXbLtbVr45eq2gVIUIkOO7CaQsHZ1234gRW2Ln9Ci67WZ0zQ1P866RVoEOGMh0L9cFyDXUoYkBezNEQXEnXCciA2BTuxwoIrRjesKQMT48zqOFKen0jEzxOOXFIQj7wgzaoJ/mfpGh9m0IknZJM9GHiFjAlqukBcJTG9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkn+KGYliN63GmoL24vAX7pv+43UCQRk1NQj84R0U8g=;
 b=Tv5e32nb7j25Hwhh2AhY4XefIU1HJ5JWSTQtgoNISfsV0nJ6I1s/06wslAvoLu7jf8HcCAkHrQ2zR/xYxfqUvwErF11+0fbl5tFndQBe6oZlyT6wjJYvIFTV/87Pe7KXAtbrKpjrDhOlugHk5i9mTflc6f40ResFxG3MhqWlk+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Thu, 29 Feb
 2024 20:59:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Thu, 29 Feb 2024
 20:59:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 29 Feb 2024 15:58:10 -0500
Subject: [PATCH v2 4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-8ulp_edma-v2-4-9d12f883c8f7@nxp.com>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
In-Reply-To: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709240333; l=2253;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=69rs8YqYZCymIbs+K13VMFKLlvI1eiJnh+HrTKSOoFc=;
 b=xX8N0++pYL1AEHJXDs2/OPlAg9/V9HhdlB4GUXLEtluiFLtWTSz6mGjpBTvwzJp9u/UrfFt3j
 WYbxfwISmPGAvbGKX3g4OGlJm2u/H3YujwGsNRdT04vdfu8pPiNGKBx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf0b413-f8e8-468b-9ee7-08dc396944f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jd4YuZRMp0P+0PZTR1xb0nauU+/u7aqMSNnM0/9rex9dfYCpkHpttQbgob8FxHt6Kkhe47+FGyxxdYd5zmpVTvyTa5x+rBEhJV+AwmzSaHbONabt3znzXc7Ku/CJ3ZbxPIeng1NGDH6pFB5f+tOPiyd0koGnXxGNEHaqLW3x9ZtD456UN4dMexcLxupYKMIfGvQjcx2TNn5WfdYPax90riI7ha6REnTjLOEk6reuzb947bRBUdeMPMHrWo6l9TZodr+bhtsAdiC4xHDRnWqi5z5cAiPXUPIejQMibyv1JL1f4VJTiugrHu8hGXooOHsh4l23xdlZ1rOwa7g2KWLyaBBZltFXuWTb8qai9rYQwL6fYY7m5lZ++Yj78uwCCxzBFwTNxakm3yXHikdjVfI1QN3yhd35T/MR4AvbWFmPCVLfMKCZnfy1mHIslXvsMJY7UE4bzrk9C2wGiUcQeb75D2wL5ZQ07HyYqu1NCyWt0AdbPrQ+51tiPONRUFyRrjw5M9tVqi4d5RlLPZ4VlpGifykkkh9jpDcfhvOg0+3vbSLUWP9xFmiDCnKaDpLYIkaxhnswn7dFT4sXgJWz/H9KEYCGBfLp/yHF07cuSM6rsLUXZwghjy5gsu9gDj6JFTBbvCg0AFnpZz+EqxdzMK1l6F9YEfTCl0SLwXM/YOEshK/VJhgdrOOy3PfYfJkDE5sADNaB0It+3dHEPsC9qNdMcGOkV9hkoiUZjBS5+Iv6yTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUp1ZHY2a09xUzFOMXQ5K2s1eXJwRUMyelN6UTM4ajNjQTcvdjh5dWxLQjFv?=
 =?utf-8?B?NC83UEdKOWJoSDdpN1pYeHBNcHJTbURSdklBK1FnUXUxMW8vRkR2TUlEeElP?=
 =?utf-8?B?ZjZ6U281akNua3JyNW9BYmlZZEdxNGoxSk55alU2cFA5MlJ3V1MvdjFaSE5z?=
 =?utf-8?B?Q044c1U2K3p0b1RjVFIvSTlIUjdLckZPeUVHUzhSVk1wT2pCalFzd3NRTDRD?=
 =?utf-8?B?N003YVk3WmJma0piRFluUTNzemFtaXQyZEJGTW1RTThtNGxwV1ZXWWpGZHls?=
 =?utf-8?B?M3RTQjZZTmVqKzJiMFVCNWZqdlBNMVAwaWw2Z25JMnFrRDJva3NuUWlNR1Vw?=
 =?utf-8?B?R0RZNHQ3YU9HOUl3Zk4yRFdDTzZ3N2FmRXQvNDRzWXBqYlRNZmRJYnQ5N1I5?=
 =?utf-8?B?ZDN3TThuTGRETEVDQ3Mwc1BlckxEUjFFMDJVK1JPM2tpcHJXRmFRdGJwT2Yz?=
 =?utf-8?B?azJuQXlXZDJNY3BLVEVuUXdiUExNNHoxRkNWbUNsMmpFYVZXRmV5MFZoLzFN?=
 =?utf-8?B?VDg3L2dQUXRIMTU3OEZUOG0yaHM4cTZVSnJLb01WSkk3SHZJWE5SNFlpWXRu?=
 =?utf-8?B?aDVqUHI4d1pNN1Z0MUgxbUJyU3VGcFgzak5lUFRCQi82cWVnTnNWRGsyU1dw?=
 =?utf-8?B?OUdicHF2bFhLcG0rMkR2Q2VxZmtZaUV5QVZrZEZldlV2YkQ5d3RlSXV0TGl2?=
 =?utf-8?B?UTdURkhOZjVOSEhWWU1seVdURmJBLzA1SHoxaU00cUU2WCswVDM3ODE4dmsz?=
 =?utf-8?B?dTdQcXoxbnJMVzVnM2MyK2JRYUdUbnNQQjBWRWZ1ZnJGOEFUdnF3d2hmcGtC?=
 =?utf-8?B?blBNOGNDcG85U3loQmtudEpjVmFQQy80c2c0YlVBTENvczFqaHNxUHFiOWpL?=
 =?utf-8?B?RXVLWDdsQlo3N1VJTnZZUVZ6WFl2VlpHcEorSlVJMzNiWlBET0xiRG13UkFh?=
 =?utf-8?B?V29peU5DTk9EKzJVSnpqelZyMDBtYmdYRkZVRGNjTGhrWjhOOFhub1FOSnR4?=
 =?utf-8?B?cklENUVMT1RHR1N2NUVTbGFxaGZMOEk5Ym1jNDBaQmhpaThrQmNQSWJZSFdo?=
 =?utf-8?B?cG5ZZElaVkVick55amJFQnZ2S3h0dEhmaEsxaXBCSWJlTWZpL09Pdm1rUUZa?=
 =?utf-8?B?SmMxYmxjSXpsaGZRMHZJOUxBenpSOTZ6MmE0b1FLUi9FMkNmVUt1M0RBSmZy?=
 =?utf-8?B?NnN6UXl3OXN3OHVjQ3lielh6UDJvS0ViSUtJNk8xWGwvZ1pDVHdrdFliMkwz?=
 =?utf-8?B?RUVMQVN2MVBGSjBhd2d3NUJNS2RybjZsYlI5Q3BaRTdpWmxQZk1OaThnem1Y?=
 =?utf-8?B?b2xUTnIrSWNBSkZiVnVjbERFVndGRk9FeWZKTm56TTNEV0twZlVLVE5sUjVh?=
 =?utf-8?B?dWhIdGhrYWJjRXJRbWNhVDBvYi9yS1RNZjhzTDlVTTB6ZzhjcDVXVG90bFgr?=
 =?utf-8?B?THQ3T0Qvd2JpdU9oZlNFQkpzSE9tbERCRXh5M3hmQlhQOG92Kzd4alUvS0xh?=
 =?utf-8?B?Y3ZJTVI2YUs2RW0yc1pJU1paVDRsdGs1Wk8weVVNa0U1bFJTOWU4NVpjMFBL?=
 =?utf-8?B?eXRxU1psSXFZYkhTd1dKME5NOFFENnZhNU5QcE0zWmptS1hPOGYydnZmTDdC?=
 =?utf-8?B?eEJxNWNGcWg3QjFyYzdZRWpFbStKZURtRVU3cms3NzVCVGVxNlpTYjE1czY4?=
 =?utf-8?B?NFNOWDllelB2VjBMUFNKalpFOFVFRG9nSTY5T1VWcUgrM3JRSWxaNmNndXlu?=
 =?utf-8?B?T0kxdU1TTHZlTjJSbFEvVE8xNUx1WVpzRzRrb01UVXVoSzA5MUJCN3NuWGtj?=
 =?utf-8?B?eTJON3JDT0RuamJzUDRQR0VJUlB2WEY1UFFJdUZHdnorcUJKVkF2RGM2VE8z?=
 =?utf-8?B?K3JSd1Y0UkZLSVlaS1JFN0lpcmxnR0ltcVZON1l5SmdmS2NPamNMUEVVbzli?=
 =?utf-8?B?RWJ6aTFDaTl6ZU4rMDZjbGhHT053SjJpNk5UbjRzU2FUNXVTMDRRelFxdnor?=
 =?utf-8?B?RWdUSFJvZEVwUTIwcmZqWnRSU2dvUitvVzJYWHVxV3FMeGUyaEFKZURaZFdp?=
 =?utf-8?B?MjBWYVFuMDVHOXg5NVF0QkhvYk83cUVNL21mV251cUUzc0VRelUrYzRKR1Vp?=
 =?utf-8?Q?F4qrP0b5INjNS7y8t3xawK1qr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf0b413-f8e8-468b-9ee7-08dc396944f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:59:07.1838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Phse07WjNjdaFCr0vXtvFV4jwr5zoM/vpMFpWbIJk/2XpeL2gssn3xyFPVOU01ao5hLO8Iw/22lGeKVt/rR3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750

From: Joy Zou <joy.zou@nxp.com>

Introduce the compatible string 'fsl,imx8ulp-edma' to enable support for
the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.MX8ULP
eDMA architecture features one clock for each DMA channel and an additional
clock for the core controller. Given a maximum of 32 DMA channels, the
maximum clock number consequently increases to 33.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/dma/fsl,edma.yaml          | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index aa51d278cb67b..55cce79c759f8 100644
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
@@ -108,6 +109,7 @@ allOf:
       properties:
         clocks:
           minItems: 2
+          maxItems: 2
         clock-names:
           items:
             - const: dmamux0
@@ -136,6 +138,7 @@ allOf:
       properties:
         clock:
           minItems: 2
+          maxItems: 2
         clock-names:
           items:
             - const: dma
@@ -151,6 +154,25 @@ allOf:
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


