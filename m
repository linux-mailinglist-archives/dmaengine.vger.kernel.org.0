Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1408AA92B
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfIEQhq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:37:46 -0400
Received: from mail-eopbgr720054.outbound.protection.outlook.com ([40.107.72.54]:43701
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfIEQho (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:37:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UI4LYa7nh7IRklHoqeCyKXlRgZfwerFUROR7sOTJQp1e5ZKUmaxivsIkXu7EBwxExwOxBANH0lvmsQ+wWSTT4zlRgSyrm1ahK9StWiiMvtPfRq34xD2DWW1gjDqK1BHUuM3QkXcdlGDSJwpnZyl+HI72EYPAseWc5JxzUjMHWC8ByqRdquC1R0oO+nD+qXAzwCeGb/8j4epuvj2kJL9GSs7U61opTDt7vvv8NWylVlGDucJH97i3s1Fs4A7Sm5qIiwDM0vYARA4hkczQdpSCPaY4grueB8r//lMHMohZUbTo7uBbgXPWjmGexR+ZN2aS6Hp51IRp2l7N4nBv96lEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7onvuECuyHmti1sIlBB7qKO8Y0xRMOesYRg0KnsDe9U=;
 b=B0T8Rmhr5E7474E3/Gvg5JdiHXkQw8rAUXEUhiuBMThzKfu/66nhUSfxQDl5Ndndzpyvh7j4ecFp/DkFpZsZuOiHjGO7TrXyc5atn+39UNv0bi+YqnG0c4f6EEvDlyiGubrlgmD0eDeJW1Qd5yfmX0M1Ku+xq6RYYeq04njbv3wsz0flLXWUbCVME4QpTBjr8iG95SfLmVF36p3eX/J8b6chNL+cb1GcGt371lSDDPXKuC/A1ADc1uLif0Q/0fw+6p1d15euAEpb+ZC4uvyWWsWbdS42qnbHsMpj/8rcDkf1qCorIwrL+n8n5nLuxixZoqzucceXlOoIim0p+ZT49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7onvuECuyHmti1sIlBB7qKO8Y0xRMOesYRg0KnsDe9U=;
 b=NQ03dYW5D3k/lziI8aoYbCrpPucj9sCQGntPRxtE7Eo9etbc5kLmsf/r9y7awxPXeQeqoI/Ff6JuSo1yfAM7xT1wR1X4ZJWy2uxK2LjCUKpjrJPKuTvUC/ooJ6q7n+7anpCb+zyYikPv01XbRmEtn8Wk/nwJJv8AJwwruPXhMsY=
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by BN7PR02MB5249.namprd02.prod.outlook.com (2603:10b6:408:2a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 5 Sep
 2019 16:37:29 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by DM6PR02CA0126.outlook.office365.com
 (2603:10b6:5:1b4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15 via Frontend
 Transport; Thu, 5 Sep 2019 16:37:29 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 16:37:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59521 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ulD-0006fb-LU; Thu, 05 Sep 2019 09:37:27 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul8-0006xe-Ef; Thu, 05 Sep 2019 09:37:22 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbLsi015587;
        Thu, 5 Sep 2019 09:37:21 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul7-0006wd-12; Thu, 05 Sep 2019 09:37:21 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 5AEBE101072; Thu,  5 Sep 2019 22:07:19 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 6/8] dmaengine: xilinx_dma: Print debug message when no free tx segments
Date:   Thu,  5 Sep 2019 22:07:02 +0530
Message-Id: <1567701424-25658-7-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.170-7.0-31-1
X-imss-scan-details: No--6.170-7.0-31-1;No--6.170-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(6266002)(8676002)(8936002)(50226002)(4744005)(107886003)(4326008)(81166006)(81156014)(316002)(103686004)(47776003)(36756003)(70586007)(16586007)(42186006)(70206006)(186003)(426003)(486006)(14444005)(6666004)(26005)(15650500001)(356004)(446003)(106002)(52956003)(478600001)(5660300002)(336012)(2906002)(76176011)(2616005)(48376002)(50466002)(126002)(305945005)(51416003)(11346002)(476003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5249;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5d7c442-a5de-4935-d691-08d7321f577e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR02MB5249;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5249:
X-Microsoft-Antispam-PRVS: <BN7PR02MB52491DA56882DD1518EAAE86C7BB0@BN7PR02MB5249.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yU/VggDegZh/LyEc3HASc0eKl9Uuq0s4erXGi+y5nCzY/3SrFLSPqxh8P8UJs2Kzkcbk78x5nF1+rRRFaAASpbqrBDxCGmoKdsAbs4KaWoOpIpWHR6XRaORlKZjNixQ2pnrQsH+w110RZutEUM9LPE6YKrdchVRfQde3s9mK2HRgW9Ujc61wdlq0EIbYuDQY26+gWRjBGszOzSuM5C/QBnL18sBxL/QH505y5P0Msjp3ePmv48WqPZqUCBc0Eao0Hw0NzdfvcJK+1vrv+2K3kQkObbXqLI3Au5+39vKlZtkPx1R4FHqm5q+OvIOoFJo6td5gnTbRfB/fEH+OGLiNlehzzvcS6KKsgKOsfp8ss+awx/VC7XE8h6RmeHBh7kgP/kOUgKz6ZaIkUWOBCsxHuNz/k0NR9UHxgkMxHmKqqNQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:37:28.6247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d7c442-a5de-4935-d691-08d7321f577e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5249
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nicholas Graumann <nick.graumann@gmail.com>

The driver should not run out of tx segments in normal operation. But,
if the user attempts to prepare a transaction with a large sg list,
the driver may not have enough free segments to accommodate the request.

Log a message at the debug level to inform the user in case they are
experiencing issues.

Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index bf3fa2e..b5dd62a 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -612,6 +612,9 @@ xilinx_axidma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 	}
 	spin_unlock_irqrestore(&chan->lock, flags);
 
+	if (!segment)
+		dev_dbg(chan->dev, "Could not find free tx segment\n");
+
 	return segment;
 }
 
-- 
2.7.4

