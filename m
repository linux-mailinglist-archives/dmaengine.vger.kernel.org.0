Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6A35A503
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 19:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhDIR5X (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 13:57:23 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:35968
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233332AbhDIR5W (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 13:57:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuYWNYbPSK1frletOjCiAvP1VefxZ26+uhmIZw4Dp6N6RB3BoERU2UbWPaGrOJoywsXLG0vqj2N1lNXCdpPvtt0oQEM4B5H9wvmVnVPPf8Ybg+DgXUAxex6Rj2eMiWEYV9p94ZQruNr8hvjo0rKxbJx2lSXGQQP9o4VrSQEsLtMZA24AqJTEJyDMZKNABPfGsBPfe0isj0Q9DVeslszm4sEU3CB9bbHZVybykPcriGo0LPTwo+2c/30IwuWhVdjhhsdje4BGoWms/Vp5uNBwQLKwjSVdwWRBMAAUadi+JMdaiu4CYt92cTNfSswA/uq7cex5Rnvk3lo69/ySx+iASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7/uVvcdXJ2kEoNBm/Dzv432KbLEgACf0H+OeSYZlK0=;
 b=kVu6ptQHb2ztXiazCYkKbDtkwgJkkSHqhGBIfnDVcrO+IP9cijWRDnITqKpCqtpR+cmx0O5fj6Y9Qu70DGHeGeKpLRa3MMeiyDlyq0bq0VmlAchBrKze80viCv+zw+u/kVIkZTjaoB2eXAGGcOri+u9N5lbWZRQEy1zCtJcRb7Zp+EYiosXjkbqiQWkeXDCf+NJzhJMwMieh4wZg2cMf3GNPDuGnH+aWBZLWx3cBKWjorOVQgeDhNMBhgfbG95hFP3ZDH3B3nXPBMEoIKA1+c8qpiavdeZWngh6qyIgnPXp58CAr9Fu5AuC+81oT+p8lA4Cj5XKSZconuIKVGEjc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7/uVvcdXJ2kEoNBm/Dzv432KbLEgACf0H+OeSYZlK0=;
 b=K6JfC3T/FGozCdTBZ4G9yE/b6RgPY+iUPy919M+O50+sSLg6PpZbSxLxoWYtmLTJ9vtEWLvSXB4gLY5O4+6O7YabMjHy6TvImCCOh3V6+gBS3FeQephhlAb1gWFTM/+fdxkpFUhjIXuQ8QyYO+aTUC+Eh91rVCrcZk8C/lW+pFE=
Received: from SN4PR0201CA0029.namprd02.prod.outlook.com
 (2603:10b6:803:2e::15) by PH0PR02MB7830.namprd02.prod.outlook.com
 (2603:10b6:510:5d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 17:57:07 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2e:cafe::8d) by SN4PR0201CA0029.outlook.office365.com
 (2603:10b6:803:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Fri, 9 Apr 2021 17:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 17:57:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 10:56:35 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 10:56:35 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=33274 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1lUvMw-0001BQ-1X; Fri, 09 Apr 2021 10:56:34 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 2E9E2121108; Fri,  9 Apr 2021 23:26:20 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [RFC v2 PATCH 1/7] dt-bindings: dmaengine: xilinx_dma: Add xlnx,axistream-connected property
Date:   Fri, 9 Apr 2021 23:25:59 +0530
Message-ID: <1617990965-35337-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be3b1ed-0839-4173-fe92-08d8fb80e3e3
X-MS-TrafficTypeDiagnostic: PH0PR02MB7830:
X-Microsoft-Antispam-PRVS: <PH0PR02MB7830E86819C164B0939BE1F7C7739@PH0PR02MB7830.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tasdq45y8YB4dwX8H+6dLiGeGfrFbGyV4TdDNqDlhA463cAvTNrXzmsyM+n5XfoCBmNIbExSC/v/d9LfbF/jaey9gkV/MGawXp9Tgmxa+YT0PmyVJvhfcLA9hIlJdtvlISyvz2fFByBtINqpobDvVXSje8Mm/p+DfxueR8NxsCK1YqbUFqPE6bvakwD9n+uUYNuT3nEJIcF4+5efpXD0ZEv0E7dQlx5n2uA5ahCNcQsSlvMDWSV2cjU/Y/1VWYU8kIO2hK9OU46lqFIvCGWojCbLTJCTZSpWyH1TJ9WMfLxZBEscrGXBJNI/1ip4MnQX3zQChA4EIaVO55lI7/XibHcDvQnfsmyHHHK9Ug6OxLEtGOmozrV++D16+SIYJyLMLQZVC+jNUb1ktYegeyUN/d7Wm8xGqabpisG/9t060l7dRyyk8BW2ZtIufVJi26YCNrGZD1u3PwQ8ARF3MvTurZze0gFnE7RR7xYjmiOg56qewVAPyGzlgVmoQwOIBRqZGpOLdgu9cD7c2ZLT/eHRBIf+XpDVMmON6alXryhsWXmY49sE4v7Jm3fmNHapRjXcB4178i1zVcP1LYhjThKFxkmqQQ9YkcEdzAeic9DYeDIGYVXOzQuyfbL7s1+ZwXfDNR6eJdmJNIGMv0ZjshXRWVpJs+5X4cQWmHp7VLEUKSnkUQ2mQ5YkvE6IDpagoX+
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(36860700001)(82740400003)(36906005)(426003)(8676002)(6666004)(6636002)(47076005)(316002)(70586007)(70206006)(110136005)(54906003)(7636003)(2616005)(5660300002)(42186006)(186003)(4326008)(336012)(26005)(2906002)(82310400003)(478600001)(107886003)(6266002)(8936002)(36756003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:57:06.9871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be3b1ed-0839-4173-fe92-08d8fb80e3e3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7830
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add an optional DMA property 'xlnx,axistream-connected'. This can be
specified to indicate that DMA is connected to a streaming IP in the
hardware design and dma driver needs to do some additional handling
i.e pass metadata and perform streaming IP specific configuration.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
- Rename xlnx,axieth-connected to xlnx,axistream-connected to
  make it generic.
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 325aca52cd43..f5f23a4a4467 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -49,6 +49,8 @@ Optional properties for AXI DMA and MCDMA:
 	register as configured in h/w. Takes values {8...26}. If the property
 	is missing or invalid then the default value 23 is used. This is the
 	maximum value that is supported by all IP versions.
+- xlnx,axistream-connected: Tells whether DMA is connected to AXI stream IP.
+
 Optional properties for VDMA:
 - xlnx,flush-fsync: Tells which channel to Flush on Frame sync.
 	It takes following values:
-- 
2.7.4

