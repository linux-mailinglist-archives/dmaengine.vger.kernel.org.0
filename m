Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63655146AA6
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAWODK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:10 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22605 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgAWODJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 09:03:09 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: KHa/lZWbE0neflBDJwen8BlHOVWBXbaF/pASxTvW0x5yW0IIK7O9/FDFusnAnypZAngSBvBOfj
 QZjxu5lwnf2oUoWwYfNFYFkT7IupzqrWIRxB9OHA4upeNS9xO6sEStF2/Ff8Yt6b+mJ7d8euC1
 k1YhO0Wu+7bwZeK3dmOp9ACvQGjWTDF19CdftBlWEc+fqUKK584TiXcpm17JSU+QLOAV1ByVSw
 q2JBJ/HzfVtw6w46/knunnlsoDbR7n0Mk5+9sE4jcbgv/d5x8mG/kBXq1M2VVtV0gBuVa+0bO4
 B9k=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="62879868"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Jan 2020 07:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnVuRcllFaTIFVW/D+jWIDilW4OsyfJZ/i1mnKTFKB2n1mYSjj2vNWbK4DGzpU6130TyKISANUVhVN6dSeJBSo770Pf77CN3uufOhY+oimZWu3hiSVBivjajIsgTppGsT+IXLRmSkZOix9807dt2hchU8paUVVLlUw6hOn5/PVCntOQJbklArF7IUAvZaFzIpD12wH437ijkJZEQqOnQ4PYndWaYMDwKeNEMect9jfOot2hOmuMe8UZ188dHF0oVPPrQztdrEMn4GIyshsTdTC0UCXimWcBkStj0f1PGqFoa1HpTY2/YpbLRi5uMkZnO8w94VqxcI8MmbVfotfeeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P11396+/3esw2Nfwf9KjTA7joaB01p8Gu/BbAl1qD2s=;
 b=ZnIqBXXQtwPlzwGGiMVtA8anrBYjMip7V5tI6q068jNzRfV5Pl9rN4VAcqfASu5/CEU4C0QLgBenKZzKgTJUS5sxtD/n8UChtfMMQ49qvlxBDTzdB/Dzz7bHPPPOg09QaqVgKKxwj9j54iXvv1kDq5kJCoIMcGBBgf2qG0vTGGiBtwpx8KDLsD/uLA6X+3/knKhphwurP2/f5IglrGS6lo8aQqT3hAt/H5vcrd1z37Dm0UDMVjt8aEhtzDkZ0XvYtI5pNrH3HWfE6ffOoSpz/CLXATnSd8LswLXJsefMmpQRMIWwjS6B2trLdiMEpj/mDWkjlEZLry7Ub7RSK2Qk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P11396+/3esw2Nfwf9KjTA7joaB01p8Gu/BbAl1qD2s=;
 b=mW1q7kuCBLVa4CwDAZga2qYLy+Hvg8xPt/N6w/YlGpEj4bHdNd/0JTUempGoGHGvROmU/GEOA0jKTM8PvEU0OnC8QIrtdebVfDeh50I7o7PXcqUnG/GjUMh8nLWbq05EhxLMW/j1Ve6klnkvUAx7FicKHOSqNvSVx4PKKatVO2U=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3582.namprd11.prod.outlook.com (20.178.251.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:04 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 02/10] dmaengine: at_hdmac: Drop locking in
 at_hdmac_alloc_chan_resources()
Thread-Topic: [PATCH 02/10] dmaengine: at_hdmac: Drop locking in
 at_hdmac_alloc_chan_resources()
Thread-Index: AQHV0fXUgX6234GlxUCdz13FB0kPlg==
Date:   Thu, 23 Jan 2020 14:03:04 +0000
Message-ID: <20200123140237.125799-2-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27f5d24f-7386-4296-26d7-08d7a00cf74b
x-ms-traffictypediagnostic: MN2PR11MB3582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB358258855CD171294C38EC00F00F0@MN2PR11MB3582.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(2616005)(6486002)(316002)(26005)(36756003)(4326008)(81156014)(186003)(54906003)(110136005)(81166006)(6512007)(5660300002)(478600001)(8676002)(66946007)(64756008)(66476007)(76116006)(91956017)(66446008)(66556008)(1076003)(2906002)(6506007)(107886003)(8936002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3582;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yGQPCMGeoXz+/ZvNfmRZhmSLYis/DGk4Hx2y9m+N/jcUf6FBy48GlX7QlzH1L0ehIfDYoLb4C/rgTlXeC6BKSbyymJ5vwiauzXCWdkZVW0jWy9ugeAhiyWYMxg20ZU21zHVHLxn2zRmY/E+o5PUQAtlVrDLGw8wsT/vTsZW2Gg4wtRxVuxeBMyOK8+vGm8dFjgqaWHDFD+0WjN8SdLY9fVlDN3NBVCYNKMr00G+ouk1Y8mCaTdWp3Jhdk2H1ujWHUByX3Mr0140I2EB9kfEv9c9M1ugy3KTwN2N6VEFCu2dpKCE9Bg3d1tWw2VdhN4Y5U4kV+6w+hrYW1tokLKuPmN/bbdOMIFKHttHUlGfwgNqI7UO4N6nbmUStv9S0CdA9FiqHDXzMtaIPyEwZcIzxFupiOM/GO/X5drrhGoqZGkIB7PTqpgHSJpMSu6vqGEof
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f5d24f-7386-4296-26d7-08d7a00cf74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:04.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXb7tGC+507enSK/VYDJBM6NZ6ywSKWVHbSwaf11UcoxwDv3eC7Mm+ksHYkmzRSg+U/7Z+98a+Kxbda87uswJAicDgifCS4mlY4FKDd8M6A=
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
 drivers/dma/at_hdmac.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index cad6dcd9cfb5..301bae45cf8d 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1542,10 +1542,8 @@ static int atc_alloc_chan_resources(struct dma_chan =
*chan)
 	struct at_dma		*atdma =3D to_at_dma(chan->device);
 	struct at_desc		*desc;
 	struct at_dma_slave	*atslave;
-	unsigned long		flags;
 	int			i;
 	u32			cfg;
-	LIST_HEAD(tmp_list);
=20
 	dev_vdbg(chan2dev(chan), "alloc_chan_resources\n");
=20
@@ -1583,14 +1581,11 @@ static int atc_alloc_chan_resources(struct dma_chan=
 *chan)
 				"Only %d initial descriptors\n", i);
 			break;
 		}
-		list_add_tail(&desc->desc_node, &tmp_list);
+		list_add_tail(&desc->desc_node, &atchan->free_list);
 	}
=20
-	spin_lock_irqsave(&atchan->lock, flags);
 	atchan->descs_allocated =3D i;
-	list_splice(&tmp_list, &atchan->free_list);
 	dma_cookie_init(chan);
-	spin_unlock_irqrestore(&atchan->lock, flags);
=20
 	/* channel parameters */
 	channel_writel(atchan, CFG, cfg);
--=20
2.23.0
