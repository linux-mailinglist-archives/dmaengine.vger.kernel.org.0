Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E1C34BFF6
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhC1X4m (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhC1X4N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3977C061756;
        Sun, 28 Mar 2021 16:56:13 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c4so10939023qkg.3;
        Sun, 28 Mar 2021 16:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaFxE7xJjw3q1QRzUlhL9vl2FAXABYAZdUNglx88dWM=;
        b=jp01Oafr+FYiNYOySvz698WmMQzo+I8B2paqvCFTlCTqcAAL37CMJwgpqQlkW5GHW2
         Dyvbvs+rlqMjPWQuuNHQDuAQ6uVGfCqAuD3H7xHGEPAJOWcAGOy/DrtrhvXYWLU0436d
         lVRkCgJp9jS4fhNJ0qaUC4akHDDGxNg25koKauz70I2VYZQOmotGc6b2/KGof4mKY6LW
         1TzvIv956J7EIBeJBzXRcahb54ThW1Yu5eyDfY18Lpqxxr6dAulMcI1wQw2QFXiQ3c2q
         Ui+ZEYtPOnzUjWjCc71Rex7kRCtuOwcEjgmEOD0DPvlk4vA+pudWfMcYnjP5m3D1ev0S
         YKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaFxE7xJjw3q1QRzUlhL9vl2FAXABYAZdUNglx88dWM=;
        b=hTZDZ5hYcN6pekwObguM/+aNfUI6VXrYNf1k8IwwFCUZKlCRa7+bZ7hstnPndyWu9s
         HI5uP+x9YGgAKcnnL2Cl884/ywhcYP2tAT2HFT77n65vEDSioPBhIVXVXuxJq11TBaFk
         5Fy83GVMF1n6LPYJJJWBOivkqCbUyc/YTyJzRaF7kpCPlNgxcL5fswIC13mE3JKRdjMf
         hkafFCysmRUHKNqnlrQdwaLgN6aioHm5VnjiB5E42DHtSRoSOWeNh7v1b0pgrrCvUf0H
         YkJC1K3aj8+Liew5Ihq0IISIKw6tANnPRuT1ebf7hmyXgc5DvtL1RDb3sjN5L0CZr9Rc
         AkWg==
X-Gm-Message-State: AOAM530pWbHo3vHNc6FkgH5REH/AojEeShMvf5pkCcL0sm8/3gQf3u62
        hUqijpp+tNVy9uEOs9RGSuHM//mo98PWiIUc
X-Google-Smtp-Source: ABdhPJx0o599PHMcyxzLn8eHnK8YWRJh3bbcuBhN5MPJAY682L8sA466e6YWGWWwK4DIft39eFQPyQ==
X-Received: by 2002:a37:e110:: with SMTP id c16mr23323591qkm.67.1616975772640;
        Sun, 28 Mar 2021 16:56:12 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:12 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/30] amba-pl08x.c: Fixed couple of typos
Date:   Mon, 29 Mar 2021 05:22:59 +0530
Message-Id: <b96052cd5c14956852fe7fc13ea47dac7b2b40e1.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


s/busses/buses/
s/accound/account/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/amba-pl08x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a24882ba3764..d15182634789 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -121,7 +121,7 @@ struct vendor_data {

 /**
  * struct pl08x_bus_data - information of source or destination
- * busses for a transfer
+ * buses for a transfer
  * @addr: current address
  * @maxwidth: the maximum width of a transfer on this bus
  * @buswidth: the width of this bus in bytes: 1, 2 or 4
@@ -1010,7 +1010,7 @@ static inline u32 pl08x_lli_control_bits(struct pl08x_driver_data *pl08x,
 	/*
 	 * Remove all src, dst and transfer size bits, then set the
 	 * width and size according to the parameters. The bit offsets
-	 * are different in the FTDMAC020 so we need to accound for this.
+	 * are different in the FTDMAC020 so we need to account for this.
 	 */
 	if (pl08x->vd->ftdmac020) {
 		retbits &= ~FTDMAC020_LLI_DST_WIDTH_MSK;
--
2.26.3

