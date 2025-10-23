Return-Path: <dmaengine+bounces-6950-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCCBFFA38
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0303B1B79
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4790E2F998A;
	Thu, 23 Oct 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DP3VNjOR"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011003.outbound.protection.outlook.com [52.101.125.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E12BE620;
	Thu, 23 Oct 2025 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203990; cv=fail; b=dLqa6jkJp+QGfhz8sDIx9nCc+bjYktvo8X+vp3TZLihTO8yLncesX0I+xEc5x0x4PdNtPgtEgtpOpcoz2XY+ABO3rF6PyYJ7uovCm3OXG5ZQTo88UIi8aEKBztrl0W4hgTQ38F5FreLcwCVYyejHo1HKeyvfO0zRWlZelX20ouY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203990; c=relaxed/simple;
	bh=mqwpxw7DF9Ij9V+k0+Jb/DwYdCtFR1/Q5gBX6pIwbl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTNcFCV4oszO3tWoXW1Fwfv7NdzmG/hKwOuzYoO1tUr2T3tyELy4DCOtgJ/tpuTzSCjfb0qHKPRZswi9Uql+BLwpjnSEUTRt/Mbf2yenu26XMdGCs6LmTzLxUO21CBJNb9mJSnbI/lgZ1KcYyP0ii28zwE0BrItE7INAsnpK+aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DP3VNjOR; arc=fail smtp.client-ip=52.101.125.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI3N4uohYbqtW+4PshvV8MGuGKwlwzQlgNzs2qK9CVUapeiidAOonX46EI8n9BJXugYXEB+8PJT8wmYEXqQgKBTN6VagHX9amqP7AKdqXEStfBFvKKBINdOBlvnhPna56q1+yaajv+c5MU1YBCMiZLT/RqBBBbCEFQWVKt1UDoYJFprHQBOuz82AS35p+xx8cDunAM9RKNGZfYCTPmxQ5++masEQjOj9w1MScEfP4xi3/sy6P/cY4h765udAqc2gR2fPWnrey7/xXiX7Bfdn6RQ70YidZt3t9qXvqqL+yEVVIVT1kMmBP76frrohQtJOVjXHzZQEstKDt2w18m3EOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNST4JR2GmjgfseSsXUyCfalQONTbNFp5geasoreGN8=;
 b=DnLMjSTD2++iWjKl4LvbD3Eg9Y3qhJUHC42bQeAWVVpD5GHDhtvyvghkjK08QuILmOxWTPFpUPTEGZphHqb+zG4KQULiTnWHBQ1fa4mhQLfS/uA3mt7dIGyapbAtMkGb5PQajBZtDhsr4sUbo3S97OS8oTQDqUEKwG7z8Q+TtZcIFeclKRsrCb4o4yI/0q9PCzMi82Y49w1a4/pyjqZgP6WgaMWm6CZrk7Z/W0X629n61Jsx6D8+hfnswm3ktrWm+W17eF8XXRWUx4QjMTKFhBqWGy9ZU3wrOwyhLYQiC10eSlu8QWaWZ+R2UteHnfkvHcMopgCYIBlh7UzVWtKhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNST4JR2GmjgfseSsXUyCfalQONTbNFp5geasoreGN8=;
 b=DP3VNjORNuMyCiYr2i2QuL+1iWrclyGDSxw6cM1ErSGutfjt+MThoBQwZiBxhu/RKHxzxqtit2E53w1Dfq0RrZOrfQhy/ifJc17uOhpS4gWvMOnC9aEy1K7KgHpor5BqdySHwWmXAViyx38Re6XzC1GGhtcdDSVYWXdGAivQD1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:39 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:39 +0000
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
Subject: [RFC PATCH 14/25] NTB/msi: Add a inner loop for PCI-MSI cases
Date: Thu, 23 Oct 2025 16:19:05 +0900
Message-ID: <20251023071916.901355-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::17) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e887acd-a32b-495f-482b-08de1204879a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M1YPC7jJRka9SUvaBs8/UO0u3TDI3F1LLkjmUIydOZE2P70kB4IpEk42rfX7?=
 =?us-ascii?Q?lUU8JYO+5c1avJwA1XEo6mofZmYft/I+gMyEnMFfM/pve1+wXeci0KBtJCce?=
 =?us-ascii?Q?fH19W8CmA9sx2dDgZxvkz5DKhx/il6MpxaulmM++PnfaFGkJCzAywvuMYbxf?=
 =?us-ascii?Q?eH/oUmcY9dNhF7vrkrPuSECLO6m6JPrrGYvKuafDdVd9di/leILukrsX3Yvp?=
 =?us-ascii?Q?ciLB2kQgM76qECgOB3yWUnwNiku9N81VQTTHyGFm0FSN4fpXzoidCGyOfDHd?=
 =?us-ascii?Q?KsHsQsLTahdWunyIUYvumWaWjWDU+rsoWVx5QsgZd6cIPWbyC808wzyMY94X?=
 =?us-ascii?Q?6QvzYOGMEkQLy6IaGl4JhdxIsG0/13teMtlG3pDCBTS2W5fOHN0my7l1RnFZ?=
 =?us-ascii?Q?dnlrL6BPxXtzqAECh5AytUM2u9fU6B/bY94WNnKrH3F34pnASUbHfLoV0Iwv?=
 =?us-ascii?Q?P4GoA/UjI02wuvmjM1Kp69vz25ePfoagr9Zzca3yZWhYt7cMG8HPD7CwcSWC?=
 =?us-ascii?Q?jHmq9GYn5W09VGnM2q9UrVqflXvtHhZjZykcVLvJNxgjEA54c9VFJlzLaA+n?=
 =?us-ascii?Q?aC0XPdLHiQ6vMCYahcn04vsBC6sHbvpBUkRa0/5jvEYKEnfzU6yhUeowAwfI?=
 =?us-ascii?Q?iiQnQezuX9rFTbDrp87CQAR+u4aif2TwhSfsQXY91zQiAU+bvVwkCMGzFRFW?=
 =?us-ascii?Q?6Gc7/vXmg8QPNUEurMSceKSZ5YSXgLjsO2gdwQi5sCVBKF+UV7GtoWjM1PVk?=
 =?us-ascii?Q?G1N/F9E41cx+/Ft1StY9SmrwV58jus9av8VXxQT33tEmhgDDRaJyJ07l0pha?=
 =?us-ascii?Q?dek2+2O8oIS7xRky47bwhiuVrqikP/KhdSr+8Cg4IKK70IR/vPT0eUfST55k?=
 =?us-ascii?Q?fvT3VVXGyml6+jrL0rLhFojXQNCVAbac+dlysjrGNQGdeOfNNkf3lRKTzBcy?=
 =?us-ascii?Q?jvINfw7nMNZElujZHhHneyky3rh8rwnTfjW8LzgxxaYXQ7+9wMFSTomRI/Tr?=
 =?us-ascii?Q?gamM7nsxaetBqH6LkNnj0HEEkI9inqrh337MgE+OplAJpURc7lixO/i4X9dn?=
 =?us-ascii?Q?/CJlvKP4+Z09mFLsrBPI1v1+74pAuBo9JdRB9nTYEN1fiDxB1eI9sguZHTDz?=
 =?us-ascii?Q?t21kBSZ6d2SUcNjgBFiKWc4fenWS/tW3uwnUmHTTqDrWQJjZpZ4k4Evry7Fo?=
 =?us-ascii?Q?zoX8X22mbp0QJG+vszRDSP7w7aK796eb3qbitZwwXW4k/SM/4ec+50N4rsVt?=
 =?us-ascii?Q?roqA1r/7tqcMbgbKNPt+CZtfgW9/08b31QX38EGtoHgGmbjZot2r26p11qLV?=
 =?us-ascii?Q?vtAzfGmhUNO0kMT3MqO92Ebn8ASe1et7du1deEF5KmEdmF+i77lQiVgF34Q/?=
 =?us-ascii?Q?mcBpeS7wejw66hjlPU4d30bDbOQ+rNx3s+ffXudUlSHJQRzstFWASuHi7Fcp?=
 =?us-ascii?Q?9U+1QXtytDEVhvXGoHDr3yhGXkHqlM/C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kj/y69xbZkw+Idhua2Bq70U9sE3NnISnEtgSozrkONty4ircpdLDPNAaWIWV?=
 =?us-ascii?Q?m7hCPzouTpK3jQAIebw1FkKffSYnx9C41DSQ98fsma+TMrkn30YcFqhsf/wc?=
 =?us-ascii?Q?x45UncU4dtvQuo8xl47NuZx6z+AL/gXDLp1sljkYQ//eRYcBM5rWexR8rZ8K?=
 =?us-ascii?Q?bqNRSTuS+YV1mp1dk5l2rCYGiXFcjMkdXxEQaj1OxhmSDR+HpZjEygCWSM7M?=
 =?us-ascii?Q?hHBmPXntEIdymKmXFj4Bper/aIGZTdk/F1gtXnMiOfYetnDWhIl1nzV8czV5?=
 =?us-ascii?Q?eW5is7U9FQtXozYJL5+Q5zsQyIMB0f61TXGHwNqmqZSz5QOLm/dzICVl+OPL?=
 =?us-ascii?Q?GiIPE1SV8AGAeoPqDyHMV8YSjQRwegCR7Y8/LzxsSSJPWX/4XR5uvsavV9nv?=
 =?us-ascii?Q?nmYU/Yt4G7kI09EbtFJ8u67z37s6pEeLcP9jnnAxdAKtiFV9uvnYR1so1mdM?=
 =?us-ascii?Q?h9XANBV00Wt2CQ/5tFAJAk9c1nRdnXFds5TqaxHm77lsKOKMa0vEyUuiYIUh?=
 =?us-ascii?Q?o4NMzyJrfCIR6lP3IIU4P3d6GRMsWZWlcEwAzKp4HYyMkl0WNocZMW/28GHt?=
 =?us-ascii?Q?jc0IOgjQuTqsPpPkwgF5f3tEpAT3yxY+sBJBvgnWAhqkdE9YPc5CbSuJh+Tg?=
 =?us-ascii?Q?UjEasuNQ5rMN0Ku4xQ8PkkMwDz7QVO8zM6QIZQxRuPsDjQvPRqIO/6DeO+0H?=
 =?us-ascii?Q?/kHR2QQspvyhWpuvTLyCTB2Wy7Alszhm0WXIvMBK+Ekm7TgTaJl7lOlBaw1C?=
 =?us-ascii?Q?k8h4ba0RR+QKBy1284U+zmCLiEuMF//Ej0sd2x0zy8OUib4qjJTo7ld5ef3A?=
 =?us-ascii?Q?6aHU2wm43ShuRIh7Kg6TAObsLSZfBibujpJl2jwyO71EkD9Qs4cJBD2RipSR?=
 =?us-ascii?Q?Ij88BV7s3IkkMvtySipon5ES2d0kSrM3+0mz8pR3h8RVtXVZFgALu5SwMUFl?=
 =?us-ascii?Q?OU+59hEqcaEVbPES7O1uOBI9O2LauHgfJtjL8qyUfxgmdIQJM1uWmtVCVSSK?=
 =?us-ascii?Q?NDnoGeviqI9z+K4CkVuSXEIyVgnsg9YkK5qyQ8Jj5BGr91TzBbL0R27cq1ZY?=
 =?us-ascii?Q?DNW9lhMKzTQQqUSxpysQMUuzLcAsja8g+eXvYPOrxQ57B6tUEs36CoFCKq0i?=
 =?us-ascii?Q?2WQsAeBXngM7cmjimpcHvFGnQleli8VFmcB9kTBCaSvrpGPLMchvzslIP63x?=
 =?us-ascii?Q?D11uCuVEpBWCubgphkgFe1G5wuI0+wRhw/Iv1N/gqJmehbdR7A14fapJoQbP?=
 =?us-ascii?Q?xOr85ZnSbhVqfFEOvJarC13kZlvTWGfAYNZ6QalWqTZ7j9034RMMiU97hzDc?=
 =?us-ascii?Q?RBebyVtw0Wmw75jl/ARMMkFNkK8V62HBqEEC68NMlpsibh6gCyVIvMii/gTC?=
 =?us-ascii?Q?z8PbyBVlTH5RHWSgczipelLHikx4+ptxW0jarOjDI2DXsiVTt9eJHvJJ/vPE?=
 =?us-ascii?Q?nJ8tSP0w6YTsxWW3CNXdZ1RsBwOzN2yr9f8JGLgQgcbXCzwUAUew7iMbH2D9?=
 =?us-ascii?Q?e806baU/P8UMQLM/V1uGT8BchFvfevGApZn5F7AEBvWVdETPRiQyI1s+GqWp?=
 =?us-ascii?Q?xDo9MiUy/KH2TAgtBlCXTsKEBjP7AsS+OztLNiagvqxx2y/DyQEVRwL3rQDd?=
 =?us-ascii?Q?pW5fy8YkuNKcyDoFVopAi04=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e887acd-a32b-495f-482b-08de1204879a
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:39.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WNdH/6iAiwtRfSObb/RJTDbb/paEa0AbRL2sQ4HAkCWpvlRRLhhVQSWC0HL3urn8dau8tidwC3/K8XzEudjqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

Add inner loop to handle MSI descriptors with nvec_used > 1, allowing
multiple interrupt vectors per single MSI descriptor as on PCI-MSI.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/msi.c   | 51 ++++++++++++++++++++++++++-------------------
 include/linux/ntb.h |  1 +
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 6d48418aa756..983725d4eb13 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -195,7 +195,7 @@ struct ntb_msi_devres {
 };
 
 static int ntb_msi_set_desc(struct ntb_dev *ntb, struct msi_desc *entry,
-			    struct ntb_msi_desc *msi_desc)
+			    struct ntb_msi_desc *msi_desc, u16 vector_offset)
 {
 	u64 addr;
 
@@ -211,7 +211,8 @@ static int ntb_msi_set_desc(struct ntb_dev *ntb, struct msi_desc *entry,
 	}
 
 	msi_desc->addr_offset = addr - ntb->msi->base_addr;
-	msi_desc->data = entry->msg.data;
+	msi_desc->data = entry->msg.data + vector_offset;
+	msi_desc->vector_offset = vector_offset;
 
 	return 0;
 }
@@ -220,7 +221,8 @@ static void ntb_msi_write_msg(struct msi_desc *entry, void *data)
 {
 	struct ntb_msi_devres *dr = data;
 
-	WARN_ON(ntb_msi_set_desc(dr->ntb, entry, dr->msi_desc));
+	WARN_ON(ntb_msi_set_desc(dr->ntb, entry, dr->msi_desc,
+				 dr->msi_desc->vector_offset));
 
 	if (dr->ntb->msi->desc_changed)
 		dr->ntb->msi->desc_changed(dr->ntb->ctx);
@@ -286,32 +288,37 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 {
 	struct device *dev = &ntb->pdev->dev;
 	struct msi_desc *entry;
-	int ret;
+	unsigned int virq;
+	int ret, i;
 
 	if (!ntb->msi)
 		return -EINVAL;
 
 	guard(msi_descs_lock)(dev);
 	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
-		if (irq_has_action(entry->irq))
-			continue;
-
-		ret = devm_request_threaded_irq(&ntb->dev, entry->irq, handler,
-						thread_fn, 0, name, dev_id);
-		if (ret)
-			continue;
-
-		if (ntb_msi_set_desc(ntb, entry, msi_desc)) {
-			devm_free_irq(&ntb->dev, entry->irq, dev_id);
-			continue;
-		}
-
-		ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
-		if (ret) {
-			devm_free_irq(&ntb->dev, entry->irq, dev_id);
-			return ret;
+		for (i = 0; i < entry->nvec_used; i++) {
+			virq = entry->irq + i;
+			if (irq_has_action(virq))
+				continue;
+
+			ret = devm_request_threaded_irq(
+					&ntb->dev, virq, handler,
+					thread_fn, 0, name, dev_id);
+			if (ret)
+				continue;
+
+			if (ntb_msi_set_desc(ntb, entry, msi_desc, i)) {
+				devm_free_irq(&ntb->dev, virq, dev_id);
+				continue;
+			}
+
+			ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
+			if (ret) {
+				devm_free_irq(&ntb->dev, virq, dev_id);
+				return ret;
+			}
+			return virq;
 		}
-		return entry->irq;
 	}
 	return -ENODEV;
 }
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index d7ce5d2e60d0..dc5aab43abc2 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -1640,6 +1640,7 @@ static inline int ntb_peer_highest_mw_idx(struct ntb_dev *ntb, int pidx)
 struct ntb_msi_desc {
 	u32 addr_offset;
 	u32 data;
+	u16 vector_offset;
 };
 
 #ifdef CONFIG_NTB_MSI
-- 
2.48.1


