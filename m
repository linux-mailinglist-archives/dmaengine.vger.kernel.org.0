Return-Path: <dmaengine+bounces-4605-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768DA49DA6
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7781898716
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA9187859;
	Fri, 28 Feb 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="CHJM1gmn"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010043.outbound.protection.outlook.com [52.101.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C41EF366;
	Fri, 28 Feb 2025 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757138; cv=fail; b=enTjCDbz5toAjQ0IvGKtrAfZeX3QsiX5woyoFMjt4pUKxV8a/9QamnKHmmKmmpCpdurGy2kSs48ePWLAUvIypXQw9N5JKTIn02qkkaJzYavuOicHHBngwb76ZB4d1vT3xVBSkj1cDRs1lsiBWIY9SlIdyyEYe2k0YsQXnbexvE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757138; c=relaxed/simple;
	bh=K6E5Yd6P4FNmKQKP+NDOxpLaqx8/tVbL2qyU07akTm0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dVRM4yy0vFtbf9l0Uvg84rWtRWTKEiNikwG+PGacEL0qD7TcLWwH07tHxml2x05eIezIqi0a0lg/GnycEWeV2+viUDkcAPHtwrSx4QLPKqU9A0JAw26kuw9EB3VTD4vtHHnEbWMaX5I0bESMjXYmJtR2XK4/qqwuVJiuomxRaoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=CHJM1gmn; arc=fail smtp.client-ip=52.101.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6+LT551dUwVGL4Uy3mnCdTz8qf/K7ifUv1gITKxAAh3trn9zwjRjULdWCH3kp8BaF3jbzsXAyxT8hnL+nsHAJz/ocWpBkZ4TfVdtAjoz6N+ehlf7+j1Wlz1WUC7opAcyfyKAimTR79L4XTHwNqagek5ut38fJLKBv2fzIrJL75iXAmJMXumSHC4EAyHHLz91Gq4LDR3xE7UliMxeWwPTXrUvEbrtZEHVBrWWFYdOn/Wu7trX457SgxecmOZb5L/GwAbV7TVOjwAd0k1owmiLtloBxFWp2rne4kd9Wpwx3/HtDz+5OmxltHf8iA1UoJoy9J6HAiXxm729M7Tgr7b9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6E5Yd6P4FNmKQKP+NDOxpLaqx8/tVbL2qyU07akTm0=;
 b=jEheq7qwIQZd+J/oaLD16CaCSAuaQ8QF/lEaymKxn1GrOnJW6k9j1i3S6QtO7sQ5Z93JdMNTje2W6wE4aexqdp40hkZS94PbDOjTXwFXhr6TME5fw16PnDIEKEC0z7QJZPBuyKj1V7R38LA4lju6gfXNHrY0cV1CujUzkWXRcr2MW3rblcSpKAtZcX5bzWso9xS+fpmE3WjQ+sJjhV3ziMTs0WClaledLc9zlcmYzf48V/3N441Ipf+/IKSw1aJvW7/l0Zk5qZaehXhyGQE1B/t37UBYBDK0No791TrlrHzPb8vlk4BX+Nn78DD0CxJfKotCJ+C8nU2jRyFYQg22qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6E5Yd6P4FNmKQKP+NDOxpLaqx8/tVbL2qyU07akTm0=;
 b=CHJM1gmnAjdBlfbPlw4Ikt7B7qa5GwAbpKTel4qh2WEE7VGTm+n2lNVI7SQVzRNAADo/WX9V6uyrcRoLAlSBx4BfApkwMGem+Wb/+/8CISsNsMyBRMyBkMSrCC3YYz4fpyYWhFAwlt4BVN18cliOh0XmEwW5LTtQYimmpX6l+Hw=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by OS3PR01MB9834.jpnprd01.prod.outlook.com (2603:1096:604:1ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:38:49 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:38:49 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Topic: [PATCH v4 3/7] dt-bindings: dma: rz-dmac: Document RZ/V2H(P)
 family of SoCs
Thread-Index:
 AQHbg6hTr6k5RmdmC0qfs3vIpDif/7NWbDgAgAUL6qCAARRzAIAAS6IwgAAH6wCAAAMrgA==
Date: Fri, 28 Feb 2025 15:38:49 +0000
Message-ID:
 <TYCPR01MB12093BE16360C82F9CB853AF4C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
 <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com>
 <TYCPR01MB12093D1484AD0E755B76FAE35C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWUdOEjECPAJwKf7UwVs4OsUAEJ49xK+Xdn_bKXhRrt2Q@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWUdOEjECPAJwKf7UwVs4OsUAEJ49xK+Xdn_bKXhRrt2Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|OS3PR01MB9834:EE_
x-ms-office365-filtering-correlation-id: 0b51148b-00f2-48e0-f817-08dd580dff26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V0Z4Q2NxZnlZdUVOZHV3ZnRjcFRmRnVGN0Nvcy9GUGt0WVZJYmcwcENYVjlE?=
 =?utf-8?B?azBTczFiSkRTWE9Mbk40bEUxMWtDa29DZGFscjdmajdTSExiNHU0ZkVtSjFo?=
 =?utf-8?B?Ujc5RXo4Um8zVXFTdnRYRWNLeS8zWTU2YkU2WGY4SWczZXlDRS81aEpiT3hp?=
 =?utf-8?B?blNaWHUrNlowWjA3bDF5c0NWR3lMOUlSWUhGbDF2aWZuNnhFMFZaZ3hxNjhV?=
 =?utf-8?B?Y1g4alY0T0JRMkFiajZuWXlzQ3JTQi96d3RUazc3aEVmblQ2cGNHSEU3ajBH?=
 =?utf-8?B?bjN6aUY4T09LZEw0Y1czeDgxb2JreEtOWnlvQk9ySkx3SUZCaERPYzdCY2Vy?=
 =?utf-8?B?QlR3RDZzdTl4Z3ZDdkkzNW9xU0Vacm0xUlc4cG1IRFBFcXpGOHptMzkyQUYy?=
 =?utf-8?B?L3pSRnVLVzlhdlRMSzloMkNSdUNnTStXTDZYWkp1WEJ6UjkrdFUzd1Fpcisr?=
 =?utf-8?B?SlkzL1dod3Uzc2RQUmtKSDJiejZqTDgxTndINUZ5OERmYTJ2Qy9XUE5BUnQw?=
 =?utf-8?B?YTJDbEpTbml6ckY1ZXh6anh6aEhuWVppbHpmTmVtU3V5endUaGxFZVV1SmFO?=
 =?utf-8?B?dHlkWlM5bDYzeFVyQW10OWJTcjdqakFybVlPeGZlTGR1NzFMdmxNN1N2UzAv?=
 =?utf-8?B?ZjMyVkQ1L3VPMTJGUVpNR0JMS0ZqSmdsbDNpeFdUaFBQVzgvSFlaQnlHZVMz?=
 =?utf-8?B?S0MyN3lTb3g3TUdpS051NG0yTzFFRTdGVVoxa2VLb0JZV0JFcjRJd3I4SkIz?=
 =?utf-8?B?VmpvcE9VQS83cHRmeS9FNVl6WVIvZUJ1M2VWeFU4ckZOV0s5end3b1BZL3N2?=
 =?utf-8?B?UkxWVXpPenVGY2VDNVJXS0JSNmJ4UkxaNi9OZDJwd0Y4QjNHZ0ZTVkVYVm50?=
 =?utf-8?B?bTJFSjY3ZDlyd2VrUTVyakJTMW1vU3NuUjJ2UDhuRTRqWDN1Y1lzTklULzZs?=
 =?utf-8?B?K0FJT3ZUcDZvd1dHNGNRczVvL01wMHROZE4wejFWbVMySHpMMVVkSFBmZ0c2?=
 =?utf-8?B?VGZNbzdkNEx0dHhvbGxSMUl4YnlPSEVXUnI1Q0I0Y1JmVDVIRDl2ZzhkanlY?=
 =?utf-8?B?MW9vWjhwRHVUMlBaaGlUTjlUWGlsZm5FYjJSKy9GeitmTVFvTjh1TVNsQW1j?=
 =?utf-8?B?WnZKZjA1UnhEVWgyQ2cvT0pHSmtkK0ZoUmlMMURaWVBsU1JPdjB1ckhHa1Nh?=
 =?utf-8?B?d3MzMlBSMUZ3cVV6QkZCVzVoM0FSdTBDalhGYVlVaUI3YVFSaFBoZ3pCUU1Y?=
 =?utf-8?B?cWlnRWkwOExFUU9XWjIxVVQ0TG45a24wWTVMTjl1dHFzUlpWMEk5VUhCTHpa?=
 =?utf-8?B?c2JlNnpwRFNBa3lCeXEyTnpDZkFBTjVMaVFmRFN5Z3gxdk1FalI4S2I0OU1s?=
 =?utf-8?B?cFdoK1NmUlArYldDWVVwaEZWVWVNYTdQTFpTSDNmMFRWSmU3dzZ6Sk40OXRi?=
 =?utf-8?B?akozc0ljK0FaSU1xTjJPMnhyU3pWQlFsTmRONFk5eUFkcmtEblNpd0hwdVBX?=
 =?utf-8?B?YlB0eDI0MEZlTU9vam5SU3ZtUTYrejJMWGowR2hXKzdLOTc5MlBaNEFrWU1q?=
 =?utf-8?B?M2NlRTN6Y1BRR0t0dDk4WS85NUxBR1h2QjhieHdPQ0ZhaWlLeU8xZzdSUTdH?=
 =?utf-8?B?SlNMd0lPRVFMZGsxNVBRMEMvcTFVT3R6RldmdXlZWC9Qem4rWWVrOEhGa25N?=
 =?utf-8?B?dVdGbXhzcW9DZ0FRejRmdEhkNXN2cHdsb3plTkhPOEQ3cU96MksyeHVEWEsv?=
 =?utf-8?B?SW83ZHdWSHYyZmgxK1lJTDZMNUJXc1F3WlpGenhTbWNvWE9OM1J4SnhRQkVV?=
 =?utf-8?B?QWpsMW41ajRTVlFBcE5ld2tDbjBYaytNTDdZN1JIRVNxVkNUUjYrT0ZvNXNj?=
 =?utf-8?B?UTlOWnZGVDM4THI1RjhBdGtyd2RqMU9QcUF2Rnd5T1puOE5XOVFOZ1VDQ1Bt?=
 =?utf-8?Q?tAbMdgeIYS47zR+qSdQ2gSIpL3Mw9Ge9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGM3V1VXWHhPUUlSUldMdENuQitRNytrbDV1UEZJSkk5U2FqRXBpOHJ5YVQr?=
 =?utf-8?B?UnNyZ2puWkJ6RlZKZjZYdE9NV0srZURBRkx3Uk5QSmpjTkV3dk9wMU11VmFn?=
 =?utf-8?B?YTU4NGFWZVV0cmF0RFd2NDEzWEdHZXMrZUR6NnBkb2J0Uy9aSjJqVnZuY0lP?=
 =?utf-8?B?RHNQdWJDeWpjZ0k4bnFJa2dzMWZ0TFlYaVptWTY4YUFRWXJXTVFwZmR6a0o3?=
 =?utf-8?B?WTZrekRiSEMrQmxncDhiSGg4blQxU0VacmhCTzJydWFtTG1TN29jdXBvZmI1?=
 =?utf-8?B?NXNtREZBaHNrS05uSmxHZEEyQzYxZ0dUWHJGS0E0d0RISlJXWUY3Tk9VQWpk?=
 =?utf-8?B?ZFRWTU4yR2UzNEhaNllXcVliRW45RFdmSkQvTzZIWnk1NmlHMUgvSm9IcmxF?=
 =?utf-8?B?bkxlNENWMzlXSk1uSS9OK1JxNHZhbXBsOFM5bUg2L3JpemVGLzk0VFdpVStm?=
 =?utf-8?B?TG1mYU10eVVCYkhsQVdsci9EbjRma0ZoQlNtY3VQNlBQd1dENzUrcVBGK3BP?=
 =?utf-8?B?a2pZWnJSWlFrNE8weGszb2M3dkdGem02VUFLa2J0TTN0eXByWUQ4dC9KR2xY?=
 =?utf-8?B?OWpHNUU0MU1UMitWYUFxK1RMVnE1aWFKZlRuYmxnNEZ4ck55ZGNmREY1RDVF?=
 =?utf-8?B?QmdmVGU3Mm1UVnVmS2hWcktWYi9MRG9hOXNXcWN0VlYrN0RRSUxGd3lrN1RI?=
 =?utf-8?B?NFBSdjRvMENPbFBaNUtTd3RTNFRmcFAvOEdxUkNoZHdmL3FGRnh4bFBmRWd6?=
 =?utf-8?B?dVBZSUE0Nm9xL052V0F5VCtsQU0xR05iRVNWd3FRbmVPZDQ1cldlQk00aDhM?=
 =?utf-8?B?TUg3RER1N01UcWhLRGVxaGhQbHZJNnJrTmIyczd1T0tQMm1EUlRxS3U4VitB?=
 =?utf-8?B?ZkJFSDVqNHJ6Yks4dS9rSVNlVEt6dlVybWhnMXJpWlJUaXdFNHp1WnFEeTJ5?=
 =?utf-8?B?a0FhcDV2aWNJRmRmM0V4ajJFd3I1bVo3MFlNV2lDazJsbGVjZFlhbTBCVGNL?=
 =?utf-8?B?SDFRMTlHZFl2MHpHeDBWT0NZb085NG1PTlE5UzNBY2o3WG1WME52V1gvd1o3?=
 =?utf-8?B?aUlwUWFJODQzSmU1d2c5RDEzbUVyenR6VjlrZHhJRWV3Ynl4Y3lVQXlCaFUy?=
 =?utf-8?B?c1gycEljakttUE9peS9tU2JMSFdNMmlWMlowQTF3ZDhPYzg2d2NlRTg5UlZx?=
 =?utf-8?B?cGdJbHJXVzlkd0U0ekJtUmFiUTd4RGdMTCtGSXV6aTdoK05wQ3pOV2Q5NFo2?=
 =?utf-8?B?eGFMeEZic01veDRSL0g0d2NFL0lwcHNqYy9yTDhWWXJtcFJRSXBSazU2a1Yz?=
 =?utf-8?B?K0lYSmc1Y2RSVXRhelZiZUZ3MXhOTW1scnZZYWtkak1lRmFkTnIrUEFZVEU5?=
 =?utf-8?B?b1BVdXY4R1J3b1NpZSsvOGlvaEpBZ2pzNWZ4SlIxaHM2bTNGZkpoUTdGSURy?=
 =?utf-8?B?SXByWWZBdDdQcG85MFBOa0pHZXZyaFNjeFZHam5PS1U0NTFQVmZXdklGb2hM?=
 =?utf-8?B?Q01DMGNoczIrZkpTc1dKUzdKSFRaNWhhN1Y1bEFXV0JUQ21VM3NCT2hlS0cy?=
 =?utf-8?B?TzV5Z2N3YmJuMnkyVHNHWDJFdWZpczNjS1dDanJzYUhxeXFLL3AxcVZRMTI0?=
 =?utf-8?B?Z0h5d1czV2VWeTZtbW56VWtlWm53ZmlIUzM3NjNWZ2t2RGpNS1JFOFZDbWtV?=
 =?utf-8?B?dFovUGd2ZW1jRVdJekF4dWJhNFpHd2NmMUxYaEZPV0gxdHdWRVdqcFlwZVB1?=
 =?utf-8?B?QUtIRzJkbGVJNFdNbXJyM0tYQ0pQUFVtZjJ2SDZTaDQxaFJyYWpOT3FlTk5S?=
 =?utf-8?B?YXllNTlzOHYyMHdpM1VnbkU5Vk9jaUVZVG9RUTZkVzRxY05ZR01UT1YveDZr?=
 =?utf-8?B?cmlGSk91dW5CbkZScGxJSmJVemZ0ejVXblE4VFhGUU9SODluZGcvM3B1Tjhz?=
 =?utf-8?B?ck9KT0huK2craVpqbEZ2ckFBallUNGx3QXFNTFRrOVE2bGJFU0VoNklJc2Z1?=
 =?utf-8?B?Yzh2dW1LOHZnUXRHbU45WnM3UWRHZFN0OEVjWGhZbVNGZTZJVVVyaEJveEtY?=
 =?utf-8?B?M3VyOVRnR2xOTlJ3NlhwQWJnZ2QwZnRpUlNXTElLcFFBTFBjUGpHOFlzdEJN?=
 =?utf-8?B?MFkvMlNRM25JK2RhY0xRZzRBaTdUaktzcEhPS1hQOFpuSC9wNFpJMUF2SG9R?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB12093.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b51148b-00f2-48e0-f817-08dd580dff26
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 15:38:49.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMFUx0N+/kSJpOQc43j//750YLr2T7Qdn33vURKISCxOx70By4tWOQzX2HXenUByAP7ezqToz2bzRnsPrtu95u7kBUtqjrcQyIQWo0RQQDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9834

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjayENCg0KPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiAyOCBGZWJydWFyeSAy
MDI1IDE1OjE2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy83XSBkdC1iaW5kaW5nczogZG1h
OiByei1kbWFjOiBEb2N1bWVudCBSWi9WMkgoUCkgZmFtaWx5IG9mIFNvQ3MNCj4gDQo+IEhpIEZh
YnJpemlvLA0KPiANCj4gT24gRnJpLCAyOCBGZWIgMjAyNSBhdCAxNTo1NSwgRmFicml6aW8gQ2Fz
dHJvDQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gRnJv
bTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gPiA+IFNlbnQ6
IDI4IEZlYnJ1YXJ5IDIwMjUgMTA6MTcNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy83
XSBkdC1iaW5kaW5nczogZG1hOiByei1kbWFjOiBEb2N1bWVudCBSWi9WMkgoUCkgZmFtaWx5IG9m
IFNvQ3MNCj4gPiA+DQo+ID4gPiBIaSBGYWJyaXppbywNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIDI3
IEZlYiAyMDI1IGF0IDE5OjE2LCBGYWJyaXppbyBDYXN0cm8NCj4gPiA+IDxmYWJyaXppby5jYXN0
cm8uanpAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhv
ZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQo+ID4gPiA+ID4gU2VudDogMjQgRmVicnVhcnkg
MjAyNSAxMjo0NA0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMy83XSBkdC1iaW5k
aW5nczogZG1hOiByei1kbWFjOiBEb2N1bWVudCBSWi9WMkgoUCkgZmFtaWx5IG9mIFNvQ3MNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IE9uIFRodSwgMjAgRmViIDIwMjUgYXQgMTY6MDEsIEZhYnJpemlv
IENhc3Rybw0KPiA+ID4gPiA+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3Rl
Og0KPiA+ID4gPiA+ID4gRG9jdW1lbnQgdGhlIFJlbmVzYXMgUlovVjJIKFApIGZhbWlseSBvZiBT
b0NzIERNQUMgYmxvY2suDQo+ID4gPiA+ID4gPiBUaGUgUmVuZXNhcyBSWi9WMkgoUCkgRE1BQyBp
cyB2ZXJ5IHNpbWlsYXIgdG8gdGhlIG9uZSBmb3VuZCBvbiB0aGUNCj4gPiA+ID4gPiA+IFJlbmVz
YXMgUlovRzJMIGZhbWlseSBvZiBTb0NzLCBidXQgdGhlcmUgYXJlIHNvbWUgZGlmZmVyZW5jZXM6
DQo+ID4gPiA+ID4gPiAqIEl0IG9ubHkgdXNlcyBvbmUgcmVnaXN0ZXIgYXJlYQ0KPiA+ID4gPiA+
ID4gKiBJdCBvbmx5IHVzZXMgb25lIGNsb2NrDQo+ID4gPiA+ID4gPiAqIEl0IG9ubHkgdXNlcyBv
bmUgcmVzZXQNCj4gPiA+ID4gPiA+ICogSW5zdGVhZCBvZiB1c2luZyBNSUQvSVJEIGl0IHVzZXMg
UkVRIE5PL0FDSyBOTw0KPiA+ID4gPiA+ID4gKiBJdCBpcyBjb25uZWN0ZWQgdG8gdGhlIEludGVy
cnVwdCBDb250cm9sIFVuaXQgKElDVSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBGYWJyaXppbyBDYXN0cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gdjEtPnYyOg0KPiA+ID4gPiA+ID4gKiBSZW1vdmVkIFJa
L1YySCBETUFDIGV4YW1wbGUuDQo+ID4gPiA+ID4gPiAqIEltcHJvdmVkIHRoZSByZWFkYWJpbGl0
eSBvZiB0aGUgYGlmYCBzdGF0ZW1lbnQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGFua3MgZm9y
IHRoZSB1cGRhdGUhDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvcmVuZXNhcyxyei1kbWFjLnlhbWwNCj4gPiA+ID4gPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvcmVuZXNhcyxyei1k
bWFjLnlhbWwNCj4gPiA+ID4gPiA+IEBAIC02MSwxNCArNjYsMjIgQEAgcHJvcGVydGllczoNCj4g
PiA+ID4gPiA+ICAgICcjZG1hLWNlbGxzJzoNCj4gPiA+ID4gPiA+ICAgICAgY29uc3Q6IDENCj4g
PiA+ID4gPiA+ICAgICAgZGVzY3JpcHRpb246DQo+ID4gPiA+ID4gPiAtICAgICAgVGhlIGNlbGwg
c3BlY2lmaWVzIHRoZSBlbmNvZGVkIE1JRC9SSUQgdmFsdWVzIG9mIHRoZSBETUFDIHBvcnQNCj4g
PiA+ID4gPiA+IC0gICAgICBjb25uZWN0ZWQgdG8gdGhlIERNQSBjbGllbnQgYW5kIHRoZSBzbGF2
ZSBjaGFubmVsIGNvbmZpZ3VyYXRpb24NCj4gPiA+ID4gPiA+IC0gICAgICBwYXJhbWV0ZXJzLg0K
PiA+ID4gPiA+ID4gKyAgICAgIEZvciB0aGUgUlovQTFILCBSWi9GaXZlLCBSWi9HMntMLExDLFVM
fSwgUlovVjJMLCBhbmQgUlovRzNTIFNvQ3MsIHRoZSBjZWxsDQo+ID4gPiA+ID4gPiArICAgICAg
c3BlY2lmaWVzIHRoZSBlbmNvZGVkIE1JRC9SSUQgdmFsdWVzIG9mIHRoZSBETUFDIHBvcnQgY29u
bmVjdGVkIHRvIHRoZQ0KPiA+ID4gPiA+ID4gKyAgICAgIERNQSBjbGllbnQgYW5kIHRoZSBzbGF2
ZSBjaGFubmVsIGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVycy4NCj4gPiA+ID4gPiA+ICAgICAgICBi
aXRzWzA6OV0gLSBTcGVjaWZpZXMgTUlEL1JJRCB2YWx1ZQ0KPiA+ID4gPiA+ID4gICAgICAgIGJp
dFsxMF0gLSBTcGVjaWZpZXMgRE1BIHJlcXVlc3QgaGlnaCBlbmFibGUgKEhJRU4pDQo+ID4gPiA+
ID4gPiAgICAgICAgYml0WzExXSAtIFNwZWNpZmllcyBETUEgcmVxdWVzdCBkZXRlY3Rpb24gdHlw
ZSAoTFZMKQ0KPiA+ID4gPiA+ID4gICAgICAgIGJpdHNbMTI6MTRdIC0gU3BlY2lmaWVzIERNQUFD
SyBvdXRwdXQgbW9kZSAoQU0pDQo+ID4gPiA+ID4gPiAgICAgICAgYml0WzE1XSAtIFNwZWNpZmll
cyBUcmFuc2ZlciBNb2RlIChUTSkNCj4gPiA+ID4gPiA+ICsgICAgICBGb3IgdGhlIFJaL1YySChQ
KSBTb0MgdGhlIGNlbGwgc3BlY2lmaWVzIHRoZSBSRVEgTk8sIHRoZSBBQ0sgTk8sIGFuZCB0aGUN
Cj4gPiA+ID4gPiA+ICsgICAgICBzbGF2ZSBjaGFubmVsIGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVy
cy4NCj4gPiA+ID4gPiA+ICsgICAgICBiaXRzWzA6OV0gLSBTcGVjaWZpZXMgdGhlIFJFUSBOTw0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gU28gUkVRX05PIGlzIHRoZSBuZXcgbmFtZSBmb3IgTUlEL1JJ
RC4NCj4gPiA+DQo+ID4gPiBUaGVzZSBhcmUgZG9jdW1lbnRlZCBpbiBUYWJsZSA0LjctMjIgKCJE
TUEgVHJhbnNmZXIgUmVxdWVzdCBEZXRlY3Rpb24NCj4gPiA+IE9wZXJhdGlvbiBTZXR0aW5nIFRh
YmxlIikuDQo+ID4NCj4gPiBSRVFfTk8gaXMgZG9jdW1lbnRlZCBpbiBib3RoIFRhYmxlIDQuNy0y
MiBhbmQgaW4gVGFibGUgNC42LTIzIChjb2x1bW4gYERNQUMgTm8uYCkuDQo+IA0KPiBJbmRlZWQu
IEJ1dCBub3QgZm9yIGFsbCBvZiB0aGVtLiBFLmcuIFJTUEkgaXMgbWlzc2luZywgSUlDIGlzIHBy
ZXNlbnQuDQoNCkkgY2FuIHNlZSB0aGUgUlNQSSByZWxhdGVkIGBSRVEgTm8uYCBpbiB0aGUgdmVy
c2lvbiBvZiB0aGUgbWFudWFsIEkgYW0gdXNpbmcsDQphbHRob3VnaCBvbmUgbXVzdCBiZSB2ZXJ5
IGNhcmVmdWwgdG8gbG9vayBhdCB0aGUgcmlnaHQgZW50cnkgaW4gdGhlIHRhYmxlLA0KYXMgdGhl
IHRhYmxlIGlzIHF1aXRlIGJpZywgYW5kIHRoZSBlbnRyaWVzIGFyZSBvcmRlcmVkIGJ5IGBTUEkg
Tm8uYC4NCg0KRm9yIHNvbWUgZGV2aWNlcywgdGhlIFNQSSBudW1iZXJzIGFyZSBub3QgY29udGln
dW91cyB0aGVyZWZvcmUgdGhlIGRldmljZSBzcGVjaWZpYw0KYml0cyBtYXkgZW5kIHVwIHNjYXR0
ZXJlZC4NCkZvciBleGFtcGxlLCBmb3IgYE5hbWVgIGBSU1BJX0NIMF9zcF9yeGludHBsc19uYCAo
bWluZCB0aGF0IHRoZSBgcGxzX25gIHN1YnN0cmluZw0KaXMgb24gYSBuZXcgbGluZSBpbiB0aGUg
dGFibGUpIHlvdSBjYW4gc2VlIGZyb20gVGFibGUgNC42LTIzIHRoYXQNCml0cyBgRE1BQyBOby5g
IGlzIDE0MCAoYXMgeW91IHNhaWQsIGluIGRlY2ltYWwuLi4pLg0KDQo+IEFuZCB0aGUgbnVtYmVy
cyBhcmUgc2hvd24gaW4gZGVjaW1hbCBpbnN0ZWFkIG9mIGluIGhleCA7LSkNCj4gDQo+ID4gPiA+
IEl0J3MgY2VydGFpbmx5IHNpbWlsYXIuIEkgd291bGQgc2F5IHRoYXQgUkVRX05PICsgQUNLX05P
IGlzIHRoZSBuZXcgTUlEX1JJRC4NCj4gPiA+ID4NCj4gPiA+ID4gPiA+ICsgICAgICBiaXRzWzEw
OjE2XSAtIFNwZWNpZmllcyB0aGUgQUNLIE5PDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIGlz
IGEgbmV3IGZpZWxkLg0KPiA+ID4gPiA+IEhvd2V2ZXIsIGl0IGlzIG5vdCBjbGVhciB0byBtZSB3
aGljaCB2YWx1ZSB0byBzcGVjaWZ5IGhlcmUsIGFuZCBpZiB0aGlzDQo+ID4gPiA+ID4gaXMgYSBo
YXJkd2FyZSBwcm9wZXJ0eSBhdCBhbGwsIGFuZCB0aHVzIG5lZWRzIHRvIGJlIHNwZWNpZmllZCBp
biBEVD8NCj4gPiA+ID4NCj4gPiA+ID4gSXQgaXMgYSBIVyBwcm9wZXJ0eS4gVGhlIHZhbHVlIHRv
IHNldCBjYW4gYmUgZm91bmQgaW4gVGFibGUgNC42LTI3IGZyb20NCj4gPiA+ID4gdGhlIEhXIFVz
ZXIgTWFudWFsLCBjb2x1bW4gIkFjayBObyIuDQo+ID4gPg0KPiA+ID4gVGhhbmtzLCBidXQgdGhh
dCB0YWJsZSBvbmx5IHNob3dzIHZhbHVlcyBmb3IgU1BESUYsIFNDVSwgU1NJVSBhbmQgUEZDDQo+
ID4gPiAoZm9yIGV4dGVybmFsIERNQSByZXF1ZXN0cykuICBUaGUgbW9zdCBmYW1pbGlhciBETUEg
Y2xpZW50cyBsaXN0ZWQNCj4gPiA+IGluIFRhYmxlIDQuNy0yMiBhcmUgbWlzc2luZy4gIEUuZy4g
UlNQSTAgdXNlcyBSRVFfTk8gMHg4Qy8weDhELCBidXQNCj4gPiA+IHdoaWNoIHZhbHVlcyBkb2Vz
IGl0IG5lZWQgZm9yIEFDS19OTz8NCj4gPg0KPiA+IE9ubHkgYSBoYW5kZnVsIG9mIGRldmljZXMg
bmVlZCBpdC4gRm9yIGV2ZXJ5IG90aGVyIGRldmljZSAoYW5kIHVzZSBjYXNlKSBvbmx5IHRoZQ0K
PiA+IGRlZmF1bHQgdmFsdWUgaXMgbmVlZGVkLg0KPiANCj4gVGhlIGRlZmF1bHQgdmFsdWUgaXMg
UlpWMkhfSUNVX0RNQUNfQUNLX05PX0RFRkFVTFQgPSAweDdmPw0KDQpZZXMuDQoNClRoYW5rcyEN
Cg0KRmFiDQoNCg0KPiBXaGljaCBJIGJlbGlldmUgYWxyZWFkeSBjYXVzZXMgeW91IHRvIHJ1biBp
bnRvIHRoZSBvdXQtb2YtcmFuZ2UgRE1BQ0tTRUxrDQo+IHJlZ2lzdGVyIG9mZnNldCBpbiByenYy
aF9pY3VfcmVnaXN0ZXJfZG1hX3JlcV9hY2soKT8NCj4gDQo+ID4gQnV0IEknbGwgdGFrZSB0aGlz
IG91dCBmb3Igbm93LCB1bnRpbCB3ZSBnZXQgdG8gc3VwcG9ydCBhIGRldmljZSB0aGF0IGFjdHVh
bGx5DQo+ID4gbmVlZHMgQUNLIE5PLg0KPiANCj4gT0suDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9
cywNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVy
dCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdl
ZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGgg
dGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdt
IHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRo
aW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51
cyBUb3J2YWxkcw0K

