Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15443907B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhJYHmf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 03:42:35 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:45947 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJYHmf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Oct 2021 03:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635147613; x=1666683613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NSqowQVDiJxwRL5modbxvpdelUWTtieJAuCRc83AKN0=;
  b=aD0WWi/d0LTTt+wB1F3lMw8t4xtx8CVp0lroqg182PE61E10ap8jnfft
   mXKsM01RrAUvz2re/KeHA5Yb0m4BMCnxUtvsU46NjqxtoMyTp9OVXKzG6
   id2GlJ8MXXoCditEIycs1osB6bNiy9ybCD84gnHZRE9tEuMBPEVt/Cfvd
   0ENM9M8CBJqBFmELF+DBJbr9mxQuVhNNjU9Hn2g1cgLjPID09R5c8k/yL
   CV8l0bg9Vra78udGx6Fg+dE5hI/7IZNTKCquFFufYA/MJDTn9/PGpeLSI
   DKD4imYhSRtaQmSIJ/4Y9WUEikQcdxf6Srs6bmHahQrEKRdPs3DzD0A12
   g==;
IronPort-SDR: ggKVEtS4xyXw+nVxEw7loM1xOMfa9edDv6YCUl5Wj5hiEHKHiNSVOP419/DJHc+PNl5gjDyWat
 RJREPzbjMTDvmlMbkY7TT4UiwFSfyg4kKJ4mq934dANgsAva5sXwu4jXaUUjX8/uJxlvC2MWdg
 Y4rzXeeIH/7+wlHLezpXtgy6Y2NPOvoQQk02a+F9txSwqaa+u7gwWPJ77YEsqa1MHXBRANm8WW
 cAiYsG+harWyBZPQIMOeOUgWBsqke2mRv9QD2DhfU69Afut9icil4qrXCgejTeeODQXJfL/3jX
 6mQD5v94V0Fi2B137DyHSygo
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="74141363"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2021 00:40:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 00:40:12 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 00:40:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH] dmaengine: at_xdmac: fix compilation warning
Date:   Mon, 25 Oct 2021 10:40:02 +0300
Message-ID: <20211025074002.722504-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixed "unused variable 'atmel_xdmac_dev_pm_ops'" compilation warning
when CONFIG_PM is not defined.

Fixes: 8e0c7e486014 ("dmaengine: at_xdmac: use pm_ptr()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7fb19bd18ac3..f5d053df66a5 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2207,7 +2207,7 @@ static int at_xdmac_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct dev_pm_ops atmel_xdmac_dev_pm_ops = {
+static const struct dev_pm_ops __maybe_unused atmel_xdmac_dev_pm_ops = {
 	.prepare	= atmel_xdmac_prepare,
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(atmel_xdmac_suspend, atmel_xdmac_resume)
 };
-- 
2.33.0

