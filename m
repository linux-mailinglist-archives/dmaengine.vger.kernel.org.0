Return-Path: <dmaengine+bounces-3437-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653CD9ACA1B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 14:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214CF283644
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622A41AB539;
	Wed, 23 Oct 2024 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iTLtf4GS"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9411AAE31
	for <dmaengine@vger.kernel.org>; Wed, 23 Oct 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687016; cv=fail; b=RuZimvCeGPzyZXdCl6zPFJMhYl2aKZPxyWUrzgjTTHElhafArISVMzur7Iz8mhsrUd1Ryu6ZjMAppcPV6y9g2TGi1GYeQwTmDn4HnizkSkDrW7FbTPJCCfVFQ0HtxaHH6ICDTGv6ImrJcB17e4OfWWc7izvv/5WPjghv4vFoqFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687016; c=relaxed/simple;
	bh=0DtXHPJuQy2PHRpNHMdFZk/EUe1L09W/CRdxPK6priw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTEIAPZkg3s0Qcb/tilIOasRUTqKK1Hb6f4phrFdQC19ZQ8Rp9FkTu105rU57BayyVMx21zueH8h/KXpqmXWT1S2JUu2xY00eD0yGIWKjOc4+HweObuHRPAp2bkQloHy3j3pMLeRL7+JD8vQ7KNdhRKGeEx8Ak/+pDXOYtkRHSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iTLtf4GS; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5PFIUWIVU/zuoq5M5Z4xnJJNaZ4ioJy6m8SN9mjjV4PEG75vCQk2cBSsCmARHL7Ae7SH8CAfaOyASmuGHfqFe6oq+O5xv3epLZOLK9mrDQa+pTlSqrVNoWZkdeKZ8Vr5tCF91KCM/HcsWLYdzoY8kr9ShnHNvUlDQd72gW3WQLRRsTu6hxdrGv+4XIb7jXbAyW3zHORJaYoQeJQtx5jXDCmdaLRCgWpHvvyAJCNRI0QnuMnNirQ0KT2SEa6X/fDAr76UK1pylVndhk0p/H9lHwvrV2GJqKiefROpU7utOoJco1hP0cXMxL2X++aAsu6/HlDVDsv9g5ksU4ih1D+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1BX+ylMJuA51jMPVMzBd1noOfpfcERitMlIGXkPfrA=;
 b=rdh8nIVryZX1ygivO236w4/QCckseHq1mG5dhzi8ILH3AI7RZcFOcb9BFQyK8QLI4tn5Hy7uX7PZkFxXJb2OPr20231NWVlfY0Hf47K1mYR1cNoQE/kzSCrmkVGvGezNHrfslz8Ni0MzkIT/k5eH3JyPHOpy6GTtY7E/Cck5XdiDX6QL6nKATQ6Ai9jzgNgal8j1303Q5Hno0yv+SJJIm+j0YwscphFx42JvFVqvj7cOEe6iLbFiJMGxtlvykg1ce1xXSDmgqfcD1WK1atVrXggTMhgkUY7BMU9RtvvYDFL2MwKAvPkcUAQuu++/dleUXQljS19MB+bbYZFuvhOdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1BX+ylMJuA51jMPVMzBd1noOfpfcERitMlIGXkPfrA=;
 b=iTLtf4GSM+3nyx9TmCWhzDPX7/iA3J5oP6Hn0pOK/CGF588RHutRRGl3EqDaF7EpwRsOJWhW+yVnSaOtXBBMW9Uj5MHR5u11HISsZLB9duZTo3iT6pEsFga8/3ikY90axRvJJzuaalwC5/S86EtsxTnrYgXswHlc2wWK+XRcX3g=
Received: from MW4PR03CA0077.namprd03.prod.outlook.com (2603:10b6:303:b6::22)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 12:36:47 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::aa) by MW4PR03CA0077.outlook.office365.com
 (2603:10b6:303:b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 12:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 12:36:46 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 07:36:44 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, <helgaas@kernel.org>,
	<pstanner@redhat.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v7 3/6] dmaengine: ptdma: Extend ptdma to support multi-channel and version
Date: Wed, 23 Oct 2024 18:06:10 +0530
Message-ID: <20241023123613.710671-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
References: <20241023123613.710671-1-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c60ed9-c81c-43c1-42c7-08dcf35f5bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4LTsiBFAoWdhE9AHb2aAaUgX+VW/6qOxDoB0rN8AM1qe8hL4xGi5DReTujO?=
 =?us-ascii?Q?la9npTdzFtlJFnUXvom060DMVNC1n6iLv8R3YlonMdqWQeAs3MPr1mNzUunW?=
 =?us-ascii?Q?lC5DjKK40omfvABe92OLVBYa+9XAbkV1H1rpFr5hNeCNBCbZH1aBjj0/q8Aa?=
 =?us-ascii?Q?kyxlrCa73mI/uGtm0xnnFBEmPLMrNIoOehITOI/nSa7zdWWNwq9iJUQ4TbY4?=
 =?us-ascii?Q?cd5+eVACC5r3yVu3TSGmWAREPZCxyiMZPhRNl8PyXV2QYEZmq1Lt/7GTWUpj?=
 =?us-ascii?Q?qnRTV08DFEP8AH/5P58PHj6LYmVRFaB3aZiPQbA7fSCTovJVW9koN6yHN2mj?=
 =?us-ascii?Q?eHFH3SjgHYlie12g0RDb0QtBdY59M7AHAICEvR08cSk2x67jPVKJ+RxWDDF5?=
 =?us-ascii?Q?M1oPc0pVQi8GAhaPulLZr8u9xEaLXwCCNX4WnsBDnHcfp4a0NVC5Zbk6CJTH?=
 =?us-ascii?Q?/KSP+PfG/pomGbB8bURwGhnc4swKhVwk1unIkl1AL5+SdJVZGujgrqyk+fiv?=
 =?us-ascii?Q?vGnEVQCWKib4frVOTWwOTkcs//8kk2UY4yhC12shA544Ur6kPGTutLN1EYRW?=
 =?us-ascii?Q?C3c3k8fwdxiFniKVRvU4pld/Z+JhePTkVy1bJRSlRdxpi7wDI9FHBf10edKR?=
 =?us-ascii?Q?bigkK7gAGxXhc3NIa5AvWmDUpCD02ZjYuX3yFsWKPxvIy9v9Kp8hH3du7d9O?=
 =?us-ascii?Q?J7Ihmq66NQ9j/CRvL8E1ToZwz30P1YjSKVA+iMg/QBxPjVq+OkvLPKYItwpk?=
 =?us-ascii?Q?KMd46q9R/k1n75kjUFP9Y3VFRlJgM5oeVwQb2znuyFn3X6OiBgmeeCDE0/5z?=
 =?us-ascii?Q?2CIXU/WNAkl86uj+Mh37g/OEnVhO7yx0Xo5pI39BUboFeSknMKYoM/r64Zki?=
 =?us-ascii?Q?BVMX994M1UOPGnMurw9kgmXkzKFSuztzX08SP9jVPHXwPI/LYCP+biDVaNDV?=
 =?us-ascii?Q?z7AfGT5T4i38RgA/scBJYzUxQtwsnLWIOe2t34FhujzOjdVi+1Z6+yl0fvvD?=
 =?us-ascii?Q?A2j6SM0ybGxHbTMSvDYdZO8kaBMp0f73n1rIxvgZX4EfRSh+TkOFpGE7jRc/?=
 =?us-ascii?Q?6UEUgWVLomSc017MdPrFngYI6gnSuIhANgLn4BOGQDWMcdc7VTCrFXgk5wdg?=
 =?us-ascii?Q?sOHdUnmge6c2AmvffN+HMPfOcGf1xZA2Gj+B/bW8xCnLS+nCoyduKZJdCOBt?=
 =?us-ascii?Q?HkgAHUPBxcmHi6/EtoaK9UIahUpfiKrtiyaOK3g7tBZyZKY/JNJNyt0YQJF5?=
 =?us-ascii?Q?ErzGJwm/AA0ZcuanY47PysJSj72K4LeQZ5ZlF5af6DW0r0Us6ItisDCoRmFf?=
 =?us-ascii?Q?WNAEA2hVvwNCX8hHX9BHPS2rDvSwLnEz8VQzEWDbDjGsbH6KX1YW3U0W28OH?=
 =?us-ascii?Q?1ZWCuUfAKAsPXO3TgVSOEQ7DTMfU4+gEK7Y/Fp3G3o5g+m7JKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 12:36:46.7878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c60ed9-c81c-43c1-42c7-08dcf35f5bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

To support multi-channel functionality with AE4DMA engine, extend the
PTDMA code with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma.h         |   2 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 105 +++++++++++++++++++-----
 drivers/dma/amd/ptdma/ptdma.h           |   2 +
 3 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 4a1dfcf620c1..92cb8c379c18 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -34,6 +34,8 @@
 #define AE4_Q_BASE_H_OFF		0x1c
 #define AE4_Q_SZ			0x20
 
+#define AE4_DMA_VERSION			4
+
 struct ae4_msix {
 	int msix_count;
 	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 77fe709fb327..e2d4bc8aa1de 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -93,7 +93,24 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
 	kmem_cache_free(pt->dma_desc_cache, desc);
 }
 
-static int pt_dma_start_desc(struct pt_dma_desc *desc)
+static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma_chan *chan)
+{
+	struct ae4_cmd_queue *ae4cmd_q;
+	struct pt_cmd_queue *cmd_q;
+	struct ae4_device *ae4;
+
+	if (pt->ver == AE4_DMA_VERSION) {
+		ae4 = container_of(pt, struct ae4_device, pt);
+		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
+		cmd_q = &ae4cmd_q->cmd_q;
+	} else {
+		cmd_q = &pt->cmd_q;
+	}
+
+	return cmd_q;
+}
+
+static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
 {
 	struct pt_passthru_engine *pt_engine;
 	struct pt_device *pt;
@@ -104,7 +121,9 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc)
 
 	pt_cmd = &desc->pt_cmd;
 	pt = pt_cmd->pt;
-	cmd_q = &pt->cmd_q;
+
+	cmd_q = pt_get_cmd_queue(pt, chan);
+
 	pt_engine = &pt_cmd->passthru;
 
 	pt->tdata.cmd = pt_cmd;
@@ -199,7 +218,7 @@ static void pt_cmd_callback(void *data, int err)
 		if (!desc)
 			break;
 
-		ret = pt_dma_start_desc(desc);
+		ret = pt_dma_start_desc(desc, chan);
 		if (!ret)
 			break;
 
@@ -234,7 +253,10 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_passthru_engine *pt_engine;
+	struct pt_device *pt = chan->pt;
+	struct ae4_cmd_queue *ae4cmd_q;
 	struct pt_dma_desc *desc;
+	struct ae4_device *ae4;
 	struct pt_cmd *pt_cmd;
 
 	desc = pt_alloc_dma_desc(chan, flags);
@@ -242,7 +264,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 		return NULL;
 
 	pt_cmd = &desc->pt_cmd;
-	pt_cmd->pt = chan->pt;
+	pt_cmd->pt = pt;
 	pt_engine = &pt_cmd->passthru;
 	pt_cmd->engine = PT_ENGINE_PASSTHRU;
 	pt_engine->src_dma = src;
@@ -253,6 +275,14 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 
 	desc->len = len;
 
+	if (pt->ver == AE4_DMA_VERSION) {
+		ae4 = container_of(pt, struct ae4_device, pt);
+		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
+		mutex_lock(&ae4cmd_q->cmd_lock);
+		list_add_tail(&pt_cmd->entry, &ae4cmd_q->cmd);
+		mutex_unlock(&ae4cmd_q->cmd_lock);
+	}
+
 	return desc;
 }
 
@@ -310,8 +340,11 @@ static enum dma_status
 pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
 {
-	struct pt_device *pt = to_pt_chan(c)->pt;
-	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
+	struct pt_dma_chan *chan = to_pt_chan(c);
+	struct pt_device *pt = chan->pt;
+	struct pt_cmd_queue *cmd_q;
+
+	cmd_q = pt_get_cmd_queue(pt, chan);
 
 	pt_check_status_trans(pt, cmd_q);
 	return dma_cookie_status(c, cookie, txstate);
@@ -320,10 +353,13 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 static int pt_pause(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+	struct pt_device *pt = chan->pt;
+	struct pt_cmd_queue *cmd_q;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	pt_stop_queue(&chan->pt->cmd_q);
+	cmd_q = pt_get_cmd_queue(pt, chan);
+	pt_stop_queue(cmd_q);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
 	return 0;
@@ -333,10 +369,13 @@ static int pt_resume(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_dma_desc *desc = NULL;
+	struct pt_device *pt = chan->pt;
+	struct pt_cmd_queue *cmd_q;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	pt_start_queue(&chan->pt->cmd_q);
+	cmd_q = pt_get_cmd_queue(pt, chan);
+	pt_start_queue(cmd_q);
 	desc = pt_next_dma_desc(chan);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 
@@ -350,11 +389,17 @@ static int pt_resume(struct dma_chan *dma_chan)
 static int pt_terminate_all(struct dma_chan *dma_chan)
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
+	struct pt_device *pt = chan->pt;
+	struct pt_cmd_queue *cmd_q;
 	unsigned long flags;
-	struct pt_cmd_queue *cmd_q = &chan->pt->cmd_q;
 	LIST_HEAD(head);
 
-	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
+	cmd_q = pt_get_cmd_queue(pt, chan);
+	if (pt->ver == AE4_DMA_VERSION)
+		pt_stop_queue(cmd_q);
+	else
+		iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vchan_get_all_descriptors(&chan->vc, &head);
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
@@ -367,14 +412,24 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
 
 int pt_dmaengine_register(struct pt_device *pt)
 {
-	struct pt_dma_chan *chan;
 	struct dma_device *dma_dev = &pt->dma_dev;
-	char *cmd_cache_name;
+	struct ae4_cmd_queue *ae4cmd_q = NULL;
+	struct ae4_device *ae4 = NULL;
+	struct pt_dma_chan *chan;
 	char *desc_cache_name;
-	int ret;
+	char *cmd_cache_name;
+	int ret, i;
+
+	if (pt->ver == AE4_DMA_VERSION)
+		ae4 = container_of(pt, struct ae4_device, pt);
+
+	if (ae4)
+		pt->pt_dma_chan = devm_kcalloc(pt->dev, ae4->cmd_q_count,
+					       sizeof(*pt->pt_dma_chan), GFP_KERNEL);
+	else
+		pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
+					       GFP_KERNEL);
 
-	pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
-				       GFP_KERNEL);
 	if (!pt->pt_dma_chan)
 		return -ENOMEM;
 
@@ -416,9 +471,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	chan = pt->pt_dma_chan;
-	chan->pt = pt;
-
 	/* Set base and prep routines */
 	dma_dev->device_free_chan_resources = pt_free_chan_resources;
 	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
@@ -430,8 +482,21 @@ int pt_dmaengine_register(struct pt_device *pt)
 	dma_dev->device_terminate_all = pt_terminate_all;
 	dma_dev->device_synchronize = pt_synchronize;
 
-	chan->vc.desc_free = pt_do_cleanup;
-	vchan_init(&chan->vc, dma_dev);
+	if (ae4) {
+		for (i = 0; i < ae4->cmd_q_count; i++) {
+			chan = pt->pt_dma_chan + i;
+			ae4cmd_q = &ae4->ae4cmd_q[i];
+			chan->id = ae4cmd_q->id;
+			chan->pt = pt;
+			chan->vc.desc_free = pt_do_cleanup;
+			vchan_init(&chan->vc, dma_dev);
+		}
+	} else {
+		chan = pt->pt_dma_chan;
+		chan->pt = pt;
+		chan->vc.desc_free = pt_do_cleanup;
+		vchan_init(&chan->vc, dma_dev);
+	}
 
 	ret = dma_async_device_register(dma_dev);
 	if (ret)
diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
index 7a8ca8e239e0..0a7939105e51 100644
--- a/drivers/dma/amd/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -184,6 +184,7 @@ struct pt_dma_desc {
 struct pt_dma_chan {
 	struct virt_dma_chan vc;
 	struct pt_device *pt;
+	u32 id;
 };
 
 struct pt_cmd_queue {
@@ -262,6 +263,7 @@ struct pt_device {
 	unsigned long total_interrupts;
 
 	struct pt_tasklet_data tdata;
+	int ver;
 };
 
 /*
-- 
2.25.1


