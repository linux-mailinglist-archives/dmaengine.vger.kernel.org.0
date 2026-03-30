Return-Path: <dmaengine+bounces-9718-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KEkHbCQyml++AUAu9opvQ
	(envelope-from <dmaengine+bounces-9718-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:03:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3FE35D655
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD0BC311CC13
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975463242BD;
	Mon, 30 Mar 2026 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lNPSVNld"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D4322C88;
	Mon, 30 Mar 2026 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881976; cv=fail; b=meawswPfu6wfjbm3cIDEXX6lMCQWRiGPrU3sNkfZ6TjJeRIqW0uQ84Lwj5ndIYa6yGJ7dU7zZpFn7lvYvkB9Q7GWDU4BxKlQUVUSHAV9kjOXxhlUtUNTK3BaSx7wdfAgLsp58EMCSLV/xVMtDpfcIHxOCSrhS53BwZBATiZkOuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881976; c=relaxed/simple;
	bh=Ngs8EPNMcbZmCb7C00t2bDxa3rlI6qLzn7lzhHMz14M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLBhW2T7BzfXqDmJApqqK3f4j0/A7mmA4RdfnQIzm2m2ft7cQKnctZdg+B+TD/nLhMS31im784QTAjT/uAqwYKlIQx/hlkq+EFVS1nGq05lP6cGo7/DkbgqnfLgTW0zIaJQJyz1W9Mv5l8rQnkX/rjt3kuhkHXzoqU7whWr50TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lNPSVNld; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVUnjMuZxi/aDdNtzHWl+fUV6GGhjfQmmfpGR0FUHqjxeigb3G7+EG4fQx3J22cPbgIKOQwC5aYcSuv9PIyVa/xpsQJV/rJ5zTCw401fmfFqqcXmcp1EGZz/k4oVbq/g1irz3e5rsaJCw1jH+Ahm0bqhG/moq2qqc+WQlMcs9ARV6wmLMG9qcwxpugudNNbkj8NFjrXh+GaSorE5GmO2zJDoG2oCcuMa23KepIluGgoKz1COK9X6AGqt70bwqSRa4eJms/ZJqGjVnB4tbwxe/l/FW9NxySiASrrVoKZdxc3M632Vr8A3CBLGNE3mfzXxIvM3pxu2dzyPktSEyFrrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhxS1xYdxOO4vXubyanW9eEpLqgh+V2kvpwL19Nm5Hs=;
 b=U6Yr17n3AtXYKLMhfuI4YCZdTneGDWIaa6LvNt6Zz4RuRPhxheUqIbJ1ilp9jFl8fQrkS3wy+MYAt5sAAn0hpraZlTIfy7+nc1ogIHtFBv9O0EzFU+Ockv/wgdePFeMlMeXn6O5IpWi4Nhv6vsvuj+NvCffflWhSB/MApimdxEiugQXjmq8KW0LRI6ehdrJMDsr7p8cayYQzy4ECxfcjQUOOKe1O52FieCKbh47K3lPR0TZmMEtbAiaLKyWgfiNd3SjuNKcfmpVVT12SZifLBjEvYk6Mu8b7kDb9plXj4hIjQVZezrtP8W5Szv0nrNx6K5eQGJx26YqzHBe30sb8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhxS1xYdxOO4vXubyanW9eEpLqgh+V2kvpwL19Nm5Hs=;
 b=lNPSVNldrA1F7W0iYzjyl6ijqyOLg0uWJB//umJBPjsfcqFERBWiYDGB7daupXw15UaD8Xh2pOZWLWJvgtqLyXQzQvYT1IsrisXtsfG7JPa9+8wfjlJc3vsHueblfPGsb4ZO/tvtS+LvSuQHcIh8vwYAxhWNqMRrJrr+/oEXu3yuHPhx/LwGfLAOVc6qrFgm841ephIJfSDXq/CjbNVDytT0wQ48VxQLdgrQjvCIOmPGormgxzHex/l8vAKAIQX74BZELjvr8dh49NaGFdqdPV1c1t7in0/G2q/J7OnDQJQ87DzqXkmEX6oKExugoilLIgxVIcIH83Iapc1V82WILQ==
Received: from SJ0PR03CA0081.namprd03.prod.outlook.com (2603:10b6:a03:331::26)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:46:10 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::7b) by SJ0PR03CA0081.outlook.office365.com
 (2603:10b6:a03:331::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:46:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:40 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:45:36 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 03/10] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Mon, 30 Mar 2026 20:14:49 +0530
Message-ID: <20260330144456.13551-4-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260330144456.13551-1-akhilrajeev@nvidia.com>
References: <20260330144456.13551-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6456db-9522-4f3e-2b3b-08de8e6b13cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S+46FG5QxtRlQanfgM6aOOY7OJvgXwlrj8sGKVWCrzw9nEiYVwlY2j6Ot7NEAclbPn2G8dNshUAAa67T372c6f8bLL3sSt4thzVOIKBS8UMNOLJZW4caljyrtNFANcd1idbhhCEpH+cHcXxZFcwt8zEAgw4+SHiAJOdMn5iWiE8DGuXEK0AggGElbwk6yjczpb/wofvtUCpQ8AwaQTts/jkbpDywh3inE/jFZc8fDuiN3NyOTUS8sFnlzCqN7dugqf3kaee0RExtfHVZgXUxVmUYRfBrJ5gbKkfIc8KgPyrAZ2dQmPg4oGeLUvjVtcCaC0rmDxqFcXYJV2ANPH5Xv0PzbohkjhxLtbJBUvNdClRwBCuYu1YWFzZPxUxzjwE/ZPHLkcgvHc3m2WTcLFIPOyy96nXXoBYdkopTLgFFTvozyczCEwxWFc/GC2d0m7CSVYdRBkGBcN0/HwWeHyC5d0PKtnaMjkRptKiVCMGQ+gN1Tl3ZNNf1VaZNaKpPdzgFu6YV6Bx0GHJUnMsFPa+GZ50IQRQB0sJyvoZVaqRF6MaqpP4H4Z5AUwL1XF/q8cgL+gdin8CCaNhNnQ7nkg7e39/IMvgT0XUTNyRJjFXQ8/CMBbLQl7WOXtWQwnQedP+sLC6jWawE1GrUAlZW90E3xMcEjZUo4rqPi5SQFIvHVwbP8QX6VHf4dq6TX2JmD0HrIbtxlqc+J5mM+9HJoFaBC8AyVKe87VPdb1W3VFbQPMFAMm1GrLb+1iLYJBIR4aUYebomXkCzK2YV5z7vIC/xTBI5wRG9stRpSFcQXNbj1xJsPI/QW6OqYjS198Ez82Dl
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iipB3zEF4Plzm2Vexmw3ATr0Gp+ZFxafwZ+VWoHmJLHHA9c9sl7+3A+ZgvlUodr92dn86Ajy+MltEP7+Nlv4mnROGp2BHMqFgvNsxci8+jtFe7QNbltm16Pk/lm0/wbL9vYsDJEZo7nLO9zPQkj0T3wRZXTJhGnfSmB5TUSlZnvVEHKSLxwrQF60tZ+pDTY924xYnpQRaTJHW4tVKRAi5tm3LlQ4t1JGjq/ZHQhQo1SKbuTMAcqhm2Iy/cTWtQ/H/SYpd0QYTo7+aN9bwqmdd3BhHMeRELO5w7ytvJNmAo/T9Di9Nq6Zxu8mL2gvQNNzgmFu9yZ/PPQ/N7DjSgcOD4qM2IHQIBmWqjthvTTyzsnG4WOwHVutVMJron4y5wdnySQME/zoz3Zn42kR4f8DovdPqbMnjuOqhym1gkNq7Dd4xIXJswH4FbDG0S1a253R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:46:07.6536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6456db-9522-4f3e-2b3b-08de8e6b13cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9718-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DB3FE35D655
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
index 64f1e9d9896d..bc093c783d98 100644
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


