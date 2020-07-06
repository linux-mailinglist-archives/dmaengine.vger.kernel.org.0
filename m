Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82991215A89
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2020 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgGFPSd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Jul 2020 11:18:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:1059 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbgGFPSd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 6 Jul 2020 11:18:33 -0400
IronPort-SDR: jQGB+gyaSCWebi7FxKroocrzAjpLF//qLZiFB7QPhAWulX+tZtHhUMkm0HcAED/wMP2nQTUFqV
 Ezv1AjZqu2Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127022187"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="127022187"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 08:18:33 -0700
IronPort-SDR: iESlZO5JkecPjLzsFXv4nl/OlTtyf173sJ0Dr3vsrMxY/4XmLJAURWjzXs6OQJG5X3H0ejNhb2
 boMXP8VwcIZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="456762928"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 08:18:32 -0700
Subject: [PATCH] dmaengine: fix incorrect return value for dma_request_chan()
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org
Date:   Mon, 06 Jul 2020 08:18:31 -0700
Message-ID: <159404871194.45151.3076873396834992441.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dma_request_chan() is expected to return ERR_PTR rather than NULL. This
triggered a crash in pl011_dma_probe() when dma_device_list is empty
and returning NULL. Fix return of NULL ptr to ERR_PTR(-ENODEV).

Fixes: deb9541f5052 ("dmaengine: check device and channel list for empty")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/dmaengine.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 0d6529eff66f..48e159e83cf5 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -852,7 +852,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	mutex_lock(&dma_list_mutex);
 	if (list_empty(&dma_device_list)) {
 		mutex_unlock(&dma_list_mutex);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	list_for_each_entry_safe(d, _d, &dma_device_list, global_node) {

