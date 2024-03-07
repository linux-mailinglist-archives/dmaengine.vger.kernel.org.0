Return-Path: <dmaengine+bounces-1280-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAEC8749B3
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 09:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F36E1F23FA0
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEADB82885;
	Thu,  7 Mar 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RGVHQmpt"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E88286D;
	Thu,  7 Mar 2024 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800499; cv=fail; b=gWbKr9CG8a+ipZMjMciS7yEMQPatn/V7A1dgkXPhKcXCQQ5C7FprAoLtgdaNDHSpKZi6mbxGSCojnXn2f3djHZJy+C3LkzEe/RWQyGlWw7aKItj8OqBiSBhyO+5wA9R9cFcjSktRS1Al1SNkweP5oc/LvmGCtSo4BrCSHh3RsHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800499; c=relaxed/simple;
	bh=gsSc7T26QFT86Y80S5LIvA/zMConjiNPpB48JB+Sfg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxJK44TXmyglhJ+7mZXbDlocUwD80nPRNl/sycHw92sT/LAGbS7Zpmo39tMm3RJ1hxDNckEZlc4/2WRML5Qc6g2Rgb+eKY79o6f7W/O3trOTK39tkOBX8XTNDfg0VvV+WuElAXGXsjfJUX8wsxo7p6inHOCaDMUoNXsBfnMOI5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RGVHQmpt; arc=fail smtp.client-ip=40.107.8.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9bzbaFhpAwT0EshqvCgh72PieA5OUPet7MHQzlWwmB7DNJBOzNFhIAnnkZAHg9uIgwo8hNX3Gf9lUN7vn34EzzKHdP/aSyFxCLhg8AuNDSwz8z2mYwxT4QRDk90fEmBTaTGqG+LbalN0pZ2dD/nrsnpSri67YQsmc0/jj/HgIAAAzr/toacnLkv11rW4fZAbRx65s/7Jbx2GqP7ZwYF62vavli6iZWf/c4BUfH521J/aQbtek2lArRfYyh1s2HQ+lWS5+myg/MxeVAkz4O1fHVtJHA/V4fJyzL278qqbujzSmYPdIptXZHJqevapISIf7sUxP/XP3jEpCU3V/TCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsSc7T26QFT86Y80S5LIvA/zMConjiNPpB48JB+Sfg8=;
 b=GPtg7uJABn4swEsryfKKcH/r4Y694VviBxSLznYbSdz5h15lyaVhEsQzCZbLpTxMl982tMCNrtP1a/VqVOQPepQTEtKsX9yFw1naHCrGn5z0/usxLI4rGzw9+ZtDZZaKLeEeVkm7k/6BPKJzEQwL/oFo1OHRRhW/pcRrwRahSCjiBoGO/3A4P320av7UQHhFFEO8Yi0Et3FQPySGUvqjhHQeZyjU7EQbnQy+I9iZNjn3NCm4O5rQxm1fzZ8NZ8lhBczRdAt0Mb5C9y/1v81vVGjs0CGDvmIOtGkE1nxAWTMVUSwEIUOfnnwISbNQlwtp8ekCEECDuUnBLwB8LBL7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsSc7T26QFT86Y80S5LIvA/zMConjiNPpB48JB+Sfg8=;
 b=RGVHQmptQFxOg4E6cSHUjl4EJ9o9RBJWiAdQnHdvmcOk17KUjMo8bV2E7x/TwWE9A449jliSeD6ye2EzOA1Nn0WpfNUeTMqPwxhv6gKyj5d6skILv+hYW+Wb6uZ1S9yJcyFFwd3ywl9rK5SkSlaK0i63d8wAg0aTCEUXGxuOtjY=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS4PR04MB9551.eurprd04.prod.outlook.com (2603:10a6:20b:4fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 08:34:53 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::8a76:10d0:859e:c8b2]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::8a76:10d0:859e:c8b2%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 08:34:53 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	Robin Gong <yibin.gong@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH 4/4] dmaengine: imx-sdma: Add i2c dma support
Thread-Topic: [PATCH 4/4] dmaengine: imx-sdma: Add i2c dma support
Thread-Index: AQHabe0jjKnsdyWNH0OB2wZbVzuQ/rEr+Ezw
Date: Thu, 7 Mar 2024 08:34:53 +0000
Message-ID:
 <AS4PR04MB938674B93282C8A15D940B2CE1202@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
 <20240303-sdma_upstream-v1-4-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-4-869cd0165b09@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AS4PR04MB9551:EE_
x-ms-office365-filtering-correlation-id: f035b8f2-4b96-42e2-4c13-08dc3e817639
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6aiZD7dP+cyEZbqSx2i9dWzzLq7Y3DrFtWVuc5H9sjaqvOdmt4+zZLPMqfbJTCCH7pYuKVaNPDzbtJvUN3nLBMV72nrM5SXxWE2Jjip434xIxMq7rw/2zrGyTQtjMAMaInD8RBDB+ngwH7UJ4GSk+eMN6HRDkNYQKxql5gNJECHqYavC2koC7f4RVZXmnb4RasQTbacuQcnNcbikt/mUOeACTIvMTSZ6UM08OqofvQgvZzKrrFdBa8yzO6wHE/s+pHmoUEfgU8/VEgBNzqnsU8MzNRDsymMQQ5oE0BqLa31c2qXhl/zvaNaQ1EOUd7CvB5t8PK052RdkKf6uqHLMKhbkt1K8eNJqwPbjRHnmie6LW8Y1yli4mw6rSlQj+HeKtYa++ggBRiguXtqHes2CwHOGNADtHHqdwqfL0wzlrVoPoIRQFmbZEIq4No80NxVq0siTtdO3/6YvuunOvMe8D64COUEOd/hksyLD/Rx75RnDeapCTYI68shloMgBtPFhEhtxJpd0Haua2v0ix2sazmOgduCV2LBoLuv/hPn4QWGFAiYJ2S5Niw6JirAcvvKZKwqFFUiDu9YKiZhQddPml5ait4kI1dsVf+cjvXk09qcEjlzKOLkn6Us8iiQiuw8Xh81+uJQF2byJgFqxaR0QnGOCU4oOO0JL4abYK00SGURI3InWeCLgvBXmQmurae4W8uNPrgkRMCqmb37zyS6FV3CV+hC5V3ziENxg3WkkV3g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDcyRVI1QWhreGRvTUI5emthUUx4MVMybjJCWFhDYlhsVDYvKzM5TXpJNzZr?=
 =?utf-8?B?R1B2TWZvVURReG84U0xRYm5lWjVjdnhNbzY4aVN3NmVFWWZkeXE2R296bVk3?=
 =?utf-8?B?YjBqd2kxbzhOa3V0V0N5Z0tTM1RvM0ZJUjNIdDR6REVoNDhKNExTdm5LV1lz?=
 =?utf-8?B?TkNFbjNuUTlwdlQ4UUNJWmVFVXFRUTFqWk8vN2VKSUErY0lWb2QzR0R5REoy?=
 =?utf-8?B?MXA3ZW05QjdXWHUrdCtrbStHY251bFhkcUdMclRpM2lYd2U2Q2V5ck9XSVVl?=
 =?utf-8?B?SjJma2pDMnl4RTFLV2xGVVRudEQvS1lXSDhSejZYcjRNNEdjcSsyM0dvYkZU?=
 =?utf-8?B?VlI0TFZBUGZFV0lGdzBKa2hHV3lXZGJtTWUyYUcwQ3JSbU5YVk1BZVMySFBG?=
 =?utf-8?B?SWRneDExRUxhOWJHYWh2RkY0SWh4SVNwRWtzdTZLMUVjMWNBa2VDc1RTWUIx?=
 =?utf-8?B?bGEwc1FZN2QvWFk5RGtzUDVhYUc3WmY5U0VnMkJtZVpHM2xsVmJaL0dRVWpS?=
 =?utf-8?B?SXQ5MVRYL3FNbmpqTDFNT3BLQStaSjFFcnduS0NJdUw3WWRVOXdGOTRwOEJI?=
 =?utf-8?B?eldZT3hKYkhkMHpRZ2xSN0VmQ1ZXUGVMSUpNeUtyRHlCMVlQNWhKdFVONnR6?=
 =?utf-8?B?dUJjU2tTODhzTTNHUTIvWjJETUZldzhwc3JuVVVSelVQcGdJTUppQlh4ZENt?=
 =?utf-8?B?QXF2QitOTFhMMWFSdS9hMnZraDVsK0lGWDMwa3FWMjN0dlVxL2RRaExhOHNk?=
 =?utf-8?B?bmtvaWMzQTF6ZVRINWNKWjBHRXVNbEx5bDVpZEJNZVh5Z2VPK2l4cDlNSVRs?=
 =?utf-8?B?d1dxSGtUNVJmaFFXcVlXeXBscG1uY0JCYlJxb3RjYlp5bDFPNzZuT3prR01E?=
 =?utf-8?B?WXR2elFjNS9KTlJaWXZuSFRhaHVEamVialN3Y3dIaDVTaFpwc0JrYlExT0tv?=
 =?utf-8?B?TW1aeVBUQmV0QllES3J3SlZKUG9mUGxJMGlqNzZPN3ZzTm5pWVlnRmlJR2Ur?=
 =?utf-8?B?Y1hicWdvQXNTTUlMRFMzb0d2S2Fwa3FUM0JYRFRBbVNBWVBvSUF5ZmdxbW44?=
 =?utf-8?B?d0Y3NHZ4eHZ1UGFUOW5zRkdoOXNjQzdtSllCOGtxRHZjU01RSFVvMzJLVHNP?=
 =?utf-8?B?dUVsdGtxQklzSXdnTGczNHZqTUpUZDhDVElXUzVVMFFQaDdjUU1iOWh0KzBB?=
 =?utf-8?B?Z2Q5aFArd3B3QXdOU2h5Y2U1WlZzOEVpb2wrNCswdjdkYnRLeWVaK0FVMUpM?=
 =?utf-8?B?T1A4Z0luemNHbUExYzVDNEQ1SmlNV3ZRTElEWDJWZm1IN3Q0MUxOeWYvTlFv?=
 =?utf-8?B?d095ekh6R3h6YjBpY3RVd0xncEcyU05DN1h1dThmR3l1N1RhUDZLanBpVE5t?=
 =?utf-8?B?N1M4V003N0lxWXNDMjV3VWhJY0M5R0hYYmpzamdzVGVxeU0xWXpSV09wNjdS?=
 =?utf-8?B?dVFlMzRhaXRseHRMVi8wUW96blZKVFQrVlkrRjlOZElKS01pbmlWTEJBRjh1?=
 =?utf-8?B?Rk9jUXNIQTk3c3NJTWd5dno2c3ZOdWN3cUFPMktUZzFLbk1Fb1pSVkVjYUp4?=
 =?utf-8?B?WGV5OVRGVmlWeUxMZVV4N3hHTzJFZlZ5bTE5bkN5LzhNMWx5KzhqYlNKa0dn?=
 =?utf-8?B?dTM5UDk0bVhvZFBpZWJkd0pTL2poRlpOY0pRNlNVZ0laQ2tpaGJod0ZXQnBT?=
 =?utf-8?B?bVRUTkZvR0tNZHBzaUIyRnJtaENqaW1BOU9COTBVdmhWVFdrV1A3c0ZaNjBX?=
 =?utf-8?B?UFRpdDY3YjlJZFh4d2NNbUxaRFl0U2FnSHBNanY2aUx4dUg4YVZJWnhER0ph?=
 =?utf-8?B?MWsyWlFIMjEva1p1bnBHMDZpWWJRZEozM1ZPbGhkWjg1cU56a0VoUUh2RFBi?=
 =?utf-8?B?V3FDL3ZrSEFHeFJETUtxWHBNaDEyWkxaakFTaDdVd3hqRjJwMFhWSHdrb0NJ?=
 =?utf-8?B?QWl4T2VXZ1FYSlNtekQ0Z2g5bElBNTBlTWM3NktZZXZjUFd5ckdoUytRRVN5?=
 =?utf-8?B?aFJob2hmYVg4YWUvUko3WnVCS3ZONDh0QmlLWHBQOFFJT3ZXN1ZqajdoU0Rz?=
 =?utf-8?B?Z3JHazRyRWVTc2JvV2JSR2V2MWF3d05aQmVPODBnbllhNXhsK0hhdjZJNDhJ?=
 =?utf-8?Q?vVEU=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f035b8f2-4b96-42e2-4c13-08dc3e817639
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 08:34:53.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8OWmH3q3ddXc9yskBpiewb8AdneiM5Q3QncnmmhX3zs/Jb6CcB4KY6/podsFjWY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9551

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRnJhbmsgTGkgPGZyYW5r
LmxpQG54cC5jb20+DQo+IFNlbnQ6IDIwMjTlubQz5pyINOaXpSAxMjozMw0KPiBUbzogVmlub2Qg
S291bCA8dmtvdWxAa2VybmVsLm9yZz47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47
DQo+IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtl
cm5lbCBUZWFtDQo+IDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+Ow0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBD
YzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbXhAbGlzdHMubGlu
dXguZGV2OyBGcmFuayBMaQ0KPiA8ZnJhbmsubGlAbnhwLmNvbT47IFJvYmluIEdvbmcgPHlpYmlu
LmdvbmdAbnhwLmNvbT47IENsYXJrIFdhbmcNCj4gPHhpYW9uaW5nLndhbmdAbnhwLmNvbT4NCj4g
U3ViamVjdDogW1BBVENIIDQvNF0gZG1hZW5naW5lOiBpbXgtc2RtYTogQWRkIGkyYyBkbWEgc3Vw
cG9ydA0KPiANCj4gRnJvbTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiANCj4g
TmV3IHNkbWEgc2NyaXB0IHN1cHBvcnQgaTJjLiBTbyBhZGQgSTJDIGRtYSBzdXBwb3J0Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiBBY2tl
ZC1ieTogQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEpveSBab3UgPGpv
eS56b3VAbnhwLmNvbT4NCkJSDQpKb3kgWm91DQo+IC0tLQ0KPiAgZHJpdmVycy9kbWEvaW14LXNk
bWEuYyAgICAgIHwgNyArKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmggfCAx
ICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9kbWEvaW14LXNkbWEuYyBiL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgaW5kZXgN
Cj4gOWIxMzM5OTBhZmEzOS4uODMyYmU3ZWNjYjMzNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9k
bWEvaW14LXNkbWEuYw0KPiArKysgYi9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+IEBAIC0yNDcs
NiArMjQ3LDggQEAgc3RydWN0IHNkbWFfc2NyaXB0X3N0YXJ0X2FkZHJzIHsNCj4gIAlzMzIgc2Fp
XzJfbWN1X2FkZHI7DQo+ICAJczMyIHVhcnRfMl9tY3Vfcm9tX2FkZHI7DQo+ICAJczMyIHVhcnRz
aF8yX21jdV9yb21fYWRkcjsNCj4gKwlzMzIgaTJjXzJfbWN1X2FkZHI7DQo+ICsJczMyIG1jdV8y
X2kyY19hZGRyOw0KPiAgCS8qIEVuZCBvZiB2MyBhcnJheSAqLw0KPiAgCXMzMiBtY3VfMl96cXNw
aV9hZGRyOw0KPiAgCS8qIEVuZCBvZiB2NCBhcnJheSAqLw0KPiBAQCAtMTA3OCw2ICsxMDgwLDEx
IEBAIHN0YXRpYyBpbnQgc2RtYV9nZXRfcGMoc3RydWN0IHNkbWFfY2hhbm5lbA0KPiAqc2RtYWMs
DQo+ICAJCXBlcl8yX2VtaSA9IHNkbWEtPnNjcmlwdF9hZGRycy0+c2FpXzJfbWN1X2FkZHI7DQo+
ICAJCWVtaV8yX3BlciA9IHNkbWEtPnNjcmlwdF9hZGRycy0+bWN1XzJfc2FpX2FkZHI7DQo+ICAJ
CWJyZWFrOw0KPiArCWNhc2UgSU1YX0RNQVRZUEVfSTJDOg0KPiArCQlwZXJfMl9lbWkgPSBzZG1h
LT5zY3JpcHRfYWRkcnMtPmkyY18yX21jdV9hZGRyOw0KPiArCQllbWlfMl9wZXIgPSBzZG1hLT5z
Y3JpcHRfYWRkcnMtPm1jdV8yX2kyY19hZGRyOw0KPiArCQlzZG1hYy0+aXNfcmFtX3NjcmlwdCA9
IHRydWU7DQo+ICsJCWJyZWFrOw0KPiAgCWNhc2UgSU1YX0RNQVRZUEVfSERNSToNCj4gIAkJZW1p
XzJfcGVyID0gc2RtYS0+c2NyaXB0X2FkZHJzLT5oZG1pX2RtYV9hZGRyOw0KPiAgCQlzZG1hYy0+
aXNfcmFtX3NjcmlwdCA9IHRydWU7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RtYS9p
bXgtZG1hLmggYi9pbmNsdWRlL2xpbnV4L2RtYS9pbXgtZG1hLmgNCj4gaW5kZXggY2ZlYzVmOTQ2
ZTIzNy4uNzZhOGRlOWFlMTUxNyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9kbWEvaW14
LWRtYS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvZG1hL2lteC1kbWEuaA0KPiBAQCAtNDEsNiAr
NDEsNyBAQCBlbnVtIHNkbWFfcGVyaXBoZXJhbF90eXBlIHsNCj4gIAlJTVhfRE1BVFlQRV9TQUks
CS8qIFNBSSAqLw0KPiAgCUlNWF9ETUFUWVBFX01VTFRJX1NBSSwJLyogTVVMVEkgRklGT3MgRm9y
IEF1ZGlvICovDQo+ICAJSU1YX0RNQVRZUEVfSERNSSwgICAgICAgLyogSERNSSBBdWRpbyAqLw0K
PiArCUlNWF9ETUFUWVBFX0kyQywJLyogSTJDICovDQo+ICB9Ow0KPiANCj4gIGVudW0gaW14X2Rt
YV9wcmlvIHsNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

