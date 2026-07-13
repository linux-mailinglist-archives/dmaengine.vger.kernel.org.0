Return-Path: <dmaengine+bounces-12371-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dLtWOh+0VGoOpwMAu9opvQ
	(envelope-from <dmaengine+bounces-12371-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 11:47:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5D274973C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 11:47:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=sKNqcnlP;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12371-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12371-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20663303FB89
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA1C376BD5;
	Mon, 13 Jul 2026 09:45:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F2C35FF6E;
	Mon, 13 Jul 2026 09:44:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783935903; cv=fail; b=r4jf+IX2i5x2+sVqoLAXaRlGrkfmTMegCmNsB3glQty9eIJJarOdlQH5j8NHeIGWxXMz6lyptHe8ZXVeY3VgUXnr+5OSJun0EBzbqO/l2naLR9MVmAeEOPK7Tqh75fki2ATvFGugmyA6HKDj6h9ouUEDZ3F7SW28/+0Jh4WJNOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783935903; c=relaxed/simple;
	bh=jnNwo+ClSWjCAKMCTN1RY1sxp8h6UvP0Eoml8b6VROo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RR633InMbJB9prUErwsq1LH4rNBR4kugSAKPoj5hdLWJ/q12Ie57wDk4gaH8zKp/Yfg8dtkTFWuy9au/N7wqVcVgPEyQZdfVOIlwfKYvO2izBuZoD2AxSjAHwbsuWP+kI8aVrh1R1Z575pB+YELUfdI7sMwOUSw32rw2GW16evY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKNqcnlP; arc=fail smtp.client-ip=40.107.200.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUESFjQ+E6lScOQf29hfFqbsVFoFW7wzRdNZBVujoTUOw+58f0Mp8ocpbO+gRMOrwN27Jglw04QjSPDyPF1XDuWQdn94Tz44Okwfd+VQ6fN8z78szLUim3NoshpFQTSbQDA+Eto8A7irREA8s7NfMKqYcvUBbobZahUyxc8oGkM/oKjORLUF7ROmxfO+7m6IvDKO/QiCFTPCJgUVScpla4/lgZCJVL6rGZAITYZ15oDfjLKjqo75Ur1Ae/ybxnZfz4pxC3sqxzmJVtK6rT93DRLnSuvJsGSU7Mxitq232ANm0cl2+WUN40YF4BWflr4ewJT2hBaKh+L9fbVFcT0zrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+e6RmfXt3qxA9UnW5TIitbXtV6Z0EGUaJKm7P6Ut0g=;
 b=e0e7sCRnpMBVOhaVMDr0cYvoVrfdxVbWYauGwhPAxaEh7kEHcqWVf/UqiAqc/bCDBG+NmXRHTTTDwUgkb19ctd4qRk7qU/lD24Yt6mwuNpM1m8oy5zA4WpvtXLml1ZHIJAY8MpXz1DiFRCk2dv14Kw4mdb/nkIEkfz9iAQkmXEyhUExQ4a0ObzGTVIOwqfXWwoa4isw9kuzBgq4ibynjzdGCaT+HQJg+X6fvDBIJr74W81hGaP+59yvTMbfA3uI7mFKWVy5NXMmSj7lTwcRP2BnvGf0j6nrU8cAeSmAVKDZffXvHNLpW/spxaaqtSd3PSMwz7i9IumtcJrdcynnOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+e6RmfXt3qxA9UnW5TIitbXtV6Z0EGUaJKm7P6Ut0g=;
 b=sKNqcnlPoT1fRK0/6mVhkZA+WOWJRQYvb+PXSxFQNVM/YvWR/f5MpEMd68J+HsKuFrkjhqxVNr75HUoWGpWZNeg4QT46LrTyjmE5pW4tVEzcbmjEqJNaz5q2VIqjBHotjC+CRISzMPRDsTLzphkq8KMkndPI5xrfB19OWh/tPEE=
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 09:44:50 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 09:44:50 +0000
Message-ID: <2a3ba353-24e3-4363-90ea-67aa893ab324@amd.com>
Date: Mon, 13 Jul 2026 15:14:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] net: xilinx: axienet: Derive RX frame length from
 residue in dmaengine path
To: Srinivas Neeli <srinivas.neeli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Suraj Gupta <suraj.gupta2@amd.com>, Marek Vasut <marex@nabladev.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Alex Bereza <alex@bereza.email>,
 Folker Schwesinger <dev@folker-schwesinger.de>, dmaengine@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20260713072146.45269-1-srinivas.neeli@amd.com>
 <20260713072146.45269-4-srinivas.neeli@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260713072146.45269-4-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::7) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: aa053265-a733-4eba-b1ff-08dee0c361de
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|3023799007|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	73yXV8PJ82aWXvEBgk+PjRwZTke47c8KwlRWqu2fo0kIAd5qlXDNQ8dQcHzcpjJ+VXeaJwGvsrzE5Wla18F8k7npVTPdWcy9Yw53h7Hkjh/z1gsaUlDA5u5uTlc8yvMSs5sku5/xIdm1FDXNIWgUnU+X/o/6oi4Ag8JMkNwPoPDSAKpvUwa1vTuc2XxkzUxLHEBTeIteysgKUzmsjtITHeYcjV0IYZZ5cIQP+i83SN8Im0Bmdyv/OdL25PkW3gxSH3ZAkqS3fSae5a+92rGSSXynXIUN5s/DU7jPc0wL9JTGix5qxczHsc5o8CR568B8eq7NxQIaIW84xIUoHvEKHwrCa79QS060jL9fgD84pIOyOjAIzFTfhQRPjHddeiLE/sSD5rYiybkZYmgbRbTEXyRmPEyzKeFDpzVosg9XKrd7x727V3xGpr39tQHPo2T26bOWavl62LBm1rU4NV2cNa4mbJPE9dDxsCVNT2rzB2j/nQ3VtoNt5FI3W2GgqgXWt1UGsg5fYrKMcJrtg25HGwzqVYcPxPAAwrpwH52GCb1f0G9h/3N9QgZLchxD4uhRqaVIsX+mquBb21Nnt8Q28OBiHeIekky2g6dpD6ES4En7s7rosoy2/pM2Pjtg+0tY7UIW2vysy3Tl1BbCYqeBmvLbLBqC7S8pwDEA9+hgvv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(3023799007)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUZTeWtLNXRDc2IxTlBrdkFEZDNLSVphcVdRZGl6bGRlaXZ4ZXI3NWxZRTFN?=
 =?utf-8?B?Q2VWYzZtWXdhaU5JR3BrSG5OY1JEOXBQOWVtWTFvV3pZTzhqdm90cWhubkFW?=
 =?utf-8?B?bmo5NndmaS9zVTlDNVRKa0JoZG0zaWw0MU43dTRIWGc0b0cvbnc0eVh4dytk?=
 =?utf-8?B?K1h0WHVTOC9tTm51ejYvTU9iTTQ2L0JnT3hHQndLQmI1bE51a0RNWE5XQVRh?=
 =?utf-8?B?Q0pmSTNYSG9SZTRHTjE3VnhtcW1pZmphQVFyWmhYdmYvQUJjQ3FrWHovK25C?=
 =?utf-8?B?MHpsUTMxRUFYYW9TOGw4R0k4WlJOWGg3eGR3bnZBdkx6YWZpRDdYZk5mYmU4?=
 =?utf-8?B?bnQ1cUkvMkM2bXRGTmRDZ0Q2cVNNNHZOZnhsYmlYa25IeDFLbXlZZFgxZjE0?=
 =?utf-8?B?RUdFOTJYODB2QWNXeWQxSWhqcnNrbjV5Tk9DeWVSTVJLckYwazhTenpWTnA5?=
 =?utf-8?B?YXkxd3RLY1hscnAwY0NCRGpEVWdVeGdxclJvR3phSm9YWDM4Q3g2Z1M5dnB4?=
 =?utf-8?B?Sm13Tk1RVnJSZGFHTzdmVm9nN2F1V3BleXJTNlhRTkE4Sk41MlFvYjZ6Z1ZV?=
 =?utf-8?B?QUJ1eFNvWmptcHQzWHZDbFNvcEFiRkoxME0yMHNPRE5IWUM0WnQwVHBVRlBB?=
 =?utf-8?B?VUZkbnhRS0JNUjRacURqOGpaNmttNkpOaG5DRC94bkhOdlBjZ1dHbElwWS9h?=
 =?utf-8?B?MXpiQ2VpVzF4WnU0NmtXWEpWU2d2SjErMmV3TS83WEtCbVdMU2pBN2FaWGgv?=
 =?utf-8?B?L3VWeG5oMGxNUDZmQTdkdWh4b2ZJQnJrWmNmc1EzdXFESDlnL1BZMldyczdH?=
 =?utf-8?B?emJzQXFtUU4wdngzQWhmMGpoM29URm85MGx4SkJvclpLQUxheGdLOGFuK25N?=
 =?utf-8?B?ZmxQMTRDZnp4blg4K2xPL2t0MTFWRHJXT0c4OTZ3Y01OZW1BS2JiclpoVFBk?=
 =?utf-8?B?VHpGejFTSGJHbllxRGNBUjF4bkwvQ3AyaktUczNCaVU3MGQ5bkl3U25iYVds?=
 =?utf-8?B?V3YyTytyR05WODdYcE1NMHhFMm9FU1pYd045c1BtTXVGbHJlL2FKUHRDU3ph?=
 =?utf-8?B?QU1wL0M1NFVEb3JnUGtnOHNMbzFsY2NHV1dsQlg0TTRZenFNNEsvczhrTUtI?=
 =?utf-8?B?U3V5QjhjdTZHKzA4VlRzMHJuQVFxcVdzSUtLN1N0N1U5amJIZkhpTk9DKytE?=
 =?utf-8?B?WGhXUnVWcjUvVGFEUjdKZFlSckd4RjVGb1JtWkoxTUlGZG1DcFRYMFNpNWJ0?=
 =?utf-8?B?dEFjaXFJa2RGdEVWMTBaZXNPalJtMUNsdGFFVzNJSWpsblBGRlF5RTVjMUtG?=
 =?utf-8?B?anE4WmptcDN5dWJqcDFDWmZUc0FiK3FaVGhOQ1k3SkswNW81N3hiUzdFbUh5?=
 =?utf-8?B?WEx0UWtPRnAyWVpEdjlsVUIyNThVZ05HSHozVGJKbXZwWllZTVVtYkFHTzMw?=
 =?utf-8?B?bElZRFBMMVRqQkRQclZJUjc3djNJQnJ5MkkyREozeUxKWVlkaGNGa3d2VUVq?=
 =?utf-8?B?djNqaUEvczdRTEJ4QVJhSTl3Y1JpZXozTDdoZlJ1bnJGejUraDRxNTQvL25S?=
 =?utf-8?B?ZExwamdUODlaZDVhVUlGaDErWkVLamJZSms5Sk1SV1BmVU9Dbk9uWkpZVzJr?=
 =?utf-8?B?QTRiMDVMRFlvN1VPVWI0Y0tTL1ByR1RGQWxlbTRLNHRWVmlpV25Lcm00TWFR?=
 =?utf-8?B?cGlCKy82ZXZzRVVhZ1REcXlzVHIyRjkxbXhteFlJYWF1N09mQnNoTXdtM25i?=
 =?utf-8?B?UjhldVZMWUF1TmdCeHd6MVhRRXlueUJMOE4vQXJlSVYweFpId3hXdjBHT1Rx?=
 =?utf-8?B?SFh1Qk5HTUNraXRJbGZ0M2FFUG9pK1BPYy9pVWdDQjBZaysyaFRaWkpOa20y?=
 =?utf-8?B?SXlXRy9RUkF1MGRnWWJTS1NnN2RyckYzQzJ2bWpFUUlOTnVyU1dRdE5hMUY0?=
 =?utf-8?B?d0pNUVk3L0pRUzJCVy95eVFmNWRrK0lmcmE4RTVlc3BIdGNyREl2c1Boa050?=
 =?utf-8?B?ZWFvSE5UanNzNUk2QmJ6cW1sRWVqbjBNSmlVZ3E3MThLbHVlUjh4cWV6REtG?=
 =?utf-8?B?TEQ3cU80UnFxcXg1bWtJNGxqeC9VL3YvV1pzZFdNSWx0RysvTFY2d1YzYUsz?=
 =?utf-8?B?eWEzSDRzMFBOZ2tSVjZoVnp1SE9YVjVGdnFiS2dEL2RKN0hyQjFjRGRXSFRa?=
 =?utf-8?B?U09hWUdwakpUUWtubkNvM2Z0OWpJdjFvQXhGT1B6S2NJNitScC8yKzh2YXFi?=
 =?utf-8?B?akRoUnp0SnhaQTNoUHNhL3Yvbmp5RkV3RjBMeU5pVU9lV3BVREFNc2NYamFZ?=
 =?utf-8?B?VVlLWG0yNEZyNXltRnhXdkRwREdkOUNCZVZRaDdGaCtBdjhqeGk2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa053265-a733-4eba-b1ff-08dee0c361de
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 09:44:50.2007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lce0K8CMMkpmJvO5oCSrz85f6XV5fQ0Kbh3APJH0KRaeC8GPn9X+m7eb4zpPAoR3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-12371-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:srinivas.neeli@amd.com,m:vkoul@kernel.org,m:radhey.shyam.pandey@amd.com,m:Frank.Li@kernel.org,m:michal.simek@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:suraj.gupta2@amd.com,m:marex@nabladev.com,m:tomi.valkeinen@ideasonboard.com,m:alex@bereza.email,m:dev@folker-schwesinger.de,m:dmaengine@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:git@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[radheys@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:from_mime,amd.com:email,amd.com:mid,amd.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF5D274973C

On 7/13/2026 12:51 PM, Srinivas Neeli wrote:
> The dmaengine RX path derived the received frame length from the descriptor
> APP metadata. That only works when the optional AXI4-Stream status/control
> interface is present, because the hardware populates the APP fields solely
> when that interface is enabled. On designs without it the length read back
> is invalid.
> 
> The AXI DMA engine already reports how many bytes it wrote into the buffer
> through the standard dmaengine residue mechanism. Compute the RX frame
> length as the posted buffer length minus result->residue, which is
> independent of the status/control interface and correct across all designs,
> including multi-descriptor frames where the residue is summed over the
> chain.
> 
> Drop the descriptor metadata lookup, which was only used for this purpose.
> Detect a failed transfer from dmaengine_result.result instead of the
> metadata pointer return value, and remove the now unused LEN_APP macro.
> 
> The transmit path is unaffected. It still passes APP metadata for checksum
> offload and derives its length from the skb.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Thanks!
> ---
> Changes in V4:
>   - Renamed subject to "Derive RX frame length from residue in dmaengine
>     path".
>   - Condensed the commit message.
>   - Dropped the Fixes tag.
> 
> Changes in V3:
>   - New patch in this series.
>   - This patch enables axienet to work on designs where the AXI4-Stream
>     status/control interface is not present. By using the standard
>     dmaengine residue mechanism, the driver no longer depends on APP
>     fields being populated by hardware.
>   - This approach replaces the V2 xferred_bytes mechanism (V2 patch 5/5),
>     making the dt-bindings patch (V2 patch 4/5) for xlnx,include-stscntrl-strm
>     also unnecessary. Both V2 patches are dropped in this series.
> ---
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index fcf517069d16..67d1b8e91d68 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -53,7 +53,6 @@
>   #define TX_BD_NUM_MAX			4096
>   #define RX_BD_NUM_MAX			4096
>   #define DMA_NUM_APP_WORDS		5
> -#define LEN_APP				4
>   #define RX_BUF_NUM_DEFAULT		128
>   
>   /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
> @@ -1159,29 +1158,26 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>   static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>   {
>   	struct skbuf_dma_descriptor *skbuf_dma;
> -	size_t meta_len, meta_max_len, rx_len;
>   	struct axienet_local *lp = data;
>   	struct sk_buff *skb;
> -	u32 *app_metadata;
> +	size_t rx_len;
>   	int i;
>   
>   	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
>   	skb = skbuf_dma->skb;
> -	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
> -						       &meta_max_len);
>   	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
>   			 DMA_FROM_DEVICE);
>   
> -	if (IS_ERR(app_metadata)) {
> +	if (result->result != DMA_TRANS_NOERROR) {
>   		if (net_ratelimit())
> -			netdev_err(lp->ndev, "Failed to get RX metadata pointer\n");
> +			netdev_err(lp->ndev, "RX DMA transfer failed\n");
>   		dev_kfree_skb_any(skb);
>   		lp->ndev->stats.rx_dropped++;
>   		goto rx_submit;
>   	}
>   
> -	/* TODO: Derive app word index programmatically */
> -	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
> +	/* Actual length = posted buffer length - residue. */
> +	rx_len = lp->max_frm_size - result->residue;
>   	skb_put(skb, rx_len);
>   	skb->protocol = eth_type_trans(skb, lp->ndev);
>   	skb->ip_summed = CHECKSUM_NONE;


