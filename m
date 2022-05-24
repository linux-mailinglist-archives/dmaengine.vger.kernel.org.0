Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB7053246D
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 09:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiEXHwB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 May 2022 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiEXHvx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 May 2022 03:51:53 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FC734BB7
        for <dmaengine@vger.kernel.org>; Tue, 24 May 2022 00:51:51 -0700 (PDT)
Received: from localhost.localdomain (unknown [123.112.66.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ACB85417A8;
        Tue, 24 May 2022 07:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653378709;
        bh=hHnlyKqpmgZR2xICxJ0+9IQ86bWwQ2NoXHLCWrzMjYk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dNp/fEiv63zqa6fP1UU3shJTXeQ7UDik+e96vx7WKXuOctD91mJmrA+C8b8GugHg2
         EezcFY+HVZQE+SSEgeY1KFp6N1iyFq7YcMGkWIGmjCzB1Nd8T7gFx0VueOlDMlcTSD
         gf5AV+19BqW6Q1jVr3P0qQRqtFLvbRdEQjAp8RSrIQjSezmsvOtdbXgyXK727KIBll
         qwtwnK4wlR7QjjP00se/bQ8ctHSYcSGiH8rEtSwZoWAg6bjFakbjHk26QBeYZm/y9j
         e2P/sfC+wdfumknuMotL4SMpIViwY9xu3aixjYvcq4/hFUASikKbw7XO11BXnFeeog
         Sf+OMdLwwVGhw==
From:   Hui Wang <hui.wang@canonical.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org
Cc:     s.hauer@pengutronix.de, shawnguo@kernel.org, yibin.gong@nxp.com,
        hui.wang@canonical.com
Subject: [PATCH] dmaengine: imx-sdma: Setting DMA_PRIVATE capability during the probe
Date:   Tue, 24 May 2022 15:49:33 +0800
Message-Id: <20220524074933.38413-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We have an imx6sx EVB, the audio driver fails to get a valid dma chan
and the audio can't work at all on this board, below is the error log:
 fsl-ssi-dai 202c000.ssi: Missing dma channel for stream: 0
 202c000.ssi-nau8822-hifi: ASoC: pcm constructor failed: -22
 asoc-simple-card sound: ASoC: can't create pcm 202c000.ssi-nau8822-hifi :-22

Then I checked the usage_count of each dma chan through sysfs, all
channels are occupied as below:
ubuntu@ubuntu:cd /sys/devices/platform/soc/2000000.bus/20ec000.sdma/dma
ubuntu@ubuntu:find . -iname in_use | xargs cat
2
2
2
...

Through debugging, we found the root cause, the
crypo/async_tx/async_tx.c calls the dmaengine_get() ahead of
registration of dma_device from imx-sdma.c. In the dmaengine_get(), the
dmaengine_ref_count will be increased, then in the
dma_async_device_register(), the client_count of each chan will be
increased.

To fix this issue, we could set DMA_PRIVATE to the dma_deivce before
registration.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/dma/imx-sdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 95367a8a81a5..aabe8a8069fb 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2201,6 +2201,7 @@ static int sdma_probe(struct platform_device *pdev)
 	for (i = 0; i < sizeof(*sdma->script_addrs) / sizeof(s32); i++)
 		saddr_arr[i] = -EINVAL;
 
+	dma_cap_set(DMA_PRIVATE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_CYCLIC, sdma->dma_device.cap_mask);
 	dma_cap_set(DMA_MEMCPY, sdma->dma_device.cap_mask);
-- 
2.25.1

