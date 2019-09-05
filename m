Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D966AA945
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbfIEQoK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:44:10 -0400
Received: from mail-eopbgr700064.outbound.protection.outlook.com ([40.107.70.64]:42593
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387726AbfIEQoK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:44:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFhcfCIwwY2TQredgodRytsKtV10QlRQeWj+d3kXuIAYEBQGGjBgbus3cssFOKMr2uEuIvxVgrSMOX+T7UeevWO0vkF7BI6/d05+d0B+HiSbicp8DXSVrUBw6wOz60Yg0TOaHEube085tfqGzL8V69eCFiVQoqeO5lLA3GR8VE5H4d73WGp4HVoluI+Y/KgWtmmP/9H3cg6+EaCJXwseXE38y0cXC5Y1JruMqZyB8TPnjY+uphwXkcKsmPcyvzyj99MEaz66Cj1sneOFn6SPfOv/P65d96a/5YPs/gNH4J+7Ke506alBQ0sGbbdVwTmKyJ+46zAf9GOVjq20ktEuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imU3yJxwD3dnI0IsVH6zCtvtjA4T18YjoeWVTyYYcH8=;
 b=ocW35/No7q68O6Temmu90fMkqgutS45fcN5Yl9EEbwml7anEiIvyV9gDk2MaqPht4aqts8J6wvxxHCnpzMaVjdTY7MzU/0PQLBMWLRVVqQIWpMYUSrNjwEbAHZ0HlnA8wPmhlzUJvrVYK/Yg06TmmlFVe5nF7w3qd5IbnO2lUTLDkFteU0UwXlmsDd+u27NLfyyqmJAAs8NvhYdGtH1yE+2Icup6cm7M8uZ2AEq3QtN+2Vja5kbaqoXxELvjVKvp7v0J7bbd4YOQh4InWq3jjk9QbdtJfCVO35z0s21+H7Uc2UuCBeNNYSyZR+iN8ddsl4Ij7eM5CxJLZ9sKag30Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imU3yJxwD3dnI0IsVH6zCtvtjA4T18YjoeWVTyYYcH8=;
 b=jk0gpXqvFMtpwMtDt4bCUL0UuLJYepBaaFdVamm2gyjTV781C4gq6xUuSfNmKISJkW+WHWUDLy/hl20JMJ6HuIKHvix2WnuWqATNJXBtYv2xr7SEcs9rhBthHO5nwy+W9M4kNQEorZtqGv9Xi+Y82ZxqwccaUw5Cp487eKIQmFM=
Received: from MWHPR0201CA0108.namprd02.prod.outlook.com
 (2603:10b6:301:75::49) by DM6PR02MB5257.namprd02.prod.outlook.com
 (2603:10b6:5:48::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.21; Thu, 5 Sep
 2019 16:43:52 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR0201CA0108.outlook.office365.com
 (2603:10b6:301:75::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.13 via Frontend
 Transport; Thu, 5 Sep 2019 16:43:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 16:43:51 +0000
Received: from [172.21.6.17] (helo=xir-smtp1.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5urO-00055x-97; Thu, 05 Sep 2019 09:43:50 -0700
Received: from [127.0.0.1] (helo=xir-smtp-dlp2.xilinx.com)
        by xir-smtp1.xilinx.com with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5uoF-0003dB-Jg; Thu, 05 Sep 2019 17:40:35 +0100
Received: from xir-pvapsmtp01 (xir-pvapsmtp01.xilinx.com [172.21.6.17])
        by xir-smtp-dlp2.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GeWpD001919;
        Thu, 5 Sep 2019 16:40:32 GMT
Received: from [149.199.38.66] (helo=xsj-pvapsmtp01)
        by xir-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5uoC-0003d5-D9; Thu, 05 Sep 2019 17:40:32 +0100
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul8-0006xZ-O3; Thu, 05 Sep 2019 09:37:22 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbL05015586;
        Thu, 5 Sep 2019 09:37:21 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul7-0006we-12; Thu, 05 Sep 2019 09:37:21 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 61619101073; Thu,  5 Sep 2019 22:07:19 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 7/8] dmaengine: xilinx_dma: Check for both idle and halted state in axidma stop_transfer
Date:   Thu,  5 Sep 2019 22:07:03 +0530
Message-Id: <1567701424-25658-8-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.002
X-TM-AS-Result: No--2.872-7.0-31-1
X-imss-scan-details: No--2.872-7.0-31-1;No--2.872-5.0-31-1
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39840400004)(396003)(376002)(346002)(2980300002)(199004)(189003)(478600001)(16586007)(316002)(356004)(6666004)(42186006)(4744005)(52956003)(103686004)(107886003)(6266002)(4326008)(305945005)(70586007)(476003)(446003)(126002)(426003)(2616005)(11346002)(486006)(26005)(47776003)(106002)(2906002)(36756003)(5660300002)(51416003)(81156014)(81166006)(8676002)(8936002)(50226002)(76176011)(70206006)(50466002)(186003)(48376002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5257;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ee56902-c49c-43ed-7437-08d732203be6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR02MB5257;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5257:
X-Microsoft-Antispam-PRVS: <DM6PR02MB52575DBAF4703071B260C393C7BB0@DM6PR02MB5257.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BywMnVk+n2TU3AuNb7tpmBiIrXB4YF+WkoTUUT51Cp8n7piTRtVLcFKtgYHo9nuzrzXQZ6E4p8Fjw2r+dhOKrq4ZVsfIsGk6/oP8Knjeht1U5QCHMiKayENac9wUCZ0OCJuM93WTT3Vxqe9cfv8y/LdZtf1XKfA37D4OFLBoi31jHfRvCweE5LJNNzNQv7WepdxzuocIG0AHqd3UvHaAToPYxIVgMNZ1P5s99facZ2+OUEHUqW1K0cEzYFRQPu1TmxrTRlQq2o4I2vwDFe3ehibDsFp5GImKL9/6d6NM8fl0cA8kWqXHtVO9vJeym++5IKYPyqTKxdacxLVeiHPF9k2h6TsB9aD/oxm0eyC4nD8S5jGRWuXCnJSH7M9NaIg3lsVa9SD78I5rBWPd8WmMZf9YgqPof8zciWrX+d6Cszg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:43:51.7622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee56902-c49c-43ed-7437-08d732203be6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5257
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nicholas Graumann <nick.graumann@gmail.com>

When polling for a stopped transfer in AXI DMA mode, in some cases the
status of the channel may indicate IDLE instead of HALTED if the
channel was reset due to an error.

Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b5dd62a..0896e07 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1092,8 +1092,9 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
 
 	/* Wait for the hardware to halt */
 	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
-				       val & XILINX_DMA_DMASR_HALTED, 0,
-				       XILINX_DMA_LOOP_COUNT);
+				       val | (XILINX_DMA_DMASR_IDLE |
+					      XILINX_DMA_DMASR_HALTED),
+				       0, XILINX_DMA_LOOP_COUNT);
 }
 
 /**
-- 
2.7.4

