Return-Path: <dmaengine+bounces-6952-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A77CFBFF94B
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF50A4FCDAF
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916762FCBED;
	Thu, 23 Oct 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rv3TFjKc"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011003.outbound.protection.outlook.com [52.101.125.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563592F9DA5;
	Thu, 23 Oct 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203992; cv=fail; b=RDm0Kl9v+cJXUF5rczh2PnxQeeWRSPwXelUweRghimZbmyIoXNgZP0TszGZK1bgoYCfZoHkp4Xec+k8+l1HupjSNwrGeDTUQwOnOnPSZcdY/W06bqWBurZ1DiLFaAKCh34MrDeqNc8fLfBdWE5FyG1w1mH2SGp8bzTe3f5fuUgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203992; c=relaxed/simple;
	bh=9QRsXnm9TZ1FPYI6O0ZyB8ryk2K9BpVI92RTPNHJ4Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RbxvNYcNIGslBh/yTYUeiQterpgK4oWFqy8rgyKrO122xZL9Dml9iqRw3ZNFo2uQXmShO8ETdIAcAM2Hhb7jAWQ5cdc2WO5FGtFWnNRHSr4TelvCM6pUkYbrte/PfYImVbaRHUBT7Kqedqmgqqgm6mU1iVwWbZeuUSPRpG0Ouog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rv3TFjKc; arc=fail smtp.client-ip=52.101.125.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=riPnuRYh8e2dbZgzl0ENnl+TufQjKH/1kyR0OnPJj49gL95fJ9xYWXKSW91J9h97je+2jbVMMNQv5HgB0w71Pn70j+rSR+kc11h64LqTZWykh6FqXM2AU0eiJvzhh+KIRANOuIbTgApid8UwQ003psI43mTh3WT89NXRNtBe9apRx+QMTmw2fs6sjkYmnz4RfpU09jkMfcnejpKqPTk3hrqhh7FU6GmsXYoU67w5lYt3KCPAxMEKkYWTU9Wdy6HlAdM1W27O6nMFyCuvfbua5Lbb958vg9V+eXJCCZTe99zhGKJGO5Adjg7QdAZhBvJgfXlGMyoadNjjwBhpjuwv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YJfiAfJsTrdEykpglInsYFblZYIcl7L6HNhA+fXGa8=;
 b=M9RBFl+VrFX0yBiyICgNjejjJgmYuiNnc9bYJ82uO/MR9JIiTpi+A/X6ExvMioz5ONgEOnoITzF81V610MdKRANI8h0yZz7vBp3UqIgbsqmiNsjhY1Gz/IPLIrpCl4LPYmw+qHFjbGlqkCVTvrnzvqx+MclnMVE75H1ATyiOnx/7qbKq+ya2gYF+6U5hnL/MRfcdyikFZtGDP/Xv8Zldpfko5Ps4JxqIcSAA80f3xH+5gb83OLLZPcCUn1TonWt2bL/d/z8PeMfbBvYb4E6v3/+otEZQErFkZiLOSW1BydkX0NYYi9QIQ6lU5tRm31fFPXBt3LAiZ7YvIM9L3pxjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YJfiAfJsTrdEykpglInsYFblZYIcl7L6HNhA+fXGa8=;
 b=rv3TFjKcDPCHU11aC6A/CyRxQ/rP6WFKiw6d0hPeT4bYuXGqdRggn6n2XWhyLd/DPvoBOxS8WfKMkJ9CPAMAYYmW5o642SspxGmIMmorsmqt9IKmYy3awF5K+L1VDhCMf6lC0zfqOchAwjyQ4Q7UUqVECUNGbuITMiR4gWHBX7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:44 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:44 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 17/25] dmaengine: dw-edma: Add dw_edma_find_by_child() helper
Date: Thu, 23 Oct 2025 16:19:08 +0900
Message-ID: <20251023071916.901355-18-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::15) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f68d9b6-6a25-405f-12cc-08de12048a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dU48aVS77ZM1ny+xojvSyJb72Zvto5tjGvh4uyfMRvXDloO3Tv4ec4tozuUT?=
 =?us-ascii?Q?eKaw7BprNl4CTUHJpgZoHHm1DYqE2N4jnW77zQCkZcabQ3aTAutAepL9HV2B?=
 =?us-ascii?Q?8aXdrgDfOSAsjCGetJ9BqdbK0vCLZv4OsyyIa2rTdrVjp1jkAZvE1re0CiK8?=
 =?us-ascii?Q?zpq+XPgB8KxlZtgWRI7mF6gOx8EXL+dFGMxdDJWBrX2t6jh4CAGTBld6wGUU?=
 =?us-ascii?Q?gWZZeEzO7IQ3XfSHqZKEpTfFXx5aERYVCRzLfm7/0HgLKMXWTrRixY++0eqo?=
 =?us-ascii?Q?JEpshmtGL5nhxJJ8QWJSLDwcSkF9QZxhXO3v9XTcC0y/OD/cg/aMEtAtgohZ?=
 =?us-ascii?Q?3oWng+bitGjbAvOzPFT0UOR6VmknSEEIvYFv3YPVTJlAf+MbnO5SGEORi8bM?=
 =?us-ascii?Q?dfVtguYnCPnWGTIfsTv1q4nJIpcTCZtCzt+M5IqTv6ylQyp0BpluvP2bTOAA?=
 =?us-ascii?Q?2GKKTQljck8CfBBW60J5f0dBS+UrRh4itx2ZbSZ5F1tSLMdJzjO8sTBi4s7v?=
 =?us-ascii?Q?ydI1XXtmJCn/B51bgdRQPu/rcfbHhucd7jHedXHeP1TBeN26mRf1DYMWgdTU?=
 =?us-ascii?Q?yO0L3IqSxDwtsk26qYoS36DicVCzLhtBbQBJtKxubyWYLIMEQttq9KQZHcLm?=
 =?us-ascii?Q?dv2EsqsLfYN1QEczDd9UocsLY1WecUMauxJ/bYcVqVUlM+YTcOw6EwkgSNG+?=
 =?us-ascii?Q?MALOhjsE4JkKpYsNzczPT8/mBJURrmXzULa8UssKzGrMwC7NVb95dhB24v54?=
 =?us-ascii?Q?fzCa3dXYyTYxoA7kbJIGzzNs+bTPKNd9+r7SzXw1nyYRY9QFd4WJ0Ts5r7I3?=
 =?us-ascii?Q?yV7YdAVYCDGoypiRJHIBisybbacmi4SZu+FEyqpJvZ9lpmAAfKu9mxLkDJAe?=
 =?us-ascii?Q?NBB3uLkVpG7XemV4B/tpivR2q0jPseBDwMiVyNIdzQZO7oyOdk6/QlQcTw5R?=
 =?us-ascii?Q?Jgfl1PZ7KRBxXoMSsBJHgNae/C4abqsh1WIEn+Sl7kQK7JRvGtGtUco131ku?=
 =?us-ascii?Q?ITZSaMRO8eVuScIMma2OFwns4KjukKAMrtf0x40oaGRL//N6T86bjmD0GdGv?=
 =?us-ascii?Q?PUN8NEBoXvAcW9XxWI3lS+10S5YZall/BvkYbPWF7Wzx74bYozk60HiLCFzf?=
 =?us-ascii?Q?y1kdUs2LWNSEf4NIcI1xfcv9oa4sTAuZBQsqAPqzcRvjxI6lORWZ8wHpL8CR?=
 =?us-ascii?Q?xnjjpNwAxba8ZQ4tMaRc3wGeQRXXGeTFY0xeh6lCNLlwDhCJaZ4pnW0fGWJb?=
 =?us-ascii?Q?wPvcZJxXRk8OxQ55Pq5LbhbejePkCUMSzPlqFHxzJuRw5cbUUaG+4lcqRt+z?=
 =?us-ascii?Q?vA5+xxsU72YUlOl459+BamQpDhmy1QyKinUruIWOBB2T70g0vnxGjctbffnO?=
 =?us-ascii?Q?wkmdEwtEMVJ5I5jw/MoxKabH3oF18wgK2fDbIOzzoYGKUSSM3SBCswFwuhym?=
 =?us-ascii?Q?HLYtPDX/UUKDaVVuPxyvNTg9CAdaIiTQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7v2U5170WyWSShpA0H7iW20xSHh/0RP2mYxmuyU0qRzG4G7Ci5PeOjIhlA8?=
 =?us-ascii?Q?LLJ9aHVq4M1GzYYSm+AeHNDWR1+grC9U91o47BgHR1lv+zwU/Ciap2jL5oV4?=
 =?us-ascii?Q?Htnyh/CYDIPfT1C+v6O1I63A1CecdMMne9F/5UwRtL/e4pdmFUsqMvEhXdOi?=
 =?us-ascii?Q?z31a0OChQ+fWu1Go5sBeQN/6mQkQ0PQNdzMlYXhyPRqUU19XExR854ujmN1T?=
 =?us-ascii?Q?qnxFbIv2ymJx6tqqv9AewnzWLMvHc4LBLajo2AHOfPnu5k8SjVQlEZd7jOY0?=
 =?us-ascii?Q?0IZ4ZdzS2pUswN5ThGb61QhHMZJa5YRy/xsA1lxC6mXMJcdZ3IZkTt68s1sJ?=
 =?us-ascii?Q?kFO1Fu1cn882/+BC+ZgUFGgi9mRKDmFuqUjgoG1EM6qjU/fOCTXvGww5W+wL?=
 =?us-ascii?Q?9NoaPY6KANFOD8MPBKlhUzCARAUphAqzzxU1K1f7n6TGsvimxGIG5MxaQwln?=
 =?us-ascii?Q?ibpQ2whFCkcFtFr6sJ5vMAad1NWWGoJqKtTLbqXk3TNj3ygWDh6QchnSIAkP?=
 =?us-ascii?Q?plxvgaqP72GhmVaYyalkNkyKVdcBoHzFpuZp80bI0jdI6Ri4+2sjSJPpf4FT?=
 =?us-ascii?Q?Gfpp8AjuWw8W8u6ZeOFTDGWitTJtiGEIgbKhMPYh2Z8jqcW2UuuGATlMzNVY?=
 =?us-ascii?Q?Z0sz5HnZoUF3nDI4gOpU30kc/Wt4KDeLh3ZS5ritJ5ZWP5MLanlp9rioWOzf?=
 =?us-ascii?Q?0+sSxx8sEjgfWZYXLiYygXzxYB7kfD699Ug6MH02t/jBvLWyNaEuJLd06pl4?=
 =?us-ascii?Q?qzkk1t22LiqX7xsgODZ5u5A5HiwOl2eKKvgVZLO+eLUMtChNyjosPABxjqv5?=
 =?us-ascii?Q?lyhoCsaISfIccLQ6HCazYCgahmXjW/sLpeUeZ9Dk0nbF/110RSgZ1yfVG/wR?=
 =?us-ascii?Q?V2dl+vrarc8CH+9vY5+PNlxqxhhiy4dbffrkDyzsBVH6p3NZNOMOraay/OuB?=
 =?us-ascii?Q?vS22h/+HfUfQ0VS6g9E0ONWKfdGpF5DRsq8I4S5I0srTw1pm6/qtK1lOr6pt?=
 =?us-ascii?Q?utcXlw05D0FpR4iqb5KAo/h2c7lEdaaXnzReNTnWrQwNfl3/mVRIzf7CDZJo?=
 =?us-ascii?Q?pR4qmajjiPUBj1/LbYvysCoaEdXdbMofXTUIzYa8aV9K63geulc/X977lO14?=
 =?us-ascii?Q?D3+s13j4mOtchEh4cLVlXI235yj7bdNjoAgmNe4H/orI4b0hhofSAdBNq7qY?=
 =?us-ascii?Q?hgJ9hZCqSubgVzf86VNl6CH1Egxy6RxMwOPJyM3cTqEOyxGdCabDep1QdvMr?=
 =?us-ascii?Q?6ZWG985N+6cAL9oOl9C70KjxfBYup/xWpfLLOMtWHKDqPkb2hnPuP6UIhwW/?=
 =?us-ascii?Q?z8PgHNVQXk09O7WwMTv9VjcybGBPKD8Gfw3tLhif4QuWe7UKz2xxmAOkzwRz?=
 =?us-ascii?Q?+d+SFfDryTq1pZpJ/jIitJvujbL42o6EWF7+4HT3tV4DyKKwK67jQL6n4cgU?=
 =?us-ascii?Q?tC0wC3MJi0VMK6iiniVFOE1dgFy70w3w+16fAonF6S9WuwtH/T369Fd0aR09?=
 =?us-ascii?Q?cv9iCtJhXhEbkLexpEL8iYTvNQZOOfc+S1FQ/IR/OazK7y/ZZZOO8MWFaRrH?=
 =?us-ascii?Q?ouCv15FeWb9hUmG7mAp+bh2LYged13NHs/P0YwJPs4Cc/Zs49qXJ0T4jJ+Bt?=
 =?us-ascii?Q?kRr4sQ0jc37+9keEuGAWMn4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f68d9b6-6a25-405f-12cc-08de12048a1a
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:44.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qrmvbl9NuOHBKNRMhX7vN6wBZZE7nYpmh/iAs7oV3qV2HaJ9AG6wLIkcqLTSWSKVSCFb/42XGwizpfHkqjX3Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

Add a helper to locate a dw_edma instance by its child device pointer.
Used by PCI endpoint functions to locate the shared eDMA controller.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 26 ++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h |  2 ++
 include/linux/dma/edma.h           |  5 +++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 28cc319e224d..6c7495504456 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -24,6 +24,9 @@
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
+static DEFINE_MUTEX(dw_edma_list_lock);
+static LIST_HEAD(dw_edma_list);
+
 static inline
 struct dw_edma_desc *vd2dw_edma_desc(struct virt_dma_desc *vd)
 {
@@ -964,6 +967,22 @@ void dw_edma_unregister_selfirq(struct dw_edma *dw,
 }
 EXPORT_SYMBOL_GPL(dw_edma_unregister_selfirq);
 
+struct dw_edma *dw_edma_find_by_child(struct device *child)
+{
+	struct dw_edma *dw;
+
+	if (!child)
+		return NULL;
+
+	guard(mutex)(&dw_edma_list_lock);
+	list_for_each_entry(dw, &dw_edma_list, node)
+		if (child->parent == dw->dma.dev)
+			return dw;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(dw_edma_find_by_child);
+
 int dw_edma_probe(struct dw_edma_chip *chip)
 {
 	struct device *dev;
@@ -1035,6 +1054,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
 
 	chip->dw = dw;
 
+	INIT_LIST_HEAD(&dw->node);
+	guard(mutex)(&dw_edma_list_lock);
+	list_add_tail(&dw->node, &dw_edma_list);
+
 	return 0;
 
 err_irq_free:
@@ -1080,6 +1103,9 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 		list_del(&chan->vc.chan.device_node);
 	}
 
+	guard(mutex)(&dw_edma_list_lock);
+	list_del(&dw->node);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 7d7dd9f13863..249d7e153cbf 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -122,6 +122,8 @@ struct dw_edma {
 
 	struct list_head selfirq_handlers;
 	spinlock_t selfirq_lock;
+
+	struct list_head		node;
 };
 
 typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 1f11b70e1b1a..abc59ffde62c 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -115,6 +115,7 @@ int dw_edma_register_selfirq(struct dw_edma *dw,
 			     dw_edma_selfirq_fn fn, void *data);
 void dw_edma_unregister_selfirq(struct dw_edma *dw,
 				dw_edma_selfirq_fn fn, void *data);
+struct dw_edma *dw_edma_find_by_child(struct device *child);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -141,6 +142,10 @@ static inline void dw_edma_unregister_selfirq(struct dw_edma *dw,
 					      dw_edma_selfirq_fn fn, void *data)
 {
 }
+struct dw_edma *dw_edma_find_by_child(struct device *child)
+{
+	return NULL;
+}
 #endif /* CONFIG_DW_EDMA */
 
 #endif /* _DW_EDMA_H */
-- 
2.48.1


