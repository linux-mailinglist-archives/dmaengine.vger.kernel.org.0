Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406D9E101C
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 04:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbfJWCi4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 22:38:56 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:57838
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730655AbfJWCi4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 22:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvIf9tCqHDlY+h/cW7leAU+20IRlX0SQ+2wjv7hwvtQQRps0fqjZjKsxLKkY0ekdU73y15RJmRlkqSNA+LFc3rqL/fU00Tv1XVzcK5N3ptojVENdgLGnKIGUG2L9mqjV3cwo1Je0QYb1rYlc7SVBBSnUnsSBtBhZjvmMgwSGpMV01cC+mV4ilmxxsUuo2Q0JV9kdYMzncB2lLt7TYTPmUEUIKhj6dSLJ87AVQjifuz/REy02+PEQg+QYPmneC5AI5kvybkM7XP82hKwdakCjCNJIzluBOfwLgj2mI668sX76XP14QrinxgnTbGJIlxfw3fGMRgygE3QTJIFCqiRZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S68jA/of1UD0/2HZUK8bkVRYB8oZB1nKc8WxpDjTzwY=;
 b=mOq/AtbnE/i47EydYOf+gn+md47TlSzbYz7M4rYiW6TeSsNR1y6bRcG7lxQ5fnDuQTv2xhy7MJHFVshv6YhGaztgUb78BH4TsQgd2a76f3ZEHbn3WEKO32b8XpjpdjSx7qqBUjVxNQkI6VFX3cUViKHSYlm43Ya+vgoajzuERXl39dA+N7OYwbNH9nMs6dNnre3yEakjzgCzxcyi27Dw4pt/U8VVWSzsCJFD8dDiXICZ8Tv8JmjThasCtvuaT1AqCzkDSPtWdSwp/Hs61Sk0/qa4ujxpaYcPKeqHfOONgSo3to0HdDw3lI7S70FmmZRYoQsgARGVopWJzgHlc6G5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S68jA/of1UD0/2HZUK8bkVRYB8oZB1nKc8WxpDjTzwY=;
 b=cYnmPsdJgsI7NLXb7d6rd7TPrbT91xRENmbU/MHHKA2Lm8y4X2cXZcVvgDNARVTmrYjNy2vN9H2jyvjgk2/YXa5DSt+mAUd9hyv70p8qRLSJ+UDotB7gXAxRold47xPVtAAIVqj8El7et5c9j0LIcRdYHTdea7X6U1UKqhsVKpw=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB5214.eurprd04.prod.outlook.com (20.177.52.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 02:38:50 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb%6]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 02:38:50 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Anders Roxell <anders.roxell@linaro.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data
 Path DMA Interface) support
Thread-Topic: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
Thread-Index: AQHVdzToZ1j6dYgSekKOe10vHO0HB6deU3YAgAAhjWCACBJZgIAADhxwgABihQCAAK1vgA==
Date:   Wed, 23 Oct 2019 02:38:50 +0000
Message-ID: <VI1PR04MB4431F221997731B3032CEA37ED6B0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190930020440.7754-1-peng.ma@nxp.com>
 <20191017041124.GN2654@vkoul-mobl>
 <AM0PR04MB44207F0EF575C5FB44DA6984ED6D0@AM0PR04MB4420.eurprd04.prod.outlook.com>
 <CADYN=9JkQMawVnLoJ8sXAbV8NB_BK0zQA0PomJ583Agj12r8Cg@mail.gmail.com>
 <VI1PR04MB443121007853185039A65534ED680@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20191022161020.GM2654@vkoul-mobl>
In-Reply-To: <20191022161020.GM2654@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ec2ec38-c0c2-4482-c961-08d75762236c
x-ms-traffictypediagnostic: VI1PR04MB5214:|VI1PR04MB5214:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB521405E47ECAC44F22B6DF5FED6B0@VI1PR04MB5214.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(13464003)(25786009)(54906003)(316002)(5024004)(33656002)(14444005)(256004)(2906002)(66066001)(7696005)(71190400001)(71200400001)(6916009)(76176011)(6246003)(26005)(966005)(99286004)(186003)(4326008)(102836004)(229853002)(9686003)(45080400002)(6436002)(14454004)(305945005)(7736002)(6116002)(6506007)(3846002)(55016002)(6306002)(486006)(74316002)(476003)(66446008)(8936002)(11346002)(81156014)(478600001)(76116006)(64756008)(66476007)(81166006)(8676002)(66556008)(86362001)(52536014)(5660300002)(446003)(66946007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5214;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+8G/5EXezhA7RSqDu90UakUpsKgERKNKM2aXZj82TXkmlKgD2ZCszlIAIWNw7UzQqMU6ZFvf3/Gdy6I/ToTDhKv/2nREDjTzt/aJmUYnDJ0PXskJ4F67TjURybuFZWWfsn3IgpoXcBgqcNSCIgqNt0vV3B/Jckj2rn1Pc8ZNC+lPEPkuaOQN7a9yWs2hEjRPfIOzqg3MtZ4jB8yPFlEEHJ+fX1LXr/yuX6SLcJYYgdDY/yl1VKHfoR/zSvqI5dTY298UBPaD/e9oMoagxcRcpTvi0HD3ti0yRk9O3GkrsDi2Uke7gFPK+3r0pSXG1qA/DuqvSxbWTFUJKXeGfytcQjDz8UhElcTIpKfJc2huQtaPBDwe1Z56wsJ4u2bEhDuE2kHrw9rQvDuH2BXI4G0KbI+y2ZMKgUTKg8k1QdYgjCDEt/vlrNrU3TiuaUcPmesrJzo13CHlNFQVm9NXsy00JQhRJ3u0MUCES+5Nj4lsgg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec2ec38-c0c2-4482-c961-08d75762236c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 02:38:50.8058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HcW52FWR5CT0dIR+bP2C87s7aEfgFhYsj7oNER+ysdnTHvkrxcwtvXoHz4N5Tkkh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5214
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtv
dWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOeW5tDEw5pyIMjPml6UgMDoxMA0KPlRv
OiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+Q2M6IEFuZGVycyBSb3hlbGwgPGFuZGVycy5y
b3hlbGxAbGluYXJvLm9yZz47IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgTGVvIExpDQo+PGxl
b3lhbmcubGlAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ZG1hZW5n
aW5lQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1Y1IDEvMl0gZG1h
ZW5naW5lOiBmc2wtZHBhYTItcWRtYTogQWRkIHRoZQ0KPkRQRE1BSShEYXRhIFBhdGggRE1BIElu
dGVyZmFjZSkgc3VwcG9ydA0KPg0KPkNhdXRpb246IEVYVCBFbWFpbA0KPg0KPlBsZWFzZSAqZG8q
ICpub3QqIHRvcCBwb3N0IQ0KPg0KPk9uIDIyLTEwLTE5LCAxMDoxOSwgUGVuZyBNYSB3cm90ZToN
Cj4+IEhpIEFuZGVycyAmJiBWaW9kLA0KPg0KPkl0cyBWaW5vZCENCj4NCltQZW5nIE1hXSBJIGFt
IHZlcnkgc29ycnkgdG8gc3BlbGwgeW91ciBuYW1lIHdyb25nLCBJIHdpbGwgcGF5IGF0dGVudGlv
biB0byBmcm9tIG5vdyENCj4+DQo+PiBJIHNlbnQgdjYgcGF0Y2ggdG8gZml4IHRoZSBidWlsZCBl
cnJvciwgcGxlYXNlIGNoZWNrLg0KPj4gUGF0Y2h3b3JrIGxpbms6DQo+PiBodHRwczovL2V1cjAx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRj
DQo+Pg0KPmh3b3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgtZG1hZW5naW5lJTJGbGlz
dCUyRiUzRnNlcmllcyUzRDE5MQ0KPjMNCj4+DQo+OTcmYW1wO2RhdGE9MDIlN0MwMSU3Q3Blbmcu
bWElNDBueHAuY29tJTdDMTlhYzQ3ZDYwNWJmNDRhYTk5ZA0KPmUwOGQ3NTcwYQ0KPj4NCj41ZTY0
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzA3MzU3NDM1
MQ0KPjc4NjcyMyZhDQo+Pg0KPm1wO3NkYXRhPSUyQiUyRmF6VnVQTUpaVW9uZnZ6OGdMV0dWZWFr
S1cwdFJGWXlqajM0NEliRGc0JTNEJmFtDQo+cDtyZXNlcnYNCj4+IGVkPTANCj4NCj5ObyBJIGhh
dmUgYWxyZWFkeSBhcHBsaWVkIHY1LCBwbGVhc2Ugc2VuZCBmaXhlcyBvbiB0b3Agb24gZG1hZW5n
aW5lLW5leHQhDQo+V291bGQgYWxzbyBtYWtlIHNlbnNlIHRvIGdpdmUgY3JlZGl0IHRvIEFuZGVy
cyB1c2luZyBSZXBvcnRlZC1ieSB0YWcNCj4NCltQZW5nIE1hXSBPaywgR290IGl0Lg0KVGhlIHBh
dGNod29yayBsaW5rOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTIwNTYx
MS8NCj4+DQo+PiBCZXN0IFJlZ2FyZHMsDQo+PiBQZW5nDQo+PiA+LS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+ID5Gcm9tOiBBbmRlcnMgUm94ZWxsIDxhbmRlcnMucm94ZWxsQGxpbmFyby5v
cmc+DQo+PiA+U2VudDogMjAxOeW5tDEw5pyIMjLml6UgMTc6MjcNCj4+ID5UbzogUGVuZyBNYSA8
cGVuZy5tYUBueHAuY29tPg0KPj4gPkNjOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3JnPjsg
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBMZW8gTGkNCj4+ID48bGVveWFuZy5saUBueHAuY29t
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4+ID5kbWFlbmdpbmVAdmdlci5rZXJu
ZWwub3JnDQo+PiA+U3ViamVjdDogUmU6IFtFWFRdIFJlOiBbVjUgMS8yXSBkbWFlbmdpbmU6IGZz
bC1kcGFhMi1xZG1hOiBBZGQgdGhlDQo+PiA+RFBETUFJKERhdGEgUGF0aCBETUEgSW50ZXJmYWNl
KSBzdXBwb3J0DQo+PiA+DQo+PiA+Q2F1dGlvbjogRVhUIEVtYWlsDQo+PiA+DQo+PiA+T24gVGh1
LCAxNyBPY3QgMjAxOSBhdCAwODoxNiwgUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPiB3cm90ZToN
Cj4+ID4+DQo+PiA+PiBIaSBWaW5vZCwNCj4+ID4+DQo+PiA+PiBUaGFua3MgdmVyeSBtdWNoIGZv
ciB5b3VyIHJlcGx5Lg0KPj4gPj4NCj4+ID4+IEJlc3QgUmVnYXJkcywNCj4+ID4+IFBlbmcNCj4+
ID4+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPj4gPkZyb206IFZpbm9kIEtvdWwg
PHZrb3VsQGtlcm5lbC5vcmc+DQo+PiA+PiA+U2VudDogMjAxOeW5tDEw5pyIMTfml6UgMTI6MTEN
Cj4+ID4+ID5UbzogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPj4gPj4gPkNjOiBkYW4uai53
aWxsaWFtc0BpbnRlbC5jb207IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4+ID4+ID5s
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnDQo+
PiA+PiA+U3ViamVjdDogW0VYVF0gUmU6IFtWNSAxLzJdIGRtYWVuZ2luZTogZnNsLWRwYWEyLXFk
bWE6IEFkZCB0aGUNCj4+ID4+ID5EUERNQUkoRGF0YSBQYXRoIERNQSBJbnRlcmZhY2UpIHN1cHBv
cnQNCj4+ID4+ID4NCj4+ID4+ID5DYXV0aW9uOiBFWFQgRW1haWwNCj4+ID4+ID4NCj4+ID4+ID5P
biAzMC0wOS0xOSwgMDI6MDQsIFBlbmcgTWEgd3JvdGU6DQo+PiA+PiA+PiBUaGUgTUMoTWFuYWdl
bWVudCBDb21wbGV4KSBleHBvcnRzIHRoZSBEUERNQUkoRGF0YSBQYXRoIERNQQ0KPj4gPj4gPklu
dGVyZmFjZSkNCj4+ID4+ID4+IG9iamVjdCBhcyBhbiBpbnRlcmZhY2UgdG8gb3BlcmF0ZSB0aGUg
RFBBQTIoRGF0YSBQYXRoDQo+PiA+PiA+PiBBY2NlbGVyYXRpb24gQXJjaGl0ZWN0dXJlIDIpIHFE
TUEgRW5naW5lLiBUaGUgRFBETUFJIGVuYWJsZXMNCj4+ID4+ID4+IHNlbmRpbmcgZnJhbWUtYmFz
ZWQgcmVxdWVzdHMgdG8gcURNQSBhbmQgcmVjZWl2aW5nIGJhY2sNCj4+ID4+ID4+IGNvbmZpcm1h
dGlvbiByZXNwb25zZSBvbiB0cmFuc2FjdGlvbiBjb21wbGV0aW9uLCB1dGlsaXppbmcgdGhlDQo+
PiA+PiA+PiBEUEFBMiBRQk1hbihRdWV1ZSBNYW5hZ2VyIGFuZCBCdWZmZXIgTWFuYWdlcg0KPj4g
Pj4gPj4gaGFyZHdhcmUpIGluZnJhc3RydWN0dXJlLiBEUERNQUkgb2JqZWN0IHByb3ZpZGVzIHVw
IHRvIHR3bw0KPj4gPj4gPj4gcHJpb3JpdGllcyBmb3IgcHJvY2Vzc2luZyBxRE1BIHJlcXVlc3Rz
Lg0KPj4gPj4gPj4gVGhlIGZvbGxvd2luZyBsaXN0IHN1bW1hcml6ZXMgdGhlIERQRE1BSSBtYWlu
IGZlYXR1cmVzIGFuZA0KPmNhcGFiaWxpdGllczoNCj4+ID4+ID4+ICAgICAgIDEuIFN1cHBvcnRz
IHVwIHRvIHR3byBzY2hlZHVsaW5nIHByaW9yaXRpZXMgZm9yIHByb2Nlc3NpbmcNCj4+ID4+ID4+
ICAgICAgIHNlcnZpY2UgcmVxdWVzdHMuDQo+PiA+PiA+PiAgICAgICAtIEVhY2ggRFBETUFJIHRy
YW5zbWl0IHF1ZXVlIGlzIG1hcHBlZCB0byBvbmUgb2YgdHdvDQo+c2VydmljZQ0KPj4gPj4gPj4g
ICAgICAgcHJpb3JpdGllcywgYWxsb3dpbmcgZnVydGhlciBwcmlvcml0aXphdGlvbiBpbiBoYXJk
d2FyZSBiZXR3ZWVuDQo+PiA+PiA+PiAgICAgICByZXF1ZXN0cyBmcm9tIGRpZmZlcmVudCBEUERN
QUkgb2JqZWN0cy4NCj4+ID4+ID4+ICAgICAgIDIuIFN1cHBvcnRzIHVwIHRvIHR3byByZWNlaXZl
IHF1ZXVlcyBmb3IgaW5jb21pbmcgdHJhbnNhY3Rpb24NCj4+ID4+ID4+ICAgICAgIGNvbXBsZXRp
b24gY29uZmlybWF0aW9ucy4NCj4+ID4+ID4+ICAgICAgIC0gRWFjaCBEUERNQUkgcmVjZWl2ZSBx
dWV1ZSBpcyBtYXBwZWQgdG8gb25lIG9mIHR3byByZWNlaXZlDQo+PiA+PiA+PiAgICAgICBwcmlv
cml0aWVzLCBhbGxvd2luZyBmdXJ0aGVyIHByaW9yaXRpemF0aW9uIGJldHdlZW4gb3RoZXINCj4+
ID4+ID4+ICAgICAgIGludGVyZmFjZXMgd2hlbiBhc3NvY2lhdGluZyB0aGUgRFBETUFJIHJlY2Vp
dmUgcXVldWVzIHRvDQo+RFBJTw0KPj4gPj4gPj4gICAgICAgb3IgRFBDT04oRGF0YSBQYXRoIENv
bmNlbnRyYXRvcikgb2JqZWN0cy4NCj4+ID4+ID4+ICAgICAgIDMuIFN1cHBvcnRzIGRpZmZlcmVu
dCBzY2hlZHVsaW5nIG9wdGlvbnMgZm9yIHByb2Nlc3NpbmcNCj5yZWNlaXZlZA0KPj4gPj4gPj4g
ICAgICAgcGFja2V0czoNCj4+ID4+ID4+ICAgICAgIC0gUXVldWVzIGNhbiBiZSBjb25maWd1cmVk
IGVpdGhlciBpbiAncGFya2VkJyBtb2RlIChkZWZhdWx0KSwNCj4+ID4+ID4+ICAgICAgIG9yIGF0
dGFjaGVkIHRvIGEgRFBJTyBvYmplY3QsIG9yIGF0dGFjaGVkIHRvIERQQ09OIG9iamVjdC4NCj4+
ID4+ID4+ICAgICAgIDQuIEFsbG93cyBpbnRlcmFjdGlvbiB3aXRoIG9uZSBvciBtb3JlIERQSU8g
b2JqZWN0cyBmb3INCj4+ID4+ID4+ICAgICAgIGRlcXVldWVpbmcvZW5xdWV1ZWluZyBmcmFtZSBk
ZXNjcmlwdG9ycyhGRCkgYW5kIGZvcg0KPj4gPj4gPj4gICAgICAgYWNxdWlyaW5nL3JlbGVhc2lu
ZyBidWZmZXJzLg0KPj4gPj4gPj4gICAgICAgNS4gU3VwcG9ydHMgZW5hYmxlLCBkaXNhYmxlLCBh
bmQgcmVzZXQgb3BlcmF0aW9ucy4NCj4+ID4+ID4+DQo+PiA+PiA+PiBBZGQgZHBkbWFpIHRvIHN1
cHBvcnQgc29tZSBwbGF0Zm9ybXMgd2l0aCBkcGFhMiBxZG1hIGVuZ2luZS4NCj4+ID4+ID4NCj4+
ID4+ID5BcHBsaWVkIGJvdGgsIHRoYW5rcw0KPj4gPg0KPj4gPkkgc2VlIHRoaXMgZXJyb3Igd2hl
biBJJ20gYnVpbGRpbmcuDQo+PiA+DQo+PiA+V0FSTklORzogbW9kcG9zdDogbWlzc2luZyBNT0RV
TEVfTElDRU5TRSgpIGluDQo+PiA+ZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBkbWFpLm8N
Cj4+ID5zZWUgaW5jbHVkZS9saW51eC9tb2R1bGUuaCBmb3IgbW9yZSBpbmZvcm1hdGlvbg0KPj4g
PkVSUk9SOiAiZHBkbWFpX2VuYWJsZSIgW2RyaXZlcnMvZG1hL2ZzbC1kcGFhMi1xZG1hL2RwYWEy
LXFkbWEua29dDQo+PiA+dW5kZWZpbmVkIQ0KPj4gPkVSUk9SOiAiZHBkbWFpX3NldF9yeF9xdWV1
ZSINCj4+ID5bZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10gdW5kZWZp
bmVkIQ0KPj4gPkVSUk9SOiAiZHBkbWFpX2dldF90eF9xdWV1ZSINCj4+ID5bZHJpdmVycy9kbWEv
ZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10gdW5kZWZpbmVkIQ0KPj4gPkVSUk9SOiAiZHBk
bWFpX2dldF9yeF9xdWV1ZSINCj4+ID5bZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTIt
cWRtYS5rb10gdW5kZWZpbmVkIQ0KPj4gPkVSUk9SOiAiZHBkbWFpX2dldF9hdHRyaWJ1dGVzIg0K
Pj4gPltkcml2ZXJzL2RtYS9mc2wtZHBhYTItcWRtYS9kcGFhMi1xZG1hLmtvXSB1bmRlZmluZWQh
DQo+PiA+RVJST1I6ICJkcGRtYWlfb3BlbiIgW2RyaXZlcnMvZG1hL2ZzbC1kcGFhMi1xZG1hL2Rw
YWEyLXFkbWEua29dDQo+PiA+dW5kZWZpbmVkIQ0KPj4gPkVSUk9SOiAiZHBkbWFpX2Nsb3NlIiBb
ZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10NCj4+ID51bmRlZmluZWQh
DQo+PiA+RVJST1I6ICJkcGRtYWlfZGlzYWJsZSIgW2RyaXZlcnMvZG1hL2ZzbC1kcGFhMi1xZG1h
L2RwYWEyLXFkbWEua29dDQo+PiA+dW5kZWZpbmVkIQ0KPj4gPkVSUk9SOiAiZHBkbWFpX3Jlc2V0
IiBbZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10NCj4+ID51bmRlZmlu
ZWQhDQo+PiA+bWFrZVsyXTogKioqIFsuLi9zY3JpcHRzL01ha2VmaWxlLm1vZHBvc3Q6OTU6IF9f
bW9kcG9zdF0gRXJyb3IgMQ0KPj4gPm1ha2VbMV06ICoqKiBbL3Nydi9zcmMva2VybmVsL25leHQv
TWFrZWZpbGU6MTI4MjogbW9kdWxlc10gRXJyb3IgMg0KPj4gPm1ha2U6ICoqKiBbTWFrZWZpbGU6
MTc5OiBzdWItbWFrZV0gRXJyb3IgMg0KPj4gPm1ha2U6IFRhcmdldCAnSW1hZ2UnIG5vdCByZW1h
ZGUgYmVjYXVzZSBvZiBlcnJvcnMuDQo+PiA+bWFrZTogVGFyZ2V0ICdtb2R1bGVzJyBub3QgcmVt
YWRlIGJlY2F1c2Ugb2YgZXJyb3JzLg0KPj4gPg0KPj4gPmFueSBvdGhlciB0aGF0IHNlZSB0aGUg
c2FtZSA/DQo+PiA+DQo+PiA+Q2hlZXJzLA0KPj4gPkFuZGVycw0KPg0KPi0tDQo+flZpbm9kDQo=
