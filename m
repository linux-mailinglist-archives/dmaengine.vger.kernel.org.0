Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92A030B7FF
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 07:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhBBGq6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 01:46:58 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43153 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231879AbhBBGq6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Feb 2021 01:46:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UNeTzRk_1612248374;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNeTzRk_1612248374)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 14:46:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        dan.j.williams@intel.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] dmaengine: qcom: remove unneeded semicolon
Date:   Tue,  2 Feb 2021 14:46:13 +0800
Message-Id: <1612248373-43529-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/dma/qcom/gpi.c:1703:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/dma/qcom/gpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 1a0bf6b0..f20b557 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1700,7 +1700,7 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 
 		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
 		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
-	};
+	}
 
 	for (i = 0; i < tre_idx; i++)
 		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
-- 
1.8.3.1

