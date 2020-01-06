Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28102130B6C
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jan 2020 02:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgAFBSG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jan 2020 20:18:06 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46705 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgAFBR2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jan 2020 20:17:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so35286888lfl.13;
        Sun, 05 Jan 2020 17:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqNp1UdCqeyiLALCUBHMvdBWRB+JgxkXykXZjY6I1uo=;
        b=tQMIeYZSkToGF6IJkOekvw6u5tCQsNIXAfZ/9TpuCG721oFTlzA6XNgIOlv4IqLDl9
         JDIMPtndCK0LMXEs8mwiEoaemrsPoTC7EPGwCwQ7cnK5WvsUR+QGa5rjQomB4vQld2WJ
         c0E4WnMFCA+3eLMLgQ8gavW3dnqTgidaM/9EYzWjkgGC4/4whvrv3iB9Lcz/dcTICL3Y
         ZLj3iFAN9iOPBCL9mdWRw6nJ3WjWFBpI/s/dTXfpApl17eR3Lq97hAWUD6YZzoANEdC/
         1B/Ykt92HLZ0guAmkeUZp0urH7oTMjSl3fVYMhHDVDy3easer8D5a4XjxWRRkvlSR/Fb
         LSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqNp1UdCqeyiLALCUBHMvdBWRB+JgxkXykXZjY6I1uo=;
        b=kQSgyrZ6AwjBHEsSJ1gIBE67snOolXLIem5tbRwqEmlWuaAmsT0tqAjR24SVscinj9
         aszX5jl6UDgurCuCPMlbBeQCl+3Ja+1QZgGCMjipkZIdRs87lIE+GuuMbsU44/JKrHKm
         9CHU7TQLuiUQOoAGejZUITMjImH+fqyrudVmOqSxm/4Nsjj400SIWQEEFZName2lagG8
         kxSWLJPyqCYOsdDz4YUHj5B7mtn+JQ5s6SSKfBM7qozVD0sVvpDHQHifHq8fEaMg19TT
         8uHdr4Fc01GSnojrHo5bLfLcVfXgDfmV1OIGcprUBPedswLnVAcvPcF1Yh7k4nDqcVUj
         EG7w==
X-Gm-Message-State: APjAAAWHsObD5tkMYsAGIfjTD8INYAwODFdtshT1hkAmKuW0VWTZJL2z
        KJpYYVCprvQsg/f7zmlhTI0=
X-Google-Smtp-Source: APXvYqyc/UIm3DmN61QXwb/R+vKFkesTIe8fyCUSFBzSN3eOen5o/5EoFgc03oEdjEo19m6UO3lb4g==
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr55630899lfq.176.1578273445929;
        Sun, 05 Jan 2020 17:17:25 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id y14sm28353271ljk.46.2020.01.05.17.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:17:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/13] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Mon,  6 Jan 2020 04:17:00 +0300
Message-Id: <20200106011708.7463-6-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106011708.7463-1-digetx@gmail.com>
References: <20200106011708.7463-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The interrupt handler puts a half-completed DMA descriptor on a free list
and then schedules tasklet to process bottom half of the descriptor that
executes client's callback, this creates possibility to pick up the busy
descriptor from the free list. Thus let's disallow descriptor's re-use
until it is fully processed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 1b8a11804962..aafad50d075e 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -281,7 +281,7 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
 
 	/* Do not allocate if desc are waiting for ack */
 	list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
-		if (async_tx_test_ack(&dma_desc->txd)) {
+		if (async_tx_test_ack(&dma_desc->txd) && !dma_desc->cb_count) {
 			list_del(&dma_desc->node);
 			spin_unlock_irqrestore(&tdc->lock, flags);
 			dma_desc->txd.flags = 0;
-- 
2.24.0

