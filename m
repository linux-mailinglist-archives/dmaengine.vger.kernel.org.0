Return-Path: <dmaengine+bounces-6754-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D9ABB5F98
	for <lists+dmaengine@lfdr.de>; Fri, 03 Oct 2025 08:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC2219E493A
	for <lists+dmaengine@lfdr.de>; Fri,  3 Oct 2025 06:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9F1FA15E;
	Fri,  3 Oct 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Av1acVz"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395041DB54C;
	Fri,  3 Oct 2025 06:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759472361; cv=fail; b=LAQGGuYg8FJLoGkshGc/RM0rOsBqhS8Zv+NbBLSP69HgKoQ3wPFtDt229xuUzENkk09oX1m+5im/pP06FA9M68n/ZJWat3Ds6G5S7uppX2e5pw0gVh4GDAR54oi50p/YwP9lU+qD2wQTqovAiJpd8eHUWZhECo/WvEB3H3/fidE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759472361; c=relaxed/simple;
	bh=xJlrfdmSSkYP0J9ZodZjtwnWsvrkLsKRKcJB27OG0ac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sm6h0PSkMzj6+XboXIgSfHGnYlyw9nZfyd//if8Cg1q4Pao6CA/tWWcVWeHiufg8dvQqV2Im4dcc2ciFzuv9AD4o913l82V71CmrxNVohXs2nvRNaHkaFJwJ2RC1x1l0Qs7I/qUJgvcSG2zNtYJQunvdh8k9hzAjXs7JLh3H7kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Av1acVz; arc=fail smtp.client-ip=40.107.200.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHUxRFuB7wF2MsUDNv3xd7hGl4KGOrL5p/VmJj6Hms23UxPDU2kjg/qrMKB0ydZiVGVi1WILX1aWhGUEYKIYQS12lqbKfI7CLAFQPtjUlfFwrhbFslTxm37kOxfNqL7MCaAnia+7hTnACUqf1rgQEdgKgTThW5944tAZrB7+qIW+u4vPWR0trmvB5pI329BPZdDRT+qdIT/h2nQzCtpaLHQ1UXs/F+krpMMzqFTry/2dYgeUSxHKPEpgGnYfxaEla3niYX5+qacwSw2ZK3pmYAyIzt5tYIkKWplFGsD2+k87B59g55+I+QN3OqV0ZlQUkUlIoP7mR+ZnKV3YpZFe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYt6XZHSVIGxKL3QKl4pz5ON06F2jMWWKhjbqd493GU=;
 b=CoIh7yaspRUADLXCWzgMMdiHK0G84S79twSiRfgVe43i9Y8petW2Y+oW5Q3fS7LVOdiZ6RrXtuRYYv6EuaMLHd/GUksZ+ZDu21YSYSd4UfFDt0K7ekqXu5Nxv0mO83iLZBDm3sq8skUMdtPq8+27eoOaAA5lcZsefui6xm6uOF0HesBLKhW5aKkIPcIB0d357tGeucXP+1kxEXlGMaYFaZnKPrDeHJYFVui/OLeP1oepaISuAUF0QxpGrKqRvZtlqBQKGbGWussFDFMgcrNH+5pX+c4trakiAC8gyVQ9Ur/Ta+TJg9SGjdQSd9nr+mTWN5XqT24AC/N4DgqK769ZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYt6XZHSVIGxKL3QKl4pz5ON06F2jMWWKhjbqd493GU=;
 b=5Av1acVzKUnmDQu24OxTOjs4nEWVlCvOKL9hyISdQ6rdlplpNsvyS5bguWbnJdM4o2qFnVjOcRCq8RRod/d10NHUUgmJ8OXe8ZXid3UiolhRTXHQ+ZyyKNeX19v3e2xrnD/R9T0AiojAakVzLdXwFY4AjvwEeImpXo8MCNdQXfs=
Received: from BN0PR04CA0158.namprd04.prod.outlook.com (2603:10b6:408:eb::13)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 06:19:14 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::69) by BN0PR04CA0158.outlook.office365.com
 (2603:10b6:408:eb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Fri,
 3 Oct 2025 06:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Fri, 3 Oct 2025 06:19:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Oct
 2025 23:19:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Oct
 2025 01:19:13 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Oct 2025 23:19:11 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 0/3] dmaengine: xilinx_dma: Fixes and optimizations for AXIDMA and MCDMA channel management
Date: Fri, 3 Oct 2025 11:49:07 +0530
Message-ID: <20251003061910.471575-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: f42e40f2-62ee-4caf-8fc9-08de0244c628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M5vQIrDUWUl4r7zmat7TnedjoW9hjQnrEOnCIA9XL6rqrbcA416iNquL3TIw?=
 =?us-ascii?Q?QJ9pjYO2lnUu/vl0x3ldxaaj7AmBb7bExlQpoXUx26CMmPv6wbFLAqYMf8XJ?=
 =?us-ascii?Q?XuDcu7BTxw+7+38WFEUuoF7P9hCvORBd6T8V6Vd1lXTETXUhDo3JOOSyHE34?=
 =?us-ascii?Q?tDULPQp1wV/iOoD5xU+zASeAp3kgBuZCes+ZH/TdnJTP0bFi0mavh966NNy7?=
 =?us-ascii?Q?T3+1MbX43uFGP8+b4QKBF+cUjqeQA0iUxLFhNpel1IXCGtgvKe9sulQEe9vM?=
 =?us-ascii?Q?sEpzNKwaifIF9Kdhjoh+nJO1kfcdZu/+fuhho3cfqv0aoYwan+VW7IpeGlsg?=
 =?us-ascii?Q?/Q6XN4EevFOPPTC33ixNU7+0X9/9sQd+bCRCzp41iZ4lMnKWEwYr02Kj1kpv?=
 =?us-ascii?Q?XTLXJhfiWsyP6o0I4vVGxpaBDjVL+XYGJirTENEUWhDMo/b1Oo1U2Z/N+4i+?=
 =?us-ascii?Q?8DWjlBz1cyv6GC2R0BRjvG4U1/rqQIvumlcQXZS1LYBpzou5YUc0EiceZ2MX?=
 =?us-ascii?Q?vBdcJz/i8VVdJI7DYLhMcJ5oWVkdPMr+2b2mVGO074MIO2ybPHut+g1epx51?=
 =?us-ascii?Q?iyCi5ZrqwWz8XdIuZ5hrNEI9yO2ke10NgckyguIm6mra7HVAynaB+mMbhOCX?=
 =?us-ascii?Q?uXCjncU/itpttE7FuMQfmNUJzPU6gQtlNao7vQeQ+vAX7vypvgvf2Ik45KBl?=
 =?us-ascii?Q?z3wiwuaT4IWsWlzLWCSbTzpjU3YXW+QUYlnA+VfoeXTGZOLskIykUHnP8R8j?=
 =?us-ascii?Q?JZcO6HyrtKZk3usDZBPRHi5fWhXjQSHxVdAXo86mOZxCvWr/ICm74o3Uaj5Z?=
 =?us-ascii?Q?i7U9wh9FpQr27QME+Ao6hcyCst40hmFi3nceayV452hDX3TfR9Z344YaSadl?=
 =?us-ascii?Q?HI6SiLn3XlzLXvm/v4kLE9DXGscvcZZuiqj7/epJ+JowQ8JGurw3HPzV7Ji6?=
 =?us-ascii?Q?hJrJMgQUJ1jFkAHTVqsVHYxFAOsxRpC1mbuiVAqeCNlfK5WQOf4u4Q4pnEQP?=
 =?us-ascii?Q?HCEc5Ydc9oiUa/Qgg7RHDKoz7jxcGsQSPT2+53LAz92kSJfVDlZOK8Ro37Kn?=
 =?us-ascii?Q?sV9zalGMqtVbc6Aeo7FciNjEc3aPHxOiIGw5in4j3KGupPBWL7yrKwVKjbCY?=
 =?us-ascii?Q?+YBSOaC/kpEXxrqLcV1xB2DPywMqbADBP78luESsq2lnT/FLTxjjk2PrOlDJ?=
 =?us-ascii?Q?RuC3Kd97T59ldRJQSZjyMcsJnEx91INOCsiom/inLPiaGVMKa+QePlLHVdQR?=
 =?us-ascii?Q?SXYo5kNtz5mnLRij+ZfCjt3ncfuSR5BtlM3Fq+wIBTF3eel4blUP3GIIM3nY?=
 =?us-ascii?Q?EEj7y7McxF+xrMRcLPczP27ng6lW2NSGHlipdaHVuXo9Wo+oULJu1Y/HBSNO?=
 =?us-ascii?Q?BN0aFAL3RWjEfoTP5xMVx4ez0llk6PhsMlpWM5EbiCZ+qqkofiG+R2cDdRAj?=
 =?us-ascii?Q?7BXveI/JeHsRKziTxVfBIA7dPYOLtXWFvd8sl2+HDxE2Ee3HYAjPIXrwe+VD?=
 =?us-ascii?Q?nB61fOPhNx6kQjaZnItEfvEMdbFnLnpIHfUQ0nYJEvaOL0nPANggI8SNFzNl?=
 =?us-ascii?Q?YrZ6j1lHejGANom4j/g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 06:19:13.8298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42e40f2-62ee-4caf-8fc9-08de0244c628
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408

This patch series addresses issues and optimizations in the Xilinx
AXI DMA and MCDMA drivers:
1. Fix channel idle state management in the interrupt handlers.
2. Enable transfer chaining by removing unnecessary idle restrictions.
3. Optimize control register writes and channel start logic.

Note: The patches in this series were part of following IRQ coalescing
series which is under discussion:
https://lore.kernel.org/all/20250710101229.804183-1-suraj.gupta2@amd.com/

Changes in V2:
- Apply similar fixes and optimizations to MCDMA as well.
- Expand the 1/3 commit description with when the described issue occurs.

Suraj Gupta (3):
  dmaengine: xilinx_dma: Fix channel idle state management in AXIDMA and
    MCDMA interrupt handlers
  dmaengine: xilinx_dma: Enable transfer chaining for AXIDMA and MCDMA
    by removing idle restriction
  dmaengine: xilinx_dma: Optimize control register write and channel
    start logic for AXIDMA and MCDMA in corresponding start_transfer()

 drivers/dma/xilinx/xilinx_dma.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

-- 
2.25.1


