Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DE4D7913
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbfJOOsw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:48:52 -0400
Received: from mail-eopbgr770088.outbound.protection.outlook.com ([40.107.77.88]:42638
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732898AbfJOOsv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 10:48:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPcgK7szQJkqxzAvGJ8qV2RfPNjzJhZi2K5nhqRxS09jBRFwtDQ5Du6N2jsT/0WsUNXe0V3meECQitrBBFITWzG0DV0ACk68mUbT3/XzaNRF865oBpDev/EbOSz8k68gMnnwW9Sevcl38XbiVJd1wpXuxf5du0ELPH055BqYuidyXRmiEocuahx+cfblEVU5DAoi6lRh3vxgDhHjLJnuhZDzU0h2wf2ClNNwkfR69AGb73cb+mMLsmuZ10WplPICrSVUyBGEznWXtPiwQsdVtL6uMsqw88HA5xYDhBf2Ne/TPwXWSc1gcqK86FGP12J5HeXG9hyup/ED2dLnY0tcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bfw98o/cttjLLeVQI8WWVEumV9j5VRzeCFqb5qcOQc=;
 b=WNzIf6Su5Yr53joArxeDH09hC6SejwQjL46hGMyVz8dVhlFIC/X7XHkTkp/4UT28BUoji6BCSV8gLLo+/0S4X3vlfZWyVRS8jCDYdU7CuGoZyhZYM++NRtEGjVwDKJSGBaHMzNzVrkj1KQLJF1Q6RzrOIrPtnQBviMwdTmJEU9k/VK1jZiIbCg8kBH0hzt94RNPmnB8ovGIwhek7W0GMPAOYbPkis4PW/9qZziCEfmPmXzT+NnfzfcCdJuj1TXPKi3Fr+SGhzxzou1/8YuSYIo3HoJ4zN4DkIoniOHdbvEEDOMsbkup6ujE/oo56MvGK+nbcUvLBUZWuK2VUhF3xAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bfw98o/cttjLLeVQI8WWVEumV9j5VRzeCFqb5qcOQc=;
 b=datBo8qo2LesbAu6Ds5QWuCKzCBpm3cEEld4xsQG3DvuC+mt4ZtN9kHpuxFlm22ytlrBaAnX5pfBMlGMEhp3QdZ/mSzxhmTqZ0Duz1KkYFlzGDMcD2oogMKHhWycP+A56uJCAME9X2Dc+UI62fySe6tjfv93ecj2y3GnSfwR4UA=
Received: from DM6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:5:1f4::36)
 by CY4SPR00MB232.namprd02.prod.outlook.com (2603:10b6:903:30::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 14:48:48 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by DM6PR02CA0095.outlook.office365.com
 (2603:10b6:5:1f4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via Frontend
 Transport; Tue, 15 Oct 2019 14:48:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 14:48:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7z-0006Fv-8X; Tue, 15 Oct 2019 07:48:47 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7u-0002AM-3q; Tue, 15 Oct 2019 07:48:42 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9FEmeSK014655;
        Tue, 15 Oct 2019 07:48:41 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iKO7s-00029M-NM; Tue, 15 Oct 2019 07:48:40 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id EB543100DD5; Tue, 15 Oct 2019 20:18:39 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next 0/7] dmaengine: xilinx_dma: AXI DMA driver improvements
Date:   Tue, 15 Oct 2019 20:18:17 +0530
Message-Id: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--0.503-7.0-31-1
X-imss-scan-details: No--0.503-7.0-31-1;No--0.503-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(136003)(396003)(376002)(189003)(199004)(106002)(316002)(6306002)(51416003)(16586007)(42186006)(47776003)(50466002)(50226002)(8936002)(107886003)(81156014)(8676002)(81166006)(6266002)(26005)(186003)(2616005)(476003)(6666004)(356004)(36756003)(126002)(2906002)(336012)(5660300002)(486006)(70206006)(103686004)(966005)(305945005)(70586007)(4326008)(426003)(478600001)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4SPR00MB232;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1d07745-0640-46e7-1f9a-08d7517ec945
X-MS-TrafficTypeDiagnostic: CY4SPR00MB232:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <CY4SPR00MB232C02122732DD658ABA2B5C7930@CY4SPR00MB232.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pDvTE6Oj172NGO9Jg04V62SdYyqF0RBeAgzvPl328yjqeHmkClSW45h/jdhpIoWWhKP4D5U3n6k+YDWb5PqVWDahmDVmknInCgs6qh8BVzByOjqT2jzrzyegzXB9SDz7WXYHPRDR2n+UyfhSMtks1oXeibXFvpX52YbTdMErqPbs3aq9adyrC8fblRGD866lLCVVavALxQEPFPAxndHmetbg0iC+6XwfWBKCkyhmpb2nZ/+UeDYVG/h5JIVL03Yy6OQd9eC9pyRwh7NlIqtsCCNUGX86GcuahuI8flh8u4wKHoqUiEfwOqPKt6F1UzPzVqprrki9NvnrPLcMxS0+6kPKSG7oe5gPAHzNYT4DW3dqBV4i5xVAmhTIq2Kq/HTGJbf3j/cToYO3flW/u8qlIZTxgLib/FyQWYmhuSSbGBA3Dl8iGtv4L/mPoxrMMJnqTtCMDkFEgswy+puvij+x6A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 14:48:47.8952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d07745-0640-46e7-1f9a-08d7517ec945
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4SPR00MB232
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset adds callback result, descriptor residue
calculation and some regression fixes.

Changes for v2:
- Fix commenting style in 3/8 Introduce xilinx_dma_get_residue patch.
- Invoke get_residue for supported configuration and remove internal check.
- Remove residue from channel data in a new preparatory patch.
- Drop patch checking for idle state in axidma stop_transfer. 
  It need further debug.

Please refer to below link for more information:
https://www.spinics.net/lists/dmaengine/msg19480.html


Nicholas Graumann (5):
  dmaengine: xilinx_dma: Merge get_callback and _invoke
  dmaengine: xilinx_dma: Introduce xilinx_dma_get_residue
  dmaengine: xilinx_dma: Add callback_result support
  dmaengine: xilinx_dma: Print debug message when no free tx segments
  dmaengine: xilinx_dma: Clear desc_pendingcount in xilinx_dma_reset

Radhey Shyam Pandey (2):
  dmaengine: xilinx_dma: Remove desc_callback_valid check
  dmaengine: xilinx_dma: Remove residue from channel data

 drivers/dma/xilinx/xilinx_dma.c | 111 ++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 27 deletions(-)

-- 
2.7.4

