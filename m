Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51C84EDAB6
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 15:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbiCaNnP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiCaNnO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 09:43:14 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C239D214F8C;
        Thu, 31 Mar 2022 06:41:26 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2E6391BF20D;
        Thu, 31 Mar 2022 13:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648734085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sFKjxQf/ZWijetPC66x59cvgbyQoeOo0ccVgS3BwPH8=;
        b=Kv4MYuUSXWAkY024BhJEbVLN3Xkj+VijVs/QKG/gKxc1YK7H/enocTPNHEmT8hip9U0LEH
        QLAMH8ei223plu3zy4DSm+Sh7tFkRgTcvsvZuV5tcGywYVi6l0r7hCUGehrDCDFts3w5X5
        2aVwxfd+QbnP2YFNsHcmi+pz1Ws9jvRSY/YgxvV5Xxj1wOv/kE+d0z+ZgDKj6tAWdbaSlZ
        s1oeaA69j8+VxKykfSl2YA1vG3nuDRmyuqCAemwggos+8KdHse+pSkC9Lvp57qhjMw2LzZ
        Ej37Ez3K4uFLT1qNSd2jWTqVLnlJ5pidIGzpLm1WToQN0uPWKF+CsYs2hZ2/3A==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] dmaengine: Clarify cyclic transfer residue documentation
Date:   Thu, 31 Mar 2022 15:41:14 +0200
Message-Id: <20220331134114.703782-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

The current documentation for the residue reported in a cyclic transfer
case mentions that the reported residue should be relative to the current
period only. However the definition of DMA_RESIDUE_GRANULARITY_SEGMENT
specifies that the residue should be updated after each period for
a cyclic transfer, which is in direct contradiction.

Moreover the pcm_dmaengine common code uses the residue relative to
the whole cyclic buffer size, not one period.

Correct the residue-related documentation to reflect this.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 Documentation/driver-api/dmaengine/provider.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 0072c9c7efd3..d3fa80e333b1 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -457,7 +457,7 @@ supported.
   - Should use dma_set_residue to report it
 
   - In the case of a cyclic transfer, it should only take into
-    account the current period.
+    account the total size of the cyclic buffer.
 
   - Should return DMA_OUT_OF_ORDER if the device does not support in order
     completion and is completing the operation out of order.
-- 
2.35.1

