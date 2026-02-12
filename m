Return-Path: <dmaengine+bounces-8895-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD1kJDnbjWlm8AAAu9opvQ
	(envelope-from <dmaengine+bounces-8895-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:52:57 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56612DFAF
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B5D33014FDB
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC2535C195;
	Thu, 12 Feb 2026 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NSaGnrPQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA3933F378;
	Thu, 12 Feb 2026 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904349; cv=fail; b=SkwKuKIPkAtQr/Vsgfl7gtVCB1Dgr27GoUfMo+CeUSB6zYkQVm2erp2Uzte7zNUb1B5nXDkR6gAIBUMkEOBe4wqwqZJed8w6jZB6bOPIanJoqHkGOhvHyvx92ZbKesoULQtRki7sKVkKdlBgVKOmxSlQF93pyQcf2xtUBTTl+IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904349; c=relaxed/simple;
	bh=qtbkqhiklinBwMwlyf0ImoCTMruur0Mmq7ai4Evz7j0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXC7Q9pGAvTDvxxsK846VRS4q5IbhQVp5ytUC7jDmVCKZLWLo+p++U9BTdjv2p7aSwRGUI/CLbESwP6y4XUj+bVlF60B/Ek1jHgn3rGxqOfQJ9UGJ5n2A65Lbzo5OMRa141OiJzRhtpmlcgrgGWD14PizuCULicy07eWHh+yEfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NSaGnrPQ; arc=fail smtp.client-ip=40.93.194.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmV02xB2lNN7rZGah/OoAVOycThqDfgOPfGqGv6e30205EokNWjyRHkZ5o+UMBYWVGYzf5Ol0q0ADtufT8oETqlQO+qaKZkczU+ZOvb8Cg+ewAb9LPzyiyRUrHvEO3pVwgqJBdj3TMmNNlGRIWh2bG8cozJjNQVvzgqP9ADgB8Vtf+6e8D4jHAnyFYuw1yW7a5RDr+x7EAbnKSipxp/Rgtbe8AgfM4rrGwIr0CLHsDC95Hkp4f8GvZit8m+P9kfPJDzIOymqWf8F5aZdJ8u3YW+XhcR4AD9bsCJJ9FmfPkrKtNeoHbtNMKmo8Q+78lkpuaV5dqHH/g2D+2XpGSzF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euvZtQN0Mmh1HfRjV/8d66TwQcLyFpZ4EC4TyOHtYrc=;
 b=XkJfcXx349oSMVUjIEdA3JDo/YeVn/UCEaZbpNsZ5Fr13Ae1npbsP6xfoQpX8cSAyQ2o5F+d+dQx6FIiEaVuzNXQZ//zqx4usy/wDLE1BMk9fYguDizP5LIQRWQXSqMgzbyf+IXRXftfWLqsT2BC96duQN/Oob4wMFvypyzeWyVk7nsE4ftGG+phHVW4h1jX+4zIA0yQx1FFSlGqWcO5AztaKhnWlxLraAWQoIJ5iW07RKYXG60XFkMtHeFhKFfHn5LfFKrRtHXIpJ8B4/qyQwUwtkS8LvT1YqmY2pG25foRQ5r60AIHEjZC94Kg8GLm1U2mcg1y8b+0OJfg9pVtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euvZtQN0Mmh1HfRjV/8d66TwQcLyFpZ4EC4TyOHtYrc=;
 b=NSaGnrPQ+6O3iXkbN22hzJ0wNDWrBP6Nh9aZJWpBJt84APpfQ3Ek3e/45Bu8/25EnZkgPnXsTPXxfpLIAwiAl2c/j5tMuSbMTGecO6QX7Q0r/eLPjKASHYgQGVbqKlx8j5TNWAasy8fhgj3XygDt2/TUK88zloA2eN14BhL0FsY=
Received: from DM6PR03CA0082.namprd03.prod.outlook.com (2603:10b6:5:333::15)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 13:52:23 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:333:cafe::42) by DM6PR03CA0082.outlook.office365.com
 (2603:10b6:5:333::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.12 via Frontend Transport; Thu,
 12 Feb 2026 13:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 13:52:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 07:52:22 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Feb
 2026 07:52:21 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Feb 2026 07:52:17 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <suraj.gupta2@amd.com>, <abin.joseph@amd.com>,
	<radhey.shyam.pandey@amd.com>, <dev@folker-schwesinger.de>,
	<thomas.gessler@brueckmann-gmbh.de>, <tomi.valkeinen@ideasonboard.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [PATCH 7/7] dmaengine: xilinx_dma: Add support for reporting transfer size to AXI DMA / MCDMA client when app fields are unavailable
Date: Thu, 12 Feb 2026 19:21:46 +0530
Message-ID: <20260212135146.1185416-8-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: da0df808-64ef-4aa3-e1fd-08de6a3df2d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iZlTTJaY/0QF+sjbA3G0duz0U0weyI/KPk4fCwIny2xKZLd60/griq/HvLX8?=
 =?us-ascii?Q?uch/P/3QIyuXoXwU/n301FgnXoNG1sWhaIqPwd8omxveMvghAgqAYCPMdN9Z?=
 =?us-ascii?Q?QMJkOcSJkwANTdvA7/fiD9Ih50xQgk9w9O79j36FsXz+Xl2ZfhdzzvXLbH38?=
 =?us-ascii?Q?jaN9CTke8xyWVu+A6mTvFWpa5DFNFQy2rkjJCipacVDGcUi8/p0QO7K6++aJ?=
 =?us-ascii?Q?0sAa48bBomQjZhhsC7Goi302+jiAV1c+f/36wFSUBnGXkYNKP014JR+cS0uP?=
 =?us-ascii?Q?V/xkXspKbQ1RLZrSrCCwEPy7GEEq0z4EO2kHImN4HpVNx2HA/oc94nSh3WiG?=
 =?us-ascii?Q?p8W+7WJ8xTKFj9p8YT5wgjRSjCVS/tRj4fPKLon9m69nRW8M0LHb3gZof8er?=
 =?us-ascii?Q?bn0m/4IX2i9gWx4x8sRAvCN2oxlbWrYkD0dp+yqL3cqCDx8e2Qli/TqxHW9j?=
 =?us-ascii?Q?L3bwdEVyRs2Hp/WaWjj4g2vk4yEo+6GuClqot4azPanxu7em6ryncEQNkp9S?=
 =?us-ascii?Q?yHV/QySToIAM8wLaVBOojrCvWMjOsgK1PTYvKbw/pocpuWw/nSzZjvL63ci0?=
 =?us-ascii?Q?TU8jcEfus8su4AscUb8b6MbrxMvq6c9UhW2/kfE8vtngPtjkeROb5qy0VGPv?=
 =?us-ascii?Q?dOX/rKZXpe2eF5Jryeo3pQ9EsdBcX10aH/65bkw6brw8XaNWk3MuL/JZbuch?=
 =?us-ascii?Q?FJtuN7ZMkMZoJMCpa1BBdfZaYEriFWUkIDcdYJo4yXij5LHHzvOloOh1+tUb?=
 =?us-ascii?Q?KlRNMa/PxPx5NwYNUZdgW8ZG5vWR4X3x3EMvT75sg3QNXjDXaDciGRjvL3+6?=
 =?us-ascii?Q?JghWj1XBkf6mAJNeslCf4ZzHd5lkAPo2kIqTEhWOesgGK1Oo+wZHmdW2nrDr?=
 =?us-ascii?Q?dV5IsIeVFAh+jxBChFX4yUQqg2gU+OWp83sZge1jy0lQN907O9dMUOQeK89P?=
 =?us-ascii?Q?36Uhx21lBm5Hdnz+Re1dAdPSlJez3jFFtYNZoiX2uHGaSoKhF3IdRrLsrW6T?=
 =?us-ascii?Q?Sp9U90M50UUEoahnM3NYFOsgXoLvbSDBXzTPvF4l8JipxPXPp8iOSF7LDpWq?=
 =?us-ascii?Q?LCIkH5oZ+kHSVdadB+L97oIGCI7v24Et5rcfyA7zNxEthANRZTXkdtqnGYga?=
 =?us-ascii?Q?vUVbLvgaHu+hzwltWm7Kg0qJ/9NUGJ2X3ZeBjzGiC024B7omUquI/tgkFWHc?=
 =?us-ascii?Q?ESuUANxkzFyaO5q/4RhZLlMf0yHIifLrQplLpRQOe45EtozcUBaWFtxT9G3U?=
 =?us-ascii?Q?3a2ngxNl4ZDaDdx6PZv71Qb7SfNdtX/Of9iNAajv/Zt1ePxU2NrKxAeKfoJr?=
 =?us-ascii?Q?5LGAtUN6Ddct2hkIDdZ7VsmZudW/gTgvTc/U9Zis1LHSPfG6tbbdVDZi+wLw?=
 =?us-ascii?Q?D5ug2uS1qqCBcsLmBPGl9MEXcEWwisN5I0ujbv3lt5VvOXVIttdfpuUidvCU?=
 =?us-ascii?Q?b+bgqCd6I1/BOIwK8AJXDo2peMYGWtNSsJVTdpq6JhZ2XkhA6cDm1Rk8tq6h?=
 =?us-ascii?Q?JbC9ygWK9skEJYnWkzeM9evQBkHlcM9dpAUET85EWlfVNh8XBskoSHxekugF?=
 =?us-ascii?Q?jMCPyj+HNERrT2aG3FPC25M1tvXaWtP+3hk61cfX5IiVDVpq6DlyeJcfUGDq?=
 =?us-ascii?Q?CQ3iUA4HqkGyQdfyF/P1bs3X5HMJhq5NxK5L2V2dPL5om39Z4QSE+hG92Ibb?=
 =?us-ascii?Q?ibgDPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nerXktBekIzuVqrRlOcaJE0nKkXra9nagH3Sdr0nN87YDK/v2YJPRmy8+CEwi23nBKmVjaEzi7YztxdtfBG320iKLHPSGLTO6QcEKzvdXI2vWkb52Vj4XNlhDpn1K3FBXQjjPmxBSW7h11KZbUrDTOiQz+rpdzMCs8wCmOEyhCjBuXmmrp2IiWHLwleopj7KlV8j+7/sPai1apOhaM/I5jM4xG4N+YlV7XTfo9V1wHbh4HC8TV1wbUs1jRwOnMUbO58nmp6TlT9lgn9TfvQgM0rbmnk2Sl+3tMZscK99wplCLZCJNyN2nFN0qkZ1JP5GOcQ8dt6pVFJL6AhAiz+RI1aeUt3i0EEbEFa56ZWDP8anl5VlG39mp1aYTzIzgVJy1iAgTEErmv1lmPx/mzIFVsCNdU4mjPXOnzmo77T4RdqENM3nP/qAgGnFmwGpYMyK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:52:23.2114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0df808-64ef-4aa3-e1fd-08de6a3df2d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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
	TAGGED_FROM(0.00)[bounces-8895-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2B56612DFAF
X-Rspamd-Action: no action

From: Suraj Gupta <suraj.gupta2@amd.com>

The AXI4-stream status and control interface is optional in the AXI DMA /
MCDMA IP design; when it is not present, app fields are not available in
DMA descriptor. In such cases, the transferred byte count can be
communicated to the client using the status field (bits 0-25) of
AXI DMA / MCDMA descriptor.

Add a xferred_bytes field to struct xilinx_dma_tx_descriptor to record the
number of bytes transferred for each transaction. The value is calculated
using the existing xilinx_dma_get_residue() function, which traverses all
hardware descriptors associated with the async transaction descriptor,
avoiding redundant traversal.

The driver uses the xlnx,include-stscntrl-strm device tree property to
determine if the status/control stream interface is present and selects the
appropriate metadata source accordingly.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 0fed6bb1b354..651a360a0afd 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -380,6 +380,8 @@ struct xilinx_cdma_tx_segment {
  * @cyclic: Check for cyclic transfers.
  * @err: Whether the descriptor has an error.
  * @residue: Residue of the completed descriptor
+ * @xferred_bytes: Number of bytes transferred by this transaction
+ *                 descriptor.
  */
 struct xilinx_dma_tx_descriptor {
 	struct xilinx_dma_chan *chan;
@@ -389,6 +391,7 @@ struct xilinx_dma_tx_descriptor {
 	bool cyclic;
 	bool err;
 	u32 residue;
+	u32 xferred_bytes;
 };
 
 /**
@@ -515,6 +518,7 @@ struct xilinx_dma_config {
  * @mm2s_chan_id: DMA mm2s channel identifier
  * @max_buffer_len: Max buffer length
  * @has_axistream_connected: AXI DMA connected to AXI Stream IP
+ * @has_stsctrl_stream: AXI4-stream status and control interface is enabled
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -534,6 +538,7 @@ struct xilinx_dma_device {
 	u32 mm2s_chan_id;
 	u32 max_buffer_len;
 	bool has_axistream_connected;
+	bool has_stsctrl_stream;
 };
 
 /* Macros */
@@ -672,8 +677,12 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 				       struct xilinx_axidma_tx_segment, node);
 		metadata_ptr = seg->hw.app;
 	}
-	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
-	return metadata_ptr;
+	if (desc->chan->xdev->has_stsctrl_stream) {
+		*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
+		return metadata_ptr;
+	}
+	*max_len = *payload_len = sizeof(desc->xferred_bytes);
+	return (void *)&desc->xferred_bytes;
 }
 
 static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
@@ -864,6 +873,7 @@ xilinx_dma_alloc_tx_descriptor(struct xilinx_dma_chan *chan)
 		return NULL;
 
 	desc->chan = chan;
+	desc->xferred_bytes = 0;
 	INIT_LIST_HEAD(&desc->segments);
 
 	return desc;
@@ -1014,6 +1024,7 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 	struct xilinx_aximcdma_desc_hw *aximcdma_hw;
 	struct list_head *entry;
 	u32 residue = 0;
+	u32 xferred = 0;
 
 	list_for_each(entry, &desc->segments) {
 		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
@@ -1031,25 +1042,32 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 			axidma_hw = &axidma_seg->hw;
 			residue += (axidma_hw->control - axidma_hw->status) &
 				   chan->xdev->max_buffer_len;
+			xferred += axidma_hw->status & chan->xdev->max_buffer_len;
 		} else {
 			aximcdma_seg =
 				list_entry(entry,
 					   struct xilinx_aximcdma_tx_segment,
 					   node);
 			aximcdma_hw = &aximcdma_seg->hw;
-			if (chan->direction == DMA_DEV_TO_MEM)
+			if (chan->direction == DMA_DEV_TO_MEM) {
 				residue +=
 					(aximcdma_hw->control -
 					 aximcdma_hw->s2mm_status) &
 					chan->xdev->max_buffer_len;
-			else
+				xferred += aximcdma_hw->s2mm_status &
+					chan->xdev->max_buffer_len;
+			} else {
 				residue +=
 					(aximcdma_hw->control -
 					 aximcdma_hw->mm2s_status) &
 					chan->xdev->max_buffer_len;
+				xferred += aximcdma_hw->mm2s_status &
+					chan->xdev->max_buffer_len;
+			}
 		}
 	}
 
+	desc->xferred_bytes = xferred;
 	return residue;
 }
 
@@ -3284,6 +3302,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
 		xdev->has_axistream_connected =
 			of_property_read_bool(node, "xlnx,axistream-connected");
+		xdev->has_stsctrl_stream =
+			of_property_read_bool(node, "xlnx,include-stscntrl-strm");
 	}
 
 	if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
-- 
2.25.1


