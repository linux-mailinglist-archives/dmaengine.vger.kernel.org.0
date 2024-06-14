Return-Path: <dmaengine+bounces-2370-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D99909414
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 00:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9881C21023
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F612186E57;
	Fri, 14 Jun 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="23M0xCFA"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D1186E29;
	Fri, 14 Jun 2024 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718403402; cv=fail; b=gJRS5Mhvrs/WHwIg3ZzF1+S0ebM0SyASsuvl58H9mAxh4Kf2hmhxnKDpWuwkF++MDob99eZEa7czkng/RINqnTU/qa0nHA3X0oJgOnmkTx7FlrUSYTKc5S5igoylYDdgnVPt77xtoBGhO8AH2bKF3CVyc7X/c7t4TSOyNV3RINk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718403402; c=relaxed/simple;
	bh=N7b6t6nKAY6kv9gY3huKKtVSgch4oq0Ga08YN1MTDgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2x5Smuz9zxH2wfqvbn0U868JmQvl1aR9atzs0D1itWyaN2XLZKXvNARdpOXHyCgKNV3wKHAy+lxvLOhmARpp+wegx6oa6dnC8n6dEaW/g/ryzk8DJoI2xGLHRBcXCCr8W3/g8qXwUst4zHd/JKWIR7l/BEEWOXF2FHxzjB6Ip8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=23M0xCFA; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAZ9D6ZkPh6wnGmQ8Yjx4TSYxfV3vm+FpNyO2CfftIdPRZaR2w32fpliUh5yXmh3Wk0KA0aUOh01PcZzPEKLUxrnLvMTyFnhq1IVsWP31ueQR9AkOcp9GLIita3gLwuIymt9aq42Jbp3fe2WDd50pZu8Lg2hdsUVJlWDBi5CS3UU87onA4+6Cdiiv0LvMLUQubKsbn1S5XzvCMWYtO2XSr66LBLI515OSXqfs7ng7+zgD4An/8EvYia/CHKMR9ItCiNR9VkyTXo8CU5EXFnGyS/TeU+jxi3GcM9hBJ29H3pRa86ueF+IfsO4/FwZf4aDN6c0wzE20vQ8Nc4GwQrWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPio4bxFILAqiYRQIwgxfYQY7t+eiEq4ufvJeX3p6m8=;
 b=eLH/oKXAa9MV1hutVGErIdiFz4g46XIrPjaJn3sgExjr9JQUkMNWQOndm2BF/r5KdYyMFOHa9wlRBdxnaJOXeYHLI6twry6fXSIVVKtXiKvV1rxV8+fbDcLhksQENeR4Lz+xJYKS/P3RjnoZVmgZy3XL01FNWdQdPzNFzhPFZrNYYSXbQwdVXDHwW+jm/R84eN6SO2jlgSKs+nFS63R3U5wa0r6L20jHDWNaqyVp8HY3kSJaznGJzWgLpRFvmnZcXDGggv0I3MYnAx91zfcGmB/CRhNYJNaZwA7TZjPyc1cIvbnPPzgFPVFOkyE1xe0ZSBiqpGIZp5WGmaEKJYO64A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPio4bxFILAqiYRQIwgxfYQY7t+eiEq4ufvJeX3p6m8=;
 b=23M0xCFAxfBCtYUlLmQpZaKj8WTYWV1oteUGEZs6o/A5ubq3aWXOCc6gHBVpwOg/0AA8IDrxUFpk4uZvGhNeYLpxk7G4kC0omPgAxpnBJ2/X/xL4PUHg6Un5T8thwgLv/uVqw9zqo7Lc6q71Ct1WuZUm1jB+e4HrsEcBOwHWqJ8=
Received: from DM6PR13CA0022.namprd13.prod.outlook.com (2603:10b6:5:bc::35) by
 LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 22:16:35 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::23) by DM6PR13CA0022.outlook.office365.com
 (2603:10b6:5:bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Fri, 14 Jun 2024 22:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 22:16:34 +0000
Received: from BLR-L-SHIVAGAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 17:16:29 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <bharata@amd.com>, <raghavendra.kodsarathimmappa@amd.com>,
	<Michael.Day@amd.com>, <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
	<shivankg@amd.com>
Subject: [RFC PATCH 3/5] mm: add migrate_folios_batch_move to batch the folio move operations
Date: Sat, 15 Jun 2024 03:45:23 +0530
Message-ID: <20240614221525.19170-4-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614221525.19170-1-shivankg@amd.com>
References: <20240614221525.19170-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2bff54-580a-4823-2337-08dc8cbfa715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/gQbTpKJTJt91DURPcQSZx5M4WWRbBE7XbZ2s8a4wxu19JGclmlKndY2o9EQ?=
 =?us-ascii?Q?mW9V9ae1Utp8RdC5Sa4zZvPG1D8Zpp0/lMb1c+SC8CB5OGm7AOsP4QmF2IL1?=
 =?us-ascii?Q?oFXGapG6e9PyYy0H6SWZ0L3ccwA+W9ky7K1DYdktzBpmYMPGmnUmiKyxmay7?=
 =?us-ascii?Q?Jl2RkiS1gcj7iNq0wqdTPBmg60rpFYFHk5CV3f61eLYx3hRRK3mYraB0Mh3M?=
 =?us-ascii?Q?Ysexo/upcg72griklhZpa56DNWadJrA27z6Zpn1nTSPWLI5qjihjhK9xGvZh?=
 =?us-ascii?Q?+/L33k5+tQUedE9tHRDaKqM++uzm5abX/YzR50/TSnMM4LSlhznDb/cZaY+w?=
 =?us-ascii?Q?6VXbRJ0GREEHc3Mpj2HYanKb3orIs/cnfmAa5KD6tc4mvs8nHUvUGI7AQxV9?=
 =?us-ascii?Q?BT9rShLvrKTC3SPfGNu9FbfRI1tVeRIEwXmaUL3EZU/uXNyfjeiekK8zv06d?=
 =?us-ascii?Q?366kZaVwsIbE3qRdEVDrRETHsHPoyVzFvXKFm0QNaD/pBdorNhy1FK308lz2?=
 =?us-ascii?Q?jNj6xwqSJwIv+C8t5nB8ZBEvs1JXmV6WMLHi0vUwPlSrN16fjqzV4KUEszOW?=
 =?us-ascii?Q?i2pei6tjsHll4tVKiP/In/J49Wg3xxSsYTAjQ3w//kbSoW7aa6WgHbUE+mFg?=
 =?us-ascii?Q?8vTx03RX4BGzUpXxLiWE37ciuMkh/TRfG587gnybcs6wBi24WNJ95YRmsMkz?=
 =?us-ascii?Q?00yxOPZGQAa8/x2frjwSEw3k6KB/2ondMWeJc2gEbBP6xI0B26bDBMPxmhwZ?=
 =?us-ascii?Q?vdOzA6JVVRncaoGGV8XiA/41pZ5/Bpqma13ky7vmveZAuCfsa67+G5Ixcgyp?=
 =?us-ascii?Q?NEWOqpEQgcPTo6lfrhSDkwUaJ9S1Eweb+/zziJbKkRNnXVZT1YB4K2e0+qk3?=
 =?us-ascii?Q?iKIjXW9SZtSt6FEZUL6sPaBIQKWmKQSysR6QX0AzD0avFRVNVBw/mw0pdI0b?=
 =?us-ascii?Q?2jqyBBJ6LFSfvGJ1g1d8hay1QGMbmLqlgMPN08ZGobtyKmCZiV4SQETmzI9u?=
 =?us-ascii?Q?iYrNASAg2/S//wNdW2LwngpS60U+o5L6NLHL4Lly7OlXWHncFUPwGmjR4XRo?=
 =?us-ascii?Q?TYvQqtZrCVsEdPq8GLo07eeVEDAT+x0psHW7VMHMPplTg9WS11+ynKOKKwjt?=
 =?us-ascii?Q?Fi6ePXOY9MaexZV0NkDs/GJrj4ny619/48NkpVg7lFuQhigwP3shiiGl+uwp?=
 =?us-ascii?Q?B3yXej2HRb4ylTxyrs8foAEFat0dgogZRvcB7I0PYZbj3hIOjfKABD7QunYj?=
 =?us-ascii?Q?FwE2ATJFKyQ3lFpS3Zdy0eLQ8Qfxyj9QQhS+DQT/Jw/1ol6mH+1VoMthSHRC?=
 =?us-ascii?Q?by5UrwnxprLQvrT/zgAkIanK78rg5Ue0pUwDu6WLhh69zjbzkJw0t3Pfiee9?=
 =?us-ascii?Q?HHAyX8jViMwDUn5Yzctsi0KYtpqm3/Kcw3JIA2fEN5b3yy8Peg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:16:34.7090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2bff54-580a-4823-2337-08dc8cbfa715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

This is a preparatory patch that enable batch copying for folios undergoing
migration. By enabling batch copying the folio content, we can efficiently
utilize the capabilities of DMA hardware.

Currently, the folio move operation is performed individually for each
folio in sequential manner:
for_each_folio() {
        Copy folio metadata like flags and mappings
        Copy the folio bytes from src to dst
        Update PTEs with new mappings
}

With this patch, we transition to a batch processing approach as shown
below:
for_each_folio() {
        Copy folio metadata like flags and mappings
}
Batch copy all pages from src to dst
for_each_folio() {
        Update PTEs with new mappings
}

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/migrate.c | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6c36c6e0a360..fce69a494742 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -57,6 +57,11 @@
 
 #include "internal.h"
 
+struct migrate_folio_info {
+	unsigned long private;
+	struct list_head list;
+};
+
 bool isolate_movable_page(struct page *page, isolate_mode_t mode)
 {
 	struct folio *folio = folio_get_nontail_page(page);
@@ -1055,6 +1060,14 @@ static void __migrate_folio_extract(struct folio *dst,
 	dst->private = NULL;
 }
 
+static void __migrate_folio_extract_private(unsigned long private,
+					int *old_page_state,
+					struct anon_vma **anon_vmap)
+{
+	*anon_vmap = (struct anon_vma *)(private & ~PAGE_OLD_STATES);
+	*old_page_state = private & PAGE_OLD_STATES;
+}
+
 /* Restore the source folio to the original state upon failure */
 static void migrate_folio_undo_src(struct folio *src,
 				   int page_was_mapped,
@@ -1658,6 +1671,201 @@ static void migrate_folios_move(struct list_head *src_folios,
 	}
 }
 
+static void migrate_folios_batch_move(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		enum migrate_mode mode, int reason,
+		struct list_head *ret_folios,
+		struct migrate_pages_stats *stats,
+		int *retry, int *thp_retry, int *nr_failed,
+		int *nr_retry_pages)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+	int rc, nr_pages = 0, nr_mig_folios = 0;
+	int old_page_state = 0;
+	struct anon_vma *anon_vma = NULL;
+	bool is_lru;
+	int is_thp = 0;
+	struct migrate_folio_info *mig_info, *mig_info2;
+	LIST_HEAD(temp_src_folios);
+	LIST_HEAD(temp_dst_folios);
+	LIST_HEAD(mig_info_list);
+
+	if (mode != MIGRATE_ASYNC) {
+		*retry += 1;
+		return;
+	}
+
+	/*
+	 * Iterate over the list of locked src/dst folios to copy the metadata
+	 */
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		mig_info = kmalloc(sizeof(*mig_info), GFP_KERNEL);
+		if (!mig_info)
+			break;
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+		is_lru = !__folio_test_movable(folio);
+
+		__migrate_folio_extract(dst, &old_page_state, &anon_vma);
+
+		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+		VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
+
+		/*
+		 * Use MIGRATE_SYNC_NO_COPY mode in migrate_folio family functions
+		 * to copy the flags, mapping and some other ancillary information.
+		 * This does everything except the page copy. The actual page copy
+		 * is handled later in a batch manner.
+		 */
+		if (likely(is_lru)) {
+			struct address_space *mapping = folio_mapping(folio);
+
+			if (!mapping)
+				rc = migrate_folio(mapping, dst, folio, MIGRATE_SYNC_NO_COPY);
+			else if (mapping_unmovable(mapping))
+				rc = -EOPNOTSUPP;
+			else if (mapping->a_ops->migrate_folio)
+				rc = mapping->a_ops->migrate_folio(mapping, dst, folio,
+						MIGRATE_SYNC_NO_COPY);
+			else
+				rc = fallback_migrate_folio(mapping, dst, folio,
+						MIGRATE_SYNC_NO_COPY);
+		} else {
+			/*
+			 * Let CPU handle the non-LRU pages for initial review.
+			 * TODO: implement
+			 * Can we move non-MOVABLE LRU case and mapping_unmovable case
+			 * in unmap_and_move_huge_page and migrate_folio_unmap?
+			 */
+			rc = -EAGAIN;
+		}
+		/*
+		 * Turning back after successful migrate_folio may create
+		 * side-effects as dst mapping/index and xarray are updated.
+		 */
+
+		/*
+		 * -EAGAIN: Move src/dst folios to tmp lists for retry
+		 * Other Errno: Put src folio on ret_folios list, remove the dst folio
+		 * Success: Copy the folio bytes, restoring working pte, unlock and
+		 *	    decrement refcounter
+		 */
+		if (rc == -EAGAIN) {
+			*retry += 1;
+			*thp_retry += is_thp;
+			*nr_retry_pages += nr_pages;
+
+			kfree(mig_info);
+			list_move_tail(&folio->lru, &temp_src_folios);
+			list_move_tail(&dst->lru, &temp_dst_folios);
+			__migrate_folio_record(dst, old_page_state, anon_vma);
+		} else if (rc != MIGRATEPAGE_SUCCESS) {
+			*nr_failed += 1;
+			stats->nr_thp_failed += is_thp;
+			stats->nr_failed_pages += nr_pages;
+
+			kfree(mig_info);
+			list_del(&dst->lru);
+			migrate_folio_undo_src(folio, old_page_state & PAGE_WAS_MAPPED,
+					anon_vma, true, ret_folios);
+			migrate_folio_undo_dst(dst, true, put_new_folio, private);
+		} else { /* MIGRATEPAGE_SUCCESS */
+			nr_mig_folios++;
+			mig_info->private = (unsigned long)((void *)anon_vma + old_page_state);
+			list_add_tail(&mig_info->list, &mig_info_list);
+		}
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+
+	/* Exit if folio list for batch migration is empty */
+	if (!nr_mig_folios)
+		goto out;
+
+	/* Batch copy the folios */
+	folios_copy(dst_folios, src_folios);
+
+	/*
+	 * Iterate the folio lists to remove migration pte and restore them
+	 * as working pte. Unlock the folios, add/remove them to LRU lists (if
+	 * applicable) and release the src folios.
+	 */
+	mig_info = list_first_entry(&mig_info_list, struct migrate_folio_info, list);
+	mig_info2 = list_next_entry(mig_info, list);
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+		__migrate_folio_extract_private(mig_info->private, &old_page_state, &anon_vma);
+		list_del(&dst->lru);
+		if (__folio_test_movable(folio)) {
+			VM_BUG_ON_FOLIO(!folio_test_isolated(folio), folio);
+			/*
+			 * We clear PG_movable under page_lock so any compactor
+			 * cannot try to migrate this page.
+			 */
+			folio_clear_isolated(folio);
+		}
+
+		/*
+		 * Anonymous and movable src->mapping will be cleared by
+		 * free_pages_prepare so don't reset it here for keeping
+		 * the type to work PageAnon, for example.
+		 */
+		if (!folio_mapping_flags(folio))
+			folio->mapping = NULL;
+
+		if (likely(!folio_is_zone_device(dst)))
+			flush_dcache_folio(dst);
+
+		/*
+		 * Below few steps are only applicable for lru pages which is
+		 * ensured as we have removed the non-lru pages from our list.
+		 */
+		folio_add_lru(dst);
+		if (old_page_state & PAGE_WAS_MLOCKED)
+			lru_add_drain(); // can this step be optimized for batch?
+		if (old_page_state & PAGE_WAS_MAPPED)
+			remove_migration_ptes(folio, dst, false);
+
+		folio_unlock(dst);
+		set_page_owner_migrate_reason(&dst->page, reason);
+
+		/*
+		 * Decrease refcount of dst. It will not free the page because
+		 * new page owner increased refcounter.
+		 */
+		folio_put(dst);
+		/* Remove the source folio from the list */
+		list_del(&folio->lru);
+		/* Drop an anon_vma reference if we took one */
+		if (anon_vma)
+			put_anon_vma(anon_vma);
+		folio_unlock(folio);
+		migrate_folio_done(folio, reason);
+
+		/* Page migration successful, increase stat counter */
+		stats->nr_succeeded += nr_pages;
+		stats->nr_thp_succeeded += is_thp;
+
+		list_del(&mig_info->list);
+		kfree(mig_info);
+		mig_info = mig_info2;
+		mig_info2 = list_next_entry(mig_info, list);
+
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+out:
+	/* Add tmp folios back to the list to let CPU re-attempt migration. */
+	list_splice(&temp_src_folios, src_folios);
+	list_splice(&temp_dst_folios, dst_folios);
+}
+
 static void migrate_folios_undo(struct list_head *src_folios,
 		struct list_head *dst_folios,
 		free_folio_t put_new_folio, unsigned long private,
@@ -1833,13 +2041,18 @@ static int migrate_pages_batch(struct list_head *from,
 	/* Flush TLBs for all unmapped folios */
 	try_to_unmap_flush();
 
-	retry = 1;
+	retry = 0;
+	/* Batch move the unmapped folios */
+	migrate_folios_batch_move(&unmap_folios, &dst_folios, put_new_folio,
+			private, mode, reason, ret_folios, stats, &retry,
+			&thp_retry, &nr_failed, &nr_retry_pages);
+
 	for (pass = 0; pass < nr_pass && retry; pass++) {
 		retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
-		/* Move the unmapped folios */
+		/* Move the remaining unmapped folios */
 		migrate_folios_move(&unmap_folios, &dst_folios,
 				put_new_folio, private, mode, reason,
 				ret_folios, stats, &retry, &thp_retry,
-- 
2.34.1


