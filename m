Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E1B3B70CE
	for <lists+dmaengine@lfdr.de>; Tue, 29 Jun 2021 12:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhF2Kjq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Jun 2021 06:39:46 -0400
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:55904
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231956AbhF2Kjm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 29 Jun 2021 06:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjkHHEEuaCsJn4r+MVdYURsTDULD/XsLOmxyZlkFyFTDE7VtTeJYJUiR+PtyfhyWBOTelComMEBPHmhVPJoInjlygfV2Cz3K7K1oEsPfERmR15rLM47DwEAopFUeNUBPy/2eH6Cw7AyW3S1vCkarBWar7UfDdzOzpHIu60WC8JIXq3pWGzUJ0Ya39inZsPGThYCychYz0Wr50Tvw3kQ5g7f/m4fHWqCECKIk6FOFKMFmmVa8DrtvAVhW08Yfg3Qb7OaZT2o7GBHw0svvoqbWfmG5wcTdc1irSI+0PRD3oUEOockwFfLOGa5Kwbjn2V5REDn6vXpjuasptt/AoSh/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB77udtJWALg1OY2OYBI/3+cBhuCoJyxsmFFx4nA9GU=;
 b=VbtM27Xni+xFDzi5v05MLSNdCRh4jks7OyAPJUw0uvgLThu6+fwtKeF1F602l6Ehv7i+pmDpSE6WLc6UcIAk9v2e5oRIxnVUfo/zZalGCR55exLu541iZb7F09J/3ZLFbiKd6w0ei2iV8T0AGZ76Zfsnb3CDtIPXkiDryA6QNxuFpjfquZAHkxwRN9axFYg84n4CUkL9zKEmgOaohH8Ac5uCDLabjPd1QkApl2pzqniswg5jVTdGXJLn2eAmDm5kJY6UueKjv8aPwCc+SZsPeJW/8RFJxx+QsmmgyOWiy37QtumS/hujLpsBOfeVw7Z4nqNWgDNB1H5ZvCNoBCiXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB77udtJWALg1OY2OYBI/3+cBhuCoJyxsmFFx4nA9GU=;
 b=bhoUe3H3mxI4jN/Y51Vopt/6Gu20FgAEvrG5dlprYcHfrM5sIkX2KJapcrXFCJf3ZN1uppCk606vYReQSPA+rNhsVyE/6OzgCgitmMBE5KdEaZGAgvu6UdHIwWPvYZSF++hlPn94Ss0mFYQ58yNP8hQN/63/KtQcnWDktT/idI8=
Received: from BN6PR22CA0070.namprd22.prod.outlook.com (2603:10b6:404:ca::32)
 by BY5PR02MB6535.namprd02.prod.outlook.com (2603:10b6:a03:1da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 10:37:14 +0000
Received: from BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::61) by BN6PR22CA0070.outlook.office365.com
 (2603:10b6:404:ca::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Tue, 29 Jun 2021 10:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT049.mail.protection.outlook.com (10.13.2.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 10:37:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 03:37:13 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 29 Jun 2021 03:37:13 -0700
Envelope-to: vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 harinikatakamlinux@gmail.com
Received: from [10.140.6.13] (port=43806 helo=xhdharinik40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1lyB7A-0006BE-Oe; Tue, 29 Jun 2021 03:37:13 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinikatakamlinux@gmail.com>, <michal.simek@xilinx.com>,
        <harini.katakam@xilinx.com>, <radhey.shyam.pandey@xilinx.com>,
        <shravya.kumbham@xilinx.com>
Subject: [PATCH] dmaengine: pl330: Typecast with enum to fix the coverity warning
Date:   Tue, 29 Jun 2021 16:07:10 +0530
Message-ID: <20210629103710.24828-1-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff0cfb1-0a6f-424d-177a-08d93ae9dbc0
X-MS-TrafficTypeDiagnostic: BY5PR02MB6535:
X-Microsoft-Antispam-PRVS: <BY5PR02MB65355807893223F454F76D49C9029@BY5PR02MB6535.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yqyM6EQEXhjnlYNfkysfPB3ER5pKRQT8o9baHnAQvTR7h0J6VpcN4u+wZKb2cNzeAIJZPdJSVFUMtgsf465lftIiZ3pPPGzxv9EhCiMBOisEJDoepo5EZxggIVgxLVhIZbStr7o5792D2H8Ixu9eQn2WoVoMGZvNNT4EDwyXA+xGFKXe4S9esduaKv68MkwyEUGBlyki4jmA91gQrtEKR/6Vh3tKSgCfJemaKg0aWQv7XREJHBlUzABB0uKVz3DKdlfPmyNZKs7K7nceif0ihLpbKZlZZ7CbmeFdnmVgTR+6aDIFfkR6PGibrnM0hmXNSzplBuu63ltvfDkOxDO8WnDGpePEtIxpITnJxRXv49HWIEifY7VxVqT5ykAdAda7jvAroEtwrXB+eQ0aUNHqz7XJWxFm5BaqF2b+1Ho+3UEqY73nlCvz/oiEFPs3TLG1DFq/voj67GQhD8UqybM7QbY86wlSRIE93yNJVXu0sO2QEHzeQh+fTwntMyi4jVQ94Kqj1SXnreixcH5HMeg+Jy+gE1/Be6OLEczQZfZ4y31BjQumNtrNgRtSCFoJ2CpJw16NibglTwXjvTsYMGX+Kbh/FU5Jq0rxldaVZdYMt91sQCI+/KKzkVRM77MWnZeh6luCW5XtBfzA4KWc9fKYTLxm4ccwWXnX/1F7vC53xhHodD1jLpdun9Udr9kK5SNQQMyPS2tR0ULQpWozJFXMlmMhDcfgTnucf4+1rY/C+TU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(7636003)(356005)(83380400001)(8936002)(36860700001)(36756003)(82310400003)(8676002)(82740400003)(70206006)(47076005)(186003)(70586007)(336012)(9786002)(2616005)(36906005)(316002)(54906003)(26005)(6916009)(426003)(44832011)(7696005)(4326008)(1076003)(5660300002)(478600001)(107886003)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 10:37:13.6746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff0cfb1-0a6f-424d-177a-08d93ae9dbc0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6535
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

Typecast the flags and flg variables with (enum dma_ctrl_flags) in
pl330_prep_dma_cyclic, pl330_prep_dma_memcpy and pl330_prep_slave_sg
functions to fix the coverity warning.

Addresses-Coverity: Event mixed_enum_type.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/pl330.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 110de8a60058..35afbad2e1a7 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2752,7 +2752,7 @@ static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 		return NULL;
 
 	pch->cyclic = true;
-	desc->txd.flags = flags;
+	desc->txd.flags = (enum dma_ctrl_flags)flags;
 
 	return &desc->txd;
 }
@@ -2804,7 +2804,7 @@ pl330_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst,
 
 	desc->bytes_requested = len;
 
-	desc->txd.flags = flags;
+	desc->txd.flags = (enum dma_ctrl_flags)flags;
 
 	return &desc->txd;
 }
@@ -2889,7 +2889,7 @@ pl330_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	}
 
 	/* Return the last desc in the chain */
-	desc->txd.flags = flg;
+	desc->txd.flags = (enum dma_ctrl_flags)flg;
 	return &desc->txd;
 }
 
-- 
2.17.1

