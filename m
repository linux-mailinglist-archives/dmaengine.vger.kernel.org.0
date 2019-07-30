Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D007A465
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jul 2019 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfG3JfJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jul 2019 05:35:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46824 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfG3JfI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 30 Jul 2019 05:35:08 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6U9Z1tf100582;
        Tue, 30 Jul 2019 04:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564479301;
        bh=FmEP4mSp+GB3++ivD8Sfw2OMCbXIs8M52yHh6m5wEd4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LYATqRcQprPaQwLyBByKQlP9ll91SQSwU1S+vHgkyFgcBK4FVPI+sCVfljtrp251M
         CS5nYpTDQeyfD7CoEJw72YivxZV9R2sSKS+DgrYA30gTBEauCjmQCm0IyWc2X7nE6H
         OD1BU7PCw+Z3cllFAUqsxQyYKhs4YhDzzjTudXls=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6U9Z1G9058580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 04:35:01 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 04:35:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 04:35:00 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6U9YkU0027547;
        Tue, 30 Jul 2019 04:34:57 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v2 03/14] dmaengine: doc: Add sections for per descriptor metadata support
Date:   Tue, 30 Jul 2019 12:34:39 +0300
Message-ID: <20190730093450.12664-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730093450.12664-1-peter.ujfalusi@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Update the provider and client documentation with details about the
metadata support.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/driver-api/dmaengine/client.rst | 75 +++++++++++++++++++
 .../driver-api/dmaengine/provider.rst         | 46 ++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index 45953f171500..d708e46b88a2 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -151,6 +151,81 @@ The details of these operations are:
      Note that callbacks will always be invoked from the DMA
      engines tasklet, never from interrupt context.
 
+  Optional: per descriptor metadata
+  ---------------------------------
+  DMAengine provides two ways for metadata support.
+
+  DESC_METADATA_CLIENT
+
+    The metadata buffer is allocated/provided by the client driver and it is
+    attached to the descriptor.
+
+  .. code-block:: c
+
+     int dmaengine_desc_attach_metadata(struct dma_async_tx_descriptor *desc,
+				   void *data, size_t len);
+
+  DESC_METADATA_ENGINE
+
+    The metadata buffer is allocated/managed by the DMA driver. The client
+    driver can ask for the pointer, maximum size and the currently used size of
+    the metadata and can directly update or read it.
+
+  .. code-block:: c
+
+     void *dmaengine_desc_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
+		size_t *payload_len, size_t *max_len);
+
+     int dmaengine_desc_set_metadata_len(struct dma_async_tx_descriptor *desc,
+		size_t payload_len);
+
+  Client drivers can query if a given mode is supported with:
+
+  .. code-block:: c
+
+     bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
+		enum dma_desc_metadata_mode mode);
+
+  Depending on the used mode client drivers must follow different flow.
+
+  DESC_METADATA_CLIENT
+
+    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
+      1. prepare the descriptor (dmaengine_prep_*)
+         construct the metadata in the client's buffer
+      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
+         descriptor
+      3. submit the transfer
+    - DMA_DEV_TO_MEM:
+      1. prepare the descriptor (dmaengine_prep_*)
+      2. use dmaengine_desc_attach_metadata() to attach the buffer to the
+         descriptor
+      3. submit the transfer
+      4. when the transfer is completed, the metadata should be available in the
+         attached buffer
+
+  DESC_METADATA_ENGINE
+
+    - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
+      1. prepare the descriptor (dmaengine_prep_*)
+      2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the
+         engine's metadata area
+      3. update the metadata at the pointer
+      4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the
+         amount of data the client has placed into the metadata buffer
+      5. submit the transfer
+    - DMA_DEV_TO_MEM:
+      1. prepare the descriptor (dmaengine_prep_*)
+      2. submit the transfer
+      3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
+         pointer to the engine's metadata are
+      4. Read out the metadate from the pointer
+
+  .. note::
+
+     Mixed use of DESC_METADATA_CLIENT / DESC_METADATA_ENGINE is not allowed,
+     client drivers must use either of the modes per descriptor.
+
 4. Submit the transaction
 
    Once the descriptor has been prepared and the callback information
diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index dfc4486b5743..9e6d87b3c477 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -247,6 +247,52 @@ after each transfer. In case of a ring buffer, they may loop
 (DMA_CYCLIC). Addresses pointing to a device's register (e.g. a FIFO)
 are typically fixed.
 
+Per descriptor metadata support
+-------------------------------
+Some data movement architecure (DMA controller and peripherals) uses metadata
+associated with a transaction. The DMA controller role is to transfer the
+payload and the metadata alongside.
+The metadata itself is not used by the DMA engine itself, but it contains
+parameters, keys, vectors, etc for peripheral or from the peripheral.
+
+The DMAengine framework provides a generic ways to facilitate the metadata for
+descriptors. Depending on the architecture the DMA driver can implement either
+or both of the methods and it is up to the client driver to choose which one
+to use.
+
+- DESC_METADATA_CLIENT
+
+  The metadata buffer is allocated/provided by the client driver and it is
+  attached (via the dmaengine_desc_attach_metadata() helper to the descriptor.
+
+  From the DMA driver the following is expected for this mode:
+  - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM
+    The data from the provided metadata buffer should be prepared for the DMA
+    controller to be sent alongside of the payload data. Either by copying to a
+    hardware descriptor, or highly coupled packet.
+  - DMA_DEV_TO_MEM
+    On transfer completion the DMA driver must copy the metadata to the client
+    provided metadata buffer.
+
+- DESC_METADATA_ENGINE
+
+  The metadata buffer is allocated/managed by the DMA driver. The client driver
+  can ask for the pointer, maximum size and the currently used size of the
+  metadata and can directly update or read it. dmaengine_desc_get_metadata_ptr()
+  and dmaengine_desc_set_metadata_len() is provided as helper functions.
+
+  From the DMA driver the following is expected for this mode:
+  - get_metadata_ptr
+    Should return a pointer for the metadata buffer, the maximum size of the
+    metadata buffer and the currently used / valid (if any) bytes in the buffer.
+  - set_metadata_len
+    It is called by the clients after it have placed the metadata to the buffer
+    to let the DMA driver know the number of valid bytes provided.
+
+  Note: since the client will ask for the metadata pointer in the completion
+  callback (in DMA_DEV_TO_MEM case) the DMA driver must ensure that the
+  descriptor is not freed up prior the callback is called.
+
 Device operations
 -----------------
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

