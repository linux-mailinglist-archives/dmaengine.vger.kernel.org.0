Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC01DD8E2F
	for <lists+dmaengine@lfdr.de>; Wed, 16 Oct 2019 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392471AbfJPKma (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Oct 2019 06:42:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39936 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389345AbfJPKma (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 16 Oct 2019 06:42:30 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GAcaIv007387;
        Wed, 16 Oct 2019 06:41:43 -0400
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2053.outbound.protection.outlook.com [104.47.34.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vk8pavy0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 06:41:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmuPJppCzJgNW6CT77X/beQ/evcqvi9r1mLLqpNI+/LJjl0cTAsI/AYmtL9UW3cCB01syaqxzd3kOuxghxz8a0Du3Sf8dxoT4mqA5kCwx/YbTIgM5GvVmQKYlUklJ9c4dzmQ9EiJ/zvVtwwfaTJKzt5RAAqq7wfs3xEt1nPJ6Uv4t0O+J5yOWQ/A2HfuGV+d5d6swdIdPlg7EPTYEiu1iy9BQPlpOzL8zbfKg0GRc/azBLQl3xUDsyELyEKFSUYzcPkg6maY9m7s06KJsnYIgnwxZLkBFNUX9IMt+kDnAHp6O+1/a2jx1lhVXBKoGGXwTXf0BxxJrBtL3YueFggfdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fmuMYGNgUm2Moe/OPwlYRvDeoPE53l7iZ1eFWjQRpM=;
 b=Mgts5wQ2IguxYmnyz+Xsd2vJbxY5Z6VXLfcIh4xt/JcwSEK2qB1LbRcbYF4xx8fjh2OPgikOAyZCg2nVrFa7+tGRg9Jpaunu1kILOjdFzXTAFt/D+kOxLjUSpIh3s6NHWOyCuSZpqVu/kVDeoXxMQy18MiamjbXBoOwH6A+vM+KT3UBqIpvHcYjSN4KhidbUZzM2mXSV4nv+TqncB5EbldoTYdR0A07OpFcZQV3/60PAYN15RzvxLQCqb28jONOvwp5sFuGKBoUhMlccZaPZkC1HvlgBQJPgz+7ORPYg9leFTg3qqmci0Iqtmi3uhpdEPMnGMzyFmjZQgzjK6ihTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fmuMYGNgUm2Moe/OPwlYRvDeoPE53l7iZ1eFWjQRpM=;
 b=REGGcyde69cuEl3D3J6p7flEmNJjtZWeapUWMYDzCC8cGDeRFDTCbhtfOLEnvoZCptxzOugzEIlERYiVJDHa6aTUhFrkmL9xsvkg343jd5/scChCVlMYpjeIGimw4uDtdjI5ImQ+Xapb9gUebmGimwA8DMJHAp/M8t1byYI8nvY=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5254.namprd03.prod.outlook.com (20.180.4.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Wed, 16 Oct 2019 10:41:41 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::99:71f2:a588:977c%3]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:41:41 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "alencar.fmce@imbel.gov.br" <alencar.fmce@imbel.gov.br>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: axi-dmac: simple device_config operation
 implemented
Thread-Topic: [PATCH] dmaengine: axi-dmac: simple device_config operation
 implemented
Thread-Index: AQHVgl1XDQuPzs7EEUSctiEEmydhCKdbSU+AgAA8yACAAK4aAIAAhqGAgABdIoA=
Date:   Wed, 16 Oct 2019 10:41:41 +0000
Message-ID: <68e30adcd61677659092ae9a157a12b639a6641d.camel@analog.com>
References: <20190913145404.28715-1-alexandru.ardelean@analog.com>
         <20191014070142.GB2654@vkoul-mobl>
         <4384347cc94a54e3fa22790aaa91375afda54e1b.camel@analog.com>
         <20191015104342.GW2654@vkoul-mobl>
         <4428e1fa-1a2a-5a5f-ada8-806078c8da94@metafoo.de>
         <20191016050841.GA2654@vkoul-mobl>
In-Reply-To: <20191016050841.GA2654@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44035de5-5da5-42cc-1420-08d752256e85
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: CH2PR03MB5254:
x-microsoft-antispam-prvs: <CH2PR03MB52548592704D419A38E11818F9920@CH2PR03MB5254.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(366004)(39860400002)(396003)(199004)(189003)(305945005)(7736002)(4326008)(4001150100001)(256004)(14444005)(118296001)(14454004)(446003)(11346002)(86362001)(2616005)(476003)(486006)(478600001)(66066001)(81166006)(2501003)(76116006)(66556008)(66476007)(66946007)(66446008)(64756008)(99286004)(71190400001)(71200400001)(5660300002)(26005)(186003)(76176011)(6506007)(102836004)(53546011)(25786009)(36756003)(8936002)(81156014)(316002)(3846002)(6116002)(2906002)(8676002)(229853002)(6512007)(54906003)(6246003)(110136005)(6436002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5254;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2M1mWxDpncXD2o7Vl47msFoHMYCXlaWDZ6209Mda32yMSUxIU4+v+BdZ12ILUxLvx9tkREnZBxQ8UZBlePszMTRkqhXWjmu2/sxZKgvRFwS+OsKzdRtG6o5DX4YHFVdBi1OBKFE5XfOYzKTDiOus6f5w4iIywmCVkUngTtOvGuPPPU65tqQSZMyLBu4hQG876t9aXsGjId+nFiECIw7EKYo0QcOJmTePNxp8+Bz0T3EgN1OcQc73BJxG5UMCsmxuJyyWccK2v3sMA5wTLzpNQPvo7gTJHOShCV1tjoiVGGeQf1y84BwT6DkENlGSHm16ymP9Hm642synucgFgVAB4p53elBfj9MChpoZTd/yy5DSSTnyD50qBIXekfP9AfvnznNWLXUHgLrarpwuwhD3IGiefHkfksPeNSrFoojIRc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF6E8103514F914D937DBB108B4EBADC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44035de5-5da5-42cc-1420-08d752256e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 10:41:41.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZIlpWmAMAIg3AJ+bXUixgj3fUkquxmTfpWoYk87ptc7F5OwaUfZmbb2+zX+db3wEG1invy546HohoisoqN+9LZCQa8oymGg/d4CsbxynGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5254
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_04:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160096
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gV2VkLCAyMDE5LTEwLTE2IGF0IDEwOjM4ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiBPbiAxNS0xMC0xOSwgMjM6MDYsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3
cm90ZToNCj4gDQo+ID4gPiA+IFRoaXMgRE1BIGNvbnRyb2xsZXIgaXMgYSBiaXQgc3BlY2lhbC4N
Cj4gPiA+ID4gSXQgZ2V0cyBzeW50aGVzaXplZCBpbiBGUEdBLCBzbyB0aGUgY29uZmlndXJhdGlv
biBpcyBmaXhlZCBhbmQNCj4gPiA+ID4gY2Fubm90IGJlDQo+ID4gPiA+IGNoYW5nZWQgYXQgcnVu
dGltZS4gTWF5YmUgbGF0ZXIgd2Ugd291bGQgYWxsb3cvaW1wbGVtZW50IHRoaXMNCj4gPiA+ID4g
ZnVuY3Rpb25hbGl0eSwgYnV0IHRoaXMgaXMgYSBxdWVzdGlvbiBmb3IgbXkgSERMIGNvbGxlYWd1
ZXMuDQo+ID4gPiA+IA0KPiA+ID4gPiBUd28gdGhpbmdzIGFyZSBkb25lIChpbiB0aGlzIG9yZGVy
KToNCj4gPiA+ID4gMS4gRm9yIHNvbWUgcGFyYW10ZXJzLCBheGlfZG1hY19wYXJzZV9jaGFuX2R0
KCkgaXMgdXNlZCB0bw0KPiA+ID4gPiBkZXRlcm1pbmUgdGhpbmdzDQo+ID4gPiA+IGZyb20gZGV2
aWNlLXRyZWU7IGFzIGl0J3MgYW4gRlBHQSBjb3JlLCB0aGluZ3MgYXJlIHN5bnRoZXNpemVkIG9u
Y2UNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IGNhbm5vdCBjaGFuZ2UgKHlldCkNCj4gPiA+ID4gMi4g
Rm9yIG90aGVyIHBhcmFtZXRlcnMsIHRoZSBheGlfZG1hY19kZXRlY3RfY2FwcygpIGlzIHVzZWQg
dG8NCj4gPiA+ID4gZ3Vlc3Mgc29tZQ0KPiA+ID4gPiBvZiB0aGVtIGF0IHByb2JlIHRpbWUsIGJ5
IGRvaW5nIHNvbWUgcmVnIHJlYWRzL3dyaXRlcw0KPiA+ID4gDQo+ID4gPiBTbyB0aGUgcXVlc3Rp
b24gZm9yIHlvdSBodyBmb2xrcyBpcyBob3cgd291bGQgYSBjb250cm9sbGVyIHdvcmsgd2l0aA0K
PiA+ID4gbXVsdGlwbGUgc2xhdmUgZGV2aWNlcywgZG8gdGhleSBuZWVkIHRvIHN5bnRoZXNpemUg
aXQgZXZlcnl0aW1lPw0KPiA+ID4gDQo+ID4gPiBSYXRoZXIgdGhhbiB0aGF0IHdoeSBjYW50IHRo
ZXkgbWFrZSB0aGUgcGVyaXBoZXJhbCBhZGRyZXNzZXMNCj4gPiA+IHByb2dyYW1tYWJsZSBzbyB0
aGF0IHlvdSBkb250IG5lZWQgdXBkYXRpbmcgZnBnYSBldmVyeXRpbWUhDQo+ID4gDQo+ID4gVGhl
IERNQSBoYXMgYSBkaXJlY3QgY29ubmVjdGlvbiB0byB0aGUgcGVyaXBoZXJhbCBhbmQgdGhlIHBl
cmlwaGVyYWwNCj4gPiBkYXRhIHBvcnQgaXMgbm90IGNvbm5lY3RlZCB0byB0aGUgZ2VuZXJhbCBw
dXJwb3NlIG1lbW9yeSBpbnRlcmNvbm5lY3QuDQo+ID4gU28geW91IGNhbid0IHdyaXRlIHRvIGl0
IGJ5IGFuIE1NSU8gYWRkcmVzcyBhbmQJIHRoZXJlIGlzIG5vDQo+ID4gYWRkcmVzcw0KPiA+IHRo
YXQgbmVlZHMgdG8gYmUgY29uZmlndXJlZC4gRm9yIGFuIEZQR0EgYmFzZWQgZGVzaWduIHRoaXMg
aXMgcXVpdGUgYQ0KPiA+IGdvb2Qgc29sdXRpb24gaW4gdGVybXMgb2YgcmVzb3VyY2UgdXNhZ2Us
IHBlcmZvcm1hbmNlIGFuZCBzaW1wbGljaXR5LiBBDQo+ID4gZGlyZWN0IGNvbm5lY3Rpb24gcmVx
dWlyZXMgbGVzcyByZXNvdXJjZXMgdGhhbiBjb25uZWN0aW9uIGl0IHRvIHRoZQ0KPiA+IGNlbnRy
YWwgbWVtb3J5IGludGVyY29ubmVjdCwgd2hpbGUgYXQgdGhlIHNhbWUgdGltZSBoYXZpbmcgbG93
ZXINCj4gPiBsYXRlbmN5DQo+ID4gYW5kIG5vdCBlYXRpbmcgdXAgYW55IGFkZGl0aW9uYWwgYmFu
ZHdpZHRoIG9uIHRoZSBjZW50cmFsIG1lbW9yeQ0KPiA+IGNvbm5lY3QuDQo+IA0KPiB0aGFua3Mg
Zm9yIGV4cGxhbmF0aW9uIQ0KDQphbHNvIG1hbnkgdGhhbmtzIFtmcm9tIG15IHNpZGVdIGZvciB0
aGUgZXhwbGFuYXRpb25zIDopDQoNCj4gDQo+ID4gU28gc2xhdmUgY29uZmlnIGluIHRoaXMgY2Fz
ZSBpcyBhIG5vb3AgYW5kIGFsbCBpdCBjYW4gZG8gaXMgdmVyaWZ5IHRoYXQNCj4gPiB0aGUgcmVx
dWVzdGVkIGNvbmZpZ3VyYXRpb24gbWF0Y2hlcyB0aGUgYXZhaWxhYmxlIGNvbmZpZ3VyYXRpb24u
DQo+IA0KPiBva2F5IHNvIG5vb3AgaXQgaXMhDQo+IA0K
