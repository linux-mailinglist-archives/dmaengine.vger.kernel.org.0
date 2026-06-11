Return-Path: <dmaengine+bounces-11412-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NDFoILUbKmqciwMAu9opvQ
	(envelope-from <dmaengine+bounces-11412-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 04:21:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC7066DCE6
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 04:21:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=k6C0JQMV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11412-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11412-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D505312887F
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jun 2026 02:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3B2E1746;
	Thu, 11 Jun 2026 02:13:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF52314A79;
	Thu, 11 Jun 2026 02:13:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781144025; cv=fail; b=VoH8K1hJ0KKIUuuiBrMIzRFG90cAJb5N1lUs2Zau4QCWO3hyR99Qr3wcXxzc8cB1KhwNarSb5OSioQ4D67acD0nGQTWSpMjSVdipdNvbf8G8qdISFx8N+74WBnqh+G0hlRct6XESlNJRHZ+JZ3QdRyTshyik7JT8p8Nl2qDg9ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781144025; c=relaxed/simple;
	bh=vGwWtcpMbmTLqTbqdBbFTSu2Wg2y2TPYk3PL4UIKyLM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bhXGvzzRlHSLWMyATDBqPZ4qBQW0bVwnmAJrEBzAYAIshFF+Cz4ZwIjlz29ta4g39vqKI1wxOJYPggFL0dLnnP2a6RaQiLdHiUj4tjt+T5uIsImhxfKYII8tty1FlxGZ85/hzxqIwdUo6zY3mgcsWdxd2KYjAAVAkCNU0BA6yuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=k6C0JQMV; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWhz7+ZCOvnoz5uyKiOXUfoWy5/kP6WM0CVQxl4S+9JYCXGjCceheQ6C/5gzxCiPW3I9H/lkgJ9odo0QepVLGVQrfFyCjvodWwD7+gq5QCDJpooXkwxDm8bJoxjucnvGOWM2ORNLXSQBaUd4ABQxckGAxC0/71V13h+ROdFu0csisvGdI09ODfSsCIsjnDk5mEBId+sp2nat7lHZ0lzGOvHIpQWgq59z+JxZTYWCD2K1LLIM0b54RoEfbWsXnllIMmhbfkovfkM1PaxCnq/03bgxm+nr+wl1HShmgSNRXWYvj/aFjlaHc4Gpq4Vm9khF+Us2qX6OSlO9FYdei7rDfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGwWtcpMbmTLqTbqdBbFTSu2Wg2y2TPYk3PL4UIKyLM=;
 b=jrI1OSANIy0oTpXgEqvI09W1rxX1WX38Fe44W1TBG4IR+NFiH6gU+2pb1EvLZvCq1QX8jv3UyO+R84QfXf0nRhtWef+7mrWeERWc3i6pMq87CxLlKjkz0goRtmS9txDc+Rf54Gmj2x2pH69636eSToYStyKmdvyhWwoC9h2gW82B3jpZ3rDB++VAeoSOBEfLaNdeBUKaA7DYShczfvD0WRbYeC83CWJQJey1fCxTA2Km8lbZwhw6BxlcA7V1b6/pMNWr/XUxvvVzZzxkHL9bAFsTw9VaDlFi4F1z74eOIkl3Hvn1SWdAqUyEOrNUr/NL7s5qJvdM5+YMpd27OvCmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGwWtcpMbmTLqTbqdBbFTSu2Wg2y2TPYk3PL4UIKyLM=;
 b=k6C0JQMVmIuR9UBqzQnajemMQLfzRVxmDHFHIKy9A03gy975+MzjSk1PYulLUjIzzxHfy+EiqfKJe4rbOmHNEROBWQvweeSjB6hHXZU4gYmmtQmicAsOOz9cFnFeJ0af5zHYIJDNIzlIbPtZzsxwLxcmjmmMs39nqmKBYuWmcOnqMZTEByJ/FERq1j5THA3vnS+QO5/K2vqWWRctTGzZf8BnjG4J90LIVxfRy6VrlAfP/Qjo6dpwS3UsHfT7d2i0Nuz9jS70VZGidNJ4hETfAkaMyvIFq/5rX2reitqcNjBUCX6TQBGhuyG+0OQ9szD1YNW/U9UxzBbFNoGuKw0VSg==
Received: from SJ0PR03MB5951.namprd03.prod.outlook.com (2603:10b6:a03:2de::13)
 by DM6PR03MB5067.namprd03.prod.outlook.com (2603:10b6:5:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:13:37 +0000
Received: from SJ0PR03MB5951.namprd03.prod.outlook.com
 ([fe80::f285:8376:68af:6acf]) by SJ0PR03MB5951.namprd03.prod.outlook.com
 ([fe80::f285:8376:68af:6acf%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 02:13:37 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul
	<vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "NG, ADRIAN HO YIN" <adrian.ho.yin.ng@altera.com>, "Nazle Asmade, Muhammad
 Nazim Amirul" <muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: Re: [PATCH v2 0/2] dmaengine: dw-axi-dmac: clean up DMAC enable and
 PM
Thread-Topic: [PATCH v2 0/2] dmaengine: dw-axi-dmac: clean up DMAC enable and
 PM
Thread-Index: AQHc7AwigzDUH7pnZkqrRlq8QASrwrY4t7kA
Date: Thu, 11 Jun 2026 02:13:37 +0000
Message-ID: <9e207296-f608-427a-94d0-9f0162f28b58@altera.com>
References: <cover.1779688569.git.tze.yee.ng@altera.com>
In-Reply-To: <cover.1779688569.git.tze.yee.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5951:EE_|DM6PR03MB5067:EE_
x-ms-office365-filtering-correlation-id: 77a99b14-bcd1-4e76-2cb9-08dec75f0c11
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|55112099003|38070700021|18002099003|22082099003|11063799006|5023799004|6133799003|56012099006;
x-microsoft-antispam-message-info:
 Oxrep6k7l+2hGD5byzlfJ7qIky7MWojYJwtX+8MUkzwmJ00M+2PN1BRiMI/pz8KwA7A3sXS6GiR5l6yufoXxZOyMEW/Vqqfj/JHZ5RhuJyF2LoKpJJr4PrzvbSfHgjSJVPD1eyDvopIdXULDClJpx1+VwtL1qhxQ5sagBq4kFsGlE3huayned6lqqhiOEzgymu/JNfsWVHcr/mcQNVB9RU+4hXaqmLQLNiPcEIzpj30wF0xqHPcRh483YJJtk6DwoJViGE9mIOVhl+EQtLN3IbP9YuizTO03glCN48pH6UMddL5xGC5hcqhzZShHJE3JrjFptoMZmKRm1NqlfdMqKh+WzvJRQNvXMMlVPT+GDwwkuMyK8uX5Lb6iZSYlcFUQafQL8U3Xr5wWdxROQh9OBjiLITLbmJAKX7bBhdiDjfflcJS3GBZgAgBPba8Dy8lgLBmJyialm1dWJaKye01gP8vLBJjRsfKSdYcQsO9D2ZPtJqc5zux15s+AYBSnB+Fg9VCAVbK5nnvIQs76k2/8eAIcqyvAdmPY01ci7CNg0M9HITecN4YRgpg5a4o9T42bJfodRw3P1HFl1m/IfgyxCQyFdpgWnpf+zBm6KNEvGsN6vI2ruOinYpfidlx64s/aOaeRtSM1OOf5bKGV/eBBcl8Z7lemEYulMh5rpDYDMMU+GUrrZoQagvtDuKupQpAOZb+ITcmcS7Ib7KBCFO4Zn8XbpfzmW/LFCwfAxdc3XFpRagCJF4Oaa85xvEkJ70Kw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5951.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(55112099003)(38070700021)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzFHdzVNanFOa1hjU0pBclNpOE9UdmJiVUF1cll0WHlzWFh6ZFRZbzRETU9l?=
 =?utf-8?B?S1hRbW1GQUFNTFdwdjRjTTF3dWtaWGhnblJWdEE5QUlOQVBPRG4xblY1S0RY?=
 =?utf-8?B?TTN4ZFhOTjM5QXFQc2poenhZaGFTQ24vZWxpY0t3UTB5dlI5RklkbEhLbDV1?=
 =?utf-8?B?bENBK1VTS2FoUjRDM2NiSjdmYjREdFpSU2JxdWxoSmg0dDYyR2p2MXYvVUNr?=
 =?utf-8?B?N0JFa08wdWRmc3R5Q29JWGhHeUNNaXVvZGw1aXdFZHZzSERkUmh6bVM4RTZQ?=
 =?utf-8?B?YU1KTVI2M1JoRUJtNDZBcjFhakVSOWxxV3k5a0xZSUdabm5ncUptMDY2S05G?=
 =?utf-8?B?akJtUHpDUkV3OGRweHorcUVtSWNvbUxqdTRkeGtzTTV6SFRnVllvNVB1TmpC?=
 =?utf-8?B?Ymw1c3pxYjk5YVpLV1EzYTBpLzlucFQxVXlhZFVGK0F2WEVLc05aQkpTQndy?=
 =?utf-8?B?bW4zVzZHbE5Lckp3eHFEblNSWmNqUlhrOUhFenlNeTU0VnpCWlRCNHROQ29r?=
 =?utf-8?B?N0p1ajJoMFRFeDVKZ2FjZnhHbVhOR1hkZXFDRm5VT201Z2IzNmJLWWFEWkF4?=
 =?utf-8?B?ajU0Q2JoWU0yWGI1cFJmUnVoS1VoYjJpcGtuNHlGK1RzeFN2TCtaN2loK2N3?=
 =?utf-8?B?dUo5TGJhNEJBelQ1bXhpYmZtbmhNQThKanZlbUxIVUdlVGNaSFBaZTd1OENT?=
 =?utf-8?B?QmtQNWIzWC9DWlM2Rnk2SEw4VlIzQmdDMFh3dTYrWGxRazRuQXpuMnhON215?=
 =?utf-8?B?bGRKWmpMc3p2Qy80Rk9iTzE3L243NWlJV245YXVGSFZ0WWdDa3hoSjJleGk0?=
 =?utf-8?B?UkVVcVV0U0FHSG9qVHB1MVJIOGEzV2Q3by9SQm9RSDdQb3ZMRmR0N0I4dUI1?=
 =?utf-8?B?bzlTS2FCQkFOdXJueVMyeWtSVGMzWDFOYyt6aUZtS0dYZ1dZOHBoQ2xKdjRj?=
 =?utf-8?B?TmpDNC81enNYNWh6Z2x6R2djQ21uVXhYRVFuUWg1TDZNd2Y1bG9RUStFQmZp?=
 =?utf-8?B?NkgwME1GU21zNFA5WmFlY0xnaXYyNjA4QjFoUHRyOVNLenRKcnJEb3dhL2pO?=
 =?utf-8?B?eWJ2Y1RRQzEvV09ieCtKbXlxcFlWRW1lalRtYVZGSDFleGhqNGk5QWdkdVJV?=
 =?utf-8?B?ZXN2N0R2UjlNaFNGSklDWEpHTldSU3U1L2xzMzFjWFZYbWxCSzlFWmhLNzJH?=
 =?utf-8?B?NFVSZERNQzYySTNpcU1WTUw4cUI0MlFIMnVkdXZSZW05WkhGdDdhOWlQTWxQ?=
 =?utf-8?B?ejVBQXZhUlVDcS9PV0p6Z2dIS2FZZ212NDFiOGZIY3lPTENjUjVlQWdxUEdj?=
 =?utf-8?B?M2U5bkpoWTJpTDEvRVZBVUYxVjFwSmNzYkJ3cDYvelkrVHduak9sNWUxR3hG?=
 =?utf-8?B?b2tGVG1RY2dqUWg5U1I2TVhmQUdORlNRZ1pHeDVDaHRtcDY2dFJ3SW5iZy95?=
 =?utf-8?B?TDEwNmw2SzdZRzBvVy9YVEE2QnlPQUxPTGRZL0dqcld3K2pZNjd4cVZSUEZN?=
 =?utf-8?B?SW5hSmdaWk1Hd3lrOTUvcFRVYmgxRnB5TTl1NjVzNTB5WTVkc0RFUlU3d2Vm?=
 =?utf-8?B?eUhOeUpvYTJlTW04cFMvZzNENTZCMFVYSGpmUjR0a0QxOWtjSXRQcFZQUEp0?=
 =?utf-8?B?SFc0YnNVTUlHc0lJTGpIU3FTWW1MQ0Z2ajA3WWVzUjhTa0F0N0VoOHdsdjZH?=
 =?utf-8?B?ZHU5Vmp1RmUrTy9tK251dVI4TnN3MU04Mi9CbHo4a3dyOVF1VmNWYnBFL1ZO?=
 =?utf-8?B?U2hZM3VlV2ZwL2FMT0N0NTF2cy9Kb0dvN0t3QXIvZFlObXc5NVlEQ2RGeHlv?=
 =?utf-8?B?eTJTUmtjUW9IME1ZK21RazVQd09aL3BVVmlTZ3dMQWVRRHJBUTNaZVRnSU5k?=
 =?utf-8?B?RUNNWlhQOUQ4VWF4SGtZekt3RDkwYnNDY2pjZElnSXArb2tKUm1kQVozWlRY?=
 =?utf-8?B?VWFXZWprNlJBL1Y2UXh1bnozUjNxZ2NDK1hzaUtxQTlhaTdzTVdXczd1d2Rl?=
 =?utf-8?B?WklXRUdJVnh3blZJNWptYjN4R2paL1l1ZllLdll0SG80ZUVhTkNmTGhub0J2?=
 =?utf-8?B?eHA1eFFQdjdRWFJ6eVNSWml1QVVmNDFqYWtHUUQzYUtpUDg5V211M0hGaWg2?=
 =?utf-8?B?RWFEUHAzRXFMaXJPa2ZLWWF0UktnbVpudU1RR3phN1M4Z1JNWVpVNU5KWDVs?=
 =?utf-8?B?SjJYK3hxZ0JITGdFRkRodHBacFdkcFJDVXpsOU5KMzUzcXpMVXBkOWJZNE01?=
 =?utf-8?B?bG9yWkc2YUVocXJLZ1BwL1NWaW1UbDRCNDBGSTJHS0VwS2tPb2puRWZzOWdm?=
 =?utf-8?B?Y1ljaXhNTlJBb05uQjNnZWZwS2hURDVIUkRWZ0xYRG9jcmpQaFBoQmNzV3da?=
 =?utf-8?Q?LxM9sMxJqQVInCK4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8252570007929C499194EEC76BA581A5@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5951.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a99b14-bcd1-4e76-2cb9-08dec75f0c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 02:13:37.0876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CwgTFduR0JbT7Xzer6+F8UcN5gfX1Fj8oDVjDjQc9JSAVYHhpKr8ly7YFWQ2fORYo6CFTMV9Na4nM2kwHJzuFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5067
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11412-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:Eugeniy.Paltsev@synopsys.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:adrian.ho.yin.ng@altera.com,m:muhammad.nazim.amirul.nazle.asmade@altera.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFC7066DCE6

T24gMjUvNS8yMDI2IDM6MTAgcG0sIE5HLCBUWkUgWUVFIHdyb3RlOg0KPiBGcm9tOiBUemUgWWVl
IE5nIDx0emUueWVlLm5nQGFsdGVyYS5jb20+DQo+IA0KPiBUaGUgRGVzaWduV2FyZSBBWEkgRE1B
QyBkcml2ZXIgZW5hYmxlcyB0aGUgY29udHJvbGxlciBpbiBheGlfZG1hX3Jlc3VtZSgpLA0KPiB3
aGljaCBpcyBpbnZva2VkIGZyb20gdGhlIHJ1bnRpbWUgUE0gcmVzdW1lIHBhdGggYW5kIGZyb20g
cHJvYmUuIENhbGxpbmcNCj4gYXhpX2RtYV9lbmFibGUoKSBhZ2FpbiBhdCB0aGUgc3RhcnQgb2Yg
ZXZlcnkgYmxvY2sgdHJhbnNmZXIgaXMgcmVkdW5kYW50DQo+IG9uIHRoZSBub3JtYWwgcGF0aC4N
Cj4gDQo+IFRoYXQgZXh0cmEgY2FsbCBoYWQgYWxzbyBtYXNrZWQgYSBnYXAgaW4gc3lzdGVtLXNs
ZWVwIHBvd2VyIG1hbmFnZW1lbnQ6DQo+IHdpdGggb25seSBydW50aW1lIFBNIGNhbGxiYWNrcyBy
ZWdpc3RlcmVkLCBhIGNoYW5uZWwgY291bGQgcmVtYWluIGFsbG9jYXRlZA0KPiBhY3Jvc3Mgc3Vz
cGVuZC9yZXN1bWUgd2hpbGUgdGhlIHJ1bnRpbWUgdXNhZ2UgY291bnQgc3RheWVkIG5vbi16ZXJv
IGFuZA0KPiBheGlfZG1hX3J1bnRpbWVfcmVzdW1lKCkgd2FzIG5vdCBydW4sIGxlYXZpbmcgRE1B
Q19DRkcgYW5kIGNsb2NrcyBvdXQgb2YNCj4gc3luYyB3aXRoIHNvZnR3YXJlIHN0YXRlLiBSZW1v
dmluZyB0aGUgcGVyLXRyYW5zZmVyIGVuYWJsZSB3aXRob3V0IGZpeGluZw0KPiBQTSB3b3VsZCBt
YWtlIHRoYXQgc2NlbmFyaW8gbW9yZSB2aXNpYmxlLg0KPiANCj4gVGhpcyBzZXJpZXMgZHJvcHMg
dGhlIHJlZHVuZGFudCBlbmFibGUgYW5kIGFkZHMgdGhlIG1pc3Npbmcgc3lzdGVtLXNsZWVwDQo+
IGFuZCBjaGFubmVsLWFsbG9jYXRpb24gUE0gaGFuZGxpbmcgY2FsbGVkIG91dCBkdXJpbmcgcmV2
aWV3Lg0KPiANCj4gUGF0Y2ggMSByZW1vdmVzIGF4aV9kbWFfZW5hYmxlKCkgZnJvbSBheGlfY2hh
bl9ibG9ja194ZmVyX3N0YXJ0KCkuDQo+IA0KPiBQYXRjaCAyIChmb2xsb3ctdXAgdG8gcmV2aWV3
IGZlZWRiYWNrIGZyb20gU2FzaGlrbyBXYXRhbmFiZSk6DQo+IA0KPiAgIC0gQWRkIFNFVF9TWVNU
RU1fU0xFRVBfUE1fT1BTKHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZCwNCj4gICAgIHBtX3J1bnRp
bWVfZm9yY2VfcmVzdW1lKSBzbyBzeXN0ZW0gc3VzcGVuZC9yZXN1bWUgcmV1c2VzIHRoZSBleGlz
dGluZw0KPiAgICAgYXhpX2RtYV9zdXNwZW5kKCkgYW5kIGF4aV9kbWFfcmVzdW1lKCkgcGF0aHMg
ZXZlbiB3aGVuIHRoZSBydW50aW1lDQo+ICAgICB1c2FnZSBjb3VudCBpcyBub24temVyby4NCj4g
DQo+ICAgLSBSZXBsYWNlIHBtX3J1bnRpbWVfZ2V0KCkgd2l0aCBwbV9ydW50aW1lX3Jlc3VtZV9h
bmRfZ2V0KCkgaW4NCj4gICAgIGRtYV9jaGFuX2FsbG9jX2NoYW5fcmVzb3VyY2VzKCksIHdpdGgg
cG1fcnVudGltZV9wdXQoKSBvbiBlcnJvciBwYXRocywNCj4gICAgIHNvIGNsb2NrcyBhcmUgZW5h
YmxlZCBiZWZvcmUgYSBjbGllbnQgY2FuIHN1Ym1pdCBhIHRyYW5zZmVyIGltbWVkaWF0ZWx5DQo+
ICAgICBhZnRlciBhbGxvY2F0aW9uLg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBBZGQgUGF0
Y2ggMiBhcyBhIGZvbGxvdy11cCB0byByZXZpZXcgZmVlZGJhY2sgZnJvbSBTYXNoaWtvIFdhdGFu
YWJlLg0KPiAtIE5vIGNoYW5nZXMgdG8gUGF0Y2ggMS4NCj4gDQo+IE5pcmF2a3VtYXIgTCBSYWJh
cmEgKDEpOg0KPiAgICBkbWFlbmdpbmU6IGR3LWF4aS1kbWFjOiBkcm9wIHJlZHVuZGFudCBETUFD
IGVuYWJsZSBpbiBibG9jayBzdGFydA0KPiANCj4gVHplIFllZSBOZyAoMSk6DQo+ICAgIGRtYWVu
Z2luZTogZHctYXhpLWRtYWM6IGZpeCBQTSBmb3Igc3lzdGVtIHNsZWVwIGFuZCBjaGFubmVsIGFs
bG9jDQo+IA0KPiAgIGRyaXZlcnMvZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3Jt
LmMgfCAxMyArKysrKysrKystLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gDQoNCkhpLA0KDQpHZW50bGUgZm9sbG93LXVwIG9uIHYyIG9m
IHRoaXMgZHctYXhpLWRtYWMgc2VyaWVzICgyNSBNYXkpLCB3aGljaCBhZGRzDQpzeXN0ZW0tc2xl
ZXAgUE0gYW5kIGNoYW5uZWwtYWxsb2NhdGlvbiBmaXhlcyBwZXIgU2FzaGlrbydzIHJldmlldy4N
Cg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIGFueXRoaW5nIGVsc2UgaXMgbmVlZGVkIGJlZm9yZSB0
aGlzIGNhbiBtb3ZlIGZvcndhcmQuDQoNClRoYW5rcywNClR6ZSBZZWUNCg==

