Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5786C3A48EC
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 20:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFKTAo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 15:00:44 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:57696
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229824AbhFKTAn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Jun 2021 15:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7bcRD8Eg7wAO8Q1lRthZC4WkR1IVwdRvnGFUQwWZGMJPVvXBOkrFhtcCEZnDLD4PVC2VT5pb7aniwLijofKOevdxPVtm1i+XQGPsqPSsz/i0cB+l58302c44baM6BHDL74Z3mfBxO4vpr8YepKJdXY/Mk8+MUHWhM1wbivevL0KIBDt060SBfY+x557mqVVkI3cD8+cHtnKP6FU8piuGqSAjhc9hcd11tWVST1f5CVZdISSttrqRxMl030X8orV4xQ59DYnmX1y5WZBZMJhA2qwcB9sDdqxwjgF4KHynftfSgRe8hA4341uNxZ3tcqMUfUFTNqHsZzpBC6vB4fuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E276EkhTdSLtmfAoF+awu1jTBRbo3jXRkMHZ4mWPA8U=;
 b=iXCK7DU70R2xBCQUjGZlSVCvcXwtPVKelpyMuv7mdWIeOLyft8/lBBJ89sQtfex8y0eEJBo1QF/HyM6jhcYsuBIgjTTzzGOF4+YMgLX031q6E9yI15xa79s8Qe2TRMyZPH4eHxTARHlR3KL5yLrzyC4lH/dhoUmOC8VF5cPB4da6es1nMsSLPEoWFN3DPYQL9wknP1FWT7408nK2aYngRzExjDPfNE3XvaH0WoNRkhxCAH4qxL7lqDMM2HRgKb1ZF/hh4UWMtDsxgbyt2RadeWwilJUsghkWKSl+QHAtXIc7qYayWEYuXAS4yy60mSd7c3fUMqJCRfbnNhzIvnWWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E276EkhTdSLtmfAoF+awu1jTBRbo3jXRkMHZ4mWPA8U=;
 b=o/n7AcqzxL7OhTLfiiZyFgsOuVkbbaRKauLaR96C57cBxBw9CLWnbJYHiQ7SL9fRyBJa4y4da3tbg5AN1HcZoteaZq2IWY3QTHmuCWtAsiBWwQtOrM+/TPZxw5OosezVzIypZz+WuBJGUwnnZxR9IM6rD7VnNhBbZSpyFeqUHeo=
Received: from BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8)
 by BY5PR02MB6130.namprd02.prod.outlook.com (2603:10b6:a03:1fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 18:58:41 +0000
Received: from BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798]) by BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798%5]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 18:58:41 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [RFC v2 PATCH 5/7] dmaengine: xilinx_dma: Freeup active list
 based on descriptor completion bit
Thread-Topic: [RFC v2 PATCH 5/7] dmaengine: xilinx_dma: Freeup active list
 based on descriptor completion bit
Thread-Index: AQHXLWnQwGXrB49GLkeWOkZPWQaKgqq1NliAgFpWBTA=
Date:   Fri, 11 Jun 2021 18:58:41 +0000
Message-ID: <BY5PR02MB652069D06D93955A3D45DF49C7349@BY5PR02MB6520.namprd02.prod.outlook.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1617990965-35337-6-git-send-email-radhey.shyam.pandey@xilinx.com>
 <94a2a053-46b6-77be-7c1f-3ece3a0f9af3@metafoo.de>
In-Reply-To: <94a2a053-46b6-77be-7c1f-3ece3a0f9af3@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 884e6c81-8592-476d-a55e-08d92d0aedf6
x-ms-traffictypediagnostic: BY5PR02MB6130:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB61307960A1E4A4553E014A30C7349@BY5PR02MB6130.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x3IQCVivbd0WQX8pcn8Yij+IjmqKGrTPr6V+IfOm4yBmiXB6zl7E0sMdlH3MnFDPMTSVBqq+EpWxO8v/6AzTI4yivxKTNY7Nuuf2t954ZfpaCZQS0drb06UZoKa6dyLfMx80+Yvrka87iAyUA5m7GBw+De/91irayQjcesn05y/XS5L7jIXi0gCfOFGf7f5wuuEqYvp+10oRIkKl/qT6TNT+mpxiFhn220l0HUxujdtfo/0SwrcE5Ol7tRqANrI5aezTDO/6CNbeZ43LR7EkZT9AuKuIW+f1x1NxkHM6/+zRpp5YGjlc/4aZ6rYPUCGtbh9F2Vc6RjPPTP4gidUJU42NW34mk9a3Gfghs5NLQce/o6oolzKknq+Q8IqQslBdRnoZ6V5yPfESGUVI/WRNhr5wVL6MhGef+seYqgZcHb/nw1YGIUyzWqli01ytJPOc7MXxzDf7+171mS7vCujQ9poJUq01EV4bP0SxRMwwU11ByYqKAeMrXqVYuJjxrDzs58pN7mIJ3eryj0ySmzbk79ZFSnKT/zkC5BU/ya7hrV7Ka2+71/4YUCE/X59fG1V4yxl2AFl0ansMkLI0GlOCUKZjgDmNzqcgTaoH4jDYnKY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6520.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(7696005)(38100700002)(9686003)(8676002)(110136005)(316002)(55016002)(122000001)(478600001)(5660300002)(66556008)(33656002)(64756008)(66476007)(66946007)(86362001)(186003)(66446008)(76116006)(6636002)(54906003)(107886003)(26005)(6506007)(53546011)(52536014)(4326008)(71200400001)(83380400001)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmxzM1k3Tno4UHFwNyt2REM2L3ZEQndwZWJtbTVXNzlFWVpHOTFqNUVmdTRn?=
 =?utf-8?B?V1JxRnM5M1RpWFd5UWFLTkpMZGh3cWhYM3VvdjM3SXVROTUxTXQ4ai9aRXV0?=
 =?utf-8?B?SVVoU2Y4UHlwc2JTZWRFRDlqK05sbGkvMFVaYXcxR2xnQXpFa0IyU21XTjdh?=
 =?utf-8?B?eVlERVBtckRJOTRRMVJDQXRLalhydTNuMHF0ZG91aCtnRUJqR2pZYmMwWXdW?=
 =?utf-8?B?blBrN0V1WkJOMlgwTlhxNnhseGE2U2czYjU0VlljY3g4azg2dEJIc2h2VURk?=
 =?utf-8?B?SFpMWXFDRFNZV3Yyc0FLRm12cXZJWkZrM0tXTkNVRml3S2NyelovOHFCUFpJ?=
 =?utf-8?B?NVlUOXR6UFY4ckFqaXN1NDF6WlBBZlpkclgyWXd4UzdHcDJKUjBQaXJQUVhQ?=
 =?utf-8?B?VERmb3gzM3JzZ3AycE5yMWFLOHNmelNQd2RaSWEwMUs2bEhwaGVEY3MyVEo2?=
 =?utf-8?B?TEo2Y3VEamprRnNYVkFqY0k2Z3FwYU1ISEJ2OFRGWW56blJvZEVHYUs5eEt4?=
 =?utf-8?B?TnJndFRoMTdqU3hQUTUyWGVJbjRkZnF4QXpESWtxcVVQaERkaVZZVkhjQlE2?=
 =?utf-8?B?VGR0TWxIUE1OVHl5eC9jRkluZEIyN2RTQUgvVTd3R1U5MFE3SXFFL1dmQ3dY?=
 =?utf-8?B?NFVrY3NXdmo0TnNDWEorVWpjOGNEVEl6R2xkaFpONXpzK2lVSEQrdVVzMXkx?=
 =?utf-8?B?bTFMZWIrNzNLVVUxdEY2YUI1SE54cVVLUVByWTZJdzFFbmlVdFZmVWVDemwv?=
 =?utf-8?B?ZE5ieHNtVlUxQnJIL1ZhMHViUHZ6VStxZlhLZHh6OXFJdjNMYWs0MzJtWU5V?=
 =?utf-8?B?VUMyU2FqVTc0QUdNR0tmMWc2Zm5LNjgrRnJVZTBMSUU4ZkpMSlFtM1ZLWExy?=
 =?utf-8?B?VlBqRzFRblEyUkY5V0pZUFZzMHJYdmdiREVlb29tMnJDQUVWSVlQUG5GSE5Y?=
 =?utf-8?B?WnA2UVpqeEdQUmlSdkh3bmRPQjhjamJ4VTF4TGVhb2h4N2Q5MXM5SEhNN0V1?=
 =?utf-8?B?SC9VSitPV3kwZXhaUnB2WGZrWEE0aE1qNzhMeWNPSnlMaVBsaEd1SGdLNko4?=
 =?utf-8?B?VXRsZC9kYnh1TnVqOHYwSlNCMkVvWVlRUkdoQmV6QXc1UVV6NlovWFhWT3ZJ?=
 =?utf-8?B?Y2xyN0o1dW10TU9JQm1yRGdpVUlxQ29yRjFvd2d6WVVPWDN1by9zdEpCTDla?=
 =?utf-8?B?SzVWM0VLOUJkem40UnlqeFNqbUpkcHVOMVFxVHpXYjFnQ1BBVDBYV1IrdVEw?=
 =?utf-8?B?dURTbDlDeVJGVlJjbDJPVjRVRjFJelJJMlkzQ3AvVUZjejVIazExbm5hRFls?=
 =?utf-8?B?UUFEM0RWSWl0MmZDcDgzR0p2Zzc0b3Z4Qk92OGJQc29GdjUrTWlCRllIcHlm?=
 =?utf-8?B?a3prNjVIWXVwR2t1ZGxkNk5SbTh5Qmwxc2h0Z0RSdzRQRVpkUTNXckpsNUVS?=
 =?utf-8?B?QWdSakhPMGowaUFQalErU3gxUFNELzVhaDRkU0owVHp2TkVycEZPWHhRWWNS?=
 =?utf-8?B?QzdJbGFZdDV1SmFPNlJVQTI2dDZFcTBTS0daQlpLQkVDbGxucmNodlpOM2NC?=
 =?utf-8?B?NEwrSkJYdUo1VmFxVnhqTmc3dnprbGMxWnRPZG5lSlplaVhrNFhkVU5saUFv?=
 =?utf-8?B?VDJxWGNkV0VJdXBwNFZkQ2JDd1BTTGFFdHJFcnJPMld6c0U2eTM4K0x3TjRO?=
 =?utf-8?B?YjhTbGZPaDlwUk9MeFQ0NG02YWZ3cHdnN2xWQVdXNERuRi9ZK0tKbDVWbVBr?=
 =?utf-8?Q?Ds4iex5RWBdK5L7I78m4fhxqPTOUDXsRkNcEp+T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6520.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884e6c81-8592-476d-a55e-08d92d0aedf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 18:58:41.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvTgl4o8EBzh6vvtuGuWyEQAsySMtpw5TCg4LUO+qSP5C1DEb3a0jdLXIgDW63yXzL7tpH/KoNB7aDHjERlacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6130
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4g
PGxhcnNAbWV0YWZvby5kZT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDE1LCAyMDIxIDEyOjU2
IFBNDQo+IFRvOiBSYWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXlzQHhpbGlueC5jb20+OyB2a291
bEBrZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IE1pY2hhbCBTaW1layA8bWljaGFs
c0B4aWxpbnguY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdA0KPiA8Z2l0QHhpbGlueC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYyIFBBVENIIDUvN10gZG1hZW5naW5lOiB4aWxpbnhfZG1h
OiBGcmVldXAgYWN0aXZlIGxpc3QNCj4gYmFzZWQgb24gZGVzY3JpcHRvciBjb21wbGV0aW9uIGJp
dA0KPiANCj4gT24gNC85LzIxIDc6NTYgUE0sIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+
ID4gQVhJRE1BIElQIGluIFNHIG1vZGUgc2V0cyBjb21wbGV0aW9uIGJpdCB0byAxIHdoZW4gdGhl
IHRyYW5zZmVyIGlzDQo+ID4gY29tcGxldGVkLiBSZWFkIHRoaXMgYml0IHRvIG1vdmUgZGVzY3Jp
cHRvciBmcm9tIGFjdGl2ZSBsaXN0IHRvIHRoZQ0KPiA+IGRvbmUgbGlzdC4gVGhpcyBmZWF0dXJl
IGlzIG5lZWRlZCB3aGVuIGludGVycnVwdCBkZWxheSB0aW1lb3V0IGFuZA0KPiA+IElSUVRocmVz
aG9sZCBpcyBlbmFibGVkIGkuZSBEbHlfSXJxRW4gaXMgdHJpZ2dlcmVkIHcvbyBjb21wbGV0aW5n
DQo+ID4gaW50ZXJydXB0IHRocmVzaG9sZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhZGhl
eSBTaHlhbSBQYW5kZXkgPHJhZGhleS5zaHlhbS5wYW5kZXlAeGlsaW54LmNvbT4NCj4gPiAtLS0N
Cj4gPiAtIENoZWNrIEJEIGNvbXBsZXRpb24gYml0IG9ubHkgZm9yIFNHIG1vZGUuDQo+ID4gLSBN
b2RpZnkgdGhlIGxvZ2ljIHRvIGhhdmUgZWFybHkgcmV0dXJuIHBhdGguDQo+ID4gLS0tDQo+ID4g
ICBkcml2ZXJzL2RtYS94aWxpbngveGlsaW54X2RtYS5jIHwgNyArKysrKysrDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9kbWEveGlsaW54L3hpbGlueF9kbWEuYw0KPiA+IGIvZHJpdmVycy9kbWEveGlsaW54L3hpbGlu
eF9kbWEuYyBpbmRleCA4OTBiZjQ2YjM2ZTUuLmYyMzA1YTczY2I5MQ0KPiA+IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZG1hL3hpbGlueC94aWxpbnhfZG1hLmMNCj4gPiArKysgYi9kcml2ZXJz
L2RtYS94aWxpbngveGlsaW54X2RtYS5jDQo+ID4gQEAgLTE3Nyw2ICsxNzcsNyBAQA0KPiA+ICAg
I2RlZmluZSBYSUxJTlhfRE1BX0NSX0NPQUxFU0NFX1NISUZUCTE2DQo+ID4gICAjZGVmaW5lIFhJ
TElOWF9ETUFfQkRfU09QCQlCSVQoMjcpDQo+ID4gICAjZGVmaW5lIFhJTElOWF9ETUFfQkRfRU9Q
CQlCSVQoMjYpDQo+ID4gKyNkZWZpbmUgWElMSU5YX0RNQV9CRF9DT01QX01BU0sJCUJJVCgzMSkN
Cj4gPiAgICNkZWZpbmUgWElMSU5YX0RNQV9DT0FMRVNDRV9NQVgJCTI1NQ0KPiA+ICAgI2RlZmlu
ZSBYSUxJTlhfRE1BX05VTV9ERVNDUwkJNTEyDQo+ID4gICAjZGVmaW5lIFhJTElOWF9ETUFfTlVN
X0FQUF9XT1JEUwk1DQo+ID4gQEAgLTE2ODMsMTIgKzE2ODQsMTggQEAgc3RhdGljIHZvaWQgeGls
aW54X2RtYV9pc3N1ZV9wZW5kaW5nKHN0cnVjdA0KPiBkbWFfY2hhbiAqZGNoYW4pDQo+ID4gICBz
dGF0aWMgdm9pZCB4aWxpbnhfZG1hX2NvbXBsZXRlX2Rlc2NyaXB0b3Ioc3RydWN0IHhpbGlueF9k
bWFfY2hhbg0KPiAqY2hhbikNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgeGlsaW54X2RtYV90eF9k
ZXNjcmlwdG9yICpkZXNjLCAqbmV4dDsNCj4gPiArCXN0cnVjdCB4aWxpbnhfYXhpZG1hX3R4X3Nl
Z21lbnQgKnNlZzsNCj4gPg0KPiA+ICAgCS8qIFRoaXMgZnVuY3Rpb24gd2FzIGludm9rZWQgd2l0
aCBsb2NrIGhlbGQgKi8NCj4gPiAgIAlpZiAobGlzdF9lbXB0eSgmY2hhbi0+YWN0aXZlX2xpc3Qp
KQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4NCj4gPiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUo
ZGVzYywgbmV4dCwgJmNoYW4tPmFjdGl2ZV9saXN0LCBub2RlKSB7DQo+ID4gKwkJLyogVE9ETzog
cmVtb3ZlIGhhcmRjb2RpbmcgZm9yIGF4aWRtYV90eF9zZWdtZW50ICovDQo+ID4gKwkJc2VnID0g
bGlzdF9sYXN0X2VudHJ5KCZkZXNjLT5zZWdtZW50cywNCj4gPiArCQkJCSAgICAgIHN0cnVjdCB4
aWxpbnhfYXhpZG1hX3R4X3NlZ21lbnQsIG5vZGUpOw0KPiA+ICsJCWlmICghKHNlZy0+aHcuc3Rh
dHVzICYgWElMSU5YX0RNQV9CRF9DT01QX01BU0spICYmDQo+IGNoYW4tPmhhc19zZykNCj4gPiAr
CQkJYnJlYWs7DQo+ID4gICAJCWlmIChjaGFuLT5oYXNfc2cgJiYgY2hhbi0+eGRldi0+ZG1hX2Nv
bmZpZy0+ZG1hdHlwZSAhPQ0KPiA+ICAgCQkgICAgWERNQV9UWVBFX1ZETUEpDQo+ID4gICAJCQlk
ZXNjLT5yZXNpZHVlID0geGlsaW54X2RtYV9nZXRfcmVzaWR1ZShjaGFuLCBkZXNjKTsNCj4gDQo+
IFNpbmNlIG5vdCBhbGwgZGVzY3JpcHRvcnMgd2lsbCBiZSBjb21wbGV0ZWQgaW4gdGhpcyBmdW5j
dGlvbiB0aGUgYGNoYW4tPmlkbGUgPQ0KPiB0cnVlO2AgaW4geGlsaW54X2RtYV9pcnFfaGFuZGxl
cigpIG5lZWRzIHRvIGJlIGdhdGVkIG9uIHRoZSBhY3RpdmVfbGlzdCBiZWluZw0KPiBlbXB0eS4N
Cg0KVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQuIEFncmVlIHRvIGl0LCB3aWxsIGZpeCBpdCBp
biB0aGUgbmV4dCB2ZXJzaW9uLg0KPiANCj4geGlsaW54X2RtYV9jb21wbGV0ZV9kZXNjcmlwdG9y
DQoNCg==
