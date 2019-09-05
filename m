Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05653AA925
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfIEQhf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:37:35 -0400
Received: from mail-eopbgr770083.outbound.protection.outlook.com ([40.107.77.83]:55859
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731584AbfIEQhc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:37:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1wPlOs54RYQY3DAtqBmYf3Eyww9ZLuIdCB2e3sHtyez+n3JnMRJIalrRKXNnSG5dVgspCTAXqzimeq33Aad+yIycsRgGO51C6VXOm50L3k4d2Mh1YeBeXbeC4C67NxPC8qmpARoVs35QOxm1rOjFUB9nwRBe+OIlJz2MJzi7fUtqic/tA5v4LPiAlqzoauIXd8mp4ZPhL+ae9rGqapJKCANekYJRO6mFP1mtNrrU5cAoHprShMUSqWc2QmpB/hPnc+TFXMsurw16mPg61oI9tFrzk/zLQCxP4HFBKKUOZcYZ/JqoFZzOi1+1InmPCOwXyD8f4okxOqEHuPtRxdcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI2ZnalCfJYPC5WugtP0svR/SoPRnWobKhMQakujXwo=;
 b=dJMGRIONYNRTmmA8wSH/1UrVIfg2sYolQfozrSHvLkytjCChmLV58uwnO+Sxz4hVR2ZBiYsQHd9K1N8+MVVRePOkkenIX23Hz8HQdga4kzPF1uRmq5DybV01UBw8Fm1U0KK10qB4JEp8DyhY68jrIhxEdh/gM3BtVr+OANY5JCEKGoJYH8D/LBQiH8ncF9jLFDg+Pznp3O/FAyc3AujwwJ2HxKsmAWSlTNFsx2I9rtYB3jJ0Lp0/5SpsDjAE5K3ZT0J1SkJT2SF0SSTsYJuYGHYBPG54OB1uWPSZ2DEuOfQ9+bn+Cljj7zDac5KvZ3DxKCgiqiV4fMKwDWEa30Ptjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cI2ZnalCfJYPC5WugtP0svR/SoPRnWobKhMQakujXwo=;
 b=YivTw8hh3SsxITREzFCompd6Ixt1g1TdeI3ppudybySqzcD1cTZcbKpmpNJbiC69TyLkCAqBetOhiOFdfF1UXKFCmmqs39bRpq9b1lDZ4TfUJQUteHKG31KTVwqL9+y3zBpiFHWncAHheBe760V/4eshCdtUwqtSROniDHQaAgw=
Received: from MWHPR0201CA0086.namprd02.prod.outlook.com
 (2603:10b6:301:75::27) by BN7PR02MB5329.namprd02.prod.outlook.com
 (2603:10b6:408:29::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.13; Thu, 5 Sep
 2019 16:37:29 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by MWHPR0201CA0086.outlook.office365.com
 (2603:10b6:301:75::27) with Microsoft SMTP Server (version=TLS1_2,
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
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 16:37:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59439 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ulD-0006fR-CT; Thu, 05 Sep 2019 09:37:27 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul7-0006wk-UF; Thu, 05 Sep 2019 09:37:21 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbKZ4015552;
        Thu, 5 Sep 2019 09:37:20 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul5-0006wE-VR; Thu, 05 Sep 2019 09:37:20 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 3565510106A; Thu,  5 Sep 2019 22:07:19 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 1/8] dmaengine: xilinx_dma: Remove desc_callback_valid check
Date:   Thu,  5 Sep 2019 22:06:57 +0530
Message-Id: <1567701424-25658-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--3.874-7.0-31-1
X-imss-scan-details: No--3.874-7.0-31-1;No--3.874-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39840400004)(376002)(346002)(2980300002)(199004)(189003)(70206006)(47776003)(70586007)(305945005)(53936002)(8676002)(50226002)(8936002)(81166006)(81156014)(186003)(4326008)(76176011)(316002)(14444005)(2906002)(16586007)(26005)(6266002)(107886003)(42186006)(51416003)(486006)(356004)(6666004)(446003)(426003)(478600001)(52956003)(336012)(36756003)(50466002)(126002)(476003)(2616005)(11346002)(5660300002)(106002)(48376002)(103686004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5329;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 898e2aa8-27fc-41bb-f078-08d7321f576a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR02MB5329;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5329:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5329B05BA7A4EFEE494E88F3C7BB0@BN7PR02MB5329.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Xq8ecDXHmVDHmANjdf6b5Z3L+OpaLgS3NfWea25tE0rwSXuvJKJw2vKGlN3jioiQOKqdxqmBIJDHUBF6oAVURmRncZmBTFW2YIlwqRxqPsxFk0OTz/K0WJdQAayC+vEEPjwwIsvLxbeT7ZSA1xCnhvJ5mDonffW9jC2BTfIP8bn9b0ioOu2CVRCuIrnBwKxWKhe2tIkBoRP4/hkBj5QTDpcLO9Nn/OiKWSri8rjUByeTAuBWf/irSG4gwXYAUYlCdseifNPD8pEQvbCaEmDB/Q5ogN9X0ys5ointfFnz+6mIMOztLKdaCRQSVmK/6iMNWpLgUGiZraCeXF9MnYDy3llrzILHl/OU7u1Us4HPDu3oei6avK2L8UbI+sN6F6rPSetQOZmGpjAcrLmS5Imgo36LFNHiTLquTEJr58idTEs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:37:28.3952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 898e2aa8-27fc-41bb-f078-08d7321f576a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5329
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
 drivers/dma/xilinx/xilinx_dma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index e7dc3c4..8bbf997 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -832,11 +832,9 @@ static void xilinx_dma_chan_desc_cleanup(struct xilinx_dma_chan *chan)
 
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

