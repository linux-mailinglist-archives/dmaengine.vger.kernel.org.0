Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CFC2AEDA
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbfE0Gkn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 02:40:43 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:16116
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbfE0Gkn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 02:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL3MgYqeb4W9BvKmiog9qPQ/BNxGEPQ3cN/LYMhFLA0=;
 b=HRnYltieuvNYRqPqA/L3ep+oGssVRUj6un90IV7I77LCAE3DSeGOstfgS/qfDbfPPxYyzBJg5P0wy6VjH+kKbODqZTFzW4AKsSuoaKMqvAfxfxK08hnnPRadpt1q9nYh4pyrXkFsE+LKQUxHdBC14TCJv2Pup9XNUlTinWURsQw=
Received: from BN6PR03CA0083.namprd03.prod.outlook.com (2603:10b6:405:6f::21)
 by MWHPR03MB3134.namprd03.prod.outlook.com (2603:10b6:301:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1922.16; Mon, 27 May
 2019 06:40:01 +0000
Received: from BL2NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR03CA0083.outlook.office365.com
 (2603:10b6:405:6f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16 via Frontend
 Transport; Mon, 27 May 2019 06:40:01 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT006.mail.protection.outlook.com (10.152.76.239) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Mon, 27 May 2019 06:40:01 +0000
Received: from NWD2HUBCAS9.ad.analog.com (nwd2hubcas9.ad.analog.com [10.64.69.109])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4R6e1uw025859
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 26 May 2019 23:40:01 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS9.ad.analog.com ([fe80::44a2:871b:49ab:ea47%12]) with mapi id
 14.03.0415.000; Mon, 27 May 2019 02:40:01 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: Re: [PATCH 1/3][V2] include: fpga: adi-axi-common.h: add common
 regs & defs header
Thread-Topic: [PATCH 1/3][V2] include: fpga: adi-axi-common.h: add common
 regs & defs header
Thread-Index: AQHVD9+L/wsuF9Erq0SqNdDsq8WfBqZ+0K+AgAAAooA=
Date:   Mon, 27 May 2019 06:40:00 +0000
Message-ID: <c0bf6fa581cebdadaf5d86fe5e844c5e6a90c4cb.camel@analog.com>
References: <20190521141425.26176-1-alexandru.ardelean@analog.com>
         <20190527063743.GD15118@vkoul-mobl>
In-Reply-To: <20190527063743.GD15118@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9970A2FF4DFC7A4D9643157CE1CA2811@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(8936002)(1730700003)(4326008)(86362001)(6246003)(53546011)(26005)(76176011)(8676002)(2351001)(305945005)(7736002)(246002)(6116002)(3846002)(23676004)(2486003)(7696005)(2906002)(186003)(102836004)(6916009)(118296001)(7636002)(11346002)(446003)(47776003)(336012)(486006)(126002)(426003)(436003)(476003)(2616005)(50466002)(316002)(106002)(5640700003)(14454004)(229853002)(356004)(5660300002)(70206006)(70586007)(478600001)(966005)(6306002)(36756003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3134;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e1a28a8-492c-477e-7495-08d6e26e2508
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328)(7193020);SRVR:MWHPR03MB3134;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3134:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <MWHPR03MB31340C231B06CFB6D9E7637DF91D0@MWHPR03MB3134.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0050CEFE70
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fcW7uUGGy4F4MLj78nLM/c8sYhTJiA2+QnYNUIMXtjmw4TIYFMZK0DutJiGUajcpe5TjjFg0/0ithQBJTTDGaFSLqmW0Z/KdE7SpOS7pag+jdsq4tB/IzDM7vEZmBwh2kAyPhdhAWWjk9vMwNhSYfwuynbwHIuYtuKcOLrOr4Hhx/MoYLs370G9pdVoLa6Yi4Q7X8P/DHpqMA1Po9r/A12SyNj467NGjdVJllQU5zHAXdw7h5+LytWDAlkGoS2j/1YHe7AiFqSRUO6aE3zLUgiJXIaouFmMhYS5/MzBW9QHEXSsSJm2UbjOdXa1Zzv8Dd0G6LU8yF3TPDK/By6gsyvg7J/kgSmmPq6bOCT4v0m/nw9fZHZ96vgtz9TBU7zz5B18KbtJHM5UlAbsrJStMxHSp0rjOHw5MfU86PnGB/O4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2019 06:40:01.4134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a28a8-492c-477e-7495-08d6e26e2508
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3134
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTI3IGF0IDEyOjA3ICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gMjEtMDUtMTksIDE3OjE0LCBBbGV4YW5kcnUgQXJkZWxl
YW4gd3JvdGU6DQo+ID4gVGhlIEFYSSBIREwgY29yZXMgcHJvdmlkZWQgZm9yIEFuYWxvZyBEZXZp
Y2VzIHJlZmVyZW5jZSBkZXNpZ25zIGFsbCBzaGFyZQ0KPiA+IHNvbWUgY29tbW9uIGJhc2UgcmVn
aXN0ZXJzIChlLmcuIHZlcnNpb24gcmVnaXN0ZXIgYXQgYWRkcmVzcyAweDAwKS4NCj4gPiANCj4g
PiBUbyByZWR1Y2UgZHVwbGljYXRpb24gZm9yIHRoaXMsIGEgY29tbW9uIGhlYWRlciBpcyBhZGRl
ZCB0byBkZWZpbmUgdGhlc2UNCj4gPiByZWdpc3RlcnMgYXMgd2VsbCBhcyBiaXRmaWVsZHMgJiBt
YWNyb3MgdG8gd29yayB3aXRoIHRoZXNlIHJlZ2lzdGVycy4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4YW5kcnUgQXJkZWxlYW4gPGFsZXhhbmRydS5hcmRlbGVhbkBhbmFsb2cuY29tPg0K
PiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2ZwZ2EvYWRpLWF4aS1jb21tb24uaCB8IDE5ICsr
KysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvZnBnYS9hZGktYXhpLWNvbW1v
bi5oDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZnBnYS9hZGktYXhpLWNv
bW1vbi5oIGIvaW5jbHVkZS9saW51eC9mcGdhL2FkaS1heGktY29tbW9uLmgNCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNzk2NmM4OTU2MWIxDQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZnBnYS9hZGktYXhpLWNvbW1v
bi5oDQo+ID4gQEAgLTAsMCArMSwxOSBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMA0KPiANCj4gRm9yIGhlYWRlcnMgdGhpcyBpcyBub3QgdGhlIHN0eWxlIHRvIGJl
IHVzZWQuDQo+IFNlZSBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvbGljZW5zZS1ydWxlcy5yc3QNCj4g
DQo+ICAgICAgIEMgc291cmNlOiAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogPFNQRFggTGlj
ZW5zZSBFeHByZXNzaW9uPg0KPiAgICAgICBDIGhlYWRlcjogLyogU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IDxTUERYIExpY2Vuc2UgRXhwcmVzc2lvbj4gKi8NCj4gDQoNCkFjay4NCldpbGwgcmUt
c3Bpbi4NCg0KPiA+ICsvKg0KPiA+ICsgKiBBbmFsb2cgRGV2aWNlcyBBWEkgY29tbW9uIHJlZ2lz
dGVycyAmIGRlZmluaXRpb25zDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAyMDE5IEFuYWxv
ZyBEZXZpY2VzIEluYy4NCj4gPiArICoNCj4gPiArICogaHR0cHM6Ly93aWtpLmFuYWxvZy5jb20v
cmVzb3VyY2VzL2ZwZ2EvZG9jcy9heGlfaXANCj4gPiArICogaHR0cHM6Ly93aWtpLmFuYWxvZy5j
b20vcmVzb3VyY2VzL2ZwZ2EvZG9jcy9oZGwvcmVnbWFwDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiAr
I2lmbmRlZiBBRElfQVhJX0NPTU1PTl9IXw0KPiA+ICsjZGVmaW5lIEFESV9BWElfQ09NTU9OX0hf
DQo+ID4gKw0KPiA+ICsjZGVmaW5lICAgICAgQURJX0FYSV9SRUdfVkVSU0lPTiAgICAgICAgICAg
ICAgICAgICAgIDB4MDAwMA0KPiA+ICsNCj4gPiArI2RlZmluZSBBRElfQVhJX1BDT1JFX1ZFUiht
YWpvciwgbWlub3IsIHBhdGNoKSAgICAgICBcDQo+ID4gKyAgICAgKCgobWFqb3IpIDw8IDE2KSB8
ICgobWlub3IpIDw8IDgpIHwgKHBhdGNoKSkNCj4gPiArDQo+ID4gKyNlbmRpZiAvKiBBRElfQVhJ
X0NPTU1PTl9IXyAqLw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+IA0KPiAtLQ0KPiB+Vmlub2QNCg==
