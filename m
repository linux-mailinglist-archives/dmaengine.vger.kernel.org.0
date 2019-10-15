Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6A2D791C
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbfJOOtb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:49:31 -0400
Received: from mail-eopbgr790077.outbound.protection.outlook.com ([40.107.79.77]:36000
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732907AbfJOOtb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 10:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpj/06Br/5kXDGOyNyL6F6C5rOuJrFlWVMxXNraf97k5fP4IpOL0pjQ9hMJ1uGGphqDMeAemyX+B3/N7t1zYjhLbCAcuvxAZ5Utiagb20AaCuNb651ktpI77y5NbCiUOhKO029swEzCwKvrr+3df3zXP/pJADJffEnqtTWSYtIm99i5SumuM4bCOIZRQEe0SsaqhSqBWLOQwrOXb6CUgLvBuyL1g6BoGtbxZskApizT1ilyV3XfCNp24jJnxkT2Iixlg4LJVnr1YqQzaXLgG6qxblVmYwiP7uwW4XE5e+boMDie3DtTv6O6rNx084l7mTCXzNYPq5YOw2qMJwFbsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=879x4uIEcFfpbOIYUNwQp4I3jzO6zD3qihzm+cqn7t8=;
 b=OS0HGELj3x2Ckm6JEG6u0d4obk6fsE3dsvqe/23XjXAnYHUqVwReDPF4eGtKmyNqE9gYeuwUHE3WWj4Mg5tr+QnI/NX4elIb4tcJFF8a4Wp1FyMbBYEIitsT8Kt5G5Gh4m6BZ6HV10T+vftdGL5XBjNgl7c6SOvTUyXvML0mVJ2bG66p2Y2rne05EhyIr6+gy5vJtSrqbem3wjWM3bMtL9LKvc5dExZ60y00vTZU9maVdNDHllSPYbMF/RsGtyjs8EQh5pSJxYpvr4COt28qutGhWL7fK3nBDHmSAmGqTSO9zJhVscnJjpgKwINERKeLIKW5WaXMO5T6N1gFE820dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=879x4uIEcFfpbOIYUNwQp4I3jzO6zD3qihzm+cqn7t8=;
 b=ii5E+uQ7QxQUjtOQ2CD4w06Es3fiCNru25FyxpsVayGZqrOkfFHh/fzyWEAyyOlGJl26E+Pf5ScnS6dlwn/ng/wsBgIssr9b2JLhNxpvrZe25Fhdre7REqcqk7k6YJsc/QU4WZJdeBVHB/MLU4CghKJADvZFrGr1Ke+pzu87vD0=
Received: from BL0PR02CA0093.namprd02.prod.outlook.com (2603:10b6:208:51::34)
 by CH2PR02MB6475.namprd02.prod.outlook.com (2603:10b6:610:35::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 14:48:48 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BL0PR02CA0093.outlook.office365.com
 (2603:10b6:208:51::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.18 via Frontend
 Transport; Tue, 15 Oct 2019 14:48:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 14:48:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7z-0006Ft-6W; Tue, 15 Oct 2019 07:48:47 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7u-0002AP-20; Tue, 15 Oct 2019 07:48:42 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9FEmfft019620;
        Tue, 15 Oct 2019 07:48:41 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iKO7s-00029Q-Nu; Tue, 15 Oct 2019 07:48:40 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id F07A7101128; Tue, 15 Oct 2019 20:18:39 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next 1/7] dmaengine: xilinx_dma: Remove desc_callback_valid check
Date:   Tue, 15 Oct 2019 20:18:18 +0530
Message-Id: <1571150904-3988-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.874-7.0-31-1
X-imss-scan-details: No--3.874-7.0-31-1;No--3.874-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(81166006)(81156014)(36756003)(50226002)(336012)(8676002)(486006)(186003)(47776003)(76176011)(70206006)(70586007)(51416003)(50466002)(107886003)(6266002)(126002)(2616005)(11346002)(446003)(426003)(476003)(8936002)(103686004)(478600001)(14444005)(4326008)(42186006)(16586007)(316002)(305945005)(26005)(48376002)(106002)(5660300002)(2906002)(356004)(6666004)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6475;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700cfc63-dba1-41cd-fe26-08d7517ec91d
X-MS-TrafficTypeDiagnostic: CH2PR02MB6475:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6475677B9EF8EE90F18A34B9C7930@CH2PR02MB6475.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvJFY/SJHq8IsFpKcFAwNoMxtoAKPT2bE2vZSODM+4l5tA/iQ4rTYENBbsiiyE5gJGTGro+ZcIHnNBJNtvDsoASc87okYD9NzJ4kui0S0Yyvzzmzkhxpn3N+ucba9Gxnb91OP+Vgcp2xBzwE5ff5GOccMwJKXIoNM7C1WKz4dPbfXhIYwmib31g/cgjRSWJalupnVLi5EnMJ3hvesvmLKvr9Lr5KKnNtwHW0prfEIZ29VXlmIGivCyHf0y9+/1htBrQaDj/1ScESJKxoCZrJwM0/UE1tc/jXGxohrCJXSHN1VbZ/+oe0ueCJETHM9CVtXC37PzNtwqiqWIfzkJu/Tir+aRoM2WEjiz48JRC+265+jIqC+NsbITIX+baSjt5zJar59zDQ/ujgmeXjC0ctINloACOK6O2YusKuOjF34N8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 14:48:47.6718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700cfc63-dba1-41cd-fe26-08d7517ec91d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6475
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In descriptor cleanup the call to desc_callback_valid can be safely
removed as both callback pointers i.e callback_result and callback
are anyway checked in invoke(). There is no much benefit in having
redundant checks.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Reviewed-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
Changes for v2:
None
---
 drivers/dma/xilinx/xilinx_dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 440f2ce..a3f8a2c 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -835,11 +835,9 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 
 		/* Run the link descriptor callback function */
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
-		if (dmaengine_desc_callback_valid(&cb)) {
-			spin_unlock_irqrestore(&chan->lock, flags);
-			dmaengine_desc_callback_invoke(&cb, NULL);
-			spin_lock_irqsave(&chan->lock, flags);
-		}
+		spin_unlock_irqrestore(&chan->lock, flags);
+		dmaengine_desc_callback_invoke(&cb, NULL);
+		spin_lock_irqsave(&chan->lock, flags);
 
 		/* Run any dependencies, then free the descriptor */
 		dma_run_dependencies(&desc->async_tx);
-- 
2.7.4

