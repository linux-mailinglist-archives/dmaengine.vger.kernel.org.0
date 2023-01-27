Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5767F133
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jan 2023 23:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjA0Wgd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Jan 2023 17:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjA0Wgc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 27 Jan 2023 17:36:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1EC7962C
        for <dmaengine@vger.kernel.org>; Fri, 27 Jan 2023 14:36:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id be8so6392721plb.7
        for <dmaengine@vger.kernel.org>; Fri, 27 Jan 2023 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XC/ZtupLdVIFnH4AYiQA4jmFziyUHbnRtJG+3+/tCsc=;
        b=EZGajsagK5eienkyoS96UjeiRheeePkkC4C7hYG+ey9XSMt8/0jAKjnSZPtcWLW9YT
         X6IsiPfAfwBJWzypwCCp0AzdhVKZ98t6tmNQcBOu70FSjf5qWIW66ECNKAGSPU1dyThQ
         QqPIUQbGECw3JswGTM5fvQmSyssLeFqOWT2So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XC/ZtupLdVIFnH4AYiQA4jmFziyUHbnRtJG+3+/tCsc=;
        b=g7sv88gougt6RrXAcFIq8UTbG0dZF8zgbQirF8p4GBHfIdtutFB33Qk6EHzsydV4gQ
         pqwvwPnoodZ1n7YWkjjYhd4P7H9Tya1ksC7ZHjiPVOJxQyCJTY06vEc/krSkjyq4JUrM
         MLmIOVJesNUwTLlr0KEP1uhsHzsoJcl3bN/9FhxxzxFevynA+A0J4z7ekuTem5GF5dc+
         4a0/QCCSFFjBQpQIIl/46QP3xxrm1KFCiCPBhDt/z67jW9BGKP9+YFFb3xvhG64P+r13
         c3xZww6rJpYikJTEYSdkRZ/lVFI56jI/rKkWWGTLbOOYgtp6J+AmFNSKzc1EQxku8ixr
         nTnw==
X-Gm-Message-State: AO0yUKXIhNcRIosCex/qAZ6774Alsyi8aFXsIvqG9gCVOasSyP9ecIUh
        ON75RR611fw4F5JF0hW9/Rh3oQ==
X-Google-Smtp-Source: AK7set9atx6UuUzgfZ2X1Ud6LFbu6CCaARj0/duoDv4C/zvhMhgOSrXPcfoMg0atHiSD8YrmsgB6CA==
X-Received: by 2002:a17:90a:199:b0:22c:59c3:8694 with SMTP id 25-20020a17090a019900b0022c59c38694mr2063430pjc.44.1674858990947;
        Fri, 27 Jan 2023 14:36:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090a498e00b00229ff1fd7e0sm5483285pjh.14.2023.01.27.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:36:30 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     Kees Cook <keescook@chromium.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] dmaengine: dw-axi-dmac: Do not dereference NULL structure
Date:   Fri, 27 Jan 2023 14:36:27 -0800
Message-Id: <20230127223623.never.507-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; h=from:subject:message-id; bh=KrlH9ZeOH9yS+IOvCO4GDgstUfRQh+z+WHGLR1SyBGc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FHr9Chm0fhuNsD6+VwC2IRTo0J1tq8/rBdG7b0b dgCyYFyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RR6wAKCRCJcvTf3G3AJitlEA CdckUnqQGuixVX0bMwrQLwKqhy9ZLNZDE+qU9WCjS6xribOcn6s/nkIbrmKGNKRNvHh0ksDj6n3X77 CmzaYG3S4gQtKejrLAwy2MKAGiYER1d12M4vG8lEl2VPuzqKm/95lO5XsEa70+M7Rrtp5Y0z1N3d4D H8KmbBjl8ykeU0UkjIdzbFsDrwH/vqqBFvpQZKLDPQNlrnLSTsrr3b7nPF+zLSRvaO11nMetQK1Ajh sElxIzu8TOuFw0EX6GQXufpolgGvqqAzGHucyD8p0nC1Qn3kU600L5RleEQglP1NPscjAtXQVGjwdp nzHFfVZQVv1jzfW9u8cxnoxqqcu32QPjRPGDhiFY3DuFQv12AKA9JN3tLsuf2mUE99cCSw84xqOouk QxgHZ8P8147+aPOexFI39IBFM+G5+20BB7/Kag4AL1jj0wh6oD6CYcR8DgcMkpKWsrLuAH8z7b62+j jKu1cCiTDJpiTjdkphquCgbPek+TPTfAYrIv7BHbvoGSM9SuWCyik0P9wCPJV45mbFvjSop6NBtyRY Rq8XhrMuCCsoOQHFZpebkxc7cztNt+hKj8DG5tzFtxeX4cCnDry1hv74joITlcEMfDEViaeTdPO/6G ouf8wHzo5paqmOJVcpQqPxONKH2M6CbnWHopOl2SK0mXVVDE9l7evJePig0w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If "vdesc" is NULL, it cannot be used with vd_to_axi_desc(). Leave
"bytes" unchanged at 0. Seen under GCC 13 with -Warray-bounds:

../drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c: In function 'dma_chan_tx_status':
../drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:329:46: warning: array subscript 0 is outside array bounds of 'struct
virt_dma_desc[46116860184273879]' [-Warray-bounds=]
  329 |                 bytes = vd_to_axi_desc(vdesc)->length;
      |                                              ^~

Fixes: 8e55444da65c ("dmaengine: dw-axi-dmac: Support burst residue granularity")
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 08af483331fd..4169e1d7d5ca 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -325,8 +325,6 @@ dma_chan_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 		len = vd_to_axi_desc(vdesc)->hw_desc[0].len;
 		completed_length = completed_blocks * len;
 		bytes = length - completed_length;
-	} else {
-		bytes = vd_to_axi_desc(vdesc)->length;
 	}
 
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
-- 
2.34.1

