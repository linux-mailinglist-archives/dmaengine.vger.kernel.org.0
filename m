Return-Path: <dmaengine+bounces-1835-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F178A32BE
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FEC289B1E
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C5F148842;
	Fri, 12 Apr 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SmSvxa6e"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0461487F6;
	Fri, 12 Apr 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936550; cv=fail; b=BKDrTDb06Oxvf98Ed14i8z9B1EdLXU+j4Ll3Vv8t3sjvty8NjoSriU/sM/STgvHU7TWEGrUlZ2K9W4yS+HFSnqjZrHZRxfAdcnaTdYei0OlnNr1aPh4vpIcg1QDVLqkhZnKXvVjCd/xb+7lp+i0cjvISpRntAFosYI6PpHnq82Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936550; c=relaxed/simple;
	bh=hZ3FB2YoAEaQW3Ylnt/Gg7JZTQVv/tL4UPaG2eVnpcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7CQvol+L2P+baaufluOGLZ3tyq29w9ZDIt1pg1t54s0ljpwh2YUiTBQyeFEN63T70nDOh2tmC7pkDLpBMNWP5TxSicuiRjqfaXfxfm7HIhZDpIVE1WfhnzcwcP+f8dcLG9G7mV+Hqz5gFyrOFTzyeb52IboN0RdRzwCImuBwuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SmSvxa6e; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqyxzOmHkN2Y6pV4qQ+FQrE9TAgYjbYheKux+w1vTV5GoTXBaDhoy7XHzEccvNSBHvPkLHz87PiXl+I07/S5kG8o3RYmn30k/dNC+cqxY/Sc2bS0ZnpfvKcS4d8/iix0kWHVO5ACcVArOWPJKXIfhcnkhxGRgnIle9gO2AxeFhCccTU276C+DyCVML4v2AhH4B28uQTZmdBhMO/Oh3tRkCsdAezxseWy3KgrWuSkyJazZPE+S83EFO+ilsimJVY/mJ+43Ja1T3/dzhqg0RAPhQSOA3LEpc5GZQ89mnt3JL2jxAPXJrC1LxsLCKTzPyAdlmo4ZGOKOz6OdOWS/PLQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN7nKRHIak8A+YwDg+BzJQphoPyV1EGHTxG87g0wUC8=;
 b=DBxHmHVfAsFdIVWXYAwKR5FC7MvcUvZLahsYu5znIgOQsqCeMLpOgnCYsQRV91ZuTUlPO/E1/NVPQv2far1PWbRrFr+SxDoEJUxrEhwccoqqecOWUyRQ50YdAX2SZONMFFY7HcC3pp6Jyu0+zjFcPB/2ceJeAUiOrW7qnCMUXXYzPmoY1x+qPHJX+SuwFWBBPUavo+VKTWFS2YjrUEqepDmR0FczUUDq3C6q/R0cnWVPkX9UuZftNk3y97I1bbo1cIjVWD+k+Aam7c/Iw7ib1AxYQwevtI9ZJGfiVZI5NmkzbQx3AIu65B/ulCli6id1mDVhdEalQIhCiP8DdQCcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN7nKRHIak8A+YwDg+BzJQphoPyV1EGHTxG87g0wUC8=;
 b=SmSvxa6eNvoRLloZYvLBPcyjk3EWH0tfXNmn29xncr9BCaBfH3ar8xenHCm7mzdu25exG+mPTBQ+eC1r8Ug0TRHetjVkcDndaAJ40Z//TiHfAQ4DoBgu/nd4OEkQKBHH9YmrKB50IB8fUR6I4yJQmGvxMEpU7v4EQYZV+IjwuqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 15:42:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 15:42:25 +0000
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
Subject: [PATCH v4 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains' property
Date: Fri, 12 Apr 2024 11:42:08 -0400
Message-Id: <20240412154208.881836-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412154208.881836-1-Frank.Li@nxp.com>
References: <20240412154208.881836-1-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58a3c29c-849c-4f24-1ad1-08dc5b072704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lfJPteXYBd6kohK7RiGuUput4ffNYgYj8J5Tjd+D80qO5edEqa7ZsdOtmf91AuNlWZjwtx9Zvlt+gYTdOiQGjIaXFOs67evS2YvHObDEzoSpKSvxNNbXRtxcsHec/3FpFE3OQVe/Dian5xwfoJMLtUGnXW3RJ+juApz92pcM1E0nou2WhUxbQDjJkVitTNH1awiLW2aajBgh24XLyMw3ZoVqRNArgd/5gqrYGti1dV+10K07on+GE4FqldOt8aJAQJ0nUAuGjZ2YlFQQJKpvHOMLfXFlDhjWf54GDGFMVu6L1KhthbKPFjvbGb40Dr1OTQ9CosYC7XBXYAzuMh3EVjOB51f94Mnw53nvf6GERnmqSvlUaIWu+RCDvssCSy/ygI91ZB3BuKNjTzZKhuQNaqltzBDSrXSpByuGFpVNHIa0ndYYG4HpIRa27D6Dmd9CMC8QOMfpp6sKxtPc5aUDwhD60T+wGgvZ6CZFYjLQaSnyeYdUtE8FnXUtaRptcC+OePtqmXRmlL4b8DKm+7Uk8y5/b3uV7x9DC58P9/Pj6e1MTxb7A/JkKt76EvcNS3WBWmemC0cG4nPdyO7BvXyw0LQobxBpPt0k+k9LJ3Z0OxT+Pje2ZHOfRZj4bcZPDsnVkHkr/h+R2k8wTws8R93TO15o/qkfhVMMKA+HUJexNATV4g9wgVvHm5SnfydtCdnSbG2GaFD9BMEX0kFok0p/8OHLp4ELSloojgVUdPIWzlw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YXC1DJkdj7yJq+1U+yLSDohT5kbc/cKAQKONaJGREhUnCDP1taYppzNDesXr?=
 =?us-ascii?Q?n6DmsQjTtKOOttluNfOeHMjY8yzTcvNKMd46PNGrHRdAvxQYxYgcDT9YQRRr?=
 =?us-ascii?Q?8gGaVVO9oKO4ASxI7aJGxh0PNQteGRcq2xO4sdUdMyo+FjCbgW/9wSC+TAuI?=
 =?us-ascii?Q?vt7DQFOiR42OD1U9wfDPdXvS4EijdU/VQ1HpjJFFKZ1uS/kf0IK/hBec0XYd?=
 =?us-ascii?Q?QNQ+2DUhAisgXHvI0BqW0ugNUD5hrLwHEVdiEF9jx2uwJfb1hmxC2h8uEypr?=
 =?us-ascii?Q?ykusTVmxh6csWjNf2WZ3jUlMx0Yo3r7BGDzE1fqeQz31qrM9RrlpV4pj0JiN?=
 =?us-ascii?Q?jnZpiwpb3hVDmTfcksAu7tVWIuIVIepr9E4WA7Ut54BSsgT7iwnFY+BBPosJ?=
 =?us-ascii?Q?WOAE9Umn8OtpsGA0TtW1gtlLWJrt6wEXAzl9f1J/z/ltYx4rXlxKyPLsjT6G?=
 =?us-ascii?Q?AIeP4mS3v3xB4GgEr4u0THML3rCHbIOhHQl7yHYJo8Gg0X+tjFIb63fNW5+h?=
 =?us-ascii?Q?Q5dYcqohJorEwnzFnE8NbMwJ0JW9NI1gOYtNerLgIZSgc22zFF9nYxVAAJwN?=
 =?us-ascii?Q?18Ui5hKpc8axQDbAYEPITKbGk7bpxZEULlqldYVDkTygMv/S5+YlInbuxU6T?=
 =?us-ascii?Q?w+1nXYmO8lzKD1XZsutUqujMmUrn1QD0jOoqAu2m0YqxXrwT95hZ0JjBNAhN?=
 =?us-ascii?Q?bbgqGbTwspWDfkNR1Qf27Kwte9876SWNmfNn7T64SpsLt8YxqmpGd3vjEaoh?=
 =?us-ascii?Q?ENpDXEP7xxc/gFIs15WV87A6qc42lbHOCbg8CIiPwsL5AYqdKbkSB6c5rBkd?=
 =?us-ascii?Q?iNx+VZCfIstW5q+m2RXdOO+dTlqXDImFs+ViEUE2yGb19rsLqoyczKbRJqr5?=
 =?us-ascii?Q?uE5LppGFwQPhXMQvoROIQqBHJfHf6WyC3Pzg6DgkDmNo0srj3h0rOilgZU1p?=
 =?us-ascii?Q?brfZ//CB34cNpt4bqEHBSsx3rhN2hYWaCKfSkvR7jYc/PBU0oPHBb9n2RHjN?=
 =?us-ascii?Q?H/j/YbwZ50ZwhasJAS7dP7+EPjpo6eAfuEjZMFxEXaXMPDpYMjZJ+eVpyXhm?=
 =?us-ascii?Q?jlHEV27MgsM42phx+CS7vtJZvaPo1ue2Ag4+/ZKQ6tvpyfPknO088Z6rIuCE?=
 =?us-ascii?Q?Vvy8mtZ4dIN/JaE3VuAFBLbP7T4dxFCdYOhidNBLKVG1J8RiDOdR3lMA+j2v?=
 =?us-ascii?Q?v9E1fTCNlcfC+dJ1dC/2E7BIKTUJbvHARV0n6GFxZ/HlVh2+212k0Ydj0MxI?=
 =?us-ascii?Q?jsFvLPf+/BTgi1ah6jlFGN2+tqVh3CoRmXxqyfojYLd+6CaYrIGpqsynwufv?=
 =?us-ascii?Q?ZkATLXoHqMtmynqP30RHnMK4EuCcFp6jduTFTVD/+0P4goa8VBgwe0PC7I8h?=
 =?us-ascii?Q?OVOUkCqkkpXDOi2/c6fzh9Wz8GDWYD8vpCkdWvJUIcWVBTmHAtxAp4Pe0WOT?=
 =?us-ascii?Q?WRhBcLMMpvluzJpgtzhw2krFIyJYL/OJ8Bs3sOwgtpH9BjOpz9HKGasjIhbx?=
 =?us-ascii?Q?lj7Z4BP6dgOcMQy0wj1KUPv6e/nNhfC19PhXoMrs1N/DpD+hdn0/xVZ5hB0k?=
 =?us-ascii?Q?ReBKdOkhEOkd/8LM805N28kZPpZ3ziLlNH97banu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a3c29c-849c-4f24-1ad1-08dc5b072704
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 15:42:25.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOVFrn8StR/g01u+2dzZc9O1JmcNscrsOaWd/EI4v+45DVgEL+m8P42wPEZ6d2CjxGdSvm/+D+xxM09y7EmJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934

Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
it. EDMA supports each power-domain for each dma channel. So minItems and
maxItems align 'dma-channels'.

Change fsl,imx93-edma3 example to fsl,imx8qm-edma to reflect this variants.

Fixed below DTB_CHECK warning:
  dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v3 to v4
    - Remove 'contains' change should be belong to first patch when rebase.
    
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,edma.yaml
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/dma/fsl,edma.example.dts
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      DTC_CHK Documentation/devicetree/bindings/dma/fsl,edma.example.dtb
    
    After this patch no warning for imx8dxl-evk.dtb.
    
    touch arch/arm64/boot/dts/freescale/imx8dxl.dtsi
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8dxl-evk.dtb
      DTC_CHK arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
    
    Change from v2 to v3
    - set 'power-domains' false for other compatitble string
    - change imx93 example to 8qm example to affect this change according to
    Krzysztof Kozlowski's suggestion, choose least channel number edma
    instance to reduce code copy. max channel number is 64.
    
    - Rebase to latest dmaengine/next, fixes conflicts.
    
    Change from v1 to v2
    - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
    - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
        or fsl,imx8qm-edma

 .../devicetree/bindings/dma/fsl,edma.yaml     | 77 ++++++++++---------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index fb5fbe4b9f9d4..012522612dc96 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -71,6 +71,10 @@ properties:
     minItems: 1
     maxItems: 33
 
+  power-domains:
+    minItems: 1
+    maxItems: 64
+
   big-endian:
     description: |
       If present registers and hardware scatter/gather descriptors of the
@@ -202,6 +206,20 @@ allOf:
       required:
         - clocks
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-adma
+              - fsl,imx8qm-edma
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains: false
+
 unevaluatedProperties: false
 
 examples:
@@ -257,44 +275,27 @@ examples:
 
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
 
-    dma-controller@44000000 {
-      compatible = "fsl,imx93-edma3";
-      reg = <0x44000000 0x200000>;
+    dma-controller@5a9f0000 {
+      compatible = "fsl,imx8qm-edma";
+      reg = <0x5a9f0000 0x90000>;
       #dma-cells = <3>;
-      dma-channels = <31>;
-      interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&clk IMX93_CLK_EDMA1_GATE>;
-        clock-names = "dma";
+      dma-channels = <8>;
+      interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 431 IRQ_TYPE_LEVEL_HIGH>;
+      power-domains = <&pd IMX_SC_R_DMA_3_CH0>,
+                      <&pd IMX_SC_R_DMA_3_CH1>,
+                      <&pd IMX_SC_R_DMA_3_CH2>,
+                      <&pd IMX_SC_R_DMA_3_CH3>,
+                      <&pd IMX_SC_R_DMA_3_CH4>,
+                      <&pd IMX_SC_R_DMA_3_CH5>,
+                      <&pd IMX_SC_R_DMA_3_CH6>,
+                      <&pd IMX_SC_R_DMA_3_CH7>;
     };
-- 
2.34.1


