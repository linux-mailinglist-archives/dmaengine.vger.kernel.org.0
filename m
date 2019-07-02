Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3A5D4A7
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jul 2019 18:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGBQsx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Jul 2019 12:48:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40221 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfGBQsv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Jul 2019 12:48:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so14719070qkg.7
        for <dmaengine@vger.kernel.org>; Tue, 02 Jul 2019 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+sK/ptG3zA3icA9Idsc9SVgSs60jbtA7vetXvwJPKmY=;
        b=pavpJld6ECshouRBD+2HUJIQWl1CMSWsGFZO8U0kOSico3cs4rS43xIm0BWETXDJG9
         G3hk2hC+c8s0K8w7fQf6AYhUZtTvPRJkqZeXCHneFVjNFrKlGidGfo+I9xvM14LY8raK
         HfPfJEO2yiEHUAaXYaNX4hWnqn2hBpr3g/35crtEW0Ra4jqLi0xW6ulHlpBNy2pTczIR
         vUmORZOsAdT/r+m0EFcl5jxBvc7N4gbWr677GgeWEzk47mZDDWhsNEYaZbpqaH8FRBFE
         lrSg0BN89dQmaxBDhB3gwsTvrSn5pTk/b5+EqzLy2SEgmoU1+7SToWGUlnShxM5VMBdq
         iaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+sK/ptG3zA3icA9Idsc9SVgSs60jbtA7vetXvwJPKmY=;
        b=a3RSONMDaZJ29PPLhENzo+SXZbib0yeYSESOUs5JtOlRvjidaiXcl8P9rBb5giCl39
         y2FMMYc6oCNc15pnWMC07d5BLAjjxqwtK1jzC5vmOe+jQkAgv0iI+StAwyKVCkghDV2R
         XD6aQrwA5T6snNl3lh3WhNLFAtteswePb+QSN9tcQGhe9aAj/ZsT0trDIt8onVh2QBOv
         MQT1TKSlFh7zMBAvobpyz8S/0fQVrHDek3+p46IMZ5PI28/z5CipE8wGOOj0dVp5x5NU
         eO6VDpaG9A5GZyTB/xVfY1mvESaPOQLogZTuaC+OSiNwpJV4wOMdF9XZEO+/MuQi0JaH
         zHFg==
X-Gm-Message-State: APjAAAUME1uywrVQlNmT2Tm3V+35ZvNtd7SEKAo1oW9ymeW3tdJoKHBX
        Gd5eetAxkhkhFx/BUQGXJbk=
X-Google-Smtp-Source: APXvYqx40bFMd4JVMuNpmTm7dA00jViZkpHh75DvhacTqwaQA7mHXF/czxtlDtkycgZmyYYcXfgTdw==
X-Received: by 2002:a37:404b:: with SMTP id n72mr18069503qka.109.1562086131075;
        Tue, 02 Jul 2019 09:48:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id 139sm6567770qkg.127.2019.07.02.09.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:48:50 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     vkoul@kernel.org
Cc:     krzk@kernel.org, cphealy@gmail.com, peng.ma@nxp.com,
        dmaengine@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] Revert "dmaengine: fsl-edma: support little endian for edma driver"
Date:   Tue,  2 Jul 2019 13:48:52 -0300
Message-Id: <20190702164852.3195-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit 002905eca5bedab08bafd9e325bbbb41670c7712.

Commit 002905eca5be ("dmaengine: fsl-edma: support little endian for edma
driver") incorrectly assumed that there was not little endian support
in the driver.

This causes hangs on Vybrid, so revert it so that Vybrid systems
could boot again.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
---
Changes since v1:
- Updated Krzysztof's e-mail address
- Collected Krzysztof's Tested-by

 drivers/dma/fsl-edma-common.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 6bf238e19d91..680b2a00a953 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -83,14 +83,9 @@ void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
 	u32 ch = fsl_chan->vchan.chan.chan_id;
 	void __iomem *muxaddr;
 	unsigned int chans_per_mux, ch_off;
-	int endian_diff[4] = {3, 1, -1, -3};
 
 	chans_per_mux = fsl_chan->edma->n_chans / DMAMUX_NR;
 	ch_off = fsl_chan->vchan.chan.chan_id % chans_per_mux;
-
-	if (!fsl_chan->edma->big_endian)
-		ch_off += endian_diff[ch_off % 4];
-
 	muxaddr = fsl_chan->edma->muxbase[ch / chans_per_mux];
 	slot = EDMAMUX_CHCFG_SOURCE(slot);
 
-- 
2.17.1

