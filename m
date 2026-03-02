Return-Path: <dmaengine+bounces-9164-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFhQDN6FpWkeDAYAu9opvQ
	(envelope-from <dmaengine+bounces-9164-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:43:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD451D8E25
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 13:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BA73306C7C9
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 12:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0A36DA16;
	Mon,  2 Mar 2026 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LXjPtupE"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42236D9F6;
	Mon,  2 Mar 2026 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454864; cv=fail; b=pcXoEXHutuaSsyHN5DG71Z70P7Xq9NSKLz5pX5RLgM0gTrRv1AlFIIm1eRDP2Sau35/0HFDLemnFWkAgo4sPJngMkP4REfSmh9echu5dCwl8H/Do0LLMI81xxxDIbUOIw4zVmHPKb4I6w7Qvl5BXmW+pL3qsYwl2iQuDsT/pFj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454864; c=relaxed/simple;
	bh=6v6kQwLbAHYBa0zmg9OARVaR1eHoYZzgacgAzEzrhAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5gyTgeVM2REFLrHepSGCGmHAR7P0ic52XFG32WYU9kARFkZxD864JTeGiZ74e8OtzjSxeC9EVEJuxWaQiNcocHJfAsVQ/MNtgNtgO3V2rKpRGHJ+5N0+nZyRPySlLyxfy6PCDC7MOyZQckYQFgqv3DLPovURcBLixzZklK5kps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LXjPtupE; arc=fail smtp.client-ip=40.93.196.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SA+/R3FGYNkKu3igiiSwJbAMpE4+AgtwvySZwYCj/A6yQhPlLcuzS4xgzFzdMEUF/JF2cpMaanP7obMZyNBwDqh2sF/5LH13MGH2AJ0Qwuzbyd+mfL42hoPt1/cJnGrXYRPi0kgVEv0Leg2nuaJAYjLvIkJXl51PKZCDMG9q2+HBWfVAfcy+XjrNaA3+YFCM5P9gft0dFxnqW6QT5jqRY9xqRrgRVU4b/TSBar8K9Dc0xqIkdrchVGPOFJFjrf+raa/d5iDuK4isAYz7qUnK1IuHbmCAOH5RemcdzHMQ4Q/CtfaD/8JzLul0mi/TOYAJy9KTtor/BE92QyJLilDP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z1pCqp83cs4H0Q8WNc2ltQyna8n9AQia0inmNPpeGk=;
 b=Bxup6Qqg5V+fodrFc319B2ockAZSeiNHebD4cG5r9B1b+Mn4UuTQEAZSwoH6akXc7V/Gt5jJUIBS4djJ4DpZjz/KQmNnGx0bMVbGVhwj5kJOUB0fPDMZYgDfaVODtlmJZyHrHMZY7Ozqjgo5qGCBaEz7Z/TJxyNoSrN44GwG2fDu4IfgDVsSRuicYkE99jpdd/eopWpCVMG8nJsQR+lXAZLN/kOPaVKxXKUALQg3fGsKEOTA4ZXZovDa9zqQ1MRm75JTItUVfNMHM5vkiRYUzhFNLTWhuLnNZL6CBIhZ9Dq8CMTXYqimBKO+RMEqAk+znsT3r17xNu9qZS4C3rBX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z1pCqp83cs4H0Q8WNc2ltQyna8n9AQia0inmNPpeGk=;
 b=LXjPtupElDMQiEux1SERmH8O6b/D3HXbrol/V14YflUchjIizMi57DRcCuJwbwHPIoe1G1eFcviubjTv3zsOSQEU5F+ZmfT5AXfRpUvw7RbteHvDEnt5rwYPsM4DzCZtxUShVZwrHElmPzvrwToYz0PMxukqNyFqXnX5WPxK6T9JDoWm/wGZ6GnbsdfIOiHhNLUmn5hVPPyiDkwPps+9jLm4Rrlb68m5ra4UuKY6wN4HCSok1wgQV7h69zci165f2NK3dKYahLOKYdmrqOm/bqXI2B4e3vAaUfuAyExG4gAeQ0AEAAoibXE6GsrBb8pxwYFSv/cBl9CNWzBbEteV1w==
Received: from BN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:408:e4::7)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 12:34:19 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::6a) by BN0PR02CA0002.outlook.office365.com
 (2603:10b6:408:e4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 12:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 12:34:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:34:03 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 04:34:02 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 04:33:58 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v2 1/9] dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
Date: Mon, 2 Mar 2026 18:02:31 +0530
Message-ID: <20260302123239.68441-2-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302123239.68441-1-akhilrajeev@nvidia.com>
References: <20260302123239.68441-1-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee150cf-7da2-41d6-37c7-08de785806ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	aGPKBprleBSYqLdIp8qlUZLIqo7eD75K651ypb51+vTC7Dqb2FkxQlLeBe11mB4/ChWcVE+BZsUP5RY2Rfoi0V9DnWr067PIrvSrYT3FgLxL/F7u6ipYrD31k6lazVoiIgcGx4EcP5IM8wju5Rq4LGWRaHc9YlXBdESJWCrUYUY0kela554LDqaMHPNHh8P66qy1mA1WYtNnQyq9HOcdtnXI7u+CF7DnCloA8B/ZagRTmlTfqJtnuZhWD3oq/uZbZxkF5krQDGsShILRHJoiXFEavNAdIVVZJJwu+rX/8bj1v6YITdntsq10SQ+GRGfGSEdTUT8X9igOJsU6rZwklGduizW2FHc1EtVHDkpprpaO/za3aoCMTgIuI8vOrETcVjVLDUXDgux8nvP7nvcyrHn3sHG2hiaVyWEYAU4IN5hxcPsloTrv3VgcRKV5UyhOUYFi+cMB07GN1nxLZ+bGFka/cj8zwNdCZuUbGERHVqyaOZHdiy4AS7LVVtSFgCQzDJwkzJsffPHReh/2qtCEhvS5qW6aNN05EYowmIRhyv7oQi6Tt1EIMPNJqWkXiCsKm87eVqqf1w8wY+7Bw8KzgLtgNipzb+hGuLMGKtTPQOwVfnwrnsn3xbEXD4vrArfQcJMWS66LyHCiWxnZGENsGWvf/bLzwFasYPEKFBSufu4CGQr9IUXDagkJMwkjaHjVBAJVZGXXUxFP1ZILMOEz7nVhuDkiu8nZZRR+VaoSwrGJdQaGhD67YkPXo57AtdxjcH247cLJLHVsuBQrH7WTJTm/pDbDzBd1YEuG0RMu5PEx5Od3ELM3HtcqB68yfKDpPh4Hw0Qa4R+kJ4vYHwdyeepHoFBEb4+i+iBmOqCprPk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hgrM/YHGxE5euxo7GEWYNhQ23WEZc16LA+ePbBdXIFrfsGvdLg8UBBj1pyIWaoj/x1LnzEscyGIrwYt0DL9dkqJaR+2SxapkLsXyzeTkjYdRU/QZdF4nlO4+dDn0w7dbnvqng7TDSBfO5wR5Vw5PB0uIHTG/IilzfnglbiAQY4GjjGhXA7n/AcRA07xAhh1aBKE00mxQL1aQTvE2JbGtZkSd3t9cm0zDbOAH1vZXNBNFY8R6NIVoMXejW0CVLyhZdKmY85WAbdblr3I/1tlSK9nKAVw4EW9o2bUxgmW71rxlWzFOktRUupw1iI1SJQwbw16hWAwOTkToAOwhjJO6TYSa2LPpc17QnBYunQbCyTuHVQwAihbUx0T665kDnT0noz6s8PDAcmb9FaQdJMhOSs8PeiOOcNYrfZEo6cJILsss98pn/Kdri9nmE+j0l5SU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 12:34:19.5749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee150cf-7da2-41d6-37c7-08de785806ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9164-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CFD451D8E25
X-Rspamd-Action: no action

Add iommu-map property to specify separate stream IDs for each DMA
channel. This enables each channel to be in its own IOMMU domain,
keeping memory isolated from other devices sharing the same DMA
controller.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml     | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
index 0dabe9bbb219..1e7b5ddd4658 100644
--- a/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/nvidia,tegra186-gpc-dma.yaml
@@ -14,6 +14,7 @@ description: |
 maintainers:
   - Jon Hunter <jonathanh@nvidia.com>
   - Rajesh Gumasta <rgumasta@nvidia.com>
+  - Akhil R <akhilrajeev@nvidia.com>
 
 allOf:
   - $ref: dma-controller.yaml#
@@ -51,6 +52,10 @@ properties:
   iommus:
     maxItems: 1
 
+  iommu-map:
+    minItems: 1
+    maxItems: 32
+
   dma-coherent: true
 
   dma-channel-mask:
-- 
2.50.1


