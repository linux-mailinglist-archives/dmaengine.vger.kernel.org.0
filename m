Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC124146AB6
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAWODg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:36 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:43284 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgAWODV (ORCPT
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
IronPort-SDR: kYl86JlcVOZmI8m8fpkmiwWhvT2sT+G4Z3nIyZKdNnVXU+Q6ToAjybnC+t2Iekzt4sZbYrq5L/
 RoP/WW4QLMjG0pQiHoxrekLPDYO55rN68pwhBDWH0/h03or+4zbmS7chi+v0nYDrQCfalfRoaL
 /GWKgyv+gNRRJn1CsyY59CaqhAJ8gA3fRbV6k6b0f455m0FCFum6GufuyG+beRLOHc2iFS/lN8
 xLlLyyoAXEghyVVRvVcjJOjTyTNVDHyyuzKChJoLKblhD6X7lcoE8BsZuffVuQOMxj7f50I/6u
 iws=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="65735580"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Jan 2020 07:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgO8wdjQUtsNzVV7YhC+0DWIfmK+ViXkyRf0kxQyJ4T0VQMAlXoVeWJo2ifav/f2EqBOlbqyTmlHsaIqPtL5khYi8wFMLqFLb1fq7PDH8BtcRLrGt3J+uHW7CsG7YRohoIh7I74d5eb3npE1sS5RxVKLj3gteNdHE4/0DH264IzR68//nYOgOoTrYYBdtsAG6embSAjBt8Kj0fMWKqCW08oP6tKkCkJfhrwInmZ0wXfWed1d98N7oIFiwCaje+b4vSUsQBB0pybZJhsO4OmgRt2JsnHwmyW7/4e0Q5Fph+zQSEYIexpObzj+8gaNtV7PmWyILQUL5HFaXyQzslNwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utn9ypide2LtjsTCJlJCWFwEQV20hJPPfkX3MyOY9/A=;
 b=Fvgg5ekFSF0s1ZqF/2PnQo5SL0lQ8gYMyeJpFDEM4pU9Wklu8PHAndbtuVxgmng+B6p1egEmMSfPmdz7XEhnQRYs+KaS6w9XgyWkq5YARGpdqKA6CXVy6KbfDnSbuoZnA4IrgH4p9vg+pZST124HPYcFrmsJ1JH0b80Dzp5WwVWAbTZqpOPdsrWmIPfW3Z6x+GT6ZRseIsoxc33Vksh4SYq5kCDzWy/OXQk9dmkhDw+SeoTPPrJTNbOxfdxVzUCH+3BpKitri3dlHKqPC2ktkTcdTlmwo4aLm//lIVcP8FqFluPzPlJza5O354kuLMsUgVLNcaZ+ygmiOwj5Hs3bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utn9ypide2LtjsTCJlJCWFwEQV20hJPPfkX3MyOY9/A=;
 b=pCEAdAsRRhz8DdtdUr+rEpQg3L/xMQ3r2NG/bJMGFwaCrOnyCVtC9LXvR9d/6jtl2+KWA/F48XbJxS2SE23IkS0wnl8sriOpKScjFOdAjc+mFAEufPYVZAicEKSPWA0H0Lnx/a1K8UZQ5Y9jiogzF+xsJMPUknBjZGD4nkNzKB8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4190.namprd11.prod.outlook.com (20.179.151.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:16 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 09/10] dmaengine: at_xdmac: GFP_KERNEL for user that can sleep
Thread-Topic: [PATCH 09/10] dmaengine: at_xdmac: GFP_KERNEL for user that can
 sleep
Thread-Index: AQHV0fXb6oX41SDlz0uQvKasDWkPiw==
Date:   Thu, 23 Jan 2020 14:03:15 +0000
Message-ID: <20200123140237.125799-9-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43bf081e-0578-4737-4cdc-08d7a00cfe10
x-ms-traffictypediagnostic: MN2PR11MB4190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB419030627B8F15102E9370ECF00F0@MN2PR11MB4190.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(366004)(199004)(189003)(1076003)(76116006)(91956017)(66446008)(64756008)(66476007)(66946007)(66556008)(6506007)(86362001)(107886003)(2906002)(4744005)(71200400001)(8936002)(4326008)(26005)(54906003)(36756003)(316002)(2616005)(6486002)(110136005)(81156014)(5660300002)(8676002)(6512007)(186003)(478600001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4190;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3z3JnumCA/vOJEzeMfsISnS7G5HlE/dslusvOFCB+dgLzDuFvXrP531YW8euqgGyh5faI7GimmgajjorPLVDemVTgsvE+iW5CxBCVRcxgDGWMXISX2+0GVy3Z9yZivgS+BftGolSjqV5x9u3iXEUhRL1o1HoHtAON7ZbmAK8lkOujtWH4833oRIRMswNergKLaP7ItkAVMfcGwyvwDqdLYeSPjLRoffZdGijU5vOgctJObR394ESTrrYZAyg6e1356FhAhH63Xmx3f1OF23qw8VqJsX5f56seZ5Jvghjw120N1Ejf0x6dSD8JqOFdjuf2BcT3ERzXTxMFHefYEOsMYQhAjKP/J8oRZ8X63WI4phXS2JyDZ0gsGGXl3LSFS7IIK/a0WMbUJDSJsQc26zFD1ho+/ZLgea8vRibh4t6vf5EpWUWVFLv/KjEwt0XdFsi
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bf081e-0578-4737-4cdc-08d7a00cfe10
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:15.7927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWblHOOrCS73IwKt/1zN/pfyVyPBdAClCpy1+IFJ7s7I3SCl6wQtrUScnbuVVy/Stm4Nb8ja0W8akkjhYySFybxSt8oS++wp3UKQ4ncjwzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4190
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

device_alloc_chan_resources can sleep, use GFP_KERNEL flag.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 8fb01bc90ba7..31321da69ae6 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1834,7 +1834,7 @@ static int at_xdmac_alloc_chan_resources(struct dma_c=
han *chan)
 	}
=20
 	for (i =3D 0; i < init_nr_desc_per_channel; i++) {
-		desc =3D at_xdmac_alloc_desc(chan, GFP_ATOMIC);
+		desc =3D at_xdmac_alloc_desc(chan, GFP_KERNEL);
 		if (!desc) {
 			dev_warn(chan2dev(chan),
 				"only %d descriptors have been allocated\n", i);
--=20
2.23.0
