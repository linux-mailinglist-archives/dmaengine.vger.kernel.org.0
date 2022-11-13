Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75451627289
	for <lists+dmaengine@lfdr.de>; Sun, 13 Nov 2022 21:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbiKMUeY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 13 Nov 2022 15:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKMUeM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 13 Nov 2022 15:34:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4134513D2D;
        Sun, 13 Nov 2022 12:34:04 -0800 (PST)
Message-ID: <20221113202428.573536003@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668371642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=grkZQwlPRzm8fA/yPjc15QptsH4K42m6t6iVimtSNVY=;
        b=BSB0+ZgaH4YZXSBE1tbMWxdDuEFNegxLiasEBgyGom90W1/FIyeJ3nfOOYtTj0KMAgcJxF
        mRz7oVcSHL4f+b5MPX5XRr46wEl8z02hUtZQSuad5lGNope/BDNOVZYHL+znOhTDWk+Qn2
        XcXotYopueEjhBWq+IT2cS4snyTO7i2cHx7ulYS8Bx1B9TEI5UqE1YCKy/eGKhXCFODYEQ
        kK17N8Ue1wdTn4DCrP4qj5L27D5hrH8PHlRZNXMGVNN2iz0uMPQwSBunVovp0/yZl7ADTi
        K7tgyTx9U2m6j41JpnKX1MvuLYexAv8XpU9cbtLQ+RcaAvWhWaTBlioeYmUX0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668371642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=grkZQwlPRzm8fA/yPjc15QptsH4K42m6t6iVimtSNVY=;
        b=s2kaPP8Cyjsh1gKkZ6a9lFtsiclyJBVcdw+HEPscqX6fn0kEPgAZOlQXeMmMy+qlXO2gpA
        PiM4E9nZJrbZAFAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [patch 05/10] dmaengine: idxd: Remove linux/msi.h include
References: <20221113201935.776707081@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 13 Nov 2022 21:34:02 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
---
 drivers/dma/idxd/device.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -7,7 +7,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmaengine.h>
 #include <linux/irq.h>
-#include <linux/msi.h>
 #include <uapi/linux/idxd.h>
 #include "../dmaengine.h"
 #include "idxd.h"

