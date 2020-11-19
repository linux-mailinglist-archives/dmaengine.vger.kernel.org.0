Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511E82B9EC8
	for <lists+dmaengine@lfdr.de>; Fri, 20 Nov 2020 00:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgKSX4Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 Nov 2020 18:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgKSX4X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 Nov 2020 18:56:23 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC0C0617A7;
        Thu, 19 Nov 2020 15:56:23 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so10429728ejj.5;
        Thu, 19 Nov 2020 15:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5G5PNNBSIOn3Ht2O5Cjcr0nK/LDVaoYIIfZVUPTtQD0=;
        b=fKgmo6jDyqz684JA0+bM1fbz+wZL1j2FP4MMjSh59e8RdtcPm2mDCIgEPcVzUnfiYt
         N4crmBrB5zX7XgKf1V2OKTfuMT1wm/i/UmYqmy7qNPsT7gcUdmWzNGGEXaUIMysC2tiN
         t23Dehk0du4M31DYvXnjOenfs4bQSZaamU/Tqp7PFYOZwUgbZ8vHnZ5bgF9kZ3zESVwE
         EHaUUflnWELjVDzlG2rfnsnXIXBN1W4gq6lVULrMlqjqiUzqCym2BT3eQ5XY09S6yt3h
         MLPtb70AzGafgHRxHivXQnF9SvQTcBGM8BKSuqQqfBsx5HJyP7IZDdblEd9kDW9s31lE
         SFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5G5PNNBSIOn3Ht2O5Cjcr0nK/LDVaoYIIfZVUPTtQD0=;
        b=eSgA+/bUL7wxdgMy4a78LHL/g7PnchhtKkyxrAk0EYPqnV7VcN48Jwt3Q9aGIjR7Jb
         pMNJl1WYXKEQr6QysV+g9GetLZQxaEeVWv9pmAsd/ve8bID3d0CWlIvmYCK5l5LF8acE
         Cgqo7J6DchxA5GKAOjxuQC0UR12CO8l/ersrc8ZCZXYUOHjy6LN98FN8YWX88bVu5TsI
         C//q2sepGkFgPJq6euzmmaraG62HCm0SI4MSxO3X9Ob2CkQkPBUAU4yDD4Pv7WePGAql
         BSNcof4ZOzBXn2ylBhhhR5gb7gJlKOO7V0NNQL10wuqCVJCNnYEdRT8vWTiCLTHjCEu8
         U4MA==
X-Gm-Message-State: AOAM532Yg9iQR4xjkvEw8tC2dx+8x6EX/iuJilUuBTqZkRlviOO2TPlw
        yIxVCBM6/BmRZlhSqeRCWi4=
X-Google-Smtp-Source: ABdhPJxAcYe/B6juuhH0GnerzOK1KAJNgAriX7lP+DyY/nPO2Zebqlz+2djvhy+wtSSSsWvWUCuXBQ==
X-Received: by 2002:a17:906:29db:: with SMTP id y27mr26420528eje.179.1605830181834;
        Thu, 19 Nov 2020 15:56:21 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:21 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/18] dmaengine: owl: Add compatible for the Actions Semi S500 DMA controller
Date:   Fri, 20 Nov 2020 01:55:59 +0200
Message-Id: <f2e9f718eb8c7279127086795a4ef5047fc186d5.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The DMA controller present on the Actions Semi S500 SoC is compatible
with the S900 variant, so add it to the list of devices supported by
the Actions Semi Owl DMA driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/dma/owl-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 9fede32641e9..54e509de66e2 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -1082,6 +1082,7 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
 static const struct of_device_id owl_dma_match[] = {
 	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
 	{ .compatible = "actions,s700-dma", .data = (void *)S700_DMA,},
+	{ .compatible = "actions,s500-dma", .data = (void *)S900_DMA,},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, owl_dma_match);
-- 
2.29.2

