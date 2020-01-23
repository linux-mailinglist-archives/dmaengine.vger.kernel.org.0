Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5357C146AB3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgAWODV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:21 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43284 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAWODV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 09:03:21 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: eVFpOUDn0nTfUWgpsYNbPwNLOqDGwOYXwD49py+WaGWaaFg9ovtl6MTND34A1laS3ZTaO9pWFK
 tgDxG1/G/mS/ldGxeNmskV539ELkBPe0zF+GINlc7jVwavtsqH8K3Ki+qu6hlDGCkqGp0xrlkc
 lRZW80wvRicLlLyZuyca0jnQgO76KfnoKxmeuktnwl1T6pNpztONZC0pI8hZcJN9+26w+WxPKC
 XjST2mBLWcf25C4uUv5NCTNJFu20dSJLOUADA9YuKQQ0HB+SkPElf/x2nV7yss2fkcquXdr8K1
 GGA=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="65735579"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Jan 2020 07:03:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQT6bvxm06gAAB6hEbCCa4c9oDPbhrvxN0mWnjOT46SaMdf7XutmK96Lph1knUqPuH+Q6wW5UuLImqkrS0MGyU1BaM40ayvMsp2DFoRp+VuH1jP8/uAPpV6yN347Eb3YcMBHTiY+nLN7ExEMOIuRLS+bVp4L3llwFe/Y0lsu8+G7NqKSriMhkxBe2rDhxwSiKPyBa2F1BpS8gI7QiEOgCHMSQzBEypQ+LaTER0FrCrFgC/BgB/uUwtsXKjtb4CZLnYFu0DDBNM7bR3nETMwY6RC5spOXDs6nXRGkGluwZjm5AyODzqDHLUWAUIf+WM3z8fhhAyiXJvpMrr8RlXUCyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8WJ40JAHNtvXacElpVMs4YRQfvkF3MRNJBTvWkM2N8=;
 b=UQpJQBd0UVZu3LWTirdfV/rwpwvzxoGidI0YuGi1zGYucpDTo5cRhppPc2oEaQY+tn9xgbX1+oo7bURt8Y1CL08wOxvwaAQJJGK/DbW1TwQl/rNSdb8AOBaIzbGdT21qJbyAMCQJTzgUmJ/ccFV0c+5w8RPtHJI201LaRLH2cREADz7fH8g5f4S+A8QqGYyQSrRghC1MFC0pzZILHsFfCVOPhZR4ZAkbpViI41N5zBwz7+Ug/+YrxW5qiXNPTXMu/6ubzHO10mxUedltGhNhgdMSQtWIXjdKz7qH74UrJ236GU3Fqrn45ZCV62A1Q/FESZfxht9Yq6j68F5/TGMDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8WJ40JAHNtvXacElpVMs4YRQfvkF3MRNJBTvWkM2N8=;
 b=K2hyK9oRey+l/anRvpdhb8Hgab8ICTzV9oexvNCW6N+XT7CW+gJKX6uStxoIYVpfHcfDOkHNXEtNqcP5Xn4KVs9Nn3FDQ0bl56+m7NeGCE4ClX2hXDlE2X11omvYwyiWeGfnYSK77ZYT3OTDEyGQYb33ehfbBkoaKkjtMu1Fo+U=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3582.namprd11.prod.outlook.com (20.178.251.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:14 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:14 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 08/10] dmaengine: at_xdmac: Drop locking in
 at_xdmac_alloc_chan_resources()
Thread-Topic: [PATCH 08/10] dmaengine: at_xdmac: Drop locking in
 at_xdmac_alloc_chan_resources()
Thread-Index: AQHV0fXaZQjnejE0TEqc5jyVns2qLw==
Date:   Thu, 23 Jan 2020 14:03:14 +0000
Message-ID: <20200123140237.125799-8-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc2f02dc-eb3b-451c-6129-08d7a00cfd36
x-ms-traffictypediagnostic: MN2PR11MB3582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3582AD3E8656222F68DD02AFF00F0@MN2PR11MB3582.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(2616005)(6486002)(316002)(26005)(36756003)(4326008)(81156014)(186003)(54906003)(110136005)(81166006)(6512007)(5660300002)(478600001)(8676002)(66946007)(64756008)(66476007)(76116006)(91956017)(66446008)(66556008)(1076003)(2906002)(6506007)(107886003)(8936002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3582;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8hyQjmdffQa3XJKJwR1xh0D9rh5fXcKQl+z7Is56whoEJrT2yIRowH6IKMzECv+heUHJrs/LiHsIsdyf4hB3RmdVJHwyHgnP//AManWpC80pprEmicM1AjrkCEc3ozKoomH7zi7jPRIzdLwy56QOu/oUnmkC4ZqKTz963r4Tse3wVqA7tf8HdSKOGiC/CHckTrMWkiszHGK1sDJLESepGOrutSjUusO1Vb7OYTnLtOTNNNyb8FsA4H+dNqpU236haaeZEl9OaMpgb0qufn7kxgoHL0vIq3WfunDEXCU5h+laNeV9JLuEbZLCkULSdhbpkFojhgv4dQki+TWkxATrJtkb4f/Tp/FknuryKOSnmMA0UvW/aHmJq3OrogQ/3kADwNF/9xxETiKf3hxv46pdsZMpPZ4HxKRZlCNhdTp6k6VWn/IhUzfmKkFUkFpfAni
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2f02dc-eb3b-451c-6129-08d7a00cfd36
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:14.2476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQKB7eLXAX2Sg+A5rRHJhTF2jQeD1VEPPJAFpCPuPBwPQPGVJ2Sw+S2NjBZ8+wjcZp0rxV2EDj9Hs9sZ30hv2Cts0Z8KhzqXm7ZMH4DUErQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3582
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

There is no need for locking in device_alloc_chan_resources(),
the DMA core takes care of it by using a dma_list_mutex around
the DMA devices.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 3d6e84def7a6..8fb01bc90ba7 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1820,22 +1820,17 @@ static int at_xdmac_alloc_chan_resources(struct dma=
_chan *chan)
 	struct at_xdmac_chan	*atchan =3D to_at_xdmac_chan(chan);
 	struct at_xdmac_desc	*desc;
 	int			i;
-	unsigned long		flags;
-
-	spin_lock_irqsave(&atchan->lock, flags);
=20
 	if (at_xdmac_chan_is_enabled(atchan)) {
 		dev_err(chan2dev(chan),
 			"can't allocate channel resources (channel enabled)\n");
-		i =3D -EIO;
-		goto spin_unlock;
+		return -EIO;
 	}
=20
 	if (!list_empty(&atchan->free_descs_list)) {
 		dev_err(chan2dev(chan),
 			"can't allocate channel resources (channel not free from a previous use=
)\n");
-		i =3D -EIO;
-		goto spin_unlock;
+		return -EIO;
 	}
=20
 	for (i =3D 0; i < init_nr_desc_per_channel; i++) {
@@ -1852,8 +1847,6 @@ static int at_xdmac_alloc_chan_resources(struct dma_c=
han *chan)
=20
 	dev_dbg(chan2dev(chan), "%s: allocated %d descriptors\n", __func__, i);
=20
-spin_unlock:
-	spin_unlock_irqrestore(&atchan->lock, flags);
 	return i;
 }
=20
--=20
2.23.0
