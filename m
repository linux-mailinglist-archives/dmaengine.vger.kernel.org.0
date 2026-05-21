Return-Path: <dmaengine+bounces-10659-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJjFBgIgD2pSGAYAu9opvQ
	(envelope-from <dmaengine+bounces-10659-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:08:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB865A7F45
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79CAA313BC39
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7604367F26;
	Thu, 21 May 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dNyleVXr"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020089.outbound.protection.outlook.com [52.101.228.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A931AF07;
	Thu, 21 May 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373325; cv=fail; b=dsAjHkN4Y7MpYrqeZXgAAyOOxbs+UJxdpLYh3S9qQWNtwx7hoyLC06NX14Ik21aUgbMTuNzfuS+Ytuu6kvy8HT6WpHkBPJkAhwIjCuJdFVn4GzxQty6G0hJF/NtJ9IPW/L5vmM9uFmd2PXE5QGgb9DGk1YmpVsXYYJRuZqXbNy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373325; c=relaxed/simple;
	bh=zUnQ7PkhuI98hMQpybD1evRI0hiy6uBeye6R362wBXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pvhZ3fDP3AUXb0TVDDDRgozkcK+uGdHMdyXQJ4HA4YeY1i8j2L0xF+T0urakRF806yz/z6vx/4H7JbfSCjIqzo1jM/1pF/0P8F75m4EFJybD0lrmexAt2qIsD2KNWZs/2LaISwIQDtRlU5DPmCYg7BozmavzadC4uZ6vMjK1/cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dNyleVXr; arc=fail smtp.client-ip=52.101.228.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwkkhnG7OcTesHTgOMQ9G8vsXgruJbT1oLYnwiTF5goJhohvFMwMlQkZxsEFIh3Oe0lrZuTn+tpCdVyimaJWBMHv1XLL3sgkhh5gt0J93a6hYeBDxQmDZzc3KZUHz1L4zJztzCRa1Ai733rGDIO1V/euy2RJSVZqyL+4atpve7dBkSneZXyRHdh18G1GbVm9gh49PaVjULSpf4BL6AqDtc+ptideidFkYJdMV4/bIT2A51og2nUXsPG4Z48nMaaAxRBqDSSWuz0S3o3QU3u3kHezwD/SxGXyWNiOdjKlbzQcG3YG7KOb9VyNIfqYReEB7HNnZTBXgDPHpnKq2vbyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uomBw89kLDme2Lf/R8yzJFPwhB9xhJ80lsVMzZQ7bzw=;
 b=GfND/YdchRbtF2LXYJ9vouh4cEiQOGDKXQkPbSHBFLpzt4OjYJk8JCIY1cEnmRKqohy+62d5MT+0A/1RfmbSoLbRATrlCslieM69z5y5YYL2bmKnLDo9MNBERvoQmIfnI8xr3Ud23W1KamDegerjbgd2/EPwacrhnXLeohIsiWRnxhCqac/wQlRbjNvt0XFu88ghd8hToVzN5/fgaTClWKs5okFEI4RBVQ0dgykewotmmiD1OCZGFvrTGgBRYx4BRHg0H5GsOSIi6kk4Ve8Z4dmjqjWBSytvhea5PprB/c4uF6qSGmDlJNrxVdtfK4vJ8ZEmPVvOiUu8vIgT7RW32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uomBw89kLDme2Lf/R8yzJFPwhB9xhJ80lsVMzZQ7bzw=;
 b=dNyleVXrKjQdJ1RBpFkrhonaBQvjTSTcoTERnQHbYZamp4QUYuld0LYiD8n2bg7x2zzEQZGKr4xw2Q2AO1YO6BCjirjzn2nJUp9rRCIzQlrS7aARuXOK2lQUQL8tYrnR2HJV4FKO7VjSQMBly6LXUY8OBrkybodyO58VT8tvV9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6259.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:22:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 14:22:00 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dmaengine: dw-edma-pcie: Free IRQ vectors on probe failures
Date: Thu, 21 May 2026 23:21:50 +0900
Message-ID: <20260521142153.2957432-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521142153.2957432-1-den@valinux.co.jp>
References: <20260521142153.2957432-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: e42bfeda-2277-4b19-c19f-08deb7445262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pJqDlDFKiI9WJySp4Pe2dfiJKhCASq3XgAMV9KUekvUOzRLdj4vBm20Ghito1WaevFXNfa93Qqi2GnyPlzOS9m1piVkcw2vte3AEJ6TFKF+XzI44K+3Jbw5gIflLQfI86l2ck1sI6Ls8D+Iu3YioRLYdMkrKNfTcFb1LrvE+2cy/MRJ2x6zc7Rp58RrPNyoXzuuLIIDCNOmZPwL2x3+OWbsu+hlgaEbzSa3iOARNS/9iSA+wxRjZuvqKBfA04BrLolLU1LvDnCS8cKaocA0Af4fxRnj3+ZQPouKsd5C5mHO+k09m+F03yELCrLeSQ0GUA0FenPtN6UcTL74ZCvBYgFX7NxDr0mAV8iM3Wom3Z4mKuuIFHRgETvgT0/CaOpeicEHcVLboC27zwFUbyuL0mCaM1q8hWOwEuGNFTHu5d4FtLP6SefVSvJZth+JZp38zsmfvOMxA5rJmTHs9EzMC1s2atlE5kvfWV4LPSo6MC5IktbsewRs4JVPhq1ack41rsCjXSLBcyXyFdkHn5zB6AUTgW7FtKU3dnkmUZhDf3iMIkISniiy6TloUJoJPnwIdbyfXN8uIo+c3ZQaQGMEvJ7ITfkxwtTOlZkYtn1DRWI4Ivj+I0p84w+pHTK3gxi4m9go3S5DZ+mhXlB/1S3Lx0u6yrbklQ1Ryp8UAvw0S8oQ7iZfKgafCJAhZauixhb0p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YFnaMQMcDyRiH7G6SMJ0G6CkTXHMhs4jJs2bHvRCZVTEMbiMRiLc+Q3PuEvC?=
 =?us-ascii?Q?y2jNMsdeMHpNgJySBAjaUE5ar3k0R4e7Ke7YhqvxozbU+MrN2WRjc/3YEUkT?=
 =?us-ascii?Q?xLTBxH6G6vM9GIGZSC9d2nMKoRSVVoi7SyGES/QRsZ5P7O+r/d0I0wvJUKbb?=
 =?us-ascii?Q?WlPYlu3Kuwrx/a18xIu+Xf9mSXt/+KEbUKKpnuvffexwKyJ37RwzY49UMXEd?=
 =?us-ascii?Q?e/NTmkOtGvYgB/FjkyiKokYwiZMqsZ8YPg5RQ4yKS4CHXnJ9XbvrXpcFZPsW?=
 =?us-ascii?Q?9KpgCl1TDVsPrWl/x7vnSTrAOUhRQNInKBACUic6AvF/v6TE4Uj7dRnydP8u?=
 =?us-ascii?Q?kS05zyF12iKS+du4kDdNw1uWf3eaXbCcqoaoxNDjBnI71H6egDpBj084Iop8?=
 =?us-ascii?Q?PwIJzrZCKXjGK0SSa05B5YZGBFt+yA5/K/Y0fog+5uW6vLcnl0h+wj1KilR6?=
 =?us-ascii?Q?rOwv/jYkxFDLZ6BYcku/s+Qfg7EFqZiXPO+0u0ipLRO0ikhX/Et6AZQlk+5Q?=
 =?us-ascii?Q?C8dMPo5k/hvKT72+uw3Ur+6zlMVIcT0ezW3T2fx/J5SJf4FBGqCembeTPQam?=
 =?us-ascii?Q?9NQuzgj0bYesfb2Sw1izHVryLplnuyV9teaHponiBOjebYZ2S+c4OtaTgXUP?=
 =?us-ascii?Q?1nt7D9N4wgdtkxrBYVO5Tuy7KBt2Bsauvxtv2ip4ZYcsIlI5rFa6w+JFs/qU?=
 =?us-ascii?Q?On8leQ5f0mD67+WNOSKGnL3W2E9v0pu7P+1+31WW95qyUPddrtharpHu/NBN?=
 =?us-ascii?Q?dEGModMaNO5uwxezgwzrll8RR9BKdbJYRKK8gZ/He5FG73pEODYhAGxmEVlu?=
 =?us-ascii?Q?p0FK24AydsSjSXwny8qGplVq4aK+B2fKRhFGILzgJnI+7qbPpK70nPlzm8Mh?=
 =?us-ascii?Q?j4bamVjMXdiJ+Oxy+5LPi064Rnh9+bhGzV1FfBH3Hh38eVGAFkFtTPZex/wp?=
 =?us-ascii?Q?nTQ6afHkjDiM2ljO8OM9fXqBAkRQrNORGoUkAhoOZiIF0D37PEMVDhcPLxJf?=
 =?us-ascii?Q?VfjovY92LTdOA+3W7yrPlaN5Co/fTfxexuzvWnqL4YJ0HPANJ9xjUI5FGAS0?=
 =?us-ascii?Q?f3IOoGaADJf3qu86Lmj7iHsR0XtNRjMKsgV2zEnZqyvVFasjT/RykAI4df0/?=
 =?us-ascii?Q?J/63Vz6Irv9Fc2DmI2gJ3FvgU8vfH+6sWkJeR0fSs4GlqP9141NXl4jrQxo5?=
 =?us-ascii?Q?870ui5PI0jLBeXP4JmiSLlCm1gaAk54SkoFy5fKTg8kQWLBak56jm0f0vYcS?=
 =?us-ascii?Q?ZdCQ6QxfiZTuB9CYDy/kzqeO5tm3eJxx+S/qCsbXbJk1ScjeCq5bLyAxINNJ?=
 =?us-ascii?Q?12PXMkWAgMCWlIb0lp9CMou2+iMyWrfxhrQqt4otoJGW8U3PaqDQrNiP61qx?=
 =?us-ascii?Q?HY3sycgQvXElIt8QYegJz102cr0cCyJJVTgroil+5qNp3cobugzl2pbv6MRY?=
 =?us-ascii?Q?uR+YEqVx9HFCq25LQ+uJwVUAmM+66cxmbxRfSx22Pe5RkWhnJ9ngV2AypV+s?=
 =?us-ascii?Q?FV3EABeGkHJ4WjimxkX4bRFSwR5sMHvn8YTEZWExIePLZrXqzAKmVamDdG/6?=
 =?us-ascii?Q?ChbTnw5vr1VfCwu8w+mZ7qa3lgSQu8t1TY31IerzggVgXj5gu8MVpWKSEnt7?=
 =?us-ascii?Q?YFio8J3rNGrhgCSy6PU/CcjtwGZOQS+ujbp3bXjMT34JNjDrZBy9hCra+y7+?=
 =?us-ascii?Q?EFiB4aM6CqkXqG8mI2b6f0hoTm4tPIuBMtPfxRW0I7brJ9ArBPWdnLmyvgxT?=
 =?us-ascii?Q?OvgJNi54bolyI0Te5shG1n9Em9Ql3HWLEkVug1XLXaVKFW5fF5V0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e42bfeda-2277-4b19-c19f-08deb7445262
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:22:00.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWgNIb40llXBAeTwY/Vfe9Yd3zhGOzjdVQAUuN8tVWUT8mlowpKT7ola0Ktj3RtpIjA0vbQQPh3dgySpz/TdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6259
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10659-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: AFB865A7F45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dw_edma_pcie_probe() leaks IRQ vectors by returning without calling
pci_free_irq_vectors() in error paths after pci_alloc_irq_vectors()
succeeds.

Route the post-allocation failures through a common cleanup path so the
vectors are released before probe returns.

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 39 +++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0b30ce138503..87c31d01fb10 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -410,8 +410,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
 
 	chip->reg_base = pcim_iomap_table(pdev)[vsec_data->rg.bar];
-	if (!chip->reg_base)
-		return -ENOMEM;
+	if (!chip->reg_base) {
+		err = -ENOMEM;
+		goto err_free_irq_vectors;
+	}
 
 	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
@@ -420,8 +422,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		struct dw_edma_block *dt_block = &vsec_data->dt_wr[i];
 
 		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
-		if (!ll_region->vaddr.io)
-			return -ENOMEM;
+		if (!ll_region->vaddr.io) {
+			err = -ENOMEM;
+			goto err_free_irq_vectors;
+		}
 
 		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
@@ -430,8 +434,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
-		if (!dt_region->vaddr.io)
-			return -ENOMEM;
+		if (!dt_region->vaddr.io) {
+			err = -ENOMEM;
+			goto err_free_irq_vectors;
+		}
 
 		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
@@ -447,8 +453,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		struct dw_edma_block *dt_block = &vsec_data->dt_rd[i];
 
 		ll_region->vaddr.io = pcim_iomap_table(pdev)[ll_block->bar];
-		if (!ll_region->vaddr.io)
-			return -ENOMEM;
+		if (!ll_region->vaddr.io) {
+			err = -ENOMEM;
+			goto err_free_irq_vectors;
+		}
 
 		ll_region->vaddr.io += ll_block->off;
 		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
@@ -457,8 +465,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
-		if (!dt_region->vaddr.io)
-			return -ENOMEM;
+		if (!dt_region->vaddr.io) {
+			err = -ENOMEM;
+			goto err_free_irq_vectors;
+		}
 
 		dt_region->vaddr.io += dt_block->off;
 		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
@@ -513,20 +523,25 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	/* Validating if PCI interrupts were enabled */
 	if (!pci_dev_msi_enabled(pdev)) {
 		pci_err(pdev, "enable interrupt failed\n");
-		return -EPERM;
+		err = -EPERM;
+		goto err_free_irq_vectors;
 	}
 
 	/* Starting eDMA driver */
 	err = dw_edma_probe(chip);
 	if (err) {
 		pci_err(pdev, "eDMA probe failed\n");
-		return err;
+		goto err_free_irq_vectors;
 	}
 
 	/* Saving data structure reference */
 	pci_set_drvdata(pdev, chip);
 
 	return 0;
+
+err_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
+	return err;
 }
 
 static void dw_edma_pcie_remove(struct pci_dev *pdev)
-- 
2.51.0


