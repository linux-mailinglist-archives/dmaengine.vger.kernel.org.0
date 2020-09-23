Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C453727505D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Sep 2020 07:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgIWFmr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Sep 2020 01:42:47 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41314 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgIWFmr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Sep 2020 01:42:47 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 01:42:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600839767; x=1632375767;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=46H7bsmgCIoU177WvoYyTJNlm7V1J5H4fdbeXVYXX64=;
  b=EEchjbmWERcmJmvMrSBqua97+z+PNYkcB/m/kt3HD2PVN7Ub5175oiGB
   kKrzI3kEDtcuqLWnzIbWgjKElGvZs5zUQl6kxX0x7quDLDSKYLUJW9pk4
   DeiVPLSuE0jKN0UoBngqCYCw3rHKE5UKc2lmQdjlbrpjy0ktNegbo9O6e
   3Kj0lKbsjMcgIaujH/FxoFhybVQUY+zKSLJGfceYuAfyDGMoiqi386/eH
   quM2bnyqS5aQE97OCmIIcNZkhIwroZb4GjsoFgNCOg9aBUFT1kxCfHupF
   9CMhp3lAalXR8oEaCMJUK+tQQperUB8agwmSfEdFGoMxuycpg+gld8EcB
   w==;
IronPort-SDR: pMF9EyI9efiswm542twX4Wk7Lh4Mg3pZTf8t5Tj126XL1chg9Yqvhq3oqVdfk5/vUcG1l19w0N
 gSl+epSe1FjXsqnOM8OZnUYOv8Fc94OG1CUlC8DCU8c+HgU7p4jWqZMQO7N8g5CjVXassCKx9F
 MBWkFvp5COAIAj4m3NL/DPxJ320wchIMBXjYROtbH0dj/NYB4XoHcKrqTKENHqJKTj7F5B88kT
 zziksUc2fihtndEsBQYS4A6tzLyiSPoRC+9PJubgsWkOCp7SyF27HFD9EcvrOT0PMwltryOUPw
 QQ8=
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="92025675"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2020 22:35:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 22 Sep 2020 22:35:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 22 Sep 2020 22:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9sxXvS6p+lmPUWPnBsWJX0fCoaxTAc/aacN+HOcv+x+4ZvAsr+zc/A9KbO3XJSZTr9VppnF7jbxH4woRqJy8a3Up8shJzwLJpmCHUVi6mivnx2RLfqntUJYPO+/wRmgquily56F9/HTOUNVJ25fE/STXLGOyFV+5lZ2zHDOzFIarBLXNAH/LIxiEF/okz3MwHsMKytGAXeHr+WBVZObGbRoD+jDMZeemeTLUMdyIwK3+BPPNGCKoplO3D8ZRXQ1QiYvLMQSn89/0OT4tOgcs6AYyGqAVvx8VLSyt6jW0OVKhFN3QzXPa9o+kWcNyxKfJrsEksIJlSmzyugJ7EetCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46H7bsmgCIoU177WvoYyTJNlm7V1J5H4fdbeXVYXX64=;
 b=V8tcklx5qGN5oeQqI2c57g1qOR5PYYHwQtNau1z/WRZB+B32uFim0FLD2J2BrA45fM939nZjwANIYKaLS6DdoJ/h5ANjrHNXQ8VaUcj+DTJySU62trATuBGpQCgmUNBKDsbAgAOS1JPLIMqaSAtgwv3rvz0RMx+TlLoqUKRKS2cYTm2VSNmfbuKNGjHS+xKkhoI0giABD2l7QG4ieW5SZvOB2kT6Nl0Nywzf1z4hNw+XqaZqha2CzP9VbOWpysvSDIozY5v/MVwzsQtLk8y2XWp7fnxHhX2OtPRS2KVvMfzw3ybsENH0c8aykvHRw6NPCT8GNb18WNNGJ+cnn4wm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46H7bsmgCIoU177WvoYyTJNlm7V1J5H4fdbeXVYXX64=;
 b=hSTpkKGekQwILXgOx4S/ggOx1wkAwq5bIPpkgTuMYQ+Ym4kTKPKHg16dBP/VzIQxYi7xHD1/jb/1kFrtc/u3bWPTR0KFR2/o9sP/fcyrr9T4ilLyfLk+Ct5HskriQUS3w9DnkamX0dOFY9Cq00Qp2w5ek+VzZFTVA3YH/w6K/ug=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 05:35:35 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::a8e8:d0bc:8b3c:d385%11]) with mapi id 15.20.3391.027; Wed, 23 Sep
 2020 05:35:35 +0000
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
Thread-Index: AQHWkWqs0npVjkI8wkK878r6lyc5AKl1s+IA
Date:   Wed, 23 Sep 2020 05:35:35 +0000
Message-ID: <cb54743e-5c8a-207b-8a0a-11b9768d0cda@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
 <20200914140956.221432-5-eugen.hristev@microchip.com>
 <520058c4-00a6-bbe3-2b60-93477be982fa@microchip.com>
In-Reply-To: <520058c4-00a6-bbe3-2b60-93477be982fa@microchip.com>
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
x-ms-office365-filtering-correlation-id: b45b01f1-de6e-40cd-dffb-08d85f827f0c
x-ms-traffictypediagnostic: DM6PR11MB4513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4513ABBD6E7B4AA727CB3313F0380@DM6PR11MB4513.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:586;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QcH5pDgp/KuxVtaSAd7J3v0n9Ph1rrMEkeLgcsz/0ZkUcxUjJmFn/MUbGTlDpqOndaUaVvgXH3eYTMu5H7keFocfdhGvxuxouRvgqQkTlrPGtIsGEOv1Sjx11g13P7JjV+B/DvJmS+mvyaGhb6BWX/KqS4wd1uV5/yrpE7EK9NsKHDzNcZNVdWAN5ZecoDMfQlXP4vlleafuWqY1P8hEQQjhKJEv1syNn4+FPjfDcqaCSUVp/wPAkT5oyzX1eBsHFZfux9AGlUKfYRwVlVnrIbmEKBfmGiu31qjiYrqYhL1tfbPPFvpCl/XdwvEXj3Ox2ngodUmQEcQstV13NIgNBms1Xz7BLR5WnHX1lDjFX2K6BT2yDbU9mq2zmYtM9onUbFR/Ywnr8o5ndVM7aKtnSr40yqd4bud/dKY7EEb7kCc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(39860400002)(396003)(54906003)(2906002)(6512007)(110136005)(5660300002)(107886003)(71200400001)(76116006)(36756003)(186003)(6636002)(91956017)(2616005)(4744005)(83380400001)(26005)(31686004)(478600001)(86362001)(66556008)(6486002)(4326008)(66476007)(64756008)(31696002)(66446008)(316002)(8676002)(53546011)(8936002)(6506007)(66946007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cKsT9A9lFgemPkjKHDmM43unZsveOZEgPUGmMsQbufU5JaN8DYXuSxiOcmaGQCuV1tM3DDB1hXIo0mxW5OcveyTxy+52xlkIYUQQT5O01WUEe6Lmz8Zrlw7oqkEYcxyR8Hp3ZlLb4gnUFsssTTVZE+G4j2Zm84tcD35I97HSPwrdsIH+cY5cnq+iJ+orDj2S0TbgcyEUNZjqsACKE4Jzo7Hq/er+7IJ/gkovtTKGvdj4dENS4wRVOzvosC3iLnb7Z0ttIzkiVPg7WcGZXjpDTlDlGEl+NVBWAlWk09LHr3ptokZodXazQ7HSrdfpdUQtRWWcgL6zE5fBvqCvOkOc7m0JfJCb0rf0ZZRuVLnbMnSiQM+pZ+ZpHN4WWXVyuPoZPYgabuZa9zRe2oZPp3IlbhCmnJWn2C9tWwmJSciu3NdXub2f3ehcG1itZx+Q4ke7jo9axDK4tq53FBV9I5m2xd4+Q9bn9fZH4d28ihJdzkJngtVP0yXVAjGYrcwz4TitK2wgPlrV15gK5C4zkTY1Ovbm67ugXiAXgYEBOMZihSHtOGDqNA37FB1eZewcKefaVWsOqAsbwn45lO6Ec+tAURG5YT/Zdb+M5Z7AQfmgr9L8mDMVPprR5O+8VAbIvpOLFwvIbHIldfkoPH3VTV7kBg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <99ABE54F5E22BF4684A33DDE31504530@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45b01f1-de6e-40cd-dffb-08d85f827f0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 05:35:35.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBEFOX5r74ppUtKlyuvIsM39lySmsaHAKekzYVd7caLhKRUyVtnghxxua7U2OfSfAaDb4u9wg6xT1tb7EIdjLlPVEy7OInsogllL0FZl90c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gOS8yMy8yMCA4OjMwIEFNLCBUdWRvciBBbWJhcnVzIC0gTTE4MDY0IHdyb3RlOg0KPiBPbiA5
LzE0LzIwIDU6MDkgUE0sIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+PiBUaGUgUEVSSUQgaW4gdGhl
IENDIHJlZ2lzdGVyIGZvciBtZW0ybWVtIG9wZXJhdGlvbnMgbXVzdCBtYXRjaCBhbiB1bnVzZWQN
Cj4+IFBFUklELg0KPj4gVGhlIFBFUklEIGZpZWxkIGlzIDcgYml0cywgYnV0IHRoZSBzZWxlY3Rl
ZCB2YWx1ZSBpcyAweDNmLg0KPj4gT24gbGF0ZXIgcHJvZHVjdHMgd2UgY2FuIGhhdmUgbW9yZSBy
ZXNlcnZlZCBQRVJJRHMgZm9yIGFjdHVhbCBwZXJpcGhlcmFscywNCj4+IHRodXMgdGhpcyBuZWVk
cyB0byBiZSBpbmNyZWFzZWQgdG8gbWF4aW11bSBzaXplLg0KPj4gQ2hhbmdpbmcgdGhlIHZhbHVl
IHRvIDB4N2YsIHdoaWNoIGlzIHRoZSBtYXhpbXVtIGZvciA3IGJpdHMgZmllbGQuDQo+Pg0KPiAN
Cj4gTWF5YmUgaXQgaXMgd29ydGggdG8gZXhwbGFpbiB0aGF0IGZvciBtZW1vcnktdG8tbWVtb3J5
IHRyYW5zZmVycywgUEVSSUQNCj4gc2hvdWxkIGJlIHNldCB0byBhbiB1bnVzZWQgcGVyaXBoZXJh
bCBJRCwgYW5kIHRoZSBtYXhpbXVtIHZhbHVlIHNlZW1zIHRoZQ0KPiBzYWZlc3QuIEFueXdheSB3
aXRoIG9yIHdpdGhvdXQgdGhpcyBhZGRyZXNzZWQsIG9uZSBjYW4gYWRkOg0KPiANCg0KOikgSSBz
b21laG93IG1pc3JlYWQgeW91ciBjb21taXQgbWVzc2FnZSwgeW91IGFscmVhZHkgZGVzY3JpYmVk
IHRoYXQsIGl0J3MgZmluZS4NCg0KPiBSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3Iu
YW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0
ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvZG1h
L2F0X3hkbWFjLmMgfCA2ICsrKy0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+Pg0K
