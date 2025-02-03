Return-Path: <dmaengine+bounces-4249-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0299A2536C
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 08:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4A01883775
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1489C1F8F04;
	Mon,  3 Feb 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bwjNaunC"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D11E7C34;
	Mon,  3 Feb 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569489; cv=fail; b=Jz+nBGkue6YPivPxPZhOaX4gFhvwx7o8MQXoU6ZP5h8p5e6iOWVBws7gZjqsQF8q3I4OPQ24OWx4xJjI5gOdwueqhWYAHgpqbgyUnT93CWG0Oe3G6j/MRw2psT+lbQ56WLaHi+olfVhsS2+cLGFOacFpJAU4ecgsvfzJ5g9Kmjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569489; c=relaxed/simple;
	bh=aFjf99dJHHfpQP/pYly0VeKsMHNcIGPo0VlRn7n+uA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KQBc6VrE/qNeJqaDBwNIlZvDv33eZx/JvIVXd/wodQCk59jGp2ohl0Fkh+RSNCZ7Nm7NXM4NQsOrjkb4AuoK/O0zCWIbDxD8uSFXY8x1jPQX2QCqOGkZ+YvsmiOB5BO/bDGyoPqS0KjeG+uzGkZB4Z/fLyDrz4tFm7fBwyayd9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bwjNaunC; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gy4Lm+xG3djQONj6VROAaUZvnJTkSpuLcuMiFd6+l05hc86tEBzBsv7BGeZ1zEgnUGwPcE4sI9uPFrJ4t1Ije8AlzcoGbLHHGYDWqaJf9xaooEcsbd5WVz8vumKNC7+jd96Qtuhg9BLfm2obpKmum8gK5gmdoJZdJjZlfMjSGJ9ljXxcZLjmVsPcycEvCB7arlaXsDGy5NRbiv3Z4aFSA03/z2UsUIDg7NeAq0S6/Evh4v4DgmWqzGvUollUGNbxnapcIiJkB578viacd2/SCngEeeAnkHZUIGpW5GEf8FGlcSZgHyTv6Psn4Fof5Nbd6+hpyOU/fKCc2z67nOWBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqUOj4J09LVO3B1RvPjr4J8i/44wufWVfSavafY0X8Y=;
 b=KOiOTth3ITVg4ve2h7X7YC3S4zYF50VLD8KmJ5lZtpf0dN5nIN3LrVFyfdL+NBgoxrOO2bNCEGFcKbzY8f9b/H6+bqi7rcFvXj8RdOcM3NqrCqvX3W8RrjSZmiZCbOeCRITyWBih0YE/6zwbKLrPowv0wCrbsH3/Iot5EZFglfU1mCNIgx2Xj8OmAA5T1I6yZdQAKbRexpntEi6ed+Y9ckmo3SOFm/dki0mLyVFlAZYNzWZjnPzHAJxKXP+3jmgRFUwbQftZYrNMDnHjrC/x10mOmKm4ZJUHoh3STosq/ZuGmpXPtZl52q8c5jseKia3cik2dC1jtCAhdYJUYcPDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqUOj4J09LVO3B1RvPjr4J8i/44wufWVfSavafY0X8Y=;
 b=bwjNaunCTsZk+3mH+30Toznd3nil9fkWOXhTUVSw3gXsqslOtPGLqLbl3sptgKz16WQqvX6P69O1sbPZAIq94mSceCkfDpJLbIBAR4FAIDq4sa3gU8y1hJLxuckq7R776+7rwR0KCKdsY2ZV48K2G5i/KZ6t6K9Cz/1fs51QAY+2/p+jlBN0myZBkbQbL+KNN2co0uOG6/HdGcPWiKA7w4tHxus1G85Db0ew6HQqOt9TUxSycZEnubA8BLuNOvD4arUdbFqn9RcJqQscwuxo2WNN+C5ROg3Py/qe69Clym/a3JerrnykluvNOm/Bo3P6mNKFk+K6xCoLHIZCIzv0Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by AM9PR04MB8985.eurprd04.prod.outlook.com (2603:10a6:20b:408::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 07:58:02 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%7]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 07:58:02 +0000
Message-ID: <26f0459c-2eb5-46bf-9d55-8f830f9687ec@oss.nxp.com>
Date: Mon, 3 Feb 2025 09:57:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: s32g: add the eDMA nodes
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20250130072951.373027-1-larisa.grigore@oss.nxp.com>
 <ac1ea985-15cd-4001-9700-a185ceb338d7@kernel.org>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <ac1ea985-15cd-4001-9700-a185ceb338d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P250CA0004.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::9) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|AM9PR04MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: b75e8764-eca6-4489-4723-08dd44287bbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VktsczRDNDFrZDZ2a0ZoTlF1ZjNYaWxEYVdaT2FqenpXNkpTRE1NZGRQVSt3?=
 =?utf-8?B?K0Z4S1dmbEl2dzExdGpZR05aZm1IMjBjMWdjY1dVam9RdEJLNkJXam5pb25X?=
 =?utf-8?B?Nzh5SW5yd3VTMHFxQUwrTk5tU1I0ejNweTNMYVNlUkV6Y29KRm1yMExKUmtS?=
 =?utf-8?B?N1FSdjV0OE9tQ2h4a2ZQdlB3M3lhYkI2elB2RHUvRlRjTWRQc0d6dVhqMHZF?=
 =?utf-8?B?dXpBb2lxSGw3d3JtVDRiUG5KQTFhM09yVDNLWWkxTnQ5YnI1QVZQMExkMWJO?=
 =?utf-8?B?eGI3T0w4bzdpQyszaFhqSFZieDVGOWJRamRBUndmbkpCc1RzWDRKenp3SEJY?=
 =?utf-8?B?ZUo0ZXFtQ2hLMmpsaWtNUjgveFoveUlldENRUWl4MUozS2RzK3NhSENYUnNv?=
 =?utf-8?B?cFZLbjcrY1A5U2VXMVBsSm5rZWZhVmNUaE9Tc0VrWDdMUGt5WWFYeDVaOUxp?=
 =?utf-8?B?a1NWZlIxY1dUWDZuZHpMUlBvTWUrUFk5UzhzNkNFY21MM1pCaldmN29mV0hv?=
 =?utf-8?B?TTdUNzdNQ0FSK2tsczNUYzdoM2FtNVZEWjhnR2NrUFNkT0lkS1dQQkJWSEZx?=
 =?utf-8?B?Z1l2c2JtdzVFM1FYc0hMd1N0TjRNbVg0QTJRZjFlWnJHcW04YkRKcjB2N1FX?=
 =?utf-8?B?TkVpbmUrQ0tRa0ZvOGRHR01jNkhLQzVDaXU1WTRxSXBvY2FKUXBiWHFUb0lB?=
 =?utf-8?B?N2RqR0hFQjFoUGRSYWRnaWM4THN2aXF2aFhHOHhaamN4M1J6R1Y4YlQ1c3hT?=
 =?utf-8?B?ZFI2QzIzVnA2OEhOZDE3Rk5WcjNqSXhVamlMN1JNVVIyM2Y4Mm4rWjU2Z054?=
 =?utf-8?B?TE8xMHFWMXA3QXkrZ1NnVHI0WnFDc0lkY0VWUW5rZUhIUTFWMjdkeHNLMzRV?=
 =?utf-8?B?TmdXcXpvcEthQzEvOFlXVzlLWFpPOGZZR2lqbjFuQktrdDRSYW52RWt1azdC?=
 =?utf-8?B?aHRFSm1XcXFoSkVlMnNQUkVSWUJISysxWm9uRDUvK0JNWkZMTHY5a1JtMnVR?=
 =?utf-8?B?ZHFyR3owQjdGZVdaNTRVVDJoWENpek5hSktqT3NhcTNud1BDUlJLR0lzd3RN?=
 =?utf-8?B?SjVTUU5EVTVUZFY4S1E3QW5FVnZrait4emZ1ZzhIVHhoanBnU1pqdzl0M3ZB?=
 =?utf-8?B?dHBsRmRtWXpuVzBZQzFNTHRKc2JZOVVvYlphYzlXTTRsQ290VElUU3ZtWk5O?=
 =?utf-8?B?NGhJaHBkMjhISSsvWHgyK0QxbnRmWVQyeUVEbGVMMFU0djBodmRaSWZlUDhO?=
 =?utf-8?B?T1RLMnVJYWE0MForT3NKMjZma3BIUWhpc3ZoSWs4OENGNTZTWVM4YWFVbm8y?=
 =?utf-8?B?aFltN0hQTkFCUkJRM0VIeDVZTCtmbytFMCtUcmYwVktua3dOa1UvbDMyRldQ?=
 =?utf-8?B?RzhZR2VOQnNlOUVlK0ZkVnBYa1JocExHb1NDK0pYQ3dyQ0JNOHIrTUpVR0xZ?=
 =?utf-8?B?SXRzc3g4NlBOMitRUTFFN1dpUWlqMG9LNWdtcWZ5eTlSUzRzYUpFUlhwT1R4?=
 =?utf-8?B?bEhXMnZRSWN5MUlJV3EzYnB3WnBqSnluT24yaXlrUy9jREx0djBJWWJOcVgv?=
 =?utf-8?B?YlJHZDlhbk81Z1dwdFp0amNCSm5yS0lEVWNGNkN5MDdLNE9MUE8rbU1QTC9G?=
 =?utf-8?B?U0tOZHpLSXMwb2NITXpXNkRTTmFRNWUrNTNSTXhJREFtWHRKZC95d3VzQXpr?=
 =?utf-8?B?Z2FQZ2FlQlNZbS9JTnJtSnRpUmdkWHRFWHFldC8yQ2wxazE3SjRkSXJpNjFH?=
 =?utf-8?B?WEVzbEROdHU4elplL3JSRm94VVVvdVhpbmhHMUVSRE5vSDBUN0I1WS8yVEZk?=
 =?utf-8?B?U3RFOGdRNCtqK3BpblE5REhYN00xbU5zZHFhSlhQUGNSSWJVVjloODBHZE1t?=
 =?utf-8?Q?6M06cAwTJrHJ2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDlwbGtoYzVlSHhzb0lpZUx5U08yYW5lVWtBZXR3b21vdDNXMHh3aEFqMmh0?=
 =?utf-8?B?MDVqcWVoQ2g4Mm9aOWJocXFzNEVpekcxUFlFQllVYUk3K0VpREViUnF5cFZm?=
 =?utf-8?B?czBHaUNlZmxOZFRISEV5TEdFTXBmL2tCazBYZW1GMjYxc0tDbzhwMkRlWnBC?=
 =?utf-8?B?WDA4RXFtY0ZUbTlLOU4rbmpTdGgwelYxcUpZclBORDlJSlJmVjRnZnZxNXBv?=
 =?utf-8?B?SEk1alBNbDNiaGJwYXJERUtKRkNqYmVPY3R5TTFkQ0Nja1Y4V1I0OWtpN1Z6?=
 =?utf-8?B?OU1PMElMckhwREVEanFZaG5hbXZZMHZ5ZlVoTm4wVWFJd1JiUUNrM0NEZEdT?=
 =?utf-8?B?TlNCMTVGODFqNndobFNaU1JvaFl5Nyt0MldMOVVUYW9OZWE0TkQ3YlVOa1lP?=
 =?utf-8?B?cThqeDU0M0hBQ2oxZU5uZEY0R0NaQ1BUU0dwd2VtTDM5dkhQQk1PNlU4Rm9Y?=
 =?utf-8?B?RG9MT1d4NDNvYWN1dHFvOG9Eb0VXczU4SFNLK2d3Y3FIWW90b2Z2OWhxVW5Z?=
 =?utf-8?B?aEtKQzdBOHFqWEQ2cEJJWEx6d01WV3JkanQ3c2lEWWxEcXNWcmh0ZU1UK3pw?=
 =?utf-8?B?MnZLSVNsRlVhK21STFFjSkVJZzgwNEQrcTd6dkdzZlU1bWhFN3RrVWt2NUcz?=
 =?utf-8?B?ZkJQcDNiUExyVFJKVUdpMVVDMUo3Vi9oT2dLcWZVNW5NRVdVbXBtRzJYOVln?=
 =?utf-8?B?UTlzV0tRbUlFNjJ2eE1OeDhlbmlnT2Z3K0wvaTVKVEg4Y04wSGt1T1c0NDd1?=
 =?utf-8?B?MkpYV0lMQk9NbU1MaUlNdjkyOFEra2x5OXNXMDZLNXE4U2V5REg4NkFKYUdp?=
 =?utf-8?B?SnVINW1Nc2w0Wll3dkQzUGJQbW1mM3V1VnYyNXp3OUhIUGhPOWRET2NWSTVj?=
 =?utf-8?B?NzlPZ0pKN2FxNzRKRXdjNFovUFJHempxYmkvNjdWSjBQTGpxYXhJbUdqTGNC?=
 =?utf-8?B?QlNPQmxXdGc0UXpNOGkrTkxSQ3FlZDM1NE5SZUNtM0pMQmQ3czlkazdveFpu?=
 =?utf-8?B?YndKcXRmbnZkenBBc1pEUlpCTjNmTjNUMmQwMi9vSDlkVW1lNVh4aHZHLzRr?=
 =?utf-8?B?Qk5CS29wM2x5VE1PWmIxcUN6SlpNZm1UY0gwQStCUFZjbC9CNWg2V0ZreHNx?=
 =?utf-8?B?OEFJdTJKUHlMUUJmSEc1MCtaQTBBVnB1a2ZzU1ZmMlYrZzlvRlhHWGpUdjdk?=
 =?utf-8?B?ZmxZUnU2czAvNzg5NzkrVFBqWSs1OWtTMjZ4R1hZOHJZOFcrZTlpUmg5Z3lP?=
 =?utf-8?B?SWY2TjYxVlE3VVJKalpnM2o5MTZBbVo0blJHUGVjVExWRDUxVXNQRzVFRS9P?=
 =?utf-8?B?LzBwQmsvV1NoNExhZDRnSkZxcm9IYVg5WGYwWmJVRHZBeHo4MnRUM3VsSTR5?=
 =?utf-8?B?UUl2V2tRaitMQmJUK01Fek5qc0JEV2NYNEJrb0ZwNnowVHh2YkxIdEMxQzla?=
 =?utf-8?B?dDUyRU1NMCtjMEdZOVlHdXZTb1RVN0hMS3lIdDhENkdaVmFvdnBGMjFsRi96?=
 =?utf-8?B?MmVjbjBycm1BL3N5L1JoWU9idlF4WTNqNklzcXZlakV2RFc1QmlUODY5WjlU?=
 =?utf-8?B?S1NmVzQ3S1c2ZkUvcTh6anpGWFZxNzh3YWdGUFVPVnNoSzlIa2JDS3Nta0Js?=
 =?utf-8?B?cGcrMHRqODZ0WDlXVWgwWG0wRWtBUUJNNEVhN0kzd3ZmZ0oxRTAyK3Nnallk?=
 =?utf-8?B?aS8vcmIyVDlJTHB5VGRadEdYaGQ4RDY3Szkzc3hCdEZNdlBxRWtpUUVaMGVN?=
 =?utf-8?B?VXNvdDNKQUxBOTdnZkIxUkhQcDE5V2pjZGp2ZVA5ZFNFVlc2Smo1TlgzdUVJ?=
 =?utf-8?B?WkdFZk9lTWNSMXlmWTIrQ1F1RVptTktJOXh2bVpzWDRiK0pRaitibmF5RWF0?=
 =?utf-8?B?QTdZQ1I2NzVlZ3pjVDUzU1grWklTQXJVUjF2L1NYWG9wRlMrL0h1dGVKTytI?=
 =?utf-8?B?Q25aMjBNd3JLT0ZmelkvVmJUR1NNTnI4cVEvOG1vQzU0d2Y0WTg3TmNweUNW?=
 =?utf-8?B?Vy9aWUZjOThNT3VBR2EvVUxpMDBDNElCZitSNHM2cktOcjhCcDBraCthenBJ?=
 =?utf-8?B?cWlndGpPVG9pUFpZUlpTeDlCU29BUjZPemlMajZ3VERBZ2g4cWc2dUlXL3lD?=
 =?utf-8?B?NWt5Z1ZJekszL1c3KzRUNGd0RjJYcUhqTWcwZysxM0tHbmxpckM5UXczMnlJ?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e8764-eca6-4489-4723-08dd44287bbf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 07:58:02.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxgp3h0ooeKrmgmqnN1z9VPoH3RJzWYuMM321Z3a3jkN9PqHhed3mc1gXrfALm3HGbkI6/i0o7b9Wu5JTVWCKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8985

On 1/30/2025 10:48 AM, Krzysztof Kozlowski wrote:
> On 30/01/2025 08:29, Larisa Grigore wrote:
>> Add the two eDMA nodes in the device tree in order to enable the probing
>> of the S32G2/S32G3 eDMA driver.
>>
>> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/s32g2.dtsi | 34 ++++++++++++++++++++++++
>>   arch/arm64/boot/dts/freescale/s32g3.dtsi | 34 ++++++++++++++++++++++++
>>   2 files changed, 68 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> index 7be430b78c83..f73cd5a0906d 100644
>> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
>> @@ -317,6 +317,23 @@ usdhc0-200mhz-grp4 {
>>   			};
>>   		};
>>   
>> +		edma0: dma-controller@40144000 {
>> +			#dma-cells = <2>;
> 
> Any reason for not following DTS coding style in order of properties?
> This is odd style.
> 
>> +			compatible = "nxp,s32g2-edma";
>> +			reg = <0x40144000 0x24000>,
>> +			      <0x4012c000 0x3000>,
>> +			      <0x40130000 0x3000>;
>> +			dma-channels = <32>;
>> +			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "tx-0-15",
>> +					  "tx-16-31",
>> +					  "err";
>> +			clock-names = "dmamux0", "dmamux1";
>> +			clocks = <&clks 63>, <&clks 64>;
>> +		};
>> +
>>   		uart0: serial@401c8000 {
>>   			compatible = "nxp,s32g2-linflexuart",
>>   				     "fsl,s32v234-linflexuart";
>> @@ -333,6 +350,23 @@ uart1: serial@401cc000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		edma1: dma-controller@40244000 {
>> +			#dma-cells = <2>;
>> +			compatible = "nxp,s32g2-edma";
>> +			reg = <0x40244000 0x24000>,
>> +			      <0x4022c000 0x3000>,
>> +			      <0x40230000 0x3000>;
>> +			dma-channels = <32>;
>> +			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "tx-0-15",
>> +					  "tx-16-31",
>> +					  "err";
> 
> interrupts, then interrupt-names but:
> 
>> +			clock-names = "dmamux0", "dmamux1";
>> +			clocks = <&clks 63>, <&clks 64>;
> 
> here reversed.
>
Thank you for your feedback! I will address it in v2.

> Best regards,
> Krzysztof

Best regards,
Larisa

