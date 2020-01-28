Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81EC14B477
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2020 13:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgA1Muw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Jan 2020 07:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgA1Muw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Jan 2020 07:50:52 -0500
Received: from localhost.localdomain (unknown [223.226.101.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900FE206A2;
        Tue, 28 Jan 2020 12:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580215851;
        bh=cn0jTh0OaIuUsCZtszYlqKQ0zaZ/OyKgBa7melX7N94=;
        h=From:To:Cc:Subject:Date:From;
        b=NTfGWlZ8F4OSUhaw5qRSTyojQ4NP0PheX6Tnbv90DYZNkHLTfql5I0QII3gTeUnWQ
         OCfGTZHgVbIt1ZyRDt3L74fAPEYZFY0ne3ZC0QnlnvmdvFRA2CfYaCafvTkrJbE+3A
         vMyFDTcJzhZVA3njhqu7UiPEny19INofTQsJwDJg=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH] dmaengine: doc: Properly indent metadata title
Date:   Tue, 28 Jan 2020 18:20:32 +0530
Message-Id: <20200128125032.1650816-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The newly added metadata documentation title was not properly indented
resulting in doc buil break:

  Sphinx parallel build error:
  docutils.utils.SystemMessage: /linux/Documentation/driver-api/dmaengine/client.rst:155: (SEVERE/4) Unexpected section title.

  Optional: per descriptor metadata
  ---------------------------------

Fix this by doing the right indent

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 7d083ae98357 ("dmaengine: doc: Add sections for per descriptor metadata support")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/driver-api/dmaengine/client.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index a9a7a3c84c63..e5953e7e4bf4 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -151,8 +151,8 @@ The details of these operations are:
      Note that callbacks will always be invoked from the DMA
      engines tasklet, never from interrupt context.
 
-  Optional: per descriptor metadata
-  ---------------------------------
+Optional: per descriptor metadata
+---------------------------------
   DMAengine provides two ways for metadata support.
 
   DESC_METADATA_CLIENT
-- 
2.24.1

