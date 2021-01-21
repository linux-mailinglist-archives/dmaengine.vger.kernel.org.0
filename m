Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42DB2FE0BA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Jan 2021 05:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbhAUEbb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Jan 2021 23:31:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:11852 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbhAUEOU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Jan 2021 23:14:20 -0500
IronPort-SDR: zF5tu2wdk9LnvIgCINtJSg1rgLf2Mr7CMGdnqrgXnN0XMNIG906Fa2V379FjLLfQJ3rkxEIrm8
 WKvDmASWGrjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="240755743"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="240755743"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 20:12:22 -0800
IronPort-SDR: njPOBu4LcriKX6PHAigfnEp1F4PwrR+KhFjsYXuGIvbaXpGf84K2YcvI1oY4Sy1uhoNerTI9I/
 J7X+i7eFSDCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="400021030"
Received: from sgsxdev004.isng.phoenix.local (HELO localhost) ([10.226.81.179])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2021 20:12:20 -0800
From:   Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
To:     dmaengine@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, chuanhua.lei@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        mallikarjunax.reddy@linux.intel.com, malliamireddy009@gmail.com
Subject: [PATCH 1/1] dt-bindings: dma: intel-ldma: Fix for JSON pointers syntax error
Date:   Thu, 21 Jan 2021 12:12:18 +0800
Message-Id: <2c0d0d87352a3af132c4eb18e9e1581e03b03eba.1611202226.git.mallikarjunax.reddy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There have been some fixes for JSON pointers and tools check now got this is missing a '/'.
Add missing a '/' in '/schemas/types.yaml#definitions/uint32'

Signed-off-by: Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>
---
 Documentation/devicetree/bindings/dma/intel,ldma.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/intel,ldma.yaml b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
index 866d4c758a7a..a5c4be783593 100644
--- a/Documentation/devicetree/bindings/dma/intel,ldma.yaml
+++ b/Documentation/devicetree/bindings/dma/intel,ldma.yaml
@@ -56,7 +56,7 @@ properties:
     maxItems: 1
 
   intel,dma-poll-cnt:
-    $ref: /schemas/types.yaml#definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       DMA descriptor polling counter is used to control the poling mechanism
       for the descriptor fetching for all channels.
-- 
2.17.1

