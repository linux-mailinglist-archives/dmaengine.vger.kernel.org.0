Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383DF1AE514
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 20:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgDQSst (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbgDQSss (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Apr 2020 14:48:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C726C061A0C
        for <dmaengine@vger.kernel.org>; Fri, 17 Apr 2020 11:48:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o15so960283pgi.1
        for <dmaengine@vger.kernel.org>; Fri, 17 Apr 2020 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/m8uFUPGMTXPG6uE9UPBDXEGsmlpHvFfRMPeQIRglr0=;
        b=m55vm8qpsWewOdjKtNV9pAA/o9+H6/LdDotUxWcE6LTAdjTMH4J3LNhBIZ6wWCKmNo
         99GRImy6d5PLzuLZIH/aZlDXNr4DtUD48apChLpnvfxnpETe7l3oPQ/WtRQkVvRbdfSu
         skGOb/Tf+DAYWM4gntE5s80z0Yp0jHTWnqeG1ydjvMReWaJpGPGN3j/d1iPXF1Hn5uan
         M2t5AhwXcWJNEYNQJATDZ8rLCSC+jlt2B2QpqBzhNwiOer5QagoHIXeHh6Argt7eoU4j
         kU5xp6C9bqgXqa0hoED9I6CRFHE+bbrN49TWBqh14XXShfG5joisVXURuPXDedM/kDU7
         Npqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/m8uFUPGMTXPG6uE9UPBDXEGsmlpHvFfRMPeQIRglr0=;
        b=umyGGAVE7kDDO1yRxI37Ruztc4dp/o2q/VCykx543qmTsu8OLDf0NBLVmq7E826w21
         HKCDg3m3ntbnTv5YEMsk9IJDA28CtVfUnDoR1JHwl79F7dEjKOhmT9ydcfh3NjWlKUtI
         cwc1BSoZxRq0t4QE22RuWRlAFSjztpUYkANxMndohNjdJBj5MgpxKrsitZ7OLUOSOopn
         LPO//qBqsVbsOPONABKVqHw+h6YD6VS2zlRPyV3UhhJAa7GhNCoB7OcA1WBminh4Avgz
         xsdQ7OzHefZaofrV/9mz4Y+WgTNKFUFtjadqSDuHTu/SipoVQLSslYWa9VfP0ahIA/w0
         Iirg==
X-Gm-Message-State: AGi0PuZsjTD4OnbbjA2GB/lVETuJi/lPNIoLdXoq+hB09Eko/mEmQpPX
        uLvlivN62L/tLKJignV0fViUzw==
X-Google-Smtp-Source: APiQypJVSsNxOrC49Bt1KeprvKNWUF/fOBKhWHYpgHUpDM7iS/wLjotWqC0uiFeh2vhCtRy4gCIUgQ==
X-Received: by 2002:aa7:9207:: with SMTP id 7mr4521820pfo.178.1587149327949;
        Fri, 17 Apr 2020 11:48:47 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id l185sm18924449pfl.104.2020.04.17.11.48.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 11:48:46 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
        gustavo.pimentel@synopsys.com, kishon@ti.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] genirq/msi: Check null pointer before copying struct msi_msg
Date:   Fri, 17 Apr 2020 11:48:42 -0700
Message-Id: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify __get_cached_msi_msg() to check both pointers for null before
copying the contents from the struct msi_msg pointer to the pointer
provided by caller.

Without this sanity check, __get_cached_msi_msg() crashes when invoked by
dw_edma_irq_request() in drivers/dma/dw-edma/dw-edma-core.c running on a
Linux-based PCIe endpoint device. MSI interrupt are not received by PCIe
endpoint devices. As a result, irq_get_msi_desc() returns null since there
are no cached struct msi_msg entry on the endpoint side.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 kernel/irq/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index eb95f6106a1e..f39d42ef0d50 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -58,7 +58,8 @@ void free_msi_entry(struct msi_desc *entry)
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
-	*msg = entry->msg;
+	if (entry && msg)
+		*msg = entry->msg;
 }
 
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
-- 
2.7.4

