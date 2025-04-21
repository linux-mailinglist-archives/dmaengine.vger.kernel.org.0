Return-Path: <dmaengine+bounces-4925-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D1A9505A
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 13:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F520188D79C
	for <lists+dmaengine@lfdr.de>; Mon, 21 Apr 2025 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F647263F5F;
	Mon, 21 Apr 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U/1A/005"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA16A92E
	for <dmaengine@vger.kernel.org>; Mon, 21 Apr 2025 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235782; cv=fail; b=iaYF6oYw1y+AK0mGE/4qkf0HnoxFrEWqs9nYnpOvBfJAire2P6rWRV5/3011kA5RITVTz7NE2ITxIOm1/lMErBJEnRg1eqoIUbOc4uIBO7jzaI21xz0ylap1tlh5YYGcq1Xp0Of5slzsroqC7I2eT0jdwNt5vdUjx1LqWg+iDr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235782; c=relaxed/simple;
	bh=0rD+mD0bs+vpTuARTofNwXL7f8IHpDXpZrH4rL4rlL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WIKjs16cRErM95oDa32Bj1pCCvd9RWaPXNrqDUSidXgpHcGW5g0paO/zdF5pWIDry1dYA1uyyObIfqbymEq63SwPx39c+1a6EZ57W1tr/dza136baC/9bWrEjop9pel/zmk2JeUYCebElwZfWvldmzFYIGjhGRSnGvvUmVU7R+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U/1A/005; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS0kzZAeAcYfUzRSBfgrzZroV19H767vwpjE/u6qO48uHjYLl3sOBev8kpRO+Xwd/HmGFmU5IG4Q8mQ6w7XrdvR8ORKVPkw+ZlrBfVctINs7/e1PIGQ4G0jQ2xnIuNJ7s8QlIjE4zNM0T3kGZJgPfSdomxPpQ2mi+qFXa+kj1T/3uo+jm3BLm1mYgMDtfBjngjRyYUB2YkuZ3nncRgKgJ0LBd95hcQ7GXGsF7ySUdW3dhuUsxSpcWTNsaGQzwQwxs6Af17mYRhKpP78Q6O+bSgnMrMTpNa2ZyG50mmljDQbgBdQgXc/p8PuhoGu7hxDN+5xQ5XHoTD9yv4oovO6/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCHzqdToZa+HcSVgn/ltgW94IxH4s6PdRu1XTWDdRX0=;
 b=bRtPCLFQrhz6RbHdYCfakuChx6k/gwoJJKhIliTRrMNrNOtdy/VUCcEJMiN1NAqF2O8ATCAo7SwP0R48wrrQcqUEezzpS2yqTj0mwusME40L4xG902k0O1z+yvbnE8p+r0PNViNIn8Z1zbeJvxE20m3E7dhjB77bhF9JJ2NigsJhBZJrGbayDExwsh6/toCV6FovotWfLKYNNTzyKVqSI54QjHU3y/fnGeQcCtdqc50s7kpMMZws0Q/eE8y+hsu6KSrixSQ/1VdPHTDS6ZXf/7DmK1gWIkVwFGt6XxK59vv9A3GVO5dmDdQsMITpfoNmEJ2mEGLBwZZ2CEKTsVCaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCHzqdToZa+HcSVgn/ltgW94IxH4s6PdRu1XTWDdRX0=;
 b=U/1A/005rs34KzyMBoIU2IJrVqZZK6tdVyOJUbjn+jhlFs0DyKiXEFOGRmSRpgHmF7TXrMgDn+uBwSoZtuVJX8EftbF6tWLpywQ62OqFEYQY6/qoWKXOmxLt5qXO2zSnTGqYhmS2pcaDxnUr+1zQJiL0W8yoromYW5qlkOJshCk=
Received: from BN9PR03CA0672.namprd03.prod.outlook.com (2603:10b6:408:10e::17)
 by PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Mon, 21 Apr
 2025 11:42:55 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::1e) by BN9PR03CA0672.outlook.office365.com
 (2603:10b6:408:10e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Mon,
 21 Apr 2025 11:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 11:42:55 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 06:42:52 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <dan.carpenter@linaro.org>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2] dmaengine: ptdma: Move variable condition check to the first place and remove redundancy
Date: Mon, 21 Apr 2025 17:12:15 +0530
Message-ID: <20250421114215.1687073-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH0PR12MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d8e18e-39a7-41c2-629a-08dd80c9a7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIEluPcvLyECgjAvNMzW/SpqkcBYHCg2y53BKzDqaWKyIYb76DhU2k3P3nU6?=
 =?us-ascii?Q?2zQgDdovXQ3uf/vGyAkYpNWXCgQNYeEA8vuXPKisFGzNhBaLW4Ef9zPdIidz?=
 =?us-ascii?Q?3azGqN58c1TAjWoceL/U1NKebcArsuwGC5UmPY/HFLTlGxERTTSM+RxftwM8?=
 =?us-ascii?Q?V3udItiKetx5q8Tclhb82kB9LuDNGKv99Rxgpke9lKgwz2xe5LvWD8zDThGZ?=
 =?us-ascii?Q?L1+Xmwx7TEq2RTK5+9Zwk65lmDYdgNCvXWl2Jaq+2imlCvmUwUgz1grXcUQA?=
 =?us-ascii?Q?flhNAYt65KhvGj9HPtFqfMegE7TZzZsaujxgnAbXSMF33kV0MaaQ/1Szn0H+?=
 =?us-ascii?Q?4abDmS4Lg3Wgj71ltx+UB9tFsN0GjpZh3vSaMKP4ii7npvthRh3/RG7LpMwI?=
 =?us-ascii?Q?xXU00TKyEOjIna2kke7hHFa6VIDp54ottjVzl2/hfeaGbDW2BDYegg0K6lSr?=
 =?us-ascii?Q?c3rzmKS5bA8XK+pZPiQts/THqRS1KGR0IxXKMOW7FCeLCtUt571C9E9S+wy8?=
 =?us-ascii?Q?/Lmd6nNKDTLGMmJkWiaS2nMBygXRzeDHClgPpM8NIxRoTQltgXhrS0w/htcS?=
 =?us-ascii?Q?flY9wr3B595Io+NVv5gzebDhBMuV03Gys17WAKyOIEva9HsJMz9wyb20iTAy?=
 =?us-ascii?Q?PUhfBWyL23kXsjYSAbEsZXyBIiff8v/ZyCcQt5pT8VYgqcexpkTwSzcSqSRr?=
 =?us-ascii?Q?ORqvEB5hDC22yG/uNaLdZXPUhFITkOuU89cxz2jtp6HcyKGdHUefx283bf+t?=
 =?us-ascii?Q?Z97kROt2T/BU23z5CIm0tVCvOvK6CX36biV7dS8e2710w/TGt/tg3RKnQJU4?=
 =?us-ascii?Q?ncCnoSI1H0KlnarMr/Xgzl/apAFVGVBJ8fq6gzfDYuDSzSQ9XabTxD1kuyPE?=
 =?us-ascii?Q?y7azhiWgWYg8y1UrXiYSuValovWUnLZ8UUltAUX2amxMZZy4xppzsf3gzHKv?=
 =?us-ascii?Q?nRpJQ7uxhAcN9KGxoQbQbLD+3W8XCWs0UDZBTdVArNJW5xRenO4L+7W2ceDl?=
 =?us-ascii?Q?lDDaOZld+Yl+uzE9slYoNSOln9GRdLvXBFTERjPgY477vzRHqQf3n6Q2HGRC?=
 =?us-ascii?Q?IZ6ItmEEIthoR9xTBGzeOk5jc3/4Ns+iEnBdLs5+Bf8U5KMXCmcBNaSJEm/1?=
 =?us-ascii?Q?RQe8BXf6fYyA8+DQzPNeCKVj0Z7IwBMj7/7wQ1Olf1t6T2U7mc+f142B+NTN?=
 =?us-ascii?Q?RoHMW1wznhsAf71q9fdL2YjBRdjsD/Hqb0ukN3sTwouwVd+pTWUqF9yqYyc4?=
 =?us-ascii?Q?6ozoXLeNI3qaDx/HOwsHYBrCUYYk4y9cYBeEP+WpWVEF2O2bO7yDmb69zhlH?=
 =?us-ascii?Q?OIYe8XT518GdVZjT92Eo9vTgTHCSJw6laqJHCLQL6/Ag06gauYQcdyl+YUKy?=
 =?us-ascii?Q?iFFqxn4v0DgR9yCegIXTIsGJ4S6wrP9QHxJc72YIZBtCi2Z3xNsNcqTqEllG?=
 =?us-ascii?Q?C7ACb9i7OD+aqpwP/OlOVNwDCUZBW/eOZKnjjsl4EA8tDu7pdSq641z+AMi6?=
 =?us-ascii?Q?xKc/VJTs8NV9bg3yLucSt/at9RuU1Np7xEUr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 11:42:55.1047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d8e18e-39a7-41c2-629a-08dd80c9a7fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7957

The variable is dereferenced without first checking if it's null, leading
to the following warning: 'Variable dereferenced before check: desc.'

     drivers/dma/amd/ptdma/ptdma-dmaengine.c: pt_cmd_callback_work()
     warn: variable dereferenced before check 'desc'

Therefore, move the condition check for the 'desc' variable to the first
place and remove the redundant extra condition check.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/bfa0a979-ce9f-422d-92c3-34921155d048@stanley.mountain/
Fixes: 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
v2:
 * Revised the title to reflect the changes. 
 * Described the fix. 
---
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 715ac3ae067b..81339664036f 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -342,6 +342,9 @@ static void pt_cmd_callback_work(void *data, int err)
 	struct pt_dma_chan *chan;
 	unsigned long flags;
 
+	if (!desc)
+		return;
+
 	dma_chan = desc->vd.tx.chan;
 	chan = to_pt_chan(dma_chan);
 
@@ -355,16 +358,14 @@ static void pt_cmd_callback_work(void *data, int err)
 		desc->status = DMA_ERROR;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (desc) {
-		if (desc->status != DMA_COMPLETE) {
-			if (desc->status != DMA_ERROR)
-				desc->status = DMA_COMPLETE;
+	if (desc->status != DMA_COMPLETE) {
+		if (desc->status != DMA_ERROR)
+			desc->status = DMA_COMPLETE;
 
-			dma_cookie_complete(tx_desc);
-			dma_descriptor_unmap(tx_desc);
-		} else {
-			tx_desc = NULL;
-		}
+		dma_cookie_complete(tx_desc);
+		dma_descriptor_unmap(tx_desc);
+	} else {
+		tx_desc = NULL;
 	}
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-- 
2.34.1


