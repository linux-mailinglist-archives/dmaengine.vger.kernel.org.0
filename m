Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C649E1F67BC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2020 14:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgFKMRt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 11 Jun 2020 08:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgFKMRt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 11 Jun 2020 08:17:49 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32C0320760;
        Thu, 11 Jun 2020 12:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591877868;
        bh=TL+cCvJxcZMcr3rIlEDjazM57ouI9QtmzoB6fKwEDWs=;
        h=From:To:Cc:Subject:Date:From;
        b=McBN7Is8KkDw3Jq+G7qOZe8jTIG5ZeQjw598HNM7gyNmo5KZn5Zgcad1TovUuDtTi
         q6+5TNzob39RQvnvWqc/eloLWybEyPjzxg/MFOjsdC27uNqaHfqzPq43pFbqnfqKKV
         5rfd+dSdnnWsuKBz6ijGHR9sQpT8VgntdnGLbRC4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>, Peng Ma <peng.ma@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] dmaengine: fsl-edma: Add lockdep assert for exported function
Date:   Thu, 11 Jun 2020 14:17:40 +0200
Message-Id: <1591877861-28156-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add lockdep assert for an exported function expected to be called under
spin lock.  Since this function is called in different modules, the
lockdep assert will be self-documenting note about need for locking.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/fsl-edma-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 5697c3622699..4550818cca4a 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -589,6 +589,8 @@ void fsl_edma_xfer_desc(struct fsl_edma_chan *fsl_chan)
 {
 	struct virt_dma_desc *vdesc;
 
+	lockdep_assert_held(&fsl_chan->vchan.lock);
+
 	vdesc = vchan_next_desc(&fsl_chan->vchan);
 	if (!vdesc)
 		return;
-- 
2.7.4

