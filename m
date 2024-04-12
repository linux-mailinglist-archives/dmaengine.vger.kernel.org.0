Return-Path: <dmaengine+bounces-1829-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6CD8A263F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 08:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7C11F245D1
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 06:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FFB1F60B;
	Fri, 12 Apr 2024 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B47lPiuF"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7371759F;
	Fri, 12 Apr 2024 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902323; cv=fail; b=q0ueU5N+xUZUXukSwHaL5oPf6kN4lazTITv0prQ2EuwqNhwjKDKadTLuWvBEYm5JrWoDx5E+1Nrf5ZcEC1YWUBzg8EiW68peO4kwWdqJVs950Z0IIlfXY2kPp8IsB+lV6QggV+md6O0n221KYkTBeAb3fntoJpVjz82RgLHsUao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902323; c=relaxed/simple;
	bh=rA5ATQqzCjBXT2JO84Feo3o2Am0MsVv/Eetq4CQHZ6Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Js9wn0aCEw0nzJXVq1wuPxUrSxS1uYjS9pcSK9hbta0DGmea9gKmkrv4BdVYykOgeL0MSZdsClv3vC1BJ8nPJqbdlPaK0mtS7IwLD3fNzwPZEP2BBNaAyNfdyksfVT1cea2eYXtjIIMwCioxbAHU6N8bDndxyQWF7AH7YYpzWQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B47lPiuF; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrjyFMqmjegmorUnjPIjNGU8irmwHklIRmjzWvF9Ui9z6z3AewL+JaH+2tN2Oa7LDNkKYKRwg6LLaNxcaHi1gGajuA0oT9jjkgNJlxxcu53RhKUVSZDfk5R61nkBM8vomOAmLpG0JXaUtYiCWebBeR7TJsfGkugj7FHvvQw/VK1C4/C0r2Qhrz9UWca3MrBVZEZHHwapRdovWiHC6yvdQ2Q4Fv+Im5wf0gQBDMtxXVi9W/TA6EGmanZV0j0MfBJcxqPpEf1ItZwiMv2iXnGoRQraBG6ozqDhOIxAD5q1WXi5rm18Ob2jdk2ObCBoILcNnqdLZ0Ef8+r42rdlBVbF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA5ATQqzCjBXT2JO84Feo3o2Am0MsVv/Eetq4CQHZ6Y=;
 b=d197PJpU4w/4ffmPQ+BTyONmwkGMIsmY2r0HzVdUF5iZ6KPsOOKnje99fA3vqyw9bvxS5bDqOpxuhMtNTsVMn5S/h744wRY7vp6mpWu+g1rSE8qO5a+zpMmlkpLiwtQPrKh7Y8P6yaajVwVfbIxBJrshP6oSCmnTm6SPHRm7Hdv9pbgCVuRnPbgqP/uto1VcwSPJKOuMe/ivUAkvgB0rfvjMg7mVa2HpHSeWyPBiY2t02bJ2Yw3t/5wFQv8iwZVMpUWvkHdeWW/HJiUoBXmXr1jTQkrajPSUmKH2hYgqN3qnTaKAERxt7nw1LXrxUfjHqYudWt+kIDTvD1zWVhHoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA5ATQqzCjBXT2JO84Feo3o2Am0MsVv/Eetq4CQHZ6Y=;
 b=B47lPiuFe+el8f2Fe2Fev2I6FfpB/4Eb7bcjT7Atb4BnZ6ZwaPXOc2ooPZYzNgBfeHtS1jnUGSwIEAnJDH0aYFvqog3iYcShhCxTtv1BmIEHFZDMRoVLYTsNKdjvp/wtmyj9tloruFpYStXrQZ2mUci8KldwF5Q5X59EOlWpkmM=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:11:58 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 06:11:58 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Peng Fan <peng.fan@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] dma: dt-bindings: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Thread-Topic: [PATCH v3 2/2] dma: dt-bindings: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Thread-Index: AQHajIUuEAhXZZnpHky9jxxoW2hbE7Fj8+IAgAAxrFA=
Date: Fri, 12 Apr 2024 06:11:58 +0000
Message-ID:
 <AS4PR04MB938611B9AF281AE6CD72B08CE1042@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240412030436.2976233-1-joy.zou@nxp.com>
 <20240412030436.2976233-3-joy.zou@nxp.com>
 <ZhilSv5xh0hJ2vdX@lizhi-Precision-Tower-5810>
In-Reply-To: <ZhilSv5xh0hJ2vdX@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AS8PR04MB8564:EE_
x-ms-office365-filtering-correlation-id: e67d2c9e-5cc4-4633-876f-08dc5ab77625
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RFy4wcZMgaTYX1sH5E+38wrtguDvd1JUbQhUu2eUL2KOtFMGCKPYRCGPs04+5S3dvZvUQXX7vRveLnkE53aJJYzMZWm1uxSKj9cLbfRsC/nPs8yuE6Gnv6aV0GqjBJswIm8Asu4wFBWji0o9kD1YrJkJKISAul34KpgzmceHFyXluZcYSLu4VSCWxnLcSUN5RH0YEL1rW5i/LMvghN4JeIniZfEHWapxZIe97eteG3emY9jnB+BXMGB1dkuV2Cf/lWEG5IsFBFxzb87Qy3LhDOiIkOUquXPTyNlYwSq30SLRbi/OT64SPrEiFV/LMPn4caQqynTbwS4ryTQgIlLlG0gIb3yXOjHwt05KwTzJrv3DUZ47xk6rROTfpLtEV45yswE3WXn17dzSAEFSprrXZqIHbjAooepup+BK+I0lO2Ox52BAgDlnZESZGcy9TP8sKnPPEW5HgnBjlXTEwMCAep9iFBCh7qEnav1C7Y2fySZhYvzEsAof/xT6e2ZjJY4VxCTyyHnoYqxncwGXUikH37+6qm6weLlgezgUlE91n5uPhQILacHh9K+dnaxkBSbA6Bu1Tr11v/3Ak5S2+6ld+R/3P3ejygO4t+n9VJ+dUdmy5aWnR4CUMEZstzr/Hr5U8/JgzBXuelqC6E+OOnIB9NauvEzY1/FcK1EMydgKotcaDvoxMGknIMJqod4DzBKBKnMu4Y6u7rUIGyoSMukmTQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZjhONnhyL003UnFpUGpWTjJ1b1Z6OTNFNS9iNisyckpFK2xBTENFbklvV0Rn?=
 =?gb2312?B?cHRCQTVCVFhxOUI1NTRwKytjTGtXbmpjK3VjMkZyeHo3bDc0RmtRQldiUmZW?=
 =?gb2312?B?VlU3bUJKelF6NnVxbHhWK0Niai96b0NpSVZHaVFBMjRmM0lGNWhVc1BLMzNi?=
 =?gb2312?B?SG91RlFyVjlkei9zbFViUjFOZHJxb1ltdWJjNVl5aVRnR3VuOXMyZUkyVEw5?=
 =?gb2312?B?VHU3Z0I3Y1FTUjJValhpNXlVam5USFdDb3doR3JkcEQ5UzkwNTNxK1FoRFcy?=
 =?gb2312?B?SlRDRXh1am1ZMEdWOFBwSTdMQXBucHM5cnlDckl1NmZ1NmNQZ3Iya0Y2QlVV?=
 =?gb2312?B?REZRYzlWbTdtTlVKMlBkMjdNQjFpU2tuRXFFV0NEZzdHckd0OGc0dlpQakp0?=
 =?gb2312?B?QUFIbXV4THJ0bjFTTkhWZlVNVWJQczhDQWxjeTRJNkRzT1lzMnllTkMzQ1dH?=
 =?gb2312?B?RnJpc2xzTEtmM25OQzNlekxaak15R3dyT1Y4dHU0YlpYcDRFUFRac0g1UzRh?=
 =?gb2312?B?WURMd1lHeUlNQ0VmT2RvZ0ZtOXFOcEZOVWx0bHpBdzdiV2pXNDNXS3VBZWJH?=
 =?gb2312?B?ekdIK3huR0ZqczZ3UWh6MUdEamNkVmI4b1M1Qm5LTGFINmg5WXFoSFYxR2RT?=
 =?gb2312?B?bFFYMFBQWDNrZkh1N25xOVN6UFk2U3ZkR253RzVxcTFLaFJ3SXJscFd3clpz?=
 =?gb2312?B?RUdLSDNYMm9CWGVwVlpHSU5MUEszeVFNMkNDUS94NkRHZStqKzlPZlh3ekk1?=
 =?gb2312?B?bW1YRlJsUllWZUF5UlpEbjN5MFdXRnRCemp0V2w0QTlFaGZrYURocDVUdVdU?=
 =?gb2312?B?UUV6N2g0c1UybCtjdlRqQlNKS2VBdnNrNVhLUzdkbDVzYjdPcUd2NmNpYWtM?=
 =?gb2312?B?OTZwdXdaY3MzcDFFRWZxNFR0RGozMFUvRW9sOFV5Y2ltSmM1VThib1NNRWJa?=
 =?gb2312?B?WUJsZDBZcTZ3b2lnM2FyRzJaMkZTdlNUcGdQSStwWXlJVzAwTGMyQU1HcnRR?=
 =?gb2312?B?UzI1dVFzYnpDOEVIMy9FRFphWHA4L0ttMW9Yd0JoSEFuV00yN3c0a2tGT2Nl?=
 =?gb2312?B?eHRPNk91aS9lRmgvRVpXa0xhN09iQ1lQclBaQUpUTUtSOVRoZmV5eGprbEp0?=
 =?gb2312?B?RjJPYVQyOGlXTGxXalh1bnNKZjRLazFaR0JKRDNOVSs4WG1wK0k1K1lQRC9F?=
 =?gb2312?B?anZSTnBJRmoyeHBiWXZpa2s0S0lmZG1aUHNCcUxndHE4U3RjZXJEbVA4M0dD?=
 =?gb2312?B?VVgrWHp3WXdkS3JmbDhmelNBU0w4Z2RVZUlGVndjcG0vbWpkZ2RCTGMwK2hL?=
 =?gb2312?B?MDRUcGN3aXE2SXRJd2M1NHBmRitFUzVrQUQvMjc4aElFTWRac1krMEt2dk9j?=
 =?gb2312?B?MjJCandVOFZ3cDl4bG5PcEUxNWZOdy9lTEN6TUxEdHluMENqeE9WTDk0Tm1x?=
 =?gb2312?B?TzNxeU8xWjRKdEVMVkhpajcwRjNIWWp4YldVU29BVk1GZnphT3g3NHZrR1hS?=
 =?gb2312?B?OG0vUld2V0haOU95blIvWmFkQllFVjZUMHZCb05WNlYrd3kyQW1VeFNmMmhX?=
 =?gb2312?B?S1FzcnBPamRieHdhS25iektqdUQya1MwZXR4NDdSSDJrVUFJekt0TExzVHk0?=
 =?gb2312?B?UU4rd00xejZDVktFakdSRFpJOE9SSUtDWXJKbjRoT1c2WnpSMUxZaVpLckRM?=
 =?gb2312?B?MTdGS1hRdnhYNDNsemdNbDN3ZW9HNStWQUF2M2o4aTNxeHlHQlp2U2RRL0dJ?=
 =?gb2312?B?ekJRMHl6dTY4bUtkdk9vcHErQnFmbTF2U3pIWWk2V2JrV0xkUS9jYS9vYTZx?=
 =?gb2312?B?MWRSN2VoT3R3UjNkM240UDdvUThyTWQwbGNOeWxXanJrY0VKVHZxQlZMc2Y1?=
 =?gb2312?B?SUFlV3JQTFhCQ2E0Q2JnZmFqS21XeTVkNWd5STNWN1ZEZW9NYjZDc2c3NG1z?=
 =?gb2312?B?QVYyY3VUejY1TzF3anVkTyttaU5iUGNTOW56bW56VXAxQTdoR1I5b2NUSWJu?=
 =?gb2312?B?bVJaTnlGWU5VWGlGQXNLN1A4bzVJc1hiSHdjWFhuamF6cVloQjdZZlhKSW16?=
 =?gb2312?B?MlpXT0xDdzVvS0w5UDBHd3l5aVpxTGU2Q3ppRUgrak5PMGRkdkR6SFNtMUE3?=
 =?gb2312?Q?/NIU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d2c9e-5cc4-4633-876f-08dc5ab77625
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 06:11:58.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNXWXWciM8beGimbwKdG3ddQ1I1YGiBYBEP+AsPC8hjlJDsxbrubEHyOugZsyjYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo01MIxMsjVIDExOjA3DQo+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IHZrb3Vs
QGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBkbWFlbmdpbmVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gZG1hOiBkdC1iaW5k
aW5nczogZnNsLWVkbWE6IGNsZWFuIHVwIHVudXNlZA0KPiAiZnNsLGlteDhxbS1hZG1hIiBjb21w
YXRpYmxlIHN0cmluZw0KPiANCj4gT24gRnJpLCBBcHIgMTIsIDIwMjQgYXQgMTE6MDQ6MzZBTSAr
MDgwMCwgSm95IFpvdSB3cm90ZToNCj4gPiBUaGUgZURNQSBoYXJkd2FyZSBpc3N1ZSBvbmx5IGV4
aXN0IGlteDhRTSBBMC4gQTAgbmV2ZXIgbWFzcw0KPiBwcm9kdWN0aW9uLg0KPiA+IFRoZSBjb21w
YXRpYmxlIHN0cmluZyAiZnNsLGlteDhxbS1hZG1hIiBpcyB1bnVzZWQuIFNvIHJlbW92ZSB0aGUN
Cj4gPiB3b3JrYXJvdW5kIHNhZmVseS4NCj4gDQo+IA0KPiBZb3UgbWlzc2VkIGNoYW5nZSBzdWJq
ZWN0Og0KPiANCj4gZHQtYmluZGluZ3M6IGZzbC1lZG1hOiBjbGVhbiB1cCB1bnVzZWQgImZzbCxp
bXg4cW0tYWRtYSIgY29tcGF0aWJsZSBzdHJpbmcNCj4gDQo+IGR0LWJpbmRpbmdzIHNob3VsZCBi
ZSBmaXJzdCBwYXRjaCwgdGhlbiBkcml2ZXIgY29kZS4NCj4gDQo+IEkgc3VnZ2VzdCB1c2UgdGhl
IHNhbWUgd29yZHMsICJjbGVhbiB1cCIgb3IgIlJlbW92ZSIuIGtlZXAgY29uc2lzdGVudCBmb3IN
Cj4gYm90aCBwYXRjaGVzDQpUaGFua3MgeW91ciBjb21tZW50cyENClllYWgsIHNvcnJ5IGZvciBm
b3JnZXR0aW5nIHRvIGNoYW5nZSBpdC4gV2lsbCBjaGFuZ2UgaW4gbmV4dCB2ZXJzaW9uLg0KQlIN
CkpveSBab3UNCj4gDQo+IEZyYW5rDQo+IA0KDQo=

