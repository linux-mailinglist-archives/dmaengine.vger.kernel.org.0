Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42170BF016
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfIZKvU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 06:51:20 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:31179
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbfIZKvT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 26 Sep 2019 06:51:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoksyCv1XxCL2vRcYjNJwPoscuxOs3f7kiPxxx0hQgwFB436eu3PnnjoDaP9nUMVy+wfxD41SFvpRhc6pEa3i2aIUTzg7GnP1nueTyYtKJJsnlaJZXmjUE4oh56STxdPsjYTBw9li6Fbh7RfkXjbhhbAy4nYg4EKM2TIaZ1JYTtQppBtmJbdTIIVYCQh9DXfr8I2cSxaf34kOPKio4Q1rMh8GI7Dmacj3xl+Ipm9s0ZDzOGhsdAdylBptQyFR8ZwgcfT0wqpzmAWup6q25gJBjgrvIkfIKuvaupH/Kgm7tpKWEPa0GFY6wCb+i4dEUcz3jgvI0LXsHW/ddcetqiAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtK2W/ZxK9Yn+fSgzvHSCjxASd3UqjT8S7k8SqmFjG8=;
 b=h2gRV33fhc3GVjbQlPf+sNZV9D6aFuOT1H7e18OlU8B+CL31KhFHBiBruOmuY0B3YBOQAnxKIJsGzR7ij/dQ8WV8KYStegTUkRRfLdxseLryVI9MugEXo7K/SsXYGC940C4/5zXKWJXL934EHOjdDsA3U6sMC0ad4KmYTKhDKGlS5bNWhbg6PpEqFjezYQYvIbpNComPtyHhjB8oY3xIQmoD+FgZsbZFkBXWxs8QHSQnTTTiimgA/38mqYTOnzna3CBCBuEh3W7IUG/cNAM0jBX7xyT/9sBO5OJHC03EGn4Se+qnKD67Kg1/dV4QYpBbMolNSpUccoaAZaBQFag3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtK2W/ZxK9Yn+fSgzvHSCjxASd3UqjT8S7k8SqmFjG8=;
 b=FKjW9QNNYghCGmte0TbuetSzEDzGodXd+7Q05mz+Rp9FzkDYxTPwiVTMVGqcKQgHJo5IQBakEUiaWzsmVo7eSKZiFSQ9qgyc4yzYoZ1X2QshCFSfvax2Su6BR6K+5HRBWU9OVRnb6nYbw0vUg5MPl3h/joBM8JNIX2xf5OW8Nls=
Received: from BN6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:404:5f::34)
 by BN6PR02MB2466.namprd02.prod.outlook.com (2603:10b6:404:56::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.16; Thu, 26 Sep
 2019 10:51:16 +0000
Received: from CY1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN6PR02CA0048.outlook.office365.com
 (2603:10b6:404:5f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.17 via Frontend
 Transport; Thu, 26 Sep 2019 10:51:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT026.mail.protection.outlook.com (10.152.75.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:51:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47512 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMh-0004oK-F6; Thu, 26 Sep 2019 03:51:15 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iDRMc-0001k2-As; Thu, 26 Sep 2019 03:51:10 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x8QAp9RV032132;
        Thu, 26 Sep 2019 03:51:09 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iDRMa-0001jT-U4; Thu, 26 Sep 2019 03:51:09 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id 212FB1010F7; Thu, 26 Sep 2019 16:21:07 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com,
        michal.simek@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 0/4] dmaengine: xilinx_dma: Minor functional fixes
Date:   Thu, 26 Sep 2019 16:20:56 +0530
Message-Id: <1569495060-18117-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.983-7.0-31-1
X-imss-scan-details: No--1.983-7.0-31-1;No--1.983-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(356004)(6666004)(36756003)(426003)(50466002)(26005)(2616005)(476003)(486006)(126002)(186003)(336012)(103686004)(70206006)(6266002)(107886003)(70586007)(48376002)(8936002)(478600001)(51416003)(4744005)(106002)(14444005)(16586007)(50226002)(2906002)(8676002)(81156014)(81166006)(4326008)(305945005)(5660300002)(47776003)(42186006)(316002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2466;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5feeb2c1-4301-4285-89ad-08d7426f7497
X-MS-TrafficTypeDiagnostic: BN6PR02MB2466:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2466969F20A6511C5D3E8790C7860@BN6PR02MB2466.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jil5rI/bHCzyzpWGAd+b7SSMzCEPexG3ZRnEfLLLldc+tUIIOREWrz/B5AnNLjMUszS2VuORY3qkXfZL6aQdFT43RG9lLcoA8sD12DsbU5IybKTd0O2H6q0vXmOxZByBocuF1bYZxUY/CA7b3ujX6s2GKODCG+4523YlNrHnVU7YDhEXx6I0dQAo0w9XZQTZOn3gKsJaKV3rtBrwS96u8MG7XivcKG0Cd+I8WsNdsEuz00Cb7tAIy5iYWnOQtmSi++J8Z1LLBUeNWTuiCHJiRugOV3Vh8k5/+3cKQZG0D39IfFXqr7kzKzYucRXrTU0GHO+mmHj13zMSwTWGCfN5hVZF+gm1Ry1pwSOtKlU2fbamNvYMjM0Qyy58bgZE2p4ers4qNiFRrz/AAny1aaZnmPco48Amz0paHiWLnhFk2sQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:51:15.9704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5feeb2c1-4301-4285-89ad-08d7426f7497
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2466
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This patchset fixes axidma simple mode 64-bit transfer.
It clears vdma control registers before update, in probe
use devm_platform API and remove clk_get error in case of
EPROBE_DEFER.  

Radhey Shyam Pandey (4):
  dmaengine: xilinx_dma: Fix 64-bit simple AXIDMA transfer
  dmaengine: xilinx_dma: Fix control reg update in
    vdma_channel_set_config
  dmaengine: xilinx_dma: use devm_platform_ioremap_resource()
  dmaengine: xilinx_dma: Remove clk_get error message for probe defer

 drivers/dma/xilinx/xilinx_dma.c |   33 ++++++++++++++++++++++++---------
 1 files changed, 24 insertions(+), 9 deletions(-)

