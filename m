Return-Path: <dmaengine+bounces-9717-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ICeBvqQymlV+AUAu9opvQ
	(envelope-from <dmaengine+bounces-9717-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:04:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 830DD35D6A7
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E4C930D0EF8
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E223242D7;
	Mon, 30 Mar 2026 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c/r+pFCw"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168E322B96;
	Mon, 30 Mar 2026 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881962; cv=fail; b=hCedjvtzSEAX854f1iBBXWBt7BixV1UcsZjDbPzvbfTkB83/FYkwWP3uYan9gmHo6GMl+c5GMniV8OZp2yiiGcq06D0hqjNRJbX4vmg9or0o5398pv/prElHhOhbdy+NV9rCCvO6dlPOopwWX/4gIpXuPql7GjhACH4No6DnnQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881962; c=relaxed/simple;
	bh=I9Jf6991WxDcrrVxLgNrTEuMMpB2mQJt80ACs+rMu2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPn/Hwx8rvINFMq+lW4BgnLMnR3dy9gGMFjzuPfzWzasmTo7Z5LdqKQ9/bihbO/OEphti803yx6UYKZ4vlaY2J7jO4wU46ps0njJjMG4PS1BbzlAsnz6ptJ5fve6t+gb7YYW63QLK2rNruwyuDzOtVMnLnVtCDdnwfbhYXLfdHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c/r+pFCw; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3jqkkvX9G/DXra86HcLXRTgTtwIRjtuI7XKfgCsWDdVLgnJJz4ucyp545bVJ/eJzzlWKIhB/Uw9hKwhVUFKno82mkOpVqTVlKDqp3+UsOwbSUDxCLekSUKu1k4AsL4c+KjVbkRQw1pksuaNaCKC5zOH5h4hdN3hZF3NVZ1u1AmzdTaXm4gMmhBr+9KrC6gyodvevKTq6eQgMWSNBW5AFWZK44GVZPSYxrtzD8sqnjXNSMShIKta+kE3kFl6vvkd7kR6nSYQl/sAA3hvw2Qp4ZLRZBcgfIHZfMt3vXoGqbozXYvXmTZqshZpXaYMDuvtM7uXtPJ72VpbBvXf1Z33qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG3HNC59MBDQbzEnowzIv1XlbuWYfwd6rnH3TJgW0Qc=;
 b=vMsNHlC3Df+b7/B0lykLDhpqy2BHu0c37aHdlZes98p315rBBciZ1H9fTvyF/In+NcPy7OixrCdCwc7MmLFP1jkl+jvXkV6xa5Pml6Q5FrROgeu2rlSSYpcexw+e7vPhBlK3C4fpshtzqdq3F+SnXQyZbuuF/6kesvjWEvg+KLKtmkkkYVGyB/FbVmvXtKqj/ZZo6arvMbTq11qUOg1Ve9zJ2VENXA++yTfddjqU86srXFDvzEHHWs0CU94Z1AM1cfxirQN5e1QTyZ24kSfFUl/6twfP/GTplWNE2AfFd406TAqdKdP1ZcKHN/BNsNu4jXUVsGVspgV3FJOBIcKamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG3HNC59MBDQbzEnowzIv1XlbuWYfwd6rnH3TJgW0Qc=;
 b=c/r+pFCwZL7FV4XPThYmMgHlRJ9c6PgCh6baH37ALo/4JyVUyVsrZLo5ygtZ1GFt9ZzoZRKSYzWH5ZMXndgRkbjtuIhK9E55GhXctm8+TRBcGCTU2ADYqSeID30v4a5bU78evNnR61Tsa03LJ5WgraRyunkthd3nB6nrJcptO/7gaWtn49fcd1WEme+Mj/yZuOquF0qhBFJ0HG4u4AgG7y8Exnga0MJ4MMIqszSWXJHVW7XZSDQ9GLMAeI3ZKVBKLsdSw24xUOCL3Y+V54Hby/Flv8laxdyr67DLW+zsprOwNIDJXvxEYejglLk6oQZT1sbQPN6cTQsAter38mMLSA==
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:45:56 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::43) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:45:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 07:45:30 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 30 Mar 2026 07:45:26 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH v5 02/10] arm64: tegra: Remove fallback compatible for GPCDMA
Date: Mon, 30 Mar 2026 20:14:48 +0530
Message-ID: <20260330144456.13551-3-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 229ebde6-3d8b-46bc-993a-08de8e6b0c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/WB1F+CcPv/ABf5tyH2mXQEFi75bIPf3wAeRsl7TBm95hnGVa9D6b+fGfqR55tl+r40QXLUCOIo9d7Z+whrCCVcqdqv/UWZvp6SKiB9RGF4EMgsqI4qY2PVJnB6uUVC5xiZgU/ecMnrdv2+DvSnjdHyiwY7yAhbaChnjsC5kn69QzgjYAU1V3uV19frpYYwJIsbrmMlD7WXg3eihzzoOPDyvq+EtmoKv3yRA3K9jVzaqjnEHt7CAnH7RJRPKJdwbGI8LBoHn+zjBkmREjaJbaOJZiG4fgO0mZk9DNcZ7JqPFcGCsCg9fHEai0WThZG8u514ToECyuQncQwTnrFGW/Y6V1j0tYv9QnltvGyHjJ7GE6iIPhigyJJIjYgn9l2gTkpwHKym7RKT5wRxy5FeE8ZNPOnnM4VA1fuIlDkTutf9cQR2WmwrKc3Gkw8J0Fpdn9l/gbW1gchBxJYIhHGfzr8jQMKSSUsrY+on3HdIFw5oM6buvL1XIHIV745W9kbsS2MarMhNkz1zLkpcYVWYOB6Jbb2cU8Vc3xi10I1rNjK1XHivI4snAymX4ptlakWWMxZi1wnmLxT92sJ1OJySifnDPaBhPaS/YLEfQ5I/sUKNt/L8hxd/nTPPLLsmC9cNZ0BTu7GUEg7NXYrCgELQVzt4MEZ7LYtRgSOEIoULLJndCJZcKpUuiCzpKHFGfYiyNtUvghCwJVt9tVQYuelSeKkDQPGMNJI9d8tl+/s0kV2k82r1h4kVsFe65PwhpS3MHqUIsVPVtJKR0Vl1YoJ69dYb902ZEW2/h6s3eOxROqaAzg1xJLRQu266bMVP3FLuA
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tiPjs+U7hHv3IpYHmzPRJ0mK6MLmY/wzT2Jc5ncw8uV553hMy0dWh6HUJw2wGJhv/sP7Isc9XIzFRbqLHRgSL3s2414MXcyPEY8W1rfHYoSxpBXaZ5Lt6KnV+Xg8BHpSL7VXteXpI6/LQ1IWLL/A2d4IslgGTXUQKIxudgDutH8Bxa5hCqXwcxJX+nYKF0NEiXpOhY2p6EZ5VY6fRQkBZkV0txLTF9GbzTxB571SrFJsjyYUJAaDj7G9EnSPwP/h6GLW8pqx3t73kbEE1O7tr5mKDk0TqCaTene86fXNHrfztal9tq+YhC3KG9Ci34CSXv9vYy6FySQ70HGPQTYxCno/JibyuWE3GKCsYBehGUIAftSk0D3WzOkuefORxuhQ63FSkwQByH8Z0o6NfJb0I/e5SiC+6L8CSATSGYz+JlvBTj0Xs3dtbqKdrIcuvbUD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:45:54.7719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229ebde6-3d8b-46bc-993a-08de8e6b0c1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9717-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[0.128.44.128:server fail,nvidia.com:server fail,Nvidia.com:server fail,tor.lore.kernel.org:server fail,99b0000:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,0.128.44.128:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 830DD35D6A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the fallback compatible string "nvidia,tegra186-gpcdma" for GPCDMA
in Tegra264. Tegra186 compatible cannot work on Tegra264 because of the
register offset changes and absence of the reset property.

Fixes: 65ef237e4810 ("arm64: tegra: Add Tegra264 support")
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 24cc2c51a272..af077420d7d9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3208,7 +3208,7 @@ agic_page5: interrupt-controller@99b0000 {
 		};
 
 		gpcdma: dma-controller@8400000 {
-			compatible = "nvidia,tegra264-gpcdma", "nvidia,tegra186-gpcdma";
+			compatible = "nvidia,tegra264-gpcdma";
 			reg = <0x0 0x08400000 0x0 0x210000>;
 			interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.50.1


