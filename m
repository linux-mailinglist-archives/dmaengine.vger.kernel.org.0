Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5542E1BC3
	for <lists+dmaengine@lfdr.de>; Wed, 23 Dec 2020 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgLWLWU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Dec 2020 06:22:20 -0500
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:3360
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgLWLWU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 23 Dec 2020 06:22:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaTcLdWSXRAcC2cGcXnRbqcSI9N1PJ/UI/C49/GfywXscNkd4Ow1WVTjGTWyYMsLbVVEFXUokVbXA2jRKtfC/kQNzODOyx1poUFog6AoD/ss7rZyrI9OxFU45vHqO+eFSf0fuqJ5Z3tqitvV6VFanRVCvbVgNXSFH6ZiPLKO403xbWcTjE0knGwgFVH4fuj3mwbx0sXt88GB6PSgirnWrhG8jG5vZ1tHgwwOH9hSLcd055oOyuyGb+2oNEhv/r4nlDwFCfOvKGlCCdJvEE3j9YXkjg58NTXGdfMODUnSPIoBoGBoCIxGcnzPiWS8VIcvEcCPInjZYr58Hs7rtJgQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JON+2zq9NXWopLID4/kEXs42/5AkLHIacYTK8s33oqU=;
 b=lkciG7C2B3ytqC6kclpl8KDywqpht+d3cPOwQKrqX8LA9laHPhTzjz7UwO0m2eG7OvSARRT+DVtz3oQEJbucKGCy39ojlfG/F78fai6QLNs+EmzyfyAwGrOpXF75eHSyf3DYJ5XfbnxODsMX/6jfOzcN/mGyKaovL3UXZ4WZU9taR+YOlqvCMYUCznQYhlmDtlNZMuqSs9oea7M+2pRAKvLAkhC6yDc3/0/xVAJsk5iNe5lM0IImhSlkg75TQdOKzddnELi6Fd050Tz7AbNaOZuhIR6rcNTTeh09ABdEk5ozRlwIca4wpPC06iPxprZ0NF1UTlNqLqOS3IcF2St2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JON+2zq9NXWopLID4/kEXs42/5AkLHIacYTK8s33oqU=;
 b=gI8p95mhodRc2YNBuD03RnBBDobsiK9QhJT2zKshjaeqj54JbJIgBRhrdRHbpC5NC5eMCFiMLzcn7QydxCGiYtkEIsfjrKMECSFokUc75w6RlfbyHPZeF82ksnY9UjdY6Mb8iLkdU1Do2Hp/u8z6c5VqYMMmvjSA5jpCiDSRbn4=
Received: from MN2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:208:120::16)
 by BYAPR02MB3912.namprd02.prod.outlook.com (2603:10b6:a02:f3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Wed, 23 Dec
 2020 11:21:27 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::aa) by MN2PR10CA0003.outlook.office365.com
 (2603:10b6:208:120::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Wed, 23 Dec 2020 11:21:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3676.25 via Frontend Transport; Wed, 23 Dec 2020 11:21:26 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 23 Dec 2020 03:21:09 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 23 Dec 2020 03:21:09 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 andrea.merello@gmail.com,
 nick.graumann@gmail.com,
 dan.j.williams@intel.com,
 mcgrof@kernel.org,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=34630 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1ks2Ca-0007hV-Pe; Wed, 23 Dec 2020 03:21:09 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id E978412109E; Wed, 23 Dec 2020 16:51:07 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <nick.graumann@gmail.com>,
        <andrea.merello@gmail.com>, <appana.durga.rao@xilinx.com>,
        <mcgrof@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH v2 0/3] dmaengine: xilinx_dma: coverity fixes
Date:   Wed, 23 Dec 2020 16:50:59 +0530
Message-ID: <1608722462-29519-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85c81353-8772-404b-8d05-08d8a734e37e
X-MS-TrafficTypeDiagnostic: BYAPR02MB3912:
X-Microsoft-Antispam-PRVS: <BYAPR02MB3912FCFD4AA6A0036792358EC7DE0@BYAPR02MB3912.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L9p/4u/hOC2fBoY8LnEdWhlaph9QRZtYjKydKX09yNYfz2spQMuwP30Y3OGLz6WfdrIjBJ0pzS4bkop9WnFy4xuz9gUflSgETaCprkEPq+iVayCC2HeWpFJQoqQ1LsdRdGnkz6jNi+XyLOfsNoQvqhfpJTvzfokgmcFHWeWoTUto9AVMoV+muhHF4seGNz/FHZB7lhjg2yEouRlFP1zq69N4kWidAeHHVjMdLPZmiq+WDN/9kqug8RGcBIDQQe/Laua5mNw43D8oLL2iw8gfYy8jwPWhb0eOOt1PwPENfRTzgWHmdBPWq7YF7SHS+uirmXssNNGC8iyhllXRrknH8e/3fQS+3G+vsrrvW8vO0oKCx8LWD73wCmE4MvAb6oNHi/NbkTpmVl9AfinsCueo6nRJlLnGtcqUHyv69mArcSpOIf/XHwWLr+QFBELGjPDlUN/AY5seUQkQALSb8QSrUxSTaHVCZMTNnK/rPZmN7HKf1887qvOSml2z7spb3OgcKmygq+PoVWsVnAktpQjh0Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(6266002)(426003)(36756003)(107886003)(8676002)(47076005)(8936002)(336012)(2616005)(5660300002)(4744005)(82310400003)(82740400003)(70206006)(186003)(26005)(70586007)(4326008)(54906003)(316002)(2906002)(42186006)(83380400001)(356005)(7636003)(36906005)(6666004)(110136005)(478600001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 11:21:26.8385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c81353-8772-404b-8d05-08d8a734e37e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3912
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patch series fix coverity warnings for xilinx_dma driver.
No functional change. These patches are picked from xilinx
linux tree and posted for upstream.

Changes for v2:
- Include fixes tag.
- In 3/3 patch keep typecasting changes in the same line.

Shravya Kumbham (3):
  dmaengine: xilinx_dma: check dma_async_device_register return value
  dmaengine: xilinx_dma: fix incompatible param warning in
    _child_probe()
  dmaengine: xilinx_dma: fix mixed_enum_type coverity warning

 drivers/dma/xilinx/xilinx_dma.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.7.4

