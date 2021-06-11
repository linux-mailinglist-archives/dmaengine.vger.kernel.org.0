Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75AA3A3C50
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 08:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhFKGzj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 02:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFKGzi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Jun 2021 02:55:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F17C061574;
        Thu, 10 Jun 2021 23:53:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g4so5183220pjk.0;
        Thu, 10 Jun 2021 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sklyKCkqcoBClcesbRPk+D2OM57H8Au21vymPqCxTpU=;
        b=AH2/OLdVQvlbPqkJ3iD9lFMZN+QxGv4u7G7KOW18l494tp/TTBclaWaHJYXPz/JXyO
         JdmvFCqRQon7SWFTh02oUrFIPPn6XXDWtZb7skgDgsXOA5APBkxZrIshGZKCS+YfJaJb
         nJtOXEelb4ehtZYW635V8bQ1N1HB5zvM9S5u/UWBseYXltq7BTdFjIEVn6eT/WcwUJHE
         Nm4EBWTsJqcowQrApCQhKLAt+zOVjQ0HCPLrBOApxo2XJ3x5P2GR9+S5OZl/kVTNz445
         tqdF0aDnDd0pgQ45QTJAjIfelzgZhH+UZ8ZpWstHrQrBu4Oe+zaOGAYiqHSg1Or1kPtO
         ojKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sklyKCkqcoBClcesbRPk+D2OM57H8Au21vymPqCxTpU=;
        b=NynXLrhpGIOzPscXxNVR+nhkz/nJDCmJep3zkNDJxcokBLCws0Y6UWsuZby7mDJ5zN
         66OeU9NI/WDv2+0IU9P2Fsp7q7uAJU2iy3fiDePU7g+LZmhSVSHoszJWcTreQxOj9KYY
         Lt4WguMbes5hieedZGawgiX4LWfoBM33YPkKlgiK0bpYnq/nUzZ1+tNYrRmg/p62Pg/3
         3UB2AtqU+flWtlIlMyIPln/W0DzzBXUNxsf0njC+AdLwNxFo+Ils/P92yXi1/Y4OrjI+
         aCdxsaTSxf0jQpyKhMtdCR5ZE9baQVyyVg6BpTTbJ5VgUFG67+7oJQG71j6Q+EKZ6rq3
         RuoQ==
X-Gm-Message-State: AOAM5300Y0nsRwBEuw0MY/B/xir2+X2JzHgZFRsUQwi8AE1L06sYCfid
        2fKsOXnxyBFjxBaVKe7UZao=
X-Google-Smtp-Source: ABdhPJz3O0QWQXkwaviwj76i6+j6t2lC+fPSgVjypMvB90Rdh9vqgL7jvGu/YhI0hAGbB2QU9CiXJw==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr7960516pjq.53.1623394421237;
        Thu, 10 Jun 2021 23:53:41 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id a13sm4332599pgm.3.2021.06.10.23.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 23:53:40 -0700 (PDT)
Date:   Fri, 11 Jun 2021 07:53:36 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     green.wan@sifive.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        austindh.kim@gmail.com, austin.kim@lge.com
Subject: [PATCH] dmaengine: sf-pdma: apply proper spinlock flags in
 sf_pdma_prep_dma_memcpy()
Message-ID: <20210611065336.GA1121@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

The second parameter of spinlock_irq[save/restore] function is flags,
which is the last input parameter of sf_pdma_prep_dma_memcpy().

So declare local variable 'iflags' to be used as the second parameter of
spinlock_irq[save/restore] function.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index c4c4e8575764..f12606aeff87 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -94,6 +94,7 @@ sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,	dma_addr_t dest, dma_addr_t src,
 {
 	struct sf_pdma_chan *chan = to_sf_pdma_chan(dchan);
 	struct sf_pdma_desc *desc;
+	unsigned long iflags;
 
 	if (chan && (!len || !dest || !src)) {
 		dev_err(chan->pdma->dma_dev.dev,
@@ -109,10 +110,10 @@ sf_pdma_prep_dma_memcpy(struct dma_chan *dchan,	dma_addr_t dest, dma_addr_t src,
 	desc->dirn = DMA_MEM_TO_MEM;
 	desc->async_tx = vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
 
-	spin_lock_irqsave(&chan->vchan.lock, flags);
+	spin_lock_irqsave(&chan->vchan.lock, iflags);
 	chan->desc = desc;
 	sf_pdma_fill_desc(desc, dest, src, len);
-	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+	spin_unlock_irqrestore(&chan->vchan.lock, iflags);
 
 	return desc->async_tx;
 }
-- 
2.20.1

