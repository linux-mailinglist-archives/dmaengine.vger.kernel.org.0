Return-Path: <dmaengine+bounces-8711-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK5LJlYkg2k/iQMAu9opvQ
	(envelope-from <dmaengine+bounces-8711-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 11:49:58 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B75CEE4C52
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 11:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93CF73004682
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 10:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164A73D7D72;
	Wed,  4 Feb 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Je/PG6rW"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5263D3CEA;
	Wed,  4 Feb 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770202189; cv=fail; b=ckV9i3EO8Iqfe8aNdC9CNI6HIQkqmhpoNMtybIOBkyrA31wXWD56GqK5LMrUvN2VQSNRNchg8hc6eALUc18aQrtQox5F7n7CuiJmhU7ciZpAP8uHlb6RepdTFeLPY2K09PF95UUan5lH6GbkpkuhElZLjvta4wuTJ0jIOc7fixA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770202189; c=relaxed/simple;
	bh=C9cm2iXuak+Aiim5hcLXZr0m8FOy1/ZJERS0j7b0uS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU4/i4MNlrgz2MPy+dbLsWkrNjVJswp9b23P608TPHLwFx7tYBrp5KoOWgtVrJHIkZ/ai8F4b1Y93Mp3oh7I1PJeVtq0xuzHiz/pSn0+tkb/qXD7WJvqmetmitGKlKS1ec8Esc6g43LylSSMXpzxxnjk7k76kROb4KEmboNcId8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Je/PG6rW; arc=fail smtp.client-ip=40.107.200.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BL30/yMwr3nPmJcHZ3YqCbe1elBeqIbO7mMWNZOwgrkFZgF/O3nep7ymsbRG+lxm1jLTKtnR4AAWdz3JTkvyV0XnvRnaoisx1fkT7valdRFVVNAvnfzowqLv4FkI/2KrRpV/EKSo4Ee4IcWvByhVkFBQKKdnXW8iryAAngWQAGR2bCOvkf123K0mdB03o9I14GkQaCxRAvsdLUI5jMnK15tztQFsgP1+WO+qZXKYY3IXE1Fy+AnEO0/nsMDYWydevHSuEVTwZj7dNLREBvYrdVYlUJrE2N0TWP0gryUvFla/J2fRxdyzekGGjYZBOTAlK7RBSVDhMtLSJFAA3i1ezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rPHK7Fy1oZvuFWiCpe6lxFZonKGxzvyYt3tnuKDna4=;
 b=jFVFrDFprXtTOd/Qr1C95p/EhIXWHuW+UWDcDv3Ro8ZKU3apo38/U3OXa2kJKkpp/eaNYXCwKjllTuFW4ZsZwbcqRXzfVmbour7kgCdBHfKkp3AUK2fW1o+alqrjUEfp2onP7Bo64VZ05q3lGbnXweshWlLOVGkCmUtnxMNxr5o9/NTF0Mtbm7pk7gBhN1TL82/Bc31ZfNFhyOQI96IcXVIdYddk1yoh0xO/tGgE435nLON2kNltb0hkn/0BG/9CjgQrbdfv8Xp/GLF3KRl8F+jGmEk9ZDf5EZGJZpQMhJlJMZ8/buoj4NU10Y9PBSRd0+VSAxKvf3S4VWnoNMlorw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rPHK7Fy1oZvuFWiCpe6lxFZonKGxzvyYt3tnuKDna4=;
 b=Je/PG6rWsk5zH9Z+4+CrCGkVSAshnsBV1ZSg0ITK0SOjcur1yH78bnXBExTFMNWBmqCmEIxdfVAsj6FURhuQ3hsauNHwQRmv/K7EDxL5VQ2pngz9gaYpjTcAqdu4bcfKHaXZzC/9mBFgQfZMGKOzGABaY50pfHACPztI88bxsOQ=
Received: from BL1PR13CA0213.namprd13.prod.outlook.com (2603:10b6:208:2bf::8)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 10:49:44 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::cb) by BL1PR13CA0213.outlook.office365.com
 (2603:10b6:208:2bf::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 10:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 10:49:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 04:49:43 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Feb 2026 02:49:41 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v10 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Wed, 4 Feb 2026 16:19:32 +0530
Message-ID: <20260204104933.33179-2-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204104933.33179-1-devendra.verma@amd.com>
References: <20260204104933.33179-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7f7283-9da1-429e-8ea1-08de63db1b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dfjzOnhqBHX550AHwpWSVjkHQrTsOWGGkDwpfaRKb2B/CTFBuBv8cYNG9RD4?=
 =?us-ascii?Q?HrDAFTaIY3iHLtk2iKqBW2w4IaMdkUvxoAbv8VwyAd6gVPCjF5GcxMukRKi8?=
 =?us-ascii?Q?Q4NXglSkkJrb5CTx3PbgsrvshUmH+LdwITU0RW1wbLqV02OqwYXB8lpA90RK?=
 =?us-ascii?Q?8Sx8Xo9if1iOBPhCMa808wf7v7zoVWjVJl74wA5tszq8j877RkNSEZgYoZ5Q?=
 =?us-ascii?Q?9Pgf8fXQ5nSbh0+qauja9Xjddi9ZGQ8iJRKlW0HEZHvIQuXLdCF6KLuM89UD?=
 =?us-ascii?Q?EKrw+nCZnrKEeQhRjA1LGnARVDRfK41mNiRIs53uyXG1Ovh6qbxKKd8BQSBJ?=
 =?us-ascii?Q?TIMTWi3vluCDGGb2piBdK/veZlcNirbP3/OjSSq3B0JoHplHBsfd1xKKJlD8?=
 =?us-ascii?Q?DGfXtNt/BSyxcw1v78LJZBoRV+zNXV6y2JzjnI6xcnVR0ntEUd7HsSxKCgnw?=
 =?us-ascii?Q?TmeynyfGQTuRqLfptUIeC0BUXX7LiXlgj/DyUe0zauA6AqL3dfeqdn+nVPhE?=
 =?us-ascii?Q?Hq8/zITH1C1q2uhLr6EZxc7PrFSvk1ukl6ZAQJxOv91XxQCKQ3WFG7udph0W?=
 =?us-ascii?Q?EKWuCTASXxgGBU9Wb0qEtO0lQ3docJTXNEL1m0DJOYtsRVdEULQMKHsWAWrv?=
 =?us-ascii?Q?KxyYH1RncAeuGbixAYYWp2B1d0FVT9zFOFSEKmk6UpF3qvoxKYMg/97OGxTt?=
 =?us-ascii?Q?Q9dWWqIr+KcKcvbrsTGjW4TZO2S+rQFYOi8B+e4rB7souROVPm0sE91HWHbT?=
 =?us-ascii?Q?YfjBwFo398SjfsO6zcKEWdZ2NiwssLXtyzy6oO1n3N5C58T7/GAi7bTe3RQn?=
 =?us-ascii?Q?coBmTV0kmri+P4mpLdI9whMxdwkHL82qnMArOkjT7ONANvTy62hAax1s8QUl?=
 =?us-ascii?Q?2TzHVYtnt1mJUCq88xFBK+VLhR8ALc1uzxw5CbGvkEKay/WP8kUoNn3QqA1F?=
 =?us-ascii?Q?Kl9OThoLN3Lz/gITemCSbNEohv8Mi0I8NKIcMXnU2QNzv2NR2v7t/i1ObIrT?=
 =?us-ascii?Q?MY3+hyc25WMXvDVaeZXRWnX2Q3C3o6/IR66Qad5G4lay5mpspDvulwCXcYEB?=
 =?us-ascii?Q?FUU8AeSRIcGUFc3+XMV1tgrsIjQLLYgjzFt7RYuCxOyyfUkb7SGojQiGk3cV?=
 =?us-ascii?Q?sNMT4S7t/ynmlI50/xV0+GY4kxevf1e07egi9wLttNpeuEcdB9AIBwJAeeI4?=
 =?us-ascii?Q?DNouHjnY8WnLz+BpU4q4bkDSKPmkFCC/NDvuayb2/aR8PFDx3EIp0x/m/unk?=
 =?us-ascii?Q?6UF1piVx139VGCnLtLatf8BLBQsPCHHv/CNBhryFacnNzirzLGXh10ApQVRC?=
 =?us-ascii?Q?ZADkLqMJlOjND36zIp9uqisuo2r/L3lQ/5HZtJk38FbeoOxAm18oFwIvTVk0?=
 =?us-ascii?Q?E4VK4XuecHpkDtjYFIDA+BgfyAWBsu4Hcrgepu45UYTqd7jbrIyaK0P3Ocub?=
 =?us-ascii?Q?GVZG7ZXlZgyvkXdmF1Pag09EeHE88k1hXACEy599pQbBpd6QBewtL0GDV9sH?=
 =?us-ascii?Q?Zc3cocpLYg1iZhtqOPsrstmZouT3ma90uVAXHeiLXCJ9tkvkRl69bb2W6dQu?=
 =?us-ascii?Q?lNl4AgZrdm4JPZsZULNiCRRQWT/KGHziFVggGi1RxhgQ36HVTyU4YbxjIrrb?=
 =?us-ascii?Q?ldyvgyhZeJF1OQioVaKzxK1V3n6jpdZDGXjk853pzh86zQ+mhEMd7LXIolOu?=
 =?us-ascii?Q?47Xdcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dYuY9qFisP0Ld0TSw0Xa7YFJDDAYwi6rnWySFXK+J/92zGAKyX2XTdgxMZ81PMOcY1b6VcF9LaUPNk28bKPqFZtSXEmW724zByPtIYmpEAMkNTQiRrvACqGIBfVk9vwdGJkX0Exic5TWAg1mUj27lIVPUOG68jH1chTBk+S3Rng1GGk/TXFEG+9ujMwOTzHHHyPSqH+owiDN9M5l26jh1mQQLjaSDwfKFisfHsqgfZEFTCp+lNGuuvtMcreo3LDww2/zVndikXMwYMDhddhQ5qYkNGGyDcZQcwFe/i6jRTJ2pRY9cUr5M92HxAGJlLKt5HZA0+8KUsfZQTc2dAPhI1khAOlccaT5/JZTvLmg2ly+Quipy+8aMzd9WrFZGTR7S3QqUNU7vzUSfzst+ziHPRLKAS8E5EYWDjFGCHM07K+dtEdZ58PfC0Y/RDH+DaCv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:49:44.2154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7f7283-9da1-429e-8ea1-08de63db1b71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-8711-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B75CEE4C52
X-Rspamd-Action: no action

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v10:
For Xilinx VSEC function kept only HDMA map format as
Xilinx only supports HDMA.

Changes in v9:
Moved Xilinx specific VSEC capability functions under
the vendor ID condition.

Changes in v8:
Changed the contant names to includer product vendor.
Moved the vendor specific code to vendor specific functions.

Changes in v7:
Introduced vendor specific functions to retrieve the
vsec data.

Changes in v6:
Included "sizes.h" header and used the appropriate
definitions instead of constants.

Changes in v5:
Added the definitions for Xilinx specific VSEC header id,
revision, and register offsets.
Corrected the error type when no physical offset found for
device side memory.
Corrected the order of variables.

Changes in v4:
Configured 8 read and 8 write channels for Xilinx vendor
Added checks to validate vendor ID for vendor
specific vsec id.
Added Xilinx specific vendor id for vsec specific to Xilinx
Added the LL and data region offsets, size as input params to
function dw_edma_set_chan_region_offset().
Moved the LL and data region offsets assignment to function
for Xilinx specific case.
Corrected comments.

Changes in v3:
Corrected a typo when assigning AMD (Xilinx) vsec id macro
and condition check.

Changes in v2:
Reverted the devmem_phys_off type to u64.
Renamed the function appropriately to suit the
functionality for setting the LL & data region offsets.

Changes in v1:
Removed the pci device id from pci_ids.h file.
Added the vendor id macro as per the suggested method.
Changed the type of the newly added devmem_phys_off variable.
Added to logic to assign offsets for LL and data region blocks
in case more number of channels are enabled than given in
amd_mdb_data struct.
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 190 ++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a76d3c..3aefc48f8e0a 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -14,14 +14,35 @@
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 
 #include "dw-edma-core.h"
 
-#define DW_PCIE_VSEC_DMA_ID			0x6
-#define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
-#define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
-#define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
-#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
+/* Synopsys */
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID		0x6
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR		GENMASK(10, 8)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH		GENMASK(9, 0)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH		GENMASK(25, 16)
+
+/* AMD MDB (Xilinx) specific defines */
+#define PCI_DEVICE_ID_XILINX_B054		0xb054
+
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
+#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
+
+#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
+#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
+#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
+
+#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
+#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
+#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
+#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
 
 #define DW_BLOCK(a, b, c) \
 	{ \
@@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +112,64 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.rd_ch_cnt			= 2,
 };
 
+static const struct dw_edma_pcie_data xilinx_mdb_data = {
+	/* MDB registers location */
+	.rg.bar				= BAR_0,
+	.rg.off				= SZ_4K,	/*  4 Kbytes */
+	.rg.sz				= SZ_8K,	/*  8 Kbytes */
+
+	/* Other */
+	.mf				= EDMA_MF_HDMA_NATIVE,
+	.irqs				= 1,
+	.wr_ch_cnt			= 8,
+	.rd_ch_cnt			= 8,
+};
+
+static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
+					   enum pci_barno bar, off_t start_off,
+					   off_t ll_off_gap, size_t ll_size,
+					   off_t dt_off_gap, size_t dt_size)
+{
+	u16 wr_ch = pdata->wr_ch_cnt;
+	u16 rd_ch = pdata->rd_ch_cnt;
+	off_t off;
+	u16 i;
+
+	off = start_off;
+
+	/* Write channel LL region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->ll_wr[i].bar = bar;
+		pdata->ll_wr[i].off = off;
+		pdata->ll_wr[i].sz = ll_size;
+		off += ll_off_gap;
+	}
+
+	/* Read channel LL region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->ll_rd[i].bar = bar;
+		pdata->ll_rd[i].off = off;
+		pdata->ll_rd[i].sz = ll_size;
+		off += ll_off_gap;
+	}
+
+	/* Write channel data region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->dt_wr[i].bar = bar;
+		pdata->dt_wr[i].off = off;
+		pdata->dt_wr[i].sz = dt_size;
+		off += dt_off_gap;
+	}
+
+	/* Read channel data region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->dt_rd[i].bar = bar;
+		pdata->dt_rd[i].off = off;
+		pdata->dt_rd[i].sz = dt_size;
+		off += dt_off_gap;
+	}
+}
+
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 {
 	return pci_irq_vector(to_pci_dev(dev), nr);
@@ -114,15 +194,15 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
-static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
-					   struct dw_edma_pcie_data *pdata)
+static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
+					       struct dw_edma_pcie_data *pdata)
 {
 	u32 val, map;
 	u16 vsec;
 	u64 off;
 
 	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
-					DW_PCIE_VSEC_DMA_ID);
+					DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
 	if (!vsec)
 		return;
 
@@ -131,9 +211,9 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	    PCI_VNDR_HEADER_LEN(val) != 0x18)
 		return;
 
-	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");
+	pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific Extended Capability DMA\n");
 	pci_read_config_dword(pdev, vsec + 0x8, &val);
-	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
+	map = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
 	if (map != EDMA_MF_EDMA_LEGACY &&
 	    map != EDMA_MF_EDMA_UNROLL &&
 	    map != EDMA_MF_HDMA_COMPAT &&
@@ -141,13 +221,13 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 		return;
 
 	pdata->mf = map;
-	pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
+	pdata->rg.bar = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR, val);
 
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
 	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
-				 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
+				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
 	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
-				 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
+				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));
 
 	pci_read_config_dword(pdev, vsec + 0x14, &val);
 	off = val;
@@ -157,6 +237,64 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	pdata->rg.off = off;
 }
 
+static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
+					     struct dw_edma_pcie_data *pdata)
+{
+	u32 val, map;
+	u16 vsec;
+	u64 off;
+
+	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
+
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
+					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
+	if (!vsec)
+		return;
+
+	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
+	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
+	    PCI_VNDR_HEADER_LEN(val) != 0x18)
+		return;
+
+	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
+	pci_read_config_dword(pdev, vsec + 0x8, &val);
+	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
+	if (map != EDMA_MF_HDMA_NATIVE)
+		return;
+
+	pdata->mf = map;
+	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
+
+	pci_read_config_dword(pdev, vsec + 0xc, &val);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
+				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
+				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
+
+	pci_read_config_dword(pdev, vsec + 0x14, &val);
+	off = val;
+	pci_read_config_dword(pdev, vsec + 0x10, &val);
+	off <<= 32;
+	off |= val;
+	pdata->rg.off = off;
+
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
+					DW_PCIE_XILINX_MDB_VSEC_ID);
+	if (!vsec)
+		return;
+
+	pci_read_config_dword(pdev,
+			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
+			      &val);
+	off = val;
+	pci_read_config_dword(pdev,
+			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
+			      &val);
+	off <<= 32;
+	off |= val;
+	pdata->devmem_phys_off = off;
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -184,7 +322,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
 	 * for the DMA, if one exists, then reconfigures it.
 	 */
-	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
+	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
+
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
+		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
+
+		/*
+		 * There is no valid address found for the LL memory
+		 * space on the device side.
+		 */
+		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
+			return -ENOMEM;
+
+		/*
+		 * Configure the channel LL and data blocks if number of
+		 * channels enabled in VSEC capability are more than the
+		 * channels configured in xilinx_mdb_data.
+		 */
+		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+					       DW_PCIE_XILINX_MDB_LL_SIZE,
+					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+					       DW_PCIE_XILINX_MDB_DT_SIZE);
+	}
 
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
@@ -367,6 +527,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
+	  (kernel_ulong_t)&xilinx_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.43.0


