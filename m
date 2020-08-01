Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7723023522F
	for <lists+dmaengine@lfdr.de>; Sat,  1 Aug 2020 14:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgHAMYg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Aug 2020 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgHAMYd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Aug 2020 08:24:33 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2CC061756;
        Sat,  1 Aug 2020 05:24:31 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o23so6562832ejr.1;
        Sat, 01 Aug 2020 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4KwHv6QMJMXsH8yaJc8FAm3bwHGuyv+DgGa3tEGDGbc=;
        b=M6ZCfvutD7TU/pOV2RNFZ9MidUceEEom3Nv3cE806feUIRVqBJG/pIaUprqT1xhcje
         WdFRwEFWFMhXxFz9OgdZ1Gkc2To7DRldejROIxZU6c5ReUp9u6fMtabD/bp4nvv/xOZ1
         gEJrQOJUtdKdJ1QlchgC8PcfGkZLKme+Hi3QCWETI9t5oBQZyeKu/wRZdwIN4fw+6/p2
         aP/w5sc4rsYwGAOX8KMKUcMaGtvOVbby2SRPvd52QpVeN1oD1/I8CIBqPGmZsXStVK34
         LWU73hZRIlZwQmIZU0I3USachekVwyf51qlBk3yWeO3Owwoptvz+TI+cen849fVsnjFy
         6R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4KwHv6QMJMXsH8yaJc8FAm3bwHGuyv+DgGa3tEGDGbc=;
        b=YLVC4rbM2SimPmRemE6dbeQ1ES8J8pTZ5TVo9zuqQLNaUp4NChsTrOnOMF8s4ut1Ts
         f6fuSyp+H8WumrXW+4IhXOH0fWZnEO+EWiTDJBJqqlh6e6Zf5F8p8uCny4YZGOPmdUtB
         nshFafUTJYAVzlLyQ2lgxosnZVtlXBl14WINvSruWtKCcX4Pxao8hD92LTL8cXVp11bG
         HQB5al8vjPVxuTE57gXC5o+DEGc/yNWA4Dqy4Rk6VduqvJVYuWo4xsmeiPoSyPqq2xTp
         /8asu7ee8zsqbj/VJjx5iHaTeyog6zgsqWkzjaEgjD/kwcun/GQ+wC5lkYu0FgNiAujQ
         MSBA==
X-Gm-Message-State: AOAM531PcsKvuwmUhQy5ZuZByzCBlEy0+uiaGY3N8w1qh5fmOQnQWmUA
        cjs6UIA+YWA8LjiJdBZ288g=
X-Google-Smtp-Source: ABdhPJyP/Khv/zO4ruS71OwrBP8neVvwznKuE/Wo/7tG658TgIhiZlq1Bl/1qqyQW8Ic4CfQutik3A==
X-Received: by 2002:a17:906:694b:: with SMTP id c11mr8314854ejs.232.1596284670556;
        Sat, 01 Aug 2020 05:24:30 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:30 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [RFC PATCH 05/17] dmaengine: ioat: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:34 +0200
Message-Id: <20200801112446.149549-6-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid
value thus it indicates some kind of error.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/dma/ioat/dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index fd782aee02d9..e51418cf93b6 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -1016,12 +1016,12 @@ int ioat_reset_hw(struct ioatdma_chan *ioat_chan)
 
 	if (ioat_dma->version < IOAT_VER_3_3) {
 		/* clear any pending errors */
-		err = pci_read_config_dword(pdev,
+		pci_read_config_dword(pdev,
 				IOAT_PCI_CHANERR_INT_OFFSET, &chanerr);
-		if (err) {
+		if (chanerr == (u32)~0) {
 			dev_err(&pdev->dev,
 				"channel error register unreachable\n");
-			return err;
+			return -ENODEV;
 		}
 		pci_write_config_dword(pdev,
 				IOAT_PCI_CHANERR_INT_OFFSET, chanerr);
-- 
2.18.4

