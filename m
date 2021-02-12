Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E677E31A1A0
	for <lists+dmaengine@lfdr.de>; Fri, 12 Feb 2021 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBLP0H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 12 Feb 2021 10:26:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:39625 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232084AbhBLPYA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 12 Feb 2021 10:24:00 -0500
IronPort-SDR: QtpYe29Il3CnUn4TAD2Xe0H5bxSRoIAPogAD2VEVSfEdTbQneooBeSfpgtqLQ8/oDGu6bewsXP
 mwGN5Em6aVSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="201576951"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="201576951"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 07:23:16 -0800
IronPort-SDR: 2VEboP9KlGRTIVQmO5ryBoa+zCbgOv5SS99p5Y5w/f0iXLYCRVMJVmHwgX+YbnnF9+pkqegYwm
 PHyyvBldKRAg==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="381477778"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 07:23:16 -0800
Subject: [PATCH] dmaengine: idxd: make idxd_name constant
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 12 Feb 2021 08:23:16 -0700
Message-ID: <161314339610.2231590.18332704779939143434.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

idxd_name is a string table and should be constant.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 1df624eee6db..7fa147b1d29e 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -47,7 +47,7 @@ static struct pci_device_id idxd_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, idxd_pci_tbl);
 
-static char *idxd_name[] = {
+static const char * const idxd_name[] = {
 	"dsa",
 	"iax"
 };


