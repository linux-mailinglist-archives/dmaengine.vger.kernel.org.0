Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9F251C1
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 16:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfEUOSy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 10:18:54 -0400
Received: from mail-eopbgr790073.outbound.protection.outlook.com ([40.107.79.73]:6941
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727999AbfEUOSy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 10:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9cWoQ3fSFQyZe7sVzIDMM4z7Jfa0b4Ki519OpdyJVQ=;
 b=iXBgRGA6N83iwLPk4LQzizUdx7mVQ7nNwVb5o2oPDLNG9AVAE1EHJAIjGa00JtBc93wXrmyynt1Vk3wPibod9Zca/ApTQm8+B7UoH2Bch97lRP8aKQBYNuNpq0jFnQVrkPxl8t+QZMUhsqXDd8RH5swRXQtTM3tqs4bOpKEBK8o=
Received: from BN6PR03CA0005.namprd03.prod.outlook.com (2603:10b6:404:23::15)
 by BL2PR03MB547.namprd03.prod.outlook.com (2a01:111:e400:c23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.25; Tue, 21 May
 2019 14:18:52 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR03CA0005.outlook.office365.com
 (2603:10b6:404:23::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16 via Frontend
 Transport; Tue, 21 May 2019 14:18:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 14:18:52 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4LEIp1O002151
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <dmaengine@vger.kernel.org>; Tue, 21 May 2019 07:18:51 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS8.ad.analog.com ([fe80::90a0:b93e:53c6:afee%12]) with mapi id
 14.03.0415.000; Tue, 21 May 2019 10:18:51 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/3][V2] include: fpga: adi-axi-common.h: add common
 regs & defs header
Thread-Topic: [PATCH 1/3][V2] include: fpga: adi-axi-common.h: add common
 regs & defs header
Thread-Index: AQHVD9+L/wsuF9Erq0SqNdDsq8WfBqZ144UA
Date:   Tue, 21 May 2019 14:18:51 +0000
Message-ID: <58a7d6f3278aa15f40800b460d3ee03c06641c26.camel@analog.com>
References: <20190521141425.26176-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190521141425.26176-1-alexandru.ardelean@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6AE73D26616544390BC56C04A188B64@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(189003)(199004)(54534003)(26005)(2906002)(102836004)(6916009)(36756003)(23676004)(478600001)(106002)(14454004)(2486003)(118296001)(7696005)(5660300002)(6116002)(966005)(126002)(486006)(2501003)(426003)(436003)(3846002)(446003)(11346002)(2616005)(316002)(186003)(7736002)(7636002)(305945005)(476003)(336012)(76176011)(6306002)(5640700003)(8936002)(2351001)(6246003)(8676002)(356004)(229853002)(1730700003)(246002)(70586007)(50466002)(86362001)(47776003)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB547;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 440fc622-397b-49e2-8be2-08d6ddf7402b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:BL2PR03MB547;
X-MS-TrafficTypeDiagnostic: BL2PR03MB547:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <BL2PR03MB5472AAAC649448ED869EB40F9070@BL2PR03MB547.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: B3uA+hBrEqBHlSPjE8lChjxXHE1S+fUy/JdQ3klrd0chEkZhz/Q0spXZEBaoyAXwuFj1IrFN/t//JkQJKZHX3/m9SqdJdBun/1+d99gVofG+GA81v68mqI2Ifvs6mvpPNKAon1S04vFzlp0VVSfeCqRC+YhhumapUdnkAX9TRSn2h/CypIL16ooCsJaoRrY++ATVJdrLepmO8ti5SNvkxDzQ1NTS3cCJvBCiYVU7OEilzck/FMmMXiwQDsIqRsZYrge3bXammOewqpKmVOX/JlEYHgEJcWWDAQxnHbdOnFu6CEZSS+gcnTDyD8jqnmHcxSxrC2j5PsVJn+7Fh6cTGfexVhS5H7AmW5zahGyp1P7OW8vD5HFAGK4sjvwSj80+V+WfTLYNman453kz6Kopgox5Ycv1SsCAnjMExxgqGb8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 14:18:52.1739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 440fc622-397b-49e2-8be2-08d6ddf7402b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB547
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDE3OjE0ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IFRoZSBBWEkgSERMIGNvcmVzIHByb3ZpZGVkIGZvciBBbmFsb2cgRGV2aWNlcyByZWZl
cmVuY2UgZGVzaWducyBhbGwgc2hhcmUNCj4gc29tZSBjb21tb24gYmFzZSByZWdpc3RlcnMgKGUu
Zy4gdmVyc2lvbiByZWdpc3RlciBhdCBhZGRyZXNzIDB4MDApLg0KPiANCj4gVG8gcmVkdWNlIGR1
cGxpY2F0aW9uIGZvciB0aGlzLCBhIGNvbW1vbiBoZWFkZXIgaXMgYWRkZWQgdG8gZGVmaW5lIHRo
ZXNlDQo+IHJlZ2lzdGVycyBhcyB3ZWxsIGFzIGJpdGZpZWxkcyAmIG1hY3JvcyB0byB3b3JrIHdp
dGggdGhlc2UgcmVnaXN0ZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFyZGVs
ZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gLS0tDQoNCkkgZm9yZ290IHRv
IGFkZCBhIGNoYW5nZWxvZyBmb3IgdGhpcyBzZXJpZXMgd2hlbiB3cml0aW5nIHRoZSBwYXRjaGVz
Lg0KDQpDaGFuZ2Vsb2cgdjEgLT4gdjI6DQoqIGFkZCBjb21tb24gYGluY2x1ZGUvbGludXgvZnBn
YS9hZGktYXhpLWNvbW1vbi5oYCB3aXRoIHJlZyB2ZXJzaW9uOyBtb3JlIHJlZ3Mgd2lsbCBiZSBh
ZGRlZA0KKiB1c2UgbWFjcm8gdG8gY2hlY2sgdmVyc2lvbiBvZiBIREwgY29yZSBmcm9tIGNvbW1v
biBoZWFkZXINCiogYWRkIG15IFMtby1CIHRvIHBhdGNoIGBkbWFlbmdpbmU6IGF4aS1kbWFjOiBE
aXNjb3ZlciBsZW5ndGggYWxpZ25tZW50IHJlcXVpcmVtZW50YA0KDQoNCj4gIGluY2x1ZGUvbGlu
dXgvZnBnYS9hZGktYXhpLWNvbW1vbi5oIHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiAgMSBm
aWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNs
dWRlL2xpbnV4L2ZwZ2EvYWRpLWF4aS1jb21tb24uaA0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvZnBnYS9hZGktYXhpLWNvbW1vbi5oIGIvaW5jbHVkZS9saW51eC9mcGdhL2FkaS1h
eGktY29tbW9uLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAw
Li43OTY2Yzg5NTYxYjENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2Zw
Z2EvYWRpLWF4aS1jb21tb24uaA0KPiBAQCAtMCwwICsxLDE5IEBADQo+ICsvLyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoNCj4gKyAqIEFuYWxvZyBEZXZpY2VzIEFYSSBj
b21tb24gcmVnaXN0ZXJzICYgZGVmaW5pdGlvbnMNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgMjAx
OSBBbmFsb2cgRGV2aWNlcyBJbmMuDQo+ICsgKg0KPiArICogaHR0cHM6Ly93aWtpLmFuYWxvZy5j
b20vcmVzb3VyY2VzL2ZwZ2EvZG9jcy9heGlfaXANCj4gKyAqIGh0dHBzOi8vd2lraS5hbmFsb2cu
Y29tL3Jlc291cmNlcy9mcGdhL2RvY3MvaGRsL3JlZ21hcA0KPiArICovDQo+ICsNCj4gKyNpZm5k
ZWYgQURJX0FYSV9DT01NT05fSF8NCj4gKyNkZWZpbmUgQURJX0FYSV9DT01NT05fSF8NCj4gKw0K
PiArI2RlZmluZQlBRElfQVhJX1JFR19WRVJTSU9OCQkJMHgwMDAwDQo+ICsNCj4gKyNkZWZpbmUg
QURJX0FYSV9QQ09SRV9WRVIobWFqb3IsIG1pbm9yLCBwYXRjaCkJXA0KPiArCSgoKG1ham9yKSA8
PCAxNikgfCAoKG1pbm9yKSA8PCA4KSB8IChwYXRjaCkpDQo+ICsNCj4gKyNlbmRpZiAvKiBBRElf
QVhJX0NPTU1PTl9IXyAqLw0K
