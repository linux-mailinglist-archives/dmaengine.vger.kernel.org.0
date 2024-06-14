Return-Path: <dmaengine+bounces-2369-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E46909412
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 00:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD29E281857
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 22:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AE1186E47;
	Fri, 14 Jun 2024 22:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lgtt847O"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E221850BF;
	Fri, 14 Jun 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718403400; cv=fail; b=TfQSiLIAxo0DcTxCJWxJ/Rre9Q50VZBHvmKWrSAudO0+4z5uBwlfdWPldU2VpInvUWc6Qv4dzmVHNv93LpGJIZOZwlUpuEJvFiklZvgKXfhrXZf7nUdZfPKh5NHC/ZR5lJPPChuIMRJZ2Jl8zlFo+GwbTZ3Q8ZWsJhzxDUVDhew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718403400; c=relaxed/simple;
	bh=O6Hvec/7lMmej0k6j+BWWmPLO52AERXy9SggF90YkDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BInqJSAvuEHCvE2e0xal8spgNGgXPSDR2wgQcyKBsqFE0LLFyd/prGEhpZ9PI24qrXSq597CE0eY2yzTxyEC5T/+G6MqnFb3CglJZ98hYt48qzZsrCIalCBpS/+oCmm1fm8fqRSvyDPfC0yAgDv/BYaPd2PCRGa/1vmzctQa24M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lgtt847O; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGoifSAYQdAFyDG87Rh4HGXN6IL4niu0kHRb4lJzmJ0Y5F7G+rNkBxZEmOjOoJs4jjFRotXSYdfTTbzcmotTZP1e+yCUlH3IO+I3Iq7XRDGz0z1vw32epp6PupSXZkQWFftdBU637vIzFFkmWncTjKHKlceu42oAWv/TbE6OmwIzQDYS1RHJP9NJ8KMWY0/MqyfF0bjzuy7UjdYHSpuRte45d3F/eRmIhsMaD9+ZIEKmRfekRMZRbjqLpBmyp+11Y9a/iR8WpwPsHICKE/EevYrUy92md1K6AyHVpGR017VIcLBypMrDYwY2CjCOh+4bQbpHax82LNHdE1ukCQjh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paW7JLDrtb2aRBh8FzyCeKkpvtBTLuIly2aSw6Q9hHE=;
 b=h1AVitlkXzkTxsuzq4aYDKxYNBP/ZbV+5nMfOx5sCI8CSAJ/LhwQ1F4J76feJRuYL5xrpn9a+gG8oBMg2R7ppw7gVMi59SfCJ1DlyTPUoggBVt/meYlLOW0U1uUnMJ260a4lg1X1/IGAP4NCD9gCPBQ7pFHeqUYspfuYsCafaQdq610tWyDKux1GYXG7WSW+FmNFMkRJsTMo3unW4Jf/MV8hxWPi+Zu9ov+1lFhURMGhhyJnwA0V2MQmxtVRF5WkIKKv9W9vYCKegLLy24T5kciY8IPAAb9GEU2/iUDAOBkKqju/S2Zg8oAe/KNe159p1jalUY2L4pdnzHwsEVqN1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paW7JLDrtb2aRBh8FzyCeKkpvtBTLuIly2aSw6Q9hHE=;
 b=Lgtt847OkXGePRrNBryWOZsZN4Y4QqpPsVMQ05KddIiLgQIgcSmCir7LE4li1MnFP33h+60+D/9qwB7Czi1ZpnFypRTvj2CfV63wUGfdLYBqsJp7RAAHpEcrSbIz+th3nyokkERJ61BFsnqErjX8J8RC5eS4+TCOLZN1bealFTA=
Received: from DS7PR03CA0199.namprd03.prod.outlook.com (2603:10b6:5:3b6::24)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Fri, 14 Jun
 2024 22:16:31 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::99) by DS7PR03CA0199.outlook.office365.com
 (2603:10b6:5:3b6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 22:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 22:16:30 +0000
Received: from BLR-L-SHIVAGAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 17:16:25 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <bharata@amd.com>, <raghavendra.kodsarathimmappa@amd.com>,
	<Michael.Day@amd.com>, <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
	<shivankg@amd.com>
Subject: [RFC PATCH 2/5] mm: add folios_copy() for copying pages in batch during migration
Date: Sat, 15 Jun 2024 03:45:22 +0530
Message-ID: <20240614221525.19170-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bc017b-1066-43be-6da7-08dc8cbfa480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VwoEtAfxhdgsi/0NL9sxq39rO9UUHOlRfptpokGYLuYcAehJaOwcgHCySlli?=
 =?us-ascii?Q?GmYjB4fjysFl9ARUweKhrIpzEYzSaXN+//3neIMPhsy6zBxXelKcSFn3Ol/Y?=
 =?us-ascii?Q?BcQMa2TeWkd8RL/6C25vatTe9bcgjJuRczi5ZEmWV9Kelyf2KQzL4KRMRy4V?=
 =?us-ascii?Q?fuYlOJBtwo8nVmuZ1YOK0Fsz6/9OGJgvtbM61Dkcm+zBHMgkT/9z6r+lMBNL?=
 =?us-ascii?Q?3I9J3GqxVsD+wDrPFpG90jQRvwM+2Abvct9NdnVvdd14Xnvv+84HHpiZ692p?=
 =?us-ascii?Q?d9X4d63cpNM8S5oRwid3MZggHuez1EgnlYK9WPLzsNDih4w20R7E6Mq3u34Z?=
 =?us-ascii?Q?QQhMyB5vDfTATiZ7Oee1bEll6r1sBeYXb9L9zCNAid7DQndoiyGg13+0c1zi?=
 =?us-ascii?Q?choL23fQwsXb/YZ0uO7IyaThPrkV8eIgr6FhHUsTXRKg1IKxpJX5apH+pJ/G?=
 =?us-ascii?Q?7WqtvFSM742Pj1DswRUVtRjcdm5msVY94v9pHEpWL5PJFxsootguC75vJnUw?=
 =?us-ascii?Q?JIOel6r/91pTlp4MGmOFJc83Cx7y/4zbIek6OboZlu6krknCnWA5Y9tOoMhq?=
 =?us-ascii?Q?bfAIfuYSNbGksYPYq07gdFy4sD+WS/D9gncEIHOsOQp0jPWyWMG9WFHR6Gsh?=
 =?us-ascii?Q?I6Kqm+UWpOGIP8dh1Kj7BzXwMXASUEXKYhgD+vTJCP9cwW5MfaqYPYa3pEoW?=
 =?us-ascii?Q?OItUFhH5c55XmQRkINzkeytVhnMUTCnUscAtN+KxHK1sqB2/FuJC6157KpoH?=
 =?us-ascii?Q?mWxu9Qoi+D9OXN/WGhMQK5TtQRFU3TIFL7h/H42YnuOzTcNVglH35WkPSXA9?=
 =?us-ascii?Q?0TevfO6BhWw0bRpxVKRtyonij+Hz9TwZ+GmFk5XajSwG65fOpVvIzbrxzj6Q?=
 =?us-ascii?Q?yYWwoXVwR96fxQEyERlis/soot15z1IDUuvL9YvbOLyZwBTd9zLxbmMFKMwp?=
 =?us-ascii?Q?Ruu/xYFfcN5sekrjOckku73rtm/zn1mApEPZJ6iylVKjcbWNHWUUyRgJ2dte?=
 =?us-ascii?Q?d+1sPOgrUKIM633wNY+81R1HS6bJIc3xOTyevcXNqMWbKit547wv20/rC6fw?=
 =?us-ascii?Q?A7xLg3rhcnlYvpCKxotR7lJ7mD1zs5XLBmcy5NvVPrTWA823khtlI3OlQt1h?=
 =?us-ascii?Q?11hnVtib47XiByxqMeuTTT6gFty6eDizx3G88X7PvMJi0ydSLBCbM8JRJXQL?=
 =?us-ascii?Q?Xt9o0IoI3klrVpYOAI40CoGvC13DBeHxwfKCvtKIPhZP31aAeaRre1cTddP3?=
 =?us-ascii?Q?s5wEhONtZoe2MCQdFsr02MzJz423Ixy28WUlSqkqJ6+y30JVFqH2icCMzIUE?=
 =?us-ascii?Q?1Ka+nPea+gGIZeUXxZVOOzX1jjs+2WLBt+/mmRVaqNfEoW8FY4bO6v7FQvyi?=
 =?us-ascii?Q?n+pu9HxHXkQVCDW5qx6JN8RfeEj9A1WoOpjZJ040Aqfr+NoYJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:16:30.3321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bc017b-1066-43be-6da7-08dc8cbfa480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727

This patch introduces the folios_copy() function to copy the folio content
from the list of src folios to the list of dst folios. This is preparatory
patch for batch page migration offloading.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/mm.h |  1 +
 mm/util.c          | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..cd5f37ec72f0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1300,6 +1300,7 @@ void put_pages_list(struct list_head *pages);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
+void folios_copy(struct list_head *dst_list, struct list_head *src_list);
 
 unsigned long nr_free_buffer_pages(void);
 
diff --git a/mm/util.c b/mm/util.c
index 5a6a9802583b..3a278db28429 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -811,6 +811,28 @@ void folio_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_copy);
 
+/**
+ * folios_copy - Copy the contents of list of folios.
+ * @dst_list: Folios to copy to.
+ * @src_list: Folios to copy from.
+ *
+ * The folio contents are copied from @src_list to @dst_list.
+ * Assume the caller has validated that lists are not empty and both lists
+ * have equal number of folios. This may sleep.
+ */
+void folios_copy(struct list_head *dst_list,
+		struct list_head *src_list)
+{
+	struct folio *src, *dst;
+
+	dst = list_first_entry(dst_list, struct folio, lru);
+	list_for_each_entry(src, src_list, lru) {
+		cond_resched();
+		folio_copy(dst, src);
+		dst = list_next_entry(dst, lru);
+	}
+}
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 int sysctl_overcommit_ratio __read_mostly = 50;
 unsigned long sysctl_overcommit_kbytes __read_mostly;
-- 
2.34.1


