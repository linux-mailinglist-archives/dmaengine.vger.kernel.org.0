Return-Path: <dmaengine+bounces-1881-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B78A90C1
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 03:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9861F22A6B
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 01:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA359848E;
	Thu, 18 Apr 2024 01:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aG3Bk9O/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2057.outbound.protection.outlook.com [40.107.247.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D308F66;
	Thu, 18 Apr 2024 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404301; cv=fail; b=VLVoo18J3O+Y+0gBdlIVrWNnwlcbPicYEdogMwYxqkeZ96LUTQ1EaEeGQY5ywE/exXQP3mcjRd9Nyu/o8U7qtxDzmciNTwS+sTeQRjUh1ssEpTW5+21K6qqAbRZjupsWXj5eHDNGvu0HMqrAwZV3c53hnDRmyy5vRot2CiPuzNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404301; c=relaxed/simple;
	bh=U3clRqT3whR/qxzPGizfMJ8D7vnngrK3Q0XanYfd0uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nuDRF52i7lNRA1r5tBZv8VqcjJHOO8V4ULLRby6lunb9aRjYXeUhA7xJAPVCYezMmWP1DQzABAMtMmfSZ7a7gOrK04887DuXbv1L/n7k8wcgEU4H1IDMWhx5VP49/Sm8OMC2kKCisxCZMfO2kLJ99msZoUsuzTe5q+OPd0SIsQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aG3Bk9O/; arc=fail smtp.client-ip=40.107.247.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luvg6JlpRWXnrgKJ/b61/J8YFpwNhAVD1wpAQpJfraGSjGDmvjg6nWzM3RerWWV4T9mMmc662hC+lVC3Kp7SQEgftbFD13Lg4MZ0TDQSHcrU500ocBiAQvCOAuEwek3TmNh8BtWjzXsiXQk2YflPfNUwK4jPW6S96nilkglG1E/0jKxRDGX3E7E3tjWPRggY4SepM5OUs5n97NqnL3kWdfodv0nsKN6RzwZZtqivMNB3cXXVcBDNLrvM6WKLEAhM1EEczx5Th4JhIC06f4MoKcvCdl8TtBOXanqJk6cc/9DV2JwycRF4E3JDkSLZfVPUTnGZBkXwwFZdqua7Le+Nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3clRqT3whR/qxzPGizfMJ8D7vnngrK3Q0XanYfd0uw=;
 b=hjjHp3vCsxGXaqcxi43JHw4EvABfW+ETthDJAnpS12zNOnvlPaQ+bUrDNaK/2bsvof/82Psu+TEJtIEaZGehkPYDemdSonCl6sC7l70zYA0kMMqWw/JZkPQC31t/FkLmR9FBYTmFrh1MgdCROyxoK6qGDhTC2vk27l4JK1TQD0d/WblRtJ6gVQ6EToDnNIQceqZAO+t5NRsvds/7MrzAPHqjqtl8yMfOH710PBuyms2gIzpkdsy51biPaKtAml0m9RraAPzNX606Xu9VXmPXvSGV8+xF/xo1DQZ1Nju5c4wr1X+6q2JLFGoPz7PdryioNb6rzlSFCV/04YAFUsUfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3clRqT3whR/qxzPGizfMJ8D7vnngrK3Q0XanYfd0uw=;
 b=aG3Bk9O/fdkfsTAWBMuHATbNMfJ7rqXnaX2nHFQ/KuorFozRIKK1VtCBNzH43dNeAOTkjlchf74qAtryA4o0EgYhZkTGqqChrY8RwtB2atza59xTlft2DKaaSt4wGLG6Qvv+pUTFIe4NAl3uX2fsg3zg5IDhg4psr+2gMqAjn18=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PA1PR04MB10206.eurprd04.prod.outlook.com (2603:10a6:102:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Thu, 18 Apr
 2024 01:38:17 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 01:38:16 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Peng Fan <peng.fan@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] dmaengine: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Thread-Topic: [PATCH v4 1/2] dmaengine: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Thread-Index: AQHakHX7qL6WjEkEC02a4aiKijw3trFsiVQAgAC3VhA=
Date: Thu, 18 Apr 2024 01:38:16 +0000
Message-ID:
 <AS4PR04MB93862A14E6FAD42A2B5F6301E10E2@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240417032642.3178669-1-joy.zou@nxp.com>
 <20240417032642.3178669-2-joy.zou@nxp.com>
 <Zh/fQFdxHHxC5iXF@lizhi-Precision-Tower-5810>
In-Reply-To: <Zh/fQFdxHHxC5iXF@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|PA1PR04MB10206:EE_
x-ms-office365-filtering-correlation-id: ffed6040-6da6-47e1-bbfc-08dc5f48387a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nEIy5lTPmtyq8j0FFDuFhuCureZ46SEO3NPEsAoYgkujRfGu7hKdHg1uP/GTwVGcP7gg6RdQqDWF4k6UOxlJ4KxnbPUq+HmMFiqnCXf1uNhTq8YCKDkHMnV57b+XDKij/hjOT/HZWCXWqyzKFPDOlxbiMpHht8Di2Z0+Mh9fgS2qpe31ryAHV6AQC+ZnP+ijCTsgNme0o7a8rnquuaQCkj3nrD25ZVziKKTNjl1K5ikuW5zeQPUeB/lSEdJJ0tVJ7vllJilG2gZuOuLNbb5cIskNmjipsCVzPzkUnHzaOu52rILlEd+CbPKZ7oQNF9KUb7rhFDH+UAgrl2egT4zVpUHDaz5kipPigfw4NQYqZdyyPYV6DoiFg4SpCK+eZtRKqUxI/HcISXwyIRu8lvNlBSzeHWBykYrPoUYI8MYF+BZxs9IKcYbvS8mxrpH5iYMZxjX6QccwTsyRvbPVQu1g4aRBaj3bgiHqyTFNcJq0f3ZekK44idwoHUbr5M/+ia2QeCA7pVvhM4k534YcTmqQtYSIwjIgD0s+DFZ6TE+Kse07sEGqk9+EiEck+KV3Frw2Nd9SHaDBfsscdJpjYVhFmnM5X+E3u7ry8lIdTtXwg8FpG0wSVfJDuB4nrsmTcs66AI1+6b6deqHorgYIhV/4cT4cPMTs8bvDZDSFmH8Fn1gzNLweLiwJHHIeRqK8Z9nUlWCZZ9gyywICsfVrdADtargmrXQLo2Gen+ithWSjqTM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZUxKYUtDbVR1Vk11SDBYSTZDWW5qMTUxNnBpazdxZVZySkwvZXFwdml1c2Jo?=
 =?gb2312?B?U1pFRFVORjQ2bDhzeFlqSmJ2WWdYeENUbGFRWFhITCtPRTFaQmx2UVl0eWRm?=
 =?gb2312?B?ZllwZ1VmWFk1YjNrK1hJUTBUMzdTYVhMQ0NMZFlHbVQ4RVRvWUFWa241eFpq?=
 =?gb2312?B?TTBheWZGUldRZGpEWGl3bzlNckhHNElYZW0xMzhDRVUveEk5aWNPdFYxOWJO?=
 =?gb2312?B?WFo4enRoSTcwdjg2L040c1lCR3FTVitPOFpjenpYZDc2SERTWTljTmtKY1px?=
 =?gb2312?B?eDVBbFpIL3dYRHVYVUhqb0x3K2lOSHdnVERyR1QzQy9IdCtiaEFobC8zMDhF?=
 =?gb2312?B?Vmh0b0V5RWRZYnlrN2xhcXVVVTh6MytscjN0Nnk0YzFNVDlUSTRwLzBUSm8v?=
 =?gb2312?B?Y21OWGttdGUxTzNWY0ZTK0FGTmNzaC95QzFvaTRFWTBGTEJ5bjVOZVhqOUpR?=
 =?gb2312?B?bnA3YlFYQWJaTHZsQ2UzZSt6aEIvcjRSSEV4VkZKUlJJakVaRHNDazhMRStJ?=
 =?gb2312?B?cGR6QkNYbTFyT2RTTDBQSnF5SzVTS01IdVIvMUp3dlRBMUJJdU5UZUswTmJi?=
 =?gb2312?B?d0k4VDNWNDFpdXVRbk5jRGJuV1VVUzJNWm93aGNNSldaTkgvbG83TnZUM3JY?=
 =?gb2312?B?RHZnWCtGMUpMQW85YktxaWg1QklkZmN3U0gyaVJBalN4Q0pCd1FyTENxSHRj?=
 =?gb2312?B?N1k2NkVxbWFHckVoOGpVN3FJeTR3bGlFNXZpN1RKNGdUOVAyRSs5VnVVT000?=
 =?gb2312?B?eXIzckJuVGc5QzBiOC9URnQwZlp0M1ord0plZ09tREE0NWFnQnUzZ3o0SnJJ?=
 =?gb2312?B?bUtOVWFJeFZ4d0dZSXMvWlN1UUw5eXNzU0tnc2JJNjVCa2J6b1hvc0NJQzJl?=
 =?gb2312?B?Nk92ZXFPd0pKSkFjcnVxTkwrVkd4WmE0TEFDYXNSakY1UzVXQUpYVGl5VW5q?=
 =?gb2312?B?SkxBNEs5RzlDVHdLU2FWdXAwZTdEUDQrUGpSSTZMbDllZ1RLVHczRXJORDdq?=
 =?gb2312?B?azZaSEVKRlE3a3R1c0Z1TlFTNGYrdyt6Tmh6VGF0MitVZ0ZrSStYQmE0bXlm?=
 =?gb2312?B?eFNJS3J4MHo1OTlCUkNUcmttVkdkWU9xVUIzUkI2Nnp0dVRFTWtMczhpSTM1?=
 =?gb2312?B?UEdyenBqNHFXK2JaNDlJcDBRUWxWcWJiOGtFQ0tGa3pNSmpkTmlKcWhqNWVU?=
 =?gb2312?B?dEFtenozVGkwbk9iaDRDVm9oK1l3RHdvdGwvc2xSWnU5ZXVwZzdkZWlmYnhn?=
 =?gb2312?B?ZlVGTStmUXVUTTNaVUJkSWU5Q3BtWW50WS9QYU9mZGJycU9mWlVDbkgyeUU4?=
 =?gb2312?B?cWE5WC92NXpIZE9paWhrdW1KS2pZRDlkWjV3Nm4yaGFuRUYySTFZS01iVDE5?=
 =?gb2312?B?UEliQVZqWmNIK2FCTDFoNEtlVy9OWGUxbnZJM2RZbE11a1ZoWW1PVFJMUG1G?=
 =?gb2312?B?N0czSk1LU1FvbXFFNGdZdUNrbDdaVHRxZm9OcnZVK0FidmV2UkM0VXNXQmNw?=
 =?gb2312?B?Q2JTRmRGVTdLK0krdGFpUEtzc0ZxV3ZrZUJLQ0U1R3l1UldnTWRZYmlHOVNE?=
 =?gb2312?B?Ky9ITWNZdWRoODJ2a3RqUjNDZW9TR0NhMk55SFVqRWNVNmFaTXJpWXVYVlN2?=
 =?gb2312?B?dTBCakMramt1REF3N2tac1gxbG42dW0vTnAzNDQzYnFUZXNPMkw2aHlJTnJF?=
 =?gb2312?B?TXlya3RzLzJzTzlpbEVsMXB4WDRrUGlWeFBjdzBDOFlmSG05Y0M3bStUQVlF?=
 =?gb2312?B?dWhhNnlqdXRZcVBqZUcwZDhucWx1ZGVlS3ZBWHZqdjlDZ2djQm9iY0d4US8x?=
 =?gb2312?B?S214NTlwR2dHUHFpYzBhWk9WWEVEb0tJRmdvMXNtbTF1djZ1M0RSdHZnMlJQ?=
 =?gb2312?B?RjgxZzV3NzNZalpPRE12eENDZ09kY2NsdEx1dXNBU3JQTHNNaFAzNk16enRS?=
 =?gb2312?B?blZjTjJRNEtVS0hZek41eWdsZUJFWFlpRmRkYUlFcUNJbjJKVkthNjRUZmNj?=
 =?gb2312?B?Q0h0aEdwNUtJUCtzcU5TRWNuMUR4MnBVWkg0SEJEVmpoUElKaGpySXFCOXZP?=
 =?gb2312?B?RFM2b1BydllxT29HL0Y1MTlLUUhuOGFORE51cEM3T25wZ3FrR2hHTi9mM0JY?=
 =?gb2312?Q?vvg4=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffed6040-6da6-47e1-bbfc-08dc5f48387a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 01:38:16.9269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtaudVQNSAX5ZwxzxN3GbMKzgEid5aG8X9aGtYFeJrrHd2IokFesRApKZ3IgdBSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10206

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo01MIxN8jVIDIyOjQwDQo+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IHZrb3Vs
QGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBkbWFlbmdpbmVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvMl0gZG1hZW5naW5lOiBm
c2wtZWRtYTogY2xlYW4gdXAgdW51c2VkDQo+ICJmc2wsaW14OHFtLWFkbWEiIGNvbXBhdGlibGUg
c3RyaW5nDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLWNvbW1vbi5jDQo+
ID4gYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYyBpbmRleCBmOTE0NGIwMTU0MzkuLmVk
OTNlMDEyODJkNQ0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLWNv
bW1vbi5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvZnNsLWVkbWEtY29tbW9uLmMNCj4gPiBAQCAt
NzUsMTggKzc1LDEwIEBAIHN0YXRpYyB2b2lkIGZzbF9lZG1hM19lbmFibGVfcmVxdWVzdChzdHJ1
Y3QNCj4gPiBmc2xfZWRtYV9jaGFuICpmc2xfY2hhbikNCj4gPg0KPiA+ICAJZmxhZ3MgPSBmc2xf
ZWRtYV9kcnZmbGFncyhmc2xfY2hhbik7DQo+ID4gIAl2YWwgPSBlZG1hX3JlYWRsX2NocmVnKGZz
bF9jaGFuLCBjaF9zYnIpOw0KPiA+IC0JLyogUmVtb3RlL2xvY2FsIHN3YXBwZWQgd3JvbmdseSBv
biBpTVg4IFFNIEF1ZGlvIGVkbWEgKi8NCj4gPiAtCWlmIChmbGFncyAmIEZTTF9FRE1BX0RSVl9R
VUlSS19TV0FQUEVEKSB7DQo+IA0KPiBZb3UgZm9yZ2V0IHJlbW92ZSBGU0xfRURNQV9EUlZfUVVJ
UktfU1dBUFBFRCBpbiBmc2wtZWRtYS1jb21tb24uaA0KVGhhbmtzIHlvdXIgY29tbWVudHMhDQpZ
ZWFoLCB3aWxsIHJlbW92ZSBpdCBpbiBuZXh0IHZlcnNpb24uDQpCUg0KSm95IFpvdQ0KPiANCj4g
RnJhbmsNCj4gDQoNCg==

