Return-Path: <dmaengine+bounces-8891-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDBiMw7bjWle8AAAu9opvQ
	(envelope-from <dmaengine+bounces-8891-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:52:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7021812DF6A
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A0BB30151F5
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED4A35B628;
	Thu, 12 Feb 2026 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JU15ApD5"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63333A9EF;
	Thu, 12 Feb 2026 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904327; cv=fail; b=amYg4JzmudbBHb+wag2zCR/UCOwknKLTXTd0w3vckqNOTQ1piSEHaFnvIEyL9ha3A7yhZPCQkzTd1tR/P8CwPB135tWGgZbVLyLlRVS7MQrVas+TtBepU0Wx9W/ud5p1fcf3HAmwBHfn6tYUhNlumQfFOO/aIXyqQFBAw1AvT7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904327; c=relaxed/simple;
	bh=IWoqtZBTD2eoLu5cs3FVuGVhU6OwiVSgeLqGXAqkdGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsPEc3b3Nj7xZx/MYPctG1T0zCU813ABtnjuEe/zob2D5k5V6Iqm2pRRM7inSwfPFvosFbl7LYW7NKhwE7r2aWf7PfvXgSA0OxPChT1t51ATZCrPEM5G68ma6Tv0UUnKy4SBWoGaFTEHrXjdpNsbMtUkFNK5zQUx1Ka5Jgp1z5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JU15ApD5; arc=fail smtp.client-ip=40.93.196.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1NpmQAKqxCQj8kOMpSzDZ+mpJIlmjpAJlei9aUJFmtUtyzT/NYf9voS/5UNEmJ0TOlXdIZnX/d1FdPIMcHk+1qmkXFZz3RmyGWTXQl5qV7bJ8Kru9DKWt99r176HiF5jDqmDupB1lSLDCorthumUMEFVw7L6/eEExnUZt/DnrMbPqAZCSUxRy9C+PtvCMqumTXiYKH7AIgLmCsXw69jfftUUa084yzK2MIQS6x0RxZ6nn6KhIxk1m1WPGjSQOzTalK+JIVpO0ZUkkzuJUfyAS0vds8RsGbdhc2dPjReIYXIPPCbn6coKCYfm551LqGyB0zoerfNpYBBZKcYdC40mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjcyfNF4HgBZjo4M8mk6zLrLzMFGWZIrpSy9fmymuH8=;
 b=ulU5yqq9/uIp2km4fVXyyBF7TA64RiTEH3toN/3lEd9DhSaosCD0/JInUHQt16k2kpTUlgJIIYnKKFH/djJihYWCqrz1BHttHvSkxFcuuKQCGDLJgjQg5fIZF3cb1x8IDXA0fxIkKdzg1Ua6VDTLiK4hafPuYd8/Jbu53oG3wX+pdx8sSpPdmWzBbs8s/UWODaAHb956spmMZKTkWTWtIBk/3hvdr5k54o/ph43WMenqigmnuD2K5YjAa1PA5q6dGhwhhOkwLKCA81PiaF5nM0ZbHVNg9tBY51FCI+zoQKcaO28g8lMsDbdHqXv7Q/ZMDBPAjXvecDil9Pfsf4vwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjcyfNF4HgBZjo4M8mk6zLrLzMFGWZIrpSy9fmymuH8=;
 b=JU15ApD5wTwQ3InBMeLOBBgvDzA1dc+qtDuIT/B60i+0hBRVvBt2AJa8S1Zc7LCEpX1vSED8ZMtaUWGNPZnEtQfUNiih+OmO1SxHziZJ3PyvfRG6Lb9JQjGKOAE2R6m/bkCcfwijZ/vFJssPGah/EXtK6NCm6IgdiOZnXBKgAq4=
Received: from MN2PR15CA0044.namprd15.prod.outlook.com (2603:10b6:208:237::13)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 13:52:01 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::38) by MN2PR15CA0044.outlook.office365.com
 (2603:10b6:208:237::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 13:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 13:52:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 07:52:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 05:52:00 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Feb 2026 07:51:55 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <suraj.gupta2@amd.com>, <abin.joseph@amd.com>,
	<radhey.shyam.pandey@amd.com>, <dev@folker-schwesinger.de>,
	<thomas.gessler@brueckmann-gmbh.de>, <tomi.valkeinen@ideasonboard.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [PATCH 2/7] dt-bindings: dmaengine: xilinx_dma: Move xlnx,irq-delay to common AXI DMA and MCDMA section
Date: Thu, 12 Feb 2026 19:21:41 +0530
Message-ID: <20260212135146.1185416-3-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260212135146.1185416-1-srinivas.neeli@amd.com>
References: <20260212135146.1185416-1-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e76433e-62b7-4bf2-aa7d-08de6a3de5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebgpXIDIV42Z9yTjDVFuBf2SF7sBgM+FPqxm6soVJT0OSpLHWvbTUpsEIN53?=
 =?us-ascii?Q?SSBIpvc3lFCTSAI/+fYrPm7Nf0b0Bl5hkngJ8Oq196A+hVIiLhsV92iurZak?=
 =?us-ascii?Q?CDAlWxF4wvcz+g3chEb4dhEZRR4lpbXdN+/s/92i0//UyMG4EHfabRDVAdKn?=
 =?us-ascii?Q?mfZ75HFducd0GFh7j/olOvEDPPovYiEF+CyA5WmOpuVrfStiG9G7Uu6Yhrxu?=
 =?us-ascii?Q?1kF70yT8DIVUaA22UZ2RUEOEMkvt9XClUjnPOljETr3TlK03VDUTN2Pgehxs?=
 =?us-ascii?Q?jyqN8T0K+lDW9nk+iCWepVzRfU3oeqaAM2KtRACziKfuZvyJ6FQAmD2Hz7To?=
 =?us-ascii?Q?C5Cd9Tn+yKVJAWWJSsWl+2OGgbnWL5OgzdkTcXne+sTXzUsZhAqRQAZT5090?=
 =?us-ascii?Q?6fnYg0YJqyjFOUOz0cTLG0Zm+bwHlLuENPaDTJNNsc6mt06gMjwz1/AbcI+6?=
 =?us-ascii?Q?/0vxECiOI3HdQtzi6xQKhKIK4v7m2xHqz5Ru443YCq1tSkTtH+JmuYd9qOBn?=
 =?us-ascii?Q?ToUpFyeSzUxJN6/xQ4yuSRZq8e+vkedjDqNZ//gxPktnA7lwsHPbFTCg7Hcs?=
 =?us-ascii?Q?CazBTdBTyiH28H5puN8NyJXYj1Q++C3BYJ602NPIPnEAYHKXAAZZS+qm13qL?=
 =?us-ascii?Q?BLx3ZjGaANwH4h8jeDfh6hgqAQH+MFs8AgS/Yeo6zvVFIJ2r92vgcP/EoEBW?=
 =?us-ascii?Q?w6bBGZFPVKHPLPJ82f8ApW5Y/zCzjWBs7I/N53ck5G2usB+7e5MWpfYSAlGh?=
 =?us-ascii?Q?dV10199u9/Hlk4yMZ3JdI5egMtyLtKq7m//t75dE+56O/+bvs2C+xsGsPOjG?=
 =?us-ascii?Q?si9eYkTvI/dksKiM8Ti5XTqcNDjv7EWOZZNnFzRgLluB7wE5hAjgZ6Ai3Leu?=
 =?us-ascii?Q?KQzk8JspiUy0npjrTaYY4pJ5T1XDT+15/snhh8zzsBfxPMk6kSGsogyC0cC2?=
 =?us-ascii?Q?PXJvwLW1qJJZ4khaN61gu/CL03bNKAsYTIXuiV4wc94YEIvF4/mTXPOw7sHr?=
 =?us-ascii?Q?RFtaPuE2LFp5KOb6HbAz4/Lg6EZnYB+eJ4gtraih2r3MIVGo6vJ3CLWF66uf?=
 =?us-ascii?Q?omqFAmKNqNhov2cDI92PAd6N6/LRjQxuj9Fog6+AqG/4rZl7ZamSPy1z3YKS?=
 =?us-ascii?Q?3i1iV7xGLesCz++hBqqOsL/HSoI0/UsvbGRpRthobNLKxsx66qzDyDmJle/t?=
 =?us-ascii?Q?7jmrxIz/LBkzMXGsEJhCyM+sKhaLh4wMXazYUqlNigjW3tGEI+p8+oF1qF7H?=
 =?us-ascii?Q?bl+YzEw4O0kflEaDJZniS8GdA5JJk3wj2XfbiwsYCLAgeb8I8Dxwuc4lMCdo?=
 =?us-ascii?Q?byJ+088wj9gyF+c8fEF1c2sDAnni5pz4hKSncyxm/9jau0zn573jsvBF7jpa?=
 =?us-ascii?Q?dD0ydFhVvV3Ww2PL1oGYbzL1pNZi7yYivsaHrD086ZJsU5JVOvttLe5BDqbH?=
 =?us-ascii?Q?fcw1Q85c/I12xhFcaIe54mnAsPr6vmRqoTEYgSZo0CuufYvWckPpgO5R5JoP?=
 =?us-ascii?Q?DDY7B2rumIM+u0GzHSrFkzLWed1ZfYsFdvO0UCrcBnpxMtPudVAJNoPFbma8?=
 =?us-ascii?Q?uqIfgpL5PWC2y+Ukqw7dQxaNDVTjP7e6V9JfoxsUOUiSgq2YjNoYGMaf9huc?=
 =?us-ascii?Q?t7YdA/cNGiobi+pw9f6IF41aKCNhkDLwe8Ac5f3aiMDn/TdFiniCHMJvFT/i?=
 =?us-ascii?Q?hco+iQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3ShoAmoLve90CMknfUxj69+gVZI9BgmmwxYhRPfDn2ScMWFDMlaogrs9eHRU3HMhkFikHCKOtTcBHhNdIZvcyKxzepBZJ7cs6a+iAoJxMbJK67rOPo/kypoUhU5TdrRhuL0Q8DZ+D7O/yXuchN3kVjbULJWX1TGHMB6I9+KTS1fkrg7J+8KEXiW3fmGH5fyuP7tXRbizqONwhkbLNYYRM3Z0r6dxzPKeHGr9U4UUWvgeser9pZGnjnHqEjZA9gkwr7h8EzOXH8wPQ6wI+nWalo9A/6npytxk0DBr+5BZWyDPec40DLM3dxI6iugEd1dWLCQBMU+N6GvhcQUg12a5G5giLtNShijt+vC6QeO2fPv6w8ldH1t8rPuQPCIUumO09Ip1kXlLJb3MSErSKbfucULg4WwSq03xEbYfklFAvfZLTOUeYEJ5GepRCxTmdkp6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:52:01.2924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e76433e-62b7-4bf2-aa7d-08de6a3de5c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8891-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7021812DF6A
X-Rspamd-Action: no action

xlnx,irq-delay property is applicable to both AXI DMA and MCDMA
designs. Move it from "Optional properties for AXI DMA" to "Optional
properties for AXI DMA and MCDMA" section to correctly reflect its usage.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index b567107270cb..c9e75ce23d55 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -49,12 +49,12 @@ Optional properties for AXI DMA and MCDMA:
 	register as configured in h/w. Takes values {8...26}. If the property
 	is missing or invalid then the default value 23 is used. This is the
 	maximum value that is supported by all IP versions.
-
-Optional properties for AXI DMA:
-- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
 - xlnx,irq-delay: Tells the interrupt delay timeout value. Valid range is from
 	0-255. Setting this value to zero disables the delay timer interrupt.
 	1 timeout interval = 125 * clock period of SG clock.
+
+Optional properties for AXI DMA:
+- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.25.1


