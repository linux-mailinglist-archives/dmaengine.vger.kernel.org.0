Return-Path: <dmaengine+bounces-6604-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618CCB7F6EE
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318B7486F96
	for <lists+dmaengine@lfdr.de>; Wed, 17 Sep 2025 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDB03195EF;
	Wed, 17 Sep 2025 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OaNDs+79"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DF302774;
	Wed, 17 Sep 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116184; cv=fail; b=Jt0edQJr2c0DpezngZKym6haWpTE7H4I0kJbyw5qtFJbg0qJajMQyjUto/JLR+mCB1wJwjYVHdefZ3pp4mM8r9YXdmqkjzR8lJHVGBS6IGvn4831wBiaJoq1e/ZYWoz84r/fSk3ue9CM9/mcsraBoi31HIVLBo2pUYenhWStAIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116184; c=relaxed/simple;
	bh=OoRmKRCwcgmtbywoBZnH9cZQ/8T7Q8Ne4jga0I1DriA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgI/SuxFcjeyS+70KyeVfjWuNA0i6bDaLcjPjFukO77ROcM6td2fBJw5xGKkiCx1wHMostHYFV6/CT34IIA4U33DfXfKwWnU9IOwI9MildElTTiuTOfpvNjTVq0npNOmop9u6sCKpb3yc0ilpnu4HjUiVGYyqS+W656y0LYqSFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OaNDs+79; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSiZbs4unLf1zDgqXJFwYR7GoLpTbiOeeL3pB3BKbukpN9uXPVG0qCwlxtHuHCe+emh6/lHgbOGHYGoQ32rJAx9MfLHX+dYeco33NlfC0XZgg+11o5ZGUJv7cbABS325fAo99C8yP/FT9B7pvbOwABDNbaCPD67kN6XwcqFpyC6ZbAk1qtmY+EaigED9EJMyguxJL9qAeNM35f921mUP4JUrAYQIT9QXDnGnBJya6dGYamlj1iYZ8DCPCfPU199yi9kOVG/ji98aCZ11Ssc3ge1FS0vd9r+NhvccaaAGZkgn2VAMamJQRZL4XElJOArk4QjAyXgN3iIYBor7c4vqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ0xBOgVnFj72ohvoBp+/Ol/MIKB06H+59m2QYcv2Uo=;
 b=ddWbNkz67j/5acqtboU499tnlUwnn/IRb5b0Z0KFB1H/0KWMnxbmlKqa8NVYBhPoRt3bHEE0oDPgdwpnTsIUD2cAlLtCcu8YDyYCiDtQ7wLAIn6cR6PiIrfp+PS5lKR00oMfnbwoaMMoRcR3805YUFis6cPI5GGdc2ncWxpbKlAiGKbcYm/zYH7JIBN6fHjCmQRQ5aWoOot278cnZrQ0npPKVl4AmA3bLQ1411eBaSbeQXwNa/GJO37SzrYH2KecHLJK1+K5GXXw+fyaof1sEvQKh11aWignnEWy7ZDbg+sOzjwOopggBHDEZ8Q6Y86CvcVGXVQiipq9DNRWZOT4cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ0xBOgVnFj72ohvoBp+/Ol/MIKB06H+59m2QYcv2Uo=;
 b=OaNDs+793MxOVkXp0anQ7rHhrrqUGTa//m8PtOEufnmXYkWIU8VJfgedqhjnyy8ysYy3Mkbx2O4CrAmZ7cxU6Vfj3BAKXENUa6uQGxQgDE1vBHaSLsqIy0M2SNw6O5DVrEf6cjwC/1Mb+tezwbQO2jhFO9SxUsYErgejil9v7Es=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 13:36:18 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::20) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Wed,
 17 Sep 2025 13:36:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 13:36:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 06:36:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 06:36:15 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 17 Sep 2025 06:36:13 -0700
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <vkoul@kernel.org>, <radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] dmaengine: xilinx_dma: Fix channel idle state management in interrupt handler
Date: Wed, 17 Sep 2025 19:06:07 +0530
Message-ID: <20250917133609.231316-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250917133609.231316-1-suraj.gupta2@amd.com>
References: <20250917133609.231316-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH7PR12MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: d5099fd9-4b52-4e0c-f32c-08ddf5ef2e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wAseg5BB8Jggr085yCIwC9IBu7LW2QrkApJQKLdyPa6hy/PLPhBzi/KraehU?=
 =?us-ascii?Q?VpjqzXpGeXE6JRG+ZDRj5jZetq+eoIS2N0gh51OYZHjTU7rmwaHOWKF7qhq/?=
 =?us-ascii?Q?1Rv2v7FWvK0Bx2CDy8+00QvyrWRyfrpbja/Eu8v+SY7eU83IVbyEGtKTjh/J?=
 =?us-ascii?Q?n1fC7JSLhAsssUZqygPLE9u3Td0Uk8W7USe0dwKwk2KBLYnOpit8zBRvCJQw?=
 =?us-ascii?Q?TiRgND4pkVUoc+lL3l18InPBN/V/OUTjXbf8ZhW6/IdNnpMlhCLbZsPFMPla?=
 =?us-ascii?Q?g60ECyANOaDDPqucPSOCEFEGp+/iWQKhpnm7WpMgK47zl8w/gP+7GmU8bM+i?=
 =?us-ascii?Q?N0OpsSgpDLMho6kZ9YRdyRo4ucv81dKy+sHcw6CWtCZlNURtMz7uxC4QjIQ0?=
 =?us-ascii?Q?/Tiwf+6fICwNaZG4PgcVRJyGfUQI/zjRYTxoGBiZ5pWU3MZwoocnWCSPvlsI?=
 =?us-ascii?Q?qnGWdpQ7yOrz1Okqjic3ufr/xKs093/3ecn9wemCwWnjx7BntUVSxLEbK6N2?=
 =?us-ascii?Q?WNWvPIbqXclezN59Ll2O6axLg5CaS6Qz69l2Rjpqed4fak46s7a8Fs1/EUlX?=
 =?us-ascii?Q?y4OSD8rcjsenbk5m79p4S6hez6BPJpiCls9px6qTXSfTCD2JnpNSRT+G0c6d?=
 =?us-ascii?Q?J6zIRmlnjto/rirkshU9qaHqyR9dCcduvwPLdBP9iG4pp4ImxJHxY3T53DHE?=
 =?us-ascii?Q?8ufvcnc3f9TFDFxiRCg7nQLEDR2BcpNsH9sajhVMNuS6cMtvzZCoMrCHleTq?=
 =?us-ascii?Q?hRqc5PO7mFR6WQ5GtlxIAMeDhSCJioTQcbjeLOgKKL5xRdHBZhVx0bld3DNr?=
 =?us-ascii?Q?FgNpBZpP1Y8u1fJVPW2KPpUlXio9Dg4DH6MQ7pYncj8bVP9/I+fYyBJSHnnE?=
 =?us-ascii?Q?uIevHh/D/5AX/tKu7013XVcc3g9cHX7Z7iVUziLZirUzG/sK8tiF5cKyU6Vf?=
 =?us-ascii?Q?SHRciQEHg6BTYqTxIN652iao3vw4s4i+DVP5dqnfVihoRgZhrVVg4rLZa0zw?=
 =?us-ascii?Q?tIQBrpVpuMFt3UOam2L2aVpACSkO4ZcDeQgmsQkR8xhMw3JTwLtkFO+jZeDl?=
 =?us-ascii?Q?zIZlT3IgvgSsR3KI1Gppe4hq6+tRwrMhji4SMT6baA2rN2ZweokWtmmnkbaZ?=
 =?us-ascii?Q?DIQkOY35hcWPCqaKtydI5kuL2djh0eluwSL34CdU2Xz99ii7huwc0xxbncwz?=
 =?us-ascii?Q?4xPhNneT9uKXEPtwS2UoTmLFEALeyoaKDiPD7Io8Ds1dS40nEjDm7YG64YFS?=
 =?us-ascii?Q?3MCWnPoHEsQ4xhJxgXDUy3om7v4Qfiae6yCRA7r/MBnoITVJhPj5BUTpUQnG?=
 =?us-ascii?Q?qfVhgv0GworX527/nWRwI725gNtW13Ru+W4DgSHXmFPrtWy8FP0B2o4++7ML?=
 =?us-ascii?Q?LjnUytjY8qW7rUSDQZQ7QW/FuKQt4F9BgMJ4/1G/KReRIQeV3FvEXpwPt69i?=
 =?us-ascii?Q?pGsv9uRxO23F7+BHKryzXE1uPY/Qckp2u+pukhtm732Eek6Gfj1sOxsPZ2Tk?=
 =?us-ascii?Q?sljSIRFN6iP44bLzRbuNpZmNM8SFtUuhVycb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:36:17.8645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5099fd9-4b52-4e0c-f32c-08ddf5ef2e57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879

Only mark the channel as idle and start new transfers when the active list
is actually empty, ensuring proper channel state management and avoiding
spurious transfer attempts.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")
---
 drivers/dma/xilinx/xilinx_dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a34d8f0ceed8..9f416eae33d0 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1914,8 +1914,10 @@ static irqreturn_t xilinx_dma_irq_handler(int irq, void *data)
 		      XILINX_DMA_DMASR_DLY_CNT_IRQ)) {
 		spin_lock(&chan->lock);
 		xilinx_dma_complete_descriptor(chan);
-		chan->idle = true;
-		chan->start_transfer(chan);
+		if (list_empty(&chan->active_list)) {
+			chan->idle = true;
+			chan->start_transfer(chan);
+		}
 		spin_unlock(&chan->lock);
 	}
 
-- 
2.25.1


