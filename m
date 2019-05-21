Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E215324C78
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 12:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEUKN7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 06:13:59 -0400
Received: from mail-eopbgr800085.outbound.protection.outlook.com ([40.107.80.85]:53152
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbfEUKN6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 06:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvIevJpH8phmcZff4nQVBQOYXNFYuiFPWf5LjqxLTsg=;
 b=OPvQLG3hrvkLnWsWOCgLgeQdKFssiS8NOMVmS1VM5shikYZHZGQvHAB4EPVlKCm5C6iEALOMQvgk/OQ57I18ODluqscPJk78Uy4X3Fh+nBwPSTqcxWpKn3fpHpYdC2qioNj8Pnvrc4hIfQog54mJqBa+I0DuRwHRKko3nLrwRSU=
Received: from BN6PR03CA0093.namprd03.prod.outlook.com (2603:10b6:405:6f::31)
 by DM2PR03MB557.namprd03.prod.outlook.com (2a01:111:e400:241b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.17; Tue, 21 May
 2019 10:13:56 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN6PR03CA0093.outlook.office365.com
 (2603:10b6:405:6f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.18 via Frontend
 Transport; Tue, 21 May 2019 10:13:55 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Tue, 21 May 2019 10:13:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4LADshH004887
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 21 May 2019 03:13:54 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Tue, 21 May 2019 06:13:54 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "vkoul@kernel.org" <vkoul@kernel.org>
CC:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 1/2] dmaengine: axi-dmac: Discover length alignment
 requirement
Thread-Topic: [PATCH 1/2] dmaengine: axi-dmac: Discover length alignment
 requirement
Thread-Index: AQHVD7O9rDImV13Iu0q4u2mKgqNjYaZ1n2+A
Date:   Tue, 21 May 2019 10:13:53 +0000
Message-ID: <0eeb8b8ca54e7268a905abd72785dde51d254498.camel@analog.com>
References: <20190521112331.32424-1-alexandru.ardelean@analog.com>
         <20190521090042.GC15118@vkoul-mobl>
In-Reply-To: <20190521090042.GC15118@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <80F59EAFFD3DB34496AA62F203FA4FF6@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(199004)(189003)(186003)(54906003)(246002)(50466002)(106002)(1730700003)(8936002)(47776003)(8676002)(70206006)(36756003)(70586007)(7636002)(76176011)(2486003)(7696005)(336012)(23676004)(316002)(6916009)(2351001)(2501003)(7736002)(118296001)(26005)(14444005)(4326008)(126002)(6246003)(5660300002)(53546011)(426003)(86362001)(14454004)(11346002)(486006)(436003)(476003)(5640700003)(102836004)(2906002)(229853002)(478600001)(305945005)(3846002)(6116002)(2616005)(446003)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB557;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0c3a19c-2ab7-4f54-3302-08d6ddd50835
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328)(7193020);SRVR:DM2PR03MB557;
X-MS-TrafficTypeDiagnostic: DM2PR03MB557:
X-Microsoft-Antispam-PRVS: <DM2PR03MB5571731A12263C3AEF7C4EBF9070@DM2PR03MB557.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0044C17179
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2t6gv1oFCRqOru3l/eVTB9nZVcA45gUknw5A7uOlGq1CJVoTJyqkvMkR9FBL2ZW+HFuP98wInDAVvmPEEmil19Tx2fIOIqhEtpvHEXsSCyVr8YbOPyPYlXH7FVpH6/2rRhpu2CFtto2gjomH+bTDD9lAG+tlDgns/pQkVU5gonhyAXXa6aXp+uEyKE+IJ1ZqAORApq3Xr4VHcBmI9qTXiDHaWHhwzs2rSa6Wi2cq8fWJdPoLVtOiQMRg+CcVdycI4Bpv2sxrOUDEBf+vvysgbY0CRiPXi8Mk8RPxQIjT9YhjrqDWGZ3PtaAbtt3c1pOWjdkvFoiFcIz1nlMTUfJoq/NZYwpWO3CMoL7pqYGVzCcSlsbo9orx59XD7f9jq8ozkhKeUHK6kqrTZabvYVCp8tOBqi6QJCEfkcGO1VbSWH4=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2019 10:13:55.2698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c3a19c-2ab7-4f54-3302-08d6ddd50835
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB557
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDE0OjMwICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBb
RXh0ZXJuYWxdDQo+IA0KPiANCj4gT24gMjEtMDUtMTksIDE0OjIzLCBBbGV4YW5kcnUgQXJkZWxl
YW4gd3JvdGU6DQo+ID4gRnJvbTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+
DQo+ID4gDQo+ID4gU3RhcnRpbmcgd2l0aCB2ZXJzaW9uIDQuMS5hIHRoZSBBWEktRE1BQyBpcyBj
YXBhYmxlIG9mIHJlcG9ydGluZyB0aGUNCj4gPiByZXF1aXJlZCBsZW5ndGggYWxpZ25tZW50Lg0K
PiA+IA0KPiA+IFRoZSBMU0JzIHRoYXQgYXJlIHJlcXVpcmVkIHRvIGJlIHNldCBmb3IgYWxpZ25t
ZW50IHdpbGwgYWx3YXlzIHJlYWQgYmFjayBhcw0KPiA+IHNldCBmcm9tIHRoZSB0cmFuc2ZlciBs
ZW5ndGggcmVnaXN0ZXIuIEl0IGlzIG5vdCBwb3NzaWJsZSB0byBjbGVhciB0aGVtIGJ5DQo+ID4g
d3JpdGluZyBhIDAuIFRoaXMgbWVhbnMgdGhlIGRyaXZlciBjYW4gZGlzY292ZXIgdGhlIGxlbmd0
aCBhbGlnbm1lbnQNCj4gPiByZXF1aXJlbWVudCBieSB3cml0aW5nIDAgdG8gdGhhdCByZWdpc3Rl
ciBhbmQgcmVhZGluZyBiYWNrIHRoZSB2YWx1ZS4NCj4gPiANCj4gPiBTaW5jZSB0aGUgRE1BIHdp
bGwgc3VwcG9ydCBsZW5ndGggYWxpZ25tZW50IHJlcXVpcmVtZW50cyB0aGF0IGFyZSBkaWZmZXJl
bnQNCj4gPiBmcm9tIHRoZSBhZGRyZXNzIGFsaWdubWVudCByZXF1aXJlbWVudCB0cmFjayBib3Ro
IG9mIHRoZW0gaW5kZXBlbmRlbnRseS4NCj4gPiANCj4gPiBGb3Igb2xkZXIgdmVyc2lvbnMgb2Yg
dGhlIHBlcmlwaGVyYWwgYXNzdW1lIHRoYXQgdGhlIGxlbmd0aCBhbGlnbm1lbnQNCj4gPiByZXF1
aXJlbWVudCBpcyBlcXVhbCB0byB0aGUgYWRkcmVzcyBhbGlnbm1lbnQgcmVxdWlyZW1lbnQuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28u
ZGU+DQo+IA0KPiBZb3UgbmVlZCB0byBzaWduIG9mZiB0aGUgcGF0Y2ggYmVmb3JlIHNlbmRpbmcu
IFBsZWFzZSByZXJlYWQgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5y
c3QNCg0KQWNrLg0KDQpTb3JyeSBmb3IgZm9yZ2V0dGluZyB0aGlzIG9uZS4NCg0KPiANCj4gPiAg
ICAgICBheGlfZG1hY193cml0ZShkbWFjLCBBWElfRE1BQ19SRUdfRkxBR1MsIEFYSV9ETUFDX0ZM
QUdfQ1lDTElDKTsNCj4gPiAgICAgICBpZiAoYXhpX2RtYWNfcmVhZChkbWFjLCBBWElfRE1BQ19S
RUdfRkxBR1MpID09IEFYSV9ETUFDX0ZMQUdfQ1lDTElDKQ0KPiA+IEBAIC02NzAsNiArNjc2LDEz
IEBAIHN0YXRpYyBpbnQgYXhpX2RtYWNfZGV0ZWN0X2NhcHMoc3RydWN0IGF4aV9kbWFjICpkbWFj
KQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4gICAgICAgfQ0KPiA+IA0K
PiA+ICsgICAgIGlmICgodmVyc2lvbiAmIDB4ZmYwMCkgPj0gMHgwMTAwKSB7DQo+IA0KPiBtYWdp
YyBudW1iZXJzIHlhYXkNCg0KR29vZCBwb2ludC4NCldpbGwgZml4Lg0KDQo+IA0KPiAtLQ0KPiB+
Vmlub2QNCg==
