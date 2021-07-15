Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D9D3CA61A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jul 2021 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhGOSqR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Jul 2021 14:46:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:48725 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237964AbhGOSqO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 15 Jul 2021 14:46:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="274436142"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="274436142"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="506035189"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:43:15 -0700
Subject: [PATCH v3 02/18] dmaengine: idxd: add driver name
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Date:   Thu, 15 Jul 2021 11:43:15 -0700
Message-ID: <162637459517.744545.7572915135318813722.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
References: <162637445139.744545.6008938867943724701.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add name field in idxd_device_driver so we don't have to touch the
'struct device_driver' during declaration.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h  |    1 +
 drivers/dma/idxd/init.c  |    1 +
 drivers/dma/idxd/sysfs.c |    4 +---
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index c26f7baa812d..b1e4fd202d7e 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -34,6 +34,7 @@ enum idxd_type {
 #define IDXD_PMU_EVENT_MAX	64
 
 struct idxd_device_driver {
+	const char *name;
 	struct device_driver drv;
 };
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 19f5cf9a1c55..6b616ae47fc3 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -853,6 +853,7 @@ int __idxd_driver_register(struct idxd_device_driver *idxd_drv, struct module *o
 {
 	struct device_driver *drv = &idxd_drv->drv;
 
+	drv->name = idxd_drv->name;
 	drv->bus = &dsa_bus_type;
 	drv->owner = owner;
 	drv->mod_name = mod_name;
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 983ccc32813e..1d71dbad85fc 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -311,9 +311,7 @@ struct bus_type dsa_bus_type = {
 };
 
 static struct idxd_device_driver dsa_drv = {
-	.drv = {
-		.name = "dsa",
-	},
+	.name = "dsa",
 };
 
 /* IDXD generic driver setup */


