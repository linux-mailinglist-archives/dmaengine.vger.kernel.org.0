Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5A4439E55
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhJYSTp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 14:19:45 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46494
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232606AbhJYSTk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Oct 2021 14:19:40 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC66B4029A
        for <dmaengine@vger.kernel.org>; Mon, 25 Oct 2021 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635185836;
        bh=oCCJcDvPPpYCEpim/tCzuq7YuxbYYlpz5fHWjLFk2qY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=X+N9Ul/3/v2YCJO55MnUrOLpE/dLiBUJ7q5S5bwBHO4h5kN0W+bRBzBELPkDeRzNp
         qfZ89nwx7+YWXT76oiVFDK6pyJM3B+msQ8bEWByWpOyF7B+qW8ollGu53sKAigjrz+
         GH80GZGnydc2lQuruQKIxrozD14FgrRyi/qXcFwJsJtKFFxk5GU9QE1vjb4eYREuVV
         eh8OVv0ezutnFYvGcaaiq3EgbG46UVRH7/5AA3yXyRxPa3gxtX/9hzil5GFdRxwwUX
         hEDmhRTxY2ojNlCQttzg4LBQaOQhIdGRhr0FJghHthSX5n50CggyKLNDOr55E77yaP
         FIsv9tUWnKP3w==
Received: by mail-pf1-f197.google.com with SMTP id y41-20020a056a00182900b0044d43d31f20so6935900pfa.11
        for <dmaengine@vger.kernel.org>; Mon, 25 Oct 2021 11:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCCJcDvPPpYCEpim/tCzuq7YuxbYYlpz5fHWjLFk2qY=;
        b=6WYJbDJDzKhZGx5jq59iFVW4PGATm1rIZ3AJEgFvsciRgRQ6VDU+RPVtib6hvt+dJH
         qWI2IRp6XlKBQGBin0i9ZEnRqA5D+XtDH5woE49bL56QkTvGXQ9zVCF9dv6iRD42nT0e
         qsDUV7cpqKTmR07ZsH4Chxj/DJ6++muK/nytYJt74Xyz63fnG51yZMyap8KbAevFptH7
         TLbW5b0kpe3/n8oPtM1HN0a92wyp1T4v7em5dg/kMPh3+BBKMNW0aNzjbE5fFr90nHHC
         QOKIAzZMromNoXLNQ95qgQ4I9yyRLr4JTP93ZUMDtCWdK0qEfwAwg41GO49LLYfvD3ke
         L8cw==
X-Gm-Message-State: AOAM5325HFAhwStlpINXj/lou+SFZLptS5/H20gxT98EvZ/YaR36esSb
        rua6QbXQv+3FiVx7m9U7T4ctX0/swsek7epvT1ZrpgT0wI94f9RJfeTDybZw2OicijT2mGEMN1a
        ekmdzl5JDIPzvQ8V7uktUxjYTdvERcB5ZDRDgTw==
X-Received: by 2002:a05:6a00:22c8:b0:44d:cb37:86e4 with SMTP id f8-20020a056a0022c800b0044dcb3786e4mr20476247pfj.78.1635185835326;
        Mon, 25 Oct 2021 11:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3CObGgMZNQaozjZA/TGdwLBc9W8h2QmMpfppjSZMhzt184XyIufQPs/vn8vZR1d/95dpf4A==
X-Received: by 2002:a05:6a00:22c8:b0:44d:cb37:86e4 with SMTP id f8-20020a056a0022c800b0044dcb3786e4mr20476218pfj.78.1635185834990;
        Mon, 25 Oct 2021 11:17:14 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id b8sm19125939pfi.103.2021.10.25.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:17:14 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     vkoul@kernel.org
Cc:     tim.gardner@canonical.com,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2][linux-next] dmaengine: dw-axi-dmac: Fix uninitialized variable in axi_chan_block_xfer_start()
Date:   Mon, 25 Oct 2021 12:16:56 -0600
Message-Id: <20211025181656.31658-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <YXZBxx8NObaf3x70@matsya>
References: <YXZBxx8NObaf3x70@matsya>
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

Fix this by initializing the structure to 0 which should at least be benign in axi_chan_config_write(). Also fix
what looks like a cut-n-paste error when initializing config.hs_sel_dst.

Fixes: 824351668a413 ("dmaengine: dw-axi-dmac: support DMAX_NUM_CHANNELS > 8")
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

v2 - Use static initializer for 'config'. Drop the memset() call.

---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 79572ec532ef..9a9194da0dcb 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -373,7 +373,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 				      struct axi_dma_desc *first)
 {
 	u32 priority = chan->chip->dw->hdata->priority[chan->id];
-	struct axi_dma_chan_config config;
+	struct axi_dma_chan_config config = {};
 	u32 irq_mask;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
@@ -391,7 +391,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
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

