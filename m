Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDA2151AC7
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 13:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBDMvY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 07:51:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37236 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbgBDMvY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 07:51:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id z12so2664633pgl.4;
        Tue, 04 Feb 2020 04:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMrrb66MGEbD6GSo5BdrpjzOshLwkOOTkFspZPak8GE=;
        b=WHMVZUVJEJ0pC8B+iZ1JBCsWVsv8eBXdKZrzP/8K4esYX9yDFyUClbdP4SU2ERAtok
         Ar9ZWb8B/4N6/hfedwSpxqgzn1vqG0NKD86moVuR5ZuAa0DmSkUur8PtxOvep20pMN8+
         dZ/CISaFDHrknP7w3vo9EnhqbP+Ot3LswpzL3KrzPhiAx8Qw8HXQUqHbrHnbYoPlIDTN
         uwkBWBa/zl5/i90txXKaso/Kv7zTHRqQWxKXNWgf8oQVjGzPLaEZ9Ju2ywJ/RjcpZGjk
         aUg8hbaXlS0trsAgzggVyuSsNKIFsFoYI3SoxNV9wFW0zcY+kmnbRo2xmVU1zIOwZq9Z
         jonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMrrb66MGEbD6GSo5BdrpjzOshLwkOOTkFspZPak8GE=;
        b=i+yI89ZGYvxO6yUOxQRMNRCgqHfPp9mxiUKGn30km8MNOtg7RaTrB2f1pF+W37j7pB
         gMij1Wci9N0I9GGtJejq6qfEVa8COLcibhUkOj8BhUIb8WbHtsdgC6YvBDDIWVxfOOn9
         Cvn+NevQUv1+zqJPKkiAUi14GqHXHUxo68/rOX3hUIoMONLR9y2vcjfuuaDzezkZGaOW
         M/FJQU0jMkBXpEmq+KY7DwhwRe4Es5xXXWfk7pznc+sa7049L1FgQ5RTawwAOTgTdRgl
         oFf9QPmygbww4MnafqHBT3c6NRmazXs99MF89yAz06s0C6WBiBnzmlrV0kYLKz9hyhZ7
         eeCg==
X-Gm-Message-State: APjAAAVDeABUDrzKiScaenWW0U6Yod4nsrKpfqjVyEx10O9RdFOfPc2c
        u5gimckmQec+hr+mATasUEb1ZUjer2k=
X-Google-Smtp-Source: APXvYqxtixvFWJN7QKq8GwCcWpgDv9aJd+UJz4i9Aa+hcWvkdTCpaIFsi/+d3+56oWUKrj+T8PlCiA==
X-Received: by 2002:a63:d442:: with SMTP id i2mr32444338pgj.349.1580820683740;
        Tue, 04 Feb 2020 04:51:23 -0800 (PST)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id o19sm3529569pjr.2.2020.02.04.04.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 04:51:22 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] dmaengine: doc: fix warnings/issues of client.rst
Date:   Tue,  4 Feb 2020 20:51:15 +0800
Message-Id: <20200204125115.12128-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This fixed some warnings/issues of client.rst.
 o Need a blank line for enumerated lists.
 o Do not create section in enumerated list.
 o Remove suffix ':' from section title.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/driver-api/dmaengine/client.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index e5953e7e4bf4..2104830a99ae 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -151,8 +151,8 @@ The details of these operations are:
      Note that callbacks will always be invoked from the DMA
      engines tasklet, never from interrupt context.
 
-Optional: per descriptor metadata
----------------------------------
+  **Optional: per descriptor metadata**
+
   DMAengine provides two ways for metadata support.
 
   DESC_METADATA_CLIENT
@@ -199,12 +199,15 @@ Optional: per descriptor metadata
   DESC_METADATA_CLIENT
 
     - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
+
       1. prepare the descriptor (dmaengine_prep_*)
          construct the metadata in the client's buffer
       2. use dmaengine_desc_attach_metadata() to attach the buffer to the
          descriptor
       3. submit the transfer
+
     - DMA_DEV_TO_MEM:
+
       1. prepare the descriptor (dmaengine_prep_*)
       2. use dmaengine_desc_attach_metadata() to attach the buffer to the
          descriptor
@@ -215,6 +218,7 @@ Optional: per descriptor metadata
   DESC_METADATA_ENGINE
 
     - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
+
       1. prepare the descriptor (dmaengine_prep_*)
       2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the
          engine's metadata area
@@ -222,7 +226,9 @@ Optional: per descriptor metadata
       4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the
          amount of data the client has placed into the metadata buffer
       5. submit the transfer
+
     - DMA_DEV_TO_MEM:
+
       1. prepare the descriptor (dmaengine_prep_*)
       2. submit the transfer
       3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get
@@ -278,8 +284,8 @@ Optional: per descriptor metadata
 
       void dma_async_issue_pending(struct dma_chan *chan);
 
-Further APIs:
--------------
+Further APIs
+------------
 
 1. Terminate APIs
 
-- 
2.24.0

