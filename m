Return-Path: <dmaengine+bounces-4217-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD059A2049B
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2025 07:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06032166C22
	for <lists+dmaengine@lfdr.de>; Tue, 28 Jan 2025 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7326F19047F;
	Tue, 28 Jan 2025 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lk4FUHqk"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D774A1A;
	Tue, 28 Jan 2025 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738046815; cv=fail; b=fLNlxQ1etyBkQYmn8tlm1lkl362NA5lxNly8k0WSkH27mVqnRVGUXY6glnU3BQN1BJIzzpOdopJB6aqSFvsMrxxaQtngHxRfdFXsI6EAsd02BLShQZuOrwKuW+pceSdeQ2skTLdOA7d7O9ZQX5c9sF6ZiJLrcV+ny+yJgMAA+VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738046815; c=relaxed/simple;
	bh=IdHsrvlQFShzb6TaK4f0bUVuTtLOgRNWtFZgCJhYOM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IPuc6H49PAF+uf5fjHhW2xVuzpEYw8dhF+fB0q4Jb+HArG384Qh6oW8j8iBzS3tkSyEjuqx58BFO8KRTSlRYfiSNQmqDpvfzySnnDa+ouiwYHsVzau3jxsW6XTDFXND+M8IWcJ/NTtUWGdLLf4fbSBkjlmgsZCi8b0Iz5iRvWAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lk4FUHqk; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO0kS2XyxEliV9wkYDyoQn12GYH6Z2CsQjdiFa0ghbmCX2rCI3oCetcDR94+X1Fvrca42Tx2ep3HeEuPMiB3G+QyFEb7K4ERk72myYXBXtsZof8Gcv4Ju9Bg0htNZHWYk81f8oG1k6iE/A6axheEOjGdz8nArPLLTurjgkhf80oJGVqWZaDeybj0FX1TfZKKpkSemn40VkgU7ctsv/k2Gfw0W/2rCgstRq38Andb5/hVO9U9nifsfH8C8eKgk8xGke+kaYP3g5ROd6jbg0OQvQwvylXdAUnT/j+aIciXjS9vvBCupncNN2tmTE2eeUYgxukyKE0/x+RMXEQKUoERcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdHsrvlQFShzb6TaK4f0bUVuTtLOgRNWtFZgCJhYOM4=;
 b=L8ryrMRpHBRlmjlAzwvhfzMzYYuiM+Aj0jmUPMm/Uptd38qebeTIm2HQpwOwBNG/l6PGYqn4IvMarr2Fe5bXGO2xNQaBTU22BwIZzk3NU1sTlUAHYueHIim21maWluiwB5qsSPkZvNI670fj7n5+xITk00ABU9HX2Kt76pIA9dFqdlc6gT47j1A2AVqwPKOnz/VqHyrdQqPnMZkapIRi3aUeq0oZglfpF29vqztGdidnvslERpKkBPMhJHHS/yAaihnDXk/LubPD8udxwhNOWEBR0Un5dAzqGXN1p+nORRvm77Yh7dWsj0jfoEUQdA2In6inQNZL38mTgkeNqxHwyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdHsrvlQFShzb6TaK4f0bUVuTtLOgRNWtFZgCJhYOM4=;
 b=lk4FUHqk9fkMLfAvqEhLm9fhFUfFOGgKbrbuTC7dqiRpJ0+/56VsgkxWnryv3N2EsUwoObqxCPeyQEbgDHXtAQfZjsEev2krZ3PBUqWFJqHg9IWQ6P1MndZEhBcNiIqZeoElddVYd53pmtjpXaIT5SHqeE1wwxqGYc4S1IxphZYWDh42Gke136aal4XErWr9MlywHz0gx2TXnL3wyqAKEC8TbRdskFZD4vGgfhQbbrjayQdGPKafHpW51sY6aYUZ9Gt/RHxieNNfMW4Rw15736a0noHv7JPY7cZdlzgC0WI/fFWvp9UJlasEjmdKOaCtqV5Va9RW0MrhW7OGVoGYtg==
Received: from SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 06:46:50 +0000
Received: from SA3PR11MB7414.namprd11.prod.outlook.com
 ([fe80::c62:b3af:49ff:79e6]) by SA3PR11MB7414.namprd11.prod.outlook.com
 ([fe80::c62:b3af:49ff:79e6%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 06:46:44 +0000
From: <Charan.Pedumuru@microchip.com>
To: <robh@kernel.org>
CC: <Ludovic.Desroches@microchip.com>, <vkoul@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Andrei.Simion@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Durai.ManickamKR@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: dma: convert atmel-dma.txt to YAML
Thread-Topic: [PATCH v3] dt-bindings: dma: convert atmel-dma.txt to YAML
Thread-Index: AQHbcKVhVjSa433gwU6echnpn1RbarMrF7aAgACnx4A=
Date: Tue, 28 Jan 2025 06:46:44 +0000
Message-ID: <7ee1b6cb-f743-4d15-8c90-a3d4fc4eac4d@microchip.com>
References: <20250127-test-v3-1-1b5f5b3f64fc@microchip.com>
 <20250127204613.GA820642-robh@kernel.org>
In-Reply-To: <20250127204613.GA820642-robh@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB7414:EE_|SA2PR11MB4796:EE_
x-ms-office365-filtering-correlation-id: e3aa5a67-99ad-40fc-3009-08dd3f67875f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmFZaVBNeFF6My93Z0hQQk5UUkFLbG05VHRMM2M2a3pZQWVDV1EvYWZtbkky?=
 =?utf-8?B?bXgwZGltUW9ZZlJQR0hKMHZtSXJPcVJSZDYvVkFiek56THdDLzR6c21MRlRD?=
 =?utf-8?B?a1gyRi96bHJYZXRKZTBOdDNicEdjQ2lvZGNQNTdiYjhvdzhQeE5CRmovWTUr?=
 =?utf-8?B?cC9yeGFncU1pRkZSTHl6OWprRE9lODNTNEtmOUpJTWxFWHNIbGs5U2FCZnF2?=
 =?utf-8?B?cVhBSm0wa3dGc21mRm1SWnE2c1plRnRlZ2F3a3BSUmcycWExYzAwZElQbVJq?=
 =?utf-8?B?SEFOOW14MDkyY0d5bEg5b3JSeFBScDdnaTEvMFlkN1V2NzNUbXlzR1FnZTRi?=
 =?utf-8?B?NDVXZU9Va3JlYWVFYUhtMjkrdUxYamRlQk1uK05QZFJOTkdjcGtyOXVHQTlS?=
 =?utf-8?B?clg5Z3pZUnE0dzgvZ2N0bmxYOENHeFZhOU9nVm5RTWphbFozcnlPZE9oNC8y?=
 =?utf-8?B?U2RvUS9hVXFvWkE5SlRGZEFBZjYxZHhkaGRIcGlqV1A0MTV1SlJqR3V6em5V?=
 =?utf-8?B?ZVA2UHZWbFBPRjJrSnRRQm5CSVhuL053cXVjWnp0OER3SDNTV1dxQVYvL08x?=
 =?utf-8?B?a1puQTV3RU55TFdPL2dveFU3M1NRd0ZUTExEb1hYY2VTU2NmSGpnYkJac1FK?=
 =?utf-8?B?RUNZdGFHVEl3SEd4L096RUlyZUkzVkdnZC8rcG8yK002Y0o0M3YzTzI0S00x?=
 =?utf-8?B?WnZsMUtBbS9NWGRtRFl1TWthMnR0TVd6akNuTmxCQm8yTzNZWml3dklpdUs0?=
 =?utf-8?B?Q250b1lYQjExRzNRb2NGeHFYVWZ4QnVSRjJkSU4weExpV24wbXdUb01CQlRo?=
 =?utf-8?B?cFAySFV3cHk4cm1aUWxPdmxCcFNQRkZOeWhxdmpJSmNqTVlleVY3UEd3aWh0?=
 =?utf-8?B?N3JLcEhjdVEzR2JIZUoxRjFsQ0hPazVNTVZUL042MlA1SEZ5OHBtcC94QlIz?=
 =?utf-8?B?VVdtTGNHRkM5Yk1FVHlzVzNRR1dEQnpBRlBlYVVHdy9TaWljaVU3bUQ2bVpi?=
 =?utf-8?B?RkJpNFN2alFSU0lVbktDSFdZWWwrTkVhN25mRGljbUw0d0VUNU1YN0RHaThG?=
 =?utf-8?B?bk40YVU3NVVpcjRKT2VXRmJmY040YUpYOGxYOWQ2eGxiM240Rkc3UkJlMEhh?=
 =?utf-8?B?cGVqS3RJVENJWmd2VnJ1cDNTcllRWEZ2NitFL3ErQ2VEMzRXOWY4b1ArZ1Vy?=
 =?utf-8?B?OTdqQnVGeVVzMDhObEhlbERxa00wRW82UThNTHU4eUlBV2FJMDRQZG9EQ0Zz?=
 =?utf-8?B?eEEvdWc1VVNSck14ejc5L0o1Y3BTVGpTZXEzeGd6R0hEOGd6VkZtZ2tKYVNR?=
 =?utf-8?B?VXZjMW40a2RSdXIwSlR3bGtTNUVsb0F5RkxJNitpaTdyeHFwNmNrWjJPU1Fy?=
 =?utf-8?B?WGRIOG5jQkxucTJ4aW5KbFN5c3BVcFpKTDVqdkFSQUpSM3BOUUZYMSsveURR?=
 =?utf-8?B?RlNFcFpFYndnL3B4bDZjZzBSSm5mT2YxSFVrbHY4SGo0R1pnRnY4SGp6VGwz?=
 =?utf-8?B?bkVzOFExWkV5NHVGbHV4Y2lNaWt6ZnBvdjBJMDZaTVFNZzRqZTQxM0ZyMHZP?=
 =?utf-8?B?UGpHRHlBT3dZb1dwTzZ2ayt5c2xqTjNtYWJQR0tlZWpnVGs2OGl5NloyVUg5?=
 =?utf-8?B?dXFhU0gwNXYyT1BsV2NETjdXSWU3SGVEeHM3d3pwNENQNjMvRWl2a2VKQ21t?=
 =?utf-8?B?WjBFcU5ocU5DMCtKUVFhZDQ0Wk9JMmZZSW56cHBTUTZPZWRNazlLRFZZNW1j?=
 =?utf-8?B?Ung1OVRoTlNvaTFxT3hwWTVpU3VjT2szSEFwaUE0R0tLcjJFSGFpSmRTeXpK?=
 =?utf-8?B?NmovUGNEbVZjcnpteU9mQjI3ZUZmNkNGdHVqdTBkSVhlbHRad0luSldhTzU1?=
 =?utf-8?B?TUVDQUpKalc1UG42Z1YvQzdYaW1zVlVFNGJxRWZkYXFRRXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEJYVFJmWVlmbWRzUFBWK3h4NHMvVndpb0pZUE5nYXUzUU9wWUFXeSs4QVg4?=
 =?utf-8?B?b29JYkVxaGUrQWdUZVB2bHJLdGVpUjBDcWpHNUc2ZkZPM00rbUVkczJrekFH?=
 =?utf-8?B?RzNQRG9SbFcxb0kxLy9LaEVUY0dwVWI2MS8zTmsxc2w5YzBvN0VFNGFLU2o1?=
 =?utf-8?B?OTYxVjB3MnVsMXlreVJCVXBhMm5BYmxsYitjZ0lOTTNHUjdOMmZ2ZnFEZXhm?=
 =?utf-8?B?OXpJWFhmbHNXajluVFZ1ZmFCaUkxSnJEcHRSdjFIVUxESk1nYWpWbWF0Q011?=
 =?utf-8?B?M2tqQWFNOHhXRFZ2aGNYOG1hU2JnMng3ZFRBQ1hFM3kyMTNpNjNodkpiVWRw?=
 =?utf-8?B?MlhROTVYN2dzbEdtL2xldy9zVkFnZ0RBdlhnSDZOYk00VURnNlMzMzdwVERj?=
 =?utf-8?B?TC9uQXp4VDd5SmgwSEZ4RXJiWFdLZXZuZElqS2Zkd0hScXEvcjYwNStxdnZp?=
 =?utf-8?B?T21XK2RrckREZ21VOTg2MkpWZDU1VWpOUzBlSjlMblovL21YaFRQNUhHNWJ3?=
 =?utf-8?B?eXE0MXhMQkJweXZoK3dEeUR3Wi84OUdBcGRPYzhiSGc1WWc4TytjSGgxbHIx?=
 =?utf-8?B?QlZCZDY3OFdnUXdURnV3KzFVL0NTUkEwci9IdDQ0L3Z0N0E4RUR0Rkt0citk?=
 =?utf-8?B?d04yK0JMNitPd2JYQURaQXJjeUl1djQzZjE5T0NrVHhsMTNIVFVuaHFxajEv?=
 =?utf-8?B?WWRWandmZ1hPR2U2MXVZeXJ2YkZ5aGpLdVRsZjAwcEJVdHVqaVllYzBURE01?=
 =?utf-8?B?ZnhyOTNzQ25VT1VwNmhZVm0vK3RiWXJmcm90cGdyZ3ZsOHYwWHhrYjV4RFRQ?=
 =?utf-8?B?WUljSVVpSCtkMVp6ZkJnM1ZMbW1GZG5rc1M0L3NhL0t3NEdva25vWThBN0E2?=
 =?utf-8?B?QmhKYVpCT01ET3Q2RTVMZjl1dXBpQTZ0VDlMVm5ieVFibks3MU40Mm50S0xT?=
 =?utf-8?B?aVUwclZqUjBJYVU4WnRlYWpUdnE4RThtQmxoZUp4bFlHRDBUMTUyRjYxd3Vt?=
 =?utf-8?B?cE5QaTNMTFoyWTd5dHZuZUJ6d1JFdnVvRE9Gd2tjUXJiQUxoU2c0c1Q1c0lG?=
 =?utf-8?B?eEtrWG0vcWJOSDFoNWFIdnJPcjFIM2NHU0VLUnREZ0pMK2NXcE1pMWRJL1BM?=
 =?utf-8?B?WHREUlFpTjZyT2NJakpJS29BZjRUQS9aTGtUTVBJbEFXT1JucVBVT1EwQ1N1?=
 =?utf-8?B?TmJyR2NsYnZ4dytYdHk3enNSV2VFdERuU09jU1Q5MzBBc2s2dmd2c09ML3RQ?=
 =?utf-8?B?YThHSDFxRTVBdTJWejlzWW1Eb0hrVFQ2Q1p1OTJZbFJFTnllUDNhcXVidUVD?=
 =?utf-8?B?c2tpK3duMUpQZHZwRi9yR1NLZklNRHpxSHAyeFFiZHRUTWEraWRYSy96Tnlq?=
 =?utf-8?B?c24ySWR4Y25jUm1rL2tQRlkwMDk0RnpPNjJqQ1pNWnpPSHk2NkFLYm9LaERL?=
 =?utf-8?B?TDlYb2QwQnpsZ0V0dTFGN1hHcWswVlBPQ1dueW14aEwzdXhzMWloMjZwU3hW?=
 =?utf-8?B?STNJUTVkdUdnNHBFb1pvWUs2RU5xK29YY2Nwa0FvVHdnR0FUVGNkUjVKRytG?=
 =?utf-8?B?ajlnUmcrVGhvbUt1cWtqTHgwR1dqRnRCdUlNejNpVkIzbTVaU1pSTmxLSzk0?=
 =?utf-8?B?VUF5bTEzd2dZeWpRa0NNTnFaV0hDVStWUFIyenZqL1M1NnR3TnU5WmxLUW1H?=
 =?utf-8?B?R01rMjlRMXFDaUJaeWg4Ti9NOHZxOHU1WVRDcDhZZWdmMm5PTkExc1FRL0k3?=
 =?utf-8?B?Rm9jUlVMYnlEb2g2ZWQ3ODVjMmJUTHBPVUk4V1dvTit2dnY3MkhGWnRXVnFY?=
 =?utf-8?B?TXJCbVhyeTRBZ1RSM291RzV4clAzazZ3cXoycVgwakFhK1pJTk1hR2pMVnZo?=
 =?utf-8?B?SU10Q3gxeCtNMUpqQVI4UVoxZnlUM0hEcHVWSDdhTGFFay9ldUNYbVJjcXRB?=
 =?utf-8?B?UEJQZ1paZlErVGtidkhneTBkYW15RkFITGlqYmh3Rk1ETTZQOEpyaW5tU2JS?=
 =?utf-8?B?KzhGM0dXWGYrRm1qUE9VZUlQUmIvdzhCaS9PQ3J3ZGZQSkJ5Z3FIQXd5Skhq?=
 =?utf-8?B?M1U5RGFxWFRNUkZVTWdhdjhvS29xSG9UMU1HeEdTdjdVRXJsWkVBMDBPODVM?=
 =?utf-8?B?U3lXTVNjd0I1UnJzdXhuQTErQ294WGttUWxnbVpEMXJuUHM4eUtKaUhhRVg2?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCAA1044D8D23A40BF7DD94E08827B36@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3aa5a67-99ad-40fc-3009-08dd3f67875f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 06:46:44.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +85qPzhEtO2mQ9NM/JYkvJN+Dh+0qRSGT5lJdjCybU3aixjPL/94PNG3JXchVsKlAdS9fzvV5HX3xQXKUX1jkgdWv9MfzCIr+jnOWD6vfAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796

T24gMjgvMDEvMjUgMDI6MTYsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4NCj4gT24gTW9uLCBKYW4gMjcsIDIwMjUgYXQgMDM6NTE6NThQ
TSArMDUzMCwgQ2hhcmFuIFBlZHVtdXJ1IHdyb3RlOg0KPj4gRnJvbTogRHVyYWkgTWFuaWNrYW0g
S1IgPGR1cmFpLm1hbmlja2Fta3JAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBBZGQgYSBkZXNjcmlw
dGlvbiwgcmVxdWlyZWQgcHJvcGVydGllcywgYXBwcm9wcmlhdGUgY29tcGF0aWJsZXMgYW5kDQo+
PiBtaXNzaW5nIHByb3BlcnRpZXMgbGlrZSBjbG9ja3MgYW5kIGNsb2NrLW5hbWVzIHdoaWNoIGFy
ZSBub3QgZGVmaW5lZCBpbg0KPj4gdGhlIHRleHQgYmluZGluZyBmb3IgYWxsIHRoZSBTb0NzIHRo
YXQgYXJlIHN1cHBvcnRlZCBieSBtaWNyb2NoaXAuDQo+PiBVcGRhdGUgdGhlIHRleHQgYmluZGlu
ZyBuYW1lIGBhdG1lbC1kbWEudHh0YCB0bw0KPj4gYGF0bWVsLGF0OTFzYW05ZzQ1LWRtYS55YW1s
YCBmb3IgdGhlIGZpbGVzIHdoaWNoIHJlZmVyZW5jZSB0bw0KPj4gYGF0bWVsLWRtYS50eHRgLiBE
cm9wIFR1ZG9yIG5hbWUgZnJvbSBtYWludGFpbmVycy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBE
dXJhaSBNYW5pY2thbSBLUiA8ZHVyYWkubWFuaWNrYW1rckBtaWNyb2NoaXAuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogQ2hhcmFuIFBlZHVtdXJ1IDxjaGFyYW4ucGVkdW11cnVAbWljcm9jaGlwLmNv
bT4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+IC0gUmVuYW1lZCB0aGUgdGV4dCBiaW5k
aW5nIG5hbWUgYGF0bWVsLWRtYS50eHRgIHRvDQo+PiAgICBgYXRtZWwsYXQ5MXNhbTlnNDUtZG1h
LnlhbWxgIGZvciB0aGUgZmlsZXMgd2hpY2ggcmVmZXJlbmNlIHRvDQo+PiAgICBgYXRtZWwtZG1h
LnR4dGAuDQo+PiAtIFJlbW92ZWQgYG9uZU9mYCBhbmQgYWRkIGEgYmxhbmsgbGluZSBpbiBwcm9w
ZXJ0aWVzLg0KPj4gLSBEcm9wcGVkIFR1ZG9yIG5hbWUgZnJvbSBtYWludGFpbmVycy4NCj4+IC0g
TGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDEyMy1kbWEtdjEtMS0w
NTRmMWE3N2U3MzNAbWljcm9jaGlwLmNvbQ0KPj4NCj4+IENoYW5nZXMgaW4gdjI6DQo+PiAtIFJl
bmFtZWQgdGhlIHlhbWwgZmlsZSB0byBhIGNvbXBhdGlibGUuDQo+PiAtIFJlbW92ZWQgYHxgIGFu
ZCBkZXNjcmlwdGlvbiBmb3IgY29tbW9uIHByb3BlcnRpZXMuDQo+PiAtIE1vZGlmaWVkIHRoZSBj
b21taXQgbWVzc2FnZS4NCj4+IC0gRHJvcHBlZCB0aGUgbGFiZWwgZm9yIHRoZSBub2RlIGluIGV4
YW1wbGVzLg0KPj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NDAyMTUtZG1hYy12MS0xLThmMWM2ZjAzMWM5OEBtaWNyb2NoaXAuY29tDQo+PiAtLS0NCj4+ICAg
Li4uL2JpbmRpbmdzL2RtYS9hdG1lbCxhdDkxc2FtOWc0NS1kbWEueWFtbCAgICAgICAgfCA2NiAr
KysrKysrKysrKysrKysrKysrKysrDQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2RtYS9h
dG1lbC1kbWEudHh0ICAgICAgICAgIHwgNDIgLS0tLS0tLS0tLS0tLS0NCj4+ICAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbWlzYy9hdG1lbC1zc2MudHh0ICAgICAgICAgfCAgMiArLQ0KPj4gICBN
QUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICst
DQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
bWEvYXRtZWwsYXQ5MXNhbTlnNDUtZG1hLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZG1hL2F0bWVsLGF0OTFzYW05ZzQ1LWRtYS55YW1sDQo+PiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kNmQxNjg2OWI3ZGINCj4+IC0tLSAvZGV2
L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEvYXRt
ZWwsYXQ5MXNhbTlnNDUtZG1hLnlhbWwNCj4+IEBAIC0wLDAgKzEsNjYgQEANCj4+ICsjIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+ICsl
WUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L2RtYS9hdG1lbCxhdDkxc2FtOWc0NS1kbWEueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQXRt
ZWwgRGlyZWN0IE1lbW9yeSBBY2Nlc3MgQ29udHJvbGxlciAoRE1BKQ0KPj4gKw0KPj4gK21haW50
YWluZXJzOg0KPj4gKyAgLSBMdWRvdmljIERlc3JvY2hlcyA8bHVkb3ZpYy5kZXNyb2NoZXNAbWlj
cm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIFRoZSBBdG1lbCBEaXJl
Y3QgTWVtb3J5IEFjY2VzcyBDb250cm9sbGVyIChETUFDKSB0cmFuc2ZlcnMgZGF0YSBmcm9tIGEg
c291cmNlDQo+PiArICBwZXJpcGhlcmFsIHRvIGEgZGVzdGluYXRpb24gcGVyaXBoZXJhbCBvdmVy
IG9uZSBvciBtb3JlIEFNQkEgYnVzZXMuIE9uZSBjaGFubmVsDQo+PiArICBpcyByZXF1aXJlZCBm
b3IgZWFjaCBzb3VyY2UvZGVzdGluYXRpb24gcGFpci4gSW4gdGhlIG1vc3QgYmFzaWMgY29uZmln
dXJhdGlvbiwNCj4+ICsgIHRoZSBETUFDIGhhcyBvbmUgbWFzdGVyIGludGVyZmFjZSBhbmQgb25l
IGNoYW5uZWwuIFRoZSBtYXN0ZXIgaW50ZXJmYWNlIHJlYWRzDQo+PiArICB0aGUgZGF0YSBmcm9t
IGEgc291cmNlIGFuZCB3cml0ZXMgaXQgdG8gYSBkZXN0aW5hdGlvbi4gVHdvIEFNQkEgdHJhbnNm
ZXJzIGFyZQ0KPj4gKyAgcmVxdWlyZWQgZm9yIGVhY2ggRE1BQyBkYXRhIHRyYW5zZmVyLiBUaGlz
IGlzIGFsc28ga25vd24gYXMgYSBkdWFsLWFjY2VzcyB0cmFuc2Zlci4NCj4+ICsgIFRoZSBETUFD
IGlzIHByb2dyYW1tZWQgdmlhIHRoZSBBUEIgaW50ZXJmYWNlLg0KPj4gKw0KPj4gK3Byb3BlcnRp
ZXM6DQo+PiArICBjb21wYXRpYmxlOg0KPj4gKyAgICBlbnVtOg0KPj4gKyAgICAgIC0gYXRtZWws
YXQ5MXNhbTlnNDUtZG1hDQo+PiArICAgICAgLSBhdG1lbCxhdDkxc2FtOXJsLWRtYQ0KPj4gKw0K
Pj4gKyAgcmVnOg0KPj4gKyAgICBtYXhJdGVtczogMQ0KPj4gKw0KPj4gKyAgaW50ZXJydXB0czoN
Cj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgICIjZG1hLWNlbGxzIjoNCj4+ICsgICAg
ZGVzY3JpcHRpb246DQo+PiArICAgICAgTXVzdCBiZSA8Mj4sIHVzZWQgdG8gcmVwcmVzZW50IHRo
ZSBudW1iZXIgb2YgaW50ZWdlciBjZWxscyBpbiB0aGUgZG1hcw0KPj4gKyAgICAgIHByb3BlcnR5
IG9mIGNsaWVudCBkZXZpY2VzLg0KPiBZb3UgZmFpbGVkIHRvIGFkZHJlc3MgQ29ub3IncyBjb21t
ZW50IG9uIHRoaXMuIFRoZSBhYm92ZSBpcyB1c2VsZXNzDQo+IGJlY2F1c2UgdGhlIHNjaGVtYSBz
YXlzIGl0IGlzIDIgYW5kIHRoZSBkZXNjcmlwdGlvbiBpcyBmb3IgYW55ICNkbWEtY2VsbHMuDQo+
DQo+IFdoYXQncyBtaXNzaW5nIGlzIGFuc3dlcmluZyAid2hhdCBkbyB0aGUgMiBjZWxscyBjb250
YWluIGV4YWN0bHk/IiBUaGF0DQo+IHdhcyBjYXB0dXJlZCBpbiB0aGlzIHRleHQ6DQoNClN1cmUs
IHRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0LCBJIHdpbGwgcmV3cml0ZSB0aGUgZGVzY3JpcHRp
b24gDQpmb2xsb3dpbmcgdGhlIGJlbG93IGZvcm1hdCBleGNsdWRpbmcgdGhlIHBoYW5kbGUgcGFy
dC4NCg0KPg0KPj4gLVRoZSB0aHJlZSBjZWxscyBpbiBvcmRlciBhcmU6DQo+PiAtDQo+PiAtMS4g
QSBwaGFuZGxlIHBvaW50aW5nIHRvIHRoZSBETUEgY29udHJvbGxlci4NCj4+IC0yLiBUaGUgbWVt
b3J5IGludGVyZmFjZSAoMTYgbW9zdCBzaWduaWZpY2FudCBiaXRzKSwgdGhlIHBlcmlwaGVyYWwg
aW50ZXJmYWNlDQo+PiAtKDE2IGxlc3Mgc2lnbmlmaWNhbnQgYml0cykuDQo+PiAtMy4gUGFyYW1l
dGVycyBmb3IgdGhlIGF0OTEgRE1BIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIgd2hpY2ggYXJlIGRl
dmljZQ0KPj4gLWRlcGVuZGVudDoNCj4+IC0gIC0gYml0IDctMDogcGVyaXBoZXJhbCBpZGVudGlm
aWVyIGZvciB0aGUgaGFyZHdhcmUgaGFuZHNoYWtpbmcgaW50ZXJmYWNlLiBUaGUNCj4+IC0gIGlk
ZW50aWZpZXIgY2FuIGJlIGRpZmZlcmVudCBmb3IgdHggYW5kIHJ4Lg0KPj4gLSAgLSBiaXQgMTEt
ODogRklGTyBjb25maWd1cmF0aW9uLiAwIGZvciBoYWxmIEZJRk8sIDEgZm9yIEFMQVAsIDIgZm9y
IEFTQVAuDQo+IEFkYXB0IHRoaXMgZm9yIHRoZSBkZXNjcmlwdGlvbi4gKE5vdGUgaXQgaXMgcGhh
bmRsZSBwbHVzIDIgY2VsbHMsIG5vdCAzDQo+IGNlbGxzLCBzbyB5b3UgKmNhbiogb21pdCB0aGUg
cGhhbmRsZSBwYXJ0LikNCj4NCj4gUm9iDQoNCg0KLS0gDQpCZXN0IFJlZ2FyZHMsDQpDaGFyYW4u
DQoNCg==

