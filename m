Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C34496C4C
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jan 2022 13:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiAVMPm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jan 2022 07:15:42 -0500
Received: from mail-dm6nam11on2085.outbound.protection.outlook.com ([40.107.223.85]:8032
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234479AbiAVMPl (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 22 Jan 2022 07:15:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P85Lp16smjCcujUrjM6bxCYG5wyK59yY2Q8zrE3d3Cu96943Q/vGpmhu10jWVywXMyCGOkv4lYqcjWMECw3DyVtVY3vc8QTCii2oGzmVo0mtFJqoil7ksAiUqiTSaZErt+IuYOPN1Fu61tDYKI8Pqtmf/6B5EIuroA5qTnXux2GSmf5QcFLvQ8G6nE/IOby6Oa3pO2t5A2OhUnRB9kmWJkC2tc2mSK0vO1LlTRZ3cEOs8XLZbrjiQWIOHFXjLgdJGutiofZ/kUtoEa7qvKZ040l7ZIaSwWTSuk/yfS3SaatgiMaDyCxL2olnWDOe3kzAkGl8pr11hUTlbWBy1612Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ui36tzfCJbeTtsChupAKG/d86OCaes9gaF8nEj3sAE=;
 b=cb1SR3+FRzvadBHDg4bHwgF6CM/r8Uglkdy0cRr3MZCOK7zU0Hd3uIF3M4c2XTIQCD4ojwAEvxeSMMpMj6L2j8J5RLPskRGJhtXrJds5etgkmeHdo2R2Ny2p03fEgFXer+VVklCkiyCj6Qfi33oe7r5+CXPTH41F8+oiDZGjCbkjAzBTIcq8ca15F8AXYInlIQVwE//zVaQ1CRGflUzqk6QPynkvcBNkp44Gc8kGMXwPXKEEkneRcK0EjGqNyP/y0K7S1fqLO5tcM8cccD0ljvO3N/PL4ncQmLu17CMgSUYVIwh+NipJsRO8orugOw91JWC12igZb397Tp/Nr8qASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ui36tzfCJbeTtsChupAKG/d86OCaes9gaF8nEj3sAE=;
 b=OhN3BiM/zMBtSV3MJs/F6Yc7qCMeepyfMKLcZfU59PkJ/6p0sSBOb6Or+uEqH9gBFh/463MmjNbGHHIoKgkm9HGy4Rx0ZciYObG+6gYRF5UUeF5H7i7H+V64l7o72Y1r2vmaBW5JB+WDC1MV8pegLGHMJjNlWUnjW7ANAB5aUvU=
Received: from BN0PR04CA0130.namprd04.prod.outlook.com (2603:10b6:408:ed::15)
 by DM5PR0201MB3624.namprd02.prod.outlook.com (2603:10b6:4:7f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 12:15:39 +0000
Received: from BN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::c6) by BN0PR04CA0130.outlook.office365.com
 (2603:10b6:408:ed::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Sat, 22 Jan 2022 12:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT018.mail.protection.outlook.com (10.13.3.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Sat, 22 Jan 2022 12:15:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 22 Jan 2022 04:15:38 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 22 Jan 2022 04:15:38 -0800
Envelope-to: laurent.pinchart@ideasonboard.com,
 dan.j.williams@intel.com,
 vkoul@kernel.org,
 dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.80.212] (port=43038 helo=xhdneelg42x.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <neel.gandhi@xilinx.com>)
        id 1nBFIw-0006X7-3z; Sat, 22 Jan 2022 04:15:38 -0800
From:   Neel Gandhi <neel.gandhi@xilinx.com>
To:     <laurent.pinchart@ideasonboard.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <michal.simek@xilinx.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Neel Gandhi <neel.gandhi@xilinx.com>
Subject: [PATCH] dmaengine: xilinx: dpdma: Fix race condition in vsync IRQ
Date:   Sat, 22 Jan 2022 17:44:07 +0530
Message-ID: <20220122121407.11467-1-neel.gandhi@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 572590b1-053f-4605-3aeb-08d9dda0e761
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3624:EE_
X-Microsoft-Antispam-PRVS: <DM5PR0201MB362497330E60CF601FB60DC0D25C9@DM5PR0201MB3624.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLfGz0V5swvgJ6xeFBN9dlzIV4UjvulT1e7QapECIq/WSAls3FtwugCJK25XTYEujdQGuKM5UahzXVl3T+wBROY/4P496Okcjrg7Pz+xYXji1Qz5mlzPPowJZMbEsnP+UoSxNnevhexsmxwjRQsFH0Xx4mK4G9nE80A2Z5Jg2CJRxDAEU87RbCw+VJ+mgnl4/utj5aRpmlTbCE6ahwOgIhG7ePJ/JwyWSzFQ7rOBcE3nJaqCdT+9CG6jUyR75p5Mctt30DNNdTc+ji/zyFJhDZs9yXhGp5b3HkV924JCCsEvrXS0LurBWkLP5KT/QeXG39eLCZemn/BM1chJvNHtxGfRcASyQFf/2klmV203kvTjoiNAdi27jr8GD0SepGsqnsz9IeqrZ7f/f3+eULn4VvN8n/S2H5lxPPEUxeBckiCXMd+B7G+GIZFy57jwfK56HttwZwOU5ZHzkFClQN6l3KZQRvPXEel44n0iUwwo1mfc5D0YIAfqu4V0L2kF9R67V6SYdcNkovqt7s6+SsmQ4QFW3bbncY+JrLepF4zAUNUcRxYFfkNA+Y0XOv3LmLhufr7zR5nR5vCLfx0Ga5ZQiYJIKHw04N0WV3DwkYZ/1ACRtiJJVWFEU4M+By0EcHFPMCsR4zgAjiV+bnyk3NaDWiSzQrVrnwghu/3oad4L+cp6RTwbAoz3D0cgr8tk044Zsfvgiz8sKyieSWkHvzkIShGVJwv03Xok7n4PbYvV9UEOHZwPr/FQR5GSNgCYTw3xDUwbdnm/aL09TsjQ7jttDEBcErFC/Da/Z9MWHlIYeZ0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6666004)(7696005)(70206006)(426003)(82310400004)(26005)(336012)(356005)(107886003)(2906002)(47076005)(8676002)(5660300002)(8936002)(70586007)(4326008)(110136005)(9786002)(83380400001)(36756003)(186003)(316002)(44832011)(7636003)(54906003)(2616005)(36860700001)(1076003)(508600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 12:15:39.4644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 572590b1-053f-4605-3aeb-08d9dda0e761
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3624
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Protected race condition of virtual DMA channel from channel queue transfer
via vchan spin lock from the caller of xilinx_dpdma_chan_queue_transfer

Signed-off-by: Neel Gandhi <neel.gandhi@xilinx.com>
---
 drivers/dma/xilinx/xilinx_dpdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_=
dpdma.c
index b0f4948b00a5..7d77a8948e38 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -1102,7 +1102,9 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilin=
x_dpdma_chan *chan)
        chan->desc.active =3D pending;
        chan->desc.pending =3D NULL;

+       spin_lock(&chan->vchan.lock);
        xilinx_dpdma_chan_queue_transfer(chan);
+       spin_unlock(&chan->vchan.lock);

 out:
        spin_unlock_irqrestore(&chan->lock, flags);
@@ -1495,7 +1497,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet=
_struct *t)
                    XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);

        spin_lock_irqsave(&chan->lock, flags);
+       spin_lock(&chan->vchan.lock);
        xilinx_dpdma_chan_queue_transfer(chan);
+       spin_unlock(&chan->vchan.lock);
        spin_unlock_irqrestore(&chan->lock, flags);
 }

--
2.17.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
