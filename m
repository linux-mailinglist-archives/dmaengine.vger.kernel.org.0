Return-Path: <dmaengine+bounces-1423-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD99787EFA9
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD911F23CD8
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78F656763;
	Mon, 18 Mar 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ACaNm84i";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JkIbkbl2"
X-Original-To: dmaengine@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1EF56442;
	Mon, 18 Mar 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785902; cv=fail; b=tRuLOHPFOskBxpDP6omYKlxO/Dj0a5oJYjeBVPCl27trSgdngkJvJ//1tPGZAQB52NdiCNPIWE9A9TuCXhlxlSZceSd/s93Flk1AJWa1q2GVnvQcYb+v1gqgpyoF5F67AagQJYlXri5ZkjJ2XP3iqPDQG+p5z4JP2E8BWKkwMhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785902; c=relaxed/simple;
	bh=qYy1LORlnRGhs8uMxlz9+f30nTBp77V8Tb+hNyocqbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYZinoY52NSlGlxqRoOwyzeqcXVNXEjQ1LolsbZFagiQ7IbVR82rGB8/JiQFf/4frJAWWmb6G2vEq/xEfZPjmF7fHo//MD1QjpDtcJQDJo+K5bSJBBDSiYczFv9E7EaRKJvLuKiu+O1S0Wvmn56BNDusyFkBKhhFLqFsodQNCJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ACaNm84i; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JkIbkbl2; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1710785900; x=1742321900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qYy1LORlnRGhs8uMxlz9+f30nTBp77V8Tb+hNyocqbw=;
  b=ACaNm84i1TstbjqdimWro9jWD/l2wVf1bsaL3bNqHzbDWohXC53QOwUt
   WhrEnN9RwVLeugCuOLcCNPbI6QOiJZBllDinoHZ45PMb1xoabBPuvhbGY
   xB7jGxsEW8BS5/eTGA8rPL2im5kz0cenrS0Il/3H04hMVyRcUjBC00wcu
   uvafm4Cm5a49Bq4CqQ4QGVd1s9n6wtHcQErH6pcPXQaA3U6v3lXt3dMGP
   tcGlI0GqRwTsdbvDjEU9HDaGLYdtU/9wArP5B1Unu1LiNtFj3XWzhCjtu
   WQniZioq0TeJ60LC0mIEVn7hBsqqi/SHt+uQ7mHw2B5z/8fHE4FmbK+xF
   g==;
X-CSE-ConnectionGUID: GKKgAqd7R5uKtfbXr+wupA==
X-CSE-MsgGUID: 4GUyWbhXTEWqljk4HnRLnA==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; 
   d="scan'208";a="185072403"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2024 11:18:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 11:18:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 11:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KK1BXNmqjeD99zBfbzq/oD1kCHBcxMpjENNClhNCfcL2hHDwVy2f/GVcqNqCT81aQ5Hln/JeENHU7hHUEaLr7PFrNK0BBSrkCQg9VDPjjfKKM4sIOiRb5WkmC8vqO2syAxkuWpH0PkCcMjU2YzAk2QXr59VTIOuKT5nY9xQDJWqePHDFntEmu3U1zmdhSEYdl0iifqPSxTx+o+lJ/EAS5epg92TxXD0PkP+aldtg5V0N6/1EcewmrRIR639tQcuDke4pnlovoO07IKReBbPdDCHx5wik1K8Y82R8UVFIKSnSgBJpJVXHagOGFKbVSjL4L4EIv2HFcgym1Y63ILpoxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYy1LORlnRGhs8uMxlz9+f30nTBp77V8Tb+hNyocqbw=;
 b=ccbpHRFGq28k2c9QpwRv7N8/OvkigeK86AyZt8W3Uyi/1hvLLAzEF+ro3CP1dl55cJjcIE6jZc060+IBXB+9JwjIxb/hlBbZ1mvc0nrJyPg8gIBY8aOJwNnA0Q0p/bgOdamCbXm+XsgCllmaFuPyGhMcv1PYqCTp39kvwxQjVwA2uMXPrCdxexNnbZzzFbZnLs2TI4NrfOSGY0dNRBTZwrmvRBJ/4BmhlCD9pESCaMHnQa4ZYip/a34L3qTBXpHVjiscw7MwYjv9XTiayPIVxgbKI8vTeLodEFDzV0Tlvi1YgRDclO85wyFQEam7OqXDImdE5cC7FpvDldYULfvuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYy1LORlnRGhs8uMxlz9+f30nTBp77V8Tb+hNyocqbw=;
 b=JkIbkbl2YwRDWSlyC/ZNY0ENSequvtqifO4+Qw5i/XcmBz8u2Js5BhH2X0RbekdFOzzDXWFvDmixmwrMz6HwfOFVlZFuEUdEjXQNGtqOLm7Z4oPHSFBSXAVKeEanYW2k9D846jl88SLQr7ubA9+ExCVZJSTmGKQn3SWllk9w1a+s+1UESY/0mSIS2s67qaf0+a6QXAaVRemyCExbDUxjCkpXQSdnhzd5596TwpJ1tuJlymz8xJIqNOreVjnYInkXt2zGJdUMEeZN7X0d7yZae6TqlC18VXEK0oJVhrfLzB3pTEY7Xbw3Ujf9NRDkTf6/5fCQTTFX/QrdF4q1bqfoeA==
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 18:18:12 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::921:548d:66c4:43ba]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::921:548d:66c4:43ba%3]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 18:18:12 +0000
From: <Kelvin.Cao@microchip.com>
To: <vkoul@kernel.org>, <hch@infradead.org>
CC: <dmaengine@vger.kernel.org>, <George.Ge@microchip.com>,
	<linux-kernel@vger.kernel.org>, <logang@deltatee.com>,
	<christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v7 0/1] Switchtec Switch DMA Engine Driver
Thread-Topic: [PATCH v7 0/1] Switchtec Switch DMA Engine Driver
Thread-Index: AQHZ/JlyCX03hIIKNE6cYQj1McwQzLEIhjUAgAUjWYCAMR6CAA==
Date: Mon, 18 Mar 2024 18:18:12 +0000
Message-ID: <b70b4155ea8c99c1bae8a26854690931a814155a.camel@microchip.com>
References: <20231011220009.206201-1-kelvin.cao@microchip.com>
	 <ZcsButDIoe0AjiuD@infradead.org> <Zc9RH1kV0ILtzEpa@matsya>
In-Reply-To: <Zc9RH1kV0ILtzEpa@matsya>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5618:EE_|DS0PR11MB7926:EE_
x-ms-office365-filtering-correlation-id: f049fa60-e12d-493c-7664-08dc4777c5d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfNKQ+qfCtyBzjQw84eJMqIFySehW7n8t8PpRN1P4aoUYdbgVqn+oUX5nqKrQnWgDKg8WhKzsK/WGitS0SH956FftXig78WVM3bIU6fscrZh9I3b1Q4elBtc7KqKzlsxTgrRKAUHyb1qLe+gwt/DVNdscx0vge80fNBiXWgAYgmf9HAps22PdDdmcJ9e6ysJ7RkpBK0P+Ww5M9CVKjcAd6WSrJz4jckTcKQt6eY61zL2FDjI4EVETm4vP3M332NdSTPPIzMQ5R/jZ9PwibEw9dAGrTGJiBCrVhLsBcP3fusPjD2YdoK16S0kx4RpW2aL9VUAd70Cz6uYkOTE6oqaot8yfEslapY9Kg3FoqsmIi2GaDjv1rqjZQxZfN5ghYWVnvPozdaSpUyRsqWLK8go02AGyOA8rlk1zRJmdtUtCsiIF8zhrNb9ljMK5Hr7SUO7wpje8ntcICCrrpfkOyJyaxd6PziiiQ/yHZvKc+wfnisnn7e+KwFoZmjqPvajQeS96SJlfjXpz7JMVxZDyteDa4Re6VqJqqozi5up2b5DCDA9bVjhMLiNB6lA4HAXlqCCW+gwhUycIQm+hiu2UBYfdGVbt5GHIK6aGXE7CMeNwWUYPC7keNG61ConYPwEfhaQt0QpzCdaYkY7w7ZJZlSMGiF69XMmgb3/kQMM9SxuGwPz7/srdlgyZn5Tttd1JGGmHR3XuC4EMZcAAu+DsaHU2T2n0VcikUnBw//B3oU00js=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU1YbUZ1QXpLOC9qUnlUajc5NlB3YUR2NXBHbmVWVGVkL3VCcjhaajNMT3du?=
 =?utf-8?B?VVlZbGVMS1NJS0RKZ0RoV1FJNXdVenJBRHJIOXI1Tlo3ZjJQYVRKZyt0dWxu?=
 =?utf-8?B?SUFZVmxkckwrdXdzZWg1aTh4NmRTamgySklHenQ2cjhYZVpoVDdseGFnVzRU?=
 =?utf-8?B?S3czd1V4YjFkb3ZrSy9KclQvbm12THVPRTUxYmtEMmpPempJWEJ3ckp1ek5n?=
 =?utf-8?B?TzMxK0ZpOG0rZEZmRWVTY1BXM1RQMy93WXAwTHFsd2lPVkRjbmJIejR1dzBJ?=
 =?utf-8?B?SnFxdHBjVU1HSlovL0ZTUDlDMENSeDdNdU9YWEU5Zmk1QlRsekszWUtoMHJt?=
 =?utf-8?B?Ull0K2RnWVgwc2xjalF6RWNyUWdjTnlZTUltVDFKOUJaNGpRVitkWlhMMmtt?=
 =?utf-8?B?Z0l4MUZOdUJPTWltK005eTkvQVpscTdGVXI3dU8wcTBjOElwTmRTN3A4Z1FF?=
 =?utf-8?B?ZG5VSjNjSjdQM2ZwMVVVVmNZVHlPOEprY1NEYktQRjF3aFcwZEJZVUpIVHFL?=
 =?utf-8?B?dHFXcDhqZkhhdlAzZ2t1VXhlaksrQ2h2TERDemNYaE9sa2NicDhSY3hnYXFy?=
 =?utf-8?B?RG5qRE1lNm0yQUdRREZNN0Ura2dhZldqQk5KL1JDM0hzZEhRMG9sbXMybFNH?=
 =?utf-8?B?dHBBYWN2TVN6dElEV2VwQ21lbG1MNEZyeHZtTHpQOFp1Z1A2T3loZ2tqblBQ?=
 =?utf-8?B?WGZCUHNWUk9rUFN2Q0htYWtmZWV4MzZJc0UwSi9wMjdLdTgyMG9TZGVMZTRK?=
 =?utf-8?B?L3pNdmEwYWVidlNoMkx3REEwZENOeW5ydFBvUzcvR1lFL2xNNlF2VCtyL3JU?=
 =?utf-8?B?Mzk2MDRTVG95dEZ6RHhlY3VibnJYTXVOYVJGVXhSNFBqY1JwUzJKR1AxRmVM?=
 =?utf-8?B?THZQQWdXVGozbmMxRll1M3c3ZnBaSWluVjI4WXZlNkpOTmpEUUxOUnRBajd3?=
 =?utf-8?B?ZUdaU2YxU2htZkhZclBvUjl6YVFGS3RBM2ZvN05XTUUrQzlWOWZNV0J1M3lz?=
 =?utf-8?B?UVlBSEt0am41NjhkMDZCbTNKakVJUmxBK0xWVjVtREVidTAxTnQ0NnVxTFAw?=
 =?utf-8?B?MzVNLzJEOGtyd1N0U0hRTWdwSENWR201UUZDb0NleE5pcHU0cDR6VVJCc0JB?=
 =?utf-8?B?azVCcjlBQ3cveGVVOXRWKzZmdGs5SER1RVZadVAzOUZZc2xkbTNlM3BzZE9L?=
 =?utf-8?B?aXY1aEpOZTdJYXBiTllXanhnY2ZOaHlEcXRqODcvTUlpajFFNE5mN3lDK1Uv?=
 =?utf-8?B?ZEo0MG5LUkREd3Q5WjlNd3lzTzUvb2RxRHllL0l3UTYxMTluVWYvTHE5dDNx?=
 =?utf-8?B?VTBaYVVPRDRsVWsxSXF5TEphcFpoZ3ZMc1dBTVh3STdkWWd4S1Y3ZXpaYVd3?=
 =?utf-8?B?STJweU1iTWNwR0c5Qi9JV0U5Z21qaVYzRGZTQVF1LzNoWnZRMi9SalZrNVV0?=
 =?utf-8?B?dENHOW50dmw2TitrMEFNQll6SlpIeGo2a3pwWmtiOUliTkwyOXJtZGZDdVpG?=
 =?utf-8?B?d01mZVMzd25QY3g4Sko5bUNBQ2lnK1dOVXRZWkJtNTd3Y2tiOWhhVTVUbm9Q?=
 =?utf-8?B?VTVJV0hBWHEvOFduSkllSVJFVnMya1ozTUc1MnRIWll0VUNYZ3RSZ25kL1JS?=
 =?utf-8?B?eElmUnZ6MncrSU5pc21tQ1dtQjZyTGtndi9aY2MzNDRITG9TWVFXbHFsV0JD?=
 =?utf-8?B?TFZLcjZ1eUhQU2k0YzdCd01nWkN3L3FwckF4K3VaWlBlemVCRThNSFI1ZnQ0?=
 =?utf-8?B?ZUpZWktZSCtqR09aOHpDQm1pS0Q4aFpubkdSdEVjeUxoekJSVnRSWElyWFpQ?=
 =?utf-8?B?SHpPUmR2UnRGbk9ZWG5oQmpXQS9vdnQvQXZpUkIwYWp6U1Z0OUFvaXRkZm5Q?=
 =?utf-8?B?TlpybjNXa05NYnVGdEk3cHdPcmsxdS9IWWR0QzNlUm01bWNYZFZWRzZWZWJU?=
 =?utf-8?B?MXBZUlVGNUo5VkhFZnU3Ty9ISlN4alYybFAxQklXS0xSZ0FseWl5emRkeUNI?=
 =?utf-8?B?ZXdHTWlqYmk4anE2azRYYmNTcXFRd0RFUEp0MWovMm84OVU5NnBZc3ljRjdK?=
 =?utf-8?B?R0FTdmxRdml0WmNmbXdUNTBtT2RYYmhqU1pKZExvTENwV3VEZFF4ZnZPcGo5?=
 =?utf-8?B?SkFQaXFGeDRYTjBqQjlJRnFSOU8xUEcwalVpb1J0bkdsTnBRNjErL3d6ZzNI?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BAE3DB5F2767E429E679EEFCA75E649@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f049fa60-e12d-493c-7664-08dc4777c5d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 18:18:12.5464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBAlcdZ/VXlkl5aeWpQtxgxjKGSs0beyxmO7el6DA6nukviZE8XRbfj7Y4asELa3lJif8lWzA5jU8940HIxkKdQCH4oX26bJevOyEVpe8UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926

T24gRnJpLCAyMDI0LTAyLTE2IGF0IDE3OjQyICswNTMwLCBWaW5vZCBLb3VsIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDEyLTAyLTI0LCAy
MTo0NCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gT24gV2VkLCBPY3QgMTEsIDIwMjMg
YXQgMDM6MDA6MDhQTSAtMDcwMCwgS2VsdmluIENhbyB3cm90ZToNCj4gPiA+IEhpLA0KPiA+ID4g
DQo+ID4gPiBUaGlzIGlzIHY3IG9mIHRoZSBTd2l0Y2h0ZWMgU3dpdGNoIERNQSBFbmdpbmUgRHJp
dmVyLA0KPiA+ID4gaW5jb3Jwb3JhdGluZw0KPiA+ID4gY2hhbmdlcyBmb3IgdGhlIHYyL3YzL3Y0
L3Y1L3Y2IHJldmlldyBjb21tZW50cy4NCj4gPiANCj4gPiBETUEgZW5naW5lIG1haW50YWluZXJz
OiB3aGF0IGlzIGJsb2NraW5nIHRoZSBtZWdlIG9mIHRoaXMgZHJpdmVyPw0KPiANCj4gVGhpcyBz
ZWVtcyB0byBoYXZlIG1pc3NlZCwgY2FuIHlvdSBwbGVhc2UgcmViYXNlIGFuZCByZXBvc3QgZm9y
DQo+IHJldmlldw0KPiANClN1cmUsIGp1c3QgcmViYXNlZCBhbmQgcmVwb3N0ZWQgYXMgdjggd2l0
aCBzb21lIERldmljZSBJRHMgYWRkZWQNCmNvbXBhcmVkIHRvIHY3LiBQbGVhc2UgcmV2aWV3Lg0K
DQpUaGFua3MsDQpLZWx2aW4NCg==

