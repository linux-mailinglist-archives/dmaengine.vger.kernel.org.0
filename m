Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4C7D790C
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbfJOOsw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:48:52 -0400
Received: from mail-eopbgr800053.outbound.protection.outlook.com ([40.107.80.53]:7680
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732909AbfJOOsv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 10:48:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdlgAilvWZ0oEIhDR2hWYjvobYNEGf3Ew9zKk3X40XR7CWdfeQ2rWY4QM9eeKOPDu/FIRladvmIuAESeghjlQiAp5Rlo/FuuNw1tXtlXabkAUKhb9T53bh3vCB7tRpbY7f2/BFnzItjJQyUPi/1jiB1/miPK1ERvzfkYRw9jS0Galp1n9arKHg7VDOcaeN+iSsoTK/FqaGVft8r3M8+sNJvPAyZxerEy3reC7U1Tegnu0vu2x0eMMfHkdzTdR0aqp6bp7kvjHeFXhS3iwNfDUepu1raUsPChrrXMx9Ndmg2dRgfQuGaKqkkOX/cMYic3IymvrCV1zeJ8LilYxXwi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7i5O8AkP7mVizfDypfihzcLg7vKXFkfhX8XCF5XkL4=;
 b=RgbHXFblrjQ4SF8s/FlNm3qJFwRVh3Ssmh+dkTTiA3Qr4/XDADo/m+YokUwiHZWj7efqX/ofjWRJU+SoL8MUUWqPLyKrQF/3yCcyJofK9tjUmYX+OKGHsN42U/58IRKmElkKwwEgZmYhnp0yBxegKXkiz4q636wCASxa2E1dsJY8MTA905ZWMFM79IU9BYp3ckqvxsAvFDwOUz13c2rZlXSJGL3/GD1ziJl+hb21IfA8aqtsmQQioPBbOZx23V6aoA5tkbQzOAjlC9fjicTgg4Jxv+wegfGN/SqNrYazyWpc5UszfCMzP+AKvXwQ8LsUkutU73/Vhf+etl0G1zXPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7i5O8AkP7mVizfDypfihzcLg7vKXFkfhX8XCF5XkL4=;
 b=cfNGdCMFHjjlFI31y1qXqEGnsgdK7dJWQxTM0Vbqwh7RNDkIRSdxbA50dBj7TwAhFqvGMmAugM67JCjiU/BIPo8bjOwiV3trZCbBcoxrmdXhm//mlTMBFdIKME+63xPZEnQ0eO/aYdfZLMWEo309zCV9cwLRu5KOvZqbk1L6lXM=
Received: from DM6PR02CA0066.namprd02.prod.outlook.com (2603:10b6:5:177::43)
 by DM6PR02MB6283.namprd02.prod.outlook.com (2603:10b6:5:1d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.21; Tue, 15 Oct
 2019 14:48:49 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by DM6PR02CA0066.outlook.office365.com
 (2603:10b6:5:177::43) with Microsoft SMTP Server (version=TLS1_2,
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
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 14:48:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO80-0006Fx-2L; Tue, 15 Oct 2019 07:48:48 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7u-0002Ar-UD; Tue, 15 Oct 2019 07:48:42 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9FEmgdt019628;
        Tue, 15 Oct 2019 07:48:42 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iKO7t-0002AJ-PJ; Tue, 15 Oct 2019 07:48:41 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 1E8B3101132; Tue, 15 Oct 2019 20:18:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next 6/7] dmaengine: xilinx_dma: Print debug message when no free tx segments
Date:   Tue, 15 Oct 2019 20:18:23 +0530
Message-Id: <1571150904-3988-7-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.170-7.0-31-1
X-imss-scan-details: No--6.170-7.0-31-1;No--6.170-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(199004)(189003)(8936002)(70206006)(81156014)(8676002)(81166006)(70586007)(14444005)(50226002)(6666004)(356004)(4744005)(305945005)(5660300002)(11346002)(126002)(2616005)(336012)(476003)(426003)(478600001)(107886003)(6266002)(51416003)(26005)(446003)(76176011)(486006)(2906002)(36756003)(106002)(4326008)(186003)(48376002)(16586007)(103686004)(47776003)(42186006)(316002)(50466002)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6283;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f58df84a-c1e7-495d-f97e-08d7517ec9bb
X-MS-TrafficTypeDiagnostic: DM6PR02MB6283:
X-Microsoft-Antispam-PRVS: <DM6PR02MB62838CB2556E5D7AF864A78EC7930@DM6PR02MB6283.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hiyF7xXFNguM7dhROCdbPsP2oyTzg+u9+7IcUpDiYp9WKBxspsU6bEeVNsvSMZsnCXOSaeOu7mGs5frcssT7kk1FnDDBHxixnnuq8y8MiNaU/xb2fXsTABsDqkxH9b7vHXfY+iW1yy23sS4lXDlzXPAGeEl1PSbMgYnoOYkRZYSmTytn4SLbBCTfiMwsNOReXoLZgJokol+2Q4b3EWGMjYLpStnAYaExf02OCj7BN6ZJmDYmJ7a804YsZMqKtS45kKUP6MVs1lozRL5hZt68zntTLGV3oaPUZvmyzkQA3DbouZr4WqLJ2dAapvI/GvJlIs33TaKDShc/tQSw7Kwoi1XZ2HPJLn7CWGWwDzXFmZQUuIskY/jozxr0nYg4P2qXkZ9+FP4XWVvSBXSgpeqgx9jwNFO+KgIastBp0zCdWLY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 14:48:48.6751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58df84a-c1e7-495d-f97e-08d7517ec9bb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6283
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
Changes for v2:
None
---
 drivers/dma/xilinx/xilinx_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 932407a..b0d3aac 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -615,6 +615,9 @@ xilinx_axidma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 	}
 	spin_unlock_irqrestore(&chan->lock, flags);
 
+	if (!segment)
+		dev_dbg(chan->dev, "Could not find free tx segment\n");
+
 	return segment;
 }
 
-- 
2.7.4

