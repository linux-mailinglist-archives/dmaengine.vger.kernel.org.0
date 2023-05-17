Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146C8706063
	for <lists+dmaengine@lfdr.de>; Wed, 17 May 2023 08:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEQGpB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 17 May 2023 02:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEQGow (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 17 May 2023 02:44:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D883A82
        for <dmaengine@vger.kernel.org>; Tue, 16 May 2023 23:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B1363638
        for <dmaengine@vger.kernel.org>; Wed, 17 May 2023 06:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DD1C433EF;
        Wed, 17 May 2023 06:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684305889;
        bh=biOktKWmlXXCOkgO66+JM7H4QrZR9B/VSDtRsZv+3Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HncMCuRljw09BLDgM9auY8tWiXcmH9OEyrUievYu9yVfcAS2E6G0GepFfmIKycKKw
         KP2XhhEu+b+lwzczsEOLo6R1ZjdibBVRpixTsT7wKnqreCaaMOo8X8js2boJ2PHBVF
         Vqrv1fgYkzFTKn8DHnzDceptz/jCQQZ7GFn0FSYWwiE4B58uxaSuiiP2ro5Oot3ppp
         kul/5HdJukCcuecgZCiKGOFU72Bnt1INGBgzCIIDKc/aMEjAmZnSCpywHBlrFBbjqD
         uTcmWqXbuGyiTJngG39U1wqlN96G7B4kEPXeSuevfEgK6HhVrHXyvGs/UAumtgWHrh
         gEG9ArtvEqElQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] dmaengine: ste_dma40: fix typo in enum documentation
Date:   Wed, 17 May 2023 12:14:34 +0530
Message-Id: <20230517064434.141091-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517064434.141091-1-vkoul@kernel.org>
References: <20230517064434.141091-1-vkoul@kernel.org>
MIME-Version: 1.0
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

s/40_command/d40_command to fix the below warning reported:

drivers/dma/ste_dma40.c:151: warning: expecting prototype for enum 40_command.
Prototype was for enum d40_command instead

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/ste_dma40.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 56c839241a53..2246a604256e 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -136,7 +136,7 @@ static const struct stedma40_chan_cfg dma40_memcpy_conf_log = {
 };
 
 /**
- * enum 40_command - The different commands and/or statuses.
+ * enum d40_command - The different commands and/or statuses.
  *
  * @D40_DMA_STOP: DMA channel command STOP or status STOPPED,
  * @D40_DMA_RUN: The DMA channel is RUNNING of the command RUN.
-- 
2.40.1

