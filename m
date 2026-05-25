Return-Path: <dmaengine+bounces-10806-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA+vBpvpE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10806-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:18:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F11B5C6455
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DAE03013D57
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592EA257825;
	Mon, 25 May 2026 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GEou20HF"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBDA1E0DD8;
	Mon, 25 May 2026 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779689861; cv=fail; b=hCQSLwRJ2vBHiBIJBUCVnTmfE5nsiZ0Nd9hHPJ5qlIo97enA2e2woQutTxRzl1Ud/k9eFt3mj3Yc0YTrsdZs32SYTwqoUMlQdGnBL6TLdmqsREoFrysQzUy8KFu63ruFQr8+tiEOEB5vazQB0plABCnb1EA/oOZrL52G7CHik70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779689861; c=relaxed/simple;
	bh=CCfg24bE/5oqCUFFNeqmbD8vg5EH7zIjukPz7EQK0Ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EUL9PLHsVDpHgDQc+AMvp94c2/vHHbPiu2e7mHvQTkaAp3Qn8NfJEsScbMzXGJmTkRoYcNlQR+uc8sIQ+wtwIHPdvwIHI37o67dqLp0Cc86xKc1o/8dUhr0OxtLlmg57R7Fj+0McKQFhwYiYYzTCmrz7IOoc6BIWj+CBjK122Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GEou20HF; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvEI0krq9iCqfX8D1+04MRz3PLayvh7rayzdUkFplTrF57qKK/eQilnEKFoNJYrZ8oNEYxBwCsT/SFb528aJ0wkHJ3I/tM4ufjQIXVI12fruBUQOpMiC9ecvf/1MWZ0ygOxcTyQxwR7+BAZN4sAxzuQtey3DAIz9y3k1K5TkCNcldlTlkWMWVKGzr8/C74D3Vwyv2JjRTwRta31QRlXV2rkhVI1cPzcVdGhcrBZzNIh5zWdkOIw9/cn71wniQ9SOwl5xqj5xeHA8wPI6j5hcGE1ROoarp9Cquqd44LceAQsU2Ot58oHjrWJh9sWcOM16SE7YHF80aEpAcPcyb7K2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCfg24bE/5oqCUFFNeqmbD8vg5EH7zIjukPz7EQK0Ew=;
 b=enQd5Jl/CD3zyNhX9rCBwgws6Jl82VcllbogP6/3aVGXeaPmyubxWCKrErN4k47skON4ulI8QmO6w/t2ZTb0bLYp6stSZ5GZ8xNBaPV0P7w7k0QXDCdy2BAR4C5Y7p7eev0+jjI0cgnzJDBktCvEyPQwaEZBlB7lHJJonGrgSnwz4s8kgxaleyV2CoIEGyDzdeRcxX0YBqcw0IQQLTChZW5yJ6mGMIz4LjCXyVxgDg1Wxm85Ewlbkctg7vOcg2e+cVH9Lqne0hxsxvbAk2zMOwnvfV5BiLGD1nTv22/cUzd5fCW+VEMwaSz6NuWDzEiMUmVQ9VjMHnwerYAphig/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCfg24bE/5oqCUFFNeqmbD8vg5EH7zIjukPz7EQK0Ew=;
 b=GEou20HF3XLxQBCMcBjx0IsFffCy+HAjg8Y5pr0FdI4ew8IKoH2QJjpOGiWs9jsn2FnTqyx8fO//9I/aPeWs5d+z7bJI4wfbauelGtNE6VB2OWilsJhmEznTrwzC1PU0EvsKr/gsoEDSwR9YVsh/QsV9X/UQtSxIfyCa5JSssr2vtxxmvcnVBCLrYDUOidK6GpoptPigaD6/QkiRkqo1faAQVpnMSVI1EMkXY6TGggOt8bb1kEpaaASXGEF7A5PoXPnxIZZk3pNa8vhSf8DOYfb5l0I3epCPLQGYFDLuPX2BbeuR6sMEw+4BhUBAsq3gLKV5ctmLVzZqg14Dtq7oPQ==
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB6551.namprd03.prod.outlook.com (2603:10b6:a03:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:17:36 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 06:17:36 +0000
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
To: Frank Li <Frank.li@nxp.com>
CC: Olivier Dautricourt <olivierdautricourt@gmail.com>, Stefan Roese
	<sr@denx.de>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "NG, ADRIAN HO
 YIN" <adrian.ho.yin.ng@altera.com>, "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: Re: [PATCH] dma: altera-msgdma: Replace memcpy with io32write in
 msgdma_copy_one
Thread-Topic: [PATCH] dma: altera-msgdma: Replace memcpy with io32write in
 msgdma_copy_one
Thread-Index: AQHc51tYFSPJSHId1UCxmI2LBqJobbYXcOOAgAbcwYA=
Date: Mon, 25 May 2026 06:17:36 +0000
Message-ID: <8d9bd7a0-4927-40d8-a747-c3d7cf34cf67@altera.com>
References:
 <4586c39b43aa3b9480989940fe905dac40c8cefc.1779173156.git.tze.yee.ng@altera.com>
 <ag4n0ycl1KB3p0hP@lizhi-Precision-Tower-5810>
In-Reply-To: <ag4n0ycl1KB3p0hP@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB6551:EE_
x-ms-office365-filtering-correlation-id: abf87b1f-513c-4d6e-6ac7-08deba2550b2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003|38070700021|55112099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 /GDwm7azZvPRVwWJN1EqxMxxP3Jo0nCvO9wzptkWano/Wg1eipNjTxqa7LhaGJRT0UPMq0fKWGEHSxSWwA4cy8xojJQNh5zjdLacBA0a7nE/llRHkHrFW2Uc6s6AojJxaQW2lZSOoHlvcFaHWk0iGNnBPZEgCiTJFQ0GRfXbwHWHJs5eXn5MP/yFl3dI34C8yJ875OnXIvpSTZNELNQmLG/EhOaOO0lJAwDS8exAddd5gyUnj60eTjLWJO4HxKqx2A7nWS+WWcyR/pJp5z+h/AsnkxbfabwtBCculPuHDQ8UcrcOTbMVbVKHbboW5SaLGVMps7M/0/6Xhxm9euHoHxDh4wUlPZxNYrLJyesoaxUgKbA0+F2Toaqc3uAr+7tg8tRc0QMLI+5FAUvZaM3gK/gA5kz4asG0GtrRpXYbN7k/fmJRvRZrr/X0hmq9Hwhc1pu2I+Sl30fOnVBBqbJxp4sxs+rIuIUpUVOmh/3wwCYvdDRKX8omPNCLQgAaZnIe1NmVUzWaY4ES+NxkoeWr2ljzVmAwhA2WLmY8AeSxVU7hhkhrbpVyaSMx+JQjRQVatODpond6gXHFZPkdVpo83H712Gy14y7KYQIRWL67szrQO+7fCx7KgYpgLKRQlcLPYF/KPjk7hGIdyFohga5bMspsFVYIAqDbN3xVu5Q5CXLpdJmhUN4Rcm30uvICYjKHEB6dRGkVDBOwYlY06BJc6UY8wPQW/B0ZwSeqmsDjCbMn3PhJ1c/FIMtGZBfoKWNQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003)(38070700021)(55112099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkVpdGtSZldJUXlCODZOM1h4UnRDK3ZUWjljcnpKV3dxVFpLbE5JaDR1QmhG?=
 =?utf-8?B?VnpMQnV4NkgzSjcyWno4Y1RrVVFuWVNjM1Z6Q24vd0twbDNHZEUwelAvRTRy?=
 =?utf-8?B?Rmd3VVZsUjFkQ0I4RmRWeWhEdkZ5WDdHU1V6UnIyN0pVNmVMVGplZ2VsbnF6?=
 =?utf-8?B?MzlMdS8wVlFEcWRsaXNYSHVLSytUQzBUVEFiY3BTNmpWSUVpTzdNRVAxSkd5?=
 =?utf-8?B?VEFaTzBBUzVsWWg0QVRqQkxVZTJsNFZ3S0VPMm5hL3Vydnh6VGJhMEtSaHYv?=
 =?utf-8?B?RkNDb2RZZDlyeWFCUm9HZGs0eVk0bGRPZm55dWZOamRMdGhFbGs0c3lMSjV3?=
 =?utf-8?B?eS81dVkwQUdDdis4ak1EcjR5ZlEwTTdDcmY3VldGejJvTnYzR1QvelV4NU5M?=
 =?utf-8?B?T2NlM1cxMEFTSklidVNLWFlpSFk2QzRyOHZ4RjRCTG1aVWFES2dQU2FsVUZU?=
 =?utf-8?B?OHZzMXp0N0pkU05xU1ViVUh5Snd4eDJBK25jMWg2RWpiL2MvNkRBcDQ1WlJP?=
 =?utf-8?B?cFhRckUzYlBVZkRQK3Nqa0pod1R2VENMMVRkWXhuMmJWaHR0SHJudVVBTDhn?=
 =?utf-8?B?eTFBbkJzY0hyaXZOcTZYdWJHOHBVa1lqTkZrYjA4aWpkSERPSlpTWFNQaEFV?=
 =?utf-8?B?M2RKNFlFNHJxSTQxaTJ2M2dubjZXakw3NlV2YlNybmxqTGowSVU1anVGcWFp?=
 =?utf-8?B?dnk3bjhZOVp4SVNWZ1VxRXg3bXR5UUg0Vk5FOW5HMGdtUmtWNWJ6c0pyQ25T?=
 =?utf-8?B?Zm5JNjl0OGFxVXRZRHpvODNoZkRHbGNRWENlR1R6V0ZtOXFOeWxucmdURnJ4?=
 =?utf-8?B?blZNeFN3M1dlQnk5Y0NrUnltQkZhVHFhdFRlVXVTb0ZqdisrQzdoV3lzZFhO?=
 =?utf-8?B?ZmN5T0RPa29TZkF6dUVIM0c0MUdDbENUM3ZUQk1uY0hURzRpR3ZtOVlISlYv?=
 =?utf-8?B?MDhPN3Y5YVVDZU80OFQ5YWRIZzdUcjFQRXpQQVdEa2RTN1BUbkszUTNiMjFx?=
 =?utf-8?B?eElVaGphQWliL084UE9TdE1JSWV6MTVNaVBWWnpYVSt6ZE5aWmYrWVJYU1NH?=
 =?utf-8?B?eE9NallCRmtHUzV2bTM5cS9DeVhwdXFOSkdtUXhrQ1YzR1cvaTJ2WXVwQy9T?=
 =?utf-8?B?RnZFZkZLQk80aUd2REthTWNmdjFPWnR0K0hEc2c4MmdVcDVObGdxWDM2djFR?=
 =?utf-8?B?eW1yYS84anh4TlRLL3k2WGdkR05mcXpOYVRPam9uY0FLWTJUekVha2N3alBk?=
 =?utf-8?B?M0RmVkVuSzNxSFdNNEdiK2VVaUNuT0VjVFpIZEQ3Tm1YZGNZOStmVThlTXBH?=
 =?utf-8?B?cWRWcDhjck9ULzcvMXFKQVhqcHNuZ0w1cUNybHJieXFDZ3V0RWJKaU51RWtv?=
 =?utf-8?B?Q2tXSGlXelZ0ei9FZnJNRU5GS0JlMDN5T0V5Qmc0b3p1bnUrTjdFaERUMDdW?=
 =?utf-8?B?UmkrTU5kYVo0NEF5UjJMejMrZllZZmN1YnYrQUduSE15L2NZTTU1eXRVanRK?=
 =?utf-8?B?QkJkNXFRU2dTMjk4ZXc3eGhlS04rS01nRU8vTjFNWnlodEFyakFVNU9Qb0Fa?=
 =?utf-8?B?OVJxMFZHR2UzM0xaM1hJS2hXaWJyaUd0TXhXUUg4WVhwejJUb0Fod2I3VHY0?=
 =?utf-8?B?K2lqMHFOYUJ0am9sR3VNRUVoSXRYODdJOEFQckFZRkJZZmlaS1JQTy9sYktu?=
 =?utf-8?B?VFNwSmlISm41UXpHMCs4cWZrRU5EaHN6UVVFZEh5RXlJdGlUUDhWT0lsOXJw?=
 =?utf-8?B?SGQ5NWtOaFJPM0FWcTV6U0tzbzI5WjFKVDI4NWNBSHNnVHVkNDdWUFp2QVBi?=
 =?utf-8?B?S1JGTGJqYnFIeXVKWmp2SkpiNFMrRmpHWEQ3Z2MzeEt6dnRQMGdLS055REli?=
 =?utf-8?B?OGdnTzY2RVllNkdSM3BFcXMzTFprbUNMWHpualUzcThqaHJjemxOWjJ2QVZp?=
 =?utf-8?B?Qk9xRkZkWjIvUm05SWFxU2o0am5Eb1pEQ1VSZ0k5Z1NHN0VjSTBhelZuLzJn?=
 =?utf-8?B?d29qSlhadEUrRHdBdmhNbTZxU29NTHRnNlpBYmwyY0d5c1NRRGVWUktlWW1w?=
 =?utf-8?B?ZkNxNm9tcWRScWo2Qkl3VHVWdVNkRCtkeG1VWTBLTHlkY1BjUHVxaVJyV05N?=
 =?utf-8?B?blpiWDR1amJxbkM5bmUvVUcyeUVzU25RUmVzL2dvSUJOQ0JSa3B3QmZvUERi?=
 =?utf-8?B?clFtRmViZk9ValpxaksvTnNNQy9UbkZKYWM0WFR4a0pZeG5jb2RaTjdwcFI0?=
 =?utf-8?B?eVBEYVBxMm4xa2I4MWw0aEd1OFk4bldSUk1zek5GbUVYVWxQVmVWU0lkc0Nr?=
 =?utf-8?B?QXN3RERiK0NEUXNndDhQanc3bzRvM0xyclV2UjdXMjhNU2pEM0hXalpJT01k?=
 =?utf-8?Q?fr8XQ0EI4XsXNreY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E312B3219F5D8149BC043EAA03AFF311@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf87b1f-513c-4d6e-6ac7-08deba2550b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 06:17:36.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ifs6JNBewWQSPixy+OubFqTfHwUMn7mpjq1R0Nwc3dbzYxvBEGB0BAA9jU6sssDQL+pVPnukwA0cMQ5dFoM2vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6551
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org,altera.com];
	TAGGED_FROM(0.00)[bounces-10806-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[altera.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tze.yee.ng@altera.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,altera.com:email,altera.com:mid,altera.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aka.ms:url]
X-Rspamd-Queue-Id: 6F11B5C6455
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gMjEvNS8yMDI2IDU6MjkgYW0sIEZyYW5rIExpIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hv
IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBmcmFuay5s
aUBueHAuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMv
TGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IE9uIE1vbiwgTWF5IDE4LCAy
MDI2IGF0IDExOjQ3OjIwUE0gLTA3MDAsIHR6ZS55ZWUubmdAYWx0ZXJhLmNvbSB3cm90ZToNCj4+
IEZyb206IEFkcmlhbiBOZyBIbyBZaW4gPGFkcmlhbmhveWluLm5nQGFsdGVyYS5jb20+DQo+Pg0K
Pj4gVGhlIGRlc2NyaXB0b3IgRklGTyByZXF1aXJlcyB0aGF0IGFsbCB3b3JkcyBvZiBhIGRlc2Ny
aXB0b3IgYXJlIHdyaXR0ZW4NCj4+IGluIG9yZGVyLCB3aXRoIHRoZSBjb250cm9sIHdvcmQgd3Jp
dHRlbiBsYXN0IHRvIGZsdXNoIGl0IGludG8gdGhlIERNQQ0KPj4gZW5naW5lLiBVc2luZyBtZW1j
cHkoKSBpcyB1bnNhZmUgc2luY2UgaXQgZG9lcyBub3QgZ3VhcmFudGVlIG9yZGVyaW5nIG9mDQo+
PiBNTUlPIHdyaXRlcyBhY3Jvc3MgYWxsIGFyY2hpdGVjdHVyZXMuDQo+Pg0KPj4gUmVwbGFjZSBt
ZW1jcHkoKSB3aXRoIGFuIGV4cGxpY2l0IGlvd3JpdGUzMigpIGxvb3AgZm9yIGVhY2ggMzItYml0
IHdvcmQNCj4+IChleGNlcHQgdGhlIGNvbnRyb2wgd29yZCkuIFRoZSBjb250cm9sIHdvcmQgaXMg
c3RpbGwgd3JpdHRlbiBzZXBhcmF0ZWx5LA0KPj4gd2l0aCB3cml0ZSBiYXJyaWVycywgdG8gZW5z
dXJlIGl0IGlzIGFsd2F5cyB0aGUgZmluYWwgd29yZCBwdXNoZWQgaW50bw0KPj4gdGhlIEZJRk8u
DQo+Pg0KPj4gVGhpcyBtYWtlcyB0aGUgcHJvZ3JhbW1pbmcgb2YgZGVzY3JpcHRvcnMgZnVsbHkg
ZGV0ZXJtaW5pc3RpYyBhbmQNCj4+IHBvcnRhYmxlIGFjcm9zcyBkaWZmZXJlbnQgYXJjaGl0ZWN0
dXJlcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBZHJpYW4gTmcgSG8gWWluIDxhZHJpYW5ob3lp
bi5uZ0BhbHRlcmEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVHplIFllZSBOZyA8dHplLnllZS5u
Z0BhbHRlcmEuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZG1hL2FsdGVyYS1tc2dkbWEuYyB8
IDIxICsrKysrKysrKysrKy0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEv
YWx0ZXJhLW1zZ2RtYS5jIGIvZHJpdmVycy9kbWEvYWx0ZXJhLW1zZ2RtYS5jDQo+PiBpbmRleCBi
NDY5OTljODFkZjAuLjU4MTY5NzNkMmM3MCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZG1hL2Fs
dGVyYS1tc2dkbWEuYw0KPj4gKysrIGIvZHJpdmVycy9kbWEvYWx0ZXJhLW1zZ2RtYS5jDQo+PiBA
QCAtNDk1LDYgKzQ5NSw5IEBAIHN0YXRpYyB2b2lkIG1zZ2RtYV9jb3B5X29uZShzdHJ1Y3QgbXNn
ZG1hX2RldmljZSAqbWRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBt
c2dkbWFfc3dfZGVzYyAqZGVzYykNCj4+ICAgew0KPj4gICAgICAgIHZvaWQgX19pb21lbSAqaHdf
ZGVzYyA9IG1kZXYtPmRlc2M7DQo+PiArICAgICBjb25zdCB1MzIgKnNyYyA9IChjb25zdCB1MzIg
KikmZGVzYy0+aHdfZGVzYzsNCj4+ICsgICAgIHVuc2lnbmVkIGludCBpLCBud29yZHMgPSBvZmZz
ZXRvZihzdHJ1Y3QgbXNnZG1hX2V4dGVuZGVkX2Rlc2MsIGNvbnRyb2wpIC8NCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzaXplb2YodTMyKTsNCj4+DQo+PiAgICAgICAgLyoNCj4+
ICAgICAgICAgKiBDaGVjayBpZiB0aGUgREVTQyBGSUZPIGl0IG5vdCBmdWxsLiBJZiBpdHMgZnVs
bCwgd2UgbmVlZCB0byB3YWl0DQo+PiBAQCAtNTA1LDE2ICs1MDgsMTYgQEAgc3RhdGljIHZvaWQg
bXNnZG1hX2NvcHlfb25lKHN0cnVjdCBtc2dkbWFfZGV2aWNlICptZGV2LA0KPj4gICAgICAgICAg
ICAgICAgbWRlbGF5KDEpOw0KPj4NCj4+ICAgICAgICAvKg0KPj4gLSAgICAgICogVGhlIGRlc2Ny
aXB0b3IgbmVlZHMgdG8gZ2V0IGNvcGllZCBpbnRvIHRoZSBkZXNjcmlwdG9yIEZJRk8NCj4+IC0g
ICAgICAqIG9mIHRoZSBETUEgY29udHJvbGxlci4gVGhlIGRlc2NyaXB0b3Igd2lsbCBnZXQgZmx1
c2hlZCB0byB0aGUNCj4+IC0gICAgICAqIEZJRk8sIG9uY2UgdGhlIGxhc3Qgd29yZCAoY29udHJv
bCB3b3JkKSBpcyB3cml0dGVuLiBTaW5jZSB3ZQ0KPj4gLSAgICAgICogYXJlIG5vdCAxMDAlIHN1
cmUgdGhhdCBtZW1jcHkoKSB3cml0ZXMgYWxsIHdvcmQgaW4gdGhlICJjb3JyZWN0Ig0KPj4gLSAg
ICAgICogb3JkZXIgKGFkZHJlc3MgZnJvbSBsb3cgdG8gaGlnaCkgb24gYWxsIGFyY2hpdGVjdHVy
ZXMsIHdlIG1ha2UNCj4+IC0gICAgICAqIHN1cmUgdGhpcyBjb250cm9sIHdvcmQgaXMgd3JpdHRl
biBsYXN0IGJ5IHNpbmdsZSBjb2RpbmcgaXQgYW5kDQo+PiAtICAgICAgKiBhZGRpbmcgc29tZSB3
cml0ZS1iYXJyaWVycyBoZXJlLg0KPj4gKyAgICAgICogVGhlIGRlc2NyaXB0b3IgbXVzdCBiZSB3
cml0dGVuIGludG8gdGhlIGRlc2NyaXB0b3IgRklGTyBvZiB0aGUgRE1BDQo+PiArICAgICAgKiBj
b250cm9sbGVyLiBUaGUgRklGTyBpcyBmbHVzaGVkIGFuZCB0aGUgZGVzY3JpcHRvciBiZWNvbWVz
IHZhbGlkIG9uY2UNCj4+ICsgICAgICAqIHRoZSBsYXN0IHdvcmQgKHRoZSBjb250cm9sIHdvcmQp
IGlzIHdyaXR0ZW4uIFRvIGd1YXJhbnRlZSB0aGUgb3JkZXJpbmcNCj4+ICsgICAgICAqIG9mIE1N
SU8gd3JpdGVzIGFjcm9zcyBhbGwgYXJjaGl0ZWN0dXJlcywgd2Ugd3JpdGUgZWFjaCAzMi1iaXQg
d29yZA0KPj4gKyAgICAgICogaW5kaXZpZHVhbGx5IHVzaW5nIGlvd3JpdGUzMigpLCBhbmQgaGFu
ZGxlIHRoZSBjb250cm9sIHdvcmQgc2VwYXJhdGVseQ0KPj4gKyAgICAgICogYXQgdGhlIGVuZC4g
VGhpcyBlbnN1cmVzIHRoZSBjb250cm9sIHdvcmQgaXMgYWx3YXlzIHdyaXR0ZW4gbGFzdCBhbmQN
Cj4+ICsgICAgICAqIHByZXZlbnRzIG1lbWNweSgpIG9yIHRoZSBjb21waWxlciBmcm9tIHJlb3Jk
ZXJpbmcgYWNjZXNzZXMuDQo+PiAgICAgICAgICovDQo+PiAtICAgICBtZW1jcHkoKHZvaWQgX19m
b3JjZSAqKWh3X2Rlc2MsICZkZXNjLT5od19kZXNjLA0KPj4gLSAgICAgICAgICAgIHNpemVvZihk
ZXNjLT5od19kZXNjKSAtIHNpemVvZih1MzIpKTsNCj4+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBu
d29yZHM7IGkrKykNCj4+ICsgICAgICAgICAgICAgaW93cml0ZTMyKHNyY1tpXSwgaHdfZGVzYyAr
IGkgKiBzaXplb2YodTMyKSk7DQo+IA0KPiB3aHkgbm90IHVzZSBtZW1jcHlfdG9pbygpPw0KPiAN
Cj4gRnJhbmsNCj4+DQo+PiAgICAgICAgLyogV3JpdGUgY29udHJvbCB3b3JkIGxhc3QgdG8gZmx1
c2ggdGhpcyBkZXNjcmlwdG9yIGludG8gdGhlIEZJRk8gKi8NCj4+ICAgICAgICBtZGV2LT5pZGxl
ID0gZmFsc2U7DQo+PiAtLQ0KPj4gMi40My43DQo+Pg0KSGkgRnJhbmssDQoNCkdvb2QgcG9pbnQg
4oCUIHRoZSBpc3N1ZSB3aXRoIHRoZSBvcmlnaW5hbCBjb2RlIHdhcyBtZW1jcHkoKSB3aXRoIF9f
Zm9yY2UgDQp0byBfX2lvbWVtLCBub3QgYnVsayBNTUlPIGNvcGllcyBpbiBnZW5lcmFsLiBtZW1j
cHlfdG9pbygpIGlzIHRoZSByaWdodCANCkFQSSBmb3IgdGhlIGRlc2NyaXB0b3IgYm9keSBhcyBs
b25nIGFzIHdlIHN0aWxsIG9taXQgdGhlIGNvbnRyb2wgd29yZCANCmFuZCB3cml0ZSBpdCBsYXN0
IHdpdGggd21iKCkgKyBpb3dyaXRlMzIoKSwgd2hpY2ggdGhlIGhhcmR3YXJlIHVzZXMgdG8gDQpj
b21taXQgdGhlIGRlc2NyaXB0b3IgaW50byB0aGUgRklGTy4NCg0KSSdsbCBzdWJtaXQgdGhlIHYy
IHBhdGNoIHdpdGggbWVtY3B5X3RvaW8oKS4NCg0KVGhhbmtzLA0KVHplIFllZQ0KDQo=

