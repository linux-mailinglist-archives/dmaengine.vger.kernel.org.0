Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E69056BEDB
	for <lists+dmaengine@lfdr.de>; Fri,  8 Jul 2022 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiGHRB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Jul 2022 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbiGHRB6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Jul 2022 13:01:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05111F2C6
        for <dmaengine@vger.kernel.org>; Fri,  8 Jul 2022 10:01:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q9so31347706wrd.8
        for <dmaengine@vger.kernel.org>; Fri, 08 Jul 2022 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9y5PG1Rr8iDrXv2X77tqhUSPBmVN5ApM2R46XCdl3U=;
        b=LJdiLzVHN+p0WIGtL/55wQEAZNPxymx9Yfq9Zw5HEUKPdFwATHGsR+LlzO2Alfn7Mw
         0TKWyUX8K6NithcBYmlPCgaY+Hdvy93i6EOdwwJ5u62P5Z14bn4nSfBDsevUC4j0AyQf
         UVrSkgzfqftaZ3ebvyEv4kz2IJZXLOsYu6gyrzlvR+HKd5+n5QtL6+awcXIr9xr6dgdP
         OQVtzSVlGP4iyUlaUi1dIqJSdB/yBgZpHT1JlEtFlX04Fyv3YJ4Cw0uarKAlUhKO/QlJ
         3zIkUqrtE7sh7UWqy3RhALn2+m3Mp3WClXTeTq3qLrFa8Wg5ynuym8ZaV2lfTaVrl+mb
         fCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9y5PG1Rr8iDrXv2X77tqhUSPBmVN5ApM2R46XCdl3U=;
        b=wF8Djr5R8sc8GJn5WFYGZytJnfxBwCULCKt96k1+CMT80H53mGLKbh2aS11tTUpHy2
         g3hxB8VZLVs1BSp6EpZM7f2wr/JbB2EJKoA5CfVMYX8IkRvfsiyUWL+8SLRLdQVgSTQE
         WYRm37iSijOtZFVJ7jSR5ZM/typma0yrd297Pb6pcHFGo2580bI4oshKZBYb5Qji4MIZ
         N+Md1eG8VsFTCan5l2XgdTmZ+iqzNTYmOBZVBH0TCit9IyukB7ZkCoHD/UE8HOs0WImK
         KlF+ZhyzTXD2xZNy9oITQ/zBLueJx7BHxU4QIEf5bUl0x9lTH2Mt6SZ/A+0atcrFvx5l
         M3TQ==
X-Gm-Message-State: AJIora8HSjug6E5cWD+/lqtOJsN8okKRnVDH+lhYt26KlSjQBBzknpiy
        RKtgHeUhDeYXqXNqJekIl/sDeG+63rR19591
X-Google-Smtp-Source: AGRyM1tnC+Fzc7OLwyv5lgOip+TsqjIBVU4EsPLZwexvWSy9wLxmCxg8Mn86KKeyn4C1RhpCZcsAkg==
X-Received: by 2002:a05:6000:12c8:b0:21d:6913:89af with SMTP id l8-20020a05600012c800b0021d691389afmr4189427wrx.546.1657299715925;
        Fri, 08 Jul 2022 10:01:55 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t5-20020adfe105000000b002103bd9c5acsm41336252wrz.105.2022.07.08.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 10:01:55 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     dmaengine@vger.kernel.org, Eugeniy.Paltsev@synopsys.com
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 1/3] dmaengine: dw-axi-dmac: dump channel registers on error
Date:   Fri,  8 Jul 2022 18:01:51 +0100
Message-Id: <20220708170153.269991-2-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708170153.269991-1-ben.dooks@sifive.com>
References: <20220708170153.269991-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On channel error, dump the channel register state before
the channel's LLI entries to see what the controller was
actually doing when the error happend.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index e9c9bcb1f5c2..75c537153e92 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -79,6 +79,20 @@ axi_chan_iowrite64(struct axi_dma_chan *chan, u32 reg, u64 val)
 	iowrite32(upper_32_bits(val), chan->chan_regs + reg + 4);
 }
 
+static inline u64
+axi_chan_ioread64(struct axi_dma_chan *chan, u32 reg)
+{
+	u32 high, low;
+	u64 result;
+
+	low = ioread32(chan->chan_regs + reg);
+	high = ioread32(chan->chan_regs + reg + 4);
+
+	result = low;
+	result |= (u64)high << 32;
+	return result;
+}
+
 static inline void axi_chan_config_write(struct axi_dma_chan *chan,
 					 struct axi_dma_chan_config *config)
 {
@@ -979,6 +993,18 @@ static int dw_axi_dma_chan_slave_config(struct dma_chan *dchan,
 	return 0;
 }
 
+static void axi_chan_dump_regs(struct axi_dma_chan *chan)
+{
+	dev_err(dchan2dev(&chan->vc.chan),
+		"R: SAR: 0x%llx DAR: 0x%llx LLP: 0x%llx BTS 0x%x CTL: 0x%x:%08x\n",
+		axi_chan_ioread64(chan, CH_SAR),
+		axi_chan_ioread64(chan, CH_DAR),
+		axi_chan_ioread64(chan, CH_LLP),
+		axi_chan_ioread32(chan, CH_BLOCK_TS),
+		axi_chan_ioread32(chan, CH_CTL_H),
+		axi_chan_ioread32(chan, CH_CTL_L));
+}
+
 static void axi_chan_dump_lli(struct axi_dma_chan *chan,
 			      struct axi_dma_hw_desc *desc)
 {
@@ -1020,6 +1046,8 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	dev_err(chan2dev(chan),
 		"Bad descriptor submitted for %s, cookie: %d, irq: 0x%08x\n",
 		axi_chan_name(chan), vd->tx.cookie, status);
+
+	axi_chan_dump_regs(chan);
 	axi_chan_list_dump_lli(chan, vd_to_axi_desc(vd));
 
 	vchan_cookie_complete(vd);
-- 
2.35.1

