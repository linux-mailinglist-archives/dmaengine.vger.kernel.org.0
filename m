Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDA66AF5E8
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 20:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCGTkt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Mar 2023 14:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjCGTka (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Mar 2023 14:40:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2EC7E79D;
        Tue,  7 Mar 2023 11:27:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4743A61518;
        Tue,  7 Mar 2023 19:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC44C433D2;
        Tue,  7 Mar 2023 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678217224;
        bh=rffBK/cmJusylWS6PUrzcOSzwk1o9RC+zuh589MfdC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvpKij3f3hfUhNK4xgM7ZJdiEYz1vvjJdUfn7UuefjWY+t/Dufsy28uHfrOiZoY5J
         XX21sYnk/Meg3vP198fDFUKJPxvGa9ShQSXe58t3s7yF+tzWeTJEre14ItAAC9JmQL
         T7LsXgWaP9dJXp/6yT2eA5mJasbLA2PvHItzRiuQ343zzrgMf0cVUjr8TzWbKDz+xe
         KJ3LycXhy4t6wauyn9yFRSRYeb0cu3ha5s6xcdqO8EuVnvPMuhoSe0JxzVi+iCrfm9
         DiRMX2AMPwSzFL1ar+4pfCubTTOMqXcTfnN4ebwQgIgeNppSuJDVLY7aY64eQ3sijd
         Cd82dIYvYmXmQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 2/2] dmaengine: idxd: Remove unnecessary aer.h include
Date:   Tue,  7 Mar 2023 13:26:55 -0600
Message-Id: <20230307192655.874008-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307192655.874008-1-helgaas@kernel.org>
References: <20230307192655.874008-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

<linux/aer.h> is unused, so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 640d3048368e..a85efcda7095 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -9,7 +9,6 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/workqueue.h>
-#include <linux/aer.h>
 #include <linux/fs.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
-- 
2.25.1

