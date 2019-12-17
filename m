Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214AB122DD9
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 15:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfLQOAA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Dec 2019 09:00:00 -0500
Received: from out28-53.mail.aliyun.com ([115.124.28.53]:56526 "EHLO
        out28-53.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfLQOAA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Dec 2019 09:00:00 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3617134|-1;CH=green;DM=SPAM|CONTINUE|true|0.912045-0.000889018-0.087066;DS=CONTINUE|ham_system_inform|0.0175439-0.000412785-0.982043;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.GJ3eyQr_1576591147;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GJ3eyQr_1576591147)
          by smtp.aliyun-inc.com(10.147.41.137);
          Tue, 17 Dec 2019 21:59:35 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, paulburton@kernel.org, mark.rutland@arm.com,
        paul@crapouillou.net, vkoul@kernel.org, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 2374286503@qq.com
Subject: [PATCH 2/2] dmaengine: JZ4780: Add support for the X1830.
Date:   Tue, 17 Dec 2019 21:59:00 +0800
Message-Id: <1576591140-125668-4-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1576591140-125668-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for probing the dma-jz4780 driver on the X1830 Soc.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/dma/dma-jz4780.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index fa626ac..f8ee4b7 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -1020,12 +1020,19 @@ static const struct jz4780_dma_soc_data x1000_dma_soc_data = {
 	.flags = JZ_SOC_DATA_PROGRAMMABLE_DMA,
 };
 
+static const struct jz4780_dma_soc_data x1830_dma_soc_data = {
+	.nb_channels = 32,
+	.transfer_ord_max = 7,
+	.flags = JZ_SOC_DATA_PROGRAMMABLE_DMA,
+};
+
 static const struct of_device_id jz4780_dma_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-dma", .data = &jz4740_dma_soc_data },
 	{ .compatible = "ingenic,jz4725b-dma", .data = &jz4725b_dma_soc_data },
 	{ .compatible = "ingenic,jz4770-dma", .data = &jz4770_dma_soc_data },
 	{ .compatible = "ingenic,jz4780-dma", .data = &jz4780_dma_soc_data },
 	{ .compatible = "ingenic,x1000-dma", .data = &x1000_dma_soc_data },
+	{ .compatible = "ingenic,x1830-dma", .data = &x1830_dma_soc_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
-- 
2.7.4

