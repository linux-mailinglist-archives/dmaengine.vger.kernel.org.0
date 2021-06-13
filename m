Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA343A5B06
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jun 2021 01:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhFMXel (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Jun 2021 19:34:41 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:33529 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhFMXej (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Jun 2021 19:34:39 -0400
Received: by mail-wm1-f52.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so8563487wme.0;
        Sun, 13 Jun 2021 16:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19kxl/rhOerh1ELMQori6rwEoEPcch3hGGkAm5qc07k=;
        b=LY7nbCqK5FgOsNW9SCKga4bYJGTR/cvdd+nTCVHryJ+uIuWezriB3ho84etSLlVUA0
         O5EOhXUM3lAYB5F5Hgd0p59koGYkOAKq/7P9/rnJHiJYTiUOjp9vqP3sYqqfafyHmeWH
         I/h9y+YtYLwFeh1yxafBTQD8qSH5Gwys2H6dpWZWvtzOjfmH26aqsv92NyUxMzKqLzDq
         4psDCpYL7CMnt0DFghB1zDDAix76m6UXBt+F6GzqXm8Lvi6HKYHFl9an2cXfp3jQ40Kk
         /Ly9OFLcLA6hUNKYKMArPwEfPbuMYX00NDSHgSRKNtYY9jiebkPw/1Qb4jFwhKoKzcJF
         kvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19kxl/rhOerh1ELMQori6rwEoEPcch3hGGkAm5qc07k=;
        b=pRIQ1YUAhGY7AZD2JyAttHjnhbTYF4pFnc7WvG4Nz7fWWyydlvoKx2TDevqRBaI4HT
         O5UZ1IFsjfoP1PnWz7EhkdP2bBNp/RizQn0lg09rjlDvyZPgSsB9kW/MGOjWgT/MA9r+
         bf6NWzt/80ZYsIiEBXXr6Dtql4v+L2eTVT3lpeiTB+8Hr2yDD526QlEgbR9aU3AlbTfE
         uJJVMFFio0fTYi9W/LNWDM1U19ixR8+0D1JJVgT+fWvaHYjKfaNPBidkvHH7ACqdvqBi
         PAUVMvYR+Nww4J3ntCXSYJ30qxqQVqihGLftZNMx4DtQUegIpTr45al8bG8fSow4ACzd
         ypBw==
X-Gm-Message-State: AOAM532z0Oj74472XG+/Cy7diJcxTllYpO/X5AEJ8GT9etZipKL6KiLp
        OtxH1f7n9CTXyPCgSkFD3EQ=
X-Google-Smtp-Source: ABdhPJyuKdiPSO2kOB48IZqh0emfjke/lDWUo16OE5MAl81d4Fb5elZ5/f5i/En2SWOMNBqCxKsGXg==
X-Received: by 2002:a05:600c:3ba2:: with SMTP id n34mr13493721wms.120.1623627083877;
        Sun, 13 Jun 2021 16:31:23 -0700 (PDT)
Received: from localhost.localdomain ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id i9sm17882511wrn.54.2021.06.13.16.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:31:23 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        dmaengine@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dmaengine: ep93xx: Prepare clock before using it
Date:   Mon, 14 Jun 2021 01:30:39 +0200
Message-Id: <20210613233041.128961-6-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework, otherwise the following is visible:

WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
Enabling unprepared m2p0
CPU: 0 PID: 1 Comm: swapper Not tainted 5.13.0-rc5-tekon #1
Hardware name: Cirrus Logic EDB9302 Evaluation Board
[<c000d5b0>] (unwind_backtrace) from [<c000c590>] (show_stack+0x10/0x18)
[<c000c590>] (show_stack) from [<c03a5fb8>] (dump_stack+0x20/0x2c)
[<c03a5fb8>] (dump_stack) from [<c03a2118>] (__warn+0x98/0xc0)
[<c03a2118>] (__warn) from [<c03a21d0>] (warn_slowpath_fmt+0x90/0xc0)
[<c03a21d0>] (warn_slowpath_fmt) from [<c01d8358>] (clk_core_enable+0x9c/0xbc)
[<c01d8358>] (clk_core_enable) from [<c01d8698>] (clk_core_enable_lock+0x18/0x30)
[<c01d8698>] (clk_core_enable_lock) from [<c01e1844>] (ep93xx_dma_alloc_chan_resources+0x94/0x244)
[<c01e1844>] (ep93xx_dma_alloc_chan_resources) from [<c01df7d4>] (dma_chan_get+0x90/0x124)
[<c01df7d4>] (dma_chan_get) from [<c01df92c>] (find_candidate+0xc4/0x188)
[<c01df92c>] (find_candidate) from [<c01dff30>] (__dma_request_channel+0x68/0xb0)
[<c01dff30>] (__dma_request_channel) from [<c027d2e4>] (snd_dmaengine_pcm_request_channel+0x68/0x90)
[<c027d2e4>] (snd_dmaengine_pcm_request_channel) from [<c0290618>] (dmaengine_pcm_new+0x254/0x29c)
[<c0290618>] (dmaengine_pcm_new) from [<c0289b84>] (snd_soc_pcm_component_new+0x40/0xa0)
[<c0289b84>] (snd_soc_pcm_component_new) from [<c028c7f8>] (soc_new_pcm+0x47c/0x5fc)
[<c028c7f8>] (soc_new_pcm) from [<c027f300>] (snd_soc_bind_card+0x73c/0x8a8)
[<c027f300>] (snd_soc_bind_card) from [<c029180c>] (edb93xx_probe+0x34/0x5c)
[<c029180c>] (edb93xx_probe) from [<c02126e0>] (platform_probe+0x34/0x80)
[<c02126e0>] (platform_probe) from [<c0210bf8>] (really_probe+0xe8/0x394)
[<c0210bf8>] (really_probe) from [<c0211464>] (device_driver_attach+0x5c/0x64)
[<c0211464>] (device_driver_attach) from [<c02114e8>] (__driver_attach+0x7c/0xec)
[<c02114e8>] (__driver_attach) from [<c020f1b4>] (bus_for_each_dev+0x78/0xc4)
[<c020f1b4>] (bus_for_each_dev) from [<c0211570>] (driver_attach+0x18/0x24)
[<c0211570>] (driver_attach) from [<c020fab4>] (bus_add_driver+0x140/0x1cc)
[<c020fab4>] (bus_add_driver) from [<c0211c44>] (driver_register+0x74/0x114)
[<c0211c44>] (driver_register) from [<c02134f8>] (__platform_driver_register+0x18/0x24)
[<c02134f8>] (__platform_driver_register) from [<c047084c>] (edb93xx_driver_init+0x10/0x1c)
[<c047084c>] (edb93xx_driver_init) from [<c045ce88>] (do_one_initcall+0x7c/0x1a4)
[<c045ce88>] (do_one_initcall) from [<c045d184>] (kernel_init_freeable+0x17c/0x1fc)
[<c045d184>] (kernel_init_freeable) from [<c03a6550>] (kernel_init+0x8/0xf8)
[<c03a6550>] (kernel_init) from [<c00082d8>] (ret_from_fork+0x14/0x3c)
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
2.32.0

