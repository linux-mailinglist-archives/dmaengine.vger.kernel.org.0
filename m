Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F94C35A500
	for <lists+dmaengine@lfdr.de>; Fri,  9 Apr 2021 19:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhDIR5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 9 Apr 2021 13:57:09 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:30497
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233896AbhDIR5I (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 9 Apr 2021 13:57:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H940HEHv/Nfh/SpTyHp6oLG0YQAU5JDaPLUhOJKBX8pcnZan7BnYiWDZRuNFwT8fuvfqS0tYE9ofNkcwggiBXmmNqVUENiidV1P72qN6xtNLa0kamaF37QmpIqmQpOXnp2QXGQZYESwXmPm5WSU5ncAJfQaclx9Go4nG0nVviiBRaqVcJZCmiltvgypczu/ZhDzoFo8Qv57cOzBeLrAi65iPqt7G9svum7qt15OQJs1w0UlxzvDNvv+W0KEDZFebTno7fjnnFOmqE9QC8FeBkfUm0aCqDnys5cGrg2Ky5d3B1lG1myQuOB9+EsRf5mFB3jnLdPL+tusQsIr63YzpHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTgyts5DOIFhaYlA7A/QOByz28Ob9F0+3bvA9XmD3M4=;
 b=J602VjhdZho3lbCb9NH3gFkrD66PZ6mktX0FQNNbAXMKgvbno+49uwf+OhYnHnUjYd3NgbN4cp1H8NgM+MudX4MDlepJyFNXbY2X3eSwRz6JRoJBEiiaTLUFxr+ot4Ie/qRyMBuv6PIjOnKi1QSokLZ1LPk7A0KsuhK3daeTokBinmbQm1tArpqB3ObC0HlUn4dT2DQnKd705pC0J2kGfzyPUI9My+yVzoEZ3igWnLPNpWC8h+4ZKKx9UfTogTW+ZOwAJ/IrCILtZFnVUUKOiMBoySe3sq/0iz+gkKVFAbqRVRtHS7tWCf0eJgV5r8vxOei1z6hlcy9AmotZig8d8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTgyts5DOIFhaYlA7A/QOByz28Ob9F0+3bvA9XmD3M4=;
 b=ngpMWJyi9+0xAqpSiW9z3hG04iIwQ6a1pejdjlRTXhuRwRr19exUSW9aZfROzfjj+3Z3buHWblXLct1zG500M2EEzyVTZStZfjBS/Nh5HnvhA33mcsFttUauw+ZqB316kQckytfA1xr89HKsXBmwJlZMUzHi3Q7Ec62WJNlttBk=
Received: from SA0PR11CA0151.namprd11.prod.outlook.com (2603:10b6:806:1bb::6)
 by SN6PR02MB5199.namprd02.prod.outlook.com (2603:10b6:805:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 17:56:52 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bb:cafe::2c) by SA0PR11CA0151.outlook.office365.com
 (2603:10b6:806:1bb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 17:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 17:56:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 10:56:22 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 9 Apr 2021 10:56:22 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 vkoul@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=33271 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1lUvMi-0001Aq-UO; Fri, 09 Apr 2021 10:56:21 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 13245)
        id 2A2A9121386; Fri,  9 Apr 2021 23:26:20 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [RFC v2 PATCH 0/7] Xilinx DMA enhancements and optimization
Date:   Fri, 9 Apr 2021 23:25:58 +0530
Message-ID: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6658f5c2-bbe1-4cd1-9121-08d8fb80db2b
X-MS-TrafficTypeDiagnostic: SN6PR02MB5199:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5199E107C44BDF7607352723C7739@SN6PR02MB5199.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F76XK8osWIwgy6RDQ+ZKCDcKACfDCM0aqkMrZN3yusjGZmnK2+kyZnA9wGQrMUzhDsKKG0mG20BpgEZVGg2DGde2PWo9N0iNxueo6mcVjzTlCmMM5hs42J/1ubaEZcwWPNosXWYDxh8AlT3u93lhaWLqekgnoLlw1pnlS9sAhJ5aMZFEVy3Hm0nGUB1Hzq6Jtk6sm75JXRz8Dnze635sC/venKXbq20Uv9lKZw8tPYR7PP022jLlCSmzjJxxtKGeCeh9VbjhaXxIydslKPmTqCEvUV4keHqVyXVTbZcTdn7PgKnWhPoTuqAWVRfUTsuGBwvqNZkX/G9XYz2iP5hAtHOEmXqhxXnBoZnRuH3pY+C2r5qzQVG3S286jdt08nICKJb5Fl5PBK+JyqYaEBYUCCcz63UOP5ue2sL8BY0rBIuyjEP/u/uBQxudN+9/I5jgHRs1vMXzkaBNHfG2rTbIGvcj/YuCrlAjN4OnJCnMWTLcH9ZDusaqYzrEgamFl4N4FksoXSe8O1mq4MvSnjTitEvgt871AXP30Y8rct0HpZY0byJaZrdD0G6eXqmVEjv50Lr4ma8lN59tm2EIkeeEzkEH/fS+HoN5YZcvhNJmW6BJS44aY/gXDQFtrsL8jkTVE+yGM0UCSpO2iW7CUDEniV87n8WDPsHYoV+tXv8iQUeuCytVKGYHsR0Ysiv4aY77ytnn+jpnnUB4m3haSh6Zdk3B0hOwFpw5pxo2Ft6hYX9kx/wrV/6bwboD3tMPWRGhch8GdZWBrI5+HZwz8oAodg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(346002)(136003)(46966006)(36840700001)(316002)(6266002)(336012)(426003)(82310400003)(8676002)(110136005)(2616005)(966005)(36860700001)(6666004)(36756003)(5660300002)(6636002)(70206006)(42186006)(36906005)(26005)(107886003)(2906002)(478600001)(82740400003)(7636003)(4326008)(70586007)(8936002)(83380400001)(47076005)(186003)(54906003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 17:56:52.3566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6658f5c2-bbe1-4cd1-9121-08d8fb80db2b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5199
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


Some background about the patch series: Xilinx Axi Ethernet device driver
(xilinx_axienet_main.c) currently has axi-dma code inside it. The goal
is to refactor axiethernet driver and use existing AXI DMA driver using
DMAEngine API.

This patchset does feature addition and optimization to support
axidma integration with axiethernet network driver. Once axidma 
version is accepted mcdma specific changes will be added in 
followup version.

This series is based on dmaengine tree commit: #a38fd8748464

Changes for v2:
- Use metadata API[1] for passing metadata from dma to netdev client.
- Read irq-delay from DT.
- Remove desc_callback_valid check.
- Addressed RFC v1 comments[2].
- Minor code refactoring.

Comments, suggestions are very welcome!


[1] https://www.spinics.net/lists/dmaengine/msg16583.html
[2] https://www.spinics.net/lists/dmaengine/msg15208.html

Radhey Shyam Pandey (7):
  dt-bindings: dmaengine: xilinx_dma: Add xlnx,axistream-connected
    property
  dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
  dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
  dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
  dmaengine: xilinx_dma: Freeup active list based on descriptor
    completion bit
  dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical
    usecase
  dmaengine: xilinx_dma: Program interrupt delay timeout

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  4 ++
 drivers/dma/xilinx/xilinx_dma.c                    | 68 ++++++++++++++++++----
 2 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.7.4

