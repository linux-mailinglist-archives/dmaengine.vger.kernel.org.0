Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0826B27504A
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 07:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgIWFap (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 01:30:45 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57143 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgIWFap (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Sep 2020 01:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600839042; x=1632375042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zSuy1EcIiNrZpEDc76+PV8VqmcvIrWKgMmawDW06apI=;
  b=hm2vE/yEnWlt3lsrGhjGQqnkO9rwlgC3BpgUgHmb9VOoCkCo/+0CwDpK
   yD6mFfxDMAlTCx8TZ3wKbczziP+s3bq99uqKfCg0a58c7oKHirkkbTqKe
   I303RaZpzUjnE3KvdZVVzmBG8OYQZIaXyQyU7uWBYVTUxkj9br7XZtpkR
   Qs6UKyrauDoLD/L4ozwB7RzYlraPo4qNFCPEq97p4mW6Ld58WCMoyAd0B
   0tJZ9FuXkUaJKLJxfJCGkK+1mVOELrPHkbtEuWcsRH0NrRsBM9yhF4REr
   Ttxao/FggrDlkeFd4dqZilZPbTOOhz+qZ8xjdZAhW72Itz9knyeEtUhnL
   w==;
IronPort-SDR: LySbLzlW5w8+/pE9LFL5bzOIa3qc1DbN9JDRT4yD6mQcRpeCMAhoTZuqV5GFdN/E1RZW9efFBA
 V+HJoobcsf3XReEyXs83/F/uf163huBO+IYEvHWzPFyetCugjXzgiCVkuUDBwaRS7TmflYn8T8
 saKG/OvCGFtWRXm4JscmVz2F2TNvpSIw3TQGQLCayZy9WugrRhujAC1MQzNvWbR9/etujWJ1C9
 wHJe38hLDFEdJBALP8v/OWd5CxGNoJlE+We2PH8ypbp3beDGtBifgsHY3895bjnY/QOdr3QwA4
 E7g=
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="87836742"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2020 22:30:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 22:30:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 22 Sep 2020 22:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7MuAcyLrupp0BE74fgE5p4wPlICT9RciVKlLg8Fg7RCdUd7qoa8RbfhB4+RNfB/beMj0vyCfz7s4qY9qH+25DbHSgFAgOp0jFL5NN71haBaE6qTc8e22OzcIGz0IRmnwgfPO4+7oPgAFg76pYq9+gyKpuKkzoOc2Ahg7Z5Igp7OaR0PE7TLHkzovB56RRsP+jHaAkbfZR9z2BYiyjSbcIee4xbX06g5BQoQePoKtU3M8C1KImJI9AikMHTiWoOmtSTekRJfyaplMxZiBZswtuhM51cKiPzSpxL64Lss/4zTY3nrytG7+vMXbvHU4DHIQ77MtmGjOLoSwPoaQxH8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSuy1EcIiNrZpEDc76+PV8VqmcvIrWKgMmawDW06apI=;
 b=N+jOO1PpGxVeKfAFUjXeJ9kHip0NAw3GM+oPtPBzRb4mREis2X2DrDckRwOIbBX8fXvoZt/Hy8ZcWIxs2bhk42hu3DLrjOY5A2mCQW/OrT9uZMhRCF+jR5yJVnY/Oerkjpu9WkhFfi9ivODswhbhhQZVNCt8sEB4/29YVSNPq+dOoVgSqi9sfYiDzovHfvElXu6Crp+76o0DZDiAvyJnfhuy7kP4cXjD5tWNRzSdR2EREmlN1XafeidsuTPwx7hd8TQkUaUiY2PKk+pkZtgu+ZwoHHKi+Hj49eGFyFm3Cg8eku0Ci/C0UpbmF2OtDqN1mNmO9n7pxI6iuJv+IF6XDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSuy1EcIiNrZpEDc76+PV8VqmcvIrWKgMmawDW06apI=;
 b=CudcLNp6zFdgFdA55MnKUpCjbYUzy/wPTwdXVeDv9v6kssMxJgd8kglLa7d9AqNUkyJel7THWDRFON3OOE7s7Ex7poXSgzkxthoJPbYhOBqSW9QyjSYCE4V3cRioPJ93ukOdnk+9WcQKIH5OvczsWT/jU6jJVCpksdDo5We4GE0=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 05:30:40 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385%11]) with mapi id 15.20.3391.027; Wed, 23 Sep
 2020 05:30:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Eugen.Hristev@microchip.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <Ludovic.Desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH 4/7] dmaengine: at_xdmac: adapt perid for mem2mem
 operations
Thread-Topic: [PATCH 4/7] dmaengine: at_xdmac: adapt perid for mem2mem
 operations
Thread-Index: AQHWkWqs0npVjkI8wkK878r6lyc5AA==
Date:   Wed, 23 Sep 2020 05:30:40 +0000
Message-ID: <520058c4-00a6-bbe3-2b60-93477be982fa@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-5-eugen.hristev@microchip.com>
In-Reply-To: <20200914140956.221432-5-eugen.hristev@microchip.com>
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
x-ms-office365-filtering-correlation-id: b87065a9-99f7-48a3-bb79-08d85f81cf5e
x-ms-traffictypediagnostic: DM6PR11MB4513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB45135C9113B18AB3C8E27274F0380@DM6PR11MB4513.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUT1WgsXBBT4/LavWiVbXqWxHoERW5teI/0hgHn4pxSHxnif4pSzk8+HF1d5dcqx6WLZZoYUZ4Ruwa+HDbEHgTw8KWh7ESSnpBtboX9IVI6vpdBBxS+YG1A8LU5tLvetGvX/K+w9FLfEYmEHCRkvgsqVY8KAenwTSZ4AjZ6uXb9g31MwKSv1/hEiLR6xvcEWhB3etIPxcL52B9XOd6InTJuGxs2iz4KveuNRAI8qpkBzhUAQYJ0YabTrFiEUSMz5X6PRUVYx9QUlNYmf3A2WM19ZqlfL++rLy2su6DLYiE/zWqT+MAo4p9wX48VzokZYNZ0Kd87PPMhuFimommvvgn3ev0W4hTzzUo3m/F0bJ5DkJ964fOyY6/OeMPMEvQhUSdKDAazw1IGa4tw47fghfpe3C1j5n0koaSPv+/Ma79Bb6T4zoQD+QsyZLWUzgVs2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(136003)(366004)(64756008)(6486002)(4326008)(66476007)(66556008)(8936002)(6506007)(66946007)(31696002)(66446008)(8676002)(53546011)(316002)(71200400001)(5660300002)(107886003)(36756003)(76116006)(2906002)(6512007)(54906003)(110136005)(478600001)(86362001)(91956017)(2616005)(6636002)(186003)(31686004)(26005)(83380400001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: krqigUpZDZx0esNVSWSMhL6EvlHJZuMp4e8xRGbxTRpCFqNV0khJngAvOQOKVzrL7me9iLJZKptMv8rnEfyPA/XQNIG4nnzX3Rcs11NB0Jsqa8yzKuVOU66R+yCD9TyuqCRb9n4VEWwi8lE1Q0x8ucOB3bhsh+RVRJiFqSKJ34yoLjTxavVqWR/nMgwttFI4JT6qjV6DY4a0u+iqhxqP2D3RgtT8cxW0uLJI+CLJjyAvq9JOxLe7WJosMIzvvhtBLB7/HeHgkG/SAeip2wAH/+KG3+xHqvu/vYlwr26LH4KBuURfcsQQLpHaS8dXpGDRk3sn0HG06MASxww2o6DnDqat9KDyANGCRhXS6u0TEYouVeLDAYouH0Lya32OzmL4ZyE5703xPo/jUflL7nAp5v92DujbOIviK84HW7+vhGnI2/YCR3a44aNuCLdqRpZzN+qCl9dFR6kpJJZTemJV9C/lpCtKcnr3udJZcLsgsam9lhJp769ww/EZDN7cCTbQQ9volKlE8dXsPyViavCjbvS3Ew9YdfY868nOSBua5ThNkrC2aQPdk/Cnnkqps2O25t8yaPwMeC8SvbEdfdpEZ4MGFQs4bLuGqtReWXSoaDurxvy4QTumth0ne/3nGFZTkrHPrmHDFg3glFjf/kwzsw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED688D66E6827A42831E6E574CB99124@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87065a9-99f7-48a3-bb79-08d85f81cf5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 05:30:40.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMxycrOF5+Ln2aTCjjSksQbcb32YtEsHjAYjhMg2IvwwNwChQ6JlZ7zEMP7B6BC3FDm/f0dtZ35UAzo7jNaQqVPRND1IrBsbDbgqjXK+KxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gOS8xNC8yMCA1OjA5IFBNLCBFdWdlbiBIcmlzdGV2IHdyb3RlOg0KPiBUaGUgUEVSSUQgaW4g
dGhlIENDIHJlZ2lzdGVyIGZvciBtZW0ybWVtIG9wZXJhdGlvbnMgbXVzdCBtYXRjaCBhbiB1bnVz
ZWQNCj4gUEVSSUQuDQo+IFRoZSBQRVJJRCBmaWVsZCBpcyA3IGJpdHMsIGJ1dCB0aGUgc2VsZWN0
ZWQgdmFsdWUgaXMgMHgzZi4NCj4gT24gbGF0ZXIgcHJvZHVjdHMgd2UgY2FuIGhhdmUgbW9yZSBy
ZXNlcnZlZCBQRVJJRHMgZm9yIGFjdHVhbCBwZXJpcGhlcmFscywNCj4gdGh1cyB0aGlzIG5lZWRz
IHRvIGJlIGluY3JlYXNlZCB0byBtYXhpbXVtIHNpemUuDQo+IENoYW5naW5nIHRoZSB2YWx1ZSB0
byAweDdmLCB3aGljaCBpcyB0aGUgbWF4aW11bSBmb3IgNyBiaXRzIGZpZWxkLg0KPiANCg0KTWF5
YmUgaXQgaXMgd29ydGggdG8gZXhwbGFpbiB0aGF0IGZvciBtZW1vcnktdG8tbWVtb3J5IHRyYW5z
ZmVycywgUEVSSUQNCnNob3VsZCBiZSBzZXQgdG8gYW4gdW51c2VkIHBlcmlwaGVyYWwgSUQsIGFu
ZCB0aGUgbWF4aW11bSB2YWx1ZSBzZWVtcyB0aGUNCnNhZmVzdC4gQW55d2F5IHdpdGggb3Igd2l0
aG91dCB0aGlzIGFkZHJlc3NlZCwgb25lIGNhbiBhZGQ6DQoNClJldmlld2VkLWJ5OiBUdWRvciBB
bWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTog
RXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvZG1hL2F0X3hkbWFjLmMgfCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Rt
YS9hdF94ZG1hYy5jIGIvZHJpdmVycy9kbWEvYXRfeGRtYWMuYw0KPiBpbmRleCBmYWIxOWUwMGE3
YmUuLjgxYmI5MDIwNjA5MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kbWEvYXRfeGRtYWMuYw0K
PiArKysgYi9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+IEBAIC03MjYsNyArNzI2LDcgQEAgYXRf
eGRtYWNfaW50ZXJsZWF2ZWRfcXVldWVfZGVzYyhzdHJ1Y3QgZG1hX2NoYW4gKmNoYW4sDQo+ICAJ
ICogbWF0Y2ggdGhlIG9uZSBvZiBhbm90aGVyIGNoYW5uZWwuIElmIG5vdCwgaXQgY291bGQgbGVh
ZCB0byBzcHVyaW91cw0KPiAgCSAqIGZsYWcgc3RhdHVzLg0KPiAgCSAqLw0KPiAtCXUzMgkJCWNo
YW5fY2MgPSBBVF9YRE1BQ19DQ19QRVJJRCgweDNmKQ0KPiArCXUzMgkJCWNoYW5fY2MgPSBBVF9Y
RE1BQ19DQ19QRVJJRCgweDdmKQ0KPiAgCQkJCQl8IEFUX1hETUFDX0NDX0RJRigwKQ0KPiAgCQkJ
CQl8IEFUX1hETUFDX0NDX1NJRigwKQ0KPiAgCQkJCQl8IEFUX1hETUFDX0NDX01CU0laRV9TSVhU
RUVODQo+IEBAIC05MDgsNyArOTA4LDcgQEAgYXRfeGRtYWNfcHJlcF9kbWFfbWVtY3B5KHN0cnVj
dCBkbWFfY2hhbiAqY2hhbiwgZG1hX2FkZHJfdCBkZXN0LCBkbWFfYWRkcl90IHNyYywNCj4gIAkg
KiBtYXRjaCB0aGUgb25lIG9mIGFub3RoZXIgY2hhbm5lbC4gSWYgbm90LCBpdCBjb3VsZCBsZWFk
IHRvIHNwdXJpb3VzDQo+ICAJICogZmxhZyBzdGF0dXMuDQo+ICAJICovDQo+IC0JdTMyCQkJY2hh
bl9jYyA9IEFUX1hETUFDX0NDX1BFUklEKDB4M2YpDQo+ICsJdTMyCQkJY2hhbl9jYyA9IEFUX1hE
TUFDX0NDX1BFUklEKDB4N2YpDQo+ICAJCQkJCXwgQVRfWERNQUNfQ0NfREFNX0lOQ1JFTUVOVEVE
X0FNDQo+ICAJCQkJCXwgQVRfWERNQUNfQ0NfU0FNX0lOQ1JFTUVOVEVEX0FNDQo+ICAJCQkJCXwg
QVRfWERNQUNfQ0NfRElGKDApDQo+IEBAIC0xMDE0LDcgKzEwMTQsNyBAQCBzdGF0aWMgc3RydWN0
IGF0X3hkbWFjX2Rlc2MgKmF0X3hkbWFjX21lbXNldF9jcmVhdGVfZGVzYyhzdHJ1Y3QgZG1hX2No
YW4gKmNoYW4sDQo+ICAJICogbWF0Y2ggdGhlIG9uZSBvZiBhbm90aGVyIGNoYW5uZWwuIElmIG5v
dCwgaXQgY291bGQgbGVhZCB0byBzcHVyaW91cw0KPiAgCSAqIGZsYWcgc3RhdHVzLg0KPiAgCSAq
Lw0KPiAtCXUzMgkJCWNoYW5fY2MgPSBBVF9YRE1BQ19DQ19QRVJJRCgweDNmKQ0KPiArCXUzMgkJ
CWNoYW5fY2MgPSBBVF9YRE1BQ19DQ19QRVJJRCgweDdmKQ0KPiAgCQkJCQl8IEFUX1hETUFDX0ND
X0RBTV9VQlNfQU0NCj4gIAkJCQkJfCBBVF9YRE1BQ19DQ19TQU1fSU5DUkVNRU5URURfQU0NCj4g
IAkJCQkJfCBBVF9YRE1BQ19DQ19ESUYoMCkNCj4gDQoNCg==
