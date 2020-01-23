Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2E146AAC
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAWODX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:23 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:5788 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729186AbgAWODW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 09:03:22 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 9j5hEO8eZ6hegDfNsTyRb5MgWQ85ZgMsX2okKLyjkxlapSKVYB4xQDvUhxgExtoWOq9vpY/Ppt
 i3UzyKtGdYZCjCcjYezGS03M0LWN606jluqK2EnyAtBKgeqJe3NKSXZkAizutpVCrgZ9XA9Fno
 Vcgcs6w645oVInYqupW7r/AD161zccO5YC/01vEg4CRnm9BYIEP8NwH3RfsGmjuFw4qOWVf+RR
 Tui4VurjN2BDzzelJOX+cAVvbKWC6mbWJQXe7r071W/r3mmpRdlkP5GR2/5RkIh6El5RqHnar+
 vZU=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="63527841"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Jan 2020 07:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moLiCqvTQPgVBi83y2bCFfVBVL7N9Heb9N7eQaLQo6VF7uPcGbizurvpu6xWU3mv0hc0jUCwYnrTOIcoH07Puw5tzOoiWRtnCvSJadZ7DpAhe6CdGuQDSoIPSCWnR5M1ydXCd7hcNNMIu0AS6NvWS7YNLCG8HzdDGjykEODkOdLTN1fObF88y971sMf9ovgvHJt/E0VOJRiPrfCyoEkWk5uMqmOWM8jARdvvuBn7iDecMLN67MaB1xtmemeI6w41E4TtTy/z+5Lm57x2dayTMktwj8m5SghSYbl1MoxHKUUvVJ3rWgZjTunyf1AGhNst/VlLey7CMYvkj+y9KtM5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH9EbT/FPyK7w4KJ1mOp0JOUUtYPDR0qGvxVTMYivp4=;
 b=mVf0iN6SIMA/3Yxd37r2xCsIARdxnUJgHKsMgdFDrJfr/T7UBwroEVXj2RKh6Pk6S7DoJLK3bcXn2mJMzXC7DJqjYZxnG2jT3ezFgvpWwEBOvJdj0QTTyQCKx59xIJlb8Tlx8f6AfBDW7NMYa7riqCTyshAq1c9KIbwuUsuI2+Eu3iZGl+Pu+64b5vb9KQSBvi29hYEsgkeGMZrya0fIx60vpwMnZoojdZgkfIBQGzhPBTsEXrqLIoJ1D6GVFZezk5OnP/E2qLvwABA9P2xT+Fho+voYouXIEA3l/u04H2mnf1+yKRsaUpn0Q64Upf7a9feM2cEe/F3RURBRdOyDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH9EbT/FPyK7w4KJ1mOp0JOUUtYPDR0qGvxVTMYivp4=;
 b=HVyMTIGbhf9xVpZOd5ShaJz7JuP9/1N7Lvm6X2ScHKV93FnuLv1Uk/w5fLg+3VT/Tih1iWePDnQUC1VDkJf93JZnQhd3IS5+yqeJwZmNLdVRwDTBRbRVPrNJakT5uBydpP4Z7oVRix4cBEZLpmJzWpKrq501eahrKsyIQLH4DJ8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4190.namprd11.prod.outlook.com (20.179.151.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 05/10] dmaengine: at_hdmac: Switch atomic allocations to
 GFP_NOWAIT
Thread-Topic: [PATCH 05/10] dmaengine: at_hdmac: Switch atomic allocations to
 GFP_NOWAIT
Thread-Index: AQHV0fXXs9r8bOU5kkSU4QX5BgPxKw==
Date:   Thu, 23 Jan 2020 14:03:09 +0000
Message-ID: <20200123140237.125799-5-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12b16a5c-0d3b-4174-a4a0-08d7a00cfa4e
x-ms-traffictypediagnostic: MN2PR11MB4190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB419050B9FA25A502713147D1F00F0@MN2PR11MB4190.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(1076003)(76116006)(91956017)(66446008)(64756008)(66476007)(66946007)(66556008)(6506007)(86362001)(107886003)(2906002)(71200400001)(8936002)(4326008)(26005)(54906003)(36756003)(316002)(2616005)(6486002)(110136005)(81156014)(5660300002)(8676002)(6512007)(186003)(478600001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4190;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rCq6MOCIuE/D00QcDaXfJzSU1MGCbEmmrUq+46izB74OstI3LfSxKKCIR4l6jlH6aqdOZpNs25tDrKPJdC00SGudEIMAw6tVPJ6abh8piVe4FJPdzMI9wmtiVZiTqkQ3tPUi7nnasZmUuTsfLeVnTHH2QPv5L2i4HHGgv5PTLUeDAH/iPNSmXNPSCx82uUoJWQf589CAjisFm+SN/qWSGi+JJ+VFSYb6O5D5j1zalJ1EwhUCdLM/gD14E/+yKEIWXQ2dbQHWXpB3X30wP78mPhXWO2Cls5EKeiU36M27+f5y/UekJxzybE490SZYageWsCiNSHMy7sGPPEel7ZZVAEoRmIxmK6wPYjehc9qDfSu2GPShZLm6YRzFcEecnY8ICNCxVecy4uvqice6by9Q7ubyDcmYmIThgmmz5jL8s971i4otPbpD4Dr8C8gq0c1V
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b16a5c-0d3b-4174-a4a0-08d7a00cfa4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:09.4814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUTDd8l7Bgrr0uNhG5ywGxw64PjmomMIiGXsqzrSuQO0g3QWqGkmpNg5BMiYnOmLUhme/EymRVBtxcdTtHFUAfh9tkbKCE5P0gkr4njnzuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4190
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Avoids sleeping without depleting the emergency pool.
The rationale being that in most cases a dma device is either
offloading an operation that will automatically fallback to
software when the descriptor allocation fails, or we can simply poll
and wait for the dma device to release some in use descriptors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 44d998bc894b..8e8e04bd1b28 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -147,7 +147,7 @@ static struct at_desc *atc_desc_get(struct at_dma_chan =
*atchan)
=20
 	/* no more descriptor available in initial pool: create one more */
 	if (!ret)
-		ret =3D atc_alloc_descriptor(&atchan->chan_common, GFP_ATOMIC);
+		ret =3D atc_alloc_descriptor(&atchan->chan_common, GFP_NOWAIT);
=20
 	return ret;
 }
@@ -931,7 +931,7 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t d=
est, int value,
 		return NULL;
 	}
=20
-	vaddr =3D dma_pool_alloc(atdma->memset_pool, GFP_ATOMIC, &paddr);
+	vaddr =3D dma_pool_alloc(atdma->memset_pool, GFP_NOWAIT, &paddr);
 	if (!vaddr) {
 		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
 			__func__);
@@ -989,7 +989,7 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 		return NULL;
 	}
=20
-	vaddr =3D dma_pool_alloc(atdma->memset_pool, GFP_ATOMIC, &paddr);
+	vaddr =3D dma_pool_alloc(atdma->memset_pool, GFP_NOWAIT, &paddr);
 	if (!vaddr) {
 		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
 			__func__);
--=20
2.23.0
