Return-Path: <dmaengine+bounces-5491-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C4ADB43D
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D106188B8AD
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D3208961;
	Mon, 16 Jun 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MsEKlAAf"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D917A2F7;
	Mon, 16 Jun 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084906; cv=fail; b=PMuI46+DQiCtHcmBFrRspDktLHhtnrK/ImhqItpH8sKVTyVwySZAIz8Q8QN3p4R65Kjef3u7vjMURim49aXGdeHLh8nUYIQcrZkHcv7RX7iSkW/xRoPs3RSkBm3cYuNKS0qb+O3XTlB8wITZQf3uhKHw2IWvSCJmb6cYVGCkwTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084906; c=relaxed/simple;
	bh=v+yqcXMi+EhiENEhMIhkC2KnprpLt/XuBr+C+ULv+GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/uvFZapUixT8mWsO8Q85KNrNA1Urrqtuf5HssGUpb+466Qw74BrBRsSEA9u0UGWINFb9XvWEfdZTYTUUoAszkv7MgmtS30uqfih0Y+1Xq/D4f0Cq6DWBRcRWz+LCcMTgZgH2hd31HkfcywD/7cWVFRX1TAt8CEPMSAe3kxNrY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MsEKlAAf; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3FMXEg6+58HHRSvX+F9TeJTXeObM3tKCIzJFiSdVEyOqBa1jmCR0Y1PXZDscWQsmAVU2MYXzY7wx6BM8Rcwk6XzmvZV28d5bKDgDPZApOwVvgTZgtViA8MaAjvtxBBEOnN2dDV9kmYSkAV2AdyxwhG2kzmUrnQ8SqXfzbU4v1DLZS/4ifIYqnACmArhz9mwperzeQbVifSUwgjwYxOgi3l6wQIspL0mmY0R5T2XF6UUhNdLUaLGPmjdQPmG7MbEPBaQ2YdlCMt/X71fzjDvlmJRTyH0Jbp3wdrTAYzd4bPv7qQrS0FrEh7iEjXTcow4pH71TRgLojIiNrlw4z7hOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEE9otLIa1IQNRRQENKP/ocGACMoj1vjrgSVP9Svfdw=;
 b=pB3dp7bQmF6jofXGcg5NgT1iP35d5f571p6C4QpRkegcV8iFxTefKEPAHXzqcUvR+AeA7TCLOZAL3O8kCqp6GmJmon7rJCXJJU38TX3csDL9/d3dVBnNCs/vMZ4mazGmI96fEgPQzttdX5+/MesXav+3xyt+BkBVnYzdC5dFmG2g0pQDMNCR401wLRnXf1+jpM2cm9SbfYym30RDH0GpL1/KYaYW8pa0oVjp3qrp4MneiXTaBE2GxGArCIS8zrNIrqO+wXK1+xGKzxgmd73L20kXE/E1mpUe+/AK9zDcdpuYDJKRnv7rE9fW3URP5/Quq67phtSxhPXAIriZvNuiqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEE9otLIa1IQNRRQENKP/ocGACMoj1vjrgSVP9Svfdw=;
 b=MsEKlAAfi088BB+zMOs1/59nrENpxRlVEa2xxf5qdTD8pVLDiUIIa8pAilU0Y7TeSw30M5cbHs+kj029aA8g19p3rWQP9G+8ADUDGvYj9fvSBnakqIhQMuJZT2GrFoMyj4NjRt9jtHjNyh4BVn30G7/zycevVkwUBsDSVNzuG/MobNgq5OVqDTmb5rxlnHnXMYBTQGP4PwJqJOS1NDdUSTnERVFJwmKxpdYJRClrBj1KKk0s6J2JXTTCAyVfmdCFbzpdhwIG5S7RYAnshWB0YJK4kJ5pNOuGa1YEvjNCE/2kRh96C+yjNZymHAXnq6IvwW9nT5dlfMhSEjXAGVtUKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 14:41:43 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 14:41:43 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: [PATCH v3 1/4] dt-bindings: dma: snps,dw-axi-dmac: Add iommus dma-coherent and dma-addressable-bits property
Date: Mon, 16 Jun 2025 22:40:45 +0800
Message-ID: <144d2070c7b2f69f034b6f16bc938a538afa9f15.1750084527.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1750084527.git.adrianhoyin.ng@altera.com>
References: <cover.1750084527.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7deab3-fb6d-43b9-38d0-08ddace3e974
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3fJHzbO7iiQGyUxXZB96uTfMc0XwL4c/TcOH8bUPsnoiLZZF1bMnxFv6nuVP?=
 =?us-ascii?Q?m6chlsV9Fb7MuezTdOZYp32Y2wzjHiuGGqKs7Tuf5zzaX73H3a7mGrIln1+Y?=
 =?us-ascii?Q?XFs+UQbrsG36zG6iCA9T4ZjMXSqileW/DDnf8SDXlwLq4GqMqg/I4Jy0gzcH?=
 =?us-ascii?Q?pNfFtY/GkrFMStu9tI+IaOVRawyTylGeXv7aIjb0pSp8niGldyn+bRowKiK7?=
 =?us-ascii?Q?2zT1THBhE9dWmWHcM5EH0dGfk9XTdpL8Nm6vECk4nmYaKfVJfB32CHfJaHAS?=
 =?us-ascii?Q?CR2y7jX8wLcQ8x7rOmiG7ZnpR0pHG1R/WeVfD1o84chmW/BQZy+qMrY9Mnen?=
 =?us-ascii?Q?uuavUoOeYa3TD3vEQOosPKUfeeY/Qjvs7tloayGfSHV1m/pKDEAs+SoIA8rZ?=
 =?us-ascii?Q?d2qrFgrkjU1VPsELub9J2DdxL84UbgtOP4Epwz05u8tev8Rqv4Kwbyr7c733?=
 =?us-ascii?Q?FH95cJxhLfu3AcE+jTDNf9QV4VK9HPlQL6WSTkoks3MD7F91XEycGC6eUOK6?=
 =?us-ascii?Q?9U7v8rx3q6Ycg0JGo42cKPHxsQZnXmem403LdoNEMMj8PIPMqU/L4r6P5OLc?=
 =?us-ascii?Q?mgN9bjGMyZ8Cpwt8g9DxR3bNkw3ty0PXpXug2oaiZQ7kJeUpanlh3S9/29TT?=
 =?us-ascii?Q?Re+N82CR8jcdtwDpmSCgPE+NHiourP7JgmtxxfzCQ4aMEk2WjW1GteoKZjl6?=
 =?us-ascii?Q?UBI2e8aaPlxSPrvvu4JmuPVfCMOzBXVfLDO5Kewjl/dhQV6dL7MMPFxOeK8F?=
 =?us-ascii?Q?d03QwJ1686rbow77RMmPhU68ApzhHFXHXPyigr1yOZfM+AQCWhYyjUlxp25E?=
 =?us-ascii?Q?x0jy3qOanCEpF+zXqwI1AvsrBg0Mg1FGolq+JsPg9EhqvbnS18P+KgOxMTlj?=
 =?us-ascii?Q?flq5x9sIzeW5HLn9h5GzSZmAYYSE4wCiVmoUo2tj9UBzzAGgEwkWWC8CC9NN?=
 =?us-ascii?Q?eZcS7Ji7neihB2wdfJKTRvRFjuHiAwYRsJqzbEYY6jwozpNoDZ47QKSaWHjW?=
 =?us-ascii?Q?zOwD6i+4WVs75IYBdHw25W/Ro5TlMR73/QSSdAGyZXAtCTsjCxTl7vVULRuC?=
 =?us-ascii?Q?y0cJdn2AO35XFzU/S3YpjjhUgKCEJ5s5+jWnNdaoJKiB2VV/1jubfMwK2znj?=
 =?us-ascii?Q?xULcd4n5VX1Df1yIFIdxx3HAjGUB/for4seu9wQn8yOO8pAx1DKB9nzQCBbb?=
 =?us-ascii?Q?cNwUiyJLGAbsPgqYLNit2h35g2jg4O7Ds3HeI7N7R3s8WpxKdV0SVLokagKR?=
 =?us-ascii?Q?d4xs11rASGZ+JSHYtk5RTSKED5okhjOqmzb1BOayuUrr6gGP7ptWtEl3ifeQ?=
 =?us-ascii?Q?GjDE6S33X9M7VYrrJWf8bhY1py5qcownH+cuOeIJoYGAs5DiDnYS3+3ALAu7?=
 =?us-ascii?Q?hkKv5QEF7apvQ/20M03KqWJwgmLPSugY6fjt6H1yIr4qny4d32NNkufGCG5o?=
 =?us-ascii?Q?9PLTbGsAe2M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bX7l1VH2/88BnKACI9K0+ZdhhJ5VAhjzE6cSAx+88FSeSf4A9S8GuCzOkEji?=
 =?us-ascii?Q?oTTwUse3cdXALpDLadVmIX76Gi8W5LlQM19gEUcDaxskNeR86cNjDyY0YnHm?=
 =?us-ascii?Q?oeAYr67w4cYmqWBpywiC51a21GUFvzJK3S0KeXVqNZBJVyoPTlP7rSI/szoY?=
 =?us-ascii?Q?BcATRwEqJhU1nRZUoHr8qvmacQ+WMDu434KI5UeAD5cXyltTAkDg7AZ4cMYN?=
 =?us-ascii?Q?aVFcbkFXQ6la0i7DCVxKxE+I81/2XpwYL7j7wd/tWzArnG8mTy7yGRi7+ITn?=
 =?us-ascii?Q?aNymsJtCmqhPJKYXqAuXonzZpndw9EJsUA5gvkbUxARI5MxvhYhDwExWwFuE?=
 =?us-ascii?Q?NnR1zTeagJa1NZAqbVaNoyYUlFvFq8wGBujRl4mXsuy0ih1NFuqSrLxRRCZK?=
 =?us-ascii?Q?NaZ9/av7fKNAjmRfR24HFvGeLQrp3qiAeuoCSuN8wdJvZXveUzDCJPuLHGR4?=
 =?us-ascii?Q?QzClj59KeTQYhrRR6YGCD+au58CTMU37waT+rOT8mQQuJtgHPORMtTt8nMQ+?=
 =?us-ascii?Q?fPk8P/S60r/Hgt8jHXQ2qDR7+OVaS89/nEgMvPotX7kl9NEtVjN8XL21fFaH?=
 =?us-ascii?Q?rHTccxf0hsUcasfPrnsYsPfIkxM0oB5P91JopotQHMyPC5Sn/lttfP/Q7pFF?=
 =?us-ascii?Q?+6qjFPlLVh9wdD/N7tn7Lc7dOYNO/kNQ3C/wBAEfOWTwc5tSxKMAQpS4tJmy?=
 =?us-ascii?Q?XIJFVNn7wxCJ4sDzsFRMNQtnQ9j0drOoHRcrhB/fMfh6gEiV8zkKRWBVwYnA?=
 =?us-ascii?Q?35h6Cw31C8Dd9szrw4dgm1PnCUGsTAoPpuRk2BKDxXUBbRqfzBkZ5n8S+mlw?=
 =?us-ascii?Q?qDMLvfvfuZ+3+7XKO+KQnsP1dDxqa1W3f6RdfLbjJ1hrTUiJ67j5bZiwRZPV?=
 =?us-ascii?Q?QoBgBkOWWjrSp0/l9hCcucbK4iiOx5fCoIj6PL+Qu6A5rc6dlBbBgQgRgd4f?=
 =?us-ascii?Q?/O5/Wi4JzXG2UBz21r0tbICRayk+1/x1j7NxSoKqKHmwPIrjuwDiAKRrqQRn?=
 =?us-ascii?Q?Tyue47xlup1MG1KN6l0ba9jvPvSFiaCfybMw3diEH37K1V8kKVsuGcvo7Fxq?=
 =?us-ascii?Q?xBmrbCSqKbML8q3NAfkScYtJVJOIYkbQO1yclgqhxF0+YxG7ytUFjxKyS6Vj?=
 =?us-ascii?Q?cNy9uZD1DIhSiSphkYX23zdlUByali9fXtegZ0NnT5d/4rN2A5Y9ufhUzPdF?=
 =?us-ascii?Q?SlpvCE0L4FmwWNChmynT9/9CWs+Vke/wZYs2T8QYinJ/QkJ9XAZ1wRZG5zV2?=
 =?us-ascii?Q?6i2zj29ra87WbyRUEwgNNjQ0W48mKpnvbl48fIjuyLaZa2gpDq46nZYjeoyL?=
 =?us-ascii?Q?fqjalnDsDa67jPWiGS4nzxY6qOXGG1HFnb6tffzKN46lf5oP01xHYUfEB05E?=
 =?us-ascii?Q?1yE7NPuMzt7Q33/pxmyEEFjleaEu/n/dDJqO9Vh+C8XYqIyt9e02/MThnH0R?=
 =?us-ascii?Q?Lx6R7PNHJfs3gFW2fPENDRaAI4/VowxMC6Q4Rw0efNL0UgZlfCqM9bwOQ6pn?=
 =?us-ascii?Q?vBNnvp5+1ZseGIrTfvOLEghgHdRVtjDORK2IMX3Lwc+z4AfHvqJgVOFCyuf+?=
 =?us-ascii?Q?IL9NkxleKrPgLhtmyZRR5XzO7c6zJnaKrxleSzUTk+DDMUmqSwIHjfZB88ct?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7deab3-fb6d-43b9-38d0-08ddace3e974
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:41:43.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdeS3G/NUkQLimqVmEESj7/4gB4+5y+3m5lmFRtePTWY/Us5kwb3r+9xclAE/GZnpU2u482NRIT9CPLm+09vWJSEL7x9SUcC+b6M4C9JM0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Intel Agilex5 address bus only supports up to 40 bits. Add
dma-addressable-bits property to allow configuration of number of dma
addressable bits.Add iommu property for SMMU support. Add dma-coherent
property for cache coherent support.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>

v3:
-update commit description.
-update property naming to match description.
-removed text description for default value and add as default property.
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index 935735a59afd..4000ffad46ea 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -42,6 +42,9 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommus:
+    maxItems: 1
+
   clocks:
     items:
       - description: Bus Clock
@@ -61,6 +64,8 @@ properties:
 
   dma-noncoherent: true
 
+  dma-coherent: true
+
   resets:
     minItems: 1
     maxItems: 2
@@ -101,6 +106,13 @@ properties:
     minimum: 1
     maximum: 256
 
+  snps,dma-addressable-bits:
+    description:
+      Defines the number of addressable bits for DMA.
+    default: 64
+    minimum: 32
+    maximum: 64
+
 required:
   - compatible
   - reg
-- 
2.49.GIT


