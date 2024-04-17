Return-Path: <dmaengine+bounces-1864-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A54148A8782
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3A281EE5
	for <lists+dmaengine@lfdr.de>; Wed, 17 Apr 2024 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12724147C7F;
	Wed, 17 Apr 2024 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MKOb8FDs"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168B142625;
	Wed, 17 Apr 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367523; cv=fail; b=ROR/CymCsKWYOwFoXed983POa2Sot3j8U33DUA5XBSLyTGSQGB4Ph8KX2joPyTrCB2ULQKRwK/BGbwn5bvf2bgWm/uc4kBAYuPkGBCqm653XaZmSisuYQjHHGFSRSLwcBxnNA5JDy2ltL7jEIIIlSSSNfXc+gwEQmlZ0rBd4DIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367523; c=relaxed/simple;
	bh=HD/uCKzsPdfbWXoe66+ZGhbku3BLDHjLkysWMnnwSIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/G22h9z/xqfLUAq9a+fH2+bTGMg/U31GbyxfrYzhm0UKX1dxw80Lp/EJwfdf5Vna47mOxEdqMxpKQeh6uYpW4c8/8NHBuVvnsa18RlB/BZKKrwyEhbNlMnZDjGUD5TzB7cKw91xi3Q/rQ+/lx0i2oVZLUEiHDxRae/EGbne26I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MKOb8FDs; arc=fail smtp.client-ip=40.107.14.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maQpYScl/IqrBH4HKlnZmWNXKeDAOIx9h63Cuvcrkg/DqXCDCXf91j5bPJpLV+yFpXRyqNgCwvqSyZVmXNp4F7GJxgtPh971hp5GGU4VdaLgDAScOycHvZ1Hx2XjYcvdWCSEyjYAsz6HPThAifPbFwMTFq96Gk4heoDdmHCVldF8x2/kRN3tvKS8gf+/tKIR6LPQl8uSnMFu69GGhzx5s4+A066GQkxEH4gZ4iBldrmUD2AXCzonnNrC4GF49HC4nWFDpdtQh3A72MRERoO2kS/Tmr9papBm/7IDBJA6Z50TI3h959BL/YLkIm4a4rwLH8mUMHPGS3dpFmkmuPza2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8IheWQqeAIo9+kMhBnoow3/Mg2wyj1iReYyOccRic0=;
 b=S5gSvWFncZcHQwvHTFj0H1KxbClDx9duQvjHurSFltUFogDrydLj8KJURPb+zSiGRDuQEZOzUeoeTP81Rqlk486A4KHPFMERs9I0CiRpA5WI3R3hHnSLpp5vs+bBZqKnwRvxs7t7o+flKSfKpC3GaBSvSipSjaILVVOiqiwuSAQGWhXuhLmYo05eQAm19Iyby9zuYgxD02K+vhzYCffQjxzIpSN/a09zqgd8wnva44XfiPknMUjs01ukUHtJaTQvG2fV8ykFzI+RJAFgDiDZoQhunlDH0/Bsxnxzelq5hn9VoQBk8HDlpU7dR2VNQ1b7NxOxfetdJ/IPZNo5H8c3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8IheWQqeAIo9+kMhBnoow3/Mg2wyj1iReYyOccRic0=;
 b=MKOb8FDsNjn81sBcDLXb09gaUDD5cytyd21lJAb5SUCWMw0u2CFCdHG6+IkXdPBdNUAs8vDp4spp5ee4Gt8ad7Ruv8FqOwq+QVM5vRdWtmJKAgg2Mq/RouTvTdvgHwrz6d7h+4oz2x4qd1hLKyUm0AuCN3fu46Bu1RutM/hUtKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10108.eurprd04.prod.outlook.com (2603:10a6:150:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 17 Apr
 2024 15:25:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 15:25:19 +0000
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
Subject: [PATCH v5 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains' property
Date: Wed, 17 Apr 2024 11:24:57 -0400
Message-Id: <20240417152457.361340-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417152457.361340-1-Frank.Li@nxp.com>
References: <20240417152457.361340-1-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed4c7168-010b-487b-062f-08dc5ef2972e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0ShuNpM8RKbV3r0/vain0VwMfVhEPVv5VXH8oQkSdTJksg78WRD7QkP/0vYZ1RVeMNozrkfLZFLUTaTz8dlYSTUOIGqDoByvJXwNeCWC+WIL2d8fKM2rju+Tbt1zB1MsjBZRvFuNHHxTU03j+MVWhHE5eoa/nOUIcCXOHnw+nnKoSlqEcYwSp8PUHV217CU0sl8rOPXIMOIg6ljno7A1yfFumLb+JKBfIUE/FlIoG3LgJzyPYehBgsnsBi88OXjlHccE/mMn7hT/vTk7UK8wy2R/UQ8ZUriUJFlv3X41T1Lnzu8wfnOwsEWv5xwbpc1FKsBZUkMbA2wKup/6I/F/Vtn4Q2Z/VAJTqSsDPS59fQrVMcSqtws2F13CNQq7cY7m22d5I0WBlM+FvNzgjC5VXATTkFBD8OpUw9mrw67shIf4T8XWQ1BLnfVWBp39B/vFnKi970oiYKG1GKNJtSJdb6jFLcohUPWYDIIbsZsS6jcABXTO5f0mh+owi0Vja/YBdIesPAdYS66xZt5SMlAYNlnJkFKCxpi2shTBS80baA816OG7aRZ8LxlVwXHRwqc3NwSPcOCEt54W1+xUaO37Zr3GYc9dAO1ELjDZlfjELvJK7737H1YbetncfHnG3vVFVwJEQzHdDTxIjXJgThk04gbto9CNbytiNBS5IFxsvCgQRVtvfn+cnqqNu003lzZdtf7yzZ2Rtl8r+399aX/Vtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5DQMLrZwdGns5zf3qImBVKGg23ZKg3aRbxwCiKDeIU/UWaB3wyviYV112AQS?=
 =?us-ascii?Q?efh/GGQutnvXsL/Ej1T5IISjljnER85XaLHsb/Dv9kgwWGXdG4yDhRNVJiK9?=
 =?us-ascii?Q?r0IXuxI7swIa6P9J/A0PiFWHnZxMvD4z0QzHXe66KQVMwqqdUo2ZX4e/DDGG?=
 =?us-ascii?Q?+gGORrfNXFW5/jQokmxr656WWpUAYm1NZUeGAscFFs1xL7vjKObz3FEVF1uM?=
 =?us-ascii?Q?+c5MCM+NgiabAEjUZ9ZG0ZBkvGQYrQMdZU9jcJkcAhiqqMj5NPpmdR+dElmS?=
 =?us-ascii?Q?Ke41lC6yDLJfGLb4Q4Hwefoty5WDqYdhkC0NLW2UHZXVY2Sc8ru9GEGtyEM2?=
 =?us-ascii?Q?q7O5YQywl4tL7QwT71YEyWKOi8Qc1kQ1J0e+NJaWY7JTtiE1iK2K4XNZfQvZ?=
 =?us-ascii?Q?dtKxE726ipEPveb6JQ0aEaGmUbmXTA+hulqNLcpk5/W3GSebjZD68cSsD4lk?=
 =?us-ascii?Q?fBdbn4g2Bfpyd9usv2xj5Eqjeuo8fLpjrox3vvHAfVfEBgL7KpL9EnX+1GLZ?=
 =?us-ascii?Q?IU0IzhRjpCaPvIyuFRdY81xurxPL4hs8wd3PtNcPO2Xt2gDOOs8NY9UBNo5a?=
 =?us-ascii?Q?mI8ciJBNllSlQic8RBvCraXjaUMSlvQt+RYzH2lFHHPG7yFAd5cPxvoIgpuK?=
 =?us-ascii?Q?B+jsd3V4bvUvk33GGRaPUNnBjiCLYR5tIT8J+OFUO76f8XqlfaqwS2yODuwR?=
 =?us-ascii?Q?Tf8TexuKF4ZcxqJqq36cYbZZZH8Hsa0ncxSRcO12BIYObxe97yIHCFtdT5Ts?=
 =?us-ascii?Q?x7f/9ep/eAaKBwP6d1z4bpVAuSNy4AGirDYE0sCTPJTcJhYftYQiLkogtNVe?=
 =?us-ascii?Q?9W1Q/CpF7VTD5djO2nwEgvII0c6YFKcNStxh+nlKEPFfE674uTOVJaNSIh3V?=
 =?us-ascii?Q?0N1rjxVlIokaBf6aBFLD/fWp5EvsRkO4RDyIx0YIp0p1tKfzNgelp6X31+KZ?=
 =?us-ascii?Q?Xsz6MJB4DhrYXYxu/8uDibrKEPKWIpJd8N4yBwSB1A8doxKsQkE21cOr32kG?=
 =?us-ascii?Q?Nmm62nHf/GHYLZiWQNUZg7cWqouk7yoHbVdEsCF+vecz2FRR6ab85iHqaU4g?=
 =?us-ascii?Q?mBEgxrXvOFqATkdZejTTHUpXU8GJwow+zxSPlx2D8TEED4val9U+/8BMQDk3?=
 =?us-ascii?Q?Lbs8/biS4+jGcVLOzgBKAe4UEwLTABGVaV2plzzUzXWKyI+81Tcgq9krwM4i?=
 =?us-ascii?Q?xnkhdmVEVCHz9AA7gRGDCMKv9j+8MOAaS0Y+/Uh51aC8InHC8FTRcXkEQNt6?=
 =?us-ascii?Q?N7pCbok7pWQuELB9Hi1UUDUB/QFdX9ZgyuVn0hJ0prX3H/1VnFag832sqwRx?=
 =?us-ascii?Q?7bpElU+JgvP1K5BhD/XcD+HYbtunTnKJAtg7hEhOXVXqddTBd1795rji4tvo?=
 =?us-ascii?Q?VBAGpY/ezBpjAjNSUvDzEvWx0WyyX+VqGrcGa6TfRAv32u1v1bi8EFvHU+Rr?=
 =?us-ascii?Q?RR7C1vhEjVgGiXIZeXro7Em8V2Gu2LTOqP0L8FSL50d4MZDZ9BbWrGa7oUdn?=
 =?us-ascii?Q?BufRa4HojkfLuNjrW+Bg7RBlISd1ranPzKGJEaJ4Og70IJeztcpYnQoJ+fCL?=
 =?us-ascii?Q?k2wJnuB5OcJIe9W0xVscq92Xavk6wdt/RaEBNfn2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4c7168-010b-487b-062f-08dc5ef2972e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 15:25:19.3012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKN9Zl5Xyb8yRNqHMhqZJ9Zl0Gs2Ie+fx4n6qt66Bm6AVk892RtZhGJhSaaxhUqEEbeFYu2Q6yT1H3dqLKxEYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10108

Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
it. EDMA supports each power-domain for each dma channel. So minItems and
maxItems align 'dma-channels'.

Change fsl,imx93-edma3 example to fsl,imx8qm-edma to reflect this variants.

Fixed below DTB_CHECK warning:
  dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - Add description according to rob's suggest.
    
     "The number of power domains matches the number of channels, arranged
     in ascending order according to their associated DMA channels."
    
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

 .../devicetree/bindings/dma/fsl,edma.yaml     | 80 ++++++++++---------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index fb5fbe4b9f9d4..f624961223f34 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -71,6 +71,13 @@ properties:
     minItems: 1
     maxItems: 33
 
+  power-domains:
+    description:
+      The number of power domains matches the number of channels, arranged
+      in ascending order according to their associated DMA channels.
+    minItems: 1
+    maxItems: 64
+
   big-endian:
     description: |
       If present registers and hardware scatter/gather descriptors of the
@@ -202,6 +209,20 @@ allOf:
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
@@ -257,44 +278,27 @@ examples:
 
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


