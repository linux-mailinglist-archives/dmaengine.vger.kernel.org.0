Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB13BD65C
	for <lists+dmaengine@lfdr.de>; Wed, 25 Sep 2019 04:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbfIYC1J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 22:27:09 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:17858
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390331AbfIYC1J (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 22:27:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsM16Oqg8p3104AJSujrJAUNTF+LWGPzTK+0oUGv2TF/yoN/Im00mGwR3KThJ9Zt+O6A24+6YlG+gAInzJgNYshxAqj15brtxFjQEEMqtovHOKk7HYKhgys4dZkBGSBD9zvY5zS96zq9plXxUOE4E+UNH58G61+YC6alYk0QzW5R4ivtEzamrlqvEPdKXohIN5cG6WNHgYMeVWodNe3M95aXOwU2sa+DnZ6veTgHpm641CAdLy+XHNbRm1bx22F9XlqdVGnjrQCn+i6bV92YOhiU7wfjiFT8CK3rz5LCGAf3rCvQwWX8S3kC8c6Ui7HlK1uhVcVHfQgPVAtPD399Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5OuLP6l8iIy7Dy7vdSYdf+03SjyXdp7kfa1C0rncoE=;
 b=iQNTMRdgweHW24q6WJFd8A0j4u0DIW3fJdDsi5YbsFAfxaOu7O0f4C/Oc/gR87poC/Dvb0SX6I0F7w6Canl1MW3yJOn4Jcnl4VjPVBOShwaPrJ9JTT6r8mSNvkPD0Q5ovElXeqr7cclqLajsYTcyfcjOXJUhZZh480s86gH5tCaQkuNY6YkoiLO6eMgq1sB0Zgx1Mqcxe+rTVZ4bGo3oVbNi9X4LAZzRAbuTVhvSeR7X3Yz/eo1O7xia0aGjLoeG4GL7rODuLQ9P0prnUaAta8OqelODJP4kJp0gioDxf9kNw9TLVI3yq19xJ7N0SaJysQORp+ZRxNkuNzrH5va50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5OuLP6l8iIy7Dy7vdSYdf+03SjyXdp7kfa1C0rncoE=;
 b=bqQ1IB4uxf9vffzXpHkI7qw2SRjiU7/0fdBeGvIHpP9PUdeLJqiRRdu7Fl+X+MoKrlcM22KVX1M4CQVeXerTwRETRefkzkMyhMd56+nS4yBaC9Ds073gBR+1s8T3vXhHc/aGc9uW8mDJWMlFEXz2jJk8p1d1fKtuK5NsspB+TjM=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB4717.eurprd04.prod.outlook.com (20.177.48.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 02:27:04 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e158:ee7a:cebe:5b3e]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::e158:ee7a:cebe:5b3e%7]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 02:27:04 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [EXT] Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Thread-Topic: [EXT] Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Thread-Index: AQHVIdHlJeIOycgBm02VgX87ZyLFMqarFPIAgHsuGRCAFZePAIAAcoEw
Date:   Wed, 25 Sep 2019 02:27:04 +0000
Message-ID: <VI1PR04MB44314EF818033EB52D0A591DED870@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190613101341.21169-1-peng.ma@nxp.com>
 <20190613101341.21169-2-peng.ma@nxp.com> <20190624164556.GD2962@vkoul-mobl>
 <VI1PR04MB443142772665BB29B909DFF4EDB10@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190924193446.GF3824@vkoul-mobl>
In-Reply-To: <20190924193446.GF3824@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b18d548-05ea-41a2-9ba7-08d7415fdab3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4717;
x-ms-traffictypediagnostic: VI1PR04MB4717:|VI1PR04MB4717:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB471785E4C3048EFAB6F236DAED870@VI1PR04MB4717.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(13464003)(199004)(189003)(3846002)(256004)(4326008)(8676002)(81166006)(81156014)(25786009)(71200400001)(74316002)(5660300002)(54906003)(2906002)(316002)(71190400001)(6116002)(52536014)(7736002)(33656002)(305945005)(86362001)(8936002)(102836004)(6506007)(186003)(26005)(7696005)(6916009)(76176011)(99286004)(486006)(476003)(76116006)(66476007)(64756008)(66446008)(66556008)(66946007)(44832011)(966005)(66066001)(446003)(11346002)(14454004)(9686003)(55016002)(6306002)(45080400002)(6436002)(229853002)(478600001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4717;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XLvcH0aonjJqJfGBGAv9N/vlHg7QKHaqIV1JNof99XfXbCLxDoRcKcbrlQ2zAi/Ed5QleTFqnOdRV2ZoYpcOI3AKFEcN9oYyaMJ7QKkcAk4TXQ9alzhpjc64+bDwHOr0gxVK1U2L0ehMaGYCR+QiB1mifULaGj4tfPg5ojGLkEP1olzMdxAnF592w2aQzOOL21C1p0wa1F6b6gJNEi5R1yCTgBpz2l/73p6/kHnpZYpbO5JaAQZ+sYuNockI80sGH+dRdeoU3M54BlxlCtvpHpKCAnaZ4OEEMib/kTcSP+wBqe/drcNKoLTUfc0PNOFfNkI2DNECE0iV4ArVrpb184CnE4gjpGKzEaoUuhztxxPo+tBCjdJWT0KWkYU9+ee91dghVMEdUwNIdWo/7rzOEvW9O2rC4j0XB10LOsznRFU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b18d548-05ea-41a2-9ba7-08d7415fdab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 02:27:04.2612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1lhJp6r2zXRWQateDaBNUoFNQ08qV2a9S8lZk6OmlqKJlNSbJjRG5SLXxvRr5Se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4717
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

SGkgVmlub2QsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFZpbm9kIEtv
dWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+U2VudDogMjAxOcTqOdTCMjXI1SAzOjM1DQo+VG86IFBl
bmcgTWEgPHBlbmcubWFAbnhwLmNvbT4NCj5DYzogZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyBM
ZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1Y0
IDIvMl0gZG1hZW5naW5lOiBmc2wtZHBhYTItcWRtYTogQWRkIE5YUCBkcGFhMg0KPnFETUEgY29u
dHJvbGxlciBkcml2ZXIgZm9yIExheWVyc2NhcGUgU29Dcw0KPg0KPkNhdXRpb246IEVYVCBFbWFp
bA0KPg0KPkhleSBQZW5nLA0KPg0KPk9uIDExLTA5LTE5LCAwMjowMSwgUGVuZyBNYSB3cm90ZToN
Cj4+IEhpIFZpbm9kLA0KPj4NCj4+IEkgc2VuZCB0aG9zZSBzZXJpZXMgcGF0Y2hzKFY1KSBvbiBK
dW5lIDI1LCAyMDE5LiBJIGhhdmVuJ3QgcmVjZWl2ZWQNCj4+IGFueSBjb21tZW50cyB5ZXQuIFRo
ZWlyIGN1cnJlbnQgc3RhdGUgaXMgIk5vdCBBcHBsaWNhYmxlIiwgc28gcGxlYXNlIGxldCBtZQ0K
Pmtub3cgd2hhdCBJIG5lZWQgdG8gZG8gbmV4dC4NCj4+IFRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHlv
dXIgY29tbWVudHMuDQo+Pg0KPj4gUGF0Y2ggbGluazoNCj4+IGh0dHBzOi8vZXVyMDEuc2FmZWxp
bmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGMNCj4+DQo+
aHdvcmsua2VybmVsLm9yZyUyRnBhdGNoJTJGMTEwMTUwMzUlMkYmYW1wO2RhdGE9MDIlN0MwMSU3
Q3BlbmcubQ0KPmElNDBueA0KPj4NCj5wLmNvbSU3Q2ZlMDI5M2E4M2ViODQ3Mjc4N2QzMDhkNzQx
MjY2ODJjJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmMNCj5kOTljNWMzDQo+Pg0KPjAxNjM1JTdDMCU3
QzAlN0M2MzcwNDk1MDU1MjEwMjQ0NjcmYW1wO3NkYXRhPXFraWo2Qnk3SGt1NGVON3pvDQo+Q25J
a0NLOTYNCj4+IDdXbndFMjFXJTJGVmtXS2liSUJ3JTNEJmFtcDtyZXNlcnZlZD0wDQo+PiBodHRw
czovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZwYXRjDQo+Pg0KPmh3b3JrLmtlcm5lbC5vcmclMkZwYXRjaCUyRjExMDE1MDMzJTJGJmFt
cDtkYXRhPTAyJTdDMDElN0NwZW5nLm0NCj5hJTQwbngNCj4+DQo+cC5jb20lN0NmZTAyOTNhODNl
Yjg0NzI3ODdkMzA4ZDc0MTI2NjgyYyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjDQo+ZDk5YzVjMw0K
Pj4NCj4wMTYzNSU3QzAlN0MwJTdDNjM3MDQ5NTA1NTIxMDI0NDY3JmFtcDtzZGF0YT1PZUw1T2ZN
SmdnTVMzSzdJDQo+WjF5dTlXV1o5DQo+PiB6U09TeVdvanIlMkJ2N0JMNUJwVSUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KPg0KPkFtIHNvcnJ5IHRoaXMgbG9va3MgdG8gaGF2ZSBtaXNzZWQgYnkgbWUgYW5k
IG15IHNjcmlwdCB1cGRhdGVkIHRoZSBzdGF0dXMuDQo+DQo+Q2FuIHlvdSBwbGVhc2UgcmVzZW5k
IG1lIGFmdGVyIHJjMSBpcyBvdXQgYW5kIEkgd2lsbCByZXZpZXcgaXQgYW5kIGRvIHRoZQ0KPm5l
ZWRmdWwNCltQZW5nIE1hXSBHb3QgaXQuIEJ5IHRoZSB3YXksIHdoZW4gd2lsbCByYzEgb3V0Pw0K
DQpCZXN0IFJlZ2FyZHMsDQpQZW5nDQo+DQo+LS0NCj5+Vmlub2QNCg==
