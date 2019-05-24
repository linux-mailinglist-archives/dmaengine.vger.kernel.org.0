Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0F7928E53
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2019 02:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfEXA3C (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 May 2019 20:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfEXA3C (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 May 2019 20:29:02 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 192BE2133D;
        Fri, 24 May 2019 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558657741;
        bh=GJSQsLGKFEw/q14NqFuVkMJI/P9w7wVpGKEWFUnovSM=;
        h=From:To:Cc:Subject:Date:From;
        b=fRlHLsclounchpuyRBndvCb3T2UJBq5RhzHPs+zM9LbqL/H9X/OvY2OwPhjnH234a
         8eTswoD+8X09pRhlHjToE2GmKXbATX+eqrs/DjoC3SwfPXRbG4p+DO4+JxVtSem5bz
         H8UIlkaxJaK0IvP3Q7gHeN6/Zf1qUKA7QeGcZq1g=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, vkoul@kernel.org
Subject: [PATCH 1/2] dt-bindings: pl330: document the optional resets property
Date:   Thu, 23 May 2019 19:28:46 -0500
Message-Id: <20190524002847.30961-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add the optional resets property the pl330 dma node.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/dma/arm-pl330.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
index db7e2260f9c5..2c7fd1941abb 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
+++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
@@ -16,6 +16,9 @@ Optional properties:
   - dma-channels: contains the total number of DMA channels supported by the DMAC
   - dma-requests: contains the total number of DMA requests supported by the DMAC
   - arm,pl330-broken-no-flushp: quirk for avoiding to execute DMAFLUSHP
+  - resets: contains an entry for each entry in reset-names.
+	    See ../reset/reset.txt for details.
+  - reset-names: must contain at least "dma", and optional is "dma-ocp".
 
 Example:
 
-- 
2.20.0

