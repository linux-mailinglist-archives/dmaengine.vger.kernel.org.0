Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11836228096
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jul 2020 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGUNIs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jul 2020 09:08:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:18111 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgGUNIs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 Jul 2020 09:08:48 -0400
IronPort-SDR: 76D3uVCxjEiuEIwskhhvw138CBjaggEHh7TC6hSsmC7Km9yiHuUA30nmrJZw3OVofWf0KX91yo
 VoAMugtSJ9XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="211669171"
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="211669171"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 06:08:47 -0700
IronPort-SDR: L4lnyJw3Z9heHPMQcHi6G01gVydy4YPIgKqLHNQhF45YIm9ZLJUk3A+UxF9myB+xyIg5MjC19X
 V052cjKzSsSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="319897862"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jul 2020 06:08:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9FCB0119; Tue, 21 Jul 2020 16:08:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: dw: Don't include unneeded header to platform data header
Date:   Tue, 21 Jul 2020 16:08:44 +0300
Message-Id: <20200721130844.64162-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Including device.h is too much for the dma-dw.h platform data header.
Replace it with the headers of which dma-dw.h is direct user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_data/dma-dw.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/platform_data/dma-dw.h b/include/linux/platform_data/dma-dw.h
index f3eaf9ec00a1..f02a16dfb44b 100644
--- a/include/linux/platform_data/dma-dw.h
+++ b/include/linux/platform_data/dma-dw.h
@@ -8,11 +8,14 @@
 #ifndef _PLATFORM_DATA_DMA_DW_H
 #define _PLATFORM_DATA_DMA_DW_H
 
-#include <linux/device.h>
+#include <linux/bits.h>
+#include <linux/types.h>
 
 #define DW_DMA_MAX_NR_MASTERS	4
 #define DW_DMA_MAX_NR_CHANNELS	8
 
+struct device;
+
 /**
  * struct dw_dma_slave - Controller-specific information about a slave
  *
-- 
2.27.0

