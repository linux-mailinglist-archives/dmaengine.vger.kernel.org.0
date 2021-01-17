Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDDB2F912E
	for <lists+dmaengine@lfdr.de>; Sun, 17 Jan 2021 08:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbhAQHDd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 17 Jan 2021 02:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbhAQHD0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 17 Jan 2021 02:03:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95A7322D5B;
        Sun, 17 Jan 2021 07:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610866963;
        bh=mkNqT9MGlZstPmc/uEs1cKwlHj4CQwTVy+Ce7GwyAws=;
        h=From:To:Cc:Subject:Date:From;
        b=rQrT1Fnxjl6KibILMrjX4Y6/yJq1XGgQQigfhBdbjx15VeuVWNFGjfldZ8TON9mBx
         oY2L8prno2or8oWFGh/yjBmL4ivi4lA/K/gplKw0pdkkqEZ7wUyryX7K1NMlmQzwNe
         P/OWZ36bzdILO5mJ2GFxo/23N9PB5py0relvQMCOf2wqoJKPnXIhQj5eqsBL6S9LKw
         W3aKCGd0Z1U7iAoh929FGqhndET/1l+VD5ECgki0gNfyjwq6fk18MydfJLekltBDLZ
         7/RoMlHF4FRN60pWWN638sHlnN7NLJvFFg6kFUa5uSVZZJ7Ti9tFgMxddzSe4FLfN8
         d+5rGT1HDb1ZQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: ioat: remove dmaengine susbstem files
Date:   Sun, 17 Jan 2021 12:32:29 +0530
Message-Id: <20210117070229.2537866-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

[1] mentions the IOAT entry contains dmaengine subsystem file. So update
the entry and remove the dmaengine files

1: https://lwn.net/Articles/842415/

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d62310a31f8..49647c6a03fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2872,9 +2872,7 @@ S:	Odd fixes
 W:	http://sourceforge.net/projects/xscaleiop
 F:	Documentation/crypto/async-tx-api.rst
 F:	crypto/async_tx/
-F:	drivers/dma/
 F:	include/linux/async_tx.h
-F:	include/linux/dmaengine.h
 
 AT24 EEPROM DRIVER
 M:	Bartosz Golaszewski <bgolaszewski@baylibre.com>
-- 
2.26.2

