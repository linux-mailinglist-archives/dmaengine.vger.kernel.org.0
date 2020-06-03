Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152B91ED645
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2020 20:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFCSlM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Jun 2020 14:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCSlM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Jun 2020 14:41:12 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF18C08C5C0;
        Wed,  3 Jun 2020 11:41:12 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d7so3464108ioq.5;
        Wed, 03 Jun 2020 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4UZn1m8i+GTVFcPn+YVw+OUlQUVxZ68JK29N9qiN5LA=;
        b=jTHETujJmL8bdrqtHjJvJU0L8J+NhAyERxefQFrox2Z1sbmr241SO8FEYrhD1wSw0o
         CN5XRTwkEPPSRpmp8pdm/EuGz/hw8/MfIFyoUBMxRZ1BFhhX4en1Wb99NL8cYNlZOJbS
         GqNh51yWI9JOM5/IluSMK2mVSv+/WajRh1zhCxs7dN1Lhk3dbN05w1xF4TMLeIRADo0o
         BnTlLL5ll30st0reT7bTOf62hXaIctPSUjhdO9l5WUH+iftJrtfa4ABRRVVfuV+sIgxq
         f6s6nk5MZ4CknQQBF1JWOzmc/bSq7yDh2O0BbltOQgFs1c+FbX+IS5YCPRtUjckA+IZz
         AGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4UZn1m8i+GTVFcPn+YVw+OUlQUVxZ68JK29N9qiN5LA=;
        b=Jx5ZRFP7QD7u8ANjxJGHhX7Z405ahy0YEueyMYt8BUXLr7Th0s4u28nrPXu5t+OsQd
         NqL90EDYeFoNcelYRhwtENQS1q/xTfyNCLGl4DW3CXD6gB4xiPVLa7RbWhpLiWASk10I
         MOIzXYv8Xr5l5mAsClGzPQCqXrOfvIx5AERNHHuq2/zX0qtF36FG/6rH5d68wWd++kXD
         8AE8EJkLWA0B5tqWLH036Mmdezy3UaxWkd6LziW4Z5rmTSmeYN9ViRvsFg9/0rUZIdBI
         cbKXWLlqwWiEDuchIOkv2ZeVSt2ecn+TzTdQYkt0nEToKo0DwprXuPNN57/I8LIKWIiM
         NHfg==
X-Gm-Message-State: AOAM533gGYSIssPFUDMllx3SZIGcwbmPW7JsdyKdXs8S1xAPG4xK/OdR
        grVRBYLgt194GKrxcARCZwE=
X-Google-Smtp-Source: ABdhPJxT+Z+BosqqjpESxL62YHg0quvbIdfbSdkdLQeITvgOAij2bpfXodxRSygCGgbCItBvVFxHbA==
X-Received: by 2002:a5d:9310:: with SMTP id l16mr1006638ion.194.1591209671520;
        Wed, 03 Jun 2020 11:41:11 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id q15sm985488ioh.45.2020.06.03.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 11:41:11 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] dmaengine: tegra210-adma: fix pm_runtime_get_sync failure
Date:   Wed,  3 Jun 2020 13:41:04 -0500
Message-Id: <20200603184104.4475-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/dma/tegra210-adma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
index c4ce5dfb149b..e8c749cd3fe8 100644
--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -659,6 +659,7 @@ static int tegra_adma_alloc_chan_resources(struct dma_chan *dc)
 	ret = pm_runtime_get_sync(tdc2dev(tdc));
 	if (ret < 0) {
 		free_irq(tdc->irq, tdc);
+		pm_runtime_put(tdc2dev(tdc));
 		return ret;
 	}
 
-- 
2.17.1

