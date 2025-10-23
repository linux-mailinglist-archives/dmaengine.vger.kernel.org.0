Return-Path: <dmaengine+bounces-6953-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E267BFF89A
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04FB1A02D14
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2892FD1A7;
	Thu, 23 Oct 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qMYwqUsM"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551662F9D85;
	Thu, 23 Oct 2025 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203992; cv=fail; b=AU1BFKD3l3nz6GJbwlz2ZFiPa+gppzWv7O6WsFmObFFCxt5JjKyq6RIJCpodMIfgS//75r4gVT2rFQU5U0it0+dB+f3w692pMs/Jz6Bh+AN/XioZSI1zJTvb5sR71qn26vhL9FybPbLEtcCv/+6xkI6mE8WwL3IfId6giu+aEzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203992; c=relaxed/simple;
	bh=vrGB0OsRM/Vk4FNdhLpmF/ezg+2e7yF1Q226xwb+7po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoYhV+iP8Am1B812cYQtdxyBR3rEnRqgVF38XPI61fn3exNscsXhWRoy0Hxy+rq5oEkJyWk52PSe9Psgn2CBm1vaGBGx6XeS24eHp2j5tiONIYeufbZG0nAqyWtkbbQfLUs/ee3geVF/grSNdRidAJFdmsPCn5KLHKFBDXnqD24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qMYwqUsM; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYstW07+WJTmpxwZOSOL3qR6L70fX/4hBW/4rCUVbsZ6MHnSEkqAn/y8nanqHNChEcq1jPw2QzsuN+eUUrgUcsVfBZQMp7r4fDy2KaTbajAp2saZ+JPUk5TDvfH3C3JRYFa293bra74FZcx0W0X2IYkSX9nO1/moIe9duKNlSEQmuU9SQwzYJ5oY4o6sR4CqRXVQyHIyngYhlyvX9erajZ10a4StEzUShEyu5yfBTSYK0CgFpB0oWoelKha9dNFtDB/oqltMJCXc5Gz2SGXoKErCQpG0vLggKOisDdnElHMZglwoLBOAzaiWQDkxkwjMV6QYCG44kh15rJL3ow8zGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0RVBx17S9DALbyYtwtcWYWWUJRmjurGuOhiLmhOMW8=;
 b=d+iSmYtlJ154A2uza6Nkc4XeGOol6mWpIbedP+raNW/lA0W9pYNdeXk1U2ethfBvS4LcDMhNnBZ2/oFXYbTx2xz7trmq3EU7YslgC1vAfSephc3T2RAXuc/0+kTX5lKyjVJGLkU0wTM5Zjv/7Gyd5Y9FKVPHRXv53xwfyXYB3bsq9WtPjjvi2W6zaGiG0YPRNvAOoRVJ+L57UjnNmfDP7SPT+om4/AoBig0fVKdTRUEPfJtVY+Bu7FQOZmkdkdPiPXWjWiC1gzK+XmwrQqdIkBUvBQxxHd+u4Dt3iupMkmOyl356axQU3SisSs2irgHqiBQFneXqVFvjao0gcNMwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0RVBx17S9DALbyYtwtcWYWWUJRmjurGuOhiLmhOMW8=;
 b=qMYwqUsMY2lSkFRaASFDktRdQAfCT8b/5ZDQUol0KF9g8TqeyM2f2OyFEoYM32ezFaTJdhB7vQYa6gnPY+b6snEZYebvzB4qchsPTTkZptKK+vZAn6fEflyXLCaDBU3WFJHde75Nn29Tp0RmN4GY/aqkCRnYIoZ4gmeJoMzGi44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:43 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:42 +0000
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
Subject: [RFC PATCH 16/25] dmaengine: dw-edma: Expose self-IRQ register offsets
Date: Thu, 23 Oct 2025 16:19:07 +0900
Message-ID: <20251023071916.901355-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::6) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e82a98-419a-4c9c-dcef-08de12048904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bCDiZcJcnz5wTt6VaMmwhdHqsPNzEINhARGUlj+expaVFUcIYJvLk7zxGhfR?=
 =?us-ascii?Q?FK8PzUh5wAfEpPpkNpOky3PxYqWeSAjMGyFMKR8LBm/L3iWS3DA+P1NwBUyF?=
 =?us-ascii?Q?WyPmLLyt7ZSxXriyRoEw9U+mCjkFLKsbuglX2f0b0jr+QWqyR4GKzBeJxiTS?=
 =?us-ascii?Q?jVfoiV5DO2W6ts8AoDltxlDxscMd1/+nh6Yv9HUEIEOqa7ebUBSXG3fkzg+J?=
 =?us-ascii?Q?mimYWBhV2du8giLNZ77myYKcvhAhkgzoFheCgUJfT+S4Tn+FEVRVqTkuMI/5?=
 =?us-ascii?Q?jauUdTneQPS0gdZilifP1FHsgWTEhdBSN8fy2cVFMxbhiilfj9cRDVX9Wdzv?=
 =?us-ascii?Q?mclfqJjLvG26GSPmDQO4h6T0UwenrQN6bINo4oqEgmAn/iynDbzLA/VETJs9?=
 =?us-ascii?Q?AyW1/0HS26dRgdTnr1lNlDj32MLqu5ynOrAFHDDrpWSNUB1Kbg7C2gdZv/7K?=
 =?us-ascii?Q?vBTnSWQgFzNqMFSQY5pCXB3seXE4/iie8saxgn06o6N7kcQsd3L3q5wxF6td?=
 =?us-ascii?Q?7qERHkpYsGAJz9OzI6Kv1ecouJuHSKN2k1TPpYV/JMnmNLUgBQmWYDZXwJoL?=
 =?us-ascii?Q?Klm5iG/tf8Y96Dglsx8HPkEyWBhanCfwoNDymFBVot96uUJ30swO9P25F1cZ?=
 =?us-ascii?Q?E1n2qNJAlhaTR8k+L3W2vtAK3/67P8T9pBGhvs6gd567lhowVWPk4qPrsH+a?=
 =?us-ascii?Q?8Z3JTmtUzFcyaYZT09qhiJ/bYnXDSHCXAjEhY09yi6kUxzYn+2pKj2JFS7RI?=
 =?us-ascii?Q?7GU0ZgAL6w1x6w0Wjbxh9eeeX663CR85F6IAitNcogPiAF7OxPelGkRw0Zya?=
 =?us-ascii?Q?1VJvn7+aqd2gTrYXJbkblbXOE0kLGrvl8QY4kF9OV+MsMU9qmFYRVnCb78Bu?=
 =?us-ascii?Q?99F2Ux3Mm6JQXTOAUlqooEud+hL+3VWOzeVch7gm0nEPqkq7FYKun6kx1rkV?=
 =?us-ascii?Q?9dQAyu3v5dsjI0Iq+Z9fkMEAbvAcfvg+fuODd/kLQsNMOGECgFAIHsKMm3HC?=
 =?us-ascii?Q?ntliUdhAVpKNUTd9Yh4lHJN0NASY5lnSM2czzgC42D6aFgE229P3zJ/dDueu?=
 =?us-ascii?Q?mYAyjsjDyYT7g4cSZd4Vz8U8rcn4KdIJ4u6OwH9Umncq9SSNmcyqbZ1GIZfS?=
 =?us-ascii?Q?Si8xpX+eo0GDu4y9OeTVId33j9wawXd2S9BQSMVYf5QFC+r0fPYXlc2Yb5ST?=
 =?us-ascii?Q?C/deHNZKizyFmkBvAAQlOvf+I3eco6B/hVudGrIln+U1kEewzl/g/OZFTpY3?=
 =?us-ascii?Q?kD6J+fz/dRI9I1MV6h9Z2DhM2gARpElDWV4IMw8emRiq+MMaBY9DymrIFj/5?=
 =?us-ascii?Q?BHOhCLFXwVJnfZgm9GMiFHkTB28FRtLk0ltLEWfFST4X/rslAow9sudZM/MQ?=
 =?us-ascii?Q?ft3sQ/99+tDnJaNvp8JW8nzbmjsXcnLCanj67ET4/oE7SvtUGIx/SLo4it/4?=
 =?us-ascii?Q?n5l42cgeaiH/iffqrIKs0CCBH33yDuL2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jcHQSMpXJmMX39F6vnrBUKtnDgByU8sEx1vHtSIvBL4X8NWcnoJYrY8Z56PY?=
 =?us-ascii?Q?oOb0ToU1E1H6E8Fk+zwu9ZIrhF+K9wOSLP2SQ0Iz6C08pdi3TWbGBmIIi4Uc?=
 =?us-ascii?Q?UsHUxscqZDM6FvBhQOClKjrB0ydLdftdaz5F6ogSLOdY2SriEuPTe/9EeXn5?=
 =?us-ascii?Q?hNyf0DSC4pRBP/hQbTJQRlIKWyMo9uJGN8qXkhCPahBaiFONL85nL4GHfIzw?=
 =?us-ascii?Q?BHthoqHeZzAOua7/tukoHYOfjaCWMRdBjHSUHpVrr+M/u7+oeUOmrqUt/jtW?=
 =?us-ascii?Q?6BtUGvFY+NHelbj7Ojn19cYDXzNR14JnESAVxFU7VUO+nLvJgyQ9raCCv6kd?=
 =?us-ascii?Q?fLqETXxZYXeTvSKgZ0aU5NpaoLY2OpuF87z5pAerFcAgGGn/KeBbg9/58syy?=
 =?us-ascii?Q?DMPexJl8/vVvx7Ms/hhNXMpmWfqzJA2nvyqZBW+osim7Q37+KQDw8ubjIP/v?=
 =?us-ascii?Q?rIYgg85R6JhdrmjOqHwO3s0O05BsdsNnc1i7piiwQLNi6wU6fXZX5beAMtUf?=
 =?us-ascii?Q?xIDJNW5IQcHO/IJohP3jd9OvoDExb+fAi6k298DLV2Ezz0TE+igBYK1SvI3w?=
 =?us-ascii?Q?EsCkzJFJWf7CiEvYAqPOVIsA10izEZXDjwib/flmX5H+OR8Nuys7y9jAGPL/?=
 =?us-ascii?Q?iQMa3sO5McJCoHSRLM0fa+5VZGPXHKSF4bYeD5ufAzxVLMgPQdz6XXy5PLTt?=
 =?us-ascii?Q?iu2V7rrfMjalbJu2Nrb4L9XirfFw+OD6JNP3Y+UmlP+O/Fo3me15JFoN4Y5g?=
 =?us-ascii?Q?YuPRXEkjwqHgUIbKPjDKc2oLzClzClbMXfpnxAMcsbBpxZG/lelf8wGWeSKA?=
 =?us-ascii?Q?p4rQAh2+g9/R7Tmo3+ISenjtt45rhoVoPuaKYXH6XSXezrZq7ukkxiw3ceKu?=
 =?us-ascii?Q?LtQwBrAVrFEH9uesUwrTEq2TMvxqB+Ty+STE1eapJ+1keBDQWhzbZ+3wT/vR?=
 =?us-ascii?Q?KkbkhVMeuptPFPS+8cB4lKBZVnR0BNrsfZTfTjUSxMrlgI6D7hdPiDJnyBpu?=
 =?us-ascii?Q?mP0IiA5mwwzKHE46T2To5R9HeUQRNXpGHt7fVhy9EJMaI5+5sa1VkdwAGgTk?=
 =?us-ascii?Q?2mGYuvMnc5SqSPHIX+ihpTjKbCqE5aR6yMxUPYjZtRpZ3o59i/lwvTrzm3ld?=
 =?us-ascii?Q?gTc77r48uu5BHDcVHJlLE/lo0Co+e3uKXZ1PfqESj5WDc+XDwGxNvAA+3kgF?=
 =?us-ascii?Q?OS4DpYLXHkaXusf/sJGZrjfj6pKOlNJXcpl3z3eJiqNyr8PO8zud7MAkN2ZG?=
 =?us-ascii?Q?eh17TMQnuAPMENWooNNXQqE94i2xGCSFiZ+3hfNQMk1aeJH+6yKr5QNetQGZ?=
 =?us-ascii?Q?7nzjE4FtAXF17Fugq8AxPRKYLPrs2ng05fhPG6WbsLChcG/bh7RARou4qGK7?=
 =?us-ascii?Q?zV019gxFnX6GLWD5uy0+v31WH54RC/Ms1xTRpqvno1dRkebpUUJYOiiLi9/K?=
 =?us-ascii?Q?m9jNzqczujPmjxnYIE9J/m1wJnBjhlChLzJ3cr64SxEDpOEkHy6vxeDLjHm7?=
 =?us-ascii?Q?M79Cbm5BxF4Euuw3jjRC5nl5OxY0urXqYY8aEXT9R2g/Txvq2KQWRxdDzQTx?=
 =?us-ascii?Q?qzJbMqrBiuSY0Y17K1QIBwDAMnSZd+49Bx4THe1kSwysKNC8pONKn7Z6/0X1?=
 =?us-ascii?Q?2BatyVIogZwWl9u40Clh7BY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e82a98-419a-4c9c-dcef-08de12048904
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:42.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdm8MxsEjuksvfhRTK7Arl0KBzVR6syIzpsgpUmpkHHqvxpJZnBEvYnSonVXiebLK3k9wET/rLJ7/kAH4Ej56A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

Add helper dw_edma_selfirq_offsets() to query the physical addresses of
status and clear registers for software-triggered IRQs.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c           | 23 ++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c |  1 +
 include/linux/dma/edma.h                     | 10 +++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 7cf9e5e74a89..28cc319e224d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -20,6 +20,7 @@
 #include "dw-edma-core.h"
 #include "dw-edma-v0-core.h"
 #include "dw-hdma-v0-core.h"
+#include "dw-edma-v0-regs.h"
 #include "../dmaengine.h"
 #include "../virt-dma.h"
 
@@ -903,6 +904,28 @@ static int dw_edma_irq_request(struct dw_edma *dw,
 	return err;
 }
 
+int dw_edma_selfirq_offsets(struct dw_edma *dw,
+			    resource_size_t *rd_status_off,
+			    resource_size_t *rd_clear_off)
+{
+	struct dw_edma_chip *chip;
+
+	if (!dw)
+		return -ENODEV;
+
+	chip = dw->chip;
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY || dw->chip->mf == EDMA_MF_HDMA_NATIVE)
+		return -EOPNOTSUPP;
+	if (rd_status_off)
+		*rd_status_off = (uintptr_t)chip->reg_phys_addr +
+				 offsetof(struct dw_edma_v0_regs, rd_int_status);
+	if (rd_clear_off)
+		*rd_clear_off = (uintptr_t)chip->reg_phys_addr +
+				offsetof(struct dw_edma_v0_regs, rd_int_clear);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_selfirq_offsets);
+
 int dw_edma_register_selfirq(struct dw_edma *dw,
 			     dw_edma_selfirq_fn fn, void *data)
 {
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..8233cc26249f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,6 +162,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma.reg_phys_addr = res->start;
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
 		}
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 42daf9a76b56..1f11b70e1b1a 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -85,6 +85,7 @@ struct dw_edma_chip {
 	u32			flags;
 
 	void __iomem		*reg_base;
+	resource_size_t		reg_phys_addr;
 
 	u16			ll_wr_cnt;
 	u16			ll_rd_cnt;
@@ -107,6 +108,9 @@ typedef void (*dw_edma_selfirq_fn)(struct dw_edma *dw, void *data);
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+int dw_edma_selfirq_offsets(struct dw_edma *dw,
+			    resource_size_t *rd_status_off,
+			    resource_size_t *rd_clear_off);
 int dw_edma_register_selfirq(struct dw_edma *dw,
 			     dw_edma_selfirq_fn fn, void *data);
 void dw_edma_unregister_selfirq(struct dw_edma *dw,
@@ -121,6 +125,12 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+static inline int dw_edma_selfirq_offsets(struct dw_edma *dw,
+					  resource_size_t *rd_status_off,
+					  resource_size_t *rd_clear_off)
+{
+	return -EOPNOTSUPP;
+}
 static inline int dw_edma_register_selfirq(struct dw_edma *dw,
 					   dw_edma_selfirq_fn fn, void *data)
 {
-- 
2.48.1


