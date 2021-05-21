Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FEA38D158
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 00:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhEUWXd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 May 2021 18:23:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:8303 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhEUWXc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 May 2021 18:23:32 -0400
IronPort-SDR: grx/HONAPRJwuVQ2Jz9D4ndBmnM3gbiAtwyC09ff74NRV26rGsfCYFM2NofP7a9Wbhu8Gm3shV
 42xEHJWdit4g==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="265490099"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265490099"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:09 -0700
IronPort-SDR: Ejck5G7nfJOoZwjceTSV10mOIwBcnGdwQy1Uxp61l3nniV1c5JNGxA1ywJwOSfTpw9oWiMR0JU
 CXGPFg/Du1vA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441119207"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:22:08 -0700
Subject: [PATCH 08/18] dmaengine: idxd: remove iax_bus_type prototype
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        jgg@nvidia.com, ramesh.thomas@intel.com
Date:   Fri, 21 May 2021 15:22:08 -0700
Message-ID: <162163572820.260470.16679699701033560578.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
References: <162163546245.260470.18336189072934823712.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove unused iax_bus_type prototype declaration. Should have been removed
when iax_bus_type was removed.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/idxd.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 0b0f9361c2eb..feefe2d2fff9 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -364,7 +364,6 @@ static inline void idxd_dev_set_type(struct idxd_dev *idev, enum idxd_dev_type t
 }
 
 extern struct bus_type dsa_bus_type;
-extern struct bus_type iax_bus_type;
 
 extern bool support_enqcmd;
 extern struct ida idxd_ida;


