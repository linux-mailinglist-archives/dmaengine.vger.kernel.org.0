Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 812E6E102E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2019 04:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbfJWCoc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 22:44:32 -0400
Received: from mail-eopbgr40071.outbound.protection.outlook.com ([40.107.4.71]:7495
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389296AbfJWCoc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 22:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTcijFuI1qsB2JqRIaApnDf4MJGccm04kfPamLvju7anHX4Isasv5jhIXf1+YnGFSd/ibf4qR6dE+gtvyoyMdwxHsNqoWx9HaWt5dnhwuFs62IQa+FOkyPdBKkpFhz03Cu6d84lAIEQy5U5xS8inR/wWxmokJp4dWKzDI1w6lMYurnAVLjxRHpQPKh/ijiApqPabPXpc+W6KglSdWdsUskHoVKx0AwrPk2RJ06/BqBeEZdQ9BrgT5WmNZG29AKoicf+LXC8AOqEeNBynRnMYWD4UrX30/TARbJ2YhoyoE2bFKKj6rKpcr2Y6l98lKnfiDPE2PPe3FgntkZTaGl1XBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeLNrCXulEd87DC8cv0ieptEIRDGKsYGodKPb4O21X0=;
 b=m1X+FXGTDFH69XweHlZ+vJVunc5zL7QdQ7svlsdNjy1KkJzUQoCua2xnoSbKEms2/R/pfBCXY1bsqQ8RLxc2bcze40J+cTQsyih3ie689ypqf3cud2wT6VhONOXhxnHG5xNfJYFH54Qn97s/iLWdJnR8gJcnbG5fxLdrPgAn78LuTGA0qgh8sk7gsTcoY5O3Pjr8MwW0SNPAvIraJMGusBSFdKz+LCGXjx8aJO1RcBrYELYfperpykOagbLsPE8sJd4OGkgo2J9k/psAObdG0tRX+pQT7uzbj5JpfFfq9dUskWLXQa4k+MLoWDbnxRIb5xx7rlfIAhjYhTMfoeNV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeLNrCXulEd87DC8cv0ieptEIRDGKsYGodKPb4O21X0=;
 b=H/WiW/Xjf15M8VAlTU6k+ieSsIvODAHmwxurYhWiGkSQw3oMxzdn9dJRnFyLugxWBNocWhrbf3UkLFQenNOBWxXLOLj21hxvzACCQypXYZpGM9K9oc6YFW/fQbJNCn2B7MHLBjWCoExfBiisvOlXvlcjFDW6iKpQ5v/86e1IjL8=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.205) by
 VI1PR04MB5214.eurprd04.prod.outlook.com (20.177.52.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 02:44:26 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::7cba:52d6:9ae9:e5bb%6]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 02:44:26 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Anders Roxell <anders.roxell@linaro.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the DPDMAI(Data
 Path DMA Interface) support
Thread-Topic: [EXT] Re: [V5 1/2] dmaengine: fsl-dpaa2-qdma: Add the
 DPDMAI(Data Path DMA Interface) support
Thread-Index: AQHVdzToZ1j6dYgSekKOe10vHO0HB6deU3YAgAAhjWCACBJZgIAADhxwgAAOyoCAAQOL0A==
Date:   Wed, 23 Oct 2019 02:44:26 +0000
Message-ID: <VI1PR04MB44311BA49D0FBB6A40EFD8DEED6B0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190930020440.7754-1-peng.ma@nxp.com>
 <20191017041124.GN2654@vkoul-mobl>
 <AM0PR04MB44207F0EF575C5FB44DA6984ED6D0@AM0PR04MB4420.eurprd04.prod.outlook.com>
 <CADYN=9JkQMawVnLoJ8sXAbV8NB_BK0zQA0PomJ583Agj12r8Cg@mail.gmail.com>
 <VI1PR04MB443121007853185039A65534ED680@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20191022111039.GA8762@localhost.localdomain>
In-Reply-To: <20191022111039.GA8762@localhost.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 606eda0a-7ffd-4a05-9cd7-08d75762eba0
x-ms-traffictypediagnostic: VI1PR04MB5214:|VI1PR04MB5214:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB52147EFA69A8A719FD2907FBED6B0@VI1PR04MB5214.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(189003)(199004)(13464003)(25786009)(54906003)(316002)(5024004)(33656002)(14444005)(4001150100001)(256004)(2906002)(66066001)(7696005)(71190400001)(71200400001)(6916009)(76176011)(6246003)(26005)(966005)(99286004)(186003)(4326008)(102836004)(229853002)(9686003)(45080400002)(6436002)(14454004)(305945005)(7736002)(6116002)(6506007)(3846002)(55016002)(6306002)(486006)(74316002)(476003)(66446008)(8936002)(11346002)(81156014)(478600001)(76116006)(64756008)(66476007)(81166006)(8676002)(66556008)(86362001)(52536014)(5660300002)(446003)(66946007)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5214;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W9++03LNNUydm189TtgELKsozwrDLwyuIB6sZETmS/gx3hpcWHxovr7tWoBBVw3nWh+CaI5Wlsusksje7+XdeDNXCsm/70AXa7ZqnbdMnar82epG6K8BkTrYFFFRMQkw3pbNxRRsuPEts4mts//ZP8GX4AoUumqyh6kyXHsutQKJt7DHhfEAVOLFjMiCsLSMts4bzRaJn5XKC4BQX0tH+oqeL80TdXvaHxVBDaS59B0poUAV0US7VRV9lE4sZ851aBEm3iwYc/ue9Vr64vyV9CpsT/tzrlKSGtZKGerRMV2W3MdUMSgtAea2GSBAW4fZUvBi+iBvV/9iA5HNo+s0rkn0cPoAE1uAL+WlIyioeTlM2rf2mhpVr/K66V4JqDya93U+msR8bUhVcUoVANdcl2td3xjXt6Ck4xiJkC/Jn3nx2mREn/qqejhyBft67LO+od2oCV6b4R1hbmYDpj2OsZDy65oFizpUAAZFTJ8rP8s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606eda0a-7ffd-4a05-9cd7-08d75762eba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 02:44:26.6738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QReTWk5pFGRFXJFDbBDnU3RmLQj0S0W8+9A05/fegIwqua7hRp/6xM2TSWFgm+ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5214
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgQW5kZXJzLA0KDQpUaGUgZml4ZWQgcGF0Y2ggbGluayBhcyBmb2xsb3dzOg0KaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MTAyMzAyMTk1OS4zNTU5Ni0xLXBlbmcubWFAbnhwLmNv
bS8NClBsZWFzZSBjaGVjayBpdC4NCg0KQmVzdCBSZWdhcmRzLA0KUGVuZw0KPi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVsbEBsaW5h
cm8ub3JnPg0KPlNlbnQ6IDIwMTnlubQxMOaciDIy5pelIDE5OjExDQo+VG86IFBlbmcgTWEgPHBl
bmcubWFAbnhwLmNvbT4NCj5DYzogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47IGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbTsgTGVvIExpDQo+PGxlb3lhbmcubGlAbnhwLmNvbT47IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPlN1
YmplY3Q6IFJlOiBbRVhUXSBSZTogW1Y1IDEvMl0gZG1hZW5naW5lOiBmc2wtZHBhYTItcWRtYTog
QWRkIHRoZQ0KPkRQRE1BSShEYXRhIFBhdGggRE1BIEludGVyZmFjZSkgc3VwcG9ydA0KPg0KPkNh
dXRpb246IEVYVCBFbWFpbA0KPg0KPk9uIDIwMTktMTAtMjIgMTA6MTksIFBlbmcgTWEgd3JvdGU6
DQo+PiBIaSBBbmRlcnMgJiYgVmlvZCwNCj4+DQo+PiBJIHNlbnQgdjYgcGF0Y2ggdG8gZml4IHRo
ZSBidWlsZCBlcnJvciwgcGxlYXNlIGNoZWNrLg0KPg0KPm9oIEkgd2lsbCBjaGVjaywgZGlkbid0
IHNlZSB0aGVtIHdoZW4gSSBzZW50IG91dCBteSBlbWFpbC4gPS8NCj4NCj5DaGVlcnMsDQo+QW5k
ZXJzDQo+DQo+PiBQYXRjaHdvcmsgbGluazoNCj4+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGMNCj4+DQo+aHdvcmsu
a2VybmVsLm9yZyUyRnByb2plY3QlMkZsaW51eC1kbWFlbmdpbmUlMkZsaXN0JTJGJTNGc2VyaWVz
JTNEMTkxDQo+Mw0KPj4NCj45NyZhbXA7ZGF0YT0wMiU3QzAxJTdDcGVuZy5tYSU0MG54cC5jb20l
N0M3ZjIwMTk2NmRkNzQ0NzAzZGQ0DQo+YzA4ZDc1NmU4DQo+Pg0KPjE5YTIlN0M2ODZlYTFkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MDczNDI3MTc2DQo+NjU0NjE3JmEN
Cj4+DQo+bXA7c2RhdGE9JTJGc2cwaU9oQkRDcXJUekR4UzBXUG1Rb0VtcSUyQnJ2YnBaZDd4eXRs
b0g0ODQlM0QmYQ0KPm1wO3Jlc2Vydg0KPj4gZWQ9MA0KPj4NCj4+IEJlc3QgUmVnYXJkcywNCj4+
IFBlbmcNCj4+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPkZyb206IEFuZGVycyBS
b3hlbGwgPGFuZGVycy5yb3hlbGxAbGluYXJvLm9yZz4NCj4+ID5TZW50OiAyMDE55bm0MTDmnIgy
MuaXpSAxNzoyNw0KPj4gPlRvOiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+PiA+Q2M6IFZp
bm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb207IExl
byBMaQ0KPj4gPjxsZW95YW5nLmxpQG54cC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPj4gPmRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcNCj4+ID5TdWJqZWN0OiBSZTogW0VY
VF0gUmU6IFtWNSAxLzJdIGRtYWVuZ2luZTogZnNsLWRwYWEyLXFkbWE6IEFkZCB0aGUNCj4+ID5E
UERNQUkoRGF0YSBQYXRoIERNQSBJbnRlcmZhY2UpIHN1cHBvcnQNCj4+ID4NCj4+ID5DYXV0aW9u
OiBFWFQgRW1haWwNCj4+ID4NCj4+ID5PbiBUaHUsIDE3IE9jdCAyMDE5IGF0IDA4OjE2LCBQZW5n
IE1hIDxwZW5nLm1hQG54cC5jb20+IHdyb3RlOg0KPj4gPj4NCj4+ID4+IEhpIFZpbm9kLA0KPj4g
Pj4NCj4+ID4+IFRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlvdXIgcmVwbHkuDQo+PiA+Pg0KPj4gPj4g
QmVzdCBSZWdhcmRzLA0KPj4gPj4gUGVuZw0KPj4gPj4gPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+PiA+PiA+RnJvbTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj4+ID4+ID5T
ZW50OiAyMDE55bm0MTDmnIgxN+aXpSAxMjoxMQ0KPj4gPj4gPlRvOiBQZW5nIE1hIDxwZW5nLm1h
QG54cC5jb20+DQo+PiA+PiA+Q2M6IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsgTGVvIExpIDxs
ZW95YW5nLmxpQG54cC5jb20+Ow0KPj4gPj4gPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcNCj4+ID4+ID5TdWJqZWN0OiBbRVhUXSBSZTogW1Y1
IDEvMl0gZG1hZW5naW5lOiBmc2wtZHBhYTItcWRtYTogQWRkIHRoZQ0KPj4gPj4gPkRQRE1BSShE
YXRhIFBhdGggRE1BIEludGVyZmFjZSkgc3VwcG9ydA0KPj4gPj4gPg0KPj4gPj4gPkNhdXRpb246
IEVYVCBFbWFpbA0KPj4gPj4gPg0KPj4gPj4gPk9uIDMwLTA5LTE5LCAwMjowNCwgUGVuZyBNYSB3
cm90ZToNCj4+ID4+ID4+IFRoZSBNQyhNYW5hZ2VtZW50IENvbXBsZXgpIGV4cG9ydHMgdGhlIERQ
RE1BSShEYXRhIFBhdGggRE1BDQo+PiA+PiA+SW50ZXJmYWNlKQ0KPj4gPj4gPj4gb2JqZWN0IGFz
IGFuIGludGVyZmFjZSB0byBvcGVyYXRlIHRoZSBEUEFBMihEYXRhIFBhdGgNCj4+ID4+ID4+IEFj
Y2VsZXJhdGlvbiBBcmNoaXRlY3R1cmUgMikgcURNQSBFbmdpbmUuIFRoZSBEUERNQUkgZW5hYmxl
cw0KPj4gPj4gPj4gc2VuZGluZyBmcmFtZS1iYXNlZCByZXF1ZXN0cyB0byBxRE1BIGFuZCByZWNl
aXZpbmcgYmFjaw0KPj4gPj4gPj4gY29uZmlybWF0aW9uIHJlc3BvbnNlIG9uIHRyYW5zYWN0aW9u
IGNvbXBsZXRpb24sIHV0aWxpemluZyB0aGUNCj4+ID4+ID4+IERQQUEyIFFCTWFuKFF1ZXVlIE1h
bmFnZXIgYW5kIEJ1ZmZlciBNYW5hZ2VyDQo+PiA+PiA+PiBoYXJkd2FyZSkgaW5mcmFzdHJ1Y3R1
cmUuIERQRE1BSSBvYmplY3QgcHJvdmlkZXMgdXAgdG8gdHdvDQo+PiA+PiA+PiBwcmlvcml0aWVz
IGZvciBwcm9jZXNzaW5nIHFETUEgcmVxdWVzdHMuDQo+PiA+PiA+PiBUaGUgZm9sbG93aW5nIGxp
c3Qgc3VtbWFyaXplcyB0aGUgRFBETUFJIG1haW4gZmVhdHVyZXMgYW5kDQo+Y2FwYWJpbGl0aWVz
Og0KPj4gPj4gPj4gICAgICAgMS4gU3VwcG9ydHMgdXAgdG8gdHdvIHNjaGVkdWxpbmcgcHJpb3Jp
dGllcyBmb3IgcHJvY2Vzc2luZw0KPj4gPj4gPj4gICAgICAgc2VydmljZSByZXF1ZXN0cy4NCj4+
ID4+ID4+ICAgICAgIC0gRWFjaCBEUERNQUkgdHJhbnNtaXQgcXVldWUgaXMgbWFwcGVkIHRvIG9u
ZSBvZiB0d28NCj5zZXJ2aWNlDQo+PiA+PiA+PiAgICAgICBwcmlvcml0aWVzLCBhbGxvd2luZyBm
dXJ0aGVyIHByaW9yaXRpemF0aW9uIGluIGhhcmR3YXJlIGJldHdlZW4NCj4+ID4+ID4+ICAgICAg
IHJlcXVlc3RzIGZyb20gZGlmZmVyZW50IERQRE1BSSBvYmplY3RzLg0KPj4gPj4gPj4gICAgICAg
Mi4gU3VwcG9ydHMgdXAgdG8gdHdvIHJlY2VpdmUgcXVldWVzIGZvciBpbmNvbWluZyB0cmFuc2Fj
dGlvbg0KPj4gPj4gPj4gICAgICAgY29tcGxldGlvbiBjb25maXJtYXRpb25zLg0KPj4gPj4gPj4g
ICAgICAgLSBFYWNoIERQRE1BSSByZWNlaXZlIHF1ZXVlIGlzIG1hcHBlZCB0byBvbmUgb2YgdHdv
IHJlY2VpdmUNCj4+ID4+ID4+ICAgICAgIHByaW9yaXRpZXMsIGFsbG93aW5nIGZ1cnRoZXIgcHJp
b3JpdGl6YXRpb24gYmV0d2VlbiBvdGhlcg0KPj4gPj4gPj4gICAgICAgaW50ZXJmYWNlcyB3aGVu
IGFzc29jaWF0aW5nIHRoZSBEUERNQUkgcmVjZWl2ZSBxdWV1ZXMgdG8NCj5EUElPDQo+PiA+PiA+
PiAgICAgICBvciBEUENPTihEYXRhIFBhdGggQ29uY2VudHJhdG9yKSBvYmplY3RzLg0KPj4gPj4g
Pj4gICAgICAgMy4gU3VwcG9ydHMgZGlmZmVyZW50IHNjaGVkdWxpbmcgb3B0aW9ucyBmb3IgcHJv
Y2Vzc2luZw0KPnJlY2VpdmVkDQo+PiA+PiA+PiAgICAgICBwYWNrZXRzOg0KPj4gPj4gPj4gICAg
ICAgLSBRdWV1ZXMgY2FuIGJlIGNvbmZpZ3VyZWQgZWl0aGVyIGluICdwYXJrZWQnIG1vZGUgKGRl
ZmF1bHQpLA0KPj4gPj4gPj4gICAgICAgb3IgYXR0YWNoZWQgdG8gYSBEUElPIG9iamVjdCwgb3Ig
YXR0YWNoZWQgdG8gRFBDT04gb2JqZWN0Lg0KPj4gPj4gPj4gICAgICAgNC4gQWxsb3dzIGludGVy
YWN0aW9uIHdpdGggb25lIG9yIG1vcmUgRFBJTyBvYmplY3RzIGZvcg0KPj4gPj4gPj4gICAgICAg
ZGVxdWV1ZWluZy9lbnF1ZXVlaW5nIGZyYW1lIGRlc2NyaXB0b3JzKEZEKSBhbmQgZm9yDQo+PiA+
PiA+PiAgICAgICBhY3F1aXJpbmcvcmVsZWFzaW5nIGJ1ZmZlcnMuDQo+PiA+PiA+PiAgICAgICA1
LiBTdXBwb3J0cyBlbmFibGUsIGRpc2FibGUsIGFuZCByZXNldCBvcGVyYXRpb25zLg0KPj4gPj4g
Pj4NCj4+ID4+ID4+IEFkZCBkcGRtYWkgdG8gc3VwcG9ydCBzb21lIHBsYXRmb3JtcyB3aXRoIGRw
YWEyIHFkbWEgZW5naW5lLg0KPj4gPj4gPg0KPj4gPj4gPkFwcGxpZWQgYm90aCwgdGhhbmtzDQo+
PiA+DQo+PiA+SSBzZWUgdGhpcyBlcnJvciB3aGVuIEknbSBidWlsZGluZy4NCj4+ID4NCj4+ID5X
QVJOSU5HOiBtb2Rwb3N0OiBtaXNzaW5nIE1PRFVMRV9MSUNFTlNFKCkgaW4NCj4+ID5kcml2ZXJz
L2RtYS9mc2wtZHBhYTItcWRtYS9kcGRtYWkubw0KPj4gPnNlZSBpbmNsdWRlL2xpbnV4L21vZHVs
ZS5oIGZvciBtb3JlIGluZm9ybWF0aW9uDQo+PiA+RVJST1I6ICJkcGRtYWlfZW5hYmxlIiBbZHJp
dmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10NCj4+ID51bmRlZmluZWQhDQo+
PiA+RVJST1I6ICJkcGRtYWlfc2V0X3J4X3F1ZXVlIg0KPj4gPltkcml2ZXJzL2RtYS9mc2wtZHBh
YTItcWRtYS9kcGFhMi1xZG1hLmtvXSB1bmRlZmluZWQhDQo+PiA+RVJST1I6ICJkcGRtYWlfZ2V0
X3R4X3F1ZXVlIg0KPj4gPltkcml2ZXJzL2RtYS9mc2wtZHBhYTItcWRtYS9kcGFhMi1xZG1hLmtv
XSB1bmRlZmluZWQhDQo+PiA+RVJST1I6ICJkcGRtYWlfZ2V0X3J4X3F1ZXVlIg0KPj4gPltkcml2
ZXJzL2RtYS9mc2wtZHBhYTItcWRtYS9kcGFhMi1xZG1hLmtvXSB1bmRlZmluZWQhDQo+PiA+RVJS
T1I6ICJkcGRtYWlfZ2V0X2F0dHJpYnV0ZXMiDQo+PiA+W2RyaXZlcnMvZG1hL2ZzbC1kcGFhMi1x
ZG1hL2RwYWEyLXFkbWEua29dIHVuZGVmaW5lZCENCj4+ID5FUlJPUjogImRwZG1haV9vcGVuIiBb
ZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10NCj4+ID51bmRlZmluZWQh
DQo+PiA+RVJST1I6ICJkcGRtYWlfY2xvc2UiIFtkcml2ZXJzL2RtYS9mc2wtZHBhYTItcWRtYS9k
cGFhMi1xZG1hLmtvXQ0KPj4gPnVuZGVmaW5lZCENCj4+ID5FUlJPUjogImRwZG1haV9kaXNhYmxl
IiBbZHJpdmVycy9kbWEvZnNsLWRwYWEyLXFkbWEvZHBhYTItcWRtYS5rb10NCj4+ID51bmRlZmlu
ZWQhDQo+PiA+RVJST1I6ICJkcGRtYWlfcmVzZXQiIFtkcml2ZXJzL2RtYS9mc2wtZHBhYTItcWRt
YS9kcGFhMi1xZG1hLmtvXQ0KPj4gPnVuZGVmaW5lZCENCj4+ID5tYWtlWzJdOiAqKiogWy4uL3Nj
cmlwdHMvTWFrZWZpbGUubW9kcG9zdDo5NTogX19tb2Rwb3N0XSBFcnJvciAxDQo+PiA+bWFrZVsx
XTogKioqIFsvc3J2L3NyYy9rZXJuZWwvbmV4dC9NYWtlZmlsZToxMjgyOiBtb2R1bGVzXSBFcnJv
ciAyDQo+PiA+bWFrZTogKioqIFtNYWtlZmlsZToxNzk6IHN1Yi1tYWtlXSBFcnJvciAyDQo+PiA+
bWFrZTogVGFyZ2V0ICdJbWFnZScgbm90IHJlbWFkZSBiZWNhdXNlIG9mIGVycm9ycy4NCj4+ID5t
YWtlOiBUYXJnZXQgJ21vZHVsZXMnIG5vdCByZW1hZGUgYmVjYXVzZSBvZiBlcnJvcnMuDQo+PiA+
DQo+PiA+YW55IG90aGVyIHRoYXQgc2VlIHRoZSBzYW1lID8NCj4+ID4NCj4+ID5DaGVlcnMsDQo+
PiA+QW5kZXJzDQo=
