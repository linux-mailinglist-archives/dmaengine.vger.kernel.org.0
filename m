Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4241B2D5
	for <lists+dmaengine@lfdr.de>; Tue, 28 Sep 2021 17:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbhI1PV3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Sep 2021 11:21:29 -0400
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:40161
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241405AbhI1PV3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Sep 2021 11:21:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0w7getXpr2KUJz01/jm0E52SkUXwdWYGLzdBY7fhyfcnwOewQGZz1/pTj+IhycpkLtP0KkhXPYk+E6ZZHfvP20A0lIVkQh8ahJRfBRc+EtUr+zy0AjEtpwz4OR4YVO0/Olaa5ffV3rI1XYKBM7EeQlPf7QXuMwImQN6aAT7Ow50CMCIGjLeiIILJaEkU2DGARVhRnEyHjBMJKhLcgdpq6yo9Kf8qMamFI3ZKwGvafA1Cf4onnQMq5EuRkCgxhFUgy3DzV7FLQrxE+p7oh5LwASugoq87UJhfvPN2a1e+KvgbNpNd4aEE7ccmjVa2bun4g0WXCNjlbnjKUrN0WCxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=g0YYPJu6k4nLFfF0Qw5mV8lnqTq7o+IquhdNTnDx150=;
 b=irC8MAqw8KwSno+pB0X8kl9wFkdPYm5lBGu/SPYaFLyQANY0Qq+hleFbd423qhfQujuDceTu+YVdWpZK5CBSHAt5/qYAIVL9Qt2UcI+18in9Ks/bQadmZwCSzahNqt7PVDfZgoQANngE0cx42ypQfs/kCgZ9O7FK6msEYCvhF9zelNZVKHv/PAk8lz4y5J2Gm4U6PowBqvFmq/SWPMzSAw1kWkjPptk0QKwIsXquHQjTAmUOLbkKFHWOZEKKmOyOGM7230Eo/UIbCK7FU6fcqJfG481pmxNsXtaSZ0UiWf0qytIxq1SevxAGkfxWr0MaCiKqfFaXbPSm7W+JK6Wyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0YYPJu6k4nLFfF0Qw5mV8lnqTq7o+IquhdNTnDx150=;
 b=O0ls0hLcxjXPUFzegLOnaHycbQvG6ecSUhhzuX2n6i83k3QY98vwXkKE4TLGr1XWFM5gS2WQwsAXQe4C+RgYC2v0nfMJIZrgLPuMQm76gdPUAlfLr/L89qUc452qpg7Oh2RebUUAoynUolfOTQPN5U0y0WT04v3JgQdaA/DZSpE=
Received: from DB9PR02CA0018.eurprd02.prod.outlook.com (2603:10a6:10:1d9::23)
 by DB7PR01MB4377.eurprd01.prod.exchangelabs.com (2603:10a6:5:3a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 15:19:46 +0000
Received: from DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::3f) by DB9PR02CA0018.outlook.office365.com
 (2603:10a6:10:1d9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 15:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=asem.it;
Received-SPF: PermError (protection.outlook.com: domain of asem.it used an
 invalid SPF mechanism)
Received: from asas054.asem.intra (151.1.184.193) by
 DB5EUR01FT060.mail.protection.outlook.com (10.152.5.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 15:19:46 +0000
Received: from flavio-x.asem.intra ([172.16.17.208]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.0);
         Tue, 28 Sep 2021 17:18:51 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 3/4] dmaengine: imx-sdma: align statement to open parenthesis
Date:   Tue, 28 Sep 2021 17:18:32 +0200
Message-Id: <20210928151833.589843-3-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210928151833.589843-1-f.suligoi@asem.it>
References: <20210928151833.589843-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Sep 2021 15:18:51.0001 (UTC) FILETIME=[24612690:01D7B47C]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ff194abb-063e-44ac-51ab-08d9829367f4
X-MS-TrafficTypeDiagnostic: DB7PR01MB4377:
X-Microsoft-Antispam-PRVS: <DB7PR01MB4377A9E91EF8A078A450BBB3F9A89@DB7PR01MB4377.eurprd01.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5L6v9InZ5/0kvTxTh+hwCE7Qm34gEIeWVvoT5GCLpmmlVtS/2T/xRYExaJDAh4uYKvj8HAGkwcP30r2tDCQe7wjsRkemUp4yOYaM32H2xKOdZ8KZgD8wmqTO1GqwiOhKIdjAUV3NW9pZGfWjo+YCK8AMAdOojd7AE6zYOQ1gCaAUPSidjcj3V2cpybptDIphLM8hqZOge+I9IBs1fD8fc+YnnfteM5I38WDVClL7laVWHAfcXn+gLo+MkFf5QtrMgXkAjnbket9jVSZJs6X8cLt5a4E7LITW4HiODi6wn7wEJiU6MCJpj9ZHWgNywvSbTkohzfpehaG6P3fhMIVtnyJCMKNL1yc+JeS3subKS0a7d/MkcRQBI0D/38c29MrWCyUEyt8JxrABP0Df5XOcJfn3Qn0NH0pd0d+2oxIaGC3Ql36INH1ojBnBBHNMdfB828VBB+xpWlr1jvDlGJehJUptkDjZYzKXa8lQ2lF70mP412ysgGmo1L6OuXTrz81YS2IfVFeI6s1yk5wTl5m+26p9PkPRRyhBj0FnSHCctCgI8FkII1zUeF7MEXhvqFAPhymHiH14AYTTjw7f6PGCBhuyaA1OGfgMuToWAHpvILgBoC2XedJYZyYiVv4PSQGmYQldm05RFztDOhPRXJiCFKI2Fju9gPKs9JhvEYcVSdEKmXjc162vmz3gRooS5yTybT6grDO36cM9+Xqh/9Y29gWO1j8zTII/3z8+gDVG0Kg=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(36840700001)(46966006)(336012)(2616005)(186003)(8936002)(26005)(47076005)(2906002)(36756003)(83380400001)(6666004)(36860700001)(4326008)(81166007)(54906003)(508600001)(450100002)(316002)(70206006)(70586007)(82310400003)(356005)(5660300002)(107886003)(1076003)(8676002)(110136005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 15:19:46.4194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff194abb-063e-44ac-51ab-08d9829367f4
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR01MB4377
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Alignment should match open parenthesis.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/dma/imx-sdma.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 726076683400..7b3bd3608651 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1241,7 +1241,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 }
 
 static int sdma_set_channel_priority(struct sdma_channel *sdmac,
-		unsigned int priority)
+				     unsigned int priority)
 {
 	struct sdma_engine *sdma = sdmac->sdma;
 	int channel = sdmac->channel;
@@ -1261,7 +1261,7 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
 	int ret = -EBUSY;
 
 	sdma->bd0 = dma_alloc_coherent(sdma->dev, PAGE_SIZE, &sdma->bd0_phys,
-					GFP_NOWAIT);
+				       GFP_NOWAIT);
 	if (!sdma->bd0) {
 		ret = -ENOMEM;
 		goto out;
@@ -1284,7 +1284,7 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 	int ret = 0;
 
 	desc->bd = dma_alloc_coherent(desc->sdmac->sdma->dev, bd_size,
-				       &desc->bd_phys, GFP_NOWAIT);
+				      &desc->bd_phys, GFP_NOWAIT);
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
@@ -1757,7 +1757,7 @@ static void sdma_issue_pending(struct dma_chan *chan)
 #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
 
 static void sdma_add_scripts(struct sdma_engine *sdma,
-		const struct sdma_script_start_addrs *addr)
+			     const struct sdma_script_start_addrs *addr)
 {
 	s32 *addr_arr = (u32 *)addr;
 	s32 *saddr_arr = (u32 *)sdma->script_addrs;
@@ -1840,8 +1840,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 	clk_enable(sdma->clk_ahb);
 	/* download the RAM image for SDMA */
 	sdma_load_script(sdma, ram_code,
-			header->ram_code_size,
-			addr->ram_code_start_addr);
+			 header->ram_code_size,
+			 addr->ram_code_start_addr);
 	clk_disable(sdma->clk_ipg);
 	clk_disable(sdma->clk_ahb);
 
@@ -1850,8 +1850,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
 	sdma->fw_loaded = true;
 
 	dev_info(sdma->dev, "loaded firmware %d.%d\n",
-			header->version_major,
-			header->version_minor);
+		 header->version_major,
+		 header->version_minor);
 
 err_firmware:
 	release_firmware(fw);
-- 
2.25.1

