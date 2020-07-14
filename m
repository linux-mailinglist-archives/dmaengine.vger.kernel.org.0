Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EE21EF00
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2020 13:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGNLSm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jul 2020 07:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgGNLQm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jul 2020 07:16:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7217C08C5F3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so20883653wrn.3
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2020 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QiZP1EJ4HMANCxwy0emf1RpubxHNKPeVfuS0vb5jwJ0=;
        b=Bt0GCA6sAZ1Dhav8uxfVkLsp+I/g50wOtMFqyePzqFC2JGKGQxf3cofzFqQLhNbxix
         MYHy7BJqu7ePGOEXENWyzEDOqRnf7hx4HmX+xp/YqM9BmOTD2QM8AHwRHx8+rdCKXCic
         Pyjf/Qqn5u/+f+t2ojun7ZEgZQ26jHK8sFVi7bFwAMD2KWCNJeaUK/snV2iHB/lrurng
         h2WH838TmE6UU8l1dStBAttQpIHjjbZDEUOqOTzlzpn/lcbltMLgIlmu3iJyR3SW1lMm
         wl7f4eeoVNZIyCvMf8vK2JiVtvZbc0GHpPNzkvbArAVJhlqNI1knGxYIRsaYRGwWSPZy
         Ip0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QiZP1EJ4HMANCxwy0emf1RpubxHNKPeVfuS0vb5jwJ0=;
        b=S6fDDsqjBtSAUXBf69SCrwtqDVybF3POkgAdszNtgV68Y/KfMjvH8ts0Igexcl6k1G
         KQGcQKhQyoAc7VCMitFHbYdDnk6Ukniopylag1LSpeDX4m+Yswr+zexhfBZdSUyLTK1Y
         7L3LbNpBPAOXqP3xAkPQfUziH47Udvj9GmjFpoVofHEto4hPC1XdYZY76+6NiqP/DJq8
         hzfMZxrmDLxifGWjkm3QXsVtrd2vSvOQJbp/dYPIafGM1cFvVbFjUjpfSJHySXgZ6SF7
         tGg2J+bDvGhCxirplPeu6YTKbf9cRQknJi660YHoMbcMYUyF0FUVPU+fUiFntUA6DY82
         OGFQ==
X-Gm-Message-State: AOAM530cBi/XHu5yv6xsWXEOlHr5Isyfnf0eqONgsowDH0JUZv8/PbaY
        ZPZCSEau2fnGaf6TnGEKBAs0LA==
X-Google-Smtp-Source: ABdhPJwkiwpi8l/2xIcMFabgGHg0sSEJz0lNu3Gqu0LiD5h2i/XCtSzTUFZ2AhtZQDnFonigsMSt8A==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr4524901wrw.63.1594725356234;
        Tue, 14 Jul 2020 04:15:56 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id l8sm28566052wrq.15.2020.07.14.04.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 04:15:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Per Forlin <per.forlin@stericsson.com>,
        Jonas Aaberg <jonas.aberg@stericsson.com>
Subject: [PATCH 06/17] dma: ste_dma40: Supply 2 missing struct attribute descriptions
Date:   Tue, 14 Jul 2020 12:15:35 +0100
Message-Id: <20200714111546.1755231-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714111546.1755231-1-lee.jones@linaro.org>
References: <20200714111546.1755231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/dma/ste_dma40.c:398: warning: Function parameter or member 'dma_addr' not described in 'd40_lcla_pool'
 drivers/dma/ste_dma40.c:601: warning: Function parameter or member 'dma_parms' not described in 'd40_base'

Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index de8bfd9a76e9e..21e2f1d0c2109 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -381,6 +381,7 @@ struct d40_desc {
  * struct d40_lcla_pool - LCLA pool settings and data.
  *
  * @base: The virtual address of LCLA. 18 bit aligned.
+ * @dma_addr: DMA address, if mapped
  * @base_unaligned: The orignal kmalloc pointer, if kmalloc is used.
  * This pointer is only there for clean-up on error.
  * @pages: The number of pages needed for all physical channels.
@@ -534,6 +535,7 @@ struct d40_gen_dmac {
  * mode" allocated physical channels.
  * @num_log_chans: The number of logical channels. Calculated from
  * num_phy_chans.
+ * @dma_parms: DMA parameters for the channel
  * @dma_both: dma_device channels that can do both memcpy and slave transfers.
  * @dma_slave: dma_device channels that can do only do slave transfers.
  * @dma_memcpy: dma_device channels that can do only do memcpy transfers.
-- 
2.25.1

