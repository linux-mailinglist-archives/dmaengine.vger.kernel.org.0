Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB027503F
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 07:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIWFT6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 01:19:58 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9926 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgIWFT6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Sep 2020 01:19:58 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 01:19:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600838397; x=1632374397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BsqXve8rWhB/yTXwiea/KZFuZEi02Bt/d8/HkaoBSB8=;
  b=MzQKoRuRegPyCNKqZQg1wjSEHQa+/5+PxBK99h30N/9qNIu897ImSgKz
   +IVqencINhlh3o76nBtmqOhw43P8MW81rtwhI5VIBWXNdrF+gKUUMCNXY
   dQ4YzWCTsRXBju8hZBboqEl0CgcGg/WXvSGbbtDs9eqBn564GwiWGpQgl
   6G7Qb7USf8svtW3AAEwbSYicBt/nx/Txc5bdJTP0cPqO3FsEnRa6mY9cB
   C3D75KGV8xPO28LeNeXUHsuC4zaNYbSMKEbnAG/QxAxzPPAm5MCyolLyQ
   p3QPhylIAPow92zMiAv59SvQEmg3lNNu8GCzpeXPelpg5ZZJqgewcstPq
   g==;
IronPort-SDR: TtQ8xWnEe5HDPKn+/9HBpXgvgAuUBoIqWdHaC7tk1LdEjkEv96nPM8UPnNnpFxgK0KGzfbHrqj
 8pR/wNu2kOJqUvl2bcNl8VlY8FdXJiQDxpakmMpgDdrpV+VnxE0mW0WM4j4bbOHdfpKNExzm3H
 zHrxbthH/aVWDGg3vZNwkGvNH9nmgwF1mek5dZISTIZ7aVbsK6e+3/8rkRx+rKLpfzo4H88axI
 c3SzZFThKy/ots/kkPuwgoQd4CqaFzKbM6gHP8q9fy1wFB/sZxBYQ2P1l9a6OA24sB4aWPO1Lg
 bF8=
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="87835200"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2020 22:12:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 22:12:48 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 22 Sep 2020 22:12:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBPEDDyzhCBn61SlOvsuOn4/5AeE21DZVIZrSqxJy4JGuL1T+8PnLST3eSAuTvXCsOj8tR2T153Thwdbj2ikuf/2XW9oCJEk61ZHOZXgYAQec/r1dzGxkD3qUvtMB9UWO+JNXNfnF35cfPJI1L+Rr2+VionJLWmNz7jMfp89Oe/v8kuX/7qIbADN7Wkga33CrunZDgmoF4c0GVvEjOC0+MpzwJTKrsOmp9aEEY8dSqAgdI17LMyf5VLUqvvFyvyC8vPpOcRw0Ixj3wNMim2caiHhfmijmqoInLlP9Mnh7DnpvdDpV1IKfc5f893o4Q37KxD3P2Zenvr0XGPfzq3I1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsqXve8rWhB/yTXwiea/KZFuZEi02Bt/d8/HkaoBSB8=;
 b=dTJz/nJyR6xwhz8N8/td3RWtn+G3Q1ZtXNvMaZfmSGefX43AdaRtunf+JF3EZpUzAURfNNzCJCMIBJMXfPysB07rkNu5WajjikRLXADDW8LYKasjJnMb5tCA4qErWQK/FrUGzslHPQl4ZWpXeh89/HictF3RWcVcmqtr4uYRe6zbdk0schhTXPwSvY+Z+l0VnHW2QWXOsrhfJ0ZV6aTLW6B1fq03xoDr6meLvCW/UDgS17wOGdxTeC4wWADWmho5K68drYkZxjkoBVW8LwTgNWLnihZj7/pOqWFSQlzVlu7nNmoH/EZ+ClLoTrbfLIaBNIIWR317GXHNLDPEzH+zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsqXve8rWhB/yTXwiea/KZFuZEi02Bt/d8/HkaoBSB8=;
 b=fBqt9Sp8du1Hkq5GWBfcrp1VcilmYDCKiPhgQ1gZCWSVqKvMcX2B8KE3ouppfO9YCul2rVcYEkN453C2jN1EmissLNPd6peXJStRPsk9NZ2w2iyh8kmZYuQzQytXfRW6cbR7OKFLfcytnXbsSOfU1kFlotGDQzkjxHsTbrUpMXM=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB3546.namprd11.prod.outlook.com (2603:10b6:5:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 05:12:49 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385%11]) with mapi id 15.20.3391.027; Wed, 23 Sep
 2020 05:12:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <Ludovic.Desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 2/7] MAINTAINERS: add dma/at_xdmac_regs.h to XDMAC driver
 entry
Thread-Topic: [PATCH 2/7] MAINTAINERS: add dma/at_xdmac_regs.h to XDMAC driver
 entry
Thread-Index: AQHWkWguSoeuuW/qjkuDTxVB0zkctg==
Date:   Wed, 23 Sep 2020 05:12:49 +0000
Message-ID: <dbd936b1-5a32-0028-3647-b25f8e109be9@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-3-eugen.hristev@microchip.com>
In-Reply-To: <20200914140956.221432-3-eugen.hristev@microchip.com>
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
x-ms-office365-filtering-correlation-id: f84a5cd2-d3a5-4dc8-4f9f-08d85f7f50cf
x-ms-traffictypediagnostic: DM6PR11MB3546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB35462FCD8217315945C6E61FF0380@DM6PR11MB3546.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdlPtN2VCD0DdDFHOwdfnjIhL5F9ct95eacX3DPP0cWFjuNGjIRvagX7UwsvqU182afMdvvOetiu9GfiG7own2K+3+baE25JCl6gRLX5CVYXhpmJWicXtELsslzoTd0ZsSHC6hMbrW3pQesxqY4E0H/t/+uNGOMPeytkph/tR7mzSChux2Lnrwm4r5tgwExLu3kbokJ76dmL8th+EADr9S198sUTBqJ5YctMR4aDhUuEkTyk2XnlCh5PCAvLv2T6gLYQIMctTrU0I3lJHBulkudvTJoqaZLek8Q7WcWy5nz2Sf65ULry2F9G8fQ2ZZ79be/yEnF4nCsPsXAkJGkShGVlD7wTpN5IYtNJjFKV8Mxin6dHe77LC8swKX6NqZXn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(346002)(396003)(4326008)(478600001)(66556008)(8936002)(6636002)(64756008)(76116006)(6486002)(31686004)(110136005)(66476007)(66446008)(8676002)(66946007)(91956017)(31696002)(36756003)(4744005)(186003)(54906003)(26005)(71200400001)(5660300002)(6512007)(316002)(107886003)(86362001)(2616005)(2906002)(6506007)(53546011)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wnLC6I2fBi7vv1Zq5y2raUOtDVm7G5ncHe1R7M4gl3hr2SMxf1DlRgJM/2QeHGAX8pHtsUX+5oAOvlTsS7nnllNvtOJhL+iFi3HqC37fskiIsMPaBWunCAuRQO8HmGQHiRNWUpz9qEDDNw8722QFoAd1rXz028BBqhrG5c8qyJMXwSKLWFLmV0A9h/iaYfWpSDoOYXrI9xy6yluyq1V2//Q6ZKDJ1dSvcVFBTXS70riruLN9JmbsVv2P/6TdF4Up4FDwZDNUvK2BDJWqKnKa0uemwC6lT3fwAvy2wjxr/eOzFmOtZS7VXz7qWs/luTPvfVSLoSrTT/aLlaMqvTFeGYNr3sLAErjh8nkrabgmX7aXFOA9jxibsuytWdusmx6tTvsLsfDDGoWUA67nAF0YLeDhTKWtj/inmsaB7gmNsUESnJtvgsnqfkmsqkdHgRmpnhNfLvKLJOIjKerhYwON/AiYjF37eJPeh45kaZCHw0ZG5p7I3akHNcOElNg/vsV5r84Wa4Zg1SX/nMtltPIx27C8WH2i2p7T1YIvl1pbiissKxE3aeRgSD1UKrOJMJynoMCsj1TduWfGOyLYs+5jpXSKWaUNTLLxd1dzsHFeWbsxcBcUHVIT/JKHqKj2dA6dTu2KEfOZ8xoDYErV7ElyCA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F94B12FA08F19E4D8ADC99080C1E9C98@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84a5cd2-d3a5-4dc8-4f9f-08d85f7f50cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 05:12:49.2824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZVxWEMoUkdjwwZyhoN8idbgzy7VRx1H1EKpFUryMiFtCz8c1Q92rWV5EQihPs/lVMQfO5oAI5JFTpFV/p2jLC/Ur0Ql6sa1xqkx3PvP/EA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3546
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gOS8xNC8yMCA1OjA5IFBNLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPiBBZGQgbmV3IGhlYWRl
ciBmaWxlIGZvciB0aGUgYXRfeGRtYWMgcmVncyBkZWZpbml0aW9uIHRvIHRoZSBwcm9wZXINCj4g
TUFJTlRBSU5FUlMgZW50cnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbiBIcmlzdGV2IDxl
dWdlbi5ocmlzdGV2QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgTUFJTlRBSU5FUlMgfCAxICsN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01B
SU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggYjVjZmFiMDE1YmQ2Li4zMTJiYTZhZTVm
YzcgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBA
IC0xMTM2MSw2ICsxMTM2MSw3IEBAIEY6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kbWEvYXRtZWwtZG1hLnR4dA0KPiAgRjoJZHJpdmVycy9kbWEvYXRfaGRtYWMuYw0KPiAgRjoJ
ZHJpdmVycy9kbWEvYXRfaGRtYWNfcmVncy5oDQo+ICBGOglkcml2ZXJzL2RtYS9hdF94ZG1hYy5j
DQo+ICtGOglkcml2ZXJzL2RtYS9hdF94ZG1hY19yZWdzLmgNCg0KQSBkZWRpY2F0ZWQgZW50cnkg
Zm9yIGF0X3hkbWFjX3JlZ3MuaCB3aWxsIG5vdCBiZSBuZWVkZWQsDQpidXQgc3RpbGwgd2UncmUg
aGVyZSwgbGV0J3Mgc2hyaW5rIHRoZXNlIGxpbmVzIHRvIG9ubHkgb25lLiBBIGNoYW5nZQ0KbGlr
ZSB0aGUgb25lIGZyb20gYmVsb3cgaXMgd2VsY29tZWQ6DQorRjoJZHJpdmVycy9kbWEvYXRfKg0K
DQp0YQ0KDQo+ICBGOglpbmNsdWRlL2R0LWJpbmRpbmdzL2RtYS9hdDkxLmgNCj4gIEY6CWluY2x1
ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9kbWEtYXRtZWwuaA0KPiAgDQo+IA0KDQo=
