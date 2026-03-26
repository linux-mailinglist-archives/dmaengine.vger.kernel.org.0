Return-Path: <dmaengine+bounces-9665-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OAaBwUWxWnr6QQAu9opvQ
	(envelope-from <dmaengine+bounces-9665-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:18:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 889793344B4
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 12:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E1EA3113A7C
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2026 11:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76083BFE5A;
	Thu, 26 Mar 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fVqMW1Is"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213538C2A9;
	Thu, 26 Mar 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523458; cv=fail; b=JMsxewWCYzRMoJggGvIM2NCEOf1bF4Qx0Tfvidc3g0uj5kFfhzt4BhIQ7PYtofbkRt7OTRQ7FLT8W6sS9s60UoeoIINemvko7Gu6DqH8os3Bj+KYenXDa4Fn4XKoTZaOhONBCirO7focKLmpS5SaaVzDl5xjUXEItf7126MF/T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523458; c=relaxed/simple;
	bh=6j28uLu1xKmrY8yhSmyvyK4Jmout6qnXPmI+SWxxXZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay80jBohFEWjZWgU2fFlYUeLb9q+uo1YToM7nCGVd7yeZiT4aYtZ0vz3NTC9pk80GANxJLlksKxbOyBzDHLv1BGMvGRFD8fNfBKJ7rH9WhPZA241yB/GHhbbZIe7INirO+OIPbrbxxFhmg/2w/ovPkkp/OrDca66uuL5ocPcny0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fVqMW1Is; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR0utsTQ2tcZs+iL34u66C8cmjjlU8xp6nPF935YvDPQL9KWaxpzJ7+0ReNX/soGWe7imjG8iCQl+dZZgpWzwUuQTXkFR9yceOCn/Aa5t+jbq5qjqeovvCfL42KpmHDvyvCgIsjyCWLppD48WPoJ7zeicQ29vmJRdFMkF1jgsgF0yClgg+YnWPQ1JnnN44ZUFG4exdUkinXTANXxRD7C+ceasYtbtehG/lgkboDpyOzya1olLRxPfghgcVYSMBkZR54iNsuxShOk0badLulbc7Gcvtfa0UfjYMGB9g4nEHrLFjdZ3yWOCJ6blU9hPjhyLzRUsoWCx19akqw4JoMkOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4/6eiXNtz/Xnhq3+6P8/inzJUExGAOUHTx0roSa2NY=;
 b=OQK7D74nTm3c2F89vzM97w2bpTkWuXxKnSxrqmeQWGtRZTa8NKiy43ur7NAZGdkmqmqEng2lNAIgwBRQLNWUVP9Re1pbMSOkcQyREtqqOw1JVflXtd5uZmN4y2ATRZ8dPerVwDRon2Oi4T3IdsruvXv+z3pybtJjph1OztfsQEByYJijcIqdyTPuSp+RMjoHKnN6sX1iRsXyzECx9OMX37W7IhtNEqRcqxE76/1Z8+fYyU34e4KVp72/w8xQK0Y53OG9KQ95LSi01KxaPtSuPL2ER7fvUZoGM90NmsaEEqJnNNdrodNkizqGpKBlMKbfwr9mcmbCo0xKCqaTMLn8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4/6eiXNtz/Xnhq3+6P8/inzJUExGAOUHTx0roSa2NY=;
 b=fVqMW1IslCGnFerZ6Iho9IT3DjqQyJvkrEjezkLbeosON+8o3ttsYblD10YQ/O6m3Xdx5D2RL1Yw3gLJfiDCinnuK4i4PmQFHSPZfMWGoikrVN7pnOaUHkBIjq1aURhSPETTxLFMIvj6nw4fdsgLpVJt74N7F2Hk2QzkGjDLNCDgeSmA7i67L2O+8GCbLluI1sH+hSZNWFnD6y5OmvnJK36DfCYPjlZOWvXXWd3t8b8sR8q8Qe945+M7j4T0O8MagSPHqxnU+rWn+OO9ORtz4Spfp+gNyYy4ydzXr6/NhxjDXMyPT+6rnTCMfq5mQECDzx9GqB3kPzMyMFk0f+EhFQ==
Received: from PH5P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::11)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:10:53 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::21) by PH5P220CA0011.outlook.office365.com
 (2603:10b6:510:34a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:10:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Mar
 2026 04:10:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Mar 2026 04:10:41 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Mar 2026 04:10:37 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v4 03/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Thu, 26 Mar 2026 16:39:40 +0530
Message-ID: <20260326110948.68908-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260326110948.68908-1-akhilrajeev@nvidia.com>
References: <20260326110948.68908-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: aee0b708-3fe6-4dfa-fa82-08de8b285833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P8g9594WkJBnCLDvXBffAcY/OnBLabIMZUCk0CJ4yh6LM0As320P3T8Oa1ccpwLja6HVlVhIRpxgILFeE5m2BVWvlwONguY72YHi2pbNU/ZEZ2sbrl++2o2uQ23D0z5+Yvmnly70YT7hm/qzLFFw8xgx6dSe2ideMSEuAhhT5PzsmXexFA50wBOCugc5FpbhDdcSDc29Tfdl7GjHElb44vjbd5VZ8tb9Lsf6SxxA6mHY/hUw3NclZuPH8dIvOXv/y0eNwUTaQOsPEjtfkxc0KvA0rkw0lwh9cfggkXSTF1CifkJJ+Ink3VAXmAH35TJKd3NXQvcazGtD+OpfGcukFRSRBqeMH9X0qA8F4Fddj8Q6DFHcXL2ZWrPdQj7f6h71qAD88lOFJd71fX7ihvj4ovhp9xrvzPaqFBj/VaQvU8zVNt/BeDnaEFzl3c9RwsMGuqC0Q8ynJbcU+xVshC/6RkhRvMCkJdZ+smkzqvEHfJr52GKeJ/qboOJzUqMBedyBWuPi2g8ub6Zn3QUGWx3K27SqvtEdm7mi6qkuPEkud8YjucGgHStD6WcZOrCtpW4qCB3gdSnev2JoM8bXxI24PSvv4IugBBIoHvrR7JzBhZ8lZ8vegzti0/3ir+dJ2xBNvBjgW4ANt/Bt/IBJFP81/nqOxHl1laLxeZIr1kPQGJRxENqxkkWVY7tQwiQt6LDTJijAs337Xap3G1LUOOw3TV7rOcp1OSdYG3ANXr7k7XaqfW9QZdpw16ALxuj6ZgRXMH2e3H+UhSniLK+mP/wEYGVc/1yNdjhphCUPdI1qz4wYchZT4RD/ENvs95smB6pl
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Ou7slZcE9hqpoEbFzAhGeL8332nc5c0vx++XQEFLXeMRWosTt8hEWSjpj0LM/iTv6D+JS5hj6LoM++owGCWNYjrMFDPy338CSIe4ySFLdwMMMOquTRskClrqSMsu4uMvuqcz4kzrCvoCv3mjqF7EEbsVPBarfomMe+wwCDPKM8XusQNorgKLnQg+2CU5QsOhLQ9PR/GmPEygTtJjGlLH5KtQExTXft4JHsmJ0XO6edn0UpvX5I1LKF6CcTmn/g5CFZv6sDYrtZdNdy/iSCWRMxvnTPP2jAlukZBiXEclnPE2rwHIDsXmGd/oUMwMekFB4MebBeEK4RLYPomj41ViwWmDweWLK4a3fOKcHyKEQvOcW7Y2ft4oLXKGqJidklDwJAIuXuV7rBAT1/27LfYRyuxlUB5yRQzP9fME50zqbPX4FjGmyL9epT87bxDyoPI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:10:52.6882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee0b708-3fe6-4dfa-fa82-08de8b285833
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9665-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 889793344B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add iommu-map property to specify separate stream IDs for each DMA
channel. This enables each channel to be in its own IOMMU domain,
keeping memory isolated from other devices sharing the same DMA
controller.

Define the constraints such that if the channel and stream IDs are
contiguous, a single entry can map all the channels, but if the
channels or stream IDs are non-contiguous support multiple entries.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 9f9f1a30e139..b849d4cc2901 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -14,6 +14,7 @@ description: |
 maintainers:
   - Jon Hunter <jonathanh@nvidia.com>
   - Rajesh Gumasta <rgumasta@nvidia.com>
+  - Akhil R <akhilrajeev@nvidia.com>
 
 properties:
   compatible:
@@ -49,6 +50,14 @@ properties:
   iommus:
     maxItems: 1
 
+  iommu-map:
+    description:
+      Maps DMA channel numbers to IOMMU stream IDs. A single entry can map all
+      channels when stream IDs are contiguous. In systems where the channels or
+      stream IDs are not contiguous, multiple entries may be needed.
+    minItems: 1
+    maxItems: 32
+
   dma-coherent: true
 
   dma-channel-mask:
-- 
2.50.1


