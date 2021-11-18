Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29574558BB
	for <lists+dmaengine@lfdr.de>; Thu, 18 Nov 2021 11:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245539AbhKRKOZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 Nov 2021 05:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245435AbhKRKNJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 Nov 2021 05:13:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EB3C061207
        for <dmaengine@vger.kernel.org>; Thu, 18 Nov 2021 02:10:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso7144256wmr.4
        for <dmaengine@vger.kernel.org>; Thu, 18 Nov 2021 02:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSWch0XGdw9WQfitAuDG0nGa0+fWKH7MnIQOOP6eHa0=;
        b=mhwGrcez7SQFjrLcUMtrR3wacB+60WOedOKv1UMCuLk1SLgWtQ4PXv8wCS+CQf0kIn
         sNol+rWyJF5bQibbwEjUu5q7LWitxlip7qjz07FN335WBidXTapsTzuPnXtLyKWtxhPi
         JnMZRkl00cG0PN8Ycu6vLAWcIqjfFLOdAjRjVMYROBGhmjgETUyGDM/LOEI91+dO5loG
         qKeym2w1biDZmapDPmpSGppg/VmbyWIoHBD3DqR+FVBI0OesgQaQ0SaNZntCu+LCGKcp
         Jo4h44c99aHXB/lHwPXrbzooLIoVE706L+k7zvkOpl3U0OlCJtiCr3nHPOgMrh1mQxV1
         Kfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSWch0XGdw9WQfitAuDG0nGa0+fWKH7MnIQOOP6eHa0=;
        b=HWAy4opDF1xdlwdiM+uh1ofT/YM8v7zMMoiZhs6yweqm8ZMJRIwAWQRXji/s50NbYw
         4O1lLp8/wFh/UtKg7Foa6a169Sr4C6iWV21f7EjI7SH3fEUr5AkPHYL7dN/+oj4rM1Fi
         AgVfznPTcwgs0do/IW8MUU7/+3JYl1fs9Twt2/TJm9x+x20OjE7cbGl9jS1Hl+8Xdjv/
         LwuBOSg2zP4q/rR3iv7mvr1dKUlIPhtnJc0aAunuW02pAW3WLQ7JTcPF5ts/4eY39lGd
         jBAHlpkWFOhiMbv9ZH55uPRgsIc82oxFPvZoUzVnjGUAM1W1fb86t0AJnIfdb9J1wjf/
         xccw==
X-Gm-Message-State: AOAM533Ojr62NJ36vSLFQNpDrHisiUzZIBNDJ8s5tXD2W1poe4LeVZPR
        flCbRH75y3l69ISa4YHCI9vwyg==
X-Google-Smtp-Source: ABdhPJwmQzBp0qtPSPyB7UjYy4JS90aVhF5fASBfXtrnRETwo038+eyorpDtUHvPdbLFf2JhN5T10Q==
X-Received: by 2002:a05:600c:2118:: with SMTP id u24mr8389385wml.0.1637230207856;
        Thu, 18 Nov 2021 02:10:07 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z15sm2525846wrr.65.2021.11.18.02.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:10:07 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@linaro.org
Subject: [PATCH 2/2] Documentation: dmaengine: Correctly describe dmatest with channel unset
Date:   Thu, 18 Nov 2021 10:09:52 +0000
Message-Id: <20211118100952.27268-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118100952.27268-1-daniel.thompson@linaro.org>
References: <20211118100952.27268-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Currently the documentation states that channels must be configured before
running the dmatest. This has not been true since commit 6b41030fdc79
("dmaengine: dmatest: Restore default for channel"). Fix accordingly.

Fixes: 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 Documentation/driver-api/dmaengine/dmatest.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/dmatest.rst b/Documentation/driver-api/dmaengine/dmatest.rst
index 529cc2cbbb1b..cf9859cd0b43 100644
--- a/Documentation/driver-api/dmaengine/dmatest.rst
+++ b/Documentation/driver-api/dmaengine/dmatest.rst
@@ -153,13 +153,14 @@ Part 5 - Handling channel allocation
 Allocating Channels
 -------------------
 
-Channels are required to be configured prior to starting the test run.
-Attempting to run the test without configuring the channels will fail.
+Channels do not need to be configured prior to starting a test run. Attempting
+to run the test without configuring the channels will result in testing any
+channels that are available.
 
 Example::
 
     % echo 1 > /sys/module/dmatest/parameters/run
-    dmatest: Could not start test, no channels configured
+    dmatest: No channels configured, continue with any
 
 Channels are registered using the "channel" parameter. Channels can be requested by their
 name, once requested, the channel is registered and a pending thread is added to the test list.
-- 
2.33.0

