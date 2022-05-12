Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E574524149
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 02:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349512AbiELABC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 20:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiELABB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 20:01:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DB92BB02
        for <dmaengine@vger.kernel.org>; Wed, 11 May 2022 17:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652313658; x=1683849658;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JfSQjDWYfHOMRIW3TlnRrl5daGGw64FPIbqE/5lqEsY=;
  b=SXWpgNYgzlkbeLPrO4eOFPpNkA6EQflBJEoSyKTkkk9Lu5wV4S9sfv2E
   3ajgEsZCVrHPj4PF+VAbiIuP7oWtGZ/CIz2ucwypt6OCz2XPrv3D2+p9x
   yO98axA0QSu87qPxfktTc6TwFUpjRfCHS0STqa3rtb1rUqs9ZAavvYEi4
   4dotEp/cGFdvAx/hloZrT+9RsUR8/IF0SVgIAViT9r8YSO6l0H/deFLMz
   uWaXyeVsSLSJpmKvA+tUqt2VHclO2GmeGfCcqdZKR6JaW1V2hE6jz2xWj
   nqInCoSFM+JJkyuJVG52NJTet6Tw6vrGJZdvh0kdqKANyjq9NMBKZeIv1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269974677"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269974677"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:00:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="624165023"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:00:57 -0700
Subject: [PATCH] dmaengine: idxd: remove redudant idxd_wq_disable_cleanup()
 call
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 11 May 2022 17:00:57 -0700
Message-ID: <165231365717.986350.2441351765955825964.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

idxd_wq_device_reset_cleanup() already calls idxd_wq_disable_cleanup().
There is no need to call idxd_wq_disable_cleanup() again in
idxd_device_wqs_clear_state(). Remove redudant call from
idxd_wq_device_reset_cleanup().

Fixes: 0dcfe41e9a4c ("dmanegine: idxd: cleanup all device related bits after disabling device")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 8d407d2bea4f..4617219376f7 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -395,7 +395,6 @@ static void idxd_wq_device_reset_cleanup(struct idxd_wq *wq)
 {
 	lockdep_assert_held(&wq->wq_lock);
 
-	idxd_wq_disable_cleanup(wq);
 	wq->size = 0;
 	wq->group = NULL;
 }


