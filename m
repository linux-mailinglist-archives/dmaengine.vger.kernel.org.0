Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4F31088C4
	for <lists+dmaengine@lfdr.de>; Mon, 25 Nov 2019 07:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfKYGuI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Nov 2019 01:50:08 -0500
Received: from mail-eopbgr800059.outbound.protection.outlook.com ([40.107.80.59]:29472
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfKYGuI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Nov 2019 01:50:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9fR9QYztQsxZ4tZ1QuJ2OGglhqQ4VC3JLLFvnu2uNLdkjhsSKnHxjiXuXXgeGYDAbrDE4uKFlpbOto+cufltUugT5zNd4CVIHUyhjPu7ediqKDxZ83GJ61isLq+YfRdwCtBFLeIp0367GcmeoQPEYGDPHLQv7RYprK/dpyqLhDYm0UaDF8y2oW0wQVuzoH5ZFlYfCpCx2Avgw1fbQuOAoAXN4B3Lx5Vn+G8+sYuwWKPIapmGt7/dVZKxwyl5OOWuxoREX/gl1UW2/qkqpZM09QY1RW4FidPbHTuVxB/gZLq4zef6hb+4Toalw/AYMSPwAIvCruAqcLT/d2kxGA5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6l5KvdcJa0ccXBN+PYpy6Nc/2p21mtTmyjYszCsbwM=;
 b=I3qNaGMqlHPYAs9OtHNNvkJtrzr50EnG+hE46UyKUFcT5/t151CTUm/x7NoCs3qV1iz+o3evIBkcb51K9uOb0HC1pSkqULTlfYPdeRz6CPA5JMKix/3J4RkOyRQ6R8DZDPsmVA4fLF6UdK9qN1yEva5gasZtEpe62PJeueSTwEoTfKGSN4ViNVcUdmBs1NJO559zBPqFRCfxQg+KY8F+rTTaZPrJs1CzGJ0QMELfzO/zS4QoFGlJAUNjBxbhnJD4/RZtO39w9icIj5jX52LGhUXvSYMhxLeSs5tMK5MarQ3mjPljBJTrYMpm0Y7IinnczFHH9xbMOShXvvX4fvUHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=xhdpunnaia40.localdomain; dmarc=none action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6l5KvdcJa0ccXBN+PYpy6Nc/2p21mtTmyjYszCsbwM=;
 b=CWNwUM5avgO5QoedtsfOxfKd6CEgK4yMfSYCaSTCWyLtfVXryBWTZaHGrYpuUCln2n8oQY7G/6tRiqjz5Wl4E+vUFyzGAnlWIviUzbCi7F45aCBmTHU7NUIDwajHilTlk8+YcFqVH9HRiRiHMz2JuoYLXmCYOxfHM5r9XiEVqmo=
Received: from SN4PR0201CA0041.namprd02.prod.outlook.com
 (2603:10b6:803:2e::27) by DM5PR02MB3704.namprd02.prod.outlook.com
 (2603:10b6:4:af::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Mon, 25 Nov
 2019 06:50:04 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0041.outlook.office365.com
 (2603:10b6:803:2e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Mon, 25 Nov 2019 06:50:04 +0000
Authentication-Results: spf=none (sender IP is 149.199.60.83)
 smtp.mailfrom=xhdpunnaia40.localdomain; vger.kernel.org; dkim=none (message
 not signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: None (protection.outlook.com: xhdpunnaia40.localdomain does not
 designate permitted sender hosts)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 06:50:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1iZ84Y-0005dU-Gg; Sun, 24 Nov 2019 22:42:10 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1iZ84R-0003BF-Vc; Sun, 24 Nov 2019 22:42:04 -0800
Received: from [10.140.184.180] (helo=xhdpunnaia40.localdomain)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xhdpunnaia40.localdomain>)
        id 1iZ84R-0003Af-6u; Sun, 24 Nov 2019 22:42:03 -0800
Received: by xhdpunnaia40.localdomain (Postfix, from userid 13245)
        id 65911105F6F; Mon, 25 Nov 2019 12:12:02 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH] dmaengine: xilinx_dma: Reset DMA channel in dma_terminate_all
Date:   Mon, 25 Nov 2019 12:12:01 +0530
Message-Id: <1574664121-13451-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--0.351-7.0-31-1
X-imss-scan-details: No--0.351-7.0-31-1;No--0.351-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(428003)(249900001)(189003)(199004)(50466002)(14444005)(42186006)(16586007)(103686004)(51416003)(316002)(36756003)(5660300002)(26005)(2616005)(336012)(70586007)(42882007)(70206006)(305945005)(498600001)(81166006)(50226002)(81156014)(8676002)(48376002)(2906002)(8936002)(356004)(47776003)(4326008)(107886003)(6266002)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3704;H:xsj-pvapsmtpgw01;FPR:;SPF:None;LANG:en;PTR:unknown-60-83.xilinx.com;MX:0;A:0;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 374d063a-3a8f-4f3d-13a7-08d77173b362
X-MS-TrafficTypeDiagnostic: DM5PR02MB3704:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3704C4F4C7DCB90B0036AF7AD54A0@DM5PR02MB3704.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0232B30BBC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XM6qyOSU4XYNgWGzWUS8WC7jNFjOXij1yxWkD+zfrlOukevpY6h6xab8vQYa3Ci5jrwW4L7T5Rt0VsnVfargeTNn9yha3TMQNrnTZNLmuTnvxF1mE4OJPc4EqGpMD467iw8NmfN2hdAUPOcPeFKqUAxPe5Odo8/lSGnGgo3KFup2SQcXnKi/50+UJSx6bdW9RRk2ewyaxaKd61wO4BhTaHYCstN8tYoSKbjqEWUMe8JrRNHNsbLaJQsG0p5M9flZhlcgpHe1prCJbY67ZN9/yjDpb7O9WwdyFGhlq3wPGK0lGa5fTmYYGCrHV2P4xHsjysjggfckjhwYLbMnxqbc52L2VMnXPq1WuMNSgggXmjpa+2dpTOgPibP9ZZqzYaGeUPDB7yncBGN0IDGlLHTMKrlPNKWFN5w/IjYbjmQWlGTomKP9RF9kLSKuhPskvjuS
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 06:50:03.9210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374d063a-3a8f-4f3d-13a7-08d77173b362
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3704
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Reset DMA channel after stop to ensure that pending transfers and FIFOs
in the datapath are flushed or completed. It fixes intermittent data
verification failure reported by xilinx dma test client.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a9c5d5c..6f1539c 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2404,16 +2404,17 @@ static int xilinx_dma_terminate_all(struct dma_chan *dchan)
 	u32 reg;
 	int err;
 
-	if (chan->cyclic)
-		xilinx_dma_chan_reset(chan);
-
-	err = chan->stop_transfer(chan);
-	if (err) {
-		dev_err(chan->dev, "Cannot stop channel %p: %x\n",
-			chan, dma_ctrl_read(chan, XILINX_DMA_REG_DMASR));
-		chan->err = true;
+	if (!chan->cyclic) {
+		err = chan->stop_transfer(chan);
+		if (err) {
+			dev_err(chan->dev, "Cannot stop channel %p: %x\n",
+				chan, dma_ctrl_read(chan,
+				XILINX_DMA_REG_DMASR));
+			chan->err = true;
+		}
 	}
 
+	xilinx_dma_chan_reset(chan);
 	/* Remove and free all of the descriptors in the lists */
 	xilinx_dma_free_descriptors(chan);
 	chan->idle = true;
-- 
2.7.4

