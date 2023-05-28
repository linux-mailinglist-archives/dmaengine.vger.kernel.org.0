Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC997139EF
	for <lists+dmaengine@lfdr.de>; Sun, 28 May 2023 16:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjE1OMB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 May 2023 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjE1OMA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 May 2023 10:12:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F2BE
        for <dmaengine@vger.kernel.org>; Sun, 28 May 2023 07:11:58 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3H7jq4uCWZO7A3H7jqkgSo; Sun, 28 May 2023 16:11:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685283116;
        bh=y3+xzWyNMJI6Fo1vf7HM2FwwEMDemy6nUMbYmtfSJAo=;
        h=From:To:Cc:Subject:Date;
        b=MkqYroq869dWCNPUaGO8IPR2Eei6nlkHrBoAFM8ZtoR7LOZesAA/wfZThpcPpNDA0
         APsGbRNmo+0lERhGQ4/FjUenENWDqx4vGreOPNIxs4kcdqVrkGP1olHL+qIIwLKN82
         N+BMfwz78eTUdtkQMesHOA5mhVy+8Bevnp/ND9tWOxcLbwhfMdt7fpho2vY9KPyv8o
         gjdbB3+OsaRuThkxSvxhQtBdpWp7Qr3KU7I/VS/gqp8DP7RhOwDnb6dOMzdZdd8pDz
         FcqL/aijEt0h12vC6pT/Ywxtb9nufUKaty2CLRlDyIrSOsYEr5tLh99CXD2LbNo4Rf
         o7YxqqMVgcqMQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 May 2023 16:11:56 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: No need to clear memory after a dma_alloc_coherent() call
Date:   Sun, 28 May 2023 16:11:54 +0200
Message-Id: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dma_alloc_coherent() already clear the allocated memory, there is no need
to explicitly call memset().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/dma/idxd/device.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5abbcc61c528..7c74bc60f582 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -786,8 +786,6 @@ static int idxd_device_evl_setup(struct idxd_device *idxd)
 		goto err_alloc;
 	}
 
-	memset(addr, 0, size);
-
 	spin_lock(&evl->lock);
 	evl->log = addr;
 	evl->dma = dma_addr;
-- 
2.34.1

