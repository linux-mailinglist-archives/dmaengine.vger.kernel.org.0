Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA7D791A
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbfJOOtG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:49:06 -0400
Received: from mail-eopbgr770051.outbound.protection.outlook.com ([40.107.77.51]:6851
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732933AbfJOOsw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 10:48:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOI8LOxvr4u8oLmJrjzmp/JcCywZyOhRLdDfsFAGLPnu36A8ENGkZiSnOcBlYFhA7utJ6XyjVZ5bEgu26vAFEVTZ0fxk7WgshKBIZvWl4gTEy6ZZM89ip3j6gKl6uIW1/wNeJxbCF/DKAJkLfcivtIwk3EVNrHroD+uMDBuEh/liXD3lr+KYruehEETbTgx6c5zRHtGdhsVyOn3Vb9bC7lIqEg6VCtq7L0/R43PBMb7mvSOeRcYXRJfg6rZ3KvFe1TzuNRhCKRn+zl8G0ie6fomN01pn8+oj/Do98+9OR0mWqoqeSZsenCO9CRlnw75KClk0RIJiMETL1IkJu9y9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGLJy7WjISY0rEn0djaXuX0N0QEmpJG0gZngoPbvPO4=;
 b=i0c+XFprSc1MdKmXuPmjgm4TRpiLcSLOQl2llUMxkm9ckA7D1ZsGyYcUZXla0OGMweitJyAqpoec2VCarRELXv1rhEjC+u6k7rRpQtC1GYe3psxs2zNR8VTrgY1YtiYenC0sBHiEb7Iow9lHwJAPYmOePPxK0mlYUWZxUKj7fMKKAoaVhK4qFrA1k27/oHEInlhqKJrszPbsY0u55Dr1AAvweQi7qj3strNdkOs1/0nQiC17T6ZOuk/ltJpFDMgQgtDDTqRuVlxQyaEeafZJMFQLH9LcpOf10e5Teew/KOl0aP/ZtvfMXw9tX0XfuSVfg1oHm5Wi/AdbJCPWWBLNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGLJy7WjISY0rEn0djaXuX0N0QEmpJG0gZngoPbvPO4=;
 b=f9EpqBRoUJmwTsToomjFdj/6Nmd3VV3aTUS2Krb5xPrHczBIU99HwIMztRhYE2gVQ6r30vGO62D23AaIrdJQpnljtWmvOXVKR9T7X0tYXesKCQ9A9Nus4Hf2IrXxPoYWloPRXENyIkwNRvxRxKJ8NC0x7Z6xl9uDz54R5Pa78BE=
Received: from DM6PR02CA0130.namprd02.prod.outlook.com (2603:10b6:5:1b4::32)
 by BN7PR02MB4066.namprd02.prod.outlook.com (2603:10b6:406:f2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 14:48:49 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR02CA0130.outlook.office365.com
 (2603:10b6:5:1b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.24 via Frontend
 Transport; Tue, 15 Oct 2019 14:48:49 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 14:48:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO80-0006Fz-Dh; Tue, 15 Oct 2019 07:48:48 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7v-0002As-2H; Tue, 15 Oct 2019 07:48:43 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9FEmgcW014677;
        Tue, 15 Oct 2019 07:48:42 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iKO7t-0002AK-PY; Tue, 15 Oct 2019 07:48:42 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 2414F101134; Tue, 15 Oct 2019 20:18:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next 7/7] dmaengine: xilinx_dma: Clear desc_pendingcount in xilinx_dma_reset
Date:   Tue, 15 Oct 2019 20:18:24 +0530
Message-Id: <1571150904-3988-8-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.495-7.0-31-1
X-imss-scan-details: No--4.495-7.0-31-1;No--4.495-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(8676002)(36756003)(81156014)(8936002)(107886003)(51416003)(81166006)(336012)(486006)(186003)(47776003)(76176011)(70206006)(70586007)(50226002)(50466002)(6266002)(126002)(2616005)(446003)(426003)(11346002)(476003)(478600001)(14444005)(103686004)(4326008)(16586007)(42186006)(316002)(305945005)(26005)(48376002)(5660300002)(2906002)(356004)(106002)(6666004)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4066;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1407bfba-cd59-42b8-e9f0-08d7517ec9f8
X-MS-TrafficTypeDiagnostic: BN7PR02MB4066:
X-Microsoft-Antispam-PRVS: <BN7PR02MB40664A843283D3A87B8E9A72C7930@BN7PR02MB4066.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFhYbtDZiXVRancgtqa5HWPyXGdzLh+01+JysKkR7EiCPLr3PmHoAOqrmfeHprEoUlQJU/LwqI3OG9fnczprhmRX5Xyo+bsPMT3Pv57g1CwUgq2YIhdsp9TZ/iR35rYMzS4ZMMrap8sRWrXUdfggvNjgmh5aBm7d6NutKk1zZ8ZCtEd5XqAsRiYlJ6rvyvtDh2wGETYi3GSWmd7+8qi4sQ8BNP78BK06zVZBhEPl63ugGoapiREe+RRXE3Zuq8GVx1weJUzxz0JujZluC61AfdtY8LzEspn7BZ9RmGii7cNkyZGTUtWC06hQhvFKD6E7/szoFV5BA0/6C7f5kfAINioixd/jPz52zWN0ZJIWLkeLaaJ/Izg6GUxvMxDtfS41nvbqfx/4nSwGOrPCD5K1q2wnEEvEPEO37wDaghYU2v0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 14:48:49.0735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1407bfba-cd59-42b8-e9f0-08d7517ec9f8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4066
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nicholas Graumann <nick.graumann@gmail.com>

Whenever we reset the channel, we need to clear desc_pendingcount
along with desc_submitcount. Otherwise when a new transaction is
submitted, the irq coalesce level could be programmed to an incorrect
value in the axidma case.

This behavior can be observed when terminating pending transactions
with xilinx_dma_terminate_all() and then submitting new transactions
without releasing and requesting the channel.

Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
None
---
 drivers/dma/xilinx/xilinx_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b0d3aac..56a7317 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1486,6 +1486,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 
 	chan->err = false;
 	chan->idle = true;
+	chan->desc_pendingcount = 0;
 	chan->desc_submitcount = 0;
 
 	return err;
-- 
2.7.4

