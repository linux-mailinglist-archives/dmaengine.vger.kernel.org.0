Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B019D53E5D5
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jun 2022 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiFFPRU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jun 2022 11:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbiFFPRT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Jun 2022 11:17:19 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4766C04
        for <dmaengine@vger.kernel.org>; Mon,  6 Jun 2022 08:17:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C7937240009;
        Mon,  6 Jun 2022 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654528637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/u7Zre2RTjOtQbg5t7WQekZc1cvEp32HAoIfo2IIPz8=;
        b=Ao77GHLE7Sy6TiqdoiQOT0smX8p2/o3q09/M3SMU03kio1S4vXcRlUARfFc7LxDWE/ND2B
        moy03KgyWir1YsPsPOuK0lbzCpgMPpjQhocO5p8TGQot6VMCA2aWvM2iVKsK4s3+sNPR9Z
        CUYpjurPtowvGMDGBDljzwJXNeOR+RATIFtCGMTPj9sudyvtpg4a4gSfB8cT4uILx5BUiy
        KFWo45aqK1bulXNB+MybhrUZtT/uk88rcxbccMj4RNoZERB+ZcnKEaC7CA893KZ1OoTNmc
        mgloXCofGTljtOMxR0m4DGRBKz+Sx3Sz/HvMFGZJCBNijTf/lEwERt07jKBP+g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] dmaengine: dw: dmamux: Fix build without CONFIG_OF
Date:   Mon,  6 Jun 2022 17:17:13 +0200
Message-Id: <20220606151713.33682-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
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

When built without OF support, the match tables are not used and may
produce the following output:
>> drivers/dma/dw/rzn1-dmamux.c:105:34: warning: unused variable 'rzn1_dmac_match' [-Wunused-const-variable]
   static const struct of_device_id rzn1_dmac_match[] = {

One way to silence the warnings is to define the structures with
__maybe_unused.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/dma/dw/rzn1-dmamux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 11d254e450b0..45aba783cfbe 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -102,7 +102,7 @@ static void *rzn1_dmamux_route_allocate(struct of_phandle_args *dma_spec,
 	return ERR_PTR(ret);
 }
 
-static const struct of_device_id rzn1_dmac_match[] = {
+static const struct of_device_id __maybe_unused rzn1_dmac_match[] = {
 	{ .compatible = "renesas,rzn1-dma" },
 	{}
 };
@@ -136,7 +136,7 @@ static int rzn1_dmamux_probe(struct platform_device *pdev)
 				      &dmamux->dmarouter);
 }
 
-static const struct of_device_id rzn1_dmamux_match[] = {
+static const struct of_device_id __maybe_unused rzn1_dmamux_match[] = {
 	{ .compatible = "renesas,rzn1-dmamux" },
 	{}
 };
-- 
2.34.1

