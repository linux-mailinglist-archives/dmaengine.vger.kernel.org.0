Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B112B4C0831
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 03:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiBWCaY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Feb 2022 21:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbiBWCaP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 22 Feb 2022 21:30:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914746B1C;
        Tue, 22 Feb 2022 18:29:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3337B81E01;
        Wed, 23 Feb 2022 02:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A004C340E8;
        Wed, 23 Feb 2022 02:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645583353;
        bh=3Q6HfLvnyk20c5KteC9b+hLzCTbQ2st3hb44bFNMDzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eycplXqci1dKtID9tugJ4a6FlUMwRKEqBpraL3gJXwwLinDvVT9L8FTEnL00KSbTW
         xuN8Z8FCTykHVjhw3bU2acjWaepUoXnOIQW+V3BcfXmp/nSlEvc4/RkUzpuBTczc9V
         hXJrMOemapi2pt0POlNe8m7Z5EAwckRGcx5zrNXcgBn5TbB3XWKJ4OOZ0259+L5gqf
         ahnz6joYlG2nv1xYwSP5379KqOCQxmmcqgxsuTONEjXcpWIotD8qlmxjRcw77fQpIl
         6Bx/QFBgxbDJ7xtu6S0y8h2D1rcJbK/cTf3xud3LKrJXTtt3OPeqkv4Fhgzx9Xr3WD
         t8x7K5a+LwlWg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yongzhi Liu <lyz_cs@pku.edu.cn>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, christophe.jaillet@wanadoo.fr,
        arnd@arndb.de, laurent.pinchart@ideasonboard.com,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 24/30] dmaengine: shdma: Fix runtime PM imbalance on error
Date:   Tue, 22 Feb 2022 21:28:13 -0500
Message-Id: <20220223022820.240649-24-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223022820.240649-1-sashal@kernel.org>
References: <20220223022820.240649-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Yongzhi Liu <lyz_cs@pku.edu.cn>

[ Upstream commit 455896c53d5b803733ddd84e1bf8a430644439b6 ]

pm_runtime_get_() increments the runtime PM usage counter even
when it returns an error code, thus a matching decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
Link: https://lore.kernel.org/r/1642311296-87020-1-git-send-email-lyz_cs@pku.edu.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sh/shdma-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 7f72b3f4cd1ae..19ac95c0098f0 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -115,8 +115,10 @@ static dma_cookie_t shdma_tx_submit(struct dma_async_tx_descriptor *tx)
 		ret = pm_runtime_get(schan->dev);
 
 		spin_unlock_irq(&schan->chan_lock);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(schan->dev, "%s(): GET = %d\n", __func__, ret);
+			pm_runtime_put(schan->dev);
+		}
 
 		pm_runtime_barrier(schan->dev);
 
-- 
2.34.1

