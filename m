Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F7490247
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 08:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiAQHCM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jan 2022 02:02:12 -0500
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:41312
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235059AbiAQHCL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 17 Jan 2022 02:02:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9++C4REIdYIAhNjAnohrfNmkfMF2oRqh9rxiMQ+t+3ZjzP1slxrJrxup1fd+LITBgX6XWUmxVEV3GbAEMNNoGOl3DsYAUksze1PGnKDvtR2IujMZ9txKVDeJEx5d7fbvH+wlVg1hmqGGaJOMRKIBRMTyRLrOn/xdV/Oa0/xW/xERRwB5xJBpmezcbdspnU4Y1ijHOkP8j+DJLkk0GU6WxZ98c1bxo5Qck6uUokHt9e74iqtCrTjFQ4GlSrOyzF/x+BIRoZx/JVOzClI9f2RxwZeok55O7fZEnxR6fDrYfsWCPd4v6y4gxe3D6fc+PLYpD6LAPi9R2oV2ejeLtLxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxukNvnmf6Aigm61oB2pGLhp+XtFN3PmcLUBepP7t6w=;
 b=lwSTviL8ftKDUrlXVgVkwzfvYZ5Olfbhpq5u+Bs9mqFkQ5iAhZLOT0Es0Pnb0gu7Sh+Fd2Waoffup357zJglmrwS6mV8wr8D22WTFyUXOHNVMK6QkpqgpYacSXmVY+CMmX8DVDUEY1r87vGjddG16gIdY1t9q4NsT/zBxwyCsdxv8uWach3N4Q2Gl0lCDzoUYnjkz2R++ygn4FoHypBWlR7+xiJBn9rcugBEIerjKEfGeZNLuhzeW6FIOr/JtSl/RkCO3CHnf/CJW6wHJm694mX/DPhfPw7JHbS6nf7zk1eI2mRmsR6HUuMj9Ekl9trtiWSWjNizVWmHBBrZA6rkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxukNvnmf6Aigm61oB2pGLhp+XtFN3PmcLUBepP7t6w=;
 b=L3uh7wszzKOD0/QEntIGU6FjPQC4zVpBkRGMk8nveltLVi+EoPHTfbHMAQTCcImiqvL4ILcxkYPrxkxu3ibQ6a3vIAOmXl9GB5zawe7VIHzb3kFXqVvElct7T/wnsmp0ysUVAg/trGUa/4Gb+qZXmvHeZd/oF1V7KxyWV4mO4iGIISYf6jxB0Ml9RfXW+USCYy8WchfzaJhHaX2wfCiI5hAkKfXGp477gr6NUSKd3KGEmwGQVekv0ePqJQjZzIm7jZzDpMDeYsCeQnp272eptk6I+aybbwwseq1dgzAwPIwyKFPckCZcSczGq7SWt5q0O/TMWvTpFnd7sTh+AiNYMQ==
Received: from DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 07:02:10 +0000
Received: from DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851]) by DM5PR12MB1850.namprd12.prod.outlook.com
 ([fe80::880d:1407:db31:5851%11]) with mapi id 15.20.4888.013; Mon, 17 Jan
 2022 07:02:10 +0000
From:   Akhil R <akhilrajeev@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
Subject: RE: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Topic: [PATCH v16 2/4] dmaengine: tegra: Add tegra gpcdma driver
Thread-Index: AQHYBjv6V3jR20SoJ0WlGaDgyuzZEaxib1oAgARSzJA=
Date:   Mon, 17 Jan 2022 07:02:09 +0000
Message-ID: <DM5PR12MB1850A5F5ABA9CD5D04C37086C0579@DM5PR12MB1850.namprd12.prod.outlook.com>
References: <1641830718-23650-1-git-send-email-akhilrajeev@nvidia.com>
 <1641830718-23650-3-git-send-email-akhilrajeev@nvidia.com>
 <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
In-Reply-To: <16c73e83-b990-7d8e-ddfd-7cbbe7e407ea@gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38ed48a2-9c2d-42a0-57dd-08d9d98747f2
x-ms-traffictypediagnostic: BYAPR12MB3384:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3384E783C527243D5D8253BAC0579@BYAPR12MB3384.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RjjJDKyhg7nUywxfVkCLYvDu+QBv0jIyy1s/M2LgE92+qXu2dtZLMM4XaRBOnoDf2xq2MK4G3jAR8fLSFzK4Xf1fboqULgmIWSn5Yo55ldPJ5TRmTWZcvwA3f2NJYWmXzt5WdB+C7ami0/Y7tB0YJtjNbbhY2VW1ScWk5BsVGuMqMm+fE2VSFymDJbeEovA5nGMuYvZr13GTIIdAT7wNO9IxuyRQ0hTFYBfYohGgRZoCvmbRaPINgNqS+ISpMT+n92jFXdJt/8JDnyJ28xv204UNfDEj1/bZ+IsG7tsx1eGZJgtAOHaJDyKlF13nf8zf/Sy3AF0Zz1Kmi/7BaGc6TfGlaPLe1WaLjcB1+dN1IcdVk8XNfVNt8vqu+kZWyjyoqsRZ4RUsK9QU1BnwC/aYi07X7UjitvtuDhIlh+TT2BOtZ6mWfN1Az2D6H0oxenWtpaq4VqPwsdLCcx6Em9g/jVSwj8tn6kPeIVlNCIjGFrzYqgr9jkfycuWMB6/T9Ajjr5am2Hd0bHOkh2hOLZJ1N/HUNfHN9IC7poHYcZI4sajbHs24/AoY9I9LtL6oxN54wsjp5dKDYyoCDpB8gk69sMUkfdIODWdtn6hzpVIjV3OU28revEEyOA2jVi45V47tGLOciYo1N2+YnHc8ebKhmo49QWlQ3zDvTYq8XfyC3LJfB+jK3QWldajjwqQsn8baxK+0JUqxWYk+0SKCKm/KjDoB490S7tdh1P1rZzYcoe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1850.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(66446008)(66476007)(66556008)(2906002)(64756008)(7696005)(26005)(4326008)(76116006)(8676002)(6506007)(4744005)(66946007)(9686003)(508600001)(33656002)(55236004)(71200400001)(7416002)(186003)(55016003)(122000001)(38070700005)(110136005)(38100700002)(316002)(107886003)(8936002)(5660300002)(921005)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGx3aFpCa0dYbjkyWUZ4TzlpaWlvdE1jc3ZPUlJhb2paMHJQMzZSSEVWaGNo?=
 =?utf-8?B?N0I4QVpaSDMzYXlEKzhsQUpzRHJVbEpSQUdXdGhOL2tIcXhOelJMd1JHT3NZ?=
 =?utf-8?B?R1k5b28yek40N3JScXFxVVYrS3BDeGFqUjNIa0ZjQ2sxU0hMYVMvVnQvK05V?=
 =?utf-8?B?Vy9xSnRidVlreGZPcHdGcDVyYVI3WDZtcy9xSERTTzJXZEhEODIxek40UDk2?=
 =?utf-8?B?eTJJSThCckpxUFM2T0VveTdNRVc5RjNFMmEyKzZwdVlYVE1tR2NDYldKaW5j?=
 =?utf-8?B?eE1GRUs0R2hrQXNHUnQySnd3UWluaUhmWWJVVmlNZGZoWmxJa2xHZ1Izb25k?=
 =?utf-8?B?S3RDTHp6ekR6VjlRdXZHSXA1d0U4dHJuK0ZPRzVGRkFEU25jMXFHbjhxVkc4?=
 =?utf-8?B?VVBxYXFSUlA1OTZTNHZ3KzJUcmIyZzBYbU15MjhvMXh6a2tqT2Jaa0JvS3Zm?=
 =?utf-8?B?cmI5RnQ4Ni9Qb0dHS0grVSs0QlZIV1M5ZE1HUDJiSEdzMGVaZFZkeFRiMEZn?=
 =?utf-8?B?aVlyazNmTi9iV3IyZTNoSXVHcy9sYW13cnR5Q2R2MXVuY1M4Ky9SK0NvVU02?=
 =?utf-8?B?M2FSMWZXQmZ3WWowWVJiaVFBTmNhZCtTNEdETVQ4b04yR2JCclNEN3BlK09l?=
 =?utf-8?B?OVMxaWhHWndHeHVHNFBpTHduVGFRN0F1VWo2NzBRV1RobEVyeHJyQUN2cyt1?=
 =?utf-8?B?RGkzcHBBSUY1L3hDNzR5TkhEZE53ejJaVGVlYk1uWGF0dWRIU1VNQjBlaEwy?=
 =?utf-8?B?Y3k4QnMxQXZWakhmTkVkS1ZZSnA0NjlhNURXRDVjbHpYNVRqTHVBUHd3UlRG?=
 =?utf-8?B?ZHk2MUNQeXFUZkhEOHNQNHd2U0RKdHhXTXlZaFdhaFpYQThlN1Uwb2hIdVJv?=
 =?utf-8?B?eDNpMDNGdXBEZGRFdXY3UmJSZHViS0NNY0VsKzN1eUJsOVdSWmtxbE5wNUF4?=
 =?utf-8?B?dnJ1OXNzc0lEOHVpTHhMMkYwZnBma2lKVUZGN1B5ODRLZ1dXK2ZGd3B0RTRP?=
 =?utf-8?B?RU9pa3hkUE9qZHI0eUdOdmVnaGRPSWlVbVkwNUZFQzRNK0h1K2hhUWNmeDY0?=
 =?utf-8?B?dTVFNmFiNzFYYlJRcGVBakYvdWJJOU5YUlFHb1BxK0JCZzdqL0tFbDJiN1dB?=
 =?utf-8?B?bWJDYVFaajd6U0lXK1NaOFd2UVI4bFN5TFhsbDNkWU1hQ0E2TTZSa2JHV3dU?=
 =?utf-8?B?TUhtQ2VpVHJOM1h6SWkwcjRIV2hzeDMrRGpRVDJ6RGdHaUJ4NTRvdnlVbkFs?=
 =?utf-8?B?MEJQWEF6Q0IxeXBXbWpyWUVFK0tFZFRFdnVqM1pQZDJQbkdYMkF3WFNpY3RE?=
 =?utf-8?B?RWJISzBNSE9wd3JPdFdaSGZoZlA2czY4QXlqS04vYlRXclE5TVMwWTNuZFVz?=
 =?utf-8?B?MHVQUlF4b3A0MDdCRkJsZVp1WlVFcmEwS2N2dExJcWJEaEZrZHF5ajdzZUpT?=
 =?utf-8?B?ZnVuNUh5UFBFM3ZsSWYrMXZpV0p4R1BPeGFHN0Y4NzhZY2tXanJCc0VRNER6?=
 =?utf-8?B?elVLOEwvOHBMTlY3c2pkMk5WWHNtSEw0Z0s2U3h0cHNQU1dWczA2VUs0OXU3?=
 =?utf-8?B?THYzY3ZEVnRyZVlqMmNmNlVtTG5OVzViODV3OGgvRUNMdUN1bGJwMVNMTjNX?=
 =?utf-8?B?NHpoamR6R1FDZTh0d3hSUGdJT3UrdC9pak11blVGSjBSUlMyRlpkVG1Mdllr?=
 =?utf-8?B?WTRNS3ZFZUNHTUw0WkpubUlWK0FZMHlnUWFEbGZjbjFmOUdrZ0gwVEh4U0Fr?=
 =?utf-8?B?VWtTRkdwVzBMMzF4ekxxMUUxeldHRkNQYlRoZHRpSnFhMlNiYWpSdXNlUUJs?=
 =?utf-8?B?bkZQVG9BYisxMFEyM1dYMFo2TGFnN0NkVURMcGVKSklHQkpQbjg1ajRRZzNC?=
 =?utf-8?B?MUJoRDRRbWZhQTZIV096YTdSRVRkN0RrNlNXcWE4bVhQR0xxaVJGRlVncm02?=
 =?utf-8?B?VnEvRithRnpDOGJRVDFreHJmSXJkOU5rQ2liWTFPU2ZqMVFCdGFTNEpSU0hw?=
 =?utf-8?B?dlJIUERtMlIvVzBVRFlJdnE2cXlFYjNISVlVNkRtMHpnZ2hlZkVyTEg4NkdH?=
 =?utf-8?B?TVF6SWlNSmFISE82NVFKMDg4empCTEU5dU91SjBpNW5tT0VxaTNsSGsyNVhN?=
 =?utf-8?B?djQ3czV4KzkyOWRORnlQOVVFeEdDVFhJWGhQNHloWk9SN1pqZmtldlJtbURl?=
 =?utf-8?Q?Dhrd1Qj4qsHL7PvWd9pLP28=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1850.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ed48a2-9c2d-42a0-57dd-08d9d98747f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 07:02:09.8794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6ZG0YNQutpMnPa9CLhFbAijnIEgwr8zy+dPe8ABkEGucE9qy7s1x2BEAhZHM7H/ebKrdK6OqId/XJXguYnefQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

PiAxMC4wMS4yMDIyIDE5OjA1LCBBa2hpbCBSINC/0LjRiNC10YI6DQo+ID4gK3N0YXRpYyBpbnQg
dGVncmFfZG1hX3Rlcm1pbmF0ZV9hbGwoc3RydWN0IGRtYV9jaGFuICpkYykNCj4gPiArew0KPiA+
ICsgICAgIHN0cnVjdCB0ZWdyYV9kbWFfY2hhbm5lbCAqdGRjID0gdG9fdGVncmFfZG1hX2NoYW4o
ZGMpOw0KPiA+ICsgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gKyAgICAgTElTVF9IRUFE
KGhlYWQpOw0KPiA+ICsgICAgIGludCBlcnI7DQo+ID4gKw0KPiA+ICsgICAgIGlmICh0ZGMtPmRt
YV9kZXNjKSB7DQo+IA0KPiBOZWVkcyBsb2NraW5nIHByb3RlY3Rpb24gYWdhaW5zdCByYWNpbmcg
d2l0aCB0aGUgaW50ZXJydXB0IGhhbmRsZXIuDQp0ZWdyYV9kbWFfc3RvcF9jbGllbnQoKSB3YWl0
cyBmb3IgdGhlIGluLWZsaWdodCB0cmFuc2ZlciANCnRvIGNvbXBsZXRlIGFuZCBwcmV2ZW50cyBh
bnkgYWRkaXRpb25hbCB0cmFuc2ZlciB0byBzdGFydC4gDQpXb3VsZG4ndCBpdCBtYW5hZ2UgdGhl
IHJhY2U/IERvIHlvdSBzZWUgYW55IHBvdGVudGlhbCBpc3N1ZSB0aGVyZT8NCg0KVGhhbmtzLA0K
QWtoaWwNCg0KLS0NCm52cHVibGljDQo=
