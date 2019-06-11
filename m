Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC03D0E8
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jun 2019 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404995AbfFKPeu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jun 2019 11:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404969AbfFKPeu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Jun 2019 11:34:50 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20CA2080A;
        Tue, 11 Jun 2019 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560267289;
        bh=IwaEn04OTTO9wzCXVfHrjtCqw+4I+XDn1SqlUlas02c=;
        h=From:To:Cc:Subject:Date:From;
        b=z1J7ffmQqBUkHYGOlgPKiWhAk969NDA9LsZxPCiAM4wFUo1ZfE/HgpI/PT8vmU4EV
         vTOwXThkYF8ep0E9Ep/yuwUD4VLqpn8AHf6SomGfsDppKns2Hb385EL7x/y+PzTqHC
         TtKrEbH6IXB1N4XIIrtzoNA7a8WJ6AYFbOIV0jtc=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        vkoul@kernel.org, geert@linux-m68k.org, devicetree@vger.kernel.org
Subject: [PATCHv2 1/2] dt-bindings: pl330: document the optional resets property
Date:   Tue, 11 Jun 2019 10:34:32 -0500
Message-Id: <20190611153433.22129-1-dinguyen@kernel.org>
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
v2: no change
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

