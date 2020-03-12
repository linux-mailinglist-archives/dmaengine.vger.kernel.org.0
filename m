Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1343A183903
	for <lists+dmaengine@lfdr.de>; Thu, 12 Mar 2020 19:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCLSvL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 Mar 2020 14:51:11 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:48442 "EHLO
        13.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgCLSvL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 Mar 2020 14:51:11 -0400
X-Greylist: delayed 2239 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 14:51:10 EDT
Received: from player728.ha.ovh.net (unknown [10.110.103.118])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id A5A7F22AA27
        for <dmaengine@vger.kernel.org>; Thu, 12 Mar 2020 19:13:49 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 7C8D11047C29C;
        Thu, 12 Mar 2020 18:13:36 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <t-kristo@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: driver-api/dma.../provider.rst: fix indents
Date:   Thu, 12 Mar 2020 19:13:18 +0100
Message-Id: <20200312181318.1368421-1-steve@sk2.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8925290037935820104
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This fixes some block indentations, formatting them as definitions
(which seems appropriate given the content), and addressing these
warnings:

	Documentation/driver-api/dmaengine/provider.rst:270: WARNING: Unexpected indentation.
	Documentation/driver-api/dmaengine/provider.rst:273: WARNING: Block quote ends without a blank line; unexpected unindent.
	Documentation/driver-api/dmaengine/provider.rst:288: WARNING: Unexpected indentation.
	Documentation/driver-api/dmaengine/provider.rst:290: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: 7d083ae98357 ("dmaengine: doc: Add sections for per descriptor metadata support")
Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/driver-api/dmaengine/provider.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 790a15089f1f..6367a79de47d 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -260,34 +260,35 @@ descriptors. Depending on the architecture the DMA driver can implement either
 or both of the methods and it is up to the client driver to choose which one
 to use.
 
-- DESC_METADATA_CLIENT
-
+DESC_METADATA_CLIENT
   The metadata buffer is allocated/provided by the client driver and it is
   attached (via the dmaengine_desc_attach_metadata() helper to the descriptor.
 
   From the DMA driver the following is expected for this mode:
-  - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM
+
+  DMA_MEM_TO_DEV / DEV_MEM_TO_MEM
     The data from the provided metadata buffer should be prepared for the DMA
     controller to be sent alongside of the payload data. Either by copying to a
     hardware descriptor, or highly coupled packet.
-  - DMA_DEV_TO_MEM
+  DMA_DEV_TO_MEM
     On transfer completion the DMA driver must copy the metadata to the client
     provided metadata buffer before notifying the client about the completion.
     After the transfer completion, DMA drivers must not touch the metadata
     buffer provided by the client.
 
-- DESC_METADATA_ENGINE
-
+DESC_METADATA_ENGINE
   The metadata buffer is allocated/managed by the DMA driver. The client driver
   can ask for the pointer, maximum size and the currently used size of the
   metadata and can directly update or read it. dmaengine_desc_get_metadata_ptr()
   and dmaengine_desc_set_metadata_len() is provided as helper functions.
 
   From the DMA driver the following is expected for this mode:
-  - get_metadata_ptr
+
+  get_metadata_ptr
     Should return a pointer for the metadata buffer, the maximum size of the
     metadata buffer and the currently used / valid (if any) bytes in the buffer.
-  - set_metadata_len
+
+  set_metadata_len
     It is called by the clients after it have placed the metadata to the buffer
     to let the DMA driver know the number of valid bytes provided.
 

base-commit: 7d3d3254adaa61cba896f71497f56901deb618e5
-- 
2.24.1

