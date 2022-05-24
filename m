Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE67532460
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 09:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiEXHtW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiEXHtV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 03:49:21 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2069.outbound.protection.outlook.com [40.107.101.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EBB986F4;
        Tue, 24 May 2022 00:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxQs0XuONK9N98nx0Qc0tXWiQMIl/kUS/s/23/EnYkmTOOc4YVIdNp+lUb8PtSX+b3HtvYXG29CsQilGc6p30WBRvZO2tSDAbY0gXI5W8uJu3S3VAGuL0dPvpnyEBty/daycjr1KCuvSAotWz9c/X7/TaMRjiDXkwHhBY4Yok8WxU3fLF6LlJrWb+5I1+kZ8T0Xc6dTAx7eH9FQGAsw5swJ5jOSIvkw+m0lIPKWM3TWp//5Sz+G3RM/Mcu2dqEDCfB2ocjC6JeeExQ3tSyDgcibL8QzB3ztrNOaEul6lJOev4/fwkkF4SHd748uOv/QcE0J1kHqNdjG1ot4P7tdb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGLGsYGN9UdlhCwzhKs6vNlQj92cRhVcArkvCrs8bbs=;
 b=iHO4ztMjsD/lTQb4kBF3+LlVqEMwgXJDPO1tNmoOB3tuztnuxlztd2EWa8EvwjEpCdknJdN+wLx/s1fg4SKvwsZwlp5Ut3k9Z9pxwy98MUujk0XgCJSLgHlBESu+8RuRRXoCI6wmi61quRK2PU9RwxJ8HSFqmLpW868jCcHG6B9ZAgFAJKfpAu3JIK+Q1ZZlrFVc8UxKBQg3p9/+AfZv2DCE0vKsXld8yuAny/L3WtRCkE4hB6y36af0/TLPUV/U1OcnnqRkk++tNayHNq7GgL9dzPvV6XzPk5pEq073klO2mzo+zLwYn/x6gPxLk+fVqOC8ed50tvHwRBhX3ZdOpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=amd.com smtp.mailfrom=xilinx.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGLGsYGN9UdlhCwzhKs6vNlQj92cRhVcArkvCrs8bbs=;
 b=qFMfbm6forPvQlmHeoFeAbQ+3DCcIONAHwZQDbAXlw/fzGE05aPf+Z3bzU2QTnuUjGRPz6ewY/NK7NZPX51dUv0Eu+uFSIaItdTUcwXLBh7YOxnt6NEknMm37gDQPUAi+ROrR85B+4V28Mgaers/0jynJalj2VyiFwM64Aq75BA=
Received: from SN6PR16CA0039.namprd16.prod.outlook.com (2603:10b6:805:ca::16)
 by SJ0PR02MB8626.namprd02.prod.outlook.com (2603:10b6:a03:3fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 07:49:18 +0000
Received: from SN1NAM02FT0025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::b) by SN6PR16CA0039.outlook.office365.com
 (2603:10b6:805:ca::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23 via Frontend
 Transport; Tue, 24 May 2022 07:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0025.mail.protection.outlook.com (10.97.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 07:49:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 00:49:16 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 00:49:16 -0700
Envelope-to: git@amd.com,
 radhey.shyam.pandey@amd.com,
 vkoul@kernel.org,
 m.tretter@pengutronix.de,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.4] (port=55505 helo=xhdvnc104.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1ntPI4-000EHV-Gp; Tue, 24 May 2022 00:49:16 -0700
Received: by xhdvnc104.xilinx.com (Postfix, from userid 13245)
        id AF5EA120500; Tue, 24 May 2022 13:19:15 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <vkoul@kernel.org>, <michal.simek@xilinx.com>,
        <m.tretter@pengutronix.de>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, Shravya Kumbham <shravya.kumbham@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] dmaengine: zynqmp_dma: Typecast with enum to fix the coverity warning
Date:   Tue, 24 May 2022 13:19:13 +0530
Message-ID: <1653378553-28548-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4416ab30-fba3-45f7-7b27-08da3d59e839
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8626:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB862675D320B3B10D0D310520C7D79@SJ0PR02MB8626.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txAdCHcAEYHs5IjAAKJSUqbZ8icXgrt2008VwinSNn4Na1EQJHSFNjWezngDlgwr6SWKcO8BwTT+BpQIKjkHN0wmAdx0DdKuX6HxDgpcxN2+emwsn7oIKu/4xn2RsXytyyupgz1Bhq8nCKPplL0WlWDlWcZEyVmMMUGeUelqrGfUauYdIeG6uOX31Y9XKlw5GsEgzZnWtHDaqqbjdu4+h+PanHkD/nlmLIfDpHaxiL+FcOmLESEo2ZhGNANFcKG1go1JQsXf0hMCZ+lXbS6oqobCP6TY81BYyaKLm31n45NEmY6CIpeqNlowNgsxEMRnCUsijtStXHkqQvWu/zLXyz5z9ZwFZHNq8GNgt+n/FAEb4miFOQ/qE9xiuEiqeZsjBWmN8QILK0vpir640Gv7fGmtUlDVag4JDvMu7YcaxSDUGfg6FabHkUBOHysDYXpa74fx6xbkGTUambsFy/UWLQT410E9mdprz6KqSOvCGg1fY72kEC3Dlbug8a9++Fv9LZCrI96hte3z66JZKWjize7J3ZYSkgO5xXvBX1rewHERJUZC7bMnGIDyKRXAF50p+1U7VlCmYbQtbnNirxqFozITCoZ32nSDvbe4DQx5VrGxD34a1WrkIgpr9IY+fEiHr5KLgZoJ+/pOWWBCwXDU6X+9Z0PfNn1s9+WKDufrz3clIDULUbK7MuES6NgFw/0R+BGOSDbQBVJeuD3tXi7nL6i4nj+pZEJTUdDFNTJSYpmA1PwmS6jKcJQdRAgMNdMd3bb48Yjqvk5hjmdnJM4G3yVjcwK6HpERCIiXKovCT6fxNhUEONXElJdJviSVGU7s
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(8676002)(316002)(47076005)(186003)(2906002)(70586007)(4326008)(83170400001)(42882007)(82310400005)(36756003)(70206006)(110136005)(36860700001)(42186006)(356005)(336012)(8936002)(5660300002)(7636003)(26005)(6266002)(40460700003)(966005)(508600001)(2616005)(83380400001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 07:49:18.3030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4416ab30-fba3-45f7-7b27-08da3d59e839
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8626
X-Spam-Status: No, score=1.3 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Shravya Kumbham <shravya.kumbham@xilinx.com>

Typecast the flags variable with (enum dma_ctrl_flags) in
zynqmp_dma_prep_memcpy function to fix the coverity warning.

Addresses-Coverity: Event mixed_enum_type.
Signed-off-by: Shravya Kumbham <shravya.kumbham@xilinx.com>
Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
NOTE- This patch was sent to dmaengine mailing list[1] and
there was a suggestion from Michael Tretter to change the
signature of the dmaengine_prep_dma_memcpy() engine to accept
"enum dma_ctrl_flags flags" instead of "unsigned long flags".

All device_prep_dma_* API variants have ulong flags argument.
So this is a wider question if we want to change these APIs?
Also there are existing users of these public APIs.

[1]: https://lore.kernel.org/linux-arm-kernel/20210914082817.22311-2-harini.katakam@xilinx.com/t/#m1d1bc959f500b04fa1470caa31239a95c73fd45d
---
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index dc299ab36818..3f4ee3954384 100644
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
2.25.1

