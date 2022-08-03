Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967658934E
	for <lists+dmaengine@lfdr.de>; Wed,  3 Aug 2022 22:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiHCUew (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Aug 2022 16:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiHCUev (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Aug 2022 16:34:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB515C345;
        Wed,  3 Aug 2022 13:34:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C46ED1FAE3;
        Wed,  3 Aug 2022 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659558889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eH4d+cyTHh9Ne0by5EuH9phhvC2M0+I+zjkaxlqYSRw=;
        b=tZSRtXKixcrCXhZmSLOrTNzu+KpQiQ091+E26A2lEbquCcpHDd7wfdTFTNed0BFZzZnTum
        Xwnax2qIsCHZXEt33lWVrzmAhZJmTBFPAjBtD1/HHNj9kVNwXr6wpF9yUU7OZXQqVl3yHL
        HRpYesOBIUAQwawISFcoYiJl1ZjW2Uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659558889;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eH4d+cyTHh9Ne0by5EuH9phhvC2M0+I+zjkaxlqYSRw=;
        b=X+xUoaICE4BaQ9mLlL0b98Snh38eHhtyRlAAeTyF7MTJFlDC/1uXWWO2OSduN9u9Gm74xH
        dYkUug2yHnyRWRCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97C2F13A94;
        Wed,  3 Aug 2022 20:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /HiHI+nb6mLMLgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Wed, 03 Aug 2022 20:34:49 +0000
Date:   Wed, 3 Aug 2022 22:34:48 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] dmaengine: dw-axi-dmac: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20220803223448.6f08095b@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.18.orig/drivers/dma/Kconfig	2022-05-22 21:52:31.000000000 +0200
+++ linux-5.18/drivers/dma/Kconfig	2022-08-03 22:29:02.013889846 +0200
@@ -172,7 +172,7 @@ config DMA_SUN6I
 
 config DW_AXI_DMAC
 	tristate "Synopsys DesignWare AXI DMA support"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS


-- 
Jean Delvare
SUSE L3 Support
