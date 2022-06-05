Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56F53D9E4
	for <lists+dmaengine@lfdr.de>; Sun,  5 Jun 2022 06:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347730AbiFEE1r (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jun 2022 00:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiFEE1o (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jun 2022 00:27:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F79591;
        Sat,  4 Jun 2022 21:27:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so10058159pjf.5;
        Sat, 04 Jun 2022 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=377P3GiWS6Ja0VuhpiPDuucDoOAmDK/eKfkp6EhTFu0=;
        b=X85GBKZBZtOcq0fc0p0F1LsVMB7NR1tG1Hvek8LcFIjq86FSUD/JGGaNynv4gUsr1L
         CFKlaYXrrB7llvna83z5QJU9ePW/nsFrA8ckU/NZgFcc7/9oLcdob6kqkZR9wP1AiF/M
         LJKwYrvGZueAi5bhxpLue2sMeJ78YfXmuMzsJurvRyOituj/4JnUjPo41UPFMgc7uuuh
         Hf+IxdGkjFKe9ZAYEBPdlfuQGewD3PeSuCaophynmkMOe9V6NUm9LGyZdHeUfwe5Cg5h
         OQe5YqOjMbpJVQ9uOLrc6VoLckAkWHt+hgtNKoxyoFhbInnI+rDBwfZaS0xcj7Y0PX2Y
         UzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=377P3GiWS6Ja0VuhpiPDuucDoOAmDK/eKfkp6EhTFu0=;
        b=DNcrZ3yKgBkixi8wMAuQAgb3hrWxEi7u3wGD1jUmhJxM7FzebEiN9MLACkMftIwjHh
         T+XUEl6l69EfDw9a+DtFE0hI9d3jzgGJZvuVr0WdMF/ROtHZbGfTyXZZ6l0glvg7wcKn
         OB9NL8ygsfVezkJwRC8B5gyH/6jW+sK6AcPZtAYZ1DIcICtqJMDVAU6QH/4DYucC1/jK
         mlHzMUdgWEeJt/fGn7aEaon+tgeXPr1/YLGPzGt4MPPBBjoG9qUSsh1BWXIkPHmHgLUt
         7EbkaVVyXJNs231YrAD96/IS7oW3FDrS6xUo/FW1VD8zO/KacrH4mOZasjqOG1LFTNdj
         l9vA==
X-Gm-Message-State: AOAM531shYNfdjZVA+JELYDasst2E1LCHFSc39IF3ylActDSU3tJ9z6f
        ngck1HS7x8MNOx17AuZShyICPGshnEaiyFrV
X-Google-Smtp-Source: ABdhPJzxo4XeOAKt4AD34r+EC0Xh+YiEd4oZ4oCWInPjJj8pW5Jj9TJOHKSr7W7P/SZpK58XG6hl0g==
X-Received: by 2002:a17:903:213:b0:15f:4ea:cd63 with SMTP id r19-20020a170903021300b0015f04eacd63mr18088523plh.68.1654403262947;
        Sat, 04 Jun 2022 21:27:42 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id d62-20020a623641000000b0051baaa40028sm8316601pfa.11.2022.06.04.21.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 21:27:42 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v3 1/2] dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate
Date:   Sun,  5 Jun 2022 08:27:23 +0400
Message-Id: <20220605042723.17668-2-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605042723.17668-1-linmq006@gmail.com>
References: <20220605042723.17668-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not needed anymore.

Add missing of_node_put() in to fix this.

Fixes: ec9bfa1e1a79 ("dmaengine: ti-dma-crossbar: dra7: Use bitops instead of idr")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
v3 has no changes, just assemble two patches into a series so I keep
version consistent.

changes in v2:
- split v1 into two patches.
v1 link: https://lore.kernel.org/r/20220512051815.11946-1-linmq006@gmail.com
v2 link: https://lore.kernel.org/r/20220601105546.53068-1-linmq006@gmail.com
---
 drivers/dma/ti/dma-crossbar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/dma-crossbar.c b/drivers/dma/ti/dma-crossbar.c
index 71d24fc07c00..e34cfb50d241 100644
--- a/drivers/dma/ti/dma-crossbar.c
+++ b/drivers/dma/ti/dma-crossbar.c
@@ -268,6 +268,7 @@ static void *ti_dra7_xbar_route_allocate(struct of_phandle_args *dma_spec,
 		mutex_unlock(&xbar->mutex);
 		dev_err(&pdev->dev, "Run out of free DMA requests\n");
 		kfree(map);
+		of_node_put(dma_spec->np);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(map->xbar_out, xbar->dma_inuse);
-- 
2.25.1

