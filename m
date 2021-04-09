Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9C535A516
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 19:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhDIR6G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 13:58:06 -0400
Received: from mail-mw2nam12on2084.outbound.protection.outlook.com ([40.107.244.84]:33153
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234049AbhDIR6G (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 13:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koiVeOh5+JUqRVYGo4sDPwTlTnjRPM8Pfh+f0i8DqOQRryuYu5LAwaUEOBMEiLqccuWZbHB2K0ik3NneYxfhuLsHAE3SfSQ0EWagsIkPQOjP5jDsTJwym9Rl7vLjShfmrcDY+L+lVJkAv4ek9iYxG7gpE8eN0FXg1aghb0vKGgEDei3fkLXd72qdWJtHhSF01ibZK3dXX6jc7qbIqsPDlBUzEM41iYnP1bIg+bMdskOFxhct52tCYH59n3MTuULvGpT77LFwAhXhfzZ3GFDUUfKHvD6iqAAlD/0P/4FX3ys1ZKc2Kjspw+RnTU0IomPlZvlThaxWPBlHJAXZDBb1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynSf1739VRvFA2Ng9lvlNGhX2y2FtM5WCnohiOs1p4E=;
 b=l3AI6rx4rd5FoxfGxmtVvT+yVb07fHxQxByrRYBM06kLegqp0mZxRaqWhwLOXL6LU7Ifslht2+Mb3tT7dptA20fZdGE/G9wmzLfthhZ/tcK67FhSiGIu/EnuK2ReaZyJqDMfAr2lIqhwFLckQn8oF7AjtjlRPyKAMeu121DAI0DiHQE4Ed2IAkr4WkhdE/jFPsEgXTK4jR+Sg+LQp6skPrxDqEgbtU4gS813VxxYVzJin3uNeTo47Yisyyaso13nFLyuGndQzUpt706NpyOdml+U4mpKnER9KqHbLhD4FYPi3aHkxiMm8DxUap64dkBIMPaUB+dcU8N/LZRddKhtYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynSf1739VRvFA2Ng9lvlNGhX2y2FtM5WCnohiOs1p4E=;
 b=ZQUSGwRv8pGkrHopuOIsG3ASl00OdPuZ4vbwSZaPxUCaH/jsC1CP0I47gwhMO6lAQoDxsg1jtdhS2FfLSOLH80Ky0uWJPuygKD4rmwZMjAwFm+5PppRp4Ody3zxjw7e5iprq1uC9gODhho9BzPpoGmaeDicuL+0wSCSg05MNgGc=
Received: from SN6PR16CA0037.namprd16.prod.outlook.com (2603:10b6:805:ca::14)
 by CY4PR02MB2581.namprd02.prod.outlook.com (2603:10b6:903:6e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Fri, 9 Apr
 2021 17:57:51 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::d2) by SN6PR16CA0037.outlook.office365.com
 (2603:10b6:805:ca::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Fri, 9 Apr 2021 17:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 17:57:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 10:57:40 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 10:57:40 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=33307 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1lUvNz-00030x-Ne; Fri, 09 Apr 2021 10:57:39 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 4BB8112216C; Fri,  9 Apr 2021 23:26:20 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [RFC v2 PATCH 6/7] dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical usecase
Date:   Fri, 9 Apr 2021 23:26:04 +0530
Message-ID: <1617990965-35337-7-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe9219f8-d50b-4f80-b8b3-08d8fb80fe2d
X-MS-TrafficTypeDiagnostic: CY4PR02MB2581:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2581284170BCCA83B33A9709C7739@CY4PR02MB2581.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOaPa1oPTl0wcGvY/ok/34+OTSYnr8n2uuOJBaoN4rAWiYmpue6aVQ9S3SQfsLTXkDQmxZ+PIbGaA6y+fCuOQvXNMu30tyQaMaUIfoYszxrwZNMan3Zt/Y/BF9QLL7lfbT3rJw4hPaTcDI7qZM5Z+kglCswjen1TsWkiFtak2XblbIqDecsCEebFR6YN5kbr/u4kWf0m3SlpsTE772ktblrumuICiCQNmQQabkwZLju5w62gN1YtaJU1UMHc+m+dDPSOUrv+tmil4yEPepOlC29IgT5OC58yNYwZXPI5Bt/duUxNdHlzFqxKIuY02ejyKBYjidOUSXukc/a3+JrI1lAKr7yNJ+NwbVKFXvP4yysYuCGI2q7X7p7QItT+4QlLxQFR/aoBTzA/wSJ0URbuIgWHEcy8c5e9IeJnJAzGVK+QhDgPBH10AVJ6Wr6413ky6bYRcx8nY4pnbD9OQkVonDWR0S1fM8kEvw+gfxX/ECdLtjNz51Y0t20I+3Bi/VFi0ocv2Xq+CBSQcaO+3YCovbNCFs0001scqG5vMK/YPfd6Mo+GO+NcywjjGaw5KT8OloL41duE+CyFpndcvbg6HgrR0Oq0IbwJOrQ9z/fC/kuQqluMIvyW4x1MCCnTBJiXcIbz+HL7BWU7ubBjaBvs09U9WiLNmDDtgECuOdLjKQEER4xvVcGnQdD628ta8M2u
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(346002)(136003)(36840700001)(46966006)(82740400003)(478600001)(36860700001)(5660300002)(110136005)(2616005)(6666004)(6636002)(82310400003)(26005)(4744005)(47076005)(8676002)(42186006)(54906003)(336012)(426003)(356005)(36906005)(70586007)(316002)(107886003)(4326008)(83380400001)(2906002)(36756003)(6266002)(70206006)(186003)(8936002)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:57:51.0900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9219f8-d50b-4f80-b8b3-08d8fb80fe2d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2581
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Schedule tasklet with high priority to ensure that callback processing
is prioritized. It improves throughput for netdev dma clients.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
--
Changes for v2:
- None
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index f2305a73cb91..a2ea2d649332 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1829,7 +1829,7 @@ static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
 		spin_unlock(&chan->lock);
 	}
 
-	tasklet_schedule(&chan->tasklet);
+	tasklet_hi_schedule(&chan->tasklet);
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4

