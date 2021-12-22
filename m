Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E647D042
	for <lists+dmaengine@lfdr.de>; Wed, 22 Dec 2021 11:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbhLVKru (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Dec 2021 05:47:50 -0500
Received: from mail-os0jpn01on2116.outbound.protection.outlook.com ([40.107.113.116]:43670
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244268AbhLVKrs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 22 Dec 2021 05:47:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJIpp9DH9yn71HubsUkTC/XQg87YpGUDdjdjn1uO5GPJkKdUGAa4VEK/FvSdUW9FeWDYnn/ElQVL+McJjmu99KKeMp9ylGQ/0SZFDctBM0dLfnDF+ASmidOHv5YSA2MONMXazLe0ufbCe0BxYJ8OvXbBolRbXxQ22bFZbQyYox23+irqoo5Oupnu1hddAq18XayT/Ubr2XNVM4HBdGf0Z113YfhYKaUMnwTJ9NSFjn2yTXAV7k1Og9h+D24PbsKimUahBk9rqH+b44t/l4/V/CCk8JyICy5LJ9K/nXLLCVDq/IeWc8zckT3qloWqqL9fOdOc2Xb2dLpIceA4rgaQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5vD6O07sga0MwG83Aav4VxH+9IEW15L3ch1yRubMgQ=;
 b=fnveKUhqxsUNCvIpOoeEx+Ja/WjWlszhVl96PI+2mUsSROr4VMOMHRsi2Z54+EczvvyUosvPKfLTUZLXylKiW1uszyRg/MRupC6BS9/ZYBpSRq5E4zMbDUVU4WbSrVfz6hC1MCLh6Mq0vX3T0ZLWWXPAAmo2c7mfbSj2QvE1dYCKMvHRwAUVt9dJyc0E/MGDPbm3xHsgKDf4v95nHfXXYYuAqVHZew85waGuaGrc9/b7Oj3jVs0v+ca1tnVKnhtAnjhSJMkXzqSHqPm14s/+TLU3GhR8Wh1kk76uoHVMZ48OUScbnkRMzfxk8Ncu5ivikDlJD2opdsL5vQ4tN/2tVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5vD6O07sga0MwG83Aav4VxH+9IEW15L3ch1yRubMgQ=;
 b=i1BspdkMIadg2qMSfPsvxSrnjo32Yr9BLokMNwTUlAEXt5pFAFffLdLdB3ubeDrpHiNEiThvP6dEy94saao09hhTgOdNIZA0sgDxuZDIMjtWMdBMCHqEJAKcWXbX2Lw+Py2xUk2tdJ0nfW5sia1hIJMyggoLky09Awg3DPxcieg=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB5274.jpnprd01.prod.outlook.com (2603:1096:404:d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 10:47:40 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b0dd:ed1e:5cfc:f408]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b0dd:ed1e:5cfc:f408%3]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 10:47:40 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/3] dmaengine: rcar-dmac: Add support for R-Car S4-8
Thread-Topic: [PATCH 2/3] dmaengine: rcar-dmac: Add support for R-Car S4-8
Thread-Index: AQHX9it3/T9ejSK6aUednmQ2PJTQdKw+POEAgAAJUzCAAAWwAIAACgpQ
Date:   Wed, 22 Dec 2021 10:47:39 +0000
Message-ID: <TY2PR01MB3692BE2A52CD78581D5F5249D87D9@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20211221052722.597407-1-yoshihiro.shimoda.uh@renesas.com>
 <20211221052722.597407-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdX81Ed-U_DSTKtv074qAq0yB0DJA4YnF9XS1YfEi2zW=g@mail.gmail.com>
 <TY2PR01MB3692659BC6251EED054C326BD87D9@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <CAMuHMdVb3gfsNLO4tB8nh9sWeHYJZdxd3aZGRHxSEPZGE+Qi8Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVb3gfsNLO4tB8nh9sWeHYJZdxd3aZGRHxSEPZGE+Qi8Q@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 506e8491-8cc5-44d5-8e3b-08d9c53879af
x-ms-traffictypediagnostic: TY2PR01MB5274:EE_
x-microsoft-antispam-prvs: <TY2PR01MB5274F211ED96274D7B46AF0ED87D9@TY2PR01MB5274.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:519;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AATk3HHnqsWlbekpxVy5h7kqZUxgLMjocbgsbtO8t4BNWfuBrqoYQhe6Xk7dytXM/skLobUPCnO1YHyMq1Y7O/0dzoT5K9Q/ZtgXl214LdNFpJrfagTOVOKZaQv+7KcaEfRTu08FEYFtXAeYq7C1MLv4dW4cSNsSshcp9QbI3NFjLSZ8CUYM2POM+FCPSeHKCGBW/Oy39jIwnXRVrI4UkpPo8vlfudjiN0Ll3wR910nREtGJacwmVk36mmxLOVbkjyV0dLAeWEQsqP0wasQQ7IUckhLAkAb+/tuBT6SLAzeSP214SNG5OhsDgi/fRdvuWoLvz0JUSCiWqWWgxbx4yVhhcs+2kWWJSLrNmk3jOF3dXUgywgyPQK3nq5oarJf/fK8fTsufQQka8NOP3c1/IGJBgUW0T3Xs9MgEEulTA3sjwdy7XnWii7zwQHVWj1/k1zHMRf4DOUmuj29rRNscPbC+kIgUYyorbDo9f7XOFcMZHsdUhkEOSGEuX1KIB+isaZNvW58VW7lGwYzgc7Sc9KN1FJ6SDdFC1Wcv3Wh7/ndP8oOLgTiXbBR9C3RHanX3p+YsrZmE+uVrG1sXoBOvFbR5UBadL2WGk9POf/2fNK/04gVI+8CsBSIFSxZiS0r9jxl1qU8bbMO8inRV/HNU8ytt2hkO0icIWG0ORuEeWtGEkvRVfPbDK3rgJI8E4PwxxhH55AL8mlHI7iibe0Rk/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(7696005)(6506007)(6916009)(33656002)(4326008)(71200400001)(54906003)(316002)(122000001)(38070700005)(38100700002)(5660300002)(86362001)(66446008)(8676002)(9686003)(186003)(76116006)(64756008)(66556008)(66476007)(55016003)(66946007)(4744005)(52536014)(508600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SytVekhmMjFjdlhVaHM4MmdzR3gwdlZEeWlYRG9pZkRJR0NTVFE0YVd0R1k1?=
 =?utf-8?B?YjZXbTNhR0VDYkNJNUljdzZOaHkvMTJUR2NFTnlhN0FYUmZxdGtld0RTRVpa?=
 =?utf-8?B?d1NoVENwcjRCOFJkZlFLQTd2dGVtTmRzSGxRWXhRa3dNSGRML0JkN0tEd0My?=
 =?utf-8?B?bTk1V0ZrZlNlU2YwU28zbUM4THllK2FEUkVVWm9BYWtvRVVFRCtpd1hUUXN4?=
 =?utf-8?B?WVVnbE82eEpoc3pZOTRBY05ZL3JraTU4bitTeWE3SE4xZWk1UW0wRlFCcUEx?=
 =?utf-8?B?ODJVQVJwVXA4V1Bvcm05Nk1XRXhCc1pXUU9EaEtJM2VtUnkwcHRzSFdOMHpX?=
 =?utf-8?B?ZndEejNBSWxsRFhQU0NRbHdrMmEzc0pRZHordURZSm8weUI0cml6dGxIelZ3?=
 =?utf-8?B?bndSdmxtU05qN0xsSjFBaXA0VmxxbkQvbXJjYnh1bG9sbWU4VDVydXVrTVZo?=
 =?utf-8?B?VWpjbVVYSXpNT0l6TjRRTWRKMzRJRFk3QUhWaGNWSlF0UWc5RFE1WGxRSTNB?=
 =?utf-8?B?TEtzSXY1aDBwcWFXVVdHTitseVRTd2VybjJGdWQ2UnNTalB4c014d3BHam9O?=
 =?utf-8?B?eHhDYU5mUHlCVDVaZ0MwMFprNGkwaG5PQm1WRHU2WlBickljZnJmZVBQWXFo?=
 =?utf-8?B?QXEvSjNldVJ3QjNPSFJNZC9zZFR5OCt3eTJZdmpMSXNlUUd2c0x1TEViQXZh?=
 =?utf-8?B?dTQzWU8xRnM1M3V4OUFOS1ZXNWdJcFhOb2VUci9yUENXUWtYQ3RqNGhpWkxi?=
 =?utf-8?B?eUNyWTZPNkJMNW9NcmtqNkxhYVVLSFU5aGNoN1lJUUt2ZlJvdWF0ajYxeU9S?=
 =?utf-8?B?aGF6dEliY3lab1VNdXRBaVNvbUp0VEExVnZBUW41NDdxUlU5OVZLUnZRb0lp?=
 =?utf-8?B?YjROdHQ3R3B5bTYvdWlGU1BQWGR0dHZUVHpFZ1JnVUVZR0lEOFNpTlpKYlNT?=
 =?utf-8?B?Z2srRENKckk1Q0FtekN4cmpZdjhwZDduUkZudmtWbkZwcU54cDNrMTVaSEMr?=
 =?utf-8?B?TlJLRFVBNzYzZ3FqTVZNY3JZMTlMRVlmWnhKUTF1NEc1enFadGxPeWN1bDBT?=
 =?utf-8?B?TS9zODNsRm00SXZ3Q1ljZnh6aWhSMk5Bemp4RjljczBSbGpGMzU5bkFTbE9C?=
 =?utf-8?B?UVpBOFM3L1J6OGJDbVhmaTJRU0pUN2FGVWFuTDJuQUIwWm9BRjdPa1dSbkFk?=
 =?utf-8?B?NlBVbzV0RkNaUHFuV1BLSUpmZXlyTXJDL0R2QTU4NHQrQlpiUllicnQ5WXI2?=
 =?utf-8?B?a0ZZL1c3b0NZaWpOd3JLcEtNUHFGZ20xMkVOUlhOUXNxbTY4T0I0dC84dWU5?=
 =?utf-8?B?Qy9lWWtXcXdRK0l3OEZ0VVBFY1VudTZ3b1c4bFN3bEhOWFkwbmp5ejVoNWJj?=
 =?utf-8?B?YW5MU1NQdm9CVVNxZnd0KzJIYjBKOHJlU2FYUHBmSkVjM2s3S0xMVUlIMFJq?=
 =?utf-8?B?RmxaUHVkWjRVaWt3REduQ2JuNlZPUDh0Z2JidkR1TFljME5oeTJYTk9OdnBa?=
 =?utf-8?B?THN3Z3dFM1NCTTZhNysyUElmUWI4bzdxR3BxdzgrcHllTk5VMmwzd1hDU2JD?=
 =?utf-8?B?QUdIdnhpVlZ5c2xHZzVOaTN2VmNvUndsVE5ad3Y1WUI2aDdmaGR4Y1NoSlRD?=
 =?utf-8?B?aXBqeStYdElHc1NoeFkzSGQwOEJ3ZGJZS2FOV3RvWXVWOGN0NDZ1QVBHNmhN?=
 =?utf-8?B?MmtTSkdKTGlZVHAwQzZ5WkRrVDhTZFBTcSsxeW5zMXFubk5ydExsbUZnRkdp?=
 =?utf-8?B?OG5zWVNTOTM4cUFjek1PU2oxVEhsVk50RWRrenNPcGUzM1JYUFdSUmcyVk9i?=
 =?utf-8?B?M1ozTmprakJyK1BpZS9MM00xTzRKY1hvWXZacStiQXRSSTFtSzJsbWJuTHBx?=
 =?utf-8?B?NTVrT2dhdUNXZy96d3NrV2Vvc3N0MllmRW82SElNTUQ4QXZNT1hkbVlkN0lE?=
 =?utf-8?B?NUtoNWwxS1Z0QUgvOUxYVXNZQ2oyVVFwcGNCbjBDd2I2cXFseXkwUUwrTVBY?=
 =?utf-8?B?aTZ6K1ZFQUxWdjhEM1p6NWdxaWZrb01SOTQrTEdRQVArajBxdXI0QjhLTHdS?=
 =?utf-8?B?TUp0ZmRKVDJMdmhqN1dRUkVaY2lrUkY2TkNzR2FPZzRxVlZTWEcrMVVPbEE4?=
 =?utf-8?B?MTcvK29GeW9Veis4M3ZXQmEya3dTeVQzZklKajJGT2FaMjBXd3pDTDZMQ3l2?=
 =?utf-8?B?aDF0Y0NWZkFmZ2NwTHl6NStzK1ZkTFFOZUlpc203VHNtaldlZnpYN1JaUHhB?=
 =?utf-8?B?Slh3Sy84NTdVbmNFTjIybGwwSTd6aC9JL3I2U09QeU4yRllSeG9BcTFSWHI5?=
 =?utf-8?B?QzBiTjZVNC9ObndoYXFvdVZqSWZOcml6c1Y1MitnWG9ycEwvR0FXeGlhMUVK?=
 =?utf-8?Q?ZJm3lz2i/ROvKc+asvq9W6NkT0sWtSc+kcIsX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506e8491-8cc5-44d5-8e3b-08d9c53879af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2021 10:47:39.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQxZK/6aVwPOollMSmna3FZVG1piRUQTTHM5ainM9S3ODfDoXc057zKcK2bRya7F1lLLio8D9FCNOj43HnLCeK/we2gKhgpairkUlj9p7FkoFwxZLWdkFpyzh8mhibcK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5274
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVz
ZGF5LCBEZWNlbWJlciAyMiwgMjAyMSA3OjEwIFBNDQo8c25pcD4NCj4gPiBZb3UncmUgY29ycmVj
dC4gU28sIEknbGwgbW9kaWZ5IHRoZSBmb2xsb3dpbmcgY29kZToNCj4gPg0KPiA+IC0jZGVmaW5l
IFJDQVJfRE1BQ0hDTFIgICAgICAgICAgICAgICAgICAgMHgwMDgwICAvKiBOb3Qgb24gUi1DYXIg
VjNVICovDQo+ID4gKyNkZWZpbmUgUkNBUl9ETUFDSENMUiAgICAgICAgICAgICAgICAgICAweDAw
ODAgIC8qIE5vdCBvbiBSLUNhciBHZW40ICovDQo+ID4gKHNvcnJ5IHRoZXNlIHRhYnMgYXJlIHJl
cGxhY2VkIGFzIHNwYWNlcykNCj4gPg0KPiA+IEFsc28sIEknbGwgYWRkIHN1Y2ggaW5mb3JtYXRp
b24gaW4gdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBsaWtlIGJlbG93Lg0KPiA+IC0tLS0tDQo+ID4g
QWRkIHN1cHBvcnQgZm9yIFItQ2FyIFM0LTguIFdlIGNhbiByZXVzZSBSLUNhciBWM1UgY29kZSBz
byB0aGF0DQo+ID4gcmVuYW1lcyB2YXJpYWJsZSBuYW1lcyBhcyAiZ2VuNCIuDQo+ID4NCj4gPiBO
b3RlIHRoYXQgc29tZSByZWdpc3RlcnMgb2YgUi1DYXIgVjNVIGRvIG5vdCBleGlzdCBvbiBSLUNh
ciBTNC04LCBidXQNCj4gPiBub25lIG9mIHRoZW0gYXJlIHVzZWQgYnkgdGhlIGRyaXZlciBmb3Ig
bm93Lg0KPiA+IC0tLS0tDQo+ID4NCj4gPiBBcmUgdGhleSBhY2NlcHRhYmxlPw0KPiANCj4gUGVy
ZmVjdCEgVGhhbmtzIQ0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkhIEknbGwgZml4IGl0IG9u
IHYyLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo=
