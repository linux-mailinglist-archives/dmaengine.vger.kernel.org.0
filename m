Return-Path: <dmaengine+bounces-7574-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1ABCB779D
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 01:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD2B23018D66
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 00:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38E223E229;
	Fri, 12 Dec 2025 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="U3G4CrIB"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7E23A9A8;
	Fri, 12 Dec 2025 00:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500417; cv=fail; b=dtH1nfyEmUhlAqONXryw33UnBu+yDXuOrY5Lvys9mjrFClTASAj5D2nsCneDfOzeZ1nuPUXf30eCsDekIEvPALsdIFvByJJcya2zskERRn6G0dkKM1ABnoloGRz2H+rVxyBaGeQE8Sd4EdUAMht2HbygPWaRxllAdzXZpoYUjMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500417; c=relaxed/simple;
	bh=D89JJAQHFrx6rko/A31FXaMqVQrqD2UP4bT0jM0bm+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bTN3MNfe7+BkGSK+AfM/2OJ//kD/Wkg5H5N2Ib722f6EuAeaGNBg4i0sUvpyPeC5UEmzTmlZ+VaID7QMlY9Di1WyrXPAGppV7cUNiFBbRLNM63P7qsQHnznh5/OeWtC9zxu57DdWc4/urHfyOsd4O278guCaCikC+9MxiFreaM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=U3G4CrIB; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ0GrzhjhP8yyTmCMQ7UVJJ0P7YHkut+Bk1pNf3uLjStCoV+R58r80RijoiAVzvVW0x0naKQSx3XI2ShsqE+azJrSCw7lqx6KV9khWXs/E4snBV0Q2gKdjgeij1T+7I2r/DHrU9sUfqSbRuS+I3LPmwCn4cTAn/AXb7mnIz7/fYTWNe6tqn1YKIHpGovvrp50/NjYZZqb5TfhU0Ac5Zhj2HHY2u5tuhd2HN5iWFOMyx0KHt8zc3gVt0UbEIwCQ/Lkm174xI8+JCt73uFRSl2i4AQtzwg6REe9pIM6XebfIsgmWWb+gyW9uaJMHgZa8GD8ysO2oZGaU1rVOUeVYSiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D89JJAQHFrx6rko/A31FXaMqVQrqD2UP4bT0jM0bm+o=;
 b=zH7PrkmySSiYsRNys+FuW1jXYgMVGltYpnbbirtadcT1qVsXWAV6BekpI/3L6KId4jqI82cYlh0F2Moo6mjbo5sxfGie5LL1JaOhlR1ipXT70ekYz+7XEPywcoSG+azbdOK9I1ItUKoDaSCl2FiyQxE8AD0Mvx91sLaEnWNTE3Mii3MHB7WfrZlU6rkuRVtfnDCNqphicMAFWkXsCe8hmFfUaJ7r7pey/HO15Y+4BLXi+kdAjTQMAcKrdNfAIVHu0uShgCs/JNX0fLVpCOQ7/Bpeux9xYO6q7tZSMfxjR37Sbvql/evb9jF+1d+2C+yOrwJAIJWtxeGi4GhvrGSwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D89JJAQHFrx6rko/A31FXaMqVQrqD2UP4bT0jM0bm+o=;
 b=U3G4CrIB48//WPbSe8IUYVaG1wGgEx/HQA3eAFk0PeKDrM6gNfdBVihP/cKHCk/2A4TjksjPT6N20yU54pihEZaKkxV4UsTWueisiV5qE00pCJRVfc6PEh4YOxXPP9M78lOxRGGmPle3C94kIxmGTwc47jaeiQ7l/RSxrRgWxnc0+rB6AjeYaV/8pLnOz/db9yepyHau5aoEwLWFN9sjY8Y4df4Ry4TdCLmMXplQ4QBiX0IflWOKRn9vcQDjLp5yPI/SmOk+t7CTtiiI0jMq0aWR1QtXLmjP+4jvQtW6lW4EEUyqdhNow/RKJfmg04d7M4G7yiaa2vg6YKpbmPM+bg==
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SJ0PR03MB5949.namprd03.prod.outlook.com (2603:10b6:a03:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Fri, 12 Dec
 2025 00:46:53 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Fri, 12 Dec 2025
 00:46:53 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Rob Herring <robh@kernel.org>
CC: Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Eugeniy Paltsev
	<Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
Thread-Topic: [PATCH v3 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
Thread-Index: AQHcalhVEwmMZRtFIkGO/9LTwzjtj7UclaMAgAACEoCAAJU2AA==
Date: Fri, 12 Dec 2025 00:46:53 +0000
Message-ID: <b4e36cd5-959b-4758-8c52-6dad7e6f17f0@altera.com>
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
 <646113c742278626c8796d8553cdb251a4daf737.1765425415.git.khairul.anuar.romli@altera.com>
 <20251211154524.GA1464056-robh@kernel.org>
 <CAL_JsqKPVdUzytrVKs5q5JfPnxLdz-UdN5K-cJUVQ_uWM5azLA@mail.gmail.com>
In-Reply-To:
 <CAL_JsqKPVdUzytrVKs5q5JfPnxLdz-UdN5K-cJUVQ_uWM5azLA@mail.gmail.com>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PR03MB8447:EE_|SJ0PR03MB5949:EE_
x-ms-office365-filtering-correlation-id: 9b579823-8aca-439f-4d34-08de3917f1bd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXdWdDFuSmlJVEIxZmdrbXZZZm9VS2ovM0dCSk5vK3BEL1hhakJXd2VhTnFq?=
 =?utf-8?B?UTRCU2lyM0FxQ2tHT3dOYnhyTXNXUnBIVXQyZVVuNDF1WDJRRmo4ZFhvM2E1?=
 =?utf-8?B?Q0tVSVhJZFRQaDVKYVY5WnJvK01BQmdJOE5SRGhsamVGU2FsYWxETHRTTFFm?=
 =?utf-8?B?eEVMMTZMRFUrTlEzbVFSSDJQdFpaQXI4SDg5dXR4OFp2WExpY09Ic2dSUHNR?=
 =?utf-8?B?T1EzTVlYRURRRkR3dGkrd05NcjJoUWNwbzlkSHBLWHN3WlNXekFVTG5LUkNG?=
 =?utf-8?B?MUN0KzloMVpTWkRwWWREUkxDdE1PcDFFT2s5b1YyK3RiY0xpMi8zWFEwUUo2?=
 =?utf-8?B?UlVFeVQ3OXJQeWNvNS94TmgvWkE0b0J3bXRvS1JZZEZxK2VDYTY3K2NQSHpJ?=
 =?utf-8?B?WVFma0dyUUwwT1llZWNSeU5wSDYxOGU1aVRnSXNTRU9KRlVyN0k4cWY0Q0N2?=
 =?utf-8?B?Z2x0ZkZ0cFp5TVpYd1ZFZXR3bEp6UWxBUkhkVGhXZGU2bmQ5ZDFrYkRvWXRi?=
 =?utf-8?B?WDI3cEhITXZoK1hBQkxwZEpDazNRZnpHK3ZsMHFncGZEby93QmdXaXphOERQ?=
 =?utf-8?B?eTRBUjRlalFvZVUxYTlBZmRUOEUycmZjRGRYWDZiRUFsZVN5c0plMUxiaUVO?=
 =?utf-8?B?SEV4dDBSRVZaam8zZXJFUEJCS0dNSmtMZmZKeEoxQk1NMXlyS3o3blU2ZmYx?=
 =?utf-8?B?NlJlbTgrNGhLOHJHQWVlRjFNMU5ILysxRWN3WksrZk5sQXhJZWRORnVVczk5?=
 =?utf-8?B?RzFaZk4yOWRTNm5rWlJzQWtOMDBYSHU3N1FYTm5MNjNRaWtwNFdoMHpMRUZI?=
 =?utf-8?B?Z2ZTZzZxUE93S3QxVFJab3VLUFc3N1J2R0NCUzJUY3JHRkJxalluRnJ2MzBq?=
 =?utf-8?B?NnJGRVM0YWVlUkw1czFadEt6Ujh4d0lWTTBpTkZrSlBuaUxNOGJTcU9IME9C?=
 =?utf-8?B?K1NOUzdHNmRWT0xMTFNKR2g3dXZpdFhwbmxOeC9kYk0vYU9NdlFmSmhiaVFa?=
 =?utf-8?B?YVh5aGxJVk9KQVcva1RVWm1YNEVmcDRVeTI4YW9Kc0hzOVp6OWdEekR1Wnkr?=
 =?utf-8?B?MHBYR0J1L2o1SHg5cnBITG9KREJYd2wrUzZLM09GenlhMkxIdm1QN0xuUE5F?=
 =?utf-8?B?R0hOaVhuQVFFeWk2eVJLZW00eGozWDBVV3MyRFhIT05IUzZEbVhtS2xrOXps?=
 =?utf-8?B?a3l2U0ZyajdPUVNRMGswdlQxVmhpSi94dkVKbGQ3RmVEQ0ZOUEIyRTA0S0FT?=
 =?utf-8?B?c0VPOUZPRDNIOHhTVVN1Rm5VOWJrM3ZFdm85VnlNRXZFQUtpSlBFRkErRGtx?=
 =?utf-8?B?aXVpZ281YzJKV2dQYWZCZXhrUnZyN0szdlNIczNES1k1WTB2MTRsVUgvZEJm?=
 =?utf-8?B?NWRNdWk1VWZSblNIeWhNa3JDeGRDenZqYlVaM2t3NWh6SGdxdFdncFQwVlBk?=
 =?utf-8?B?bHV5UHRIYXJTYTFPZ0RweVhJeVJQdU43eFJ3R3dKa0wwMGlrTzA3STNKalow?=
 =?utf-8?B?YXB1Y1VIb1lTUnVNNitWL0NHMmszcGV1S3h1K1JzTkNZL1NpaGo4YVhXZ05z?=
 =?utf-8?B?c0EwcFFPRnVjcEdIc05oL1EyZVhQKzk1RjFya2FLRFNFcjB2bDBvbGk0Qk9F?=
 =?utf-8?B?YlZTK1prTHR6eXNEc01pdDV4S3NGdSt2bDIzaDVoVHdDQ1RYSGhTNkdXMU12?=
 =?utf-8?B?eU9RUG9SY01QYlkzbm1sQVFNYk8xbTJNVEkzOVVZemRxeWJ6dURlbnRxNjdz?=
 =?utf-8?B?ZjFxaWR0SXN4K1Yvb1dPZzRtN29IdU0wZGVYTzlWSU50Yi8rc2hVcVdXUkVm?=
 =?utf-8?B?Y1FjNmF0bTFQaTluZUYvTWU2dVQwZEU0dW9DdmlMa2czb1ZmTmpCYy9nNjMr?=
 =?utf-8?B?NFhUVHFFSDJUaDRPYlprMGNaZ3AraXZZMVJzbitXb2tZaVhUVHA2OWozdEJU?=
 =?utf-8?B?Q0dRS0FEdCtqU0ZpdThSc21pQjI0ekNmL3ZXeXVBWXdVNWZIb21FaEwzSG5n?=
 =?utf-8?B?Q0UvZjVybGxtLzZ5Y01HdUJtNTcyYmhsaWFsc0JZNDkzNkd1WmVkaU12bHYr?=
 =?utf-8?Q?Mumn4K?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b05VY3daM2sxMmlOMFAwNDdFVkprWTlKWTg1V3p6dXEyTU9VQ05HWFlTQndL?=
 =?utf-8?B?WGxQSEdUdnNNbHpuSXltRlZsRkxnZjRCdjFrb1ZQeE54YlpTWG5SQVlzTS9v?=
 =?utf-8?B?TytpWjdjMVlOM2JjVm5vWFRuc1ZpenJOSWVwUG9DUlBxSzNVL0hRcUI2S211?=
 =?utf-8?B?cmdUUXUwSVJOUk9XeVMxWXo5MU1GTXZiT24wdms1Yk5EazBPMFc4bTg1TWsw?=
 =?utf-8?B?aUd3WW91SmtjZUZOaVJvSCt6UTQ5OFJYYXA0Nm1NTktOMElIaDlaUXJTUXFL?=
 =?utf-8?B?Y1U5Z0ZIQ2RpMW9hSkZMYmxoY3hObFV3TmZaZDUwWmk3UnNDb2kvTVFJdWwv?=
 =?utf-8?B?RXlMNHlrbTJXSVVyZm1yWEJsT0ZkOXdUaGpJT3Z1cDBFczE0UEEzc3Q5bzZY?=
 =?utf-8?B?WGVzd0ZEM1lXK1NVMzdCeFN3SHdzdS9DSklUai9PRFkwWnVib21iRXYrV3dV?=
 =?utf-8?B?Rkl3SndVTEkwKzgyRmlnNXN3Wnl0TDFJSU50NEkyRlJrK05SK3JvMUU0TzRr?=
 =?utf-8?B?aWI3N2piYjU2Q1RZREgvMEI2SkRFRXdSWUVTWFhSQlV2cXhnd0o1S1VuODFI?=
 =?utf-8?B?VUhLa05SYkNQY1FSZUNlUFZuYkduU2tMa2p5eU1jN3R6MHhYczVCL3hDdy9i?=
 =?utf-8?B?N1Y4STBBNHJZQ3JXdzBKU2N5bHh4djdpTHE0STFFeDVLUUhiZlZSZjVwUURo?=
 =?utf-8?B?eDQwQzgwTmplOGlCUG92ZEU1cHhGc05xS2E2YW00THZ2MjF0STBta1hQa2hj?=
 =?utf-8?B?WFBSN3d1TWI2KzRkQzJIRFMyYjBpb3dkSHhIMXVvdDUwd2R4ZHJOa0plUEFy?=
 =?utf-8?B?MEhzaGZ4R2ROVjdZYllxYWs4cTROVUFaQWtrbVJldXZIZ25UREJPWnB2dk9B?=
 =?utf-8?B?d3AwUnhvTFRTTXRud0tZMDRYM2hOQjIyM2p5VnY5c2hKTlZ0dUVma2k3bHcv?=
 =?utf-8?B?QUpFZ1QrQUtqUHhqczFjTm5DOTJOazM1VGQ0cFBaek45Z1ZaVXllczlSajdV?=
 =?utf-8?B?OU5DRTlOSk8wWFUvcDVHWHZ5eFZrTkM1TzJTUFdvOHlkd0NvR09WVWVMcEhY?=
 =?utf-8?B?bERkOXBoRW44aVBDbjNZc2g0M2tzNmVTdGVybVFLcGZxR0FjL0hQODF5ZlZp?=
 =?utf-8?B?YUlvUm5lcktibFdrRnRWbVhvMTJSNE9jbjdFbXpFZnNQSkxJMXQxbmNXOXJY?=
 =?utf-8?B?cHlmRkZRNm1WYnFhYTljTE5hSGZFOU9mWGxuTTdRUXlRY1hKbGx2QXEyQjR6?=
 =?utf-8?B?ODlmV3V3VDVra3Vzd1BmT2VLeitZQkZDTkdDaE1yUXlBaU1UZ20wUVZSK2h3?=
 =?utf-8?B?b2JjMU9NSi9FMklWT0Q5VXpXa3BCaHI1N2hrRXM4SnVtbXl6Yi8yNDF1ZExh?=
 =?utf-8?B?UFFRdkR4Qm1tN25VbTFxK1NVTW5SRXMrT3RmV2Mrb2lSU3lSN1dLZy8wcU9I?=
 =?utf-8?B?WmlyRlVhQ0NEV0xSOHBKQU4rcjU2aXkwOWZ2RmpWVExtSTMveVQ4SFI5QzRJ?=
 =?utf-8?B?SEdEMGxlVmJsSUpWRytoUC9YV0F2ZkVHSkthcmNUWHdhbGpMVE5JYUdva3dO?=
 =?utf-8?B?ZGJKMm4xZVFNcEtscjFXaFlwVlJ4OWdoUWp5T1VOajZNc3NPY1YyZkl2YTFK?=
 =?utf-8?B?V3JUb3BFcnNXOWxIaVpLZkpRRDVRdXJSaXNHZ2NoYkpTYU5WQWhXYjRpQ0I1?=
 =?utf-8?B?NlI3L1JNcFB0SVliTDYvdWFjdThNems0dEFMdzZyMEd5SnBoVWtSb2tCaTY0?=
 =?utf-8?B?K1J3UjV6UXMyN1R3bkt0RXhVL0RIOWVXNllkZ2N0clRoZ1RRWVJwVFlOR0d6?=
 =?utf-8?B?bnNVcHNhVUc2cDF1eVBBSUxkaTFpWjRFZElXci9rM3dxNDRmQ0JueDZ1STcr?=
 =?utf-8?B?UzQzNmhhRDRpMGNRcithUUhYZTZzT3FFTy92d3YxbHl3K3luSko1aVhNWW15?=
 =?utf-8?B?RE5ybTFUYzlYZzdFN1NGdlRRbDBhK1hFaXJOeTVrOWlja1NYaStYdTB0TWJP?=
 =?utf-8?B?ZkxxakdxYUtBd255dEwxY2FaWXN4aytGRldRcDE5QWVJOXY2WlpjY0JJTkJM?=
 =?utf-8?B?K1AralBrMFJMQlMvQXcycUIreElNcGJ5d0wzVlZ4L2lZYmlBYk5sK3pVM3Y5?=
 =?utf-8?B?S0NjdHhHdko2aXV6aXF4ejJSd1V3UmdwcC9ya2hBbjQ4Nkd5N0JrajA0disw?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A004F7DE07CF9F41A59FC0B8AC4B6065@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b579823-8aca-439f-4d34-08de3917f1bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 00:46:53.5777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5n8Fkey/KA91zL1muPiBCG5CHX4VMSjcsZqN+eWqEWjRBjK97HQib6qMkUToZmjGMsSjvONE3O1txwUcL3rszp4qnDLdOVhyMS05cmpO+f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5949

T24gMTEvMTIvMjAyNSAxMTo1MiBwbSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFRodSwgRGVj
IDExLCAyMDI1IGF0IDk6NDXigK9BTSBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiB3cm90
ZToNCj4+DQo+PiBPbiBUaHUsIERlYyAxMSwgMjAyNSBhdCAxMjo0MDozOFBNICswODAwLCBLaGFp
cnVsIEFudWFyIFJvbWxpIHdyb3RlOg0KPj4+IEFkZCBkZXZpY2UgdHJlZSBjb21wYXRpYmxlIHN0
cmluZyBzdXBwb3J0IGZvciB0aGUgQWx0ZXJhIEFnaWxleDUgQVhJIERNQQ0KPj4+IGNvbnRyb2xs
ZXIuDQo+Pj4NCj4+PiBJbnRyb2R1Y2VzIGxvZ2ljIHRvIHBhcnNlIHRoZSAiZG1hLXJhbmdlcyIg
cHJvcGVydHkgYW5kIGNhbGN1bGF0ZSB0aGUNCj4+PiBhY3R1YWwgbnVtYmVyIG9mIGFkZHJlc3Nh
YmxlIGJpdHMgKGJ1cyB3aWR0aCkgZm9yIHRoZSBETUEgZW5naW5lLiBUaGlzDQo+Pj4gY2FsY3Vs
YXRlZCB2YWx1ZSBpcyB0aGVuIHVzZWQgdG8gc2V0IHRoZSBjb2hlcmVudCBtYXNrIHZpYQ0KPj4+
ICdkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KCknLCBhbGxvd2luZyB0aGUgZHJpdmVyIHRvIGNv
cnJlY3RseSBoYW5kbGUNCj4+PiBkZXZpY2VzIHdpdGggYnVzIHdpZHRocyBsZXNzIHRoYW4gNjQg
Yml0cy4gVGhlIGFkZHJlc3NhYmxlIGJpdHMgZGVmYXVsdCB0bw0KPj4+IDY0IGlmICdkbWEtcmFu
Z2VzJyBpcyBub3Qgc3BlY2lmaWVkIG9yIGNhbm5vdCBiZSBwYXJzZWQuDQo+Pj4NCj4+PiBJbnRy
b2R1Y2UgJ2FkZHJlc3NhYmxlX2JpdHMnIHRvICdzdHJ1Y3QgYXhpX2RtYV9jaGlwJyB0byBzdG9y
ZSB0aGlzIHZhbHVlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogS2hhaXJ1bCBBbnVhciBSb21s
aSA8a2hhaXJ1bC5hbnVhci5yb21saUBhbHRlcmEuY29tPg0KPj4+IC0tLQ0KPj4+IENoYW5nZXMg
aW4gdjM6DQo+Pj4gICAgICAgIC0gUmVmYWN0b3IgdGhlIGNvZGUgdG8gYWxpZ24gd2l0aCBkbWEg
Y29udHJvbGxlciBkZXZpY2Ugbm9kZSBtb3ZlDQo+Pj4gICAgICAgICAgdG8gMSBsZXZlbCBkb3du
Lg0KPj4+IENoYW5nZXMgaW4gdjI6DQo+Pj4gICAgICAgIC0gQWRkIGRyaXZlciBpbXBsZW1lbnRh
dGlvbiB0byBzZXQgdGhlIERNQSBCSVQgTUFTVCB0byA0MCBiYXNlZCBvbg0KPj4+ICAgICAgICAg
IGRtYS1yYW5nZXMgZGVmaW5lZCBpbiBEVC4NCj4+PiAgICAgICAgLSBBZGQgZ2x1ZSBmb3IgZHJp
dmVyIGFuZCBEVC4NCj4+PiAtLS0NCj4+PiAgIC4uLi9kbWEvZHctYXhpLWRtYWMvZHctYXhpLWRt
YWMtcGxhdGZvcm0uYyAgICB8IDY5ICsrKysrKysrKysrKysrKysrKy0NCj4+PiAgIGRyaXZlcnMv
ZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLmggICAgICAgICB8ICAxICsNCj4+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3JtLmMg
Yi9kcml2ZXJzL2RtYS9kdy1heGktZG1hYy9kdy1heGktZG1hYy1wbGF0Zm9ybS5jDQo+Pj4gaW5k
ZXggYjIzNTM2NjQ1ZmY3Li45NmIwYTA4NDJmZjUgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9k
bWEvZHctYXhpLWRtYWMvZHctYXhpLWRtYWMtcGxhdGZvcm0uYw0KPj4+ICsrKyBiL2RyaXZlcnMv
ZG1hL2R3LWF4aS1kbWFjL2R3LWF4aS1kbWFjLXBsYXRmb3JtLmMNCj4+PiBAQCAtMjcxLDcgKzI3
MSw5IEBAIHN0YXRpYyB2b2lkIGF4aV9kbWFfaHdfaW5pdChzdHJ1Y3QgYXhpX2RtYV9jaGlwICpj
aGlwKQ0KPj4+ICAgICAgICAgICAgICAgIGF4aV9jaGFuX2lycV9kaXNhYmxlKCZjaGlwLT5kdy0+
Y2hhbltpXSwgRFdBWElETUFDX0lSUV9BTEwpOw0KPj4+ICAgICAgICAgICAgICAgIGF4aV9jaGFu
X2Rpc2FibGUoJmNoaXAtPmR3LT5jaGFuW2ldKTsNCj4+PiAgICAgICAgfQ0KPj4+IC0gICAgIHJl
dCA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoY2hpcC0+ZGV2LCBETUFfQklUX01BU0soNjQp
KTsNCj4+PiArDQo+Pj4gKyAgICAgZGV2X2RiZyhjaGlwLT5kZXYsICJBZHJlc3NhYmxlIGJ1cyB3
aWR0aDogJXVcbiIsIGNoaXAtPmFkZHJlc3NhYmxlX2JpdHMpOw0KPj4+ICsgICAgIHJldCA9IGRt
YV9zZXRfbWFza19hbmRfY29oZXJlbnQoY2hpcC0+ZGV2LCBETUFfQklUX01BU0soY2hpcC0+YWRk
cmVzc2FibGVfYml0cykpOw0KPj4+ICAgICAgICBpZiAocmV0KQ0KPj4+ICAgICAgICAgICAgICAg
IGRldl93YXJuKGNoaXAtPmRldiwgIlVuYWJsZSB0byBzZXQgY29oZXJlbnQgbWFza1xuIik7DQo+
Pj4gICB9DQo+Pj4gQEAgLTE0NjEsMTMgKzE0NjMsMjQgQEAgc3RhdGljIGludCBheGlfcmVxX2ly
cXMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3RydWN0IGF4aV9kbWFfY2hpcCAqY2hp
cCkNCj4+PiAgICAgICAgcmV0dXJuIDA7DQo+Pj4gICB9DQo+Pj4NCj4+PiArLyogRm9yd2FyZCBk
ZWNsYXJhdGlvbiAobm8gc2l6ZSByZXF1aXJlZCkgKi8NCj4+PiArc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgZHdfZG1hX29mX2lkX3RhYmxlW107DQo+Pj4gKw0KPj4+ICAgc3RhdGlj
IGludCBkd19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICAgew0KPj4+
ICAgICAgICBzdHJ1Y3QgYXhpX2RtYV9jaGlwICpjaGlwOw0KPj4+ICAgICAgICBzdHJ1Y3QgZHdf
YXhpX2RtYSAqZHc7DQo+Pj4gICAgICAgIHN0cnVjdCBkd19heGlfZG1hX2hjZmcgKmhkYXRhOw0K
Pj4+ICAgICAgICBzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcmVzZXRzOw0KPj4+ICsgICAgIHN0cnVj
dCBkZXZpY2Vfbm9kZSAqcGFyZW50Ow0KPj4+ICsgICAgIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgKm1hdGNoOw0KPj4+ICAgICAgICB1bnNpZ25lZCBpbnQgZmxhZ3M7DQo+Pj4gKyAgICAgdW5z
aWduZWQgaW50IGFkZHJlc3NhYmxlX2JpdHMgPSA2NDsNCj4+PiArICAgICB1bnNpZ25lZCBpbnQg
bGVuX2J5dGVzOw0KPj4+ICsgICAgIHVuc2lnbmVkIGludCBudW1fY2VsbHM7DQo+Pj4gKyAgICAg
Y29uc3QgX19iZTMyICpwcm9wOw0KPj4+ICsgICAgIHU2NCBidXNfd2lkdGg7DQo+Pj4gKyAgICAg
dTMyICpjZWxsczsNCj4+PiAgICAgICAgdTMyIGk7DQo+Pj4gICAgICAgIGludCByZXQ7DQo+Pj4N
Cj4+PiBAQCAtMTQ4Myw5ICsxNDk2LDYxIEBAIHN0YXRpYyBpbnQgZHdfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4+PiAgICAgICAgaWYgKCFoZGF0YSkNCj4+PiAgICAgICAg
ICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+Pg0KPj4+ICsgICAgIG1hdGNoID0gb2ZfbWF0Y2hf
bm9kZShkd19kbWFfb2ZfaWRfdGFibGUsIHBkZXYtPmRldi5vZl9ub2RlKTsNCj4+PiArICAgICBp
ZiAoIW1hdGNoKSB7DQo+Pj4gKyAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsICJVbnN1
cHBvcnRlZCBBWEkgRE1BIGRldmljZVxuIik7DQo+Pj4gKyAgICAgICAgICAgICByZXR1cm4gLUVO
T0RFVjsNCj4+PiArICAgICB9DQo+Pj4gKw0KPj4+ICsgICAgIHBhcmVudCA9IG9mX2dldF9wYXJl
bnQocGRldi0+ZGV2Lm9mX25vZGUpOw0KPj4+ICsgICAgIGlmIChwYXJlbnQpIHsNCj4+PiArICAg
ICAgICAgICAgIHByb3AgPSBvZl9nZXRfcHJvcGVydHkocGFyZW50LCAiZG1hLXJhbmdlcyIsICZs
ZW5fYnl0ZXMpOw0KPj4+ICsgICAgICAgICAgICAgaWYgKHByb3ApIHsNCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgbnVtX2NlbGxzID0gbGVuX2J5dGVzIC8gc2l6ZW9mKF9fYmUzMik7DQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgIGNlbGxzID0ga2NhbGxvYyhudW1fY2VsbHMsIHNpemVvZigq
Y2VsbHMpLCBHRlBfS0VSTkVMKTsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgaWYgKCFjZWxs
cykNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+
PiArDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMy
KHBhcmVudCwgIiNhZGRyZXNzLWNlbGxzIiwgJmkpOw0KPj4+ICsgICAgICAgICAgICAgICAgICAg
ICBpZiAocmV0KSB7DQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycigm
cGRldi0+ZGV2LCAibWlzc2luZyAjYWRkcmVzcy1jZWxscyBwcm9wZXJ0eVxuIik7DQo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+PiArICAgICAgICAgICAg
ICAgICAgICAgfQ0KPj4+ICsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgcmV0ID0gb2ZfcHJv
cGVydHlfcmVhZF91MzIocGFyZW50LCAiI3NpemUtY2VsbHMiLCAmaSk7DQo+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkZXZfZXJyKCZwZGV2LT5kZXYsICJtaXNzaW5nICNzaXplLWNlbGxzIHByb3BlcnR5XG4iKTsN
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4+ICsgICAg
ICAgICAgICAgICAgICAgICB9DQo+Pj4gKw0KPj4+ICsgICAgICAgICAgICAgICAgICAgICBpZiAo
IW9mX3Byb3BlcnR5X3JlYWRfdTMyX2FycmF5KHBhcmVudCwgImRtYS1yYW5nZXMiLA0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNlbGxz
LCBudW1fY2VsbHMpKSB7DQo+Pg0KPj4gV2UgaGF2ZSBjb21tb24gY29kZSB0byBwYXJzZSBkbWEt
cmFuZ2VzLiBVc2UgaXQgYW5kIGRvbid0IGltcGxlbWVudCB5b3VyDQo+PiBvd24uDQo+IA0KPiBB
Y3R1YWxseSwgdGhlIGRyaXZlciBhbmQgRFQgY29yZSBzaG91bGQgdGFrZSBjYXJlIG9mIGFsbCB0
aGlzIGZvciB5b3UNCj4gYW5kIHRoZXJlJ3Mgbm90aGluZyB0byBkbyBpbiB0aGUgZHJpdmVyLiBB
IGRyaXZlciBvbmx5IG5lZWRzIHRvIHNldA0KPiB0aGUgbWFzayBmb3IgdGhlIElQIGl0c2VsZiBh
bmQgb25seSB3aGVuID4zMiBiaXRzLiBUaGUgY29yZSB0YWtlcyBjYXJlDQo+IG9mIGFueSBhZGRp
dGlvbmFsIHJlc3RyaWN0aW9ucyBpbiB0aGUgYnVzLg0KPiANCj4gUm9iDQoNClRoZSBjdXJyZW50
IGltcGxlbWVudGF0aW9uIGV4cGxpY2l0bHkgc2V0IHRoZSBtYXNrIHRvIDY0Lg0KDQotICAgICBy
ZXQgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGNoaXAtPmRldiwgRE1BX0JJVF9NQVNLKDY0
KSk7DQoNCldpbGwgdGhlIGNvcmUgcmUtc2V0IHRoZSBtYXNrIGJhc2VkIG9uIHRoZSBkbWEtcmFu
Z2VzIG9uIERUPw0KDQpUaGFua3MuDQoNClJlZ2FyZHMsDQpLaGFpcnVsDQoNCg==

