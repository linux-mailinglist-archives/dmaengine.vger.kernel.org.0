Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420513D5900
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jul 2021 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhGZLS6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Jul 2021 07:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhGZLS5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Jul 2021 07:18:57 -0400
X-Greylist: delayed 429 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Jul 2021 04:59:25 PDT
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF412C061757;
        Mon, 26 Jul 2021 04:59:25 -0700 (PDT)
Received: from iva6-f3088a0362c9.qloud-c.yandex.net (iva6-f3088a0362c9.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:6105:0:640:f308:8a03])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id E45581C82038;
        Mon, 26 Jul 2021 14:52:10 +0300 (MSK)
Received: from iva6-2d18925256a6.qloud-c.yandex.net (iva6-2d18925256a6.qloud-c.yandex.net [2a02:6b8:c0c:7594:0:640:2d18:9252])
        by iva6-f3088a0362c9.qloud-c.yandex.net (mxback/Yandex) with ESMTP id jJ6IXdL2KA-qAHalXlL;
        Mon, 26 Jul 2021 14:52:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627300330;
        bh=VghBgGCaG8Igu8fYmyfHMl7z7z7YIdXbOUURfaXg0tY=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=TB04QbPC50SPA8uZ+UXCIjYSMmpwrVogD2TEmFXauhWBlJPgxWHMSPlLEua1hj7fu
         vvxDL6MKjCR0so1HMZ3ojj6jytdKpgYKtFxV3K0TyawgOFNYO5/FGS6QWSLngIuHbA
         KIV+pAFclDMRfLDc7VQG4ZsradJKaQD4qUBna5ec=
Authentication-Results: iva6-f3088a0362c9.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva6-2d18925256a6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id PIKatQa27D-qA2Sc5Qx;
        Mon, 26 Jul 2021 14:52:10 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/8] dmaengine: ep93xx: Prepare clock before using it
Date:   Mon, 26 Jul 2021 14:50:49 +0300
Message-Id: <20210726115058.23729-6-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726115058.23729-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared m2p0
...
Hardware name: Cirrus Logic EDB9302 Evaluation Board
...
clk_core_enable
clk_core_enable_lock
ep93xx_dma_alloc_chan_resources
dma_chan_get
find_candidate
__dma_request_channel
snd_dmaengine_pcm_request_channel
dmaengine_pcm_new
snd_soc_pcm_component_new
soc_new_pcm
snd_soc_bind_card
edb93xx_probe
...
ep93xx-i2s ep93xx-i2s: Missing dma channel for stream: 0
ep93xx-i2s ep93xx-i2s: ASoC: error at snd_soc_pcm_component_new on ep93xx-i2s: -22
edb93xx-audio edb93xx-audio: ASoC: can't create pcm CS4271 HiFi :-22
edb93xx-audio edb93xx-audio: snd_soc_register_card() failed: -22
edb93xx-audio: probe of edb93xx-audio failed with error -22

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/dma/ep93xx_dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 01027779beb8..98f9ee70362e 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -897,7 +897,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 	if (data && data->name)
 		name = data->name;
 
-	ret = clk_enable(edmac->clk);
+	ret = clk_prepare_enable(edmac->clk);
 	if (ret)
 		return ret;
 
@@ -936,7 +936,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 fail_free_irq:
 	free_irq(edmac->irq, edmac);
 fail_clk_disable:
-	clk_disable(edmac->clk);
+	clk_disable_unprepare(edmac->clk);
 
 	return ret;
 }
@@ -969,7 +969,7 @@ static void ep93xx_dma_free_chan_resources(struct dma_chan *chan)
 	list_for_each_entry_safe(desc, d, &list, node)
 		kfree(desc);
 
-	clk_disable(edmac->clk);
+	clk_disable_unprepare(edmac->clk);
 	free_irq(edmac->irq, edmac);
 }
 
-- 
2.26.2

