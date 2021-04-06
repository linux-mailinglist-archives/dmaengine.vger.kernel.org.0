Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE5B355095
	for <lists+dmaengine@lfdr.de>; Tue,  6 Apr 2021 12:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbhDFKME (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Apr 2021 06:12:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:4213 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbhDFKMD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Apr 2021 06:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617703916; x=1649239916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QHeh4aDKWHU1FX1EG4pgOrKB2WXgGIU9KkJ44/oni2U=;
  b=SPLd/bOY0WcUFZWUzJ5liMzmFepbxJTRCyuWWzlbiTtCMZzCMiaVMuqx
   oeLp1CoLFUDVIXecfZ4qqG6EIDejJwoDRBmrmpmxrPIclYQO17lmF+k8l
   vEZUZufrnMm49NnIjCQ7EE/ZRtsHtz6cqiB00StlGjnR7RtIXcf0hUCR3
   IC9XGbyAPaI7sEHbdpqt0ilfLmFNomqZ9kJMZZ1ehbEKQWxDFGFoHclqA
   r9HPTpWKO6OblpDxsNVSwPe68BbRqEpP5k1arzvFInliQXGbKbyrhqczR
   sZtNLfPRUluw++xnpSTrmMiZP9/plyZSCDW7nk+zKVVi5D7gwHD5Y2plW
   A==;
IronPort-SDR: oLqUCD1F5AQrTbGamjpwllw75D9wbl0eUAxfueIJDmyqaChXE6QorY5De8LYoLwrXEsOv3Hhoi
 skAGkzEVkbMVT8wGWHi16r8oFCEeAhV8yT/cfPGJsS+kwuTaHk1MG4JO+ZYelwWKz33jQulgQm
 /FkOgAgxF+yE3ubwAMzF3YdpsYwguD3xqc0MMgxKR6AOJAHGM3qbhqj4w5hzwWjl0mj8Mu5aU9
 rVjnu10e0NLJ+ZNGZDw1KilsVm8phJG4ZSSG/yJnuKwO4zbCqUbXX8Wpie//KbJNsfFO593nKw
 lUo=
X-IronPort-AV: E=Sophos;i="5.81,309,1610434800"; 
   d="scan'208";a="112584352"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2021 03:11:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 6 Apr 2021 03:11:55 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Tue, 6 Apr 2021 03:11:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2rkQwhijRS+7tbNYuPCzJJuT4qF8hpZBDG0nHAIr/zTwIF9NW4pNXontL1WGNpL8EnHWVtLhKrQ73vxmNFA77LGC9zjOwOsgQD/XP1ifbNYRK6ypPyycbxpmvlw3W13WGfZJ1DHkxZwDhoN05lg1jrh/WqUUBKI/NE0Dj6eztsdTDpDg2R6aEZH910Fj67qoBpX7VXmdbvXO+xSgv9pKMLvTqJqvziahPLNoj01mTlW1YW/mDPubbz0HPIYJdYDdnWd/ChDKEOooQyd0FcMqbIMCpCruWhfDcAzJ9RWvHbEI8oR7HIqrI7WZpejJuvJr1v5/sw+QjgaoATV1q2HLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHeh4aDKWHU1FX1EG4pgOrKB2WXgGIU9KkJ44/oni2U=;
 b=jk5jsHhUzMozeunPapHTiw87OKF19ps2OeMmPWpMILsRZpluyfqtQVqdhy6n8C3CPE3yVoFJiqBcErkSS01yOEO3AVeS9pqsYd4TVVbLSz+NinwPRej+8dRITDoRVDVA/3TnArJNrJGQqplxACFcMa9N1wxa4iVeDIOZCNqjIE9EJOJrW/Ec6fAYmzSDhVtDIqshbvubH7hLARlBH4AwrOSfQ7luR86v2AUDnFPOrBLKkwKHLM+a+iG99dEC0d9r2nX7l0Z/9T1dHXEzkGoenrxeQcTQJjGdIvSlQ8iS/BTvC+mSfZc4RPqt2TS9oCmgIUFl/RCMAV9BXhmM9qqehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHeh4aDKWHU1FX1EG4pgOrKB2WXgGIU9KkJ44/oni2U=;
 b=nQbBqpO3k9YjbVyASf/irgWAW3Tj8vDUyEXBLRjYC3RIAChrWd1P0X7wui44ya2SQJc2vqqQwXhUs22aW/39Jx+BbvkYxaFfRZPDk32G8chPNRL4fXGSwKeOCyD/rGVBst4zocsGmzcyqkdt2BHg1ZK22VmP7jzYslwGLncJvfc=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3197.namprd11.prod.outlook.com (2603:10b6:805:c5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 10:11:54 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49e5:8be7:95d:b6a9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::49e5:8be7:95d:b6a9%4]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 10:11:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <yuehaibing@huawei.com>, <Ludovic.Desroches@microchip.com>,
        <vkoul@kernel.org>, <Eugen.Hristev@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] dmaengine: at_xdmac: Remove unused inline function
 at_xdmac_csize()
Thread-Topic: [PATCH -next] dmaengine: at_xdmac: Remove unused inline function
 at_xdmac_csize()
Thread-Index: AQHXKs1EiBekPi/xUUuKDb6O6Sublw==
Date:   Tue, 6 Apr 2021 10:11:53 +0000
Message-ID: <e854d48d-d15b-43f1-07ad-2d545ea94638@microchip.com>
References: <20210406085043.32544-1-yuehaibing@huawei.com>
In-Reply-To: <20210406085043.32544-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2a6d5b6-999d-4bf6-a6dc-08d8f8e46734
x-ms-traffictypediagnostic: SN6PR11MB3197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3197681B63B64A7BB8A06958F0769@SN6PR11MB3197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:200;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxs+5P5ZIuIAhgv+klW5HrKQpDFpsFeCDBWEJFYdesCXLfwu8CkoV0gMsKKlYCQzNa6URmKaj3EMS1taMa/FFOjjzUuJ8rCIDjoabZUiAWQZzDAVP+V4WpOg0F3oAhRm5PUuUlEb3Dbvtc2rg/YmGtL7KGNP0Tp4ftARRNLqA2rYDpX2CY/Q2A3PW5BkCfczwgvyHgsDFOBGq2VsbaxmqhfkOVuhhLS1Ov1yNddXdRThXfjDxJ2UgsHKv5TLPiKTKsX8JSAeqgqimRwv5P6i+D4Z3bhW6opGCObqXp29I2qSQHgfJ28iKym7Lw1o4Ir1c0Z34gom55hFb9oQ89nR8cgzDXzqtD6dbzCe6rBCoI+H+I+5GYvri4v/Hf7AsuTdLBB38skcu+j59IrzWqGPUViVDNgub2cpy9zTSW5Dv/3cYZj0dmF/Sav0QaM3CFPWWi7VSb1qKXmPkdUhJ6c2HtUDc4gcVt5QqIW+Hdg3KNVAEV+12Fdkoy41Vxkmw8WGZu7S7IXJCLWopPGpwgTPC2cW+eRIwnqCaO+je9fl06Zpfa5fE3leBA2RZoX9oc/+s6mRqAyM5pgy+Y85qUeNpsi3Ha+ARc7Z300/9EbNw+o/m6cuKBQ1oex0EqrmXfqa6AdTnprZeGcwkzWBu2GfAGMhYTJjAxpgVZn1C6TOu8Xr0SU5vm5LTJa3upJ1PFuieNE8KOgjnbv/aFutrXzyfeeFcrDTaaKgElykWEDCZgs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(396003)(39850400004)(36756003)(6506007)(53546011)(8676002)(66476007)(64756008)(26005)(110136005)(66946007)(71200400001)(2906002)(186003)(6512007)(38100700001)(2616005)(66556008)(91956017)(6636002)(316002)(8936002)(4744005)(4326008)(5660300002)(66446008)(86362001)(31696002)(6486002)(76116006)(31686004)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?STErLy9NRDRwck9Fa3dURk05RE4rNndUSWpyOUpOUkY3NHJFSUhvcFduT3Z6?=
 =?utf-8?B?SUhzUFBoTDc2NUxrbDJxS2RNYnpFeG9Vbjd1QzBMcVRpR3liM2podEZ1K3Bv?=
 =?utf-8?B?YnEva0VicUtMMDBZaDlITEsvSmlxRXJxNkVEWUJUQS8rd1JUekxBWGZPa052?=
 =?utf-8?B?MTRnVkpFV0xxTHVyai96dzBrVnRTdzF0VnlCTnY5T1QwMEZQUzZ5dUw5QXpo?=
 =?utf-8?B?SG04N1FrWVFtcXAxdnFtRzhCWG9CTFVUWWZXOHpBYkhmZVpDcjh1dGVWVkFM?=
 =?utf-8?B?NUtYN3JmS2dpRWNPZU9ZSllXaWs3RVlOY2hBTmoySHdRVjFJOTYzK2dteHNV?=
 =?utf-8?B?QmJQa0N6ZDZha1E3RFdTS0NvR052dkRNSXFiYk1uK2FBS0tCbHR0eklIL04y?=
 =?utf-8?B?QU9mUmJnZ0o0R1dVdUJ3SWY2c09uUlpiRmNUbGs2QkNFU1N3S2JnR0YwSlYx?=
 =?utf-8?B?Vy8vNU5sSlZkQWFRQkhJdWxhK3BlMG9ibi9rQ25SSEtPdkY0NkhYYUNKTE5Y?=
 =?utf-8?B?VVFEaUc1VENnd0lCdzVjdkdvZVhOaVZ3Y2NlMXJhT2lrVkdnZU5hREpURTdi?=
 =?utf-8?B?a0pRZ05nV1JEbXo1SDVEb1NMVGNPVHNwS2xrTlU1RUU1ZlpvcU8vT0FzR0hh?=
 =?utf-8?B?ZTRid2VIeGlYODdqaVJWM2diTHQ3Szl5N2ZnQUdPRmtBY0FiVUJZVzEwLzJm?=
 =?utf-8?B?UjU4L1lxWi9kVVNXblI3M0lpQ1pXZkRXMkdhWk1TMjBtRDNZSUJUd1dUYzZi?=
 =?utf-8?B?M3RPOWhaS09GL3U5UTQ4UHUvZlY2eXlMK09jamxySTMzOFRFNHJqUXExQ2tn?=
 =?utf-8?B?VjNNT1RlUU9ZOGJTYUJkMTI3d2xYTHpUNVg4bmVielZzaE1lNzhtMHlQK1kr?=
 =?utf-8?B?YWFuRkV5bmVINjZPRVlqTkd4T0J2eEVaU0tZdUdIUy9CbDNWK2hXQVBkbzZC?=
 =?utf-8?B?SFh5SHJHajUyZUVCY0tKNHE2bS9LQ0hnM0VWeWFrd1NkL21VOHdhOW5sYjZw?=
 =?utf-8?B?NWUzMmltRUtiQVlhR3Z5S3l5dVYyWHNhVmtHcmZjOWVGbnBuWWl2RUFUL3J4?=
 =?utf-8?B?SUpxUWgxWGoxRllYUmgvVlJQYTJEaVlOZFVnamF4TTBHcGE0Qm9IN0JBdG5T?=
 =?utf-8?B?bHdHWjJGaTgzTGU4ZWx6NUtLVmtFaU1qNnlzY0FFTS9FOEVnUjFZS2M2aXZs?=
 =?utf-8?B?Q1VzYmh2STJVNGFvL0hsSFVIbmo0TGNXNVBxOGUzVjRjNVJNOFBqSkpDSjh4?=
 =?utf-8?B?R3RBd3plZWhIR01uS1BMVUgrMHhyUzVFVXR3TUJKZTFoVG83dWQzM3hRbzRs?=
 =?utf-8?B?M3ZRdmM3VzFod3RhWEk1NFZZdkZJWjdLUnFLS0VoZC9nbmt0clptYjhWSnBk?=
 =?utf-8?B?eS8zU1NibExOTng4Zk1jaktlUVhZTUJBM3JnSkNIYUY3cG9zekJYSnVMcWRL?=
 =?utf-8?B?Q3pJdit0OXJHa0d1djBxeVNwbkFyRmFsY2ZRMG9SUkg3K0FDRXNIVFRlQnJW?=
 =?utf-8?B?bU5MY0xiY2xoN1lHZUJkVWdmdVNNVDNSOWw2NmMxYlZ6RzhhUzdzS2sydG0z?=
 =?utf-8?B?eFBzczlyWVZNaE90dVZHb044cUJvdThEaHdVL2xBazQ4ZTQwazJIRFpmRkI5?=
 =?utf-8?B?aGw5dldlMlEyNFp0SlRJWUFxaWlkUnhUYjliRm5Hd1NwaW9BaUMvcnI3L2Uy?=
 =?utf-8?B?ZW1DelU0MmY3Z1BDTHVDTGZmaG95YVFINjV2WU01eDZ1QVVvMm5KYTc3NS9G?=
 =?utf-8?Q?AN+zbIFXo7jn2bNa4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8631ED6476E684A8A46C02518043892@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a6d5b6-999d-4bf6-a6dc-08d8f8e46734
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 10:11:53.9804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38VOA/iOEpzkAA4rCsJ6Vm1IWk20P4fYgRT3bttJZI4Z3EtnKK5RGWCJ3Kp28QwRnORaEcXWI3u+9Xk+Z5WbGdLb3Nus3/fBMVtl7mIsGuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3197
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gNC82LzIxIDExOjUwIEFNLCBZdWVIYWliaW5nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IDc2NWMzN2Q4NzY2OSAoImRtYWVuZ2luZTogYXRfeGRt
YWM6IHJld29yayBzbGF2ZSBjb25maWd1cmF0aW9uIHBhcnQiKQ0KPiBsZWZ0IGJlaGluZCB0aGlz
LCBzbyBjYW4gcmVtb3ZlIGl0Lg0KDQpDaGVja3BhdGNoIGNvbXBsYWluczoNCkVSUk9SOiBQbGVh
c2UgdXNlIGdpdCBjb21taXQgZGVzY3JpcHRpb24gc3R5bGUgJ2NvbW1pdCA8MTIrIGNoYXJzIG9m
IHNoYTE+ICgiPHRpdGxlIGxpbmU+IiknIC0gaWU6ICdjb21taXQgNzY1YzM3ZDg3NjY5ICgiZG1h
ZW5naW5lOiBhdF94ZG1hYzogcmV3b3JrIHNsYXZlIGNvbmZpZ3VyYXRpb24gcGFydCIpJw0KDQpi
dXQgdGhlIGNoYW5nZSBpcyBnb29kOg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9y
LmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcg
PHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2RtYS9hdF94ZG1hYy5j
IHwgMTEgLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9hdF94ZG1hYy5jIGIvZHJpdmVycy9kbWEvYXRf
eGRtYWMuYw0KPiBpbmRleCBmZTQ1YWQ1ZDA2YzQuLjY0YTUyYmY0ZDczNyAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9kbWEvYXRfeGRtYWMuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9hdF94ZG1hYy5j
DQo+IEBAIC0zNDQsMTcgKzM0NCw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IGF0X3hkbWFjX2NoYW5f
aXNfcGF1c2VkKHN0cnVjdCBhdF94ZG1hY19jaGFuICphdGNoYW4pDQo+ICAgICAgICAgcmV0dXJu
IHRlc3RfYml0KEFUX1hETUFDX0NIQU5fSVNfUEFVU0VELCAmYXRjaGFuLT5zdGF0dXMpOw0KPiAg
fQ0KPiANCj4gLXN0YXRpYyBpbmxpbmUgaW50IGF0X3hkbWFjX2NzaXplKHUzMiBtYXhidXJzdCkN
Cj4gLXsNCj4gLSAgICAgICBpbnQgY3NpemU7DQo+IC0NCj4gLSAgICAgICBjc2l6ZSA9IGZmcyht
YXhidXJzdCkgLSAxOw0KPiAtICAgICAgIGlmIChjc2l6ZSA+IDQpDQo+IC0gICAgICAgICAgICAg
ICBjc2l6ZSA9IC1FSU5WQUw7DQo+IC0NCj4gLSAgICAgICByZXR1cm4gY3NpemU7DQo+IC19Ow0K
PiAtDQo+ICBzdGF0aWMgaW5saW5lIGJvb2wgYXRfeGRtYWNfY2hhbl9pc19wZXJpcGhlcmFsX3hm
ZXIodTMyIGNmZykNCj4gIHsNCj4gICAgICAgICByZXR1cm4gY2ZnICYgQVRfWERNQUNfQ0NfVFlQ
RV9QRVJfVFJBTjsNCj4gLS0NCj4gMi4xNy4xDQo+IA0KDQo=
