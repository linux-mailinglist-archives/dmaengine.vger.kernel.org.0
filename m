Return-Path: <dmaengine+bounces-2371-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7980909417
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 00:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D681F2264D
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 22:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A86118754C;
	Fri, 14 Jun 2024 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJp/MCTa"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4E1862B9;
	Fri, 14 Jun 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718403406; cv=fail; b=K229CtLqG+/AQK4x68xkxg2WDdkCmOI3EJzkBfNcomCiBu+Hf9zqVUuFFQ83LDrOgFppYeLWZwyt6INFrk+P7u3PIyd4CkApkBbs9oysgA2Qhh05/VGoNGX7Cx5aELQaT4gXOnS7698/rdekDbTQcZdH9f57Eb1qREZmFpM3YtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718403406; c=relaxed/simple;
	bh=2lOGRzTx4p08CUb36BtNffI4I078C66ao1hvSaDZsm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtpmIZrOfuT7pGtcCq8hFcati9b29+jJrTBCZG6y8YEOjSoczUqVNYsw7wVNNyUguGj87r9WkFAbKFXIjf/bdi5EosnvZIlDovYO71uDT80khiZgwD+qo/dV7DTI+b8BN+x+BERTmxTqWQlGgTOwwx4lQDGEOFF4eV/W1Cv4v70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJp/MCTa; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyDmWkZHPhrk5JRywqsdXcYc+j3uSN+IBf0dNJVGl8zNwZV9ZWPGR/rhFf1QkL6EvCKWX6oAxXpp6Lp8mFUD5m35aYv712ZpVwCjVsp/X447H7WHQ6iVTYCJmM/aEonb4HncqO2oxpkc/aSIRkdX9WyJiUqiJVrPXPRKdJdfH7RMEPCZr0lZ4mBu6U6v+CCqpBJVIk4DZNR4h3zAZ43JLJb+GNxHszRepuvqwb4DIUXMM1jWPLdZUSlyJp99ZLQL/Scee7D98BXxkbj9ub4UE/lyRhsReaPLCQidklvtXJHYzeAN/jIclKaQwfmWm0v3ZO5cXBwqJmNIF6f65puRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Hc6CfG76p/sijk5GtkVRUOWEv/pgj/Kai61B6gQOm4=;
 b=VqQrQto7XtQ3ZEOVI3mCFzt8jOrNC8FAaXPNuPoCkC/EUNFxXY6QmgKWUPZlsezDW/rfw/cwZzQgy0gT9rQH2oOfwlcpPtK0CHYt08+z1ZicEyWJ37nyfJm9WBoIgnP0o1gH5HI8UY059VUl6+dil5VP3sO73xZrkDyUeCLAmtjb5W6JFkd5ueRgD4N1ahJi0iRaObWCIlpWIx/+X/4jdO26f0dittcEnqhWp3xyxzcG/gc0JwnrST2bNWvzRuhRojDkTD98/hMSOvc/uGRxrFOlEJ3h+//OQMn6vbed7B45mq5awEVHGlwgFDmKf0H/6Ar6GIAadc6ZoGBEGzvh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Hc6CfG76p/sijk5GtkVRUOWEv/pgj/Kai61B6gQOm4=;
 b=uJp/MCTaZE/XsYv/8igUSH0ezCb7lIVpW8ZoayEuutwe2S14UQGiALOchSOjUAVG7hel7QAIVS8mhNwwGkjTWnOf/4t777/BbPoCswTV1xVZleDKvRE7aXUNOStjGrpT4KQp3Mwyx0kSPhX9z3JEGf+76jqXY6tsinO3NoEeFAU=
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Fri, 14 Jun
 2024 22:16:40 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::82) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 22:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 22:16:39 +0000
Received: from BLR-L-SHIVAGAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 17:16:33 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <bharata@amd.com>, <raghavendra.kodsarathimmappa@amd.com>,
	<Michael.Day@amd.com>, <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
	<shivankg@amd.com>, Mike Day <michael.day@amd.com>
Subject: [RFC PATCH 4/5] mm: add support for DMA folio Migration
Date: Sat, 15 Jun 2024 03:45:24 +0530
Message-ID: <20240614221525.19170-5-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 455125b0-30cf-4de1-f2b2-08dc8cbfa9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XyQUv2s9dH3vKiDYGmr+m68vR9oSRaKqdrvdg7fdxp7ujmvA5RAVEjugfSCv?=
 =?us-ascii?Q?I+hEop6sLSAmNog+MwXhS5jyYlcFmptl/3Uy0OaCNxVZluAmh1cNxr3sj0yj?=
 =?us-ascii?Q?0B1vrJMq6GnxLWwe2Dd7fTR8q+s4Fl0U/YwpuVtunkPJ/PcPdZj35qI2nHqe?=
 =?us-ascii?Q?MoVIcmiWOTt+7YFxrcSVS0bskBPMSq/mjxYQ1TvkSddOiC/fjft7tr8uEMiQ?=
 =?us-ascii?Q?jrUedknxsRu+d5ps70D2ejocQLBl9tcsklbHrvNCBVOtOHfSNF6WDCx20TA/?=
 =?us-ascii?Q?Hbi9HkfoJsla/iSR3gmwGPs5e0uLkbfstbuSvSyC9ZIduyUxBXTiPXSd9W1l?=
 =?us-ascii?Q?kFoWv+0ebWq9nuRiAyaKS5O/qjJjyDRPdMz9BHVW6rosWFe1pn1Nhe8Se1fb?=
 =?us-ascii?Q?chTWv+zvAxeIG9yzomPHuGAlqfk4HSdfi6kSzZyG1TplWaG5JoEZHa/qS06G?=
 =?us-ascii?Q?y+WzPcuwQCUXt+qOvLbgcoJkb97gINcBhP1MDK8cVA76dJ56ZCwXx8c+FO1W?=
 =?us-ascii?Q?LV3gdSwQ1WoW6S3+AgYIFMIyTWWkDRr//JuU6LCBtJXoxPKOlIEVme/fT12p?=
 =?us-ascii?Q?gunJ6E4inPemywTOmjiBI5dqDO5/6TjzO4X6D2SZAEgznHI9iQURk3BoMbYA?=
 =?us-ascii?Q?IXQ4HFZzm7bVYXHFK9eZfrfkdSCQz+f6PHoBFWrikQW8h/APlxKUGvz2Iv/S?=
 =?us-ascii?Q?9pXgNoT2VyP73Vnogc4NMZMoPKX7ZqOd5Q1M6i9sGa9vff2Ssan9iWeS9E8k?=
 =?us-ascii?Q?xfQWwwYo7EXQ+1pUeyJ4zeSSQqxkiA8hIG9IhRFY8i33JJSNblyQqtcbexp0?=
 =?us-ascii?Q?ZEdCyycnpc1/zRxNjbyQ+vGI/Aojj215qWEqX3jUcUGBTZunjeoxstN4QD62?=
 =?us-ascii?Q?ggmkIoccH4wpSp1cXx4MlF6GvvNduIhIgAKxZE5F+/zDAUhzt8Ue6C7OU+aF?=
 =?us-ascii?Q?OCoNxsz+HkzQI+GU8t3jLUa+VuWvaQPIgi8Eoa+G+FOWe2Kons1CiJTECQzC?=
 =?us-ascii?Q?vdmGGkRb8NjfR3YCgSN5XNI33upyHY1TTmLMkNC3z/wPQIO0JgUCzuSVt9dg?=
 =?us-ascii?Q?TuKE0ACFKePmiWP9cb8RPvPHICwxiXvibXrfbR5+Judvy0ojJIqjrP7NFJhf?=
 =?us-ascii?Q?M+RqKIaBGtaFVpJU4iUA7zti0bFp09LrBeYaQ3fNgryvxcJwUVKc4p9S22jd?=
 =?us-ascii?Q?/NB7uJ9mqq9sZLa0OKtNyVGbUpN4VcLFuBcAzjHs2VxgFzuqGKri79HAhWzp?=
 =?us-ascii?Q?DNpYWhRVXewIJL9+T2wF6JIKq5IVyX0WhCnTX8bKY+zqwotCazx/BGMwvw5Q?=
 =?us-ascii?Q?JqeZQconFpAm1XHT3HuyAbYA8+Oy/p+HpEbExH/L6SptqHAKoyEOzW1PpHnW?=
 =?us-ascii?Q?a5CJVFyvJxCEehwo5LDl++kG/KU7/DyTl+Rg77FmEcvy7iDvMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:16:39.3467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455125b0-30cf-4de1-f2b2-08dc8cbfa9df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939

From: Mike Day <michael.day@amd.com>

DMA drivers should implement following functions to enable folio migration
offloading:
migrate_dma() - This function takes src and dst folios list undergoing
migration. It is responsible for transfer of page content between the
src and dst folios.
can_migrate_dma() - It performs necessary checks if DMA-migration is
supported for the give src and dst folios.

DMA driver should include a mechanism to call start_offloading and
stop_offloading for enabling and disabling migration offload respectively.

Signed-off-by: Mike Day <michael.day@amd.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/migrate_dma.h | 36 ++++++++++++++++++++++++++
 mm/Kconfig                  |  8 ++++++
 mm/Makefile                 |  1 +
 mm/migrate.c                | 40 +++++++++++++++++++++++++++--
 mm/migrate_dma.c            | 51 +++++++++++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/migrate_dma.h
 create mode 100644 mm/migrate_dma.c

diff --git a/include/linux/migrate_dma.h b/include/linux/migrate_dma.h
new file mode 100644
index 000000000000..307b234450c3
--- /dev/null
+++ b/include/linux/migrate_dma.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _MIGRATE_DMA_H
+#define _MIGRATE_DMA_H
+#include <linux/migrate_mode.h>
+
+#define MIGRATOR_NAME_LEN 32
+struct migrator {
+	char name[MIGRATOR_NAME_LEN];
+	void (*migrate_dma)(struct list_head *dst_list, struct list_head *src_list);
+	bool (*can_migrate_dma)(struct folio *dst, struct folio *src);
+	struct rcu_head srcu_head;
+	struct module *owner;
+};
+
+extern struct migrator migrator;
+extern struct mutex migrator_mut;
+extern struct srcu_struct mig_srcu;
+
+#ifdef CONFIG_DMA_MIGRATION
+void srcu_mig_cb(struct rcu_head *head);
+void dma_update_migrator(struct migrator *mig);
+unsigned char *get_active_migrator_name(void);
+bool can_dma_migrate(struct folio *dst, struct folio *src);
+void start_offloading(struct migrator *migrator);
+void stop_offloading(void);
+#else
+static inline void srcu_mig_cb(struct rcu_head *head) { };
+static inline void dma_update_migrator(struct migrator *mig) { };
+static inline unsigned char *get_active_migrator_name(void) { return NULL; };
+static inline bool can_dma_migrate(struct folio *dst, struct folio *src) {return true; };
+static inline void start_offloading(struct migrator *migrator) { };
+static inline void stop_offloading(void) { };
+#endif /* CONFIG_DMA_MIGRATION */
+
+#endif /* _MIGRATE_DMA_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index ffc3a2ba3a8c..e3ff6583fedb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -662,6 +662,14 @@ config MIGRATION
 config DEVICE_MIGRATION
 	def_bool MIGRATION && ZONE_DEVICE
 
+config DMA_MIGRATION
+	bool "Migrate Pages offloading copy to DMA"
+	def_bool n
+	depends on MIGRATION
+	help
+	 An interface allowing external modules or driver to offload
+	 page copying in page migration.
+
 config ARCH_ENABLE_HUGEPAGE_MIGRATION
 	bool
 
diff --git a/mm/Makefile b/mm/Makefile
index e4b5b75aaec9..1e31fb79d700 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_DMA_MIGRATION) += migrate_dma.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
diff --git a/mm/migrate.c b/mm/migrate.c
index fce69a494742..db826e3862a1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -50,6 +50,7 @@
 #include <linux/random.h>
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
+#include <linux/migrate_dma.h>
 
 #include <asm/tlbflush.h>
 
@@ -656,6 +657,37 @@ void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_copy);
 
+DEFINE_STATIC_CALL(_folios_copy, folios_copy);
+DEFINE_STATIC_CALL(_can_dma_migrate, can_dma_migrate);
+
+#ifdef CONFIG_DMA_MIGRATION
+void srcu_mig_cb(struct rcu_head *head)
+{
+	static_call_query(_folios_copy);
+}
+
+void dma_update_migrator(struct migrator *mig)
+{
+	int index;
+
+	mutex_lock(&migrator_mut);
+	index = srcu_read_lock(&mig_srcu);
+	strscpy(migrator.name, mig ? mig->name : "kernel", MIGRATOR_NAME_LEN);
+	static_call_update(_folios_copy, mig ? mig->migrate_dma : folios_copy);
+	static_call_update(_can_dma_migrate, mig ? mig->can_migrate_dma : can_dma_migrate);
+	if (READ_ONCE(migrator.owner))
+		module_put(migrator.owner);
+	xchg(&migrator.owner, mig ? mig->owner : NULL);
+	if (READ_ONCE(migrator.owner))
+		try_module_get(migrator.owner);
+	srcu_read_unlock(&mig_srcu, index);
+	mutex_unlock(&migrator_mut);
+	call_srcu(&mig_srcu, &migrator.srcu_head, srcu_mig_cb);
+	srcu_barrier(&mig_srcu);
+}
+
+#endif /* CONFIG_DMA_MIGRATION */
+
 /************************************************************
  *                    Migration functions
  ***********************************************************/
@@ -1686,6 +1718,7 @@ static void migrate_folios_batch_move(struct list_head *src_folios,
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru;
 	int is_thp = 0;
+	bool can_migrate = true;
 	struct migrate_folio_info *mig_info, *mig_info2;
 	LIST_HEAD(temp_src_folios);
 	LIST_HEAD(temp_dst_folios);
@@ -1720,7 +1753,10 @@ static void migrate_folios_batch_move(struct list_head *src_folios,
 		 * This does everything except the page copy. The actual page copy
 		 * is handled later in a batch manner.
 		 */
-		if (likely(is_lru)) {
+		can_migrate = static_call(_can_dma_migrate)(dst, folio);
+		if (unlikely(!can_migrate))
+			rc = -EAGAIN;
+		else if (likely(is_lru)) {
 			struct address_space *mapping = folio_mapping(folio);
 
 			if (!mapping)
@@ -1786,7 +1822,7 @@ static void migrate_folios_batch_move(struct list_head *src_folios,
 		goto out;
 
 	/* Batch copy the folios */
-	folios_copy(dst_folios, src_folios);
+	static_call(_folios_copy)(dst_folios, src_folios);
 
 	/*
 	 * Iterate the folio lists to remove migration pte and restore them
diff --git a/mm/migrate_dma.c b/mm/migrate_dma.c
new file mode 100644
index 000000000000..c8b078fdff17
--- /dev/null
+++ b/mm/migrate_dma.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/migrate.h>
+#include <linux/migrate_dma.h>
+#include <linux/rculist.h>
+#include <linux/static_call.h>
+
+atomic_t dispatch_to_dma = ATOMIC_INIT(0);
+EXPORT_SYMBOL_GPL(dispatch_to_dma);
+
+DEFINE_MUTEX(migrator_mut);
+DEFINE_SRCU(mig_srcu);
+
+struct migrator migrator = {
+	.name = "kernel",
+	.migrate_dma = folios_copy,
+	.can_migrate_dma = can_dma_migrate,
+	.srcu_head.func = srcu_mig_cb,
+	.owner = NULL,
+};
+
+bool can_dma_migrate(struct folio *dst, struct folio *src)
+{
+	return true;
+}
+EXPORT_SYMBOL_GPL(can_dma_migrate);
+
+void start_offloading(struct migrator *m)
+{
+	int offloading = 0;
+
+	pr_info("starting migration offload by %s\n", m->name);
+	dma_update_migrator(m);
+	atomic_try_cmpxchg(&dispatch_to_dma, &offloading, 1);
+}
+EXPORT_SYMBOL_GPL(start_offloading);
+
+void stop_offloading(void)
+{
+	int offloading = 1;
+
+	pr_info("stopping migration offload by %s\n", migrator.name);
+	dma_update_migrator(NULL);
+	atomic_try_cmpxchg(&dispatch_to_dma, &offloading, 0);
+}
+EXPORT_SYMBOL_GPL(stop_offloading);
+
+unsigned char *get_active_migrator_name(void)
+{
+	return migrator.name;
+}
+EXPORT_SYMBOL_GPL(get_active_migrator_name);
-- 
2.34.1


