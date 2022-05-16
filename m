Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A50528391
	for <lists+dmaengine@lfdr.de>; Mon, 16 May 2022 13:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiEPLyT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 May 2022 07:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiEPLyS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 May 2022 07:54:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B486CE0E9;
        Mon, 16 May 2022 04:54:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y41so13778867pfw.12;
        Mon, 16 May 2022 04:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5SGYSEGadVU2eEjxvVDKszadunBHM/FO9yACqwpu1c=;
        b=H4Oe+7jyL6hakus/ITr5+rbSUQt0AB0yj4ewslfssmUAmFtDw5pu67Iy5wx3RIizk2
         ZU3mwdOYT81RAf4kzkZH2wxQ/3nLhz0oWnFKTgCjnmK7VRqV3H1sV9VM1CImxtciBjRO
         jPn7MQGxQvnrnuYD/02uwCBsN0kTqxeghkrAYlU2pp9fPreuTA5WDiO0qxM8jnPmv1ed
         oWPP2LnsAVUFpAdg1JM1JH7Qv4L0LevmVstHvKl31ECMvHhd3YAoUd913Dmdv9qJa+Fp
         pljqWM863JksfdbC5P9VLmzuw4v3MJJuMHahhXttOE+THmUnbqHQvMSfrdXbLfn3kV28
         ENUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5SGYSEGadVU2eEjxvVDKszadunBHM/FO9yACqwpu1c=;
        b=lW3AbCRSFZsq5zDewT2nSrYisfqLEalc07omsoyFWqldjcdbrqGQK0JlaHSLg1hWp/
         HVrNFU4AxTNLmM/wt1kiYkl1yiWYbqr28e5DZQqZpk6lmAim3wQBd62s9GBeWoO/8IPR
         RLlCeu3YSlPw8MejjPRVazz/oFMLYd4vVnEic7eyXNIjS3XPqgIPUIB38OWFTQ/7nnQy
         LAb2r8UqYg+PFGzhkMpxWfOtuO9GfDlTlObNyUcrIsT48IP63YGNU2JB4aKbSzdWiTfK
         2SjcxOXLLmsU52XiqlSqiEcA2xSqnuHmP0XvteeOUXqQkUIHalxCwQanJtBrUg5SnqbT
         qRUQ==
X-Gm-Message-State: AOAM530d44gvF0AdadnYuDigQVmSab69d2fYjgpaVYb0WcqdqQU+2m8t
        ap0lu0RLeYyacuQUk/NyXKs=
X-Google-Smtp-Source: ABdhPJxUxjxphtM5BwvrrUWYqPIN2shiAOI1UZkB+eFGzhsID3wNF46z6GJKlgYRkrh5guLjBOW+QA==
X-Received: by 2002:a63:ec53:0:b0:3db:822d:1e49 with SMTP id r19-20020a63ec53000000b003db822d1e49mr14804867pgj.134.1652702057221;
        Mon, 16 May 2022 04:54:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bb11-20020a17090b008b00b001df58f4649fsm1646010pjb.18.2022.05.16.04.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:54:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     vkoul@kernel.org
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        zealci@zte.com.cn
Subject: [PATCH V2] dmaengine: idxd: Remove unnecessary synchronize_irq() before free_irq()
Date:   Mon, 16 May 2022 11:54:12 +0000
Message-Id: <20220516115412.1651772-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YoI2ZRm3irWmqZDg@matsya>
References: <YoI2ZRm3irWmqZDg@matsya>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Calling synchronize_irq() right before free_irq() is quite useless. On one
hand the IRQ can easily fire again before free_irq() is entered, on the
other hand free_irq() itself calls synchronize_irq() internally (in a race
condition free way), before any state associated with the IRQ is freed.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
v1->v2:
	remove Reported-by: Zeal Robot <zealci@zte.com.cn>
 drivers/dma/idxd/device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5363fb9218f2..9dd8e6bb21e6 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1179,7 +1179,6 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 	struct idxd_irq_entry *ie = &wq->ie;
 
-	synchronize_irq(ie->vector);
 	free_irq(ie->vector, ie);
 	idxd_flush_pending_descs(ie);
 	if (idxd->request_int_handles)
-- 
2.25.1


