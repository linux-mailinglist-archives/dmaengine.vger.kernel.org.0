Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30DDD790A
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfJOOsv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:48:51 -0400
Received: from mail-eopbgr790071.outbound.protection.outlook.com ([40.107.79.71]:8080
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726523AbfJOOsv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 10:48:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoXa3e/v25QfuU2O62ccn4sp+ExvzZJMNH4lBBUCZ1qpBjfRvjLXBrYhC2mwU/VmVKFvDSqV4sL1TN0T/1uMB9WFVxVcg70xDbRWuxpa/W4+nDXUYHSZ7rfuuj3y9T4PT5Mx/QXeVVTd+hpmAzDymxXb9NKY5omMEK8ycfoEhvF0bRgWkYine+uvq+/tzUADuptICO3LSjZNTUIJguV0reDElFCKDMDKiBngxSLW5fDj9ouqlMkede6ToNnwLyX38MR3HY/0ht/jxCpiSdLf1GrxXfHxXc428keSxbfIulJWR3EhGB7Rd5xp9cDJ3XbMxibqxxH+rykWflCet04PTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI9tyAIbqw/J3VJHMPGaDDeK+uy30YVr0Cww27ovDLU=;
 b=CSzqNjVUL4jf2lXRmnouU0h7o9qJewyCoqhBuT2sDtmWuUDreUL62nXVCAnWDPVjsI0QZcTkiAKQsrtAWdJVKEwxGg4h9G7b1YOsBDANV5YzNftmOBpC+MhXp/QmHW2bQwZsSf1doFfCRkRVdZ1mq4Ll6LxgsbcEzREf/6U030iQRZrrSyHE7MLrwDnPnuguuAElnr43UWodvJ6nGlwPqU9QSY+VxthWis5IfzkHWJOGZeItjbYAh4t7BG1lwZyLOLkOurW+TnYKHq/X4jdfde8mYsnAyfDP57t30S2s9wFB2er79IRqWMRg7fnKXFT9S0t56Jvb8Pn1TbA7irNh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI9tyAIbqw/J3VJHMPGaDDeK+uy30YVr0Cww27ovDLU=;
 b=bBwotmV8rVpQlewSjWNugHTd1p67q2+elA+0Kbr16wt0nv45CaZe/1i1xgmDdFSbSzaAli72Gi79GztafibIEBi/a+NRJWmQFqnOwSjoyDsGKHULrj270Z4A+7YR3RZcAOWBq/n+sT65vMX+CDaXvePTH8hE2VpiCUujRmtO8mg=
Received: from DM6PR02CA0092.namprd02.prod.outlook.com (2603:10b6:5:1f4::33)
 by BYAPR02MB5685.namprd02.prod.outlook.com (2603:10b6:a03:9f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 15 Oct
 2019 14:48:48 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by DM6PR02CA0092.outlook.office365.com
 (2603:10b6:5:1f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17 via Frontend
 Transport; Tue, 15 Oct 2019 14:48:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 14:48:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7z-0006Fu-70; Tue, 15 Oct 2019 07:48:47 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7u-0002AS-2M; Tue, 15 Oct 2019 07:48:42 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9FEmfr3014659;
        Tue, 15 Oct 2019 07:48:41 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iKO7s-00029V-On; Tue, 15 Oct 2019 07:48:40 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 045E410112A; Tue, 15 Oct 2019 20:18:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next 2/7] dmaengine: xilinx_dma: Merge get_callback and _invoke
Date:   Tue, 15 Oct 2019 20:18:19 +0530
Message-Id: <1571150904-3988-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.555-7.0-31-1
X-imss-scan-details: No--1.555-7.0-31-1;No--1.555-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(70586007)(426003)(356004)(11346002)(446003)(5660300002)(14444005)(76176011)(6666004)(51416003)(6266002)(50466002)(107886003)(4326008)(2616005)(476003)(126002)(2906002)(26005)(486006)(186003)(70206006)(336012)(36756003)(42186006)(16586007)(305945005)(106002)(47776003)(478600001)(316002)(103686004)(8936002)(8676002)(81166006)(81156014)(48376002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5685;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70bc20f3-1347-4760-d70e-08d7517ec910
X-MS-TrafficTypeDiagnostic: BYAPR02MB5685:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5685A81817B27057CC354FF0C7930@BYAPR02MB5685.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woLjRZXH4eaHDF8/u20n1/oaCJdDQzdMzA+EqxSRGlE5xcbIPlwSBHiDIAyyVWxOzebMGxCsv45cjHAiBLOaDulD1JThFHMhE9QG6pOyYeNtPQesjqtjY13w+J3x0x9UH3Yr9eURE3jH8fe1YJpA+hMKGLNZgsThNZ7oYNm1PxAB88YFDw96XhbKKZQub1qG74XQl3mEQbfc3Hib+qeUOUK1vAmCHDRgXN/GhQYt3+zcnTywxMjLmVkCPExKUBm/0acaTYY/HIp5BP5JX8s8X7hUMTJLkpRgS2vWUnti8l7DeyAM0F/u4XxuhzthXkkzB1BPVTV1aoyy0J/MzslNb8lw02ZGN90ri1GtPwKk+oDMBpcCapBoW8TKYtE8uM4SSiDPA4Unahj90wJIdIow3oEMF+XlhxQvp79QN43i1mI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 14:48:47.6136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bc20f3-1347-4760-d70e-08d7517ec910
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5685
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nicholas Graumann <nick.graumann@gmail.com>

The dma api provides a single interface to get the appropriate callback
and invoke it directly. Prefer using it.

Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
None
---
 drivers/dma/xilinx/xilinx_dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a3f8a2c..465dabc 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -823,8 +823,6 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 	spin_lock_irqsave(&chan->lock, flags);
 
 	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
-		struct dmaengine_desc_callback cb;
-
 		if (desc->cyclic) {
 			xilinx_dma_chan_handle_cyclic(chan, desc, &flags);
 			break;
@@ -834,9 +832,8 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 		list_del(&desc->node);
 
 		/* Run the link descriptor callback function */
-		dmaengine_desc_get_callback(&desc->async_tx, &cb);
 		spin_unlock_irqrestore(&chan->lock, flags);
-		dmaengine_desc_callback_invoke(&cb, NULL);
+		dmaengine_desc_get_callback_invoke(&desc->async_tx, NULL);
 		spin_lock_irqsave(&chan->lock, flags);
 
 		/* Run any dependencies, then free the descriptor */
-- 
2.7.4

