Return-Path: <dmaengine+bounces-5919-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD491B16BA7
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 07:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6384E84BD
	for <lists+dmaengine@lfdr.de>; Thu, 31 Jul 2025 05:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2031537DA;
	Thu, 31 Jul 2025 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="1ipTQ6ae"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B95479B
	for <dmaengine@vger.kernel.org>; Thu, 31 Jul 2025 05:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753940645; cv=fail; b=B/+MKAyriY6UKQK25UvvIUlOU/hEpL4xb29x586h8Q+rfmQtAVH7mHt+YieU5eSeDcvEpD4Rd0DWaE2+XUGPxcyDFORM8wg9DG1N7kz3s0fQZHJd3cF51B/bdhaEV2mFSNDpTiT3gP9m4QwBIflmX+VBW9Sh4sQ9s6rjIvgjgG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753940645; c=relaxed/simple;
	bh=wtn9jTdHvYwhbeM/jB1hpWPf1jd/Fid82FUx/5nRGvQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uzrOv3QcyiSShVgTGXpLa08ObWWpRJNjabdjSBtFTB7nhek6OOQuZ/U02yMBnalH0cXGQ8j7JD0LQkvhEPUJ4XENf7m/BnhTgu47N/1X+zHwlNomVpNtqTcnXfnkt8OI9PviG30aIRZisTOOb9S+Baf+/Zno6MUhLZsZ2GEvmBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=1ipTQ6ae; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC36V1Mk5hyrFoeHML1qqGB+ZbqoVVfZIQW90+5fx3EFaQMLSFthO9pwIm4nQtexPI3xNrjpS46vFiV2zVBT1EFkjKqz1ZLwPfM1fQfmjDYmDMIxAK6Xyr8IgEMsws8/Ly8a0WLifyq2BOBie40FxYMJ8pEj4sEVnkqbBi2cj0FstUJC22h2CKwDfdI0PrS/TPmxQRy3tsogMrBDucM5RqmTs/QdzmhN0SjyikkU8yu8fgGVMwyQzxWktd3BfcMOqc9XAlEg3XZbCUJTO6yLYu5O43e+SzmNtr4m0K5mQAsiOPiMgNerFJ137zIOLsIb+cHcnJJZt/JJOWUgH3q/oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtn9jTdHvYwhbeM/jB1hpWPf1jd/Fid82FUx/5nRGvQ=;
 b=Ues6YUueA7tIcKsdYxmMmmZyN2rPOo2OgcODRxw7VaEGlJpUI/m9zFjNSlHxHneB5076HxL27DkjJpHkVSPzefyIleXShIrXX7je8JEwipZqy+sEAxy2RcKFtdWoZcTOxpE2ebDJlTdXNZiws76zsFDasC5NYfxkKNLtGra6j2ueQayDbw9DCit73/F2pIFKF/0sdeZYac7zJwmaj2ql7WiHl4EuzLx7/lPvVG2vo1j/5Lo3l36kIZ0oRByvWJ24mwx4TxYftteAF0c5oshXbTETEH0mSFaa/WWY7y02jhywoFS4jxmXcmZnHqqbjMK1zTt55rThuX5L6r8GlCTVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtn9jTdHvYwhbeM/jB1hpWPf1jd/Fid82FUx/5nRGvQ=;
 b=1ipTQ6aeRvYJQVjv1Eh92vZdMBLIkHP9R20LWOy7mt+Eur/OTcZdIcFhzyZs8HegVJOoOeNXUkt5a2jofV0idWzfkrtzpqDb6G1OufUYBpXV+Q6eTy+GE/sk7uTjD2ACTAnfl+w7W/8O5kI+KgU9QsLUqrQnmxafg30j4uhAFsBSBvjVIFrs5eqfzgOObtLKVv929Fcz7Q1A0Gop1ocMeCOuFmSMXVJuRz4wWMHh+9xfStIg+CojAjh5eO6fQP7QXXk3EQ+PW5IajjCLMWN4vAA24o+DvUUgZYz2/0c7kBJzCkpoEg8W/bfEADjL9KTBd4yhh8eIgSCAOSPvwoEhTQ==
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by LV8PR19MB8716.namprd19.prod.outlook.com (2603:10b6:408:256::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 05:44:00 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f%4]) with mapi id 15.20.8964.021; Thu, 31 Jul 2025
 05:44:00 +0000
From: Yi xin Zhu <yzhu@maxlinear.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: Jack Ping Chng <jchng@maxlinear.com>, Suresh Nagaraj
	<sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH 1/5] dmaengine: lgm-dma: Move platfrom data to device tree
Thread-Topic: [PATCH 1/5] dmaengine: lgm-dma: Move platfrom data to device
 tree
Thread-Index: AQHcAP2HvFG7jtDcskCEJSSNl1x0KbRKMfcAgAAmAYCAAAUMgIABWaKA
Date: Thu, 31 Jul 2025 05:44:00 +0000
Message-ID:
 <SA1PR19MB49099E41F163126129CD6D16C227A@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <20250730024547.3160871-1-yzhu@maxlinear.com>
 <62599303-fab0-4068-9d5e-55cebd093f90@kernel.org>
 <SA1PR19MB490993CCD0F80D63501DAE92C224A@SA1PR19MB4909.namprd19.prod.outlook.com>
 <fd17b4a9-119d-47a3-8fef-5f89a30cb212@kernel.org>
In-Reply-To: <fd17b4a9-119d-47a3-8fef-5f89a30cb212@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|LV8PR19MB8716:EE_
x-ms-office365-filtering-correlation-id: 3b8e3183-0d45-41f5-8912-08ddcff53fe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2VxbWdTNkFCVE1MaG0ySHd4WlNNem1DZ1FtRk9FYzFVcHllQWNweVdrV3pX?=
 =?utf-8?B?aW1meHY4ckg2NHVJN21lb2JVNkZJejZsdWwzNzV2b0ExakNEajlGM1ZhSkNU?=
 =?utf-8?B?cGNTMEJla3BqaGR3MjdodjVoTXliazI4OUJxaktRRytSVWc0ZldPQXNrTG9a?=
 =?utf-8?B?NmFLZnNFZXVBVjF3aUpUNHR6b1ZUa080NDNVcXd0REIvWUdKTVBUYUs4Qmoy?=
 =?utf-8?B?d3hFRUE2NFZ0aXRvbjVBZUIzNlFObWNkTXpNQXg0TnhVWC9yM1VXTUw3ZUti?=
 =?utf-8?B?L0lobVhFNG1LY2Y4ZGhoRHlNcjZ4Q282dnN0VklWMHA2ZEcxRTExa09vQU5Q?=
 =?utf-8?B?OHNLa3Eya0ZLTEdETnJ6VHdWZS8rZ3FNNzJtZUNIZ0ZqWE5BendlV2s2aFhs?=
 =?utf-8?B?dS8raWF4SS9Hem9hVEFPaGdFeG9OM3lkSHZWWEtDMnZpSDZyUDlXSDQ5cncy?=
 =?utf-8?B?UWM1b2RmYlhpaWhuLzhialAwQnZJK2tUMEp4aGtDd215V2luZktHNDI3QVk3?=
 =?utf-8?B?VTU3b2o3N3M2c0tXWkpob0Zva2xOR0ROQmVGWVRCb3QwY09udUFBa1lRS0ZP?=
 =?utf-8?B?VXRDNWF0Nk9Sc1pkQ0thZnhwaHJOLy9DRCtZQ0Zhd2V6MUxjSFIvNXVtK1lV?=
 =?utf-8?B?WVBPaXdYNjBqYThselJpc25BeXIzdGpEdmhIM0dORmJ5eEVhaW5yeU5yN0dq?=
 =?utf-8?B?bGR3YnZ4ZHU4WXMvNFoxY1lrVjY2aUZrSE9pL2w1VDAvdzhHUzF4Z1VLUEVY?=
 =?utf-8?B?SnkwQUFFcU42MGpLb0Z0WnNmcW1IR0NuR3BjVVp1TnQyakVWdS9vVG1VQk44?=
 =?utf-8?B?UE1hYW1sQlNYSGZxdHNwOVEycVgzVzRLa3Z6VlZNaS9BM3NFckxKVWR0K2E5?=
 =?utf-8?B?UHdBMXA2TnFWODU1SURaMGpqcVpONXY1OVlhd0dLUWRjcFhjNitsWXVjYzVu?=
 =?utf-8?B?cHQwcVBvYzkzekRnTjBBQzZtTS9XWlRhbGQwanZpYlRQUERnT0g4VlMyd2VV?=
 =?utf-8?B?NmdLak5iMENhRW1QQ2VMRnZmZHFNS1poUGZ4aGVxalk5ZFIzVEtLUTk5b2hH?=
 =?utf-8?B?UkVkTEhsTnYraGdmZVRrVVBTSzRSZjRSdGN1bENBTGd2NGNXRWxiRE4yczc0?=
 =?utf-8?B?NTMyYm5oaWVKYVk5anpUdkwxNzFVWlNWMmVyMzdFM1FuakwyVEplM2ZqcXpP?=
 =?utf-8?B?RTBHQU9ibW5sdTRJdXY0ZVZuM1ovZVRLbjBTOE55RUtCdk9mTnlQTmJsekdl?=
 =?utf-8?B?ZTZuSlZKYUxBRWFjWFRkSnFTcnFxT25IcUZNZmpmbk5DY21CdU5yT0pjbEVo?=
 =?utf-8?B?VURTK2J5aHVuTjNOUVE0ZExnWnJPWU9zclJZRGtNcVE2bDZsRjJma0dNL1ZR?=
 =?utf-8?B?VjRiOXV4ZmE4UmJKVVk0V1dYQmxiM0tScFBpbkgyRjUvRndvWGNZaGhtOE8v?=
 =?utf-8?B?Nk95bm5Zck1PckE1cjFlaUhrQVJiZkY2K1F6b1dSVW5KbHRhNGpBUVRobDA2?=
 =?utf-8?B?TXFucllnU3lKOEJkTkx3aWNhSFBVUTl3U3JQNENDR1RaditTTnBDcmFSckZp?=
 =?utf-8?B?UlFxMk5DNThXbmdkZGpUZ29GUDN0UEJTOU9KL1R2dlQzcnJ6YVRHb3draXdI?=
 =?utf-8?B?OXIwSXUyTEZDYTZqSWZ1aW12b0F2L2pVa0llUkZORU1lOFpaekVZMWFIdERG?=
 =?utf-8?B?NjBiYkxLOEdReVhadGlOSEYzT0lLQ0VEeXZtVitGSHpsaXhxZ0JrSEhsczFw?=
 =?utf-8?B?bmxtV25CTmluL2JrWWpMQjFaNlhhb0hodlF1Tnp6TDBUVndUZWhPMmVYK0hS?=
 =?utf-8?B?SGVMaW1RS3JuWDNKbGFFVFZQd3NvMzFiaEhPSDdaQnhmKy9SeS9wOTNrQytP?=
 =?utf-8?B?Y210blhJNUtmc05wZ2VKbGhVYWl2WWllYU5SOHYzaTRVc0FhU3pYSU9lOSth?=
 =?utf-8?B?ODNwM1RoN0JtbUNxUXBOVHVhWlNrNEMzcHlFQlEvNWpYYXMwMGE5SzZ6NHpN?=
 =?utf-8?B?UHE5L01HNXBBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aElNVmtNT2tvVytLZ2dmSDBPTTNuV1U1eW55dWJ5NEZ1VnhnZE9sQlJOaFZG?=
 =?utf-8?B?NTBPSGUyN3M1YVlsMzdOazQvVFpaalZlS3Vyc3pOZVdlYUZxY1BDVWNFMTFZ?=
 =?utf-8?B?SDNkUC9WdVFhbDRrZ3EvSnhIbnFydFZHRWRwQll4ckk3eWZEMGhhTkhsZkJy?=
 =?utf-8?B?OXFQVjMyV20xd3I5NUJIbGc0WFp6WGo2V1FYY3V6UktkTlhSNFVEWVZZd1dY?=
 =?utf-8?B?S1hCUXpUUEhkcnQzNWQvSzEvWnpDRFRBQ25lTzNCc0J6WFFOKzlRTGQrZjVl?=
 =?utf-8?B?MVpBS3QxZXYza0pteCtSbmcxTG1ENUVLckc1a1hmVXJCUHFNMzBaRXgvUG50?=
 =?utf-8?B?c2hGRTJsWC9TT1VpbkxiWXFLT3RFMWJ3UkpJV3BUQk05SldEYUMvd0wvM3ZO?=
 =?utf-8?B?b3dwRlduamg1aGJTb0Z4bWl5eThpalJRbEFyQTJ2S2dFZStCb1BieTBCaEQ1?=
 =?utf-8?B?MldEcEdTMW1wdU5QZEtlRW9lUTJ3d0FES1B3NjN6Q0IwSmhkanJGME1aQ1Qx?=
 =?utf-8?B?ekdYSVFsQUR3cUl1TTJJS1haajhKMjlGamNYdkttZ0thUmZLUEY4b3FQNUd5?=
 =?utf-8?B?SlgweGlYNUk0My9BeldidWhNYTZtd09GN2I2YktSQVZ0SVFlcU9QN1JZdGEx?=
 =?utf-8?B?ZmpnaDJ0RmdGaHJmTU1aUkFjNmZwaVZyWnZtYzFSeUdQSmVwdGtNMHZjZG9w?=
 =?utf-8?B?akNKQTdYcmZPTVh0QXh3TG5hWEZQUXY0OVhGZFBoMGtqZzE2S1FxeXFwTzAw?=
 =?utf-8?B?YVc0NGpOd0k5WVI5cHlQSFExbFJueGdTNmV6Wmw1c3l4UncveVFySUpSakJH?=
 =?utf-8?B?ZlRPM0tmbEs5Q2tDNi9qaklOeVRWL1ZpRE1WalhDMXdKSjMyYWVJU290TmVF?=
 =?utf-8?B?OFI5L1E4RGFQU2ZzQ3FrcGRaWk9YY20wZ3g4QzgvbWpZMnpsK3RUZ2VESjlJ?=
 =?utf-8?B?Y21IdXYvb09RM01nTGE4Z1A1c29zcUk2TjdxU240aGtEVEZVclkzd0s4eDVB?=
 =?utf-8?B?RSsxaGVoMGpvSmpRYXk2WjF1bUxFd0tsMld0TUs1NEg2TVdNc21MZC9nQ0dL?=
 =?utf-8?B?U2pTS1dBZnN4azFOM3RiZnBaRDVhWm52N2NsZTFHQkQ5ZzE2cnA3aEE4VWxt?=
 =?utf-8?B?aTZ4QVB3SCtoQUpMTXBXVUREUU5aZFZ4REdBRWFDWnZKZHdqd3A5bmxNNG5v?=
 =?utf-8?B?dEtTeXpTaVlBV0xzQTUxTnFoNFNMTW83dGFBZ2h0K1o2ZXpCMUZFUmwrcUd4?=
 =?utf-8?B?R0FUczYzRDJjOXVzN0lpOG5qWEk3b3FDK09veWdxTnpiMllHNmVlOGhnQzRj?=
 =?utf-8?B?QlM4RnpZbkZIZ2JZeE9Gc2R2bVZDRWhZK2hqQzZqRnZ0d1dHUUZET2ZqZHRN?=
 =?utf-8?B?MUlFT2FETGdpSS9iY0FSM1NxWGZDdFVtUjdUOUwyUldwN1A2RTRndDJxZ3BX?=
 =?utf-8?B?UTdLeWFHUXJsV3gxeTY2MVN3S3RIdThOOXBDdlpxR0JyakQzMWkzN0ZBdHBa?=
 =?utf-8?B?eU5OZnp0RTlhaXFhT2F4WnhDMDZSNU02UE5XaHlMdDVjUHlMaGlPM0V0Q1p0?=
 =?utf-8?B?T2pNRXpWSXMzZ09TMERLalFRVVdCUDNVaER6R1JTRWhGbnNBcUpDd3hoNHhJ?=
 =?utf-8?B?NlJNTnplZm40N0FDd0VneWQ1cE1nNzdjK2g5OXNRQUNEWTUwZG53L1lyaXNU?=
 =?utf-8?B?UDZWbkFyblY0ZUtlTWpGUEZIUkVIbGJmL2tmNzNMQlh0R0MwaTMrL3dGTnND?=
 =?utf-8?B?Z3NGTlJOcGJMSExLWFFTekVnYWVQSko1RmJreThqT042QkRGcVhCbFh1S3hh?=
 =?utf-8?B?aHEzVzNVclFqYktZOTdnYzJHT29sczY4WjFiZU9JK3gyTjIrZlJZMGdoTG9p?=
 =?utf-8?B?NFZKRGh3RVdBempUeC83M1Bqcmk2UHc2a1l3UWwvcllQaU9VMUtkSUo5eFl5?=
 =?utf-8?B?elJIZys2V1BmZ0tPRm5PdFc2b01neTVvUmgwVVZZdkgzTEorVWxRSGJqNTdl?=
 =?utf-8?B?WEhRTkFoNVYrN2h4RVNTRXBkVm1FZjhPR3RKZXlNRTJRMjVybW1icVErb3li?=
 =?utf-8?B?Ukd4bEo0elYvS1g0NThpTUNDcE1pckZGOE5LU1FYVGFyWFhhaFRDZURSYnAw?=
 =?utf-8?Q?qTIw1kEIQEGEV6pGUTi1hHsE/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4909.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8e3183-0d45-41f5-8912-08ddcff53fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 05:44:00.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djI27txyKb99dsJt6KTuOZhnHGykbZ3bG3KnMddoueC80ff2YW8iwPddnNijjxfjO7vMh633sn+mGXqr8+dOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8716

SGkgS3J6eXN6dG9mLCANCg0KT24gMzAvMDcvMjAyNSAxNjo1NCwgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gSXQgaXMgdW5saWtlbHkgeW91IHdpbGwgY29tZSB3aXRoIGdvb2QgYXJndW1l
bnRzIGZvciBicmVha2luZyBBQkkuDQo+IEFueXdheSwgaWYgeW91IGtlZXAgZ29pbmcgdGhhdCB3
YXksIGV4cGxhaW4gaW4gdGVybXMgb2YgQUJJIGltcGFjdC4NCj4gDQo+IFNlZSBhbHNvIEFCSSBk
b2NzLCB3cml0aW5nIGJpbmRpbmdzIGFuZCBzdWJtaXR0aW5nIHBhdGNoZXMuDQo+IA0KPiANCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCk9rYXksICBJJ2xsIHJldmVydCB0aGF0
IHBhcnQgb2YgdGhlIGNoYW5nZXMgYW5kIHJlLXN1Ym1pdCB0aGUgcGF0Y2guDQoNCkJlc3QgcmVn
YXJkcywNCllpeGluIA0K

