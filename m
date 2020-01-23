Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3107146AA9
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jan 2020 15:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAWODR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jan 2020 09:03:17 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:22605 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAWODK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jan 2020 09:03:10 -0500
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
IronPort-SDR: 4iKMywHmHHbx6m7LLuIdWaMa1FKOsrGa9P+rkf44JPhLIHs7iwVM8cOiRxGeduxciK4zJenFoi
 TaZJVArsv+9q270GYhnNILsYlpeLMK6zOIlQppw+1ZE3H0eZME1CS24wZlD8LpPMChKzdR0F84
 rhwj6DUrYAjBKH9u8SLw6hEviaTrk1vc9t/qv9gUWhDv7psWTA2ruLjg3MpGaiurdWE4u1phbl
 IzXrHogyR5CK0rGVhsTwiGXj1qo+hN0F35lJkApa2qbxExSsTgywzmQiYuoUlGnFlQJ6Vs9hSh
 ff0=
X-IronPort-AV: E=Sophos;i="5.70,354,1574146800"; 
   d="scan'208";a="62879880"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 07:03:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 07:03:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Jan 2020 07:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Stp2Oug6ljge/6USkvAR+A174WsoCFTU4Mo/fj2/hIk3LoGVxZ0zf1aIloPwT8oNCC6pnU8JYu08bxHrzpO8LDUMJgS+tH+n+6A9nzcX7JPMNiM+eDECrxs+jH/U0LfTFqjCGZSQGzgRvtjB48EL8mtxg06IndMSh1yJ96xthtQrEJ3gqlhdOEm8ahcUX+SLQULSkghTQZlbWoGs/q9M2wJy6zueGqMpH6TCaRjz1jqSSx1Gw4JYhBV1xTwKFoUyS5l3DGMNOxU7EH61ngQQcbnyNyxEMzPLm4yLdeaOBxxIwyvXZJ4T7nwyskNqjwNsL3JnMoOtHjy598dGthxe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga74aBoQfPJJJ2JhbZYrZ6NygndUxd1tEGrY8jJXQew=;
 b=dE915sdHFgSKaV/B3HGxfCaXwAtBh5TrotFQkU5G0FW2NpZ67iIJdHxVt30HzUsbZE9+lVid8r5RN76m7+g4HCtIDj2m0/hxe1R5695YgBIj+Skidd7/QQ6CwyrRGq2QsUeFm/fYmdos9x7JWB7DKHtzyjCffIkxBkJUTHqFCOI20BhvNAZ8Hh30VSyCFj3b2mHZOzX59cHUF/QNd2EZi2bmMl1hok9St+BAgrlaNCQi94kvsOy/xse93y61GG/Lm4fL+0Y66IPicNzt6qLOkWCxc6EcCu5/P5xfhT/9zoYSeZZqREEjwKxJTEHOWEpY/ZLcW+X1ykQqyydP7IuYAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga74aBoQfPJJJ2JhbZYrZ6NygndUxd1tEGrY8jJXQew=;
 b=ulvWkw0sEQjORMCPlD4CDhGR7ar0sTCEizwM6Qg2+guN6NHplwUpQW+JT+ssYLyHXRPZx6CqIzLL1ld3vdG+jLg4tl2WPgLRT4For5V+QhOiMDpXqy6plewSw02UD8ePHho3kMiJpzyfOO3LSwELaFADynq3aNH/gWsRIZVKgAQ=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3582.namprd11.prod.outlook.com (20.178.251.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 14:03:08 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::3c8f:7a55:cbd:adfb%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 14:03:08 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Ludovic.Desroches@microchip.com>, <dan.j.williams@intel.com>,
        <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 04/10] dmaengine: at_hdmac: Drop description for a not defined
 parameter
Thread-Topic: [PATCH 04/10] dmaengine: at_hdmac: Drop description for a not
 defined parameter
Thread-Index: AQHV0fXWPjB4PfrBgUGm0ZHrnuo/yA==
Date:   Thu, 23 Jan 2020 14:03:07 +0000
Message-ID: <20200123140237.125799-4-tudor.ambarus@microchip.com>
References: <20200123140237.125799-1-tudor.ambarus@microchip.com>
In-Reply-To: <20200123140237.125799-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68a2879e-036e-490b-2138-08d7a00cf972
x-ms-traffictypediagnostic: MN2PR11MB3582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3582DBD2C8C29D7B4140DC63F00F0@MN2PR11MB3582.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(2616005)(6486002)(316002)(26005)(36756003)(4326008)(81156014)(186003)(54906003)(110136005)(81166006)(6512007)(5660300002)(478600001)(8676002)(66946007)(64756008)(66476007)(76116006)(91956017)(66446008)(66556008)(1076003)(2906002)(4744005)(6506007)(107886003)(8936002)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3582;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihhl7H3FXZ7gYPrgbJ83CpwtZKvnSp4oPLrHzLWDSF8YAIzP35FxZGc1yAb+coFfRoKA/Z2GsbO0/WZglpqsrjxQSYeAuk62xML/5j7L3wnIfBZE4wHt4upRcMUjeU1DkvPXxLcJzAJ5LL8sV4MrhseAbVyRrvZnJTR6kWtpAPjCNCytJLA5HI37QjVnVzf6iGB+lWTKy+Z+59BUXOb4JtMHnJsTIaa3QYxstQ3Drfhf3cxK3Qs6Rru429Vm79bCxbCAsuIeWzigqCbo/MW07ZuqBclBP/IvOwxxHZZIqdTQ/qG/3+PYmgAji9xsVXCYEnGR3baQ9nTNmNwzk5c85cUDgGwcWqMDJETKWGFZWOvlcZq5a0pZZuZR8uJKJwFR1+87YRHKUxBd7bJhxZYP4b+aqBYa8pZXjUuH9SohY4PbL0h8hfx1Bi58TKmm4R2a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a2879e-036e-490b-2138-08d7a00cf972
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 14:03:07.9613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DMYFCvSO6Q3nBC/6aAs+IXMBs0yqRLj6VdHHcbN6lYYx1oxYcHjHB/60DU+FcEWCgIToFLS21CFHwIC1aBn7ulsq2woLeBU9W++Y9tvRNpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3582
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Probably a leftover, drop it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index e17b75075904..44d998bc894b 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1523,7 +1523,6 @@ static void atc_issue_pending(struct dma_chan *chan)
 /**
  * atc_alloc_chan_resources - allocate resources for DMA channel
  * @chan: allocate descriptor resources for this channel
- * @client: current client requesting the channel be ready for requests
  *
  * return - the number of allocated descriptors
  */
--=20
2.23.0
