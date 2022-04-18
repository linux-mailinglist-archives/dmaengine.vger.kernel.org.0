Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2CB505AE4
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbiDRPWx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345448AbiDRPWh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 11:22:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C8AD64D4;
        Mon, 18 Apr 2022 07:20:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id j71so5622082pge.11;
        Mon, 18 Apr 2022 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccR/mnwveIJy1+ZaW/EVppjy7Ucpakkl1UjrV+8YXAk=;
        b=XEiadJDP5pRoh9TElIIjDpGwvXHzinAi+cZWXrgMmFKiX356STHcLvNbO/c4ZXqYR+
         Knr6EZeYjIYRu+IGA4188A6O5jEjDX+gUVdW9aHQQlKjhWwpyR56ED5Vp8stWXA4J1ak
         8AHGY95ejcUuPKxQJ1d+az7rMgzmOIpfUxg2dgkIvTXy+XBlc1r3waKeAPgceGMgZ7mg
         puYi4vLQaxF1WxYlH6DaagWeva2/CIpCKVWQNfy+fjeue2xiKePqXJgpnSzW2mH1gbJE
         oTccNo7N0WvpV3hPRzj37uMo0R6+5UHRTP0CT34GEOwDNcTdxLBet0zw5PCYmFZjPFM4
         wEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ccR/mnwveIJy1+ZaW/EVppjy7Ucpakkl1UjrV+8YXAk=;
        b=7fEOISAzpKMNi3Kfp4ZYYp++bpV7TZ9q+EByBMjbDcEivS7VV1+Gcv4w4KCJNMvLLB
         wFb4sXwti+Pe7lyxeQ1OQbNLqojmFtICsbX/v7ISY80krrkv8qTguTSKw+vCLMqOSnV+
         WxMHajkQpo0pRZAPHUFepslWZQ3Acri5MdshwbUUG44Yxd2Y7l/yApDxW/ggEgBAhw1d
         gvG2D0m8si05T9mUle+x9shahDGtc8E7is26qW4CDecsc+7cuAokxqm09PrCxw6afPBC
         1NIfUt+kjmZfAP2pzYuRMas2nBVEn2LHn9Z5jJiQsF5FA5HHdodSf82O0ubpGiiGwpIE
         yTAg==
X-Gm-Message-State: AOAM532h7p+tCBLRal/8Z9JeLEeCzhwkS1WIMY98ugwVEk+B6TQzlHw5
        buHi9c8PdEidYZ5H0EUt+bneZWgP5ZJhB/NQyVs=
X-Google-Smtp-Source: ABdhPJz9os8jYLIPcOuVijLhtTg5dh1Z5J9eTsNjGg6jB1Kc2u6VraFunUrIqz9QmP5si3ls5lZ3OA==
X-Received: by 2002:a05:6a00:1310:b0:4ca:cc46:20c7 with SMTP id j16-20020a056a00131000b004cacc4620c7mr12720042pfu.44.1650291624922;
        Mon, 18 Apr 2022 07:20:24 -0700 (PDT)
Received: from localhost ([210.21.229.138])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm13425938pjy.35.2022.04.18.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:20:24 -0700 (PDT)
From:   Yunbo Yu <yuyunbo519@gmail.com>
To:     logang@deltatee.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunbo Yu <yuyunbo519@gmail.com>
Subject: [PATCH] dmaengine: plx_dma: Move spin_lock_bh() to spin_lock()
Date:   Mon, 18 Apr 2022 22:20:21 +0800
Message-Id: <20220418142021.1241558-1-yuyunbo519@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It is unnecessary to call spin_lock_bh() for you are already in a tasklet.

Signed-off-by: Yunbo Yu <yuyunbo519@gmail.com>
---
 drivers/dma/plx_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 1ffcb5ca9788..12725fa1655f 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -137,7 +137,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
 	struct plx_dma_desc *desc;
 	u32 flags;
 
-	spin_lock_bh(&plxdev->ring_lock);
+	spin_lock(&plxdev->ring_lock);
 
 	while (plxdev->tail != plxdev->head) {
 		desc = plx_dma_get_desc(plxdev, plxdev->tail);
@@ -165,7 +165,7 @@ static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
 		plxdev->tail++;
 	}
 
-	spin_unlock_bh(&plxdev->ring_lock);
+	spin_unlock(&plxdev->ring_lock);
 }
 
 static void plx_dma_abort_desc(struct plx_dma_dev *plxdev)
-- 
2.25.1

