Return-Path: <dmaengine+bounces-7253-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5BC73C4B
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36000342D14
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD22FD1B9;
	Thu, 20 Nov 2025 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Xsl6Sq/8"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C282D4B40;
	Thu, 20 Nov 2025 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638317; cv=fail; b=nSozj2NVTWZ0U9ag0HGWxJKNS3UlcMwClOviiPQJDFhvFBHFQSvxBMMV1tN/ppjW1hBdKnnsubGlS4AoAGqUbGwisZBq7MB4T6RzO4wjdSKXsR6YDIqEt3/1wy/hEYerK3qejDWbj8Uz3gk5gLahP4xhJd/w9T6glJn1atKbhZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638317; c=relaxed/simple;
	bh=7gnAbxI9bqVKGpz4NWjoLHHS2cK5bJn9fg650v5P1no=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4PHihRidC0fY4/VdOWahN08pWqKg9fisgm5A0e9kdG4MeYs8f304AJtMEzjn+caRRczDySrE4+tcmJ8FA2iJaxCrbaKN+5t2FCJMFjF/dNxOvTpGRuYyMb9dDn5NZYUcjXch4svlen4tK3ZW1dcfGppW5tHrRkC+UZEbRdAuwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Xsl6Sq/8; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lG2BwIWtMdkQ9YGTxvc6VqwmuC8vHfsPGX+vG5PHK7WEn9Lx38kvim+P4+XxZ61SFeN3gL3JWQVI4UMftu2NSxvHJ6z1I36PpLpywCRqYVwXZwCLCHNIpIbEnbX5Okcl6xnuNuyg/sa/ZYeqI8f8tIDcdPXn16fbX8hrGte9xNu7EZm6MNOHx2D7uNzPYBS1N5/Ps1le01Ir4ACz0EjGv9zP6m2SQNhOcOUw0qKThjKLCXeblYAorlaJY0ZuhzJ4FHf9vuKb5brEAu1fSpd6tyKsqmlz1k+QPLtEe/gjvLd/rX2afeEyRABTKs2U7nLki6EVQ9SijkS/mRzjGbUY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH1hrwNxPuSs3XlgaP7bK+QWe1Hr3ui+S8alJQdFCyw=;
 b=k1KR0HUg/ehvvlW9TQ14JSNi6l6HSXEbMdeX6asqKkL0wI5Tg70qwn99pd2kTzThMXi93J5CHYZRGaSwkeW8q0tj9O7dKFeltMKxZokRgnLWiF2o7Y9xo07cUmFpshoVvy+4TdFkVfxaQxp/+hcYFqisqEEqmbD+lgiwLMNKKoWfXcB8Z1jEsOeXYwDZz9nqDMSU4/BuUfp2LSzxDxPLGj9L3VkQVsMVIiKIRSs3eBkUAMjAXQ441u9uNaACPpEQyz103u5zh3pfJGrsAJfWCSQyY0CgadK2wrmUiGXCfw4l47Uyt7xVkI9pdNtRl3yObsJsjf6AQoydKU1apOLeqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH1hrwNxPuSs3XlgaP7bK+QWe1Hr3ui+S8alJQdFCyw=;
 b=Xsl6Sq/8ILaZZEXNcUCH+VQHAWXi6oZXgUPWC07Z5lCwCQLBaTrGEZCULaFUwKPNtUHl5N/JQYR2b9qjLoEPuRbsXVeBLyzwaj05rlk6Kpf6Ll6/0etJen/7+qIkv0X0jm8X25WvsTpXQWPYrbk/elIM8jvze4zOPSxdOyvdh0Qq/kloYwhM4hpBsZ4QTB8wEhPEheBS008lI3JXDtHFcKCAd2SBo7W0OnFRfo5nMqYWCpCor6lFAnNgXWq8Q0p6EUenwazucSGKp2AFrHesVMEn9b6M2loqc7Ci9GUEcK4YwQ01Z59SLFq+UBTBjI8K8CFkk9Aw/8+Mcijh2VjmrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by LV9PR03MB8440.namprd03.prod.outlook.com (2603:10b6:408:377::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 11:31:53 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 11:31:29 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/2] dt-bindings: dma: snps,dw-axi-dmac: Add compatible string for Agilex5
Date: Thu, 20 Nov 2025 19:31:10 +0800
Message-ID: <bd19d05233cb095c097f0274a9c13159af34543b.1763598785.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1763598785.git.khairul.anuar.romli@altera.com>
References: <cover.1763598785.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|LV9PR03MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: e851d8de-0617-41aa-0026-08de28285540
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcDq7VIVzMNpw3GPRFhllfnyaSfyQaA1XtKGWtDgvrf53lN8y7DXs/8L/nM+?=
 =?us-ascii?Q?AvTeYRYjrR3I+m7oGTIYkqT5Mp0Waum39HMJRmu6LSZE8mc5Ue0K6psHvih0?=
 =?us-ascii?Q?53f6t2kdFOoxLdv0WydBnDaQ1vjOjcePV35bQgX/2yH/t8rizQAIf2tSWBlj?=
 =?us-ascii?Q?1sDUYMvanYrFUcaLPu55lKRrtmyDokifoXJt5sX/5oIMGmPI7qEpAmveIfKW?=
 =?us-ascii?Q?6U7Dgkdl+HAa2LBcw/2gNNgxbt2JY/2g80aZL8zTsQkKahPTmx5HohXNr1/M?=
 =?us-ascii?Q?Q+HiTvkADWEm9BWCcuAGhdVLmqwdnV6eC0pnE9CmfJYq8lng9Xl4RNrsKYv2?=
 =?us-ascii?Q?Bawa/mi8sW2v7nYR/hxP0Bf5gXjXnxAspsg3IlhES91iA+el8JkcHVNgXF6Y?=
 =?us-ascii?Q?JNWWv31ySwu7zIme6vu2KMFqBsWCGYj0ZH+Mfv56QAC8ZvK7Q7EgH+eZXBve?=
 =?us-ascii?Q?/NWH6XBCHdikNAV1O96ccEQY2JH4LMnUYApYf3JGJ/fAb8y37osOAXQQItjw?=
 =?us-ascii?Q?6mAA3T8f5G80rQY9K18YUAT+swpXQladSzAGIQcBndBeXH1iNoWg0o+kBFm4?=
 =?us-ascii?Q?6jLBIPQFq/voyj/Qr8/BhE4kddG8jHZfBINyifOV+TQlVVGQ0fUFPG5nI9F1?=
 =?us-ascii?Q?NfTRlTP9o89Z14LIgrjYZyYQC51AMoB5suQjalKfx7EMbejuQrK4V5AHSkfQ?=
 =?us-ascii?Q?znhb8w52rSb76iZU4JPjyl5WQbaWHLvMRy1WgNXGVngvgnoXtfmZlqXAuu8p?=
 =?us-ascii?Q?Do00fuEzOxCyrGVLTYKis1+sUi1PRZ6SIyxhR5UxHYgjWO0Ncq3YLBAs7jyZ?=
 =?us-ascii?Q?odIt8DDs8uC3vW/rSn8ia+B1hr/N+PMMnJ210GJl/nXm1jiE99BizK4BiOVw?=
 =?us-ascii?Q?+EdmNtmkIZ2XwCuTX5M6ra72esSfXkhRICYbQYWv53FPdRxB0YaaYgwyu4Zh?=
 =?us-ascii?Q?AX6Clp8py+a/FOF4l97Qu9wSqbFthaOTeThQjM6DOO/WeymrHCiBL/3XLt6P?=
 =?us-ascii?Q?mS6j8QBvVEkVhBoTtmQ1byzYJ/MGMxQJx8Ovuvn28OmkW7P3hP5IReXDp2a5?=
 =?us-ascii?Q?9LI2nLZzrSg2RLzMwDby5gMJ6tcwhhFhDYPwx0CVKeCUnc8IbXb5wUP070gm?=
 =?us-ascii?Q?2c2qkddCgRR1zxLM2lF/HcB2SrqE8qRXMXg81JDq9BVUSKzJ+VqPNZNaNrK5?=
 =?us-ascii?Q?0oEFWZ0RDHgBNtZEzvgDp1kbAmhLbJKkUiJzQfumL+J2wTciWAHLBT5SVxR7?=
 =?us-ascii?Q?5Uw2K/4HHf/VpoFiBGjpZjU2fA1XK/r8UW2ck1bO722pu4SVF25kAeTRLbh9?=
 =?us-ascii?Q?BTxX/WWTGf3mTBIcHA9IHeHQ56HCXzbArqjOMGV0oNk/GJ0V0iqbOEJVkay1?=
 =?us-ascii?Q?mRV2OYzlGYAaTzO20Ry5lqg/c7MWsYeZD0vRL4qnuEgOMCrE1qEZ1TGdT5sB?=
 =?us-ascii?Q?+75eoxLEdiR2Y7w2MGu0g3XEwz04utuY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yoFINFDaKDYVVvuJxw1/BenJqxRAgi6yUytKiK+HhAkBspRcRBPZXl82Pxi5?=
 =?us-ascii?Q?PV7dyJXnEVyO0PTntc96hiEky3siLSTyJnWCKUCdMOuN90T0v7+p9Lv6MCQt?=
 =?us-ascii?Q?rAtDcgwmUh1egx7D+mtiklA16YS5TejgKs5G2fii5vXzYsBNok76qaiFpi6b?=
 =?us-ascii?Q?fn1eXe1Z5PHjXuzlp2a8k3J51YNkmfi9CPeqm+FX5vLFT5NB0WjlZ98gV2g4?=
 =?us-ascii?Q?6WuBwIKAmgHsqDm2j9vv2P2vZm95MwPgvQrQnI4pwrs0cwbUe3PxOv3czjP8?=
 =?us-ascii?Q?orbtvEbTGf6UUm09cEf/XPCvn4DZUunejV4BvXtPAG2oP3dQImcTkM23ZhrT?=
 =?us-ascii?Q?WZfUDnVxmV27Vw8zkXdNIoL5zfOK/Fyp6/0l93F8V1jbWelZOoqEywAPFL0i?=
 =?us-ascii?Q?RJyDNP/iDRbR+GK+qRJa8rZZwYw8Le/ZoqBDilWySHU1Dmg1wfsXQu1fBzNw?=
 =?us-ascii?Q?kZ7S16O6mNjgXhh2m8NdChw+fNLFPhlQ7QnQU8G9zO60G6JuKcfnc5iwVwq6?=
 =?us-ascii?Q?C2O/6o1UBLBT5W15wLyRW/1sTKM9/JTXsx2HtxxTxCBWBnht9X32pYoGYj46?=
 =?us-ascii?Q?MLs8rNgN0u0s9i0uNF+GbIVnw2cxvjLXi1tmqz6hSTpa55R0CM6kPCDJYCC7?=
 =?us-ascii?Q?qJ9DqkoXvy0TAaG3+T0oLxGLwe31Yd5HcC2mPYfVBBKr+N2AC78wcSjSMse6?=
 =?us-ascii?Q?2sCHqQ0j3F81N84kSzZ1ObwD7siIg6h1xRghefYh3BwMX5Cje+KQCuCr1zJe?=
 =?us-ascii?Q?Mppdg1NMy/ZerlkDTajSCEUvoeL4B2Bca1GSWgaTPmbfy5mXkZTcMJehyAYW?=
 =?us-ascii?Q?sGiLk16uY7e6w+9f2D1fuxDWQYvdMrl0gRXkuofviYPvwiFFS1vmz1fA/zK2?=
 =?us-ascii?Q?kglJ82GTDPidb3irCAP3IsczaTrPDOEncDlv1W30uTXsfB8u1/Oe/Cy3vMAG?=
 =?us-ascii?Q?4a/F2/Mn8SLSjjW1f9CHBLd3gBgYHbEMywfDzeWNBMof9RpNwI6+dWVgP7wP?=
 =?us-ascii?Q?4kK6Eutt8wRPnyjYJ2UvVU2iBHqezGLaSIkKD4vQfiaiZ+jUmhl9i0FcEBGR?=
 =?us-ascii?Q?KzFL4CtZuk6+oe6hWgmx6Fq6OQQptWHbCbcV1SReBV6PXOAzxzZWnQCHEQeg?=
 =?us-ascii?Q?Oi1pdAVRsCV5PAcD484fMfKs3ffltvoAn9dSNK3W0CnYbqvrF8XEp2qDOdfs?=
 =?us-ascii?Q?NA8q7TuHdqIaKUi+rb9BymRHuTlIisEAsqqLciV9kffDbL9VUWcb4FJs2Url?=
 =?us-ascii?Q?Em/ye4WEMyq/HJGd70Q+AVc7C3SijGDWajwfaeq6dMi0psy3QD2t5EtjA9nO?=
 =?us-ascii?Q?RTBCc9jgJzOi0xHyIfmqyq+6LiVXS9tHQ8LhsBdTdpMqrv0t2S70CUs8H0yV?=
 =?us-ascii?Q?fnjLv8W/H3IbW74eMMuItYKsKohZW4XIXxMDSpBotuS1XzPRDytVsUx6zpV9?=
 =?us-ascii?Q?VlH0svHDCqH1TOb/BO1ZT2WtZp6Meiho4PD80KytW4SC7liZme3BbKjkgXaz?=
 =?us-ascii?Q?ThH+Xj174ndnpL91wIRSJgf49+r/UfX3EilAzYC8u6YQfm23lE3W4Ht1uMmg?=
 =?us-ascii?Q?Ql/HeDBlbp1sQUeWHzxYMuDqmylhKgt81qdHooeUINDvVdPwDJ/CpNMyJXkN?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e851d8de-0617-41aa-0026-08de28285540
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 11:31:24.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSNmSSIqMRpBHiuXE+W65Kx5KvCLQNwIygm5YC2LATTGaZMCdmm7R+odbeilGEmQAGsClAHL2+Y2xCu/vkz1+eYTw1EuAfW+J1G6cxIcDDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8440

The address bus on Agilex5 is limited to 40 bits. When SMMU is enable this
will cause address truncation and translation faults. Hence introducing
"altr,agilex5-axi-dma" to enable platform specific configuration to
configure the dma addressable bit mask.

Add a fallback capability for the compatible property to allow driver to
probe and initialize with a newly added compatible string without requiring
additional entry in the driver.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index a393a33c8908..db89ebf2b006 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -17,11 +17,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - snps,axi-dma-1.01a
-      - intel,kmb-axi-dma
-      - starfive,jh7110-axi-dma
-      - starfive,jh8100-axi-dma
+    oneOf:
+      - enum:
+          - snps,axi-dma-1.01a
+          - intel,kmb-axi-dma
+          - starfive,jh7110-axi-dma
+          - starfive,jh8100-axi-dma
+      - items:
+          - const: altr,agilex5-axi-dma
+          - const: snps,axi-dma-1.01a
 
   reg:
     minItems: 1
-- 
2.43.7


