Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2B30AA94B
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbfIEQoe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:44:34 -0400
Received: from mail-eopbgr820041.outbound.protection.outlook.com ([40.107.82.41]:36096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728601AbfIEQoe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:44:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llen5VqxdLkS3wCNMHF9n2qCsyBu+qZIqDh+3iUXzdqVcRgKpRtGJse6dyL6MTXRcIwdAepl1ddo3IeXq1YVlLCi/24JSNi7GPGDEU/ohSUOEhex2JVd19F9AO6pNU7BSI4ZS/2iLrMBRBfSyfO3KHtK56908CW3WpMYpG2bif3yjE5ohLsvawPKyjcwbup5/Fa0aYkbNFAH+tZ7fOyX9zCfY7LOLGuTi/du8flvCJF0nE2j8YvCnB97dPOLww2S4YFkjX4Bun4oFTMpsGcNYvTGTb/RIZWU/Kx9PKFAFdj3olTWF7XNcLheSABi3dmeywzWdFlWzC4zYJmoT7igNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XeiAuPaLEVFIz8TRH6ejTMOetWQ5SdX+IQ3VEFER50=;
 b=oU4Skg9ojBUTQyvxDNX6Hy+yvsCLeXXHJ+XzVlWmjbed3WA/yxlfYYUrBmg3AQqbF1Kbz1yqdfYaHZH+8S7Nb8BPypr/FopfwIU3yZNT5QiEjjz4ch5hgUDUExOzck7oPpO5lTJtczYfDZmffV6w9Ci/myshK6sxrLAndrnRp4o1QezRephjEGOJTue+eO+nIJLO7X8it3lg/3kMNJQEJpF+wF2ZrVshxwjda4Gfg28k0LSWEwAIxYh6Rvn666hWQFDRJZ9BuRbVd//+FL5mxeCyo4x26WmX/EQOSuXKDGnbnBDSz0ms8TAjs3OLArXT7QqPwoWCXiZ8f86MMlkpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XeiAuPaLEVFIz8TRH6ejTMOetWQ5SdX+IQ3VEFER50=;
 b=kX4vetgvBFzPF3Ljn38dpC4Ozv1xje7WfDPdwgqi8dnQBdSlEVcT9doapdYg3uN3jT1HAv14Vcx+7x90Y0A85PA8eC5u3f8Y9X6AxYDIlMXVPcRVNXA4jywYTviEX9QKaEGRXnIpNqBg+3KXoUjharF7I19pQPYQD3D7sc0jqvk=
Received: from BN6PR02CA0074.namprd02.prod.outlook.com (2603:10b6:405:60::15)
 by DM6PR02MB5338.namprd02.prod.outlook.com (2603:10b6:5:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Thu, 5 Sep
 2019 16:43:52 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN6PR02CA0074.outlook.office365.com
 (2603:10b6:405:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21 via Frontend
 Transport; Thu, 5 Sep 2019 16:43:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 16:43:51 +0000
Received: from [172.21.6.17] (helo=xir-smtp1.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5urO-00055y-Ak; Thu, 05 Sep 2019 09:43:50 -0700
Received: from [127.0.0.1] (helo=xir-smtp-dlp2.xilinx.com)
        by xir-smtp1.xilinx.com with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5uoF-0003dC-KL; Thu, 05 Sep 2019 17:40:35 +0100
Received: from xir-pvapsmtp01 (smtp-fallback.xilinx.com [172.21.6.17] (may be forged))
        by xir-smtp-dlp2.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GeW61001920;
        Thu, 5 Sep 2019 16:40:32 GMT
Received: from [149.199.38.66] (helo=xsj-pvapsmtp01)
        by xir-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5uoC-0003d4-CJ; Thu, 05 Sep 2019 17:40:32 +0100
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul8-0006xd-Mh; Thu, 05 Sep 2019 09:37:22 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbLWm015589;
        Thu, 5 Sep 2019 09:37:21 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul7-0006wf-1I; Thu, 05 Sep 2019 09:37:21 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 67FF3101074; Thu,  5 Sep 2019 22:07:19 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 8/8] dmaengine: xilinx_dma: Clear desc_pendingcount in xilinx_dma_reset
Date:   Thu,  5 Sep 2019 22:07:04 +0530
Message-Id: <1567701424-25658-9-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.002
X-TM-AS-Result: No--4.495-7.0-31-1
X-imss-scan-details: No--4.495-7.0-31-1;No--4.495-5.0-31-1
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(189003)(199004)(11346002)(446003)(70206006)(126002)(6266002)(107886003)(2616005)(316002)(4326008)(486006)(476003)(305945005)(2906002)(8936002)(47776003)(50226002)(106002)(26005)(52956003)(51416003)(186003)(6666004)(356004)(36756003)(76176011)(14444005)(336012)(5660300002)(103686004)(426003)(70586007)(81166006)(81156014)(8676002)(478600001)(16586007)(50466002)(48376002)(42186006)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5338;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4268fe91-8d9b-4ca3-a4a5-08d732203bae
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR02MB5338;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5338:
X-Microsoft-Antispam-PRVS: <DM6PR02MB53387E3626B6C04C52665F84C7BB0@DM6PR02MB5338.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UCKnd18Uq6gneVKGaUwQY3mKl3x15ZXTXEpvAlM8yr5IPomyZhuSgJPl5kiKFfZuBjPJG46KveZ9qGlrzSRjS9azWMhncICsbi9ts82E7zFP1A9aIwhWAElBYSErUaOY8g9467yBWEVAV2P+nfbv07y9XC+EL7o07ymo5C2/R8ciZDMbtRBbMVuVFm2ceDSi+zBKTBg9EujvOBVL/2gUBH/iuGW09GYh1CAV4A2+Y92REqSu6cKYr2FuTzo40bHxuYOszd7I82j5BEPT/T9yLYsWx5xcwSCO7mpfXRcuCM9l247i1OaYUohGlamDSSTkYQrWq/iTExzK5VxcNqZbry4xyzy1wKuWYj+vk5foK/K6EmA1TcBKpPfMbmKhN7yHiT54qHk69gJU6GG+x//+ymu7XP/nhTajkg8PInbhS1s=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:43:51.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4268fe91-8d9b-4ca3-a4a5-08d732203bae
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5338
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
 drivers/dma/xilinx/xilinx_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 0896e07..010baed 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1480,6 +1480,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 
 	chan->err = false;
 	chan->idle = true;
+	chan->desc_pendingcount = 0;
 	chan->desc_submitcount = 0;
 
 	return err;
-- 
2.7.4

