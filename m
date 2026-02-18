Return-Path: <dmaengine+bounces-8943-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAi3BGuMlWlVSQIAu9opvQ
	(envelope-from <dmaengine+bounces-8943-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:54:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86779154F57
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 10:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0975C3021706
	for <lists+dmaengine@lfdr.de>; Wed, 18 Feb 2026 09:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FCA33D6CB;
	Wed, 18 Feb 2026 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HhmAK5Wo"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADD33A70D;
	Wed, 18 Feb 2026 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408407; cv=fail; b=Dktiw/VpWgACt6n+myB7R2Efnmve05/GnSQ+Sn2qEcGVfQq/k/8OOACmuqFjUFF5RBgZv74QTfEXTD/4Rh2JHfbvdAA26cxLWq6KzoWhCJrRu+XBSQjm1F8HFbkHiu39hIJ2nXrqOAhQo7ByoEyoWnGT2t5ZNWkvDaBrAlkgluc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408407; c=relaxed/simple;
	bh=NL9glftgcCaAITpq0Lbolzpo/4IfNXgge7QUIOzPE8Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETVRsby5I3v0SpjjQqkNvOt+/jLwitdTZXez0mQU/omB9vyX7D2o/NUpUO1VVzVzD6QZJeM90wmLUDA8PHre8iVWhX0KSf/g4d9zGyJSxB+uOmksA9ayZYLFQY7XNQJyaCiHnzt156hL3WtT57gStpolngWIrl+lI1OMqWJGHA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HhmAK5Wo; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfFX0ujX0Vsf2hPSECxDFYc2uq1VBX02rKqVCiuvhAKHmwbFf/20lP+BjSh899F4MYrXTEcGCCzHjOnwmARKSIcFwxokogyta8S5CF90LAL7f8iscKJv7sMZjxL5mLN20ADV4k9dsaXnzBbHpQw8vBGRYpmRcplOLbBbGDGlejOFpZTBiqQ0+mj8+puLb9HMmFPEY8tS83yp+NVHVINUjMCZh54VNsaqG/upS2h0TXWyO+fOZDByg1kZaNPeG97EPcUZ9Q5xjqxUuttdW6vKUbUTOOBReN3Ru265ekqYwZMFA7/0833nr5diGGWDXRmt6cQSa4jWOAR+DZs3AaTdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2bIk2SZE0v6BlkSCPG/4zOqhTWUbSzk5lHezTF0ymE=;
 b=HslDyygo3INRY3EJi4PuqmyzPi1mX5o7jX/DvSiGJF+BHI9/U2YhX9gnVpZSyCkVqWlBGJayPFYOrz+OQMxg9tK8JLa658iC+vaGe+JEGcGzSW9PyPLFRU2sQdu3peojoIszzWeX2Xh2+ZzxhChh1uKJzz0E8MwiKZkR7QIZvW/tuc61jIr3ClXBh1yEluuuTrPgejFv0Cs6l/9l2yiAKgpT9EExtvliLh1r6KL7OcANcsrPUmMOZJOnrc9jeKv1RUgUc7FpmOTiZhDPNyobi7a7gm3gfenMKNwIiC3CiuJ5x9bsHIr6QGCSQApLqXdzWxNrjGwGAyIGFSwpRtlKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2bIk2SZE0v6BlkSCPG/4zOqhTWUbSzk5lHezTF0ymE=;
 b=HhmAK5WoS1fn9OAxyU0rZp+5KGwT5H+AvwFYSpd4U9ZCVUV6K4vSiUojb1+whP7wrkYCMOf22qSw0FjvUITAsPBp/oUm0b3bJNamW3NZiPagppnI9DDsPRa2ZxAR2Z+WqZiJ0EOFQZJVs4sgFy3k++RGp28l2KJ2060gBLTfU8c=
Received: from DS0PR17CA0024.namprd17.prod.outlook.com (2603:10b6:8:191::29)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 09:53:23 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::88) by DS0PR17CA0024.outlook.office365.com
 (2603:10b6:8:191::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 09:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 09:53:21 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:21 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 03:53:20 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 03:53:20 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61I9qpIC200561;
	Wed, 18 Feb 2026 03:53:16 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
	<Frank.li@nxp.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v5 05/18] dmaengine: ti: k3-udma: move ring management functions to k3-udma-common.c
Date: Wed, 18 Feb 2026 15:22:30 +0530
Message-ID: <20260218095243.2832115-6-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218095243.2832115-1-s-adivi@ti.com>
References: <20260218095243.2832115-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 31de0fb4-7f0d-45cb-b7ce-08de6ed38d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ci9ht3aS7wWNwSO3nTy5ec8AQl38KKJT2ODsEDYWWAUeAObH+SaTJYtYMloU?=
 =?us-ascii?Q?kf1Zv81LgBw+YUzPwBMpoZLZEWx71/uAptjGMXYhilyQc86Sz09DNu6vVthP?=
 =?us-ascii?Q?o+dyFRxn8DJnAXG1BzxfgQJENVojPaY5DJtv3Eni/3TJ03NbR9VZ5naicDDK?=
 =?us-ascii?Q?og8mr+RF61c0xQoTxbW/fL6J0+Yr6WU1+lhaTP2ip8r8PdHHfbUINqqMDGwT?=
 =?us-ascii?Q?u2KR6LLEgRzt+fISBBoV1ll82/T18vsVPd3fEDr2yVwY1fDErgE3TEypP6SG?=
 =?us-ascii?Q?wrC5e8LlmPQxxRdKERyX2KJhQ7ofNjnPaunoZ/isSEyrN5v4WC9kVX2BKYKO?=
 =?us-ascii?Q?RP/gW4C6dXnOuh1JtqheJJHrpsBfeodOmL60CwHKRmbPpJAdzzK3ocgZXlCQ?=
 =?us-ascii?Q?p4HHg8u0nhkkyq++39gvXmWvW5Kh4/dBcLNroDIWG4ed5UeknjBoF3twgL98?=
 =?us-ascii?Q?RG4Fd+HEMB7LR9PJX4vqD0GED4uRNGzDpt5SFPByyF8s+6TBy13fzv/qRifp?=
 =?us-ascii?Q?IKzm7mSzTHMHe8pBVpyZVYxkfp2NOqGKu+utN2Dr4AhNr1mg3XevwrAL+yTc?=
 =?us-ascii?Q?XXjK/WZwbBKi3VjQxnv7NvWlIhagLq3OLv16LFPnCd4AJnsYZUzJAI2XBp7O?=
 =?us-ascii?Q?reVfFQ0LyhY3yH4117y6pNATRlz3+Qqb+ckt+YnIbN07Fg/setV7X5QNbq0N?=
 =?us-ascii?Q?WNnqUmeKNgIQEW0HU61LeT+PohPd3zhKz6uJLn/dchaLqvbVNdAdeqi+m5ai?=
 =?us-ascii?Q?raTZrhUd1ryaDlmwL6D+uRLn+xB29iFGO8p+m163E952gu8vnxV8vW6eY0pg?=
 =?us-ascii?Q?tfsGJVPwLPlOgbEU/zt2X1Ba7PaGmYJZ7gpWqHKh1SfZ7tObkPDqKyPRoZdq?=
 =?us-ascii?Q?dACjQWZc3kmDI4964PT72NOkm6bhrE8IEz544tLKR1QN3SJ44vSv7LEDBcC/?=
 =?us-ascii?Q?x6ZzKBWBm7cXcPEHhvm5wNDwpiyBAIQ6pojZW35aorh38YNR6GnfbXZzwDPk?=
 =?us-ascii?Q?9RfkSuwsmFzU6i+TgVBWall3W8OLvodDdDrVvikDazifbAt0AdMM4De7BuJs?=
 =?us-ascii?Q?NR6NCkJsofBsQ9O7M7yFREixwbZOdOaZINjuXY2k0yJoOIzKZvYdCLcdKGlX?=
 =?us-ascii?Q?fEn4IlGIFa4LnAXtSsQK9CA3ZwVXHTUwpz1+w+OpyAHT2/y9MJqQR6UDRrAi?=
 =?us-ascii?Q?O2seoBHdmEEVtUjKHbQP9NvNmhtbU3crj1zFGIHpSS975RgfJ6oxGVtUXYtE?=
 =?us-ascii?Q?4bvsfKqVsvUcWh4SZIxAJmVCj2URVFlt2K7QJ1hG8fJqjtKPBArM5I+2rQka?=
 =?us-ascii?Q?KAzj50JkMW9L1r56gOsGOq/piq69F7zoyuhQlJjsX3UUR23J99NOk4t6u+94?=
 =?us-ascii?Q?mD6nbZ3PeGkLRRBAa7U82jdMHuTrIctZ+EoOXTPQvSeeqSYcMeb4n/WoM9Ps?=
 =?us-ascii?Q?wFonsCkOGtpagnL9IY7hGBtNxQ/35waRoVvN1y0UNnmSVSrA15xjBI19JkI2?=
 =?us-ascii?Q?Q0Y94q/MLZXhXyU1evlJPg3Qgz609fREVsITfqhulamzFk/Rcvmc8gWKyzT5?=
 =?us-ascii?Q?l4eawgvl5NbnIMGEAF/hW92x05t7ACzjzBmDbPxNx2Qo5g3/JXDJ1J3yAd0h?=
 =?us-ascii?Q?3bKPNRnIMgHMGoiPuiuoj9CTIuBaWJlCqIoQ9/PfMRlLMWoMRfG8mGfZUrdP?=
 =?us-ascii?Q?m4Ola29J1lCVv7IZ8t9z1qFjse8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jRhnQdIp+dcm8LLsz1CFPwgOOnIm/n55wU7iUYwI4MmfAs8MgfFPlyBC/FhU3+PSQbnY2lfYlXl4UU1d55sLvnP6rZ04/pBucdIzhIESfcZ3b9VtmPQM5NjxZpjiJOQ5rU0SiH/uxiG2gLqAjmlBSl7QR/lzHOC+hY6JgMB8uHbBrIIEkaRTZjBKz4fs88R8J3eaR4vabJioXTckIEY2tYkSd3c0uhCO5sE/uJagTKVC2Gg9FZ/pn8YjeVXmrjWw5S4++hP2vW2bWeyFwNUocjxRbXEo286NGNoRVvetMnvTphYXCSfQGHueaOG/i1nIj6cIA1nPc7ipTPvpZAf6ZzmOd8XH6wNN0BVlIbI8ckI49aiP5qpgi38JrkT6XhY55dC36wO6LYT+E1B3JNfF7lMjmk+AUCJpQ8b9cdVOKFof6zhqErlIe8QkZuy4S8Dy
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 09:53:21.6834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31de0fb4-7f0d-45cb-b7ce-08de6ed38d1d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8943-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 86779154F57
X-Rspamd-Action: no action

Relocate the ring management functions such as push, pop, and reset
from k3-udma.c to k3-udma-common.c file. These operations are
common across multiple K3 UDMA variants and will be reused by
future implementations like K3 UDMA v2.

No functional changes intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 103 ++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-udma.c        | 100 -------------------------------
 drivers/dma/ti/k3-udma.h        |   4 ++
 3 files changed, 107 insertions(+), 100 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 9cb35759c70bb..4dcf986f84d87 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -1239,5 +1239,108 @@ void udma_desc_pre_callback(struct virt_dma_chan *vc,
 }
 EXPORT_SYMBOL_GPL(udma_desc_pre_callback);
 
+int udma_push_to_ring(struct udma_chan *uc, int idx)
+{
+	struct udma_desc *d = uc->desc;
+	struct k3_ring *ring = NULL;
+	dma_addr_t paddr;
+
+	switch (uc->config.dir) {
+	case DMA_DEV_TO_MEM:
+		ring = uc->rflow->fd_ring;
+		break;
+	case DMA_MEM_TO_DEV:
+	case DMA_MEM_TO_MEM:
+		ring = uc->tchan->t_ring;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* RX flush packet: idx == -1 is only passed in case of DEV_TO_MEM */
+	if (idx == -1) {
+		paddr = udma_get_rx_flush_hwdesc_paddr(uc);
+	} else {
+		paddr = udma_curr_cppi5_desc_paddr(d, idx);
+
+		wmb(); /* Ensure that writes are not moved over this point */
+	}
+
+	return k3_ringacc_ring_push(ring, &paddr);
+}
+EXPORT_SYMBOL_GPL(udma_push_to_ring);
+
+int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
+{
+	struct k3_ring *ring = NULL;
+	int ret;
+
+	switch (uc->config.dir) {
+	case DMA_DEV_TO_MEM:
+		ring = uc->rflow->r_ring;
+		break;
+	case DMA_MEM_TO_DEV:
+	case DMA_MEM_TO_MEM:
+		ring = uc->tchan->tc_ring;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	ret = k3_ringacc_ring_pop(ring, addr);
+	if (ret)
+		return ret;
+
+	rmb(); /* Ensure that reads are not moved before this point */
+
+	/* Teardown completion */
+	if (cppi5_desc_is_tdcm(*addr))
+		return 0;
+
+	/* Check for flush descriptor */
+	if (udma_desc_is_rx_flush(uc, *addr))
+		return -ENOENT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_pop_from_ring);
+
+void udma_reset_rings(struct udma_chan *uc)
+{
+	struct k3_ring *ring1 = NULL;
+	struct k3_ring *ring2 = NULL;
+
+	switch (uc->config.dir) {
+	case DMA_DEV_TO_MEM:
+		if (uc->rchan) {
+			ring1 = uc->rflow->fd_ring;
+			ring2 = uc->rflow->r_ring;
+		}
+		break;
+	case DMA_MEM_TO_DEV:
+	case DMA_MEM_TO_MEM:
+		if (uc->tchan) {
+			ring1 = uc->tchan->t_ring;
+			ring2 = uc->tchan->tc_ring;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (ring1)
+		k3_ringacc_ring_reset_dma(ring1,
+					  k3_ringacc_ring_get_occ(ring1));
+	if (ring2)
+		k3_ringacc_ring_reset(ring2);
+
+	/* make sure we are not leaking memory by stalled descriptor */
+	if (uc->terminated_desc) {
+		udma_desc_free(&uc->terminated_desc->vd);
+		uc->terminated_desc = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_reset_rings);
+
 MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0a1291829611f..214a1ca1e1776 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -174,106 +174,6 @@ static bool udma_is_chan_paused(struct udma_chan *uc)
 	return false;
 }
 
-static int udma_push_to_ring(struct udma_chan *uc, int idx)
-{
-	struct udma_desc *d = uc->desc;
-	struct k3_ring *ring = NULL;
-	dma_addr_t paddr;
-
-	switch (uc->config.dir) {
-	case DMA_DEV_TO_MEM:
-		ring = uc->rflow->fd_ring;
-		break;
-	case DMA_MEM_TO_DEV:
-	case DMA_MEM_TO_MEM:
-		ring = uc->tchan->t_ring;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* RX flush packet: idx == -1 is only passed in case of DEV_TO_MEM */
-	if (idx == -1) {
-		paddr = udma_get_rx_flush_hwdesc_paddr(uc);
-	} else {
-		paddr = udma_curr_cppi5_desc_paddr(d, idx);
-
-		wmb(); /* Ensure that writes are not moved over this point */
-	}
-
-	return k3_ringacc_ring_push(ring, &paddr);
-}
-
-static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
-{
-	struct k3_ring *ring = NULL;
-	int ret;
-
-	switch (uc->config.dir) {
-	case DMA_DEV_TO_MEM:
-		ring = uc->rflow->r_ring;
-		break;
-	case DMA_MEM_TO_DEV:
-	case DMA_MEM_TO_MEM:
-		ring = uc->tchan->tc_ring;
-		break;
-	default:
-		return -ENOENT;
-	}
-
-	ret = k3_ringacc_ring_pop(ring, addr);
-	if (ret)
-		return ret;
-
-	rmb(); /* Ensure that reads are not moved before this point */
-
-	/* Teardown completion */
-	if (cppi5_desc_is_tdcm(*addr))
-		return 0;
-
-	/* Check for flush descriptor */
-	if (udma_desc_is_rx_flush(uc, *addr))
-		return -ENOENT;
-
-	return 0;
-}
-
-static void udma_reset_rings(struct udma_chan *uc)
-{
-	struct k3_ring *ring1 = NULL;
-	struct k3_ring *ring2 = NULL;
-
-	switch (uc->config.dir) {
-	case DMA_DEV_TO_MEM:
-		if (uc->rchan) {
-			ring1 = uc->rflow->fd_ring;
-			ring2 = uc->rflow->r_ring;
-		}
-		break;
-	case DMA_MEM_TO_DEV:
-	case DMA_MEM_TO_MEM:
-		if (uc->tchan) {
-			ring1 = uc->tchan->t_ring;
-			ring2 = uc->tchan->tc_ring;
-		}
-		break;
-	default:
-		break;
-	}
-
-	if (ring1)
-		k3_ringacc_ring_reset_dma(ring1,
-					  k3_ringacc_ring_get_occ(ring1));
-	if (ring2)
-		k3_ringacc_ring_reset(ring2);
-
-	/* make sure we are not leaking memory by stalled descriptor */
-	if (uc->terminated_desc) {
-		udma_desc_free(&uc->terminated_desc->vd);
-		uc->terminated_desc = NULL;
-	}
-}
-
 static void udma_decrement_byte_counters(struct udma_chan *uc, u32 val)
 {
 	if (uc->desc->dir == DMA_DEV_TO_MEM) {
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 7c807bd9e178b..4c6e5b946d5cf 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -610,6 +610,10 @@ void udma_desc_pre_callback(struct virt_dma_chan *vc,
 			    struct virt_dma_desc *vd,
 			    struct dmaengine_result *result);
 
+int udma_push_to_ring(struct udma_chan *uc, int idx);
+int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr);
+void udma_reset_rings(struct udma_chan *uc);
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


