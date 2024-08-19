Return-Path: <dmaengine+bounces-2900-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E729569C6
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1149C1F2327C
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6681216CD32;
	Mon, 19 Aug 2024 11:47:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9616C87A;
	Mon, 19 Aug 2024 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068038; cv=none; b=njUSQiUOWqw4ZFuLC6gIWFKvALF2Umi2F9gDZWjjntR8u4AVeigfzwOJB6TVwuBzWdtZoqqQVJ4d/+lA54oGbF5TpiKktir5qR7ma/kc/fNxlyT43AM8SJHkdW9t4oZxTImiqQXn0Lo0+SRieI/oMNkQZTH/mJPnYdQyNKvw/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068038; c=relaxed/simple;
	bh=n71Tc4j/yk2qLbxtHEISLr9b5WoeJfTIO0LlZ2c+ylI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3gMfjdQ0SApZhCC0w017SnD2IZ+nKnNCYO2jWiLQLnpz7gqfW9JlYNXBZ2H5qRBAFFdanpZcUu0JkHv76HZQiq1efbEqwz8wng4VW7zxBYlCiJS5T3HPhUb6C48AqRJPkbZr8ZGqMSmg2x220w7SN8+yqvNinARcYDub9Tb5a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnW4p277qzpTWN;
	Mon, 19 Aug 2024 19:45:46 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A90761800A5;
	Mon, 19 Aug 2024 19:47:14 +0800 (CST)
Received: from huawei.com (10.67.174.76) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:47:13 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <openipmi-developer@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC: <minyard@acm.org>, <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
	<daniel@zonque.org>, <haojian.zhuang@gmail.com>, <robert.jarzmik@free.fr>,
	<morbidrsa@gmail.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>,
	<codrin.ciubotariu@microchip.com>, <andi.shyti@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
	<stern@rowland.harvard.edu>, <u.kleine-koenig@pengutronix.de>,
	<duje.mihanovic@skole.hr>, <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>, <liuyuntao12@huawei.com>
Subject: [PATCH -next 8/9] dmaengine: at_hdmac: fix module autoloading
Date: Mon, 19 Aug 2024 11:38:54 +0000
Message-ID: <20240819113855.787149-9-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819113855.787149-1-liuyuntao12@huawei.com>
References: <20240819113855.787149-1-liuyuntao12@huawei.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from platform_device_id table.

Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
---
 drivers/dma/at_hdmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 40052d1bd0b5..614c60b16ee5 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1904,6 +1904,7 @@ static const struct platform_device_id atdma_devtypes[] = {
 		/* sentinel */
 	}
 };
+MODULE_DEVICE_TABLE(platform, atdma_devtypes);
 
 static inline const struct at_dma_platform_data * __init at_dma_get_driver_data(
 						struct platform_device *pdev)
-- 
2.34.1


