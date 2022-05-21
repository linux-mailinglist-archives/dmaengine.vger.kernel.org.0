Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8B52FB5F
	for <lists+dmaengine@lfdr.de>; Sat, 21 May 2022 13:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354989AbiEULN7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 May 2022 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354898AbiEULMt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 May 2022 07:12:49 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C184F9C2;
        Sat, 21 May 2022 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gzpQJI/4l4hMaFVZeeSTL4mFsKH6STSl0UKXBUWewJE=;
  b=oHGj8diLmpgthet+7zwIdUD8xrcky8GS0VRlcE0kb53O5GiQ/+221HBv
   iyVAXhfwlnF3NZBo1UwYBsxHjWHzDwH4feJUCYDqA9aSrKOA23MWRtdCY
   hvivKaSc+X4Ln2ilomXm0Ik7/LFyufqnzXXvzA/d0nF+NdclN/hKuAzqX
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727967"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:03 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Andy Gross <agross@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: qcom: fix typo in comment
Date:   Sat, 21 May 2022 13:11:12 +0200
Message-Id: <20220521111145.81697-62-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 include/linux/dma/qcom-gpi-dma.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
index f46dc3372f11..6680dd1a43c6 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -26,7 +26,7 @@ enum spi_transfer_cmd {
  * @clk_div: source clock divider
  * @clk_src: serial clock
  * @cmd: spi cmd
- * @fragmentation: keep CS assserted at end of sequence
+ * @fragmentation: keep CS asserted at end of sequence
  * @cs: chip select toggle
  * @set_config: set peripheral config
  * @rx_len: receive length for buffer

