Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF569AA92D
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389673AbfIEQhy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:37:54 -0400
Received: from mail-eopbgr820044.outbound.protection.outlook.com ([40.107.82.44]:49556
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389096AbfIEQhh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:37:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr+UNQ3uimlizihCu4V6zWWiGy0wYHn1bxsAOygGBNb9GWoTBBA9uROPq6c0YsvA95rrKJEWh147MLI6KQ/KSjW0EK8kzSmz3NfKc0/ddN9r0KvrBYOIYvIOxzcUBOGHgg18TOWLTnArB702x6n7m2lZwm5vvkamZi8HlGkiddsDVKrKBkq60g/QjTYWnEwwydMVnxr6DPoepRqxxwyNGZO1zrXE93d/dSxKRl2mAfAPiKJPZPM/BfcGCNFfkJ9+oMOBqpCdTl+A4+BSFm89ReXZzXlArng9aR/t9cNzY2r1Bx7piPKZl8V5zXzT4TSmu9xOJewrIcNk9WrueNnOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htv4rpvStZ8B9fbAg7xETSsbMY//ZaXN+kQuDgOPU2Y=;
 b=O1Y68ivHS7BuTfDFz+Px19Y1sXIlPWkC/2bF85lOgwfeHv+atBzjNFGJlLlJ4sFZ0L1bK01e/S+WCeMyxlAZt1VJ57cs2HE3ZTi8J/qsLpM0rEHvT6pqDd2F33xT3nUSCs6KmyY8pDvYhW/h0jIIwIgzTIVIYk0huSWIs64ZHZtqxR4+2QO97TfRx9EZJPkggvn5f/k8ib4hyJz/r6ORQORe4NjxY6eqRqQDFKTx0AEUu6rcprFP+/M3K2oSJ2cIgDdcZvJ+NAsxE3HqIjvJiE1PLRotp9onBfDZBRIakcpTqm2vzNYrLSoXOeWT4f1kMh1mcDTxfnN7a6Rz93KKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Htv4rpvStZ8B9fbAg7xETSsbMY//ZaXN+kQuDgOPU2Y=;
 b=o+4jGeJzJJqgmRKoETuic3dx5kOzpvBfDDMXTBZhXwkeQywCJ0/4AQoU9hXC1Z8lIj8AgamQcKnNwODzjkU3iAaQoLndeyEiP4l3vTLcubiGjEeUjsUa9FsGvBcucr2Y6ZO3PYLGdyC4quH/TI4UZzjZrizQOFVt+kw8514yIOA=
Received: from SN4PR0201CA0024.namprd02.prod.outlook.com
 (2603:10b6:803:2b::34) by BYAPR02MB5336.namprd02.prod.outlook.com
 (2603:10b6:a03:67::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14; Thu, 5 Sep
 2019 16:37:30 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by SN4PR0201CA0024.outlook.office365.com
 (2603:10b6:803:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.14 via Frontend
 Transport; Thu, 5 Sep 2019 16:37:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 16:37:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59444 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ulD-0006fS-Ct; Thu, 05 Sep 2019 09:37:27 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul7-0006wm-Uw; Thu, 05 Sep 2019 09:37:22 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbKJm015555;
        Thu, 5 Sep 2019 09:37:20 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul6-0006wF-06; Thu, 05 Sep 2019 09:37:20 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 3D7B110106B; Thu,  5 Sep 2019 22:07:19 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 2/8] dmaengine: xilinx_dma: Merge get_callback and _invoke
Date:   Thu,  5 Sep 2019 22:06:58 +0530
Message-Id: <1567701424-25658-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.555-7.0-31-1
X-imss-scan-details: No--1.555-7.0-31-1;No--1.555-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(189003)(199004)(356004)(316002)(42186006)(6666004)(6266002)(53936002)(47776003)(16586007)(4326008)(2906002)(52956003)(107886003)(103686004)(5660300002)(36756003)(70586007)(70206006)(336012)(48376002)(11346002)(14444005)(8676002)(81156014)(81166006)(186003)(50226002)(26005)(126002)(476003)(2616005)(426003)(446003)(486006)(478600001)(76176011)(50466002)(106002)(51416003)(8936002)(305945005)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5336;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4e3ec2d-a5b1-4cd4-9164-08d7321f5787
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR02MB5336;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5336:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5336F6285DC338FF2ECB96C1C7BB0@BYAPR02MB5336.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: DCki4C+5eEOG+8/MGwcL2kNghsLskCRMG6IRRCaeKr+podg9N7+EPevimNQgDANk9Tzjx7IwlO8zIXfUQbDbVWXWuDjlS70JHr/xyHl1yzMV+dpJe0tDWyKTwC1/qfWDFhcTK/A/v3YngDryn5EEaDvljWUE7hX/a9AgL6p2aIIgpCBhgyMkYMGBbtcJPHF/YoIVjFhUCaJn31bgh0GmsJviPVMouwy+ZphkJ4zHC1DPqm46BIjv8QEx8Jr/HOJwZc/6dqjrNHRTcqHLb0iMXA2leUJfjneRfBYmyw4oaIJlbrKpQejU1OXf1/GKWQEEtFGu/dKE/jnMnYBamevxIUVwlzwRljoBCj2TMPBJRLInNWxflZ8PgR4/VcUUXL/Gn258L3W3K6GezV9bzo0IKGk4c8KpgInsgKBU364Q9Vo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:37:28.8350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e3ec2d-a5b1-4cd4-9164-08d7321f5787
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5336
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nicholas Graumann <nick.graumann@gmail.com>

The dma api provides a single interface to get the appropriate callback
and invoke it directly. Prefer using it.

Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 8bbf997..9909bfb 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -820,8 +820,6 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 	spin_lock_irqsave(&chan->lock, flags);
 
 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
-		struct dmaengine_desc_callback cb;
-
 		if (desc->cyclic) {
 			xilinx_dma_chan_handle_cyclic(chan, desc, &flags);
 			break;
@@ -831,9 +829,8 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 		list_del(&desc->node);
 
 		/* Run the link descriptor callback function */
-		dmaengine_desc_get_callback(&desc->async_tx, &cb);
 		spin_unlock_irqrestore(&chan->lock, flags);
-		dmaengine_desc_callback_invoke(&cb, NULL);
+		dmaengine_desc_get_callback_invoke(&desc->async_tx, NULL);
 		spin_lock_irqsave(&chan->lock, flags);
 
 		/* Run any dependencies, then free the descriptor */
-- 
2.7.4

