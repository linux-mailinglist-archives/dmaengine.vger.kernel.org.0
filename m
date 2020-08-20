Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72324C123
	for <lists+dmaengine@lfdr.de>; Thu, 20 Aug 2020 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHTPBu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Aug 2020 11:01:50 -0400
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:6373
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726854AbgHTPBs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 20 Aug 2020 11:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdJbIaLUaF4Px5EIuDiBNGYFK3rRY7jNYbn0IjivJt5FaM1S+P78WfxK2NZFzppeY3KlYw1dYt42pahNMwgmYslfTR01ZKAkG3lyR2Rica5fw4+ib/H7k1CaHaqLiyZEa5nxnYqp9YhvtlNsN5jmt0kZsZbusPEGEq0JFoO7YckaEAz9BPAEIcM4E3ihURDrIomS6VnK9AktqIhDlPqaNLpSlWp3Ss9mUld3+w5s6i2SI0lB5/fhENncs50l+iuDrWntXEDEbI/AOZb3dC24SavL649sQHNG+rmNMsZpo2e3Xjb2pqICMwEHZcjL8e0NKsTZFxFO7zrQdUAkQCavIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdhWFIYBIyHxtfv2TMR9UO8e2r+fwkCZHmqScpn0P4k=;
 b=iaqpXwDmZM4lvMSpdVs0WaFLQye1WoVNmeMydZBJOOIOVnyHlWTN5yMDkI9TYlap10hSKAvL2u+eTjTNevHkQ7jc5CAr2VxNec34Ua15FSo0zMOC7PYLSq/EmdIlYdSx88tAZsI3KKi+5GjUzEi6xW67PrItE30wglNczs1/kVnjJp65XF+t7r2pGrTAveKrLgTtzbk09jWhyIfUxXOOI76z9QB8e+eE6XcSM1nn6z8SzeWGcIT3nLVchghyylFFy8F6a0MEs3Ga3CFBahCLConc6C1mivuyiA437q01kTf8E3KDcdH4YCDbL/LFlYMM5B9zbhhh3Axm3MVMOifBNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdhWFIYBIyHxtfv2TMR9UO8e2r+fwkCZHmqScpn0P4k=;
 b=o1gmSDr81CAlGPvweZ4/WB947sXwrmPsvOZ0NbY2IYkFJaN4msV2+Rc/rE2Rcb60pSWKZFqZFaTYzDwpuLG3bG11bE4fD8jLMney+rKFxxas3Z7IHvB1TvFqYZyW9/otrOFEqZGw8mzhcqXYI3CXSWNCgoVJMjArG8UAfs74pak=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB7343.eurprd04.prod.outlook.com (2603:10a6:800:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 15:01:45 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 15:01:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Benjamin Bara - SKIDATA <Benjamin.Bara@skidata.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "timur@kernel.org" <timur@kernel.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Richard Leitner - SKIDATA <Richard.Leitner@skidata.com>
Subject: RE: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Topic: pcm|dmaengine|imx-sdma race condition on i.MX6
Thread-Index: AQHWcWQbD9eqMlwY2U27XyctTVPmVak3Rd/wgASnXICAA2IfgIAANxuAgAFCSvA=
Date:   Thu, 20 Aug 2020 15:01:44 +0000
Message-ID: <VE1PR04MB6638A7AC625B6771F9A69F0D895A0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20200813112258.GA327172@pcleri>
 <VE1PR04MB6638EE5BDBE2C65FF50B7DB889400@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <61498763c60e488a825e8dd270732b62@skidata.com>
 <16942794-1e03-6da0-b8e5-c82332a217a5@metafoo.de>
 <6b5799a567d14cfb9ce34d278a33017d@skidata.com>
In-Reply-To: <6b5799a567d14cfb9ce34d278a33017d@skidata.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: skidata.com; dkim=none (message not signed)
 header.d=none;skidata.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.235.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bb7857f-79f5-415d-0f11-08d84519f497
x-ms-traffictypediagnostic: VE1PR04MB7343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7343600441659F288374C4E3895A0@VE1PR04MB7343.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5fVH0mbJ4+YPV7nk5Ad73lzNocbaTtDPhFYWGfloZIU1/eDQnOP3rKfOAow6gP022gvTHBmXtyx3AfkWhYinf8XafLd0NgDqd1ClGDHI42TMtUqeasoRczTJgyPWQeoFtp2Ps8ZKB3GZXON13icmClqBb02wzZcL+TFUlaN5nCWMuW0a6qtO4JzMHrNGpTO64NC74iSG0KGF810TcHOqba6lk4UUExDC6m4qPLgwLU7SMbIzXwhSeGTpJd+4bqznFQoVkX/u/ewNn6Ra4iZycugPp/pGxtRudognDE7epO1hqUgprEcOp/2T0ejmCjwpwTG29qL4zdEhAnNJy/6dg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(478600001)(55016002)(8676002)(9686003)(86362001)(64756008)(66556008)(66476007)(66946007)(8936002)(76116006)(4326008)(52536014)(2906002)(33656002)(66446008)(7416002)(5660300002)(316002)(53546011)(26005)(7696005)(83380400001)(71200400001)(110136005)(54906003)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WqUbWRixlKXxaEeSIoGUFMksPU7BnuSLboUMH4jXhWkuuLzZkMC4Y4Wasewf9WQLqfTXtkkDC69IRrmbHAFMOZgKCAjjQd0nz8HYwyrM/d3CVOeZi27ufrHvFlLq9XVK4OSw6rO2fPBfsdGt7wp21fKBczfTkcgd23pSjIKqxxbXzLgFv8fxy2SQmfZpVuzOGiF2kcL+Ti1AD7hKFsib115EhDoz9cPqFJi5SaWFzHl+9pjW+1GxgWcyR5I1ksRiuWTEgVQ9WWR6FCJCA3JRUA0kWRP/4zsoKILcGJ87p0achI0ynWNPfXlF5O4Xpx2zGYeEM9JCtst5C+98O9XjFN92kIXBaGcJ2nGD/IClun9coR91qZzGlYVYYJjOP3iMfh631v7ZQ88KlZJNEqyqxwzihzFzqzrDNEf/ZuYi4vBNMEKLQpe5ced13mscH/Aewg7ffq0kPuH6D68OcIr59iPH2UNaKY3DyvuHW+oWPTLCbajDEnH79mXxC6Tq74P7SATYLLYzw2WgtlfmzDhkB/y88UXeWrNNvK1i1yDSrwvYXJZsidHeKGEJxVx+vjepv4nDAvFqAOH/0uuV0CrjxP6f3AjyUG5cc2unQ8fntKCgE0t+PpzCaXohTYcoWOzuw3anfJF2fkSxQug7ofYMpw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb7857f-79f5-415d-0f11-08d84519f497
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 15:01:45.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/V6b/ZenbtPqZ0nkdpYJOnq/J3lrrAql8UiXdyrKTppGIbd9i0O0/KYAnnWyiGjMa4AGF71jIXY1PEPLru4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7343
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gMjAyMC8wOC8xOSAyMjoyNiBCZW5qYW1pbiBCYXJhIC0gU0tJREFUQSA8QmVuamFtaW4uQmFy
YUBza2lkYXRhLmNvbT4gd3JvdGU6IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gRnJvbTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gU2VudDog
TWl0dHdvY2gsIDE5LiBBdWd1c3QgMjAyMCAxMzowOA0KPiA+IEkgdGhpbmsgdGhpcyBtaWdodCBi
ZSBhbiBzZG1hIHNwZWNpZmljIHByb2JsZW0gYWZ0ZXIgYWxsLg0KPiA+IGRtYWVuZ2luZV90ZXJt
aW5hdGVfYXN5bmMoKSB3aWxsIGlzc3VlIGEgcmVxdWVzdCB0byBzdG9wIHRoZSBETUEuIEJ1dA0K
PiA+IGl0IGlzIHN0aWxsIHNhZmUgdG8gaXNzdWUgdGhlIG5leHQgdHJhbnNmZXIsIGV2ZW4gd2l0
aG91dCBjYWxsaW5nDQo+ID4gZG1hZW5naW5lX3N5bmNocm9uaXplKCkuIFRoZSBETUEgc2hvdWxk
IHN0YXJ0IHRoZSBuZXcgdHJhbnNmZXIgYXQgaXRzDQo+ID4gZWFybGllc3QgY29udmVuaWVuY2Ug
aW4gdGhhdCBjYXNlLg0KPiA+DQo+ID4gZG1hZWdpbmVfc3luY2hyb25pemUoKSBpcyBzbyB0aGF0
IHRoZSBjb25zdW1lciBoYXMgYSBndWFyYW50ZWUgdGhhdA0KPiA+IHRoZSBETUEgaXMgZmluaXNo
ZWQgdXNpbmcgdGhlIHJlc291cmNlcyAoZS5nLiB0aGUgbWVtb3J5IGJ1ZmZlcnMpDQo+ID4gYXNz
b2NpYXRlZCB3aXRoIHRoZSBETUEgdHJhbnNmZXIgc28gaXQgY2FuIHNhZmVseSBmcmVlIHRoZW0u
DQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9ucyENCj4gDQo+ID4gSSBkb24n
dCBrbm93IGhvdyBmZWFzaWJsZSB0aGlzIGlzIHRvIGltcGxlbWVudCBpbiB0aGUgU0RNQSBkbWFl
bmdpbmUNCj4gPiBkcml2ZXIuIEJ1dCBJIHRoaW5rIHdoYXQgaXMgc2hvdWxkIGRvIGlzIHRvIGhh
dmUgc29tZSBmbGFnIHRvIGluZGljYXRlDQo+ID4gaWYgYSB0ZXJtaW5hdGUgaXMgaW4gcHJvZ3Jl
c3MuIElmIGEgbmV3IHRyYW5zZmVyIGlzIGlzc3VlZCB3aGlsZQ0KPiA+IHRlcm1pbmF0ZSBpcyBp
biBwcm9ncmVzcyB0aGUgdHJhbnNmZXIgc2hvdWxkIGdvIG9uIGEgbGlzdC4gT25jZQ0KPiA+IHRl
cm1pbmF0ZSBmaW5pc2hlcyBpdCBzaG91bGQgY2hlY2sgdGhlIGxpc3QgYW5kIHN0YXJ0IHRoZSB0
cmFuc2ZlciBpZg0KPiA+IHRoZXJlIGFyZSBhbnkgb24gdGhlIGxpc3QuDQo+IA0KPiBJTUhPIHRo
YXQncyBuZWFybHkgd2hhdCBSb2JpbidzIHBhdGNoZXMgZG9lcywgc28gdGhpcyBzaG91bGQgYmUg
c3VmZmljaWVudDoNCj4gUHV0dGluZyB0aGUgZGVzY3JpcHRvcnMgdG8gZnJlZSBpbiBhbiBleHRy
YSB0ZXJtaW5hdGlvbiBsaXN0IGFuZCBlbnN1cmluZyB0aGF0IGENCj4gbmV3IHRyYW5zZmVyIGlz
IGhhbmRsZWQgYWZ0ZXIgdGhlIGxhc3QgdGVybWluYXRpb24gaXMgZG9uZS4NCkhlbGxvIEJlbmph
bWluLCANCiAgSXQgc2VlbXMgTGFycydzIGxpc3QgaXMgbm90IHRoZSBleHRyYSB0ZXJtaW5hdGlv
biBsaXN0IGluIG15IHBhdGNoLg0KSW5zdGVhZCwgaGUgbWVhbnMgdGhlIG5leHQgZGVzY3JpcHRv
ciBzaG91bGQgYmUgbW92ZWQgaW4gYW5vdGhlciBwZW5kaW5nIGxpc3QNCmlmIHRoZSBsYXN0IGNo
YW5uZWwgdGVybWluYXRlZCBub3QgZG9uZSB5ZXQgYW5kIHJlc3RhcnQgdG8gaGFuZGxlIHRoZSBw
ZW5kaW5nIGxpc3QNCmFmdGVyIHRoZSBsYXN0IGNoYW5uZWwgdGVybWluYXRlZCBkb25lIGlmIHRo
ZSBsaXN0IGlzIG5vdCBlbXB0eS4NCg0KICBJIGxpa2UgdGhlIGlkZWEsIGJ1dCBvbiBTRE1BIHRo
YXQgcmFjZSBjb25kaXRpb24gbWF5IG5ldmVyIGhhcHBlbiBJIHRoaW5rLCBiZWNhdXNlDQp0aGF0
IG9uY2UgdGhlIG5leHQgZGVzY3JpcHRvciBnb3QgZHVyaW5nIHVzbGVlcF9yYW5nZSBpbiBzZG1h
X2NoYW5uZWxfdGVybWluYXRlX3dvcmssDQptZWFucyB0aGUgbGFzdCBjaGFubmVsIHN0b3BwZWQg
aW5kZWVkLiBJIGhhdmUgbWVudGlvbmVkIGJlZm9yZToNCicgYmVjYXVzZSBsb2FkIGNvbnRleHQo
c2RtYV9sb2FkX2NvbnRleHQpIGRvbmUgYnkgY2hhbm5lbDAgd2hpY2ggaXMgdGhlDQogbG93ZXN0
IHByaW9yaXR5LiBJbiBvdGhlciB3b3JkcywgY2FsbGluZyBzdWNjZXNzZnVsbHkgZG1hZW5naW5l
X3ByZXBfKiBpbiB0aGUNCiBuZXh0IHRyYW5zZmVyIG1lYW5zIG5ldyBub3JtYWwgdHJhbnNmZXIg
d2l0aG91dCBhbnkgbGFzdCB0ZXJtaW5hdGVkIHRyYW5zZmVyIGltcGFjdCAnDQpub3JtYWwgZGF0
YSB0cmFuc2ZlciBvbiBkbWEgbm9uLWNoYW5uZWwwLCBzdWNoIGFzIGNoYW5uZWwxLDIuLi5ldGMg
d2hpY2ggaGFzIGhpZ2hlcg0KcHJpb3JpdHkgdGhhbiBjaGFubmVsMCwgc28gaWYgY2hhbm5lbDAg
Z2V0IHRvIHJ1biB0byBsb2FkIGNvbnRleHQgbWVhbnMgdGhlICdwb3RlbnRpYWwgdHJhbnNmZXIn
IG9uIHRoZSBsYXN0IHRlcm1pbmF0ZWQgY2hhbm5lbCBoYXZlIGJlZW4gZG9uZS4gU28gbm8gbmVl
ZCB0byBtb3ZlIGxpc3Qgc2luY2UNCml0J3Mgbm8gZGlmZmVyZW50IHdpdGggbm9ybWFsIHRyYW5z
ZmVyIGFsdGhvdWdoIHNkbWFfY2hhbm5lbF90ZXJtaW5hdGVfd29yayBtYXkgZ2V0DQp0byBydW4g
bGF0ZXIgdG8gZnJlZSB0aGUgbGFzdCBkZXNjcmlwdG9yKG9ubHkgc29mdHdhcmUgaW1wYWN0IHdo
aWNoIG15IHBhdGNoIGZpeCkuDQogIFRyYW5zZmVyIG9uIHNkbWEgY2hhbm5lbCB3aWxsIGJlIHNw
bGl0IGludG8gbWFueSBzbWFsbCBwaWVjZXMgb2YgdHJhbnNmZXIgDQooV2F0ZXItTWFyay1MZXZl
bCBzaXplKS4gT25jZSBkbWEgcmVxdWVzdCBldmVudCBhY2tub3dsZWRnZWQgYW5kIHNjaGVkdWxl
ZCBieSBzZG1hDQpjb3JlLCB0aGlzIHNkbWEgY2hhbm5lbCB3aWxsIHN0YXJ0IHRvIHRyYW5zZmVy
IFdNTCBzaXplIG9mIGRhdGEgYW5kIHRoZW4gc2NoZWR1bGUgb3V0IHRvDQpvdGhlciBjaGFubmVs
LiBOb3cgdGhlICdwb3RlbnRpYWwgdHJhbnNmZXInIGFsaXZlIG9uIHRlcm1pbmF0ZWQgY2hhbm5l
bCBvbmx5IGhhcHBlbiBpbg0KdGhlIGJlbG93IHR3byB0aGluZ3MgY29tZSBvdXQgaW4gdGhlIHNh
bWUgdGltZToNCiAgIFsxXS5UaGUgY2hhbm5lbCBpcyBydW5uaW5nIHRvIHRyYW5zZmVyIFdhdGVy
LU1hcmstTGV2ZWwgc2l6ZSAoc2RtYSBzaWRlKS4NCiAgIFsyXS5UaGUgY2hhbm5lbCBpcyB0ZXJt
aW5hdGVkIGJ5IHNkbWFfZGlzYWJsZV9jaGFubmVsIGF0IHRoZSBzYW1lIHRpbWUoYXJtIHNpZGUp
Lg0KRXZlbiBpZiBpdCBoYXBwZW4sIHRoZSAncG90ZW50aWFsIHRyYW5zZmVyJyBvbiBzZG1hIGlz
IHZlcnkgc2hvcnQsIGJlY2F1c2UgZmV0Y2hpbmcvZmlsbGluZw0KZmlmbyBpbiBXTUwgc2l6ZShm
aWZvIHNpemUgb3IgaGFsZiBmaWZvIHNpemUpIGlzIHZlcnkgcXVpY2suIEFmdGVyIHRoYXQsIHRo
aXMgY2hhbm5lbCBpcw0KdGVybWluYXRlZCBhdCBIVyBsZXZlbC4gSGVyZSAxbXMgZnJvbSBkZXNp
Z24gdGVhbSBqdXN0IGZvciBiaWcgc2FmZSBJIHRoaW5rLiBTbyBJIGRvbid0DQp0aGluayB0aGF0
J3MgYSBiaWcgZGVhbCBpZiBtZW1vcnkgYnVmZmVyIGlzIGF2YWlsYWJsZSBhbmQgZGVzY3JpcHRv
ciBhcmUgdGFrZW4gY2FyZSB0bw0Kbm8gaW1wYWN0IG9uIHRoZSBuZXh0IHRyYW5zZmVyIGFzIG15
IHBhdGNoIGRpZC4gDQoNCj4gDQo+IA0KPiBAUm9iaW46DQo+IElzIGl0IHBvc3NpYmxlIHRvIHRh
ZyB0aGUgY29tbWl0cyBmb3IgdGhlIHN0YWJsZS10cmVlDQo+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnPw0KQ291bGQgbXkgcGF0Y2ggd29yayBpbiB5b3VyIHNpZGU/IElmIHllcywgSSB3aWxs
IGFkZA0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgDQoNCj4gDQo+IEJlc3QgcmVnYXJkcyBh
bmQgdGhhbmsgeW91IGFsbCENCj4gQmVuamFtaW4NCj4gUmljaGFyZA0KDQo=
