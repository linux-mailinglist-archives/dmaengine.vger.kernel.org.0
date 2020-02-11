Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58865159663
	for <lists+dmaengine@lfdr.de>; Tue, 11 Feb 2020 18:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgBKRmt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Feb 2020 12:42:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:2004 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbgBKRms (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Feb 2020 12:42:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 09:42:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="222005597"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2020 09:42:47 -0800
Subject: [PATCH] dmaengine: idxd: fix runaway module ref count on device
 driver bind
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, jerry.t.chen@intel.com
Date:   Tue, 11 Feb 2020 10:42:47 -0700
Message-ID: <158144296730.41381.12134210685456322434.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

idxd_config_bus_probe() calls try_module_get() but never calls module_put()
when it fails. Thus with every failed attempt, the ref count goes up. Add
module_put() in failure paths.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")

Reported-by: Jerry Chen <jerry.t.chen@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 6d907fe150aa..298855ca934f 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -124,6 +124,7 @@ static int idxd_config_bus_probe(struct device *dev)
 		rc = idxd_device_config(idxd);
 		if (rc < 0) {
 			spin_unlock_irqrestore(&idxd->dev_lock, flags);
+			module_put(THIS_MODULE);
 			dev_warn(dev, "Device config failed: %d\n", rc);
 			return rc;
 		}
@@ -132,6 +133,7 @@ static int idxd_config_bus_probe(struct device *dev)
 		rc = idxd_device_enable(idxd);
 		if (rc < 0) {
 			spin_unlock_irqrestore(&idxd->dev_lock, flags);
+			module_put(THIS_MODULE);
 			dev_warn(dev, "Device enable failed: %d\n", rc);
 			return rc;
 		}
@@ -142,6 +144,7 @@ static int idxd_config_bus_probe(struct device *dev)
 		rc = idxd_register_dma_device(idxd);
 		if (rc < 0) {
 			spin_unlock_irqrestore(&idxd->dev_lock, flags);
+			module_put(THIS_MODULE);
 			dev_dbg(dev, "Failed to register dmaengine device\n");
 			return rc;
 		}

