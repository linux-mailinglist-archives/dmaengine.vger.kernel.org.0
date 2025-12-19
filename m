Return-Path: <dmaengine+bounces-7848-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF984CD2269
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 23:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766EF301A727
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 22:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EB228CF5D;
	Fri, 19 Dec 2025 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="uTo5bpXD"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615C218821;
	Fri, 19 Dec 2025 22:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766185142; cv=fail; b=Lf2hOe5wlBJlty1Gkv6vJgqY70ik+xtOVZU+lAMvqI/pqQSZZwZamdxXEA7RJRxNKGqYG1/49bWSKqPwB6Z5a0lDMaoguXnhVMSf2uM9oL9gF4xpenI6jTnDMRnJ7NzJQ+DKQf/S0WAjD0iifqj7wWUjk9rcM3Y7mWm1IOl8otA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766185142; c=relaxed/simple;
	bh=jwNTOhzGitOLQv0vAjXDStezhPrqc2jXsPbwEfhxpVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hw7QYTKGjinM0iu2mjvgSHY/EzQIMe2QKaTBcFYZtNkKdEYUV7rXR0aj0s7U6nG5JrSn5Qp0540/GIMDL0OyoQtCLEnsD7jpEPqp7JxqcVVf9Jk+Gi1z7gGCzFotSczWotzUKtHjXUPW5hASEz9uUtotxIOM9dkRWPS5YXL1hjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=uTo5bpXD; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIwGOz8webrlj0iu0a5vLrK+3iNAXESpzmXoj7AIZGN5tDZ29aVP/1+71BDSKjNVkSSJEkR1Pz8lb+FOpK2bgKp2/h1ZRGLA4GeLLMIFkfy62Epegxgg14+XvJo2JVDltO7+HjWskVOzoWJTpOk3VWmVCpzc1kFnJneuYgVvBZ9ASiHm9nj+7AMoDs9zTaFzuXHWZwDraWWTwzTM0IOYMUYYPaZm2rWKvWuqKwdE2fKOjAn2TjWQf37mbGPjDZgi/Gf0LbQQQegZviQsCgRlyZStZBUIJY/ouqw8Oh6SU6yTpTHqZHGw6422bwxaL8fQ0DgXCD5QP8DCaIlc3Z/yrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwNTOhzGitOLQv0vAjXDStezhPrqc2jXsPbwEfhxpVQ=;
 b=lGtcBXyjVljdSZAICnGtJEghEYE6fZQClFSbkGjXwsKFlkzl+Cnpz8f6WuI17jUqPloLQh2Xq0ISv3l5elLGY9WbzoYONATegv52STuAykJxjj2PXPKSjIWFsDeG3fmfACmszgFuKv0WMQIJRrCaUZnHI7qocUIxb7jcM/0QJ57hePGyDiU+9QT0Q1i0kmPR57WKbdR3Fw7dFS+gpzfKW9jwlz/1KQEyhSIfuABHxF4KL6Itqi11pegvb6KmFi5QdIJGTiE+MFan+4lDMqaHVms45P6AhTGdEFIGI4oEkbG+TA9SlwFonE2miL7xCS6sDW2MYiFhTT3PZE2Xk4WLug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwNTOhzGitOLQv0vAjXDStezhPrqc2jXsPbwEfhxpVQ=;
 b=uTo5bpXD1m8i/j/Afl9NsBW916t+7+heGMrgIqyKd3LjqOn041cHfgkhjeTkNpEopT00zCk20RUTTEYUUUumnc+bLkZApzOARibDEMvpwwqy0n4rgIGdVeOTkjVxZbGL7k610rTeBYRZfuix8MnmhRn/Llu03EYz8bS1JZutkJeKa4POceiAGTTRRRn8AzaJJcpIEBUhORt/iUc9VTq40H28dj2SUz0hUog9VIMKCxluuH6aK/kc0oHnpHFTkByZDt5NK8mKvsXxXiD4nAimC46XBLKvSOz2q2GDLSHxlMnbGMOzii4Ki7y9A6gx34BSoLguffKhdZKTlrGl6DLrMA==
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by MW4PR03MB6330.namprd03.prod.outlook.com (2603:10b6:303:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Fri, 19 Dec
 2025 22:58:57 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 22:58:57 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Rob Herring <robh@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Eugeniy Paltsev
	<Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
Thread-Topic: [PATCH v4 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
Thread-Index: AQHcbuNrE5U9tUZTAUaUtr72x5+JLrUpc2qAgAAk6gA=
Date: Fri, 19 Dec 2025 22:58:57 +0000
Message-ID: <c159352d-3ca4-44ba-89ee-e37b167211e6@altera.com>
References: <cover.1765845252.git.khairul.anuar.romli@altera.com>
 <bce96511426a3c63d32530e359c7d966a7321679.1765845252.git.khairul.anuar.romli@altera.com>
 <20251219204649.GA3902569-robh@kernel.org>
In-Reply-To: <20251219204649.GA3902569-robh@kernel.org>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR03MB8447:EE_|MW4PR03MB6330:EE_
x-ms-office365-filtering-correlation-id: c16feb94-319e-4eb6-3ade-08de3f5230c5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUVxT1llb2g1dTZFeWFKTktDbUgvU0NWWlozbVhWa1kxaThvSmtNQWNrMDMv?=
 =?utf-8?B?V0Z0YmRkL2FyZFdVTlJQRHNrbDFUUGVrd0dBNWJrVGsyNzJkdjcrbG9DQzJ4?=
 =?utf-8?B?Z0xqTFhqWmhuYjBhMnkvbldNdGJtSTFvUW00TSs5SnYwRVBTUWIzcWxUaDZ4?=
 =?utf-8?B?ZHg5MWhtaVhIb2pUc1dWTFNaU1JJNU5ZUHk0SjB4QnZNSDZrTHF0MEQrV3F6?=
 =?utf-8?B?WEwzdlo4cFlVZ1VLNFVIS3hrb1B4R2UzZjVXbXljTmMrUkx0bWlCZ1FHQUtK?=
 =?utf-8?B?VGpJekVGOEVGNjlKbjJnWFhyWldtUkhBdXl2VDg0d3FMeUJhTzJGQktYOVR0?=
 =?utf-8?B?WXRhbGs5MUl5dFc0N1UyU1JBVjBNVy8zdHBPUUd2LzdzWTA1RFFLSnVsNTUv?=
 =?utf-8?B?aDZDWjgwbXBZbVgzcyt6ampiL3ZGcVlxTk9CQk41ME5mTUlXOWFIQ1ZjQ1hO?=
 =?utf-8?B?eTcvU3RsUDFZMnFOTys5WU1mclY0RTUwdlZSVklOZ1FUNE8rMXBuTUlMam1N?=
 =?utf-8?B?VDNBZ3BrY1FjcTUxcFE1eHRzdVRlcWRlcSs3RG1lWUtVQjNtREJMM3BRN1lz?=
 =?utf-8?B?dHBZVklJUlRYYWFHVU1WSHBPTjhQZUI4NVNOUDhxeFhxam4yajNBa05EYUts?=
 =?utf-8?B?cTZ5NzV3dEZad2xxNjAwc20wQkhsenBlQWdvR2crS1RaN1hKN2d3cUIyZzBn?=
 =?utf-8?B?elZhQWxnckhsS0syMmJpRHBNZURkbTc2N3diVlgxNElacElkR2czd0xnK25q?=
 =?utf-8?B?OGIrVjVoYzczQWw5TXEzN04ram1xZFVvYlNVUElKVXRqR2ZoWGtGSHpvRWlt?=
 =?utf-8?B?N0p3NnZZK0VGd2t5QkZnblBYd1hIdUYxaW9TTGdiTmxSRFl1V2tGRTdURVNR?=
 =?utf-8?B?NkRic010SXFmazBFeUN3UVRtVlpmQWt6K1RZVEtIc1k2OEl1STRBREQ3blls?=
 =?utf-8?B?b0trSDZOTkVuQjJTdkt0SUF3VjJzZVN0UmNaTzlIK0dSWjZGU0dzZEZ1Z2xM?=
 =?utf-8?B?Yk1Ud1h2dTRtR2lKaFlKcFJjR0o5RDZ5SlF5aXNxdzdmZVgwa0tRTXhzTmVB?=
 =?utf-8?B?aDFvOVdoNGlQeFRIUlVQTndtN0R5WVE0SndUbzd6NCtodHBqa0FOOUkxOXQz?=
 =?utf-8?B?eWh6akVqOVRlak5UekJZSjBMQTZ5RTU2Yjc0SDMzekRZcXY5NnNUVWF0MTJ5?=
 =?utf-8?B?WVBqS0drakVOVTI2UnJSMXR1Yklvb2JQTW1Sbm5nNUpRZmVmWG5jcWIzUXQy?=
 =?utf-8?B?SDhnYXNzbGlmRlVic2dQLzc0cnFENjlRdjJwdS9tVzhIU3AwWTU3N0hueTdq?=
 =?utf-8?B?OEdMcDBQWExpRUtKTW52djdiZUNhTTdZRURCSE1qYjloWE10d2ZkM3hpNWtq?=
 =?utf-8?B?MTB4L1c3OVo3amo4UEtpK0Job1U5elFaSmR1ZmxHam9JNEpDL2FHREl4THhl?=
 =?utf-8?B?azFVMzE3VGdYaXdoY05OREUrM2Y4NXZ0M2p3RGVyaVNERDBMVzFDZUNIclVV?=
 =?utf-8?B?cFRPZzlVUkc4VEZBYUsxdXNOYTF2TTY0YjBLZHFKSnBUclFoa2YrK1R4OHky?=
 =?utf-8?B?SlJkeW9ncktwZENSanI4MlQzQTM5azBjbUlJMEpJeE8vZlFGQS9PT1kwNHE4?=
 =?utf-8?B?cDJ4c3h6Uk9SOHp3d1VLYmNZQ2czVkxHUCtEaWdERjlScWliNEtPbDNSOXY0?=
 =?utf-8?B?Z1VwQUJHc1dRZUwyb0REQnh3em9wZkdJNk5XSVJHK0E3a3RCclNjZFVPQjlz?=
 =?utf-8?B?R1pSaW1xMUZEeDVNdmF5SzBzMkdZOEppV2QwSzVJU3NEYzBZZWRnMEZKVGF2?=
 =?utf-8?B?RlVBR1dhOTlOd3JQak9sbTI3TldDUEltY3JhaXpnOVkzRmYvbVlYZmhITVR3?=
 =?utf-8?B?Qk9zTENkMmtzMDdRMGZ4TWtIcnRaZ2RrN3RLMTE4WmlrV0J5dGR4NW1Ca3ZL?=
 =?utf-8?B?ejA3czA5YldlbFA1RWs4SDRwUVc1N3MvNEczVHFZSkJocndnT0pYeGs2WExq?=
 =?utf-8?B?TkdSdE05T201RTMwY2Jra2VGMnBxdFhySm5RTzVydnlwY05UclRFZFRXTTRT?=
 =?utf-8?Q?pvJjJ6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmNBL0xNZVFSdzU1NVhVRUVUVzdYMjVRWThMK1Q2SGp0SDFoWnVoYmt4ZTlR?=
 =?utf-8?B?ZFZtN0Z2eVZwUm40ODM4d3lYcHZiUzYrcUo2dG9PSHpyZlVxaVJpVDg2SzNo?=
 =?utf-8?B?N200VDFLejErczVXTVN5WXB5T2Q1Tkx1emswMXBEQS85YkU1Mm81Q05KbGNZ?=
 =?utf-8?B?c0pKOWFyUnJzRmZiV3VRTHFxUy9MVXA4QWNCaTMwdjlHS1hGbkZ5T29rck5C?=
 =?utf-8?B?UzgrR1FXTnppVTJySjdOVzdBVmx4azgzZUJmcmVON1ZXTW9Ia1ExOGtRcnJZ?=
 =?utf-8?B?cU1MNkpHK09iRlFoVW9wZWsrRWRRQWFNVHV2MnRWNjNiUk1IUU1yTmpVeUcr?=
 =?utf-8?B?T2V6VUxtT3UzdW5NdXJQNkczLzU1R3kwdjN1TWNsL3lsQzhhVml5OHc1NTYz?=
 =?utf-8?B?cEhJL2tMNzhsRzhLQmMxdDdmeEthNStNYWI2VGlaRy9ZK0k1ekk0N3JRaE1t?=
 =?utf-8?B?c1RBd2ZMUG9qd0N5bTN3VjM0OGQ3QXZST0J1YjVTOXUvSWhPaWx2bXU0SmNY?=
 =?utf-8?B?ZWg2bGo3ZEk1bWNVYnc1RmcxM3FtSmNTS0NFWHova3V3dzdjUTZpdk44YUtW?=
 =?utf-8?B?M3d0SExiRlBUeU4xTzVlQUZjUXFGZjZUQ3RDaml5SEZoNDVDWkVleW82Nld2?=
 =?utf-8?B?UUhhY3J1RjhhSW4vd1dPV2lrKy9odG15QzlubjFNQ0taZ1hiWE5jU01zbERn?=
 =?utf-8?B?NUUrSG1Ydy8yRzlSODluSXd0WG4zQjhaMVZoSWdoRlNUbkdabFFCZ0hKSHJl?=
 =?utf-8?B?OEFQMjRRR1pDT21ONTBLc2lQajNuYTdwRm9YRVZuaWc2OGwzeEZKbjNka1ZN?=
 =?utf-8?B?TEdzVERCbENjMWZyWmJTSmVycm5hdE5samUzK1NBcFRQTmJrZFN6NXd4L3lX?=
 =?utf-8?B?VVFqWVlkYTJwM1JaL01JY1Fic2lwYUJpY0ZlNEdEUWFHVW13b1MrRjBxWmpv?=
 =?utf-8?B?N1NtcXlKNjJEbC9hUDBzeEN6R0R4NGxCWjMzV3k5UktBdEVVRGY1WVlvYmZC?=
 =?utf-8?B?RVhVZlZFQUNRVzJWWk9CTlRzUjdGR0Rqb0hvNXJoOTJCYWF5ZEcyT3JLaGdT?=
 =?utf-8?B?Q1d3M1JacjRubXZhQXlDdVBaSFhMYThHT3ZEZnh6cGtJMzFQZisrSXRBRmgy?=
 =?utf-8?B?SEtzKy9lUzNQSnFOajlCaVNKY05SUHZxMDNSVEROYnl0Ky9wR1AyT25GT1F3?=
 =?utf-8?B?Lyt3ZEJiek40eFhHV05PTExsMXJvTjQ2T3phQ3BtQUEvZzlkUGphYUZhVEpC?=
 =?utf-8?B?Qit5MFVXZUkrMGJJeGYzbGswVkZXK0ROQnlHazU3NnV1QUowdHRiM0k4QjBL?=
 =?utf-8?B?OUIvaHg1N295WHcySkIydW84VnRoR1pQRWFYR3ZVVUlzM0pKYVA0QTBzTlBW?=
 =?utf-8?B?VW5FV001a1VkK2d3YlNQMFBIWC92YVFGN2NwclhZdTJoWnVlNVJORDMyMW5v?=
 =?utf-8?B?Q3JxVkJOTnFUTWlsTWpkSDlhN0puV2xGMTJTT2pxZ1F3ZHFWSWVxU0lGc0NV?=
 =?utf-8?B?KzRib0wxQ3NVbGk1NUVWeS9ucHNyOXN5VW1qeVNwUUpUK21sMVdYOUQxTndC?=
 =?utf-8?B?RTIweTNGMGU0Rmk2NXV0RlRYZUxzVFZRYW1YeE9xL0pUeXFNS2NSU25uTGwx?=
 =?utf-8?B?Z1haVEJzMDdrQyswQm9RTk9uc055aWRwZyswU3Q1eU1VOVdCemhtVVRQbTN2?=
 =?utf-8?B?NFNjTkx6bE5HSWowRVVLOEU0VnhkRGgrdGc1NnRSekZKL2w0RWpYOStTbys5?=
 =?utf-8?B?aDluUnM4MDQ4MWovcHV2MURDcUt1a05iYWZaclBpLzJHaytjVFlaRkcrdVFI?=
 =?utf-8?B?b3puU0E3dEtvVWErYk9qV2tVWVduSmZZWUJlcmNHTEY2bEcyWDBBZHk0OUpq?=
 =?utf-8?B?MmRGcEYzVHV4RVVjZUhFRjdHTEpQSzllTkpjallCY1ZYdHowWXNXMlpDZkJl?=
 =?utf-8?B?MUd2K094YUNGZy82Um5MdnJzRnVOUlBDL3hSYy8yK09KUk5MMkRPOEM5Y0Qr?=
 =?utf-8?B?Q01DcjdEZ1A1Wkw1UmEydjhMQVNuMitZM0krYmxlb3A0dHRNMFhTb1pvd3Nu?=
 =?utf-8?B?ZHJiQzk3U2I1Zk0wcGdsUTVncGFQOEhna2YrenNPMlBrZ0syMnVOeW1UNVNr?=
 =?utf-8?B?dXN2WEJtZld3UUQxOXRENUhJN3BFLzhJUHM5bVhkdWd1cWZzVlpBUUJJUjdq?=
 =?utf-8?B?REh4aHhySjNlUkJwaDJKUmk1ME83ckFrTVJ0WGZScVRONGtuckVZb3FCYmpi?=
 =?utf-8?B?OUlhK0xWMHdwR3VUUEVkYWN5K2hFMXp6TWlQWit3ODhPWDZxYlRuK1lYRjZn?=
 =?utf-8?B?SUZkczJROUFmNmVBdHlkRDZLV1lrSTgvNmZyU09ZQ1kzcFNiWkY4NnRLbjZm?=
 =?utf-8?Q?Ilt27ZPgegpGg3Fk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B63AAB57B707DD4FB2847DF9A3E22FAF@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16feb94-319e-4eb6-3ade-08de3f5230c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2025 22:58:57.0754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mGehLJODDoZ7q1L3dgijOXq9nRItXuWeviE6+KTq7BPC2PjyvXI9XxPnr6i7U9sPifk66DRg/wzdX/it90ZC7UjYVjKQXlDMOM3n/XNp66g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6330

T24gMjAvMTIvMjAyNSA0OjQ2IGFtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gV2VkLCBEZWMg
MTcsIDIwMjUgYXQgMDc6MjY6MThBTSArMDgwMCwgS2hhaXJ1bCBBbnVhciBSb21saSB3cm90ZToN
Cj4+IEFkZCBkZXZpY2UgdHJlZSBjb21wYXRpYmxlIHN0cmluZyBzdXBwb3J0IGZvciB0aGUgQWx0
ZXJhIEFnaWxleDUgQVhJIERNQQ0KPj4gY29udHJvbGxlci4NCj4+DQo+PiBVc2UgY29tbW9uIGdl
dCAiZG1hLXJhbmdlcyIgcHJvcGVydHkgYW5kIGNhbGN1bGF0ZSB0aGUgYWN0dWFsIG51bWJlciBv
Zg0KPj4gYWRkcmVzc2FibGUgYml0cyAoYnVzIHdpZHRoKSBmb3IgdGhlIERNQSBlbmdpbmUuIFRo
aXMgY2FsY3VsYXRlZCB2YWx1ZSBpcw0KPj4gdGhlbiB1c2VkIHRvIHNldCB0aGUgY29oZXJlbnQg
bWFzayB2aWEgJ2RtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoKScsDQo+PiBhbGxvd2luZyB0aGUg
ZHJpdmVyIHRvIGNvcnJlY3RseSBoYW5kbGUgZGV2aWNlcyB3aXRoIGJ1cyB3aWR0aHMgbGVzcyB0
aGFuDQo+PiA2NCBiaXRzLiBJbml0aWFsaXplIHRoZSBhZGRyZXNzYWJsZSBiaXRzIGRlZmF1bHQg
dG8gNjQgaWYgJ2RtYS1yYW5nZXMnIGlzDQo+PiBub3Qgc3BlY2lmaWVkIG9yIGNhbm5vdCBiZSBw
YXJzZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1bCBBbnVhciBSb21saSA8a2hhaXJ1
bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGluIHY0Og0KPj4g
CS0gU2ltcGxpZnkgdGhlIGNvZGUgdG8gdXNlIGNvbW1vbiBjb2RlIHRvIGdldCBkbWEgcmFuZ2Vz
Lg0KPj4gCS0gTmFycm93IHRoZSBjb2RlIGNoYW5nZXMgb24gaHdfaW5pdC4NCj4+IENoYW5nZXMg
aW4gdjM6DQo+PiAJLSBSZWZhY3RvciB0aGUgY29kZSB0byBhbGlnbiB3aXRoIGRtYSBjb250cm9s
bGVyIGRldmljZSBub2RlIG1vdmUNCj4+IAkgIHRvIDEgbGV2ZWwgZG93bi4NCj4+IENoYW5nZXMg
aW4gdjI6DQo+PiAJLSBBZGQgZHJpdmVyIGltcGxlbWVudGF0aW9uIHRvIHNldCB0aGUgRE1BIEJJ
VCBNQVNUIHRvIDQwIGJhc2VkIG9uDQo+PiAJICBkbWEtcmFuZ2VzIGRlZmluZWQgaW4gRFQuDQo+
PiAJLSBBZGQgZ2x1ZSBmb3IgZHJpdmVyIGFuZCBEVC4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2Rt
YS9kdy1heGktZG1hYy9kdy1heGktZG1hYy1wbGF0Zm9ybS5jIHwgMTYgKysrKysrKysrKysrKysr
LQ0KPj4gICBkcml2ZXJzL2RtYS9kdy1heGktZG1hYy9kdy1heGktZG1hYy5oICAgICAgICAgIHwg
IDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEvZHctYXhpLWRtYWMvZHctYXhpLWRt
YWMtcGxhdGZvcm0uYyBiL2RyaXZlcnMvZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRm
b3JtLmMNCj4+IGluZGV4IGIyMzUzNjY0NWZmNy4uYWM2N2MxOGEwNWMwIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9kbWEvZHctYXhpLWRtYWMvZHctYXhpLWRtYWMtcGxhdGZvcm0uYw0KPj4gKysr
IGIvZHJpdmVycy9kbWEvZHctYXhpLWRtYWMvZHctYXhpLWRtYWMtcGxhdGZvcm0uYw0KPj4gQEAg
LTEyLDYgKzEyLDcgQEANCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPj4gICAjaW5j
bHVkZSA8bGludXgvZG1hZW5naW5lLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9kbWFwb29sLmg+
DQo+PiArI2luY2x1ZGUgPGxpbnV4L2RtYS1kaXJlY3QuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4
L2RtYS1tYXBwaW5nLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4+ICAgI2luY2x1
ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPj4gQEAgLTI2NCwxNCArMjY1LDI1IEBAIHN0YXRpYyBp
bmxpbmUgYm9vbCBheGlfY2hhbl9pc19od19lbmFibGUoc3RydWN0IGF4aV9kbWFfY2hhbiAqY2hh
bikNCj4+ICAgDQo+PiAgIHN0YXRpYyB2b2lkIGF4aV9kbWFfaHdfaW5pdChzdHJ1Y3QgYXhpX2Rt
YV9jaGlwICpjaGlwKQ0KPj4gICB7DQo+PiArCWNvbnN0IHN0cnVjdCBidXNfZG1hX3JlZ2lvbiAq
bWFwID0gTlVMTDsNCj4+ICsJdW5zaWduZWQgaW50IGFkZHJlc3NhYmxlX2JpdHMgPSA2NDsNCj4+
ICAgCWludCByZXQ7DQo+PiArCXU2NCBtYXhfYnVzOw0KPj4gICAJdTMyIGk7DQo+PiAgIA0KPj4g
ICAJZm9yIChpID0gMDsgaSA8IGNoaXAtPmR3LT5oZGF0YS0+bnJfY2hhbm5lbHM7IGkrKykgew0K
Pj4gICAJCWF4aV9jaGFuX2lycV9kaXNhYmxlKCZjaGlwLT5kdy0+Y2hhbltpXSwgRFdBWElETUFD
X0lSUV9BTEwpOw0KPj4gICAJCWF4aV9jaGFuX2Rpc2FibGUoJmNoaXAtPmR3LT5jaGFuW2ldKTsN
Cj4+ICAgCX0NCj4+IC0JcmV0ID0gZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudChjaGlwLT5kZXYs
IERNQV9CSVRfTUFTSyg2NCkpOw0KPj4gKw0KPj4gKwlyZXQgPSBvZl9kbWFfZ2V0X3JhbmdlKGNo
aXAtPmRldi0+b2Zfbm9kZSwgJm1hcCk7DQo+PiArCWlmICghcmV0KSB7DQo+PiArCQltYXhfYnVz
ID0gbWFwLT5kbWFfc3RhcnQgKyBtYXAtPnNpemUgLSAxOw0KPj4gKwkJYWRkcmVzc2FibGVfYml0
cyA9IGZsczY0KG1heF9idXMpOw0KPj4gKwl9DQo+PiArDQo+PiArCWRldl9kYmcoY2hpcC0+ZGV2
LCAiQWRkcmVzc2FibGUgYnVzIHdpZHRoOiAldVxuIiwgYWRkcmVzc2FibGVfYml0cyk7DQo+PiAr
CXJldCA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoY2hpcC0+ZGV2LCBETUFfQklUX01BU0so
YWRkcmVzc2FibGVfYml0cykpOw0KPiANCj4gSSdtIHByZXR0eSBzdXJlIHlvdSBkb24ndCBuZWVk
IHRvIGRvIGFueSBvZiB0aGlzLiBUaGUgY29yZSB3aWxsIG1lcmdlDQo+IHRoZSBkZXZpY2UncyBt
YXNrIHdpdGggdGhlIGJ1cyByYW5nZXMuDQo+IA0KPiBSb2INCg0KU2hhbGwgd2UgZHJvcCB0aGUg
ZW50aXJlIHBhdGNoIHNlcmllcyBvciBvbmx5IGRyb3AgdGhpcyBwYXRjaCBhbmQga2VlcCANCnRo
ZSBiaW5kaW5nIGFuZCBkdHMgcGF0Y2hlcz8NCg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KS2hhaXJ1
bA0K

