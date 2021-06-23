Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70493B187C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jun 2021 13:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFWLK0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Jun 2021 07:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhFWLKC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Jun 2021 07:10:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944D0C061574
        for <dmaengine@vger.kernel.org>; Wed, 23 Jun 2021 04:07:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so3726326wms.1
        for <dmaengine@vger.kernel.org>; Wed, 23 Jun 2021 04:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3XSjAUgIycOsJaRGQxufljkRRuVDo+N2vgMRUqZcmE=;
        b=Oo9my/B/3iFQsW7qS44zdQpsS7K4uAcB+Yv8Tf9MP+bVEF20P/gELD9ckgd/6BSva5
         HBfOWZHPTQIRbAkryQy4dJ3wAfuj5XDTT/b5SugRd2866VuAz89AIkMhrh/4NUEnhiU1
         Ng6Far7MXTa5RLmfIXk+MLDwHg8zRY/sGpOwq3sHep2ii8resl7nWMcf1fSXXrZfCiC1
         8gI+aib24vowbmh3By/8RxfqhZ9AaTyffJYGdtgNkEG0hzT0T/QwZpj/ppSdGwAKtMUF
         7ytJh2YLcSuIWr6oe3sPWWs/i2JgC+UKs5fLtiXc1961gsFt4B9PoLIIEBz0Pc7FutDQ
         1F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Y3XSjAUgIycOsJaRGQxufljkRRuVDo+N2vgMRUqZcmE=;
        b=TrOViroRGztA3sMDE1/CiYvV+sIxPgM7aCPpChxO/jbG5tq2trGqccRQY0DECKFmfy
         NPshWbbjidUC4BGdVCGq3KKnJ3Wjl81qH/axD/RupJzdoAkhBnfjejHXvRbfnkhvYrxp
         qAtedvo9e+jizStVYOcdpJ0zn4fpRfJulSo0H6Q7JY2+pRCHZ2rfb7atrd41ulf3geCn
         kvfD2lSar6v+UYXIAeEYTa8bCV+w1nEdCfyhh1ltdYs4UcWGaYUEv+HoF163fUbm+XHv
         sgM0TGDpfW14sPYGizEW5LepEa4NA08A3MD6CIP+Od/yOL9dIxBFH2Tj8kIhYw8iPJ4y
         lmKw==
X-Gm-Message-State: AOAM532DHdy/VMFobZgPdlmWcWyL47DhGGNuA5Qifb4slexSMM97YADu
        GHZmDYb6ajAdajiOBoxqQ+UiMQ==
X-Google-Smtp-Source: ABdhPJwfHKLqQcbSufJeAPQZzKJKDt4BAEHiNDkqYgH8qODWgBBV2zqXwRUSgYbDVnObyxRuJm4yKg==
X-Received: by 2002:a1c:f215:: with SMTP id s21mr10248788wmc.179.1624446460184;
        Wed, 23 Jun 2021 04:07:40 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::648])
        by smtp.gmail.com with ESMTPSA id s5sm2701475wrn.38.2021.06.23.04.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jun 2021 04:07:39 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: xilinx: dpdma: Fix spacing around addr[i-1]
Date:   Wed, 23 Jun 2021 13:07:38 +0200
Message-Id: <ef7cde6f793bfa6f3dd0a8898bad13b6407479b0.1624446456.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use proper spacing for array calculation. Issue is reported by
checkpatch.pl --strict.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/dma/xilinx/xilinx_dpdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 0b67083c95d0..b280a53e8570 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -531,7 +531,7 @@ static void xilinx_dpdma_sw_desc_set_dma_addrs(struct xilinx_dpdma_device *xdev,
 	for (i = 1; i < num_src_addr; i++) {
 		u32 *addr = &hw_desc->src_addr2;
 
-		addr[i-1] = lower_32_bits(dma_addr[i]);
+		addr[i - 1] = lower_32_bits(dma_addr[i]);
 
 		if (xdev->ext_addr) {
 			u32 *addr_ext = &hw_desc->addr_ext_23;
-- 
2.32.0

