Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E356A1E73
	for <lists+dmaengine@lfdr.de>; Fri, 24 Feb 2023 16:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjBXPWq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Feb 2023 10:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjBXPWj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 24 Feb 2023 10:22:39 -0500
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D676EB1A;
        Fri, 24 Feb 2023 07:22:31 -0800 (PST)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1677252145; bh=StaFikSjZpFQ+BUcIlQfwrxM+sCnU+rvBEoVvGQ2nmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fOvbi5u7TfZbdRb/5lxtFwcD+ebCgEW+egwfuLYdhfzxpB2grc3CsYFX5m3JosTZ3
         5CP7I59IxQyKuSrYvD7i+g0nm3Z7Anzbz6LcVbPDatTuX7bCwQrAa765yoNtapNLkx
         VYNi76Ina7OQb60oYtDZ5wzW7ec+E3dPHKVJiV+4=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dmaengine: apple-admac: Fix 'current_tx' not getting freed
Date:   Fri, 24 Feb 2023 16:22:21 +0100
Message-Id: <20230224152222.26732-2-povik+lin@cutebit.org>
In-Reply-To: <20230224152222.26732-1-povik+lin@cutebit.org>
References: <20230224152222.26732-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In terminate_all we should queue up all submitted descriptors to be
freed. We do that for the content of the 'issued' and 'submitted' lists,
but the 'current_tx' descriptor falls through the cracks as it's
removed from the 'issued' list once it gets assigned to be the current
descriptor. Explicitly queue up freeing of the 'current_tx' descriptor
to address a memory leak that is otherwise present.

Fixes: b127315d9a78 ("dmaengine: apple-admac: Add Apple ADMAC driver")
Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 drivers/dma/apple-admac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 00cbfafe0ed9..497bb65b7d6d 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -512,7 +512,10 @@ static int admac_terminate_all(struct dma_chan *chan)
 	admac_stop_chan(adchan);
 	admac_reset_rings(adchan);
 
-	adchan->current_tx = NULL;
+	if (adchan->current_tx) {
+		list_add_tail(&adchan->current_tx->node, &adchan->to_free);
+		adchan->current_tx = NULL;
+	}
 	/*
 	 * Descriptors can only be freed after the tasklet
 	 * has been killed (in admac_synchronize).
-- 
2.33.0

