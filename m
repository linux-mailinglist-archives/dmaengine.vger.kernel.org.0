Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1B834C021
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhC1X5p (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhC1X5S (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:18 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475AC061756;
        Sun, 28 Mar 2021 16:57:18 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u8so8197657qtq.12;
        Sun, 28 Mar 2021 16:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktllqx7QjnWspPMzXQ7sjhNooDB0vIxKm9ezXXcwic0=;
        b=f4QMuwyF5jrdPtMVo2+9CGy2hpnU6X9VG5or5cpG0i5tKec8GXJPvfE2Lpfk2UtaIc
         ESCMfIgnWL/UzyeGdrF5UBJ0iKYk2Q4qnsji667z2vAPF+u8CnsV9GYOtBno/G+/nqdq
         ZICRcmrtcXLksFUAwiGUvZpBxgizflQwSbKEaSuqDRxIqIeES2reI+kqyNZdZV2qHhv+
         GRJOMDGRqxSXoEJfkRzo2Xs8jWRYDGz0wMjhbIHXsUbZfochhQqfqzobUs0jKKMVgs/y
         AgbCDh9rd/1jlkPabHd0/Hk9bEm2jgro2YGuiorbB8cCG4HdzN8B20aMcPA+NJLNEqs2
         eH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktllqx7QjnWspPMzXQ7sjhNooDB0vIxKm9ezXXcwic0=;
        b=YbC/FtkFEX2tQLBVyBgX9DT0PhvXsPk5urBL8xE+J+Y+tb+3/8OtP45bB4vpn6CBz+
         YRl1BIW87lo4yxF19JzH8T7GN5dLkXu3qqJ9nbIGFlAcFy9O0QFQSk3rwMqLLlKJ2uxQ
         aYEXwhvPubnESF451YktqQTKkFs2JrYsBMoD7DopttWf/lhhZT2IoQ26NynAuQuTaSvt
         wXZJKPZ4Dw2WkMkGQH5iIxsVQdER+C3zSOyhn4v/mT7rhSwen3/vQX8CLYWkxD5rNH6T
         QfRRX0OEPGzFD92bVEuRk3lXL1T3EzKZgrAInGIF7qLYllOneMxx7V61lnvatmJg99yP
         qxhA==
X-Gm-Message-State: AOAM531rinWjfoq08fLJYpSEY5n5FjF26GFCMspZ0PnZSLfYnpgHWaPh
        SYv8UiBOHSbREvci4QEwZgcrlBURvdI6GyZc
X-Google-Smtp-Source: ABdhPJwxkLWZ5bJL30+ltWO6L6GdjSR/KZBPmPBB//wO0w+nDIDxzLuRqwzNpg9JihsmsPxrBn04TA==
X-Received: by 2002:ac8:7776:: with SMTP id h22mr21395212qtu.325.1616975836988;
        Sun, 28 Mar 2021 16:57:16 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/30] st_fdma.h: Fix couple of typos
Date:   Mon, 29 Mar 2021 05:23:12 +0530
Message-Id: <e116ad3d06c03a655e4f8940ebfa4650c860ef3c.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/transfert/transfer/  ...two different places.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/st_fdma.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/st_fdma.h b/drivers/dma/st_fdma.h
index fa15b97a3bab..702b21021124 100644
--- a/drivers/dma/st_fdma.h
+++ b/drivers/dma/st_fdma.h
@@ -41,8 +41,8 @@ struct st_fdma_generic_node {
  * @saddr: Source address
  * @daddr: Destination address
  *
- * @generic: generic node for free running/paced transfert type
- * 2 others transfert type are possible, but not yet implemented
+ * @generic: generic node for free running/paced transfer type
+ * 2 others transfer type are possible, but not yet implemented
  *
  * The NODE structures must be aligned to a 32 byte boundary
  */
--
2.26.3

