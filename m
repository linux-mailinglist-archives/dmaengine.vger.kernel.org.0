Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1AD3A463C
	for <lists+dmaengine@lfdr.de>; Fri, 11 Jun 2021 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFKQPm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Jun 2021 12:15:42 -0400
Received: from mail-bn1nam07on2070.outbound.protection.outlook.com ([40.107.212.70]:20033
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229572AbhFKQPm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Jun 2021 12:15:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqgjbdAGEu0I7yojAvseUrF9tu20g3xwBhJvjqhmdLScYlez6ldme8cBJ9/fPr31hKBuvAJOT3n26W5VNskFl6xMDSZ6Pyd3doj2igPJfAqm84blucaBchm0WJvdbrgq/ZvsHf0SJpxgdi/GuTSMvDUUE+4KMX2/MFuZTOoR5aHAI+96jMT+w0+EhFUHTg/68+j5JPpCKXXlUKe7ZlvEyjzS/yTJy5tiB1+X/te54puTn85+R0g96sA56xvgcRIYINn8iK0LKccBS1wx67dMKRqm8HYfrbQwbPNWBCyMKSWoicWkqq4sbGvtdacCRaAenFC5TosvbaTLcFJWrTyWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urtrlkoCzDFMmcXhC7MlSxhNXd/T17f+LRwn7MmAyr0=;
 b=MidS5jxsenRCCYLdW8b5a3thLe9uBg3axoW6Swdjr/fkYj2msuE8rInjmu0lEESOYA6l6VyUfbUJao+iuxgV605CgOtrAylxmTpKUur22iqWKlYbDhdcPeDb05oKYGTpL+WdNpTlwD48ou0dKcfS15DnhYAoXe5lOnnGnaUSahP01xKG1TEU9qT/HVZ3JvzosOGIMH97Kl7ys6nmMENOm5HA9CPUkKZNr0SWrwEPkV8QPNvQTTfJrj3pKSNeruajBXPomsENupYFqUMVpOB1lho1eOEIvmOwT9xWzILU2G+BMoYpGOLvyEzelGQkvTRLz02WsV4o+grzUTYWZRvWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urtrlkoCzDFMmcXhC7MlSxhNXd/T17f+LRwn7MmAyr0=;
 b=n4vXRe/deATy0o6c6+Wo2FaPfXeeQEi2JszuRfoNe6YfCnFvIuxxDRYwNISmk+rweTlFACKnpo4UsB5XRS2y4OKDj+uzZ30kk3CDg+rc/7DMAQri6UdsIsmgUM2BmV2unpyVuDqDYE4mn5tVFLsH6A2JyJ5i/6B76GSQYZf9J1U=
Received: from BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8)
 by SJ0PR02MB7504.namprd02.prod.outlook.com (2603:10b6:a03:29b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 16:13:38 +0000
Received: from BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798]) by BY5PR02MB6520.namprd02.prod.outlook.com
 ([fe80::d880:7694:92d6:7798%5]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 16:13:38 +0000
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
Subject: RE: [RFC v2 PATCH 0/7] Xilinx DMA enhancements and optimization
Thread-Topic: [RFC v2 PATCH 0/7] Xilinx DMA enhancements and optimization
Thread-Index: AQHXLWmyjVcEROieG0WzNyBWPWqoIKq1MN6AgFotHyA=
Date:   Fri, 11 Jun 2021 16:13:38 +0000
Message-ID: <BY5PR02MB6520288804388360C1CE0091C7349@BY5PR02MB6520.namprd02.prod.outlook.com>
References: <1617990965-35337-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <0948eae0-b304-79f8-7d9a-543cba78fbe5@metafoo.de>
In-Reply-To: <0948eae0-b304-79f8-7d9a-543cba78fbe5@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc88f4e7-bfd6-4df8-1df1-08d92cf3df69
x-ms-traffictypediagnostic: SJ0PR02MB7504:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB7504E314B34C8C517F442AEFC7349@SJ0PR02MB7504.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pKP2ptRtkR+IvSOdNoLTrjtBP4gXRhnBz6N5qLiVCIsiS5AkHiSFVblmvhh/QPDY7zyYR0vOy/CxDoBxyO3i8oX4NZgaF5VwsxHCY0lzRCZzx+M6iO4n8rGNbhLKNFaLebif7xRGulBjYqBOE6OsFXB+yLbs2HTbirPy4v3zn0EjSySVA65Aon7lqBipfa6UJ/Od9KLC3q9l7BDOjKgrQt93ht9NCwFyuj6rfGr7p7zz8DvdiUIFkA1MSPxCW1WKdO/qAea44RE9yvMh5wxA7CfQAUMxsLhsZLxggMDwi412gQvy05n/TsnnpgQirvLhmR0/VLhBlDdxS4aHN7T4g3PB0txdYfJGx7eGXSkCbc3Dndfekv9w+nY4E81PzYxKcF3l7Qduhp0UIYzcjQBIsxhybstpHlo8/g62lggVRVRsf+l/pkjusB0hDavBgBng0INwAoR65QPPHgT4hPifdLH867aNEJ8K0gEeI2PZbB9uIXPCt/D32a30u+khCaH6c67IdxOrzk0bKtQC3lHgSirxghLsjH7P0ptokSnLsSzuuSHai1xOkXgW9mVG1yUsgrRA2VRy36UjCLZMlUsAZenfwf6loB0wDnlzMIkLoeHjiZnaTVmID9OJ2YdR57fpkY9YjXI+SMlJ2rQwh0R55HHNn4Xom9wbY4BaCWTdjx1oG/wLBa/D1rdyRFF+Frj9w5c2GsniPiWEqVIxQthl01Q73mxw0AQEA8DzLmBKKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6520.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(478600001)(26005)(316002)(66446008)(9686003)(76116006)(64756008)(55016002)(66556008)(66476007)(66946007)(86362001)(6636002)(7696005)(71200400001)(5660300002)(52536014)(6506007)(53546011)(2906002)(4744005)(4326008)(186003)(38100700002)(122000001)(966005)(8676002)(33656002)(83380400001)(8936002)(54906003)(110136005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2U3Nm96TzNSam1mT2ovMEY5bXV6TExac2EzckNIZGdXaWtMVDRER1dpcFFS?=
 =?utf-8?B?b0hhMkxxOWdnS1BoYlVZNUx4WmdrRzNvcnAwZzYrdUxzTFVLNCtEMWF3S3FP?=
 =?utf-8?B?MkhoMkVOUXRwMnVyYVRtL0d5c2hzanZadGVSdWllK0pZY0dMRkJ0bXFOVUE1?=
 =?utf-8?B?RStFQXV4RmhGWVU5Y2RTM2dINHhEQ1dEQTdMUXhaWTY4T0hIMWtJT1Z1cWpR?=
 =?utf-8?B?TWxXSlJiSUREdk1DT1FQMXFGeDE4VFliU2gzdTM2R2hmekRZRHlqenVLMEJp?=
 =?utf-8?B?L0VxajR3VlRPWUxmZitGbmRxMTVhd25wUWd0T3FPdU9ScGVwWGNSYnk1Q3RP?=
 =?utf-8?B?Sk8yeklBNjdHQk1QOU9ES1FISXR4U1FOdGRoQzFjeHU3QjNmTVBmWUZqNVNr?=
 =?utf-8?B?U01nRVJ1aDZvb3lVUGdkZjZYMDhJZWJlR2ZSWXQ1dGFRNElCcFBhcm5RdU8r?=
 =?utf-8?B?N29zWXRjUlBrVTJZVm9TcGxuRTlGTndlcEVoSiszOXpUSDkxajlreC9xUjNo?=
 =?utf-8?B?cTFkWll1MllCaGVzZlNHY2d1b2FpdXNHR043YllidnlESWdOMmpkTjkxclVj?=
 =?utf-8?B?eU1mRm9YWXkzbklPZm9hU2tiQTdCZzFPbldjQVFxT2hkbzVaYVhWWWp1NnBO?=
 =?utf-8?B?eU1YZE53cWhqSGhBTWdQWURMWkZBdnBTZTY3U1d0NjVGMmdyaE1wakxmNHFY?=
 =?utf-8?B?emU4ci9SKzlSK1hzVnpTem5PM0E1QUwvcldicG1DQXE4LzU4UXVXL3RVN2xw?=
 =?utf-8?B?Q1A2V2dqRHNGUHpzbmQ3dXgvUXdKRnJua2RGLzdlV0pXbnFYZnNwTW5rZklv?=
 =?utf-8?B?Um11NVR2K3Rjckd4YmxGNzVhcVZUUng4YXRIZHlvSi92a3hHc05lc3UrVTZP?=
 =?utf-8?B?Q1lBOVNyRDBvUkpoTWZhaEFudmJCb1lja2NhRlBpelNOL09hcWhqQjd6WkJG?=
 =?utf-8?B?MmgycFJPN2FNcXlBazZlWXVmQ0t6NU80d3ZEQ0ZYNnpEcW1BSWl6YnRHdlA2?=
 =?utf-8?B?M3F5eFlFY2Q0VFFad1hSTm9BV3UxTldYcEhBWkNaK1FFNHBvQUxvSDZNRXpB?=
 =?utf-8?B?QVBWelJ3VDFtN0VIclE3N1c2THVuMnhsci9TaUxxeVMyblpKaGYxS05tYmNt?=
 =?utf-8?B?RVlWS09iQ0FibFJtbUhqK2lKQ0twMmVxYjBCckdHZ2dpTVdiNFFuNk9DSUZH?=
 =?utf-8?B?UlRtczRCb1JDVzlzSzNDdHhXa01TK25kcGZwdUE2OGxsL1Z3YllXZkh0NS96?=
 =?utf-8?B?UjVpYno3Ti92VnJVQ1NMYyszMkpsSUtaTndiblhIOG9lMnFUOXZiOFJBT2Z4?=
 =?utf-8?B?NVZibmM4b09VclhIcytIU016ODlCTHAzVjhmeEc1VTF2TFg2WlBDOFJvTTlT?=
 =?utf-8?B?RlliODRaYmlOc1hUSWVlaEYwSzh0UzczSXVjU1ZQV1laL1J5a3FXa1hTaG8v?=
 =?utf-8?B?TmczK3pjWDJ1UmxWSWFFOVpIWUtDbGdGbjNEV3JSUDRTVTl2eWhjbnlUMndT?=
 =?utf-8?B?cFQyMTgzM3pwYmgxY2dTL1Q3QTlGa3lmZ0dscCt5VmcrR2hSL3lJdllBWDBp?=
 =?utf-8?B?dCt2Z2xuQUNHOW81bEgzVjJiZjdieVVacXNjN1FVNVVNTVI2bjZjQ0d5Z3dm?=
 =?utf-8?B?bzVCZHJJVFUvRmVsaGVydkxSWW9UckQ5c3dDTVhkaDFxZW56TjQ4YlZlMnBW?=
 =?utf-8?B?RWs0YnJlQm9tWWdPaVNlNDlNeTBOK3F0dElhb21JQ0lyNXBGRForb0dQR29C?=
 =?utf-8?Q?IDI2LCXlQj8L47UD/xJ1S+ejnn/mFzCRFf8TCn+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6520.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc88f4e7-bfd6-4df8-1df1-08d92cf3df69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 16:13:38.4637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmLKMXQSxfR8wx/hf+NJQnNPDTLjDlLc4m4U8DmBE4vPtJlQIOfeIiRTbss8xHFrec1Tr86DjsL9jo2OY5arxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7504
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4g
PGxhcnNAbWV0YWZvby5kZT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDE1LCAyMDIxIDEyOjM2
IFBNDQo+IFRvOiBSYWRoZXkgU2h5YW0gUGFuZGV5IDxyYWRoZXlzQHhpbGlueC5jb20+OyB2a291
bEBrZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IE1pY2hhbCBTaW1layA8bWljaGFs
c0B4aWxpbnguY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdA0KPiA8Z2l0QHhpbGlueC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUkZDIHYyIFBBVENIIDAvN10gWGlsaW54IERNQSBlbmhhbmNlbWVu
dHMgYW5kIG9wdGltaXphdGlvbg0KPiANCj4gT24gNC85LzIxIDc6NTUgUE0sIFJhZGhleSBTaHlh
bSBQYW5kZXkgd3JvdGU6DQo+ID4gU29tZSBiYWNrZ3JvdW5kIGFib3V0IHRoZSBwYXRjaCBzZXJp
ZXM6IFhpbGlueCBBeGkgRXRoZXJuZXQgZGV2aWNlDQo+ID4gZHJpdmVyDQo+ID4gKHhpbGlueF9h
eGllbmV0X21haW4uYykgY3VycmVudGx5IGhhcyBheGktZG1hIGNvZGUgaW5zaWRlIGl0LiBUaGUg
Z29hbA0KPiA+IGlzIHRvIHJlZmFjdG9yIGF4aWV0aGVybmV0IGRyaXZlciBhbmQgdXNlIGV4aXN0
aW5nIEFYSSBETUEgZHJpdmVyDQo+ID4gdXNpbmcgRE1BRW5naW5lIEFQSS4NCj4gDQo+IFRoaXMg
aXMgcHJldHR5IG5lYXQhIERvIHlvdSBoYXZlIHRoZSBwYXRjaGVzIHRoYXQgbW9kaWZ5IHRoZSBB
WEkgRXRoZXJuZXQNCj4gZHJpdmVyIGluIGEgcHVibGljIHRyZWUgc29tZXdoZXJlLCBzbyB0aGlz
IHNlcmllcyBjYW4gYmUgc2VlbiBpbiBjb250ZXh0Pw0KWWVzLCAgSSBzZW50IHRoZSBheGlldGhl
cm5ldCBSRkMgc2VyaWVzIHRvIHRoZSBuZXRkZXYgbWFpbGluZyBsaXN0LiBIZXJlIGlzDQp0aGUg
bGluazogaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbmV0ZGV2L21zZzczNDE3My5odG1s
DQoNClRoYW5rcywNClJhZGhleQ0K
