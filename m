Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE854169AC2
	for <lists+dmaengine@lfdr.de>; Mon, 24 Feb 2020 00:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBWXS3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 Feb 2020 18:18:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55566 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBWXS0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 23 Feb 2020 18:18:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so7177675wmj.5;
        Sun, 23 Feb 2020 15:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D226Q712hm4RRuLjuRLwvzFIxXTYHeeP4FIQmGcb/n4=;
        b=GCLwLyyF5ZoS6d1OmnyDt1cTIkPYcFUnQewizYiPNQ5Ombi1m0z17U0Krh/rOyOkn4
         n/Lc0hrlyUSfl3Fwv+bRNjPqgyHv8WnWsf2K36q9iXs4xQBQFhovuQH4CyTn8DWIp6WY
         AVdnQxUK2GhvjAlHrepv5euNhFIhhlxmSN4b3/7PIHcAFnT5wmB41qb2SDo45QOfBVWi
         RfO+9IF/OYARyUrm1WbG9pkWGpdEEz6OH0f2w8i1kM0zZAkFN5LmzTa9Y7iuxa/nDnAS
         ZhA3AFm6+1JRxWw0c+3J6/saRBfwGeI+cLXUGPf5tOtREVUIAD8EGjMKzp0KAED2OP4o
         ViUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D226Q712hm4RRuLjuRLwvzFIxXTYHeeP4FIQmGcb/n4=;
        b=VgY4x1uKfMT9EpSgGUPN6h2TMgyMWcoDK86GZBRPRfqXTgGG0jplICfPxBukOdcLeZ
         ZZpHLp6pEbO2KiqeCvBOFx6RI4/+pZLhu6CVcfHPJQkjukeEEbhQl/LWGiDrDG+ti+8O
         8uel0U2tJN9Uu0erWa4ZE2ZK546rGGZ/I9PzxnZzUnJFy3neMjn/u7CydVOEjmSz8X+T
         RZHv+X8A5/RwWe6sJylXMwKeWiWhnE3Musa8SCjcfQ4VSeKTFBo5Ww6tYs1ugohVilk8
         +cvH8FDbb08QHUET21Ze93rDTN9LX+4WH135Ea++pyaTipUiNRQH8q0XOCt2pnFKFh+W
         I47Q==
X-Gm-Message-State: APjAAAUwWJPhq+0/lmjFCSeVKw8q70ui/LMDGjIyKvCVZuxF42T5XprR
        1vNkn1BWKpxJeawXRFpZhw==
X-Google-Smtp-Source: APXvYqxbSpeNGF2MlyRcH36FppSj1XVmUcZHhQGSkPs2u0+P5CusVXHN5m8U3eJCh0HQtgoHaUvzpA==
X-Received: by 2002:a05:600c:414e:: with SMTP id h14mr17871964wmm.179.1582499904465;
        Sun, 23 Feb 2020 15:18:24 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:24 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE
        SUBSYSTEM)
Subject: [PATCH 24/30] dmaengine: mic_x100_dma: Add missing annotation for mic_dma_tx_submit_unlock()
Date:   Sun, 23 Feb 2020 23:17:05 +0000
Message-Id: <20200223231711.157699-25-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sparse reports a warning dma_cookie_t mic_dma_tx_submit_unlock()

warning: context imbalance in  mic_dma_tx_submit_unlock()
	- unexpected unlock

The root cause is the missing annotation at  mic_dma_tx_submit_unlock()
Add the missing annotation __releases(&mic_ch->prep_lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/dma/mic_x100_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/mic_x100_dma.c b/drivers/dma/mic_x100_dma.c
index fea8608a7810..d15c41151d09 100644
--- a/drivers/dma/mic_x100_dma.c
+++ b/drivers/dma/mic_x100_dma.c
@@ -236,6 +236,7 @@ static inline void mic_dma_update_pending(struct mic_dma_chan *ch)
 }
 
 static dma_cookie_t mic_dma_tx_submit_unlock(struct dma_async_tx_descriptor *tx)
+	__releases(&mic_ch->prep_lock)
 {
 	struct mic_dma_chan *mic_ch = to_mic_dma_chan(tx->chan);
 	dma_cookie_t cookie;
-- 
2.24.1

