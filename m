Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6D24ADF66
	for <lists+dmaengine@lfdr.de>; Tue,  8 Feb 2022 18:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384183AbiBHRWS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Feb 2022 12:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384210AbiBHRWR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Feb 2022 12:22:17 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E591C0612BA;
        Tue,  8 Feb 2022 09:22:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmrILd7OSHrdhefCBidOj1xceecFWoP3awz8/c12txj1yt+TsVVJnymPeCtrZ8VnR/8RmhzWpWCfrzqIOe/+3LHNfdVNefhttQC9QyIRpumNY9cFF6RAha9hJ0VySL17u+K61BZPEd0MhQEAzQI/JIJeZJ3z+Z0tmVfg8BH+uLE5bqzTN6NE2UO+kFbX0yLCCgjwW6hUjzpLbyyIvhZjjsAHmR78Y3GVJozdgH1+USPAJqQNc/baYyV7Ahc6/EVgLbPMa+6eh7BmUagIOvIitESPPX7DRqQFtXupyaYDCNkIqOk/eD3VUBw2P6UAd/xHg/cHNb/eOtENrIjfTOeZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kr5QSr0Vwn2zJdLb/02bjNvdjn4FBt/O6ZogGGbnhA0=;
 b=fxxRlITj08Udo+XvLW3s3NenApGEAtIPDD9AeOQlBqyizekPIySPbaZfBhIxwncakes/hpgDz5mi7HRbA15o7JuORmk4Li1Fj7UBDxjtqwpAY4mOdkvw+U/S7EKI20BU2qSecfO0/BRIll2xoLZl0WfIAY4yiWxuqxHNvXXc/sX1etC2usulvsgRIjqs4JHWayDf01ZzNwPzWPQ7L13HjJjtP1UwQU2obkMyRBrDPoK75jS4e7VzCr4k3RWLMHzKSC5WttcvLvYHoyMG/eidznmZEVz0dEblA2Y+W92TAVZ19qZZ+WD1XNJubJhSt4gqd10Wt01kisW54VGeP9ORIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kr5QSr0Vwn2zJdLb/02bjNvdjn4FBt/O6ZogGGbnhA0=;
 b=ZrRQYNt3zPvUZktriEcoCX3NKCp0vq89jWYFC1CFEb/u46f4kFqSMrz8mlEP2Qa1Spzyx/KgN3199HaaJ1huwXxqzxYX3rjR1y7I0+izx96fpyMRgY4L75YhrY+fd9ssYxrTWFUdr/jmsVlF7NdGxEyvc1s+obGjfyjpm8E2mbM5OQ8YVMu7J4eyfik20nO4ngSD762btIgYO9MpYWMrB88gyk+ceQA4NG/fN53YAijQt6W5IAAVr2SN0P0+DxaeTRfbyrZ3CsElx0UaMPn9G6xBEvk0pc/+nc2FdgrzT7VFh6gDp+a2ysoDlleSxHd5c1sLcvz6vTZhBiXTbmw0/Q==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 17:22:12 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 17:22:12 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>
CC:     Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v19 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v19 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYHDPFJEXt+ayd6UCTLcFwvF14KKyIoPmAgAFHF8A=
Date:   Tue, 8 Feb 2022 17:22:12 +0000
Message-ID: <DM5PR12MB18500301A842B79A803096C3C02D9@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1644246094-29423-1-git-send-email-akhilrajeev@nvidia.com>
 <1644246094-29423-3-git-send-email-akhilrajeev@nvidia.com>
 <fd8ba6fc-b389-3e8e-2671-51656d3d8e5c@gmail.com>
In-Reply-To: <fd8ba6fc-b389-3e8e-2671-51656d3d8e5c@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3a5d2ad-738e-40d9-32d9-08d9eb278b54
x-ms-traffictypediagnostic: BL0PR12MB5537:EE_
x-microsoft-antispam-prvs: <BL0PR12MB5537D8F92708D98A6BAF5BC5C02D9@BL0PR12MB5537.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Va9CgorGPmEyMUs8Nf6+DnvGldyAbxKaREjhzGDNpACGSYOA7yX7ZPxOAwiv2RbPn5d1gMxkPg9FPMD91kSRWB3DUld9Ot+2WywtQyvZdkKUsPD/dRbzxTiZ4X1bW0FKkU1GF37tr8rShcYBSBd+bMUkFJ/U8SoeAxm5MV4FxQdMeBPrewXNCgvfkPsxTNoHm4UqyEdUAFBBVgJzRLjVFhKjGE8k7Ja67k7JAtmotC6i92Tlw9YVxJ0lCwG31/yKGX+qxOq8h35jo0tiKIL94AyxLe4GHMt9/T0tkn+yxFY0Ir+yLrcCZ5Cn8k+7phbIHxFEdzEvZRlyiYsvoXIzneevZFueKHRrkxotxslB/xvybNhcD8Qmdlmlfnmlp1YSoHg/PppjS9gjo8yx/lYpPoknVQaxx3yhpUR1vyeseBHfBUfaE4w/90Mgp1MCaMkPHIBjlztXHaBjpVDtvx1m/fDEXHaWtVX8e+eUabkn4D6/gAnfpDI4mGAI+whRRgjwcbKYxqXuKYlWLqUP6U6enpxbyRjaRZrKWXDhZ9JVcLaqsQNh8uG20a5F8pCHLzo5v0KUh17TI7dXMgGg3olepfFM4R1a2LbrjQGUBpRUlKx4WXHrkZccUxAPdEN6NMTrMAOxcplHV+YQdad+pizNTriLcbPEheKqLJ6aEYeM0zV1J1R/gdb5wH4GksqnoHZFD6Bvip0zOIV2EBt4eBzy/KogLcH+/8RafiKROq/gVHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66446008)(66476007)(66556008)(2906002)(8676002)(55016003)(76116006)(64756008)(55236004)(86362001)(52536014)(33656002)(38070700005)(8936002)(4326008)(107886003)(122000001)(5660300002)(508600001)(316002)(38100700002)(26005)(7696005)(921005)(6506007)(71200400001)(9686003)(110136005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW95OG42TXgrN1RRT2cwdXAwQWRrVHdrQlhMaWJqRjJHVnQ1WVNrTzVXYUtD?=
 =?utf-8?B?b1VZU1hsdGJSTnhvbzY4aVFkODQ3eTdBNForVmFraVFNLytoTlhwTkd6d0pY?=
 =?utf-8?B?dmtHMzJITXppcEVpWlpYeGthWUhBOEtMcmZYOFlvbFBFY1ZjeGlGYTREaUpP?=
 =?utf-8?B?NjlOOWZxaklGWDcvWHJ2YkNLNC83a1VQbDROc1BjcDNoNlVKSTJQUTNXU2JZ?=
 =?utf-8?B?UnlEaFJIbVdNV1p3REpTaXV4VUN4eUtnRTZodjBoVmRRSFdIakRrOUxaZnMz?=
 =?utf-8?B?RmVCVCs5NnpwcE1DcjQvMm9Db3ZmQ2ZmdmVDWGpxRW16bnkyUkNBYTg2Sk1h?=
 =?utf-8?B?cXdEZGJhUlhJcDc4RndVdU8vUDFLcUJIYzdzaXRTMlo4Wis4VTc4OXhuSjc4?=
 =?utf-8?B?OXo3eXpQYThRVGxTTzcwU1krNEVIU1FMRzFtVUtqRkRFeUNrRmZVZU5FWnpZ?=
 =?utf-8?B?TVZ2U3FPbTA1YmxYcUpydER0MUxGQkhnSHNQMlFVREhkLzJ6dUFIV3llQnRt?=
 =?utf-8?B?bjVUV0JBQkZXUjczMmN1akFMVUVZNTVIM2Zqd1N5V0JxaGg1UGh2TDUzcmhz?=
 =?utf-8?B?cG1QdmJ0N3NMVHFwdW1KeGlVdEVWbTVEWTNZU3hJUnZIZW4rN2FJQ0RiK284?=
 =?utf-8?B?SHpGWVhJSklmRWNEOUllZlZkbURUY09xY1U4VW9aSXRNNzlRSGx1ZEVTSlkr?=
 =?utf-8?B?WFBDVWtVaFlqZ2RHVVZYdjlXNytvM1ZKMlo3aVhTVnRlQXlWTU1sK0tObmlO?=
 =?utf-8?B?WEMrWXAzckc3WSt2d29paVdMS3BYS2tuTzdpWFljdmE5MnovV2xaYjA3NSs4?=
 =?utf-8?B?M2lzQTJMb0VZZ2hlQ2IwNEVnNXAzYnJkd3lBenNRWVF0dFdjYjI5TFFESWRE?=
 =?utf-8?B?NUpCcnRmQ0JjU2pXcmZubVo0QVJ3Z0dOcDhuQmkrai81OVFQelR1azFlMmFY?=
 =?utf-8?B?ZFdBbGxPTGZMSm5nK1N4WWZNSjdPalNIQXd3WEV3bEtQS0tZWGYrVmpNZm80?=
 =?utf-8?B?NDZUcktZNG0vQ0NkQUxqSHhrSzQ1NXlQZE5WYUJweUdQUFl6NE1WN1dUUStL?=
 =?utf-8?B?c0Y5RGRNSEc0M2ZTL2RNM3V2WWNKVG1hc1FmQXIwRFcvbWphYWFqV2RmWWhu?=
 =?utf-8?B?bHp3Q2t1MC9XSjZrelhrOXpkVmFSZmpPQ0tOYyt5ck9pZ0x0QXF2b2VRUDMz?=
 =?utf-8?B?dUE4VG1aSGE0bkR6bWtZNll2a3hBalJrZWxSQmd2OFNnU1Y5aGVaVEdFMEtt?=
 =?utf-8?B?OFhoNzZkcHZLbFBhR25PL2JrWDdwS0MzdzdwM0U1NWJEdC96U3B4Y3VNY0JB?=
 =?utf-8?B?SXh5QU9HeU1zNE9Lb1V3Z1dnUitGUjJSVDZ3U0kzVkNMYm5URTVuRVljY2lU?=
 =?utf-8?B?MENBblZ4MDN4Y1lBeFVGc1J2d1lMTmN5N2JhTGdJOVB4TFpzRnRyWmt1Qksv?=
 =?utf-8?B?YTVtOGxTSXZXbWY3aWZpdys2WG5VcHdhMWVFQ3ZtOUs2YXlHNkt2UmtWdlY0?=
 =?utf-8?B?aE1QK1NvbytZbjVJcSt1VHJ6QWNqQndNMkxveUd3RnI5b0ljK3pucjZhSXZ6?=
 =?utf-8?B?cUNaemU0L0FRTWl1eVMyaEdSTUFxL0lhby95Ym9kSjJONENpZ2pPRUpJVW1W?=
 =?utf-8?B?bytUU3RrUktFVmhHUDBXK0dCNG5QNW02MW84Y3FvWnFDSm5rMmc5ZzJvRmRi?=
 =?utf-8?B?ODE5NEw5eitYSnBCc3EwZjN6TDY2V2xVVmYzL3Jtc0NDU0QrdEowVmpIUTlv?=
 =?utf-8?B?djZpVzlHMVZwRWR5N0pHb2cvZGhxZXF5NllQZGtlZDZOTHFNQmtJTTltQW5k?=
 =?utf-8?B?dUdyMks4dVIva1I0RXUraEpnZi96bk05WHYvRUs3NGhZN09QWXZhczJtUHlC?=
 =?utf-8?B?eHlGZVdqM0lQemlXc0dYbGUxOFdQL2xDaFBGa3BsZU9WeEJobkhkbVlUcUxM?=
 =?utf-8?B?eFpEVTE0bER5M3o1SUhua1dkY24xNFUxUExHTFRlMXNydmErSVFxa2h0TXVO?=
 =?utf-8?B?eVBPaituSFpVeW9KOFlOdldmQjVFTi9zMFQyQjV4aUhoSTlKMEVxS0ZIV0tq?=
 =?utf-8?B?SlIyNTlVRldPQ2xITXkxVEdqbU1tUStPdWgxYi9NVlh1REpnQWhjc3BXSkRB?=
 =?utf-8?B?WkF1QWpJd2pZd3NmOHlMT0llVkFQd3FkLy9SWlR6TmdJNStTcGJCa2g3MHRO?=
 =?utf-8?Q?avs/er3+e0DI6Wfvlw0t3sc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a5d2ad-738e-40d9-32d9-08d9eb278b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 17:22:12.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQ+Dc6UeDSY6QFiJlQbYALIiNXNrKkv4vpp91R8CV96mm0tRdku9bZLdcgX2RhNp5PuHrMXwnk0o5kX6qd8iig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAwNy4wMi4yMDIyIDE4OjAxLCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4gQWRkaW5nIEdQQyBE
TUEgY29udHJvbGxlciBkcml2ZXIgZm9yIFRlZ3JhLiBUaGUgZHJpdmVyIHN1cHBvcnRzIGRtYQ0K
PiA+IHRyYW5zZmVycyBiZXR3ZWVuIG1lbW9yeSB0byBtZW1vcnksIElPIHBlcmlwaGVyYWwgdG8g
bWVtb3J5IGFuZA0KPiA+IG1lbW9yeSB0byBJTyBwZXJpcGhlcmFsLg0KPiA+DQo+ID4gQ28tZGV2
ZWxvcGVkLWJ5OiBQYXZhbiBLdW5hcHVsaSA8cGt1bmFwdWxpQG52aWRpYS5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUGF2YW4gS3VuYXB1bGkgPHBrdW5hcHVsaUBudmlkaWEuY29tPg0KPiA+IENv
LWRldmVsb3BlZC1ieTogUmFqZXNoIEd1bWFzdGEgPHJndW1hc3RhQG52aWRpYS5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogUmFqZXNoIEd1bWFzdGEgPHJndW1hc3RhQG52aWRpYS5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogQWtoaWwgUiA8YWtoaWxyYWplZXZAbnZpZGlhLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogSm9uIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvZG1hL0tjb25maWcgICAgICAgICAgICB8ICAgMTEgKw0KPiA+ICBkcml2ZXJzL2Rt
YS9NYWtlZmlsZSAgICAgICAgICAgfCAgICAxICsNCj4gPiAgZHJpdmVycy9kbWEvdGVncmExODYt
Z3BjLWRtYS5jIHwgMTUwNQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTUxNyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2RtYS90ZWdyYTE4Ni1ncGMtZG1hLmMNCj4gDQo+IExvb2tz
IG9rYXkgdG8gbWUuIFRoYW5rIHlvdSBmb3IgdGhlIGVmZm9ydCENCj4gDQo+IENvZGluZyBzdHls
ZSBpc24ndCBpZGVhbDoNCj4gDQo+ICAtIGluY29uc2lzdGVudCBhbGlnbm1lbnQgb2YgdGhlIGNv
ZGUNCj4gIC0gdW5uZWNlc3Nhcnkgd2hpdGVzcGFjZXMgYW5kIHBhcmVucw0KPiAgLSBpbmNvbnNp
c3RlbnQgdmFyaWFibGVzIHR5cGUgc2lnbmVzDQo+ICAtIGFsbCBhYmJyZXZpYXRpb24gc2hvdWxk
IGJlIGNhcGl0YWxpemVkIGluIGNvbW1lbnRzIGFuZCBjb21taXQgbXNnDQo+IA0KPiBidXQgdGhp
cyBpcyBub3QgY3JpdGljYWwgYW5kIGNvdWxkIGJlIGltcHJvdmVkIGxhdGVyIG9uLg0KPiANCj4g
UmV2aWV3ZWQtYnk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4NCg0KVGhhbmtz
IGZvciB0aGUgcmV2aWV3Lg0KDQpSZWdhcmRzLA0KQWtoaWwNCg==
