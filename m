Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC146E09FC
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 19:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfJVRBS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 13:01:18 -0400
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:65312
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730768AbfJVRBR (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 13:01:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8XcNa+yjyt1MqU8sO4RME5s6YvHBd5mMmJGsWyslk6Zd+GUuYXxUsgm/H5PIWEqrKfSjcjDaiEgP8ThOy05k+wRWU8SUgLklgTAu+R6vQGMivQnVScoBF4VXaIJbNGSLF4oNsVI5dvMCcTzhcvuqFv6fj3vbS8+jBJNPDTmyskSAX8rzympsKCxsxTjrgyutPW0S2amPYjBv2HkyudpBC6iUStrwYoA3FT0ILVK7mPIo+pbsXlM+W8QpTI6REtd8XKqGOsNU+pbfjvmKWyQ5nVila6jUHrS/AqSbIo8dCAyMXXCoYogEh8uzfXEm1gIukCx9sfTxAzZIr1Ly2qbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU76ojE5cyfLDJ4NzqiIRVsIPhl67djomZGnU4Ca31w=;
 b=OMMLPvE3MChqrc8Gz7ZSv50LKYuEDR0+WYGAIeuFBU3aE5fegjTsfayL6rcQXE5gF95yzrdpF0No2UJ/txye4/lxe7ByFhgsgDr+YCbeHANsqQ/Rcirg8Tyigv8+B4g9fWTtQMM5//MGmOgq0TnCnIxmzk7tg9n1VEPd3+2edPpNB4tVmhGhstK7+gHkKj70l0TO3ReJEOmsFlTuNNduFIbNpimxS40T1zVKd/MNHhjINuhJuHM4sgq8rj4nfw7m2hn+AKZgxX+CkjaANE+hcCriFUcdSDUlNGWrJ6dUQ6MvZ/vGnZ4XDLh/SzUcAvo1yczRl1vi4gVNgQn9n6vJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU76ojE5cyfLDJ4NzqiIRVsIPhl67djomZGnU4Ca31w=;
 b=Sacs5uUs9cuRw21FntbXSwRqM6NOzsGN42dgxkxRwalzGoWHs5ZBVR/IEllFZ8MZKsNvQ6Z1nqPNlMFxSHA6Eez4aKYUkhSt7pcB8EKwzxcNE7XxIHSa1uRFrTHI/OpU6FepoxwhGdZrwiE05xpXEvUFW4OwYjByRmTldqrvz7g=
Received: from BN7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:20::20)
 by DM6PR02MB5354.namprd02.prod.outlook.com (2603:10b6:5:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.24; Tue, 22 Oct
 2019 17:00:43 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BN7PR02CA0007.outlook.office365.com
 (2603:10b6:408:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via Frontend
 Transport; Tue, 22 Oct 2019 17:00:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 17:00:43 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWU-0006Ap-Ea; Tue, 22 Oct 2019 10:00:42 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWP-0005GT-1M; Tue, 22 Oct 2019 10:00:37 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9MH0XNG022072;
        Tue, 22 Oct 2019 10:00:33 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iMxWK-0005B3-Pg; Tue, 22 Oct 2019 10:00:33 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id DA455101132; Tue, 22 Oct 2019 22:30:30 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 5/6] dmaengine: xilinx_dma: Extend dma_config struct to store irq routine handle
Date:   Tue, 22 Oct 2019 22:30:21 +0530
Message-Id: <1571763622-29281-6-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.725-7.0-31-1
X-imss-scan-details: No--5.725-7.0-31-1;No--5.725-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(476003)(2616005)(446003)(103686004)(50226002)(478600001)(81156014)(8936002)(81166006)(8676002)(356004)(6666004)(70206006)(70586007)(126002)(486006)(50466002)(11346002)(186003)(5660300002)(14444005)(26005)(336012)(426003)(47776003)(76176011)(6266002)(305945005)(7416002)(107886003)(4326008)(36756003)(106002)(2906002)(48376002)(16586007)(42186006)(316002)(51416003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5354;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63cdd267-7f3f-412b-2891-08d757115ff0
X-MS-TrafficTypeDiagnostic: DM6PR02MB5354:
X-Microsoft-Antispam-PRVS: <DM6PR02MB53548A4BD99512C0389FBDAAC7680@DM6PR02MB5354.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UD9A4z2kc1lQ+EhzEl7IgGpBvMu6LJSm9Z2jheJTtL8NNliULP8MAKBrLH6HEuB5NXwaqeYsh+Z7ijR6mQw4ykpRD+UKInV7Blnhh+At22oaZbdXmD56aIAACUBeHoQNCal8XXpkMkv3Bww7ZHU/fHgCGE6MoJBagvUgkovm5m9ZYDnTZKPEPo83FtFB81uLyP5BQfaYCWqsjo6T8qmEWPMgCfi2ki/4kUywGI5cnKQQigxOvfZjk5FhclE7atAFsEONh5b3sqyQbU+jDqQrCPDUv2cw6xceZIZpo8Zejy+95qC4/ZmA2PalgiB9Yrqg5HsWMWr2VUJ4WWPwWx9l2vGWHJ9GaXbAO0dUJN2O3VcenCdoXrR6RzbjFGq0T/DFtdG1aihp3v9+qxntSfz1aZ0xrBfr1mkQdq3i/i+/hVIAfg/LzGjFcSnuyzRKvq9K
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 17:00:43.0428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cdd267-7f3f-412b-2891-08d757115ff0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5354
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Extend dma_config structure to store irq routine handle. It enables runtime
handler selection based on xdma_ip_type and serves as preparatory patch for
adding MCDMA IP support.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Suggested-by: Vinod Koul <vkoul@kernel.org>
---
Changes since RFC:
New patch. It serve as a preparatory patch for MCDMA driver support.
---
 drivers/dma/xilinx/xilinx_dma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 6d45865..25042a9 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -391,6 +391,7 @@ struct xilinx_dma_config {
 	int (*clk_init)(struct platform_device *pdev, struct clk **axi_clk,
 			struct clk **tx_clk, struct clk **txs_clk,
 			struct clk **rx_clk, struct clk **rxs_clk);
+	irqreturn_t (*irq_handler)(int irq, void *data);
 };
 
 /**
@@ -2402,8 +2403,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 
 	/* Request the interrupt */
 	chan->irq = irq_of_parse_and_map(node, 0);
-	err = request_irq(chan->irq, xilinx_dma_irq_handler, IRQF_SHARED,
-			  "xilinx-dma-controller", chan);
+	err = request_irq(chan->irq, xdev->dma_config->irq_handler,
+			  IRQF_SHARED, "xilinx-dma-controller", chan);
 	if (err) {
 		dev_err(xdev->dev, "unable to request IRQ %d\n", chan->irq);
 		return err;
@@ -2497,16 +2498,19 @@ static struct dma_chan *of_dma_xilinx_xlate(struct of_phandle_args *dma_spec,
 static const struct xilinx_dma_config axidma_config = {
 	.dmatype = XDMA_TYPE_AXIDMA,
 	.clk_init = axidma_clk_init,
+	.irq_handler = xilinx_dma_irq_handler,
 };
 
 static const struct xilinx_dma_config axicdma_config = {
 	.dmatype = XDMA_TYPE_CDMA,
 	.clk_init = axicdma_clk_init,
+	.irq_handler = xilinx_dma_irq_handler,
 };
 
 static const struct xilinx_dma_config axivdma_config = {
 	.dmatype = XDMA_TYPE_VDMA,
 	.clk_init = axivdma_clk_init,
+	.irq_handler = xilinx_dma_irq_handler,
 };
 
 static const struct of_device_id xilinx_dma_of_ids[] = {
-- 
2.7.4

