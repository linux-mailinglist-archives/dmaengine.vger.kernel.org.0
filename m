Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7370410C05
	for <lists+dmaengine@lfdr.de>; Sun, 19 Sep 2021 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhISOpt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 19 Sep 2021 10:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhISOpm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 19 Sep 2021 10:45:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C7DC061574;
        Sun, 19 Sep 2021 07:44:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 203so5946123pfy.13;
        Sun, 19 Sep 2021 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10LUk0W8IOVg0OUZbJtJhF1cbYBC9z6X1SxaX5YYh8Q=;
        b=jXrpgOxNs1ZU4+Il79/OZ0GDGWHMWM3co+agqBxXG1C0LXni2VRZDzrF1XK44Fuqw/
         9+zLm3sR26nXysMyUTrAnc5L0AQocUUwpCDDhlgacYRtrhgP5N/EfMoTEh1iCWlO4AfP
         kCoUvfMP9EiZS/9Q/Uf4rlFsHoCdYoDk/n4IctmVpMnbWcJuR6LJKiw3rT/HgT44Jnmy
         YN2t73z1to2BxFjsUsIVnF5ERc3ciwPYAQiC6vnIxFwuD8GobVG9YPFttzonpRHm7R0C
         DjoO8MEHM5VcdOhsr5YSXCjZbQFTe7bBaZSvW35uGpEXuFWaERq644INgPAmLcYVBGbG
         grpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10LUk0W8IOVg0OUZbJtJhF1cbYBC9z6X1SxaX5YYh8Q=;
        b=Zj1rycWVOSAoDjcZoq1bHux/jhdwsVE2r8u0muHfufWdzA4E5OF4Mjs6TmGl/h07mi
         NWsSdyPuZ2umg7r1IWHv4Fnp4pNFf2T/HxIeQ+k/tju7x59JJqBpwmxmWQLqlGxE22GD
         aqszi2zTHpW4+xvWY3x8ZxEKjWjPmy5q/cONuv9huqA/H8beJ5uvo1rcaymJpQ0QC3IH
         1qcNOiPszREPNY8kmyH7NYQT6FXyNFm4+c3ZwTnqL+svGzzAx7XcQfeIKhoOQoU6jSxb
         UBaaDgc4LAI+ItjQ6ar5G13WdBeYKIn+NRxhDng2zL0BTFLi0f+S81SEjw6sgm5GpcDP
         1DVg==
X-Gm-Message-State: AOAM531wsaEkzVP7qDOiYjiX/XjrslvmZsFJwGQmsYKOxzDzCD4km/m5
        MxG2WO/DBZTX3c0Qbsm7dsWbrYmfKXoPL7kX
X-Google-Smtp-Source: ABdhPJxOOgxA2vAtef/IbEwk3K61jYYWuTeN+IeIIDc8wVeGFEl6SXwrGd3nASGBeRGcNZJtX9P40w==
X-Received: by 2002:a63:7f58:: with SMTP id p24mr18973660pgn.203.1632062656317;
        Sun, 19 Sep 2021 07:44:16 -0700 (PDT)
Received: from skynet-linux.local ([106.201.127.154])
        by smtp.googlemail.com with ESMTPSA id c9sm16270427pjg.2.2021.09.19.07.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 07:44:15 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3/3] dmaengine: qcom: bam_dma: Add support for immediate commands
Date:   Sun, 19 Sep 2021 20:13:21 +0530
Message-Id: <20210919144322.31977-4-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919144322.31977-1-sireeshkodali1@gmail.com>
References: <20210919144322.31977-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Immediate commands are needed by the IPA driver to send commands to the
IPA controller over BAM. To support immediate commands, all we need to
do is set the relevant flag in the descriptor.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/dma/qcom/bam_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index c8a77b428b52..cebec638a994 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -58,6 +58,7 @@ struct bam_desc_hw {
 #define DESC_FLAG_EOB BIT(13)
 #define DESC_FLAG_NWD BIT(12)
 #define DESC_FLAG_CMD BIT(11)
+#define DESC_FLAG_IMM BIT(8)
 
 struct bam_async_desc {
 	struct virt_dma_desc vd;
@@ -651,6 +652,8 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
 		do {
 			if (flags & DMA_PREP_CMD)
 				desc->flags |= cpu_to_le16(DESC_FLAG_CMD);
+			else if (flags & DMA_PREP_IMM_CMD)
+				desc->flags |= cpu_to_le16(DESC_FLAG_IMM);
 
 			desc->addr = cpu_to_le32(sg_dma_address(sg) +
 						 curr_offset);
-- 
2.33.0

