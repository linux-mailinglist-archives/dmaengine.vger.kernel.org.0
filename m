Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A398573BE8
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiGMRWd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiGMRWc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 13:22:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EABFF58D;
        Wed, 13 Jul 2022 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657732952; x=1689268952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BnzXUwt5+K+Mc2Kvjt3JDGXklnVAwoVYXy8cAkKNCds=;
  b=fJT+VaNEwJB7SJfaVqitEpotLHVSeXR7mWYaNVn5IVnOjN7p+Ty/zZbw
   YlfT29Engno1RsSbEayKPdu6zp7JxQP3wlK/RTjbqIp29lpUzNdXXvPvB
   8vmDd6uicPRtTvbLKi4qh0l4Y47Me+6duJbsAYh9+uCkzKHETGQSRq4ye
   O3oX2UksRD0V3SJt3B2eFsq9IUCst+ZYcir5W8uBaaH1yLfwt0Evw0Iv6
   N2p4sviY8ynSkAdXA/8W7BOhEY2JQLqePia/dvaz+iBblBJqf9tFme6H8
   JcJKCfWpJ5VF9Zg21s1f/yaybzi28IlIYpVAq6RqTLf/idnAyuU6up1XM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="310933517"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="310933517"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="722429515"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2022 10:22:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4385316D; Wed, 13 Jul 2022 20:22:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 3/4] dmaengine: hsu: Use GENMASK() consistently
Date:   Wed, 13 Jul 2022 20:22:34 +0300
Message-Id: <20220713172235.22611-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
References: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For the masks replace chain of BIT() macros by GENMASK().
While at it, explicitly include bits.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/hsu/hsu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/hsu/hsu.h b/drivers/dma/hsu/hsu.h
index 9e5956345748..1c1195709c2f 100644
--- a/drivers/dma/hsu/hsu.h
+++ b/drivers/dma/hsu/hsu.h
@@ -10,6 +10,7 @@
 #ifndef __DMA_HSU_H__
 #define __DMA_HSU_H__
 
+#include <linux/bits.h>
 #include <linux/spinlock.h>
 #include <linux/dma/hsu.h>
 
@@ -36,11 +37,11 @@
 
 /* Bits in HSU_CH_SR */
 #define HSU_CH_SR_DESCTO(x)	BIT(8 + (x))
-#define HSU_CH_SR_DESCTO_ANY	(BIT(11) | BIT(10) | BIT(9) | BIT(8))
+#define HSU_CH_SR_DESCTO_ANY	GENMASK(11, 8)
 #define HSU_CH_SR_CHE		BIT(15)
 #define HSU_CH_SR_DESCE(x)	BIT(16 + (x))
-#define HSU_CH_SR_DESCE_ANY	(BIT(19) | BIT(18) | BIT(17) | BIT(16))
-#define HSU_CH_SR_CDESC_ANY	(BIT(31) | BIT(30))
+#define HSU_CH_SR_DESCE_ANY	GENMASK(19, 16)
+#define HSU_CH_SR_CDESC_ANY	GENMASK(31, 30)
 
 /* Bits in HSU_CH_CR */
 #define HSU_CH_CR_CHA		BIT(0)
-- 
2.35.1

