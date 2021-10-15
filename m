Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4384042EAE4
	for <lists+dmaengine@lfdr.de>; Fri, 15 Oct 2021 10:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhJOIFl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Oct 2021 04:05:41 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:49056 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbhJOIDc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 15 Oct 2021 04:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634284886; x=1665820886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=l8YS04J6TxsJ3upxIg2G369h0E9NlS6upnnzsFrbiPc=;
  b=ygZK36wHIFQy/+EW/hcyo2ZhYgqHIOKjd+UHJge0/R7oBvHzqZB1jpyV
   JqRJ7wveLSRo/Bdp/UlEBBV03PtMda5NUYe+DXTVegCe2V5Ffzuis6zph
   St0ukHdgQXoqZZbj3Dq9+K8s3pf7Eegny+BIE7uUUKswsRVzn2t/PQNsE
   6ocuO66kr492ai6zFTu17BBRcd+oBs2nEc8IPbx+fZX0ToXG3ij1MBOcc
   VcfNl22sxRiECT3WdRZkmG6TirOvyNqMlXphzs0IJ6jB3n4UHvxMtncSm
   DJ8jroLRWMC7GH7h9VTa26y21rt4aqqMopQsXSSiG/fr356CNipMDYLSA
   g==;
IronPort-SDR: 2wLt9jrQOqXY6JJ09/JmHFb+NoLjNkGVJzHn6JNMJnCQhQK7V9v8Wox5izfJQdzKvaA51QBDRA
 fCGlSIXS4cfH3etNeeBlgjLzjLbkRf1BHkUWx9CHVyFw7NJ1eBejdi/mTazllExX8I4l6/yte/
 yq6pY1k2g83RIJQsRPH8g29Nzldnpf5PZ2vtkQ6w3hiYX2d9rT+zpQ189a8kiNvkgCwElkH1a2
 vHOXXjfG+mW8u65dLH/cs+N8cWqv7/CchtrAZZMQaqW+CiXaut0hF6fknmnI10QyMZWCntf4v5
 ovwp1lb4Z+J2dKPU6Ew7Sjan
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="scan'208";a="140404536"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Oct 2021 01:01:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 01:01:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Fri, 15 Oct 2021 01:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWOBmqIb81LSIDF+n5qe3gShbVeUZkAck7q4fDJpGj5ZQRn7C930vuAyj1bTr3sZmKsRedVoElROM17k3ZULfILXWEYHjcoaFmzt7jaJQu616B5Cwf17suIy9gKerb50x/PHoYBFMxdkcs0YRUJycsVZJJGXnvVOR9nKkxKjLqNTQ7MAMQ8PoXQurcFCzso6PL6RHuOeGA12F81xdWq7sIrrhhpINLRbZ8cBl3zPpOHxFpdTOMjM2hp3GNDfVUZHZBr0Kydp3IeGWK8kJ3a7/Dq5s5GH7Kv5Kq1WL5RBQh5mfj3MYn6hcnmY0rfWDdAH1zGBlnJFtpEHBFmocWW40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8YS04J6TxsJ3upxIg2G369h0E9NlS6upnnzsFrbiPc=;
 b=DFBoZD+dMJoG7fv6tPPKSUtkfirJPgZ60s2xByrg77JvmNCQbCnThA4KGpWOMuR504VxophSW+cdHOGgNQIN+FtFx0h0DBi2Vw7u8/KcoIQwjKbvZN5wEnkIXWjob7SCZNkFVDGhMKRXnKiwUiF12i2suRyoxLc3JZMAcI8tege47Q6QXCms7iScHwrMncOuXlDl7ksDXAZnVPZ/F4yLr9PvVNYADMrDrB6K9N9XQ/09hWKXs9Hp5ylxICYOR/ZNqMREF6Vw+MAWPRqwh4NOYlB0w6KmM3URrjQqlR9WRoSvBsWVutN7FiOWVyWWGbj7KeRm4ICmQ5rfZLPJzEljDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8YS04J6TxsJ3upxIg2G369h0E9NlS6upnnzsFrbiPc=;
 b=QlEBVkA/OrLNRD3BHKuiiLQSLhcygLJDmVG9V/WP6jBsOXs+KmtDaJBq7xxUHkK8U3EQldkWd8iAyrhjOu36UI3sAo6cBw6DnYsiHgpPfdWyMFQPK+qY521iD9DO+Mm08Vaz+yZrLw32YGniBy2p4dR10K4CaEAi+cpDDhZIFUk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 08:01:16 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4587.026; Fri, 15 Oct 2021
 08:01:16 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] dmaengine: at_xdmac: use __maybe_unused for pm
 functions
Thread-Topic: [PATCH 3/4] dmaengine: at_xdmac: use __maybe_unused for pm
 functions
Thread-Index: AQHXwZrUafk2m7OWmUi676gTLPMENQ==
Date:   Fri, 15 Oct 2021 08:01:16 +0000
Message-ID: <2f897cb2-a498-c386-2d5b-26a304f20d1f@microchip.com>
References: <20211007111230.2331837-1-claudiu.beznea@microchip.com>
 <20211007111230.2331837-4-claudiu.beznea@microchip.com>
In-Reply-To: <20211007111230.2331837-4-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 996687bb-1079-4508-ede3-08d98fb1f72a
x-ms-traffictypediagnostic: SA0PR11MB4717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB471755FC469814ABAA1907C2F0B99@SA0PR11MB4717.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BqyUynV74T2x9YMHIan47AI2GRh0TnuvfaUoBWUhIM1l5lJDmhlpPnCL+70f/1oLX8auNsoo+ii6oru+u0/QHFaTVGwskHLc2YPbjkRNrGrfBSLFvI84QkbFzSmJcWThcgPZMXFcIdD2zcB8wveeWBha1iyN1MNp1KM+MuWVYAyNa8KwUNPHfklCGaJLQvxLyaBVThGDUxg9vwrNIDZh+KZqjdeU99tQueV56Z1XjHQzNAF6Ns6Cwe39QedArRWOQIwO8R5md+p68APPX5DsA6hGyVr9PvIQLsC3reERsSJ27FxeEWXsFYa87rSCrW8h0iy+y1U+NDBmOoMdccANbY5SFx+LrkQoIW3aXZQs35vDVqjhG+gpGKPwv89ZSyfdPgjZPf6VBKcxIR1WO2/D9bMVgxBuF2L6xc4Kxg8TzW2D51derhFVSnIBQ+s5cq1c7yat0JwNeeaAY8vWWClLEyXdJeLEGR6E987A9GM+COr0HF2gQ1W/F/woc9WORfpbnrF4R6imibD/zW2+NSxM3xn8FpXdBhB1LzTdQlzOuzjKREyBQ8OZY0cZQ2usNH3WucsHtJJwzftG4eNTG0ZDb0SPEU6kEwq9/OU++0jdpRzAvS27aedT4S0NLm1OfC/SZcxlTyuBmS9n++CHuj/6IZN7eVAwcnjQjwp5U1dJ/qJ6KDTCkiFS3Q/sb3w2k1GxOdHKBzRSv57iqTgBIdQRn3Z8CCT/5bmNKNbePBpClk73e/gYYQ61VS9Cp+4dZosDpVGFCuG2cc7dSgPMuNZbjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(2616005)(8936002)(8676002)(66446008)(6506007)(64756008)(66946007)(91956017)(71200400001)(86362001)(76116006)(54906003)(66556008)(316002)(2906002)(5660300002)(53546011)(66476007)(508600001)(83380400001)(110136005)(31696002)(186003)(4326008)(31686004)(38070700005)(38100700002)(122000001)(36756003)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2Nhc3crSXNibEdqN0dkRW1aREdZYU9wM3BBSUpHN1Nkbnovb040d01VTlJy?=
 =?utf-8?B?SU9rdEhNTnVhenNORW00UGpOTVp2TlA4NG5GVmdzVGlSZ3BocElSNFBzSkpV?=
 =?utf-8?B?cE1lK0tLaEFzNnpQeGdvMm9SemZiMnZPR1ZpUWRUQnZOcWpLck1xcE9OeTZl?=
 =?utf-8?B?cmdGSHJOWWNCOFNWc1huR01qV2VvNWVQSW1ydVV5Z2JYRlUvUTkrVzNka0FZ?=
 =?utf-8?B?TFBTYWp4WHU3dU4wL3FpOHhPYXZDeEpmaFdqdkh1YkVPd2tXSk93ZUVBTUFX?=
 =?utf-8?B?L0tLQnU5QU9QV2RUT25MRHRKNDF1SkNMQzNocEVSYU51cVlaUTl2eUhBRDk3?=
 =?utf-8?B?bElSQyt3MmhGYnk0UmlkRiswZHIrbndJdk5YbUF1S0xNQmcwSjZycWNzN0sr?=
 =?utf-8?B?MmJ5cit3SjRDWlNjM1lRNG5EL3Z3Z2RxYmVkdXllL3p3MW1vQVd4Z05UTjJv?=
 =?utf-8?B?WDFQbmdrRi85aVNKN0VkVWxDYmRPcnpvSXRJTDhmbTJ4SVdIdTkrWlBKcGx1?=
 =?utf-8?B?Ujg1aXhmcy9Kd0RYWmhjZGFPWG9MYkFGQkVqNHR5Ty9vWDRRdURqUWlGR1dX?=
 =?utf-8?B?ZSt1USt5SHlyNk5iSlVNMk1NZ0hrYnNDenZBVnFmN2ZWeEhjZ1BOQldFdlFP?=
 =?utf-8?B?UEhlbGw0MEJOVWJXVTkrbzhUT0QrNTVlMGtqYVlpUXlDMFcxYjZEYnpzY1gv?=
 =?utf-8?B?R25tWDJuaGU5RndmaFFnU3kySjNvblVlYlg2WFpmMFNLb2I3M1ZzSnN4N25G?=
 =?utf-8?B?ajJhN0tYK1JBZDh2TE5XczY5TWFrcnFBQ2RlVnd0N1VIT2M1TEdRVngvTGYw?=
 =?utf-8?B?OWxucmYxd3lNTzBDeHVnMzZwSkFCSFhmc1BtY3NmdVBlRlNvdndEZDJXMFVS?=
 =?utf-8?B?eHYyaVlRNWtrckg0dzlTTTVzV2ZsU2pHaEJ5TWtwWVc0YTlnalVSZ2xrRlpF?=
 =?utf-8?B?L0luODR0bTlFazU4R1BxaWZMSWp0NmpaOC9oOGtxOEtURTR6d0x4cFA0dXMx?=
 =?utf-8?B?eWtUSU1XeUlibEMwd0k2ZUFBejJFSUR1cXlsNldoU2JVSE12cENyeEhhdm04?=
 =?utf-8?B?MzhyVVVTV1hBZHdyK2ZBWFJseUI3NEw4WHVMVkYvTWVwdWV5ZnBpTk9rZkN5?=
 =?utf-8?B?cUxEZUFqK1BBdDlEeVpERzhyZkxQOUYyazJNbFQzVUxCYnpENmxmaW40TG9X?=
 =?utf-8?B?OFVwWVo2YW5DSFhUaGoxVml2S21PUE5EZXlsalpnVXdGMTBDem5kOG1qY3lj?=
 =?utf-8?B?eFhBSWRpRDUvYU9aRnY0aU1xQnZZS1g1UnM5d3VPOHg4dmh6L1h5RnBkaTUz?=
 =?utf-8?B?eFQ3cEJLRE8xaFEyNzJDUHY1U3dpWnIwM0lBUjBtNVd2SGwxK25Lc3FnUytH?=
 =?utf-8?B?S2ZmY1huQ2FjUEhhamJmVk80eHlPTGt3aHMyMzdBRE5VSko1YUdoaW5LbjFl?=
 =?utf-8?B?VU55MERzU0VwdWVlMElHaVEvVUZqd2VDcnExNHVHZ0RkaEZ5OGNHbDBKR2d0?=
 =?utf-8?B?OHg1aDA1cCtJSkREZFM3ZkFxa2ZETW5XVmVHaDVaTm1IRGk3MVFFT2NUMHlU?=
 =?utf-8?B?Zi9penNIaStTZW0vNmJ6SUMzZnF1b1lsK3BhVmVYWmRxNUNoTE5IaDU5K1Vr?=
 =?utf-8?B?TlZyeU0rTU15SUxSU3lHOVVkbzBGQWN4ME4rVWpFZ3pIV0pZK29DYnFzazBh?=
 =?utf-8?B?Zzc3bnJ6YVNMUGhrNjk4blBXYkY2UW1mU2Y0bEhsdTQyM3V6RzlGb0drWUtn?=
 =?utf-8?Q?Jmj2jpriQgY2zcgxOs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FAE3876F6208A4390BF48C2AA1666BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996687bb-1079-4508-ede3-08d98fb1f72a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 08:01:16.6821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Knn7iPkNGkv2cWk4OiO3cif804zOTLpHHqCtzfZ3FWiJAdrLjdmBswMm2VPdtu2QhBxYhcfSfASCUSu7Rq0p9SLdKNjKm8AqxZ2CiNzON9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMTAvNy8yMSAyOjEyIFBNLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4gVXNlIF9fbWF5YmVf
dW51c2VkIGZvciBwbSBmdW5jdGlvbnMuDQoNCkV4cGxhaW5pbmcgd2h5IHdvdWxkIGJlIG5pY2Uu
IEUuZy4gYXZvaWRpbmcgaWZkZWZzIHRocm91Z2hvdXQgdGhlIGNvZGUsDQphbmQgc3RvcCBkZWZp
bmluZyBhdG1lbF94ZG1hY19wcmVwYXJlIGFzIE5VTEwuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQpSZXZpZXdl
ZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0t
LQ0KPiAgZHJpdmVycy9kbWEvYXRfeGRtYWMuYyB8IDEyICsrKy0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jIGIvZHJpdmVycy9kbWEvYXRfeGRtYWMuYw0KPiBp
bmRleCBlMThhYmJkNTZmYjUuLjEyMzcxMzk2ZmNjMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9k
bWEvYXRfeGRtYWMuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jDQo+IEBAIC0xOTUw
LDggKzE5NTAsNyBAQCBzdGF0aWMgdm9pZCBhdF94ZG1hY19heGlfY29uZmlnKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IC0jaWZkZWYgQ09ORklHX1BN
DQo+IC1zdGF0aWMgaW50IGF0bWVsX3hkbWFjX3ByZXBhcmUoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiArc3RhdGljIGludCBfX21heWJlX3VudXNlZCBhdG1lbF94ZG1hY19wcmVwYXJlKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgYXRfeGRtYWMJCSphdHhkbWFjID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7DQo+ICAJc3RydWN0IGRtYV9jaGFuCQkqY2hhbiwgKl9jaGFuOw0KPiBA
QCAtMTk2NSwxMiArMTk2NCw4IEBAIHN0YXRpYyBpbnQgYXRtZWxfeGRtYWNfcHJlcGFyZShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ICAJfQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAtI2Vsc2UNCj4g
LSMJZGVmaW5lIGF0bWVsX3hkbWFjX3ByZXBhcmUgTlVMTA0KPiAtI2VuZGlmDQo+ICANCj4gLSNp
ZmRlZiBDT05GSUdfUE1fU0xFRVANCj4gLXN0YXRpYyBpbnQgYXRtZWxfeGRtYWNfc3VzcGVuZChz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGF0bWVsX3hk
bWFjX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBhdF94ZG1h
YwkJKmF0eGRtYWMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIAlzdHJ1Y3QgZG1hX2NoYW4J
CSpjaGFuLCAqX2NoYW47DQo+IEBAIC0xOTk0LDcgKzE5ODksNyBAQCBzdGF0aWMgaW50IGF0bWVs
X3hkbWFjX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiAgDQo+IC1zdGF0aWMgaW50IGF0bWVsX3hkbWFjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIGF0bWVsX3hkbWFjX3Jlc3VtZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGF0X3hkbWFjCQkqYXR4ZG1hYyA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiAgCXN0cnVjdCBhdF94ZG1hY19jaGFuCSphdGNoYW47DQo+IEBA
IC0yMDMyLDcgKzIwMjcsNiBAQCBzdGF0aWMgaW50IGF0bWVsX3hkbWFjX3Jlc3VtZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ICAJfQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAtI2VuZGlmIC8qIENP
TkZJR19QTV9TTEVFUCAqLw0KPiAgDQo+ICBzdGF0aWMgaW50IGF0X3hkbWFjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+IA0KDQo=
