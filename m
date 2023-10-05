Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEB77BA5B4
	for <lists+dmaengine@lfdr.de>; Thu,  5 Oct 2023 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbjJEQTG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Oct 2023 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241138AbjJEQQq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Oct 2023 12:16:46 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04987D68;
        Thu,  5 Oct 2023 09:02:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAC271BF204;
        Thu,  5 Oct 2023 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696521759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCLnsJGsiyoluV0LAjwd+krd3tUOX8QFfVoMfa2/x2E=;
        b=R+4NfyxjPPiY9r8zv+NkRP26PmJku2Kych4OR0oLfZ5CP2c9Rcd6M+lkIs+BmDXZJjI+6/
        m/rqfEYUiod+KgQA6CQe5tkQRhAdCHIluW9L7gdfUgEK96IDKzAlYV/QNJrEMODGJDdP8Y
        AkfhmuP0nhxpr+INSWwgfWQLHCDVYinAWIQKgIQ+KeG6UuugAQHLfo8a7fE4+wEOHch2If
        nNVuwACqnXl3jRokYLu1MMtFMMpIbvUVGb9bRvHItInabxE6JsBjG8Qk1O1OUFSbCVIaPV
        HRI4K5QmXti6nB/T3Aj+0h8VG3NBmcjpTXrWjundS8wKAXcQ6yCW+PqWdWeAwA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
        Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
        Vinod Koul <vkoul@kernel.org>, Michal Simek <monstr@monstr.eu>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 1/3] ASoC: soc-generic-dmaengine-pcm: Fix function name in comment
Date:   Thu,  5 Oct 2023 18:02:35 +0200
Message-Id: <20231005160237.2804238-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005160237.2804238-1-miquel.raynal@bootlin.com>
References: <20231005160237.2804238-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

While browsing/grepping in the sound core, I found that
snd_dmaengine_set_config_from_dai_data() did not exist, in favor of
snd_dmaengine_pcm_set_config_from_dai_data(). Fix the typo.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index d0653d775c87..cad222eb9a29 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -44,8 +44,8 @@ static struct device *dmaengine_dma_dev(struct dmaengine_pcm *pcm,
  * platforms which make use of the snd_dmaengine_dai_dma_data struct for their
  * DAI DMA data. Internally the function will first call
  * snd_hwparams_to_dma_slave_config to fill in the slave config based on the
- * hw_params, followed by snd_dmaengine_set_config_from_dai_data to fill in the
- * remaining fields based on the DAI DMA data.
+ * hw_params, followed by snd_dmaengine_pcm_set_config_from_dai_data to fill in
+ * the remaining fields based on the DAI DMA data.
  */
 int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct dma_slave_config *slave_config)
-- 
2.34.1

