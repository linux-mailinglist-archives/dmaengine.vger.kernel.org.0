Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199A831B081
	for <lists+dmaengine@lfdr.de>; Sun, 14 Feb 2021 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhBNNWy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 14 Feb 2021 08:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBNNWm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 14 Feb 2021 08:22:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4FC061756;
        Sun, 14 Feb 2021 05:22:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id a9so121910plh.8;
        Sun, 14 Feb 2021 05:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZJUJP+0hpUhBOkgWzlt6vUfmAhDNyiWOxNF8b84Yuc=;
        b=JEzm+lip1D2t1SGhmjncnQWIxOb016Bc8pykqgXo7/pU4i8ppu2b8RXyIGfNLH0NbQ
         nK4T4RTvyBjRVpYcN/jp9ZumtZRIsJwcXYWEio6Qlmzv3b8N2HcqvirOyqHx430DUTdA
         Xui/NzhA3Dhqnzt6XRXR01TXmFcRcnjJqme0yejlIQEaacMZAHP/n0sHrGSJ7uyTeoab
         YrvdS6lbExls8tkoLw9QSenkPB4zMQXHCEznty2GiJ19rQpxb4c9rlvY+9spcBgR98AF
         ctB6/omn0qCMmNpK9A7OC5w4q53tmYn7GEbMunuDFqAKvK2iAoeI+J/di5e1o9FNIaBD
         6kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZJUJP+0hpUhBOkgWzlt6vUfmAhDNyiWOxNF8b84Yuc=;
        b=lpS1oqfvuqVmzAdG1vrmwma3EAxFEPNaY9bkCkNUYxpIz7I5yRpcd5xWGWy9AjDI1D
         /NRCj/3EbBlp4Ir5JRNXQol+OOqIOKQvSUvjcOoC2OG1LVVe8dK8yOKaItdNYW87Wxyu
         dbwZjCdILwc1yWruDiYt6r4jz92TVkJbj2fRZNeTrNKy/c0cxwCsVzxLRE2+xJ+NvYGr
         6QOf2yvn35D7Bo/gSlKJ/C6r2dmg/OD+MuKV3NFHdQggjSzt/HZBWjmDFTcG39YoxjC5
         9kbfOXM4A45/7ZG0MJHJFn7qifeOetXenk7CW0B0EZV8KVntXS7AfHuz6vpUc8Pv6/PB
         u+1g==
X-Gm-Message-State: AOAM532fS54E6v0Jk3Xeu2qtuLwflx9X2qjdKiPPzaRNVY0CMU2BpXMM
        UHUu4EobBe4q3KTOkng+E0k=
X-Google-Smtp-Source: ABdhPJzN5GwurHS6BvKw2Ss0zpRNXZtLS72WGscvf1YWuYWiVYGBMKE2lzDst3xw9xnVBZGnWL3Avw==
X-Received: by 2002:a17:90a:e292:: with SMTP id d18mr11509996pjz.66.1613308920838;
        Sun, 14 Feb 2021 05:22:00 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id q126sm14816129pfb.111.2021.02.14.05.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 05:22:00 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gustavo.pimentel@synopsys.com, vkoul@kernel.org,
        wangzhou1@hisilicon.com, ftoth@exalondelft.nl,
        andy.shevchenko@gmail.com, qiuzhenfa@hisilicon.com,
        dmaengine@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH 1/3] dmaengine: hsu: Add missing call to 'pci_free_irq_vectors()' in probe and remove functions
Date:   Sun, 14 Feb 2021 21:21:51 +0800
Message-Id: <20210214132153.575350-2-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210214132153.575350-1-zhengdejin5@gmail.com>
References: <20210214132153.575350-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Call to 'pci_free_irq_vectors()' are missing both in the error handling
path of the probe function, and in the remove function.
Add them.

Fixes: e9bb8a9df316a2 ("dmaengine: hsu: pci: switch to new API for IRQ allocation")
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/dma/hsu/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 9045a6f7f589..b335e2ef795b 100644
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -89,7 +89,7 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ret = hsu_dma_probe(chip);
 	if (ret)
-		return ret;
+		goto err_irq_vectors;
 
 	ret = request_irq(chip->irq, hsu_pci_irq, 0, "hsu_dma_pci", chip);
 	if (ret)
@@ -112,6 +112,8 @@ static int hsu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_register_irq:
 	hsu_dma_remove(chip);
+err_irq_vectors:
+	pci_free_irq_vectors(pdev);
 	return ret;
 }
 
@@ -121,6 +123,7 @@ static void hsu_pci_remove(struct pci_dev *pdev)
 
 	free_irq(chip->irq, chip);
 	hsu_dma_remove(chip);
+	pci_free_irq_vectors(pdev);
 }
 
 static const struct pci_device_id hsu_pci_id_table[] = {
-- 
2.25.0

