Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A29AA921
	for <lists+dmaengine@lfdr.de>; Thu,  5 Sep 2019 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbfIEQhe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Sep 2019 12:37:34 -0400
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:42982
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbfIEQhd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Sep 2019 12:37:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buDAhgtGMVBmM6OvA36ItCbv3R660zgbyCG+7ShCPbiGdpF8TND/cSRcBNOLqyDN9ZOmkKLRDmtyfkHosvBoEvMn4DXW/1LpDrkpMnfFp2VxUNERQWJJUSdFM+sK8s6cWck1Jqb5omdtZdWQjHOm1GhV3C+bwIeXO+TZrZ+BWFGSwqkvd2Biqf1S3KIocb0O/j067N0S0ifrwQ3hjuuUXhdZPadu7PN9h2vJY5w0LZ/aRsO1GCGM0fYEsNhMBlzg7GR+aB97oEuniIwOpXjfWxVNw4MimPFnh1ZIdMsTVKEPeqypqXF3eYSeK4QDJfY/XdxGGq0VWxS+/T8Tw3CANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JemmC9wTSkAg4G+qjpwkHOPXaMK3prtocB96XorHJhk=;
 b=G2M9sS+/FRg70mXnFoUbZuUHCnhz2vswCY0WKe4QxXJA+aJD93+k+le6bQQqcLy27LXzgah+LUXZAIdDtgOC7UueWk8aRaM7iSBoikNAwzHNYMx29p0QG9YcJZeyRgGaB49PW29clH/e+uVZNh6jNx8cnTlWKcw7jkMlo3eLJvasaYM4VKT18Sb8FHFGNfUWyJ9nCP0p++Er4quXzSzm4I073v8wvbNCxmyFV61spqVQ1xolxMNtuIk3Rj08lNoStk16Qdpm8YAb6d8vLe91PTN7INdSF9OvK4rIjx8zH96NzMv0cJVb9KSwCUwD8/EGcFy9gatLzFKSV0I/+Cp9jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JemmC9wTSkAg4G+qjpwkHOPXaMK3prtocB96XorHJhk=;
 b=P3bnWoidf/gSlAy62Fc9LP3Zmh0S8YST3WNtrfUK97IQAAHMkDykmU3YkohVZjY/jcELUNoOEX0ZVgUxzbEXHTclOSYOuMN6aKtr2g80YvuUZOk8j67nMupVUzsg9QZn8zQ7Q/sKa8PL0X2GbGULzHP/EM3E1LGjMN8/4X89D5Q=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by SN6PR02MB5344.namprd02.prod.outlook.com (2603:10b6:805:71::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19; Thu, 5 Sep
 2019 16:37:30 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.19 via Frontend
 Transport; Thu, 5 Sep 2019 16:37:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 16:37:28 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59539 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ulD-0006fc-Ur; Thu, 05 Sep 2019 09:37:27 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1i5ul8-0006xf-KW; Thu, 05 Sep 2019 09:37:22 -0700
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x85GbLSW015585;
        Thu, 5 Sep 2019 09:37:21 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1i5ul7-0006wc-12; Thu, 05 Sep 2019 09:37:21 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 534B7101071; Thu,  5 Sep 2019 22:07:19 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 5/8] dmaengine: xilinx_dma: Remove residue from channel data
Date:   Thu,  5 Sep 2019 22:07:01 +0530
Message-Id: <1567701424-25658-6-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1567701424-25658-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--2.201-7.0-31-1
X-imss-scan-details: No--2.201-7.0-31-1;No--2.201-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(189003)(199004)(478600001)(70586007)(53936002)(70206006)(8676002)(50466002)(8936002)(81166006)(2906002)(186003)(48376002)(36756003)(50226002)(26005)(14444005)(305945005)(2616005)(126002)(6666004)(356004)(106002)(16586007)(42186006)(316002)(51416003)(76176011)(47776003)(426003)(52956003)(6266002)(486006)(446003)(103686004)(11346002)(81156014)(5660300002)(4326008)(336012)(476003)(107886003)(42866002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5344;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d94c0e48-63c4-4be8-45fb-08d7321f5788
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:SN6PR02MB5344;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5344:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5344C0B8E445CBE359902FD1C7BB0@SN6PR02MB5344.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: il2zpD7QC7ckbaRQcffZAUsuR528pWXFBuc/woznurqf8sFhPwx7GP/BsQSLF3/a7rPap37IcFzqdr5TUmMh5YavUBFMGyIDeXnp7mbdvt7xh+DA9y+8jyBGaT0QND3C+XdtOEjX+4LPrq6/dnhnZEle0stPRHXtVosA13Vanh6L55ahY7fQskbLksnUKt4aGlvr2lX1k5RQr3S1ooAla1NCyAjmhMulOGwGByhLiSTu4y56QMonH0IoLgGJBkfBlCcPaYwz7BRotw+CcHv/UI4zLE6XBACsywOpNND1g1N1dW1qUsuJtFXVuDyavkGB3SSMezZNISYxugLfe8q8qUCEtdhsQ03nzXskV/dBtopg+Y23ed1KfqcDb3yt4ZuMyIe7CzPAa8EWfkeOxsCYIz/EkUY4b3ngo7dbgh0mESg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 16:37:28.7235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d94c0e48-63c4-4be8-45fb-08d7321f5788
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5344
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Nicholas Graumann <nick.graumann@gmail.com>

Now that we track residues for each descriptor, there is no need to keep
track of the residue for each channel.

Signed-off-by: Nicholas Graumann <nick.graumann@gmail.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3f2e0ad..bf3fa2e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -340,7 +340,6 @@ struct xilinx_dma_tx_descriptor {
  * @desc_pendingcount: Descriptor pending count
  * @ext_addr: Indicates 64 bit addressing is supported by dma channel
  * @desc_submitcount: Descriptor h/w submitted count
- * @residue: Residue for AXI DMA
  * @seg_v: Statically allocated segments base
  * @seg_p: Physical allocated segments base
  * @cyclic_seg_v: Statically allocated segment base for cyclic transfers
@@ -377,7 +376,6 @@ struct xilinx_dma_chan {
 	u32 desc_pendingcount;
 	bool ext_addr;
 	u32 desc_submitcount;
-	u32 residue;
 	struct xilinx_axidma_tx_segment *seg_v;
 	dma_addr_t seg_p;
 	struct xilinx_axidma_tx_segment *cyclic_seg_v;
@@ -1068,11 +1066,11 @@ static enum dma_status xilinx_dma_tx_status(struct dma_chan *dchan,
 
 	desc = list_last_entry(&chan->active_list,
 			       struct xilinx_dma_tx_descriptor, node);
-	chan->residue = xilinx_dma_get_residue(chan, desc);
+	desc->residue = xilinx_dma_get_residue(chan, desc);
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	dma_set_residue(txstate, chan->residue);
+	dma_set_residue(txstate, desc->residue);
 
 	return ret;
 }
-- 
2.7.4

