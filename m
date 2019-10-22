Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3883CE09F6
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbfJVRA5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 13:00:57 -0400
Received: from mail-eopbgr810075.outbound.protection.outlook.com ([40.107.81.75]:21088
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732901AbfJVRAo (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 13:00:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNFUQMl7Ear6ArU2DxvaGoyfLdgd3SZAOd2o+07cFAqiiXnRLeKThZZvy/+xCoKvHEA6pE0Dv1FI7VInf5l9qXgVTJOdYh+nTDwrtxTV4/3P3CtTxCVs1r6upMR5zpNZcmteKPUGR7Zos1UQxxrfuuQggcn0d9Fqi6Ancw20bpehejd1cjNXyQHmNn0DspEMEeJqRXCvv2EvexlZmcPFhEqkXi3oxcpP8L50A3Rkr0zvBDEtE8uXopq42OAAXGDOnlW4c0kh/G403jKsY8Zk2TFA9MqjyqQFGlIBaOI4Obj34VzReqFYPnRVw8D+WN+4zSg5wvP1VOOkyYvfLohmWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv/e1GMX0SeztnCQFk/4xSve8HK350bCNHTx0laONDE=;
 b=dfk/GsVMjG+HC4esa2DWO2XJweZr1U2ghak3qyk/YfiVlNOBh07bpdWy3/iK77aNm/hfL2EmgARF7+hJNRaR3Ganh8Py37PsuH2WD+NaVcp4I7UF62pVsYUj4KIgQUAiBACpiaXnNsMjsZcsbdi5gj7e7iDrD3zG02rElvD4WjKmwDRLJF0066pUSlsBcQ0IA8h8r1BWmd8i7ovjDl04FxSbpzOFJVJ3SycpWJUc+hPetmaILaHXtDvUgzfqV8C/feXVZbiBrioQdJlI2P6cvWOgbTGDFquc0ohs2dyXZVKhUslnrpfgQWfBwzJR2ez9MCT7SZFzJUEIw2Q8SrESjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mv/e1GMX0SeztnCQFk/4xSve8HK350bCNHTx0laONDE=;
 b=qiLOxJ95XorhCyq3MSlafeuGgc9BqhCM8wIRUvtfC85/iXQRm1rGTE88wlo+rzK/FPMm2ptzAOm6QBPDg+2rVcNSc9f2wnBlOCt2RaZmKSFqckk4BxCOhRxQq1/1hjT3EYvbicoKB624VIy86gwIyj6iJUAo/s/VGHQTjJPF2AE=
Received: from BN6PR02CA0030.namprd02.prod.outlook.com (2603:10b6:404:5f::16)
 by CH2PR02MB6053.namprd02.prod.outlook.com (2603:10b6:610:1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Tue, 22 Oct
 2019 17:00:41 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN6PR02CA0030.outlook.office365.com
 (2603:10b6:404:5f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20 via Frontend
 Transport; Tue, 22 Oct 2019 17:00:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 17:00:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWS-0006Am-GU; Tue, 22 Oct 2019 10:00:40 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWN-0005DF-4Y; Tue, 22 Oct 2019 10:00:35 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9MH0WM1030515;
        Tue, 22 Oct 2019 10:00:32 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iMxWJ-00059Y-Hj; Tue, 22 Oct 2019 10:00:31 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id BE39C10104D; Tue, 22 Oct 2019 22:30:30 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 0/6] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support
Date:   Tue, 22 Oct 2019 22:30:16 +0530
Message-Id: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.831-7.0-31-1
X-imss-scan-details: No--6.831-7.0-31-1;No--6.831-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(189003)(199004)(2906002)(5660300002)(107886003)(50226002)(16586007)(6266002)(47776003)(14444005)(50466002)(106002)(186003)(478600001)(7416002)(336012)(426003)(966005)(70206006)(6666004)(486006)(476003)(4326008)(6306002)(81156014)(126002)(103686004)(356004)(26005)(48376002)(51416003)(81166006)(316002)(2616005)(36756003)(70586007)(42186006)(8936002)(305945005)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6053;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5b8795e-bfb9-4177-a852-08d757115eb6
X-MS-TrafficTypeDiagnostic: CH2PR02MB6053:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <CH2PR02MB6053A31784BDF03E71A79C22C7680@CH2PR02MB6053.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xu2O7nIvjM0cZM7MXPRkLJAcF0qyOkxZBLHegV5vBF8afvtiuvzhtlBh+Z4fQxLv8coOthKHoLmxmQlQj/FOrD+mDF/IlLM6ebF69BlREEGWesUYhY3MHGh3F+s9WdylJmOGiFs9J+yjhYFsUHsJZbC7pO6E7ylPPxr2T5BPzQUKavVIRgfIz6B9oroPCDlSrPogi+4g0eGnTPMBBXzm8y4POZa9dpAACDt0YBCbpfChW8XC6r30kN9a0YgK3NCZGyrUwBSJLGHzfho+VCqg/URkzyjwcjDzCWv7ypWs7qPOIjfFuKYGq9Az7eLz1FX3AnKZ5YSEk9kYg2Hgq8SO7oSMHwHiNvw6XCGoa8OmXP/S5eYtPtixd+3vpLDbDFRUDQmgvx0UyYPqHrWbSyYbKKQw8vjsUbkyOS6eWCj+8IOJV3/3HrkRUBy5jo+P4gK0CAM6DavUZIVJgzqvfQ3iTc9+bu++zh8+aWv69qMNl2k=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 17:00:41.0173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b8795e-bfb9-4177-a852-08d757115eb6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6053
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset adds Xilinx AXI MCDMA IP support. The AXI MCDMA provides
high-bandwidth direct memory access between memory and AXI4-Stream target
peripherals. It supports up to 16 independent read/write channels.

MCDMA IP supports per channel interrupt output but driver support one
interrupt per channel for simplification. IP specification/programming
sequence and register description is mentioned in PG [1].

The driver is tested with xilinx internal dmatest client. In end usecase
MCDMA will be used by xilinx axiethernet driver using dma API's.

Changes since RFC[2]:
- Remove xilinx axidma multichannel support.
- Addressed all RFC comments except modularizing initialization of channel
  segment is skipped as it would create tight coupling b/w axidma and
  mcdma internal structures.
- Include MCDMA IP description in Kconfig.
- Few regression fixes from xilinx tree.

NOTE: This patchset is based on next and previous[3] axidma series.

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_mcdma/v1_0/pg288-axi-mcdma.pdf
[2] https://spinics.net/lists/devicetree/msg242427.html
[3] https://www.spinics.net/lists/dmaengine/msg19910.html

Radhey Shyam Pandey (6):
  dt-bindings: dmaengine: xilinx_dma: Remove axidma multichannel support
  dt-bindings: dmaengine: xilinx_dma: Fix formatting and style
  dt-bindings: dmaengine: xilinx_dma: Add binding for Xilinx MCDMA IP
  dmaengine: xilinx_dma: Remove axidma multichannel mode support
  dmaengine: xilinx_dma: Extend dma_config struct to store irq routine
    handle
  dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  24 +-
 drivers/dma/Kconfig                                |   4 +
 drivers/dma/xilinx/xilinx_dma.c                    | 517 ++++++++++++++++-----
 3 files changed, 431 insertions(+), 114 deletions(-)

-- 
2.7.4

