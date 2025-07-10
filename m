Return-Path: <dmaengine+bounces-5753-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2DFAFFED0
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 12:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB96644DE4
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4C2D6618;
	Thu, 10 Jul 2025 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p0Mb+ztO"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33B2D6612;
	Thu, 10 Jul 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142357; cv=fail; b=RdxoGvqtNLfJhgGTzA554naib7Y7dwN9ypAmpY5ZZnkZAqLd7qKkYEKOUwdSoYYEbUb6pbosw5jeyuwfJ1tfgxL50Y3Q7jTaAdUW55X/1qj3Gpf3BH3dDK3CcCW7aOWX7iowuT4wcLWMNDLExFty4Ly98pTfblq0gCLd93oBG/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142357; c=relaxed/simple;
	bh=3as8W6Q9hKM+N6yoRG57dJsF7lU0G7sjSwPYZSIN+ZE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eajGTUGZ7qgSKyEvNZcYcscHXIGod66VLTd0y7i0/UQhAaD/CLAgSZvQHcHYrf5/J6E83v8MqCauV6oQARarNSjfzBil8EIsfxdTR2GoZsnwmGRfIeMquqhNldrQdDDAJtyfbDcZgGMEgM/4cqDh8KGF4z5wZ+dnXxpZkaqT4wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p0Mb+ztO; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q48ZQrZ4BCVXtEpCoZO8O2e1yZ013gAjKcL+0ZfZZP2lDeYIDhXUM1JunM4DjLfztHVT9dYV2IahqCw0RwuuJwIC+KUXKYEWIZDh4mGBAfwsAB5ZpmiwuogJrKO+CGmEUjluEihRA1PQXjHr4P/wsoiHtH4SA1PlxsBoo9zgrdh1qSV6EwqtsUcioUSvYBonE+f+XmkAsFmCt8Rw9Zw/4a0LKxLUEQuSth+mjYlkmT31MziF0EPIlHm5aO1lE3VBD1v3VKcr+Pyrzxo2mwLz+grQUauw9OJAnukbxIeHWAmxLX6ZWgV6b3ahc/jjimQpPRsZBIeYZqOMqL5uMcEfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkSAFx3ZvLpceW0cZFgVx3mLSASxC60pjiNxF8y1y/c=;
 b=Msx16EmThzoMESqVSysLj+61u7J37iWnpTwA65Q4CcTWaS4dn5SnbnDtR51YKKm3SrxRePETeOFrhs3QgosacmXNvA5pCc1xG4NQnDNjsUFKhfykMXPD6PyRhbZAAvDSayQ/LJdVlO4nA/Zl4z+5s6TgGIJfx0cw9yr5ls6jFfyhZV7DGuahNR98DhgF7YtNlnaDBUulqqAzA/n11r4ufQrbA6Jb640SvT2qJTr0pIXdPIDVFfqCYd5+PNGNO3RsagMwiGNL7gho6701rnGSEeU/wQub5GYypR0quFv23+CIZjoVyzasQdp1eX/CkXZlxvEg0r1u7CKxMDKdJVWf5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkSAFx3ZvLpceW0cZFgVx3mLSASxC60pjiNxF8y1y/c=;
 b=p0Mb+ztOzSB2wrtkjAkcAfDwGs5R+etY+RPpLwKAQW77JxOsUdogtvopbOBXW19G+/3ExiKu4FoE2tJzdI7ljWvjsndRLzQGfOD/ds82VxQaaoEd/DZuLzCfc0ROdXeoixMbc5E1Fb5iOcQ6v4lBLsTWfj7vsyp9V1KgxSGVsEE=
Received: from DS7PR03CA0338.namprd03.prod.outlook.com (2603:10b6:8:55::31) by
 DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 10 Jul 2025 10:12:34 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::1c) by DS7PR03CA0338.outlook.office365.com
 (2603:10b6:8:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Thu,
 10 Jul 2025 10:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 10:12:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 05:12:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 05:12:32 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 05:12:30 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <vkoul@kernel.org>,
	<radhey.shyam.pandey@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<harini.katakam@amd.com>
Subject: [PATCH V2 0/4] Add ethtool support to configure irq coalescing count and delay
Date: Thu, 10 Jul 2025 15:42:25 +0530
Message-ID: <20250710101229.804183-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a6a05c-7ea0-4bce-9950-08ddbf9a4997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03G77YZ2YxmcsM16Auzt0uvlf7dtKAPETATsSFrYclDDQL1QEyqbQp6OubEj?=
 =?us-ascii?Q?bRmOfjwQPYqyr4MPXgjfL5efBUdYXpk6FtcmiX4FwmkfToQzwRXHikXDnu82?=
 =?us-ascii?Q?P875gQAPjqEhLCwGdYfOpd+vFo9AUAjcWjQe03J4N1IWnlHrzBp6vA5y4I32?=
 =?us-ascii?Q?/aW59Y8hRF6bpn9rU5+kSGuc/BFnymofCMnX+0CauWDTA2APZRpTbiDPWEkS?=
 =?us-ascii?Q?OMWbVmGh2C5+2r3mJFjUCMriBMO5qpQ2P0HC5EQt2quMjFg4QeVQbLifsRDo?=
 =?us-ascii?Q?QKsOCB/QAmX0iVQRHsWZhL30h5A16ki8oLbReq1GZCH7jev8VZCpqe3aVPLn?=
 =?us-ascii?Q?E2/Nz1oi2ujZC8/ZSIhYwFTsb9WlEkX2rfeT/zaMU0pNohFfAnUslVGdoAmh?=
 =?us-ascii?Q?8TnU5hWiqXsUd6z84wbn20Q77bEG9Oo57TPHhg7rMfusIJZtEIkfGJeublyV?=
 =?us-ascii?Q?fdb/yJ9rdtNI7XQjEkguI5Pp++1yIviVOW7uYdXO3iBY2TtFFxFBLgDUFxwW?=
 =?us-ascii?Q?domuyBiq+pDFtsUq4xsWUPn/VsCc63pyhkxSwXyPMyyX9DLGVBrdePE0J+Xf?=
 =?us-ascii?Q?Nq29wr4+evNQwcNS/o7z6piUOuBbGCap+Aid7h+Y9cK1FRg4Sog3b7ZNVCbu?=
 =?us-ascii?Q?Uh0qXdrsMwXmzj0Ik73AlZlkLaQKl5+UcW2XjzMGTExi9vlpY18pCQ9pwKnT?=
 =?us-ascii?Q?xVS/28ECS0cvOdBHM6eMfVR8O9sm5EHAY1fruCiicIiGDFczZVJpLiiQU7uA?=
 =?us-ascii?Q?Zzvbcq0yaIqH9qMZUh5WHyLiCy49jAFX87MU/NoJUmcyEU2bdep7xWW3AxSw?=
 =?us-ascii?Q?Mh9Ii29Jmmkj346VK0GbrDaMNEL8rK9/T/nZC0XfNz2MYadSvIq7xkl4euDu?=
 =?us-ascii?Q?1PZA+KTW9BnOvDm2lwYKYfzH5tjYhLTzFSDGhZLzhdtvNlCIW077fX59SwuC?=
 =?us-ascii?Q?woleYcsT6K3tl9J4MO1WAxmUMxLEW9qUSwG9THorczB5PfbygQb5qBASrONZ?=
 =?us-ascii?Q?svAtDMOU1p42NY5/SB1wR6KPTAFPPKTAvzg0T1MKLQP7Oi/m6+A8M9UCIoSp?=
 =?us-ascii?Q?z3Sx/mH6XUSZWEYqEpVOg66HFRnAFlxTeVyTaNzcY6uJCEfFHR4aZpOFPU46?=
 =?us-ascii?Q?HOF3Qe/S+pGcMVnPhmDQ/XAKKnmOAQtFRntKBuwFBvn8G1WXih/fvVFPOzoF?=
 =?us-ascii?Q?4ECTsLK1W1F3TG2Q5b9uqZ/7d4uPM7w6Uz76wJr9PlxXecM6z7ZPZ04tpctv?=
 =?us-ascii?Q?LIGtTeVNU8XWBy8q91Ke+2NJSQe8gIml/esxB1Olpatr+NXk5HqzQsAq37yS?=
 =?us-ascii?Q?rAuLdJJjrdyzqcvAyPrmywWipklXyns3+hXxqm792G41CPbnlxUpG7qBRr3F?=
 =?us-ascii?Q?lElpWjnIaCR+GdBzLLpleoSImM3+Xo3TcoFSo6DpLS+YjxRN2NzxXzTQF7H2?=
 =?us-ascii?Q?jtfJBmcUzQ3IZNt9Nm7cQXq4dgqOPaE3lb3C72/rokVMvTtqghS0dG55iwYt?=
 =?us-ascii?Q?55COzGNLrxHEJZRF9BiDADoYO3uNivG75MIn4PAIS/g042RXMhsegBLmpA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 10:12:33.6274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a6a05c-7ea0-4bce-9950-08ddbf9a4997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

AXI ethernet driver uses AXI DMA dmaengine driver. Add support to
configure / report coalesce parameters dynamically during runtime
via ethtool. Add support in DMAengine driver to communicate coalesce
parameters between client and DMA driver. Add support for Tx and Rx
adaptive irq coalescing with DIM in AXI ethernet driver.

Changes in V2:
- Add DIM in AXI ethernet driver.
- Fix following LKP warning in V1:
 https://lore.kernel.org/all/202505252153.Nm1BzFUq-lkp@intel.com/
- Consolidate separate Dmaengine and netdev series in V1.

V1 axienet and dmaengine series:
https://lore.kernel.org/all/20250525101617.1168991-1-suraj.gupta2@amd.com/
https://lore.kernel.org/all/20250525102217.1181104-1-suraj.gupta2@amd.com/

Suraj Gupta (4):
  dmaengine: Add support to configure and read IRQ coalescing parameters
  dmaengine: xilinx_dma: Fix irq handler and start transfer path for AXI
    DMA
  dmaengine: xilinx_dma: Add support to configure/report coalesce
    parameters from/to client using AXI DMA
  net: xilinx: axienet: Add ethtool support to configure/report irq
    coalescing parameters in DMAengine flow

 drivers/dma/xilinx/xilinx_dma.c               |  93 +++++++--
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  13 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 190 +++++++++++++++++-
 include/linux/dmaengine.h                     |  10 +
 4 files changed, 276 insertions(+), 30 deletions(-)

-- 
2.25.1


