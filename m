Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1513138783
	for <lists+dmaengine@lfdr.de>; Sun, 12 Jan 2020 18:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbgALRbf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 12 Jan 2020 12:31:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33734 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgALRbe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 12 Jan 2020 12:31:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id n25so5171820lfl.0;
        Sun, 12 Jan 2020 09:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVivrbUaLAvYOWEQyaxZv2B+LG1a8MlZfEIn/W+0au8=;
        b=SJjsUnuacjwEmmFeP1a4th9a3eAh0uaYtlNT7/X4jvCpH1AI7dHTBFWk0SVlk+b0IH
         E3hD/TbeBVZHBOEXVL5vr8LQthhIu2TW65i8uVVBOSt6h3cVUp/NmB97oYtccCmB8xx1
         gMCqnBds58LoBwEE3Wnze9BFP25Mxj9IVeSVm+I9WVmp07YH/FFuSvbrsfiWlmcdo/80
         Q6PgSqmBQeinfTpsuHqALeldYcuX2ZhlTFnl0t4hAqGaT8iYhoBIrHz0iF9jRewRWGUs
         gnvmjrGTKpb6f8DwiO6i6nQ5re1kqeRMs4jHLbvTxPsvoTdU0QiCvOy/m8HrEiCkE3fE
         4sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVivrbUaLAvYOWEQyaxZv2B+LG1a8MlZfEIn/W+0au8=;
        b=nAelAacijgjj34quagI8X6oD1Av8MAS6cZFRvUz/Bhd2cfeQRLMWmy3dUm/d2O0rsc
         BSYHkvdAjB3ScQaZ4V7tJ6cnzfegpolcP2aCMnNWFk7fzIEqnoT24CYcnYChHs6yTdOr
         eFXbCcnc4SySr0QQNF9lILG1PYJSvTiw1vpDXoEeNHqdkc6Dd4z7Pclp55Yr8eW3+es0
         xJE8vpwpH3IjiB+A1AwheSEUGI2hihkvQoFd5qICa3Nt+jIPpziEaqP5+NngbAuK0DeG
         m8l9tNaoFTY9CiLxl/3sYSan2taiKzbgOoVPm+3M+Ia9yA7hWQ4awX4ZTQIs0265NdKp
         4/zg==
X-Gm-Message-State: APjAAAXjeJsnO1tDEGQRN01el0dRB+dWz6ivRLvQpTFmfP0hUDA0AOpJ
        xiTCzydUbc5Tz+WIEUi+gHM=
X-Google-Smtp-Source: APXvYqxche74SfZP3bBOfOX10phuAZEUaoTHurS8Kbd28t9dK269h60bqAU/0dfFh9UYQFWgHAv9+w==
X-Received: by 2002:a19:8a06:: with SMTP id m6mr7003628lfd.99.1578850291621;
        Sun, 12 Jan 2020 09:31:31 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id 140sm4458888lfk.78.2020.01.12.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:31:31 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/14] dmaengine: tegra-apb: Prevent race conditions on channel's freeing
Date:   Sun, 12 Jan 2020 20:29:55 +0300
Message-Id: <20200112173006.29863-4-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200112173006.29863-1-digetx@gmail.com>
References: <20200112173006.29863-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's incorrect to check the channel's "busy" state without taking a lock.
That shouldn't cause any real troubles, nevertheless it's always better
not to have any race conditions in the code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/dma/tegra20-apb-dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 664e9c5df3ba..24ad3a5a04e3 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1294,8 +1294,7 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 
 	dev_dbg(tdc2dev(tdc), "Freeing channel %d\n", tdc->id);
 
-	if (tdc->busy)
-		tegra_dma_terminate_all(dc);
+	tegra_dma_terminate_all(dc);
 
 	spin_lock_irqsave(&tdc->lock, flags);
 	list_splice_init(&tdc->pending_sg_req, &sg_req_list);
-- 
2.24.0

