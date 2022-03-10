Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252834D4DBD
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiCJP7a (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 10:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbiCJP72 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 10:59:28 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723AE15F35C;
        Thu, 10 Mar 2022 07:58:22 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 00C9E20000E;
        Thu, 10 Mar 2022 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646927900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpeaOG5nnpAyO8y3G2f6g1+6+hMraPiSI/fGW8VNsxA=;
        b=TEVMrhgQq3tlKTNn5B6TRrXzOVlX9oTS0RJCPcVG1CZh5DVBOOoXt5zIR0Vjaq9GcqYGFv
        4S+3KNXlInNGHQvRpKSY3SKiMIiHkAL+uoifgaNRBDX/M8P+3h/57fzxIxP5I4V/xtnKYb
        cDgAaOukkPMGrgfknxu7vi0Fp8Wf4XK+dcBP//5uZnhIVNJ27B3LK57GwpPqn44G4AeCs1
        5mFuEqkEOnjSQ0SxkVXc5kRcwphmdHzcAWbgIVwF0AmsbgAd8JZs8Rpab46k346CdqS+qf
        YQwjMMetNCW0AbtQdm/cXZelj85BwjZxx/tEVw0Nb1O1mRwsAgwCn3n7ffKhxA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 7/9] dma: dw: Avoid partial transfers
Date:   Thu, 10 Mar 2022 16:57:53 +0100
Message-Id: <20220310155755.287294-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220310155755.287294-1-miquel.raynal@bootlin.com>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

As investigated by Phil Edworthy <phil.edworthy@renesas.com> on RZN1 a
while ago, pausing a partial transfer only causes data to be written to
memory that is a multiple of the memory width setting. Such a situation
can happen eg. because of a char timeout interrupt on a UART. In this
case, the current ->terminate_all() implementation does not always flush
the remaining data as it should.

In order to workaround this, a solutions is to resume and then pause
again the transfer before termination. The resume call in practice
actually flushes the remaining data.

Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/dw/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index 7ab83fe601ed..2f6183177ba5 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -862,6 +862,10 @@ static int dwc_terminate_all(struct dma_chan *chan)
 
 	clear_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags);
 
+	/* Ensure the last byte(s) are drained before disabling the channel */
+	if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
+		dwc_chan_resume(dwc, true);
+
 	dwc_chan_pause(dwc, true);
 
 	dwc_chan_disable(dw, dwc);
-- 
2.27.0

