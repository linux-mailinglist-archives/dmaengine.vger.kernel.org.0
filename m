Return-Path: <dmaengine+bounces-8890-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GElExHbjWle8AAAu9opvQ
	(envelope-from <dmaengine+bounces-8890-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:52:17 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C818B12DF71
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8C463038F25
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87B0311C22;
	Thu, 12 Feb 2026 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xfQ+37Ph"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F4B2E88B0;
	Thu, 12 Feb 2026 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904325; cv=fail; b=hABzMaY0sx2j6gfL6UiRTvW4ucXQ+cG4FsgjrxGVI57YX9/kCsjKv0vzztOYGtZY93wR025GjdC+oVaSSBNXqy21KSOGPPPdaghNyIZLNkVkls+DzNUNH+e/QVh/5xq8IGB+MjFF4rCR7KObKxKk+Usf8pIrhSZgoNsEup3soA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904325; c=relaxed/simple;
	bh=ty7SMivIMp25d4xhGPqP4p6hPxOI1urx9bXEkiqcKJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djgZgjoxvQE3Cq10Z6mri0Pqh7frcoKbPp/emI50BnM6yMwIYhUYd1tPWsc8dKy6YlZsbr24ajm+OX1bpAEZUxjq86u0rzm+yRBSq6wcyeKEqL2sSE9Z99cFiBtbZoZNv/bzttXCKdSkodWaGiwxev1DrXOPtqS79+wP9gqgVJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xfQ+37Ph; arc=fail smtp.client-ip=52.101.46.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYpq8StXWkkxiB4BBbPgVfeUwNoPi5k/nXkI922GP5zXir1Oh5AiFCAxmmEfsvX+PVry/G+kLVMuqrOkgLtif0K3m1h1AdOJa6geJuYzTQ7czEedQaoaJD4mKrwTyGGj2U+v/fBtxScjYAECzjwpU+4GMy1YAqKcPfaRYpuP8I/G6dyHgYR5H6LXfi7AT4gzRLfK0qdHDn0p75f9mTOBKPidz3QfNwwNBhMAXh3kvNdF6kjkRVPrwPr4IXwL+9irBtgWNV2AWAJVKzD37TREsKVEHi+ibTs/XDplxv0QA690dmkl0S8pOJOoklAk/qbf/Dy4H3Q8qWc28sOXoF4iSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AvqPPEvzc5PIqZz5MMZ/QX0gCTz5ckEu1j2cJ4TKJU=;
 b=b+gH+Fxx/a8jGlZGvQ2WpBQISfO6orrbNrBxI9TekwF9KUijMLPDYQHbRAyrX00lt2I20d6onKgWB/8hpkYup73XKYeGXhDf3YiPhHmwbZOZHz2Zln9LUT+cuUjlYsBU9yeXiOkYrc1Uq3lcsKQbP4Ch+EtjstI8xlGm8PcvlKuAvZ4hoqGzHty54+UVFToNjslUD7nM1Cm9GmFZHL7VHjFJCnuhFS4C1vs6kfT8VC8pBP8NiloTUZjqhFbTRLBeUbvGejVNQTuES2KeRWHLg/1GtOhjHxRVlh7hUB6s87sxyniN+62ZGaBGYeLSxgg5fkQ8+XRWTvw7BWhqNC8x9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AvqPPEvzc5PIqZz5MMZ/QX0gCTz5ckEu1j2cJ4TKJU=;
 b=xfQ+37Ph3INORTT4LNnFG9JYhgQu41Iq4zOZ/5L2zDC98SVpGrU31MAjk+6HNh7zHjBHqIaeYQuuhN+bmKK82i1EY+hMoZ+hwZ4Y+Pe+ru14+BpN//09Ci2jUeS0rtcFoY1oKsPys44p/JPUhAlXxqGT191eBu+RnhxOxm3IUa8=
Received: from DS7PR05CA0039.namprd05.prod.outlook.com (2603:10b6:8:2f::16) by
 PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 13:51:57 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:8:2f:cafe::43) by DS7PR05CA0039.outlook.office365.com
 (2603:10b6:8:2f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Thu,
 12 Feb 2026 13:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 13:51:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 07:51:56 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 05:51:55 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Feb 2026 07:51:51 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <suraj.gupta2@amd.com>, <abin.joseph@amd.com>,
	<radhey.shyam.pandey@amd.com>, <dev@folker-schwesinger.de>,
	<thomas.gessler@brueckmann-gmbh.de>, <tomi.valkeinen@ideasonboard.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [PATCH 1/7] dmaengine: xilinx_dma: Fix MCDMA descriptor fields for MM2S vs S2MM
Date: Thu, 12 Feb 2026 19:21:40 +0530
Message-ID: <20260212135146.1185416-2-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe3b3d4-c7a3-46a3-7c22-08de6a3de32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F7DSA+prYOFnGu+3AOJiwSPJADwGTzV/qDrzrb6sbNJodZh9IyQYHzXFcbfh?=
 =?us-ascii?Q?bfeBT3jFj17Q24WGshv/PL0Lagx0K4wNjWQ3G1mQWYuvYeQ5xxSIKoshvSB5?=
 =?us-ascii?Q?J8pmzfk+ldFePB1lBLqKYOTixo2s6SUEdA5iP7gjdyfWHtoijuiZPK1UpdHi?=
 =?us-ascii?Q?JOc7/P1lpdXHWMXzPW1ZOQD9823CefTstJQQ5T46lryb4M52/4KdPf8x8Dks?=
 =?us-ascii?Q?/OaHfcjCeIuw4T4fwug+HFlI9FIM/fp6hmjybgfs1ADgRJHYRMahM6Qad0vs?=
 =?us-ascii?Q?3llO8XXCpoP1WZYl9U+oOqSzcyaLgGmkj6rNWlwtJtEIXkVf86iGn3dJdvXs?=
 =?us-ascii?Q?YqrZOuSXt2QmUsHRBZHBItbPixOq5dJzulq/0f9bW8+J85P1ftWcP+DW40OS?=
 =?us-ascii?Q?avIWMbRnGr2cETVu7h8MOX4TY/sl1RDlzAgDDWYkuTyKlOeHWc8LyNg7wc+p?=
 =?us-ascii?Q?xSWlpt04kI/f1wxv3DFBkVgZh7EX8d0VyKvSmF/telv4v7f4wuhOIiHE/Jda?=
 =?us-ascii?Q?vvBmNPKhvz68pPz9XYgDGoSw6S+nwhxoa5dtwIhMA1Nj3m5eedA956wEtDJL?=
 =?us-ascii?Q?0C+yzPmJEWf10NvHCc3kpb5qkSNALGQIn1Rvg9hqN5NwwV2o6lHUAr0vGRF3?=
 =?us-ascii?Q?hr4hyvnowzRnVE0vOwRBu44uz1PFLevmjkOYo1rt216yh75cEhwrfrgYGxtC?=
 =?us-ascii?Q?MkysMJngfbWf4lvwS5dauPUjdoQl7Lo3Q0fpBb3FVFV0Kbx4xQVtAFlhF4lw?=
 =?us-ascii?Q?1Bj/o5n+FAMHj5uvY2Zqn9Dwp/AOTGLjyYD8pZEYtDJnId5ok/xLcMmEE749?=
 =?us-ascii?Q?TTTeMQpBOKyuUBC+02/r8GZiVPkUWRa8dhEDVAjWAoDuYhFJKDDMQ+skAUTC?=
 =?us-ascii?Q?pi8LJEWYeDHQsxecz+CzZs8z7M28g3/X9I8bV2/V6KWZ+QxT5E0Z81zcPNEy?=
 =?us-ascii?Q?gVHXxe7r8l0O3SHUH3Zo4AT8MJTGkWiDa3DZpDtFKcqTPicbyfCAzXmerHV0?=
 =?us-ascii?Q?F0W/E8tAyMl08b40SdtWO/wDyQjQAKgh6iGsqITGETQjaC8gu/9IwiVRHa+c?=
 =?us-ascii?Q?KcQ+Bi39IgtaUt9CTWjC2avnlMd86epv34wlEby7zyY7zye9/oOQJk2kneHB?=
 =?us-ascii?Q?mYeGEHpntSGxW3GpHrA1s89wx/D9KxXduxu5qs1O2EaHmHFQMUtUwD5AItda?=
 =?us-ascii?Q?ePEPUemBtjvwo5aNMExndZ7D9UlA0MWsZz1biba9SbH3GV0bJXbt5McGvURz?=
 =?us-ascii?Q?hqJHjjn5+ftMyClAr574ni8GcVjWJWQYhFsRVYuwjCY/dP4YHjdWVv7iXRXh?=
 =?us-ascii?Q?YnsKHQrFzEhUC6ftfMLEji0AzTFqB26RBaVX4z17IsTKHrgWDsZdobYMHGwi?=
 =?us-ascii?Q?YKQGBJsNryqOrVDacbc31d/g+xbrdpsQTuishsEwUIFMHT3hr6hauAkpvAX6?=
 =?us-ascii?Q?OafuegFBcaOssqf0tKBbwi3kEY4K9Zuq1v/+iyXxQjeFwacqqcrtn7ydCgbK?=
 =?us-ascii?Q?Oy9T9wAP297a4qmosOz89fzB/SrjDaQNn1NJr2qacBhGHOe+BSwgUpkIpF+e?=
 =?us-ascii?Q?/+UhRDd8uI/WTkWfXcIrRtMB7thqs3eH6GkD/GTlsbxJXQ4plb1wDAWNq1Si?=
 =?us-ascii?Q?Cf6/P+NAnSQG/0wZRrlaFPdsKF/kTCEEmKwO2Z04q2zNq6+f35ECP66soE7A?=
 =?us-ascii?Q?SnyZlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cm6mA3b5z+EBLWzN3M3n/WoxSN6y4RLvd463nvLe5I5S/8AVeGEe7ZKJFl44V/qPb8+r8I1sLAdm0n6vlfZPCjJfsasJga+lm1ylCt/Or1gnGMncfv6YHjQeraCCJKDaXBVka/kEqeO8MMfzrKFHXABH0dXANfYyn4RD6mQ7f8BIPYm/CSwUhAWE87i78BjkItwvGAddJWH9ZjSq243jadhnd1pHtkYuHEA5EHeRTCarwAo9gNQceTFC/v8/uekT6R7wDS8I++LyU7ei7IYiVqVjsob9rsdglrD6Q3ON5XfqKp0V9qGDkugZ9HD8a32z04yqjSpyw/nj0IAvP42ByfTF9HYTzGeraZAB/qcguOmM3+qHTPPy3CN/CT0Nk0hEpFhSGxGoazBx2TaQn2fr0Ngtj5p7ZaH+pwaBkbCaPEX8TuRW9VjaxjSwJIcpI7JV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:51:56.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe3b3d4-c7a3-46a3-7c22-08de6a3de32f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8890-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C818B12DF71
X-Rspamd-Action: no action

The MCDMA BD format differs between MM2S and S2MM directions, but the
driver was using generic 'status' and 'sideband_status' fields for both.
This could lead to incorrect residue calculations when the hardware
updates direction-specific fields.

Refactor the descriptor structure to use unions with direction-specific
field names (mm2s_status/s2mm_status, etc.). This ensures the driver
accesses the correct hardware fields based on channel direction and
matches the hardware documentation.

Fixes: 6ccd692bfb7f ("dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support")
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 53229d8ebc52..e09a22721c01 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -275,8 +275,10 @@ struct xilinx_axidma_desc_hw {
  * @buf_addr_msb: MSB of Buffer address @0x0C
  * @rsvd: Reserved field @0x10
  * @control: Control Information field @0x14
- * @status: Status field @0x18
- * @sideband_status: Status of sideband signals @0x1C
+ * @mm2s_ctrl_sideband: Sideband control info for mm2s @0x18
+ * @s2mm_status: Status field for s2mm @0x18
+ * @mm2s_status: Status field for mm2s @0x1C
+ * @s2mm_sideband_status: Sideband status for s2mm @0x1C
  * @app: APP Fields @0x20 - 0x30
  */
 struct xilinx_aximcdma_desc_hw {
@@ -286,8 +288,14 @@ struct xilinx_aximcdma_desc_hw {
 	u32 buf_addr_msb;
 	u32 rsvd;
 	u32 control;
-	u32 status;
-	u32 sideband_status;
+	union {
+		u32 mm2s_ctrl_sideband;
+		u32 s2mm_status;
+	};
+	union {
+		u32 mm2s_status;
+		u32 s2mm_sideband_status;
+	};
 	u32 app[XILINX_DMA_NUM_APP_WORDS];
 } __aligned(64);
 
@@ -1013,9 +1021,16 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 					   struct xilinx_aximcdma_tx_segment,
 					   node);
 			aximcdma_hw = &aximcdma_seg->hw;
-			residue +=
-				(aximcdma_hw->control - aximcdma_hw->status) &
-				chan->xdev->max_buffer_len;
+			if (chan->direction == DMA_DEV_TO_MEM)
+				residue +=
+					(aximcdma_hw->control -
+					 aximcdma_hw->s2mm_status) &
+					chan->xdev->max_buffer_len;
+			else
+				residue +=
+					(aximcdma_hw->control -
+					 aximcdma_hw->mm2s_status) &
+					chan->xdev->max_buffer_len;
 		}
 	}
 
-- 
2.25.1


