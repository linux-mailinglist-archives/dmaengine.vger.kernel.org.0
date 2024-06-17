Return-Path: <dmaengine+bounces-2387-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D47390AAB9
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 12:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446DA284C63
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412518FDAE;
	Mon, 17 Jun 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7P7x22Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D618C326
	for <dmaengine@vger.kernel.org>; Mon, 17 Jun 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618689; cv=fail; b=OQbQhZjfsj7ThDtI4Z4Zpx8g0bU6a2WeXba/mT0PmR44lxqPWqkCkwxs2ZUfRTFvpknXUQc89aE5D7Gesk8zm/5j5/9P20GwfcW2E1jtMfPRok7mZK9oV+/mTy+RxraiUQEd3juhFQ5blDLgZKKmoEezPYByh9m9A2NA5NLwoQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618689; c=relaxed/simple;
	bh=GJdCAMcp5b/y9yqRWXiHjD5Ho1F7GWfORT266acLJxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHeclC08B0cFKBscBiQdHKQFZy/knwWIvR9Rs7Xy7TzW/xLDsyYheP1b8yMV4zcfklai8heHg8eYX/S5zR9vbDwxx4YQZTj+0LpXHE2N1Aga+AIXFbQTKIUbk+lIEOii+L8A4BMnx/Sk8DuSviWLzJ4Ily8MTki/4c13gK+9rMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M7P7x22Z; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmqLpjrxMYPs+mncDDU9j9AqqzpaxIW7e6znOQz9tAvb02h6p2CBuJ1o/Abr8/KiCkhOjpiDFRkw6WhPaEuj7FVHeBb1tfj3j0DhfUwmEs2FWQLIvoGuppJKlomHFmlrbUAfLY124NgYlbqNBJImWOoJdXN8yyNeIO6wZrQ4TlbO7CLYtyANRaIZU0K6fo2TkW9lrJQBRdenTUjCTwlJgLgDwMDmxDIQh16NAiOzwjvjvJl7qPsFuaMwoxm2liIiBuliox1eiwC0eo0XBH9UYO8cIUL08yo3Y7Z99qT7xS/3qTQDQI7KP14MV5/kakPrtyIbkZhqG48wRr+5jjnvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgjaKKJoqv9HPDvKiBAf/IVsK7ldU9fAser3h1hU9jA=;
 b=Oxx5wET40gOllBKGcNhunZojHwSK9LAEtWc+80PUkKPnITbb1fahEGM/lBFmMEtixpm8KTboMOGGMjN5sJFV3vunF/L7axC4sAK/pHunogxBHE+oz0YlVv8FCEFwk7f8Kywno3cTDk7/SxCR3w3IjGEs8bzuWgjM+wWWu0W+WWkyltrzWnviAspPmvUlba4ReV7kQwM+RYTOrjKNvcyt2JdzDxHw7gAvuDVqVz77wxcFoTP3pMy53cAU+NskiDkDj7hZ9ZR0FuZHUquK4uerteWz8M+gL31vUlhL7wlHva1Q6AbTJeBehUyFFHFj1pvwCtLD8CA2GRzfdKz3quwZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgjaKKJoqv9HPDvKiBAf/IVsK7ldU9fAser3h1hU9jA=;
 b=M7P7x22ZKWx4HrV6Sb5634cLfcWcdK+4GTzYYwrBJZTvjWOWf6yRky5Ux4zMBjnHzuYLECosBIWo0C579KBjSDUp4HuW+yIPVOFKSWeQs7tDzyFBGBMBidbOCX/aESMZrRZwTxtGKCtW9rJhaPAxVDCv/3Z6GrabJQeP4/ZLQZE=
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 10:04:44 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::e0) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 10:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 10:04:43 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 05:04:40 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <Frank.li@nxp.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 4/7] dmaengine: ptdma: Extend ptdma to support multi-channel and version
Date: Mon, 17 Jun 2024 15:33:56 +0530
Message-ID: <20240617100359.2550541-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
References: <20240617100359.2550541-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|MW3PR12MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: b3981478-81c8-46f8-a73f-08dc8eb4e91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?byrtIK5LZmwmqC/YzgGBW93UwK8rza4uBbkxjov0cZL+D988II28pJMNf8kg?=
 =?us-ascii?Q?TFLYdvpvBbBujE2BDC7mO31Q7n5xAK7ydiG5qztVet5vr72OIcCVEyR9nECY?=
 =?us-ascii?Q?KZg6cNKOevuY48Ylf1jD8bXkDcwIaQAuPWjeTnv1ITNyO0Qdn+IXPAfYa8ib?=
 =?us-ascii?Q?KSJ6ukijdyRqh6ixFcXuFSiRFrgU5phFsm166iloKJxQWiqH6DltHH7UsFDF?=
 =?us-ascii?Q?iO3gUASmiOtDjcYhtJIMy23leXFEG8kUKyzcZoaGVwNt2qj8VBzycElSSrTT?=
 =?us-ascii?Q?fc36qd2NfFep/6Sj4r1QUTj6h8sw2w8+G8Lxma6CsarRa6wOLeUqqOs2/bq0?=
 =?us-ascii?Q?nez7wOlWx2jEJBTkG5Xa+13GuZYBAuvj2ApVhS27Zq3Gx4trKuM9Rf/4D694?=
 =?us-ascii?Q?ILpG3tk70irTnLwlTp12DGJwxY6s/QIg757/couE5999vRsbeBtFp6SBoy5R?=
 =?us-ascii?Q?nuSHJ7op29f96f6OIrcZo53boJpDlRJvQ7kjqx0wd1lHjAcQflRvEbsrt90G?=
 =?us-ascii?Q?i0LB/VJ0+yN3SCi1VPpKz/RouIntFKLVxOqHaQOlCwFl9hLfU5Hp5qSjSb07?=
 =?us-ascii?Q?xKZYLtMKimszCthPCjlk9PGDM64BFMuSyO0HfretxQ7M8lv24wFaQ2LrXADG?=
 =?us-ascii?Q?qnkinXDyaUhRXUoUfrs9ex+WmJuc3tSmtcfGGPplYsTM9jkFXz5g+D+5ox+K?=
 =?us-ascii?Q?ISLH6myuatKEgmm600POEeCKm26ivMAdccv6ZCKUjdrW6uKAtyhc+ABE26pd?=
 =?us-ascii?Q?jEuSQ7NW3wVadCEIvWmLhWQPOeUESFyu01zTj1BzU5INseINrsUUO8jKYJYL?=
 =?us-ascii?Q?ahjMgySUGPm2DyuhcPx0YEZk6E+UqS43DUZvrEkLGBPyOVsY8tZcaZMyod+2?=
 =?us-ascii?Q?pjfz+8dnwYQpmCuRUJks0zkDUbRPJc8i8czykNdXS49wXfjG8pv5EwFhTo+T?=
 =?us-ascii?Q?XMncKKsXnJqT15r7RaJ93Ek8yXaie5+JU5XOi0iQrwG29UK/j1PI4cAE+EJY?=
 =?us-ascii?Q?GCyh0+sJ44CdYjOeSwFGDtY4/PVe+yiaaeQ57qVFaHTpZZtX8HfM9Ykmah6H?=
 =?us-ascii?Q?ajOBal5zUrMj2zSAQPVBFrmcsn1zesBlQQzjgfROTTixLdJnqKuonImrBYNH?=
 =?us-ascii?Q?0G2GQxxakmbbTRQt8FjMU+K5ZMJBBX/gCSQx3TP6i1fvD/VGZ7wP+SS5F7tw?=
 =?us-ascii?Q?TV0QSRbnirwuUKqYoYwdeu8ydP8L64teaRAFoDusPfN4DnLl2kwxQI7lK/KE?=
 =?us-ascii?Q?+9T3pipdp86xwqDOCOiu458CoMWI/tpwCQXcfMouF3BwJ3ks9oCsuKEtSBvo?=
 =?us-ascii?Q?ERvmRaDjgxjTXFSLW4TKgq8U8eM4yx4/KQAg+W3zwW0vR9xAW61b7Je8o+Kh?=
 =?us-ascii?Q?4OagE4F9Jx8D10X5GYD1DoZhIBz/ASjI3i68CgD6oOOJpHxrcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 10:04:43.5082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3981478-81c8-46f8-a73f-08dc8eb4e91a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427

To support multi-channel functionality with AE4DMA engine, extend the
PTDMA code with reusable components.

Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/dma/amd/ae4dma/ae4dma.h         |   1 +
 drivers/dma/amd/common/amd_dma.h        |   1 +
 drivers/dma/amd/ptdma/ptdma-dmaengine.c | 105 +++++++++++++++++++-----
 drivers/dma/amd/ptdma/ptdma.h           |   2 +
 4 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
index 24b1253ad570..4e4584e152a1 100644
--- a/drivers/dma/amd/ae4dma/ae4dma.h
+++ b/drivers/dma/amd/ae4dma/ae4dma.h
@@ -15,6 +15,7 @@
 #define MAX_AE4_HW_QUEUES		16
 
 #define AE4_DESC_COMPLETED		0x3
+#define AE4_DMA_VERSION			4
 
 struct ae4_msix {
 	int msix_count;
diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
index 44251918f157..40f18fc912ae 100644
--- a/drivers/dma/amd/common/amd_dma.h
+++ b/drivers/dma/amd/common/amd_dma.h
@@ -21,6 +21,7 @@
 #include <linux/wait.h>
 
 #include "../ptdma/ptdma.h"
+#include "../ae4dma/ae4dma.h"
 #include "../../virt-dma.h"
 
 void pt_start_queue(struct pt_cmd_queue *cmd_q);
diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
index 66ea10499643..90ca02fd5f8f 100644
--- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
@@ -43,7 +43,24 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
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
@@ -54,7 +71,9 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc)
 
 	pt_cmd = &desc->pt_cmd;
 	pt = pt_cmd->pt;
-	cmd_q = &pt->cmd_q;
+
+	cmd_q = pt_get_cmd_queue(pt, chan);
+
 	pt_engine = &pt_cmd->passthru;
 
 	pt->tdata.cmd = pt_cmd;
@@ -149,7 +168,7 @@ static void pt_cmd_callback(void *data, int err)
 		if (!desc)
 			break;
 
-		ret = pt_dma_start_desc(desc);
+		ret = pt_dma_start_desc(desc, chan);
 		if (!ret)
 			break;
 
@@ -184,7 +203,10 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 {
 	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
 	struct pt_passthru_engine *pt_engine;
+	struct pt_device *pt = chan->pt;
+	struct ae4_cmd_queue *ae4cmd_q;
 	struct pt_dma_desc *desc;
+	struct ae4_device *ae4;
 	struct pt_cmd *pt_cmd;
 
 	desc = pt_alloc_dma_desc(chan, flags);
@@ -192,7 +214,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 		return NULL;
 
 	pt_cmd = &desc->pt_cmd;
-	pt_cmd->pt = chan->pt;
+	pt_cmd->pt = pt;
 	pt_engine = &pt_cmd->passthru;
 	pt_cmd->engine = PT_ENGINE_PASSTHRU;
 	pt_engine->src_dma = src;
@@ -203,6 +225,14 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
 
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
 
@@ -260,8 +290,11 @@ static enum dma_status
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
@@ -270,10 +303,13 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
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
@@ -283,10 +319,13 @@ static int pt_resume(struct dma_chan *dma_chan)
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
 
@@ -300,11 +339,17 @@ static int pt_resume(struct dma_chan *dma_chan)
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
@@ -317,14 +362,24 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
 
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
 
@@ -366,9 +421,6 @@ int pt_dmaengine_register(struct pt_device *pt)
 
 	INIT_LIST_HEAD(&dma_dev->channels);
 
-	chan = pt->pt_dma_chan;
-	chan->pt = pt;
-
 	/* Set base and prep routines */
 	dma_dev->device_free_chan_resources = pt_free_chan_resources;
 	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
@@ -380,8 +432,21 @@ int pt_dmaengine_register(struct pt_device *pt)
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
index b4f9ee83b074..3ef290b78448 100644
--- a/drivers/dma/amd/ptdma/ptdma.h
+++ b/drivers/dma/amd/ptdma/ptdma.h
@@ -184,6 +184,7 @@ struct pt_dma_desc {
 struct pt_dma_chan {
 	struct virt_dma_chan vc;
 	struct pt_device *pt;
+	unsigned int id;
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


