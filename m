Return-Path: <dmaengine+bounces-4608-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42435A49EEF
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 17:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654BC1642CF
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC81276042;
	Fri, 28 Feb 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="EYDohX7/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8F2270EC0;
	Fri, 28 Feb 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760373; cv=fail; b=qQ9svWoHvh+VzqCIGt4GZi9TqU/zL1S4wFoBnPRCzwMmRwkqpLaLxP7CyCLAuZIpmrRXxo0JIEiUgyXWFTITw9HxvF0ehK1rodcnXGjTZA45jDMfe/46ltL5+oriORlNfKPHbf88/xQJ6g8kcV2TE2jgEYjscXrbKnEhnfghPp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760373; c=relaxed/simple;
	bh=gP5TddtZHS5O10bv5Pz2GKVN7jH5GT517xeW/GinWio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S5L8LYgGG31CIeNP0kNv+qK7ewvP2wxQgenBEJVt+Xlm9oRfzzAXYUhfGux9eZp1IxP+I71/Qr6rhkp5ygFpTrzQ2XVA9lgXf+5o7X8/2Pzb7Ytsu1PQWLPJAvoy1Km4dfaLsyF/Ho3QYRyesFOd4GeJK8GDfz2cY5FDli6R504=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=EYDohX7/; arc=fail smtp.client-ip=52.101.125.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/+pL2OGst7doWNyUOKb9qHhFTkeaTQuoMQRDn0dfPQXN3DB2W6THkrPT00TY8p3vZ3PY9GpV/UnmCoGLwEKJU+tPZJO/zL8KkAkrVYTHHnJhx/tME2SnPwfqpgFk9KYi1TYTvGCziS3HTKL70HrHJ/IOmkUHwyN7HCPA8vaHm5VtO07ScJHHy3dLOVE/oA39T80XG4cCS4oWZKBewpGeRCkFW+TfDZvIL0cwFaEnmPEPYK+KUrP9WogJK9hU1VhaLufFnnxwS63GHbmzMFIQxZC16kNe48iGExW/4dlKkVmd6apoZzgo7uM8mUDAtCWCCD/mrxD+ST2sOQrQPxxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP5TddtZHS5O10bv5Pz2GKVN7jH5GT517xeW/GinWio=;
 b=kvqW7/ltEY1k2+DLaNx2hJyIzc+HavLbPizX7A2a9vC1si/8XjAsqTO3uvxjsCWUjHFwh4H1rbCINi8arYWtKlMekAToAd0TM6BhbAUQBJvW95m5VReuqXLqMhIOm6sr8iAabWNiMame0XOl887ryZUzjBYHHDog1RkM5kqmkUQk26ZSHjYwRjEYw2ijaCgavMX/014OlUuDxuxItWpvCdN1BQ3qVOoCbc9L91rhv8s0g7fYybYxZVD8jVd2S0iopDYxGxF67dq3SK0tLmWSEg6/OCISRQotxEFZt3jRPJaTyRYwTbJNk5KdHnKiQ/VZbDSOYWHXGsE8RcZljZXawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP5TddtZHS5O10bv5Pz2GKVN7jH5GT517xeW/GinWio=;
 b=EYDohX7/zsYZ4L4Jw2i1zEyY2xeIHoDDCtlhFnH8TPZHmP9EpoNitIyvRPASSQOhKAdYS08Lg4iFVDgeeFW1HQNaf2y5p8WCzi/63dCtNXR7USf/1RiK7xqLbZeCMDYr6l5i2OWRVGeetdLo892+W5wPF4PCEZY6mcpA8TeRtvI=
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 by TY4PR01MB12809.jpnprd01.prod.outlook.com (2603:1096:405:1e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 16:32:46 +0000
Received: from TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430]) by TYCPR01MB12093.jpnprd01.prod.outlook.com
 ([fe80::439:42dd:2bf:a430%7]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:32:46 +0000
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
 AQHbg6hTr6k5RmdmC0qfs3vIpDif/7NWbDgAgAUL6qCAARRzAIAAS6IwgAAH6wCAAAMrgIAACCMAgAAA8CA=
Date: Fri, 28 Feb 2025 16:32:46 +0000
Message-ID:
 <TYCPR01MB120935A45DD8D9E414D869453C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
References: <20250220150110.738619-1-fabrizio.castro.jz@renesas.com>
 <20250220150110.738619-4-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUjDw923oStxqY+1myEePH9ApHnyd7sH=_4SSCnGMr=sw@mail.gmail.com>
 <TYCPR01MB12093A1002C4F7D7B989D10C4C2CD2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWzuNz_4LFtNtoiowq31b=wbA_9Qahj1f0EP-9Wq8X4Uw@mail.gmail.com>
 <TYCPR01MB12093D1484AD0E755B76FAE35C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdWUdOEjECPAJwKf7UwVs4OsUAEJ49xK+Xdn_bKXhRrt2Q@mail.gmail.com>
 <TYCPR01MB12093BE16360C82F9CB853AF4C2CC2@TYCPR01MB12093.jpnprd01.prod.outlook.com>
 <CAMuHMdXkgK-EdGhyrE6PRzskRXkJ8u+xQ=c5x1-=couedtcmqw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXkgK-EdGhyrE6PRzskRXkJ8u+xQ=c5x1-=couedtcmqw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB12093:EE_|TY4PR01MB12809:EE_
x-ms-office365-filtering-correlation-id: eb2b9689-17f7-4dec-dcd1-08dd581588a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmwxdldERzAreWtqOGhQTTU3WU5ncXVELzcxL0pBOGpRR0FWWlE4Wmt0VUR0?=
 =?utf-8?B?NGhLNEQ1cURiVkZyVk1yYnJKK3FrelB3aExDKzJuU0NvRXgySEdVL2xkYVNN?=
 =?utf-8?B?cjJma3plQjJDZ3VJWlpDc2ZzN3V3V1VlUHpFMHJKNEdxeTZUN2t2eXZWNVhi?=
 =?utf-8?B?YWxONGNnV3hNY1ZabVc4akl5NHRBNWVkY2tDajUvZXFLNzdQdlc4NFVzcGUv?=
 =?utf-8?B?QitVSnNYRVZ1c3VBaFYyeFdITTVZNTY1YkdsRCtNdkh4ZGtyU2ttNlVwZ3JL?=
 =?utf-8?B?RTZoOTJaTzF3d25penFZWElLdXpEbUtJRTB4ZytBOU1KVTMrOVd6bWQwZ3R4?=
 =?utf-8?B?ZUFZTDRiN3hSY0tDeW1DVlRLeEhEU29IaGl1UXo3Umw5bjcrc1ZYT3gyT3k2?=
 =?utf-8?B?ZHc2SFQwMTlCNUhITUdUOWdNTlhvYUJ4YlpvTUliNzlxZS9tNHJKdjc5bzQ3?=
 =?utf-8?B?ZmRkTDBlQmNtU09UZTN3dTUxM3NlQjRmYWxPU2daTktubU5lVG54WFpzajNn?=
 =?utf-8?B?WlpuRSt1ZGxlTG5GaFF1eDZjcWE0M3duS1JhazVxUk9NUVhLSE5tNkFhUzUy?=
 =?utf-8?B?a2ZYU1lRa1R4SlhMczlDc0tpbWFGNTRrY3pFR0ZNbDg3WUk2Uys1Q2JGeTFV?=
 =?utf-8?B?bzViNXhva1JIVTV1K2g0S2xpbmNwbk90SWQ2TEgvTzJqZndxd3N4b0dzQUdC?=
 =?utf-8?B?R29PUk9vakFYd01tYVM0WHFEOGN6dG55aGZncW13VWNGc28rWUlKdVFXRDEv?=
 =?utf-8?B?TE1kaklDeG5KQUx3aTZBcGc0Rk1uUXhIbHB5cjhpTEF3VGtiVWF6QWtUb25U?=
 =?utf-8?B?dzQ4OG5tbnFrVmhNb25jWjBWWXZQYzdqM05tZm9HN09MeGlzMWtLaWZyR3M0?=
 =?utf-8?B?S0tobGt0Y3MzWnp4R3E2Vm4xMmxWU2xMNjJPSVY4eWsrY0ZaSk5GT0ZNWmxz?=
 =?utf-8?B?MWZzN1h1R2VzOXJ5VS93SnhzeFZkUVlOT01zZzkvSG5zc1ZzMUhBa1Z4eVYz?=
 =?utf-8?B?eGo0UjZSSkZ0c01OK0w0VkFsWk1lYUtNVmVxUWgzd2EyZzdQMjBjK1VabmhO?=
 =?utf-8?B?d3NNMC9sd0NXYmE0S1phNUk4Y001ckh2QWtqRGJkTlBnaWNvTGQ3RjJKTXIr?=
 =?utf-8?B?a01zWkJweWFpa0grbEpCV3BQNGVpQm4zNXgwTmVmUzhTOE9LcnR4YlYvQjlZ?=
 =?utf-8?B?OUNyd0VvR0FyYkoyVXBQT2U5WjVEelR3VlcvWjZVNE1WdEQ0bFZxWHhybnhJ?=
 =?utf-8?B?L3h3RzVzZ2ZGTXdIdDM2QWxxN0pEbVNOelNyUFMrQVZsb1BsZ2tpU0dSOWJk?=
 =?utf-8?B?Y3lEZkkzTEpVRUZ2VVAxdzVkWE4xeHYyUE84QkpxcTUrTVNUQ2k1T2tIQXdj?=
 =?utf-8?B?ZkNPTGYzQ21iQjc3Q2twWnBLdHcxUnJSdnRaMVo0cFpRb080bG9sZUYwSFE0?=
 =?utf-8?B?WkpycmFkMGFkTHdGdWJZNjcyMTB4VGxsaGVrZllNYmxiT2MwWEdhUk5VQkpS?=
 =?utf-8?B?M21UL1ovbGw2Y0RBRy82U0FYYllTc2tGQ3VjWlFRRS9nV2VPRC9vUlZ2L2RE?=
 =?utf-8?B?OHlTV2NCRVhpTXBhUkw2a3VON0NmalRBOW1XbHVUS2VFalNPRzFkaHgzTTJu?=
 =?utf-8?B?aE5BVmRXYWh3cjdRaHpOenJBb05VRUpNOE5YMWdHRFdObCsxMmdWUnNlcUZ0?=
 =?utf-8?B?WEl1cE04ZDlsMVhFT0dkcE0wbFFUSC9yY2VkNVpHbVprVHF6eFRxL2xicFBH?=
 =?utf-8?B?U2RmUXIwZkN5bDYvMlBoLzAvZlh2TVhvbXBRaUVSSkFVV2tXa0xGdzJhK0FP?=
 =?utf-8?B?d2tpMTRpTFBsNjQ2disrRk9IZXFqTHJBdFp0MXVOeVp2eE5RbCtSOTVRblFC?=
 =?utf-8?B?OWtJbnV2Q0pwVDFYMElCRUJiOVNUQWF1SThVekhkOHI3RHlic3hDd21hdDZO?=
 =?utf-8?Q?mwBbsN1SWXFXXwn6x2reP9XDelqDAP0a?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB12093.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3N1NDhrYjNwem1QQzgrUC9rSEY4MXJJYW9ZSDZ5MFA2TkFLbVgvdVMwTnhB?=
 =?utf-8?B?ZENWSkE0TDYrSWMyZ21ITkFVQnBMUVlDWVI2cUc2d0RBdjg3dXZXa0ZzQlc0?=
 =?utf-8?B?WkRaZTMxRWdVTUJkRll3L3J1aXJGZXBnU2hxL1NWcTVFWGw5ZGx0WUozZzF3?=
 =?utf-8?B?SWdqMGRpUVJaRmJhVEVseXVGZEZweEw4VnAvUWR0ODJEbkZobldoT0lEaDll?=
 =?utf-8?B?djFMRElpZk5iWUd0alhZNWsxeFFzWkFIVjViYUxWV1EvVmgxV1hxSHlLWjd4?=
 =?utf-8?B?Y1h2VGVSclAzTXR3SEJ6ZDc3cUVObUdIeUlCU3lDbWFyeG9oZDBUeGhucnRw?=
 =?utf-8?B?SExwVlRBNWlSVHJyWXVMMEcycXlpQm9tZjdjc291SEYzUmFMVWhCdjV5MXRB?=
 =?utf-8?B?K3ZYaVdNclhiZmRXZzFBTk50bjV5NXlQZEo2WEZCblRpN3M1MWw2SHhEUkRR?=
 =?utf-8?B?NkdQc2dQQjUvNnJZLy93aFIySW8rRHJ0QlFQOVJRL1NVbE45MUMweFVkeERy?=
 =?utf-8?B?VDVHYTJuSWxsT0J5S0hVdmt4Qnk3Tld0QmpDVGN2UEtjR3E2NnlBSnBGUURr?=
 =?utf-8?B?eG84QnBJMHBVR0xPeUNmSVpsOFdBQXhUaVdMUWZaUm9Tc2J4aDV2SlM3WUgr?=
 =?utf-8?B?SlM4YWloaDM5SEVOVXhESU1aeGxSamROVmxrbG9tMlhXcnRMV3NlTSs2UVRk?=
 =?utf-8?B?a0NHZkM2ejdpRC9hVHBkZjM5Wkc2NlAxSkNwYkR5c1EybmtoRUZ2dGt2UERR?=
 =?utf-8?B?V3krMnZPK05QUk5iOVZFdzRDNHdpZXB1aUUxd0l5VWx5WUVvNzZUOFFmYStQ?=
 =?utf-8?B?SHpMWDA4SWtiUGNYb3kxWHJ3eWFrcEdpSEhNQXBObWhSR3ZlTEgyUUwvZXBh?=
 =?utf-8?B?L0xIYXk2Z1VQY0g0QnJVZ3pOUWU5SVNFRy9nYmhFODBwQmd4QjAwUnp4ajFx?=
 =?utf-8?B?S1E3dHdBZ1BKVGdTOGxWVkY2c1U0d0JqWkpsNlJaNXh4L2hhNFpWU1lwNitL?=
 =?utf-8?B?S1RLZVJpeEUrT2tIU3F0d3hVRTloMXU0T2hzUWFmQjlHb0hKcjk0Z09Wa3FU?=
 =?utf-8?B?TWQ5RWZNcVR6YlRnQTRtemwxdm1sdTkwRGdWVVBKQ1RBVjN5cTBGdGRnR0lp?=
 =?utf-8?B?eEFpUTdsK0NyWHpJNGNYbkhPYXJYM0E1UnMyMC83V2UvUTlIa1BEUFdWUW1h?=
 =?utf-8?B?eFBvaDhVdkdVTjZtekdBZGR4WjRhTGJjMUxsQWdYYzhzVWllVUdoWWpSN3h1?=
 =?utf-8?B?TlViZi9ER0phRkVRTlNtQXFEOTJXeklPL1pKV1Q1NmNGYjlzTlNaU2JzVU5R?=
 =?utf-8?B?ZGo1dHlQVDB6NnpaakE1ajUraGtDb3hJdlJTMVhCRHQwaXI2YUtXZmlaTUE0?=
 =?utf-8?B?RDlia1VuREZSdlJBUzRDaWhxV0ViMk9PVXR1THUrQU9KY2lzVDF4OWlYMkFX?=
 =?utf-8?B?aGgyOEt6OG85V0liQ25JSmhoNUhjTWQzMkpTRklIZGY1V3NvVy9oRHBuTm95?=
 =?utf-8?B?eWNxZUdlNUlTZUp6eTIzcGxoNDZiZlhJNmlKUC9WMmxENkh3NExqeFkwdUk3?=
 =?utf-8?B?c0tQRFNaL0pyb0lQUHF2bnZFeDk5cHVZM2VieFFXcitRbVcxM1pHWXJ2VEFr?=
 =?utf-8?B?LzFoM1VGL0JoajVram84VXR5NDYyWFBDMThEcVFWQk1kQVRTZXBUTTcyaGxq?=
 =?utf-8?B?OGlKeVhGMFZGdktqbExQZ0xaajA0Nk94Um92Q0Fsbmd4ODhmcldweVhicG1m?=
 =?utf-8?B?SXhWZkYxKzYzNkh5T2hkV1BEZm5NR3ZyZEs5c3M2d1hZSlhzZUZLKzBwd0Rr?=
 =?utf-8?B?TlEyaUVRbmk2R09xby85RGhXTFNHTS96dGt5NnYyMXdlN3c0RjNsZ0VJQWdY?=
 =?utf-8?B?UWhrMU1BTk9xVWxGWnlreXJNTXNBdUVaSXhnZjVBOUNQUnVKZUFEb2FnNlYv?=
 =?utf-8?B?QU5Ib3plVWNQd0pMZFBNM0xiZy81YXdtQk1CTHhzVnh6R29WMVpha1gyLzZB?=
 =?utf-8?B?VVlxMEpyZWNPTWNFZEdFb080TE9MZkRkM01hc0hwRTRkY1NVSTMxeWo1Snl3?=
 =?utf-8?B?ZWJBelpRM0llWWlBbGNZTS9Qb25kNVB3NnVHQXZXU2lqZHpYV2NvSE91WEFL?=
 =?utf-8?B?TkxNaW9Ic3c4WDl3VlVkcmdpQVZoUlNqa05uK09iV2dydUl5MzVFQWVteTZ5?=
 =?utf-8?B?U2c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2b9689-17f7-4dec-dcd1-08dd581588a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 16:32:46.6041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vV2g0kahu4JyNGSqtYdkELpPs05EngoV1qWrnLN4ultcsQx6Vd1z/qb0RM8Vqe98lsoC21pl09OAg2drTi7H303HZ8QdNpErOP6rpRbhKc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12809

SGkgR2VlcnQsDQoNCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogMjggRmVicnVhcnkgMjAyNSAxNTo1Nw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0IDMvN10gZHQtYmluZGluZ3M6IGRtYTogcnotZG1hYzogRG9jdW1lbnQgUlovVjJIKFAp
IGZhbWlseSBvZiBTb0NzDQo+IA0KPiBIaSBGYWJyaXppbywNCj4gDQo+IE9uIEZyaSwgMjggRmVi
IDIwMjUgYXQgMTY6MzgsIEZhYnJpemlvIENhc3Rybw0KPiA8ZmFicml6aW8uY2FzdHJvLmp6QHJl
bmVzYXMuY29tPiB3cm90ZToNCj4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRA
bGludXgtbTY4ay5vcmc+DQo+ID4gPiBPbiBGcmksIDI4IEZlYiAyMDI1IGF0IDE1OjU1LCBGYWJy
aXppbyBDYXN0cm8NCj4gPiA+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+IHdyb3Rl
Og0KPiA+ID4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5v
cmc+DQo+ID4gPiA+ID4gT24gVGh1LCAyNyBGZWIgMjAyNSBhdCAxOToxNiwgRmFicml6aW8gQ2Fz
dHJvDQo+ID4gPiA+ID4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+
ID4gPiA+ID4gPiA+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5v
cmc+DQo+ID4gPiA+ID4gPiA+IFNlbnQ6IDI0IEZlYnJ1YXJ5IDIwMjUgMTI6NDQNCj4gPiA+ID4g
PiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAzLzddIGR0LWJpbmRpbmdzOiBkbWE6IHJ6LWRt
YWM6IERvY3VtZW50IFJaL1YySChQKSBmYW1pbHkgb2YgU29Dcw0KPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiBPbiBUaHUsIDIwIEZlYiAyMDI1IGF0IDE2OjAxLCBGYWJyaXppbyBDYXN0cm8N
Cj4gPiA+ID4gPiA+ID4gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4gd3JvdGU6DQo+
ID4gPiA+ID4gPiA+ID4gRG9jdW1lbnQgdGhlIFJlbmVzYXMgUlovVjJIKFApIGZhbWlseSBvZiBT
b0NzIERNQUMgYmxvY2suDQo+ID4gPiA+ID4gPiA+ID4gVGhlIFJlbmVzYXMgUlovVjJIKFApIERN
QUMgaXMgdmVyeSBzaW1pbGFyIHRvIHRoZSBvbmUgZm91bmQgb24gdGhlDQo+ID4gPiA+ID4gPiA+
ID4gUmVuZXNhcyBSWi9HMkwgZmFtaWx5IG9mIFNvQ3MsIGJ1dCB0aGVyZSBhcmUgc29tZSBkaWZm
ZXJlbmNlczoNCj4gPiA+ID4gPiA+ID4gPiAqIEl0IG9ubHkgdXNlcyBvbmUgcmVnaXN0ZXIgYXJl
YQ0KPiA+ID4gPiA+ID4gPiA+ICogSXQgb25seSB1c2VzIG9uZSBjbG9jaw0KPiA+ID4gPiA+ID4g
PiA+ICogSXQgb25seSB1c2VzIG9uZSByZXNldA0KPiA+ID4gPiA+ID4gPiA+ICogSW5zdGVhZCBv
ZiB1c2luZyBNSUQvSVJEIGl0IHVzZXMgUkVRIE5PL0FDSyBOTw0KPiA+ID4gPiA+ID4gPiA+ICog
SXQgaXMgY29ubmVjdGVkIHRvIHRoZSBJbnRlcnJ1cHQgQ29udHJvbCBVbml0IChJQ1UpDQo+ID4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBGYWJyaXppbyBDYXN0
cm8gPGZhYnJpemlvLmNhc3Ryby5qekByZW5lc2FzLmNvbT4NCj4gPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+ID4gPiB2MS0+djI6DQo+ID4gPiA+ID4gPiA+ID4gKiBSZW1vdmVkIFJaL1YySCBETUFD
IGV4YW1wbGUuDQo+ID4gPiA+ID4gPiA+ID4gKiBJbXByb3ZlZCB0aGUgcmVhZGFiaWxpdHkgb2Yg
dGhlIGBpZmAgc3RhdGVtZW50Lg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBUaGFua3Mg
Zm9yIHRoZSB1cGRhdGUhDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9yZW5lc2FzLHJ6LWRtYWMueWFtbA0K
PiA+ID4gPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
bWEvcmVuZXNhcyxyei1kbWFjLnlhbWwNCj4gPiA+ID4gPiA+ID4gPiBAQCAtNjEsMTQgKzY2LDIy
IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gPiA+ID4gICAgJyNkbWEtY2VsbHMnOg0KPiA+ID4g
PiA+ID4gPiA+ICAgICAgY29uc3Q6IDENCj4gPiA+ID4gPiA+ID4gPiAgICAgIGRlc2NyaXB0aW9u
Og0KPiA+ID4gPiA+ID4gPiA+IC0gICAgICBUaGUgY2VsbCBzcGVjaWZpZXMgdGhlIGVuY29kZWQg
TUlEL1JJRCB2YWx1ZXMgb2YgdGhlIERNQUMgcG9ydA0KPiA+ID4gPiA+ID4gPiA+IC0gICAgICBj
b25uZWN0ZWQgdG8gdGhlIERNQSBjbGllbnQgYW5kIHRoZSBzbGF2ZSBjaGFubmVsIGNvbmZpZ3Vy
YXRpb24NCj4gPiA+ID4gPiA+ID4gPiAtICAgICAgcGFyYW1ldGVycy4NCj4gPiA+ID4gPiA+ID4g
PiArICAgICAgRm9yIHRoZSBSWi9BMUgsIFJaL0ZpdmUsIFJaL0cye0wsTEMsVUx9LCBSWi9WMkws
IGFuZCBSWi9HM1MgU29DcywgdGhlIGNlbGwNCj4gPiA+ID4gPiA+ID4gPiArICAgICAgc3BlY2lm
aWVzIHRoZSBlbmNvZGVkIE1JRC9SSUQgdmFsdWVzIG9mIHRoZSBETUFDIHBvcnQgY29ubmVjdGVk
IHRvIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICBETUEgY2xpZW50IGFuZCB0aGUgc2xhdmUg
Y2hhbm5lbCBjb25maWd1cmF0aW9uIHBhcmFtZXRlcnMuDQo+ID4gPiA+ID4gPiA+ID4gICAgICAg
IGJpdHNbMDo5XSAtIFNwZWNpZmllcyBNSUQvUklEIHZhbHVlDQo+ID4gPiA+ID4gPiA+ID4gICAg
ICAgIGJpdFsxMF0gLSBTcGVjaWZpZXMgRE1BIHJlcXVlc3QgaGlnaCBlbmFibGUgKEhJRU4pDQo+
ID4gPiA+ID4gPiA+ID4gICAgICAgIGJpdFsxMV0gLSBTcGVjaWZpZXMgRE1BIHJlcXVlc3QgZGV0
ZWN0aW9uIHR5cGUgKExWTCkNCj4gPiA+ID4gPiA+ID4gPiAgICAgICAgYml0c1sxMjoxNF0gLSBT
cGVjaWZpZXMgRE1BQUNLIG91dHB1dCBtb2RlIChBTSkNCj4gPiA+ID4gPiA+ID4gPiAgICAgICAg
Yml0WzE1XSAtIFNwZWNpZmllcyBUcmFuc2ZlciBNb2RlIChUTSkNCj4gPiA+ID4gPiA+ID4gPiAr
ICAgICAgRm9yIHRoZSBSWi9WMkgoUCkgU29DIHRoZSBjZWxsIHNwZWNpZmllcyB0aGUgUkVRIE5P
LCB0aGUgQUNLIE5PLCBhbmQgdGhlDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgIHNsYXZlIGNoYW5u
ZWwgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXJzLg0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICBiaXRz
WzA6OV0gLSBTcGVjaWZpZXMgdGhlIFJFUSBOTw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiBTbyBSRVFfTk8gaXMgdGhlIG5ldyBuYW1lIGZvciBNSUQvUklELg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVGhlc2UgYXJlIGRvY3VtZW50ZWQgaW4gVGFibGUgNC43LTIyICgiRE1BIFRyYW5zZmVy
IFJlcXVlc3QgRGV0ZWN0aW9uDQo+ID4gPiA+ID4gT3BlcmF0aW9uIFNldHRpbmcgVGFibGUiKS4N
Cj4gPiA+ID4NCj4gPiA+ID4gUkVRX05PIGlzIGRvY3VtZW50ZWQgaW4gYm90aCBUYWJsZSA0Ljct
MjIgYW5kIGluIFRhYmxlIDQuNi0yMyAoY29sdW1uIGBETUFDIE5vLmApLg0KPiA+ID4NCj4gPiA+
IEluZGVlZC4gQnV0IG5vdCBmb3IgYWxsIG9mIHRoZW0uIEUuZy4gUlNQSSBpcyBtaXNzaW5nLCBJ
SUMgaXMgcHJlc2VudC4NCj4gPg0KPiA+IEkgY2FuIHNlZSB0aGUgUlNQSSByZWxhdGVkIGBSRVEg
Tm8uYCBpbiB0aGUgdmVyc2lvbiBvZiB0aGUgbWFudWFsIEkgYW0gdXNpbmcsDQo+ID4gYWx0aG91
Z2ggb25lIG11c3QgYmUgdmVyeSBjYXJlZnVsIHRvIGxvb2sgYXQgdGhlIHJpZ2h0IGVudHJ5IGlu
IHRoZSB0YWJsZSwNCj4gPiBhcyB0aGUgdGFibGUgaXMgcXVpdGUgYmlnLCBhbmQgdGhlIGVudHJp
ZXMgYXJlIG9yZGVyZWQgYnkgYFNQSSBOby5gLg0KPiA+DQo+ID4gRm9yIHNvbWUgZGV2aWNlcywg
dGhlIFNQSSBudW1iZXJzIGFyZSBub3QgY29udGlndW91cyB0aGVyZWZvcmUgdGhlIGRldmljZSBz
cGVjaWZpYw0KPiA+IGJpdHMgbWF5IGVuZCB1cCBzY2F0dGVyZWQuDQo+ID4gRm9yIGV4YW1wbGUs
IGZvciBgTmFtZWAgYFJTUElfQ0gwX3NwX3J4aW50cGxzX25gIChtaW5kIHRoYXQgdGhlIGBwbHNf
bmAgc3Vic3RyaW5nDQo+ID4gaXMgb24gYSBuZXcgbGluZSBpbiB0aGUgdGFibGUpIHlvdSBjYW4g
c2VlIGZyb20gVGFibGUgNC42LTIzIHRoYXQNCj4gPiBpdHMgYERNQUMgTm8uYCBpcyAxNDAgKGFz
IHlvdSBzYWlkLCBpbiBkZWNpbWFsLi4uKS4NCj4gDQo+IFRoYW5rcywgSSBoYWQgbWlzc2VkIGl0
IGJlY2F1c2UgdGhlIFJTUEkgaW50ZXJydXB0cyBhcmUgc3ByZWFkIGFjcm9zcw0KPiB0d28gcGxh
Y2VzLi4uDQo+IA0KPiA+ID4gQW5kIHRoZSBudW1iZXJzIGFyZSBzaG93biBpbiBkZWNpbWFsIGlu
c3RlYWQgb2YgaW4gaGV4IDstKQ0KPiA+ID4NCj4gPiA+ID4gPiA+IEl0J3MgY2VydGFpbmx5IHNp
bWlsYXIuIEkgd291bGQgc2F5IHRoYXQgUkVRX05PICsgQUNLX05PIGlzIHRoZSBuZXcgTUlEX1JJ
RC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gKyAgICAgIGJpdHNbMTA6MTZdIC0gU3Bl
Y2lmaWVzIHRoZSBBQ0sgTk8NCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gVGhpcyBpcyBh
IG5ldyBmaWVsZC4NCj4gPiA+ID4gPiA+ID4gSG93ZXZlciwgaXQgaXMgbm90IGNsZWFyIHRvIG1l
IHdoaWNoIHZhbHVlIHRvIHNwZWNpZnkgaGVyZSwgYW5kIGlmIHRoaXMNCj4gPiA+ID4gPiA+ID4g
aXMgYSBoYXJkd2FyZSBwcm9wZXJ0eSBhdCBhbGwsIGFuZCB0aHVzIG5lZWRzIHRvIGJlIHNwZWNp
ZmllZCBpbiBEVD8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJdCBpcyBhIEhXIHByb3BlcnR5
LiBUaGUgdmFsdWUgdG8gc2V0IGNhbiBiZSBmb3VuZCBpbiBUYWJsZSA0LjYtMjcgZnJvbQ0KPiA+
ID4gPiA+ID4gdGhlIEhXIFVzZXIgTWFudWFsLCBjb2x1bW4gIkFjayBObyIuDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBUaGFua3MsIGJ1dCB0aGF0IHRhYmxlIG9ubHkgc2hvd3MgdmFsdWVzIGZvciBT
UERJRiwgU0NVLCBTU0lVIGFuZCBQRkMNCj4gPiA+ID4gPiAoZm9yIGV4dGVybmFsIERNQSByZXF1
ZXN0cykuICBUaGUgbW9zdCBmYW1pbGlhciBETUEgY2xpZW50cyBsaXN0ZWQNCj4gPiA+ID4gPiBp
biBUYWJsZSA0LjctMjIgYXJlIG1pc3NpbmcuICBFLmcuIFJTUEkwIHVzZXMgUkVRX05PIDB4OEMv
MHg4RCwgYnV0DQo+ID4gPiA+ID4gd2hpY2ggdmFsdWVzIGRvZXMgaXQgbmVlZCBmb3IgQUNLX05P
Pw0KPiA+ID4gPg0KPiA+ID4gPiBPbmx5IGEgaGFuZGZ1bCBvZiBkZXZpY2VzIG5lZWQgaXQuIEZv
ciBldmVyeSBvdGhlciBkZXZpY2UgKGFuZCB1c2UgY2FzZSkgb25seSB0aGUNCj4gPiA+ID4gZGVm
YXVsdCB2YWx1ZSBpcyBuZWVkZWQuDQo+ID4gPg0KPiA+ID4gVGhlIGRlZmF1bHQgdmFsdWUgaXMg
UlpWMkhfSUNVX0RNQUNfQUNLX05PX0RFRkFVTFQgPSAweDdmPw0KPiANCj4gSWYgeW91IHRha2Ug
dGhpcyBvdXQsIGhvdyB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIEFDS19OTyA9IDAgYW5kDQo+IHRo
ZSBkZWZhdWx0Pw0KDQpJIGFtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLCBz
byBteSBhbnN3ZXIgaGVyZSBtYXkgYmUgY29tcGxldGVseSBvZmYuDQoNCkFDSyBOby4gMCBjb3Jy
ZXNwb25kcyB0byBTUERJRiwgQ0gwLCBUWCwgd2hpbGUgQUNLIE5vLiAweDdGIGlzIG5vdCB2YWxp
ZC4NCg0KTXkgdW5kZXJzdGFuZGluZyBvZiB0aGlzIGlzIHRoYXQgdGhlcmUgaXMgYSBEQUNLX1NF
TCBmaWVsZCBwZXIgQUNLIE5vICgyMyBJQ1VfRE1BQ0tTRUxrDQpyZWdpc3RlcnMsIDQgREFDS19T
RUwgZmllbGRzIHBlciBJQ1VfRE1BQ0tTRUxrIHJlZ2lzdGVycyAtPiAyMyAqIDQgPSA5MiBEQUNL
X1NFTCBmaWVsZHMpLA0KdG8gbWF0Y2ggdGhlIDkyIEFDSyBudW1iZXJzIGxpc3RlZCBpbiBUYWJs
ZSA0LjYtMjcuDQoNCkVhY2ggREFDS19TRUwgZmllbGQgc2hvdWxkIGNvbnRhaW4gdGhlIGdsb2Jh
bCBjaGFubmVsIGluZGV4ICg1IERNQUNzLCAxNiBjaGFubmVscyBwZXIgRE1BQw0KLT4gNSAqIDE2
ID0gODAgY2hhbm5lbHMgaW4gdG90YWwpIGFzc29jaWF0ZWQgdG8gdGhlIEFDSyBOby4NCklmIERB
Q0tfU0VMIGNvbnRhaW5zIGEgdmFsaWQgY2hhbm5lbCBudW1iZXIgKDAtNzkpLCB0aGVuIHRoZSBj
b3JyZXNwb25kaW5nIHNpZ25hbA0KZ2V0cyBjb250cm9sbGVkIGFjY29yZGluZ2x5LCBvdGhlcndp
c2UgYSBmaXhlZCBvdXRwdXQgaXMgZ2VuZXJhdGVkIGluc3RlYWQuDQoNCk1pbmQgdGhhdCB0aGUg
Y29kZSBJIHNlbnQgd2Fzbid0IGRlYWxpbmcgd2l0aCBpdCBwcm9wZXJseSwgYnV0IHdhc24ndCBz
cG90dGVkIGR1ZQ0KdG8gbGltaXRlZCB0ZXN0aW5nIGNhcGFiaWxpdGllcywgYW5kIGl0J3Mgc2Fm
ZSB0byB0YWtlIG91dCwgYXMgdGhlIERBQ0tfU0VMIGZpZWxkcw0Kd2lsbCBhbGwgY29udGFpbiBp
bnZhbGlkIGNoYW5uZWwgbnVtYmVycyBieSBkZWZhdWx0Lg0KDQpMb29raW5nIGFoZWFkLCB0aGVy
ZSBpcyBhIHNpbWlsYXIgc2NlbmFyaW8gd2l0aCB0aGUgVEVORCBzaWduYWxzIGFzIHdlbGwuDQoN
ClNvIGZvciBub3cgdGhlIHBsYW4gaXMgdG8gdXBzdHJlYW0gc3VwcG9ydCBmb3IgbWVtb3J5L21l
bW9yeSBhbmQgZGV2aWNlL21lbW9yeSAoUkVRIE5vLiwNCnRlc3RlZCB3aXRoIFJTUEkpLCBhZGQg
c3VwcG9ydCBmb3IgQUNLIE5vIGxhdGVyIChwZXJoYXBzIHRlc3RpbmcgaXQgd2l0aCBhdWRpbywg
b3IgdmlhDQphbiBleHRlcm5hbCBkZXZpY2UpLCBhbmQgZmluYWxseSBURU5EIE5vIGlmIHdlIGdl
dCB0byBpdC4NCg0KVGhhbmtzIQ0KDQpGYWINCg0KPiANCj4gPiA+IFdoaWNoIEkgYmVsaWV2ZSBh
bHJlYWR5IGNhdXNlcyB5b3UgdG8gcnVuIGludG8gdGhlIG91dC1vZi1yYW5nZSBETUFDS1NFTGsN
Cj4gPiA+IHJlZ2lzdGVyIG9mZnNldCBpbiByenYyaF9pY3VfcmVnaXN0ZXJfZG1hX3JlcV9hY2so
KT8NCj4gPiA+DQo+ID4gPiA+IEJ1dCBJJ2xsIHRha2UgdGhpcyBvdXQgZm9yIG5vdywgdW50aWwg
d2UgZ2V0IHRvIHN1cHBvcnQgYSBkZXZpY2UgdGhhdCBhY3R1YWxseQ0KPiA+ID4gPiBuZWVkcyBB
Q0sgTk8uDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBs
b3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnDQo+IA0KPiBJ
biBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15
c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBq
dXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

