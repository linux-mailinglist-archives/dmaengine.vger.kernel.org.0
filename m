Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D398C1C0224
	for <lists+dmaengine@lfdr.de>; Thu, 30 Apr 2020 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgD3QTR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Apr 2020 12:19:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgD3QSk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:40 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6106208DB;
        Thu, 30 Apr 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263518;
        bh=c5rGfIVc6nKN+2qYEHMgvGqnFyObN9KqjtBkbeJ52nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9g83dHbWXsf7oCrWhtpfHlrfITkDagdMesqOK2F/Xds4ERpdwbBO96oca67Rh8Ht
         G/OFIMUrX60IWp+40xU8Z+T9d2mlFXE32hsFX+wYh2LUcVSOZ6SMe0Psoc8UBv19YX
         zrY89ODlD+HB2q6DNkywIrSJopsshfbT59QO7+Es=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBtT-00Axgq-V5; Thu, 30 Apr 2020 18:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: [PATCH v4 04/19] docs: crypto: convert async-tx-api.txt to ReST format
Date:   Thu, 30 Apr 2020 18:18:18 +0200
Message-Id: <d3dc546fc7caee9a575b788da0e42f97b7b61b96.1588263270.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588263270.git.mchehab+huawei@kernel.org>
References: <cover.1588263270.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

- Place the txt index inside a comment;
- Use title and chapter markups;
- Adjust markups for numbered list;
- Mark literal blocks as such;
- Use tables markup.
- Adjust indentation when needed.

Acked-By: Vinod Koul <vkoul@kernel.org> # dmaengine
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{async-tx-api.txt => async-tx-api.rst}    | 253 +++++++++++-------
 Documentation/crypto/index.rst                |   2 +
 Documentation/driver-api/dmaengine/client.rst |   2 +-
 .../driver-api/dmaengine/provider.rst         |   2 +-
 MAINTAINERS                                   |   2 +-
 5 files changed, 154 insertions(+), 107 deletions(-)
 rename Documentation/crypto/{async-tx-api.txt => async-tx-api.rst} (55%)

diff --git a/Documentation/crypto/async-tx-api.txt b/Documentation/crypto/async-tx-api.rst
similarity index 55%
rename from Documentation/crypto/async-tx-api.txt
rename to Documentation/crypto/async-tx-api.rst
index 7bf1be20d93a..bfc773991bdc 100644
--- a/Documentation/crypto/async-tx-api.txt
+++ b/Documentation/crypto/async-tx-api.rst
@@ -1,27 +1,32 @@
-		 Asynchronous Transfers/Transforms API
+.. SPDX-License-Identifier: GPL-2.0
 
-1 INTRODUCTION
+=====================================
+Asynchronous Transfers/Transforms API
+=====================================
 
-2 GENEALOGY
+.. Contents
 
-3 USAGE
-3.1 General format of the API
-3.2 Supported operations
-3.3 Descriptor management
-3.4 When does the operation execute?
-3.5 When does the operation complete?
-3.6 Constraints
-3.7 Example
+  1. INTRODUCTION
 
-4 DMAENGINE DRIVER DEVELOPER NOTES
-4.1 Conformance points
-4.2 "My application needs exclusive control of hardware channels"
+  2 GENEALOGY
 
-5 SOURCE
+  3 USAGE
+  3.1 General format of the API
+  3.2 Supported operations
+  3.3 Descriptor management
+  3.4 When does the operation execute?
+  3.5 When does the operation complete?
+  3.6 Constraints
+  3.7 Example
 
----
+  4 DMAENGINE DRIVER DEVELOPER NOTES
+  4.1 Conformance points
+  4.2 "My application needs exclusive control of hardware channels"
 
-1 INTRODUCTION
+  5 SOURCE
+
+1. Introduction
+===============
 
 The async_tx API provides methods for describing a chain of asynchronous
 bulk memory transfers/transforms with support for inter-transactional
@@ -31,7 +36,8 @@ that is written to the API can optimize for asynchronous operation and
 the API will fit the chain of operations to the available offload
 resources.
 
-2 GENEALOGY
+2.Genealogy
+===========
 
 The API was initially designed to offload the memory copy and
 xor-parity-calculations of the md-raid5 driver using the offload engines
@@ -39,40 +45,52 @@ present in the Intel(R) Xscale series of I/O processors.  It also built
 on the 'dmaengine' layer developed for offloading memory copies in the
 network stack using Intel(R) I/OAT engines.  The following design
 features surfaced as a result:
-1/ implicit synchronous path: users of the API do not need to know if
+
+1. implicit synchronous path: users of the API do not need to know if
    the platform they are running on has offload capabilities.  The
    operation will be offloaded when an engine is available and carried out
    in software otherwise.
-2/ cross channel dependency chains: the API allows a chain of dependent
+2. cross channel dependency chains: the API allows a chain of dependent
    operations to be submitted, like xor->copy->xor in the raid5 case.  The
    API automatically handles cases where the transition from one operation
    to another implies a hardware channel switch.
-3/ dmaengine extensions to support multiple clients and operation types
+3. dmaengine extensions to support multiple clients and operation types
    beyond 'memcpy'
 
-3 USAGE
+3. Usage
+========
 
-3.1 General format of the API:
-struct dma_async_tx_descriptor *
-async_<operation>(<op specific parameters>, struct async_submit ctl *submit)
+3.1 General format of the API
+-----------------------------
 
-3.2 Supported operations:
-memcpy  - memory copy between a source and a destination buffer
-memset  - fill a destination buffer with a byte value
-xor     - xor a series of source buffers and write the result to a
+::
+
+  struct dma_async_tx_descriptor *
+  async_<operation>(<op specific parameters>, struct async_submit ctl *submit)
+
+3.2 Supported operations
+------------------------
+
+========  ====================================================================
+memcpy    memory copy between a source and a destination buffer
+memset    fill a destination buffer with a byte value
+xor       xor a series of source buffers and write the result to a
 	  destination buffer
-xor_val - xor a series of source buffers and set a flag if the
+xor_val   xor a series of source buffers and set a flag if the
 	  result is zero.  The implementation attempts to prevent
 	  writes to memory
-pq	- generate the p+q (raid6 syndrome) from a series of source buffers
-pq_val  - validate that a p and or q buffer are in sync with a given series of
+pq	  generate the p+q (raid6 syndrome) from a series of source buffers
+pq_val    validate that a p and or q buffer are in sync with a given series of
 	  sources
-datap	- (raid6_datap_recov) recover a raid6 data block and the p block
+datap	  (raid6_datap_recov) recover a raid6 data block and the p block
 	  from the given sources
-2data	- (raid6_2data_recov) recover 2 raid6 data blocks from the given
+2data	  (raid6_2data_recov) recover 2 raid6 data blocks from the given
 	  sources
+========  ====================================================================
+
+3.3 Descriptor management
+-------------------------
 
-3.3 Descriptor management:
 The return value is non-NULL and points to a 'descriptor' when the operation
 has been queued to execute asynchronously.  Descriptors are recycled
 resources, under control of the offload engine driver, to be reused as
@@ -82,12 +100,15 @@ before the dependency is submitted.  This requires that all descriptors be
 acknowledged by the application before the offload engine driver is allowed to
 recycle (or free) the descriptor.  A descriptor can be acked by one of the
 following methods:
-1/ setting the ASYNC_TX_ACK flag if no child operations are to be submitted
-2/ submitting an unacknowledged descriptor as a dependency to another
+
+1. setting the ASYNC_TX_ACK flag if no child operations are to be submitted
+2. submitting an unacknowledged descriptor as a dependency to another
    async_tx call will implicitly set the acknowledged state.
-3/ calling async_tx_ack() on the descriptor.
+3. calling async_tx_ack() on the descriptor.
 
 3.4 When does the operation execute?
+------------------------------------
+
 Operations do not immediately issue after return from the
 async_<operation> call.  Offload engine drivers batch operations to
 improve performance by reducing the number of mmio cycles needed to
@@ -98,12 +119,15 @@ channels since the application has no knowledge of channel to operation
 mapping.
 
 3.5 When does the operation complete?
+-------------------------------------
+
 There are two methods for an application to learn about the completion
 of an operation.
-1/ Call dma_wait_for_async_tx().  This call causes the CPU to spin while
+
+1. Call dma_wait_for_async_tx().  This call causes the CPU to spin while
    it polls for the completion of the operation.  It handles dependency
    chains and issuing pending operations.
-2/ Specify a completion callback.  The callback routine runs in tasklet
+2. Specify a completion callback.  The callback routine runs in tasklet
    context if the offload engine driver supports interrupts, or it is
    called in application context if the operation is carried out
    synchronously in software.  The callback can be set in the call to
@@ -111,83 +135,95 @@ of an operation.
    unknown length it can use the async_trigger_callback() routine to set a
    completion interrupt/callback at the end of the chain.
 
-3.6 Constraints:
-1/ Calls to async_<operation> are not permitted in IRQ context.  Other
+3.6 Constraints
+---------------
+
+1. Calls to async_<operation> are not permitted in IRQ context.  Other
    contexts are permitted provided constraint #2 is not violated.
-2/ Completion callback routines cannot submit new operations.  This
+2. Completion callback routines cannot submit new operations.  This
    results in recursion in the synchronous case and spin_locks being
    acquired twice in the asynchronous case.
 
-3.7 Example:
+3.7 Example
+-----------
+
 Perform a xor->copy->xor operation where each operation depends on the
-result from the previous operation:
-
-void callback(void *param)
-{
-	struct completion *cmp = param;
-
-	complete(cmp);
-}
-
-void run_xor_copy_xor(struct page **xor_srcs,
-		      int xor_src_cnt,
-		      struct page *xor_dest,
-		      size_t xor_len,
-		      struct page *copy_src,
-		      struct page *copy_dest,
-		      size_t copy_len)
-{
-	struct dma_async_tx_descriptor *tx;
-	addr_conv_t addr_conv[xor_src_cnt];
-	struct async_submit_ctl submit;
-	addr_conv_t addr_conv[NDISKS];
-	struct completion cmp;
-
-	init_async_submit(&submit, ASYNC_TX_XOR_DROP_DST, NULL, NULL, NULL,
-			  addr_conv);
-	tx = async_xor(xor_dest, xor_srcs, 0, xor_src_cnt, xor_len, &submit)
-
-	submit->depend_tx = tx;
-	tx = async_memcpy(copy_dest, copy_src, 0, 0, copy_len, &submit);
-
-	init_completion(&cmp);
-	init_async_submit(&submit, ASYNC_TX_XOR_DROP_DST | ASYNC_TX_ACK, tx,
-			  callback, &cmp, addr_conv);
-	tx = async_xor(xor_dest, xor_srcs, 0, xor_src_cnt, xor_len, &submit);
-
-	async_tx_issue_pending_all();
-
-	wait_for_completion(&cmp);
-}
+result from the previous operation::
+
+    void callback(void *param)
+    {
+	    struct completion *cmp = param;
+
+	    complete(cmp);
+    }
+
+    void run_xor_copy_xor(struct page **xor_srcs,
+			int xor_src_cnt,
+			struct page *xor_dest,
+			size_t xor_len,
+			struct page *copy_src,
+			struct page *copy_dest,
+			size_t copy_len)
+    {
+	    struct dma_async_tx_descriptor *tx;
+	    addr_conv_t addr_conv[xor_src_cnt];
+	    struct async_submit_ctl submit;
+	    addr_conv_t addr_conv[NDISKS];
+	    struct completion cmp;
+
+	    init_async_submit(&submit, ASYNC_TX_XOR_DROP_DST, NULL, NULL, NULL,
+			    addr_conv);
+	    tx = async_xor(xor_dest, xor_srcs, 0, xor_src_cnt, xor_len, &submit)
+
+	    submit->depend_tx = tx;
+	    tx = async_memcpy(copy_dest, copy_src, 0, 0, copy_len, &submit);
+
+	    init_completion(&cmp);
+	    init_async_submit(&submit, ASYNC_TX_XOR_DROP_DST | ASYNC_TX_ACK, tx,
+			    callback, &cmp, addr_conv);
+	    tx = async_xor(xor_dest, xor_srcs, 0, xor_src_cnt, xor_len, &submit);
+
+	    async_tx_issue_pending_all();
+
+	    wait_for_completion(&cmp);
+    }
 
 See include/linux/async_tx.h for more information on the flags.  See the
 ops_run_* and ops_complete_* routines in drivers/md/raid5.c for more
 implementation examples.
 
-4 DRIVER DEVELOPMENT NOTES
+4. Driver Development Notes
+===========================
+
+4.1 Conformance points
+----------------------
 
-4.1 Conformance points:
 There are a few conformance points required in dmaengine drivers to
 accommodate assumptions made by applications using the async_tx API:
-1/ Completion callbacks are expected to happen in tasklet context
-2/ dma_async_tx_descriptor fields are never manipulated in IRQ context
-3/ Use async_tx_run_dependencies() in the descriptor clean up path to
+
+1. Completion callbacks are expected to happen in tasklet context
+2. dma_async_tx_descriptor fields are never manipulated in IRQ context
+3. Use async_tx_run_dependencies() in the descriptor clean up path to
    handle submission of dependent operations
 
 4.2 "My application needs exclusive control of hardware channels"
+-----------------------------------------------------------------
+
 Primarily this requirement arises from cases where a DMA engine driver
 is being used to support device-to-memory operations.  A channel that is
 performing these operations cannot, for many platform specific reasons,
 be shared.  For these cases the dma_request_channel() interface is
 provided.
 
-The interface is:
-struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
-				     dma_filter_fn filter_fn,
-				     void *filter_param);
+The interface is::
 
-Where dma_filter_fn is defined as:
-typedef bool (*dma_filter_fn)(struct dma_chan *chan, void *filter_param);
+  struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
+				       dma_filter_fn filter_fn,
+				       void *filter_param);
+
+Where dma_filter_fn is defined as::
+
+  typedef bool (*dma_filter_fn)(struct dma_chan *chan, void *filter_param);
 
 When the optional 'filter_fn' parameter is set to NULL
 dma_request_channel simply returns the first channel that satisfies the
@@ -207,19 +243,28 @@ private.  Alternatively, it is set when dma_request_channel() finds an
 unused "public" channel.
 
 A couple caveats to note when implementing a driver and consumer:
-1/ Once a channel has been privately allocated it will no longer be
+
+1. Once a channel has been privately allocated it will no longer be
    considered by the general-purpose allocator even after a call to
    dma_release_channel().
-2/ Since capabilities are specified at the device level a dma_device
+2. Since capabilities are specified at the device level a dma_device
    with multiple channels will either have all channels public, or all
    channels private.
 
-5 SOURCE
+5. Source
+---------
 
-include/linux/dmaengine.h: core header file for DMA drivers and api users
-drivers/dma/dmaengine.c: offload engine channel management routines
-drivers/dma/: location for offload engine drivers
-include/linux/async_tx.h: core header file for the async_tx api
-crypto/async_tx/async_tx.c: async_tx interface to dmaengine and common code
-crypto/async_tx/async_memcpy.c: copy offload
-crypto/async_tx/async_xor.c: xor and xor zero sum offload
+include/linux/dmaengine.h:
+    core header file for DMA drivers and api users
+drivers/dma/dmaengine.c:
+    offload engine channel management routines
+drivers/dma/:
+    location for offload engine drivers
+include/linux/async_tx.h:
+    core header file for the async_tx api
+crypto/async_tx/async_tx.c:
+    async_tx interface to dmaengine and common code
+crypto/async_tx/async_memcpy.c:
+    copy offload
+crypto/async_tx/async_xor.c:
+    xor and xor zero sum offload
diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index b2eeab3c8631..22a6870bf356 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -19,6 +19,8 @@ for cryptographic use cases, as well as programming examples.
    intro
    api-intro
    architecture
+
+   async-tx-api
    asymmetric-keys
    devel-algos
    userspace-if
diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index 2104830a99ae..b0f32cfc38c2 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -5,7 +5,7 @@ DMA Engine API Guide
 Vinod Koul <vinod dot koul at intel.com>
 
 .. note:: For DMA Engine usage in async_tx please see:
-          ``Documentation/crypto/async-tx-api.txt``
+          ``Documentation/crypto/async-tx-api.rst``
 
 
 Below is a guide to device driver writers on how to use the Slave-DMA API of the
diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 56e5833e8a07..954422c2b704 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -95,7 +95,7 @@ accommodates that API in some cases, and made some design choices to
 ensure that it stayed compatible.
 
 For more information on the Async TX API, please look the relevant
-documentation file in Documentation/crypto/async-tx-api.txt.
+documentation file in Documentation/crypto/async-tx-api.rst.
 
 DMAEngine APIs
 ==============
diff --git a/MAINTAINERS b/MAINTAINERS
index bc849ca40b87..2f9bdcc80ef2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2808,7 +2808,7 @@ ASYNCHRONOUS TRANSFERS/TRANSFORMS (IOAT) API
 R:	Dan Williams <dan.j.williams@intel.com>
 S:	Odd fixes
 W:	http://sourceforge.net/projects/xscaleiop
-F:	Documentation/crypto/async-tx-api.txt
+F:	Documentation/crypto/async-tx-api.rst
 F:	crypto/async_tx/
 F:	drivers/dma/
 F:	include/linux/async_tx.h
-- 
2.25.4

