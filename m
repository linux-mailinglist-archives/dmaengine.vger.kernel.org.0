Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD915146AB2
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAWODU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:20 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:59663 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgAWODR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 09:03:17 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: J+UCl9oqSXh5h+b1AqlEGWYJjur7WYRFlz2R8DJnh5/NE5hpi345CBA3+U+8X4j2Zbscyyv+vk
 RPt5NsxMN3JyYeORpr3tbj2umbrq/0qDOnW5RAuD06tfn9doOsK8zaNJ1B2Xj9nY/Ssvi88BiY
 1FcNrPoRP8KwEVKyppbbX41+QYSDHJy+kA6nNj2vYbXneFn/lgcitqgEsQTlqQo2LGavAu8ioE
 wsHemhz3gOGuO2xjbtfWPUzY4Rnd/TDZWoESX8k9G8ZWnj7hz7VO7iJ6hWW+r6VnG5+zYmeeuf
 Itw=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="61795150"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Jan 2020 07:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw21m/CkNl4dDtFUjnbVGd5VljIlSvd2ZkJrKhSv8LarPdaJikqbe/YH/XxHCM4GhmRBuPEurgC9zCs4yxVXZPnuEyJqLzCggxoqbaE7eQ74fQHfV+vNCuNztsRBDa8WDab+SuZgkl2NZQxtlcnQRd7HVV1/OZwsLPDXoXfIUPYdpcjh2OKnDWfGT0Li7y96r9mqumT3PpWP8QQxyQszLCutFM1/mqmatUutQQuQX5pTV8ruIZuk0saCicSvo3Yesnm7GYa6QHAns8um7j5gp+frDk+DJyMdNgzMayESUBhuDCYDDyOakCoUzV70UMh8I5Vqkqrk1qCtwd8jh6XDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvJaVMeAjvnduoZnVGPo0vCM73snETi768FFqnDBLb4=;
 b=JYJkNIv60pNkQFRjlDNegG7gqpGnBN/Wu3vm5i7TmCRYDAHlVXs5sQcFk95mM33J2vCrt/xAi/xfy2tAIE7LCKdXghn581QbHFQTNxG66y4CLsLZp1T0GiGjgUospHT6sg0ixWZFRmOOQGOawY81+vJBfSZ4ChqyOL0DybK4y+dgtGDLIjCEjjmO07ZnTpKuWdC8iyOlCSL4tcLeO1cEKrL/P9K7yRo9kfxNspjE5v1Ya5bN4iiMB6EAYMQYpDPMNI0flQcpFscvIQyKqjCuO8wNVB1ToVRBRn6tAj9Zt+4BsJaGQ6UELe7q3TMjnbcSojhOxP1in7/9d2vvA7T4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvJaVMeAjvnduoZnVGPo0vCM73snETi768FFqnDBLb4=;
 b=bPwfCk+VLLErIfeF+tMWyckYNG+AKdXkGe9/kLQtIm6Fnz1qv3SGSAV5VPtGZeR8oBvKgnDbM0YypOXFEQmZ6MUp3qhctIo2zUYnXujEQSvSkuIb2FFjRw1j20tnx9+LK5uP4m+5F+jRyqmcqhMBj0iWG/8dAavWZjSF7DJWcyQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3582.namprd11.prod.outlook.com (20.178.251.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:12 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 07/10] dmaengine: at_xdmac: Drop always true check
Thread-Topic: [PATCH 07/10] dmaengine: at_xdmac: Drop always true check
Thread-Index: AQHV0fXZBZaAhMQN4EGCBG7fYIqIiQ==
Date:   Thu, 23 Jan 2020 14:03:12 +0000
Message-ID: <20200123140237.125799-7-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9103a7d8-17b3-4b3f-895c-08d7a00cfc39
x-ms-traffictypediagnostic: MN2PR11MB3582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB35821D457303C2B17CD24EECF00F0@MN2PR11MB3582.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(2616005)(6486002)(316002)(26005)(36756003)(4326008)(81156014)(186003)(54906003)(110136005)(81166006)(6512007)(5660300002)(478600001)(8676002)(66946007)(64756008)(66476007)(76116006)(91956017)(66446008)(66556008)(1076003)(2906002)(4744005)(6506007)(107886003)(8936002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3582;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQJCu0j2QHQn5m1YQOH2HvtI1tWfxYk8RKe3uHM+C46Mynt3ManzdXW2fwbcE9ir12ybRv7s6mjWH8MZfdojlV7zQnt51iBko+Ki89NT1JWoRZPcN4bLFOyTS7o5Pai3SJAy2pyn1+pGVYoePftGUuQdPnzoMcqpmXYPiJX9zvOBpWanw/bwKOWAGLDIxpPhgIyj/F3XsFiLHLHuS2QQNQQSgC8sTMI8aMw3z2ipTj4O5ROQtGm/h7bKbBCxd+a/UWdmwNgAr7fBkRTfoDkfD4DSFnYhESR0d8W5Nt1x1MuH9kLLC7ZiZon8GF/9OUWtA3B60UtEpWlIOr34AfpMJMbz003i+XSTxYsmuAHqyL1mYt6YxFE8/4VAqcmclE4SeOM9M12cVAl3Zigr26G+Tsgcl4Xdry1leajqDbXM057ok7kogI7onvUyKZG3fbwf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9103a7d8-17b3-4b3f-895c-08d7a00cfc39
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:12.6856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F4waPFdTJ3QHf44ZeBEzncLiBbiJ9IE+1f779T9shBt2LG/wEyrgQh6RsMAx6mwJP2QjzVkbsjKxSW2TQte0mfsW0190MLOTuldE0KZIl54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3582
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The code in cause is already in the else case of
'if (at_xdmac_chan_is_cyclic(atchan))', drop the redundant check.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index f71c9f77d405..3d6e84def7a6 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1656,11 +1656,9 @@ static void at_xdmac_tasklet(unsigned long data)
 		at_xdmac_remove_xfer(atchan, desc);
 		spin_unlock(&atchan->lock);
=20
-		if (!at_xdmac_chan_is_cyclic(atchan)) {
-			dma_cookie_complete(txd);
-			if (txd->flags & DMA_PREP_INTERRUPT)
-				dmaengine_desc_get_callback_invoke(txd, NULL);
-		}
+		dma_cookie_complete(txd);
+		if (txd->flags & DMA_PREP_INTERRUPT)
+			dmaengine_desc_get_callback_invoke(txd, NULL);
=20
 		dma_run_dependencies(txd);
=20
--=20
2.23.0
