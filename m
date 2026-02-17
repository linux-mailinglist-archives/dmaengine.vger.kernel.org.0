Return-Path: <dmaengine+bounces-8920-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAkjGxynlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8920-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:36:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C396D14EA2F
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A721303D733
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9CE36EA9D;
	Tue, 17 Feb 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fZ/YzftF"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40B36EA9E;
	Tue, 17 Feb 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349763; cv=fail; b=PB8crFCj4YYRwo/H9ekkI9qvh9ZBVA3DTGhCHUXth1lNHeWD6ljGASbsLXH73cA1faPiTzHsn8wKPVDtVpy4VEo4ti3ouC80jLyQljZfKva2U9dPEEuLb7fPmIv0T21zCrGF/9SQGJSsuPBOCn2W4heR5T6twJ1rojS7mNE3HCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349763; c=relaxed/simple;
	bh=nmtYleU8g/3i89moukqpRFVTH/jLqXceCad7lN4JgPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdpMjn6GA9Hp4RsPJFOJxozrjE8tnAihA5RSbeXyzfeCj9PdqyJ8QEEfpCXqP9Pbzf4Iwv5be+N/aCFcuMd3ckBbUqfJ24jvBn9aMNeaCTH0JvUQm0RUcUgddmSdmYeAEL9xKQyFaP5x/nbf7vmtgFowRZ/WpLg4IafHAOQzorI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fZ/YzftF; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aslcGpkILFq2fgz9LTTNDFgOEcPhogG03Y+W3yS4hZJLW/lfeShUBz8SYA8r/Tu6S0b+JRLJqiajBynPHAPoMNoy2jqbe6OdhSIiTGGLt3ImKkX7UTDkwGrsom9VW0wcIEMd7NRC78VvXS37VhBTjtv1kZR3PsKcT8bDKbFODF7roh2nwdVXLadPB/xbmVHLNhy/CFZzDfk255ft+NfQ73R5RA4+6GXGnoof3DvJuXY+d+3uZujWMrLxIzyxmCDoIok+jOkoBn8loCOckXey8xSLUoTGwg6F/NPMqdhqc5dxe9+YTV2W2JIS7qmWAM8zhdtzx+p3a5IHF5ZqTWUY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQb13qoEF0I7SQZSDbrA0a/IXGj4gQtx96mMaCfet2Y=;
 b=IQZ8IC1VBc1TMfeNFQNQniIR7SmFssRwLLxtfGUI51uN9XhzAdNwdKesoTJTV4BMRsilu8nOAaTsCmSt6cqMgnbxOmxatlzkiiRNMOkRkyvOHekxqrq+1ajBXbqdvFdf8ddVP4fd/WFpDRimBEb/bCOq5+Q9PoDdEwSNdI2hcTmqyBYngqYOsvn1ngltXdn8VlBm0dv8wEQxwlQROP+s3FTOKNpE3FTA/NcO8fdllxIfUZH+1ZJEVXiSLQOd1xaff738kQNAwClFNrEPylGABqx2TRb0cijxGnNxajDl6miQwVkrguRI+mFmVf6yUkOlu0/fs27+XQnZPBG+2gtjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQb13qoEF0I7SQZSDbrA0a/IXGj4gQtx96mMaCfet2Y=;
 b=fZ/YzftFhEs3RwqqrOevix2E6NRD4evaazHzTri5BhYVfNMCgXYfFrkxeZjp6cHZg0IBtVZvF19ax9sn+sLAife4D5CF4cNTRHc01+2qEscJCaHRNdNQcXzhVvd/bOUjUYqP8fv0KfB6RYLwGrG3RaJJoRdYhPhS+DJ9PBrVqm7WeApaQPHsx9RL+I65NFc/9ecFrI83mTxxQS0lSPtPYTmDoAoRlmHsjoZMJYTv3MNQp8uj+ZvjZAFdRVLftLEQL70PCfASAxCbGlWQiEHUtixwHrn0/UMsJ/fZN42nUk1wjRxwS8euEwgt/9/pnlIVk3ib8chjjyjzLedyNXVJgQ==
Received: from BY5PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:180::31)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 17:35:55 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::f7) by BY5PR13CA0018.outlook.office365.com
 (2603:10b6:a03:180::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:35:53 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:35:36 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:35:36 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:35:32 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 1/8] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Tue, 17 Feb 2026 23:04:50 +0530
Message-ID: <20260217173457.18628-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217173457.18628-1-akhilrajeev@nvidia.com>
References: <20260217173457.18628-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 439babef-e381-4df8-7c2b-08de6e4afffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNSrxmSQ+1AxcPREDNtm9tKihRYhPq0WpotxLRJh/ng6B1xIH3cm2EwdaGGb?=
 =?us-ascii?Q?NAaUZumQowLZQkgNQjSiuPUbyqLf3h7wMUnyGWsRdooQ99PHnmwCzVXhA9qI?=
 =?us-ascii?Q?+3/ehYL+nMoaqi8wczmKiORcoCHCIpUow7TeYaBdPT4YeZsEJh9VHRbEThMO?=
 =?us-ascii?Q?tVgEpEkbS31MZFM8AFSIXBMaFvd4OPfWjniZvBEiTyhT1MkmqbnZpP4rEl1e?=
 =?us-ascii?Q?uVuLoDJhoYrlIDPicQ4cDoFJp2FYfmS0qdEgrCUjie2JFYdPgB48RM6lJTGd?=
 =?us-ascii?Q?ukozCM/46aTJFjFegDTz/kUAgcCNVi28Zfp5KlCV7XLT/U5Qkg0Z/x+flzQY?=
 =?us-ascii?Q?s2mz+7Zlu+aRVXdyMt7s/HeNliKHWlyBMLjCcUVU/l6VSBSP+zhjDgpet/yn?=
 =?us-ascii?Q?DkbSjj7z9ks/IkvhMpHlT6ATLGycNfIVm70ge1R8Aq3xIx4Q140DrOo+ZOud?=
 =?us-ascii?Q?C1GcfQk5KVW2uiKX2DduGj5SygdbbwzNle9YUE5HwM1twfCmT059Z2VR/abP?=
 =?us-ascii?Q?HleqC2aHVpQDAifLja43Xqf47B7OcoiUE2pQnh6VXrEXWDHWXdSDn/Kb0ei3?=
 =?us-ascii?Q?EHy+mgGIfgV6MUmb+LLs0a7uGLdT5IW6wrT5oMH4idXoiX0T8B2Mo5GgvK1f?=
 =?us-ascii?Q?xxFXPFnYddDbHB+wzzE6gDsFwAa0UC4T5zSHWtdPZ37JqjHeACHGOYprnblE?=
 =?us-ascii?Q?Z5RjZhwXhyH4dWKevr1uq8WRWfxo435U/Fro7JFuoi/TkjkmWhj10JkhclCS?=
 =?us-ascii?Q?R0FGVg53OLojpf8t6xepENaVylwTAwU3kC5muRHKVkusTCRCohgciQe7t7Eb?=
 =?us-ascii?Q?3PLThHrPxVYgM8nAIaFmyRJT4T+xLXcti1/0u3BMjZo/8/TqMkIc3MjFTPfy?=
 =?us-ascii?Q?XrkgFi0p7I6GqS1ZPyzanJYjimElE9PZ2mRH5MKhypOQ0ll8vY6F3Jz2xPZX?=
 =?us-ascii?Q?zyKHRXuXg2o/wcAFvrcNpCww3p3x/ohrgUbuGvgMjwbDP2M1Scuwg08CD1m1?=
 =?us-ascii?Q?IOO3Ll8hVqWTs8wcz8x2T8Fw4Hjhki278XRclzaQKtboOuUj+LnCF9toevlV?=
 =?us-ascii?Q?SXBuUwGUYREpeo4A9eirwlxHSMP1mNabaBn0hGofq8peIGa9DvNhSQi0NMMe?=
 =?us-ascii?Q?AiLFojBx8Q0ry6dCBj+Z2aCfo2PPR+XxMf6Q2nT8A2TmkZHcKezz8aO4Puu6?=
 =?us-ascii?Q?3HM7ID0znvkhTjCF6lpMH4/ejmWV2YkW/75jOCfhdiHc/izvXum9tP7FQ/l2?=
 =?us-ascii?Q?Eq7PLyMvsaFev0MmZjSSrSX/zYnsZjyTVzEl/mG5W2JsOhvsJYA18cMHP4R+?=
 =?us-ascii?Q?9RE+wTadlIjSxg3mWlEl3MIKwgt+utcwmlmgfn3m97lKU7oUwB12VbkcUM6o?=
 =?us-ascii?Q?znZCrzTIvxbKNg0p9ptMDG4AS155UG/nAROmA5jk90vaIksitK8wiHLWVfnw?=
 =?us-ascii?Q?LYA4AOrLgOsWlh5R10LJRq45EWTgP/syNf27Y1VEVnwt0WWMIJh/Glfdjfda?=
 =?us-ascii?Q?t9AS8Fpk6u+8rwPDzD+4uyOYtq1kC0XkJeSSpGM3dXIeW//FpRT8ALZQh4eQ?=
 =?us-ascii?Q?kqv5M9kGu/F2mhKFNTcAbQmLwNy1BML24hV9gjRapkIfI7mmDPJFnbhEzp5J?=
 =?us-ascii?Q?ESs1dD9IKV8pIGc5LjSkCQnuaChzH2RisUt+ZvTXMV9jNN8ICEuValsQZC9a?=
 =?us-ascii?Q?v1vHaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m0mgorXTtiYiCGWz8kGl78AqKEVE9nXJM/oL7GAeAdMQXWsWQMK+WiBB8dqgMM3D3AjDwbS9MpuWAuuYhbUrdqif7hswzCttRLFBY1/9+V87zTnku0DzygxxTXvj/CVFVQUQTsZdDvUyBeFFaEfN5ksxpL30STJ7EEMv9ViCcPqITVcVLKRjJyf5VRWdxWGXnSy38tYQtsT+sHKmXEABrQTgVGSCiPHtQomadbMZXHCTpdlhHHNZ2kvdtaC1SVjmY4c+ozAfclLkSjhPnyIM3HnuDrEhPq9xixHhHavdVdAct0zoYX8M83oshJ0xWE1Le34QEoXAZbFePMcybv/1k8OazeSukMTgaj4XL0OctjTo8wvJd6NHRsUoNQNgvcd2mbMN8yHWEgB8gThMQE/N69AHn13hmSmRmC98etgaXUEE8jHUlR0WDnUGDzP+Nu88
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:35:53.4493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439babef-e381-4df8-7c2b-08de6e4afffe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8920-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C396D14EA2F
X-Rspamd-Action: no action

Add iommu-map property which helps when each channel requires its own
stream ID for the transfer. Use iommu-map to specify separate stream
ID for each channel. This enables each channel to be in its own iommu
domain and keeps the memory isolated from other devices sharing the
same DMA controller.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 0dabe9bbb219..542e9cb9f641 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -14,6 +14,7 @@ description: |
 maintainers:
   - Jon Hunter <jonathanh@nvidia.com>
   - Rajesh Gumasta <rgumasta@nvidia.com>
+  - Akhil R <akhilrajeev@nvidia.com>
 
 allOf:
   - $ref: dma-controller.yaml#
@@ -51,6 +52,13 @@ properties:
   iommus:
     maxItems: 1
 
+  iommu-map:
+    description: |
+      The mapping of DMA controller channels to IOMMU stream IDs. Each entry in the map specifies the
+      relationship between a DMA channel and its corresponding IOMMU stream ID. The format is:
+      "<ch_no &smmu stream_id length>". Example: "<1 &smmu 0x801 1>"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
   dma-coherent: true
 
   dma-channel-mask:
-- 
2.50.1


