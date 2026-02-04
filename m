Return-Path: <dmaengine+bounces-8710-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJXKNU4kg2nWhwMAu9opvQ
	(envelope-from <dmaengine+bounces-8710-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 11:49:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53B8E4C3D
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 11:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77526300E721
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FE63D3CE4;
	Wed,  4 Feb 2026 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NKekl8n9"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010017.outbound.protection.outlook.com [52.101.193.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481938F255;
	Wed,  4 Feb 2026 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770202185; cv=fail; b=nMuzJKV7gMnqgSzVGqlOno2/7HgQO1cVefQCYbfwm1U0Xuy2NaAKvn1Cbn/MrOLmCaYOCbHXESS/0GSiOFEEQsdPPELK+jb3LGeBD5ncqTjXvk9ezflef+awY2RP9ahh2d6YuYANiYMRZ4mC1HN7wLHMo74IUgpGk/XBcoA/zJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770202185; c=relaxed/simple;
	bh=Z7Uicl9V30UGzEqdRsf758amgl1VB2li6MAWs8IUjfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TPC1IgSSX12l14tWNH1ODu447FnUHT3oexz++7A/4rQQsK3VcgYSV4vtEI2CTb91CmpscBP/cJgj/5+y7sEt3JaFT+pPpalwP8Yg2oZxR0cWlkENtboXJbf6h6lB2oaRNUmIiUIK5VBYLNd5fn01yLSuH47VH9BnJutrVNFpfBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NKekl8n9; arc=fail smtp.client-ip=52.101.193.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIgoHNdMteLFJQxCVe0AnwYxyk/iqgks2JaWa6BAOnimr3ZUsvmM9RzxGo7RGAVWMdCQ6eGfIktwH8SusOe7Zd0AaZX4g83qodyNinleOtoik0x28tPM2yhy7TwdBl+qPEr3KRQj5XhNnyidWAoNDTjQGqOYxFSCTzvOTRUsnti7TpQVH7RX+zEBjQ7PbWnlifCg6ctqpYWKCg/AI9XpNEDKrTrM0iho/LC9E8QJ655GJjkt8HLe3u1MnI72dohhSlNNnYFz1ZkEpIvjwg3nvzja3dSgEy6qAtXqk8idjTdtK0WquEoqiouvzvi0kW706TaJae850GHwzW9WQ/rn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h7hhDHPEmy+A9N1DoRQUHnH9U1oD1eXKY8/AAMjJ3s=;
 b=FIzHTIgRFVM6umwD+6B4vxSpsy6dq+H/QWDZv5Od5P47Kqt6eXxshsjx0ih9Yi6/ii/uOIzn2nmL8hO0v39zGxZk3G5pld8JuvRF+S2avyN+OK9AY2F9x6HdYTA+U51gH5yEjw0s2LyOOQn4SbHRlm72QjXKY5luV3TEpsUMudFCOJjChcc2W6U0Uldtz1fViESZ0CpQdTjSQyuC74FmZ2U6JMdcrByUu6Pvszs+hJRB+A3FP5WfUyBCe5jN45HW4hDodJ1pvq8WwmOr7/ZhT5+1Qmr8WNx+Ng55C/TKIwrmmlVOx5TUfzwFXdKhtRpRphH8/RgqyB5nzZt8gQmhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h7hhDHPEmy+A9N1DoRQUHnH9U1oD1eXKY8/AAMjJ3s=;
 b=NKekl8n9yFpaSHbYs6DBb6Zdg7J+/4KR+4NlHE8H1rZL5DIn3v8/E/IFphwdNpOQEEHtxuaMNJ1pFW7QzKbHWq5J0bVv+IJcvCd//B7hIFl9n85b5sI7r32qX9w1QwE44XzMYaTQQ9CCnZg/QJs7BYR9BR6NNIWVVSc2TLbtB8M=
Received: from MW4PR03CA0016.namprd03.prod.outlook.com (2603:10b6:303:8f::21)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 10:49:42 +0000
Received: from CO1PEPF00012E80.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::5a) by MW4PR03CA0016.outlook.office365.com
 (2603:10b6:303:8f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 10:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E80.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 10:49:41 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 04:49:41 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Feb 2026 02:49:39 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v10 0/2] Add AMD MDB Endpoint and non-LL mode Support
Date: Wed, 4 Feb 2026 16:19:31 +0530
Message-ID: <20260204104933.33179-1-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E80:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c888f6f-78a7-40b0-20cb-08de63db1a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N46w5+xl1D/RQ19fffNmnEXIPrux9yzebAY20ylQcUOE/eeYWkZmpRhT3mrA?=
 =?us-ascii?Q?kErFJKCY3nyzf939WaJii+Xz2APzN1uZcPpnRtc4XdxJeBz6D6uzff4dsmf7?=
 =?us-ascii?Q?LjQKQfQcz+BUJrfbVIP0WggYNX7pKP/ejz1GSski8e3JjVnpnGUwER7Z2H/5?=
 =?us-ascii?Q?iiwrjWmzdUReJjHLyW94T+K+FCnkJDRx9E7kC8YOky/eW3aZL3uYNBcijROS?=
 =?us-ascii?Q?k2I86fF/h9u84JQMv4KqYH4NiKYGAHilVoUWSPr0+IVo5C2BaPI/O7xNiR4+?=
 =?us-ascii?Q?WEjwxAs4UFqWAOxlh6je8yF4Gf39OhFHTw2E8oD9KIv5GPo7tXRBI2EFXifl?=
 =?us-ascii?Q?FSIitnyONlrw8khg8b/A7jbohFwzgzXEpgKbzXCbZSbbSPpvMDC1ALAre6Ew?=
 =?us-ascii?Q?UaVBT2iMoGqt/pOgBxTsoxPXYcNvCnSGHO4M5n4zv3oDKG5twV8QyI5RhnsE?=
 =?us-ascii?Q?PCN5zkdAzr8dgRQ+aSq+3Ll87UHrLLfHxulWrP1gRoRFAeGm9+PCvC0rzUMn?=
 =?us-ascii?Q?Q4l0PcE+zeqJeobg5rd6uWuf53+Ii5OZpjr9wN/8nn5K/CLh+I2ujAoYxkgq?=
 =?us-ascii?Q?tuJFYZWPAhxpGpClVqSxfPZI6gnWqophur1d0G3I1gJoXXvhTlupaGKmXdBJ?=
 =?us-ascii?Q?NECgTIscw0+6iyWayomnhmADNYhCE1Sl2/i6L+0bHYjv0UMVgP8stzeO/nx0?=
 =?us-ascii?Q?R7yZEozBVwrccd1EGDWJ0lwRi0hwaOB2Ih7ycsQ6gMMLJiKEwMOeUa0QMzT6?=
 =?us-ascii?Q?Zw6MCamQuZKKsN1mkzoOB6wN8NIUPpwK/UU34C029pc5WJEkgD/LGWVN+WzC?=
 =?us-ascii?Q?ZtqFU5wHLeGgRih+ikjT/T0OcyLwkxn6eT0v4zk8CxKifpVhQDAjdNfHj9Yw?=
 =?us-ascii?Q?Rua+cGrwc8U1S0S2+0UvK3/42BWEYAAxU0KFBmx1UF14ozsk3Dae0AGPplpd?=
 =?us-ascii?Q?gmn8vR39T1yODpHH/j7jeyMSuNkkzh/isVbUWHDMmAsmNP+9p7vSE/wUOrgU?=
 =?us-ascii?Q?/Hnieuu2KRjvrFqTaYlq9p7IIiFnB0O9AdeRA1fanKlilKVuJfmwBuKcD0Ct?=
 =?us-ascii?Q?O3Mh17wS+Y5s84jGdmDCOEU+r5oxIdUvHhX5UxMAiVb8GAJVuLp0Z9opakHP?=
 =?us-ascii?Q?/pO6Cr/fAVCzI5b2C8BPhQf/KtYN0r/HEGshfaehe8jhEv1/hKYUfX2mJtku?=
 =?us-ascii?Q?1eiiiGG/9DS0cEhWiMu7SKqi3XEqA6SGxNFMV90+EgU7Luex3OmhaqdJ8OTr?=
 =?us-ascii?Q?mNDW04i5tKsvQfuMDs0okBhDz38G3YZqfxAnedcyOpusevYalWKHx/drPo+V?=
 =?us-ascii?Q?tqt3ZISmYWj11dEWaOXp3KKVWLnF3XmDVdPe4/+8rrfvYLC4MfmuoxMafI6P?=
 =?us-ascii?Q?0lPCMb0IjB7dMhY420ruz4Csu4vO7wvntVq/EWTBtx6x/0c9m72c+wH2oJL8?=
 =?us-ascii?Q?gBYAamW3EbDoqVW41RxAJptB5j7gwIxw7/XUzgRT2y9QCA1vez6k6/dB+OPl?=
 =?us-ascii?Q?SGECanyIKZnaO27LdblxNdBtQFtPjZJpP8sc+xPYmY6HI+D9QPwKh6dUCTYG?=
 =?us-ascii?Q?udHhXPRXaFvGnOsolt0o+4eAvBlp/dFPUO/p/aXJfmSnipQGTAKqzq+8utYW?=
 =?us-ascii?Q?y3KrjHsUmGshcis9WMwRgbgtXv39oVxoF9Ak886V/SqHtlly4tytBpf82jNr?=
 =?us-ascii?Q?L2R0yQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WnavjLcwBw2G0RvQfPlIHcRuwRdmi8A+6utR6/R/d+vdbWe/3ThQnZ2mZd/hjIZ+wStihBa2RtwMo6Z6YMZnT0QN6QYX+KYR3Hzhytn6Y4cG35Udpkx9ETY2/M7BkiDE/E6SQHCu4OBW2XTWb5TjOks8aWZBW8Z1MaOdKY6ObUrhR66o02S939yD+1Z7lu0qMtGFOGwEdFXb3IQstqZ9oY0qz4K45bb88pcUSLAjTUjU2jw9PCwtkmIxZauQHpFdLu7VSnHExpaPvaEo/aJSv1/JKFJUnQNoxpFm09TGAWNa/mKyxEHkhuKBE9rtRgaHfCXYm7NSoXu8H+CrIrMtSXLvvMASvRUB65D5f1ubPNXPbZvL5wSENXtIGBLGc0A7d10xeJi7CER+54Hr917L03idbDiFqrK7NKou4JgRtxlxFLEXF71ZS0FDgqkhMnOP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:49:41.9311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c888f6f-78a7-40b0-20cb-08de63db1a24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E80.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-8710-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B53B8E4C3D
X-Rspamd-Action: no action

This series of patch support the following:

 - AMD MDB Endpoint Support, as part of this patch following are
   added:
   o AMD supported device ID and vendor ID (Xilinx)
   o AMD MDB specific driver data
   o AMD specific VSEC capabilities to retrieve the base of
     phys address of MDB side DDR
   o Logic to assign the offsets to LL and data blocks if
     more number of channels are enabled than configured
     in the given pci_data struct.

 - Addition of non-LL mode
   o The IP supported non-LL mode functions
   o Flexibility to choose non-LL mode via dma_slave_config
     param peripheral_config, by the client for all the vendors
     using HDMA IP.
   o Allow IP utilization if LL mode is not available

Devendra K Verma (2):
  dmaengine: dw-edma: Add AMD MDB Endpoint Support
  dmaengine: dw-edma: Add non-LL mode

 drivers/dma/dw-edma/dw-edma-core.c    |  35 +++-
 drivers/dma/dw-edma/dw-edma-core.h    |   1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 220 +++++++++++++++++++++++---
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  65 +++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |   1 +
 include/linux/dma/edma.h              |   1 +
 6 files changed, 301 insertions(+), 22 deletions(-)

-- 
2.43.0


