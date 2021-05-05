Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22F5374A95
	for <lists+dmaengine@lfdr.de>; Wed,  5 May 2021 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhEEVkn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 May 2021 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbhEEVka (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 May 2021 17:40:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748DC061352
        for <dmaengine@vger.kernel.org>; Wed,  5 May 2021 14:39:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p12so2788869pgj.10
        for <dmaengine@vger.kernel.org>; Wed, 05 May 2021 14:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulnvpDvs2fMyqboyMzQm9/EA+gzjDEWFkHrEeAbq2gg=;
        b=xmcZO9BqiiwuCQXEGkkeYd7kTJJnCMVlc5B/zNAatnZadm2F4mpDGLz70FeX8aAYsp
         3GFyJpGpbkP2/ke+MwZj/FcV+BGhCVSHg3tXAY+WEJ2/q2z6fvPB2ddNT0Q42dndrWXY
         JpuYGT07KXrOwLviGBuG8ocui5svisaAVu8f53ME5oF57ezd+rt93Ng534tD8SRlzjrh
         4kRh/gbzjtkP+ZzbDMb6bXIW41WV0EivelaE4nsZ4XydRjYmUxobYawILFQH3b7CTbWb
         e1aTBITfMsUcu7faoRdYieSUo/MByKX+D/+cugM92jG3qSyEwJRqDlPGjKnnv2sV45jm
         hDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulnvpDvs2fMyqboyMzQm9/EA+gzjDEWFkHrEeAbq2gg=;
        b=rTAncx8fhae62xBWvsVdtSYqX05HQR96eW0gtbbn1vxEpqWWHlUQICg1QdVdOXeBXJ
         0nI3LrWqCXNBYNwZ3Zc4HPrl+6YZBPmCj/M3esfghSGOOQJI/SX/6weTrXCqDd43S4Bp
         nWQE95GPet3TYwF8w4XsNGEh5JIdHZaLAvFRaAScV73fB3rxIuEO5hv2GEApJTiNv1Oh
         ZZQQpYBoi0TpenHKe1EJ4wKfOyhGg57eRd1kwCimz/h4X633T4zmfjrN6upwi1MaMYR2
         8sg8iIh1NkA8VVwnbaRSOiztVBmTOsa/4S5sl+dlAVZJ69XXQuo3JokY338Z1QhNALwV
         Z14g==
X-Gm-Message-State: AOAM530c1+NL+D4qiCdrY9H/1JR3cM9IoGbW1HwIonopKk8SYwWHyIkO
        DgVpMPHiZivdGqto/U/1MOSyHA==
X-Google-Smtp-Source: ABdhPJxn3lcn081f/vXnMNfPrbmSTIiujKSY5Dev3vHLCjfQw2M/otRYm+HvZ1PoiD00E0sPhZpRoA==
X-Received: by 2002:a65:4c0c:: with SMTP id u12mr911229pgq.122.1620250762971;
        Wed, 05 May 2021 14:39:22 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:39:22 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v2 13/17] crypto: qce: Convert the device found dev_dbg() to dev_info()
Date:   Thu,  6 May 2021 03:07:27 +0530
Message-Id: <20210505213731.538612-14-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

QCE crypto driver is right now too silent even if the probe() is ok
and a valid crypto IP version is found.

Convert the dev_dbg() message to a dev_info() instead.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index bae08fdfc44f..9a7d7ef94687 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -179,7 +179,7 @@ static int qce_check_version(struct qce_device *qce)
 	 */
 	qce->pipe_pair_id = qce->dma.rxchan->chan_id >> 1;
 
-	dev_dbg(qce->dev, "Crypto device found, version %d.%d.%d\n",
+	dev_info(qce->dev, "Crypto device found, version %d.%d.%d\n",
 		major, minor, step);
 
 	return 0;
-- 
2.30.2

