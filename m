Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1055D7910
	for <lists+dmaengine@lfdr.de>; Tue, 15 Oct 2019 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbfJOOsz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Oct 2019 10:48:55 -0400
Received: from mail-eopbgr800074.outbound.protection.outlook.com ([40.107.80.74]:8352
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732599AbfJOOsy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Oct 2019 10:48:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqS3mALt7CNd4CZXNW2JKuZqHc++ssLdyfrhFCLgPTZQrBaXZLsLII9j/6lAKdesuttUc0oWJsjnKBRHpCBSdMCFY6Al7KTot0RV+9X2bPD+N4ZAZrY8jQ5RW82LFzsMSq41czqObJ08tJlMz6cYZBJhYYHzOKf464lHD4sNRgQA6+iPNn56r1rOVNCSF05XgaSoqWJjri2Qku/BrAj8p0u+pnbcg2Hgr4KiK6xb77naoisjY+zLINIa+qWqqoXQUcbJPvNZiFBz311bLZygbiyu2LZkscMTYgWVKtWh6oRMMRLsgYlR7bXyZXdEnVXhv2f4/QYNfiLgFJalv5YabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ5tlbtgcZOVkDC059S40GiBTD7TE5wgm4wfSIP2k5g=;
 b=Zqns7IgfUJ158j5jFzyGmRA+QQoTFL5QKHE4Kz8mNgePViaq27RNu4ncfn9XSWNgQzdYuNT51q6LuBl/JtvrCTyJ1Q94LPyDa0zPQzW9UnB2/SRRVnNQc6z/oqy6Nfb0apP/N/Io9qccVxn89QP3CoDV5oytZpRWdVCvmxzcODrywtivZVI5qtnyKHCCn4LuDRe0OZX+qHdkhHPuaxv1bLhQISdOWqM3qffBbjPqKgqCkWITzi78SyQE4alXqCKpk+4LggKZbTpcUxGlY23KppQhd9MzyT8YWVaQdXJi542Ah+ZB5i+5i2QKlqEGXeMbH1ev0XGmze+GVhtJSdYB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ5tlbtgcZOVkDC059S40GiBTD7TE5wgm4wfSIP2k5g=;
 b=j0ktKrvulTkLRfAr+IMaROmED9NFsGOlcIC7HbwtHlhWX24VbYD0HxpuY+ghYiO8Q1lUR3Bew/MY7PfGW+UEPmDQk6DarDEsbTzgFAd0Jvig31W+5f/c0P/d9+HpQtU+CpIA/Z71FX7PdKXZVKDWkD4SM9l+c4lfjrKxMw6eu9k=
Received: from SN6PR02CA0007.namprd02.prod.outlook.com (2603:10b6:805:a2::20)
 by SN6PR02MB5343.namprd02.prod.outlook.com (2603:10b6:805:71::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Tue, 15 Oct
 2019 14:48:48 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN6PR02CA0007.outlook.office365.com
 (2603:10b6:805:a2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Tue, 15 Oct 2019 14:48:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2347.16
 via Frontend Transport; Tue, 15 Oct 2019 14:48:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7z-0006Fs-5g; Tue, 15 Oct 2019 07:48:47 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iKO7u-0002AT-14; Tue, 15 Oct 2019 07:48:42 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9FEmfbn014661;
        Tue, 15 Oct 2019 07:48:41 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iKO7s-00029W-Pc; Tue, 15 Oct 2019 07:48:41 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 0A92510112C; Tue, 15 Oct 2019 20:18:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 -next 3/7] dmaengine: xilinx_dma: Remove residue from channel data
Date:   Tue, 15 Oct 2019 20:18:20 +0530
Message-Id: <1571150904-3988-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571150904-3988-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.046-7.0-31-1
X-imss-scan-details: No--1.046-7.0-31-1;No--1.046-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(36756003)(103686004)(51416003)(336012)(14444005)(16586007)(5660300002)(42186006)(316002)(76176011)(106002)(478600001)(107886003)(6266002)(4326008)(11346002)(70586007)(48376002)(476003)(70206006)(47776003)(305945005)(26005)(486006)(6666004)(356004)(126002)(2906002)(8936002)(50226002)(8676002)(426003)(186003)(50466002)(446003)(81166006)(81156014)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5343;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4acbae0-07bd-48ec-c00d-08d7517ec933
X-MS-TrafficTypeDiagnostic: SN6PR02MB5343:
X-Microsoft-Antispam-PRVS: <SN6PR02MB53438F9A341EA3723DA233B2C7930@SN6PR02MB5343.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 01917B1794
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 56Lr0MUACYeG2vQNYi8rasjbFnrN8jBgDbFymIDovG9PQ/zpcfANe+eyZq16CN96JRhalzZLQ5ELkSdOYMhAmdFkbYhmzlh1piN/IC1PuIMXn5IsEZs7s0hETmriKye0Zxtmoyt04ETMEWI+nMJ6tgUzbdH2vlMq1xCDauvaWT9nnbi+BZ1swmP5LCNd1LAd+AkK6aSeNif7kpxAk4S9xPC64X26ZLekVmm4ofyY8zptHe3Ff441TJqTC/UWoEfFrPszoYZbmopMQn3KpLdXESplE6lbthANgN8Ck3SJKY8dhJSkjyHCw245vaWCTB89hnkgB4zfNV+2HtwyJyPhzt30J6vcwe/y/U7H0X5z8weNuz5TGWahrlY4Gy/KebxpSjbSKVcP9TK5vMQAGAgScinv5c9CyrbulZnt3xAltho=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2019 14:48:47.7814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4acbae0-07bd-48ec-c00d-08d7517ec933
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5343
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no use of storing channel data residue field. So clean it up.
In tx_status simply pass calculated residue to dma_set_residue.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
New patch , derived from 5/7 dmaengine: xilinx_dma: Remove residue
from channel data.
---
 drivers/dma/xilinx/xilinx_dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 465dabc..809e638 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -339,7 +339,6 @@ struct xilinx_dma_tx_descriptor {
  * @desc_pendingcount: Descriptor pending count
  * @ext_addr: Indicates 64 bit addressing is supported by dma channel
  * @desc_submitcount: Descriptor h/w submitted count
- * @residue: Residue for AXI DMA
  * @seg_v: Statically allocated segments base
  * @seg_p: Physical allocated segments base
  * @cyclic_seg_v: Statically allocated segment base for cyclic transfers
@@ -376,7 +375,6 @@ struct xilinx_dma_chan {
 	u32 desc_pendingcount;
 	bool ext_addr;
 	u32 desc_submitcount;
-	u32 residue;
 	struct xilinx_axidma_tx_segment *seg_v;
 	dma_addr_t seg_p;
 	struct xilinx_axidma_tx_segment *cyclic_seg_v;
@@ -1022,8 +1020,7 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 		}
 		spin_unlock_irqrestore(&chan->lock, flags);
 
-		chan->residue = residue;
-		dma_set_residue(txstate, chan->residue);
+		dma_set_residue(txstate, residue);
 	}
 
 	return ret;
-- 
2.7.4

