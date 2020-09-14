Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572EC268443
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 07:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgINFxH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 01:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgINFxE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 14 Sep 2020 01:53:04 -0400
Received: from localhost.localdomain (unknown [122.171.195.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC93821548;
        Mon, 14 Sep 2020 05:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600062800;
        bh=hlGqel7p8xW9ykeELpNGI2jnINIqXQtf7fPGszvl2vI=;
        h=From:To:Cc:Subject:Date:From;
        b=TTfdGxzUskZq/pm5SqpBeVBa+Tj2rP+6bJwt4nFuyCoBZjDIi5ZwrQ7M1pygI69Ww
         CrawKN2hJehBpPOoVn4Krn1KF5XoTCMI2KE0F/Th/fQbJQEiGxgnqMz12eHNcyUG5b
         jl+phuQM6MDtNPdka/aANvE8lvHiY5Ju6fkOTUos=
From:   Vinod Koul <vkoul@kernel.org>
To:     dmaengine@vger.kernel.org, Green Wan <green.wan@sifive.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] dmaengine: sf-pdma: remove unused 'desc'
Date:   Mon, 14 Sep 2020 11:23:02 +0530
Message-Id: <20200914055302.22962-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

'desc' variable is now defined but not used in sf_pdma_donebh_tasklet(),
causing this warning:

drivers/dma/sf-pdma/sf-pdma.c: In function 'sf_pdma_donebh_tasklet':
drivers/dma/sf-pdma/sf-pdma.c:287:23: warning: unused variable 'desc' [-Wunused-variable]

Remove this unused variable

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/sf-pdma/sf-pdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 754994087e5f..1e66c6990d81 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -284,7 +284,6 @@ static void sf_pdma_free_desc(struct virt_dma_desc *vdesc)
 static void sf_pdma_donebh_tasklet(unsigned long arg)
 {
 	struct sf_pdma_chan *chan = (struct sf_pdma_chan *)arg;
-	struct sf_pdma_desc *desc = chan->desc;
 	unsigned long flags;
 
 	spin_lock_irqsave(&chan->lock, flags);
-- 
2.26.2

