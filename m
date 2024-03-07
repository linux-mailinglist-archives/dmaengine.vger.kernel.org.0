Return-Path: <dmaengine+bounces-1282-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6F874A52
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 10:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8BAF1C21C46
	for <lists+dmaengine@lfdr.de>; Thu,  7 Mar 2024 09:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0382D83;
	Thu,  7 Mar 2024 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AMOiEU04"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481882D75;
	Thu,  7 Mar 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802391; cv=fail; b=FiOk71PoXa4mxgxlUN/UAL6FC2m2i4geOwmrUARR+1e0WdIG6lhAvR0pj+PNg/i2ieI2U0nLwOdoGW7U/oiKidKCSDEZ7K9qqt7gADP3yEwf91r2sIPoufjvisLvTNFTW4LjL3t+Rlu9ehWbY0USoRE88Kth5Xb3s0ENHKe+nnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802391; c=relaxed/simple;
	bh=TX+biI4JBx2oYwtViyy0cND2v1s/sZE/NispqnIaSwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ObxZpdA5pQWjAqrVLwkajOm4cEp3NQ3Tz4GNEIufOZut4FWAhHegaSMAi582p7jkU0xPLSipTiRD9DQhuWFQUkffGmwAlpHyDyRN5fH8iGZzO1wIjk1DeNjXS7AyhkNaago9P/Pskpx+NnVn1lO4w+S11YM89hNLbQm/WNz4HDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AMOiEU04; arc=fail smtp.client-ip=40.107.20.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSFJJ/SVXnx2f8tJw30UCHEYSIxh6BHC/0XElrGgoKdiL6gR6VMSClmstNd0mtlZWMqwFUlfxp66uY9nvuo4C4J80FMBwfZ3RxvGMXEruv54AAgHwIvvNdX+FEp9SyFGC5XTXQr1jaw3OhnPqirU8oHyUDc6YZnxpK0agCer6CxaUs008XqA//yFdr/fzCwItAADGH7hv7jlZnVBruNgr8fOn2YEJktGD24ZmDesl8437OmRWGzwQL6xiOItKOADVstv6skycMFBpsI5f0BcqJYrakCeRMsUqamgx6lfjgRbgyRcQwLlMt9zACTRNBksGkifnPt9r9Hg3rojQdj6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX+biI4JBx2oYwtViyy0cND2v1s/sZE/NispqnIaSwk=;
 b=Gm21GuP2k98NSRuKp5A2gnpGPQz+Rxe56WRgETfeodftEEDrMwitoSj1XPK5bNXItsJH2M38gEajEDbVqiMHe814dbijIChdUPKGnu55E4kmUiyQsbkdvddq9wC7IFeNZTOVPhgFLuisKJeSNHVjDCW0AoP9354IVERt1VJ352gKcbiY3jswIBegteANPvps0O/UwJABBNlx5DVYShaIpxvXwKoEbZYx6UxD9oyWvzI0eQByBkoH0GKws/mjGm3c0CkOIGcFLdrLZ+cd8AOBnu8W9bscrchZ5TDS8C5UssEf8iFavmA1K2uXAie4/+q2a4En7SL28YWSQJwIi3uoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX+biI4JBx2oYwtViyy0cND2v1s/sZE/NispqnIaSwk=;
 b=AMOiEU04XFrC0eX2HO/DQ4l49SSprnd0LSFaIxQp5XhZ+wXlSKgyLdmpVpjbV0RGpAqAVV5xw5rTksGZsvPoSuxD/CA4mheoKTbDvVGCO2y4fn3gdjahxYJJKzx+627K9tCsCCA0TJBhntYFtFD7oOCirBMSR1JikpRywQs/oDE=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM0PR04MB7188.eurprd04.prod.outlook.com (2603:10a6:208:192::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 09:06:27 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::8a76:10d0:859e:c8b2]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::8a76:10d0:859e:c8b2%4]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 09:06:27 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Frank Li <frank.li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 3/4] dmaengine: imx-sdma: Add multi fifo for DEV_TO_DEV
Thread-Topic: [PATCH 3/4] dmaengine: imx-sdma: Add multi fifo for DEV_TO_DEV
Thread-Index: AQHabe0hyF4VQvxfTkOW62b9rmmvLrEsAYZQ
Date: Thu, 7 Mar 2024 09:06:27 +0000
Message-ID:
 <AS4PR04MB9386FB32B150AA897BEAC3FAE1202@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240303-sdma_upstream-v1-0-869cd0165b09@nxp.com>
 <20240303-sdma_upstream-v1-3-869cd0165b09@nxp.com>
In-Reply-To: <20240303-sdma_upstream-v1-3-869cd0165b09@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AM0PR04MB7188:EE_
x-ms-office365-filtering-correlation-id: ca4fe026-723c-42f6-448e-08dc3e85df23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 r27nPRUPYQpIVlwiNJwx7yGuJDffyiU+HxVobf548gVyVRmycLjJWGWjeBuxeBXCOLB3+uhsOB6CdbQH0G/z6mEP+Oy+Lpqr0kNpJkLzYpwiT6crlHqovXT1/9m0GKOC7nbvOmYLSpMce3wKEKlHIyS0aLLIsPACN3fh2ip88xFSoI7+ycI++bAKWlOAWb7yBWylZRSpLG93UMThaLRjwjwaJKOIvpZytaR60Axcdq1+v6BJw03gDTMeyTJ2e+HnUcEvsbZBiLhwZC8PwRzxoh8ppJnIbdSOhURWkMX93S6UMrmEnIdj4Ov4RvmiHUJRwUZjFUJelnglMy1btV1aSvL+RLVqLNFiamfucdPuoRiOW39u+ZyjkIeXT0Lh0y9tgleV+bVkMKJWBYMVyy8uoYYw9lQgyYklN8+Jk934B9y9aQq++HHqm9NrrZn2WGCfkyVJRVlU8EFbZ1XOV+u57eMkp6xT5xAAbbI1KOwJQQUZ0BtIMYPsAAFjo+77FOZhVYXLo44r/iTar5KNWvtzxsGalRXT7TClTq5HalCEgaol2LGcTWNdl9TmtMXoR3TP0pwmQROz8vWRWM45AsJvNlQWxVQAdCCwvu+Qj9JijAeQbtXB4m6kKy/iPEhZS6WscBH5bNFOX71UxJxAbEGxD+rOVZ5F4Hj1FZFD7bZ6lXyeLsXd5i06Ltb8uLQBZmmX+/gBXevWHsayylon7tkZTg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDhUZ3g2N2s3V3VLbk9ZSDZFK3NmaGJlSUFBRFhFUnJXV1ZrQ3JkNUd4Q0E1?=
 =?utf-8?B?UEdpMXRydm5JVWJ2SnNwdVMzNE1oSlkrZmJlaWpmNStPUCtreUlMdDZlTHF2?=
 =?utf-8?B?TUl1azVQQ2M4OStsSWdxUk5rUHlDUXNQQk1ERDNMay9rdFAxR05qVkJhNG84?=
 =?utf-8?B?ZDZOY1Y5R1ByZlhEY3AyQXEwckEvbk9McURUSk5vTVJWN0tBOEFDaGNkOTdC?=
 =?utf-8?B?Z29nVTgyKzQraStrM2ZvTGs5bi9za3cveFRlUUZ5bzR6UXhCUk1zUXdKYjBx?=
 =?utf-8?B?bEhCZUVZU3JIbEMzVEpwNkcyTE1WL01tZlZPTVFtYThnejVOUGRzWUJqUG1a?=
 =?utf-8?B?ZThWSTdEM0VxdFdDNi82bE9iV1JGd0s2ZGc4eVkrS0tOcjROL0JQMGxVL1dJ?=
 =?utf-8?B?NkRnZ2x3WjBWSnRDMHdZUVBVOFQweGNDQVc1RXpmeFMwYlZ5em52VExiMWhm?=
 =?utf-8?B?NmRtZUhOZGs5T1AwZ2tZQ2R6Yll0Wk9OZitndHpkRGJJQi9hV0RPMEhQNlYz?=
 =?utf-8?B?eXNpUDJnanQrUFJnaGpXZzJaYUsrdXNYTWw5NkJPZXZKTTNoRk5nVUhaalFh?=
 =?utf-8?B?UE9vRGU4RWhRdnM1TzJBdW5RVXlXdFBMWnhMYXBiRnBsd1NtUDhrcDQrWDVh?=
 =?utf-8?B?TVoyRzlYeXFkNm5nVlNrVGVwN3R2aHJEVjduMmZmNmRTaFBUMTN0dGoyNGFY?=
 =?utf-8?B?SUdJMUpncjlQTDRBTU5SODRHa3JkblR1UXdwRThLVWFVVDRUSGZXWFg5R0xv?=
 =?utf-8?B?eWNZdW90b2U1TkZWQnBJa3hraGJPdHl6TjRNWjhKL09GMW1hdmNhNVdzSnJp?=
 =?utf-8?B?Qy8wUmljQjJNMmtzMnBhV1NmMlB1eHBSY3I3QjZ1Q3VGai9sdC9oYUE5eEg4?=
 =?utf-8?B?TkZZMDFFMHlEWjJMdHlPU29JWkNrY3lpU095OWtXUVBGQ3VNVEFkaFhZNlR5?=
 =?utf-8?B?cUJqTnNmeE5uS0dycG9JRi9rTG1LWjMvb2hzcHpMYWFucjJuaTR2ZTA0YzZq?=
 =?utf-8?B?SDk0d2pGNS8xUWpzM1B1VVdwWkpSUVI5aUxKU2tmSlVKMWFaU0tzbW91bE1O?=
 =?utf-8?B?OW45dVBnYkV4Ujh4S2FyZE45WWFTWnRlYi9RMXF1c2hWV0ZFcXI5VEJTZG85?=
 =?utf-8?B?YzZCZTZCeDVsckhEUXVPbEh3cHJYSzIvNzh4dXZLcmJrNUdrQWYzWkJTNkxq?=
 =?utf-8?B?TnZPUGxEdTZYeklGb3F3VFNLSFJaQ21STE1pUC9BdFFTTmovaHVkcFl5QWdL?=
 =?utf-8?B?MTk0UWxDQnZDS1ZmSi80eFJJd0dKb3RlZFJKdEViZWJ5ZWdLb0RNc2UvYm92?=
 =?utf-8?B?NWhrKzlxZFBQZnJlQ3lxVjI1NndCbWJIV2Z0c3kvdkx0TWp5ZCsrUFFTRzVi?=
 =?utf-8?B?SmNxM2lPTzNMSmNST3lyNktQNGt0MDJHbUtKVGtuVTBMTFZYQ0I4V1VuWEZY?=
 =?utf-8?B?cWZUMC9Jdm5ha2p1cnBRZDgxbnNPTVJvdTYxZHo2M2ZON3o0VzdpZGUrYis0?=
 =?utf-8?B?cjFuR1QvM3M5TDBEQUtNbjkrNU5WbDc0UkZ1ZTZzQ0cxYXA0VDF0WXZHQVVH?=
 =?utf-8?B?MFBXVmFjUkFqNVFvbXhVYUljTGhkME8rUXFJWFhwNUE4U3lZdTY0S1B0OEtk?=
 =?utf-8?B?aFgxNGxQUWk2U080SnZoTzdOR0RkN1VvZlNaeUh5SFZSemdBWHNPYjF5M0ky?=
 =?utf-8?B?SytKTUJpZFJmdUxoR1Rhcm5JdEF6bjVRSmwxNjhrc00wNE5UZVJoYmhQQU1r?=
 =?utf-8?B?Q2R1cDF3cmdFRlBhRmJteXV3ekpPTkFRYjVkQTIxTi9JOVdHL0RjUitOZVcy?=
 =?utf-8?B?OUppcE1rVjNCRk9lUlFRRTByRkNNTzhFZWl4VG5lbzcxTFFqNFBVenplcmVp?=
 =?utf-8?B?cjR6TmlDOHhBbGxBTEw0YVFsYW56SWI1Q284MU1LMlpsQVEvRUtJOEc0dEM5?=
 =?utf-8?B?QzVyMzV4Y2JXWFhIc1hqaWlQb3pFb295RmZBdjBmS3lOaEZYcHF3RVFTV1hD?=
 =?utf-8?B?T1VQYnc1a2o2R242VFRHRmlEN0huMWRsU0Z3WUxMN1BxdzBFL1kra203THcv?=
 =?utf-8?B?Vnk0ZTh6VmtTOTVySFJFRCt2bkx4eFJxakZWSFR5Z2ZrRithSEVzZ0srRG5n?=
 =?utf-8?Q?GeyI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4fe026-723c-42f6-448e-08dc3e85df23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 09:06:27.4504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzJHcZQiwQp5+dPXnEjOPJssIwvAsquAIGBU6U6y78R9q4Lrx1ntY/nXoSIGWmPQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7188

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZyYW5rIExpIDxmcmFuay5s
aUBueHAuY29tPg0KPiBTZW50OiAyMDI05bm0M+aciDTml6UgMTI6MzMNCj4gVG86IFZpbm9kIEtv
dWwgPHZrb3VsQGtlcm5lbC5vcmc+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Ow0K
PiBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJu
ZWwgVGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2
YW1AZ21haWwuY29tPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gQ2M6
IGRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4
LmRldjsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+OyBKb3kgWm91IDxqb3kuem91QG54
cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAzLzRdIGRtYWVuZ2luZTogaW14LXNkbWE6IEFkZCBt
dWx0aSBmaWZvIGZvciBERVZfVE9fREVWDQo+IA0KPiBGcm9tOiBKb3kgWm91IDxqb3kuem91QG54
cC5jb20+DQo+IA0KPiBTdXBwb3J0IG11bHRpIGZpZm8gZm9yIERFVl9UT19ERVYuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KUmV2aWV3ZWQtYnk6IEpveSBab3UgPGpveS56
b3VAbnhwLmNvbT4NCkJSDQpKb3kgWm91DQo+IC0tLQ0KPiAgZHJpdmVycy9kbWEvaW14LXNkbWEu
YyB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2lteC1zZG1hLmMgYi9kcml2ZXJzL2RtYS9pbXgtc2Rt
YS5jIGluZGV4DQo+IGVmNDU0MjA0ODVkYWMuLjliMTMzOTkwYWZhMzkgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZG1hL2lteC1zZG1hLmMNCj4gKysrIGIvZHJpdmVycy9kbWEvaW14LXNkbWEuYw0K
PiBAQCAtMTY5LDYgKzE2OSw4IEBADQo+ICAjZGVmaW5lIFNETUFfV0FURVJNQVJLX0xFVkVMX1NQ
RElGCUJJVCgxMCkNCj4gICNkZWZpbmUgU0RNQV9XQVRFUk1BUktfTEVWRUxfU1AJCUJJVCgxMSkN
Cj4gICNkZWZpbmUgU0RNQV9XQVRFUk1BUktfTEVWRUxfRFAJCUJJVCgxMikNCj4gKyNkZWZpbmUg
U0RNQV9XQVRFUk1BUktfTEVWRUxfU0QJCUJJVCgxMykNCj4gKyNkZWZpbmUgU0RNQV9XQVRFUk1B
UktfTEVWRUxfREQJCUJJVCgxNCkNCj4gICNkZWZpbmUgU0RNQV9XQVRFUk1BUktfTEVWRUxfSFdN
TAkoMHhGRiA8PCAxNikNCj4gICNkZWZpbmUgU0RNQV9XQVRFUk1BUktfTEVWRUxfTFdFCUJJVCgy
OCkNCj4gICNkZWZpbmUgU0RNQV9XQVRFUk1BUktfTEVWRUxfSFdFCUJJVCgyOSkNCj4gQEAgLTEy
NTksNiArMTI2MSwxMSBAQCBzdGF0aWMgdm9pZA0KPiBzZG1hX3NldF93YXRlcm1hcmtsZXZlbF9m
b3JfcDJwKHN0cnVjdCBzZG1hX2NoYW5uZWwgKnNkbWFjKQ0KPiAgCQlzZG1hYy0+d2F0ZXJtYXJr
X2xldmVsIHw9IFNETUFfV0FURVJNQVJLX0xFVkVMX0RQOw0KPiANCj4gIAlzZG1hYy0+d2F0ZXJt
YXJrX2xldmVsIHw9IFNETUFfV0FURVJNQVJLX0xFVkVMX0NPTlQ7DQo+ICsNCj4gKwlpZiAoc2Rt
YWMtPm5fZmlmb3Nfc3JjID4gMSkNCj4gKwkJc2RtYWMtPndhdGVybWFya19sZXZlbCB8PSBTRE1B
X1dBVEVSTUFSS19MRVZFTF9TRDsNCj4gKwlpZiAoc2RtYWMtPm5fZmlmb3NfZHN0ID4gMSkNCj4g
KwkJc2RtYWMtPndhdGVybWFya19sZXZlbCB8PSBTRE1BX1dBVEVSTUFSS19MRVZFTF9ERDsNCj4g
IH0NCj4gDQo+ICBzdGF0aWMgdm9pZCBzZG1hX3NldF93YXRlcm1hcmtsZXZlbF9mb3Jfc2Fpcyhz
dHJ1Y3Qgc2RtYV9jaGFubmVsICpzZG1hYykNCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=

