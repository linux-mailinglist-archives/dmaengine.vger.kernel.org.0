Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2021B146AA2
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAWODI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:08 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22605 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgAWODI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 09:03:08 -0500
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
IronPort-SDR: wJFLhp0KtSYkzVWYxNCfEkJwW1O5jVtN8S1EzBBUOAFbUkp009wRfMDqfQitgWf//gOnWCVMWj
 wjm3fzC5ncIdu1oH6mpdmTsjrUyRhY7xGm91C0tF2WEMS/BNfpVwvF87jtmPF3LHWuihaShJqq
 AJpAj3J+Qkvhw/2J5pAdijAnrkCEWS0azkZgIg2lC7CL+hLu8wqvpjImBS/solKpX+FKsLa2HA
 1pKJsMrYnaN6oEH7pKpOBojbpshM4c4fyzio1vnmoRSMAH339VCELb3cGe1zfese0OIwEnmO3C
 40I=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="62879867"
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
 b=fu+gjaGMnnW+0/HAXJBntc36dYhyjuSR7r0WjNfQxH1WjADJIEbC6chlqimZEp7ooGLW36eJyaqZscIXzNs9qpwpQKsRB7lv9ed4suk7FqVLP9ALDbks4lAAyteR0tfB8ygQ9jw6cJ0oZTFS5QONkRZ5xqFMSxU9aWYFx6Sr8kYliiubj1uaqM1fXeydXPhqDPNdZu99fC/2N30xLqMzFhNiq4UlW2VFnh4KUS9Qm7C0QxwALwvgMaDd2AADh71KnN4Aie0Hz/GMo9fTLF89WHgUw3NmfBSJgaopC2viDD1KH+4sHO8WAqQfEYlPhg2UaIjQ1w3p8P/rtpSoeCD4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkT8JJetRMdDwVGPcWOgCt77LA+s0kNgmTWF9ltJLnA=;
 b=iDsceVSWLExJAMVUXMKCfNDqQBlTFqZYsu8MHKZzyquu30bmEf1Kkbmy9kQ2H5DTDRPPuTxTD3ii2FHlDnDHozz5Tp/e/pSBghlVkvC5dk433JdRv5R3Cjnjai53BMA/SEppoeaqg9qE/FR5olRsg8ZZrAnTDEXXroVQUlQZVLgO9Wih1sQGvvT73pv2pMBKVP45ih5qNbJJon5ERBsXC6yN7Wm8KOAPDFBJPj/WAqzcwkqnfwLz8NIkglJYfTZ1/JHlywhPMH+S2qcpnLMbLQsGaJdZY3DvZ+Y/eUq545eTSGRoPb8maggVpWAaWGjF+UhPqjvDJW1MCBF2RapTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkT8JJetRMdDwVGPcWOgCt77LA+s0kNgmTWF9ltJLnA=;
 b=TcP3lEOLVmXM6syYVt/hyj5GAJ/xFQiJvczFjn0Qn3X3BtOuwFvR/g+OfDfesl6M5HRFoGvvhN8pknus5VYyNROV5MWJQbpe3uyb2EyeA2CdtVAn6HGtsk0n+Nj5YhjjDnQX78QnyHnq8BljKnBwsNA2RGwLsyajA9kU62RYByU=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3582.namprd11.prod.outlook.com (20.178.251.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:03 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 01/10] dmaengine: at_hdmac: Substitute kzalloc with kmalloc
Thread-Topic: [PATCH 01/10] dmaengine: at_hdmac: Substitute kzalloc with
 kmalloc
Thread-Index: AQHV0fXTyMvfeqBPZU6BecAiUKnxHg==
Date:   Thu, 23 Jan 2020 14:03:02 +0000
Message-ID: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94ab9cfb-6b7d-41f1-10f3-08d7a00cf661
x-ms-traffictypediagnostic: MN2PR11MB3582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3582259EC4C688BC3AC7C655F00F0@MN2PR11MB3582.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(2616005)(6486002)(316002)(26005)(36756003)(4326008)(81156014)(186003)(54906003)(110136005)(81166006)(6512007)(5660300002)(478600001)(8676002)(66946007)(64756008)(66476007)(76116006)(91956017)(66446008)(66556008)(1076003)(2906002)(4744005)(6506007)(107886003)(8936002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3582;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 493Yewy6wuki3Kwx+Hebux81J9J16fpFYgOrLIaJTXJA95Es6O9vsTdjZnf0Zg1tkmVPcJcDMB/mCdnsSLNEqVkarV9nlRmBy6q5+kX6VDMrMLM4rFsW52Uq1+qdUZUswWJuNsJUwfxUtc44/zq1tx/naOzyEcSCXlDT69DBDsFLklq3UHiRYvyTCSaO+wBiPosljsAOF48O8/3iWJXYd/65VypdWOzdkBx+HBU1wvlPfNBZnVfoqIpfsk9vEjou0Bi1lRlMovWS/yo9El7Au6HI7bN78FC13Wm+Oek3iA5j3mFJbC1u/mcBGbRpDKvi/YqA+NBIf5GM89joqQPgVIu/tiOlJH66S9lMrt7W5X/tRHGzBik6ugHkoyT7P9wQA7BpUCnd+3eFbbY/X/dcbZKhaptDBA6ZhcoWnss/5Ql+Gg8y1pu4/c5jVSY3G4Cp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ab9cfb-6b7d-41f1-10f3-08d7a00cf661
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:02.6844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aOOtcxQtjBuLj50G+/0mquFw/38o5HXpTOOTbr+V2ogBIFb/5ytdpyL2BtI8kUintODW9Yxdhk0rwbLTWc/XpDO/tYzoecCBZTwXRWLdm1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3582
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

All members of the structure are initialized below in the function,
there is no need to use kzalloc.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 672c73b4a2d4..cad6dcd9cfb5 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1671,7 +1671,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandl=
e_args *dma_spec,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
=20
-	atslave =3D kzalloc(sizeof(*atslave), GFP_KERNEL);
+	atslave =3D kmalloc(sizeof(*atslave), GFP_KERNEL);
 	if (!atslave)
 		return NULL;
=20
--=20
2.23.0
