Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A314A4AB8
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 16:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379732AbiAaPiK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 10:38:10 -0500
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:28256
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376980AbiAaPiJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 31 Jan 2022 10:38:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd3l+7Sy79PT5tgDdlY1W2AED9Pr9REWt0FRFCN3SKzYCgdVdUhqYBzjWCfUsTiFypI1buHxm2UFX1goNb/D0RByLbmJdYrNt2Za4rlR1vqDk8SE/IS1hETL2p9wgMB+VaGyaDfNbLRp0GkteTtIQbySRwR3CTLOGQP+2T1iQNe4wkvuIKmJhJOGjB1wF+PghgcCzxHWO2il5/0GnJdaVgW/9+l0xgPMlgs94cpe8VYOlRgNHHBj3ZjpFcXm4ShzyPvN63j8JSU1P/7sFu1PEXN5onqWSzITj/rLi1Mf4JQRBOVRIl6S0POdXUxxT/V+JzCL3t+YWCONky/tnBLiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0W4iwygjwA18Ec5kGcRy92q1MdUbmqTywrvCuSdS2k=;
 b=mdCwWROXT/jWWj0JLTPWOpnrjvKZF7K8SPlLGe6MAFKM6X5W/+3qQW/0oSzsEGVFDUZfqPzVqlp3C77QirJwUkyEwLbbpoONFJ/WZYAFx5Y9iHgULuOy/3VGoNpjIlbQSjoNIv/XXRfLzFXQb18hCtV1iqtG8OMbKFFG04r8yyMa5RxVaZ8bMDFhEKk4SAsFHkBATUdCc/ApsZ8Bwc//Co3Y5gDVJGC1EW0/Pin+oPQ8P2StRrgZhg2/9eVKe6tAWzh843rve+nbkuk6GPCfmnV0j4tBCFXroLFMZgDmPng700ATzLt2QHiluUFsiVjUyP7OulqO3CZHQQdmHbJ3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0W4iwygjwA18Ec5kGcRy92q1MdUbmqTywrvCuSdS2k=;
 b=GWPRcY1EdvDFshuGt80YJKv/AJ3N+3jtn7c1IjWlmyCgsc/v7e8u5YfR25LXX7zDubGYfF/Kk643TvU1gfMxhrom7v03eVwe++MG9rrgNukGrXDVOU9xnqKMRzr02uwLvI/YEkywRmSOC6eeMkPzkMjf8mnQrQ6svOpGlIMnkV/oVWE0s1krF6ywKH+c0NJL6gYHMnZM+7nNkLEnhmG33TVbpZaXbhgiEqVIs3Q4Rdw46tSPAUSsnRXXaFC3Ob4uHTRyYB1kCU9fPmSM8kzjsUolQwPtO0SIjPPKGWxaVge0H8tAKbmRLoRPqKXDjQZOwQaeReilNsBbGHPngbrxug==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 15:38:07 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::94d8:5850:e33d:b133%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 15:38:07 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: RE: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v17 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYFS8ttZm9vnsYMkmLjfwGSkse9qx7V3sAgABn8UCAAHOwgIAAU3IwgAAqZYCAACYYkIAABPUAgABaxWA=
Date:   Mon, 31 Jan 2022 15:38:07 +0000
Message-ID: <DM5PR12MB18505C4CB4A34F96E74BF28FC0259@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1643474453-32619-1-git-send-email-akhilrajeev@nvidia.com>
 <1643474453-32619-3-git-send-email-akhilrajeev@nvidia.com>
 <ba109465-d7ee-09cb-775b-9b702a3910b0@gmail.com>
 <DM5PR12MB1850D836ACDF95008EF74CC7C0249@DM5PR12MB1850.namprd12.prod.outlook.com>
 <08f6571e-af75-b6b3-443e-e86e3bdb365b@gmail.com>
 <DM5PR12MB1850FD5F3EF5CBFEA97B3611C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <20220131094205.73f5f8c3@dimatab>
 <DM5PR12MB1850D677140466EC74C621A4C0259@DM5PR12MB1850.namprd12.prod.outlook.com>
 <8abf2da8-9a11-8f16-b495-d8ef2d00ab51@gmail.com>
In-Reply-To: <8abf2da8-9a11-8f16-b495-d8ef2d00ab51@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7b94d62-e5ee-4855-4661-08d9e4cfadb0
x-ms-traffictypediagnostic: BY5PR12MB4242:EE_
x-microsoft-antispam-prvs: <BY5PR12MB424211A8B0E0546FDEA71A2AC0259@BY5PR12MB4242.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zNXa8MJC9eW+y9m99+LuVcEuyKRDOj4ri3N408QWIpNwNiAy3D9e6tSu8bG8+Xgjh1leAjXxOnXaMffgYrlQwTNzgoeYkQ2gy2uNyYwqaEfSJk9lXhFlbU12pwL9pSmrbmNxV81fYdt70swyyoFUFykYOi74V/kY3a2lhywVsQ734DQuYPdfj2b+2IHxBc1seRxAhMFABuLq8yv+FPAFn/z0EXrhK2QJc4H6nuGXVYoIfD3K1d92U1LM/MdYV0jrSjztS8WIv4yko9s/yLJuRCiwhh4VxVKh5WeAdZ5BLslmrlyLX0U0QFs3XpxMfEKVtPubZrt2l6vFkp+/bq1J/PBKQ6z/e+IE09We591H0ofxQfj6qGvNInO2H6qzg8J6Gfbc8gqvbqiWp0hILNNfcQKS8PyD8GLLDMZeOxjuAzD/R/hCQrfUdjMdWiQPtwIGGn0K+qEPoHxb6Qa7bd+c0YFxyLPZgCdea2LJztoUhgRJkwZSnWIZMCNGBhYtvhkTxsAgCh4Rcx4aJg0SJESzgOUljb8YAz3KGIFhcXB7J/A/n4+XFdC9LU+Ptf98rEcajg8P8eIRpYavBFLo88hcJCOXzets0e1RyIEGCSf7t/S6XSMJDnDyOrmV3gj24E5KVPfAvTzuCEv5cZ7vyZLiNkWdVAK36cTVFpwB0fcY9ZIs9WPiRbTOWll0h7vpZ0rpLyDV0XlmyidCmhMJJTChtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(2906002)(66556008)(8936002)(86362001)(107886003)(66446008)(55016003)(66946007)(83380400001)(38100700002)(122000001)(64756008)(66476007)(38070700005)(6916009)(76116006)(7696005)(52536014)(9686003)(54906003)(6506007)(55236004)(33656002)(26005)(5660300002)(316002)(508600001)(71200400001)(186003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZRQ1VUa1F0R3J4bTVhNVRYd2Z4b2JZN0xOcGtrYVVETXd4ZGJTcEcraWV2?=
 =?utf-8?B?QlF1VGpZUmRBNkZycWJPQjdFUUNhd25pWldyZ3g3QW1HYWd1bmt2WDlKVW55?=
 =?utf-8?B?N0RDc0pZN2hadU9hRU11Z1huZXBvamZPa1NodTROUnhFbGtOQUt3aVJOSnpi?=
 =?utf-8?B?MXFWNnhzS0RMTm1MaHlROEc1N3ZldXJZZ1ZxUlR5U0xWckVGWWZiQml5WGpj?=
 =?utf-8?B?TzgxYURwd1Z0V3lJZFFSbnJpZkMxd0hrMFFTZ2kwT1NkMk1LNnUveWZFQkpX?=
 =?utf-8?B?TWJxS0VqMkR1RDRTWThtem94cXFFeitScEtOcmErSGw2ZlBGM3A1TitSWnhQ?=
 =?utf-8?B?WCsrUjQ3dWZWNW91VFNudmZ0WDdVeVdsVkN5MVh0STk1eVdTY2loT0pBaVBO?=
 =?utf-8?B?eTdRZ3RONnpXZ21mOWRvMWNPWjNRRkRML21mUlZhUWNiSk1OTXFuc1VUcXZ1?=
 =?utf-8?B?aEVmRWZTdHZBWG9rYmdCKzRCdlUzOE03ck1xeGFRQnpaYVJtZThlcXBSMUVP?=
 =?utf-8?B?TzB6K3lNMGREbjR4UDRWZmo5MEFvaUxYTlRjREI0SUJjVEZQMVpKNHRsZVFZ?=
 =?utf-8?B?ZHNaay80cG9UZ2ZvNDk3anZjbTVYSVJsWllLaUFYKzlWRm8rQ1Eyek8yeE1Q?=
 =?utf-8?B?K0FraTRGekJSaXpkbndvMmRtRHJHeHRFdUJ3TFpXTVIzRVhNWlRPSmpHQmVi?=
 =?utf-8?B?ZmM5aFd0MjR5cko2WU93a244VFVIak56ODJCVW5JenJRS3JRaWlLVTE5b1RL?=
 =?utf-8?B?a2Q0L0RjSHZmalNFdGJtZEdOdHNvV0hnU0R0S1ZWNmtCeEdKOEFEcnE5dXZN?=
 =?utf-8?B?U1d0Mm9kZFExejl2aE43R3I2THZaWU13UFNGKzU1MWZTdS9iZ05JQ0c2VHU5?=
 =?utf-8?B?UlBwTHdnWW5KR3dpenpuYStKWDdxWjB2S0dGZjVJT0grOFg3QTJ5SncrTm1B?=
 =?utf-8?B?MFkzY2pHKzc5ZEprcitManl2K094Zm90dEMwcHZxVHFaU3Jkamw3Wmw1MG0z?=
 =?utf-8?B?dWdvK3VLZjgwTERTT0s4eHJHNUJNNzJwdW9rQkZ2KzVzTFdrZm9IZFNOVVN4?=
 =?utf-8?B?WVFad3JPUlVFeUFXOGx5Z2JsZXZmakZVUFQ1QStvSFk2ZjhpRjhpbFdrRUJ3?=
 =?utf-8?B?OHVDclBkT2RWS3pSQ1JrYU4zL2M1U0h0MkN3STAvZ3hHMU5iWkQwdng5a1Ji?=
 =?utf-8?B?d1JoVEtqeWRJUXFwWXJuSG1YTDdza05iRWlTZkpDakRkSVRvbmVzK0NaM0FZ?=
 =?utf-8?B?UW13NGpaekJqR2REYlFqOXIwM285SEQ1ZU1iVWgzQ0Z6MWljWi9DWTFiWEtQ?=
 =?utf-8?B?MEtWdEZUOEdZcmxDYUhReHhFNzdaaG5TVk9lWHU5blRtQy9RY2wvSElRaFRX?=
 =?utf-8?B?UytJTitQZVczZjcrTTNMMjAyRDRyWG9YRVBMdVNPRWpPeW9MM01FQ2s5OWZT?=
 =?utf-8?B?R2pEdW9ZV2lNTFc5d2NqMytvTGNZbXUxeXk2dXJXdkUrVnU1dllnOVNEaGpL?=
 =?utf-8?B?V1gxSEQ4RkVDMldMczZOTXVqc3dIWGlpRGtFWEpFdFFKUktmRzV1RmMwUjJO?=
 =?utf-8?B?SXozVFFQaGpTeDhwVzNrWXYvV3B4Tm1mM1RGUnErUVZaSmJlVjNBeGgrTVpB?=
 =?utf-8?B?WGdvMEtIb3Axd3ZmT0ViMlNpN3VSdnEzSlVuRld5MHBOak5kT0NVTWZaQ0Zh?=
 =?utf-8?B?ZTBtVHQ5blo5YXF5dVVSZFRvb3hPd1FOejk0UmphR1p2c1ZxYW5vczl1MUt5?=
 =?utf-8?B?eVNpWGd2ZFZONWEvak0wY2MraW4rZmdLQW1obGFGWlhGdGNmUFV4ZzR2dWdn?=
 =?utf-8?B?ZVVvcHJGZWhFR2M3SUZXUHcyUFRQZzYyalA4VjNEeVAyUVd1cXg1N2c2ZkJl?=
 =?utf-8?B?MHphZUFLb3BkVW5jQkM2OHRic2FiYlFLLzRWbzFKM3pTdnFlZEhNdVhhMzJm?=
 =?utf-8?B?aEo4ZUhYeHpKWVJNYVBpMkd3T1dWYXhnMHFxZTFXK3hqditEVHh2RURDTEli?=
 =?utf-8?B?WUZBSFlqeXFmd1J1dmI1VHdESHVDNi9ZT0RYbkdTcVVTM2VnQWhGVkVSREla?=
 =?utf-8?B?TlB2bGRPRVJNMnE5d2xpOW9YNmdCQWJyZnlKU3JJV3kycFM3NVFGdURiZ0JL?=
 =?utf-8?B?RnpraXl2K1pGS1QwU3JGRi9BOUIzVGpubTY1UXZyRVlmK1l1bmF6dW0rRzcz?=
 =?utf-8?Q?rgNySpttT+J1Y9GsIKYiVdU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b94d62-e5ee-4855-4661-08d9e4cfadb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 15:38:07.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNq5d0b7GeE9GVM0cr5QCMP7yNhLJ89rGQwbAZmoFKrnALOZZMsNcS+19o37LBaD4NzijHqqzkvy4c8QpbfN/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAzMS4wMS4yMDIyIDEyOjA5LCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4+INCSIE1vbiwgMzEg
SmFuIDIwMjIgMDQ6MjU6MTQgKzAwMDANCj4gPj4gQWtoaWwgUiA8YWtoaWxyYWplZXZAbnZpZGlh
LmNvbT4g0L/QuNGI0LXRgjoNCj4gPj4NCj4gPj4+PiAzMC4wMS4yMDIyIDE5OjM0LCBBa2hpbCBS
INC/0LjRiNC10YI6DQo+ID4+Pj4+PiAyOS4wMS4yMDIyIDE5OjQwLCBBa2hpbCBSINC/0LjRiNC1
0YI6DQo+ID4+Pj4+Pj4gK3N0YXRpYyBpbnQgdGVncmFfZG1hX2RldmljZV9wYXVzZShzdHJ1Y3Qg
ZG1hX2NoYW4gKmRjKSB7DQo+ID4+Pj4+Pj4gKyAgICAgc3RydWN0IHRlZ3JhX2RtYV9jaGFubmVs
ICp0ZGMgPSB0b190ZWdyYV9kbWFfY2hhbihkYyk7DQo+ID4+Pj4+Pj4gKyAgICAgdW5zaWduZWQg
bG9uZyB3Y291bnQsIGZsYWdzOw0KPiA+Pj4+Pj4+ICsgICAgIGludCByZXQgPSAwOw0KPiA+Pj4+
Pj4+ICsNCj4gPj4+Pj4+PiArICAgICBpZiAoIXRkYy0+dGRtYS0+Y2hpcF9kYXRhLT5od19zdXBw
b3J0X3BhdXNlKQ0KPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4+Pj4+Pg0K
PiA+Pj4+Pj4gSXQncyB3cm9uZyB0byByZXR1cm4gemVybyBpZiBwYXVzZSB1bnN1cHBvcnRlZCwg
cGxlYXNlIHNlZSB3aGF0DQo+ID4+Pj4+PiBkbWFlbmdpbmVfcGF1c2UoKSByZXR1cm5zLg0KPiA+
Pj4+Pj4NCj4gPj4+Pj4+PiArDQo+ID4+Pj4+Pj4gKyAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJnRk
Yy0+dmMubG9jaywgZmxhZ3MpOw0KPiA+Pj4+Pj4+ICsgICAgIGlmICghdGRjLT5kbWFfZGVzYykN
Cj4gPj4+Pj4+PiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+Pj4+Pj4+ICsNCj4gPj4+Pj4+
PiArICAgICByZXQgPSB0ZWdyYV9kbWFfcGF1c2UodGRjKTsNCj4gPj4+Pj4+PiArICAgICBpZiAo
cmV0KSB7DQo+ID4+Pj4+Pj4gKyAgICAgICAgICAgICBkZXZfZXJyKHRkYzJkZXYodGRjKSwgIkRN
QSBwYXVzZSB0aW1lZCBvdXRcbiIpOw0KPiA+Pj4+Pj4+ICsgICAgICAgICAgICAgZ290byBvdXQ7
DQo+ID4+Pj4+Pj4gKyAgICAgfQ0KPiA+Pj4+Pj4+ICsNCj4gPj4+Pj4+PiArICAgICB3Y291bnQg
PSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX1hGRVJfQ09VTlQpOw0KPiA+Pj4+Pj4+
ICsgICAgIHRkYy0+ZG1hX2Rlc2MtPmJ5dGVzX3hmZXIgKz0NCj4gPj4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgICAgdGRjLT5kbWFfZGVzYy0+Ynl0ZXNfcmVxIC0gKHdjb3VudCAqIDQpOw0KPiA+
Pj4+Pj4NCj4gPj4+Pj4+IFdoeSB0cmFuc2ZlciBpcyBhY2N1bXVsYXRlZD8NCj4gPj4+Pj4+DQo+
ID4+Pj4+PiBXaHkgZG8geW91IG5lZWQgdG8gdXBkYXRlIHhmZXIgc2l6ZSBhdCBhbGwgb24gcGF1
c2U/DQo+ID4+Pj4+DQo+ID4+Pj4+IEkgd2lsbCB2ZXJpZnkgdGhlIGNhbGN1bGF0aW9uLiBUaGlz
IGxvb2tzIGNvcnJlY3Qgb25seSBmb3Igc2luZ2xlDQo+ID4+Pj4+IHNnIHRyYW5zYWN0aW9uLg0K
PiA+Pj4+Pg0KPiA+Pj4+PiBVcGRhdGluZyB4ZmVyX3NpemUgaXMgYWRkZWQgdG8gc3VwcG9ydCBk
cml2ZXJzIHdoaWNoIHBhdXNlIHRoZQ0KPiA+Pj4+PiB0cmFuc2FjdGlvbiBhbmQgcmVhZCB0aGUg
c3RhdHVzIGJlZm9yZSB0ZXJtaW5hdGluZy4NCj4gPj4+Pj4gRWcuDQo+ID4+Pj4NCj4gPj4+PiBX
aHkgeW91IGNvdWxkbid0IHVwZGF0ZSB0aGUgc3RhdHVzIGluIHRlZ3JhX2RtYV90ZXJtaW5hdGVf
YWxsKCk/DQo+ID4+PiBJcyBpdCB1c2VmdWwgdG8gdXBkYXRlIHRoZSBzdGF0dXMgaW4gdGVybWlu
YXRlX2FsbCgpPyBJIGFzc3VtZSB0aGUNCj4gPj4+IGRlc2NyaXB0b3IgSXMgZnJlZWQgaW4gdmNo
YW5fZG1hX2Rlc2NfZnJlZV9saXN0KCkgb3IgYW0gSSBnZXR0aW5nIGl0DQo+ID4+PiB3cm9uZz8N
Cj4gPj4NCj4gPj4gWWVzLCBpdCdzIG5vdCB1c2VmdWwuIFRoZW4geW91IG9ubHkgbmVlZCB0byBm
aXggdGhlIHR4X3N0YXR1cygpIGFuZA0KPiA+PiBkb24ndCB0b3VjaCBkbWFfZGVzYyBvbiBwYXVz
ZS4NCj4gPiBJZiB0aGUgYnl0ZXNfeGZlciBpcyB1cGRhdGVkIGluIHR4X3N0YXR1cygpLCBJIHN1
cHBvc2UNCj4gPiBETUFfUkVTSURVRV9HUkFOVUxBUklUWV9CVVJTVCBjYW4gYmUga2VwdCBhcyBp
cywgY29ycmVjdD8NCj4gDQo+IFlvdSBkb24ndCBuZWVkIHRvIHVwZGF0ZSBieXRlc194ZmVyIGlu
IHR4X3N0YXR1cygpLiBQbGVhc2Ugc2VlIFRlZ3JhMjANCj4gRE1BIGRyaXZlciBmb3IgdGhlIGV4
YW1wbGUsIHdoaWNoIHN1cHBvcnRzIEdSQU5VTEFSSVRZX0JVUlNUIHByb3Blcmx5Lg0KDQpEb2Vz
IHRoZSBiZWxvdyBtZXRob2QgbG9vayBnb29kPyBieXRlc194ZmVyIGlzIHVwZGF0ZWQgb24gZXZl
cnkgSVNSIGFuZCBpbg0KdHhfc3RhdHVzKCksIHRoZSB3Y291bnQgaXMgcmVhZCB0byBjYWxjdWxh
dGUgdGhlIGludGVybWl0dGVudCB2YWx1ZS4gSWYgdGhlIHRyYW5zZmVyDQpnZXQgY29tcGxldGUg
aW4gYmV0d2VlbiwgdXNlIHdjb3VudCBhcyAwIHRvIGFkZCBzZ19yZXEubGVuIHRvIGJ5dGVzX3hm
ZXINCg0Kc3RhdGljIGludCB0ZWdyYV9kbWFfZ2V0X3Jlc2lkdWFsKHN0cnVjdCB0ZWdyYV9kbWFf
Y2hhbm5lbCAqdGRjKQ0Kew0KCXVuc2lnbmVkIGxvbmcgd2NvdW50ID0gMCwgc3RhdHVzOw0KCXVu
c2lnbmVkIGludCBieXRlc194ZmVyLCByZXNpZHVhbDsNCglzdHJ1Y3QgdGVncmFfZG1hX2Rlc2Mg
KmRtYV9kZXNjID0gdGRjLT5kbWFfZGVzYzsNCglzdHJ1Y3QgdGVncmFfZG1hX3NnX3JlcSAqc2df
cmVxID0gZG1hX2Rlc2MtPnNnX3JlcTsNCg0KCS8qDQoJICogRG8gbm90IHJlYWQgZnJvbSBDSEFO
X1hGRVJfQ09VTlQgaWYgRU9DIGJpdCBpcyBzZXQNCgkgKiBhcyB0aGUgdHJhbnNmZXIgd291bGQg
aGF2ZSBhbHJlYWR5IGNvbXBsZXRlZCBhbmQNCgkgKiB0aGUgcmVnaXN0ZXIgY291bGQgaGF2ZSB1
cGRhdGVkIGZvciBuZXh0IHRyYW5zZmVyDQoJICogaW4gY2FzZSBvZiBjeWNsaWMgdHJhbnNmZXJz
Lg0KCSAqLw0KCXN0YXR1cyA9IHRkY19yZWFkKHRkYywgVEVHUkFfR1BDRE1BX0NIQU5fU1RBVFVT
KTsNCglpZiAoIShzdGF0dXMgJiBURUdSQV9HUENETUFfU1RBVFVTX0lTRV9FT0MpKQ0KCQl3Y291
bnQgPSB0ZGNfcmVhZCh0ZGMsIFRFR1JBX0dQQ0RNQV9DSEFOX1hGRVJfQ09VTlQpOw0KDQoJYnl0
ZXNfeGZlciA9IGRtYV9kZXNjLT5ieXRlc194ZmVyICsNCgkJICAgICBzZ19yZXFbZG1hX2Rlc2Mt
PnNnX2lkeCAtIDFdLmxlbiAtICh3Y291bnQgKiA0KTsNCg0KCXJlc2lkdWFsID0gZG1hX2Rlc2Mt
PmJ5dGVzX3JlcSAtIChieXRlc194ZmVyICUgZG1hX2Rlc2MtPmJ5dGVzX3JlcSk7DQoNCglyZXR1
cm4gcmVzaWR1YWw7DQp9DQoNCnN0YXRpYyBlbnVtIGRtYV9zdGF0dXMgdGVncmFfZG1hX3R4X3N0
YXR1cyggKQ0Kew0KCS4uLi4NCg0KCXNwaW5fbG9ja19pcnFzYXZlKCZ0ZGMtPnZjLmxvY2ssIGZs
YWdzKTsNCgkuLi4NCgl9IGVsc2UgaWYgKHRkYy0+ZG1hX2Rlc2MgJiYgdGRjLT5kbWFfZGVzYy0+
dmQudHguY29va2llID09IGNvb2tpZSkgew0KCQlyZXNpZHVhbCA9ICB0ZWdyYV9kbWFfZ2V0X3Jl
c2lkdWFsKHRkYyk7DQoJCWRtYV9zZXRfcmVzaWR1ZSh0eHN0YXRlLCByZXNpZHVhbCk7DQoJfSBl
bHNlIHsNCgkJZGV2X2Vycih0ZGMyZGV2KHRkYyksICJjb29raWUgJWQgaXMgbm90IGZvdW5kXG4i
LCBjb29raWUpOw0KCX0NCglzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ0ZGMtPnZjLmxvY2ssIGZs
YWdzKTsNCg0KCXJldHVybiByZXQ7DQp9DQo=
