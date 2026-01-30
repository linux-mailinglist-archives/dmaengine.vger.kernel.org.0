Return-Path: <dmaengine+bounces-8599-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGWMOBORfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8599-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:08:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B4B9CCB
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 212A73082F5D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7547378D7B;
	Fri, 30 Jan 2026 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kfw6h5Ki"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F39378D6D;
	Fri, 30 Jan 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770973; cv=fail; b=k+S10F8pCbdZ8hBbeSJJ5mSdc6eO6ZoH/fVUIWCKcHtKTDR9zSDOUwKyOgFe4Bn0g8TzKl8tBM8b6bupJ4NDmypz+Z6YrlVLVuQkag6YYFicg8+g+H9PGlruylnIKyHrihrlxoA4ebCKQame4reazNQbEFrbk8Ot9mBujGZYLVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770973; c=relaxed/simple;
	bh=EOZV7OnhzUoCIJEV265mhQKiTgEtEVKCf2DT6qSW54c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rveqbguBP4X+iVR5Waz6a2VmTrQjE9c/Rc6BeNNn846g9ycmy5LdlddGc//TOC8k+ro/VVV3ypaiKvNKhnAS0KoEcmbdCKmFXkauff66O9bixwjVzM94QPGzcWXxpLj+kZUmEq4YU1U57Y+mL3vAHBewi5OTAPsQg9hYzTNE82Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kfw6h5Ki; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P34Gq6d4jPZl8Htc3FfuGRTmUvK42t07EYLWeCjPMI2BKdHnWT/qHwCX5yT8CdeSMD5ZDnD+1F1qEX0UnnB9dtzrKcbc0hNK+UJB9Ta/kYYFL6EPCL8Y2OD2Yg8WEWql7Eyz5BFTdYIgWqiVqs5gshbzxKjeRNkFoIyp7DRfMC/OeIkEtQy8WgXoz7LV7kQ5gxdWx1g8IeAYN8g43RhILVXja5MqcW3FXyIoENL/OMi+xUzfqmMd/acRqKi6yvGUuCTokOryvqnqTIkWbk/LTEULzaCsE3PF16W97FH6hO9jlNRyZYYfkvXUj/c6F1clTqP1zSyNEJtE1KFPyCtOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrhmZWP/foXW5+f91W7nQkH5uzZtOZQsnj6DB0YMfl0=;
 b=Ms19mpfFtI+nMwk3LcpjK+5h0S3jBTi4OeiN5oYvRniSZWiextHkC7qs1xq33sWlwdRUt8eUJnTc8QnxIZNqQZYBL/Kmdx1OrizaxbcNobeZe8CBdpB7ssZCNGfUrUeLdUBHEHsY84VAPlUo3vdVLZuz6QUCsJaojXPgnh7Gq9bA6SssLhysZe9HI39AUYgmh00ciYpnyc/HDygwtAwc7L1TtwyYrJijlPgX7gWDo7VIkyju7WX3molsFkMEvUCYNZdeocbaFLjcdV+a2buIaifKreXXnXYCo83k8KUjfdSd8Bo4EttRbHxkesroQAUEoC/eLlyALpjohoCqo3d93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrhmZWP/foXW5+f91W7nQkH5uzZtOZQsnj6DB0YMfl0=;
 b=Kfw6h5KiLjbXJpH/+wkEUiqRoQEvl8D8FqKUTPxm0I461jApwWXzFqvk1ZcqlQpQc9ZGzCI4GZp4allljNCMoV6T4Ts87sZ5nDLWRCKKrsApY+w2yoNn/z3BxENHBrJzbME/yXAZ+eZmAXhSpCQWqDGGSl2g3eI2mIibkc1mC1M=
Received: from SN6PR2101CA0012.namprd21.prod.outlook.com
 (2603:10b6:805:106::22) by SJ0PR10MB4543.namprd10.prod.outlook.com
 (2603:10b6:a03:2d9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 11:02:49 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::75) by SN6PR2101CA0012.outlook.office365.com
 (2603:10b6:805:106::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Fri,
 30 Jan 2026 11:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:02:49 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:48 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:48 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:02:48 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBj1204392;
	Fri, 30 Jan 2026 05:02:44 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 06/19] dmaengine: ti: k3-udma: Add variant-specific function pointers to udma_dev
Date: Fri, 30 Jan 2026 16:31:46 +0530
Message-ID: <20260130110159.359501-7-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130110159.359501-1-s-adivi@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfb4bba-324c-4bc4-919a-08de5fef1b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oGAcOv1yLTKISeCDziuVBzy6pky+deCi2ayGUb6pvFgNlvabF5Z+7uTx4kl+?=
 =?us-ascii?Q?5cRLpV1Aej8mR/h70TtdXgSQaaUA/hD4uWrdyTgmOhD5Z9sIDlDihiKrNIbK?=
 =?us-ascii?Q?OHtbBSYHq1AJcyTauTTMl5tk0d8PSUMmRK5A5drlHg4ffVIvLnqXxtQZKW6P?=
 =?us-ascii?Q?/jFYPMUuup+LNcEht4u6oJpTZGp3/w/xjawR3CbpzSXdba8QhFFTWaN1fGrn?=
 =?us-ascii?Q?jsys43GbU8NRE+OOLD+xnuCvWaodAt3m5eK6OWNjzRai6n3J0yCSPZe6k1EX?=
 =?us-ascii?Q?pOmP7yaOpE6uVZ7YRrd62XwtwWTsrnGfn+tig75ecDSO1dmc5H6vOb/eDZOJ?=
 =?us-ascii?Q?mW9yjfzAwqDJpsOI2pd/GOsygE/o4JFgmHTY7psAfclbMvoIlONKYEicvTdL?=
 =?us-ascii?Q?VhEQ2owMGerNTXtKbYdUvEgvbF9xLf0VGv9CdLzPXZNv77cEnA9JMt61eGAu?=
 =?us-ascii?Q?9YrOh/BZ5tovY2KVMTMWSuGM3TDjE6AWcxMBishnjgTXgXjsfbCK++yvWZM5?=
 =?us-ascii?Q?18ICRbDiI3jF8tiUzGbxTCnTk8ILOWqWpH2gfprG86y8c9C48XhWzAsADz8u?=
 =?us-ascii?Q?4HiMT/TWDZgyBE4yw4B5JhJ44mtoN5AzuXX38DGOj+ozwMZa1Hci8O5kVN3N?=
 =?us-ascii?Q?76L3rwzsyQiSQS9vAdmFzI4GbjCGFrhuG0n/Dtuz8+NVvyg6Nx6I1f2a8/5i?=
 =?us-ascii?Q?ej85Snx4yWF4YYApNWwNT+GanBCi1yieuGmujEqwaAd3Oe8QOj/XxZtz7Gok?=
 =?us-ascii?Q?AfpltXvLsB6nSyrX1+bMD14e/dknDdRIav2ExU4oh04/13Y6YXTEiGDQxNES?=
 =?us-ascii?Q?HAYPUyD2pHCQR8OwdJzqf7cYFJDt6m/oy0kq+FZo+dSUR3vwSD9wg4WUdbXs?=
 =?us-ascii?Q?MoHbgYLQp7rLK20S9NDY98np7sLQEwRLwlX8a3x3b84IxvphWg5kLwuzPDS4?=
 =?us-ascii?Q?L9VdLQL2BiNIY+y8e5yclIKOkVgFyCZCqzhc2KrVrCGj1PftaTMuL+I2AtOb?=
 =?us-ascii?Q?1a1VPIdeZtTL56YGIImSYxQFuNEB/5pxnTCkm/U6/NzOsyKb3vsT0NLiyChD?=
 =?us-ascii?Q?30s7rAfioegkREoW2LCZolQn04J81h6Y3rA55P0rsofIPG1CGuE8WOFkyw5i?=
 =?us-ascii?Q?WJhg6xh+oL4vGPy+bbav2buU+sGTrq0XZUoabjak4RKvv+ZMxzjkpibkLnKR?=
 =?us-ascii?Q?qYQ23OtUJFAtuwhSwN1jF1s8aucTJHxacnOiBoh4hIpktgdZRN8x6AYMJWgy?=
 =?us-ascii?Q?QipJZVfPN51pTevW1QTs3QyopkOCpe0wnZl1rt1QU3MmxFROzcYIMMABFgVn?=
 =?us-ascii?Q?4V2HLTEWxv5gnKFezIb7n4oa/CyqlzUt0wXL2lMWXtu6YyCY+NKKvHe0ybt/?=
 =?us-ascii?Q?xXOoKj3L1kjX9ZNKXGx8cNmVoUtpSXlzM6U5Ck4j+V0WEQy28doM6SW6bti2?=
 =?us-ascii?Q?A1ekp0Ha0CIOhPJei45YXG4Xnaj5+sH/Jmcl5DYcyL3/q6CKHgkZ6eKnR4tx?=
 =?us-ascii?Q?N45J18kDywVCxunNpEW+2MWZvJW7rjM9KfLtIxYn0wYcjtaNc2/u6FEh6fsw?=
 =?us-ascii?Q?IPtjzi0aFvh1uQYlBGXETp9cr0Tkq7Cj+AcQVJX1GzP3DdqmdHIKKW1sn3Mc?=
 =?us-ascii?Q?f8eWXc87xL6IwRvB086yBsAGtl+qKW60aSRWfRO6jXTVe0tvYPJVuxF/5xCR?=
 =?us-ascii?Q?/fCxdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UhsmVuOnQ9WluSrRw9c1hLkZrV7fQkKydIjuc+5FzY680RCKGQxYO7MMKzmaiGyTubmwe8Nd7PgENj9OdK3iTJFcS5PaDRisRcv4I2KZPWBehXbYimsiD6yO8zDtEwGxFUGxa/KrKh29bCTY2XjAW+z4ggCMutJ/5H6cLDsIgg0cYw0vG8PVihz/T9KsgqrPrwT6Ri8ZxgQqA/adPUeiFxwTkW4fZd/Xl+poQP6qtccHekc/hBR7xiSd4CNICxkzSEkCzYcaxJmg/PHUt/eJzsxsUoO4Zq0DSFbNxRxN4UNfuxvxp+U+z1wGKZMis6LlAqBBQk8MEppv07tN66ICf0fbJuJwtAGctbd1EnlbFiuiIUF04BU4b7aCXtXYt0+mDowsr1tLUKmiJonKQKWOLOqdylHdvG0vFT95Jo1juho24MEAvFiqoD3z+jDzsyYB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:02:49.3152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfb4bba-324c-4bc4-919a-08de5fef1b58
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8599-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 622B4B9CCB
X-Rspamd-Action: no action

Introduce function pointers in the udma_dev structure to allow
variant-specific implementations for certain operations.
This prepares the driver for supporting multiple K3 UDMA variants,
such as UDMA v2, with minimal code duplication.

No functional changes intended in this commit.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-private.c | 10 +++++--
 drivers/dma/ti/k3-udma.c         | 46 +++++++++++++++++++-------------
 drivers/dma/ti/k3-udma.h         | 12 +++++++++
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 624360423ef17..44c097fff5ee6 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -8,13 +8,19 @@
 
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
-	return navss_psil_pair(ud, src_thread, dst_thread);
+	if (ud->psil_pair)
+		return ud->psil_pair(ud, src_thread, dst_thread);
+
+	return 0;
 }
 EXPORT_SYMBOL(xudma_navss_psil_pair);
 
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
-	return navss_psil_unpair(ud, src_thread, dst_thread);
+	if (ud->psil_unpair)
+		return ud->psil_unpair(ud, src_thread, dst_thread);
+
+	return 0;
 }
 EXPORT_SYMBOL(xudma_navss_psil_unpair);
 
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 214a1ca1e1776..397e890283eaa 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -40,7 +40,7 @@ static const char * const mmr_names[] = {
 	[MMR_TCHANRT] = "tchanrt",
 };
 
-static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
+int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 
@@ -50,8 +50,8 @@ static int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread)
 					      src_thread, dst_thread);
 }
 
-static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-			     u32 dst_thread)
+int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
+		      u32 dst_thread)
 {
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 
@@ -329,7 +329,7 @@ static int udma_start(struct udma_chan *uc)
 	}
 
 	/* Make sure that we clear the teardown bit, if it is set */
-	udma_reset_chan(uc, false);
+	uc->ud->reset_chan(uc, false);
 
 	/* Push descriptors before we start the channel */
 	udma_start_desc(uc);
@@ -521,8 +521,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 		if (uc->desc) {
 			struct udma_desc *d = uc->desc;
 
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
 			vchan_cookie_complete(&d->vd);
 			break;
 		}
@@ -554,7 +554,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 		}
 
 		if (!uc->desc)
-			udma_start(uc);
+			uc->ud->start(uc);
 
 		goto out;
 	}
@@ -576,8 +576,8 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 				vchan_cyclic_callback(&d->vd);
 			} else {
 				if (udma_is_desc_really_done(uc, d)) {
-					udma_decrement_byte_counters(uc, d->residue);
-					udma_start(uc);
+					uc->ud->decrement_byte_counters(uc, d->residue);
+					uc->ud->start(uc);
 					vchan_cookie_complete(&d->vd);
 				} else {
 					schedule_delayed_work(&uc->tx_drain.work,
@@ -612,8 +612,8 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 			vchan_cyclic_callback(&d->vd);
 		} else {
 			/* TODO: figure out the real amount of data */
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
 			vchan_cookie_complete(&d->vd);
 		}
 	}
@@ -1654,7 +1654,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -1821,7 +1821,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -2014,7 +2014,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -2123,7 +2123,7 @@ static void udma_issue_pending(struct dma_chan *chan)
 		 */
 		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
 		      udma_is_chan_running(uc)))
-			udma_start(uc);
+			uc->ud->start(uc);
 	}
 
 	spin_unlock_irqrestore(&uc->vc.lock, flags);
@@ -2265,7 +2265,7 @@ static int udma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&uc->vc.lock, flags);
 
 	if (udma_is_chan_running(uc))
-		udma_stop(uc);
+		uc->ud->stop(uc);
 
 	if (uc->desc) {
 		uc->terminated_desc = uc->desc;
@@ -2297,11 +2297,11 @@ static void udma_synchronize(struct dma_chan *chan)
 			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
 				 uc->id);
 			udma_dump_chan_stdata(uc);
-			udma_reset_chan(uc, true);
+			uc->ud->reset_chan(uc, true);
 		}
 	}
 
-	udma_reset_chan(uc, false);
+	uc->ud->reset_chan(uc, false);
 	if (udma_is_chan_running(uc))
 		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
 
@@ -2355,7 +2355,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 
 	udma_terminate_all(chan);
 	if (uc->terminated_desc) {
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		udma_reset_rings(uc);
 	}
 
@@ -3694,6 +3694,14 @@ static int udma_probe(struct platform_device *pdev)
 		ud->soc_data = soc->data;
 	}
 
+	// Setup function pointers
+	ud->start = udma_start;
+	ud->stop = udma_stop;
+	ud->reset_chan = udma_reset_chan;
+	ud->decrement_byte_counters = udma_decrement_byte_counters;
+	ud->psil_pair = navss_psil_pair;
+	ud->psil_unpair = navss_psil_unpair;
+
 	ret = udma_get_mmrs(pdev, ud);
 	if (ret)
 		return ret;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 4c6e5b946d5cf..2f5fbea446fed 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -344,6 +344,15 @@ struct udma_dev {
 	u32 psil_base;
 	u32 atype;
 	u32 asel;
+
+	int (*start)(struct udma_chan *uc);
+	int (*stop)(struct udma_chan *uc);
+	int (*reset_chan)(struct udma_chan *uc, bool hard);
+	void (*decrement_byte_counters)(struct udma_chan *uc, u32 val);
+	int (*psil_pair)(struct udma_dev *ud, u32 src_thread,
+			 u32 dst_thread);
+	int (*psil_unpair)(struct udma_dev *ud, u32 src_thread,
+			   u32 dst_thread);
 };
 
 struct udma_desc {
@@ -614,6 +623,9 @@ int udma_push_to_ring(struct udma_chan *uc, int idx);
 int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr);
 void udma_reset_rings(struct udma_chan *uc);
 
+int navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+int navss_psil_unpair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


