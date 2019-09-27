Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03C9BFDA4
	for <lists+dmaengine@lfdr.de>; Fri, 27 Sep 2019 05:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfI0DaF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 23:30:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43422 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfI0DaE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Sep 2019 23:30:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so693914pfo.10
        for <dmaengine@vger.kernel.org>; Thu, 26 Sep 2019 20:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3fUQ2wevxoVB9of7yE52sU9E/NILQiAovPtEjfDhHSI=;
        b=O9bMdKw8cO5Q2wlyIDHcAUhYNbgKrh+mR8kF3DArk29wCYuc0N+J3CVrMKS1hjGqJe
         cfx2wihV5CmxVYMWcpBqDg3wYYYnfONcnOthmS2ymzXwjWZb8SC59d8/y02jfFjMdcQI
         rnn4HNNSvgyOXUmy+frN+luqQrpKGYKKeE5v5Hl8PupLPqHcLEUo0Ip1zA6LHsUZlBZ6
         WVi6CTQwmrq+bAld5FeSH/xLRqR96x94t1ZtC7myJz46FcVQeSkDafn0HYQa958B5Mx6
         bcFSjDnsCEWadfn4yEtZdp90b/PG0WDBCN6SiwN3OHMcR+UZifTjMohaIFMt09hCMF8i
         hWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3fUQ2wevxoVB9of7yE52sU9E/NILQiAovPtEjfDhHSI=;
        b=pZeRf75eZ0kGOK1YRtIIuuyXS4BcgluNob4uDqi72nA0LX5xd6+M5p9EgApSTRHQCU
         9Oe1/OF0lr6Pi3jvOmDG+eQp03+3gY5Ra0LiCNNm5dI7EzGOePTRcS2udReCbYETSyzA
         gsEaj/EHfV19Nofmp68bOKNwbpcsPpJ9FKw6GieFTNqD5J+/u6TTe37K8VKiEQmyBb/c
         2P0NtOT0jgg6Mh+uADVkryhpk+OarXRWrdTLwxGGEH7YblCwORjnlpt9MMMBxpKeTYgS
         FoFyqdSUQnJZNfWtMZ3zHymJtFohEp40r1Ul4/qUKfnGWAJAp8BfFKUbU1ErPHwWcWv8
         0dlw==
X-Gm-Message-State: APjAAAUiZfk0GlMfypy+qs6vOGIPGyZTT7hW/txcBGOtQrdYN0peCQMf
        8wv0lwvucDV0oEZW2ZIASVTyzQ==
X-Google-Smtp-Source: APXvYqxKLdRaPcT++pt/WrvbpfM7lnJxg+XwLfQhQzjCfkYtKVCt8f0XzxpgGcR03nk93tHTblJRfA==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr6916116pgj.276.1569555003985;
        Thu, 26 Sep 2019 20:30:03 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a11sm674857pfo.165.2019.09.26.20.30.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Sep 2019 20:30:03 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH] dmaengine: sprd: Change to use devm_platform_ioremap_resource()
Date:   Fri, 27 Sep 2019 11:29:43 +0800
Message-Id: <1af3efdac3b217203cace090c8947386854c0144.1569554639.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index a4a91f2..60d2c6b 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1065,7 +1065,6 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct sprd_dma_dev *sdev;
 	struct sprd_dma_chn *dma_chn;
-	struct resource *res;
 	u32 chn_count;
 	int ret, i;
 
@@ -1111,8 +1110,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "no interrupts for the dma controller\n");
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sdev->glb_base = devm_ioremap_resource(&pdev->dev, res);
+	sdev->glb_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sdev->glb_base))
 		return PTR_ERR(sdev->glb_base);
 
-- 
1.7.9.5

