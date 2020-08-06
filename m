Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6CE23DF92
	for <lists+dmaengine@lfdr.de>; Thu,  6 Aug 2020 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHFRtu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Aug 2020 13:49:50 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:5011 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgHFQdw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 6 Aug 2020 12:33:52 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2c0bfb0000>; Thu, 06 Aug 2020 21:56:13 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Aug 2020 06:56:13 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 06 Aug 2020 06:56:13 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 13:56:08 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 6 Aug 2020 13:56:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OND8eULtNTglGlgQ3D5+IzwG4NXA3mbiIT7HrpXTLwN395mydHcC1y2LTgIiM29I3IN8NzFt57NsMevX9QdUm52eLCKfoSFyqdEIUPtTAKG8aWeQ5PuB6rN6ZdmF2SOvX8UU1/5ZvIQopMBdYKGxoSvWnAGxfMkWPMAykO6XIYEq8qVd97UoRvO/3FsXRzlx8FZ6dVzx/PS2LA+h0Il21M+0m5+zG6gsjqM4rHBvJVGpRWlNnRkffUJGK24ynIK07GHZSfrhN4ej7atxtEoAgvBandvYSaa0MjR2gFWt8EYXlZb/AP24SWTYVd5n5ZW6Qc3KPJ9hN66CtbCaE4KOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3kXfRFz5pAx9q//Nw5Cu6I0m7BXmIIrpPZvY8lJHyw=;
 b=D9Xc79mdIO4nAtFPtOejzbEgj5pgBHasiLwysKkhqBOd6ayw69HfzPy8e4+E57t9ymuezP+UeejNl6QGsIDlpXKrc981qdhIVCb9yZ7BrG9/IHpc/ASDi7YWVlbUVyLaUqh6qpUmD36vj/AmuqehtZk4h89+PNMebpJU03gcOHD2AKJeu5YC4xwQA+LerPPLkteLEAUaa6GJB+iwTDQwL2Pfu0sIcznih8KeaqjCIaN1oHK+INzrDYvyur0RpMWQdDQKgrMKyBRzppoirDCwKG39a6GcymAfXth737Awjjo6bz4Pwdv3Q7A8j3ctP/UIFJIde+tbKcx0qibP/ihWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 6 Aug
 2020 13:56:05 +0000
Received: from CH2PR12MB4135.namprd12.prod.outlook.com
 ([fe80::5c6d:6cf4:8e78:154c]) by CH2PR12MB4135.namprd12.prod.outlook.com
 ([fe80::5c6d:6cf4:8e78:154c%8]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 13:56:05 +0000
From:   Rajesh Gumasta <rgumasta@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [Patch v2 2/4] dmaengine: tegra: Add Tegra GPC DMA driver
Thread-Topic: [Patch v2 2/4] dmaengine: tegra: Add Tegra GPC DMA driver
Thread-Index: AQHWa8OB+CPw1KNMkkeLJdtszOpPiqkrGF8AgAABvrA=
Date:   Thu, 6 Aug 2020 13:56:05 +0000
Message-ID: <CH2PR12MB41350E273B36463F9B372A52A2480@CH2PR12MB4135.namprd12.prod.outlook.com>
References: <1596699006-9934-1-git-send-email-rgumasta@nvidia.com>
 <1596699006-9934-3-git-send-email-rgumasta@nvidia.com>
 <bc7d0d9d-ac7f-b720-64f5-63e0c76e6786@gmail.com>
In-Reply-To: <bc7d0d9d-ac7f-b720-64f5-63e0c76e6786@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=rgumasta@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-08-06T13:56:03.2165375Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=646c1c28-e47f-43b7-bd9d-6a8ad7b80637;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [115.114.118.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f54a77f-8752-4325-73de-08d83a1076b6
x-ms-traffictypediagnostic: CH2PR12MB4328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4328372206703AADFF15F48DA2480@CH2PR12MB4328.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogf0z75XgAFS0fFBKxia5FUIqJAadqCxRJjLzTG6Y6T41B7gL9oXHJmnaYq6cIkGq8uJh6zd8p6bFZ+TyOFmKL2GdrJAhEiiQq7aYUVcu79/4UV06Zyfwb8w5x8vYp7LB8k6wumAdN4u3+3VyWi1RBhmxSFOZ9iGe7iRUsjXKyycbctKfww3MawLlcoBOTSNV9q4AwGXN/wcG4J23vZTv88Y8I/6JhTwiYGhkOdFiRBfELIF4vvtx56sIa3VEDAgRthuq1k8/oM7wxtAsudIXtMaqsKM/LYKq6v+l0U4wQoywH5xvxB7YR+UcuiwYX8mdTsnu5svf4DqHRqD/WD6Yh1/lQp+4YM4oUGoXr/MQj64sYbklw2AX2fCh5T07qTB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4135.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(86362001)(76116006)(66476007)(64756008)(66946007)(66556008)(66446008)(8936002)(54906003)(110136005)(8676002)(316002)(26005)(478600001)(83380400001)(71200400001)(2906002)(55016002)(186003)(107886003)(33656002)(9686003)(4326008)(5660300002)(7696005)(53546011)(6506007)(52536014)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KhvB9a//363hUH75PrW8m3+Q8yiWPgfFD8DI1oU8HWFTkNhiWJmpqP7uKSmYpfK5De8gQjr1ybquJy+R/I2lZqL2PWZvkkzqj3NycMoQ4p1lXBOs8hqR/MUXBOsP9hZr7tEDVTvzNaJoKlCv2NRNcQijmuqaYJUpxn1fGJSsOKlS+ys4xCv4poIKcCabESsuFxuiYahBUkf7HhzB0FSnv44+WcvbcydEP2s/1+s+gepLo5STSHlx7NqJydBd/+BSuKm5sD8wbv4TabXHL9mQhKQkx9Yjmj66RWYS1njPlTyIxdNaJBaOWDysZI5PRXuVgMv5PXbx2PII+yWBxqk4XkDISU+Rauo6ScCN1La8PlG5Tm9ULwRnUbiijl4RSLHzR5oC0LiQwGlAxwE+MkUQyJ2E1DoX6A2bCt/1WKF+jVUgS9gd17tGADsCFYOaxwqNkDY3C1TUGX0aguEfmofvg9YdVrq+p3ghQY0PnDNFbI0Zew3zG+3AX5tkcAhSRHdfmyWzRMUjJMrUhF+IThRghubyzQXFkZXMVoGlfRD2EkabQZ6u51YqEXEao3NOfrHCa1mOSsq5o81Tf+lTNiRD3kU8CCSxPxlYe79s2R6F5hs1/Kkk0lte41tp1P58q6sikE+C+sHzuHJ2hQ68j9r49A==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4135.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f54a77f-8752-4325-73de-08d83a1076b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 13:56:05.7366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gP6A8UQVvUenQPJNohghp6vm6xTlX5irdOvXo9yPLh1HuQIj+nHXvJeFX7fj7Apnu2Q8D7x+6kTSsmTnOVQfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596722173; bh=W3kXfRFz5pAx9q//Nw5Cu6I0m7BXmIIrpPZvY8lJHyw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         MIME-Version:X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=GeNnH3nyky/FDHAeIaZhzNqnrklMW3eBx0jrO4fpTaH/Lr8mYYOMF8lbgdAnXyOAj
         CKE108xkkKYGf1wLgkTFIVMvhIoLKtrQksf7aVZ0O+3VXzXVkqX9sPVASa7lcfsjGH
         G9LSCg7RS5eM+usC5dxS6V6cQnITqaML9PZN2m2gbcH07js8kdAC/kedSVP07+GsRs
         8FqtC+8szrnLkh6Gz9g6/tI+KZKguciI8tFzlpJaXnO9qGzj+XV2YQxSJbPngVeLoa
         CIAfnN5KG5MZ5rnfTNJi041qZiwmMmqYmP/vLJUGmfAAO+f2bAj6+XmcrMl8h3NmdS
         M9nKyYhiOMmOw==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG1pdHJ5IE9zaXBlbmtv
IDxkaWdldHhAZ21haWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDYsIDIwMjAgNzox
NiBQTQ0KPiBUbzogUmFqZXNoIEd1bWFzdGEgPHJndW1hc3RhQG52aWRpYS5jb20+OyBMYXhtYW4g
RGV3YW5nYW4NCj4gPGxkZXdhbmdhbkBudmlkaWEuY29tPjsgSm9uYXRoYW4gSHVudGVyIDxqb25h
dGhhbmhAbnZpZGlhLmNvbT47DQo+IHZrb3VsQGtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGlu
dGVsLmNvbTsgdGhpZXJyeS5yZWRpbmdAZ21haWwuY29tOw0KPiBwLnphYmVsQHBlbmd1dHJvbml4
LmRlOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gdGVncmFAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBLcmlzaG5hIFlhcmxh
Z2FkZGEgPGt5YXJsYWdhZGRhQG52aWRpYS5jb20+OyBQYXZhbiBLdW5hcHVsaQ0KPiA8cGt1bmFw
dWxpQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUGF0Y2ggdjIgMi80XSBkbWFlbmdpbmU6
IHRlZ3JhOiBBZGQgVGVncmEgR1BDIERNQSBkcml2ZXINCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBV
c2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gMDYuMDgu
MjAyMCAxMDozMCwgUmFqZXNoIEd1bWFzdGEg0L/QuNGI0LXRgjoNCj4gLi4uDQo+ID4gKy8qDQo+
ID4gKyAqIFNhdmUgYW5kIHJlc3RvcmUgY3NyIGFuZCBjaGFubmVsIHJlZ2lzdGVyIG9uIHBtX3N1
c3BlbmQNCj4gPiArICogYW5kIHBtX3Jlc3VtZSByZXNwZWN0aXZlbHkNCj4gPiArICovDQo+ID4g
K3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgdGVncmFfZG1hX3BtX3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiB7DQo+ID4gKyAgICAgc3RydWN0IHRlZ3JhX2RtYSAqdGRtYSA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsgICAgIGludCBpOw0KPiA+ICsNCj4gPiArICAgICBmb3Ig
KGkgPSAwOyBpIDwgdGRtYS0+Y2hpcF9kYXRhLT5ucl9jaGFubmVsczsgaSsrKSB7DQo+ID4gKyAg
ICAgICAgICAgICBzdHJ1Y3QgdGVncmFfZG1hX2NoYW5uZWwgKnRkYyA9ICZ0ZG1hLT5jaGFubmVs
c1tpXTsNCj4gPiArICAgICAgICAgICAgIHN0cnVjdCB0ZWdyYV9kbWFfY2hhbm5lbF9yZWdzICpj
aF9yZWcgPQ0KPiA+ICsgJnRkYy0+Y2hhbm5lbF9yZWc7DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgY2hfcmVnLT5jc3IgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0NTUik7DQo+
ID4gKyAgICAgICAgICAgICBjaF9yZWctPnNyY19wdHIgPSB0ZGNfcmVhZCh0ZGMsDQo+IFRFR1JB
X0dQQ0RNQV9DSEFOX1NSQ19QVFIpOw0KPiA+ICsgICAgICAgICAgICAgY2hfcmVnLT5kc3RfcHRy
ID0gdGRjX3JlYWQodGRjLA0KPiBURUdSQV9HUENETUFfQ0hBTl9EU1RfUFRSKTsNCj4gPiArICAg
ICAgICAgICAgIGNoX3JlZy0+aGlnaF9hZGRyX3B0ciA9IHRkY19yZWFkKHRkYywNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRFR1JBX0dQQ0RNQV9D
SEFOX0hJR0hfQUREUl9QVFIpOw0KPiA+ICsgICAgICAgICAgICAgY2hfcmVnLT5tY19zZXEgPSB0
ZGNfcmVhZCh0ZGMsDQo+IFRFR1JBX0dQQ0RNQV9DSEFOX01DU0VRKTsNCj4gPiArICAgICAgICAg
ICAgIGNoX3JlZy0+bW1pb19zZXEgPSB0ZGNfcmVhZCh0ZGMsDQo+IFRFR1JBX0dQQ0RNQV9DSEFO
X01NSU9TRVEpOw0KPiA+ICsgICAgICAgICAgICAgY2hfcmVnLT53Y291bnQgPSB0ZGNfcmVhZCh0
ZGMsDQo+IFRFR1JBX0dQQ0RNQV9DSEFOX1dDT1VOVCk7DQo+ID4gKyAgICAgfQ0KPiA+ICsgICAg
IHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IF9fbWF5YmVfdW51c2Vk
IHRlZ3JhX2RtYV9wbV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4gKyAgICAgc3Ry
dWN0IHRlZ3JhX2RtYSAqdGRtYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsgICAgIGlu
dCBpOw0KPiA+ICsNCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgdGRtYS0+Y2hpcF9kYXRhLT5u
cl9jaGFubmVsczsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgICBzdHJ1Y3QgdGVncmFfZG1hX2No
YW5uZWwgKnRkYyA9ICZ0ZG1hLT5jaGFubmVsc1tpXTsNCj4gPiArICAgICAgICAgICAgIHN0cnVj
dCB0ZWdyYV9kbWFfY2hhbm5lbF9yZWdzICpjaF9yZWcgPQ0KPiA+ICsgJnRkYy0+Y2hhbm5lbF9y
ZWc7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgdGRjX3dyaXRlKHRkYywgVEVHUkFfR1BDRE1B
X0NIQU5fV0NPVU5ULCBjaF9yZWctDQo+ID53Y291bnQpOw0KPiA+ICsgICAgICAgICAgICAgdGRj
X3dyaXRlKHRkYywgVEVHUkFfR1BDRE1BX0NIQU5fRFNUX1BUUiwgY2hfcmVnLQ0KPiA+ZHN0X3B0
cik7DQo+ID4gKyAgICAgICAgICAgICB0ZGNfd3JpdGUodGRjLCBURUdSQV9HUENETUFfQ0hBTl9T
UkNfUFRSLCBjaF9yZWctDQo+ID5zcmNfcHRyKTsNCj4gPiArICAgICAgICAgICAgIHRkY193cml0
ZSh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX0hJR0hfQUREUl9QVFIsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgY2hfcmVnLT5oaWdoX2FkZHJfcHRyKTsNCj4gPiArICAgICAgICAgICAgIHRk
Y193cml0ZSh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX01NSU9TRVEsIGNoX3JlZy0NCj4gPm1taW9f
c2VxKTsNCj4gPiArICAgICAgICAgICAgIHRkY193cml0ZSh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFO
X01DU0VRLCBjaF9yZWctPm1jX3NlcSk7DQo+ID4gKyAgICAgICAgICAgICB0ZGNfd3JpdGUodGRj
LCBURUdSQV9HUENETUFfQ0hBTl9DU1IsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgKGNo
X3JlZy0+Y3NyICYgflRFR1JBX0dQQ0RNQV9DU1JfRU5CKSk7DQo+ID4gKyAgICAgfQ0KPiA+ICsg
ICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IF9f
bWF5YmVfdW51c2VkIGRldl9wbV9vcHMNCj4gdGVncmFfZG1hX2Rldl9wbV9vcHMgPSB7DQo+ID4g
KyAgICAgU0VUX05PSVJRX1NZU1RFTV9TTEVFUF9QTV9PUFModGVncmFfZG1hX3BtX3N1c3BlbmQs
DQo+ID4gK3RlZ3JhX2RtYV9wbV9yZXN1bWUpIH07DQo+IA0KPiBQbGVhc2UgZXhwbGFpbiB3aHkg
dGhpcyBpcyBuZWVkZWQuIEFsbCBETUEgc2hvdWxkIGJlIHN0b3BwZWQgKG5vdA0KPiBwYXVzZWQp
IG9uIHN5c3RlbSdzIHN1c3BlbmQsIHNob3VsZG4ndCBpdD8NCkkgaGF2ZSByZWNoZWNrZWQgd2l0
aCBIVyB2ZXJpZmljYXRpb24gdGVhbSBhbmQgdGhleSBjb25maXJtZWQgdGhhdCBhZnRlciBzdXNw
ZW5kLCBjc3IgYW5kIGNoYW5uZWwgcmVnaXN0ZXJzIHdpbGwgZ2V0IHJlc2V0IGhlbmNlIG9uIHJl
c3VtZSB3ZSBuZWVkIHRvIHJlc3RvcmUgYmFjay4NCkFsc28gR1BDRE1BIGRvZXMgbm90IHN1cHBv
cnQgcG93ZXIgZ2F0ZSBhcyBhIHVuaXQuDQoNClRoYW5rcw0KUmFqZXNoDQo=
