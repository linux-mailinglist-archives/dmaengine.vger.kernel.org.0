Return-Path: <dmaengine+bounces-1882-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9618A90C7
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 03:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12961C219A0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Apr 2024 01:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EA48F66;
	Thu, 18 Apr 2024 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nNMvHgA3"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AEF848E;
	Thu, 18 Apr 2024 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404408; cv=fail; b=RyaQyeSyM1QWSI/v51+lIFIhyXHTq7pwKGJngeg2hE0uK1LAXXTroCztTG1CHL2YuAcHWR6puWx4FaiUvJZUKZ0rlGKzCsR0yIGRZb4H+1CmRbBupGvf8TuTlu/FxCF2NeyjXcHyXD1AyqJmQ9wllALF0am29bl1gRV7VuxcMaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404408; c=relaxed/simple;
	bh=1rwIb7AvsQz2KG2DcSnzIg78EMPFMJUI1OgGzDRGH3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g1t/Zjd+q10Wacx4XYBYhPFF7tgfZ0dwdS/pR067O3KJNnDsK9ra/gw+0Xfd0F6sjaLxuhRMHDToPI+KJvwTDVR09DtNjlVuGOVTdUUsh4bPnvGTZ6JBpe6V9EZeEHvQpi0q/KRtsCk2KY4S1Q976LQdqlxjIIfl/ifikSHOPGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nNMvHgA3; arc=fail smtp.client-ip=40.107.7.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLQfTaBOLhTWjo9HayKyp1D9tqdDCeNKRGIbxR/pemK3gLvSFlMQQSeHndG0vN8UXnGUNAztyUg7K4yxe1B8NxEgZ2URAkSgUzd7KRsBnrJXFK0OM/I3FcVE/OfnBx4E009+X2jf3vAg67EiA687iuH8dhu+44U9WDD8gL/oBszdtCxdGCQtWyyfXslC9eWRJIP2KtSvfJ8F+yngJbDY1T+b/Tf6vxW7/n8tjhrQQJfvvI0Oqe3Bpcjti+iD/NthhFHulQhL0QSglOHM+WAlJioKS8u0BUv0rZLsa5fsHHt3j1ZxxDaFYClj0sTw66IIeYNRH08Co+D41zJ7Y+4pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rwIb7AvsQz2KG2DcSnzIg78EMPFMJUI1OgGzDRGH3s=;
 b=ebQVttWPoPQnWtFsR64rgVo7TJfq1MoGxHyVPj7bxGVty9MKJY57zaaVXzgeWt/eXjNWpbci9xCx1FvQZHt8iR1ChC9FAaXoiPgYKWy831d7vRO9hLuFdf522viA7De+q6T/i9bHy+wDw7RqbjVFzZg8ok42Ee8H3DrdliyqpF/74ErdOO/BiSMYVZ7X2Wjxgkqc8zktuR/ok3p4t+cN0fG0POhmjFeG5D4UNZOvHpYtFdWmfV84ia5husAWT3A9hvD7xArs/wNH4sPj+y6Q2mGyF77uYv4aUsfBqgsn25vcfCBvEqpvPFu0y1P9Br2w6kYU6ocS2oNjE6HwUkg3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rwIb7AvsQz2KG2DcSnzIg78EMPFMJUI1OgGzDRGH3s=;
 b=nNMvHgA3VXMvPtONCdIadZNB5o02eRZhPiykRQyhgpZt3tnPenV6GrOmri4WmsYe7qTnfH8cDj4HOEDAjYnO1X75qrnNIe7zazA61dRv2ikH/RdP3gnviO45XVj/NCFMYZWxBOpAW4b3wMEJVAd4f5Q4CzVHgQfEmDuiQV/FRfI=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAXPR04MB8490.eurprd04.prod.outlook.com (2603:10a6:102:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 01:40:02 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 01:40:01 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Peng Fan <peng.fan@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 2/2] dt-bindings: fsl-dma: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Thread-Topic: [PATCH v4 2/2] dt-bindings: fsl-dma: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible string
Thread-Index: AQHakHX+gykj9sKIG02aneceTSVL+bFsir+AgAC2mzA=
Date: Thu, 18 Apr 2024 01:40:01 +0000
Message-ID:
 <AS4PR04MB93863D999D75E86C8EFD0C84E10E2@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240417032642.3178669-1-joy.zou@nxp.com>
 <20240417032642.3178669-3-joy.zou@nxp.com>
 <Zh/gcSXV3ZPpjufh@lizhi-Precision-Tower-5810>
In-Reply-To: <Zh/gcSXV3ZPpjufh@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|PAXPR04MB8490:EE_
x-ms-office365-filtering-correlation-id: 0a999512-d143-4b04-158d-08dc5f4876f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Db1DToEK7KAdvY2jCjody3QYBguo64A0D9FDX3ITY9NGANvZ9q9d6gHAtD/ELGg5YDwS4nGCYIo1GiYbO3p+8LwP3ssGsIePJgj6q8SVZY6XjUFB2yZuFEUax0Kb37Fm31XDIs+LEzdNOUuBELNn9COX8/Jd23e5vTEwxabKRzo/j4YjHRGLNH6POwO9Dtgbucxwxv4TvwlW+WXQBweU8MVc6bmfm20olFeZ7ST31pEr7IWY0HEvJ3kqfWhtjvTWZJFO/P0eSri5uzbNfr/kee3bvJ6mNEsgCv8kGLExHTPUI7SB9+sJGTbU2JdlRzANkMpzgM0FmcD6bOLuMTkfxg5lcIo4uIJ9q7OaPS8fJrm3vcbX2udiOfFs9iZX+Z/6LNsNj5Tu5KNsEKU2e6fpt7rfNcGihlBeRJwLOmqfOpn+LqaJUdO/nqQbt0fXdKXc5jo2axwUdvQMAxLIcBElDWFv+meeLjcyrgHkHkdqayrCB/DIKUg6QKl+v9q6lv4WZvRlD7RmilfJ1jLThKFGlaDmJ9Md4Q5JUWqZUhoNCmaW913fGYllhmRpPm+9VUfralxjPOSY+BG5Md9v7Ngkqx/MXAboLZQneYi4ZR0+7m4WK4Xf/4yQf99KfzErdAR+ReA2HkEmzYD+wlQtiVE/B0PmvraTi0tAN7x32oaano/TZcOJ/cAcAHYW1/GklmOG/ScWb6P9cRTSIcxcgEGwJg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dGIycHBNdWcxUGhOc2lIbmxwQ2hXNlphc01nZzlGcUJiTWVlWkJDcXRPdkor?=
 =?gb2312?B?Lzlzd0RVZ1F3d295M2NkVm5FZ05hVWQ0cVVNdUFUajB1b3l3NTNvUTFscDBB?=
 =?gb2312?B?cnAyNWNQVGExdTRGYXMzSElmMGZsTHllK2cxeGhtWW56MjhIQXZ6T1hERDg1?=
 =?gb2312?B?aldFcytVajZSU0pqOEJQcHE4WUlOVGRpWTNHRDVUN01keTRNNVJ5RUptaXl2?=
 =?gb2312?B?NkpZYU9velhYSFpLRWdHSFhVcFhyVG9mcXNQdll3RUl6VUdiLzB3NEpXTWhw?=
 =?gb2312?B?R2lWbVZuc3FKcnRpU1NHS2RDd3VYaHZ1bGRSVS9TdlZaVmNRSnVOTnRDNEVh?=
 =?gb2312?B?c0hlTENwczR4dm1UejlJMnBDNUxCc1hkREtkZXQzR0VpZ3ZpVms3ZGFlNGtF?=
 =?gb2312?B?RUtucTdGK2laUjVod0FheUdzb2JudU5QYTRqZk9MZmMzUWE0akorV20zT242?=
 =?gb2312?B?RnpaL0NST0FMdjVQbzZwYmNsNkYwejJyaDYzbTI4THZZR0g0T2UvT3hWaFVY?=
 =?gb2312?B?VERwSUN5OEFHak1BMUlsNHhFTnpyNmRYeEZCalVEQkhiS0Q3K3BoK2Y2akNN?=
 =?gb2312?B?OUgvT3B3a2Z0eEoxVndXcmk4WXh4REFrNzdjZDYzV2FZQ21MNmRrakdjQVlD?=
 =?gb2312?B?RXBORHVZVmwrRk1RV2F1dytRSEMzYk1wclBwZ2NleXovOGlXUjNxdUk5eUF0?=
 =?gb2312?B?N0p4TEFINVhQdFVWMzYxZGFpbDM4bmRtYk1kcENLOUNyd25nQ1doMVJVK1h0?=
 =?gb2312?B?a0VOSGhxSjcwQmQ5b205WTB6VjZ1V1JyK3pyekZlSjcrN3ZXOEpQSTYyeUll?=
 =?gb2312?B?cm9uTmV4TTNPMFhCRHFnVjk5MWlTcCtOQ3A2VG9sWlpKYWpDQ1VKVWNwVXI1?=
 =?gb2312?B?SGl0Nng3V1drWW8rbnR3R0l4SDVyQW92bXAzRTlJUUZzY0NPS1BUay8rbmFm?=
 =?gb2312?B?NFVoRG4rSWNSNVJjdjVlQWM2QXhjbklnQlRSemF6WEd2eGt3aGJxcEpDK0Yv?=
 =?gb2312?B?OTErK1ZjSGUzcHpZL1hheXVma0crVU9ma1BPZXVscHJsM3VURmlkMDBjT0lH?=
 =?gb2312?B?WjF0bitpMjd0TlhWYnlRVjZiZU8zMkZoVnZ3N21ZQURSWGIvMWVSY3R4Nzg5?=
 =?gb2312?B?YUExWk00VEdEbG9VakJ3SktMTjlHWUNuT0VRZmJRdG0xckt4eXdVMWFyNGRy?=
 =?gb2312?B?NE93UEE2TzRBdkU2QTAxSVhaeE9UUlU1QWthSzVWMmZLQkQwUnA0c3BBSXFV?=
 =?gb2312?B?Y0RRazZ2N3VWditGc0JiUVdnQVh6MmpsdGEybnZoaDFkbzBHZW1CVjZvdzFm?=
 =?gb2312?B?MUpyR1NjRzgxb003K2NBMGNreHZKb3ZhSEE0U1FUYWx4N29BVWF6R21WQzZS?=
 =?gb2312?B?TFFHMEpJbUttby91WCtEa0pVMjUyN05rWnZNTExZSml5WDdLOHhxSE9XZ1Q5?=
 =?gb2312?B?YWEyQkZZZ2FCWWVJZVZzT0lxVmc2TUlpSWFDbkVaMFZRbnlBU2tyMlVnQ1dC?=
 =?gb2312?B?WlpRK21ORWlpaWFtbWdWcFNFc0NCL0xUVHdMY1N2TmxPbStDQjJzSXBTZXFJ?=
 =?gb2312?B?ZFE2NUpzZjVBWU1CdmtMRytQZlgxQ0Y1NElnaEkyeGtFYy83TXpvdWtmL2FX?=
 =?gb2312?B?bG1FUTFBbElLcDRaUS9KdFExZ3BIM3FWQVg4amVld21kMXUxRGkydlVROW0x?=
 =?gb2312?B?K2RuYU1ZU3VDRnhaMzl2akJtLzdJWDhKU3NQc0xZdFlYRENBL0Z5VHpud1lJ?=
 =?gb2312?B?N0JVYVROUHFleHh1Y1dsNDVUSUFFQVA1c0QyU2doNkd1bk1zMDRSWHFGcWcr?=
 =?gb2312?B?K2c1eXlkTXJjc1NlTXJKRHNaNnNBRko0enFzL29HNDRFVkpZYmk3UGIreW05?=
 =?gb2312?B?bmc1RmJDUGF1MEM3RTVkUExiY2FOV3V5dVp2RUdENG90UWJCZ2szZW5na25a?=
 =?gb2312?B?TndpQncwckozdWp3UFZCQjNWL1k0RzJIV2xPMFVtNXVpSTc3RklYTlZFQk44?=
 =?gb2312?B?d0twNHY3NVV1VC9CQmc5ZUtpYUt0L1liOElnK1dnU1FlU1lYMW83amlxZ2RE?=
 =?gb2312?B?MTllYnhnMDQyWVNZNmhnaWszYkxTQTBsNTduN1VRc3FHa3RRZnA3WDZUMyt6?=
 =?gb2312?Q?dFBQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a999512-d143-4b04-158d-08dc5f4876f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 01:40:01.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNQh8ye4PJUDwKwx+fTFCVHjKluDr2YfFo9dLoJy3JigP6d0WKc0vK5Y05cdNCWr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8490

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI0xOo01MIxN8jVIDIyOjQ1DQo+IFRvOiBKb3kgWm91IDxq
b3kuem91QG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IHZrb3Vs
QGtlcm5lbC5vcmc7IHJvYmhAa2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBkbWFlbmdpbmVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvMl0gZHQtYmluZGluZ3M6
IGZzbC1kbWE6IGZzbC1lZG1hOiBjbGVhbiB1cCB1bnVzZWQNCj4gImZzbCxpbXg4cW0tYWRtYSIg
Y29tcGF0aWJsZSBzdHJpbmcNCj4gDQo+IE9uIFdlZCwgQXByIDE3LCAyMDI0IGF0IDExOjI2OjQy
QU0gKzA4MDAsIEpveSBab3Ugd3JvdGU6DQo+ID4gVGhlIGVETUEgaGFyZHdhcmUgaXNzdWUgb25s
eSBleGlzdCBpbXg4UU0gQTAuIEEwIG5ldmVyIG1hc3MNCj4gcHJvZHVjdGlvbi4NCj4gPiBUaGUg
Y29tcGF0aWJsZSBzdHJpbmcgImZzbCxpbXg4cW0tYWRtYSIgaXMgdW51c2VkLiBTbyByZW1vdmUg
dGhlDQo+ID4gd29ya2Fyb3VuZCBzYWZlbHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb3kg
Wm91IDxqb3kuem91QG54cC5jb20+DQo+IA0KPiAiU28gcmVtb3ZlIGl0IHNhZmVseS4iDQo+IA0K
PiBUaGVyZSBhcmUgbm8gJ3dvcmthcm91bmQnIGluIGJpbmRpbmdzIGRvYy4gYWZ0ZXIgZml4IGl0
LA0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KV2lsbCBjaGFuZ2UgdGhlIGNvbW1pdCBtZXNz
YWdlIGluIG5leHQgdmVyc2lvbi4NCkJSDQpKb3kgWm91DQo+IA0KPiBSZXZpZXdlZC1ieTogRnJh
bmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IA0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgZm9yIHY0
Og0KPiA+IDEuIGFkanVzdCB0aGUgc3ViamVjdCB0byBrZWVwIGNvbnNpc3RlbnQgd2l0aCBleGlz
dGluZyBwYXRjaGVzLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjM6DQo+ID4gMS4gbW9kaWZ5IHRo
ZSBjb21taXQgbWVzc2FnZS4NCj4gPiAyLiByZW1vdmUgdGhlIHVudXNlZCBjb21wYXRpYmxlIHN0
cmluZyAiZnNsLGlteDhxbS1hZG1hIiBmcm9tIGFsbE9mDQo+IHByb3BlcnR5Lg0KPiA+IC0tLQ0K
PiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxlZG1hLnlhbWwg
fCAyIC0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQoNCg==

