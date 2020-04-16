Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4F31ABAE0
	for <lists+dmaengine@lfdr.de>; Thu, 16 Apr 2020 10:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440768AbgDPINd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Apr 2020 04:13:33 -0400
Received: from mail-eopbgr1400117.outbound.protection.outlook.com ([40.107.140.117]:14353
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440433AbgDPINK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 16 Apr 2020 04:13:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZWFQt+yumk0kCPy0Gn6K6MfAWceSz23G3Uem+sa64f8M/AGEWOGG+BzIYfkb2Kv7E678V6Wm8ex1ng4hnBmLNJM9og/BHQJfK7+oZtQW+ahsnP1CGw7pJBUKRNRo/TcnrycSTNt7S8yLtyjJyTV0yPKsmhNZktvZY3YLtAKIGq0QsgUUuclrW/hgATw5agql+5t+N1IGbvb+qmrFu3lqI6Q+tZLFGxrN704LjUHy0AjpCTMXhfygZbzCtZVmNzDOJTUXAxKcYIns+ad4ZzwrJlARHKbwyBtQ2EHG7fsQy7qSDbPHuGQ0p8JB+gC6EG6v5WHQ+2WcliuxI0IOunfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz5uinTdjVCVp0YrzopkP+oDJKTb2K89yvlM6ohUyDw=;
 b=c7OcFAfAOfAmcwzg0QqjvVYShTHeDi+X8Fty/QJK+g+4wRf/AfBCCnhJ+xph9/ZmiTwPSOe1cBy5IBX0v6nKAe9i4GTgCntYn3gsIa/16A3KUrYen/GxlEej4+SfKawL4UPbImhMK1tA0WslGvUtUsrds8znjRPW0yg3eZ91CB/jE1mDIXzscf1u05Oipbela3IlN8LGKQPe9YoGtCg+/ozrGbiwqGoROG8cJzeqDAkc3qKroYgjLip1PmnLf3pE//jKd/ddRUvReaEmW4ule8lQYW7ppTluqAhqEHafM9ff35TjLiIIOCQSWG0YDmeFeZwXMBiTFG8tvL7+GuNoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz5uinTdjVCVp0YrzopkP+oDJKTb2K89yvlM6ohUyDw=;
 b=sLWJGOSK4Qb53B77CJnNbkTN/Jq7IizsucjUsPHCyJbDSU7NWamRnqbxs3olzD+aJKRiYZwIU2+6PlWl8O/nByg5z7WFhr2sYaOusgFoYRCil18nyW15tp/Lpwc4tq4EiOTnrNwfKs3OQKdthIzQUsQMeNcmQy2Opgocr2OkVjo=
Received: from OSAPR01MB4529.jpnprd01.prod.outlook.com (20.179.176.20) by
 OSAPR01MB1907.jpnprd01.prod.outlook.com (52.134.236.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.25; Thu, 16 Apr 2020 08:13:03 +0000
Received: from OSAPR01MB4529.jpnprd01.prod.outlook.com
 ([fe80::3056:e118:8a8e:b3ad]) by OSAPR01MB4529.jpnprd01.prod.outlook.com
 ([fe80::3056:e118:8a8e:b3ad%7]) with mapi id 15.20.2878.023; Thu, 16 Apr 2020
 08:13:03 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: dma: renesas,usb-dmac: convert bindings
 to json-schema
Thread-Topic: [PATCH 2/2] dt-bindings: dma: renesas,usb-dmac: convert bindings
 to json-schema
Thread-Index: AQHWDx8gtNeFxgyfAE26KaVsY8FTY6h6POmAgADJxGCAAGI2AIAABivg
Date:   Thu, 16 Apr 2020 08:13:02 +0000
Message-ID: <OSAPR01MB45292EC62BA96BC551EAB0CFD8D80@OSAPR01MB4529.jpnprd01.prod.outlook.com>
References: <1586512923-21739-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1586512923-21739-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWziQYKFeZZt7ZOCYMEWxD8e3mjqf+x0xsAcA7XDzZHWQ@mail.gmail.com>
 <OSAPR01MB452933886B2C83A6E054AE50D8D80@OSAPR01MB4529.jpnprd01.prod.outlook.com>
 <CAMuHMdXauwb2zwxUSPw_d-wZiOAfuo939r+TWYFVDjqmpbg_2A@mail.gmail.com>
In-Reply-To: <CAMuHMdXauwb2zwxUSPw_d-wZiOAfuo939r+TWYFVDjqmpbg_2A@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f221d2b9-8b69-4c89-a89a-08d7e1ddfc58
x-ms-traffictypediagnostic: OSAPR01MB1907:
x-microsoft-antispam-prvs: <OSAPR01MB1907C02C1F6CFB467C1DD630D8D80@OSAPR01MB1907.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4529.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(7696005)(55016002)(8676002)(9686003)(76116006)(8936002)(33656002)(81156014)(6916009)(64756008)(66446008)(66946007)(66476007)(86362001)(66556008)(4326008)(186003)(54906003)(478600001)(5660300002)(316002)(71200400001)(6506007)(52536014)(55236004)(26005)(53546011)(2906002)(142933001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2NrOxlAjW4rBR3KXUsM95l/Uq94jDfeIoakcDD1/YekGAsQHITcrHw/bReYtLIQMeNxLaxjI9hn6B52Pyo8TK2rn+858WixWpsdl9FMsMeEgDNfnytWn5tAwRZSNSZ6vQoKsCdLwdQzBsBp7LFlWSKlv7P21L8KTeCSJf/7/1EFXSGtLWZw0lYgKd8AyZtBggApK86SqTeMOThe+m5EhjfFgyVEf4Y3auI99wC8y3+Oz/pxd67qepGpsoAn4k8MmH64W52Np0LgycYRtTavkQkIXiZ/ZbllS7AVxEDR6TKL0ceZ2NodQYkYTFthvNA4S8a4x5rvKv+xrb//osliAsEkBPlSTtHzduiBGgqQ9Gpvjqfd3l2ge/Qj+xN3mXuDVCeK8pprS6/bvmkJXB7+hkOWOf7RBJ2vNevusVeFUkyiP78+DH8tVnRJh4LNWaRw2OQYpKYbIWTj2RiF5Hp0A0vMy0mrs1hF56dydSxMIrVOIJHE6HJojqt72GwwZVKTf
x-ms-exchange-antispam-messagedata: KbGy5Dlnf7CUUScPkd+sg7k2MPzhbiJoIZSANQSagI2qQ1Ivo/u2PT2NFhZ5SQhzSwIjDyonFrxIgk6v+TejdYNhQYy/oiEwzddiqgViOGrFw1JlSZIquAl+w8nHOxeOfeWelCCr97cKchHcUDMwTw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f221d2b9-8b69-4c89-a89a-08d7e1ddfc58
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 08:13:03.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFvMH9RRJ4zST7iTb8WNL04cEKTdqLynRIAOUb24eD9JZcnr6mPukjvsoMU5bbMl2SA4n4p3zsFgR+VRpG2CywEm1VmWrikl7caQ8R3eqHPwLAX17rhKFtnOxaIiUOqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1907
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVGh1cnNk
YXksIEFwcmlsIDE2LCAyMDIwIDQ6NTAgUE0NCj4gDQo+IEhpIFNoaW1vZGEtc2FuLA0KPiANCj4g
T24gVGh1LCBBcHIgMTYsIDIwMjAgYXQgNDowNCBBTSBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA8eW9z
aGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuLCBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE1LCAyMDIwIDEwOjU2IFBNDQo+
ID4gPHNuaXA+DQo+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9yZW5lc2FzLHVzYi1kbWFjLnlhbWwNCj4gPiA+
ID4gKyAgaW50ZXJydXB0czoNCj4gPiA+ID4gKyAgICBtYXhJdGVtczogMg0KPiA+ID4NCj4gPiA+
IElzIHRoZXJlIGEgdXNlIGNhc2UgZm9yIHNwZWNpZnlpbmcgYSBzaW5nbGUgaW50ZXJydXB0Pw0K
PiA+DQo+ID4gTm8uIEFsbCBVU0ItRE1BQyBvZiBSLUNhciBHZW4yLzMgYW5kIFJaL0duIGhhcyAy
IGNoYW5uZWxzLg0KPiA+IEluIGNhc2Ugb2YgUi1DYXIgR2VuMywgcGxlYXNlIHJlZmVyIHRvIHRo
ZSBGaWd1cmUgNzUuMSBVU0ItRE1BQyBCbG9jayBEaWFncmFtLg0KPiA+IFRoZXNlIFVTQi1ETUFD
biBoYXZlIENIMCBhbmQgQ0gxDQo+IA0KPiBUaGFua3MgZm9yIGNvbmZpcm1pbmchDQo+IA0KPiA+
ID4gPiArICBkbWEtY2hhbm5lbHM6DQo+ID4gPiA+ICsgICAgbWF4aW11bTogMg0KPiA+ID4NCj4g
PiA+IElzIHRoZXJlIGEgdXNlIGNhc2UgZm9yIHNwZWNpZnlpbmcgYSBzaW5nbGUgY2hhbm5lbD8N
Cj4gPiA+DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgaW9tbXVzOg0KPiA+ID4gPiArICAgIG1heEl0
ZW1zOiAyDQo+ID4gPg0KPiA+ID4gTGlrZXdpc2U/DQo+ID4NCj4gPiBBcyBJIG1lbnRpb25lZCBh
Ym92ZSwgdGhlcmUgaXMgbm90IGEgdXNlIGNhc2UgZm9yIHNwZWNpZnlpbmcgYSBzaW5nbGUgY2hh
bm5lbC4NCj4gDQo+IEhlbmNlIEkgdGhpbmsgYWxsIG9mIHRoZXNlIHNob3VsZCBoYXZlICJjb25z
dDogMiIgb3IgIm1pbkl0ZW1zOiAyIi4NCg0KVGhhbmsgeW91IGZvciB0aGUgcHJvcG9zYWwuIEkg
Z290IGl0LiBJJ2xsIGZpeCBpdC4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGEN
Cg0K
