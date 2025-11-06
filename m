Return-Path: <dmaengine+bounces-7088-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05987C3C247
	for <lists+dmaengine@lfdr.de>; Thu, 06 Nov 2025 16:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A70FD4E69D8
	for <lists+dmaengine@lfdr.de>; Thu,  6 Nov 2025 15:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07BA337102;
	Thu,  6 Nov 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ABNOmtDl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477B31A810
	for <dmaengine@vger.kernel.org>; Thu,  6 Nov 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443903; cv=none; b=tCCdhsmGE/a+zjMSxWyyzGl9QlF2uBxcIK6bxDJ3dM9YoVKDZUuw82K/0xyYs8QbvjnUY17SW+Q444hy/StT3LB6UZhNQVc6v9UyUx0R1l9Ok8lZfZjKZpNYbwVHJQ9v0N10/Hfo/DcDWY2Cph9mbsH7HrBxtQ5GdhPLC4NK/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443903; c=relaxed/simple;
	bh=qbhajpU0G4kJl7tgyhXKSP59dX10IT1q+klpIbWREpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jWMNeWFojArS1r9Gvc/rCKXqd300JFIuajWoAQoa4tkSOruFf5iq/aSofL8w8I/iBG+kcR6EgpOmZUPaN5N6S9tPq4kw/VDQ4UpEPGrgEz0J1hj88I1Yam+u4FuIq8g3mtV1VrsMKDO0kFRDVAqXl4eYZ8O7hkA5Ra0dcvsICJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ABNOmtDl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477549b3082so10558785e9.0
        for <dmaengine@vger.kernel.org>; Thu, 06 Nov 2025 07:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762443899; x=1763048699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x66guca1eftJPuWCv2VQqhGjAMisaYzjZ4uDuE1tm+w=;
        b=ABNOmtDl35JvgV5qJ97DZbDB9OFa2hGqfdga6fZENEGwfbMbWyHqOpOXyqlFmQUs5u
         FRkQcO/f4SaAStfqzL5LD9KjL7rH3BEC6OpeIsLS1hbEDLP8s4nIrlVoiM2aDCxO072y
         8g2cp89lLP3Xb6MdDLQ+jLVFKKvIjtcqKDdGFtt2uuuVZ2e1EmDEpcAZJeFBP0qnj9eO
         R1hJNlN7ibLfxQUgTcswMb0Jsip32qZZd+TtqQymrBaT3VkwZK/ww0/xImUksQocuC6T
         lsstcXySQXXvyBoAlNlN5Sr5FctH7JaqaZ8mOX2lxF9o/GEZB1XTbxV84GjofIBmjW0A
         4tEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443899; x=1763048699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x66guca1eftJPuWCv2VQqhGjAMisaYzjZ4uDuE1tm+w=;
        b=XLkiAMMAfZ8gfzjSJI8S9CBI4UhAfQESNMW/36UqDyKMZIrkUUPD74JCtXN2/S/3RZ
         TRI734Q/h10PAz+ktxRwZjlqTKMGgjDHBYCOl5w5jFJl9U0GSbW2x94zjZb6JfAq8dn6
         fY3us/BdgPdUVNM6cSH9LdjkBdn99AcCizDn5Xh77HLcQjogQz78RKhhcFVbd76ceMcO
         ELe/O47eufqWZpgMU+pFeU+fl1SLbdkMkFcXZ1Qfwh5pm6DV+Ljz7kc3lQLDUYdYliYM
         1VrrqulTAllTUTJCQAXutdxwEKVLC7OSgF/xYjMeEs4wXFE+GxptUxb9k60UIRXyvFAM
         1q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcySULT5ujjT7TWG39Ncj8fg6p50h9mC9BkvI0r5L5rPCOzIZSihBbwP+4nqXxD9A9ngfoA+Nm7Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlGeRvYfNrg7R91lpmpeYtbaToCIVmTjlRLWdqU/Gz2GhJ5Tz
	khxcF2tz425fJinsmZp+PCM3xk+UGb+OWhQHyGcVyt5dRQbEq9qQKtjpO93kUhvRE6A=
X-Gm-Gg: ASbGncv5U+vyyP+mN3vBIMRltc9LlEFE/Y1AXULoGcFUB/lDOOrafZ7cmkoJd5e2R6e
	OI3qCda80BJ822ihEFarCVDngPZG4Q8hKy9EKBgIk80xnVt9huMIhHvbpZ1w/b+AQz7QJIz1BIb
	98Ocflls2+3mw3HGLhqKNo1Jj3Sr1tDI+5yNR3wx69cZ6kcjoG8swEY3V3KMjv5//HtfdlP5ZMm
	4fd7N6GzXOS0rKGuKYxL0cwHziwxS8fu5CL6UAw/doCKNC+YiAbXJWHqYBvIULq1cc0VwPzM0xv
	NsG1lH1YUzXCqnQ6pehTRNU50/jfmDr+leRuMTKi2IQ0KGV4hdKwBITaFIBn4zFKdJZAYk1A2ai
	T7JFXkHveIwPtFTxVYSoVqxE1rHI6hREMa+NnCP1Oi12CzEVqTXpw1evSvtpM6M4pu5L7Hw==
X-Google-Smtp-Source: AGHT+IEGoGND80uf9mOa5zbUVNeRt3iYWwEu+Kyw+xpveCZRRlkiUNTnCbyfpa/6u3X0EIG0bh4BHQ==
X-Received: by 2002:a05:600c:841a:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-4775cdad627mr57791065e9.1.1762443899025;
        Thu, 06 Nov 2025 07:44:59 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e66b1fsm20621705e9.1.2025.11.06.07.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:44:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 16:44:50 +0100
Subject: [PATCH 1/3] dmaengine: qcom: bam_dma: order includes
 alphabetically
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-qcom-bam-dma-refactor-v1-1-0e2baaf3d81a@linaro.org>
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
In-Reply-To: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=e7cbrLbtrA2QdYXynWY0z/h9f2KdWIz0hBln6YJk0L0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDMJ3wDD2iDBCwRq63Jsh20+PEuvzfO1VNoM8c
 UWpJEg308SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQzCdwAKCRARpy6gFHHX
 cmvdD/9stMXXL0j4g69U3lcomFVsfQJQpzTmu+YskFtImN0Dwz9haq2L24+GCKQxrkb46zFkS9m
 mhc6DLIiWboRf9MmT4+tnh/Q9uuXGRZj9aLED1R5+4NJTWuuKFQHA6ZZmPVwgS5sCnY0omEVawX
 0wq93BmeG1ChHA+nvqubkhUE8rKWrcZIo+hWkpHZ8ncWjoEIc7nl4JVTgt5o6MpAxnCPY8NlGmu
 WbQIfOOF7ZPkibrQhDEfnKv5AMfiTktll1b+CJXxHv+i63R1oRxNmI+1SyT2HqVlIhQiBE7bECR
 RZEKztqv7bM/Dl4kOfJTW85sUHL+zt3YkTXbsSyA8HWgml0pcAdYmYMGiPp7lhFQwEmvoVy2NRr
 tUvdVSwNCb3bQR/fmxYaKLyIVPaQrVrjSFCGMiKgtlc6P/OgSDhoBHn7P+4jmBnf4YG7OCtCv0F
 bIBlVyuGbMjJLpeLToSmftHcytHwbohtX4sZbehnt9EiLjg2wFxlO6KcYBM0C3ooF+6BlaJnqah
 OwO/DLmp4r+exW8mW1F+P1Rm+dRYKiZznvuybJfy2dCjnG6g1Jxmo4BDu5gg/bjJi1DeBT/1Xnp
 I6Y8dn3C/c7rPp1XTD+ExTOEVWl4akKA1Fr8YZ5YxTl0M+E9aLN7g+nKuYv6VucZM+29WEkFZCV
 aAow4lMyOdoRxcw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For easier maintenance and better readability order all includes
alphabetically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/dma/qcom/bam_dma.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 2cf060174795fe326abaf053a7a7a10022455586..2f1f295d3e1ff910a5051c20dc09cb1e8077df82 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -23,24 +23,24 @@
  * indication of where the hardware is currently working.
  */
 
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-#include <linux/scatterlist.h>
-#include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/of_dma.h>
 #include <linux/circ_buf.h>
 #include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_dma.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
 
 #include "../dmaengine.h"
 #include "../virt-dma.h"

-- 
2.51.0


