Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF27234C00F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Mar 2021 01:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhC1X5O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Mar 2021 19:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhC1X4x (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Mar 2021 19:56:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26178C061756;
        Sun, 28 Mar 2021 16:56:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y18so10894479qky.11;
        Sun, 28 Mar 2021 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFq3P7yiseEEIQs2lgtrYVJcUzd7SMyJml+jQ6mPYF4=;
        b=uqre0zmSKtKLv++i82S0mbofGjuwskwC3CvMsmMtmcwjGtVJxeycjVJ6RpN1VYBSe+
         0CQzJMu7PEalUVZXmadGM2px6kQtZ3N7tNZA8m0dvlRcCIAf2qxYblhfj3libS6ly7pM
         7cP6Y7jQrTC4iCIUP2k8mrM8YO2OpsBVZioO1TYaUyX8FXX33csqU52/jNiOF/7HzRdW
         h0q2j3ogjbDgvmDtoSNvMcXXBHSfFF65U6v9ngv5ZS5aXjxah14f4OMwQwxkXQDvmGYq
         AtbeqfKk09GWR+OXgzvinDBtt6Vlb1woQTa7OM74PpgkMbt4TVzXSvTJ5IGTkC59YqDm
         2KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFq3P7yiseEEIQs2lgtrYVJcUzd7SMyJml+jQ6mPYF4=;
        b=Qx1lWfytZmRLHtm+3M/f2nVPy8Dj5woBbsbVOut531lrF9qtihvhEvenM3Jl/A0Iya
         YaDaIPwgI2B7GqHYRexrcRj3MkkxHxQTaLAxx9+nstW52c8wKj8RiwlrmPmepX4TKjjc
         Px1VEkp5pZquBYFiZJYymchkQuelWSWcL6/Xik8h5k2amjw0TDMUNHvVNRnqqJ9qukYC
         T/zQB2cf1XJMnesnyTszxZTgg8ayx8KezkHKbY4ffu2f6+AE1+urtofxFOA1Fvx0jMPA
         FMeP5qFloyT0ZQDHl46EW8CAk+X1yl0Tg79r2K7CZ+sQ5SsX7jfFHXhkjbLlC0flB26+
         vqrA==
X-Gm-Message-State: AOAM530c1qB1xYs3hlIOFw8WtghgkAJ5gXohfj8snSn6jW6+75UkE29N
        alth/aEh3fAvEck/2ApUQMWxHk8iR5kmOGYj
X-Google-Smtp-Source: ABdhPJyLHhya4uvoU4yUX2xpbMzIUxvQ1LFqJZoKSNEtSVlVs50tStFXatwwOAyjof/U/tKgBPUUrw==
X-Received: by 2002:a37:a10a:: with SMTP id k10mr22547586qke.171.1616975812145;
        Sun, 28 Mar 2021 16:56:52 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
        by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 16:56:51 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, dave.jiang@intel.com,
        dan.j.williams@intel.com
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/30] nbpfaxi.c: Fixed a typo
Date:   Mon, 29 Mar 2021 05:23:07 +0530
Message-Id: <4171b74a36b486ce83fd019e654660d7cbe2dae0.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

s/superflous/superfluous/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/nbpfaxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 9c52c57919c6..9eacaa20ddb3 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -898,7 +898,7 @@ static int nbpf_config(struct dma_chan *dchan,
 	/*
 	 * We could check config->slave_id to match chan->terminal here,
 	 * but with DT they would be coming from the same source, so
-	 * such a check would be superflous
+	 * such a check would be superfluous
 	 */

 	chan->slave_dst_addr = config->dst_addr;
--
2.26.3

