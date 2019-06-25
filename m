Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4852757
	for <lists+dmaengine@lfdr.de>; Tue, 25 Jun 2019 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfFYJAI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Jun 2019 05:00:08 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:64613
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbfFYJAH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Jun 2019 05:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hxsi3zpM+USB1d3CvAQiCHsJAXg2IOOspdzz4okWBMo=;
 b=GD5gFG7V2Io6cXfok0Q+OJtt2RzoxQfnYM1IHToXbzpTpm5sY6R4Yb9JWszfQwZzfQayeaIGhbfCVNip+oVI7Wrz4PQbUqgfHiVAiIi58rZKfcdu/fU2YITZGNRuzxOaNaQR7wBNt4uSnBA3/co8F3UVCL+OOgw4iSHKYdmCGKU=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.235.81) by
 VE1PR04MB6494.eurprd04.prod.outlook.com (20.179.233.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 09:00:03 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::a4a8:729f:e664:fa8%2]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 09:00:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Michael Olbrich <m.olbrich@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] dmaengine: imx-sdma: fix incorrect conversion to
 readl_relaxed_poll_timeout_atomic()
Thread-Topic: [PATCH v2] dmaengine: imx-sdma: fix incorrect conversion to
 readl_relaxed_poll_timeout_atomic()
Thread-Index: AQHVKSwpS9Y9hkdtT06s9y32rUNxhqaoDoyAgAAQxoCAAR3MAIACylig
Date:   Tue, 25 Jun 2019 09:00:03 +0000
Message-ID: <VE1PR04MB663808AF44F01F064C96125089E30@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
 <E1helB3-0005d6-7m@rmk-PC.armlinux.org.uk>
 <20190622192653.puxds354sx5v3jg7@shell.armlinux.org.uk>
 <20190622202655.lwj43wpvw2ylzmcf@shell.armlinux.org.uk>
 <CAOMZO5CdHXXP1X_71SVL4nrV=009xNugPFjbjP8s7NZ3byyP2w@mail.gmail.com>
In-Reply-To: <CAOMZO5CdHXXP1X_71SVL4nrV=009xNugPFjbjP8s7NZ3byyP2w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cfd9d74-40dc-411f-a7b7-08d6f94b82ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6494;
x-ms-traffictypediagnostic: VE1PR04MB6494:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VE1PR04MB6494DD5C61EE6D3AA114A0A589E30@VE1PR04MB6494.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(55016002)(8936002)(478600001)(486006)(446003)(102836004)(9686003)(2906002)(966005)(305945005)(316002)(66066001)(476003)(68736007)(6116002)(86362001)(11346002)(45080400002)(71200400001)(71190400001)(3846002)(7416002)(52536014)(7736002)(6246003)(6436002)(6306002)(53936002)(33656002)(7696005)(256004)(25786009)(14454004)(229853002)(4326008)(74316002)(99286004)(76116006)(186003)(66946007)(73956011)(76176011)(6506007)(66446008)(66476007)(8676002)(53546011)(66556008)(64756008)(81156014)(81166006)(5660300002)(110136005)(26005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6494;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CQZe20Z8u2bGuijUm4zkRXXuyutSyNRmY39fgyZJo2qo17tuwbxX9zm49+f/bZPDMaA+5yXOKlRTnLA2QZGeXBoFHXU0lOdFAUO0K65x/GldecUMCsJvZ9DO8WKTyMMHGGAhR9r918ErcfEIvUIaww7oJMwRSrBblDUUC5CDgt6CpsoKm/AoTDvB5NJGZCyz5av/OqJGJHyZJINel8jUXOlgaHgj4Vz0Z/rqlvMrPACeoLJl3MJJybcriabQLhBgAryLbqpimR0LUI7fXTA0I4pwudzispbIxelq8iz0/4OrzD+QUjNZ5ohVjtRdlvc4q7+Fi0W2O4Yecm/HCHcPlUPXlY7+ktGYBhQbcfa1Yqde/6iycGUx2Mi8MxlmkKRFScVyo6IvFdDoXrL0mNVuXDNc3uIOm5k0R3a+RXtd1mc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfd9d74-40dc-411f-a7b7-08d6f94b82ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 09:00:03.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yibin.gong@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6494
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gU3VuLCBKdW4gMjMsIDIwMTkgYXQgMjE6MzAgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21h
aWwuY29tPiB3cm90ZToNCj4gSGkgUnVzc2VsbCwNCj4gDQo+IE9uIFNhdCwgSnVuIDIyLCAyMDE5
IGF0IDU6MjcgUE0gUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IGFkbWluDQo+IDxsaW51eEBhcm1s
aW51eC5vcmcudWs+IHdyb3RlOg0KPiA+DQo+ID4gT24gU2F0LCBKdW4gMjIsIDIwMTkgYXQgMDg6
MjY6NTNQTSArMDEwMCwgUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4IGFkbWluDQo+IHdyb3RlOg0K
PiA+ID4gV2VsbCwgdGhpcyBkb2Vzbid0IGFwcGVhciB0byBjb21wbGV0ZWx5IHNvbHZlIHRoZSBw
cm9ibGVtIGVpdGhlciAtDQo+ID4gPiBvbmUgb3V0IG9mIGZvdXIgb2YgbXkgcGxhdGZvcm1zIHN0
aWxsIHNwYXQgb3V0IHRoZSBlcnJvciAoYmVjYXVzZQ0KPiA+ID4gdGhlIFNETUEgaW5pdGlhbGlz
YXRpb24gY2FuIHJ1biBvbiBhIGRpZmZlcmVudCBDUFUgdG8gdGhhdCB3aGljaA0KPiA+ID4gcmVj
ZWl2ZXMgdGhlIGludGVycnVwdC4pDQo+ID4gPg0KPiA+ID4gSSd2ZSB0aG91Z2h0IGFib3V0IHVz
aW5nIGEgY29tcGxldGlvbiwgYnV0IHRoYXQgZG9lc24ndCB3b3JrIGVpdGhlciwNCj4gPiA+IGJl
Y2F1c2UgaW4gdGhlIGNhc2Ugb2YgYSBzaW5nbGUgQ1BVLCB0aGUgaW50ZXJydXB0cyB3aWxsIGJl
IG1hc2tlZCwNCj4gPiA+IHNvIHdlIGNhbid0IHdhaXQgZm9yIGNvbXBsZXRpb24uICBJIHRoaW5r
IHdlIG5lZWQgdG8gZWxpbWluYXRlIHRoYXQNCj4gPiA+IHNwaW5sb2NrIGFyb3VuZCB0aGlzIGNv
ZGUuDQo+ID4NCj4gPiBJdCBsb29rcyBsaWtlIGlNWDYgRHVhbCBkb2VzIG5vdCBpbml0aWFsaXNl
IERNQSBwcm9wZXJseSB1c2luZyB0aGUgMS4xDQo+ID4gZmlybXdhcmUgLSBtZDVzdW0gaXM6DQo+
ID4NCj4gPiA1ZDQ1ODQxMzRjYzRjYmE2MmUxYmUyZjM4MmNkNmYzYQ0KPiA+IC9saWIvZmlybXdh
cmUvaW14L3NkbWEvc2RtYS1pbXg2cS5iaW4NCj4gPg0KPiA+IEkndmUgdHJpZWQgZXh0ZW5kaW5n
IHRoZSB0aW1lb3V0IHRvIDVtcywgY2hlY2tpbmcgSElbMF0gKGJvdGggZnJvbSB0aGUNCj4gPiBp
bnRlcnJ1cHQgaGFuZGxlciBhbmQgZnJvbSBzZG1hX3J1bl9jaGFubmVsMCgpIHRvIGNvdmVyIHRo
ZSBjYXNlIG9mIGENCj4gPiBzaW5nbGUtY29yZSBzZXR1cCkuDQo+ID4NCj4gPiBBZnRlciBib290
Og0KPiA+DQo+ID4gIDYwOiAgICAgICAgICAwICAgICAgICAgIDAgICAgICAgR1BDICAgMiBMZXZl
bCAgICAgc2RtYQ0KPiA+DQo+ID4gU28gbm8gaW50ZXJydXB0IHdhcyByZWNlaXZlZC4gIExvb2tp
bmcgYXQgdGhlIHJlZ2lzdGVyczoNCj4gPg0KPiA+ICMgL3NoYXJlZC9iaW4zMi9kZXZtZW0yIDB4
MjBlYzAyYw0KPiA+IFZhbHVlIGF0IGFkZHJlc3MgMHgwMjBlYzAyYzogMHgwMDAwMDAwMCAgPD0g
SF9JTlRSTUFTSyAjDQo+ID4gL3NoYXJlZC9iaW4zMi9kZXZtZW0yIDB4MjBlYzAwNCBWYWx1ZSBh
dCBhZGRyZXNzIDB4MDIwZWMwMDQ6DQo+ID4gMHgwMDAwMDAwMCAgPD0gSF9JTlRSICMgL3NoYXJl
ZC9iaW4zMi9kZXZtZW0yIDB4MjBlYzAwYyBWYWx1ZSBhdA0KPiA+IGFkZHJlc3MgMHgwMjBlYzAw
YzogMHgwMDAwMDAwMCAgPD0gSF9TVEFSVCAjIC9zaGFyZWQvYmluMzIvZGV2bWVtMg0KPiA+IDB4
MjBlYzAwOCBWYWx1ZSBhdCBhZGRyZXNzIDB4MDIwZWMwMDg6IDB4MDAwMDAwMDEgIDw9IEhfU1RB
VFNUT1ANCj4gPg0KPiA+IEFueSBpZGVhcz8NClNlZW1zIHNkbWEgc2NyaXB0IG5vdCBydW4gYXMg
ZXhwZWN0ZWQsIHRodXMgbm8gRE9ORSBpbnN0cnVjdGlvbiBpbnZvbHZlZCB0byBjbGVhcg0KJ0hF
JyBvZiBIX1NUQVRTVE9QIGFuZCBub3RpZnkgQVJNIGJ5IGludGVycnVwdC4gU28gdGhpcyB0aW1l
b3V0IGhhcHBlbmVkIGR1cmluZyB0aGUNCmZpcnN0ICcgc2RtYV9sb2FkX3NjcmlwdCgpJyBwaGFz
ZSA/DQoNCg0KPiBDb3VsZCB5b3UgcGxlYXNlIHRyeSB0aGlzIHBhdGNoIGZyb20gUm9iaW4/DQo+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
JTNBJTJGJTJGbGlzdHMuaW5mcmENCj4gZGVhZC5vcmclMkZwaXBlcm1haWwlMkZsaW51eC1hcm0t
a2VybmVsJTJGMjAxOS1KdW5lJTJGNjYxOTE0Lmh0bWwmYQ0KPiBtcDtkYXRhPTAyJTdDMDElN0N5
aWJpbi5nb25nJTQwbnhwLmNvbSU3QzdmYWExODUxNzYyNjQyOTc4MGQ5MDgNCj4gZDZmN2RlZDNi
NiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY5NjgNCj4g
OTMzNzQ3Njk5ODQzJmFtcDtzZGF0YT1CSWlwb0lnQmM1c01haEprejMzTDV1Y3FldUh3eVlucWcw
OW9ybnBlTEUNCj4gNCUzRCZhbXA7cmVzZXJ2ZWQ9MA0KVGhpcyBzaG91bGQgYmUgdGhlIGRpZmZl
cmVudCBjYXNlLCBzaW5jZSBpbiBSdXNzZWxsIEtpbmcncyBjYXNlLCBubyBhbnkgaW50ZXJydXB0
IHdoaWxlIG15IHBhdGNoDQpmaXggdGhlIHBvdGVudGlhbCBpbnRlcnJ1cHQgc3Rvcm0uDQo+IA0K
PiBUaGFua3MNCg==
