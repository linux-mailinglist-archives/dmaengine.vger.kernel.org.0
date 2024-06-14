Return-Path: <dmaengine+bounces-2368-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93F909410
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 00:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE96E2854CF
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D1318308F;
	Fri, 14 Jun 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lCA//9EI"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787581386B3;
	Fri, 14 Jun 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718403395; cv=fail; b=VEHB3OZsjJ2PXeFXynYimaF07zyepaiPvfBIsgyFcAYte4g1dZwG3/CnGCFIP20ZCn65rfAwaGjD6vBBDx4FsUop8UWZBT6fiR4c8tXUYzxvovkCQp9GL2Ilgy3N8m7jLiOPCAreU06jyXjWlGFVwSpx5t3ajhsnm6SnFOmk7eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718403395; c=relaxed/simple;
	bh=1ETBOh5UwVav60kPAFUHvjRYDhByWXKnPEC070kD8gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXtIIgaTNGDgp0CwRjVbfV4piZYl6qbWgIltAx1De/AOTTxIHBMJ1fWrDnkdhouT1P4r+LRts3MZCy4uHpWZyihAwSyAoQL2+Qfyiu0N8srATc6M8QZwy5OrRvy09UTVRu0JkYkewTwEH92PI3lGlYvJ8q4yrc5Amm2FFpaJXEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lCA//9EI; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzStBe8T974ZdKnRVH83dkDInGyfO5RGmn43iudb7fsK2fkB4bGDJnWG109qZzIF6ts7nDo2YdTd3ACseWL88rrNDb5y9ci2DhxrWnJJbNuMtakB2f3H+3Y1P07dlL9H2W2DESFn2HRlJuEQicuUh0S2/7iPdkLQbohGYCnWm57/pB1ALOE0wVPJ+H/O0QYicP1yBjtBUq2jiAb7z3VBE7UpZUsYUCHtqka2An08vIn+8Z3ba65X+SD33N8dNcqCaBubmlrdLSTZJxzLsmNsMZfcDmZAo7AueFBMig8XW6z8tcLIs68WSrk5lUxxDW9K+KmlJM5h/xrxKe8GyGEDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFtwicY4CyhIt3hTfES90NWrdOR1HL5qCnm9jVePVUs=;
 b=Y21oqrxVOcP8CpuVRQTtpQYqH9YlwRmHUhfuNv74KQG4UG2tXL3Ru+XgeAUOjx3MlINVxspyJ4gaNdMgLG0yKHS8x1clhAhdmXyefxu3K0YDXPN3mfxbh+v1ijHobPoBvyv+WUTYsZsgB2HcRFKbhb5uRHQKF1KCzzmc2eja/dkzFFzmrAFVu714B6d5W438BWvYC9Rmo1Fo+vLL+J/2O4rM9Hlcg5t4HC58uVElr/2y4V8j/g9aiUQbniIbqdn7AY3/nz7aadI8p6nVRXtPTqN8aisdflQhLyN5YQXtJGuOy+jUw4rhy8jwTVfzFdQ2kY/lOpJCblJn6sLdGReMeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFtwicY4CyhIt3hTfES90NWrdOR1HL5qCnm9jVePVUs=;
 b=lCA//9EI+Hdd7ew2z9isp3J6U3/VRmWIeLir/s2IZCJPCQ/fhIrp8xK5mzzB82EfJrMwjmmp/Cg8ZjO/gH31Yi1uv3QUZzUPWQa7m1mG1Z3xDhiJ0h6025LzgTSz/Nwj7pgFnkdGjCKyOY1aTQFzgtvTAbsMZzcKwMNfyqx8sgs=
Received: from DM6PR13CA0025.namprd13.prod.outlook.com (2603:10b6:5:bc::38) by
 IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 22:16:27 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::31) by DM6PR13CA0025.outlook.office365.com
 (2603:10b6:5:bc::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 22:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 22:16:26 +0000
Received: from BLR-L-SHIVAGAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 17:16:21 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <bharata@amd.com>, <raghavendra.kodsarathimmappa@amd.com>,
	<Michael.Day@amd.com>, <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
	<shivankg@amd.com>, Byungchul Park <byungchul@sk.com>
Subject: [RFC PATCH 1/5] mm: separate move/undo doing on folio list from migrate_pages_batch()
Date: Sat, 15 Jun 2024 03:45:21 +0530
Message-ID: <20240614221525.19170-2-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f60414b-8c3a-4634-6e58-08dc8cbfa231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5dh8prkNJ+fATbJRmMwsCID/1cj2gcVR+EGg8eZWJSv6WJLmvZiq09OtiQjS?=
 =?us-ascii?Q?thzDGY+VEsF73llLue+jTbQbT/MfoOKzqOu/oMzqvGDTblAJdOTrAHTo/go7?=
 =?us-ascii?Q?fX4kBKJ0aa49Lpbp20socpHoAdJXp9UzIXXG1YuoVohGxl78jhM2IaNxU/p0?=
 =?us-ascii?Q?/SaonSSCe41Yx5j+Rll4FbPS5XQaWEAiFu9CgMyRrKXUOLgcRK5ecNRO/hwn?=
 =?us-ascii?Q?23gfbPl4fh9U1R4w31hFqQusnmTnh41IqUHojXQ61gSa8FJGK7BiDFWrekZY?=
 =?us-ascii?Q?KpOz5pke+NIJ0p7HorjsgW5mwl4F+/lNcUhR5WoJFh/8T4ASIvmijAKKcUq1?=
 =?us-ascii?Q?GgR+OAJThmu4za7chdDRSs3jbUctOipoaNYY3zhhj1tJpux9uhsHpnd4qiFe?=
 =?us-ascii?Q?EbGSHMskoAP7yS9ja3BhJsKWfWnM5K4HWiqn4KipRerejkTXVn3VzWg9jkFS?=
 =?us-ascii?Q?wOUJmugwoWCPQ0NfLMXJWv2uDl9134GeTdJ/EcPXovu2tELMYdUs7wGT8GJo?=
 =?us-ascii?Q?awHdfO+JXq13mHfOlIXJb7C//gB4VSJAOt7mSmNL6+FZ8RtcP9kVSCZq6m8K?=
 =?us-ascii?Q?+W92yVkwYsODUJIepj2ig0hjt/RwKaPOJjOaLrR++nVAy1c1glk5PczOK9/3?=
 =?us-ascii?Q?+JX5Zr0wxq2tuRl8qDma6r5TT6fqoxOWSXRHx2/GxmGXuSaMzQpEWrjFOQqk?=
 =?us-ascii?Q?CnxSdYvPHwwdtNPkcF3Fkir/WjaButropI7RmvxmVJC+tvd2Aqa5cguLUIjs?=
 =?us-ascii?Q?242jESJEozODf2eJd4HNjY4Ln/8oFTIOSN4WSb/3vpJRUpgle9BYEMfrLEXv?=
 =?us-ascii?Q?pJffhAOhtFEiM8qVG/8lMuLyvYu8JatU+nsaPAu5hvGBWuQ/gOYFHdP2uLj2?=
 =?us-ascii?Q?f+aWW/zi3B1PI7ld10hI3N6FKv9zbxjIFeFg3pjXfWaN/O7/SwZc6qJtHN3T?=
 =?us-ascii?Q?/z7y6JTVWdzlX/XMtpEcE5rs5wEk6KgXJFQPZcJeiRRVFLqULe6+w/HpUtir?=
 =?us-ascii?Q?Xr9ae2EJq5nN5ib2T9rq+8J/++nBfMKIpsz8IBEsYPG42QLfrIXgqNUHIzbN?=
 =?us-ascii?Q?QwIpAYfLgxU0tgdPSbDR4VXxAgy3AQtMrS1GAILuIOP3nMRSKio9cKN4w4Rn?=
 =?us-ascii?Q?pbMHsi4jflB/yBp0mV8KRlfL5G5Y5T4I8zL9d7a1nMogSHqRIyNIREr9bof6?=
 =?us-ascii?Q?C0oKDrxKDH7cWRoeg1sXB0cJluLeYzuzyuQf0rLcl8usS5u7ouXC2pbBDh0g?=
 =?us-ascii?Q?1yBz9yVxsarvDsGyTybsZ7xoH/vGv3LGFOYwBBjwFUWhy/5tZugPzOhGrKKI?=
 =?us-ascii?Q?UV8ItiiSQbqhyu1yDrFz80RO87MYOWKev0bjteZUqHsy/qSrFk3AYZMeWHEv?=
 =?us-ascii?Q?t0u9Bx8LMv8Y5CyfuAT/3G1Tnbds/kdGg+jzKG7JvB1LtJcAMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:16:26.5058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f60414b-8c3a-4634-6e58-08dc8cbfa231
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537

From: Byungchul Park <byungchul@sk.com>

Functionally, no change. This is a preparatory patch picked from luf
(lazy unmap flush) patch series. This patch improve code organization
and readability for steps involving migrate_folio_move().

Refactored migrate_pages_batch() and separated move and undo parts
operating on folio list, from migrate_pages_batch().

Signed-off-by: Byungchul Park <byungchul@sk.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 mm/migrate.c | 134 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 51 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c27b1f8097d4..6c36c6e0a360 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1606,6 +1606,81 @@ static int migrate_hugetlbs(struct list_head *from, new_folio_t get_new_folio,
 	return nr_failed;
 }
 
+static void migrate_folios_move(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		enum migrate_mode mode, int reason,
+		struct list_head *ret_folios,
+		struct migrate_pages_stats *stats,
+		int *retry, int *thp_retry, int *nr_failed,
+		int *nr_retry_pages)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+	bool is_thp;
+	int nr_pages;
+	int rc;
+
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+		nr_pages = folio_nr_pages(folio);
+
+		cond_resched();
+
+		rc = migrate_folio_move(put_new_folio, private,
+				folio, dst, mode,
+				reason, ret_folios);
+		/*
+		 * The rules are:
+		 *	Success: folio will be freed
+		 *	-EAGAIN: stay on the unmap_folios list
+		 *	Other errno: put on ret_folios list
+		 */
+		switch (rc) {
+		case -EAGAIN:
+			*retry += 1;
+			*thp_retry += is_thp;
+			*nr_retry_pages += nr_pages;
+			break;
+		case MIGRATEPAGE_SUCCESS:
+			stats->nr_succeeded += nr_pages;
+			stats->nr_thp_succeeded += is_thp;
+			break;
+		default:
+			*nr_failed += 1;
+			stats->nr_thp_failed += is_thp;
+			stats->nr_failed_pages += nr_pages;
+			break;
+		}
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+}
+
+static void migrate_folios_undo(struct list_head *src_folios,
+		struct list_head *dst_folios,
+		free_folio_t put_new_folio, unsigned long private,
+		struct list_head *ret_folios)
+{
+	struct folio *folio, *folio2, *dst, *dst2;
+
+	dst = list_first_entry(dst_folios, struct folio, lru);
+	dst2 = list_next_entry(dst, lru);
+	list_for_each_entry_safe(folio, folio2, src_folios, lru) {
+		int old_page_state = 0;
+		struct anon_vma *anon_vma = NULL;
+
+		__migrate_folio_extract(dst, &old_page_state, &anon_vma);
+		migrate_folio_undo_src(folio, old_page_state & PAGE_WAS_MAPPED,
+				anon_vma, true, ret_folios);
+		list_del(&dst->lru);
+		migrate_folio_undo_dst(dst, true, put_new_folio, private);
+		dst = dst2;
+		dst2 = list_next_entry(dst, lru);
+	}
+}
+
 /*
  * migrate_pages_batch() first unmaps folios in the from list as many as
  * possible, then move the unmapped folios.
@@ -1628,7 +1703,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int pass = 0;
 	bool is_thp = false;
 	bool is_large = false;
-	struct folio *folio, *folio2, *dst = NULL, *dst2;
+	struct folio *folio, *folio2, *dst = NULL;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
 	LIST_HEAD(dst_folios);
@@ -1764,42 +1839,11 @@ static int migrate_pages_batch(struct list_head *from,
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
-		dst = list_first_entry(&dst_folios, struct folio, lru);
-		dst2 = list_next_entry(dst, lru);
-		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
-			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
-			nr_pages = folio_nr_pages(folio);
-
-			cond_resched();
-
-			rc = migrate_folio_move(put_new_folio, private,
-						folio, dst, mode,
-						reason, ret_folios);
-			/*
-			 * The rules are:
-			 *	Success: folio will be freed
-			 *	-EAGAIN: stay on the unmap_folios list
-			 *	Other errno: put on ret_folios list
-			 */
-			switch(rc) {
-			case -EAGAIN:
-				retry++;
-				thp_retry += is_thp;
-				nr_retry_pages += nr_pages;
-				break;
-			case MIGRATEPAGE_SUCCESS:
-				stats->nr_succeeded += nr_pages;
-				stats->nr_thp_succeeded += is_thp;
-				break;
-			default:
-				nr_failed++;
-				stats->nr_thp_failed += is_thp;
-				stats->nr_failed_pages += nr_pages;
-				break;
-			}
-			dst = dst2;
-			dst2 = list_next_entry(dst, lru);
-		}
+		/* Move the unmapped folios */
+		migrate_folios_move(&unmap_folios, &dst_folios,
+				put_new_folio, private, mode, reason,
+				ret_folios, stats, &retry, &thp_retry,
+				&nr_failed, &nr_retry_pages);
 	}
 	nr_failed += retry;
 	stats->nr_thp_failed += thp_retry;
@@ -1808,20 +1852,8 @@ static int migrate_pages_batch(struct list_head *from,
 	rc = rc_saved ? : nr_failed;
 out:
 	/* Cleanup remaining folios */
-	dst = list_first_entry(&dst_folios, struct folio, lru);
-	dst2 = list_next_entry(dst, lru);
-	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
-		int old_page_state = 0;
-		struct anon_vma *anon_vma = NULL;
-
-		__migrate_folio_extract(dst, &old_page_state, &anon_vma);
-		migrate_folio_undo_src(folio, old_page_state & PAGE_WAS_MAPPED,
-				       anon_vma, true, ret_folios);
-		list_del(&dst->lru);
-		migrate_folio_undo_dst(dst, true, put_new_folio, private);
-		dst = dst2;
-		dst2 = list_next_entry(dst, lru);
-	}
+	migrate_folios_undo(&unmap_folios, &dst_folios,
+			put_new_folio, private, ret_folios);
 
 	return rc;
 }
-- 
2.34.1


