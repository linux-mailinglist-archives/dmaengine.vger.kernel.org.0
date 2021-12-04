Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6699468535
	for <lists+dmaengine@lfdr.de>; Sat,  4 Dec 2021 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355115AbhLDOEE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 Dec 2021 09:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbhLDOED (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 4 Dec 2021 09:04:03 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E066C061751;
        Sat,  4 Dec 2021 06:00:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d9so12049977wrw.4;
        Sat, 04 Dec 2021 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRydfW5dCvLP5M5W9G1L390OMoiuU4elPL4v0ocR8GI=;
        b=KfBlGlO8ievFtXcZ7gIBb6tFFJy1t6XUKHG/+LBpAlwkhYzMt4QygssKPV4cSEp9wr
         l8v7mvBYvpnvaoybP7iEBDWWBLj88MUDWtLVwWwcQ7bogU9kgBUFI+blguQoahyTJdwg
         74Gf23L4aIFOZuTq/B+31fc5qrMC4ihUcVyeuE/krOPX/sNL4KgOw1+Dy2+jbc3ejX9W
         ogG1Pj0IrNllvaQB8qIU71LDG/R5LJUxrM3yy7eSbTDwOfk6v3qzNT1X6hgSyftXnqDt
         uqwFaxyaHDbfstTuvUmfoAuxpljnwINbegY+dUs/3NQq5sdMdYBF7MhdfyWTzHX8G7Wm
         Yllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jRydfW5dCvLP5M5W9G1L390OMoiuU4elPL4v0ocR8GI=;
        b=dPi0eVa/6SxE7ztlDmfgLPkj/sRwQv22UBuRSe5+XZb2xl0GTjhkUydTz8lRYq0zFJ
         stlqLhLeoIdWW2Ynl47kKVhXnmz5X/kUm6nI/UebsIMr8ZSYNrZ1FfyoU4wmCmztoy4O
         XkWZth8s+21OD6U/+7bnrvqNr1mILcatCEvI274DqBU66Om4XAcyrQkJZCYS6Ri/hLX3
         KTOUTbdfiXUOwijIoyIUJ6b2tIqpE2+RSuXk2DSHuvmZYZ1vo7Twx/ywwtmfEFje6s91
         1HzAop9W1iiQB8fDchRIfNA004bbQkrS1x4pbCZTo1KK4kdWNiN2DbM5a+y4/1y3hpKD
         Kq0w==
X-Gm-Message-State: AOAM531G/p9xSbe4T08N5o/Yg0nSwSXlxGRE5O5CvEMmhap1glwrP0jE
        bOG0c8hT8dUNu1mvVleXJA4=
X-Google-Smtp-Source: ABdhPJyp7Kwzh+WrHOuorXsYydzGifWlvVI1GsnYoZkSBQZorTbVIt+cVUlpC6Lv0Xx65iNRHim+7g==
X-Received: by 2002:a05:6000:15c1:: with SMTP id y1mr31001064wry.63.1638626434368;
        Sat, 04 Dec 2021 06:00:34 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i7sm5593646wro.58.2021.12.04.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:00:33 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: stm32-mdma: Remove redundant initialization of pointer hwdesc
Date:   Sat,  4 Dec 2021 14:00:32 +0000
Message-Id: <20211204140032.548066-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The pointer hwdesc is being initialized with a value that is never
read, it is being updated later in a for-loop. The assignment is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dma/stm32-mdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index d30a4a28d3bf..805a449ff301 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1279,7 +1279,7 @@ static size_t stm32_mdma_desc_residue(struct stm32_mdma_chan *chan,
 				      u32 curr_hwdesc)
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
-	struct stm32_mdma_hwdesc *hwdesc = desc->node[0].hwdesc;
+	struct stm32_mdma_hwdesc *hwdesc;
 	u32 cbndtr, residue, modulo, burst_size;
 	int i;
 
-- 
2.33.1

