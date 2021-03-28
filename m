Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99534C036
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhC1X6W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhC1X6N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:58:13 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C8EC061756;
        Sun, 28 Mar 2021 16:58:12 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l13so8218237qtu.9;
        Sun, 28 Mar 2021 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUGFgtZenGoQf8Uh4RGUdvjnZZYLeMJMHb15/4oeJgc=;
        b=mj/G1xfMN+eBi/mLaJKBCfkPK76TC91NulrZ5Jz6MjHvD1+9uv4rw5JIHWY6jJMkPU
         juBqy15jPxnjEZz88LM7f7n7mKB7TmDWozu6QfjYOf5cdeVB6jvj8YF2JK5SEbaWCtcr
         SLVpipsP8ug8RvIfOCigIBCOOkbSMY0mM8tlHsQ75zbmLFit+2cyQzvlDBSCB3LGSGbV
         pShlkMne+FQekElXhc22p72UjnAWEnoe2D3MPu8Z7RA503hwCfuXky3XJCDO45tC2vxK
         Ir37Ajvmz19yu5bi6jM78kpp6GrDyAnXm5bDAKqUzMmt+jw56iKxC+d1WcuHS2QwjAoe
         bCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUGFgtZenGoQf8Uh4RGUdvjnZZYLeMJMHb15/4oeJgc=;
        b=RxNEK1AW6HC1dFMKIEMuwI5ovW23BXDM++AkpgVRYc1CY9XdxCnREqcHdqoOCvRckm
         1sDxNFQnezlmZk23LVMd6Vct5f/GBRnnE2Rym/ejmh25UI7QaWCYdcE5CVh48UBgPIEC
         S1lrguzB2sQede9vThdhW/IlzAmPFRr9h5YH/77VYBC++1VSTnitQalJ3LtE6dbrbya9
         JD5ZpX/tfsTC8/bNlLqBs0CFDVVwGIkn3siU2FODwE1YRZyfy9V0Hbt2rkhBld5Q7JVa
         ToMhtXUCLGu9SM2I7FL9AEeFKIIULwpoMH0NMurMpcz4G0DzrjBqXXBJKVjlPEf5U7gK
         Fqtg==
X-Gm-Message-State: AOAM5319OP1AGeYAVsE9EeqMy7DeyzuuMRteCgIiK14UVfWqk3oxz3l4
        jFsbIcPSDn/HFgXtbEycc8DaDp+EN4GoGfJC
X-Google-Smtp-Source: ABdhPJw5YfqSr8OAZoUA56+SYw5JOagX/iPu+fij/qaA6VDbAiygjX2++C/zuL+4UodiHI2nu1SuPA==
X-Received: by 2002:ac8:4799:: with SMTP id k25mr1974600qtq.319.1616975891846;
        Sun, 28 Mar 2021 16:58:11 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:58:11 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/30] dpaa2-qdma.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:23 +0530
Message-Id: <75bdf547b024ece2e35f6e83e51101109ae46803.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/contoller/controller/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/sh/shdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 5aafe548ca5f..7b51b15b45b1 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -319,7 +319,7 @@ static void sh_dmae_setup_xfer(struct shdma_chan *schan,
 }

 /*
- * Find a slave channel configuration from the contoller list by either a slave
+ * Find a slave channel configuration from the controller list by either a slave
  * ID in the non-DT case, or by a MID/RID value in the DT case
  */
 static const struct sh_dmae_slave_config *dmae_find_slave(
--
2.26.3

