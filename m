Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD824815D
	for <lists+dmaengine@lfdr.de>; Tue, 18 Aug 2020 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgHRJHF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Aug 2020 05:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJHE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Aug 2020 05:07:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD5AC061389
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so8929798plr.5
        for <dmaengine@vger.kernel.org>; Tue, 18 Aug 2020 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RCQBB24TVyQgJJKqQrd+pMSwLixAZ8RHZ/Oe1XSH5Ms=;
        b=aczysO6BdRk+x106UquxKG+hK1UQJ5cUa3qDnahJUrX6fQkHunx5IlBzzEKWwrjzns
         euHHo1D1Lq2VUk2fw8ZrbRvx8iola34n4ddyKVqffPqCNmMbnm4qBLaELCKPc5+k5cgT
         rW3Q9qk8nyEg7AqAkrtjhQ7fzdP46gALKGOOYECENNkrQHSHWRq7H8Ire5rVndEyCO+U
         +gf8Fwwbf3syLxP5bsMZOWR+kASYMDTXGaymHkif9t8n8WCv/dX3TaTaSqQ9TzASe3Rr
         1c0QdK96duY5b9PJiXK+xJmi4Ex7r83JdDbJfeZAM1CXVueMkZ9PvisH/NfN4mB8LFdv
         HOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RCQBB24TVyQgJJKqQrd+pMSwLixAZ8RHZ/Oe1XSH5Ms=;
        b=J5xpf921210NCrZd7YXOMn82D4G4U9yQ0N20p6AzBCtIbc89v26K5xmEFYigViHK4s
         ODTGCtv8OLWhJjJIJHeF1dODyvvPIZod7g3eJBC14pcTIl0hjxasae2Cvl4FqzRR0xP8
         e2kvWpPfDfA0ru341ccNYS6MY3Jec8IP5vlNMsFwAYq+Bai0MObhEepQ/KJ8s6R/Mmw7
         SsM7+6SE3fAL+rEKN0Jt8PJR69WUrYrfaVOIsqFMbAQVW6MlajpBe3uI5wwx/4A0hwvo
         /M/tRl+vUXZ00FCL9pFrOGAc4XYQFgHBkpmFczlmsLy3+y7GjSvucwKEim7/vKjkqa9L
         0yuw==
X-Gm-Message-State: AOAM532HukxOgd1MwCV5wGX9n1oVadQyNC6nrrLqwEfTldA92JVfgQI4
        wR1hCh1Urrz3uZgrDDdWX6x9x1r2MkOD4g==
X-Google-Smtp-Source: ABdhPJyo9E0Z2f6dRnmm4HRcMBcs+bEbGaUSE4q03RAXioKKUd+1eyF6+zdpPDbqQeAnf3MCrqF08A==
X-Received: by 2002:a17:90a:33d1:: with SMTP id n75mr16040722pjb.217.1597741623444;
        Tue, 18 Aug 2020 02:07:03 -0700 (PDT)
Received: from localhost.localdomain ([49.207.196.79])
        by smtp.gmail.com with ESMTPSA id na14sm20280788pjb.6.2020.08.18.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 02:07:02 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     vkoul@kernel.org, linus.walleij@linaro.org, vireshk@kernel.org,
        leoyang.li@nxp.com, zw@zh-kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org
Cc:     dmaengine@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 02/35] dma: at_hdmac: convert tasklets to use new tasklet_setup() API
Date:   Tue, 18 Aug 2020 14:36:05 +0530
Message-Id: <20200818090638.26362-3-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/dma/at_hdmac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 45bbcd6146fd..4162c9a177e0 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -598,9 +598,9 @@ static void atc_handle_cyclic(struct at_dma_chan *atchan)
 
 /*--  IRQ & Tasklet  ---------------------------------------------------*/
 
-static void atc_tasklet(unsigned long data)
+static void atc_tasklet(struct tasklet_struct *t)
 {
-	struct at_dma_chan *atchan = (struct at_dma_chan *)data;
+	struct at_dma_chan *atchan = from_tasklet(atchan, t, tasklet);
 
 	if (test_and_clear_bit(ATC_IS_ERROR, &atchan->status))
 		return atc_handle_error(atchan);
@@ -1885,8 +1885,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 		INIT_LIST_HEAD(&atchan->queue);
 		INIT_LIST_HEAD(&atchan->free_list);
 
-		tasklet_init(&atchan->tasklet, atc_tasklet,
-				(unsigned long)atchan);
+		tasklet_setup(&atchan->tasklet, atc_tasklet);
 		atc_enable_chan_irq(atdma, i);
 	}
 
-- 
2.17.1

