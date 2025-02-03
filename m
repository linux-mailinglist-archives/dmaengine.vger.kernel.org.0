Return-Path: <dmaengine+bounces-4259-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8329FA25FD8
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 17:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229DC3A8A13
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750DC139;
	Mon,  3 Feb 2025 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QZsS9Q+1"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694620A5ED
	for <dmaengine@vger.kernel.org>; Mon,  3 Feb 2025 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599941; cv=fail; b=Ek61kPTyl2PCU71TMM5DPS8nf54IYSe3VH/LFmM0wWhs1wTwuUPRQqL3KrZJhTGkD8a0XT2J2gGPUp4NuWK0IdDPvlMdkM5uWAJus1slQRUCryB47VR5Nr3OP5Ggu3u1RWp7ZCH7Pk9YysF/Men0SOoXkHKMjn1ShMXUWAfvFjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599941; c=relaxed/simple;
	bh=xwZulVy4EyXs7pC7q96cLA2ESBfu3wrbimtTGa4FkzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/TkMJUi21kk5Vi9vUVpr8PR6AIIldLRskfQ5W2YvOJBVfeShRzacK14dKaU8MD6Lo7NwjvcsQBDusvuT+iM/6ljDnUV9fSVU0XwVvSxAfNM455deXdpDFf38FltJ67dglFMDzqk8Pnzya3Oi8IfatP/7CgSZ5OkuX2i5ZJrdSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QZsS9Q+1; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGV8HkK2SZFrmnz2YZSIKwbImNflK962lSJBpbYIFRePBmKesQEfaP9YfprChsMKa/Wk9uZ8juhEEZ+h2Oyyr2tOO0E0av3WOg7uAqTMbzXbWxJ8epyovcnVRDNrxNR36dpcYpQzBO962/zWbDDFekrZmZ5vD3ql8VXf4KXTXWLQmGnUJxsIe33h+mJCfPQoWd+U3cAcVwL40fAqaZQKqiIn7DE4Oj6krEVa3R5RgrE657nbj5GPwvB0GDI4fjpf10fBC0QWd/3UeRtm7bZ0hUCifR57wfDdYKR1JTkxYtY1oE2i+6nl2x4sKxE25bdcIgrwsV45+9uXhyuut2HDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWzSNIY0pCHcfq01E+UP91AaSfOJU7gpX7PDTfbWP90=;
 b=vy7SxCBary8Te1MszAN9pzKyIE4BpXiN/OgPQQeTazYsSjYBJ/tYwlduy9JTw2TQI1JeMpnqtBvQJbgOjUG/vPznt9uUm+0CZLzslDXjR2tynFfauca9LDbTjn40XYzO7cpGHu8JUBf0ItJTyIZAUByovhNFA+rfEsi+tMqBD+npIvfXgJwUQlNVtlbGUcukv1GHIab8Jcsv3KkPsWkWQGA/yz4HA6MW0UQQdaDfVS3WOWHYDEc/Fmlrq0zTGyFTeYlcloDcvzSM30bGc8XFNFbI5UZTADYg04sNZSnexQ/tUdDtxR7zAJ13ZdTu+DdWooLLWauhqKzT1DFridp0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWzSNIY0pCHcfq01E+UP91AaSfOJU7gpX7PDTfbWP90=;
 b=QZsS9Q+1lAgBpop12TB3LCmL8j9/GQFzBB4uHEG9iQ49kZZOPdaFOGGP99EEt+PNRwSRRzEvVGT6G57HmwtvIGXbnISdMNdVGcNRg7DYIeoKeVs0XaH0meyaCYj2vZT3l00sY2ml2UxxRp7evhw5F9SFzcywC7HQfDjedDbdcGM=
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 16:25:37 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.26 via Frontend Transport; Mon,
 3 Feb 2025 16:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 16:25:37 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 10:25:34 -0600
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 2/3] dmaengine: ae4dma: Use the MSI count and its corresponding IRQ number
Date: Mon, 3 Feb 2025 21:55:10 +0530
Message-ID: <20250203162511.911946-3-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea3a576-2cb8-4a23-2ec1-08dd446f645d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T41zrlcFidqiaDtRLu1QBLj6WiXnguSE4yzmu8VMQQR8DpJkh9YUROt/RZTj?=
 =?us-ascii?Q?aQxC/A9tQQp2GbgLwinr2sFQam7WE8JB2QlL7O/rWa11h7Q5kgIn+Mf7vC3O?=
 =?us-ascii?Q?2VbyNvMPYt12VSb71JOJeSyeVFAv3lWvJRHMmrWQ50WCXYp+05FZ00XdMs+K?=
 =?us-ascii?Q?D5QHE6+FAhBUZmbxD4nrQDlQ0txUdKTdjlrl+iiQHbolpu4ZvS8aWefRd/q8?=
 =?us-ascii?Q?KLh4e2l5UfdMrDf7/qshutfbVnVgIrm0XG3jymRWsiBsUxxCGH6+XN0VpMu7?=
 =?us-ascii?Q?jlgFe+SNB7nAbvd3vmNsg4VhwgOrwPUI1aPmPGhHRQ5a4snQoffLlKPhmDn8?=
 =?us-ascii?Q?Lqe21+RwHTSrqbQhmoUtEvlmhUS2m4KZWN9qlfflEsG3jOvJae0GB1kPQRsk?=
 =?us-ascii?Q?ZiqUvAae//SG740FLjbI7e5Pf7H/a86kaQpjGarwLq2KiwyFN9pncEkbDAOB?=
 =?us-ascii?Q?icdakwxo5lTBQMtBFsjol8PLDCn7/0XaJHYRSRDXgP6vZDdi0ezXGFwhWlon?=
 =?us-ascii?Q?AZzJiGESnqjfl73NDwgt3OOGdoi419MrrB3izDCDd8QqR9lTjY4LMp7flDbB?=
 =?us-ascii?Q?EiQ1VUa/YtjXMci8b6Nvt3j2J8ju20/YuWXqWJ9VVE80CJ7UPEpBuAUzdIx0?=
 =?us-ascii?Q?D+xM+MuU3dyOdJayPuv5ZXSMykoeEAS3vDJDY9GzUPwLbvrxen7xx7mhv4p1?=
 =?us-ascii?Q?JDC4JIeF6zjgGvlb2UD6bnZacdQokMHwOmPAP+6yXVjv92jRrJgPU+9lljZJ?=
 =?us-ascii?Q?vguJkiZ5XwAxHwMvzblGV/pHxCq3G0L4vd0kffZ70c/ydnaNYEK1xyBFxLYO?=
 =?us-ascii?Q?KLMlNlWZtWw7rdV6j6wUbbZneGEhHY6w4kg7eeMPCjIHzaM8ZhChjK+oKnM0?=
 =?us-ascii?Q?ydNbRGnPYRTXi3/iEekKxbiL7BwaS00Yo2n0wPlZLGPM2CH3A9CWl1Rler+r?=
 =?us-ascii?Q?681UCjtE8+e43RcjjEn/YEWG1hdRxKKo/IBfeYjpDU+XJ/SIqqHbdUlSWTp4?=
 =?us-ascii?Q?VzRqVMW70Ec1sVD4/a0fDZGW6LQPHXq4QAtNyabGbwL4/nTI+tk2v6UaUjTs?=
 =?us-ascii?Q?Op5AunLwvuKYLsr7YhC5EaYzpNoAP9r5OaITcwBVm0H1DmW85fiF8AQLV1NT?=
 =?us-ascii?Q?brXUp9RpaRpHskgw4iZK0s/rIBuQ6moLQKHaNmoJmifYDjlexd8hIrOMoHw9?=
 =?us-ascii?Q?33xDScU5wqD4FqXcZku0R+ANThzKvNCy48QSnyCTHx9IOKNamV0oOeKb/46z?=
 =?us-ascii?Q?oyfhf4wGBjEzFXfjCncGFJNs4zbIPtN51iTzzlq+Or4X5U8cxYF6QstUYLfx?=
 =?us-ascii?Q?TEK86/mnZb6m0JzW/E+dtFq0DBYdSsTVFZrsjXRf55t91NommWyIqXahUExV?=
 =?us-ascii?Q?ExQ7Fp0tS0nHNBhktB9+xUowptt/v4e+n8esZ1QSfzMzzxZDJiYO5F6Maa/V?=
 =?us-ascii?Q?Bn0tGt2YsLH0o+1pkhWPDuD4lkq7oIWOYXZXmGh8AeOlDr/lBCN+3MLVQ7kx?=
 =?us-ascii?Q?rFWBv/qjCLhHy2k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:25:37.0646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea3a576-2cb8-4a23-2ec1-08dd446f645d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651

Instead of using the defined maximum hardware queue, which can lead to
incorrect values if the counts mismatch, use the exact supported MSI
count and its corresponding IRQ number.

Fixes: 90a30e268d9b ("dmaengine: ae4dma: Add AMD ae4dma controller driver")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
index 7f96843f5215..2c63907db228 100644
--- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
+++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
@@ -46,8 +46,8 @@ static int ae4_get_irqs(struct ae4_device *ae4)
 
 	} else {
 		ae4_msix->msix_count = ret;
-		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
-			ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
+		for (i = 0; i < ae4_msix->msix_count; i++)
+			ae4->ae4_irq[i] = pci_irq_vector(pdev, i);
 	}
 
 	return ret;
-- 
2.25.1


