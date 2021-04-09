Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D01F35A50A
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 19:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhDIR5e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 13:57:34 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:63840
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234409AbhDIR5c (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 13:57:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLzD6nSyjacENLpYhEj3Vycq2CvMClxUQD5Gw1RGmT7cVoyzIX/6wP2EWg4ql+N8SBP8ftV/SYPi5/Pki8nKCm6xgzNTbABBSSL3O5rP0VMa35ZBg/lN4uQSPoQ20Ag4E/i/QsE/nCReuzgXwa+Qzbs5qvCrbh/NyLKscNag0ljee2t5Sx0eXNR1qs+TpaN8IaIUUXj0BpaLW3SEjHar8Wm4mgw584sDv5KVoycsvkBq+qD/vnA5r77RxtSRpjI7T/q7ImKgIVCYQr9a2b+CtSNPUEmYyUoT8OQOVnMZzNndLq6BbElzzeYH9JxbAIROt6vMN6r4pS8AR6vFvFdcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6mf6T0H8OLmwVCKEH6/6gtIceA7OGFd+m1owFKaJAc=;
 b=e9yYJeckUSf5+FT1O3rRjjrJw80MwFDUATrWRT38DW0rTqstOOTKu8zns5w8wMULVPVh3Dh7RogFAqvn+9lyG1KjVIxShUQCSSD+V7V5qUA9JPtsvINe6rJITQYIE5kAwjtkKPcCLOYfvLOT7Pykhli4M349+1raKtQvzV8PP1ESrixsYH/OmaPPT4KYxoEG0nbXddzzuRjLy4Wp/2jck3VRTlQcRvcbrzoGokJZgPnEMqF552WUKQLIgsJC2TAHxY3iwNewYI3eFkV7Ur0+rOLp/4UlBq0gyz0hRqX7DmcFEU2oKTXTVTZMeoZGVYj7KD7xgfAUNrOLYfNoKJDpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6mf6T0H8OLmwVCKEH6/6gtIceA7OGFd+m1owFKaJAc=;
 b=bXVApIsB4OzekRYI2PA4ytPUusxTwaXGF3/QiEN3bmZ+pKNgEKiGdW6DLx1Dq5PWPN5qNYkde1Aaw/qoXwn1vqmlikaLTxouRvqNJJCRHl7R9k4H5RS7dv0poCqmtDd06qv2qSKXH+aXYYLQn4vXoxB75ZlO5c8d/gb31baTMJk=
Received: from SN6PR16CA0065.namprd16.prod.outlook.com (2603:10b6:805:ca::42)
 by DM6PR02MB4332.namprd02.prod.outlook.com (2603:10b6:5:23::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 17:57:17 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::52) by SN6PR16CA0065.outlook.office365.com
 (2603:10b6:805:ca::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Fri, 9 Apr 2021 17:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 17:57:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 10:57:14 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 10:57:14 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=33301 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1lUvNZ-0001EK-H5; Fri, 09 Apr 2021 10:57:13 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 3FC3D122162; Fri,  9 Apr 2021 23:26:20 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [RFC v2 PATCH 4/7] dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
Date:   Fri, 9 Apr 2021 23:26:02 +0530
Message-ID: <1617990965-35337-5-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b90745c5-9671-447d-0c3a-08d8fb80ea13
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4332D026F706212A0EED04FFC7739@DM6PR02MB4332.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sX5WECi0NIjoLZSq61r6pO5lYNRvQGdf3BztIqL3yzQi5HgoP2kaoOtDFDgTMmFwKgXm9Rn7n6dvbokw0mOJQLHbbCbvX67LC4WHkAM93EbtxaT//hphP2VCq0jGjlFCDtURZnAk9P2ZKn9xU59KZiXnWwfiNjrq6IQER+5lDHaoZx9MVRYu+WzkJ9iLQamljilGUm2LK4Klv8dqawN2wAlOsjnQJ264x3gHs6M3TDLsaKX4988KWGIohsVqU4X4rUMRplejKJsRHukLJlLTaN94ahW78IkukEqcWvOWIiXHbMmiTP5vX6U0LgcR6dBXc4JvbXUa3ey3lWbfhHoRbdEMKHKP2rS3VihFJWnQCn/XwsNUsooNOBZX4tdQ3u973UNfDfjP1zp16mbzLwXrOillXQjiXPsZ4FwknMb92V7Q2M0Vgdda+7hpBg5lQmRlmqGSrlNyuwziB7jG9fxBHJC+axNRU8+2lTNOXcSEO3wC6Sbg8iIHf1jJBisb0Oiz5+eE8m7BxanufKBO9wVsQI/CWQUth6mNyVvky9rqmPTXeD7/6rDqhTioZmvLk+mwEdl1imOezGeM/1wy3UndhowHOsjY5BfE/ujgtO0WEKYWicb3Hh/MJIENPerfDJioN+pB5hCg/H2MeZxNwbeVbFfj7Z9hp9GnBoh5PRIjM4R2n+yahxKpwr81E6DyuJeD
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(5660300002)(356005)(82740400003)(4326008)(8936002)(36860700001)(70206006)(70586007)(2906002)(36906005)(47076005)(26005)(6666004)(8676002)(6636002)(316002)(36756003)(110136005)(186003)(54906003)(82310400003)(336012)(478600001)(2616005)(426003)(7636003)(6266002)(4744005)(107886003)(42186006)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:57:17.3628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90745c5-9671-447d-0c3a-08d8fb80ea13
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Increase AXI DMA transaction segments count to ensure that even in
high load we always get a free segment in prepare descriptor for a
DMA_SLAVE transaction.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
- None
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 14dcfc473e52..890bf46b36e5 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -178,7 +178,7 @@
 #define XILINX_DMA_BD_SOP		BIT(27)
 #define XILINX_DMA_BD_EOP		BIT(26)
 #define XILINX_DMA_COALESCE_MAX		255
-#define XILINX_DMA_NUM_DESCS		255
+#define XILINX_DMA_NUM_DESCS		512
 #define XILINX_DMA_NUM_APP_WORDS	5
 
 /* AXI CDMA Specific Registers/Offsets */
-- 
2.7.4

