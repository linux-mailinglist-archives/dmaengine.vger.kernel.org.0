Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0693D790E
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbfJOOsx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:48:53 -0400
Received: from mail-eopbgr730073.outbound.protection.outlook.com ([40.107.73.73]:60334
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfJOOsx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 10:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcH80y14evlZOz7TMHueQ7CYC4G1CRCb1YTfr1TUAcBvzScIRt3wR6oyUH+sbspfND+qUcpPoq5UeFFOHfeelj32ERBU7PYw35JTP8XpSVJpVRbr7HRD7/y+gD1fFjLQQA7x8EpC6UbxcU+3T1rF6o15lA7G9A3ZyMLRETvdZBCYb+bcMjkoj9Da2Whhj5VD1xFBRQcoCLATYyb3g7BypCr1YDzjt0nCIzUf4hsu/mmlDnruxZY3E1XWaY2DN2Gj1gPRdUGyEvuH0qGjbRhrah+w1Enx9kYvEA/S9+fGrKaChvPh9K6VpSa2k+Y3gF+8lz2S+/qZYiV4L7TS3Tz9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IROnSDfzJf9OEr8G/V2r07yWXK81Kt34Fi9wQVAxz7w=;
 b=jhW1vnjms+ZgGInrG+xNIRjCsdmXHaFplgCzrMOVEB5584IgnxtlXbCwhyevsDzrPvrzH+4lN9yXc2N3Xtz/Ch4cdwlyoIO1aFI25MgsrwX7NrZRhRxfcbnrzKj4zfpm2hltfmHX/pDInWgd0M6xbqKS3LcS/lW1jfZIm4jH476wzs5j6bN8PzoYaSH62Ykvg71AdIbKs03TG78UuKqHUb5sx+T2Z8GjDfS+7SzsBj2VrQOfCGp9LhyBjR/9OApUkjj4ikpbGPgzTIJ1ijh/e7oH8P8HtN11nHOm10KrF14l5Z3RTQij57LcDXDC+ADJqPq+vG8WnHyH9mMjaGliEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IROnSDfzJf9OEr8G/V2r07yWXK81Kt34Fi9wQVAxz7w=;
 b=csHpvdX9xJVfOLWeDgYYgiT4EYrHl1hDmfu/xBj4WorJwLzJ10GhRth9287ZU6Sv3cKo/6eyCVJQFbFwyzr/NdpQoU1tqytuwWw543PgN6qEAFBZHrPh5cjmTci1nzpYYBeN39kl0+3KE6VRD89voWyBM0vrEILm7YugHvtvbNA=
Received: from CH2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:4e::15)
 by DM6SPR01MB0033.namprd02.prod.outlook.com (2603:10b6:5:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.22; Tue, 15 Oct
 2019 14:48:49 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by CH2PR02CA0005.outlook.office365.com
 (2603:10b6:610:4e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 15 Oct 2019 14:48:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 14:48:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO80-0006Fy-Dg; Tue, 15 Oct 2019 07:48:48 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7v-0002At-6c; Tue, 15 Oct 2019 07:48:43 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9FEmg36014675;
        Tue, 15 Oct 2019 07:48:42 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iKO7t-0002AI-PH; Tue, 15 Oct 2019 07:48:41 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 17CC7101130; Tue, 15 Oct 2019 20:18:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next 5/7] dmaengine: xilinx_dma: Add callback_result support
Date:   Tue, 15 Oct 2019 20:18:22 +0530
Message-Id: <1571150904-3988-6-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No-2.343-7.0-31-1
X-imss-scan-details: No-2.343-7.0-31-1;No-2.343-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(2906002)(446003)(107886003)(305945005)(50226002)(103686004)(47776003)(486006)(70586007)(36756003)(106002)(356004)(6666004)(6266002)(11346002)(426003)(8676002)(126002)(476003)(2616005)(70206006)(4326008)(336012)(42186006)(16586007)(76176011)(50466002)(5660300002)(316002)(186003)(8936002)(51416003)(14444005)(26005)(48376002)(478600001)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6SPR01MB0033;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75f9b4a-775a-4a5d-da4c-08d7517ec9e0
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0033:
X-Microsoft-Antispam-PRVS: <DM6SPR01MB00334E46A135EFFDEC48F61FC7930@DM6SPR01MB0033.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRikGQH+c4KDjj1/WsahQKxETSpDYFl/ArIijGam8P0KIjrq9UxR49x6k7hN/PBL2UOm+1zPO/bAHMS5tTgAsrCzm84ulh1ZE6ctrP9AIEpl28E+y9vPPtnWhrhXxkI+3TiELgrTvl3wSKXLZY12Ea8YnJ7t/gMLwOBd8gNEQToxZaWGrYhWE8D0KU31VmoymVLl8vMwLHzNj1jQ1JIpmnpIjLYKZXv3UqnB2Q969m/Sl8bVM+/+x+UBRaiETk+yjsR2vdoYfz+EWBH+Xzt8YvhhpwGPqyFLNvB8909JIvGTOU25pRNiWSYN5q8m5sKziza2LJKvKE2OfUCJANOaMdzJKNVGmDp/ZCaJCL0QlYm+YI1ICl1qX+WqniWehKtrqELIU88N+9DTvco7oltvParNSWzt/2a/UQ/L/beMgR8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 14:48:48.9008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75f9b4a-775a-4a5d-da4c-08d7517ec9e0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6SPR01MB0033
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nicholas Graumann <nick.graumann@gmail.com>

Take advantage of dmaengine_desc_get_callback_invoke which allows either
a callback or callback_result to be specified. This can be useful when
using the AXI DMA transfer unknown quantities of data where the residue
contained in the result can be used to calculate the number of bytes
transferred.

Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
Invoke xilinx_dma_get_residue only for valid combination.
---
 drivers/dma/xilinx/xilinx_dma.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8c10686..932407a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -303,12 +303,16 @@ struct xilinx_cdma_tx_segment {
  * @segments: TX segments list
  * @node: Node in the channel descriptors list
  * @cyclic: Check for cyclic transfers.
+ * @err: Whether the descriptor has an error.
+ * @residue: Residue of the completed descriptor
  */
 struct xilinx_dma_tx_descriptor {
 	struct dma_async_tx_descriptor async_tx;
 	struct list_head segments;
 	struct list_head node;
 	bool cyclic;
+	bool err;
+	u32 residue;
 };
 
 /**
@@ -859,6 +863,8 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 	spin_lock_irqsave(&chan->lock, flags);
 
 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
+		struct dmaengine_result result;
+
 		if (desc->cyclic) {
 			xilinx_dma_chan_handle_cyclic(chan, desc, &flags);
 			break;
@@ -867,9 +873,20 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 		/* Remove from the list of running transactions */
 		list_del(&desc->node);
 
+		if (unlikely(desc->err)) {
+			if (chan->direction == DMA_DEV_TO_MEM)
+				result.result = DMA_TRANS_READ_FAILED;
+			else
+				result.result = DMA_TRANS_WRITE_FAILED;
+		} else {
+			result.result = DMA_TRANS_NOERROR;
+		}
+
+		result.residue = desc->residue;
+
 		/* Run the link descriptor callback function */
 		spin_unlock_irqrestore(&chan->lock, flags);
-		dmaengine_desc_get_callback_invoke(&desc->async_tx, NULL);
+		dmaengine_desc_get_callback_invoke(&desc->async_tx, &result);
 		spin_lock_irqsave(&chan->lock, flags);
 
 		/* Run any dependencies, then free the descriptor */
@@ -1425,6 +1442,13 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		if (chan->has_sg && chan->xdev->dma_config->dmatype !=
+		    XDMA_TYPE_VDMA)
+			desc->residue = xilinx_dma_get_residue(chan, desc);
+		else
+			desc->residue = 0;
+		desc->err = chan->err;
+
 		list_del(&desc->node);
 		if (!desc->cyclic)
 			dma_cookie_complete(&desc->async_tx);
-- 
2.7.4

