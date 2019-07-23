Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C7B71627
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2019 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbfGWKf6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Jul 2019 06:35:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45561 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbfGWKf6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Jul 2019 06:35:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so19210427pgp.12;
        Tue, 23 Jul 2019 03:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0k274Ite0iMERdUs3CaRT2A3qlgOURGFE1j4THtpIA=;
        b=XGS1cEqOFmDtAzum9ByWu6rMRd+1Yg/yPTxw/WhFF4CQa6TxMxhXxrCZdzM7kYEdbv
         aGlRkSqR2VJ1nUa8tNg1iFQv6BhA3MDSst/dTnoh5HXeHFSNLAZ8K23eLub4EOq5bmoY
         /Y1/4uzKmGN0HPQAol1zo1Nfq4NaVqjozUNRCbaSxpklCZ/FezxYwn02PWn+qww5Ul65
         6qcIv7bBP9Pg6GEhQnvyFoBkDNg8J+c12nkUGKwLNMWvebBXT7QD/skEogzH6VgrZ1Ee
         XH5B9a4BhFnA7M2Nyzr7lYnsW/HqCmX6rBtlGuwb5rPgsNbCmZ2Il27Oapz0oUjSycQH
         7MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0k274Ite0iMERdUs3CaRT2A3qlgOURGFE1j4THtpIA=;
        b=poBTfxqfPeb1GbR0DbVeFU0N3z/YxLiG5U0oDPzehSHYgUdNlsuF32wmLxVfIAjACn
         hEvrYPBuG9gfa3EfKXByhQV/OhoBkjtPe8k7lEqm5VNxh1nXUo8bpo/P9i70gYmxw+ib
         L3qZv4IyLpntNMMNHtxo/l+c9SQrvTaaIFH0l9crRTgf7STzbfU8/0n/yigLq63qxclQ
         qseREMJZmFZP/X7sR0z/PV61cHPnblxm9Loe6QRI2ZrZc7Ykg7677LfEuwknaskPHRHq
         aDcLuMhY0tSJ2th2qnqV6NBeDogJ+7GVQCduFHCtnPADguhwZ4qn2MT8mgJmJLKT6EZL
         EVJQ==
X-Gm-Message-State: APjAAAXeVrMdp1nYb/+SKy2/Ii08Z78HDq9vk5ND2osZnWcyLmHxttIQ
        4yG8F1t7NJU2hzPzm5qhB1E=
X-Google-Smtp-Source: APXvYqwG3PzdUpTNEhKJKBKQ/nOL0xQw8O03OCR+9tEU4Ozf3dnrfvqxaziOQfWtEOcLagYEQL+z4w==
X-Received: by 2002:a63:1765:: with SMTP id 37mr6921267pgx.447.1563878157756;
        Tue, 23 Jul 2019 03:35:57 -0700 (PDT)
Received: from localhost.localdomain ([122.163.0.39])
        by smtp.gmail.com with ESMTPSA id h129sm40022315pfb.110.2019.07.23.03.35.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 03:35:57 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     okaya@kernel.org, agross@kernel.org, vkoul@kernel.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] dma: qcom: hidma_mgmt: Add of_node_put() before goto
Date:   Tue, 23 Jul 2019 16:05:43 +0530
Message-Id: <20190723103543.7888-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a goto from the middle of the loop, there is
no put, thus causing a memory leak. Add an of_node_put before the
goto in 4 places.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/dma/qcom/hidma_mgmt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 3022d66e7a33..209adc6ceabe 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -362,16 +362,22 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
 		struct platform_device *new_pdev;
 
 		ret = of_address_to_resource(child, 0, &res[0]);
-		if (!ret)
+		if (!ret) {
+			of_node_put(child);
 			goto out;
+		}
 
 		ret = of_address_to_resource(child, 1, &res[1]);
-		if (!ret)
+		if (!ret) {
+			of_node_put(child);
 			goto out;
+		}
 
 		ret = of_irq_to_resource(child, 0, &res[2]);
-		if (ret <= 0)
+		if (ret <= 0) {
+			of_node_put(child);
 			goto out;
+		}
 
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 		pdevinfo.fwnode = &child->fwnode;
@@ -386,6 +392,7 @@ static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
 		new_pdev = platform_device_register_full(&pdevinfo);
 		if (IS_ERR(new_pdev)) {
 			ret = PTR_ERR(new_pdev);
+			of_node_put(child);
 			goto out;
 		}
 		of_node_get(child);
-- 
2.19.1

