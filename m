Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E192DD7E4
	for <lists+dmaengine@lfdr.de>; Thu, 17 Dec 2020 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgLQSN0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Dec 2020 13:13:26 -0500
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:48000
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727543AbgLQSNZ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 17 Dec 2020 13:13:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAzeM00HSo7tN1iWzfaRrbP88EYYAgszgkwYM7B1Mcbh8Xo4HjlCRM0llOmMyAy4Kisjy9gs+q24mo+yIJS3BrR2nv7XC0v1F8qRQZT2frvOkY+u5qFftlcrebz1WK4Epbd2wm6dt/OUn5D8RM6eW4mgByc9rjJw8jv1wtFbRnBqeTPd7hoJLW0YDekJTYKXNw+zB85gpL3nQTFKuiLk6ESFu5beIIeu+bxjgwxKl/zp1gs9fBynlT1RP9n5oEtn1dXHrrA6jde9bRIEBPYHJFeBF3hcCPpG9lfPFJ5NSZ70fjdZpaho7+I9QdDUGPq2ugWIA7VhgySr9T9yaYn25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhIdZzUK6OO5B1pO4yY/wabLoIP3CJVP9vRTgi96P2U=;
 b=Ed14+P0odjCIvEiJM8bnAKSvi8cjkw0xa/TYZPObur6PjOOYTF7jlwF6sQdOW0wBjKPCCN77os8IFpavHyzUT6Ssz1H6+s70IE6BELpfOBg80tMqbqBfHytrBEyoPvMORR5Q0akWPWKvM26WlmvH5PP7S0L2ifxM05nZVL9BV2dmhe/D4pbXQp1uWm6DpwhbexxeMCiTvVAO6NfERJiIUrcGpeHFSGN/zzOZq8rh0ch5dBGoCYjvrvvzeu5yB1IcUbMxBKs1JFxFeVJNEwX9x5+FsdUomOjinse/4FLis7H3FafnS+vYqGpU2+k+e5F21llUae+XXg22L7kz6UmmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhIdZzUK6OO5B1pO4yY/wabLoIP3CJVP9vRTgi96P2U=;
 b=NHzF/TZjOX9vEQptQxbWiAQJyicvPOiZKdhdC1pijpl1Y7hKTmaSbkzt0nqsoFQgniLVSrB/aVcOC4W9kuCl4vcnCyU9mQhOO9ZOBCbWLMVR2i55g4uZb5qAOabq1fHl6uKOIRBCugjMyH69d4AblwzncjuSYqvvq5O/GTXrrZE=
Received: from CY4PR1101CA0018.namprd11.prod.outlook.com
 (2603:10b6:910:15::28) by BYAPR02MB4087.namprd02.prod.outlook.com
 (2603:10b6:a02:ff::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Thu, 17 Dec
 2020 18:12:32 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:15:cafe::36) by CY4PR1101CA0018.outlook.office365.com
 (2603:10b6:910:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 18:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 18:12:32 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 17 Dec 2020 10:11:30 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 17 Dec 2020 10:11:30 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 dan.j.williams@intel.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=52425 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1kpxkP-0004o6-6U; Thu, 17 Dec 2020 10:11:29 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 5A388122275; Thu, 17 Dec 2020 23:41:28 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH 0/3] dmaengine: xilinx_dma: coverity fixes
Date:   Thu, 17 Dec 2020 23:40:12 +0530
Message-ID: <1608228615-7413-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3495f62-aa38-4735-0628-08d8a2b752f6
X-MS-TrafficTypeDiagnostic: BYAPR02MB4087:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4087910BEBE0DAC9C6D9542EC7C40@BYAPR02MB4087.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/QLbGMi/YNoujVTYAz4e14SKrwtnGbhv/YrRabFgpRl3cd8Hcbk7S17HrbDr2jQKjgd8uwOJ40C9jv2TlO4JGdPxiXyox2kBAaG7+Yr7FvSZ7sLs0S0CLKUgjEuMcsh63+t3YWSQDFKrWLx+fnvMATocGwwTQKGh0SXtCZCZs+/0eN7zvmiud52WA9y+3kVa2JYQXBo/bOv6YRj26J2dq+kYapzzVBAhv7n/LYNaXDir9Ld9EY9MjZi3qd4bzWAyk0mHP037IwjRfpsIbMKS+Gu0PThmV+y7KEeSjfkgFKdrSHs2LiR8EUNWDsT3nNIjhaqGPMYrziYXTUMawsgjPLltHbq6JyssVzXPZZRMKYkuKAdFgiuPVmdAv2LoilQ3N/IRGXBImw6dppqHFfFHxN/smnx9tnH7Fb5z4kYG3Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966005)(6636002)(26005)(6266002)(7636003)(2906002)(4744005)(426003)(70206006)(36756003)(36906005)(4326008)(107886003)(42186006)(6666004)(316002)(54906003)(186003)(110136005)(478600001)(356005)(2616005)(8676002)(336012)(82740400003)(47076004)(70586007)(5660300002)(8936002)(83380400001)(82310400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 18:12:32.6845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3495f62-aa38-4735-0628-08d8a2b752f6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4087
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series fix coverity warnings for xilinx_dma driver.
No functional change. These patches are picked from xilinx 
linux tree and posted for upstream.

Shravya Kumbham (3):
  dmaengine: xilinx_dma: check dma_async_device_register return value
  dmaengine: xilinx_dma: fix incompatible param warning in
    _child_probe()
  dmaengine: xilinx_dma: fix mixed_enum_type coverity warning

 drivers/dma/xilinx/xilinx_dma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.7.4

