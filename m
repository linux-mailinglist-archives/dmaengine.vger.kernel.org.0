Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D683014DCF8
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 15:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgA3Oow (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 09:44:52 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:15900 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727158AbgA3Oov (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 09:44:51 -0500
X-IronPort-AV: E=Sophos;i="5.70,382,1574118000"; 
   d="scan'208";a="433740527"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 15:44:49 +0100
Date:   Thu, 30 Jan 2020 15:44:49 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Dave Jiang <dave.jiang@intel.com>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: fix boolconv.cocci warnings
Message-ID: <alpine.DEB.2.21.2001301543150.7476@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: kbuild test robot <lkp@intel.com>

Remove unneeded conversion to bool

Generated by: scripts/coccinelle/misc/boolconv.cocci

CC: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   39bed42de2e7d74686a2d5a45638d6a5d7e7d473
commit: 42d279f9137ab7d5503836baec2739284b278d8f dmaengine: idxd: add char driver to expose submission portal to userland
:::::: branch date: 11 hours ago
:::::: commit date: 6 days ago

Please take the patch only if it's a positive warning. Thanks!

 sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -66,7 +66,7 @@ static inline bool is_idxd_wq_dmaengine(

 static inline bool is_idxd_wq_cdev(struct idxd_wq *wq)
 {
-	return wq->type == IDXD_WQT_USER ? true : false;
+	return wq->type == IDXD_WQT_USER;
 }

 static int idxd_config_bus_match(struct device *dev,
