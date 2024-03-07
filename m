Return-Path: <dmaengine+bounces-1281-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24866874A4E
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 10:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906AF1F2319C
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556DE82D67;
	Thu,  7 Mar 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PtMowo7j"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56956F50D;
	Thu,  7 Mar 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802331; cv=fail; b=LYfEiTsjRPL/eJE2aKIDgl9grdjoJW/o+bcL/UUmI7UdL2y9L7H6G/lMI0/XuRVzixBaXbF2yytUtTO3MJjuwiwP9/HZGyyJ4kXbudpAJPUUE2M/lod5a6id0W6AQfu5dD+doY0f/IvOoDWt8M4MjvHQReBIbK47nhb/0uDVfrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802331; c=relaxed/simple;
	bh=jA73U8WBqQAy9QAAcMsx9gtPk2ENcOIx5QF8puvFECo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lEbRvc8fvmRJ6llAATgw1WbCABaOyLkG+eSdbRLxxMDJCxQ0Nneqr8LIlUbVUR5UTDiz9hMqFBvaKv6n+4hSW7BrqNKvtHTT809NemxwVowloDICCiXlvQjyac+IPPIDduH8sJjVR5WOOJMwL5/phizEQTRd+P1vXrDPbT8KOCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PtMowo7j; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2sn44J3FUbQA0P89vWH+MxA4aH6l/57DyP0gW/BKPZKdzMCI3+LzB1ZcYqi4jOyTYS0r7EualWJwqMVf1GGyRTJEqzFIjhqaWDJsShTtZS2aaANEG5Jc8svMWhi46oK18NWwO1pkHNfNscH/4Y9Ok64rcy287AoBHxGu9mVyhs06fQxYy0RwYsco37qHr+xJQJyCJ1qLR9pOVKp13EovHuSO+n4XeZOUKGdyQR4KXIT2QcRrnk9iO0m9AeJp/CJAZEn++lByQJflpF5TKcbIBescPswvm19SNdBhfW4hiIqv5M2xJMxMjlVXkwAdBz7JpTeSDNliAoKUOMnMgOT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA73U8WBqQAy9QAAcMsx9gtPk2ENcOIx5QF8puvFECo=;
 b=iEVy51+t3KrcyMSxJ+MZr1QM2lXThInaiFybtTx2uZBvLNYy9ycWB8dFwzw4L/OL51enlTFmI9hSzDno8xhiYK8OqVEKbHlFs6FN7swhe7Ed1bw7DAmHl4eHSpW+xMoppsGT+/LzOwdMuXTJgAY/M+PNVw1ocg0mWxUj4DjPt5nCIPfKLnNINhmSkLb3sDHtwZncn3Y8MMbwOUJDdSIi0UjQTaCJayDdLZEMqgdom4GEqPv888UG/iPshlnuYM1mCJtoZlOGu76HoRy5uTnpjGrfqxgbihTKHpJ6HgUi583eTrydVmiqWe9mlZolLBdBLBuCNv7PlFd4lfngz9t1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA73U8WBqQAy9QAAcMsx9gtPk2ENcOIx5QF8puvFECo=;
 b=PtMowo7jmB+zeK60wX1ol4byIGZ0NkEAx9z73fj4o8YYmYjia82/sf3feIlIALExpMktyDyr9Yx7DFQnO3yxjlxESdXaGtfWigmY5a+osr8o0CU8Vo3sL9lYbnmuB7hhQX4k05lWWpiWvh5Cl6Y+mzce6X/LxuxBp4eBZwqdl2s=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM0PR04MB7188.eurprd04.prod.outlook.com (2603:10a6:208:192::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 09:05:25 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::8a76:10d0:859e:c8b2]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::8a76:10d0:859e:c8b2%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 09:05:25 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"S.J. Wang" <shengjiu.wang@nxp.com>, Vipul Kumar <vipul_kumar@mentor.com>,
	Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>, Robin Gong
	<yibin.gong@nxp.com>
Subject: RE: [PATCH 2/4] dmaengine: imx-sdma: Support 24bit/3bytes for sg mode
Thread-Topic: [PATCH 2/4] dmaengine: imx-sdma: Support 24bit/3bytes for sg
 mode
Thread-Index: AQHabe0gJsHBuBgsrkafqlknxMrlVrEsAPFA
Date: Thu, 7 Mar 2024 09:05:25 +0000
Message-ID:
 <AS4PR04MB938698DAB8515A56CA6887B6E1202@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
 <20240303-sdma_upstream-v1-2-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-2-869cd0165b09@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AM0PR04MB7188:EE_
x-ms-office365-filtering-correlation-id: 50a3a729-02c1-43b0-5691-08dc3e85ba01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 43qJteT6iZ7n5hzqptCnRCzUcBSypM/nbqRAyjXUjdBeNJ7qlIS6ngTx1ggq+WgfSIOhFTlwVsSJI+DRsjSoHXaB7wk2+a2HD+ORFLKgrRYwbG1KuIVn6JJGaIfYhxrzXkDNRGwm+j84XfXK+8kO324xbRzf3BHZa+pA3C485fPhcy68LRpzZ0n87IA7Gp+kJ7DIqnSh+JIDkX5ejTFQ0OdfJNvv2oXahhWrA1mRgDHLlTtUlkHqKbTfs41rmE3vqUd+MENDkSZOGjQ8O57ICD+idNbMP9fFZiZRx5Ckr+3ntTxkRU60O6mDvptp7QRJTLx7iM//JkIW5DLqZzFd2pCd6iA3QbGgxH6Pn1rUfer9o2nC4X1QT9K2emACcnmNweD7BASvlYc7tGeF+21/SFBNnL/0robz41Xb7gbt06sbkKKddnvYTEewKJRkHTKQMzCxMSfyHa4YXMmWXlg66W6tPtuQXGUUMyksHY0vUOH3opem0YngyOxqgzEjIhz+heNSgbgFAQG0HminWAKmPTzpIXr3cP0sROm1SdpGm7MoKcq9zxkckQ0M/sjht48VnseJR376lE4yXH+IHoRtkz8eQ7YMs7UPT5NMWPA/4KfdAO7MOjtZ1XP9eV3zBbmX2muXroeIhxxiT+ElNCYR55SL/Q5OVkXgwAtuUWSKw/XLiX6pRmJHk1ay34nglPcb0bKDAUKvJfEDI58KiO9IxisxgLTheC1+1kjMX4Ksvgo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEw0ZnRjbHhBd0hCakhlRUNFclFXNWR5ZG14MjlEakc1SWtRQ2trTDdpVDRz?=
 =?utf-8?B?ZnpuRllYcWlaMERFUlBibW9OUWlCYmo0Y0dHVUhlb2duN05peE53aExHYkRw?=
 =?utf-8?B?eWEvVzN3MUFhOXcyT2dVWjZTR1VxdVhYSmV2K2F4NHlKb085bW9TZkZPS3dT?=
 =?utf-8?B?elJGeUJ2ejd5ejBGVmladGhUWFhIS05tTE5aOVFFUGg4d3YzMFRVRnYyRTNi?=
 =?utf-8?B?ZTFkSEtQQTVBeWtoZDRmNGRMMmJ6cGNMRDNSVVVBTCs1SFhza01LZnc0RFQ4?=
 =?utf-8?B?akgrcTVvNE55Vk9UQXliRUMraXM4R2FFbHdWbUUxVnRFOU1NQWdLSUNrVmpr?=
 =?utf-8?B?OVoyek1lNlFtUVFmU2VQMXdoZ2ZXaGFhSHlUR29waDJvR3VBSk5UanBvTHdJ?=
 =?utf-8?B?bHZzUkMrMURPa2UxajNTVmxmWXNqTldDUG9DdXBYUG5xdUs3MGJNalQrZjhP?=
 =?utf-8?B?cVlLLzhLRUxHa2xWL1BMaDY3K0R5UTRSL014NnJURk1vNFdsTGFHTWZRNDc2?=
 =?utf-8?B?MFVwWG9pckJnN25RNFFQUUVvRmZSUG9ycDcyWS93QzRFengrS0RJOGRrK2Fi?=
 =?utf-8?B?NThzM1R2N0pMdTJuMmRJdldsVStEWXFQUnhtdTA2VVQ5K0hQZk9FSUV1bVFY?=
 =?utf-8?B?dXpYK2hveGV2YlpBQ1ZsWm85RDFjNU5jK0xzSCtaSnZNUnFIMTZHWlp3WW5Y?=
 =?utf-8?B?NTgwaDB2c2xVK1RiZnpweFBON3dsVkRmWGI2MStDWkkvOFpXVlI0UER0aXFr?=
 =?utf-8?B?WmpWbUo1NUhSblFwNjNSUXFOa1YwUmJKL3NUc1pKa1piVmR2cmtXdEpsT1dK?=
 =?utf-8?B?T09IOXkyRHNtUTBUTCtrSlBDdjF1a2FCZVpsTmlaV3hWSjdkVXVrdnZGZUpG?=
 =?utf-8?B?ZXVTb3d2WlpJdmhIeks4RTMwZ0FwWnh3WHRXZFlaeXlrTnVVSlFCRmVNWkFD?=
 =?utf-8?B?blRWWGZaWnVSYTd5dHV1TUhQVndUbzJlVDhQWDNGZXpwRzVka3ZVc0tXT2xj?=
 =?utf-8?B?RDR1SUtNN2pyOVRObDNwMmZEL0pWOWU1MS83VExpYXJjaisvVnhHemQ3VHhS?=
 =?utf-8?B?N1FBUHVQRW56cjBWblZzMFRlUEZZN1lKeXZXcEZDeFlkLzcveG8yUGsrVUF2?=
 =?utf-8?B?UndKc1JhNkVGL1E2VkFhVmtEQ3VYMDYza241THUyekhzOGJhNHMvRUFKemNE?=
 =?utf-8?B?TVl4eGZsTHpLMDcvdWI1VE0zUThBbG1ZTTlDeWx1Ukk5OXJzcnJqbUdyRERi?=
 =?utf-8?B?Y0lJZFpHWEd6RzlhR0xjNjBBdUlHRHN1Qk1HK0Zvc25aSHM3OXo5SHU4SlRo?=
 =?utf-8?B?WmFvMVlyVDN1Qk8vcld2OEM3L3lGTjJvWVJweUs4bkVaK3dOdUhERW9sTXk5?=
 =?utf-8?B?MmZxVHZxZTRnbVdsOVZoaEdFR3BnL0NKQVBweEVlMzltdVNFV09XajhDSWVz?=
 =?utf-8?B?eitlZWJiQnExUVhEYTVobDFIODZWbHQ2d2tIbW1TelNHZElmV2d2VXpRTG9j?=
 =?utf-8?B?eExHQUlOSGtpeUg5NCtxSitXREdFWVdXamphRTRSUU5YOTZuWlMwZk5NYmNM?=
 =?utf-8?B?TmJnRUNId1JaZWplU01MY1M5ekk4WE50MlNRTzQ2elJJaTlaVnBjRGJNelEw?=
 =?utf-8?B?Z0tyWTJDS01qWDdBSTh1ZHNzZ3BKSi9Bb3RsTU5tUzBuZFFyMjhYQk9Bb093?=
 =?utf-8?B?WmYzcDEvOXc5cVpYRzgzRFk1YzBrU0lXcm9HODVPUGNsYjNMT3RoeFl4RUVJ?=
 =?utf-8?B?Nmx6cTUzd0RSNUZidHh1NWhaOHJjM21hMzhqVGVseW0wM0oxZ0xJWVNodk9m?=
 =?utf-8?B?NHpndWQwU3crQWRqampaZkNBNk0vUndWbXlKVnhudStoNXY3bzhJVjNJLzhH?=
 =?utf-8?B?R0E0QmhoNy9vejc5cjdIVzE3bE5UZFgrUWozaEJBcmJrOGxyeG9SZ1BoT1dy?=
 =?utf-8?B?NVBkdEUzYTNQK0E0US9waWRvSndLS1c1QmpYN2JRVHZ4OHdUd0ltdVhYTk9W?=
 =?utf-8?B?dXB0aTM1RWVmZlRLSXphU2cvaTM3STFNR3BneWludGcxekVTVjgxeE9VckFk?=
 =?utf-8?B?cTQrSEtWN0daSzhkcitDa3FkektWVGE5dHJjMnNFYUlHdlBqNUFDa0w3WC80?=
 =?utf-8?Q?1OLE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a3a729-02c1-43b0-5691-08dc3e85ba01
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 09:05:25.1899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCNa4FuYIu2QXjCdxtZR/MdstXwjgcV4Xna5ZZ6BSPJGbbxgKDvLJifb5gKjaXt4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7188

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI05bm0M+aciDTml6UgMTI6MzMNCj4gVG86IFZpbm9kIEtv
dWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Ow0K
PiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJu
ZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2
YW1AZ21haWwuY29tPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gQ2M6
IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4
LmRldjsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+OyBTLkouIFdhbmcgPHNoZW5naml1
LndhbmdAbnhwLmNvbT47IFZpcHVsIEt1bWFyDQo+IDx2aXB1bF9rdW1hckBtZW50b3IuY29tPjsg
U3Jpa2FudGggS3Jpc2huYWthcg0KPiA8U3Jpa2FudGhfS3Jpc2huYWthckBtZW50b3IuY29tPjsg
Um9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi80XSBk
bWFlbmdpbmU6IGlteC1zZG1hOiBTdXBwb3J0IDI0Yml0LzNieXRlcyBmb3Igc2cNCj4gbW9kZQ0K
PiANCj4gRnJvbTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KPiANCj4g
VXBkYXRlIDNieXRlcyBidXN3aWR0aCB0aGF0IGlzIHN1cHBvcnRlZCBieSBzZG1hLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBWaXB1bCBLdW1hciA8dmlwdWxfa3VtYXJAbWVudG9yLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogU3Jpa2FudGggS3Jpc2huYWthciA8U3Jpa2FudGhfS3Jpc2huYWthckBtZW50
b3IuY29tPg0KPiBBY2tlZC1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NClJldmlld2VkLWJ5OiBK
b3kgWm91IDxqb3kuem91QG54cC5jb20+DQpCUg0KSm95IFpvdQ0KPiAtLS0NCj4gIGRyaXZlcnMv
ZG1hL2lteC1zZG1hLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jIGIvZHJpdmVycy9k
bWEvaW14LXNkbWEuYyBpbmRleA0KPiA5YTZkOGYxZTlmZjYzLi5lZjQ1NDIwNDg1ZGFjIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2RtYS9pbXgtc2RtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZG1hL2lt
eC1zZG1hLmMNCj4gQEAgLTE3Niw2ICsxNzYsNyBAQA0KPiANCj4gICNkZWZpbmUgU0RNQV9ETUFf
QlVTV0lEVEhTCShCSVQoRE1BX1NMQVZFX0JVU1dJRFRIXzFfQllURSkNCj4gfCBcDQo+ICAJCQkJ
IEJJVChETUFfU0xBVkVfQlVTV0lEVEhfMl9CWVRFUykgfCBcDQo+ICsJCQkJIEJJVChETUFfU0xB
VkVfQlVTV0lEVEhfM19CWVRFUykgfCBcDQo+ICAJCQkJIEJJVChETUFfU0xBVkVfQlVTV0lEVEhf
NF9CWVRFUykpDQo+IA0KPiAgI2RlZmluZSBTRE1BX0RNQV9ESVJFQ1RJT05TCShCSVQoRE1BX0RF
Vl9UT19NRU0pIHwgXA0KPiBAQCAtMTY1OSw2ICsxNjYwLDkgQEAgc3RhdGljIHN0cnVjdCBkbWFf
YXN5bmNfdHhfZGVzY3JpcHRvcg0KPiAqc2RtYV9wcmVwX3NsYXZlX3NnKA0KPiAgCQkJaWYgKGNv
dW50ICYgMyB8fCBzZy0+ZG1hX2FkZHJlc3MgJiAzKQ0KPiAgCQkJCWdvdG8gZXJyX2JkX291dDsN
Cj4gIAkJCWJyZWFrOw0KPiArCQljYXNlIERNQV9TTEFWRV9CVVNXSURUSF8zX0JZVEVTOg0KPiAr
CQkJYmQtPm1vZGUuY29tbWFuZCA9IDM7DQo+ICsJCQlicmVhazsNCj4gIAkJY2FzZSBETUFfU0xB
VkVfQlVTV0lEVEhfMl9CWVRFUzoNCj4gIAkJCWJkLT5tb2RlLmNvbW1hbmQgPSAyOw0KPiAgCQkJ
aWYgKGNvdW50ICYgMSB8fCBzZy0+ZG1hX2FkZHJlc3MgJiAxKQ0KPiANCj4gLS0NCj4gMi4zNC4x
DQoNCg==

