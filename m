Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0A156B7E
	for <lists+dmaengine@lfdr.de>; Sun,  9 Feb 2020 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgBIQlf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 9 Feb 2020 11:41:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35310 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgBIQld (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 9 Feb 2020 11:41:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so4430914ljb.2;
        Sun, 09 Feb 2020 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VT2b3DIhkLrsXocDLVqwdbb9fFwHJxhRiEwuiWhammQ=;
        b=VPVv7/AL+TZsIUN8+euFN7FQ/VfddNc6eHj9bDG60r4tqo8Aycn1TItOAw+jHiAjdw
         bJfVuoq6OpQBE2txANM4tSSQCN5HxlYXi85/bjuKu2CpFeQTbMRIIQF3aHG9ROE4R7GK
         qoLZVZNIO+j7vTdv+6u8EYUmUiNIPwes//5YFJjZ4AHsbhdp7rW99S9+1p+kiKr9zA8+
         FQ1INcG+7a4vD/LxFE0/tXSV1Cs25/SyeH00e/SqBO/MYAUPDGF3ODWc8Bl8LYJT2Qj+
         zRy3EpPBbDLHtdhIodLLnPfxULbphrhPzyhZEta+avxG3TMNjJ9FB6wwliMciIJsGE50
         w3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT2b3DIhkLrsXocDLVqwdbb9fFwHJxhRiEwuiWhammQ=;
        b=W5ScDxcUeYHfOujiSFTKGHhuhoqJLA+H5jL5YICy+OkF82ATa5wSEdPyY2ZehyJz/d
         zm+uf5OmZWiT9ij5VFDxLFUqDffahkuSIs1vwRFL/DauoShR9mZmoJ7o94xUth2e4p9D
         G7Tifn9/HEeR8zU0RZ2pPimExY1Ec2XfXXHrr2WwbpYcge6Jbxd5/am+EahU68J++z1f
         tN+URaOAZXoOeWkldQwnmWRqBLKZR6a0wzEmMgoKgINvr3Ju24gcbr5G/0LTBcIgH28z
         RxUBurHoDa2TeLxkfnXBYInVaFU5uIdh2tr7XtLxGUqGv9zKJZyvKwuAVZVrBMi+5zqz
         Ddyw==
X-Gm-Message-State: APjAAAXDidODrnJIgWKqnJiiz+ybkpj0Z5vrMqrvFWkYqJ2LTy8d7Fir
        Izez9oZEhwUlyAMvl5sYE5w=
X-Google-Smtp-Source: APXvYqz6o10grpCk0FrR7aS3FTOvey0ta5s11dD6fbhZ0bGqMR5TvYlyhMAXRaeglnrwYUvdgw0ZFw==
X-Received: by 2002:a2e:9f47:: with SMTP id v7mr5536421ljk.124.1581266491098;
        Sun, 09 Feb 2020 08:41:31 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id g21sm4941826ljj.53.2020.02.09.08.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 08:41:30 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 15/19] dmaengine: tegra-apb: Allow to compile as a loadable kernel module
Date:   Sun,  9 Feb 2020 19:33:52 +0300
Message-Id: <20200209163356.6439-16-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200209163356.6439-1-digetx@gmail.com>
References: <20200209163356.6439-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The driver's removal was fixed by a recent commit and module load/unload
is working well now, tested on Tegra30.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 5142da401db3..98daf3aafdcc 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -616,7 +616,7 @@ config TXX9_DMAC
 	  integrated in chips such as the Toshiba TX4927/38/39.
 
 config TEGRA20_APB_DMA
-	bool "NVIDIA Tegra20 APB DMA support"
+	tristate "NVIDIA Tegra20 APB DMA support"
 	depends on ARCH_TEGRA
 	select DMA_ENGINE
 	help
-- 
2.24.0

