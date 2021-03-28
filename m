Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FF34C031
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhC1X6S (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhC1X5x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:57:53 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA540C061756;
        Sun, 28 Mar 2021 16:57:52 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 7so10924664qka.7;
        Sun, 28 Mar 2021 16:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OMl5ABdwT5DW251I71t3DGinXKhKaq9NsZyTNddHa8Y=;
        b=Rfss4m+DyBLiE2rmvTbB3bLpSu6ljCMgZGJOXL83UY6K7+BOdjg+SSTq8kZaDOEWv6
         rx5iy/w5SOioRKCzTUe3BxyBWYWNrSBKtsFvhFu4XL0OlvsW9PoKO+DxXiWW6St0mTR9
         lTFd+lCy7V8ZkBLrnBlXt3hupR2eaF94TvrXIfIoOxKabz+84KeSvhAaYQ/pLT5rJS9T
         zXOMfY/jZWDHi6IcDT8yRNlR1FPQ+kTzxyWI7467K+gS18rtBl3iSz8m8HbJFMcf4hvI
         qKjsig+kI9u18vColYKr0q6VTUM4wM5tQPrC3qFE9KxeKgm5rGQt7CVWSbQ9fEJeDkEW
         Pyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OMl5ABdwT5DW251I71t3DGinXKhKaq9NsZyTNddHa8Y=;
        b=uCEOdO0Av44gyeKOowZSA0w1ZpfMd+31DoXEii39BLE+rXD6Q4iFvDKhwhpnpem5rZ
         Qj0bBxywfqRQVDARn/jJLnCmpLwIlnAP+o9YCyjNsIIfx9llA0itLNOfu5TPhdcvCUpS
         TWvxWfp+ZeV170dmBrNvTGR9rNKmOogCHo72cKBRSXsVSxfNwzrg5lThp1saSxmLXxca
         gpZv3OtfLOriCuwRSS5xOO9CZ1P9HvjBMw93PyyH0bK5o9lnvK6F12iY5VdzqWK2QSv1
         7WdahBk5uF146Dhj/agRtiGMl6/WbJWcNf2UAgQLIdceuq+1485diUWr3FT+YXGLf3Mi
         1hXg==
X-Gm-Message-State: AOAM530fmNmb7891aETWkeoMHRwYR4VFQTJgppTsQCZveuaoQnmv2TRo
        4xjYXYaRYbdejsg+DIQTMTKfZg6fN4y1oMoI
X-Google-Smtp-Source: ABdhPJxStwmIthIUA++khUWtx+qx1BVfAS/jMvDgsTU1bqiz3K++ChYbHlJMBeZAq5/maT4/buJuaQ==
X-Received: by 2002:a37:a147:: with SMTP id k68mr23143111qke.66.1616975871664;
        Sun, 28 Mar 2021 16:57:51 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:57:51 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] dma-jz4780.c: Fix a typo
Date:   Mon, 29 Mar 2021 05:23:19 +0530
Message-Id: <ecd961a789c07f2c6a05330688e084547e78c191.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/proceeed/proceed/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/dma-jz4780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index ebee94dbd630..451bc754b609 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -379,7 +379,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_slave_sg(

 		if (i != (sg_len - 1) &&
 		    !(jzdma->soc_data->flags & JZ_SOC_DATA_BREAK_LINKS)) {
-			/* Automatically proceeed to the next descriptor. */
+			/* Automatically proceed to the next descriptor. */
 			desc->desc[i].dcm |= JZ_DMA_DCM_LINK;

 			/*
--
2.26.3

