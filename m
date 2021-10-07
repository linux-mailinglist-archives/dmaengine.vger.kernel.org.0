Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311E14251C5
	for <lists+dmaengine@lfdr.de>; Thu,  7 Oct 2021 13:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhJGLPO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 7 Oct 2021 07:15:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52125 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbhJGLPN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 7 Oct 2021 07:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633605200; x=1665141200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RRpGJBI0gqQD/a+Q0yDIDXC0Gv/BgyAzXYWw9kQ6ODo=;
  b=x/wE8bnWMjc33tcRe+7OU9viCAtE79ig7sN8GU4klkEwBp84jMCVmrsR
   0CZVOr1Y9m31MZumd1qyPjanvrx7zMZ+zP4G82n4ehzrNn+c6+kPIMNSY
   c1YjCeAsML4YfYPf2H3xTEBKJsJMz5oI41mypJN7NEwebcgskCY4p+z3B
   A07XhwdCpLixSLmCfwXPRYON7dGujiJNcn7qNphpMH+8Nvu37bDN4hyFT
   Dbvvvb5+w3QcMHhwwqpvniTZnfhJT3Y16aI/rAa64GdTnlW35yjcIstl1
   iGaMJg5EyDF5Yaov3Dqbm1OI9738PgvTPF9DZ28W/mdo2opQFG0Owu72/
   w==;
IronPort-SDR: ie2Ypakj3LUIJPS3EoWe2I7mHso+0GTSuaotLEJa9JhAvTUmrjkd37gDStBUIq6iXGNogwehK3
 4Nha9QjyuGF6EwLoRtn0y0uWmRNgFLSIjxhSJ1Gc8mHFRMz7e8X3klpQKoElOZpbEV+b6fYWRD
 iKrC1R1PJ4w0ar4H3S0pBl5OIT7AnC9wM6AZKuk2y+DaV99aYathDNS1HxCQAgoUapuqzCl2k5
 aHZNroI3jkCRxxfpvRYpNqdK/3KinYOVgj2rJ1m3U2PZP5r0T4copDK5l0o5i8dJUjCN4FF4Wc
 tZwmVbGx/TjF/cW9ZliCkIv3
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="scan'208";a="138808603"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2021 04:13:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 7 Oct 2021 04:13:18 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 7 Oct 2021 04:13:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <tudor.ambarus@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/4] dmaengine: at_xdmac: fixes and code enhancements
Date:   Thu, 7 Oct 2021 14:12:26 +0300
Message-ID: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

The following series adds some fixes and code enhancements for at_xdmac
driver.

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  dmaengine: at_xdmac: call at_xdmac_axi_config() on resume path
  dmaengine: at_xdmac: fix AT_XDMAC_CC_PERID() macro
  dmaengine: at_xdmac: use __maybe_unused for pm functions
  dmaengine: at_xdmac: use pm_ptr()

 drivers/dma/at_xdmac.c | 67 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

-- 
2.25.1

