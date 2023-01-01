Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4C65AB33
	for <lists+dmaengine@lfdr.de>; Sun,  1 Jan 2023 20:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjAATgL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 1 Jan 2023 14:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAATgJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 1 Jan 2023 14:36:09 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33791009;
        Sun,  1 Jan 2023 11:36:08 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E85083200564;
        Sun,  1 Jan 2023 14:36:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 01 Jan 2023 14:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672601766; x=1672688166; bh=9W/vOLrywVvKMEM2uXRK7f90y
        c2YFYC7zHPiaMO2kvI=; b=MTgHuoFOyP2Q7o25ivfGtCeyUEUurVIftwEy4KFRx
        noEyaoZj2SnW6rhnJGCshxZBXYReF/wLx6ZrirDJIOGSOJP9LKgOaStNgydRbIbP
        1dUjVGjzkSmY/EscHg+IUjLju7T2TA9NgBaK+/qcMQJ5lXCI2UfgQaDbHic38ciw
        JAZTxtG6jHFU/zvwkHSx9iV+1JNLcn+CkmDl4916cvV/KvINbgel81UdBDPEGImt
        /He5xtoODZLmFr6iwtqn9hWKxmdvC/Y1nELdNgPfUKOajfHfylc7jn9wr3YpV55t
        T3T/KFDYJEDkJOdXti3371TfTh6b1GKPUrHVN1VC4+DfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672601766; x=1672688166; bh=9W/vOLrywVvKMEM2uXRK7f90yc2YFYC7zHP
        iaMO2kvI=; b=UU9AeY6IbGbUKbLkNsnZny/m407i0I3VPsquPDrDm2uATAKhGep
        i59KtZrzEKIZpKMalqWOvDPeiS+jULOhkT5lG30e7ep/CRrwKjPamrbCahSlNP9i
        lYgkOv8Ggy20oTRPG6bhej1aZbW/wTPMOwlGa2qn0ugfVnVBOyKCjc1V3SqlXtzc
        0GfxxYybkikcLlO3+Ids2m3vSPG/fdPtZI8wkHWOy7iDBUkfPsUspa1WwukZkNii
        UTAaSj6TykvPVIJqplO+O6YNKniiqm4SRbfrGdfBTalo4vgWhTl7/fFdGc1MF8Vm
        FYQjY4DYWXsOj+kc+dWVGZXINF2AZFyZktA==
X-ME-Sender: <xms:puCxYwIvA2nnXIPC9gdiLsM22_XYmEl63OyI8UuAsFJSGcjPAAi7fw>
    <xme:puCxYwLsZOw6yGEjP0Cg3mpMyfpbp7Hvi_sV_Zs8bAg3KdWjO_NO9Uo7jtbjLpc5S
    I51dQeJiy3ON9nQpQ>
X-ME-Received: <xmr:puCxYwuhOpiEf9fonovirX0i3wRvNI_7mx4sy6H7ZpQWKI_8xwpCzZbpSpwKmAY4fVvPAruS0JYhNr-3xuszyj0TQR_5MLB4eVIOLuYHAuJgazn-mzR4tEWEO-iJ0ByGW0LF0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedtgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:puCxY9bfrcKoyLBNKERtrf6nMoUdv8I9OPsPA_hfjQYSWecJWX3BGA>
    <xmx:puCxY3ZWrkSGD_XL0AYcUCazhcq_LCkc_jhQ3S16dApFZET4iiZV7w>
    <xmx:puCxY5Bwl2nPjqLjehc83FmOeDVIsfBirPCVilMgcYzFMFaOB7JDzg>
    <xmx:puCxY8NYgmjdBWYfo6AhkwkC0KYRj79vuxHyXVgh7XEEHitZLMVI3A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jan 2023 14:36:05 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2] dmaengine: sun6i: Set the maximum segment size
Date:   Sun,  1 Jan 2023 13:36:04 -0600
Message-Id: <20230101193605.50285-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The sun6i DMA engine supports segment sizes up to 2^25-1 bytes. This is
explicitly stated in newer SoC documentation (H6, D1), and it is implied
in older documentation by the 25-bit width of the "bytes left in the
current segment" register field.

Exposing the real segment size limit (instead of the 64k default)
reduces the number of SG list segments needed for a transaction.

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
Tested on A64, verified that the maximum ALSA PCM period increased, and
that audio playback still worked.

Changes in v2:
 - Use SZ_32M instead of DMA_BIT_MASK to make the limit more obvious

 drivers/dma/sun6i-dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index b7557f437936..30667d251e97 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
 #include <linux/interrupt.h>
@@ -1334,6 +1335,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&sdc->pending);
 	spin_lock_init(&sdc->lock);
 
+	dma_set_max_seg_size(&pdev->dev, SZ_32M - 1);
+
 	dma_cap_set(DMA_PRIVATE, sdc->slave.cap_mask);
 	dma_cap_set(DMA_MEMCPY, sdc->slave.cap_mask);
 	dma_cap_set(DMA_SLAVE, sdc->slave.cap_mask);
-- 
2.37.4

