Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787906AF7E9
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 22:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCGVq0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 16:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCGVqZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 16:46:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21933A80E5;
        Tue,  7 Mar 2023 13:46:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD459B81A43;
        Tue,  7 Mar 2023 21:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F431C433EF;
        Tue,  7 Mar 2023 21:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678225581;
        bh=BbnxntDqA99kiOszDlMPre85ydHf518Ayz0XkxQjDFo=;
        h=From:To:Cc:Subject:Date:From;
        b=UE+zmLdKq54jw+mWa6dLKfc/aTX/RZgoGEVrzrNnCinbPJQjJ9OHVpzyNo7F6GZmd
         5JX83gHwQ2zTGeSqjr/5wM2WInhIikgOg0Rtx346lyRA6vBxJxW/pnysa1mepWVm/W
         jikQG3vc0WhCfFuj3taWaSs+Pp0o/NLBwTefldE1nsvR/QKVqzWGelsJo1USrp2vwm
         sBOu993NHEroFb+PgprcuOcMQ9V8Ipx3H1Mm97cAWc8cfhQsidEpDf8u9yOPUAda/7
         M29uRqUNj9D/Q6teI7HG+rSyCMNyRm4X97/t/w6zVgqHY2U3rQjxRGWV3E3F6ZUmSP
         +cOorshpNQl2g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] dmaengine: ioat: use PCI core macros for PCIe Capability
Date:   Tue,  7 Mar 2023 15:46:15 -0600
Message-Id: <20230307214615.887354-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The PCIe Capability is defined by the PCIe spec, so use the PCI_EXP_DEVCTL
macros defined by the PCI core instead of defining copies in IOAT.  This
makes it easier to find all uses of the PCIe Device Control register.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/dma/ioat/init.c      | 6 +++---
 drivers/dma/ioat/registers.h | 7 -------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 5d707ff63554..fa7c0f9aa61d 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -1191,13 +1191,13 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
 
 	/* disable relaxed ordering */
-	err = pcie_capability_read_word(pdev, IOAT_DEVCTRL_OFFSET, &val16);
+	err = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &val16);
 	if (err)
 		return pcibios_err_to_errno(err);
 
 	/* clear relaxed ordering enable */
-	val16 &= ~IOAT_DEVCTRL_ROE;
-	err = pcie_capability_write_word(pdev, IOAT_DEVCTRL_OFFSET, val16);
+	val16 &= ~PCI_EXP_DEVCTL_RELAX_EN;
+	err = pcie_capability_write_word(pdev, PCI_EXP_DEVCTL, val16);
 	if (err)
 		return pcibios_err_to_errno(err);
 
diff --git a/drivers/dma/ioat/registers.h b/drivers/dma/ioat/registers.h
index f55a5f92f185..54cf0ad39887 100644
--- a/drivers/dma/ioat/registers.h
+++ b/drivers/dma/ioat/registers.h
@@ -14,13 +14,6 @@
 #define IOAT_PCI_CHANERR_INT_OFFSET		0x180
 #define IOAT_PCI_CHANERRMASK_INT_OFFSET		0x184
 
-/* PCIe config registers */
-
-/* EXPCAPID + N */
-#define IOAT_DEVCTRL_OFFSET			0x8
-/* relaxed ordering enable */
-#define IOAT_DEVCTRL_ROE			0x10
-
 /* MMIO Device Registers */
 #define IOAT_CHANCNT_OFFSET			0x00	/*  8-bit */
 
-- 
2.25.1

