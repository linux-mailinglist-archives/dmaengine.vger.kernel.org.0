Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D603214D5C7
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 05:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgA3Elc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 23:41:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37420 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgA3Ela (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 23:41:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so2342951wru.4;
        Wed, 29 Jan 2020 20:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FNAQ91XilBKtgAieSWbzITQUhnG+T3TSX8YX8IekYAY=;
        b=dUULSmdsC2EIx3rzK5K1RQQyYSZZOJc5xA/PS1f/t+VytmLHV45MYlGy1PXX98eDQp
         qze720x0DC3DqRSaiiRGqSrzjv/zO89sgpIDXD1Qk+wVmT87LiU5+Ghwgw/Ri9FTpz09
         swl50XutcVJBPbl/fofipSGfXbM7t9L/wKIMt1FH4W79s7eOT+Uy/kdgy/1X66J0ygol
         BhoWe3GIBRz5FQTayinPV/wjLoLQOBQyFm+feHH714+7H6vsqQV6LKOVPV/+uf24lWW9
         ogfE/w4tMT2JhlX287HMd8zX4zsIPnCXf36DsFDOkL3faMMqTMfQ5PpWM9whzSy2Cg1Q
         v5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FNAQ91XilBKtgAieSWbzITQUhnG+T3TSX8YX8IekYAY=;
        b=SHfpInUr7Y8RwHuol68Y0GtRIoInax7IIJDUS3sX+X1QDnzxJ705pb341GaQbJGxDo
         khb4okA19cdUFNVAik1ryC8UI+/sygLChuzFdnbQIT/M3zGHiGxBsPlqddW8Wst0POOu
         OshUTMrtyc61k49vti/NJGUrUXJdOSpjBtLTA8yngt6e7Sra0iwJLaKkL1eHTo9ZmUWb
         x9KEYVxcLvCCsyeVJGj/gZrG+vFhy0JPSdfm7KnolVFbsT+84GwUHM3E/UtoHjbxZr0I
         uFT8pEfzP/Cu225aJjsFlS+3H1Q2tJOyXX3Nw+UnIXosu4I/VhswrWmrQ86W5PD/x5iN
         82iw==
X-Gm-Message-State: APjAAAUYSyQ59NgDOFt+5Gyv7fePdkXavTaiHmFbx4zbtQzPX+83qceP
        4Mc28kZusMa/ACRLpBqNJXw=
X-Google-Smtp-Source: APXvYqxJuJrPVi+A6d0bJykaHhgmYett+01HWJrEWYang3scGfcH6Aei+J6a8PBnXu/bEouzyG8gjw==
X-Received: by 2002:adf:a41c:: with SMTP id d28mr2917555wra.410.1580359289165;
        Wed, 29 Jan 2020 20:41:29 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g128sm4494672wme.47.2020.01.29.20.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 20:41:28 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 15/16] dmaengine: tegra-apb: Remove MODULE_ALIAS
Date:   Thu, 30 Jan 2020 07:38:03 +0300
Message-Id: <20200130043804.32243-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200130043804.32243-1-digetx@gmail.com>
References: <20200130043804.32243-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Tegra APB DMA driver is an Open Firmware driver, so it uses OF alias
naming scheme which overrides MODULE_ALIAS, meaning that MODULE_ALIAS
does nothing and could be removed safely.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 8f4281ab6296..756a5dbef118 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1684,7 +1684,6 @@ static struct platform_driver tegra_dmac_driver = {
 
 module_platform_driver(tegra_dmac_driver);
 
-MODULE_ALIAS("platform:tegra20-apbdma");
 MODULE_DESCRIPTION("NVIDIA Tegra APB DMA Controller driver");
 MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.24.0

