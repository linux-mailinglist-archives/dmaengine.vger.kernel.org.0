Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2938BF015
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 12:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfIZKvT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 06:51:19 -0400
Received: from mail-eopbgr730057.outbound.protection.outlook.com ([40.107.73.57]:33440
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfIZKvT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 06:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9ITXg2hGFz/aMsr5Q+KjcDNG4gBiP0EeHvpod7RKaPB8LQRvL2pGlJ6N9sdv6ousrFKJog91+DZw8JL6QkEqCxhONk+7xyyhtIubVYMDpekxl9XGBXHqEzWcRUmTTJkj4Wrlge8hj3OGoM8CmFOGTB436KSp6fumvXOf+vkiPIL4jpDqByqUE7AnY5cgQHRvfqqnHVjCxZvGbrm3FLTRn5h1o9QIXvyUWNhUogcnG1JMQ0pz/B/1uiMrdNoble52zfCsZlDLR8mJafuOffBfOVlAQ1kHMq5itun9oQy3W4NdK5FRZ77y8VzugRjBV/NWENtL17mz4mAkhA5EVWItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlqwSIselzqNqlgROQF64eu3ppj5/CPt1d1HTlDPS08=;
 b=bcpB8+iihKYb0DPw01enAo87kdgVvQKWBkOZ55+7/ibAKCRXhJu3zjCf3WU43VI91icJ1lF5NR05saWIrCHd1Jz9OtOSeuJyCrhVw/TblJ52qF2qZTJssED8LuCGXVGVCksCjS1TwighmJKs75TCA8J9uo1f0nfVlVDkRTn+7GsCAXH5DUHb10EkoavO+YfjRlppSbSJNtuLeV0qSCR1dtk02RgUA/6rgm+IWIcT5YeN5Z+MQBmHClAvx7I+GadP0WLe3oQJBJ9TercFxwR3z+tGVctQPRxIFGbOjfuOcMHx4KxnNG7alH36GD6XYRnNv+yrV9cgLgQJYwNvHIPpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlqwSIselzqNqlgROQF64eu3ppj5/CPt1d1HTlDPS08=;
 b=svlws1Xw/hnpNmc45tSpRUUzRyLeANyhBg2Qio5UVAIWamsnWzrEsKq1ZlK3SrTQrk+YODMb4DbdVrpHcE0Q7se6uxtDu4qXvyLduVPKvWiqigHhXtzmTzIpOyoH6Aa7G0sJggDQUB2CBWGss9UaSk12SROjNDQmlFirFWKmRWk=
Received: from MN2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:208:fc::32)
 by DM6PR02MB5323.namprd02.prod.outlook.com (2603:10b6:5:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Thu, 26 Sep
 2019 10:51:16 +0000
Received: from BL2NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by MN2PR02CA0019.outlook.office365.com
 (2603:10b6:208:fc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.21 via Frontend
 Transport; Thu, 26 Sep 2019 10:51:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT012.mail.protection.outlook.com (10.152.77.27) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:51:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47503 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMh-0004oJ-By; Thu, 26 Sep 2019 03:51:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMc-0001k3-7j; Thu, 26 Sep 2019 03:51:10 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8QAp9j3032136;
        Thu, 26 Sep 2019 03:51:09 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iDRMa-0001jX-V2; Thu, 26 Sep 2019 03:51:09 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 2BFD2101106; Thu, 26 Sep 2019 16:21:08 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 2/4] dmaengine: xilinx_dma: Fix control reg update in vdma_channel_set_config
Date:   Thu, 26 Sep 2019 16:20:58 +0530
Message-Id: <1569495060-18117-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.868-7.0-31-1
X-imss-scan-details: No--4.868-7.0-31-1;No--4.868-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(14444005)(103686004)(70586007)(70206006)(50466002)(51416003)(48376002)(47776003)(107886003)(4326008)(36756003)(426003)(336012)(76176011)(11346002)(478600001)(8676002)(486006)(126002)(81156014)(2616005)(81166006)(6266002)(2906002)(5660300002)(50226002)(356004)(446003)(6666004)(316002)(16586007)(186003)(305945005)(42186006)(26005)(8936002)(476003)(106002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5323;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de0db4e6-07db-4f6a-d479-08d7426f74ae
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:DM6PR02MB5323;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5323:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5323F9BF963E98555E81ADDAC7860@DM6PR02MB5323.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: L2DNdg3K3dhIeFZ80cidDR3rU1vxF2cdZJy8uRNShRokuplWuOMDVXac0d7FvLDVGD7Mu/Y4DdhU/7dZhpz+55Mjf2ZHlyySRygdj5F/bXc5Q958kG9LN5cXZAp1r+hLRgBbIrhDX/U9jn/ZVloGIEwVpBr7UOnRlDEkag6zDvC46frxJFJTKIdq4iucYfXSobJDg67SRs45RteNG6yIVttD1BgjqR9GzYQh6juf88/2pCmTZVqN6YpWwdlyXMnodchux+Gva/v2PPvlHV+1YN5lAmXb6nvU80SghXIasXUjoBLbjcLW97wjrvZjIn5Y+arqjPgW3YYZ/2c41K6VCVJd+MaU9pr7L8+FQGXgCO0q6OJwjlD7l0PySGTepJay1n62p0DOvMYrJj9F9W6iclPOfy4khGFzkuBdA/hGxS0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:51:16.0900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0db4e6-07db-4f6a-d479-08d7426f74ae
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5323
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In vdma_channel_set_config clear the delay, frame count and master mask
before updating their new values. It avoids programming incorrect state
when input parameters are different from default.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Acked-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 1fbe025..5d56f1e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -68,6 +68,9 @@
 #define XILINX_DMA_DMACR_CIRC_EN		BIT(1)
 #define XILINX_DMA_DMACR_RUNSTOP		BIT(0)
 #define XILINX_DMA_DMACR_FSYNCSRC_MASK		GENMASK(6, 5)
+#define XILINX_DMA_DMACR_DELAY_MASK		GENMASK(31, 24)
+#define XILINX_DMA_DMACR_FRAME_COUNT_MASK	GENMASK(23, 16)
+#define XILINX_DMA_DMACR_MASTER_MASK		GENMASK(11, 8)
 
 #define XILINX_DMA_REG_DMASR			0x0004
 #define XILINX_DMA_DMASR_EOL_LATE_ERR		BIT(15)
@@ -2118,8 +2121,10 @@ int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
 	chan->config.gen_lock = cfg->gen_lock;
 	chan->config.master = cfg->master;
 
+	dmacr &= ~XILINX_DMA_DMACR_GENLOCK_EN;
 	if (cfg->gen_lock && chan->genlock) {
 		dmacr |= XILINX_DMA_DMACR_GENLOCK_EN;
+		dmacr &= ~XILINX_DMA_DMACR_MASTER_MASK;
 		dmacr |= cfg->master << XILINX_DMA_DMACR_MASTER_SHIFT;
 	}
 
@@ -2135,11 +2140,13 @@ int xilinx_vdma_channel_set_config(struct dma_chan *dchan,
 	chan->config.delay = cfg->delay;
 
 	if (cfg->coalesc <= XILINX_DMA_DMACR_FRAME_COUNT_MAX) {
+		dmacr &= ~XILINX_DMA_DMACR_FRAME_COUNT_MASK;
 		dmacr |= cfg->coalesc << XILINX_DMA_DMACR_FRAME_COUNT_SHIFT;
 		chan->config.coalesc = cfg->coalesc;
 	}
 
 	if (cfg->delay <= XILINX_DMA_DMACR_DELAY_MAX) {
+		dmacr &= ~XILINX_DMA_DMACR_DELAY_MASK;
 		dmacr |= cfg->delay << XILINX_DMA_DMACR_DELAY_SHIFT;
 		chan->config.delay = cfg->delay;
 	}
-- 
1.7.1

