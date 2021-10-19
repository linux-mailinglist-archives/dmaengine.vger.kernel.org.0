Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6003F433EFA
	for <lists+dmaengine@lfdr.de>; Tue, 19 Oct 2021 21:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhJSTJ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Oct 2021 15:09:26 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51052
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234401AbhJSTJ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Oct 2021 15:09:26 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0EB0B402F1
        for <dmaengine@vger.kernel.org>; Tue, 19 Oct 2021 19:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634670432;
        bh=IHhtpDD/c4GM+dyAw7Uqm0bjhmnwIgmCSyCGp6YU3is=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=I9vaq8Kxfas4X+fb+5jE3U3qZh69r612YvYQ9njYWHhkteigsHpbfkvTdSVgRMF5F
         fqqXerH5BXGJ2ay+YRPbrSk4o+ZnXXgKfslcYrf6SOXhdt2NI28Fna6Q66DCvLZMx/
         aL2dv1BXLLbPXLAkNsgeUwFrSPGLX6ELQS2+NaYq1kMG0d0LCpiOUuaB9TCXLZqTBS
         l28pZFF0WSh8EfG1/PyuTybo8IHkMIUxvafariG7t+bzR2y+Q9XyE6A5sNSpUvEoJj
         aMdF+ir0xOkps3eVD455pHkyN8p2lY1bjFphz8KvBaZgy/New2j88Ojz8472luYz6f
         w2ViuhbgOyGSw==
Received: by mail-pg1-f200.google.com with SMTP id b5-20020a6541c5000000b002661347cfbcso12093406pgq.1
        for <dmaengine@vger.kernel.org>; Tue, 19 Oct 2021 12:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHhtpDD/c4GM+dyAw7Uqm0bjhmnwIgmCSyCGp6YU3is=;
        b=6AUPYxSf1J2uhn9hr6UDGea6O0zStoryG01PV8gTxXyJEWxdUlaplQaGUejfX0H2Hd
         sAIuZvk+Y/rENEe458SQ7+hJYkoWhF33+0aBZ6tfFcFo6UWmgWgXeqwRl8oBEii0PW59
         JZayjGjCd6IYtVIrDnKwepEnUFu0Ab27/6twcDbWJPnXggHDlwCOjoOLmD6ql3oRifv9
         20zk4FQ7wbULa/Ozv4NjbXfIVcaUHUta4GzWRMAs8Y2xAPFTudzSeVIbyjp86JRCrwZ4
         BdMbcjVzGP6HhT1Q052kVxqRro0FmAeIDhTssTbktgB0kI/tp4d/dxDygc9icueshrFy
         caSA==
X-Gm-Message-State: AOAM532J/z89tR/YJ1De8btPwvGLF1INK03T0/FeqBqM1jcgRkxGQG4f
        ku5/biFTF9qLkaG0NqXkQ3PVtyIRuXwoqf7jGqtzs4y7v1TdTXk8J720eOenBzNrsZUmHCu08vo
        wGkVdOD6fcv/ecntdQkHXpiYbasUAo8RhHFk38Q==
X-Received: by 2002:a63:7a13:: with SMTP id v19mr70512pgc.364.1634670430434;
        Tue, 19 Oct 2021 12:07:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXKnuR0/p6MrR7zQlukcDGNWx9AKNMfc6f2mEPmd6KsrmsgQbTqlky7rw/lE+qyPrzzM+m+A==
X-Received: by 2002:a63:7a13:: with SMTP id v19mr70491pgc.364.1634670430221;
        Tue, 19 Oct 2021 12:07:10 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id s52sm1515pfw.4.2021.10.19.12.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 12:07:09 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     dmaengine@vger.kernel.org
Cc:     tim.gardner@canonical.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH][linux-next] dmaengine: dw-axi-dmac: Fix uninitialized variable in axi_chan_block_xfer_start()
Date:   Tue, 19 Oct 2021 13:07:01 -0600
Message-Id: <20211019190701.15525-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Coverity complains of an uninitialized variable:

5. uninit_use_in_call: Using uninitialized value config.dst_per when calling axi_chan_config_write. [show details]
6. uninit_use_in_call: Using uninitialized value config.hs_sel_src when calling axi_chan_config_write. [show details]
CID 121164 (#1-3 of 3): Uninitialized scalar variable (UNINIT)
7. uninit_use_in_call: Using uninitialized value config.src_per when calling axi_chan_config_write. [show details]
418        axi_chan_config_write(chan, &config);

Fix this by clearing the structure which should at least be benign in axi_chan_config_write(). Also fix
what looks like a cut-n-paste error when initializing config.hs_sel_dst.

Fixes: 824351668a413 ("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8")
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 79572ec532ef..f47116e77ea1 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -386,12 +386,13 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 
 	axi_dma_enable(chan->chip);
 
+	memset(&config, 0, sizeof(config));
 	config.dst_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.src_multblk_type = DWAXIDMAC_MBLK_TYPE_LL;
 	config.tt_fc = DWAXIDMAC_TT_FC_MEM_TO_MEM_DMAC;
 	config.prior = priority;
 	config.hs_sel_dst = DWAXIDMAC_HS_SEL_HW;
-	config.hs_sel_dst = DWAXIDMAC_HS_SEL_HW;
+	config.hs_sel_src = DWAXIDMAC_HS_SEL_HW;
 	switch (chan->direction) {
 	case DMA_MEM_TO_DEV:
 		dw_axi_dma_set_byte_halfword(chan, true);
-- 
2.33.1

