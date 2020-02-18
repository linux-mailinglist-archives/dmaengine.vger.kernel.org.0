Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C061A162B12
	for <lists+dmaengine@lfdr.de>; Tue, 18 Feb 2020 17:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRQwA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Feb 2020 11:52:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:21628 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgBRQv7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Feb 2020 11:51:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 08:51:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="382508918"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2020 08:51:59 -0800
Subject: [PATCH] dmaengine: idxd: correct reserved token calculation
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, jerry.t.chen@intel.com
Date:   Tue, 18 Feb 2020 09:51:58 -0700
Message-ID: <158204471889.37789.7749177228265869168.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The calcuation for limit of reserved token did not take into account the
change the user wanted vs the current group reserved token. This causes
changing of the reserved token to be possible only after we set the value
of the reserved token back to 0. Fix calculation so we can set a value that
is non zero for reserved token.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")

Reported-by: Jerry Chen <jerry.t.chen@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 298855ca934f..edbfe83325eb 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -519,7 +519,7 @@ static ssize_t group_tokens_reserved_store(struct device *dev,
 	if (val > idxd->max_tokens)
 		return -EINVAL;
 
-	if (val > idxd->nr_tokens)
+	if (val > idxd->nr_tokens + group->tokens_reserved)
 		return -EINVAL;
 
 	group->tokens_reserved = val;

