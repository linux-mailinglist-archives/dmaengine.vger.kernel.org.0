Return-Path: <dmaengine+bounces-4423-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DEDA322D7
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789F41881D1E
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F118206F10;
	Wed, 12 Feb 2025 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gvdLfuwp";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gvdLfuwp"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FED1FECB4;
	Wed, 12 Feb 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353824; cv=fail; b=M2nR2hoP0xbprg1rUi87sV9yJypJXxsaw96+D+CGXEknpfcJYLdeUpzDQr0jWld0l//deVLBLyso+sSPmUjHtCZ31SBxwXPit7nPIPbJyM8qJ9zONk67QLbDkAUjFrZogT9uiVKWckS8sDY9NKoI8zshtiNh0lAcKgW0opj+kow=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353824; c=relaxed/simple;
	bh=jtPLanWg4CCXuoDfkF/tQAowoy8BEdVLR4hGCQ9S+f0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c8lTFCu4o8iJdKsNURwcGi2tjKbdgYSOZ3f/Q8MThhmrNCmZVyKvwwEa3lljbzv8YNKo/YSWMghkQ1qhI/xKew8AEjqQ0Kf0He6kg2UwDTQkbrU/0Rc0l1U2bTLaaMaX7CW4DnV9VlBwKQ9NomJuZ+kRNHs0OcBB1kpXir9Ism0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gvdLfuwp; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gvdLfuwp; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=kj6rCVwGS0uHKqZ7dU43TxDSIFd1o7CqyPRQ653N5Fc8yDbDCv3HKcEaT6Wmie8f4W27O65eSlXM7sTCTnpOL8T+FLaJqRrk7xv2/ZvQOQMGKbGobTC4/ctaYmxWajyR/5mOOfgGs7iuxmdJ2ArR1xyf4+i76ZcbJ7WjlwJVv/NGovPJxdBXgaQNZiS6+5GD4kiuVkclWxP6W38J20n2D4Cu9zyONq4JKE6HmqlU+0Ug48rdXh4qd4U4Ylcvn9g6VTxgLQ/Ezza1ds3gHLbWzGqFhSjy07HUkUcs93I2KbmTxbWx/O7m4lOAW4gJObFLpwau7+LHaB0guQomV+MyDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9nnzDSPE+EidbdHEfcVSsL5ckUnh3VMW6wGoOEeprM=;
 b=mihFJ65UpuT/iR/eJrqY6gNLSr72ay5G2szzTvOAwYU9cl/wHyfQIRmk2sSqBfoN6zT5kpscjAxb64h2W6MQ8sApfMNMy98F19kSzrBdy7GeeVyPXg2QRnvSE3SerWpIAcPt4Bt8sMpxB62zGlKqgRpKMhMoa000zU34v/LoJ2HOuU/NfTGjzjSZKxhBCX8Zk5vjifJwaoeFN1+DUrzGDQKj4yKDNA+iHRL50fRKZIXAmJkfXt3m9G+JhoLQohxUWK3fr/x/wJK4vzUaIgtr95BT/lNIhoI+3EnuBl3KXbumbfmNpN0UV5s+q8UZNG9LXrrujHjsjxZRU3GQQmacdQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9nnzDSPE+EidbdHEfcVSsL5ckUnh3VMW6wGoOEeprM=;
 b=gvdLfuwpj62/hiZfqMyDpj9ElpUIJc1P7WaDhLLiqePjRbnztjfUb2hpUIe3Xx+A8+ScpRyfbiG1TCjLC3jPipEVqhES0EtdAU5vcV+5UV9QGPwU/j/zCeDQI0lJj18DbaJSvxzobqBrOS8bEZXf+cDF0Md+aO2mYq30yIebL44=
Received: from DU2PR04CA0206.eurprd04.prod.outlook.com (2603:10a6:10:28d::31)
 by GV1PR08MB11025.eurprd08.prod.outlook.com (2603:10a6:150:1ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 09:50:07 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::a9) by DU2PR04CA0206.outlook.office365.com
 (2603:10a6:10:28d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 09:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 09:50:07 +0000
Received: ("Tessian outbound d73f074635d5:v567"); Wed, 12 Feb 2025 09:50:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6df9c6bf7683384b
X-TessianGatewayMetadata: 4M0JT0e1YttWwI5J1aFwVdVJADMGnyveM9FVPWq063QYidGdnrEPt2aOFUim9c1bLrc0bXgZXOvFC6zWTraRu69MPBTpQhZncTCY6epcfgouGxaQFuttH4eR9M2BRMnsdrice4KmK8NkXTLgu61KsQ2b9vKYnkAItTgeiZCQLRw=
X-CR-MTA-TID: 64aa7808
Received: from L17136468abae.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A0A385C2-D2AD-4534-8C08-78AD9C5DD0CD.1;
	Wed, 12 Feb 2025 09:50:00 +0000
Received: from DB3PR0202CU003.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L17136468abae.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 12 Feb 2025 09:50:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk4Or2GcAKAziL2Hc6u5tWiAvMYaoadzyGZFPSXYP8rAHhnmdofYkqWLyaqaSSWiMLnoauNE0D24B8Bk+QkBs1Spr1OR+/sbDpXoA9fMME2mYv62N0R+w5PrcdMYd5QftdSq+gIMWe11XFiHcBntVNkQIPVDcAMDShfZb4vbxfbJ+7W0WkoNca7+KPLy3v/E7fLpIJ7B0q30pxt9KEYBiCR2y2p0+8X7hTCbQQLTzRlWQlQ0ugXYgJOwdSzxfEk5CzLPBOzRlo+pdw7BOsKm8j+50vACehxavgJpctGQ69nHURegpcvWlSQvD4ETs5yyEO6vilrKOaeTAU0zwN/f5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9nnzDSPE+EidbdHEfcVSsL5ckUnh3VMW6wGoOEeprM=;
 b=qzkQ+gXyC6CBcPncaJsN8nHAqVVOJ8sIg71Dvl1LZa/FaADHYGus4XxEzDgmHa6JbovS5GG/RJOx/KthRrRMhuxTkluayOaDzznrVHxaxHZ2dvAMx9fm8IDxfu64CUROP48Pjsc4QrqygeyRUMoz4PUQA23DTQWDYR23vViG41f9HjBI2ssSd9ehnCeO+lPJkW+4g2a5U+1RsCqMlFNlwPvFzAZIrGzPZ7WEieRX4h4tsv18c0JMt4+73/RYgaeu0lm/qrwWvkn2p88ZtjvdSMzQL07CGCYsM/vHxVyHDuvPkmH03JOMUWR+4z4T8sDftyFIHyGQOme/IxsbwoEvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9nnzDSPE+EidbdHEfcVSsL5ckUnh3VMW6wGoOEeprM=;
 b=gvdLfuwpj62/hiZfqMyDpj9ElpUIJc1P7WaDhLLiqePjRbnztjfUb2hpUIe3Xx+A8+ScpRyfbiG1TCjLC3jPipEVqhES0EtdAU5vcV+5UV9QGPwU/j/zCeDQI0lJj18DbaJSvxzobqBrOS8bEZXf+cDF0Md+aO2mYq30yIebL44=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com (2603:10a6:20b:574::8)
 by DBAPR08MB5607.eurprd08.prod.outlook.com (2603:10a6:10:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.22; Wed, 12 Feb
 2025 09:49:59 +0000
Received: from AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7]) by AS4PR08MB7925.eurprd08.prod.outlook.com
 ([fe80::8ef3:b027:e22f:1ea7%4]) with mapi id 15.20.8445.011; Wed, 12 Feb 2025
 09:49:58 +0000
Message-ID: <fae8df2a-3e47-4266-aace-392c5f37581f@arm.com>
Date: Wed, 12 Feb 2025 09:49:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] dt-bindings: dma: Add CMA Heap bindings
Content-Language: en-GB
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Maxime Ripard <mripard@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yong Wu <yong.wu@mediatek.com>, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
References: <cover.1738228114.git.florent.tomasin@arm.com>
 <771534be8dfa2a3bdc3876502752f518224b9298.1738228114.git.florent.tomasin@arm.com>
 <ats2unrml5a7vbpdrqrzowodrsfj44bnubpbujg2igk3imeklx@nrpmg5oeq3gz>
 <be8e6b9f-c3c6-41d1-af9c-3dcd102f0fe3@arm.com>
 <b02711c901e8acf2bc47926919de7673a0cb0b98.camel@ndufresne.ca>
From: Florent Tomasin <florent.tomasin@arm.com>
In-Reply-To: <b02711c901e8acf2bc47926919de7673a0cb0b98.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To AS4PR08MB7925.eurprd08.prod.outlook.com
 (2603:10a6:20b:574::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS4PR08MB7925:EE_|DBAPR08MB5607:EE_|DU6PEPF0000B61B:EE_|GV1PR08MB11025:EE_
X-MS-Office365-Filtering-Correlation-Id: f16bbd94-7312-4247-f84e-08dd4b4aa1ef
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZTcvc3M5VkhxVjFUcVcvbW1GS2ZjQ25scW9hdWZ6THpQTzNxQ2c4K21aUDhR?=
 =?utf-8?B?cllFZWUrd2FWUG0zb1B3V2k1SEIxdUZ3QjFwSDhpd0xrRDBvVHJMRGlBN3Bz?=
 =?utf-8?B?b1RvTzRDN0c3eDc5QkVEQTZRSWdmOWs0SHBKb0xJUE9Ka3lEc0VaRVkvNG1S?=
 =?utf-8?B?VnZUOWFPQzFrODZrNVhIaUYrVzZaYnVYRjIrejBETzQvREFsSVdKclFsRGpx?=
 =?utf-8?B?cXBkU1ZOTWM5YWk1a0FBQnErWFkyc3BSV2pzR1BBODQ0T2pqT0orZDQ5UlVO?=
 =?utf-8?B?WXNFWGVjck00V0gxUUNpR3JPbnRGdWdpeEp6QTNOT0huTFJERUdNWndONEpX?=
 =?utf-8?B?UzdhczNMTHpMOE43MmkvYmYrbXI4VE9idTl0WTU5Tk9CdzY2UWluT1ZkQ0tq?=
 =?utf-8?B?VzRZQzFHYVFxRVh0SCtwRDV6eEpUS1hMc0E0VTZHZllhTDdhUzhBa3hrVDJF?=
 =?utf-8?B?SGpXL1AvVTQ1WnNrYXBFSmNIUUgyWWt0SnNJcGtMYTUrTVZwNU1ISlNKZjRt?=
 =?utf-8?B?RGNSaER2UlBOeG02WkdvUnF0WkdBS1hCV0dYY3M3QTZjU0UwbXNDb3V3WkVw?=
 =?utf-8?B?LzBKZmJSdFh1N0RMOHJlMlBhSWpIZ1ZGclhDbXEzNDlvUXAvVTNsc0pRc1Jm?=
 =?utf-8?B?WGMvdkoxV0pGQ1ZDU3dPMHRHZ3dNUXlmNmZ4NkEyTndTRE5qa25PL2NIaFJh?=
 =?utf-8?B?d1V3WStSclVoUTd3Mk9ja2xKRkVkdnRVOTd5c0tLR0ZyNVhvOU91bjNGSEtN?=
 =?utf-8?B?QkE0VFBmekZ5OUJxbloyN1NPK3dlaERGa1JyYkJ3RHBiakxMdnFZek9rK3RX?=
 =?utf-8?B?amV1ZlMwL1RnenlPakFKbkNZNytYY2xiV2Z0eGQ0YksvNlZBRURDeHl6NUw5?=
 =?utf-8?B?OGl4d3R4dHZIOFEvUE93NGRZVno4WWdQRkZxRC91cUVDV0ZDaDU1SjRoL2xi?=
 =?utf-8?B?Y1RubzhqVFdJVmJJeEFENnRQQ3dpZHVmbC83RWNFaHhSU2wvWmh4REhsZzBu?=
 =?utf-8?B?NzNNaHpWM0dhRnpmcnRvbi9Ic2JteWsrQ3ZjdFBmK3FXMGZxTXZYOUZBam9q?=
 =?utf-8?B?dDdJOERTNWtETlZKOUlxaWdyUVg3NEJMR1dqSDArVnFIdHBHSWtjTW1vV3Bv?=
 =?utf-8?B?L2VMMU9rOEgvV0R5UDlGbHlPMWk3Tk9YbTNnOUtKN2pDNjFWTTB2TXI1OXZL?=
 =?utf-8?B?cUMyQlloOEhTclBqRGJlcElCTGk4TmhkNmhPUHJHcmxyd0ZmK1JBT0NlTjV2?=
 =?utf-8?B?VzRGV3dNR3dmTU1kQnpDSXBFOWZSMDRhY2dmbVpaT2VGd3Q1K2dZUDE3aG5w?=
 =?utf-8?B?cFpGK3hwY1JGR1Q5VEZ5Z2JsR2lUNTczaWFNSGYzb24rcXVHT0thOFpKTXJv?=
 =?utf-8?B?akpaUG1oY0xCYUVqbUFuRlR6SDhtc3REMkZQZ0dLLzJRdE5mRGlUNTdrd2NF?=
 =?utf-8?B?S29CTkJrcmNpV1BlOElONlpYNXlYaGtUMzRnZ0VWNFpOajNGVmVoTHBkOEg4?=
 =?utf-8?B?VU4zZ0lKVUpBeGlGYzEzbi9lRDFOMXdWRzI3RTFJTGVnWU9hQmhoaDdobkhX?=
 =?utf-8?B?dVIvZHkvNThPS054YmdJOStOb28xZlp3TEpxa0xMZS8zU004VG8xcmtvOWtQ?=
 =?utf-8?B?c1VQclcrSzYxemFEMkRoN0tubTAxbmN3b1ByaVJjWU9hOG5zZU41NU5ZMzJG?=
 =?utf-8?B?ckpaNnhPMklNVENyNzFFYlRaWGlqQnJLNHY0V2srdjhXTWpQcVhBZlhFZHJV?=
 =?utf-8?B?b1QwSlRoMlVwcTdTNVlJOSt4K1NXUmoyTTdTSTVlRktmd1N4dEpSTlZRTUc5?=
 =?utf-8?B?aHZrME1IamJzQjJidWlkVjB4RTN5bmNneEdRUTJYQjU2VldHOFBlOXdUaWo1?=
 =?utf-8?Q?kpf+B/TZEFrQ3?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7925.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5607
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:574::8];domain=AS4PR08MB7925.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1d339af0-1ede-426f-f647-08dd4b4a9c49
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|35042699022|36860700013|1800799024|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTFDOENqeVVMMXVkZkRZSTZhSUQzVTB4U0cxRWppcWkvY0c2b2k3aHJCK0ly?=
 =?utf-8?B?eVpyOVBHUExtSDBrcVpjc2FtYjdZakZnanUrMEdOT2tvd3FHTUdxaXV0WWVM?=
 =?utf-8?B?b1pKZm92YUg2K0JLd1NzSzJNU2tudWNKT2JLZWlDYUVjWk1vRVFmUFZSL01Z?=
 =?utf-8?B?b3ZMekdJTVZ2MzV0aGdlT1lOaHRhd2c4K3NLZVN0WG5zSkdhQnRCdEdNbG5o?=
 =?utf-8?B?bDdwdFZTTktORTY4RW1HSVlHbEtkVDN5eTVhcTJ0RUxIVUVtK1p1Y1AwMWc0?=
 =?utf-8?B?UXZ2MGN0RlBBdExWNG55NTRNdDF4YWp4STIybUlrdFBGVzZJYWtYRzBXU2ZI?=
 =?utf-8?B?ZXQya2tnb1owamMvcUV6aXRZRCtrZXJjTjd3SEFveEd4RDIra3ZMa2lhb0l3?=
 =?utf-8?B?NFR3aktHbmdyVlhra0dRNzNJWWllTjU0SzFwN0l4eTlwanNCbnNQbkFwYkhE?=
 =?utf-8?B?enV0VHFHSDJSUU91K2gyN2orZytmNkhtRXBGMHVkTUs3MFNqblpFZkpzeTJq?=
 =?utf-8?B?OXNuemdVYUU0ekxRb0NKWldMYU4vN1orQUs2MFNkMGd4cDBOVGkwRlhoRTFJ?=
 =?utf-8?B?cUQ0Nzl5ZlMxZlhiZVJZbktxM1NXMm5Bei9ja1J3NS9ncXRicnZyTktraVV1?=
 =?utf-8?B?MDhjbG1aQno3Y1J1aEVGNXVPandEelZEMVlkQnR5NGtLTmhnYlB1TmRYTEVS?=
 =?utf-8?B?My9KUVBrTUEyNVRtZzVTK0ZBU3VKVGliRjF6eStscElPNWFrVlBzaDArR0t1?=
 =?utf-8?B?RzR1azRVb1BVSm9mQXdWOHdDMkFiRWY2TWZ6eVg2K1NYWnhlOEpFbjNQakVq?=
 =?utf-8?B?Q2hGT0Q2MVpPbTZBWGJPVWRvbytOcHVHcnVoYnRab2dzeHhxUVl5YVp1OW45?=
 =?utf-8?B?Q0d2RkVscVNNYk5RNkRKNjM4YS9ZbmFvRXVJNXMwSWpvTjRyb1J2ZGpxL3BW?=
 =?utf-8?B?aE9ZUXJkT3R3RkRSUDNlaUlNMUhRZjVPenZhNHZXNFF2dHN2Q0JwWS9UZkJV?=
 =?utf-8?B?VmVZWTRyQkE0dVZqR2xtRkEzdmRiM2JxL3ZkZGRpL2NwNUppZmRMbGtXSGlj?=
 =?utf-8?B?aXpTZzA5ckI4d05DT2pObWtxMkpqY3NVa3VkdExDbWQ5Um1EYmo1ME4yU0VD?=
 =?utf-8?B?alRNbFFuMHZXeTJ4SHZxT2JBVXVJazdDU01ZMXpuLzdoVXhvZlBLUWRtZ1Nw?=
 =?utf-8?B?TGFNOUZjQ08ycXh4bkZ3VW54QlpTTmxyNGF4eHJjKzZBZXBwYkVvU2ZxakZW?=
 =?utf-8?B?RHBhV1Zod3lBcS9hNE55RWRQNUY4bzdTbS9JVmlzWE4yNnVhd0VWN0dYbGJG?=
 =?utf-8?B?UTRJeTRhZXhPbGxqeDIxMkhpSmtJQUlvTndpMzFpQVJNK01qRWtpT2o2TmM5?=
 =?utf-8?B?UW1ROGtjWkEzTnBEeDZud0NNRUxPL1ZCeS8zVHpzMjg1L0ZudjJoYjg4U1ZX?=
 =?utf-8?B?TzAvTjFxaDFKNjJXbG8rU3FaZHVhOVJZc1EzU3lOODVGUDByYXVhRW00UTZJ?=
 =?utf-8?B?YWFUYzVERUhmTWlQZWVNV3FmRVdDY1p6U09RcW56ZlBxLy9nZkpNTUpJc0dr?=
 =?utf-8?B?eTRGMjBpUjdtTlFnQTZzV3NuVDlVR05MRmwvc1hWcExmOEtpc3FWdWhpcDQ4?=
 =?utf-8?B?WUg4Sk55WWhkbHI1SXpJWmFCdkxSeVgyTkxTK0lLUjhtUlQzMTVhVGFSTkUy?=
 =?utf-8?B?ckNDWUpWM0l4RTJhNHhIWHFhT1lOb2lQUjQ3bkRvbDFyYmVxUXRPcXpQa2tV?=
 =?utf-8?B?NGNlU2praVZWdEtLQzlhUUZQRFZ4R3FtSk52N3JEQ3FRMlZjMHQwTkpRT2Q3?=
 =?utf-8?B?YW1PYzY4anFCSHJOc3RPTVYrZStNcVQ1VGtpNkVISnIzcHF2TkVkWXp3QVBN?=
 =?utf-8?B?MHc3MFNIUXdSclRDdTlZOXNUUkxIa3FKQ3oyL1p2OEIyK0FBWWdlWXlJQmFt?=
 =?utf-8?B?MkFud2FCNGUycFVYbFk5NVY1d1EveDFsS0pvcFY1T3NCUmVuRjN1SzExY2o1?=
 =?utf-8?Q?QQw5qfoWISJ5eJZMnW1lTYphUVtp98=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(35042699022)(36860700013)(1800799024)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:50:07.0656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f16bbd94-7312-4247-f84e-08dd4b4aa1ef
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11025

Hi Nicolas,

On 04/02/2025 18:12, Nicolas Dufresne wrote:
> Hi Florent,
> 
> Le lundi 03 février 2025 à 13:36 +0000, Florent Tomasin a écrit :
>>
>> On 30/01/2025 13:28, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Thu, Jan 30, 2025 at 01:08:57PM +0000, Florent Tomasin wrote:
>>>> Introduce a CMA Heap dt-binding allowing custom
>>>> CMA heap registrations.
>>>>
>>>> * Note to the reviewers:
>>>> The patch was used for the development of the protected mode
> 
> Just to avoid divergence in nomenclature, and because this is not a new subject,
> perhaps you should also adhere to the name "restricted". Both Linaro and
> Mediatek have moved from "secure" to that name in their proposal. As you are the
> third proposing this (at least for the proposal that are CCed on linux-media), I
> would have expected in your cover letter a summary of how the other requirement
> have been blended in your proposal.

Just to be sure I undertand your suggestion correctly, are you
proposing to use "restricted mode" instead of "protected mode"?

In the case of Panthor CSF driver, the term: "protected mode" refers to
a Mali CSF GPU HW concept:
-
https://developer.arm.com/documentation/100964/1127/Fast-Models-components/Media-components/Mali-G71

If preferred and to avoid confusion, I can remove the reference to
"protected mode" and "Panthor CSF driver" from the commit message to
focus only on the CMA heap changes, which are more generic and can apply
to any type of CMA memory.

Note that the CMA patches were initially shared to help reproduce my
environment of development, I can isolate them in a separate patch
series and include a reference or "base-commit:" tag to it in the
Panthor protected mode RFC, to help progress this review in another
thread. It will avoid overlapping these two topics:

- Multiple standalone CMA heaps support
- Panthor protected mode handling

Regards,
Florent

