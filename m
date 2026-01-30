Return-Path: <dmaengine+bounces-8612-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHlDHHCRfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8612-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:09:36 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D40C7B9D50
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 570EE301327D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39A37B40B;
	Fri, 30 Jan 2026 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sEqVQTcO"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0336998F;
	Fri, 30 Jan 2026 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771029; cv=fail; b=nw9grM00erAgQwQ7vuVTYhku9ATifun7DaKfaqmax7xEiw8XGu5AwFFnq5OciecxRgjKPWU6kQwgqCHlurZ8ZY1w4/w9JI5pkSHr02Gl9l3ZkQvsTlmA6xwqKu7+xCoDijLRhoNVWTwEn1SoJIDsudokgcYzIxnlEQrCrQbbczk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771029; c=relaxed/simple;
	bh=Ftmo8xwYASxaNuKK/i5Kxsj4R84MdbZHj7rKMEU8YhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUPCjw23f19vP7qhthH/XkHG0SO7fG4yCOo0odbXY+hziWY/fnavneyKIajPW+T/kPcF7KnZEJhiWIsGNd3Sj0C+swLc8T2/Wt+jzS4x5jKEH6EGBVacTJ+VOiN4mFPS8uKCVXlToIrczal2POzGgfShD8SUsCiAVu4NVURXLXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sEqVQTcO; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObRlsk9xUzJlrlnAFWpVzwQpzG+0EMVRFEUp3n/EboJQjJcTgIzzBMCoF/qBk0jpkerrLB3mrYt+RD1Z4tG6ZDzsie/34cHMx4Y0yaCHKv2oboy+4XfGX69w+KVxvlrOiTTzFsUyuDflDvkITkAh/sV11raV/c6oQ6+eebkpFThX1Nu1fhvNlEBS4VYXY8+CXRYNhSL2ZYvrZURl/P/H5ctJ27iK9MAg/X5p0CarKX4iUX5vrhgtgdO582go+0jjED2kPxx6IBH/09BxPQkpMFMXd1gAb5iKOlYRCL+KfbiAKIkfFoHzNQY8VVcDcMTIk0tpvcKiAZJSeres9VHxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqz0XSG8o59AuKUmfPRUJcZvdY1vU5Fni5uHk8Nfzj0=;
 b=pi661JGsCpz8iRlRiQBUrX169AYvBD2H83JVRhMf66CS7mSlXoOaEqdoG9gs06Af9c11UFk+0cvvgi5WqeUQMf3S+rwnE02CGnI4gGw9OFmVSVch7EM+Bnddqi/gMGcWdMG7olzQ+R5KXCI81IQfGhIbv/sBcpVhVqlQVv3TMpHWE8EpC29Roz3v0xlbzeLLvoziBf5iFGkXLt3ouGMyLog0y1xXPkBLLq2EEhDluXfgGo3VV7Y/bpbniH/KmPSO+piNN55cl9+2M15M4xIQLV3malelNlTdOFXKhALHS/gR3gYJ/P8/UYG2UGEC/dW2J5FUPs/G9TZqjyG7lm3Lzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqz0XSG8o59AuKUmfPRUJcZvdY1vU5Fni5uHk8Nfzj0=;
 b=sEqVQTcOhkIV6aCZzirBLWcFNax00c2wqJRN+6HLLVcmjjnDnoXz9wNX8MH0f6iwBifK7N0VMVZwa/gd92D/+Su7p+LhitLZwsgoESJb3TLnXOLKkxOP9oMwqOEH2TnyuxPmqLASJl+2G0QM14e2UiTOtcpALOBv36s4ihtmw8M=
Received: from BYAPR11CA0087.namprd11.prod.outlook.com (2603:10b6:a03:f4::28)
 by SA2PR10MB4490.namprd10.prod.outlook.com (2603:10b6:806:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 30 Jan
 2026 11:03:46 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::59) by BYAPR11CA0087.outlook.office365.com
 (2603:10b6:a03:f4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Fri,
 30 Jan 2026 11:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:03:44 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:35 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:03:35 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:03:35 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBu1204392;
	Fri, 30 Jan 2026 05:03:31 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 17/19] dmaengine: ti: k3-udma-v2: Update glue layer to support PKTDMA V2
Date: Fri, 30 Jan 2026 16:31:57 +0530
Message-ID: <20260130110159.359501-18-s-adivi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SA2PR10MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: f71ea2fc-4389-4887-2f16-08de5fef3c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LJ3i4WO+x2dqQHs8060pqleNjadekki9SPCNGeew9rHDuiUV/Uh6mr9EKrMv?=
 =?us-ascii?Q?Dz9i4Trql5ZPNBzyYn5Y3DkpwMy/YA/ZndM3O7rVS8jFECErjfBwJH6MVohM?=
 =?us-ascii?Q?0dZbrcQ+ocIw43AJfpuHPCrHMmD8KmiXp/iUKm966g01XU54AA1p1pZZ7bfk?=
 =?us-ascii?Q?0GP9rO3aZBkQ/Pcrahuy4rQEF2Qkft8KaQxHu8vu/RzXKdGWqjsieV6Qekaq?=
 =?us-ascii?Q?Q1zguT/uSvNEJhlUKXDtTo3VVlVhBmJwRkDGIzMAqbDH5oKBK6bdp8jlVlEI?=
 =?us-ascii?Q?hyi4yawtopXB3BFXhI2isJjMeaOzI4tgrY8o8vyBau2sNmZ0H5fKGnRHl+ba?=
 =?us-ascii?Q?ms4Z110z8Ms5nIoWpZo5TLitw9C6m1R8QZ+us4PGXhxVfAxSSg986w1GsOe5?=
 =?us-ascii?Q?hD7ISpEb0ZwZUyO+t2aE46k5NpZl1QnpkrO7Lzxy4VPhVHC+rtPSc3Qo2/QO?=
 =?us-ascii?Q?WycmzUnAQisqmSNW0cWAdMlghnNNjBCirrOkmPJ3nCOBCnFM6tfwh3ZBV6i6?=
 =?us-ascii?Q?yDJLYdP6UfwzBiyO+g9mjkMs5fWPV49PKL/eIyFVT14FEP8Kht22RXy67eO3?=
 =?us-ascii?Q?knvJyXnUTebFwzSu5ptGEya0RineI37xAzsQCFm+84cY/lLEnDz77vlJ7QyL?=
 =?us-ascii?Q?t6x+LQEvivzAAtRvkIE04/4t/3q2ST2ek/UEWehKX+ZgPaB6K50vzev16txq?=
 =?us-ascii?Q?tgVjiNHljTTjjVqXcFxrA/X2NncVjwSGu2jdbGh45nmo7NcRcdtXXtfq1WDy?=
 =?us-ascii?Q?G8MPnD/9ZqALYyUs+pLf4gIV8+h/Au2tpICiUlBD28xQlAW8TX/O6Wa+Rt8t?=
 =?us-ascii?Q?6ZUgWbVEFA+yXlPenGgvmLgQ0wIXMs2F0wIAXii4WSWeaaLtq27hSHVbmheA?=
 =?us-ascii?Q?LGFJfQFdebPo62TIJfJl3/HQ9OyODMxK6G9j6++XaN+k3STl9FdQESAIweA8?=
 =?us-ascii?Q?ck/FxGSWLjbdeysbS0qt5B41bhWfjoQzk7VX0D4a99ObvwaAp5mBPIVPBeMY?=
 =?us-ascii?Q?+coPz/RtgUdpVmLq8/x55s69fPK+KEb4L+SrXI/zVHc5cVFlVvkRu2frgX3m?=
 =?us-ascii?Q?+hcsGV5pnEU+sbJzHgGWN2yRDNxBdCFFY1pR8ujgx3EGPQRM0GIemCDkiBx8?=
 =?us-ascii?Q?nU+67p1ag25007lreq9n+qhJamBSnZ2aOmuv+mMvZ8hkqNCaDfwKdYK/EKdw?=
 =?us-ascii?Q?KJ+Aw47u9QiowVL8cEb3Ky5LAHFx2PZIs9frDjWM3YcSl31JPhZ55JgT/OPV?=
 =?us-ascii?Q?fI/2eCkgIw+yN7FcHDW+H7zJ2ozBvWLu6cgjbG22TEngM73Sv+OlFeKYY3O0?=
 =?us-ascii?Q?aOAyA3m64JE5YyOLB+uRXRc11aGGtw2Hif0BAsANoI188nO4jarlv4+vgCk/?=
 =?us-ascii?Q?P4sZQcPSYi0Wd8s18lGTbTerZW2Ue/OVHlNhksnKAGdFrPBRVdP4ckaUj87Z?=
 =?us-ascii?Q?NF3Z5ECU7BpONWg3rNaBVEZfAkaba9o8GuwvAs4LRU/zYfybVvVIEvcudlsS?=
 =?us-ascii?Q?8EmWbqf0BD8b0XGPsrQv1DNLh4JuIG+NLMjgq5n0YEiM6XKJlW3h8OGmEfp0?=
 =?us-ascii?Q?lLuvdjltv9P25W6x3yViFtRMf06HdWLglKvIx2q7+2hhdeezZ6b7Ep+rjWVh?=
 =?us-ascii?Q?h8f8yYkVmyvNkpEKKnUVcvc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	t1pAvkZO3//1HBfECr4HFJoC3/Zu+EzF4LnDhYM2W5GoVjNyOx4GjUfUVwhgPPVGAAlMyr0FbZYt6So+FVPASTmttRwWf2VnFNz/a4Qhyn5NRLy8l9jPmT+UoTCrSadsmiSj22EqKkOstnFDXwb8nth92i6+2V1DzbYslHKkMUum+alsMr9wP0FRsphUmr/xo6ZhtN8WA+Jz9jx2z3pvc9wy9w11n5pGiYyQ3fIJapgPYM5nHa3ijl+AZPoaxZ4hWmja5nupK5iWxH7+HsIXUpDIdQa2lPv42xq5nuEyzYBASCydCY0L65hpc79WX+ItL+A/FNsxYRqSMshIsXY0nfmYl27wwihnGKe6KX0xpc2Y+yzK+f2gQRtimeBfI/QQJ82Ktx0u6o2sWMlTKkKSfzRiGZdYyxDktSPlAY1JM69Nhc+p/xKRqaWxZG+gDYs1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:03:44.5424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71ea2fc-4389-4887-2f16-08de5fef3c4e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4490
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8612-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:dkim,ti.com:email,ti.com:url,ti.com:mid,out_irq.np:url];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: D40C7B9D50
X-Rspamd-Action: no action

Update glue layer to support PKTDMA V2 for non DMAengine users.

The updates include
- Handling absence of TISCI
- Direct IRQs
- Autopair: Lack of PSIL pair.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-glue.c    | 91 ++++++++++++++++++++++----------
 drivers/dma/ti/k3-udma-private.c | 38 ++++++++++++-
 drivers/dma/ti/k3-udma.h         |  2 +
 3 files changed, 102 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index f87d244cc2d67..1e7b3225ef07f 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -244,6 +244,9 @@ static int k3_udma_glue_cfg_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 	const struct udma_tisci_rm *tisci_rm = tx_chn->common.tisci_rm;
 	struct ti_sci_msg_rm_udmap_tx_ch_cfg req;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	memset(&req, 0, sizeof(req));
 
 	req.valid_params = TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID |
@@ -502,21 +505,26 @@ int k3_udma_glue_enable_tx_chn(struct k3_udma_glue_tx_channel *tx_chn)
 {
 	int ret;
 
-	ret = xudma_navss_psil_pair(tx_chn->common.udmax,
-				    tx_chn->common.src_thread,
-				    tx_chn->common.dst_thread);
-	if (ret) {
-		dev_err(tx_chn->common.dev, "PSI-L request err %d\n", ret);
-		return ret;
-	}
+	if (tx_chn->common.udmax->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
+				    UDMA_CHAN_RT_CTL_AUTOPAIR | UDMA_CHAN_RT_CTL_EN);
+	} else {
+		ret = xudma_navss_psil_pair(tx_chn->common.udmax,
+					    tx_chn->common.src_thread,
+					    tx_chn->common.dst_thread);
+		if (ret) {
+			dev_err(tx_chn->common.dev, "PSI-L request err %d\n", ret);
+			return ret;
+		}
 
-	tx_chn->psil_paired = true;
+		tx_chn->psil_paired = true;
 
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
-			    UDMA_PEER_RT_EN_ENABLE);
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
+				    UDMA_PEER_RT_EN_ENABLE);
 
-	xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
-			    UDMA_CHAN_RT_CTL_EN);
+		xudma_tchanrt_write(tx_chn->udma_tchanx, UDMA_CHAN_RT_CTL_REG,
+				    UDMA_CHAN_RT_CTL_EN);
+	}
 
 	k3_udma_glue_dump_tx_rt_chn(tx_chn, "txchn en");
 	return 0;
@@ -682,7 +690,6 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_CHAN_TYPE_VALID |
 			   TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID;
 
-	req.nav_id = tisci_rm->tisci_dev_id;
 	req.index = rx_chn->udma_rchan_id;
 	req.rx_fetch_size = rx_chn->common.hdesc_size >> 2;
 	/*
@@ -702,11 +709,18 @@ static int k3_udma_glue_cfg_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	req.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_PKT_PBRR;
 	req.rx_atype = rx_chn->common.atype_asel;
 
+	if (!tisci_rm->tisci) {
+		// TODO: look at the chan settings
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CFG_REG,
+				    UDMA_CHAN_RT_CTL_TDOWN | UDMA_CHAN_RT_CTL_PAUSE);
+		return 0;
+	}
+
+	req.nav_id = tisci_rm->tisci_dev_id;
 	ret = tisci_rm->tisci_udmap_ops->rx_ch_cfg(tisci_rm->tisci, &req);
 	if (ret)
 		dev_err(rx_chn->common.dev, "rchan%d cfg failed %d\n",
-			rx_chn->udma_rchan_id, ret);
-
+				rx_chn->udma_rchan_id, ret);
 	return ret;
 }
 
@@ -755,8 +769,11 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 	}
 
 	if (xudma_is_pktdma(rx_chn->common.udmax)) {
-		rx_ringfdq_id = flow->udma_rflow_id +
+		if (tisci_rm->tisci)
+			rx_ringfdq_id = flow->udma_rflow_id +
 				xudma_get_rflow_ring_offset(rx_chn->common.udmax);
+		else
+			rx_ringfdq_id = flow->udma_rflow_id;
 		rx_ring_id = 0;
 	} else {
 		rx_ring_id = flow_cfg->ring_rxq_id;
@@ -803,6 +820,13 @@ static int k3_udma_glue_cfg_rx_flow(struct k3_udma_glue_rx_channel *rx_chn,
 		rx_ringfdq_id = k3_ringacc_get_ring_id(flow->ringrxfdq);
 	}
 
+	if (!tisci_rm->tisci) {
+		xudma_rflowrt_write(flow->udma_rflow, UDMA_RX_FLOWRT_RFA,
+				    UDMA_CHAN_RT_CTL_TDOWN | UDMA_CHAN_RT_CTL_PAUSE);
+		rx_chn->flows_ready++;
+		return 0;
+	}
+
 	memset(&req, 0, sizeof(req));
 
 	req.valid_params =
@@ -1307,6 +1331,9 @@ int k3_udma_glue_rx_flow_enable(struct k3_udma_glue_rx_channel *rx_chn,
 	if (!rx_chn->remote)
 		return -EINVAL;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	rx_ring_id = k3_ringacc_get_ring_id(flow->ringrx);
 	rx_ringfdq_id = k3_ringacc_get_ring_id(flow->ringrxfdq);
 
@@ -1348,6 +1375,9 @@ int k3_udma_glue_rx_flow_disable(struct k3_udma_glue_rx_channel *rx_chn,
 	if (!rx_chn->remote)
 		return -EINVAL;
 
+	if (!tisci_rm->tisci)
+		return 0;
+
 	memset(&req, 0, sizeof(req));
 	req.valid_params =
 			TI_SCI_MSG_VALUE_RM_UDMAP_FLOW_DEST_QNUM_VALID |
@@ -1383,21 +1413,26 @@ int k3_udma_glue_enable_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 	if (rx_chn->flows_ready < rx_chn->flow_num)
 		return -EINVAL;
 
-	ret = xudma_navss_psil_pair(rx_chn->common.udmax,
-				    rx_chn->common.src_thread,
-				    rx_chn->common.dst_thread);
-	if (ret) {
-		dev_err(rx_chn->common.dev, "PSI-L request err %d\n", ret);
-		return ret;
-	}
+	if (rx_chn->common.udmax->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
+				    UDMA_CHAN_RT_CTL_AUTOPAIR |  UDMA_CHAN_RT_CTL_EN);
+	} else {
+		ret = xudma_navss_psil_pair(rx_chn->common.udmax,
+					    rx_chn->common.src_thread,
+					    rx_chn->common.dst_thread);
+		if (ret) {
+			dev_err(rx_chn->common.dev, "PSI-L request err %d\n", ret);
+			return ret;
+		}
 
-	rx_chn->psil_paired = true;
+		rx_chn->psil_paired = true;
 
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
-			    UDMA_CHAN_RT_CTL_EN);
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_CTL_REG,
+				    UDMA_CHAN_RT_CTL_EN);
 
-	xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
-			    UDMA_PEER_RT_EN_ENABLE);
+		xudma_rchanrt_write(rx_chn->udma_rchanx, UDMA_CHAN_RT_PEER_RT_EN_REG,
+				    UDMA_PEER_RT_EN_ENABLE);
+	}
 
 	k3_udma_glue_dump_rx_rt_chn(rx_chn, "rxrt en");
 	return 0;
diff --git a/drivers/dma/ti/k3-udma-private.c b/drivers/dma/ti/k3-udma-private.c
index 44c097fff5ee6..0d07c1ea09586 100644
--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -3,6 +3,10 @@
  *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
  *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  */
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
@@ -165,15 +169,32 @@ void xudma_##res##rt_write(struct udma_##res *p, int reg, u32 val)	\
 EXPORT_SYMBOL(xudma_##res##rt_write)
 XUDMA_RT_IO_FUNCTIONS(tchan);
 XUDMA_RT_IO_FUNCTIONS(rchan);
+XUDMA_RT_IO_FUNCTIONS(rflow);
 
 int xudma_is_pktdma(struct udma_dev *ud)
 {
-	return ud->match_data->type == DMA_TYPE_PKTDMA;
+	return (ud->match_data->type == DMA_TYPE_PKTDMA ||
+		ud->match_data->type == DMA_TYPE_PKTDMA_V2);
 }
 EXPORT_SYMBOL(xudma_is_pktdma);
 
 int xudma_pktdma_tflow_get_irq(struct udma_dev *ud, int udma_tflow_id)
 {
+	if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		__be32 addr[2] = {0, 0};
+		struct of_phandle_args out_irq;
+		int ret;
+
+		out_irq.np = dev_of_node(ud->dev);
+		out_irq.args_count = 1;
+		out_irq.args[0] = udma_tflow_id;
+		ret = of_irq_parse_raw(addr, &out_irq);
+		if (ret)
+			return ret;
+
+		return irq_create_of_mapping(&out_irq);
+	}
+
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
 	return msi_get_virq(ud->dev, udma_tflow_id + oes->pktdma_tchan_flow);
@@ -182,6 +203,21 @@ EXPORT_SYMBOL(xudma_pktdma_tflow_get_irq);
 
 int xudma_pktdma_rflow_get_irq(struct udma_dev *ud, int udma_rflow_id)
 {
+	if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
+		__be32 addr[2] = {0, 0};
+		struct of_phandle_args out_irq;
+		int ret;
+
+		out_irq.np = dev_of_node(ud->dev);
+		out_irq.args_count = 1;
+		out_irq.args[0] = udma_rflow_id;
+		ret = of_irq_parse_raw(addr, &out_irq);
+		if (ret)
+			return ret;
+
+		return irq_create_of_mapping(&out_irq);
+	}
+
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
 	return msi_get_virq(ud->dev, udma_rflow_id + oes->pktdma_rchan_flow);
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index b91e645831f64..3ae2400e67990 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -739,6 +739,8 @@ u32 xudma_rchanrt_read(struct udma_rchan *rchan, int reg);
 void xudma_rchanrt_write(struct udma_rchan *rchan, int reg, u32 val);
 bool xudma_rflow_is_gp(struct udma_dev *ud, int id);
 int xudma_get_rflow_ring_offset(struct udma_dev *ud);
+u32 xudma_rflowrt_read(struct udma_rflow *rflow, int reg);
+void xudma_rflowrt_write(struct udma_rflow *rflow, int reg, u32 val);
 
 int xudma_is_pktdma(struct udma_dev *ud);
 
-- 
2.34.1


