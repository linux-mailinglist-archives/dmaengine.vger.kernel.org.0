Return-Path: <dmaengine+bounces-1813-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B58A061C
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 04:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EA81C22B6D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Apr 2024 02:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4819613B296;
	Thu, 11 Apr 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BoyPt8VE"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2117.outbound.protection.outlook.com [40.107.14.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FD13B28F;
	Thu, 11 Apr 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803559; cv=fail; b=aU0Fhiw+e+EFskEpl6l/XNCwyzR0i4Zu+qGZLGv3aDwVuItmnDrcbosQIb++1BhsmW/C9IQpM5QgsDY0Ih/OJZAEVQoWMZWvFZN43R1UlC+wAvzoFABHE8GLy9NnnBSbnenaaIg957jliGTT08TcM3Tq2CMLm8IHa/K8MNQjUHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803559; c=relaxed/simple;
	bh=YSN7cswI+w1eK9qhU47TeqRMmTutFILDXm6TTEDoiN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJCMHW+yL++NZWmJ2rtCtUqdOzrTVPh0UPLf3Fpk1OExofD5OeWw9LnDDkPEF+c+z/XGSU7kdBkqEpOTuXvksw8Ae13cu0xyYDja5FxAMiGXbLqc+OyQXgdBZ5Id/07qQS9PaP54QNIuHU9uuw6t1RcY/wPY9ryt4CCbF7VTk6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BoyPt8VE; arc=fail smtp.client-ip=40.107.14.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itclJNNKL4OaZOONYmay1UxIHCyNVKn9rPnERWmU+LKDLtjxJ+WYVISH5okfk7ZNSNotSBA4z91IGUt4rY6F8OiCUIiUL8GOdRF2VLzWdsIaGSVoXoAjE9il2gF/ItXXykaOr2MuK6a/UUVVCM89EWpd7IrdHf6G0JnCTGG9gERfmpAjZB/fIH4Z5JZSePk6M5ayovY2lM3QmRcXkss0/L40JUwXiiSGIiXp/j1OJcesvIgft+BrxbipgXIovoQ4xP9q7wQ/i5h+5i45sSUlJiDNeTwtteoh4GBGluz81MDE6if65mX6lXtsR9fCzgXYvHLMnHhv8+iCkoo4p85tDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSN7cswI+w1eK9qhU47TeqRMmTutFILDXm6TTEDoiN4=;
 b=gipGNRiM4M6pxwNV0YrsAjrLZxMXz3BvUG0qc2Mic5f/GXdCkkwA854EgB8umMU2tWUG71HmoxX0GLfAKjbzN0ltmXcJCh6ntUOFcsNwowIme7QRlR5QH5n3cZesMTHIsrIlr9/hhDLwxtJ++fzTzp4HG0N0+dx+rmwriLJ/epDrDE9f/aDPnS7CS4ZAlrAGd5tJsAwHl9nrGJvPRmPQyXkqnstb2Fv3+cKs+xNv/Gd1UBja3mcMKTg9hgrSnpHVH/DrMTp52xrOShzt5EXyijrEgt/Rzudf/WMY8LROvnm1mY6adGaOsYwXE3X75+laXku+fScIj6aPwaIH5cng0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSN7cswI+w1eK9qhU47TeqRMmTutFILDXm6TTEDoiN4=;
 b=BoyPt8VEx2m8rg4tj1YjEMCQQbuz2yAFKSLSvflfCZrLMb0Q2s/YizY5nSlxgGDgz1PJOybzOxwha//twJI9BYExMWgE17TvyQ7x28+l1z9tAq5cBdmz9gTTTS5ggYDkMIxDw1Z3sSPJhyE2yoDycNZRyLBFYhu6DA+xrT5xOKg=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB8PR04MB7195.eurprd04.prod.outlook.com (2603:10a6:10:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Thu, 11 Apr
 2024 02:45:54 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 02:45:54 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Peng Fan <peng.fan@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] dmaengine: fsl-edma: optimize edma driver for
 imx8QM
Thread-Topic: [PATCH v1 1/1] dmaengine: fsl-edma: optimize edma driver for
 imx8QM
Thread-Index: AQHai7kWqqAB3cdtI0i0BLTcF6FZgLFiW+CAgAABE2A=
Date: Thu, 11 Apr 2024 02:45:53 +0000
Message-ID:
 <AS4PR04MB9386E7A6EB263F6AC6819278E1052@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240411024417.2170609-1-joy.zou@nxp.com>
 <20240411024417.2170609-2-joy.zou@nxp.com>
 <ZhdNsRyMxm0m83P0@lizhi-Precision-Tower-5810>
In-Reply-To: <ZhdNsRyMxm0m83P0@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|DB8PR04MB7195:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lz5jjJG89v/C7JMYW7ILISVhg4FDHJeeMqzzqvEu81URFLioveilJO439XgjDCLFQA3Jz4vOQ+P+1+dW50VsghRcFms+cWr/OQAFvZscY9bbXbFETF49MeIi7QHK25tUO1CA/Vqr6Jt26rVsfQ4f+G2K1Zj55w2+6gxcuFnvAZMp9ElhaAUDNkvf6xPZDvstw7l1+ZNL0eWdRaDcv3OwaTrDYrt7cAylfoxrwcuQs5pPNeZ+tIGWSEJzl2VLMLFi2ddYcRakEOdl/wMKIbhJbnTLi9A9e32Dg9YODgivaCYf22hNGPc++Luw784WGNcQs/sHdXhtlYSib5C3xPmrKu3lF07BiwYq3Pl8WhfM64goJU5HsvLjk3YiVsHNsoeHwnM0ZyBjAf7k5OZXbrjbB8rRxSWRB6FeniXVScJUMwo3uFD8CPfTnKGco48Zy2BZN+5kXq1DjwfByA4cx2UdCDK/SBGDyyRS/xDPlLWqbL4Ger3+gJ9155CeOyGH6wlzbmUlVBvjBfyW9LmTgqYAaJGwozjCMHvSu01ZEWazhvCDPxtHUUZCE6pr/Jg9sSlKJpbQrCyyf+J9GSLRuP5MAOpvB74b89KxlF6nIL299gpdfY6eX3tyYifCzPzgGIN+DHQ7Hc4gggqQEci0f7agD2zy7CUQFc6LbTr2Sl0tdxo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?U0lrRTl3OVVMZms0a3puVFhBTlpUR2pMbEppQ2x6b0hFYVQ3WDdZSVZkZ1V3?=
 =?gb2312?B?VEhLNms4TjA3b0MwMlg1VnFQVUt3cEV1UDM3bkQxV1FEM0IwOHpFWFFZWG9o?=
 =?gb2312?B?UDJIZGFLbkxmMW4xbldHdTNFalNtU3d3V0FmdWFEMEl1NkpxRWxkRjhrajBG?=
 =?gb2312?B?VTJleFBXVTVGVDNycExMK3VTRkJqOVpxVmFKTVllV2w3ekE4R0FlR29kWVZh?=
 =?gb2312?B?b3NTeWxNUTlYV0MzS3BzeGxXa0QrMVRQcHh1bHVTbFhkTDRsV3lwQ0tXUGx4?=
 =?gb2312?B?NkgzUzgzbDdSMWVJbVBmMUFEL2xwRmxSRWFwTnN3eExTZmF0L0xMY1BKUE1K?=
 =?gb2312?B?b252QTJvb2lDU1hqcC9XdmFMcWk2OUlUZkM0RWNLaTl1MzJuT2RWYUw5aEU0?=
 =?gb2312?B?aitrSCtLM2R0WlB6Q3ZSWWlhTFpiNlpmV0FYTmRmc2oxakkxRHIyc3NSMzhu?=
 =?gb2312?B?NWF4S3lXSXl1ZXdSbUxpTWxZRlRsekUzNkhoNlhNMmhLaUVlbXY2bmpGUlJj?=
 =?gb2312?B?dzFqcmsva3pkamN6WEdyektWSHpmM3pFTUVKdmZDSkFtTlFTOVUwM01iaDVS?=
 =?gb2312?B?U0FqcElVRWdMQ0xqekR3bmh4bW9ZZFY4MTFYU0N0SG44eEFjY3Q5NUgzODRD?=
 =?gb2312?B?RmR0OXpNN3B5WEc5L3paYnhEU2dBVjFXOVd4NjhDeHI2OTd5aS9lbFNpVFRS?=
 =?gb2312?B?a1RtTGRZRGJtb2RnWkI4WndFMTlZQVRNMXVrUTY0QlgweGNWclNYTW1yb2VN?=
 =?gb2312?B?SGs3WVpvdUNIQU1BMnJxcDc3WmRNakh1RnRvZW9PWVMwWlk1RUZEZ3ZQeXJ5?=
 =?gb2312?B?dWhGNHNhK3VmWTBWOCtyZlpzSmNmc0VKUFZGbHZwZmVBc0V4UGtxbFEwVmpi?=
 =?gb2312?B?cFA2RGt3RWY4bHdHVnJ4clNsQjFBYUtES0NISmdsQ1dHOElDejJMa21naHgx?=
 =?gb2312?B?VmZvUHlVbjBPVkFBNlQwVkJscFZDQ3d5YmdzZkRZdDNQam9VQy9FSURlRGg2?=
 =?gb2312?B?cDQ4dGd4OXNOTDc5cTdRQytEejdGWVV6UlRMMUFqSmVXNHBtQ0ROdnB3b2Vw?=
 =?gb2312?B?eEYxQzRYOXc2anRGRnhhVUREYk9kUUVUNWxLYlUrcFpiRm85V2RyY1oyNXNG?=
 =?gb2312?B?Sng5TkRnWWxSdVF6K244djRtaWs1RkMyMXZQVnZxbHRhTVVqUDM2VHpwOGF4?=
 =?gb2312?B?Tk9lRm5SNFloemRlVUhhUDUwQmtZNURpTXVobEtVR2RBTE41SWgvSW1WVEVI?=
 =?gb2312?B?aGdZWEFaWU1KLzI4d1FGNWJOa1A5NUYvakEvc2JQbWVZclpmNDRocEo5MlJw?=
 =?gb2312?B?dGJMK3lENHpjeEpKM1dCTHJGd0FtWm9Hc2d0R05zc3FEOXhiTTRESFV2YWla?=
 =?gb2312?B?SzkwZ1ZrVGVUQ0p1TkxCeVMrb01XbHIySDM2Rk1aREhkcjgwcjlTTU1YTDZ6?=
 =?gb2312?B?Nm5OcmlyYk5FQ1A0UFhQS3RVOFZSaUZVL1JSQ0loaWZIMXBOY1hpYUdldm1C?=
 =?gb2312?B?YzBZczEzcE83emwreWQrSUFmUmV5ak1lbW90Zk1YVEt3LzBpdnFlSS96NWpF?=
 =?gb2312?B?b0FtdWhNR2p2THFWdDZJa1JKZC9GS1BTRFVVcGN0RXhWbDFJOU8vNFJOWHJj?=
 =?gb2312?B?ZU12VSt0ZFVsbllockNnNUlPYlhKTXVjRUNrbWdmdlZLdGVRb2d6TERYbDBP?=
 =?gb2312?B?TkJyMVZHL1NNVGd0QU1lRkxFb0M0TWxwVDZNRG1nVEtVd0pIakNKWmMyZDhT?=
 =?gb2312?B?Z0d2VjJYbUhNRk5UNmQ1VlZsblJwZWpvY2xoWnI5WDM3dXFMSHBhcjI0RTQ1?=
 =?gb2312?B?VXFMOHYxYkRKNlA0MzZCc0RSOTh6eFdiQ0lHM0dIb01QdmIxcFRIcDNucnNW?=
 =?gb2312?B?dEpHYTExd0M0eW5UOE50Tmt5cFp5NDdYbW04Ti9yWlV1TkxzMU1Kc2hTK1pY?=
 =?gb2312?B?bEVjUThjRjBPOWFtU2tEZlYzUjVyc3BQQk1RUGxpM2V4MVBudXZkeHo1ODRB?=
 =?gb2312?B?RklQSy91Z1JZU2V2M090bGhUV1JodVFkKzhHS1ZGNUZnazF2Yy84M3FrS0I1?=
 =?gb2312?B?OVBiVmxJcmhacXJNWWRVRmxpTU5Bb2RHZXZJWEwrekZPSGIrVTFRMTlLaVhI?=
 =?gb2312?Q?XplM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5248614a-6b77-43a7-1175-08dc59d181c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 02:45:53.9855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svOCTlObPnYnD5Y065RVYLNUbMKs9g5+jopZuOnJQnNXFH7qhLJfhpLNR/KqJv2r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7195

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo01MIxMcjVIDEwOjQxDQo+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IHZrb3Vs
QGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGRtYWVuZ2luZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MSAxLzFdIGRtYWVuZ2luZTogZnNsLWVkbWE6IG9wdGltaXplIGVkbWEgZHJpdmVyIGZvcg0K
PiBpbXg4UU0NCj4gDQo+IE9uIFRodSwgQXByIDExLCAyMDI0IGF0IDEwOjQ0OjE3QU0gKzA4MDAs
IEpveSBab3Ugd3JvdGU6DQo+ID4gVGhlIGVETUEgaGFyZHdhcmUgaXNzdWUgb25seSBleGlzdCBp
bXg4UU0gQTAuIEEwIG5ldmVyIG1hc3MNCj4gcHJvZHVjdGlvbi4NCj4gPiBTbyByZW1vdmUgdGhl
IHdvcmthcm91bmQgc2FmZWx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm95IFpvdSA8am95
LnpvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24u
YyB8IDE2ICsrKystLS0tLS0tLS0tLS0NCj4gPiAgZHJpdmVycy9kbWEvZnNsLWVkbWEtbWFpbi5j
ICAgfCAgOCAtLS0tLS0tLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MjAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvZnNsLWVk
bWEtY29tbW9uLmMNCj4gPiBiL2RyaXZlcnMvZG1hL2ZzbC1lZG1hLWNvbW1vbi5jIGluZGV4IGY5
MTQ0YjAxNTQzOS4uZWQ5M2UwMTI4MmQ1DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9k
bWEvZnNsLWVkbWEtY29tbW9uLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21t
b24uYw0KPiA+IEBAIC03NSwxOCArNzUsMTAgQEAgc3RhdGljIHZvaWQgZnNsX2VkbWEzX2VuYWJs
ZV9yZXF1ZXN0KHN0cnVjdA0KPiA+IGZzbF9lZG1hX2NoYW4gKmZzbF9jaGFuKQ0KPiA+DQo+ID4g
IAlmbGFncyA9IGZzbF9lZG1hX2RydmZsYWdzKGZzbF9jaGFuKTsNCj4gPiAgCXZhbCA9IGVkbWFf
cmVhZGxfY2hyZWcoZnNsX2NoYW4sIGNoX3Nicik7DQo+ID4gLQkvKiBSZW1vdGUvbG9jYWwgc3dh
cHBlZCB3cm9uZ2x5IG9uIGlNWDggUU0gQXVkaW8gZWRtYSAqLw0KPiA+IC0JaWYgKGZsYWdzICYg
RlNMX0VETUFfRFJWX1FVSVJLX1NXQVBQRUQpIHsNCj4gPiAtCQlpZiAoIWZzbF9jaGFuLT5pc19y
eGNoYW4pDQo+ID4gLQkJCXZhbCB8PSBFRE1BX1YzX0NIX1NCUl9SRDsNCj4gPiAtCQllbHNlDQo+
ID4gLQkJCXZhbCB8PSBFRE1BX1YzX0NIX1NCUl9XUjsNCj4gPiAtCX0gZWxzZSB7DQo+ID4gLQkJ
aWYgKGZzbF9jaGFuLT5pc19yeGNoYW4pDQo+ID4gLQkJCXZhbCB8PSBFRE1BX1YzX0NIX1NCUl9S
RDsNCj4gPiAtCQllbHNlDQo+ID4gLQkJCXZhbCB8PSBFRE1BX1YzX0NIX1NCUl9XUjsNCj4gPiAt
CX0NCj4gPiArCWlmIChmc2xfY2hhbi0+aXNfcnhjaGFuKQ0KPiA+ICsJCXZhbCB8PSBFRE1BX1Yz
X0NIX1NCUl9SRDsNCj4gPiArCWVsc2UNCj4gPiArCQl2YWwgfD0gRURNQV9WM19DSF9TQlJfV1I7
DQo+ID4NCj4gPiAgCWlmIChmc2xfY2hhbi0+aXNfcmVtb3RlKQ0KPiA+ICAJCXZhbCAmPSB+KEVE
TUFfVjNfQ0hfU0JSX1JEIHwgRURNQV9WM19DSF9TQlJfV1IpOyBkaWZmIC0tZ2l0DQo+ID4gYS9k
cml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMg
aW5kZXgNCj4gPiA3NTVhM2RjM2IwYTcuLmIwNmZhMTQ3ZDZiYSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9mc2wtZWRt
YS1tYWluLmMNCj4gPiBAQCAtMzQ5LDEzICszNDksNiBAQCBzdGF0aWMgc3RydWN0IGZzbF9lZG1h
X2RydmRhdGEgaW14OHFtX2RhdGEgPSB7DQo+ID4gIAkuc2V0dXBfaXJxID0gZnNsX2VkbWEzX2ly
cV9pbml0LA0KPiA+ICB9Ow0KPiA+DQo+ID4gLXN0YXRpYyBzdHJ1Y3QgZnNsX2VkbWFfZHJ2ZGF0
YSBpbXg4cW1fYXVkaW9fZGF0YSA9IHsNCj4gPiAtCS5mbGFncyA9IEZTTF9FRE1BX0RSVl9RVUlS
S19TV0FQUEVEIHwgRlNMX0VETUFfRFJWX0hBU19QRCB8DQo+IEZTTF9FRE1BX0RSVl9FRE1BMywN
Cj4gPiAtCS5jaHJlZ19zcGFjZV9zeiA9IDB4MTAwMDAsDQo+ID4gLQkuY2hyZWdfb2ZmID0gMHgx
MDAwMCwNCj4gPiAtCS5zZXR1cF9pcnEgPSBmc2xfZWRtYTNfaXJxX2luaXQsDQo+ID4gLX07DQo+
ID4gLQ0KPiA+ICBzdGF0aWMgc3RydWN0IGZzbF9lZG1hX2RydmRhdGEgaW14OHVscF9kYXRhID0g
ew0KPiA+ICAJLmZsYWdzID0gRlNMX0VETUFfRFJWX0hBU19DSE1VWCB8IEZTTF9FRE1BX0RSVl9I
QVNfQ0hDTEsgfA0KPiBGU0xfRURNQV9EUlZfSEFTX0RNQUNMSyB8DQo+ID4gIAkJIEZTTF9FRE1B
X0RSVl9FRE1BMywNCj4gPiBAQCAtMzk3LDcgKzM5MCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIGZzbF9lZG1hX2R0X2lkc1tdID0NCj4gew0KPiA+ICAJeyAuY29tcGF0aWJs
ZSA9ICJmc2wsbHMxMDI4YS1lZG1hIiwgLmRhdGEgPSAmbHMxMDI4YV9kYXRhfSwNCj4gPiAgCXsg
LmNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtZWRtYSIsIC5kYXRhID0gJmlteDd1bHBfZGF0YX0s
DQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4cW0tZWRtYSIsIC5kYXRhID0gJmlteDhx
bV9kYXRhfSwNCj4gPiAtCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxbS1hZG1hIiwgLmRhdGEg
PSAmaW14OHFtX2F1ZGlvX2RhdGF9LA0KPiANCj4gUGxlYXNlIHVwZGF0ZSBiaW5kaW5nIGRvYyBh
bHNvLg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KWWVhaCwgd2lsbCBhZGQgYmluZGluZ3Mg
dXBkYXRlIG9uIG5leHQgdmVyc2lvbi4NCkJSDQpKb3kgWm91DQo+IA0KPiBGcmFuayBMaQ0KPiAN
Cj4gPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDh1bHAtZWRtYSIsIC5kYXRhID0gJmlteDh1
bHBfZGF0YX0sDQo+ID4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg5My1lZG1hMyIsIC5kYXRh
ID0gJmlteDkzX2RhdGEzfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDkzLWVkbWE0
IiwgLmRhdGEgPSAmaW14OTNfZGF0YTR9LA0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCg==

