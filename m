Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE723C35A5
	for <lists+dmaengine@lfdr.de>; Sat, 10 Jul 2021 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGJQ5W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 10 Jul 2021 12:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhGJQ5W (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 10 Jul 2021 12:57:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0EEC0613DD;
        Sat, 10 Jul 2021 09:54:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ca14so2280868edb.2;
        Sat, 10 Jul 2021 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qN42ft8TO2D20OJfcUBVmNsGjubNKzxaIpoGBDjnO30=;
        b=KG0sSGBzPIyk5dn/9sNt5fk1YQ28ryo6J2vVotiVbPPWEYatde9dumrcWhqceKiI3f
         IPDwqLnDEWzLXU4vPZg6+SegLfF3/3Fvf1Isv1yl3+vTyl+pgYUDMKM9493eZ7qT0H6o
         5b0907j01AT7ZHVH4/ByLhKetsMah6WUxupKX5PMuvRFiBj1gQKNDlHIuU5sPKJDBnDt
         YUqV5R/mnwb5U9eQgia3WxIs6JQDH1RYmi2/snrCPZ8H4rvyP/iulnc6+hBdBYWwzhp0
         u1/Sgp9M50AGqYuBpdzY4FElsnwk0WjKDAZPGi/gKFo3pKmp5QH5WZPeBc6OWP7ERKdi
         eviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qN42ft8TO2D20OJfcUBVmNsGjubNKzxaIpoGBDjnO30=;
        b=Met8Keoe20GeKKAbmMkhcE6xTxioMMieM6xU+jE5IEXSojveYpKmAuvoCqQfadHQOV
         VanYY9hRyEB4IevKCjnRt1Lr3MVDPPc3Q5so7blJ4o+lDFSslE0XNYsUMhDOyj/0axT3
         +p8lzCMm8LXStTzmmpR1r6N9fTRHXRIeCJyBB2+0T5J8h6NWO1QoQBZCbL+KGPjuID7R
         f37+66cDl5NscrUbAGDPBytCRwhzIAHdafr/uKb4Hq7RWIC0KWelBq+O5Kj/edocqtXs
         jPI5JaH8J5wkYF5jPywZK8VfpTio05KVvUILLuZQNjrRKqBHYcUYG2+6Kimtwj+N2L01
         HCNg==
X-Gm-Message-State: AOAM533caYDaWphKQPTZG+UxXxrzJ7GBtUjWBfIK6jd58nkrBi0pWkS6
        N5xy21kh4SomMGbaeSNHPDYyxAt6Ovw=
X-Google-Smtp-Source: ABdhPJyGZeQGHL0WIRf20gdnN8dNBz8RmT6sCRdzAsQgX3VQjmUP/4iWG4gOTCW+bCr/hOuxLfsJ5A==
X-Received: by 2002:aa7:dc01:: with SMTP id b1mr54151950edu.239.1625936074121;
        Sat, 10 Jul 2021 09:54:34 -0700 (PDT)
Received: from pc ([196.235.212.194])
        by smtp.gmail.com with ESMTPSA id e2sm4854801edy.12.2021.07.10.09.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 09:54:33 -0700 (PDT)
Date:   Sat, 10 Jul 2021 17:54:32 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     vkoul@kernel.org, krzk@kernel.org, allen.lkml@gmail.com,
        romain.perier@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND] ppc4xx: replace sscanf() by kstrtoul()
Message-ID: <20210710165432.GA690401@pc>
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

