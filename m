Return-Path: <dmaengine+bounces-6100-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA3B2F7A5
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 14:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3F424E5E5A
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958E82869E;
	Thu, 21 Aug 2025 12:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="el6/I4/F"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782D4C9D;
	Thu, 21 Aug 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778529; cv=fail; b=B8YWNp/SPVMh0URb/ytcpOB/0OVABI1kW7LbaPLzFp4FhJ3+na5EuBBNYzFFiy1rr4PbsvOjSiBj5uNi3tPdl6Z0qcLzx9FPHlDyrn/YKitF90PzgaiKV9L+SwpZW9O9ExJc8eIG/UclhDWxprtQ10Nr67x563+TdW2SVa4XAkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778529; c=relaxed/simple;
	bh=URpenvV9Rt+T8G69Ur3IgNWDY5yw4LiL9+8zAjpJDmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D1zrP2Rc5CCMKmrv1YshPKwGLbTYjUKIjIpRP7htBxD1B1xUAfWyWt0LCRjaUQU7j57ALv1bbg7oFZYOYVAvodVPL0/9dtyqjNWZX+C3hSYM9yont08IS009qYm6HBAE7uDGqEMGZOikMhw9+esWOdA9rQRQ0aP27cJMUPOcHu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=el6/I4/F; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0SCSm4Xw3JoMxe7sjIax18TfesoOuScQTxwHPcjgqDl+UDSJuqHQiMsYD3AyrBW4BowEdhQalSiVbTNo8cA/0EOhHcjNaimHglxcHtvQSAuptjpVI+GDA3Bpow5YiYC1f6oX9x3iDpwKQneMQLX4XODlh13ukpMlWCsh0FJ05svJ/e+E+c7KqwBbf8VgMzEII6QuhcPzomCBfcTZByTqSp5B1AWYPJ13/67Jn+8rhoXPd/ntAIurX+4cO+xSnnQMwZeslQ9MjPU2MM48IxViarI+jbl7FOGc9VfIXhL28c/zQKOEd6am3cfbeEuPV+tZ2HjoX8w3BhQRqGWQYD4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WLIQyD5br9RP8KB4jPqS7G6JoITfgiVDYjNQ2KW8PI=;
 b=vN8gqqgFRx7cxjfwdDVmjx3dD9dp6orT8+BnRX4fiGJ0Ab31Uo8aU3e9KdPq0uFGw26XiByESux1vym9NVQWg0yr7ZpYDYGlj+nw9HWWFQZ/rAKwkId6/6ZFL0wtuLkbIRqUA/T/jhhP1cqk3jruwN/bDP+MtWRkOsneduyXER0KNqokLu96dCQ3aiP6kSZVmAehpzHVH6KwbOAdubn8iGzEIkBMbLx6hYKjDKon+BFSPpe0PCElvQZAA/XQPbmA2fTzOvpm4ID3B726o2PqJ729YC49zWltId4htXZPXwdpkUFVLr+eSjrHP7lWJKqJIdCq0rl/mMUKn9qlZQvICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WLIQyD5br9RP8KB4jPqS7G6JoITfgiVDYjNQ2KW8PI=;
 b=el6/I4/Fn2f4AchaPsChUkbWNxzKHp8M/N7OmDwGOzPMbEFGVIQowjeBA2a9HFEp6esFuT4wDqORI4Uv0tBCDaiNKOKGlqRQAFk9Ia5uj9ya2VTWd7/t0nXTGzNQShWEr3XmvfbmFEXKfP+owHux3PsIf1nei/S+R8hWWlpylhA=
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 12:15:19 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::e4) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 12:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 12:15:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 07:15:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 05:15:08 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 07:15:06 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH] dmaengine: dw-edma: Set status for callback_result
Date: Thu, 21 Aug 2025 17:45:05 +0530
Message-ID: <20250821121505.318179-1-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ccab72-78f9-4cfe-c65f-08dde0ac641c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TAG9S3KkcRPMnwn9/ynrCo20rqsovFiFoaH0oXr/X1W9k18lEJzVJgNfGdzr?=
 =?us-ascii?Q?i/tXs6NpI2rntJFfaK7unQQIDO4OKAk6VFBWcYqYA/TEx6ygllemyll1j/Wy?=
 =?us-ascii?Q?U9ifKsH5RnQPeTO+T/QUOcGx6kk+pYQan73UDW1Gue/T+O5YBm5Bpbn7A2qI?=
 =?us-ascii?Q?L++BXRYMaw4CjNj52A0UInjQphSQqIeS7FBuAs18deuctKiihuMCyQ0XeTSt?=
 =?us-ascii?Q?5baFd8wsun2N/tFMu5q7rGfk6ha8cVJvLihTZgwOwNz5rmWXfqs0laQGcrL+?=
 =?us-ascii?Q?P3n8lW2H2IvLdXlwsYFfUacVMiJwHviEHI+bk+X2N/TJqi5syjH+9TZCKMvi?=
 =?us-ascii?Q?RVpP8Kipqnklff3OuxqnM5hFO2J1rCR+FzEKwDsNZklUq5FBLStzBiBT8G98?=
 =?us-ascii?Q?Exaa0u7nErsUoP2zFx83EETdP3uOaavCHY6hE2eV7jtnoYx90S7BV80El94k?=
 =?us-ascii?Q?s+GjAhIXznflSVDIZ2cTnL06kvoVOrzjJP2LxAYd+DkR4b/C5Wr7+evpkE4q?=
 =?us-ascii?Q?88W71KotB7/b1lc1wSAMrSyrHJfjYqb9LOw2GvtB0U2iEURYGQbnpfM6mO+V?=
 =?us-ascii?Q?r+JFTPsIW4NPHVPY0EfrJ/La48r6wFP14m5o0KYuXaReNisMTvEPndkP4wja?=
 =?us-ascii?Q?NbcKq5B9U2nDPlreTGTI0J2u1JL15F4mHr8BZhGkd9j+pQScqc2ZfXw07s2O?=
 =?us-ascii?Q?8kwCpDJ4XU+JTgd5WY6b0HFQhfXdDkoNnPSXsDdbk8pxB9qorFliYORVCotd?=
 =?us-ascii?Q?sH4RUQ8C5dvE0wrTW/AnLtdzHKarPri+S67lbCYTPy/FaMVzjahJjMYicnTH?=
 =?us-ascii?Q?b4jrMRr603LE6ax1bDhVcOkF87IbkIIpC068cUF2MhPt7unoqCkt0eFutD/e?=
 =?us-ascii?Q?MQFC7eZvrZE2r5VbdNxcmVcLzYqA6UYgkuFs65S7H4lzqdJQifT3aaePY1hY?=
 =?us-ascii?Q?jRiFeiA8cRGu3SIWdauLn8xlLBoCq5ctrUuBHeEUNFZqf3pGs14m2H5RuCmC?=
 =?us-ascii?Q?F3Y4QC3odrdG75ghHbrUbkc26uoWuFYAe9sN5sAr4AhCEhctU41zmV9mw5rO?=
 =?us-ascii?Q?Jobg9fdMPyOLiDna6rMzjidp8PqrpxrRai34yqIzHRvL/Xp6XRCKU+Fcyzn8?=
 =?us-ascii?Q?fPrpSS0Uto60SSCP67Mo+AQohYcNlI7LHGFvq3eX8EAjdOj/z0LUaGUCo154?=
 =?us-ascii?Q?3IzgCQxuuQTGcZcPVjxSSk7nBPuLa2r53MN/X60pw+mSpFJ7Ox7fR1lzjEJ6?=
 =?us-ascii?Q?HJg++UxFG3iHo1Ey3a9nRZbIlu2SIhw2dVRtYJlC8EhrwJ6T0CtAjkQwm4hZ?=
 =?us-ascii?Q?/dmDLUDVPfWUA3jgrmsDgCS/dt4kbLXoZAsZ9dmipXBLo1peF2Qch25arL+0?=
 =?us-ascii?Q?O47XTRNDoj+yUQC1elgJdxFNtKEhcv2Bzgt03fUZAadtTJhmL+AOP+FUhUg7?=
 =?us-ascii?Q?r8pnokQ9uvqDcYFmqTf2yqHpDY19yv8g2PR/zmyqG8rZxeMqapcFywyy7xWn?=
 =?us-ascii?Q?wIGi8phPz0drEbA4QIS90FKf+bmIcSSSlAJH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 12:15:17.4325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ccab72-78f9-4cfe-c65f-08dde0ac641c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958

DMA Engine has support for the callback_result which provides
the status of the request and the residue. This helps in
determining the correct status of the request and in
efficient resource management of the request.
The 'callback_result' method is preferred over the deprecated
'callback' method.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f914f3..8e5f7defa6b6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -584,6 +584,25 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer);
 }
 
+static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
+					enum dmaengine_tx_result result)
+{
+	u32 residue = 0;
+	struct dw_edma_desc *desc;
+	struct dmaengine_result *res;
+
+	if (!vd->tx.callback_result)
+		return;
+
+	desc = vd2dw_edma_desc(vd);
+	if (desc)
+		residue = desc->alloc_sz - desc->xfer_sz;
+
+	res = &vd->tx_result;
+	res->result = result;
+	res->residue = residue;
+}
+
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
@@ -597,6 +616,8 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
 			if (!desc->chunks_alloc) {
+				dw_hdma_set_callback_result(vd,
+							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
 			}
@@ -633,6 +654,7 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
+		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
 	}
-- 
2.43.0


