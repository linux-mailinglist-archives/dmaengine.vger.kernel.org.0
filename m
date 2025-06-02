Return-Path: <dmaengine+bounces-5297-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0226ACBABA
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 20:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70408177C58
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 18:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2E6ADD;
	Mon,  2 Jun 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Ycf2do/V"
X-Original-To: dmaengine@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011028.outbound.protection.outlook.com [52.103.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B35695;
	Mon,  2 Jun 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887539; cv=fail; b=nC1Lx588Tb8P9CJJ7+QOiYjHDRPdy9pXtj/txtgLJHQXutzmBuJcdJ+5YBtKKjg9h+o8qeRor7eleZv4I/NyAl0zoTvQQimd2rkI+u9RPzVfFtlHnU2yMyNy2B2itaFr1vLXelXKZVzGgz+uVaZKOet/64Y1J4gaPSgnFgMxOeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887539; c=relaxed/simple;
	bh=RVUIdjL/RN2FbU3uBVq7zOoHjpvfHI9oNvqGZi34eIs=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=aiLgTkB/vXBaCj7x1vBEZyhjVxUnTPRd3S0qIHvIc01sMXCYrzPdGTrbAgASjrJ6T+dqxi1jo8syXe1uA5e/nlJCMimQFgfiWQtpydnQ/3SVPKyTDKuk04AV/9wIf1NbJD1zTC7YReJL3RFOULAFFZisFiFTRhjGEt+9pb80/Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Ycf2do/V; arc=fail smtp.client-ip=52.103.68.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0dbfx/ZOY9J5lITYLpfro7bXYzd4mCJYm1FZ9xyoH5KVtrnLgPYKS+1mVjwvgHuWnLsc+xyufcUGmOSxF8n2Qmr3ZjXTRqQvkbgSFh+0cwM2iIuxSfzMiNHL/wZOm23+LdBGXHILb32S5wXkU5tUZUZKBakD+QsqEz1UV+Ml2K9e1L/UDdW+rJu158MFMqjt5civbzdO3ZaIOytrg4o+keaMpgHt+QLwzm5gepb22ro7poKpbEYCN0rk7/uzFyfde0fLX13NmotPLSLKBNP4F9aLZO7k9sRjagc43IgHlFWjRrGCPozm1dYINCboMsky815xxm0iAq8790Qidgu6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvURnGeD2mOL6oGzb0w1xGc4yAnHBUGpmOSRBvrNCCg=;
 b=Vya6n3qi7pwTL21FXooSHXMpfOPdG5Gl1kEJ3Ec/x1gzD+KDAqsUcM/rZrjynMlEmtFPqXDk/YfVYz84240TZF4fF2wEYkauTZhRRFbxq7xoaaWCy/Rsp7/A6tqufxLhRp3gUQYHdn+q8ZzwcVdvHKA7qY1tkI/S3INusaAXmsDqe3yBmWCCJyKZ6mEAhA8sT0v4zhyVzu55nnu9fqFwLxyjE1vnWV529oeoBhnctGKB/ntInnXVdZfmJFqbpeDDV8QsKNXspquDXSesgS/9v0uTtJ/H1NhMRtfltOdxi1gMRUvTouUQ20HMrUnyjrBQjXufgdhtkM7fGzK0wz/CuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvURnGeD2mOL6oGzb0w1xGc4yAnHBUGpmOSRBvrNCCg=;
 b=Ycf2do/V/fe8Um79i4IPsAIT8ntSNnUZvx+ZnCDTU4lXbABBqrwTti/X66g5s55TTpvA4bdGks5fqnAATMQ6wIO2hC2Et0d0QLglPhsIGt2CttHAxn1I6WtSrG5zLuoAaab12Op6giAMz2uqble/ysQfBPznSJMOcZS+YhctVR4ajeSp9hbIShAz3w3qctBrLi1R6m8VXpHBPcbxpjV5SzRiYTZlYNJzgGNSptNH5jfK5+rAAf/dPpGteJJA3PPwO8TyJ+KSDy1yHbYP6NlOt5yNDg3cvL9Z8wbDDaVU1wERHzLfxpMLoDVYzL6OT2ajfd3nlliZlS71Ry6hsvfrlw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9411.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 18:05:30 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 18:05:30 +0000
Message-ID:
 <PN3PR01MB9597C74E424033DC90B6F3B2B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 2 Jun 2025 23:35:27 +0530
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION] Re: ELAN1206 Touchpad Bugzilla 219799
To: agski33 <agski33@proton.me>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
References: <z9A_-FfhGGSZqAHPl-DnF-qPhbI563CsiUUiC8nhdhcZUZYkgpkruvHQ6Vdt8Jt0s0ogm9tCNXFAfn06utR9Zwh_UNTUy4whJ2Z9oVcfPEA=@proton.me>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 dmaengine@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
In-Reply-To: <z9A_-FfhGGSZqAHPl-DnF-qPhbI563CsiUUiC8nhdhcZUZYkgpkruvHQ6Vdt8Jt0s0ogm9tCNXFAfn06utR9Zwh_UNTUy4whJ2Z9oVcfPEA=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <18bf85e9-d30a-4676-9830-e264f436003b@live.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf64f25-6768-43c9-0781-08dda2000fc4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|15080799009|8060799009|19110799006|12121999007|5072599009|6090799003|461199028|440099028|3412199025|4302099013|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEV3MTRWKzZiRGxHLzRqNnoxbjFnRFB3VGVaSDBPRXd1SlNZOGZxQVR2OTFr?=
 =?utf-8?B?REF0eEdpdHZ6bXc2a1YxUDhWZ2VZSHB1QWoxWWp4cmlYaVhnNU5jMDZYSm9R?=
 =?utf-8?B?MFRBWnhwMlJYM0dyL0tZQk0yWFF1TGpsU3ZnTHhCRHh6UGdMYXNsUDBNVm9n?=
 =?utf-8?B?bkNaTTNUMURTSDFRR1lKQjdjQ25TOS8vS3ArbHp3U0hZWGc4YUl2cFYrNWVM?=
 =?utf-8?B?VnliczFJdWo2SFdyd09scWNDcmdoeUpvZnBLTDZjSGVGK21sOWpSWTlweExj?=
 =?utf-8?B?UkJhU3lKc1REYzZhWDlLaUFVVnl3NTBEYmJmU25KbHpvNGI2VVlOamRCRUhI?=
 =?utf-8?B?aWRJTm93cmRUUkl0T3NTQ0JydzQwd1hUdk5xR0FLT25QeWkwVnVmb2h5VCtL?=
 =?utf-8?B?dmh2bE1hblRuWE9mQ2NjcmNpUzRNcEZnRE1oRHlKOExhNHNhakZwN0ZqYWZX?=
 =?utf-8?B?dHJZRm42eDByTTA2TUZDYVZOWHBMWkNLdXc0RitiVDY5TkthR1JaZUVpK2Uz?=
 =?utf-8?B?K3hPYjJGOUoxVjlxMUdtTHZuVjdZTndHRWxBQ09sK3gzdWNuTG56b3FXandv?=
 =?utf-8?B?RlVVTXBHZW5PSEFld1gzSUJMSnBoeFZlTkFzWW14RjFuSmM4YjJ2THlNam94?=
 =?utf-8?B?NEp1M0VHaGVFUE55UXgvdG1oWnZwQlQ1S0FIQzNncWFyYXlBQlZTd1k0ZnQ4?=
 =?utf-8?B?b092Skx0ZTJjbjlFSXc5SzJJczZLWHZxeVVQK1loV3U1MzJSdElEbVJSZHdz?=
 =?utf-8?B?NFRxNXBkd3dDRFBmcWJyM0RwN1NDK0NrcS9zRjk0MWdMNVlvemJQSDFJeFkw?=
 =?utf-8?B?dlI4YUs3QzhNYmdCRUlGcTBWcmsrTEJUd3JwRm4zejdhYzl4bjVXM1NOZnBk?=
 =?utf-8?B?bjkwNC82VnZtVHZvSUxGVVJGWUlkQ1N0Z3pTbCtwOFpadmhPSkl6UGovUWcv?=
 =?utf-8?B?ZmpyT0pPWDk0TmUvV3BGMVZBbUdqTmFyeHNSZi95MUxJdkN0SFliS0FDWEY2?=
 =?utf-8?B?MkRPUmY3NEpDaFdLZ1JGMmdEV2UxZHRzdnN5OG5oYzFrQjdPVGpDc2d2TE1Q?=
 =?utf-8?B?RHp5NWk1V3l5MUtzOGI5NVdnT3ZJd0RESk1rL0NSSi8vYjQ3SWhlaEJSMnps?=
 =?utf-8?B?bDFMRnpHdmV1dU1tUXo5Tk13TUpnMExUdlFmUnhTQmp1eVRhakhOaWdIUlc0?=
 =?utf-8?B?SGRDdG1VZENhMjUyL1NNZkJ0V3lPaCtVcUVsWk1ydVZiajJRVXhpeTNqcjRK?=
 =?utf-8?B?cDdvUW0rS281RUJhc043RHhmNTlPU3FkdXNFYnZFMi9XVDUrbWdBc2tpWENY?=
 =?utf-8?B?cGxTcUhSR000S2ZHNGpLRHVXcFRSd2dMZDRMR01iSDUyU3YxQ3NkWmtxcFFB?=
 =?utf-8?B?UnNXRmgra2RYd2xPc0k0dkpSYVk4WG8vckJMT0s2dm10bWRYeDdETGdqcDNM?=
 =?utf-8?B?amtCOVBVS080NTQ3SXd5Ui9YNlBpUmhNYXNMRytreUxiaHRlaHVWR05wK2JZ?=
 =?utf-8?B?bktaWVdpeUtpWCszUHQzWVVqNEJOZHhhYXI3b2pXUkhhTDF5SWlvdzZZQWVl?=
 =?utf-8?B?QVBNSFJyWW1INDNhdHBSeTJlZGdYcmRNRzc3UDVsTVhmOGRrbk5FQXI4dERo?=
 =?utf-8?B?Z0xWTVl2UUxRV1EyQ2hHcVJycUwzUnJvYXJsa1FFcU52MnV5VU5yZS9uTHBI?=
 =?utf-8?B?bi9POVRIUDJHcDh6Z0NJQit1V0Mzd0grL200aEhBRWY5ZUkwRkY2bWtpOEo1?=
 =?utf-8?B?S2FwZ1g2d1JGVHFORkxIR2gvT2NZb2FrZVl0L2lFN2tXMFJkTGxDN1B2MnZI?=
 =?utf-8?B?NGNsenJUMEFRVjJvb1VyQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alBrQTZ6VGlRQ20zb0pIbWlTVW9qd3NRNFZNM2lHaHNPVkIybU1EYktaaGxW?=
 =?utf-8?B?UngxTFBraEU5TkFpWjJWVG5CRG5FVDMyUDh5M3hiOW5nbEd5NXVTN2g5Y0FF?=
 =?utf-8?B?UGFLV2FweUlIeTg1MkZGaENmTlhSbEpubjB2bnBjSUFVRG50STFrQnoyUGVs?=
 =?utf-8?B?RXFucmFQZEdMSGVFSTlhbmdvNG5sR2hsQXpZTmMrc3k4SmN0ampBUEYzYytL?=
 =?utf-8?B?ZXRrc3lKaGRlQ2ZyWUJLYkc5OUFka2JjRys3V1V3T2t0SkpFeWU1VUpSYmxk?=
 =?utf-8?B?MW95bWVuUkVwSFIxdk5KUFkyU1R3YjY4Tk0xNzNWVGpBek80Y3hVcXN3RWc1?=
 =?utf-8?B?a2E0eGRXQjlJNmJSbTYrZmJMT0VaZ05uYm1ualE1Z3lRUk96UGRXeFB6eE8x?=
 =?utf-8?B?S3BIdDNwbEF6ZTNOUGdMRTduUUZ3QlpJeGNJMUMzVHhGNzBuN1QwdEg1R0dG?=
 =?utf-8?B?QmM0TDJ3TS9mUjJaeGJaQ0hJd2haYjBGZEU5Qlk2akczZFllQzNsa21IRVJX?=
 =?utf-8?B?U0tmb0drdnZpSWVQZnF2Qnpwbjc3UU4wQjQ4OEgxMks0ZnJkOUZKQlhEVGo1?=
 =?utf-8?B?cUYydnp1YmtnaWxrQ3IyT2lCTXZ5ZFVNS3BQMnZGSjY1YXQvdHhHaWwvNXFD?=
 =?utf-8?B?dnFXSEtsemRLRURjd1ByWEljdnovYmVrSEdUUXdmR1NvTENhdU1HeEVXM1Vy?=
 =?utf-8?B?cEIrbFowb3dXM0VQclpGRWhJRkxnWDluWFUwTHdmRWJTcmp4QzZSWUZVWUVx?=
 =?utf-8?B?dkczZzZNQnlPNE1WaTdRTStOVFMxMFFOOTA3cDJSQUJhR0Q5OTJRQmtIemti?=
 =?utf-8?B?RU5lbUNJeWs3RitqRlhZTFNGOUtBMzlFRDhLZEVvT244alFVTUVwMTVYdHJY?=
 =?utf-8?B?STRZaG4xcElhTHVBRlhVTjUySWhNSkVsemJsN25kTDYvNFB0VnEvM3BpcDRD?=
 =?utf-8?B?U1BRaDA1a25XeFZwWElXNVZ1Vy9wcEg3eWFkSmpqQk1DU2w1d21oN0p4SGpJ?=
 =?utf-8?B?NWpacVp2eG9vd2ppaE50ZzgxeEtacDg0RXNEVzJUTlJKQXVCS2NiZ2tMbVFS?=
 =?utf-8?B?WmZjeHVHRjBMcXhqc08xQTJWNFZFV3B6VVFqK2RRUGk0VUF4dXJIdG40NDJI?=
 =?utf-8?B?YXlQWC9kK2FQUXo4OHNKNEJ1cUk4K1IzeFZ2TmtNZGkvUGFhTFJ4NEkzSVJo?=
 =?utf-8?B?L05BRU5jRFBpditCWGw2aTNxLzlLa1p1ekx2QUdtVUV1UCtzcFNqVHpzTFkr?=
 =?utf-8?B?SjNSTWpKK2owU0F0T2x1Mm0yVWJycm9MWlgvT3hWMzAvbEkrdCtkNXQ3VU1U?=
 =?utf-8?B?SHVHZGZwUWtIdmJxZVZTWFpYVFdSVU5ZREZOcy9pSExOM1VWRGE5aGluL2ZE?=
 =?utf-8?B?TzREN3NlcGp0S1dJd2xMLzZTWnE5ZnlsRXFNTWhIZ3hyTHlsbnlLdHUxRlBm?=
 =?utf-8?B?a1hNQnRCNHFMVy9WTm1vdTFKT3pHS3dNWDZ4S1hqQmhkUmM2cWx1ZTRjOTl5?=
 =?utf-8?B?NE5Zc2lkc0NHdFNHZ2gySXNoRXh0MExkVkRJYm1DRG03ZEROMjBMUHpOd0hu?=
 =?utf-8?B?d2g3eEhMc282RnZONFJHaGlHRFRTUENaRWhlZm40QnBwV0x5WjFpYlVKNHNS?=
 =?utf-8?B?NWdiQ0kxU0MwUHgvVnJkc2NkTytFdkJLcFlGcHU4NDJDdjBSODNYWGM0TUli?=
 =?utf-8?B?ckttSUFjTEo1Q3VuN0dzSVdhNEMvWFpjOERYc2VmRStvYlo0bGVpd3Y4KzBs?=
 =?utf-8?Q?6lbwmp7XbNMvdA5Oec=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf64f25-6768-43c9-0781-08dda2000fc4
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 18:05:30.6976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9411



On 28-05-2025 07:44 pm, agski33 wrote:
> Hello all,
> I am currently experiencing the issue that was previously reported in the following BugZilla entry: https://bugzilla.kernel.org/show_bug.cgi?id=219799.  I noticed that the bug was marked as NEEDINFO so I attempted to fill in the relevant information.
> 
> 
>  From my testing, it seems like IDMA transfers relating to the touchpad input are taking too long and causing timeouts within hid-multitouch.  
> 
> 
> I contacted ASUS in an attempt to obtain information relating to the workings of the touchpad that may assist with this issue, however I believe it is unlikely that I will be able to obtain anything useful from them.
> 
> 
> I am wondering if anyone has any additional suggestions for next debugging steps or things that I may try - would be happy to provide any additional information or do additional debugging etc.
> 
> 
> System Details:
> Device: ASUS Q528EH with ELAN1206 Touchpad
> Kernel versions: 6.9-rc6 is where the issue starts, persists through all kernel versions after including latest.
> Symptoms: Touchpad cursor will not move.  
>  Additional Observations: Something of potential interest that I noticed was that it appeared the touchpad is sending data byte by byte when doing an IDMA transfer, not sure if that is normal or not.
> 
> 
> Any suggestions for next steps are appreciated!  Thank you in advance for your time and input.
> 
> 
> Thank you,
> Aaron Gdanski

Looking at https://bugzilla.kernel.org/show_bug.cgi?id=219799#c2, dd4478d63b6a2b6891fcc1800eb26ce3f1ead1d4
seems to be the patch causing regression.

https://lore.kernel.org/lkml/20240321120453.1360138-1-andriy.shevchenko@linux.intel.com/

Ccing relevant folks here.


