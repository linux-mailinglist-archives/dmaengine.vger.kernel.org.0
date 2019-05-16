Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F091FFEC
	for <lists+dmaengine@lfdr.de>; Thu, 16 May 2019 09:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEPHEx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 May 2019 03:04:53 -0400
Received: from mail-eopbgr710062.outbound.protection.outlook.com ([40.107.71.62]:46501
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbfEPHEx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 May 2019 03:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsvRAloly7bvl+sAfl0spHmf1eBqXfij3AschXEcLs8=;
 b=VoMnV7ORIRJ7mOv/HO8F4UGT5y26kw/Nz96oDaOVJx2hUGPh9hpqn9lJyVVu4PaGkhWMLurOyakLdphg5fxQ2I2Z8tCvkmjxEbfQsoNC79M6f0n+fvqY/81fdPylofgBQVVcdDSNgnGPki9AE9Dzu6ZKhrX2mGjvL4EPEbNj+Us=
Received: from BN3PR03CA0100.namprd03.prod.outlook.com (2603:10b6:400:4::18)
 by BLUPR03MB549.namprd03.prod.outlook.com (2a01:111:e400:880::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.25; Thu, 16 May
 2019 07:04:49 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BN3PR03CA0100.outlook.office365.com
 (2603:10b6:400:4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 07:04:49 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Thu, 16 May 2019 07:04:48 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4G74mHu010777
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Thu, 16 May 2019 00:04:48 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 16 May 2019
 03:04:47 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <dmaengine@vger.kernel.org>
CC:     Dragos Bogdan <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] dmaengine: axi-dmac: Add support for interleaved cyclic transfers
Date:   Thu, 16 May 2019 10:04:43 +0300
Message-ID: <20190516070443.16219-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(47776003)(2616005)(476003)(486006)(70586007)(86362001)(126002)(36756003)(50466002)(53416004)(77096007)(8676002)(26005)(186003)(246002)(7636002)(305945005)(107886003)(51416003)(48376002)(5660300002)(8936002)(44832011)(356004)(6666004)(6916009)(50226002)(7696005)(316002)(2906002)(478600001)(4326008)(106002)(16586007)(70206006)(1076003)(426003)(336012)(2351001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB549;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14b7ba8b-7d3d-4761-4047-08d6d9ccc919
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR03MB549;
X-MS-TrafficTypeDiagnostic: BLUPR03MB549:
X-Microsoft-Antispam-PRVS: <BLUPR03MB549EFF314BE751610CB8FDAF90A0@BLUPR03MB549.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qXnkm/gjxTPSz+DZ7qOHzsxRzO05hjWgHDBtlEA/Mv+/WEW98dW70IHCV8Ox79pYoZfIBvLZ5rI4ZNCGNhMtuDqKIrfBz6N4PF7vzQTVUQTbRsLTH3hOjAAuhNxn2BqbuNqjK73h6NP/+SaGPG875dDcwqLFXGccyyZZvgWnGBZX8wE5SECQKo/XiXiLfGDQPGCDWZm1ptjIr1ztl78KlRycooPkyFWt+kitV94IUAcQ4QQD0QD1Y8fmjq57ePM3ZJKZCy8UGmCiWIJ5y/b+rxMyAaXo3hS7kPZB9tbZB/Vro3R20UH88fnzjToCUHQYVqN3LcpRXQ5cR+8xUCl14vvPTjqTGEck9M+pJdVPPgo8h6dJU5v4b7rQjqCc+w+ClPG7gK548r/NxSNrDVwzPPAa9bWjV9domsIeIZGGWTc=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 07:04:48.9014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b7ba8b-7d3d-4761-4047-08d6d9ccc919
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB549
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

The DMAC HDL core supports interleaved & cyclic transfers.
An example use-case for this mode is when the controller is used as a
video DMA.

This change sets the `cyclic` field to true, so that when the IRQ comes and
the `axi_dmac_transfer_done()` callback is called (from the interrupt
handler) the proper `vchan_cyclic_callback()` is called. This way the
DMAEngine framework will process data correctly for interleaved + cyclic
transfers.

This doesn't fix anything. It's an enhancement to the driver.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index f32fdf21edbd..4d2cae0bebb5 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -562,6 +562,9 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_interleaved(
 		desc->sg[0].y_len = 1;
 	}
 
+	if (flags & DMA_CYCLIC)
+		desc->cyclic = true;
+
 	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 }
 
-- 
2.17.1

