Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDD44200E
	for <lists+dmaengine@lfdr.de>; Mon,  1 Nov 2021 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhKASdw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Nov 2021 14:33:52 -0400
Received: from neon-v2.ccupm.upm.es ([138.100.198.70]:57057 "EHLO
        neon-v2.ccupm.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhKASdv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 1 Nov 2021 14:33:51 -0400
Received: from localhost.localdomain (62-3-70-206.dsl.in-addr.zen.co.uk [62.3.70.206] (may be forged))
        (user=adrianml@alumnos.upm.es mech=LOGIN bits=0)
        by neon-v2.ccupm.upm.es (8.15.2/8.15.2/neon-v2-001) with ESMTPSA id 1A1I8fSO016585
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 1 Nov 2021 18:08:53 GMT
From:   Adrian Larumbe <adrianml@alumnos.upm.es>
To:     vkoul@kernel.org, dmaengine@vger.kernel.org
Cc:     michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        Adrian Larumbe <adrianml@alumnos.upm.es>
Subject: [PATCH 1/3] dmaengine: Add documentation for new memcpy scatter-gather function
Date:   Mon,  1 Nov 2021 18:08:23 +0000
Message-Id: <20211101180825.241048-2-adrianml@alumnos.upm.es>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101180825.241048-1-adrianml@alumnos.upm.es>
References: <20210706234338.7696-1-adrian.martinezlarumbe@imgtec.com>
 <20211101180825.241048-1-adrianml@alumnos.upm.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Documentation describes semantics, limitations and a typical use case
scenario.

Signed-off-by: Adrian Larumbe <adrianml@alumnos.upm.es>
---
 .../driver-api/dmaengine/provider.rst         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index ddb0a81a796c..0072c9c7efd3 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -162,6 +162,29 @@ Currently, the types available are:
 
   - The device is able to do memory to memory copies
 
+- - DMA_MEMCPY_SG
+
+  - The device supports memory to memory scatter-gather transfers.
+
+  - Even though a plain memcpy can look like a particular case of a
+    scatter-gather transfer, with a single chunk to copy, it's a distinct
+    transaction type in the mem2mem transfer case. This is because some very
+    simple devices might be able to do contiguous single-chunk memory copies,
+    but have no support for more complex SG transfers.
+
+  - No matter what the overall size of the combined chunks for source and
+    destination is, only as many bytes as the smallest of the two will be
+    transmitted. That means the number and size of the scatter-gather buffers in
+    both lists need not be the same, and that the operation functionally is
+    equivalent to a ``strncpy`` where the ``count`` argument equals the smallest
+    total size of the two scatter-gather list buffers.
+
+  - It's usually used for copying pixel data between host memory and
+    memory-mapped GPU device memory, such as found on modern PCI video graphics
+    cards. The most immediate example is the OpenGL API function
+    ``glReadPielx()``, which might require a verbatim copy of a huge framebuffer
+    from local device memory onto host memory.
+
 - DMA_XOR
 
   - The device is able to perform XOR operations on memory areas
-- 
2.33.1

