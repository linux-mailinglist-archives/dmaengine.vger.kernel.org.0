Return-Path: <dmaengine+bounces-1824-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCCD8A2386
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 03:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4145C1C226E5
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 01:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6D523A;
	Fri, 12 Apr 2024 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A29CoSLC"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2052.outbound.protection.outlook.com [40.107.241.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D826AA7;
	Fri, 12 Apr 2024 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887179; cv=fail; b=MgrNhLvgzMQB9r3v1PjCAApoz0HbmOLHE71R64jo2m+PykIOwvT6yPQecPPtC9uxnK7OrLi9Ppw6T/+SfqRee6OFc4uNNa9tGS5iUKf6rZsFtiEieOmHLhwJLjfzCi7xfkXnR6EaoQg4TpNNlBHLFD6qe0GYrq8XDQJMvIs6dfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887179; c=relaxed/simple;
	bh=Nn9EZ+D8QeHckl4f6AQuNEXCGzL5IT/Q1RTKq88V0vg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p56PBuCNcvkZE0wTgk2LcS73Fw8xafi6Yopqy8ADDTBKtMdzCO8a1ky9wxOZUyLJvqfzUQOmQUitzMLAkyaWBtf60juRYeLtfvioD5f2+i8Wv1O81MZ2Zh/1wHyyy0hV5l9BTCXibDC0/XAFEQeB4dzSYxx16AusvqSFwFBn5nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A29CoSLC; arc=fail smtp.client-ip=40.107.241.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLEVB/Ppm0U75Orh+WS4ZP/N0XyRkc7AMMaMym8dtlhVU+cQ5nz448PVHdlrNlGkZIVCGt4Ida1Bk+d/58ToY8BgC28X3HgI8hpaDkVqleYh4iFpWbmB7FfFBMrVgeEE/aAWxVzxh1IKJ2bRhWWpyX4p4clbfg15wSRc08ZQRsBvVVtmSYOJcH+K8BeuSh2n9zsZhHUdEpU22mRuGpP0Fu/s7U0iZDzw0tKznnAz6JwrPu4iuQKUK78U1yN4E2VB9oGmLfr3hYrYBLgIZiT8oxGMLdhyXbENVBalCD50Z2apU3eBTVrv3OZsjrgY/4DJyXs+oRBToeEDY8EcW2wttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn9EZ+D8QeHckl4f6AQuNEXCGzL5IT/Q1RTKq88V0vg=;
 b=Lux0n5i8SlHXsplifXfil+/Xqz04i4hpPVylsMprc7On/M7zYorYVTLXpee59FeGC6ypE1ATx9qtu0QxZWsxaiPOUIeyTvVglEXsyo9BvS4gsCk1xHM3O1VafmZ/HHk7OhElVI+7wIAE22cd3L4vQlrioASd7X8AXKy8DVsvd8tz7v6y7qsovL/zp4xZWUIvDpiCCQt/LfakKxE7sKomh1Q8dLlvR9esh3lNNUiXGe4za13L8s9DM+9CXx3e5LNnphCEVu9OtSZtyaLJTKk/jNO7nx1sV1OTLlDO9cvhMnR8NN5ngfWYc51egVWoFzF8M+9tLBv/MW6px2TACpxNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn9EZ+D8QeHckl4f6AQuNEXCGzL5IT/Q1RTKq88V0vg=;
 b=A29CoSLC+e1xK85Le3u5b9nCwD5KxFEXTU7EX1YpFrksPC01p6wdhL5Oe+XK6u1VTwvsuhNuRGhshy05e2VITe9VniIS3TXOiImjyyxmuv6NZIuhinqa+hJGATS6B2wo6ltoDibQ5bEV8mgPzg2ivFYf8r3uJBaHLRoDPYcbf1k=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 01:59:32 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 01:59:31 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>
CC: Peng Fan <peng.fan@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] dma: dt-bindings: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible stringg
Thread-Topic: [PATCH v2 2/2] dma: dt-bindings: fsl-edma: clean up unused
 "fsl,imx8qm-adma" compatible stringg
Thread-Index: AQHajBMuScNMceYv4UW89AkRdFbJ2bFj3TVw
Date: Fri, 12 Apr 2024 01:59:31 +0000
Message-ID:
 <AS4PR04MB9386CDE4C44F8540EF4EF1F1E1042@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240411074326.2462497-1-joy.zou@nxp.com>
 <20240411074326.2462497-3-joy.zou@nxp.com>
 <703311b6-ee3a-4131-ae11-57b8d765db5c@kernel.org>
 <Zhfj2NH7PPqzz3nM@lizhi-Precision-Tower-5810>
In-Reply-To: <Zhfj2NH7PPqzz3nM@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AS1PR04MB9698:EE_
x-ms-office365-filtering-correlation-id: eb86ac90-b6ce-43b6-6545-08dc5a9431e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QkHSqbDr4qZus3dRhvuLXRLzpVElr6OVGd8Jjda4WlY7EJRHMieMNvxstZQIhRvtu4OE2ajWpklkYkUGM00TpyMp1yfw3yghNWnf7HuK5gZXof+5Kikj1hSh6dP2lrh/BQulA0u86GoD5CbVa+PFlxH+QtWX2h1pxTAeg4isfP5VuPUU2+8wVZFe6Z1BsqYK4mFtHkt0uUTsidDw0sZCFw8ueDLRRU8scgiA/s4vK4sa1VZV5UtrdJbWP1donhW7Vgc/9cCT38CWwVPE0b9UKuV7XH1SJjc4vcMY6C/oTE9j5i6qJPucFOxQM/HpGTCvkQNjKtrDBTA6zJCvehiaN3ASTebaY+2/SPviMRdP9QYyL59IJZC8JerXsdQCboOlOAdhnEVxPKMpCQHzUoV89a1+lvBryaCVGuMeMg+qU4m9VHIro6JpHKS7e4kOUK+CTPEYDWBMgPnzefQnaIO3H7x4UNfr/VJFaPwCLIDRxlt0Re3P5OPOZsWd+czscRk9Mt2wpv3xQ7fn1IpyO9JAy7TDbXWenUPXLX9qzc9rrOtIrfz0mvvCM42v75JM/e74MkLzfDu4oaH4hniIRBWaDWWhe/7A3E37ic3XigReUjS7mZ2dVAXDKcTeFmCAhtyboXImSNYKtFOb5vp4YblvnepHzK3KcEJYvkCjKvDNRT1Z/KRjjuP+i0NX2enaF/TZ67/orV2HNv7xJ2lnnA/qLFJN1487yAn7BW+xFGF0Scw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eXFWaGV0RnI0Wk50UU4rcm1LME9zcXNtejFpVGpyMmsvUXVvK0RPVk51WVZw?=
 =?gb2312?B?YitoZVpNZklQUFVuL0hDUVVvaFpMbUlKTDF0TzBYMnhBRGJOMXdPbTBFYUdG?=
 =?gb2312?B?TnRJck0zSEZtT3p4K2VZUkRUSDZDTDhmbmhSQ3ZlV1ZwV1JjaFgycENVem9w?=
 =?gb2312?B?eW1FZjE4bld2djZHR0lHcXRmb3RKQ0t2MGtFaVNJbk1JYTcrWjQ0S2VTMmxl?=
 =?gb2312?B?WVd5bGY4cHBpWnRxUzNCVWRNaVg2VE1HMWtkOFhsTFg2VnNjOW4zamtvb1Jk?=
 =?gb2312?B?QkJ0WXhaSk1WRVRkZFZ5N2gyL28rUHhLZ0lWSnoxMEFsSGdSQVN4cFZiQ2dV?=
 =?gb2312?B?eDA0WlhuRGkvWUIwc29jcGc2QzRwbUM4V0tVQ2NtRlhhL2kvdHNOd2s0UWZR?=
 =?gb2312?B?K1phNE1GQ1duUThpSGFleitybm4yemQzM2ltRjg1R1hFQU9mZW5mU1BrVmNB?=
 =?gb2312?B?WlJrVEtKUm9nbm5PMktua3U2NXhTK0NhMjhEc1d2RHBKa3I4YTZtc2o3OE1O?=
 =?gb2312?B?TTlBSUp6MEdIcFJVMUhWcHgvK0pVZWYvdCtyOTVETThValVDcmVxTkt6SFNO?=
 =?gb2312?B?aGtwUk50OUxsL0lEOVhuNjAvWEkwTkhvbHd5dUg1a0s3TXJZaWtyUVZJaC9G?=
 =?gb2312?B?RUxacE5GUEN5YTZGOXdwWTgyVm93WnNQK2ZPM1lCUGZTQjBMUDlwc1ZiOTNt?=
 =?gb2312?B?VXBkcDg0UlhvQldtQlR6bXVHaUZvZXlmSHhOaDZUdVNNT3pabFhuK1RtVjIv?=
 =?gb2312?B?bjJCTmFWWEt5VFU5enpGYkJkRmFUL0JSSFlxd3FSaHVnYjRvYVZVeUR4a0Qw?=
 =?gb2312?B?WUcvdFVuV1VOMVB5Q0g3T1RjdHlacTN0YlVoZTJiaUxKbTg2SUVjTVZDTEdv?=
 =?gb2312?B?TDByTnVVNmhSMXMyWUpERk5sZFFHSEE3RFhSenBKQy96UXYvME1vMTBmalBY?=
 =?gb2312?B?Wm5rZ2hqOEFDbzdrTmx2TDJGUm1hdE1GVUpCODRzYXN0ZURENDhrYndFdzEr?=
 =?gb2312?B?eTI3Q00zcENTL1NQazBLMHA5TmlIQ0xQMGpzb3Awbm05TmhEYnBTMVNyUzRs?=
 =?gb2312?B?dFZ4N1lIY2laT05yaWpOaEJNU2laL0dKRzVwNEdqZFRiRDdpSjlxaENYQXNN?=
 =?gb2312?B?OGMwdms4Q01Hdmo5UGZmQytjdDhUbjRTaWJQbGJtUFE1V2tDU3BpLzdJeE5m?=
 =?gb2312?B?YjU0MmlmOE9FSXRNdEgwYVdIYmN4aS9WS0FYUWVhSENqUlFLbDU0VTZvbjB4?=
 =?gb2312?B?ZWt0Ykdjdi9WMkllR2lVZGdhMDdmYkxKc3p0MXZFY3VLNWJuYm81VXd3YzAv?=
 =?gb2312?B?NGdFYW9ZSFdmbEFNNlI5TTZDSCtsMUxrUWtkOS9jM29TSnVHL0JWM1dTbE44?=
 =?gb2312?B?Y2JuVDhIOTBTSnJHdlBmM1ZEZHluZGFJeVJUVWl2NDEyZHJndmFtTW9jc1Zk?=
 =?gb2312?B?TDdCSWhCSC9udkxKMlY3aVJDbG51VnU4VlRFRkxiOXFEYUJ2SWpwSElYNGhI?=
 =?gb2312?B?Z2l6alZ5TTAzVlVzS1Jqa0xKMEFHRGc0UWZaSVM3aEVxZmRLVWxiZk52bkEr?=
 =?gb2312?B?K3FmWXI5Uk5CMC9SUVBybGgvV0pRQTd4WWpzMTRBblRQRmRhK3NkOXhrdHoz?=
 =?gb2312?B?UEVYdmRDa1ljZWlYajlkb3MxV3l5cXZ4d0MwSmhtQytNUUFBeWczMGVIV0xJ?=
 =?gb2312?B?UkMrWVJ5Uy8yN1hwN0pXYWZxZTZXcUthdUFjOWQ0aGduU08vSXhxNWhzYlgz?=
 =?gb2312?B?K2IwMmRHdTlHUEFZQzNOTmNyVnNjblY1TWhsSDF2aSt5Umphdnk4YWxhdGp4?=
 =?gb2312?B?c05TV3dieXNxSWlQcEtBdmJUdTczNnNybGtmNkRheERZeDdlTGJyTzJOdEVk?=
 =?gb2312?B?ZkFqUmpiRWxhT2VBSmFYNlJObmtEckNmam1aSmdPRER2Y2tneW5ab3JPSkh6?=
 =?gb2312?B?TEhPYi8walF4bnh1L2dYSkpjU0VzVGNocHFmRDhIWlJZUTdJTFFqSWtnT1NK?=
 =?gb2312?B?eTJyMnYrSzcrMVAzOEhrRzE1ZHdkQW1Ib3hrK3lBaDdCU2c0WDVGQko3a3ox?=
 =?gb2312?B?emtDTjFIU2RRSFZEcWdJU2RSZWVSTlNTQ3ZrOHNnbDd3amI2SEd3UnhOeVpW?=
 =?gb2312?Q?NBhA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb86ac90-b6ce-43b6-6545-08dc5a9431e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 01:59:31.8576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slWuI4pOf96spPLZ8rYp5pmqgitEiOHPWF7fYZrEJ3tZh5xna++wsKL8sUNstqxr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqNNTCMTHI1SAyMToyMQ0KPiBUbzogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBDYzogSm95IFpvdSA8am95LnpvdUBueHAuY29t
PjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiB2a291bEBrZXJuZWwub3JnOyByb2Jo
QGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsg
aW14QGxpc3RzLmxpbnV4LmRldjsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAyLzJdIGRtYTogZHQtYmluZGluZ3M6IGZzbC1lZG1hOiBjbGVh
biB1cCB1bnVzZWQNCj4gImZzbCxpbXg4cW0tYWRtYSIgY29tcGF0aWJsZSBzdHJpbmdnDQo+IA0K
PiANCj4gSXQgc2hvdWxkIGJlDQo+IA0KPiBkdC1iaW5kaW5nczogZnNsLWRtYTogZnNsLWVkbWE6
IGNsZWFuIHVwIHVudXNlZCAiZnNsLGlteDhxbS1hZG1hIg0KPiBjb21wYXRpYmxlIHN0cmluZ2cN
Cj4gDQo+IA0KPiBiN2I4NzE1YjQzMGVlIGR0LWJpbmRpbmdzOiBmc2wtZG1hOiBmc2wtZWRtYTog
YWRkIGZzbCxpbXg5NS1lZG1hNQ0KPiBjb21wYXRpYmxlIHN0cmluZyA2ZWI0MzlkZmY2NDVhIGR0
LWJpbmRpbmdzOiBmc2wtZG1hOiBmc2wtZWRtYTogYWRkIGVkbWEzDQo+IGNvbXBhdGlibGUgc3Ry
aW5nDQo+IDEwY2FmYTJkNDU4ODUgZHQtYmluZGluZ3M6IGRtYTogZHJvcCB1bm5lZWRlZCBxdW90
ZXMgY2ZhMTkyN2Y4NDY4Yw0KPiBkdC1iaW5kaW5nczogZG1hOiBmc2wtZWRtYTogQ29udmVydCB0
byBEVCBzY2hlbWENCj4gDQo+IA0KPiBPbiBUaHUsIEFwciAxMSwgMjAyNCBhdCAxMDoxMzozOEFN
ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+IE9uIDExLzA0LzIwMjQgMDk6
NDMsIEpveSBab3Ugd3JvdGU6DQo+ID4gPiBUaGUgY29tcGF0aWJsZSBzdHJpbmcgImZzbCxpbXg4
cW0tYWRtYSIgaXMgdW51c2VkLg0KPiA+DQo+ID4gV2h5PyBDb21taXQgbXVzdCBzdGFuZCBvbiBp
dHMgb3duLg0KPiANCj4gSm95Og0KPiAJWW91IGNhbiBjb3B5IHBhdGNoMidzIGNvbWl0DQpUaGFu
a3MgeW91ciBjb21tZW50cyENCldpbGwgYWRkIG1vcmUgZGVzY3JpcHRpb24gZm9yIHRoZSBkcm9w
IHJlYXNvbi4NCj4gPg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEpveSBab3UgPGpveS56
b3VAbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+DQo+ID4gUGxlYXNlIHVzZSBzdWJqZWN0IHByZWZp
eGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0uIFlvdSBjYW4gZ2V0IHRoZW0NCj4gPiBmb3IgZXhh
bXBsZSB3aXRoIGBnaXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RPUllfT1JfRklMRWAgb24gdGhl
DQo+ID4gZGlyZWN0b3J5IHlvdXIgcGF0Y2ggaXMgdG91Y2hpbmcuDQo+ID4NCj4gPiA+ICBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxlZG1hLnlhbWwgfCAxIC0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZG1hL2ZzbCxlZG1hLnlhbWwN
Cj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2wsZWRtYS55
YW1sDQo+ID4gPiBpbmRleCA4MjVmNDcxNTQ5OWUuLjY0ZmEyN2QwY2Q5YiAxMDA2NDQNCj4gPiA+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvZnNsLGVkbWEueWFt
bA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9mc2ws
ZWRtYS55YW1sDQo+ID4gPiBAQCAtMjEsNyArMjEsNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gICAg
ICAgIC0gZW51bToNCj4gPiA+ICAgICAgICAgICAgLSBmc2wsdmY2MTAtZWRtYQ0KPiA+ID4gICAg
ICAgICAgICAtIGZzbCxpbXg3dWxwLWVkbWENCj4gPiA+IC0gICAgICAgICAgLSBmc2wsaW14OHFt
LWFkbWENCj4gPg0KPiA+DQo+ID4gSSBzZWUgbW9yZSB1c2FnZXMuIE9uZSBtb3JlIHRyaXZpYWwg
cGF0Y2ggd2hpY2ggaXMgaW5jb3JyZWN0Lg0KPiA+DQo+IA0KPiBQbGVhc2UgY2xlYW4gdXAgQWxs
T2YgYWxzby4NCj4gDQo+IGFsbE9mOg0KPiAgIC0gJHJlZjogZG1hLWNvbnRyb2xsZXIueWFtbCMN
Cj4gICAtIGlmOg0KPiAgICAgICBwcm9wZXJ0aWVzOg0KPiAgICAgICAgIGNvbXBhdGlibGU6DQo+
ICAgICAgICAgICBjb250YWluczoNCj4gICAgICAgICAgICAgZW51bToNCj4gICAgICAgICAgICAg
ICAtIGZzbCxpbXg4cW0tYWRtYQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eDQo+
ICAgICAgICAgICAgICAgLSBmc2wsaW14OHFtLWVkbWENCj4gDQpZZWFoLCB3aWxsIGNsZWFuIHVw
IGFsc28uDQpCUg0KSm95IFpvdQ0KPiA+IERpZCB5b3UgaW1wbGVtZW50IHRoZSBpbnRlcm5hbCBy
ZXZpZXc/DQo+IA0KPiBQYXRjaDIgd2FzIGludGVybmFsIHJldmlld2VkLiBQYXRjaDEgaXMgbmV3
LiBJIGtub3cgeW91IGFyZSBidXN5LiBDb3VsZCB5b3UNCj4gcGxlYXNlIGdpdmUgbWUgMSBkYXlz
IHRvIHJldmlldyBueHAncyBwYXRjaGVzLiBZb3Ugc2VlIHBhdGNoIGFsd2F5cyBhaGVhZA0KPiBt
ZSBpZiBhdXRob3IgYW5kIHlvdSBhcmUgaW4gc2ltaWxhciB0aW1lIHpvbmUuDQo+IA0KPiBJIGtu
ZXcgdGhleSBhcmUgcXVpdGUgYnVzeSBvbiBoZWF2eSBkZXZlbG9wbWVudCB3b3JrIGFuZCBhbGwg
a2luZHMNCj4gY3VzdG9tZXIgc3VwcG9ydHMuDQo+IA0KPiBGcmFuaw0KPiANCj4gPiBCZXN0IHJl
Z2FyZHMsDQo+ID4gS3J6eXN6dG9mDQo+ID4NCg==

