Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA85275038
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 07:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgIWFPE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 01:15:04 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:23103 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgIWFPE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Sep 2020 01:15:04 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 01:15:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600838103; x=1632374103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0YgHTMxA2n2Zi81goY/UldQ2eGtDhStjdJT6NpLw3NI=;
  b=pCTLvgDosZFznm4cV834BrPIhS9u5ypFs7ufmN2IgzFWRj3muB7oolgq
   0ZMw1tD3aPG4n1y2y4w0ZFZi7q/frslxe21RqNS0CjtVmopR4H3zV9D+2
   VWm3Bj0VP8ar2XdFc9+79Ao5q1sqSZPHQIZWdPtQf16DUt1fJuDmyRJ50
   u+vUDX/FkhUuSvH+LLYfKX2WbTN4LtXDHz2m9t8JWsAOhamWXrg2rl/Wd
   qA8bYCWwq3oiXy+3SW74KH2UNwfpbZruYzRKuTSMRyb00414kiULP9DAj
   MmCrWQKqbRRNrsduw3qchTZH2vaLdiUrbCiq9DEeULXYXgN3obESYWn4c
   A==;
IronPort-SDR: PcIaugfzPhpShkwhnRkIUEKwvY2rsgS3TmyzkDgvGgXu9NO9Le4IhjfDM1Ywz/H63RTTtMhn2c
 4cj2fGzPKefcJDHQh3p295e5P/ZySeNXljsl6EUvTAe9Zl3zC1cuzWqJCILXinxcct0wia275W
 VZsgLFL/cecQAdW7eCxrJ2lsoLg0JNb1e72y7dir0vIgyY8cZNpPDrodq9oanbjCC8wRX4dOxh
 sb/sVvghkyYM1avGp+0HugqvN6pF8jSwqvUbvi9CBkMvN+LzWokEjS+k6R96KotrAXz3u8xf7Q
 5Co=
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="27351657"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2020 22:07:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 22:07:40 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 22 Sep 2020 22:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp2XoQJBZ1RUSo9LGn1H92tarOcvZ9ifQwNcaFjiZWeKBS4ritMo6Q/rvP5/DGR5pQQHQkiyVKi7wawJkc2Lt3N9k0K7nZ/2YJyLteolc8Ud2Rn7ryfpnInkhBCiCiaPGv5yIem71PJcjWVC0M3yjUpSH0eyPq2YC0KWF1xh5KZlJd5AeQXsfqWl5KIp5HwKr68MAFvJWlv/b02V3o/jqSgd/5VXBdnrZ4E+WNnwES8DyGHXq9rWz/v7qDGE+OcWhVRzhDcSF/Y5aGJSZU2e2nIndZQwXU8WKzzfYJoTwqThyree7RlPwkitAJEohIgk6BlLzBy76/nYaRGur5ddxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YgHTMxA2n2Zi81goY/UldQ2eGtDhStjdJT6NpLw3NI=;
 b=hS9gSbzUyFxh2nRdDhheNcqlZZs9byWQqsU0fsjoktSFwFqFH9kf4Kvx9XSAWsSYXlOcfc0j9WMqo7R+cNXe1bgNKB0/7/kKV+K85++1WzsSSJo/GkuRRvcLkcwGNQhVz2o9DSs5+3rAmUYmrWXldHSy2RCTYzINoEIW+MxXRCzPue2pAL091/1UKitKn4kwcXu7qgCsDwuF523e/NGwc9tCYBuOzpVLEk19qPYhbxgXjJi0X6RIcx5jn/vo0sVcQSfFuFZqT+pAlWaKLCQlF/WHd51glXKDC6pJZuKin3L7Os3M99hsRG2pxNrmz4xb52SVGZOvX61OASiShl4Amg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YgHTMxA2n2Zi81goY/UldQ2eGtDhStjdJT6NpLw3NI=;
 b=g+SgL1sW//WoCtvKZ8Q9c013RLLe6wurR8kv3zHaSC8K9QRXuHFxQMlGm+v2yyAr1OX2InqExIwZ4ehdzntBsw/Z1Wmst6bqhaDIRdeDboli+Y1zxBVv5qoVRmA182GtDJvOb8zZpjiQQ/YOOLIXl24qef0gdiFnQobeXSNl0X8=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB3546.namprd11.prod.outlook.com (2603:10b6:5:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 05:07:54 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385%11]) with mapi id 15.20.3391.027; Wed, 23 Sep
 2020 05:07:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <Ludovic.Desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 1/7] dmaengine: at_xdmac: separate register defines into
 header file
Thread-Topic: [PATCH 1/7] dmaengine: at_xdmac: separate register defines into
 header file
Thread-Index: AQHWkWd9PAjUGeHE7UumCgB3VuExhQ==
Date:   Wed, 23 Sep 2020 05:07:54 +0000
Message-ID: <1a63e9eb-4714-9a63-91cf-bad30e3db75b@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-2-eugen.hristev@microchip.com>
In-Reply-To: <20200914140956.221432-2-eugen.hristev@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.77.80.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3557a82a-d483-46a2-b9fb-08d85f7ea0f3
x-ms-traffictypediagnostic: DM6PR11MB3546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB354649590D4039781DBC3AADF0380@DM6PR11MB3546.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8pUijnifCzsrioPBTfmEonxX5nHxKW5mWgJntM2Z+UUlak3wwtfH8lY+zLeS9H7V06mzzid4D4khemOgHIDbO2dKvN1Ys7eTiTmBoApUBhZlyplfMPNVnyOrSjicrs4713uf1KDO7GrAeAHJcZVqYr+SeqxeRfWdR78IciIuhMXh5W99rvQ+tr8VttYd6vbcDyqmVUXH3rn9aThv2Sd9Rkk5d1LKHE2d6U+8/YyjxPVI8RpjR0lI0A6h4fATrJNQ0yQ/sIWq0DjjOPo5Vmhi8I1izXcFMjqPr+kKJ445yicMZVCG3KFVTZ2f0rTGZaifvynMWTHU8hnAme7rI90e8KTCuj6IetdyibEqQ9rhwSamGi8y2EgjOgFubL3Hkf/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(4326008)(478600001)(83380400001)(66556008)(8936002)(6636002)(64756008)(76116006)(6486002)(31686004)(110136005)(66476007)(66446008)(8676002)(66946007)(91956017)(31696002)(36756003)(4744005)(186003)(54906003)(26005)(71200400001)(5660300002)(6512007)(316002)(107886003)(86362001)(2616005)(2906002)(6506007)(53546011)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9bjdogzMt5Yg6ppsjWS4/n6l/iYnzmE5+L29sc8batXUiBae51ZBFOvz9v1GXNHY1bB2KtcOmIaE2puqyZE7la1mob3+KVLoaRVz74b78esAoAsXwQYUL92CZO7WRthYT3SRJv3a0/6eua8+CxAWJLecsWTcYW+nImPhGrZkjAww4Iww9FlPdHdVvjTMqLJZZ5bxy8MwFm9pvUiaciAka7tLgqEfjsKKrH0s11yd1c+a9EKJsZ/HnYT3nj+whPzSaRHfDSeoEiMkkCRiUkXjVublK8/6u4VK7MYWy5RI1voq7xuuIvugYZqXPpCHneyG24o0ETbjFWVhn/298NkyQgk6PSX38HJLzOBBaZLEeRAd9hq+deS3hVcXU792yH+0IVzcRCfhT2bNhfVCy0Ym4u7qNQ0JjHbpl/Dn4rAVaSPo+f+BPmxjWsJKOIVD9MSDv79g5WMRQdixAyhUFJXV/iOe2xO00HqDqtdxdms/mcuWgXffwI0H6owwhwiPkaPw3IN7Y+T01PDOPD4zuS7ugkcPRvtZSujoFuNnsfAQf4DGdgGp6XBLStfCIOU+uoUpuXiciBFT12UrApzKUDRgsr8tA55MtdVe7IdTFZMPifw7rADdvXLkOdO6Sd1iVXN5vjLt4FT/+TLYLkHGYrfXVQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <13706A66FB1C7340B676C937DE729894@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3557a82a-d483-46a2-b9fb-08d85f7ea0f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 05:07:54.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eM+Wsmb/GcwUfoojDsa2BKk9Fl7AjzzdftXHJoipoU1WDELHI+lsoILOnISu5ztDK7VoEis3gaL0+W2ui/UN3ENvX9pDzbl2bonmjmjhfYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3546
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGksIEV1Z2VuLA0KDQpPbiA5LzE0LzIwIDU6MDkgUE0sIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+
IFNlcGFyYXRlIHJlZ2lzdGVyIGRlZmluZXMgaW50byBoZWFkZXIgZmlsZS4NCj4gVGhpcyBpcyBy
ZXF1aXJlZCB0byBzdXBwb3J0IGEgc2xpZ2h0bHkgZGlmZmVyZW50IHZlcnNpb24gb2YgdGhlIHJl
Z2lzdGVyDQo+IG1hcCBpbiBuZXcgaGFyZHdhcmUgdmVyc2lvbnMgb2YgdGhlIFhETUFDLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZG1hL2F0X3hkbWFjLmMgICAgICB8IDE0MyArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvZG1hL2F0X3hkbWFjX3JlZ3Mu
aCB8IDE1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTU1IGluc2VydGlvbnMoKyksIDE0MiBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2RtYS9hdF94ZG1hY19yZWdzLmgNCg0KRXZlbiB3aXRoIHRoZSBz
YW1hN2c1IHN1cHBvcnQgdGhlcmUgaXMgYSBzaW5nbGUgLmMgZmlsZSB0aGF0IGluY2x1ZGVzDQp0
aGUgLmguIEkgd291bGRuJ3Qgc3BsaXQgdGhlIHJlZ2lzdGVycyBkZWZpbml0aW9ucyBpbiBhIGRl
ZGljYXRlZCBmaWxlLg0KDQpDaGVlcnMsDQp0YQ0K
