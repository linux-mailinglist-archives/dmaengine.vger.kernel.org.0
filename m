Return-Path: <dmaengine+bounces-8889-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPsNEUXbjWlm8AAAu9opvQ
	(envelope-from <dmaengine+bounces-8889-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:53:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C67612DFC5
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 14:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE376301E226
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE6B2EFD9E;
	Thu, 12 Feb 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KiAmXOx9"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4E2C11FA;
	Thu, 12 Feb 2026 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770904319; cv=fail; b=bPuGMQ3adt9XpTLP5xp/MoTs/Sd2O9o5ym4S5UTF6gHLvlUf0SJmomoxRZXUCW3v7Jpc1nYPay5+9e9mudUcyHir7sY89YVRRcd6kHjvpL6XVx1cogYuuK8OZz75Y7a5WyiWqJlf7NUKHD+DThWdALQFUMjqLx2k29imHNOMvVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770904319; c=relaxed/simple;
	bh=ERC0qmw9tPi2/stzsT/dzAxoF01ScJ9TY/k1qBvI5dc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6dQhvpHpX90Lln3oovqbpDUUXkdJTMS6jajNcKKSA5jvFpnQszZ3DnimSr36yLYJcYIA1eLY1KSBUNnkwXQwYW5sZ7FgwwS5wOdDgDYl8g7LvGrlviHCn89vvHYCr3nDKCJigwSX6Sa7uNl5GB64wluo9ss6juty5mN+yBtZNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KiAmXOx9; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YV2RcD37Oocg75TyKhw+nBxN2/87qgGZTA7iyw+U7FzCAHsQ6Bua3FRoBq6fdBS6zo+sV9hsr0mvq4fy9P098qRqGgdYq+lrYEsACaz9UFJHWh9jEx5xMcyiQy9IGA4lACFaBXFkwZbdBOFpHHFGfPE4Eo7dkq4ozjdzb15R1vwLnhbn2z5vD5FCqpKs1iAVauOtP8S5xdWott3UNucN0bfJpf4SHvrBNBnACmrMegNjlMJVy4qHhZiJ439VDEddb28BSk/p5ZF5Lnl4FGh9KHx1ScLwaaO8eiw5QaYKHE1o5qudJeCziRlNOJMuloDg++THJEveSzEpqBVWIm5Bhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOYP+NrbSKSJ2xwbOPy18Tp9g1EeBa641K6M9Ox0AYk=;
 b=YTpMtaEGanas/L711C2UOsWzayVDL5dLXffzQlmjee6bIEst1eOaByHukXf2v7EA83qKak2lUJI4DmIpOWFIDiae6prdfbBWtuc9wF1EMFtWgUfdFNyuhC2pdQ4jMt+VeWnENpz/VuRVibJVjo1rJekq8wHJLnHrvLcCPBCu73wchsrTWufsKNwuN2ZOnKg9LfqEDB0j0QB5gW2C0BX8apbc/4m0bXXpF5M0e4VcfLb7ngchv82KfRyDdO+2bSRPlznY6/KaxetAmh3sg1qZ1nfvVW4LRtLfNuSQF3JJM6jxNgE9UlZSHbqdydkCh8OBcSU8NZqMUQF86aC+wd73pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOYP+NrbSKSJ2xwbOPy18Tp9g1EeBa641K6M9Ox0AYk=;
 b=KiAmXOx9VZq9+9MfOASXfrD2QwcBQirG+bqs/HeciEN8HEsWn0V3c7JYzzp61tRKJOwoeYFZHr35XEms8hYHMfAGPtuNNC0hwVNkQVxA72fKOhrqIbHdvmXqGJ5QKKzutMkzwN0heHcVH5tVxfw7DqHX7n6zOyKAqAZsr9z2jpU=
Received: from DS7PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:3b8::8) by
 SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 13:51:54 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:3b8:cafe::af) by DS7PR03CA0003.outlook.office365.com
 (2603:10b6:5:3b8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 13:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Thu, 12 Feb 2026 13:51:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 12 Feb
 2026 07:51:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Feb
 2026 07:51:51 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Feb 2026 07:51:46 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <vkoul@kernel.org>
CC: <michal.simek@amd.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <suraj.gupta2@amd.com>, <abin.joseph@amd.com>,
	<radhey.shyam.pandey@amd.com>, <dev@folker-schwesinger.de>,
	<thomas.gessler@brueckmann-gmbh.de>, <tomi.valkeinen@ideasonboard.com>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [PATCH 0/7] dmaengine: xilinx_dma: MCDMA descriptor and metadata handling improvements
Date: Thu, 12 Feb 2026 19:21:39 +0530
Message-ID: <20260212135146.1185416-1-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: srinivas.neeli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f338e1-f040-4b6b-72fd-08de6a3de107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2fO2bKM79ELmk/ki+2RoW21MhLzjpk+W63ahJw3dUsaugHmG/wYDYPPHEPU?=
 =?us-ascii?Q?2fYePcIaBDA9dfLXDzooApNza582xOJ/+hsWNY8qynfl1NSDvOCfO3+2xGCF?=
 =?us-ascii?Q?8f9O5Ue4V1n5DSwubkpCO9+L26XfIOOjNVR4UGm+SriXN7LnWz88g3knqDyU?=
 =?us-ascii?Q?QRZp3q3HR+GuDHmFq+O07kMq28McAZDdC058p35UIsueqr787nRsq4R+sAmj?=
 =?us-ascii?Q?LSzqbD/cp5hQWCb9jj+1U2mcDO0GEZkjAvWM77kvk57D4LK1B9ULmE5Lq2aN?=
 =?us-ascii?Q?dw2Z34zyltNq+cjuFm1lwT74nL/55rclEKNmxtRUzK2a7QwkCIyIrgvBxdLN?=
 =?us-ascii?Q?W0bYbkZORab5WMjNdie4EHCVwde7FAopA9xsoSk7flkn9tlzXMRtRfxrFXXf?=
 =?us-ascii?Q?cXzqnLP6a52WnmhV2PyXjeASE8M/WcUL3SMKte293kojTXBCZjzOY57KJZHP?=
 =?us-ascii?Q?3Vu3wpFbaOEO1pxCOB3ueRyeYaK/wzNsEyeC39QRf9/xXUh1YxiAZJxQDKxc?=
 =?us-ascii?Q?DkZQ7dPH/Tk64oo8aUtYUAJbIGzQO6T2ci4ig6+4UUt9Rp+tnHZrkUIh6hol?=
 =?us-ascii?Q?Gt/6FZKYn0BTlvquaA+0mEAB5H5ErAWqJXe6J6laeXY9GuT5WA5JwtLtpGKC?=
 =?us-ascii?Q?v1Yfr3CZpY0H7eUyS8B82boswm7/Ia/1mFiI53Yrx1fqNOiQicyH5/Sww5KK?=
 =?us-ascii?Q?OFE7yMpOK8AemUKVRJtUdKW+cAt9qhikUTPlo/ZWz3NXqBmVtkNsl6jth0LX?=
 =?us-ascii?Q?Gmoqoo23V3U/YWQCGS08lU+E70wrP8XX3HhOzIP5lv2d2fhVGfkaUApbr4AM?=
 =?us-ascii?Q?sc9kG54RNQkZY6/mDYim+ieh6np2owoEn+V7FFvP8gEBlySilYZaBpyBmGuh?=
 =?us-ascii?Q?yf3GKPuy6uFtbwlm/L3SRIcdpT5V/rgfduav92B5ZVPzXBloJrOG4aMYnP3l?=
 =?us-ascii?Q?tKSZjLU+wyMDk6VxEVCSpbYKGyPX21cSgOB6CZxXgS0Sw0aLfufDyaHp/yoK?=
 =?us-ascii?Q?Hd5wqTnxO+ccfJJzGqnXxURpfJjRQoYJIlxgOWz9B8EF85fd+/zN57mU+hEc?=
 =?us-ascii?Q?aJiZ3GV+0gOz3IXdVmt4VNEFdGxmJ0iXzKm5wXHRImBcr51xlz9Xs2dEs20V?=
 =?us-ascii?Q?tYfM1HM+/6uVwa9d5LLYTeNoFLVsw7PzK3qgVi7tUkeB8/uWDArVtwg7lA2E?=
 =?us-ascii?Q?LUaibNutIB1VX1ywu9Vhmp8H8FcvtaKTRbbuFtMDjoaY4jNdyAX9BUtHmh3V?=
 =?us-ascii?Q?i5RPNZnhAYbjjlbpGcRN9X7SQhq/+fRFkG7uUH/ffzgBhFdtvGt6Qd6qOUbb?=
 =?us-ascii?Q?TqUYb0lSUKHpkLswg4utxO9sqEjrPQpvHN70B15h26tBvftOdcwPojTG4/LN?=
 =?us-ascii?Q?Y7iOzTpSHeGJg8GJjQufq8QFfysz5eeBIzPeIaXb89mSSdYB2CikaOFYSgHH?=
 =?us-ascii?Q?blXndlsC1H0YKnAEhYRsvpWHBIUIIJ6SkVlkD3pOlllIxMp9jh3Egb5IvEG2?=
 =?us-ascii?Q?9AzU/rwSHhzA6RbUSwboHJ5iugLClhGXauzarw3wy81HbyQyV2JSLIbCedBd?=
 =?us-ascii?Q?tAfASE+IhMM24JeLArcK2fB6sCqCnU/LbjD1hKgvTeXT9QdN8eK91r+9oiTX?=
 =?us-ascii?Q?aRXca9R1EcIO6QIPSvDjiQTRp2DKpSlnzR5gRDgtW1wb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4F91E93TUSnzvQiUmO4vhztizxF1Jv4z7W1PougGddjYniddeGQu0H1h3jSv3lHX/L/KVAWJzY0W6B8m/IEPGgWVUj5vdDXhhE9Jzw+Cfu8y7BsVs5OTe+fDpnLJTdr/PYf1UuSPWWNnmlenzoMpHdYBIUUBoz+HfnSd5WpyDakcBxz9kas7u7ma82CmeneAc8TbdgtSkkTY9wDSr+FhgTmAAlEmX89DZmZIMYB5JgqPeRTOU1Xy4btn7liFuDqSDGfMFtj0qSsSCBrT9XbXop43hzKNH+vu7obrUAzMbie/Lq8DP6vJpYpgAJqeMc9zjEKtUEw7uKmG7t385DHIkjrg77K+aQQk2mGKuNQBIsX/DdGXfbbndiOvc2bz12Z6ljhfYwfu+2ocaiINyq6eEDqV5/XfGQhFU2MG2iPJWDiAYcgrPxK8xjZfY5wEHSLO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 13:51:53.3565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f338e1-f040-4b6b-72fd-08de6a3de107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8889-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9C67612DFC5
X-Rspamd-Action: no action

This series improves the AXI MCDMA driver with fixes and enhancements for
descriptor handling and metadata reporting. The first patch fixes a bug
where the driver was using generic descriptor field names for both MM2S
and S2MM directions, even though the hardware uses different field layouts.
This could lead to incorrect residue calculations and descriptor
completion detection. The second patch updates device tree bindings to
move xlnx,irq-delay to the common section. The third patch adds proper
completion bit checking for MCDMA descriptors, which is essential when
interrupt delay timeout is enabled to avoid prematurely freeing
descriptors. Patches 4-7 extend metadata support for MCDMA. When the
AXI4-stream status/control interface is present, metadata is provided
through APP fields. When this interface is absent, the series adds support
for reporting transferred byte count through the status field, enabling
clients to track transfer progress in both configurations.

Device tree binding documentation is updated accordingly to support these
enhancements.

Srinivas Neeli (4):
  dmaengine: xilinx_dma: Fix MCDMA descriptor fields for MM2S vs S2MM
  dt-bindings: dmaengine: xilinx_dma: Move xlnx,irq-delay to common AXI
    DMA and MCDMA section
  dmaengine: xilinx_dma: Move descriptors to done list based on
    completion bit
  dt-bindings: xilinx-dma: Extend 'xlnx,axistream-connected' property to
    MCDMA

Suraj Gupta (3):
  dmaengine: xilinx_dma: Extend metadata handling for AXI MCDMA
  dt-bindings: dmaengine: xilinx_dma: Add "xlnx,include-stscntrl-strm"
    property
  dmaengine: xilinx_dma: Add support for reporting transfer size to AXI
    DMA / MCDMA client when app fields are unavailable

 .../bindings/dma/xilinx/xilinx_dma.txt        |  9 +-
 drivers/dma/xilinx/xilinx_dma.c               | 93 ++++++++++++++++---
 2 files changed, 86 insertions(+), 16 deletions(-)

-- 
2.25.1


