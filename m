Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239681142D1
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2019 15:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfLEOiE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Dec 2019 09:38:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42718 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfLEOiE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 5 Dec 2019 09:38:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id e28so3821509ljo.9
        for <dmaengine@vger.kernel.org>; Thu, 05 Dec 2019 06:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LSrF1PZUXbppNkp6LXsmHrupmqPqLYDRsBF1XZV1SZg=;
        b=sxN67uP4loA2uHVs+iOAju81idbHAz9JP72QF6fKvTGIBFrU1Ua8i01zaU68+uf3r/
         urNNV+Iz+exbXJ5FVf9/xL0wwVLxJjGMy26aTWthtKyBHeJBU5QpIlUOCXNIsTUcs+RI
         jiB7cRjBt+fPB+dm138tcJkjdDnnJQTJjor5aPFh5cLcVvaKvYoGabS5xUxT+xqe+XTR
         CiEWOrrv5UtBchNW0igsiGTTUPyx54CeEfWEr0YP0OE4UKZUp8E4o3mG9k61O8F4hSOG
         z2rSjx62rxmpyyqczRq84KZH7KyFgTOoApJxXSdZnwHiaqZKTxbYqLxQHf+MS3yi9UWl
         126g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LSrF1PZUXbppNkp6LXsmHrupmqPqLYDRsBF1XZV1SZg=;
        b=oQkJl3J2PKQWI++S/Jaf/MXWCIdg71jL6AphZo2eOQK4/IKYbhb/M/1ZqF5Yyl8RZl
         UEGYFSmfdDDyoMhQLOkWUdmMTddEq4Wk9J4WlLQ+ABRMu9rObIxvrs4RoRszH7fmvTJ1
         bXl6Qun8IrbxpYYcyPLDHUMM8wYN5GkLiit8kyx6TpKVjLfLtBXvNdnkhOYuKCpPe544
         Ucwn5UjLLbvE7cGgbVoNc+0c3O+nmcID2PxWgBCa4rGsGmOAy7CBdtoAvj0dBYgeJXbJ
         j6jKqp0yf8G1dG9G6QYt5COpF3r4H9MceTElAPAgfkAQV9u+LxMYREZ207XyqIuwBk7Z
         C7Wg==
X-Gm-Message-State: APjAAAU3IAGf9q4jJ+nuxiQqK+0FDpMFZCLZzPPPdHh54HR53Kr4MOQw
        7fep3LWaw+LocuhqNhW9/u9neg==
X-Google-Smtp-Source: APXvYqwS24lod+spv8JCEF1FwqJCKBEO1ZzNkv2x+NXiSPtPs2deTNm4TBwRmXyfhjEheQuZ3E/lQg==
X-Received: by 2002:a05:651c:112d:: with SMTP id e13mr4993155ljo.99.1575556682219;
        Thu, 05 Dec 2019 06:38:02 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q10sm5091294ljj.60.2019.12.05.06.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:38:01 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] dmaengine: pl330: Drop boilerplate code for suspend/resume
Date:   Thu,  5 Dec 2019 15:37:45 +0100
Message-Id: <20191205143746.24873-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205143746.24873-1-ulf.hansson@linaro.org>
References: <20191205143746.24873-1-ulf.hansson@linaro.org>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Let's drop the boilerplate code in the system suspend/resume callbacks and
convert to use pm_runtime_force_suspend|resume(). This change also has a
nice side effect, as pm_runtime_force_resume() may decide to leave the
device in low power state, when that is feasible, thus avoiding to waste
both time and energy during system resume.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/dma/pl330.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 6cce9ef61b29..8e01da157518 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2961,12 +2961,7 @@ static int __maybe_unused pl330_suspend(struct device *dev)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 
-	pm_runtime_disable(dev);
-
-	if (!pm_runtime_status_suspended(dev)) {
-		/* amba did not disable the clock */
-		amba_pclk_disable(pcdev);
-	}
+	pm_runtime_force_suspend(dev);
 	amba_pclk_unprepare(pcdev);
 
 	return 0;
@@ -2981,10 +2976,7 @@ static int __maybe_unused pl330_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_status_suspended(dev))
-		ret = amba_pclk_enable(pcdev);
-
-	pm_runtime_enable(dev);
+	pm_runtime_force_resume(dev);
 
 	return ret;
 }
-- 
2.17.1

