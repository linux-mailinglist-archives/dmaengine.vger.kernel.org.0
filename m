Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC55D177B08
	for <lists+dmaengine@lfdr.de>; Tue,  3 Mar 2020 16:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgCCPuu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Mar 2020 10:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgCCPuu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 3 Mar 2020 10:50:50 -0500
Received: from mail.kernel.org (tmo-101-56.customers.d1-online.com [80.187.101.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D38205C9;
        Tue,  3 Mar 2020 15:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583250649;
        bh=D5TWuE5a1T3YZLgyK18r/2Ad6XegTUJLqVeALzs77vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNLJbCOr0dL3OAafCNleCQJcTAhFJtplSCTJUbboQOVuXYLKG5v5vAKr5uIocpI6t
         8BIj2hKiTxUeOAteWSdqD6KbsKOo/7RLXsx1NB8S6cJ42Q1vwr2YWzXfOs9z9lowgB
         ti+GwahryjTpEMkRbRj7Wpbhzh6yEc3xolwBrVhA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j99og-001ZOq-FA; Tue, 03 Mar 2020 16:50:42 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 3/9] docs: dmaengine: provider.rst: get rid of some warnings
Date:   Tue,  3 Mar 2020 16:50:33 +0100
Message-Id: <62cf2a87b379a92c9c0e5a40c2ae8a138b01fe0a.1583250595.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <afbe367ccb7b9abcb9fab7bc5cb5e0686c105a53.1583250595.git.mchehab+huawei@kernel.org>
References: <afbe367ccb7b9abcb9fab7bc5cb5e0686c105a53.1583250595.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Get rid of those warnings by adding extra blank lines:

    Documentation/driver-api/dmaengine/provider.rst:270: WARNING: Unexpected indentation.
    Documentation/driver-api/dmaengine/provider.rst:273: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/driver-api/dmaengine/provider.rst:288: WARNING: Unexpected indentation.
    Documentation/driver-api/dmaengine/provider.rst:290: WARNING: Block quote ends without a blank line; unexpected unindent.

While here, use parenthesis after get_metadata_ptr/set_metadata_len,
as, if some day someone adds a kerneldoc markup for those, it
should automatically generate a cross-reference to them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/dmaengine/provider.rst | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 790a15089f1f..56e5833e8a07 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -266,11 +266,15 @@ to use.
   attached (via the dmaengine_desc_attach_metadata() helper to the descriptor.
 
   From the DMA driver the following is expected for this mode:
+
   - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM
+
     The data from the provided metadata buffer should be prepared for the DMA
     controller to be sent alongside of the payload data. Either by copying to a
     hardware descriptor, or highly coupled packet.
+
   - DMA_DEV_TO_MEM
+
     On transfer completion the DMA driver must copy the metadata to the client
     provided metadata buffer before notifying the client about the completion.
     After the transfer completion, DMA drivers must not touch the metadata
@@ -284,10 +288,14 @@ to use.
   and dmaengine_desc_set_metadata_len() is provided as helper functions.
 
   From the DMA driver the following is expected for this mode:
-  - get_metadata_ptr
+
+  - get_metadata_ptr()
+
     Should return a pointer for the metadata buffer, the maximum size of the
     metadata buffer and the currently used / valid (if any) bytes in the buffer.
-  - set_metadata_len
+
+  - set_metadata_len()
+
     It is called by the clients after it have placed the metadata to the buffer
     to let the DMA driver know the number of valid bytes provided.
 
-- 
2.24.1

