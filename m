Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182A9AA927
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfIEQhf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:37:35 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:49613
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389100AbfIEQhe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:37:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WW0TxZ4TK35G5GN9yMtwQVjHsMrm1ISw5l0xZ+lrp5RFJLYIBfOH9+E5xgP+bp8k3aTpCP59zhupafbe39weroxewtFESB7AwpavE6QjNS/Zv2Wx94+FMOiHdMRVfHRS3Cz6mjBHpoKasLFHOeMLA8dUCLZ0mRKppGJ6M2E4m7vl+kOhQul6N5YvQQLtm6snDxOkyA4arsebu02W4yfNI7A1Y5DY/GGQkRDJ2oFdiqKtKyO9RpZEHgaJXrAYAvqIE8nf8qk7WbqoIPsgD6v0Hk2jNMYK8CChxHW30J9MyAoKQZJwO7Zqp+j0nDb7R5jbQU2xhsFbxzMRO9CyZXniaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSPk1cCWdw6GZz9xqLyWtYZYDXTHf2u2ZmC95ltReDE=;
 b=QBBjWHd3ZH37PuJ9wY3ziWEYyVuDbxX/ws4fjLXHqWdnC62nGbXGYBKSEOs0HnnjaZniD/M0Lo/XS6gWlnR7nrtTsU9WyDaby5FNW2V1TwE/5D5fNVKarKw74v5J0l6Oe87YKmYwtC/YhRoh6RpXo3tn/wD8Jum0TXEDLkncm+LjvUIJ5mw2ViP/8DqMdXcvrIlk4b6/oNy+2nWljYeUiIw2CG8j+EIMHLygqCgNrkdPQ3u7UjFfA5S8IrzGUoR6/9nng81LXZCtRxTfmgnTERZyMOYMn3+T1zjoDnLNbBjnlNZfSaND38GZs0GSOjdeoDc/9reXn14+8oXlLktN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSPk1cCWdw6GZz9xqLyWtYZYDXTHf2u2ZmC95ltReDE=;
 b=q5M9XHV2yEsiVOK+ESTmLO/oB1oPcAUKUFMQHB5krAUawSSgP2DFf7w9jvoCO+09sFWTT/aZP/fHXpx82MDv4QNHHF9Bf9jaJpx+Jn621yvA20xp3h4d/ybimjXvXCp5MIPDxqPbCgXmrLt3SFEHM30Qwe1ZfhkY9YxCbPQPTQk=
Received: from BYAPR02CA0026.namprd02.prod.outlook.com (2603:10b6:a02:ee::39)
 by BN7PR02MB5316.namprd02.prod.outlook.com (2603:10b6:408:2b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 5 Sep
 2019 16:37:30 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BYAPR02CA0026.outlook.office365.com
 (2603:10b6:a02:ee::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15 via Frontend
 Transport; Thu, 5 Sep 2019 16:37:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 16:37:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59478 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ulD-0006fV-Fe; Thu, 05 Sep 2019 09:37:27 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul8-0006wp-53; Thu, 05 Sep 2019 09:37:22 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbKsb015560;
        Thu, 5 Sep 2019 09:37:20 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul6-0006wJ-25; Thu, 05 Sep 2019 09:37:20 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 4B203101070; Thu,  5 Sep 2019 22:07:19 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 4/8] dmaengine: xilinx_dma: Add callback_result support
Date:   Thu,  5 Sep 2019 22:07:00 +0530
Message-Id: <1567701424-25658-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No-2.529-7.0-31-1
X-imss-scan-details: No-2.529-7.0-31-1;No-2.529-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(199004)(189003)(2906002)(426003)(336012)(26005)(36756003)(476003)(305945005)(2616005)(186003)(446003)(11346002)(126002)(486006)(50226002)(81156014)(81166006)(8936002)(52956003)(8676002)(48376002)(50466002)(76176011)(107886003)(6266002)(53936002)(51416003)(4326008)(103686004)(478600001)(16586007)(42186006)(316002)(106002)(70586007)(47776003)(6666004)(356004)(70206006)(14444005)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5316;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ca1501a-24ef-4ca1-aff5-08d7321f579b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR02MB5316;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5316:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5316A0F5EF925EB34F4B9B67C7BB0@BN7PR02MB5316.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kI5daIkQbh98tKBPnPO0A5Y9yRc/zDxUxpxzzjUjludKEBT5YTwPEPQC31Y0q2So1AxBiSY2PZzBLiXYDXBhGrtOjP1vOD1sRAd+hzy6PgiOEPPiISjV0s8NEBe1wxKgFBSzyAt6O/LqBZ1udyhjLlLnYWJxN0TgE0nXJGVyqrg/7BJh5QOsucAuYfBmy++vsVeOagGtskcKoUntVxz5C5EqKSakcj38SZMBhoVD7AP5xu2BUbj6kxPzGJ4lrpbwgtj7ZG3RUGqbl8nPel8eaJYZKjnpcnHX4ycVR8s7ZlSKQgIKX72HvmCTz9jVh+jHzLbn2iz7IBveBZmqUBC3cOx+ogajnOq41fLx6LOtzRQ9caiVmqzr2ZfIjs+uzIaN+Qv4OVNqi6O/aL3A2eIjYzYqLYoGgE7tq9oLszJYA7c=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:37:28.8998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca1501a-24ef-4ca1-aff5-08d7321f579b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5316
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
 drivers/dma/xilinx/xilinx_dma.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 4094adb..3f2e0ad 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -300,12 +300,16 @@ struct xilinx_cdma_tx_segment {
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
@@ -865,6 +869,8 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 	spin_lock_irqsave(&chan->lock, flags);
 
 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
+		struct dmaengine_result result;
+
 		if (desc->cyclic) {
 			xilinx_dma_chan_handle_cyclic(chan, desc, &flags);
 			break;
@@ -873,9 +879,20 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
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
@@ -1424,6 +1441,9 @@ static void xilinx_dma_complete_descriptor(struct xilinx_dma_chan *chan)
 		return;
 
 	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
+		desc->residue = xilinx_dma_get_residue(chan, desc);
+		desc->err = chan->err;
+
 		list_del(&desc->node);
 		if (!desc->cyclic)
 			dma_cookie_complete(&desc->async_tx);
-- 
2.7.4

