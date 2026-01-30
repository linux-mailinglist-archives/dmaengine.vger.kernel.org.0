Return-Path: <dmaengine+bounces-8602-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGoADWGQfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8602-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:05:05 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E43AAB9C07
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E9AB305533D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6499379999;
	Fri, 30 Jan 2026 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="haR4jy4A"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EE3793A7;
	Fri, 30 Jan 2026 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770986; cv=fail; b=I/32pw0TV/uFJwvvDyWbpiHbGNQ4bs9ZRTGIUepaB3WmMTfrrkLsAgZx8laCKy8rWzGNbdQFnOufaF8bZKDo4130Sg88y7cc3iCLTCW9WEpie8ILebxUdZeFehGooSp/Cl1TbLV9HTary2y2CE5OYUnoc0XxZ5fzHDVqR5sR5VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770986; c=relaxed/simple;
	bh=ulQg8zKLcnr1Rx+5Ls04WEcQeqlmARZKq9hIFYz+C+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9TQaV+9cyqMCoI/xjBgxupjLTmcHrwpnNz1mTHR2jGEsF+pPcpI5diw9YbrvfiLjMW7mijYxqOglwZfHoyIePM+WoMHsqwS1r0zVlwAb0EUGCOtpEjOtDdtlrIJqAW8NGeWHYCOHUsBi+pb7zvJmmd1cXgbu4zRVl7SpPTbLAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=haR4jy4A; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcJF4hY5adNqGEXPkq55T1vuoNaXpxtmQHRhVl46Ae5L7I2p3isjKbcq3abA+nm/6SFFmOuw7zrrWDCrL94MRXLN3PSY2ci4bxBvSkBzihyFrNKx8v1nB1YtdbwRTtg4fC/13L822/K8iaqkarD/ZxZR4R0eICoqQfAB2zZTwtO26vAznyMnxlsNKGzNPOV0AU369Lmzb1D13xC4w80lgJokML889QXfL//30Qk/MgAQRKnUxW4CEw6PjCLUH2PSl9mUCItGbryYLgMeOUgq5jAGra7b37aEoOeeZyT9bWjOe79BnpEvg9WBkCaep6zAtPSpsMYaJPgjUD9DiDJ6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIhn/ET+peJ51tOt95GX6r6kIliGQI614WduJl3z2wQ=;
 b=Gi4x4OtNQgHAIZCorkn6fYSr2dde4y7m2YuOi98bXxw7e7B8r5uY8a6kgdPmDGLWigaHO1GEqCwHNVMg0C6d7zTkfC8hh1Mri9kGjXCcFvLa4veQ9G15rrQ8pQeF7fcTd9tJv1m/XkYrAO25KhAUmcCLquGu/gSbCUJfxCng8LkCeKkj8XtuoM4CjjuzsUpK3YZ8Hzu8uNcGzOd3Q3vUDc6nGz0V7HFpENIlJPuOQ006jO6yRBqA7r9pdo5zaDuNHUP3SXTdUfQTBw76gp370qc0oJBZmb42t+fwABLgVSipdb80jf6NTcBdNeilCVNSm9vSpku6dEBCgNt6xIn6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIhn/ET+peJ51tOt95GX6r6kIliGQI614WduJl3z2wQ=;
 b=haR4jy4AxGrzp/GTf6gDTHJNoRYmnAdDZhO2IbqhXB0dCYTBGUouDC0598rlFBBr6iaDEB0dwD2jq9eY2KdGKa6LSJSjXbVLB+h1Y1KQCWTrQbVAalIK7iXZjiu+y7V8oxp/UVqPbGSCqo7I4lRCdUXdIq0WF8WSo1gi+C4QwpM=
Received: from BYAPR08CA0026.namprd08.prod.outlook.com (2603:10b6:a03:100::39)
 by IA3PR10MB8140.namprd10.prod.outlook.com (2603:10b6:208:502::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 11:03:01 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::e4) by BYAPR08CA0026.outlook.office365.com
 (2603:10b6:a03:100::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 11:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:02:59 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:57 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:57 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:02:56 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBl1204392;
	Fri, 30 Jan 2026 05:02:53 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 08/19] dmaengine: ti: k3-udma: move resource management functions to k3-udma-common.c
Date: Fri, 30 Jan 2026 16:31:48 +0530
Message-ID: <20260130110159.359501-9-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|IA3PR10MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 93031f8b-d47f-4021-89ff-08de5fef217c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f7U040jQFGeJvo2RtAwUmf6tNB3EJyGuS6By7+DPwqHjagkyBlB7eUrkF4Th?=
 =?us-ascii?Q?LHtUVQFy8gE1QHJLMErg3mVSKhq57cjnosjgja8vDQbOIUgdu6QeZzcZbUzT?=
 =?us-ascii?Q?ubb2ct9YDrXzEXynVq3uMsZKONEviSvBTMklenNjKAQFwJ2YR1nFBpXds1lS?=
 =?us-ascii?Q?NbTOZsrVEjHV6eKTfjKM1lKtikpxiwBgyZdhQQfeL3F/3l0y23+3i6fUU973?=
 =?us-ascii?Q?9pTnNOlwhnJlXWEckHmVs0KRS8WaaBEiPGRm+f77CQX6YZ1lCDyuvV1r/Xyh?=
 =?us-ascii?Q?xF9ZIuT1W6ByIfQeZQHF+jTFgxdnzXZJrXIQ/2xTGgAOErB5DG//9d2jkhuJ?=
 =?us-ascii?Q?RFrzsxo1Ycqk2CW1vW63Hv4RELwHMBindnV8gmGlNZgKaeypgWAjRJM2OJ3o?=
 =?us-ascii?Q?UlLOJUIthTXwMzhiE3o45FmhVqIsAOOM6QBb5zhx+6bJXjTr+iTMr5GzbZmJ?=
 =?us-ascii?Q?LKZFd14d0vScbgdTPT2SPjdJ04JZ6tKnv0Nse7L8dR/iMURmlJu4buBnDNJz?=
 =?us-ascii?Q?MG70kD6zT5LDhn1yIpYrhJFBY6RWtSvIzns2XsAge1j2350NBLThd3yx2Ov1?=
 =?us-ascii?Q?gPPCL2BL1Nqn2ofb/rexIxtD0UVDKGcl22nHxm8wrrnd3fHqDdNdu810MUYW?=
 =?us-ascii?Q?/mjoJcui5SN/e096a/26s8Oe7xbvKhq/m4kbbNT3ITMCu5kyG3VesWMcGqsN?=
 =?us-ascii?Q?MJKfVrtcdGGYLr/NIywhLn/IAuSJ3k392THpxcwlvQoMLXlEcilG5kFw6dW1?=
 =?us-ascii?Q?e1yJM+gP3HkWB+8zW6YPvhUvRdBLD1ZPjGnljGQYAjCQ/riW1HV7xjmryVg8?=
 =?us-ascii?Q?s0rB0fWXzKY1jJrc/hr9AHUNJBXo5fyHYOkfUe89Gaa7j9n9wOmDcfUBQuX8?=
 =?us-ascii?Q?Fo0f7bVh83Y+xI9sAwOKY83MrdEePzWEDNWWwpAyv5aXRDbR4YdE+q2uSG9t?=
 =?us-ascii?Q?mL4Kv69A54mmX/zJcRKSzGvnB+EsW7B9dZeeAowWzNJ0aWWRn7preBCk4Qm2?=
 =?us-ascii?Q?i71ssDb9bAi1sqvruYchtl6jjj8NhOVJwdcKk8rW422qY+gSom7Jm4Xi5ONe?=
 =?us-ascii?Q?qB/tGAx+zZJjshmyOjPz+UMOqOtCwpLNR8glKHdxtMw+mtAgABIKnlS4TdV3?=
 =?us-ascii?Q?KY04CJsGvf3L/EVVuhfl2WE/XMh+i8ezNK9n7aWpjpMkIQJ9B1ussbueMo7v?=
 =?us-ascii?Q?svjJ0EzILivfc88CgpU2DuqXkhKQBp22ZTowTDAFKKlnHflr9jD+DnnvTfBP?=
 =?us-ascii?Q?4U1ssidHfBsmLx224VV/ezH94Fb62Gqdv510igEWNYDORj08oDnqRdmVf0Bw?=
 =?us-ascii?Q?4d+DkwOQlXN+Qh632nu4FdcPAyrNlel/Yt8sGUHNnqAlyq/Wj/7CPEE8FHbc?=
 =?us-ascii?Q?mDItlqEY+kNz1xWkUXqZV1CyiESdvevJMy+4hDnas0Vfy0zQMNhsRpIq5Z5h?=
 =?us-ascii?Q?ezEN5YeW7NWiUlLwiSWGcrpfZvs5zpTk6Z1/ohGr6suffZ8fCCDocP8QGZ3L?=
 =?us-ascii?Q?HDc8okBj1fW1EVZN1FqU18YqsnEqG7VEU76HFoEFX8xzukQOtEdWtGexVeFE?=
 =?us-ascii?Q?ey50vm4yEf85SMgF+bmVJxEZTk/qSvUQTtMOTobABGCX7j/3gSqo5LBZpAYe?=
 =?us-ascii?Q?iuaeHEGgtak9cTRNVvqklQIFaI+4eLtVTrgGDBHXNSjLJf0H05QH7x8K63Lc?=
 =?us-ascii?Q?3gUr9Kw7cV4lPw6vFIDIDGQYFDw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UE5+M27OgegLvCUciwXfNaLDrzpTEBXsX5wnac/m6644YhYzKD7Q3DnuV819QJxhQDzqgy2O1FmHY4dOCpsblfutiQizBGD7UZzUhUOxma3MuEJLboicAiEAceeJ84ZbrtOxNI8vyHgACDbr/+n7faKrDZqTBduPD7SmzzEoxxtXN3/4FMGicPelhtoD6tF8JjmJCf/PyOqdN1YXcd8/HLJzn8G0wWF2md3ZkWijrV0V5X+r/eM+iwM6KCiLFnU9F6xph8+UQdJhWsce6xKUq+QDJ3jlsPQKxEnEVTdgEa2SPfuWm72F/88qX8K32+17V8XW0DqGePLXvjs070OTmLLheEqfkhFgFDNHAQafnZzm0/UUV7HZae93RphL51tbJCe3NgSmmaT7IX98jPhWpIfH4Xh/83OECQ8P/BDV2970k5RwL9KxSt68KTgAyzg4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:02:59.5510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93031f8b-d47f-4021-89ff-08de5fef217c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8140
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8602-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: E43AAB9C07
X-Rspamd-Action: no action

Move functions responsible for allocation and release of udma
resources such as channels, rings and flows from k3-udma.c
to the common k3-udma-common.c file.

The implementation of these functions is largely shared between K3 UDMA
and K3 UDMA v2. This refactor improves code reuse and maintainability
across multiple variants.

No functional changes intended.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 442 ++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-udma.c        | 423 ------------------------------
 drivers/dma/ti/k3-udma.h        |  21 ++
 3 files changed, 463 insertions(+), 423 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index 472eedc4663a9..882d27b3c9ee5 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -1891,5 +1891,447 @@ enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
 }
 EXPORT_SYMBOL_GPL(udma_get_copy_align);
 
+/**
+ * __udma_alloc_gp_rflow_range - alloc range of GP RX flows
+ * @ud: UDMA device
+ * @from: Start the search from this flow id number
+ * @cnt: Number of consecutive flow ids to allocate
+ *
+ * Allocate range of RX flow ids for future use, those flows can be requested
+ * only using explicit flow id number. if @from is set to -1 it will try to find
+ * first free range. if @from is positive value it will force allocation only
+ * of the specified range of flows.
+ *
+ * Returns -ENOMEM if can't find free range.
+ * -EEXIST if requested range is busy.
+ * -EINVAL if wrong input values passed.
+ * Returns flow id on success.
+ */
+int __udma_alloc_gp_rflow_range(struct udma_dev *ud, int from, int cnt)
+{
+	int start, tmp_from;
+	DECLARE_BITMAP(tmp, K3_UDMA_MAX_RFLOWS);
+
+	tmp_from = from;
+	if (tmp_from < 0)
+		tmp_from = ud->rchan_cnt;
+	/* default flows can't be allocated and accessible only by id */
+	if (tmp_from < ud->rchan_cnt)
+		return -EINVAL;
+
+	if (tmp_from + cnt > ud->rflow_cnt)
+		return -EINVAL;
+
+	bitmap_or(tmp, ud->rflow_gp_map, ud->rflow_gp_map_allocated,
+		  ud->rflow_cnt);
+
+	start = bitmap_find_next_zero_area(tmp,
+					   ud->rflow_cnt,
+					   tmp_from, cnt, 0);
+	if (start >= ud->rflow_cnt)
+		return -ENOMEM;
+
+	if (from >= 0 && start != from)
+		return -EEXIST;
+
+	bitmap_set(ud->rflow_gp_map_allocated, start, cnt);
+	return start;
+}
+EXPORT_SYMBOL_GPL(__udma_alloc_gp_rflow_range);
+
+int __udma_free_gp_rflow_range(struct udma_dev *ud, int from, int cnt)
+{
+	if (from < ud->rchan_cnt)
+		return -EINVAL;
+	if (from + cnt > ud->rflow_cnt)
+		return -EINVAL;
+
+	bitmap_clear(ud->rflow_gp_map_allocated, from, cnt);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__udma_free_gp_rflow_range);
+
+struct udma_rflow *__udma_get_rflow(struct udma_dev *ud, int id)
+{
+	/*
+	 * Attempt to request rflow by ID can be made for any rflow
+	 * if not in use with assumption that caller knows what's doing.
+	 * TI-SCI FW will perform additional permission check ant way, it's
+	 * safe
+	 */
+
+	if (id < 0 || id >= ud->rflow_cnt)
+		return ERR_PTR(-ENOENT);
+
+	if (test_bit(id, ud->rflow_in_use))
+		return ERR_PTR(-ENOENT);
+
+	if (ud->rflow_gp_map) {
+		/* GP rflow has to be allocated first */
+		if (!test_bit(id, ud->rflow_gp_map) &&
+		    !test_bit(id, ud->rflow_gp_map_allocated))
+			return ERR_PTR(-EINVAL);
+	}
+
+	dev_dbg(ud->dev, "get rflow%d\n", id);
+	set_bit(id, ud->rflow_in_use);
+	return &ud->rflows[id];
+}
+EXPORT_SYMBOL_GPL(__udma_get_rflow);
+
+void __udma_put_rflow(struct udma_dev *ud, struct udma_rflow *rflow)
+{
+	if (!test_bit(rflow->id, ud->rflow_in_use)) {
+		dev_err(ud->dev, "attempt to put unused rflow%d\n", rflow->id);
+		return;
+	}
+
+	dev_dbg(ud->dev, "put rflow%d\n", rflow->id);
+	clear_bit(rflow->id, ud->rflow_in_use);
+}
+EXPORT_SYMBOL_GPL(__udma_put_rflow);
+
+#define UDMA_RESERVE_RESOURCE(res)					\
+struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
+					       enum udma_tp_level tpl,	\
+					       int id)			\
+{									\
+	if (id >= 0) {							\
+		if (test_bit(id, ud->res##_map)) {			\
+			dev_err(ud->dev, "res##%d is in use\n", id);	\
+			return ERR_PTR(-ENOENT);			\
+		}							\
+	} else {							\
+		int start;						\
+									\
+		if (tpl >= ud->res##_tpl.levels)			\
+			tpl = ud->res##_tpl.levels - 1;			\
+									\
+		start = ud->res##_tpl.start_idx[tpl];			\
+									\
+		id = find_next_zero_bit(ud->res##_map, ud->res##_cnt,	\
+					start);				\
+		if (id == ud->res##_cnt) {				\
+			return ERR_PTR(-ENOENT);			\
+		}							\
+	}								\
+									\
+	set_bit(id, ud->res##_map);					\
+	return &ud->res##s[id];						\
+}
+
+UDMA_RESERVE_RESOURCE(bchan);
+EXPORT_SYMBOL_GPL(__udma_reserve_bchan);
+UDMA_RESERVE_RESOURCE(tchan);
+EXPORT_SYMBOL_GPL(__udma_reserve_tchan);
+UDMA_RESERVE_RESOURCE(rchan);
+EXPORT_SYMBOL_GPL(__udma_reserve_rchan);
+
+int udma_get_tchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	int ret;
+
+	if (uc->tchan) {
+		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
+			uc->id, uc->tchan->id);
+		return 0;
+	}
+
+	/*
+	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
+	 * For PKTDMA mapped channels it is configured to a channel which must
+	 * be used to service the peripheral.
+	 */
+	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl,
+					 uc->config.mapped_channel_id);
+	if (IS_ERR(uc->tchan)) {
+		ret = PTR_ERR(uc->tchan);
+		uc->tchan = NULL;
+		return ret;
+	}
+
+	if (ud->tflow_cnt) {
+		int tflow_id;
+
+		/* Only PKTDMA have support for tx flows */
+		if (uc->config.default_flow_id >= 0)
+			tflow_id = uc->config.default_flow_id;
+		else
+			tflow_id = uc->tchan->id;
+
+		if (test_bit(tflow_id, ud->tflow_map)) {
+			dev_err(ud->dev, "tflow%d is in use\n", tflow_id);
+			clear_bit(uc->tchan->id, ud->tchan_map);
+			uc->tchan = NULL;
+			return -ENOENT;
+		}
+
+		uc->tchan->tflow_id = tflow_id;
+		set_bit(tflow_id, ud->tflow_map);
+	} else {
+		uc->tchan->tflow_id = -1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_tchan);
+
+int udma_get_rchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	int ret;
+
+	if (uc->rchan) {
+		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
+			uc->id, uc->rchan->id);
+		return 0;
+	}
+
+	/*
+	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
+	 * For PKTDMA mapped channels it is configured to a channel which must
+	 * be used to service the peripheral.
+	 */
+	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl,
+					 uc->config.mapped_channel_id);
+	if (IS_ERR(uc->rchan)) {
+		ret = PTR_ERR(uc->rchan);
+		uc->rchan = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_rchan);
+
+int udma_get_chan_pair(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+	int chan_id, end;
+
+	if ((uc->tchan && uc->rchan) && uc->tchan->id == uc->rchan->id) {
+		dev_info(ud->dev, "chan%d: already have %d pair allocated\n",
+			 uc->id, uc->tchan->id);
+		return 0;
+	}
+
+	if (uc->tchan) {
+		dev_err(ud->dev, "chan%d: already have tchan%d allocated\n",
+			uc->id, uc->tchan->id);
+		return -EBUSY;
+	} else if (uc->rchan) {
+		dev_err(ud->dev, "chan%d: already have rchan%d allocated\n",
+			uc->id, uc->rchan->id);
+		return -EBUSY;
+	}
+
+	/* Can be optimized, but let's have it like this for now */
+	end = min(ud->tchan_cnt, ud->rchan_cnt);
+	/*
+	 * Try to use the highest TPL channel pair for MEM_TO_MEM channels
+	 * Note: in UDMAP the channel TPL is symmetric between tchan and rchan
+	 */
+	chan_id = ud->tchan_tpl.start_idx[ud->tchan_tpl.levels - 1];
+	for (; chan_id < end; chan_id++) {
+		if (!test_bit(chan_id, ud->tchan_map) &&
+		    !test_bit(chan_id, ud->rchan_map))
+			break;
+	}
+
+	if (chan_id == end)
+		return -ENOENT;
+
+	set_bit(chan_id, ud->tchan_map);
+	set_bit(chan_id, ud->rchan_map);
+	uc->tchan = &ud->tchans[chan_id];
+	uc->rchan = &ud->rchans[chan_id];
+
+	/* UDMA does not use tx flows */
+	uc->tchan->tflow_id = -1;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_chan_pair);
+
+int udma_get_rflow(struct udma_chan *uc, int flow_id)
+{
+	struct udma_dev *ud = uc->ud;
+	int ret;
+
+	if (!uc->rchan) {
+		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
+		return -EINVAL;
+	}
+
+	if (uc->rflow) {
+		dev_dbg(ud->dev, "chan%d: already have rflow%d allocated\n",
+			uc->id, uc->rflow->id);
+		return 0;
+	}
+
+	uc->rflow = __udma_get_rflow(ud, flow_id);
+	if (IS_ERR(uc->rflow)) {
+		ret = PTR_ERR(uc->rflow);
+		uc->rflow = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(udma_get_rflow);
+
+void udma_put_rchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->rchan) {
+		dev_dbg(ud->dev, "chan%d: put rchan%d\n", uc->id,
+			uc->rchan->id);
+		clear_bit(uc->rchan->id, ud->rchan_map);
+		uc->rchan = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_put_rchan);
+
+void udma_put_tchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->tchan) {
+		dev_dbg(ud->dev, "chan%d: put tchan%d\n", uc->id,
+			uc->tchan->id);
+		clear_bit(uc->tchan->id, ud->tchan_map);
+
+		if (uc->tchan->tflow_id >= 0)
+			clear_bit(uc->tchan->tflow_id, ud->tflow_map);
+
+		uc->tchan = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_put_tchan);
+
+void udma_put_rflow(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->rflow) {
+		dev_dbg(ud->dev, "chan%d: put rflow%d\n", uc->id,
+			uc->rflow->id);
+		__udma_put_rflow(ud, uc->rflow);
+		uc->rflow = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_put_rflow);
+
+void udma_free_tx_resources(struct udma_chan *uc)
+{
+	if (!uc->tchan)
+		return;
+
+	k3_ringacc_ring_free(uc->tchan->t_ring);
+	k3_ringacc_ring_free(uc->tchan->tc_ring);
+	uc->tchan->t_ring = NULL;
+	uc->tchan->tc_ring = NULL;
+
+	udma_put_tchan(uc);
+}
+EXPORT_SYMBOL_GPL(udma_free_tx_resources);
+
+void udma_free_rx_resources(struct udma_chan *uc)
+{
+	if (!uc->rchan)
+		return;
+
+	if (uc->rflow) {
+		struct udma_rflow *rflow = uc->rflow;
+
+		k3_ringacc_ring_free(rflow->fd_ring);
+		k3_ringacc_ring_free(rflow->r_ring);
+		rflow->fd_ring = NULL;
+		rflow->r_ring = NULL;
+
+		udma_put_rflow(uc);
+	}
+
+	udma_put_rchan(uc);
+}
+EXPORT_SYMBOL_GPL(udma_free_rx_resources);
+
+void udma_free_chan_resources(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	struct udma_dev *ud = to_udma_dev(chan->device);
+
+	udma_terminate_all(chan);
+	if (uc->terminated_desc) {
+		ud->reset_chan(uc, false);
+		udma_reset_rings(uc);
+	}
+
+	cancel_delayed_work_sync(&uc->tx_drain.work);
+
+	if (uc->irq_num_ring > 0) {
+		free_irq(uc->irq_num_ring, uc);
+
+		uc->irq_num_ring = 0;
+	}
+	if (uc->irq_num_udma > 0) {
+		free_irq(uc->irq_num_udma, uc);
+
+		uc->irq_num_udma = 0;
+	}
+
+	/* Release PSI-L pairing */
+	if (uc->psil_paired && ud->psil_unpair) {
+		ud->psil_unpair(ud, uc->config.src_thread,
+				  uc->config.dst_thread);
+		uc->psil_paired = false;
+	}
+
+	vchan_free_chan_resources(&uc->vc);
+	tasklet_kill(&uc->vc.task);
+
+	bcdma_free_bchan_resources(uc);
+	udma_free_tx_resources(uc);
+	udma_free_rx_resources(uc);
+	udma_reset_uchan(uc);
+
+	if (uc->use_dma_pool) {
+		dma_pool_destroy(uc->hdesc_pool);
+		uc->use_dma_pool = false;
+	}
+}
+EXPORT_SYMBOL_GPL(udma_free_chan_resources);
+
+void bcdma_put_bchan(struct udma_chan *uc)
+{
+	struct udma_dev *ud = uc->ud;
+
+	if (uc->bchan) {
+		dev_dbg(ud->dev, "chan%d: put bchan%d\n", uc->id,
+			uc->bchan->id);
+		clear_bit(uc->bchan->id, ud->bchan_map);
+		uc->bchan = NULL;
+		uc->tchan = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(bcdma_put_bchan);
+
+void bcdma_free_bchan_resources(struct udma_chan *uc)
+{
+	if (!uc->bchan)
+		return;
+
+	k3_ringacc_ring_free(uc->bchan->tc_ring);
+	k3_ringacc_ring_free(uc->bchan->t_ring);
+	uc->bchan->tc_ring = NULL;
+	uc->bchan->t_ring = NULL;
+	k3_configure_chan_coherency(&uc->vc.chan, 0);
+
+	bcdma_put_bchan(uc);
+}
+EXPORT_SYMBOL_GPL(bcdma_free_bchan_resources);
+
 MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index e86c811a15eb9..fa9a464f4b953 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -423,135 +423,6 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/**
- * __udma_alloc_gp_rflow_range - alloc range of GP RX flows
- * @ud: UDMA device
- * @from: Start the search from this flow id number
- * @cnt: Number of consecutive flow ids to allocate
- *
- * Allocate range of RX flow ids for future use, those flows can be requested
- * only using explicit flow id number. if @from is set to -1 it will try to find
- * first free range. if @from is positive value it will force allocation only
- * of the specified range of flows.
- *
- * Returns -ENOMEM if can't find free range.
- * -EEXIST if requested range is busy.
- * -EINVAL if wrong input values passed.
- * Returns flow id on success.
- */
-static int __udma_alloc_gp_rflow_range(struct udma_dev *ud, int from, int cnt)
-{
-	int start, tmp_from;
-	DECLARE_BITMAP(tmp, K3_UDMA_MAX_RFLOWS);
-
-	tmp_from = from;
-	if (tmp_from < 0)
-		tmp_from = ud->rchan_cnt;
-	/* default flows can't be allocated and accessible only by id */
-	if (tmp_from < ud->rchan_cnt)
-		return -EINVAL;
-
-	if (tmp_from + cnt > ud->rflow_cnt)
-		return -EINVAL;
-
-	bitmap_or(tmp, ud->rflow_gp_map, ud->rflow_gp_map_allocated,
-		  ud->rflow_cnt);
-
-	start = bitmap_find_next_zero_area(tmp,
-					   ud->rflow_cnt,
-					   tmp_from, cnt, 0);
-	if (start >= ud->rflow_cnt)
-		return -ENOMEM;
-
-	if (from >= 0 && start != from)
-		return -EEXIST;
-
-	bitmap_set(ud->rflow_gp_map_allocated, start, cnt);
-	return start;
-}
-
-static int __udma_free_gp_rflow_range(struct udma_dev *ud, int from, int cnt)
-{
-	if (from < ud->rchan_cnt)
-		return -EINVAL;
-	if (from + cnt > ud->rflow_cnt)
-		return -EINVAL;
-
-	bitmap_clear(ud->rflow_gp_map_allocated, from, cnt);
-	return 0;
-}
-
-static struct udma_rflow *__udma_get_rflow(struct udma_dev *ud, int id)
-{
-	/*
-	 * Attempt to request rflow by ID can be made for any rflow
-	 * if not in use with assumption that caller knows what's doing.
-	 * TI-SCI FW will perform additional permission check ant way, it's
-	 * safe
-	 */
-
-	if (id < 0 || id >= ud->rflow_cnt)
-		return ERR_PTR(-ENOENT);
-
-	if (test_bit(id, ud->rflow_in_use))
-		return ERR_PTR(-ENOENT);
-
-	if (ud->rflow_gp_map) {
-		/* GP rflow has to be allocated first */
-		if (!test_bit(id, ud->rflow_gp_map) &&
-		    !test_bit(id, ud->rflow_gp_map_allocated))
-			return ERR_PTR(-EINVAL);
-	}
-
-	dev_dbg(ud->dev, "get rflow%d\n", id);
-	set_bit(id, ud->rflow_in_use);
-	return &ud->rflows[id];
-}
-
-static void __udma_put_rflow(struct udma_dev *ud, struct udma_rflow *rflow)
-{
-	if (!test_bit(rflow->id, ud->rflow_in_use)) {
-		dev_err(ud->dev, "attempt to put unused rflow%d\n", rflow->id);
-		return;
-	}
-
-	dev_dbg(ud->dev, "put rflow%d\n", rflow->id);
-	clear_bit(rflow->id, ud->rflow_in_use);
-}
-
-#define UDMA_RESERVE_RESOURCE(res)					\
-static struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
-					       enum udma_tp_level tpl,	\
-					       int id)			\
-{									\
-	if (id >= 0) {							\
-		if (test_bit(id, ud->res##_map)) {			\
-			dev_err(ud->dev, "res##%d is in use\n", id);	\
-			return ERR_PTR(-ENOENT);			\
-		}							\
-	} else {							\
-		int start;						\
-									\
-		if (tpl >= ud->res##_tpl.levels)			\
-			tpl = ud->res##_tpl.levels - 1;			\
-									\
-		start = ud->res##_tpl.start_idx[tpl];			\
-									\
-		id = find_next_zero_bit(ud->res##_map, ud->res##_cnt,	\
-					start);				\
-		if (id == ud->res##_cnt) {				\
-			return ERR_PTR(-ENOENT);			\
-		}							\
-	}								\
-									\
-	set_bit(id, ud->res##_map);					\
-	return &ud->res##s[id];						\
-}
-
-UDMA_RESERVE_RESOURCE(bchan);
-UDMA_RESERVE_RESOURCE(tchan);
-UDMA_RESERVE_RESOURCE(rchan);
-
 static int bcdma_get_bchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -585,223 +456,6 @@ static int bcdma_get_bchan(struct udma_chan *uc)
 	return 0;
 }
 
-static int udma_get_tchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-	int ret;
-
-	if (uc->tchan) {
-		dev_dbg(ud->dev, "chan%d: already have tchan%d allocated\n",
-			uc->id, uc->tchan->id);
-		return 0;
-	}
-
-	/*
-	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
-	 * For PKTDMA mapped channels it is configured to a channel which must
-	 * be used to service the peripheral.
-	 */
-	uc->tchan = __udma_reserve_tchan(ud, uc->config.channel_tpl,
-					 uc->config.mapped_channel_id);
-	if (IS_ERR(uc->tchan)) {
-		ret = PTR_ERR(uc->tchan);
-		uc->tchan = NULL;
-		return ret;
-	}
-
-	if (ud->tflow_cnt) {
-		int tflow_id;
-
-		/* Only PKTDMA have support for tx flows */
-		if (uc->config.default_flow_id >= 0)
-			tflow_id = uc->config.default_flow_id;
-		else
-			tflow_id = uc->tchan->id;
-
-		if (test_bit(tflow_id, ud->tflow_map)) {
-			dev_err(ud->dev, "tflow%d is in use\n", tflow_id);
-			clear_bit(uc->tchan->id, ud->tchan_map);
-			uc->tchan = NULL;
-			return -ENOENT;
-		}
-
-		uc->tchan->tflow_id = tflow_id;
-		set_bit(tflow_id, ud->tflow_map);
-	} else {
-		uc->tchan->tflow_id = -1;
-	}
-
-	return 0;
-}
-
-static int udma_get_rchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-	int ret;
-
-	if (uc->rchan) {
-		dev_dbg(ud->dev, "chan%d: already have rchan%d allocated\n",
-			uc->id, uc->rchan->id);
-		return 0;
-	}
-
-	/*
-	 * mapped_channel_id is -1 for UDMA, BCDMA and PKTDMA unmapped channels.
-	 * For PKTDMA mapped channels it is configured to a channel which must
-	 * be used to service the peripheral.
-	 */
-	uc->rchan = __udma_reserve_rchan(ud, uc->config.channel_tpl,
-					 uc->config.mapped_channel_id);
-	if (IS_ERR(uc->rchan)) {
-		ret = PTR_ERR(uc->rchan);
-		uc->rchan = NULL;
-		return ret;
-	}
-
-	return 0;
-}
-
-static int udma_get_chan_pair(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-	int chan_id, end;
-
-	if ((uc->tchan && uc->rchan) && uc->tchan->id == uc->rchan->id) {
-		dev_info(ud->dev, "chan%d: already have %d pair allocated\n",
-			 uc->id, uc->tchan->id);
-		return 0;
-	}
-
-	if (uc->tchan) {
-		dev_err(ud->dev, "chan%d: already have tchan%d allocated\n",
-			uc->id, uc->tchan->id);
-		return -EBUSY;
-	} else if (uc->rchan) {
-		dev_err(ud->dev, "chan%d: already have rchan%d allocated\n",
-			uc->id, uc->rchan->id);
-		return -EBUSY;
-	}
-
-	/* Can be optimized, but let's have it like this for now */
-	end = min(ud->tchan_cnt, ud->rchan_cnt);
-	/*
-	 * Try to use the highest TPL channel pair for MEM_TO_MEM channels
-	 * Note: in UDMAP the channel TPL is symmetric between tchan and rchan
-	 */
-	chan_id = ud->tchan_tpl.start_idx[ud->tchan_tpl.levels - 1];
-	for (; chan_id < end; chan_id++) {
-		if (!test_bit(chan_id, ud->tchan_map) &&
-		    !test_bit(chan_id, ud->rchan_map))
-			break;
-	}
-
-	if (chan_id == end)
-		return -ENOENT;
-
-	set_bit(chan_id, ud->tchan_map);
-	set_bit(chan_id, ud->rchan_map);
-	uc->tchan = &ud->tchans[chan_id];
-	uc->rchan = &ud->rchans[chan_id];
-
-	/* UDMA does not use tx flows */
-	uc->tchan->tflow_id = -1;
-
-	return 0;
-}
-
-static int udma_get_rflow(struct udma_chan *uc, int flow_id)
-{
-	struct udma_dev *ud = uc->ud;
-	int ret;
-
-	if (!uc->rchan) {
-		dev_err(ud->dev, "chan%d: does not have rchan??\n", uc->id);
-		return -EINVAL;
-	}
-
-	if (uc->rflow) {
-		dev_dbg(ud->dev, "chan%d: already have rflow%d allocated\n",
-			uc->id, uc->rflow->id);
-		return 0;
-	}
-
-	uc->rflow = __udma_get_rflow(ud, flow_id);
-	if (IS_ERR(uc->rflow)) {
-		ret = PTR_ERR(uc->rflow);
-		uc->rflow = NULL;
-		return ret;
-	}
-
-	return 0;
-}
-
-static void bcdma_put_bchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-
-	if (uc->bchan) {
-		dev_dbg(ud->dev, "chan%d: put bchan%d\n", uc->id,
-			uc->bchan->id);
-		clear_bit(uc->bchan->id, ud->bchan_map);
-		uc->bchan = NULL;
-		uc->tchan = NULL;
-	}
-}
-
-static void udma_put_rchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-
-	if (uc->rchan) {
-		dev_dbg(ud->dev, "chan%d: put rchan%d\n", uc->id,
-			uc->rchan->id);
-		clear_bit(uc->rchan->id, ud->rchan_map);
-		uc->rchan = NULL;
-	}
-}
-
-static void udma_put_tchan(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-
-	if (uc->tchan) {
-		dev_dbg(ud->dev, "chan%d: put tchan%d\n", uc->id,
-			uc->tchan->id);
-		clear_bit(uc->tchan->id, ud->tchan_map);
-
-		if (uc->tchan->tflow_id >= 0)
-			clear_bit(uc->tchan->tflow_id, ud->tflow_map);
-
-		uc->tchan = NULL;
-	}
-}
-
-static void udma_put_rflow(struct udma_chan *uc)
-{
-	struct udma_dev *ud = uc->ud;
-
-	if (uc->rflow) {
-		dev_dbg(ud->dev, "chan%d: put rflow%d\n", uc->id,
-			uc->rflow->id);
-		__udma_put_rflow(ud, uc->rflow);
-		uc->rflow = NULL;
-	}
-}
-
-static void bcdma_free_bchan_resources(struct udma_chan *uc)
-{
-	if (!uc->bchan)
-		return;
-
-	k3_ringacc_ring_free(uc->bchan->tc_ring);
-	k3_ringacc_ring_free(uc->bchan->t_ring);
-	uc->bchan->tc_ring = NULL;
-	uc->bchan->t_ring = NULL;
-	k3_configure_chan_coherency(&uc->vc.chan, 0);
-
-	bcdma_put_bchan(uc);
-}
-
 static int bcdma_alloc_bchan_resources(struct udma_chan *uc)
 {
 	struct k3_ring_cfg ring_cfg;
@@ -847,19 +501,6 @@ static int bcdma_alloc_bchan_resources(struct udma_chan *uc)
 	return ret;
 }
 
-static void udma_free_tx_resources(struct udma_chan *uc)
-{
-	if (!uc->tchan)
-		return;
-
-	k3_ringacc_ring_free(uc->tchan->t_ring);
-	k3_ringacc_ring_free(uc->tchan->tc_ring);
-	uc->tchan->t_ring = NULL;
-	uc->tchan->tc_ring = NULL;
-
-	udma_put_tchan(uc);
-}
-
 static int udma_alloc_tx_resources(struct udma_chan *uc)
 {
 	struct k3_ring_cfg ring_cfg;
@@ -917,25 +558,6 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 	return ret;
 }
 
-static void udma_free_rx_resources(struct udma_chan *uc)
-{
-	if (!uc->rchan)
-		return;
-
-	if (uc->rflow) {
-		struct udma_rflow *rflow = uc->rflow;
-
-		k3_ringacc_ring_free(rflow->fd_ring);
-		k3_ringacc_ring_free(rflow->r_ring);
-		rflow->fd_ring = NULL;
-		rflow->r_ring = NULL;
-
-		udma_put_rflow(uc);
-	}
-
-	udma_put_rchan(uc);
-}
-
 static int udma_alloc_rx_resources(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
@@ -2024,51 +1646,6 @@ static int udma_resume(struct dma_chan *chan)
 	return 0;
 }
 
-static void udma_free_chan_resources(struct dma_chan *chan)
-{
-	struct udma_chan *uc = to_udma_chan(chan);
-	struct udma_dev *ud = to_udma_dev(chan->device);
-
-	udma_terminate_all(chan);
-	if (uc->terminated_desc) {
-		ud->reset_chan(uc, false);
-		udma_reset_rings(uc);
-	}
-
-	cancel_delayed_work_sync(&uc->tx_drain.work);
-
-	if (uc->irq_num_ring > 0) {
-		free_irq(uc->irq_num_ring, uc);
-
-		uc->irq_num_ring = 0;
-	}
-	if (uc->irq_num_udma > 0) {
-		free_irq(uc->irq_num_udma, uc);
-
-		uc->irq_num_udma = 0;
-	}
-
-	/* Release PSI-L pairing */
-	if (uc->psil_paired) {
-		navss_psil_unpair(ud, uc->config.src_thread,
-				  uc->config.dst_thread);
-		uc->psil_paired = false;
-	}
-
-	vchan_free_chan_resources(&uc->vc);
-	tasklet_kill(&uc->vc.task);
-
-	bcdma_free_bchan_resources(uc);
-	udma_free_tx_resources(uc);
-	udma_free_rx_resources(uc);
-	udma_reset_uchan(uc);
-
-	if (uc->use_dma_pool) {
-		dma_pool_destroy(uc->hdesc_pool);
-		uc->use_dma_pool = false;
-	}
-}
-
 static struct platform_driver udma_driver;
 static struct platform_driver bcdma_driver;
 static struct platform_driver pktdma_driver;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 797e8b0c5b85e..e4b512d9ffb2e 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -654,6 +654,27 @@ void udma_dbg_summary_show(struct seq_file *s,
 			   struct dma_device *dma_dev);
 #endif /* CONFIG_DEBUG_FS */
 
+int __udma_alloc_gp_rflow_range(struct udma_dev *ud, int from, int cnt);
+int __udma_free_gp_rflow_range(struct udma_dev *ud, int from, int cnt);
+struct udma_rflow *__udma_get_rflow(struct udma_dev *ud, int id);
+void __udma_put_rflow(struct udma_dev *ud, struct udma_rflow *rflow);
+int udma_get_tchan(struct udma_chan *uc);
+int udma_get_rchan(struct udma_chan *uc);
+int udma_get_chan_pair(struct udma_chan *uc);
+int udma_get_rflow(struct udma_chan *uc, int flow_id);
+void udma_put_rchan(struct udma_chan *uc);
+void udma_put_tchan(struct udma_chan *uc);
+void udma_put_rflow(struct udma_chan *uc);
+void udma_free_tx_resources(struct udma_chan *uc);
+void udma_free_rx_resources(struct udma_chan *uc);
+void udma_free_chan_resources(struct dma_chan *chan);
+void bcdma_put_bchan(struct udma_chan *uc);
+void bcdma_free_bchan_resources(struct udma_chan *uc);
+
+struct udma_bchan *__udma_reserve_bchan(struct udma_dev *ud, enum udma_tp_level tpl, int id);
+struct udma_tchan *__udma_reserve_tchan(struct udma_dev *ud, enum udma_tp_level tpl, int id);
+struct udma_rchan *__udma_reserve_rchan(struct udma_dev *ud, enum udma_tp_level tpl, int id);
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


