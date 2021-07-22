Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946EA3D2AF8
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jul 2021 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhGVQgB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jul 2021 12:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGVQgA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Jul 2021 12:36:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F9CC061575;
        Thu, 22 Jul 2021 10:16:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k4so6727982wrc.8;
        Thu, 22 Jul 2021 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qN42ft8TO2D20OJfcUBVmNsGjubNKzxaIpoGBDjnO30=;
        b=N9sGc0w6sreE1rBcKcYgbOCkI8XCbuX6TGFEbZad7NUHz3+DobUpspOinpyE4z+4WT
         LIGpgaFJz+MdemeScOYdMqZWqgYHsRKxu0WPHLqVj9YO9CEToDkU+Tr3EFkubOI7zoCu
         HLzc7UfVWSVQHYZNYoSQHLeu4FJq/Vj9oNzKTNOwchXCtVisJpBV3r7L+5D1B5BX77G1
         wrYPfL4YWMhAohVmL2tEMONeaGFI87+s8ZiLW8PDSZKAsQlmJw4QOOTHenDhmVs/zURW
         iSlijtCONe9xzs18HlnNIGSyZbeLhz1up190SV0qINS3zXw+G8ilBOsBzNx+ttfQrDT3
         fOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qN42ft8TO2D20OJfcUBVmNsGjubNKzxaIpoGBDjnO30=;
        b=f+Y1wchBH3F8gkTo+zZZyYN2Ho6V4MPnrw2x3y5knwTWkM3J4543iKxvDsEhCH72UA
         xr5YoXS1kwhf/Jl6MmfJwvTroWqMItdt8NVJG3tavYJatz7VkXtB+f2u7VP/gSm2/ESa
         +jqYnzmBiODqN60hHaVAboJwVPIFLh1tR9fVJQDkvQ3wXwww5LfyA15tcsiVUEiKcY43
         LZVj8YsQOLI7sy2coyB3C/a+uVSWKoRzvPj3Zs/lk3fmOYdzthS36WuOF4a3iGj/mkwW
         C9R+rBM/cnaW6WCAPGQcj18lkeVt/k+zRZuGp/ocChwX68AkC0+/43iAsbOHEAoGVTBN
         UGvA==
X-Gm-Message-State: AOAM530eXfgAymJVNWCwy4QzMik/IuGydxAvA3Z0ALhd9j1Hq48awvrW
        KHgx6wPpTBZhp8c8DnKCsQc=
X-Google-Smtp-Source: ABdhPJx+obe7SiWYAauUbkcctEtHZG/vskERzUfVPcrRc22QnlLsRBZH4wLuOC11l99X7asg3YPY6Q==
X-Received: by 2002:adf:f8cd:: with SMTP id f13mr1027030wrq.328.1626974194227;
        Thu, 22 Jul 2021 10:16:34 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id p8sm3081038wmc.24.2021.07.22.10.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:16:33 -0700 (PDT)
Date:   Thu, 22 Jul 2021 18:16:30 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>, gregkh@linuxfoundation.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND] ppc4xx: replace sscanf() by kstrtoul()
Message-ID: <20210722171630.GA4911@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix the checkpatch.pl warning: "Prefer kstrto<type> to single variable sscanf".

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/dma/ppc4xx/adma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index df7704053d91..e2b5129c5f84 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4319,6 +4319,7 @@ static ssize_t enable_store(struct device_driver *dev, const char *buf,
 			    size_t count)
 {
 	unsigned long val;
+	int err;
 
 	if (!count || count > 11)
 		return -EINVAL;
@@ -4327,7 +4328,10 @@ static ssize_t enable_store(struct device_driver *dev, const char *buf,
 		return -EFAULT;
 
 	/* Write a key */
-	sscanf(buf, "%lx", &val);
+	err = kstrtoul(buf, 16, &val);
+	if (err)
+		return err;
+
 	dcr_write(ppc440spe_mq_dcr_host, DCRN_MQ0_XORBA, val);
 	isync();
 
@@ -4368,7 +4372,7 @@ static ssize_t poly_store(struct device_driver *dev, const char *buf,
 			  size_t count)
 {
 	unsigned long reg, val;
-
+	int err;
 #ifdef CONFIG_440SP
 	/* 440SP uses default 0x14D polynomial only */
 	return -EINVAL;
@@ -4378,7 +4382,9 @@ static ssize_t poly_store(struct device_driver *dev, const char *buf,
 		return -EINVAL;
 
 	/* e.g., 0x14D or 0x11D */
-	sscanf(buf, "%lx", &val);
+	err = kstrtoul(buf, 16, &val);
+	if (err)
+		return err;
 
 	if (val & ~0x1FF)
 		return -EINVAL;
-- 
2.25.1

