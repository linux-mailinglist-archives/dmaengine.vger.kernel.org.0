Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B412AA926
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbfIEQhf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:37:35 -0400
Received: from mail-eopbgr680080.outbound.protection.outlook.com ([40.107.68.80]:41897
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389125AbfIEQhe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:37:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnsHAjdJju46cFNoFsOUm45r60iIPahE9lHsG7Y5qpUdbq2O0WvoZEbu2yB/rW9j7V3vpJaOXWBLGlusZl8F2NukNBf5mACtO/XwwU+VSfocBsvdFoPGpG3qd6LNA4peJlnaMKrDxMrhczLaCgwJCAQe6ylx+l1uH5GsmwmY6NQgrLDpdXwy+aro4rCxHFLbzuIAmkLQd2MWlLP2/s0lXYkH5EchLN2Mx0Rx7xacoKEKYj1U+JzRF0cIpemcaZS0h4dGxWs3ncPaqmu3iL87OIqYNl+6b0oA0aAUVnlDnHZxQq0+10Yz5KYODFg+e7TMAuua/j6YnF5VEd0Rwi5z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKWjKJSyxegNL9gZdvc8C9BEKz+W9RU+tVwscc4FBys=;
 b=PuBgZJu4YNBjqBvE+9VwDyLuPvtRky/D11M4F2Z+WxIYEg6l3h9QWhrMDqJZX+CBwCnh964y7nSPdUtsk3fn1NJS7YWYHbzTuT/OE8NN0NVBab0pT/0uEB9SFmmKGdaseatisLSRFY2TZJMEV9gFNMzmyulSOgFLBEZ+ZMiZQ9JHc2lSeGaw+9ixlla01JKfrKu1pTRjpSWN1PWj0TZP6x/JdbUO1sdBF0gAb7rIIYFFtoywXC0+H8le/3safrZyJuLrW8ERDgmHQb8BfuG4TrvcKBaYYAhnaxkbmbOmStBt+7K6xLVWLzMY5GKXPNO5IxOpZcbt6i9pLNc5vN1Y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKWjKJSyxegNL9gZdvc8C9BEKz+W9RU+tVwscc4FBys=;
 b=WAkh0dPgRYxuzXrQM8nAcgS7BZKaBJSnETJMjtSJ1fDBtNLQYxh/rsBhLPjq4ScH9GUDsXswLOd1MdBJHsA0i9rpEKtWVd3mz86UQIkl/GDOpI/iEkS9ilnH085Cfv+4/MTEsLzXAxSNoxeEbdG8Y8KEtPC6Ey5sjrKHVlKN7PA=
Received: from BN6PR02CA0096.namprd02.prod.outlook.com (2603:10b6:405:60::37)
 by DM6PR02MB5338.namprd02.prod.outlook.com (2603:10b6:5:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15; Thu, 5 Sep
 2019 16:37:30 +0000
Received: from SN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR02CA0096.outlook.office365.com
 (2603:10b6:405:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.21 via Frontend
 Transport; Thu, 5 Sep 2019 16:37:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT063.mail.protection.outlook.com (10.152.72.213) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2220.16
 via Frontend Transport; Thu, 5 Sep 2019 16:37:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59492 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ulD-0006fa-Jt; Thu, 05 Sep 2019 09:37:27 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul8-0006wl-9M; Thu, 05 Sep 2019 09:37:22 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbK57015551;
        Thu, 5 Sep 2019 09:37:20 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul5-0006wD-V6; Thu, 05 Sep 2019 09:37:20 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 30B51101052; Thu,  5 Sep 2019 22:07:18 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 0/8] AXI DMA driver improvements
Date:   Thu,  5 Sep 2019 22:06:56 +0530
Message-Id: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No-1.072-7.0-31-1
X-imss-scan-details: No-1.072-7.0-31-1;No-1.072-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39840400004)(376002)(346002)(2980300002)(189003)(199004)(70206006)(4744005)(126002)(6266002)(107886003)(2616005)(53936002)(316002)(4326008)(486006)(476003)(305945005)(2906002)(8936002)(47776003)(50226002)(106002)(26005)(52956003)(51416003)(186003)(6666004)(356004)(36756003)(336012)(5660300002)(103686004)(426003)(70586007)(81166006)(81156014)(8676002)(478600001)(16586007)(50466002)(48376002)(42186006)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5338;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02e618d3-b126-42c8-6265-08d7321f577f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:DM6PR02MB5338;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5338:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5338C181263CFD0FFB604987C7BB0@DM6PR02MB5338.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: w50wWTPIIg1bjJU7LZwCJR6/2ucoJcComXcCDY+yRSP0DhnifzLGBuOFivohfYik8VtF/qk5ZvDzJu+6fLqMQ24NzYvNenJyn9qO0rmRqFx/Anboa8ZmZ3MN3N+v2bEPakvHAxMA9uXuHwkXR4jCecn1M07W6/PtHw4HiaJ6Vpbdd4EXf1M+dYi4EWbale+X1SH2Bs7Jj774NZLnXh/qe+uHpt8jwpzsZuktJBd2+lkWJ2oel7eTs0ZbrnfkkfUcCAtvGUIJ3ZCva0Zege0GfriibrsEQr7+tjt8iyxvM0RalrPDhRszA0iZlezm1ho9s8uP6bB1+hAFJxw6hOpxPpz33cBLPrsNQ/MzeYDYQcX6XvDpsLUjpPwwrC4duhVjTKXSInXMx865l6TRbjyvNQ/dDJj0x073zZx0RC2lrIk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:37:28.6593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e618d3-b126-42c8-6265-08d7321f577f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5338
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset adds callback result, descriptor residue
calculation and some regression fixes. 

Nicholas Graumann (7):
  dmaengine: xilinx_dma: Merge get_callback and _invoke
  dmaengine: xilinx_dma: Introduce xilinx_dma_get_residue
  dmaengine: xilinx_dma: Add callback_result support
  dmaengine: xilinx_dma: Remove residue from channel data
  dmaengine: xilinx_dma: Print debug message when no free tx segments
  dmaengine: xilinx_dma: Check for both idle and halted state in axidma
    stop_transfer
  dmaengine: xilinx_dma: Clear desc_pendingcount in xilinx_dma_reset

Radhey Shyam Pandey (1):
  dmaengine: xilinx_dma: Remove desc_callback_valid check

 drivers/dma/xilinx/xilinx_dma.c | 115 +++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 30 deletions(-)

-- 
2.7.4

