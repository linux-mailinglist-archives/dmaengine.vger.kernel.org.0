Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C54251CC
	for <lists+dmaengine@lfdr.de>; Thu,  7 Oct 2021 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbhJGLPW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 07:15:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52142 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbhJGLPU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Oct 2021 07:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633605208; x=1665141208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k/mSN7o+aoBZYxo/n7LsESco3AX+6x+Db3/dTL8XL34=;
  b=Y0NZyOJi338jz2D0nVo6X6qhLzu2j/ggRmZpXco5TE18t1Ei5BpJIDCE
   4NKznFpGkWsjciMYYZmv0bKDa18BpRgzbhxn4lrJSz7KNn0PcjPc7eK83
   5cHOwdB9r2M3iD9hFqsAGZDpW8WFG77ewkRaPRhGRQDzw+jKiQeJqCGbN
   aRiCU/R6EzePHkEUPyqPAaR44BRFXaownUpUWYNVi0yS2qD0C83anD3QZ
   J8FIagR8Z1DPdIfuq+2IV9e14Mt4bv+ThqSn7xDH0U+tU0AVbI1DNORM/
   MBXrKViulWWjh2ryMWZV2jYeZHd4VFQotS+n0yTIA2oMXz3cPYuIGXsVy
   w==;
IronPort-SDR: giOBcYN79/7gJcJ339ZhXg710xwf8hRdx3UUxXpgGI9hYeEBLw9OYTSP3MBFx0nj2rQvM1aj+i
 n2+1V4OGoAhWMnt5SbyT9WnMiqMA5t/bMh3Y8UMgtGoE6zbVwEWNbsEUOsHQgJxRwUEOpJp/Y9
 TBV0qNxzrJMmoTt6LYZnJwyy6MK5vMRhnaYakFXpEM0OrYIAp0k9OZIfgiCVzS7IgIN7uWzka/
 +P1xrivR6fiKGIKau3naW4E0AWOykxXuoBPWiCCNCGdvpKLzCGBxyxCkwVtEPk0yebRD9ed4Or
 jw/lO+hOr4vEExwoaxuseHFu
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="138808614"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 04:13:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 04:13:26 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 7 Oct 2021 04:13:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/4] dmaengine: at_xdmac: use pm_ptr()
Date:   Thu, 7 Oct 2021 14:12:30 +0300
Message-ID: <20211007111230.2331837-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use pm_ptr() macro to fill at_xdmac_driver.driver.pm.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 12371396fcc0..7fb19bd18ac3 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2231,7 +2231,7 @@ static struct platform_driver at_xdmac_driver = {
 	.driver = {
 		.name		= "at_xdmac",
 		.of_match_table	= of_match_ptr(atmel_xdmac_dt_ids),
-		.pm		= &atmel_xdmac_dev_pm_ops,
+		.pm		= pm_ptr(&atmel_xdmac_dev_pm_ops),
 	}
 };
 
-- 
2.25.1

