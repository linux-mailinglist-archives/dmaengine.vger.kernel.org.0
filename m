Return-Path: <dmaengine+bounces-8594-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNRhDH+QfGkQNwIAu9opvQ
	(envelope-from <dmaengine+bounces-8594-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:05:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDFBB9C1E
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 12:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E860D301F308
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4170A378829;
	Fri, 30 Jan 2026 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W//95De6"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C55A28C2BF;
	Fri, 30 Jan 2026 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770949; cv=fail; b=nh11TlA9AMKA75CpSXgyMvVWOBywMnS5bcqBIgZeyFoOmnR0haF32683u27bInKSTjUcz4olQNE88pW1zJhp8X1VQOiigwRX+Y/AGpdKtxpzbkGx4RwXDOJSRxTYmOcYr5ryDIxG7HKKDvpBp0R329tqgZANLbUVZTazWGIXGvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770949; c=relaxed/simple;
	bh=ZUCvELV/wNL3XXuna31P8Q+rb5YgWGplWDe88rYJZr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKDsfd5GuAU+dVPEOWICklRxbDe/cs5CXumCOkhhUEiVsfdy1xQCLhTH42gXYyyM+q3hHPfCUnop/ca6e2tXO3Rl/4840Sh4cJcbXU0WPVuOeNFIK0W92WQeaFkBwfIuxyeuBKwkWmxCxx5ooqpXgbR+xFAN1QErpdyD1ctNEtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W//95De6; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P54izOkfa9fqZPzAI+OV5Tumvmekg3EBWsPcadzZZ30d23dI4ChMLtyoeoK94ViAacqcTqdPQwRTHC572y7Ic+tXHmuHKxwnPKPGwM4hWpYdOtOngrPl2a0HSYqnhWsUVY50AEs9HskS1/resOdUxLWoAjdcgfitPX3VlEydvU0WWAxH/ohqO4f4I6hhdIRofMLom0owE7B9CUiNc4fBsIpjbkBi0t3sQi5paI8Q5q7OjoGX42+tAICQHYyfoc5HHqQPfnEtGNoUvQnOBkRyW+F1gn/PppmOAsXtdaKvUQRrYTbB1RaZdcwhiEV+6rcST/qtQAY90U/iFyglWOZrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS2VuhaGkJ44LEE2DPjToA/T9BjsUReY2WTeDZbcbR4=;
 b=eZU0r0PCQkNfO8iCZNnLdsrz32G0Kb5AJ6ma2PcdMAcwPMfWJNhptxVsCgRqlgO4nVx9PNeJMDi+GU51KGlj+lzQGczt01IJYxEkztWim7ssitqhHJ4zKogz3DUai/6BuqoKZnwTRhFmu2hEcMvEm/IyauftAhvllbqpu5+QpyFbR3JlvmbH336d2ZDJ99RHA+z3HQj0J2b85+hnMKysVWGyOVmDJ/uyRf+dShVvqeu/hNPV8RI17cfd95Vl+a2cq7w2Odgq0ZzmL/YA5sxXip9VNzUqyhjw8CKnyFZSYMBX80vxX9BkuM+9xrVQaJt7RZvpmJa0BaXfj+/gcs4qSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS2VuhaGkJ44LEE2DPjToA/T9BjsUReY2WTeDZbcbR4=;
 b=W//95De6rR+71INP2CZcvLJnsBpUY647tYeKlAUbk7yUBzALvMZMKajufH8hgWmdMKvl0w2sWU0Aof7UXkOd+7+PUX5weWOgwbPqIe6adLEgmmNuLGggGOYD9JdyqdOvHzNfUgkF0iLFWQHyHOPo5FLyemwWgch1P2B3LKYK3Io=
Received: from PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::35)
 by DM6PR10MB4234.namprd10.prod.outlook.com (2603:10b6:5:21f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Fri, 30 Jan
 2026 11:02:24 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::91) by PH7P220CA0135.outlook.office365.com
 (2603:10b6:510:327::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.13 via Frontend Transport; Fri,
 30 Jan 2026 11:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:02:23 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:22 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 05:02:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 05:02:22 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UB2HBd1204392;
	Fri, 30 Jan 2026 05:02:18 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nm@ti.com>,
	<ssantosh@kernel.org>, <dmaengine@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>, <s-adivi@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
Subject: [PATCH v4 00/19] dmaengine: ti: Add support for BCDMA v2 and PKTDMA v2
Date: Fri, 30 Jan 2026 16:31:40 +0530
Message-ID: <20260130110159.359501-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DM6PR10MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6f5870-52ea-49e9-b826-08de5fef0c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TnQmLa+sEqqZJ7G6l95ZgxfXP7MAVk6gYT9QmTotrTMt9mQ0/frEihlVKKRv?=
 =?us-ascii?Q?+b5UNLiMIxtzC49MmUz0iDYyLVqWDD+hw/16Jdbl2b3EK3d+9UVIgoG09Dvw?=
 =?us-ascii?Q?DoH4VFYls88N8ZLFey3/UvpVW2SMlBy0TnortRmUzjFA8rmEekvQbNUqN/t1?=
 =?us-ascii?Q?amwpQYVlE/cPl+kDUHK93ItD9wWdKvwEX7HSi26J1pNmeoiHdChYxg22yH1G?=
 =?us-ascii?Q?/ac0Y9he20qaWM3aVx7KjKYNLuxz123e46WdsqPGlSxypSTAnE3UPMTjqwHR?=
 =?us-ascii?Q?Sdn6Sm9jAes+QPEr4xbIhK42/iSRIPWNnH3kTQ3oNoa3OWffYPZ5WqfkInt1?=
 =?us-ascii?Q?l/CA1diukLo1kCoOJSkfJEIyt45MVk2ch/A3UfV1T5s2Hh9A6lP5xANSW8KW?=
 =?us-ascii?Q?FvBNPqNvVpNzzMppAjiP7xYLtFGwu58WGUaEMFHwaZfySGjAmGMkWNp/HXyi?=
 =?us-ascii?Q?rGsbSAMjyLmPh769B2llhgkoGAMh3cjuFf4eLMhTQuNfo34nHRkn1CZ3kIxe?=
 =?us-ascii?Q?bNRxUwUu2sY5lvuf1jzJScIzEh3wOiTGEfVSLbkbZ6F4jqMEbt+RzV3MVBx+?=
 =?us-ascii?Q?kfUBkmz/JWlxLQ+hCBPNk7Q/bmO/JnzgV2oBEPCgPDXoacawpmUoTdGZ1DZQ?=
 =?us-ascii?Q?FcpnCqY8HU2F0O2WApitUFYh7+HjVZ6mUro5cE/7II1F5y1+achlgJtvgUEn?=
 =?us-ascii?Q?Wsd8ff5fwNnVt6PRiVeVe+9vLT/CK/YuQ6VhZunBEi6o/wrI2BULVEl6hb3R?=
 =?us-ascii?Q?WWb238pV6CW2dS/QuwA4ujl167e2JGX6eZJ79CGtvd8ok0zcNIPHTXKb/2wr?=
 =?us-ascii?Q?FcNKcjo9G/igwzuVsdzjvBLL+SeclrgCUcj1u4O6kVRSsrTCEIx69Ob40Z+Q?=
 =?us-ascii?Q?3jThVrt/3VYPYHktAoO0czuoM7jGI0CNh0I2Gm/DkCk7p50P9bVrO/7zRCIO?=
 =?us-ascii?Q?MGXeq2wJ0cYQVbmJYVy1TopabTJRHnXQOaWjYFdeePQDJJQz/NUlj6Za0con?=
 =?us-ascii?Q?NtC9w3kTPmDdbyxc90N00FBOMyv70nW2h1vB44E/lUSKzrAmMdsqU00WYqP3?=
 =?us-ascii?Q?cFgmJWCDGp9ByQeVJT+uOeNm307NEQyiJ+MUnDxrw4ZiIxyzjdY/urv0DobO?=
 =?us-ascii?Q?jiinZgu7IYC7y8z33wzkA3d4EAnd3oMtm1L60SlyDtHt+gp7GmTlnMhgPNlJ?=
 =?us-ascii?Q?zucQ1XRrIxQmmWSJaa8yPn1OVHs1QcpkJz+SAQiLQStMF64ySNSIuljmYbg9?=
 =?us-ascii?Q?cAQZS5wZOojgY/iionbsiyIEvXL8WcZMcjydOvMj81rSzzkdu1UhlO2c/OMl?=
 =?us-ascii?Q?IZpplPUpjt1hOBM4k+zey41cEgFW97i6/QtLZasBnva1v7e50p0X4dsyKp1Q?=
 =?us-ascii?Q?YsVecBskNabzZ/N380QuC44RBXcj1K9pAqWGliiAn2zURcbdR7kGdqJMEz2a?=
 =?us-ascii?Q?a6+rp/3lWWZi0xAIOG/e9WUyT/wBBkkYDhD7C6dieer2rPb/XrPfrOqVvqMw?=
 =?us-ascii?Q?XRSy5KYF51saX4lcDAsbW8gas9y7kwNp9jw0Z5RjGEgIUkZSWhD+sOGcvMFQ?=
 =?us-ascii?Q?hWYpLGCa+zTTgj4/ScKxJJzOOxu9HeoXTjz/4odfbjIWlC+m2D1anxWOtMj1?=
 =?us-ascii?Q?zJ1g59EgUqJ1x/z14bweQ70dXy7bPyArmvN7FePXLOXLL2JRfJJz/uFLH4E1?=
 =?us-ascii?Q?/+D5DSt3IwMRYHs7cQ175boCEGE=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/LRyfkXQfs/9mZ9bmzOSg9UAc8aBoNWddbuKrqk26d7js6XRYz6i4ZBxRipKrsHMM6y2Ygx4Jevk1mXUEHokjjxHXjm2eZbO0gbr7hIdxRC3TFjlDVC+a3tfKNOdR7R9J+Eoyxvzvaj9SLtMDDX5/1GaOWze8QrEmacnE4URJtEwOnjciAkIobvLxLmLqIDQqMMDsibhmrdiiu1pVb5CZIycrdQK5pNSJn0cxvuej4DOb3U2bffkthglJ+NYSJE6pH4v8TGp3TTP66ht9paOglJAE+ZLX9g6OEA9AKPRRyDVU6GqThtiJ2Fbsxs2YlG7fzWMPLbSMxZBT1ip3ea+UKCW+A4LRtqQDcwQz9I3EcZmpugaIWHmS9Ms4Y1volhbRQaY6QgNoa0Pp3E0cKrujdOfim0nXCzaaT0/GvNbbfXptjsmxbzlAlrDydqP5qWp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:02:23.8577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6f5870-52ea-49e9-b826-08de5fef0c2b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4234
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8594-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8BDFBB9C1E
X-Rspamd-Action: no action

This series adds support for the BCDMA_V2 and PKTDMA_V2 which is
introduced in AM62L.

The key differences between the existing DMA and DMA V2 are:
- Absence of TISCI: Instead of configuring via TISCI calls, direct
  register writes are required.
- Autopair: There is no longer a need for PSIL pair and instead AUTOPAIR
  bit needs to set in the RT_CTL register.
- Static channel mapping: Each channel is mapped to a single peripheral.
- Direct IRQs: There is no INT-A and interrupt lines from DMA are
  directly connected to GIC.
- Remote side configuration handled by DMA. So no need to write to PEER
  registers to START / STOP / PAUSE / TEARDOWN.

Changes from v3 to v4:
- Rename the dt-binding files to add "ti," prefix.
- Update cell description in dt-bindings and add client examples.
- Update k3_ring_intr_regs reg names
- Rename soc specific data to bcdma_v2_data and pktdma_v2_data to
  bcdma_v2_am62l_data and pktdma_v2_am62l_data.
- Add a new patch [18/19] to fix a null pointer dereference issue when
  trying to reserve a channel id that is out of bounds in
  udma_reserve_##res macro. Also fix logging issues in this macro.
- Add a new patch [19/19] to switch to synchronous descriptor freeing to
  avoid running out of memory during stress tests.
- Fix checkpatch warnings.
link to v3:
https://lore.kernel.org/linux-arm-kernel/20250623053716.1493974-1-s-adivi@ti.com

Changes from v2 to v3:
- Fix checkpatch errors & spellings.
link to v2:
https://lore.kernel.org/linux-arm-kernel/20250612071521.3116831-1-s-adivi@ti.com

Changes from v1 to v2:
- Split refactoring of k3-udma driver into multiple commits
- Fix bcdma v2 and pktdma v2 dt-binding examples
- Fix compatibles in k3-udma-v2.c
- move udma_is_desc_really_done to k3-udma-common.c as the difference
  between k3-udma and k3-udma-v2 implementation is minor.
- remove udma_ prefix to function pointers in udma_dev
- reorder the commits to first refactor the existing code completely and
  then introduce k3-udma-v2 related commits.
- remove redundant includes in k3-udma-common.c
- remove ti_sci_ dependency for k3_ringacc in Kconfig
- refactor setup_resources functions to remove ti_sci_ code from common
  logic.
link to v1:
https://lore.kernel.org/linux-arm-kernel/20250428072032.946008-1-s-adivi@ti.com

Sai Sree Kartheek Adivi (19):
  dmaengine: ti: k3-udma: move macros to header file
  dmaengine: ti: k3-udma: move structs and enums to header file
  dmaengine: ti: k3-udma: move static inline helper functions to header
    file
  dmaengine: ti: k3-udma: move descriptor management to k3-udma-common.c
  dmaengine: ti: k3-udma: move ring management functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: Add variant-specific function pointers to
    udma_dev
  dmaengine: ti: k3-udma: move udma utility functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: move resource management functions to
    k3-udma-common.c
  dmaengine: ti: k3-udma: refactor resource setup functions
  dmaengine: ti: k3-udma: move inclusion of k3-udma-private.c to
    k3-udma-common.c
  drivers: soc: ti: k3-ringacc: handle absence of tisci
  dt-bindings: dma: ti: Add K3 BCDMA V2
  dt-bindings: dma: ti: Add K3 PKTDMA V2
  dmaengine: ti: k3-psil-am62l: Add AM62Lx PSIL and PDMA data
  dmaengine: ti: k3-udma-v2: New driver for K3 BCDMA_V2
  dmaengine: ti: k3-udma-v2: Add support for PKTDMA V2
  dmaengine: ti: k3-udma-v2: Update glue layer to support PKTDMA V2
  dmaengine: ti: k3-udma: Validate resource ID and fix logging in
    reservation
  dmaengine: ti: k3-udma: switch to synchronous descriptor freeing

 .../bindings/dma/ti/ti,k3-bcdma-v2.yaml       |  116 +
 .../bindings/dma/ti/ti,k3-pktdma-v2.yaml      |   90 +
 drivers/dma/ti/Kconfig                        |   21 +-
 drivers/dma/ti/Makefile                       |    5 +-
 drivers/dma/ti/k3-psil-am62l.c                |  132 +
 drivers/dma/ti/k3-psil-priv.h                 |    1 +
 drivers/dma/ti/k3-psil.c                      |    1 +
 drivers/dma/ti/k3-udma-common.c               | 2577 ++++++++++++++
 drivers/dma/ti/k3-udma-glue.c                 |   91 +-
 drivers/dma/ti/k3-udma-private.c              |   48 +-
 drivers/dma/ti/k3-udma-v2.c                   | 1472 ++++++++
 drivers/dma/ti/k3-udma.c                      | 3095 +----------------
 drivers/dma/ti/k3-udma.h                      |  583 ++++
 drivers/soc/ti/Kconfig                        |    1 -
 drivers/soc/ti/k3-ringacc.c                   |  188 +-
 include/linux/soc/ti/k3-ringacc.h             |   20 +
 16 files changed, 5402 insertions(+), 3039 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,k3-bcdma-v2.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,k3-pktdma-v2.yaml
 create mode 100644 drivers/dma/ti/k3-psil-am62l.c
 create mode 100644 drivers/dma/ti/k3-udma-common.c
 create mode 100644 drivers/dma/ti/k3-udma-v2.c

-- 
2.34.1


