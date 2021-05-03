Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD23717F0
	for <lists+dmaengine@lfdr.de>; Mon,  3 May 2021 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhECP13 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 May 2021 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhECP10 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 May 2021 11:27:26 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86013C06138E
        for <dmaengine@vger.kernel.org>; Mon,  3 May 2021 08:26:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso5437718otl.0
        for <dmaengine@vger.kernel.org>; Mon, 03 May 2021 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:cc;
        bh=EI6bZyecXV+D4mAvyW1zNE2tx9yP9EY1VWyGEKOhGs4=;
        b=qeuOlliDGX/UXrFBQRGA+wZpGmrZ3HwhDOaBcLLbNorJFBQ4hQ9Q/6PhUtBuNeS8Aj
         au6pVFpGyoJApuOoR9hMvcsM3O/ekucc0pvsmba0X3h/ETYu8raP259toJ+B9EQmVv3U
         noQ0uvWbA3AQWM/Qk9dBt9TfYB86MQgd8kz3agg/3D5fZKr6N1NOHdVpSHKhVHkpQlbO
         GeOcTWWtTFUZMM+V3A3Em2sAhxFybQCvJI/ak4a4jeiX+fIB3AtFhVdTWrFtg63tw3xd
         QOgP2+GbpbYXfLlNvbH5jOyPPPAz8hsNULBRqJWfisA+Pml5+1NmzEMm7R5HvdDBlBGU
         Wc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=EI6bZyecXV+D4mAvyW1zNE2tx9yP9EY1VWyGEKOhGs4=;
        b=gbL73jATvqNXQhqiYwwkbE9cuiQsLKmhETIKT7Bwh3gAG/GRqIiD2mLZuG3EsEg7Oy
         momWDWxX61CJkCCtjZUs+UMStiD+sDiJ69vHwYO9HCSLE4ZdVPEerX1hAUleaWOHN4MC
         shlRzlFAiqQfTbC1IomAwU/Uz3gCPU9fzZpLOpT6jGDJN3xd8sOOyqsWxCKB6knB8Tj/
         rgwinQ+Y+4NdEme6GTQ6MLc6umTZlO3j+1UFIo1JUrHNr7rsB2BBK+b63zewgWwR7h+D
         c1N/uiTAI+tQC72ejGqJOnDBlbMOXkbERt1+jS8Zs5VGj0haM1CXZ7i7V7+s/iU11L6V
         rcaA==
X-Gm-Message-State: AOAM5323gt4ziwR+r4elkzPFeRY/3nqTsxW46iLKA/Bosgo+lWnd+WO7
        aaRE7HGtUXRbJrAnETl7y97BjV8l3a8NaE31nB49Ww==
MIME-Version: 1.0
X-Received: by 2002:a9d:2f24:: with SMTP id h33mt13304199otb.128.1620055591994;
 Mon, 03 May 2021 08:26:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 08:26:31 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Mon, 3 May 2021 08:26:31 -0700
Message-ID: <CABnWg9scYTkZ242STBop4yXNKsEzgd1gsGoZQzvrurL5nYhUQw@mail.gmail.com>
Subject: [PATCH 3/4] dmaengine: mediatek: use GFP_NOWAIT instead of GFP_ATOMIC
 in prep_dma
Cc:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As recommended by the doc in:
Documentation/drivers-api/dmaengine/provider.rst

Use GFP_NOWAIT to not deplete the emergency pool.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c
b/drivers/dma/mediatek/mtk-uart-apdma.c
index 249cabddb7ee..4711bec04b98 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -349,7 +349,7 @@ static struct dma_async_tx_descriptor
*mtk_uart_apdma_prep_slave_sg
 		return NULL;

 	/* Now allocate and setup the descriptor */
-	d = kzalloc(sizeof(*d), GFP_ATOMIC);
+	d = kzalloc(sizeof(*d), GFP_NOWAIT);
 	if (!d)
 		return NULL;

-- 
2.26.3
