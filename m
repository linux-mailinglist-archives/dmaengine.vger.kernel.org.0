Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD145143
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2019 03:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfFNBmE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Jun 2019 21:42:04 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:8087
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfFNBmE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 13 Jun 2019 21:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn4UoGVJoPPmRzzbsnEjyO0HLjdVu328HTIsENmgs4s=;
 b=EsZXsP1p3bO/SXwa95JeQPLYgjMBa0PNGM0n4u/cPXa8IPTWbdfeKwcuLtdRwAouYsWwJpkrgJtAumtbgw2zPKt2PaE1NqlEQxe6g5zrDBHGkvPqn7jKPBsX6HNN5nrr1fbxA42h8OmD6C5Db/l6FFF+39A7GhJ7ghhM6XE0olM=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB3197.eurprd04.prod.outlook.com (10.170.229.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Fri, 14 Jun 2019 01:41:59 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::20bb:da22:d5f2:f2ab]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::20bb:da22:d5f2:f2ab%4]) with mapi id 15.20.1987.010; Fri, 14 Jun 2019
 01:41:59 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [V3 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Thread-Topic: [EXT] Re: [V3 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Thread-Index: AQHU7qXr3uPYZwSnaEqIkDYkulszCqZSvHSAgEHP4sCABUWcgIAA9BxA
Date:   Fri, 14 Jun 2019 01:41:59 +0000
Message-ID: <VI1PR04MB4431BAEE4E97C33FD81965BAEDEE0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190409072212.15860-1-peng.ma@nxp.com>
 <20190409072212.15860-2-peng.ma@nxp.com>
 <20190429053203.GF3845@vkoul-mobl.Dlink>
 <VI1PR04MB4431B87A1F712DC232A46ECBED130@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190613110325.GD9160@vkoul-mobl.Dlink>
In-Reply-To: <20190613110325.GD9160@vkoul-mobl.Dlink>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28e1be54-3282-4cd6-d15b-08d6f0697e05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3197;
x-ms-traffictypediagnostic: VI1PR04MB3197:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB3197C370EA0D1EB18AD64356EDEE0@VI1PR04MB3197.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(136003)(346002)(366004)(376002)(396003)(39860400002)(13464003)(189003)(199004)(81166006)(8936002)(44832011)(102836004)(26005)(53936002)(81156014)(76176011)(33656002)(7696005)(486006)(99286004)(11346002)(54906003)(446003)(8676002)(186003)(476003)(305945005)(2906002)(68736007)(7736002)(478600001)(316002)(6506007)(66066001)(6306002)(52536014)(5660300002)(966005)(6116002)(3846002)(76116006)(66446008)(86362001)(25786009)(71200400001)(6246003)(229853002)(6436002)(74316002)(73956011)(66946007)(71190400001)(55016002)(66476007)(4326008)(6916009)(66556008)(64756008)(256004)(9686003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3197;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: URpu26I1CqATpXiXJFSNXUCBBYfjgcsWtRAcMCsWzKUO0YPIi5XNlI5tEFiQgHEV9KTb24HchQ3QBr66jLbQWqfBneqTSTncRuK8TOLq1mZp1fsayWIKtb6x2/tHbLlbJitA7XYpa5l6kxrWPoAOrc21Pf+p957ZTGwrq1jyRCOMgB0Tg05p+M94npUScxkBRgf4/AFwL8tJXShskMqISxWAhBR5YlfcBLCuzldP+eIsZi3Rj5jnqCZgV5KW/NoBQ437FQf+6h2OZQruzvWDIAXGhpqhVc/LwxmafxbZTweZkT6vu2RnG6pinI7dJt40wD6hfUN+81Lyp5AS1bPnFgK5qgFExWsaBPOi1LI7wS8lKXgOB1f+1Q8O7zKG+NTBBRkBGlexQfwfmcWsDU7J/RLqhLSYWfGZ0ExEzoa3ynY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e1be54-3282-4cd6-d15b-08d6f0697e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 01:41:59.4857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peng.ma@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3197
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtv
dWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOcTqNtTCMTPI1SAxOTowMw0KPlRvOiBQ
ZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+Q2M6IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsg
TGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+Ow0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW0VYVF0gUmU6IFtW
MyAyLzJdIGRtYWVuZ2luZTogZnNsLWRwYWEyLXFkbWE6IEFkZCBOWFAgZHBhYTINCj5xRE1BIGNv
bnRyb2xsZXIgZHJpdmVyIGZvciBMYXllcnNjYXBlIFNvQ3MNCj4NCj5DYXV0aW9uOiBFWFQgRW1h
aWwNCj4NCj5PbiAxMC0wNi0xOSwgMDk6NTEsIFBlbmcgTWEgd3JvdGU6DQo+DQo+PiA+PiArICAg
ICAgICAgICAgICAgICAgICAgZ290byBlcnI7DQo+PiA+PiArDQo+PiA+PiArICAgICAgICAgICAg
IGNvbXBfdGVtcC0+ZmxfdmlydF9hZGRyID0NCj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAo
dm9pZCAqKSgoc3RydWN0IGRwYWEyX2ZkICopDQo+PiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb21wX3RlbXAtPmZkX3ZpcnRfYWRkciArIDEpOw0KPj4gPg0KPj4gPmNhc3RzIGFu
ZCBwb2ludGVyIG1hdGgsIHdoYXQgY291bGQgZ28gd3JvbmchISBUaGlzIGRvZXNudCBzbWVsbCBy
aWdodCENCj4+ID4NCj4+ID4+ICsgICAgICAgICAgICAgY29tcF90ZW1wLT5mbF9idXNfYWRkciA9
IGNvbXBfdGVtcC0+ZmRfYnVzX2FkZHIgKw0KPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IGRwYWEyX2ZkKTsNCj4+ID4NCj4+ID53aHkgbm90
IHVzZSBmbF92aXJ0X2FkZHIgYW5kIGdldCB0aGUgYnVzX2FkZHJlc3M/DQo+PiBXaGF0IHlvdSBt
ZWFuIGlzIEkgc2hvdWxkIHVzZSB2aXJ0X3RvX3BoeXMgdG8gZ2V0IHRoZSBidXNfYWRkcmVzcz8N
Cj4NCj5ZZXMgaW5zdGVhZCBvZiBtYWludGFpbmluZyBib3RoIHBvaW50ZXJzLCBqdXN0IHVzZSBv
bmUgYW5kIHRoZW4gd2hlbiByZXF1aXJlZA0KPnVzZSBvbmUgdG8gZ2V0IG90aGVyLiBGb3IgYnVz
IGFkZHJlc3MgSSB3b3VsZCBwcmVmZXIgZG1hX21hcF9zaW5nbGUgcmF0aGVyDQo+dGhhbiB2aXJ0
X3RvX3BoeXMoKQ0KW1BlbmcgTWFdIG9rLCB0aGFua3MsIEkgaGF2ZSBhbHJlYWR5IHNlbmQgVjQg
Zm9yIHRoaXMgc2VyaWVzIHBhdGNoLCBQbGVhc2UgcmV2aWV3IGl0IGluIHlvdXIgc3BhcmUgdGlt
ZS4NClBhdGNod29yayBsaW5rOiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtZG1hZW5naW5lL2xpc3QvP3Nlcmllcz0xMzE3NjcNCkJlc3QgUmVnYXJzLA0KUGVuZw0K
Pi0tDQo+flZpbm9kDQo=
