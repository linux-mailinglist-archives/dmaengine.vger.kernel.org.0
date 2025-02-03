Return-Path: <dmaengine+bounces-4261-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5EEA25FDA
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 17:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B3A16671E
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C224C139;
	Mon,  3 Feb 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KCUJCCBm"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130820A5FD
	for <dmaengine@vger.kernel.org>; Mon,  3 Feb 2025 16:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599946; cv=fail; b=TKUPFNUU/5cBnGV3gFXj4sxsVxjtl3QVAXVmgxD6w+lnd+gQ7cEbwR4BQJTKw6la6Gk9JMb0cy34Shr6qnG3LII3b+qzyObcAB6po0LL67IaYbDdc1NZ70jd9rmV6QU0SaCL21KHcf4MfuVRMki2iZLoCRaEoOUjSIdjPujYBgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599946; c=relaxed/simple;
	bh=MGlVTOFtGkM7Jc6EVxVHh4cYHrzhXeyZ9FoxuWJ3Iww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FG5tk/EAh2canDkSTmjPAHzIc+C0Nlv0zYqxuqlEL3PqcFdeWYncSmUKS+Na3Px8Pl+1Hd89iZ43POkK0Vu+ufeDKnLnyHhp8nDcTvLnKrwclQr6Z+Dh9YEJi6hCaVpxgVG3WxCPjcpDYQ09JTHkKfBK0VcPXTzH7TttBxOKoXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KCUJCCBm; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3Evt5B5tHj7DkuTnxP3F4Pu+SsNlFsHsMrgauwu9yjv/Vt97tKcYW8dfidxaK5bxG2a+6ermFRUX863nYzq/s1TUnTBidSxuOkDTwOtZEakqn6UsU1FF8WxVX//yF7eaWdbv+4zB3osmQgimddaT3fpOmsS+/os4Hx274/RaqKLayxhMxd34ZNdvwuVTfIKEppnNNAql47EOcxbLLWGBRTRNtF8YO6DEZaCNHQ7CJOrFt8J0C3Qauu+rbru/ybOE7cV57tb4EHTzwitBDmsxvetvviL91DR09wpaCZ5o+8SbMCIqGIHqYPkV6vGmVZU0exrvFr/muRjD8tpIQU63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDWHaf6h0dphshqWg7GuQjVFt+0fz/6RZhRrdaJd0g8=;
 b=LAYC30TS4c60ANqOUPv/FTlMpoIOVIRDm9DzVdWVdGnv3JYpOtOUxea1/jCl1RRi123/dyPP+J5o26evGO0Gl7SBeLsGgu/SuyjqEwKme1PjlqDw+HtiGEfo7ZHh5BWaTYYDZ+/gqqmomDhnr8adjUHdGZnTb7TTXZwbnAn9bdW7zfsNCIoXZPhvvg3AjcNqIGTOmcy3sKCopBE1acFaiTSd3eU8AYsgKY6FeGHZ8bHJpucpIDRy7E1RsMseRqZEsT4nJSHmnYENo14qSYIUQuiGbjebVJMNbuaiDOmfFGRxfgc7OD4Z5IW6ssobXOUuP9wdWJ1ClkDhemBc4xmZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDWHaf6h0dphshqWg7GuQjVFt+0fz/6RZhRrdaJd0g8=;
 b=KCUJCCBmCm2tIOHi1TgDPNWweipt8S4nKxi1/Gv8SGv/h3ncnO+eszVSsDOpTq89oOcpgvmMg4PDtjaJ4vFimLDpLiwXtes3CAE6fRSqEz+4+9wmjCsxP8G36kXlQOI6iJDwtt/uSnQm7Ke1zRuZRu+0d8S+htkkcLo/jzUGvOo=
Received: from BYAPR07CA0021.namprd07.prod.outlook.com (2603:10b6:a02:bc::34)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 16:25:39 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a02:bc:cafe::d6) by BYAPR07CA0021.outlook.office365.com
 (2603:10b6:a02:bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.22 via Frontend Transport; Mon,
 3 Feb 2025 16:25:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 16:25:38 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 10:25:36 -0600
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 3/3] dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality
Date: Mon, 3 Feb 2025 21:55:11 +0530
Message-ID: <20250203162511.911946-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
References: <20250203162511.911946-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f63e8ce-a809-44a2-188e-08dd446f655d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0pVTXhIS3lSY2svMlJSc2JwQnpLTWxVaUNNQXBKZDFucWNiK2UvOHlCU0Fa?=
 =?utf-8?B?L3BoRGpadWsvYlE4L3dnZk5GTjlIeGZaUjdpRGJ6OE9mcTFiQ1ZEUmdzdVpj?=
 =?utf-8?B?eExlTURmYkY4SXhYbFFJMUdYc0pOR1ZOQ1FZVStlOG4zNmdPNzJpL3liK2s2?=
 =?utf-8?B?ZTNFRVpiQjJKcFVHWWFEQUhXczY3NmhFSVgwb01NRVZ5RDNRbXFGaTZ4ZnlB?=
 =?utf-8?B?L2hPdlczNkV4K0RuZDh0NkpzYmpvOVl6UzB4REZQb1Z0aDNJcys3OCtLd3FZ?=
 =?utf-8?B?WldkQ2Q1em5ZM3pBSTJnUkJVNVBMdlB3eGRXdVZIQmxRZnZaOEtUcDd0VU83?=
 =?utf-8?B?Z1VvMm9wMUI3dk9MUW9hOWxkQm9wL0RTZWZxSzEzNEpNZjdETnZWWWNZOHB1?=
 =?utf-8?B?UFN4Zi9CY3VsNVoySFZ5RGVhQmZRZU12Qnl2a0dZU09hVkNnY2o3Tmk4ejNE?=
 =?utf-8?B?ZTAvVlAwbzJ3SXFHLytPSkw3OWhKeVFJOGFVelVkL3B6d0YycDBZWG85cE5G?=
 =?utf-8?B?VTZxT1NObENYTHgxYWtSZmxsL09iUVlmeE1xOGQzckZSWlNPRHA0M2RBc0gx?=
 =?utf-8?B?ZVpoWTY2M0dkb2VjOWo1aG5aQzRIc3NIWnAzWjlQQnVvNEs4Wlo3OURDNnhR?=
 =?utf-8?B?ZnBSWUdrRWhCZUxkUHhPRU1BTHdNVHpLdk1Da0xsbFJWSStMOVd0RXZnQnlZ?=
 =?utf-8?B?VFVLU282ZGFYNitTMTFrV0hDQlpCTGgyQlRMYXlsZmt3czl1bzMyeE1mb0p3?=
 =?utf-8?B?NW9IcS9pNHJQeUlEZTErWU05NzVUS2FScGdCSWcyUjJhNTF6azFDT3RCblhu?=
 =?utf-8?B?OVJTN2Z5U0J0NE9TZjFEbjRQSTNNYmRmSUZUeEdWbmxON3dQTk9HSGMwSUVU?=
 =?utf-8?B?RnR5azFGSEt2d2gxeHJJRlNseDFLbjRvUFptYml0eklodmcxeDBCVmljYjhM?=
 =?utf-8?B?UHE5bWl1Qk9ieGo5MkRDTEJmby8xQnFyN3IrenBHY3Z0b05TSTFxWkdVTkxv?=
 =?utf-8?B?NW5POTN6WVc0bE5nV1kyUEI5RXIrKzYwYU0yNHNwZTM1cGlqRlNtMjlkc2xQ?=
 =?utf-8?B?TnZvTmQzOWxJcEx3VWdkbS8wNi9pVzc0VWRyZGt3TFhVRjd1YTcyRG9mZ2pH?=
 =?utf-8?B?ZTNoeWhOQjQ1VFozNllMSGZhYUpKb1hDcTduWVhlcHFHaFB1YjhGVFNITEJq?=
 =?utf-8?B?bjM5dlAwa0Nvblp2emJNQTJIbnErUFdCdElZOXNFV3JyK2ZQekFOR3hkRXY1?=
 =?utf-8?B?cDA0RmhPWjFzWTI0L0k3WDJRbUsxYit0ZEtQUjR0Z2VFcEpLQ3QzNmJLNlQ3?=
 =?utf-8?B?UmFrWlVnbTZnWTNEWFJFSnpnL28vY0ZXUHI3SEZINlVBa1psd2lxWWFRb0ho?=
 =?utf-8?B?VEtXMzR0eUJ1Z1MxUlQ2QytuTXorTUlQMFE3eFFGQkFsWnhaVzA0NEladVdh?=
 =?utf-8?B?K2RJUEVnd0ZoM2FCaGNpQXgrdkNyQ1UvRGdOVmd0d2EreDl3WERlak0xdVV1?=
 =?utf-8?B?OFdVUVZoYzV3LzlCdGZGdmxvekFzekhSYWIzWmd4enVXWVM2M2JQWC9yUSs1?=
 =?utf-8?B?bktjWE1GN1VMYldkdjNic0liSk5pWmVlN2JqUFNwaXQvLzN3UFRzSHFBZldk?=
 =?utf-8?B?YVVrSit1bnl6YzEzbktWTlY1SVhqT3RKVFdBQlluRkdpMUVtKytpc09nWk1a?=
 =?utf-8?B?dXNnem0vVHREbVBnbGtsM0F6U2dhc0pObkNuTVJ4a1RHbkdqZEpFWUJHUEgx?=
 =?utf-8?B?ekx3M1FKdk8wcGd0akIvQitTQlVMUjEwc3pGRjJDeFlBaTR5UWtOQ3lHa3Rz?=
 =?utf-8?B?TEFQaHYyS3BzODcwWXgyRE9KK1hQQmNHajNxUExjcjdYSnVsSGY0RTJ0UjhX?=
 =?utf-8?B?Q2JLMVY2Nld4QU9rWWhCNm1lcTNTcUpwQSs0c1htU2tvT3d5VWpST0tPQmdY?=
 =?utf-8?B?NkFwZTJmT014ZU9NTmZDNy9VN3RkTGpsOU5ET2c1ZFArUnd5ZTBSYlEwY1dh?=
 =?utf-8?Q?YVZKB1ZtrTAGbD5Pq6pQy0UHHdY2P0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:25:38.7574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f63e8ce-a809-44a2-188e-08dd446f655d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842

As AE4DMA offers multi-channel functionality compared to PTDMA’s single
queue, utilize multi-queue, which supports higher speeds than PTDMA, to
achieve higher performance using the AE4DMA workqueue based mechanism.

Fixes: 69a47b16a51b ("dmaengine: ptdma: Extend ptdma to support multi-channel and version")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma.h         |  2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 90 ++++++++++++++++++++++++-
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 265c5d436008..57f6048726bb 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -37,6 +37,8 @@
 #define AE4_DMA_VERSION			4
 #define CMD_AE4_DESC_DW0_VAL		2
 
+#define AE4_TIME_OUT			5000
+
 struct ae4_msix {
 	int msix_count;
 	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 35c84ec9608b..715ac3ae067b 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -198,8 +198,10 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
 {
 	struct dma_async_tx_descriptor *tx_desc;
 	struct virt_dma_desc *vd;
+	struct pt_device *pt;
 	unsigned long flags;
 
+	pt = chan->pt;
 	/* Loop over descriptors until one is found with commands */
 	do {
 		if (desc) {
@@ -217,7 +219,7 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
 
 		spin_lock_irqsave(&chan->vc.lock, flags);
 
-		if (desc) {
+		if (pt->ver != AE4_DMA_VERSION && desc) {
 			if (desc->status != DMA_COMPLETE) {
 				if (desc->status != DMA_ERROR)
 					desc->status = DMA_COMPLETE;
@@ -235,7 +237,7 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
 
 		spin_unlock_irqrestore(&chan->vc.lock, flags);
 
-		if (tx_desc) {
+		if (pt->ver != AE4_DMA_VERSION && tx_desc) {
 			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
 			dma_run_dependencies(tx_desc);
 			vchan_vdesc_fini(vd);
@@ -245,11 +247,25 @@ static struct pt_dma_desc *pt_handle_active_desc(struct pt_dma_chan *chan,
 	return NULL;
 }
 
+static inline bool ae4_core_queue_full(struct pt_cmd_queue *cmd_q)
+{
+	u32 front_wi = readl(cmd_q->reg_control + AE4_WR_IDX_OFF);
+	u32 rear_ri = readl(cmd_q->reg_control + AE4_RD_IDX_OFF);
+
+	if (((MAX_CMD_QLEN + front_wi - rear_ri) % MAX_CMD_QLEN)  >= (MAX_CMD_QLEN - 1))
+		return true;
+
+	return false;
+}
+
 static void pt_cmd_callback(void *data, int err)
 {
 	struct pt_dma_desc *desc = data;
+	struct ae4_cmd_queue *ae4cmd_q;
 	struct dma_chan *dma_chan;
 	struct pt_dma_chan *chan;
+	struct ae4_device *ae4;
+	struct pt_device *pt;
 	int ret;
 
 	if (err == -EINPROGRESS)
@@ -257,11 +273,32 @@ static void pt_cmd_callback(void *data, int err)
 
 	dma_chan = desc->vd.tx.chan;
 	chan = to_pt_chan(dma_chan);
+	pt = chan->pt;
 
 	if (err)
 		desc->status = DMA_ERROR;
 
 	while (true) {
+		if (pt->ver == AE4_DMA_VERSION) {
+			ae4 = container_of(pt, struct ae4_device, pt);
+			ae4cmd_q = &ae4->ae4cmd_q[chan->id];
+
+			if (ae4cmd_q->q_cmd_count >= (CMD_Q_LEN - 1) ||
+			    ae4_core_queue_full(&ae4cmd_q->cmd_q)) {
+				wake_up(&ae4cmd_q->q_w);
+
+				if (wait_for_completion_timeout(&ae4cmd_q->cmp,
+								msecs_to_jiffies(AE4_TIME_OUT))
+								== 0) {
+					dev_err(pt->dev, "TIMEOUT %d:\n", ae4cmd_q->id);
+					break;
+				}
+
+				reinit_completion(&ae4cmd_q->cmp);
+				continue;
+			}
+		}
+
 		/* Check for DMA descriptor completion */
 		desc = pt_handle_active_desc(chan, desc);
 
@@ -296,6 +333,49 @@ static struct pt_dma_desc *pt_alloc_dma_desc(struct pt_dma_chan *chan,
 	return desc;
 }
 
+static void pt_cmd_callback_work(void *data, int err)
+{
+	struct dma_async_tx_descriptor *tx_desc;
+	struct pt_dma_desc *desc = data;
+	struct dma_chan *dma_chan;
+	struct virt_dma_desc *vd;
+	struct pt_dma_chan *chan;
+	unsigned long flags;
+
+	dma_chan = desc->vd.tx.chan;
+	chan = to_pt_chan(dma_chan);
+
+	if (err == -EINPROGRESS)
+		return;
+
+	tx_desc = &desc->vd.tx;
+	vd = &desc->vd;
+
+	if (err)
+		desc->status = DMA_ERROR;
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (desc) {
+		if (desc->status != DMA_COMPLETE) {
+			if (desc->status != DMA_ERROR)
+				desc->status = DMA_COMPLETE;
+
+			dma_cookie_complete(tx_desc);
+			dma_descriptor_unmap(tx_desc);
+		} else {
+			tx_desc = NULL;
+		}
+	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+
+	if (tx_desc) {
+		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
+		dma_run_dependencies(tx_desc);
+		list_del(&desc->vd.node);
+		vchan_vdesc_fini(vd);
+	}
+}
+
 static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 					  dma_addr_t dst,
 					  dma_addr_t src,
@@ -327,6 +407,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 	desc->len = len;
 
 	if (pt->ver == AE4_DMA_VERSION) {
+		pt_cmd->pt_cmd_callback = pt_cmd_callback_work;
 		ae4 = container_of(pt, struct ae4_device, pt);
 		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
 		mutex_lock(&ae4cmd_q->cmd_lock);
@@ -367,13 +448,16 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_dma_desc *desc;
+	struct pt_device *pt;
 	unsigned long flags;
 	bool engine_is_idle = true;
 
+	pt = chan->pt;
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
 
 	desc = pt_next_dma_desc(chan);
-	if (desc)
+	if (desc && pt->ver != AE4_DMA_VERSION)
 		engine_is_idle = false;
 
 	vchan_issue_pending(&chan->vc);
-- 
2.25.1


