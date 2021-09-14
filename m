Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1E40A930
	for <lists+dmaengine@lfdr.de>; Tue, 14 Sep 2021 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhINIaK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Sep 2021 04:30:10 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:11624
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229507AbhINI34 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 14 Sep 2021 04:29:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mw3jCMBVusTb+TTBbgg4IFXzPs0yokTvi4Td39P5xy96vgx6OGoDZLQ7J+Xf8Bglc+DDNfK2dWdkD1PNCailKC/SB+4GIzUnof8a7YM8I1Ik6TlqI4g34O+Nz9wYSTx4cVKmoUvfQPNqD+e9hgCaf22r0+9rZC/sLSV3/ijqSZwQVhoktECbFVfbcIYiJSWw5dm80kkGGjOek04q9L5PANd71EUe+pb5yobrgFufXznFEwqI8Y6bywKUpXU+CJW8F/Y/e5+YfPaRzngcJbNIr3iWwewpBUFubTsrFPj0DeO0SfJagIdOTnYS2XZ9e8U7tREk5wcH6cVL122aZPViNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/kHxIV5qDHUCBkwAmGnw7yV6WijHa8TNqOV/eE/WFtg=;
 b=GTE31CnEd0BwKFLuX8pOKPypyl57zj1iu9LnRcPh/DBbI5ah1kNoScvOJNuR2R4ZIXyH/J3dmjDDcxplZq97RCqaNSArgkqgwJZZ2GgzDoxYcG1I3tGrsqOhhS9kPt55xQRlUUgzvJrE+w+LWqtjiCXUZ1ZT4/ZszqaVymoACZ4LNJe3mbyrDqRxR+RLB+kqkFA2RyNNP/oUtlPdDvOPYgxdm26kgOfHkXJK0XvY29WraFv6Dwoghb3y6A0UDnwOOnBIs4zZsDZqmALpPncAK4k9/8eo8VxM7Dmr6ixJWSeoUoqIwrUr+02U4oIbauWmuESfAHnep9NpWJ3vtaGKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kHxIV5qDHUCBkwAmGnw7yV6WijHa8TNqOV/eE/WFtg=;
 b=KWeqeTZlTU6vxTW3bZ+0cZmA0nfPsEHVu8shtrTPQvtgv+LVA9XYr2YmTyjS6QDJ7OPRv8R4TMOmE4jN4N0pMVUf77cR3Wovo1/gZHSzUvNzHLFLp8L7Qvru36J+hdPCQvT0+dPRe8wdeso9sMGMWraVxEeWwRcuTwdkjZhV3as=
Received: from SN7PR04CA0021.namprd04.prod.outlook.com (2603:10b6:806:f2::26)
 by DM5PR02MB3800.namprd02.prod.outlook.com (2603:10b6:4:bb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 08:28:38 +0000
Received: from SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f2:cafe::a8) by SN7PR04CA0021.outlook.office365.com
 (2603:10b6:806:f2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 14 Sep 2021 08:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0050.mail.protection.outlook.com (10.97.5.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 08:28:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 14 Sep 2021 01:28:35 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 14 Sep 2021 01:28:35 -0700
Envelope-to: vkoul@kernel.org,
 romain.perier@gmail.com,
 allen.lkml@gmail.com,
 yukuai3@huawei.com,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 harinikatakamlinux@gmail.com
Received: from [10.140.6.13] (port=35510 helo=xhdharinik40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harini.katakam@xilinx.com>)
        id 1mQ3nu-00094b-KP; Tue, 14 Sep 2021 01:28:35 -0700
From:   Harini Katakam <harini.katakam@xilinx.com>
To:     <vkoul@kernel.org>, <romain.perier@gmail.com>,
        <allen.lkml@gmail.com>, <yukuai3@huawei.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <harinikatakamlinux@gmail.com>,
        <michal.simek@xilinx.com>, <harini.katakam@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <shravya.kumbham@xilinx.com>
Subject: [PATCH 4/4] dmaengine: zynqmp_dma: Typecast with enum to fix the coverity warning
Date:   Tue, 14 Sep 2021 13:58:17 +0530
Message-ID: <20210914082817.22311-5-harini.katakam@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914082817.22311-1-harini.katakam@xilinx.com>
References: <20210914082817.22311-1-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d406210f-afc2-4b90-ad5f-08d97759a6bc
X-MS-TrafficTypeDiagnostic: DM5PR02MB3800:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3800E3FFEBCE092F56B19831C9DA9@DM5PR02MB3800.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kCwc5dPA3FV4LoQka3m3EBeNM0EfQFehm9MwfnJZQ5tZmvdzUyba22V5HToWRmf+KStHvEbSD5KZPiOSrZxTkvfwyTThRBj9veMsAOIk8w90/Ngb66UlK4w0phE1wrmTay8Yp/LN2ie1CAbkEmGjH499baFDJmsyA5ZPxvBk9sXUXa9pPCNqShziyEWivx3EBetYWKKp4TOzJ66QLL7707rE3e7U+IeSo5yGuJVAjWcoz9/W37psdstlQkMocRLhTQwgLnuT6w5P+wsf8mVVCvEyzfFMW6fjeWclZIokFyqA9GYgBHs4KNbXCmjQPY0ExfzRcvo/gmec8dZqDx/jNZ+Eil9Xkd7S/hHMRncEgA6gf9kK3eBbY3Ubx8KGaJPfrN+/lp52SdXQmsjDcVjDkhtF0cptKqCDCGN+3Dzv3qyG3aFhw/HupN5SWROZn4f7fxMCxZW2NAiEdJRLFnS5RWinfOTNuVI+4oZbrg7ia5GpOsQ6g36Wq78ZdJqnC4JXqfGkk6ivUUOL0n8Izl1jlm0VFytijtlgZ+cMwIqmS+I87Yabzgzp9FfyCbDpiXJ0WLenV4AxNa3nQWHQvlRdTYpnantc/G1XkRCYjt3Kxpf7j9CCZRHeFLgWdmDLdT0VMSnk9s0lIQroIKFZgu394Haw6XIzRqfs0aOe30wg4lcpwgxWS12/mpjxw1iAplyw8GZybPHRlJlnM6/OZJ8Z77xlMwMm45Ergqdci+l7A4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(36860700001)(356005)(2906002)(426003)(6666004)(7636003)(4326008)(36756003)(336012)(508600001)(82310400003)(8676002)(83380400001)(7696005)(47076005)(186003)(4744005)(36906005)(70586007)(107886003)(316002)(8936002)(5660300002)(26005)(110136005)(54906003)(9786002)(70206006)(44832011)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 08:28:38.2013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d406210f-afc2-4b90-ad5f-08d97759a6bc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3800
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

Typecast the flags variable with (enum dma_ctrl_flags) in
zynqmp_dma_prep_memcpy function to fix the coverity warning.

Addresses-Coverity: Event mixed_enum_type.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 588460e56ab8..282d01ab402f 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -849,7 +849,7 @@ static struct dma_async_tx_descriptor *zynqmp_dma_prep_memcpy(
 
 	zynqmp_dma_desc_config_eod(chan, desc);
 	async_tx_ack(&first->async_tx);
-	first->async_tx.flags = flags;
+	first->async_tx.flags = (enum dma_ctrl_flags)flags;
 	return &first->async_tx;
 }
 
-- 
2.17.1

