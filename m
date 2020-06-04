Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546B71EEC18
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2020 22:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgFDUer (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 4 Jun 2020 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgFDUer (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 4 Jun 2020 16:34:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A0C08C5C0;
        Thu,  4 Jun 2020 13:34:46 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o5so7843631iow.8;
        Thu, 04 Jun 2020 13:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M7Q89Pnob7mEEdbxzMTbqBnOtmvjG5A2VHrtAnUPQ0w=;
        b=bBRY4reOSBUGrcq3vOy11xefFwhEVWnsHPTs6UL45SJsQt2Z4zYs2OaYLIy5CcxW6U
         XITN+hrws3EspCgRH69VuwulRjE3KEIh2IUY9jiUwnmE+Crv0oet1XmSl/PmMU8h2oCu
         ZXijTnx8wBQlWU65Ia77+IsWascrMrNbSpRai2DWD0mMEaqmO7OJXkOLD0pQUsrcl2NL
         h4v+Z06cNVIhKlUT3egIeOX02c+ij+RHGNSsry6Z8vQwYcYWL5RpkvDSXZAkt/sS0kpf
         kNJJqbeM1DPUvIZsOlUvLNah0TpQ5rYT8RoALhHkxWrnn71wFwu7702plDhU4fPY8J4f
         Wqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M7Q89Pnob7mEEdbxzMTbqBnOtmvjG5A2VHrtAnUPQ0w=;
        b=eUolNRs8fINYWqR6uSSMBB8j0LVV41pmhle0JTQ1MygI9RZXNCQgiM+CCWsjFueFZm
         x2fXd+14egrrzjDDIDWDVIRBighqqgEDTwSObK56UESxDdVs72QDI4dVEZzqbkyDVy/m
         NCPm1kg0x4oQA/tCYNSkG9Hynm2DytSvMlcRZTDCLaE8yRQZ8P3q1/hythLSv5torQHJ
         CllLVuwxVgUUQMz7M04fXr13eJdUUuRnaqj7YB/0QYGnY3QmB3Gm21UC1igslsulMflZ
         m8Hc5Xl2AvWe/HZenoP4B05SjyYEEfW8nC8gUEkF06VaA8jnAxZ9juOcoFJFcXZCq1LP
         D9Xg==
X-Gm-Message-State: AOAM533x8o2sG85TlwOER2j7Z03dOMd2eN/uir/EKxjKA3D1DIfa9bbx
        9LXTO47T0UZZxUEUycosc4M=
X-Google-Smtp-Source: ABdhPJxuiZNAGq4D5Ba7EcCoWNGdaXWUKTsNjJghu9K8SoGaGdY5dQ4nTUo3EBGE5nnTuEd5VnkZug==
X-Received: by 2002:a02:94e6:: with SMTP id x93mr6062206jah.116.1591302885465;
        Thu, 04 Jun 2020 13:34:45 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id p10sm992141ilm.32.2020.06.04.13.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 13:34:45 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: [PATCH] dmaengine: rcar-dmac: handle pm_runtime_get_sync failure
Date:   Thu,  4 Jun 2020 15:34:30 -0500
Message-Id: <20200604203432.12082-1-navid.emamdoost@gmail.com>
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
 drivers/dma/sh/rcar-dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 59b36ab5d684..dd7ca67c93ed 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1879,6 +1879,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
+		pm_runtime_put(&pdev->dev);
 		return ret;
 	}
 
-- 
2.17.1

