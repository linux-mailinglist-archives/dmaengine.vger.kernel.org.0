Return-Path: <dmaengine+bounces-8503-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFhfNepZd2maeQEAu9opvQ
	(envelope-from <dmaengine+bounces-8503-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 13:11:22 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195E880DB
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 13:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44FAC304E739
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2377334C3B;
	Mon, 26 Jan 2026 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ITMcROD+"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010052.outbound.protection.outlook.com [52.101.229.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC6335064;
	Mon, 26 Jan 2026 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429425; cv=fail; b=Gm8GNZAOCXmvKvMynG1CFAD25XqQNEd9GsJ6wKNlFhOevL9ho4/RTzyKKDp30pn2XYXM7dSz6U5hQaaFKqGccewUN2HNVsmca34o/NOSUejVm3DbcbqZ0ZS3qMk5g54Gow63tAfbjIb4PLQ+vWOxXe4w9lAF+9Lz5+nCB6zOmjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429425; c=relaxed/simple;
	bh=yES4G5EydFs3g8WjZFq9emyhmXfd93r0h4f56sJYMR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QPKl9O7kvu0V9hzvx7u41ujO49Fe4Yg+deOsTzq7B15pV24eHQOvmqiezrh9YpC/ntpHpSntIm+pShOiWBQsLdv+zA1+K2RSTv9hZV395sWu9ZzWy/GeoNGzWBdCObNLnpt3jlfVntgZHakI597XdhcjlXXf8JKRGU6x1gmz7E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ITMcROD+; arc=fail smtp.client-ip=52.101.229.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/A39/8oBo/AY+Vx7eprdKlveXVJ7ygoD2eBfBwVtedo9+nShZD+aCr8j9KwitkUaTk8nJXazPmg7tL2s2UBTmCjH5tEmtEgfJdFM7dLwGJjGM6eWNFv/KogMt9tV7Gv599QV0hh2JPAFc08eV2Ja6xnCUSees0pTYw8KCoyBt0MZ2WDLepFyppAqqdhw4oe6YzDOrylOkTWgAF3s7UHbH8dPVxlGkXILRHZclMm4HknEnSLGzqv6/QfnvxRIbffgOrwURPTNmCT9SycVeB8VOpwUt+aU1+I8kNHiumY5jitlerjb4fyyBqt0X68fi61eqiBGwXFnHgCJ/fV95Wtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yES4G5EydFs3g8WjZFq9emyhmXfd93r0h4f56sJYMR4=;
 b=w7v/YvqUcLqPLfsDBrae3W7wTanXYTaD2riS3LJdja03cwBFRfxPN0tgGlfn3FPPhj37BFTvmLb2Vj4NuvHyF27zdzrhiLCLWT9Hgd8BOdYiHrmaduVj/UwH7RBb+wVFCBwvyQ6NEe7hFsERPsRB/JMFMaAbcEG3MmWhs7dxvArH2kEt9KUuBRpGRZpsZ16XjhEeWL3AWSraqUnnkQTaWrl4y037mp1x+46Ps7QQmnbYOGBnCIuMchFVWlglkQIdQKgSggxOlNmQ/GIh9w1AkKGGEKz3f+BHxuOLNcDsWHB5gAbj3e5hpA7eR1BwwV3ImNLZy6Y5+PgU7m6JHo8/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yES4G5EydFs3g8WjZFq9emyhmXfd93r0h4f56sJYMR4=;
 b=ITMcROD+szjtp8QGWM9fHCFb6BH88ALz42/BJk4qIg0gZwhbuUSQ/RPXKrb5aXqFMX64C+qJnEUbZ5Lv6FTeGnC+pYZYgUxsjnL0jL+7oul664CM/JxLblJ60bUyExFR6PRIvov+IGecWzo+KwdMP+JLQSazVQZy1o0ieRtzF4Y=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS9PR01MB14271.jpnprd01.prod.outlook.com (2603:1096:604:35f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 12:10:17 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 12:10:17 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "vkoul@kernel.org"
	<vkoul@kernel.org>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Topic: [PATCH 5/7] dmaengine: sh: rz-dmac: Add suspend to RAM support
Thread-Index: AQHcjq8LxgsLnLJrc0+4TWo3c3gckrVkQ4/QgAAW+wCAAAEtcA==
Date: Mon, 26 Jan 2026 12:10:17 +0000
Message-ID:
 <TY3PR01MB113463BE8A4B1A40DBB0860538693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
 <20260126103155.2644586-6-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113461F734BA087B60605C6FC8693A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
In-Reply-To: <16a6f14a-93e6-472c-8718-d46972f0ac5e@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS9PR01MB14271:EE_
x-ms-office365-filtering-correlation-id: d28ee50d-de77-45bb-dc16-08de5cd3de74
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RzdPekxaMWJLL2p6NXoxeHh2VFN4VXk1cDNsc3JXUWtncGJzVTBXSnZVU0U2?=
 =?utf-8?B?TkprdCtiYUhVSzVEbkh0YjBZOUhwSkJSU3NTeHlGSkxIQjQvNW5sT2JvRTZm?=
 =?utf-8?B?TERURDlsSjVOOUZSaHpaWm9xYmtTRWlZVXA2MkNXSTkxNzk1cmpuRnFqVGZu?=
 =?utf-8?B?SG5QdXFOU2MxbTZHR3hoc0ZKT2FtTnNHTHNwVTdzRWNWU3Y0WkNSR2owNkhM?=
 =?utf-8?B?QkpTRjU5UjU3cWkrY293eFZLS09TV3NTVmJiWDdyWElFUHVQOWMyMm55OVdZ?=
 =?utf-8?B?WXI3UGE5K2V1bmduRjNDQVZmdTh2dHlEOWNGenFacXBlN0hUcTFTUFZCOE5l?=
 =?utf-8?B?OGF0Qnd6QjFZL21OQlVCbkt3djZ2czhmb3R3SUEza3lSS1VMb2VXMGpXOUVS?=
 =?utf-8?B?VmFYSzNTUkFrN21WL1JQdE5SWWRWdWxmcHQ4dlhvOGh6VGNqeml2RU9mcDF4?=
 =?utf-8?B?dk5mZk91eVZ0VGxGdFMzSWNhaW9FRzBwTVMwckdXRHMvRnBzYm92cXNWTEl1?=
 =?utf-8?B?SWoyalRtTUtjUUk3WmZJeGNuNnk2ZE94K2pHUmZqODhrRTJOSE5mdWs2SWJZ?=
 =?utf-8?B?SkRWZi9HdzhTYlBVU2I3aEdYa2N5T0QxamxET1NVd2dOMWhBMGdVVFlranNQ?=
 =?utf-8?B?cW9Td2JTLzNrTVgwa09NT2UrOENCaVRMMG1IVkYvampYakRFWTRmWWIvZjV1?=
 =?utf-8?B?cjVIaGhoTFlFbjdCa0pnQXozMm4vUlRZdlM2MndER1BsYVhaQzgrZXlMSUor?=
 =?utf-8?B?WmFHai82TnN1UGNFZXo3SnViT3NJWTRabXdUMHA4Vm1yR3hXZStlODNjalM3?=
 =?utf-8?B?aWpQTWlKNEw4M2FXSU1FeXlmVnJPaEthZitxdmp6bzBLR2JXQ0ZkblZsWHlE?=
 =?utf-8?B?Q1hDbE9jbUEwK2ttKzd5SGR4ZDJqWWJSelFtUElCRjhiNTh0ZXZNcmRDd1Y0?=
 =?utf-8?B?cGFpbmVVa1lUZkJLYUZwalB2SHo2alRtcFVSVGp3T2NnUnFGdU1RaHpSV1U3?=
 =?utf-8?B?dXVpWGhVazF3UWdYMnlFRHdoYzVwL3pESmF1UWNkU3pXTU8zRVYyRmI1ZEhU?=
 =?utf-8?B?MTc0SW4rdjhJcTAzUUJ4MG8vNkJDby85dGpHbVB3dnkrTmVHMktybHJLYnVh?=
 =?utf-8?B?RHF1dk1lemdXSmZrZXp4RXBHWEh1Y29OTWNTaVFPTm5vRGFWNUxUZG1TcGRF?=
 =?utf-8?B?L09YOHJCUW9ObHhraWNwUStGTm9YaUR5YmxzUFdLT25wbnVtTmdVVS80aEV3?=
 =?utf-8?B?R0dBYWlvcG1pUDdlcTg1b2VXTGszdHJnWWhSaWVTOTBzTzdSbUlRRmFtdE4x?=
 =?utf-8?B?bnFvbW9qT0ZjSWJGajBFOVJnK3RQbHIyWFJJZGVwWko0clFWb0lwbGhRdXhr?=
 =?utf-8?B?S3pLTHVMbGFXT2E3b09LNnc5Qm5NeXduL0IvZFdTRUhEdy9pbzRNeTQ1WlVy?=
 =?utf-8?B?ejBpd1NORHZLWnNQVUFQRnBKc0lKSkxiT1F5dXpRVkNsS09PQ2FQb3poVjVo?=
 =?utf-8?B?VlJWY3NyNmRDeHMxUHdYaXE4c2xGbTFzNG9CeTNSTllneDdTWTVLMDhNaGdC?=
 =?utf-8?B?a0oya3JBSzlzc1NERVlLakc5cTl2aHlpOSttdEtuejN3UHROMVoxME5qU3hw?=
 =?utf-8?B?LytJbW9FanJYRFJ2SVNIWmcrNkdDZ09oVC9ONUs5RjdQbUh6NXdTSm14YVA5?=
 =?utf-8?B?Qy9RclRzWXB3UzA1cENTcEdJd0JIT3lIU21vUzhnQnRNWndBUktRVDViaHRi?=
 =?utf-8?B?S0Q4QUN4dzRBOFBPZmpIUGhGNDZzYVdhaUxJQjVvejJ6eG04MTYxdnp5SU5v?=
 =?utf-8?B?dFBLS3diUlNEYWhuUi9yTHE0Z3l5Q0JRTS9vMjJ2RXVhNEJZYkltUWMxQVdF?=
 =?utf-8?B?eHIwY2hFWll4ajRWUUVlZjZKR3Q1ZzVHY01UaG5rY3duUGt6TlR4NHFwdk9u?=
 =?utf-8?B?dWdkWXlaN1p3cTE2enB6MFJKVjJLMDE3UUR3RUZYOW1mNmVDTGJNWmxneDNz?=
 =?utf-8?B?UW95bmpOcHArbWR1ZlFGMW9IZmhIOGJYajdsVGtRU2xWNTYyeTdFYjVITmcy?=
 =?utf-8?B?eDllQTVWWFNZRzJtMXlNbU5VMERabFJPaVNHa2x6dzlDM2treXhvUnVtWWVj?=
 =?utf-8?B?RFdjd2kzMkFSV2lEWkVxZDBqU2M2REcrU0h3WU5lZjZSbmhqcXdnRFdwM1pQ?=
 =?utf-8?Q?psraJIjuOMTcqwg881pMgZHpavPLewhdkN0Ja7XJi736?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm1LUnJ5bWlUL1ZJVEVXcXB5ZjZJWG5yQjIvTzdxUHM2MklFbW9URDdVZENi?=
 =?utf-8?B?R3pVRnJiZlBNbzA4RmpLT0NZR1FhQzZHc1pnL0ppdC9lUVhmL2FTcXR5c0t1?=
 =?utf-8?B?d2t0VmlLREtuMng1VUgzbjBUdzhzbExmVHlQOUl4Mk1lZmxxbDFmZ3BUWE1y?=
 =?utf-8?B?eFJmNTJMK0kwNnViOTZpaGt3bXlxZ1d1S2J0NjA4TjJCdVJISDEyaExYOFlS?=
 =?utf-8?B?Uys0TFBYYUN6ejN1K0RmQXJRb0R2VThnNzU4VEhqOTZxOGNGNjRrUS85MFJJ?=
 =?utf-8?B?clFMVFRnYUhESGxNcmJlbVNlRUVWbFBYdGVSUHFyclRjbXI4Wk43WkRVOW9B?=
 =?utf-8?B?S3kzNEFQUmx2ZUYzNHZnTWVJbC9iZmNvVDRTOHJhTWJueW5GSytpOU14aGZM?=
 =?utf-8?B?NzdFQWhGQ290TWNPNGtYV05ESnFnUkJ3Z2pUaEZ2ckVWRXZucCtNbjRDOUR1?=
 =?utf-8?B?cnk1ZjBNWnMzVTdNdVYrUDc0TlRFaktGWTJ6elR3ajBJVXZOdjZGRnFWV05X?=
 =?utf-8?B?b1FiOFJxaStLWFh4TzlGcXE2b2xOWGxKL1FVY1pRQ2hqemJxVTFCaW5wWi9v?=
 =?utf-8?B?Wk5zRkljUHBoeXE3NmxtMU9nR1gyS2Y5WWFvencyWXJ4TVV0M0NKNVdnMWRx?=
 =?utf-8?B?NjhOUWw3Sm52biswUHQ5T3VmMldtSkM3R1FxL2hrLytvc01ZVFdqeTVkV1RZ?=
 =?utf-8?B?ekZleEM2WW82eHFQbi9OcFZNMEZaUkNsa0JsTmVQWk5YUHhBWk10Y0pJWDdn?=
 =?utf-8?B?MkFFYkMxUm5wdStuTkFZb3dhRE84VWVUSEUxeWVmMmpCcVFQWmNDWmI0K2sv?=
 =?utf-8?B?OEplNEFMSmZIeWJXNkd4bC9NQ3BxRmlvd01DYlQ4ZjE3cmxreDFUeTBSZ2p2?=
 =?utf-8?B?VEVWRW9aQWRvUUFiZTkxbkRFR0pnMVBHak5YbHAzUWxxc0dvbklMODNuSVlQ?=
 =?utf-8?B?NStNODRHQkFUSEN6cGpoTWo5aEQvNG1nUEpUR0g0MVprOW1Rc2pjandYd2ZN?=
 =?utf-8?B?MmFKRWppZnFYM2V0VFN4VkwwcUhPL0djQjcvTWNMQVlyVkt6d2w5QmY3VVRE?=
 =?utf-8?B?L0hud3NIWkVrSDR3YitJWWxFYW1ramRibnVveGNmNmNGZHpyMkpDclhaNFBY?=
 =?utf-8?B?OWxOZlBlZ0gzMEtuWlJjdHdMaVJwZExuaU1FMW5NWnJNT0xLc2JtR0d3elB2?=
 =?utf-8?B?Z3o4YWdjWHJQa1JDK2VRbE9iNmpQVmdtOEkva2FFaWZTbDlnMXV6OU83ejZ6?=
 =?utf-8?B?blBEcTh3TXZkK2puVlRpOGNVWDhzQk1kanpJS2VRWGpIZHZJQ2U5dXI3S3k1?=
 =?utf-8?B?M1BqUE9qN3hnZmhTYXZsWmlLYWdyTnNvaEdvWTFiRE9TYitwR0RRNVlZUU83?=
 =?utf-8?B?VFFWWks5TjlvWEt4WEpMWFdhbllmSFNSYlFqci90Sm9TYSthWE9Jc3FrdXVZ?=
 =?utf-8?B?S2JKTllBaUgwMnVETndPcEZ4cEc5VHhhaUM4dlNVWjA5a3hkbitkK25Uci85?=
 =?utf-8?B?RHdreXBORGVHK0czdjZFZGNxWDhLN3pPSEE0bXRxS054cStEYXVER2U3eXZU?=
 =?utf-8?B?Z21IdlRseitlRjVwRC9GM0lDaGJZZmlsalV5MUpNalFCaVByTlZpWjUxem9s?=
 =?utf-8?B?K29LYnBmd3VLK0FxY0F4ajdPUU1KYjlmd2p0OHphdlROT2FyVTJLVVlFaDJO?=
 =?utf-8?B?RXM2TUNOSXVZamFzd1JITkpTaG9SRjdUUC84WHdXSUdsZjNyR29Fekp2Y3Zn?=
 =?utf-8?B?YkF4aTdDNjAwQjFnRElUN0grZXVZUXVUeFRoZHdmUE4xeEVvZURxRHFqNFdQ?=
 =?utf-8?B?MWZaSjhsL1V5ay9pQ3dVQjlHTU9ocXcxTUZ4eWhBTXRBUjNwaG9KWXpMTEJj?=
 =?utf-8?B?Ym5ncm5FeU84ay9sYU1hdTZqNjF5ZTVLc0hjY1ZFZ3N2eWNBWURJTGZvM29N?=
 =?utf-8?B?amJwcDAzTDZTQU9WeFRwdVJ1ZEszcVhHQU92L1JvSTdyVDg5ZFRhT20xbUps?=
 =?utf-8?B?QXpBK3JkM05odGp2WmtMWTZBM3M4SkNrQ2JmaUF6T1VkbnBjaFdTcnpJWWpB?=
 =?utf-8?B?TEE4OURpS3lsMjhqMlR5TllzV2tzVy9TQWkrd045N2FIY1IxbXRsNGovanBS?=
 =?utf-8?B?ZWFWeHBlMUlOTnhaNzNsMDNKSjUzZzJ4SmVqK0JTQ1ZTUGNBVW9FTkk4Z1hD?=
 =?utf-8?B?enZxVHV5V2s5Y2VCOXZEVW83L2pDcEZzRlZ4V0ZpRDBrR0h5MzRrZEE4cTVI?=
 =?utf-8?B?OWlNODQyMWQwZGVhZ3pqVzc2RmlpUFAwWDRqN3dmNndEcGk3Zk5zeTFGd2Ro?=
 =?utf-8?B?VlU1dWFhTDZPc2Y4TW5SREVUbGtTbGtGTHRncGJNbjJZeDJmeE5mQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28ee50d-de77-45bb-dc16-08de5cd3de74
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 12:10:17.3112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mS1wUOQfngQFKR/7FnsRG4Kca+RHyYftwB6251W4IACPtDXAHg5Bh98ltUBS2sT7du/fR+/VhoBgBzMRDHajcGEsx0NV4ZeVaB0ggbjR8r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14271
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-8503-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[tuxon.dev,kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[biju.das.jz@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,pengutronix.de:email,bp.renesas.com:dkim,TY3PR01MB11346.jpnprd01.prod.outlook.com:mid,tuxon.dev:email,renesas.com:email,perex.cz:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8195E880DB
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEg
PGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogMjYgSmFudWFyeSAyMDI2IDEyOjA1
DQo+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+OyB2a291bEBrZXJu
ZWwub3JnOyBQcmFiaGFrYXIgTWFoYWRldiBMYWQgPHByYWJoYWthci5tYWhhZGV2LQ0KPiBsYWQu
cmpAYnAucmVuZXNhcy5jb20+OyBsZ2lyZHdvb2RAZ21haWwuY29tOyBicm9vbmllQGtlcm5lbC5v
cmc7IHBlcmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbTsNCj4gcC56YWJlbEBwZW5ndXRyb25p
eC5kZTsgZ2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU7IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8u
Y2FzdHJvLmp6QHJlbmVzYXMuY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4gcmVuZXNhcy1zb2NAdmdlci5rZXJuZWwub3JnOyBDbGF1ZGl1IEJlem5lYSA8
Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
NS83XSBkbWFlbmdpbmU6IHNoOiByei1kbWFjOiBBZGQgc3VzcGVuZCB0byBSQU0gc3VwcG9ydA0K
PiANCj4gSGksDQo+IA0KPiBPbiAxLzI2LzI2IDEzOjAzLCBCaWp1IERhcyB3cm90ZToNCj4gPiBI
aSBDbGF1ZGl1LA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+ID4NCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpu
ZWFAdHV4b24uZGV2Pg0KPiA+PiBTZW50OiAyNiBKYW51YXJ5IDIwMjYgMTA6MzINCj4gPj4gU3Vi
amVjdDogW1BBVENIIDUvN10gZG1hZW5naW5lOiBzaDogcnotZG1hYzogQWRkIHN1c3BlbmQgdG8g
UkFNDQo+ID4+IHN1cHBvcnQNCj4gPj4NCj4gPj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVk
aXUuYmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pg0KPiA+PiBUaGUgUmVuZXNhcyBSWi9H
M1MgU29DIHN1cHBvcnRzIGEgcG93ZXIgc2F2aW5nIG1vZGUgaW4gd2hpY2ggcG93ZXIgdG8NCj4g
Pj4gbW9zdCBTb0MgY29tcG9uZW50cyBpcyB0dXJuZWQgb2ZmLCBpbmNsdWRpbmcgdGhlIERNQSBJ
UC4gQWRkIHN1c3BlbmQgdG8gUkFNIHN1cHBvcnQgdG8gc2F2ZSBhbmQNCj4gcmVzdG9yZSB0aGUg
RE1BIElQIHJlZ2lzdGVycy4NCj4gPj4NCj4gPj4gQ3ljbGljIERNQSBjaGFubmVscyByZXF1aXJl
IHNwZWNpYWwgaGFuZGxpbmcuIFNpbmNlIHRoZXkgY2FuIGJlDQo+ID4+IHBhdXNlZCBhbmQgcmVz
dW1lZCBkdXJpbmcgc3lzdGVtIHN1c3BlbmQgYW5kIHJlc3VtZSwgdGhlIGRyaXZlcg0KPiA+PiBy
ZXN0b3JlcyBhZGRpdGlvbmFsIHJlZ2lzdGVycyBmb3IgdGhlc2UgY2hhbm5lbHMgZHVyaW5nIHRo
ZSByZXN1bWUNCj4gPj4gcGhhc2UuIElmIGEgY2hhbm5lbCB3YXMgbm90IGV4cGxpY2l0bHkgcGF1
c2VkIGR1cmluZyBzdXNwZW5kLCB0aGUNCj4gPj4gZHJpdmVyIGVuc3VyZXMgdGhhdCBpdCBpcyBw
YXVzZWQgYW5kIHJlc3VtZWQgYXMgcGFydCBvZiB0aGUgc3lzdGVtIHN1c3BlbmQvcmVzdW1lIGZs
b3cuIFRoaXMgbWlnaHQNCj4gYmUgdGhlIGNhc2Ugb2YgYSBzZXJpYWwgZGV2aWNlIGJlaW5nIHVz
ZWQgd2l0aCBub19jb25zb2xlX3N1c3BlbmQuDQo+ID4+DQo+ID4+IEZvciBub24tY3ljbGljIGNo
YW5uZWxzLCB0aGUgZGV2X3BtX29wczo6cHJlcGFyZSBjYWxsYmFjayB3YWl0cyBmb3INCj4gPj4g
YWxsIG9uZ29pbmcgdHJhbnNmZXJzIHRvIGNvbXBsZXRlIGJlZm9yZSBhbGxvd2luZyBzdXNwZW5k
LXRvLVJBTSB0byBwcm9jZWVkLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJl
em5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+IC0tLQ0KPiA+PiAg
IGRyaXZlcnMvZG1hL3NoL3J6LWRtYWMuYyB8IDE4MyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMTc1IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9zaC9y
ei1kbWFjLmMgYi9kcml2ZXJzL2RtYS9zaC9yei1kbWFjLmMNCj4gPj4gaW5kZXggYWI1ZjQ5YTBi
OWYyLi44ZjNlMjcxOWU2MzkNCj4gPj4gMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvZG1hL3No
L3J6LWRtYWMuYw0KPiA+PiArKysgYi9kcml2ZXJzL2RtYS9zaC9yei1kbWFjLmMNCj4gPj4gQEAg
LTY5LDExICs2OSwxNSBAQCBzdHJ1Y3QgcnpfZG1hY19kZXNjIHsNCj4gPj4gICAgKiBlbnVtIHJ6
X2RtYWNfY2hhbl9zdGF0dXM6IFJaIERNQUMgY2hhbm5lbCBzdGF0dXMNCj4gPj4gICAgKiBAUlpf
RE1BQ19DSEFOX1NUQVRVU19FTkFCTEVEOiBDaGFubmVsIGlzIGVuYWJsZWQNCj4gPj4gICAgKiBA
UlpfRE1BQ19DSEFOX1NUQVRVU19QQVVTRUQ6IENoYW5uZWwgaXMgcGF1c2VkIHRob3VnaCBETUEg
ZW5naW5lDQo+ID4+IGNhbGxiYWNrcw0KPiA+PiArICogQFJaX0RNQUNfQ0hBTl9TVEFUVVNfUEFV
U0VEX0lOVEVSTkFMOiBDaGFubmVsIGlzIHBhdXNlZCB0aHJvdWdoDQo+ID4+ICsgZHJpdmVyIGlu
dGVybmFsIGxvZ2ljDQo+ID4+ICsgKiBAUlpfRE1BQ19DSEFOX1NUQVRVU19TWVNfU1VTUEVOREVE
OiBDaGFubmVsIHdhcyBwcmVwYXJlZCBmb3INCj4gPj4gKyBzeXN0ZW0gc3VzcGVuZA0KPiA+PiAg
ICAqIEBSWl9ETUFDX0NIQU5fU1RBVFVTX0NZQ0xJQzogQ2hhbm5lbCBpcyBjeWNsaWMNCj4gPj4g
ICAgKi8NCj4gPj4gICBlbnVtIHJ6X2RtYWNfY2hhbl9zdGF0dXMgew0KPiA+PiAgIAlSWl9ETUFD
X0NIQU5fU1RBVFVTX0VOQUJMRUQsDQo+ID4+ICAgCVJaX0RNQUNfQ0hBTl9TVEFUVVNfUEFVU0VE
LA0KPiA+PiArCVJaX0RNQUNfQ0hBTl9TVEFUVVNfUEFVU0VEX0lOVEVSTkFMLA0KPiA+PiArCVJa
X0RNQUNfQ0hBTl9TVEFUVVNfU1lTX1NVU1BFTkRFRCwNCj4gPj4gICAJUlpfRE1BQ19DSEFOX1NU
QVRVU19DWUNMSUMsDQo+ID4+ICAgfTsNCj4gPj4NCj4gPj4gQEAgLTk0LDYgKzk4LDEwIEBAIHN0
cnVjdCByel9kbWFjX2NoYW4gew0KPiA+PiAgIAl1MzIgY2hjdHJsOw0KPiA+PiAgIAlpbnQgbWlk
X3JpZDsNCj4gPj4NCj4gPj4gKwlzdHJ1Y3Qgew0KPiA+PiArCQl1MzIgbnhsYTsNCj4gPj4gKwl9
IHBtX3N0YXRlOw0KPiA+PiArDQo+ID4+ICAgCXN0cnVjdCBsaXN0X2hlYWQgbGRfZnJlZTsNCj4g
Pj4gICAJc3RydWN0IGxpc3RfaGVhZCBsZF9xdWV1ZTsNCj4gPj4gICAJc3RydWN0IGxpc3RfaGVh
ZCBsZF9hY3RpdmU7DQo+ID4+IEBAIC0xMDAyLDEwICsxMDEwLDE3IEBAIHN0YXRpYyBpbnQgcnpf
ZG1hY19kZXZpY2VfcGF1c2Uoc3RydWN0IGRtYV9jaGFuICpjaGFuKQ0KPiA+PiAgIAlyZXR1cm4g
cnpfZG1hY19kZXZpY2VfcGF1c2Vfc2V0KGNoYW5uZWwsDQo+ID4+IFJaX0RNQUNfQ0hBTl9TVEFU
VVNfUEFVU0VEKTsgIH0NCj4gPj4NCj4gPj4gK3N0YXRpYyBpbnQgcnpfZG1hY19kZXZpY2VfcGF1
c2VfaW50ZXJuYWwoc3RydWN0IHJ6X2RtYWNfY2hhbg0KPiA+PiArKmNoYW5uZWwpIHsNCj4gPj4g
Kwlsb2NrZGVwX2Fzc2VydF9oZWxkKCZjaGFubmVsLT52Yy5sb2NrKTsNCj4gPj4gKw0KPiA+PiAr
CXJldHVybiByel9kbWFjX2RldmljZV9wYXVzZV9zZXQoY2hhbm5lbCwNCj4gPj4gK1JaX0RNQUNf
Q0hBTl9TVEFUVVNfUEFVU0VEX0lOVEVSTkFMKTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiAgIHN0
YXRpYyBpbnQgcnpfZG1hY19kZXZpY2VfcmVzdW1lX3NldChzdHJ1Y3QgcnpfZG1hY19jaGFuICpj
aGFubmVsLA0KPiA+PiAgIAkJCQkgICAgIGVudW0gcnpfZG1hY19jaGFuX3N0YXR1cyBzdGF0dXMp
ICB7DQo+ID4+IC0JdTMyIHZhbDsNCj4gPj4gKwl1MzIgdmFsLCBjaGN0cmw7DQo+ID4+ICAgCWlu
dCByZXQ7DQo+ID4+DQo+ID4+ICAgCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJmNoYW5uZWwtPnZjLmxv
Y2spOw0KPiA+PiBAQCAtMTAxMywxNCArMTAyOCwzMyBAQCBzdGF0aWMgaW50IHJ6X2RtYWNfZGV2
aWNlX3Jlc3VtZV9zZXQoc3RydWN0IHJ6X2RtYWNfY2hhbiAqY2hhbm5lbCwNCj4gPj4gICAJaWYg
KCEoY2hhbm5lbC0+c3RhdHVzICYgQklUKFJaX0RNQUNfQ0hBTl9TVEFUVVNfUEFVU0VEKSkpDQo+
ID4+ICAgCQlyZXR1cm4gMDsNCj4gPj4NCj4gPj4gLQlyel9kbWFjX2NoX3dyaXRlbChjaGFubmVs
LCBDSENUUkxfQ0xSU1VTLCBDSENUUkwsIDEpOw0KPiA+PiAtCXJldCA9IHJlYWRfcG9sbF90aW1l
b3V0X2F0b21pYyhyel9kbWFjX2NoX3JlYWRsLCB2YWwsDQo+ID4+IC0JCQkJICAgICAgICEodmFs
ICYgQ0hTVEFUX1NVUyksIDEsIDEwMjQsIGZhbHNlLA0KPiA+PiAtCQkJCSAgICAgICBjaGFubmVs
LCBDSFNUQVQsIDEpOw0KPiA+PiAtCWlmIChyZXQpDQo+ID4+IC0JCXJldHVybiByZXQ7DQo+ID4+
ICsJaWYgKGNoYW5uZWwtPnN0YXR1cyAmIEJJVChSWl9ETUFDX0NIQU5fU1RBVFVTX1NZU19TVVNQ
RU5ERUQpKSB7DQo+ID4+ICsJCS8qDQo+ID4+ICsJCSAqIFdlIGNhbiBiZSBhZnRlciBhIHNsZWVw
IHN0YXRlIHdpdGggcG93ZXIgbG9zcy4gSWYgcG93ZXIgd2FzDQo+ID4+ICsJCSAqIGxvc3QsIHRo
ZSBDSFNUQVRfU1VTIGJpdCBpcyB6ZXJvLiBJbiB0aGlzIGNhc2UsIHdlIG5lZWQgdG8NCj4gPj4g
KwkJICogZW5hYmxlIHRoZSBjaGFubmVsIGRpcmVjdGx5LiBPdGhlcndpc2UsIGp1c3Qgc2V0IHRo
ZSBDTFJTVVMNCj4gPj4gKwkJICogYml0Lg0KPiA+PiArCQkgKi8NCj4gPj4gKwkJdmFsID0gcnpf
ZG1hY19jaF9yZWFkbChjaGFubmVsLCBDSFNUQVQsIDEpOw0KPiA+PiArCQlpZiAodmFsICYgQ0hT
VEFUX1NVUykNCj4gPj4gKwkJCWNoY3RybCA9IENIQ1RSTF9DTFJTVVM7DQo+ID4+ICsJCWVsc2UN
Cj4gPj4gKwkJCWNoY3RybCA9IENIQ1RSTF9TRVRFTjsNCj4gPj4gKwl9IGVsc2Ugew0KPiA+PiAr
CQljaGN0cmwgPSBDSENUUkxfQ0xSU1VTOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCXJ6X2Rt
YWNfY2hfd3JpdGVsKGNoYW5uZWwsIGNoY3RybCwgQ0hDVFJMLCAxKTsNCj4gPj4NCj4gPj4gLQlj
aGFubmVsLT5zdGF0dXMgJj0gfkJJVChzdGF0dXMpOw0KPiA+PiArCWlmIChjaGN0cmwgJiBDSENU
UkxfQ0xSU1VTKSB7DQo+ID4+ICsJCXJldCA9IHJlYWRfcG9sbF90aW1lb3V0X2F0b21pYyhyel9k
bWFjX2NoX3JlYWRsLCB2YWwsDQo+ID4+ICsJCQkJCSAgICAgICAhKHZhbCAmIENIU1RBVF9TVVMp
LCAxLCAxMDI0LCBmYWxzZSwNCj4gPj4gKwkJCQkJICAgICAgIGNoYW5uZWwsIENIU1RBVCwgMSk7
DQo+ID4+ICsJCWlmIChyZXQpDQo+ID4+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+PiArCX0NCj4gPj4g
Kw0KPiA+PiArCWNoYW5uZWwtPnN0YXR1cyAmPSB+KEJJVChzdGF0dXMpIHwNCj4gPj4gK0JJVChS
Wl9ETUFDX0NIQU5fU1RBVFVTX1NZU19TVVNQRU5ERUQpKTsNCj4gPj4NCj4gPj4gICAJcmV0dXJu
IDA7DQo+ID4+ICAgfQ0KPiA+PiBAQCAtMTAzNCw2ICsxMDY4LDEzIEBAIHN0YXRpYyBpbnQgcnpf
ZG1hY19kZXZpY2VfcmVzdW1lKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikNCj4gPj4gICAJcmV0dXJu
IHJ6X2RtYWNfZGV2aWNlX3Jlc3VtZV9zZXQoY2hhbm5lbCwNCj4gPj4gUlpfRE1BQ19DSEFOX1NU
QVRVU19QQVVTRUQpOyAgfQ0KPiA+Pg0KPiA+PiArc3RhdGljIGludCByel9kbWFjX2RldmljZV9y
ZXN1bWVfaW50ZXJuYWwoc3RydWN0IHJ6X2RtYWNfY2hhbg0KPiA+PiArKmNoYW5uZWwpIHsNCj4g
Pj4gKwlsb2NrZGVwX2Fzc2VydF9oZWxkKCZjaGFubmVsLT52Yy5sb2NrKTsNCj4gPj4gKw0KPiA+
PiArCXJldHVybiByel9kbWFjX2RldmljZV9yZXN1bWVfc2V0KGNoYW5uZWwsDQo+ID4+ICtSWl9E
TUFDX0NIQU5fU1RBVFVTX1BBVVNFRF9JTlRFUk5BTCk7DQo+ID4+ICt9DQo+ID4+ICsNCj4gPj4g
ICAvKg0KPiA+PiAgICAqIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+ICAgICogSVJRIGhhbmRs
aW5nDQo+ID4+IEBAIC0xNDM4LDYgKzE0NzksMTMxIEBAIHN0YXRpYyB2b2lkIHJ6X2RtYWNfcmVt
b3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4+ICAgCXBtX3J1bnRpbWVfZGlz
YWJsZSgmcGRldi0+ZGV2KTsNCj4gPj4gICB9DQo+ID4+DQo+ID4+ICtzdGF0aWMgaW50IHJ6X2Rt
YWNfc3VzcGVuZF9wcmVwYXJlKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+PiArCXN0cnVjdCBy
el9kbWFjICpkbWFjID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4+ICsNCj4gPj4gKwlmb3Ig
KHVuc2lnbmVkIGludCBpID0gMDsgaSA8IGRtYWMtPm5fY2hhbm5lbHM7IGkrKykgew0KPiA+PiAr
CQlzdHJ1Y3QgcnpfZG1hY19jaGFuICpjaGFubmVsID0gJmRtYWMtPmNoYW5uZWxzW2ldOw0KPiA+
PiArDQo+ID4+ICsJCWd1YXJkKHNwaW5sb2NrX2lycXNhdmUpKCZjaGFubmVsLT52Yy5sb2NrKTsN
Cj4gPj4gKw0KPiA+PiArCQkvKiBXYWl0IGZvciB0cmFuc2ZlciBjb21wbGV0aW9uLCBleGNlcHQg
aW4gY3ljbGljIGNhc2UuICovDQo+ID4+ICsJCWlmIChjaGFubmVsLT5zdGF0dXMgJiBCSVQoUlpf
RE1BQ19DSEFOX1NUQVRVU19FTkFCTEVEKSAmJg0KPiA+PiArCQkgICAgIShjaGFubmVsLT5zdGF0
dXMgJiBCSVQoUlpfRE1BQ19DSEFOX1NUQVRVU19DWUNMSUMpKSkNCj4gPj4gKwkJCXJldHVybiAt
RUFHQUlOOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCXJldHVybiAwOw0KPiA+PiArfQ0KPiA+
PiArDQo+ID4+ICtzdGF0aWMgdm9pZCByel9kbWFjX3N1c3BlbmRfcmVjb3ZlcihzdHJ1Y3Qgcnpf
ZG1hYyAqZG1hYykgew0KPiA+PiArCWZvciAodW5zaWduZWQgaW50IGkgPSAwOyBpIDwgZG1hYy0+
bl9jaGFubmVsczsgaSsrKSB7DQo+ID4+ICsJCXN0cnVjdCByel9kbWFjX2NoYW4gKmNoYW5uZWwg
PSAmZG1hYy0+Y2hhbm5lbHNbaV07DQo+ID4+ICsNCj4gPj4gKwkJZ3VhcmQoc3BpbmxvY2tfaXJx
c2F2ZSkoJmNoYW5uZWwtPnZjLmxvY2spOw0KPiA+PiArDQo+ID4+ICsJCWlmICghKGNoYW5uZWwt
PnN0YXR1cyAmIEJJVChSWl9ETUFDX0NIQU5fU1RBVFVTX0NZQ0xJQykpKQ0KPiA+PiArCQkJY29u
dGludWU7DQo+ID4+ICsNCj4gPj4gKwkJaWYgKCEoY2hhbm5lbC0+c3RhdHVzICYgQklUKFJaX0RN
QUNfQ0hBTl9TVEFUVVNfUEFVU0VEX0lOVEVSTkFMKSkpDQo+ID4+ICsJCQljb250aW51ZTsNCj4g
Pj4gKw0KPiA+PiArCQlyel9kbWFjX2RldmljZV9yZXN1bWVfaW50ZXJuYWwoY2hhbm5lbCk7DQo+
ID4+ICsJfQ0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW50IHJ6X2RtYWNfc3VzcGVu
ZChzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPj4gKwlzdHJ1Y3QgcnpfZG1hYyAqZG1hYyA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+PiArCWludCByZXQ7DQo+ID4+ICsNCj4gPj4gKwlmb3Ig
KHVuc2lnbmVkIGludCBpID0gMDsgaSA8IGRtYWMtPm5fY2hhbm5lbHM7IGkrKykgew0KPiA+PiAr
CQlzdHJ1Y3QgcnpfZG1hY19jaGFuICpjaGFubmVsID0gJmRtYWMtPmNoYW5uZWxzW2ldOw0KPiA+
PiArDQo+ID4+ICsJCWd1YXJkKHNwaW5sb2NrX2lycXNhdmUpKCZjaGFubmVsLT52Yy5sb2NrKTsN
Cj4gPj4gKw0KPiA+PiArCQlpZiAoIShjaGFubmVsLT5zdGF0dXMgJiBCSVQoUlpfRE1BQ19DSEFO
X1NUQVRVU19DWUNMSUMpKSkNCj4gPj4gKwkJCWNvbnRpbnVlOw0KPiA+PiArDQo+ID4+ICsJCWlm
ICghKGNoYW5uZWwtPnN0YXR1cyAmIEJJVChSWl9ETUFDX0NIQU5fU1RBVFVTX1BBVVNFRCkpKSB7
DQo+ID4+ICsJCQlyZXQgPSByel9kbWFjX2RldmljZV9wYXVzZV9pbnRlcm5hbChjaGFubmVsKTsN
Cj4gPj4gKwkJCWlmIChyZXQpIHsNCj4gPj4gKwkJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBz
dXNwZW5kIGNoYW5uZWwgJXNcbiIsDQo+ID4+ICsJCQkJCWRtYV9jaGFuX25hbWUoJmNoYW5uZWwt
PnZjLmNoYW4pKTsNCj4gPj4gKwkJCQljb250aW51ZTsNCj4gPj4gKwkJCX0NCj4gPj4gKwkJfQ0K
PiA+PiArDQo+ID4+ICsJCWNoYW5uZWwtPnBtX3N0YXRlLm54bGEgPSByel9kbWFjX2NoX3JlYWRs
KGNoYW5uZWwsIE5YTEEsIDEpOw0KPiA+PiArCQljaGFubmVsLT5zdGF0dXMgfD0gQklUKFJaX0RN
QUNfQ0hBTl9TVEFUVVNfU1lTX1NVU1BFTkRFRCk7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJ
cG1fcnVudGltZV9wdXRfc3luYyhkbWFjLT5kZXYpOw0KPiA+PiArDQo+ID4+ICsJcmV0ID0gcmVz
ZXRfY29udHJvbF9hc3NlcnQoZG1hYy0+cnN0Yyk7DQo+ID4+ICsJaWYgKHJldCkgew0KPiA+PiAr
CQlwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGRtYWMtPmRldik7DQo+ID4+ICsJCXJ6X2RtYWNf
c3VzcGVuZF9yZWNvdmVyKGRtYWMpOw0KPiA+PiArCX0NCj4gPj4gKw0KPiA+DQo+ID4NCj4gPiBU
aGlzIHBhdGNoIGJyZWFrcywgczJpZGxlIGluIFJaL0czTCBhcyBpdCB0dXJucyBvZmYgRE1BIEFD
TEsgYW5kIElSUSdzDQo+ID4gYXJlIG5vdCByb3V0ZWQgdG8gQ1BVIGZvciB3YWtldXAuDQo+IA0K
PiBJcyB0aGlzIHBhcnRpY3VsYXIgcGF0Y2ggdGhlIG9uZSB0aGF0IGV4cGxpY2l0bHkgYnJlYWtz
IGl0PyBJcyB0aGVyZSBhbnkgbWFpbmxpbmUgUE0gc3VwcG9ydCBhdmFpbGFibGUNCj4gZm9yIFJa
L0czTD8gQ2FuIGl0IGJlIGZpeGVkIGFsb25nIHdpdGggdGhlIFJaL0czTCBzdXBwb3J0LCBpZiBh
bnksIGFzIEkgZG9uJ3QgaGF2ZSB0aGUgYm9hcmQgdG8gdGVzdA0KPiBpdD8NCg0KTWF5YmUgeW91
ciBURi1BIGlzIGVuYWJsaW5nIERNQUFDTEsgZHVyaW5nIHJlc3VtZS4gQ2FuIHlvdSBjaGVjayB0
aGF0IG1lYW4gdGltZSwgSSB3aWxsIGNoZWNrIHdoYXQgeW91IGhhdmUgbWVudGlvbmVkDQpIZXJl
Pw0KDQpDaGVlcnMsDQpCaWp1DQo=

