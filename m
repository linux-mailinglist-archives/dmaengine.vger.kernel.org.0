Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F834BFFA
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhC1X4m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhC1X42 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5805AC061756;
        Sun, 28 Mar 2021 16:56:28 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q3so10893257qkq.12;
        Sun, 28 Mar 2021 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b+g6kPIG/jwFitPzoitjd4fSzc6P/hya8rywnHeMN/8=;
        b=HBBLF/SJTiVQWcLhNqq7bzpHR2fKW9LP6DWRvUsmYI7rcgdhmE09hx9CIxGfTsumKX
         isRs8nn27xIKkAFpC/ZbyFrFtAkA1tz5NS7xJ3Ovmkz+afQ30TBK5a8we2BRZXGgjxxr
         z6kTysKHQ1ynwBd9QItRNqLsEpW7uXvoTnvwnv8XkMp+fdf3Uuptl6dTZMalYNMRHWxF
         NM0QNQoHDeEh0fx03RO8xhl/6Q0tu1MW6TIguY4L/6GIaX3v1qxLcUp3UUYUodE+6H6H
         XAXaSfBSUy0AypaInMTUVAZebzJYkGqKi/dXcHv+x3xT9jmB94ueRb/JpcSu+XrxdLCF
         ALaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b+g6kPIG/jwFitPzoitjd4fSzc6P/hya8rywnHeMN/8=;
        b=pOdavJ9DxqgpHk0GO3QnDrQhuFJ0g7OmnK4piiyqnu6FmHWnS3wl3KGR/m/kBfdr2o
         7qsxL/2gXhcd/BJo6Q9xmcYxdsjXu+1TI8rJ2d+N9FcIM0QZ3OgF8l7jCSLGqFWV/gCh
         8VL9b3njhWsTRnSsuHbO/ATmel5Jvq+GIxXoh93Ffvvi3/9kYaFlwfppv1Q+z0vL1gAF
         4ekwpTv0/BNtJs+wARo4KTXHZ3g/Hg8sFBuChcweDVmiQ3rRGA4Gd3wZtNMbyFlleW+P
         XCPKZeKd18nKA0buUv5+ve+Erj/sjvg+PTYjNSNw+okgNUn+5QQxHccjhB5bmAUiCzaS
         P1sQ==
X-Gm-Message-State: AOAM532fIAqDWZnW5FuPUybvS0tJXP1ceaEnWoXEtrH/RceYMBa+G4k/
        7WT3RWPT1N4eg/4e61JV8wNyET0/aYgiWBG6
X-Google-Smtp-Source: ABdhPJyldMxvnEBh7c5nmTQttLQPp8mr5BNjSHH3pinXqHmSCm2R9IbveYuxti7c4ebHxEhEJg5Pcg==
X-Received: by 2002:a05:620a:cf4:: with SMTP id c20mr22555044qkj.134.1616975787315;
        Sun, 28 Mar 2021 16:56:27 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:26 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/30] idma64.c: Fix couple of typos
Date:   Mon, 29 Mar 2021 05:23:02 +0530
Message-Id: <0e722d154cb5b29d8bad59481e74fc4853ee930e.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/transfered/transferred/  ...two different places

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/idma64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index f4c07ad3be15..3d0d48b12e28 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -282,7 +282,7 @@ static void idma64_desc_fill(struct idma64_chan *idma64c,
 		desc->length += hw->len;
 	} while (i);

-	/* Trigger an interrupt after the last block is transfered */
+	/* Trigger an interrupt after the last block is transferred */
 	lli->ctllo |= IDMA64C_CTLL_INT_EN;

 	/* Disable LLP transfer in the last block */
@@ -356,7 +356,7 @@ static size_t idma64_active_desc_size(struct idma64_chan *idma64c)
 	if (!i)
 		return bytes;

-	/* The current chunk is not fully transfered yet */
+	/* The current chunk is not fully transferred yet */
 	bytes += desc->hw[--i].len;

 	return bytes - IDMA64C_CTLH_BLOCK_TS(ctlhi);
--
2.26.3

