Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6977329C8EB
	for <lists+dmaengine@lfdr.de>; Tue, 27 Oct 2020 20:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830013AbgJ0Tai (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 27 Oct 2020 15:30:38 -0400
Received: from us-smtp-delivery-115.mimecast.com ([216.205.24.115]:49824 "EHLO
        us-smtp-delivery-115.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1830010AbgJ0Tag (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 27 Oct 2020 15:30:36 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 15:30:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1603827034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aoDppwS3J+T+jtG/x8eU9oxtO8WuOEsqCRklS6tC1k=;
        b=Im/bnJXah8N90WjSlzcQg49eZKQ4u7fYIlGC5YyA6iSEIF8s6oc9/FxNN9XpXyxv38u+4X
        JkyKABYwLAieGLPuF7ra1uolIq0IEGBj2mkv8F9jbZtTNFCHb1IK0sEn94SaIBuXrUN6ad
        LO2tTNVuGeeZUztxFA3PZ8EdV4rfUMA=
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-t9I1UpCAO6C2Jt-xn17BEw-2; Tue, 27 Oct 2020 15:24:23 -0400
X-MC-Unique: t9I1UpCAO6C2Jt-xn17BEw-2
Received: from DM6PR19MB3594.namprd19.prod.outlook.com (2603:10b6:5:203::21)
 by DM5PR19MB0954.namprd19.prod.outlook.com (2603:10b6:3:26::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 19:24:16 +0000
Received: from DM6PR19MB3594.namprd19.prod.outlook.com
 ([fe80::540:6c32:23e2:4a1]) by DM6PR19MB3594.namprd19.prod.outlook.com
 ([fe80::540:6c32:23e2:4a1%6]) with mapi id 15.20.3499.018; Tue, 27 Oct 2020
 19:24:16 +0000
From:   Thomas Langer <tlanger@maxlinear.com>
To:     Amireddy Mallikarjuna reddy <mallikarjunax.reddy@linux.intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "Kim, Cheol Yong" <Cheol.Yong.Kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>,
        "malliamireddy009@gmail.com" <malliamireddy009@gmail.com>,
        "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>,
        "Langer, Thomas" <thomas.langer@intel.com>
Subject: RE: [PATCH v7 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Thread-Topic: [PATCH v7 1/2] dt-bindings: dma: Add bindings for intel LGM SOC
Thread-Index: AQHWrDgs5Bf/aSZXOUa9iCmf1ZDADKmrsTbw
Date:   Tue, 27 Oct 2020 19:24:16 +0000
Message-ID: <DM6PR19MB3594E466A1B76229EC1395BABB160@DM6PR19MB3594.namprd19.prod.outlook.com>
References: <cover.1600827061.git.mallikarjunax.reddy@linux.intel.com>
 <f298715ab197ae72ab9b33caee2a19cc3e8be3f5.1600827061.git.mallikarjunax.reddy@linux.intel.com>
In-Reply-To: <f298715ab197ae72ab9b33caee2a19cc3e8be3f5.1600827061.git.mallikarjunax.reddy@linux.intel.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
x-originating-ip: [188.99.122.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83fa1fc2-5f12-40cc-4746-08d87aade501
x-ms-traffictypediagnostic: DM5PR19MB0954:
x-microsoft-antispam-prvs: <DM5PR19MB0954D5096DEFB5F2AD1F6FEFBB160@DM5PR19MB0954.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Xbmub2o7nZVSqDeMJkOo497BZzM/uBJ8TMz2raDd4cH3U0vvC2nAJMotUTA5u61KLGvnnRi+yZbPjdJ6rf3//gcafvlCGdMpMvaQtepezCVBzuOUlkDOC6jK8ESe6P+xqAYmvhiQu5doSE7ymffNfbykMw04z9IKfPvae0TsO1goCZOaZ7u4edQ0daLOp/JCyjMWgd+MaSYiMShXbfdF3aX4LTvEFmMgBi8UCJ/JKTTnu05QZP9dyn3BybZFbvOIVajsqHEHL0y3kbkTXvqHJFVgCIqPWnYIP3emW4YJUW947v+kWO3Hw+p76iPTuJ4w3U7fLBgBul0VdZw+RZxKsagZgiz9y9rqr00FntS8fd4xBtbA/bXkcwJBrEAhTY+G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB3594.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39850400004)(66946007)(64756008)(7416002)(71200400001)(7696005)(83380400001)(2906002)(26005)(52536014)(9686003)(66446008)(6506007)(76116006)(86362001)(54906003)(5660300002)(66556008)(4326008)(66476007)(316002)(33656002)(478600001)(55016002)(4744005)(8936002)(110136005)(186003)(8676002)(473944003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata: j69AyLCq/vcTuZ24Do3Wpc+jBnwpPE4f06NNjsMzRLerbphz96cTXMC+AupF3EA7A8PtNxu9Sezb91nIQijb9CuiSxE9gPQmk++jPlzeDNAAmGvjIV0SsHPjmoxGZ4fqggW3wF+Yu4HdlW+hVCFTs/MmJQjZCeg+zWdi2UqnsV70ucTVgKyQvtQ3qDFiuIIafD5dJoHSviNKsJxzuzgZ4EbOtyJh6gQl/U0Dcjh9VZbsxiIVxB6grMk+lBKazFECiYxGvfTqivheqHx7FD6tah4xYrv92RrFMe+DQzmjHPg3BkWQEZxlgkMq6JkksyG6tH/A+yX1ao8GMjZf3r3sCJTcioM1dCWcXmUWYrprsRtsN33iXW39yildkIGbs0SM0T70m5vW63eX7maO1UPL2FWTKRIvO1GzhQo5jBjaGoPbv10OLmbeGHoKEP64txdjYTv0UPZvCCTPdErXLAayXYAPXkCD21W0caPBxFI4PIa3AiKMZPB3Ckip9tX3gzjTUgOahpGI8G8Hx229HmtoedTIA2OrKXxx0XOZN76jWq8XUDHN90jUDMnd22hPgbEKGMV4sE88YtUnCv+LSPbuCTwbCRYuiFfFe8zDNW5dldZoV1agIa6KF7gnDbjxr/JPLaoTx2EB2hlnZZqrj4SX4A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB3594.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fa1fc2-5f12-40cc-4746-08d87aade501
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 19:24:16.1822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TA53i6LmTpeQYP8W55H6Dw8CnAzlpRj/yF5BVnQML7sr6Z+iBOEE0TBLLnjPRx6rs/GhDLKXBozQ27iGB6tFDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0954
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA115A51 smtp.mailfrom=tlanger@maxlinear.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGVsbG8gUmVkZHksDQoNCkkgdGhpbmsgIkludGVsIiBzaG91bGQgYWx3YXlzIGJlIHdyaXR0ZW4g
d2l0aCBhIGNhcGl0YWwgIkkiIChsaWtlIGluIHRoZSBTdWJqZWN0LCBidXQgZXhjZXB0IGluIHRo
ZSBiaW5kaW5nIGJlbG93KQ0KDQo+ICsgY29tcGF0aWJsZToNCj4gKyAgb25lT2Y6DQo+ICsgICAt
IGNvbnN0OiBpbnRlbCxsZ20tY2RtYQ0KPiArICAgLSBjb25zdDogaW50ZWwsbGdtLWRtYTJ0eA0K
PiArICAgLSBjb25zdDogaW50ZWwsbGdtLWRtYTFyeA0KPiArICAgLSBjb25zdDogaW50ZWwsbGdt
LWRtYTF0eA0KPiArICAgLSBjb25zdDogaW50ZWwsbGdtLWRtYTB0eA0KPiArICAgLSBjb25zdDog
aW50ZWwsbGdtLWRtYTMNCj4gKyAgIC0gY29uc3Q6IGludGVsLGxnbS10b2UtZG1hMzANCj4gKyAg
IC0gY29uc3Q6IGludGVsLGxnbS10b2UtZG1hMzENCg0KQmluZGluZ3MgYXJlIG5vcm1hbGx5IG5v
dCBwZXIgaW5zdGFuY2UuDQpXaGF0IGlmIG5leHQgZ2VuZXJhdGlvbiBjaGlwIGdldHMgbW9yZSBE
TUEgbW9kdWxlcyBidXQgaGFzIG5vIG90aGVyIGNoYW5nZXMgaW4gdGhlIEhXIGJsb2NrPw0KV2hh
dCBpcyB3cm9uZyB3aXRoDQogIC0gY29uc3Q6IGludGVsLGxnbS1jZG1hDQogIC0gY29uc3Q6IGlu
dGVsLGxnbS1oZG1hDQphbmQgZXh0cmEgYXR0cmlidXRlcyB0byBkZWZpbmUgdGhlIHJ4L3R4IHJl
c3RyaWN0aW9uIChvciB3aGF0IGRvIGl0IG1lYW4/KT8gDQpGcm9tIHRoZSBkcml2ZXIgY29kZSBJ
IHNhdyB0aGF0ICJ0b2UiIGlzIGFsc28ganVzdCBvZiB0eXBlICJoZG1hIiBhbmQgbm8gZnVydGhl
ciBkaWZmZXJlbmNlcyBpbiBjb2RlIGFyZSBkb25lLg0KDQpCZXN0IHJlZ2FyZHMsDQpUaG9tYXMN
Cg0K

