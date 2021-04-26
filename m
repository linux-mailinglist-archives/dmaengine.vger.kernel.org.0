Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7572A36BC0E
	for <lists+dmaengine@lfdr.de>; Tue, 27 Apr 2021 01:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhDZXdI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Apr 2021 19:33:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:30288 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232235AbhDZXdH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 26 Apr 2021 19:33:07 -0400
IronPort-SDR: zOFVY/hXydQOWCbgbAx6zbfgEqMPGs4VGZcp5OkU8wq+GDRw9qEQac1cd9l+UOT2S0MwG0Doqp
 b+S8Qbd9HVIw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="183901909"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="183901909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 16:32:25 -0700
IronPort-SDR: c/AFFKupepjpkylPFDApU94AvkI8qpZn2ymPRbiYZKOXWxv/QF1ghppFBncO8bHrKFy5S35MYd
 tBw752xLwXCQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="429582590"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 16:32:24 -0700
Subject: [PATCH] dmaengine: idxd: add missing dsa driver unregister
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 26 Apr 2021 16:32:24 -0700
Message-ID: <161947994449.1053102.13189942817915448216.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The idxd_unregister_driver() has never been called for the idxd driver upon
removal. Add fix to call unregister driver on module removal.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index ec7305f86bf7..6201f52f13f5 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -788,6 +788,7 @@ module_init(idxd_init_module);
 
 static void __exit idxd_exit_module(void)
 {
+	idxd_unregister_driver();
 	pci_unregister_driver(&idxd_pci_driver);
 	idxd_cdev_remove();
 	idxd_unregister_bus_type();


