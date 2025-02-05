Return-Path: <dmaengine+bounces-4298-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E3A28D49
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 14:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27201887639
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23D1509BD;
	Wed,  5 Feb 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hAoHKLQ6"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396FE13C9C4;
	Wed,  5 Feb 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763914; cv=fail; b=e4pVcBcixS0GaEfKqWt4gnNfFBO803GzGN1qmYfIZYmdMACb7ODsnQf2+QYK/Hz12LqmuVMW9FLQsW7D9h9IX5G4yWJJcYIwUd7TqkqiSwOWgpsqwb5OyYRZqSda9HjYVXQEwYOpm+W0LEFDVJa8zOfxHxyA5L80pFfldBkZQM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763914; c=relaxed/simple;
	bh=6+Vkcs7jJ3X1Zz+nqUutSCBtclvkqmn/LnZnMhMGzEM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LoQNkHtB27JMmLRHx/CJ24TNZvMeQNBYbg6S3q5Cp/zbBroMVZuVSKIhWgs2X1ig+lnC/K7wxxurnNHfBNmqHbcUJuuoz6xhJajOL3TQLYrJkrhdqwQW8pir7zkTcU+/vWiGUli2twl0j4y74nDQ4Dsy5LuOCoyvo5VtUuFxW7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hAoHKLQ6; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeDxcXKe1B+lB0wmlJA9iYJ6hXhp6xh0fycCCqKnIk2puEWkapUOWk9zHh1jU5S+xIbC4T+/yYTcLXG/gq+1P7D9Tjz5R6/Dbrw4tn5k6AKyxXtTmt6LswmeQ6vwCfv8G4Nz+DMh8bp/pmPVfIUnX8OzyLUJVoeHimT9yPh+InTxyhJt9XWUEaTnKH2fJPpLLq2d+XWeGIuBoXNBF3Cjy7O6XAEgq9xi+NtAkKfHv0qPJo9NIM2gbkw01KGNmLwE12cGCo3ZtDIWvNPjUvWxTsWH/upHNMdNjkpmW/1ZmXVakYWe1IimreEqE3f4m8HVWrgPd0AsxxPeENWbACL1rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+Vkcs7jJ3X1Zz+nqUutSCBtclvkqmn/LnZnMhMGzEM=;
 b=QlSxOM/hQnEhZ2tqf2cqsbvzLJ29aa5R+wiUJN27cdayIBm5L7fZ4+ScyS77meBxfb1jB6f5RT90EZozdqo30NN6yohCNdp88AIgjBU771n/blWOxFY6jb+VbGrEbpPlD1S7N8As6YHa5enAn1S98bNnqCoS84JhIqCKWFwL4i1xekaDu80wkHKy82v8zq8Csl8PNpXYaWW62pFCjSB+OUyB8PaK9klazHhzyXOMSwOlBlYSdC2pNuR0Vyh8PRbi9qW/MbNFtypXWOyNCY+QxLyRogFpfUyePEo6W/T/4F8biQ0Q1XyTQN86OsQd+geD8Un64lAgNDtUptMHS8RlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+Vkcs7jJ3X1Zz+nqUutSCBtclvkqmn/LnZnMhMGzEM=;
 b=hAoHKLQ6HO5ORfpN+sMMdS/9DzOC18wsxgnNQu3bR2oSyMu/LaJ/moojLRnHzp5GyVpGHLchn+sNmQ8xS97FTpjHswCTIQp6hWSHreXJ2Jz9+WkJqxs7lkGUjISGfxT+6a4U78n62V8OEVtGppgBT4o8FTxb60oye62oHOTNZvJi9o+KEumnCf/h0fnMB9abaaoQXxoawHQiK8NzlAlxUY6EtyGCykZugAHfY+/4Lgkkv2/Pb4NVBDUu2Ak1lPuXlq8dccjIbqZU8JQ57rZCpZVRS4lJGYr9BMAqD7NjrVpxaIGBIH/x0nCJNAQetdKyz8aZWHaAkMPgKH2o7+A7CQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by PH7PR11MB6428.namprd11.prod.outlook.com (2603:10b6:510:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 13:58:30 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 13:58:29 +0000
From: <Dharma.B@microchip.com>
To: <krzk@kernel.org>
CC: <Ludovic.Desroches@microchip.com>, <vkoul@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<Charan.Pedumuru@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Tony.Han@microchip.com>,
	<Cristian.Birsan@microchip.com>
Subject: Re: [PATCH 2/2] dt-bindings: dma: at_xdmac: document dma-channels
 property
Thread-Topic: [PATCH 2/2] dt-bindings: dma: at_xdmac: document dma-channels
 property
Thread-Index: AQHbd5FxpxZOPWR/L0mgfGnIIneVmbM4llGAgAAmnAA=
Date: Wed, 5 Feb 2025 13:58:29 +0000
Message-ID: <74ac11e8-2285-436b-9186-4793cb2b7239@microchip.com>
References: <20250205-mchp-dma-v1-0-124b639d5afe@microchip.com>
 <20250205-mchp-dma-v1-2-124b639d5afe@microchip.com>
 <20250205-dynamic-scorpion-of-climate-9e7b7b@krzk-bin>
In-Reply-To: <20250205-dynamic-scorpion-of-climate-9e7b7b@krzk-bin>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|PH7PR11MB6428:EE_
x-ms-office365-filtering-correlation-id: f9e5a23e-0bd8-46d5-52c2-08dd45ed2b9b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MW55RVA5NkQ2bThXYVFwSzNxdnhDSlZJQURwUDNUNWk3TllnMzN2bDhEd0Rx?=
 =?utf-8?B?SFdPVDFpb08zNGp1S2JwOGdrUHhzYnExbmNyWU92N1FheUFlTXMrakd1NHJq?=
 =?utf-8?B?S3FEZWUxSXM4Sm9wd1o3VWxsakJhcWhEeU1DeWh6d05LUWUrVUl2TTVVcHgw?=
 =?utf-8?B?OEhFYnluUHgvbGVCcDRzVzlFYWtFdExqeTdWMVJMc3pIcVJweTNOMHgyUkNQ?=
 =?utf-8?B?cUMxRldQVGUwOE40ZUhmSDZldTFiQXJ1MFV2Z0lFTWFkKy9uSnFobFBVM2Za?=
 =?utf-8?B?bmdGc2FBdFFwWTF3eHNhYTRMaGhVWVpBQ3J0dmQ1Yi96dm9PMEhUdVR4R2tD?=
 =?utf-8?B?U3VkalFpakJpL285bnRoaWg4RTlNR0NVbHgwVk5VTXZud3hYSjQ2aGl6Z09Y?=
 =?utf-8?B?eGpVQUpWR3BwVWVHYzJtVzZhS0pRa014V0U1QVdQS0pvSlQ5YjdpUk05eWs5?=
 =?utf-8?B?S1A5UWVEVUtZTGVSSEFRU3lMTWh1NWdWaDBZeURIUFR3ZWZWS0ZzcHh4UnFV?=
 =?utf-8?B?STNFRVIrV3VpMDhJREphOUZ4WGJZM0Q5dTZhNkVLNlcxQy9zZDhnY1dIT21l?=
 =?utf-8?B?MWttT1ZtRnFITVdPRzd1MnN4dklhZEJGc0tmUm5BWFJ5TnozaC9tNmtxQU9E?=
 =?utf-8?B?d3VpbmEwZjZNVHhFcFRqQ2Zic3had3h0YkxkY094dUpEb3Rmb0JjYzVPeHp0?=
 =?utf-8?B?STUvblhMOXZlQWx2cHVzb2lYL3lSUUlrNVMyK3BVTTNtRjltanU5ZHF5aXNU?=
 =?utf-8?B?M0tKOEFuY0RjOUlrRnpCMU9BTVp1Y2ZGNnBDZUgwb1RnaFZDRXl5Zzh4MkFD?=
 =?utf-8?B?S2FKaUd1OHRsK3MvYkgyR2YybG5JczA0dmtITzBtVXR3a1RpUVlHbmMrOHQ0?=
 =?utf-8?B?ZXhhRjRjMWllb3hNbTFTcXc3Z2RYU1NsTmgzNWRrVnRNSTRkK0dwdTFkSERr?=
 =?utf-8?B?dS9YNlhRY0owWFJZQWN4VWgxTWJzOHRUdnZzZGlKQ0pjVnRrU1R2UkhhbTNm?=
 =?utf-8?B?bWxwOTV0Z3pmamJpWi9FWkw4T3R5MUFTcVpMRk91cXRCWkpaSWYvT1lEcGFK?=
 =?utf-8?B?ZU5RZXhuSUpBY0V1d3JSRkhZV3pFVGRUMXBSVDArZkR0ZkxXU1hISUVvWjk1?=
 =?utf-8?B?SFZHU2tqWEdzV2FiODd4eEd3S2w2VXo3azdUcEo0T3BxakJoRHNBK1VNNDFD?=
 =?utf-8?B?MTJPTXJ3NDZwakQ5TytYa1pwTkM2S3R1TW9tOFVsVVlnejJSR0dnRE9UTU00?=
 =?utf-8?B?c1FkbUU5dzlGREJzaDFrM1FsODNwZGh3YTM1ckVPZ0hJUzJibWtPMnpuZ3N3?=
 =?utf-8?B?TUp2elcxc092eit1Z2ZhNVZ2VlJGdlh6S01zakxVRDk1SEd2ckZqU2ROVFhR?=
 =?utf-8?B?QUxSRkRzNjZNdSttOHFEbzhON05ucnV6dE15bHFka0dQdC8rR1Rac2dCelMr?=
 =?utf-8?B?NnF1MkQwWUh4ZjdQdVFyZnMrNTE1NHBqcDEreGZmSTZnYzdieU16Vk9rb1oy?=
 =?utf-8?B?bitpR3plVzVMbDc2VzJ2cEk1VFdmc2djY1dHdnU0RmEvODBVaEpUYnY0SHho?=
 =?utf-8?B?S1ZUU3c5OXF2T05VUVZIVnhRTFBxU3lsRzR4M1BzZ2IzcnJGMDRIc21XWUVQ?=
 =?utf-8?B?a3M4a3hoc0Y4aDFWYXhSdjBzY213bG54VjNpNk5yenM2LytWQTZlQjFmUnA0?=
 =?utf-8?B?ZjdFVVpTOHloY0hBV2JhdXZsRWlPeGhMRCt2TTlqSDR2c0t3cWE0MnpQZXcy?=
 =?utf-8?B?QUpWM1NpY1lISUxuMWtQZy9xWkRjcWxPMXp5ZWtNNWtFT2h3NXUybzRob0JP?=
 =?utf-8?B?MkZNNGVVVXNYai9oMzhoaTBqRWVJRUJ6NkowTXJFdWJPejdYcmZCeTd6cFpY?=
 =?utf-8?B?Q0t5enZXWlpnT0xVMFo5TE5sMnNzOVNzUFExZTdqTStWNWhlT1dKV3AvM1Bw?=
 =?utf-8?Q?rMnte9E6sfuf/05o5xpLTT4F/V+zBlSC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3E1eVltZVNGWnh1bW8zNnAwci91Vk51TkdZQ0Z6ekVpSmZsV2g0MkhKLzk5?=
 =?utf-8?B?U0JRTGh5TzlvSHVpdm5URGpWMTJsUVZubG15V0FUUDlmSFhxcmZzQmZFTmJr?=
 =?utf-8?B?VDNJKzQ2ZW9uRUtyZ1F2ais2eStlcmhSeEdnWk9FVFU0MFV0Q2FTa0l3MmRu?=
 =?utf-8?B?N2E2bVhvcEw0SWtlQVg1cTJUSkkrL2tSMmJrY2hYYXlzSFVhQTQ5b05UNzF4?=
 =?utf-8?B?OGdKUmd1TXZvd0w5NXIwakNCSmZuYkxBdE9LdnljbmJXTXliQ1h4RDExVWxI?=
 =?utf-8?B?bXA3YzN0ZEwweE1DeDFvbGljdHo5c2ZUeHVoNFJPQ3VVSUV1cXlOSVc2N2FL?=
 =?utf-8?B?bFpTNzJ1RWpGN0tlMVlpa3VDR3ZrbkRSclp0OGZ1ZjlUVmU1M2ducmJITE1i?=
 =?utf-8?B?WDlzMVNhWEtPTUlTbDJOdzdBSEdvMlhWeVpISTY0eGs3MU1GUENOUndXSXJw?=
 =?utf-8?B?YkxFRFRGY29DRi9pUFp2dUtBczdEempCSTNsVEgxUEdmcXhIMWMxbmIySTQz?=
 =?utf-8?B?Ym1BZ1BwTTQyL2VRdmVqZFRpRXdROCt0N21SSDJvRG5Ld2w2OTUrRUc0eXJB?=
 =?utf-8?B?YWNrdVo2SnZDR0tlTHI4L0pFYWx4OXdqMXhTaWZZYVdUY2wweEF6Mlh5OFhI?=
 =?utf-8?B?VFZpYXdZTGhYVGRwSnA3R09XbXZjYTN3UWRyM0U0anVJU0VUL05jS1MvdkRR?=
 =?utf-8?B?cXduVmJjZG1ZU1U0R3lBL0J1L3hKOHpnMzkvWTRyMCtQbFEvMnhjcUd1cCtR?=
 =?utf-8?B?YThSa0gzdG5NZzBKbnI4QlgwZDRyQjRkZ1krQmFJdnFIb2hRUEFmMWgxTmU3?=
 =?utf-8?B?eWt1NnVveGVidGluQ2lzTjlXWXEvb1hjRWNzNCthQUNqV3ZzK2dQbDZTQ2Zx?=
 =?utf-8?B?UVlGZ0YzYmZHZDZMV245NVkzRDlkaXZKMFh1NmtsSjhQMjNBTGxHUS8zZGl6?=
 =?utf-8?B?cEZsU3ByUVBTQzBOUXREYTNHYUp0L2crR0Q4ZTBjS2taOHJzTW9COGxqUjdI?=
 =?utf-8?B?L1JIODVKeUxoVEFSdXVCWUpZSUJZRXkzOEtiVEFhM1FEV1J4eEs2anhEczJ0?=
 =?utf-8?B?YlN0S2RIQTJSM3VWK3I1MEFiSTh4L2tQN0t2cEJoa2ZaWm94ZlpPc1FmSDh3?=
 =?utf-8?B?WVRuaFFFZ2N1ak0weTdhbU5EVXFKZ2ttQnBlUFh3M01rTEY1NnBiZXlZYVBw?=
 =?utf-8?B?VEFhZTBScXFZS0FRUnlqcHpBejJUR0xqbEFMenEzcWw5YXl0SU81KzBBY2Zs?=
 =?utf-8?B?cGx4dTBQaW1PK2poblR4UStCbmRJQlc3dlRySEVmYmRhNldEWXp2UWxLTjZB?=
 =?utf-8?B?UU56Z3lHbG44SnM3RFBZRkllSzNvZTdGaDJ1UTE1Z0ltWVdBQWFqZzB4V1Ay?=
 =?utf-8?B?dTVMU2lpVEtsRU95V3h3VDNWM2lOeHRFdEYzV3R4TEt0dGdkSEhqdGhLWUxC?=
 =?utf-8?B?TkhwUE1aTGVUakV2cE8wN3dmSDRNQ2w4MlpITmsxQWNGdm15U1lHRjM5L2I2?=
 =?utf-8?B?MUI1ZjFhZURtZFpYZ2JNYWxPTDUwRnpWS01UOFhvSXhhS2M3cGRJMDhzQlBH?=
 =?utf-8?B?QjlVSEhtL0tQd2lZa09PSnh3TDFyZDI4UTErNnRNSmpCcDdNQnR5ZzliQTM5?=
 =?utf-8?B?djVvTTVseWN0MTdLM1FqU0dHOGw5eGxDK0t1dGZ0U2dJa1R6VTh1SDdQSk1H?=
 =?utf-8?B?WitEK1RIVDZGbWJPbGQ4MFNjLzhHNEJVSUF1QzJLcFJPN25ubEl5T0w3cExF?=
 =?utf-8?B?VG5yQzdqRk4vbFdab0lKRzhFQXdjbWdjbjJVUjV4R3cxeGFOQ0R1RlhmTkxW?=
 =?utf-8?B?Z0hQVElON1luNWJiMm9jK3hYREkwaXR6K0lDd1hmYzZOOE4xd3lSVUV2WFhO?=
 =?utf-8?B?d2hMRHBNV1l6WkNHWTJLUUJueXFQNkpKK20wMEo2Q1RxR0tnK0RCbXo1T05K?=
 =?utf-8?B?emExeG50azhncFByNlYrSHl0TkNGV0NJNWRBTDIxTi9qSGlEV0hPb1Q1bzNl?=
 =?utf-8?B?MDZKcTdYckx5d0hDcFJ3bnIvaitTNW4zSGNvWkZTMEh0a3ErcWFJYUxhOXd1?=
 =?utf-8?B?SkZsVEdZc2Y5WHdLZHphNTRVN0h3eWRxWHBaQ1VTZjloSVdpcFkzMnBLSmM0?=
 =?utf-8?Q?/hoKXLT5hPUrmipZS1gGFOosM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C19EB7178B420745B01101F6B4FD86C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e5a23e-0bd8-46d5-52c2-08dd45ed2b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 13:58:29.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PI2O728GP3s/ef0bCWQ4oUI5xQ+gtDsDnvOB/mANAIcIfUctxZ1bsd5DlyJCmlD07WIctPRudgU1ua85mWLbww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6428

SGkgS3J6eXN6dG9mLA0KDQpPbiAwNS8wMi8yNSA1OjEwIHBtLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdl
ZCwgRmViIDA1LCAyMDI1IGF0IDExOjE3OjAzQU0gKzA1MzAsIERoYXJtYSBCYWxhc3ViaXJhbWFu
aSB3cm90ZToNCj4+IEFkZCBkb2N1bWVudCBmb3IgdGhlIHByb3BlcnR5ICJkbWEtY2hhbm5lbHMi
IGZvciBYRE1BIGNvbnRyb2xsZXIuDQo+IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5LiBZb3Ug
YXJlIGR1cGxpY2F0aW5nIGRtYSBzY2hlbWEuDQo+IA0KPiBUaGUgc2FtZSBhcyB3aXRoIG90aGVy
IHBhdGNoIC0geW91ciBjb21taXQgbXNnIGlzIHJlZHVuZGFudC4gWW91IHNheQ0KPiB3aGF0IHdl
IHNlZSB0aGUgZGlmZiBidXQgeW91IG5ldmVyIGV4cGxhaW4gd2h5IHlvdSBhcmUgZG9pbmcgdGhl
c2UNCj4gY2hhbmdlcy4gQW5kIGluIGJvdGggY2FzZXMgdGhpcyBpcyByZWFsbHkgbm9uLW9idmlv
dXMuDQo+IA0KPiBBcHBseSB0aGlzIGZlZWRiYWNrIHRvIGFsbCBmdXR1cmUgY29udHJpYnV0aW9u
cyAtIHNheSB3aHkgeW91IGFyZSBkb2luZw0KPiBjaGFuZ2VzIGluc3RlYWQgb2YgcmVwZWF0aW5n
IHdoYXQgc3ViamVjdCBhbmQgZGlmZiBhcmUgYWxyZWFkeSBzYXlpbmcuDQoNClRoYW5rcyBmb3Ig
eW91ciBmZWVkYmFjaywgZG8geW91IHdhbnQgbWUgdG8gaW5jbHVkZSB0aGUgZGVzY3JpcHRpb24g
b2YgDQpkbWEtY2hhbm5lbHMgZnJvbSB0aGUgZGlmZiBpbiB0aGUgY29tbWl0IG1lc3NhZ2U/DQoN
ClRoZSByZWFzb24gZm9yIHRoaXMgY2hhbmdlIGlzOg0KIlRoaXMgcHJvcGVydHkgaXMgcmVxdWly
ZWQgd2hlbiB0aGUgY2hhbm5lbCBjb3VudCBjYW5ub3QgYmUgcmVhZCBmcm9tIA0KdGhlIFhETUFD
X0dUWVBFIHJlZ2lzdGVyICh3aGljaCBvY2N1cnMgd2hlbiBhY2Nlc3NpbmcgZnJvbSB0aGUgDQpu
b24tc2VjdXJlIHdvcmxkIG9uIGNlcnRhaW4gZGV2aWNlcykuIg0KDQpJc24ndCB0aGlzIGFscmVh
ZHkgY2xlYXIgZnJvbSB0aGUgZGVzY3JpcHRpb24gaW4gdGhlIGRpZmY/DQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQoNCi0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpE
aGFybWEgQi4NCg==

