Return-Path: <dmaengine+bounces-8927-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAr4EFmnlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8927-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:37:29 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693D14EA7B
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01BB23006907
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3F1371065;
	Tue, 17 Feb 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iI45BF76"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B637105F;
	Tue, 17 Feb 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349842; cv=fail; b=Qf8b9n1farbEJT4+D3LFKh09a3ulJXAL6QV84/JLBmqEeG9v374ZXeMl/Wu2qgdFUFCH3pOgLLH8cJN9TE417URFP7LvO85mUQ3cUNu9i/4ooHpa1VOnT9uzkVrf3Msn254JZWXgXM+m4oOD57KdL/sUG5IR6sLgzQTG2mwj8C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349842; c=relaxed/simple;
	bh=X2Lk/VCr+5ARHSYFU+/+CJh33JtHpkHjBRwFqfdoBCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hULDVDxP8NsmZlIVsKbAShPlgx0lVH2Klgd+VW+rJWVz2jvWT2CBIO9edzr9Kbc3MFXBOsxCijsmscMKiweph1cp5jmXvGBYURIWb1DhqEPzy3T8oZvnNW+pMc0empJxo6uoyPxzIMlvAWutPQDhEMAmKMuEnSKAu3OoSoGT6pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iI45BF76; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzZxJnMtY/louqk+ILzyaArY60mSpaZPInhJ4mkjA8kqOht/WVu7g0rUQfNGLk75GZBuoBcKW4eZvYi1VrFiABRNtBYo4TsRc5VPKHqISwLBm3nwAiSCsBIou/zTXFzJXIw/QZUXQnLKQtwKJn9uW7EwFRmAF/N9rTk1VY18wBaYVtyxT7fSG30TO8L740HJvbovkcXS9WnpdTwgI0hLtGQ66RQmmnQGUOTzgYRLsYdjbSaPthVNVKKa3L5J5CdGQEbpw4IIEiaSBe79fyvCbqVRAuaNYqS/GnEtEAeKKqqgW8N7YodS61Y3phGJHVuLcXi9exTSgkprxfbtvoXXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNvf8YXXR41tQpXIKcz5z9EU304AdrvbU+QfhjqBDJI=;
 b=aGHLo/Fvq5M4hE3nm7k/4vTXC6Rw00avR/CNnEpCsBl4FMrf22b6ZtbNT2HBen5sAeHpS2D1QjG+ALgh9gb9IvbLKdm+TvOddj5dUxxD7c8+ZrKrOhkrqw4yLm8E+sGz1E2kk9yiKpIxgaU7bho/KXoYJpWNajZUvulO3GEzxT8GUEqZVvuBB1oKZRW0xgqeDhp90ujoXnyanlq8DF6pn8bZeQDVBl/CrKvffgFRpjNEC4S4etTqohv7CgU/YpWc9VtNjSqnFs/Ngdmi6k5rkG4wBJLVeB/M28v4eIBzGZi9hhfFQiJO1YgIw6RrK/SZHTutHWK2Dvic4yUBXeDhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNvf8YXXR41tQpXIKcz5z9EU304AdrvbU+QfhjqBDJI=;
 b=iI45BF76GoUEOlpREUXDQcsTYYz7wJb/OTBzYwDFAP5KtPvTOT0NqnIadx54XHlExs6AyStG5IK3rFcME59/dhhUfZHUi8Nbr0gmq8cUsK51t6hWrLHXmuK1vMOVI+B6GZ28YQ4P7xzCt+0srZq2WzpIg/lfyqAws7jA2Fpexxz12w4C92nMGcX6BRAlQ+cFyxa6zipvhU5NyMcnYMVL42Ua+QRmpIrkQLzviJ+7sNlanZCg5OOVqsujwyWBQfxcu+W/Kk5Gh2PS29j6p0iuNhcY9j1KS1tLKPswPI6kk3nKpqSNs1vJVe+s/2bqBasAnoZCNWUFN+owZ552uOxMBA==
Received: from SJ0PR03CA0120.namprd03.prod.outlook.com (2603:10b6:a03:333::35)
 by BN7PPF02710D35B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 17:37:18 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::3e) by SJ0PR03CA0120.outlook.office365.com
 (2603:10b6:a03:333::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:37:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:36:53 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:36:53 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:36:50 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 8/8] arm64: tegra: Add iommu-map and enable GPCDMA in Tegra264
Date: Tue, 17 Feb 2026 23:04:57 +0530
Message-ID: <20260217173457.18628-9-akhilrajeev@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|BN7PPF02710D35B:EE_
X-MS-Office365-Filtering-Correlation-Id: 1066cab6-c3d3-43f1-838e-08de6e4b3232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yw1bX8HLhBGtwJFEvnZTUN2vffTzkFgL5bJanCGKEx39N3r8A3zEFJvj3bNw?=
 =?us-ascii?Q?6hEzHtetFe1BP34J5IW7kTCFzhmsP28mxsWePhlfB/eis30riSUsW747VmtS?=
 =?us-ascii?Q?Za6iOv9yTzTN5VIaXyc+4VqaFaJaFPusIQHATWVdF4ZjAIC128NKihiToFpx?=
 =?us-ascii?Q?Vp+pHNzlqhcLHxRj8vwiGhq54OO0Sd2ZRmtqMotTW85AHnL4C5aWBZbNOjFV?=
 =?us-ascii?Q?8pFWO8I3FO/4rcUVlJf4QycQdHktru9yuYwqW/BYIR+azlX42nyePpjtf+zU?=
 =?us-ascii?Q?YMKUqkUeWdb0btUG4yX43X/XZlpfS3/R7gTpX486vg2O5xmyORziQ+Jr1UTx?=
 =?us-ascii?Q?JxPsCHPpDki3SH1EGuVePQQOISoHdZPM4Th5UJKdOT58Zl6ZWJ+IDz3NfTkv?=
 =?us-ascii?Q?Lj3Htg+r2MDjrjZ0A5Wp7diRJlB7BF1wQ79HjpMxbkvWO9Z4sCyFtR5fZ88D?=
 =?us-ascii?Q?+YrWTJmAqgl2fjyP0Wm6gKvqCnueI9n29ZqntUa4vmNZ1q7n1gyjoV+bFH95?=
 =?us-ascii?Q?gkAgC+L8XmTHow6BL/WyNNm5t6b6rc+zSg3ZRRdurT4lKtWiVqnxWrWHGONO?=
 =?us-ascii?Q?ywkJR8hHNi9cDKrIZ0hRjDa8xzlffE5u9eOGxzAuzd/V21xZOXVjydgkrY6N?=
 =?us-ascii?Q?WIyY8pTRblUSne7EnRyow2ycbXxgfC+gvoqIhj94DhFs7YAfmXXppEKb15rM?=
 =?us-ascii?Q?SFLO4qEf5CZ0yvOSvnBKb6arW4zNahf5ceK5nxCzGFRn7n0m8MCcLPwe4nJT?=
 =?us-ascii?Q?56SgCOlvM2s/xQtRwJsCQ0tYt4j1DS0aGVd3btorQ4mRHEKiL92hVLaWvy2m?=
 =?us-ascii?Q?JaCUn1sBFUXZkBGx+ZYfhQJZNmEyRmb51VKfnfmwllsa24h0g6KxF/TzSkMH?=
 =?us-ascii?Q?AljQ+ld74oq0i2CyE50tPVRCbVPu0QDTP/LSeaoeNuEnyYJxVGeeN8kLbhph?=
 =?us-ascii?Q?iucQ0LGBIVhQhODZZz0pLnZDHDk0iJteg/cceKxaOEDpA+ic5ivccj7XCGpq?=
 =?us-ascii?Q?ms7RAlrA9OmgJdRXZv6ehy/GKb802NDwKk+iBzreq8JvXjwUotGnZhzrsUUT?=
 =?us-ascii?Q?0C8bgXm4sR3K4tpqIi09qd/6XovnPXpiayeP6NqiEmNYyl305C2GrlyjxlC2?=
 =?us-ascii?Q?jhHcQc49VmwkmU+QurDuNxZpZYduNNqJn09jtRg6xiSGcCD6tLy7uWjhCSzP?=
 =?us-ascii?Q?NNrNkMFlOH01PjvqJREYvchQqNRIvxF3kkAxe+uSK54r65U2BqGvsW5SnzNg?=
 =?us-ascii?Q?jW2gwPOOowPTRvteAGvk3FgdCzJGueXmVynLKjjBoqFg5nKj5zaLsYYLKksJ?=
 =?us-ascii?Q?EkgL/1f+iQVkaUgyjL8689ZWA+bGZivy6k/tWONMDdAu0zttiQIpG1SC5E3W?=
 =?us-ascii?Q?wok2hxbj/aCBU8HgPXdjFF/X2LEWn41hAVsR7hCLib4iZvV+2Zb+JupBTORp?=
 =?us-ascii?Q?Lvw81fuh/WIsY8BpBTYQ7aV5XI/7yg00bW4aWw2Ll/EoKiwFzS8t5KvtknwP?=
 =?us-ascii?Q?On2nzh1tL/0d0oFBktfhQn08f5w601KoaHlGM6M7kjt0CLVITCqLNMBxIrAv?=
 =?us-ascii?Q?g2XMOxXAGZqa4qqi82xSfxDE6UFDJ8aFUZGanDYj7mrXMQ1Q4PsbHJr+zTuz?=
 =?us-ascii?Q?KY+hu4MVkRuxlcu5prs25xDx6ABhaBxYyiJ6BI894kv4sKT/NchqER1jfvo/?=
 =?us-ascii?Q?g29Kaw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rIRS36lDqPyOYO8dPm3e5zbzMV7NrvHl8+rcZTVlPnB137eJqFFmQLou5xi6W97xyumtPmavNSAXEYqeA8m8J/iuWDJiuBN2GVfkMvhiBHC2palLvXjVFfgqjvC+3wyX1xqTOsfo7fy+UQCKMiwHW7HtMXZnREz3hpVQYv0I3p2zOZiD/zQsA8TQvAt3EM3TfkAS7gHLZfUbn2tvjbvBINOMYnu/2o1leNDtdAEuSBBB1q+x9nUIVC7tQwS8oMHXt1N6eVsix8f/D/Wvc1c6rAtmhzcPKYgUMoQYtXbXXYjALSNJplmaSMBLoNskST2cni44/WH2vUF0HJyqtJ3AMMJ+fPCdb03tJR5znK5qfKm0kwDRRqRfOtZFRi1Iai7pu9I23E1a2D2bij6ts+W2/iyrIin01OunzX/Ed3WdF/q5OV9mF4fCf7WMjq4yHN+s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:37:17.5967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1066cab6-c3d3-43f1-838e-08de6e4b3232
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF02710D35B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8927-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c4e0000:email,0.128.44.128:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_PROHIBIT(0.00)[226.204.49.0:email];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6693D14EA7B
X-Rspamd-Action: no action

Add iommu-map and remove iommus in the GPCDMA controller node so
that each channel uses separate stream ID and gets its own IOMMU
domain for memory. Also enable GPCDMA for Tegra264.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  4 +++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 33 ++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
index 7e2c3e66c2ab..c8beb616964a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
@@ -16,6 +16,10 @@ serial@c4e0000 {
 		serial@c5a0000 {
 			status = "okay";
 		};
+
+		dma-controller@8400000 {
+			status = "okay";
+		};
 	};
 
 	bus@8100000000 {
diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 7644a41d5f72..0317418c95d3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3243,7 +3243,38 @@ gpcdma: dma-controller@8400000 {
 				     <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 615 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			iommus = <&smmu1 0x00000800>;
+			iommu-map =
+				<1  &smmu1 0x801 1>,
+				<2  &smmu1 0x802 1>,
+				<3  &smmu1 0x803 1>,
+				<4  &smmu1 0x804 1>,
+				<5  &smmu1 0x805 1>,
+				<6  &smmu1 0x806 1>,
+				<7  &smmu1 0x807 1>,
+				<8  &smmu1 0x808 1>,
+				<9  &smmu1 0x809 1>,
+				<10 &smmu1 0x80a 1>,
+				<11 &smmu1 0x80b 1>,
+				<12 &smmu1 0x80c 1>,
+				<13 &smmu1 0x80d 1>,
+				<14 &smmu1 0x80e 1>,
+				<15 &smmu1 0x80f 1>,
+				<16 &smmu1 0x810 1>,
+				<17 &smmu1 0x811 1>,
+				<18 &smmu1 0x812 1>,
+				<19 &smmu1 0x813 1>,
+				<20 &smmu1 0x814 1>,
+				<21 &smmu1 0x815 1>,
+				<22 &smmu1 0x816 1>,
+				<23 &smmu1 0x817 1>,
+				<24 &smmu1 0x818 1>,
+				<25 &smmu1 0x819 1>,
+				<26 &smmu1 0x81a 1>,
+				<27 &smmu1 0x81b 1>,
+				<28 &smmu1 0x81c 1>,
+				<29 &smmu1 0x81d 1>,
+				<30 &smmu1 0x81e 1>,
+				<31 &smmu1 0x81f 1>;
 			dma-coherent;
 			dma-channel-mask = <0xfffffffe>;
 			status = "disabled";
-- 
2.50.1


