Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60242ACDE4
	for <lists+dmaengine@lfdr.de>; Tue, 10 Nov 2020 05:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbgKJEGS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 23:06:18 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:49383 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731366AbgKJEGR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 9 Nov 2020 23:06:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7611352|0.8967155;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.0234519-0.000501654-0.976046;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=28;RT=28;SR=0;TI=SMTPD_---.IulFdj5_1604981159;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IulFdj5_1604981159)
          by smtp.aliyun-inc.com(10.147.42.135);
          Tue, 10 Nov 2020 12:06:10 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, ulf.hansson@linaro.org, kishon@ti.com,
        wim@linux-watchdog.org, linux@roeck-us.net,
        dan.j.williams@intel.com, linus.walleij@linaro.org,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        marex@denx.de, colin.king@canonical.com, rdunlap@infradead.org,
        krzk@kernel.org, gregkh@linuxfoundation.org, megous@megous.com,
        rikard.falkeborn@gmail.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
        tiny.windzz@gmail.com
Cc:     Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 01/19] pinctrl: sunxi: fix irq bank map for the Allwinner A100 pin controller
Date:   Tue, 10 Nov 2020 12:05:35 +0800
Message-Id: <20201110040553.1381-2-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110040553.1381-1-frank@allwinnertech.com>
References: <20201110040553.1381-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

A100's pin starts with PB, so it should start with 1.

Fixes: 473436e7647d6 ("pinctrl: sunxi: add support for the Allwinner A100 pin controller")
Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
index 19cfd1e76ee2..e69f6da40dc0 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
@@ -677,7 +677,7 @@ static const struct sunxi_desc_pin a100_pins[] = {
 		  SUNXI_FUNCTION_IRQ_BANK(0x6, 6, 19)),
 };
 
-static const unsigned int a100_irq_bank_map[] = { 0, 1, 2, 3, 4, 5, 6};
+static const unsigned int a100_irq_bank_map[] = { 1, 2, 3, 4, 5, 6, 7};
 
 static const struct sunxi_pinctrl_desc a100_pinctrl_data = {
 	.pins = a100_pins,
-- 
2.28.0

