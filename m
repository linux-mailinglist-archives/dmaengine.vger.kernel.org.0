Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74928243B4F
	for <lists+dmaengine@lfdr.de>; Thu, 13 Aug 2020 16:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMOOS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Aug 2020 10:14:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:46518 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbgHMOOR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Aug 2020 10:14:17 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 76537407D3;
        Thu, 13 Aug 2020 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597328057; bh=3ZoFDBZoy1WPRgiq3Qv5G/hJxOHGa4k18XmRC4w/CaA=;
        h=From:To:Cc:Subject:Date:From;
        b=FzpftSM9WmljqBDBTOEkQrgkx6jR7V8aWfahOki8sN7FPrHj3jtY+fXpgQz/9mP+o
         WmNBe9ya8FUtAtGKXM2cjXzpTehqnFL2XOIMHfynu7mOeU2P1uUUAV8C3F6pDWZn0c
         BQm8SjxyG/Ssnv6Okx6RhIHyoeEA2qptoF58gSDPlxcTTi4Xs8yOD95eDOgVMtrNzZ
         VWsd6pr41I1He2lMOQhNSlP3Leo2AFXbmHSaCJca5THL1mp1nMH1Plqk/LO84DLS2A
         ap2t9BH7cYD2K9/mkayo6HR4wI2h1nLkIZxBRPbkjDs+Rx3p0DvxVSoEeUavPHi+t4
         y3mOH1RdaOw0g==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2DB18A005A;
        Thu, 13 Aug 2020 14:14:16 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: [PATCH] dmaengine: dw-edma: Fix typo in comments offset
Date:   Thu, 13 Aug 2020 16:14:14 +0200
Message-Id: <d7c7e56a83a13a62438a6c1a23863015a3760581.1597327654.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix typo in comments offset related to padding bytes.

Cc: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-v0-regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-regs.h b/drivers/dma/dw-edma/dw-edma-v0-regs.h
index cd64768..dfd70e2 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-regs.h
@@ -40,7 +40,7 @@ struct dw_edma_v0_ch {
 	struct dw_edma_v0_ch_regs wr;			/* 0x200 */
 	u32 padding_1[55];				/* [0x224..0x2fc] */
 	struct dw_edma_v0_ch_regs rd;			/* 0x300 */
-	u32 padding_2[55];				/* [0x224..0x2fc] */
+	u32 padding_2[55];				/* [0x324..0x3fc] */
 };
 
 struct dw_edma_v0_unroll {
-- 
2.7.4

