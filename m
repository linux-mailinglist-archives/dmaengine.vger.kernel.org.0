Return-Path: <dmaengine+bounces-8680-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA4lGRGpgWn0IQMAu9opvQ
	(envelope-from <dmaengine+bounces-8680-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 08:51:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CE3D5D8C
	for <lists+dmaengine@lfdr.de>; Tue, 03 Feb 2026 08:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EFDD301A90B
	for <lists+dmaengine@lfdr.de>; Tue,  3 Feb 2026 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB5392C29;
	Tue,  3 Feb 2026 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G2IDi1WD"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF67392C30;
	Tue,  3 Feb 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770105092; cv=fail; b=LomoTWFY5eigw9+ZkKoSR892gwztx5Mn9qBjMaFBQh/DwEjOQpjxM4Q2geOAkbbpfs8SXsCxllSa/N7ylJ4ea34PuDT3MW5SwEPVWCTtlsVADXW0KcI6gu6X3O/e9V6yP8DuzSV3qK76NMDG/QbUOWMeQh0LpteTl+BbG/liBrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770105092; c=relaxed/simple;
	bh=fWtSBwnDVEYtB7gmFMYReh0CyiaAvINtkOBpMccG06U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mrQLG/8X6qEJlgeWbDP7EgJZmaCAa7I7VJD3W3Ro8ebC/tDOE8lE9C0oiGysie5i/rGnjFJ/vEoRYx6UypRkpVmP5uxjhZvaptxz7xtCL12W0ay9sUZ1P/0xSjGhfjf1hMjG8dfb1YTwgwsYbSQDJupIFm4X4sh+PGd4K4AO9OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G2IDi1WD; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkbWXVG2pX0jGDd2H5Z1XlNp4jgg3XwRqJDps0a4bzwGCi22AsTLCjPj036Zk3owyZCY6wtYtWDUmNaSpPSyWagEvMPJJWpofQhRy2ZrtFJAO6bo5xwrcDfiQaNfuvn+oNeq3QVroxoOIEIf1WAt5OijnKB5RQ0k9ycJYdsuYievbMa2Y/8nLgzrO+pAgLR6jXKZF5LBo29VgcgXxDYbV+Z3F9jOnol/6nikTm8ktepYMBSZTejO8cx7Wueo1hAVYf0BPQJT8VNq0LG3REwFBeRufXLO+VrucwKngGXuFoYulAW34rmsBVD7UpoPZPZpYoQhGHLRDKanG7dfz5Zjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS+hTaw/K2eRYQwHrNMpe00V2QzUj9TPnE0uxI9cze0=;
 b=GmZPMnlpHIeF82V5UNbivRZ3Q2rusS6YDhgIexcDqb2IcJk7gJFTCXV4vYjNzMTdPNZ/xlz/Dxil/JQQU84By8oAYQPQJCv6eoqrIA7uVV/OsVJGhtWnC23cK+6Dx0s/Gcll4s1yCyV4dQaqB4/QpZQiIxVvV602y2RQXMSRodXtImPU0iFtvnrkj/4S5VhSSknQ9o2LuLX1umdPNXeeI7HMrKrO48VxhwXVSkUyGxXjEhc2ime6GH7MHg5+5tFotr4jOgQzfJa8Wp1KFDyqJo1+DwrTZRt2NUPUGMv2Rq4HV75o1PozK5kap4GdyJu4X+zzfoWCtrut+QaFpSRwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS+hTaw/K2eRYQwHrNMpe00V2QzUj9TPnE0uxI9cze0=;
 b=G2IDi1WDz5ht/zLd2yL+9CUQBGh+wNFz5/xt2u8fxyZspAGb0tT0jfrhpdKwDPiwzr+Hg0Xmtr/WtnJL2tTYJAZAFn4U7v/HizlM3/H4t88B9k0SeQOW0SmXVo+ibP/jp349mGUhkS2o+PYqbN1BXkZHvi6q5Gn5ewmpcC34QR4=
Received: from SN6PR04CA0097.namprd04.prod.outlook.com (2603:10b6:805:f2::38)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 07:51:27 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::66) by SN6PR04CA0097.outlook.office365.com
 (2603:10b6:805:f2::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 07:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:51:26 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 01:51:22 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 01:51:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 01:51:22 -0600
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6137pHDh3149600;
	Tue, 3 Feb 2026 01:51:18 -0600
Message-ID: <f423267e-4324-4770-877f-78869ed6a360@ti.com>
Date: Tue, 3 Feb 2026 13:21:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/19] dmaengine: ti: k3-udma-v2: Add support for
 PKTDMA V2
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
	<vkoul@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
	<dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<vigneshr@ti.com>
CC: <r-sharma3@ti.com>, <gehariprasath@ti.com>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-17-s-adivi@ti.com>
 <bb476db0-1421-4fdd-9415-85839425f9b9@gmail.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <bb476db0-1421-4fdd-9415-85839425f9b9@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: dc854461-b732-48bd-193e-08de62f90871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnV6d1B3Mkd4YTVVQ0ViVkxLWmpzcVl3Q0VZa3R1SjA2RWFMNFBEeG1qRmkr?=
 =?utf-8?B?MU5NN2dDd2dKb215ODBpV1Izd0NSNGdxSFBia1hEcmg1MWd1UWNoQmY0QjA5?=
 =?utf-8?B?bUc5ODQ5WUcvWDdKYWIyS0VlVUhJMmg2aXhyN3hLSWVuQzJLb3BFa0IweVVY?=
 =?utf-8?B?bmVwc3c0dXRXVDdxL3RRejNVUDhRTXN5dGdvNmZBNHNNRDE4emU3d0RMdmlu?=
 =?utf-8?B?TDZpd1A2aXNWSm9GdWg2ditSYm1TRmNSTU5ERThoUDZybVVQK0hMR0tUeDh6?=
 =?utf-8?B?cGljRU1pblBlc2JPVEJwNGFWR2h2VHlqRndxVlZlOVpNaU12T1VMOG8ycFcw?=
 =?utf-8?B?Q1pMSEgwNHpCL3ozNWR0ZmloWVJQM1lidUZkVkpVUk1pa2R1YjlVMlV4Kzgv?=
 =?utf-8?B?ejkzZmljVDEzdnpjbm1Ta2R3VjdMdDRsVDEzRmdkS0ljSGdOWmFsbk5BcGln?=
 =?utf-8?B?aGEyUnlXSVpkQklZalFoUGxJMjRabFFtYzVOU0NXSS9Gc0VxTEFNQXpLeGJj?=
 =?utf-8?B?QW9DVnJnb0FvR1NQY0h3YmNLcE9ZOXQwNjFteWREQzlEc3dOZVR2Q0s1aTFJ?=
 =?utf-8?B?d0xGSEU2RFlHZVQ3R2NaN3R3Wm5mVzBnTjl5SHBaZE13NVJ6NzY0bTJWZWpI?=
 =?utf-8?B?WE1iRGU2Z202WHhqdldLWGx6b1pKUXJQK2ZmcnlzcG9SQnp4Sm4wTFl5SHpa?=
 =?utf-8?B?WExZOHZHL3hLTnI4KzBoQndna1VHYWYyV1dkcWx1dFZRRC9pRVNrRkRsQzJN?=
 =?utf-8?B?TWFTbndXdCs1NFJHTkFEa21nNEVLK0hnWVh2OXFkZkhNazh6eTBYUjhiaDNx?=
 =?utf-8?B?aStBZ2lXcDI5VXNVdjBSemlGTHlobXR5UGVwQ3FtdkpocWNBcTBaU3QvYnRh?=
 =?utf-8?B?aGltN0Fjb3NQTmVPekZ5eUJybm5NMFc2dVhPOERCSlpUTlNGMC9vNCtpbXNX?=
 =?utf-8?B?YktLMHJ0NVg3aUYwekoyTC8rL3BET0tPWFpia0RCbzNlVHJNNU1nVEV3djlV?=
 =?utf-8?B?dVN3MEJoUEluaXc4eWlnYzNVLzQ3dmlSaGhEdTVUNlZPUW9YN3NPSWNvdHQx?=
 =?utf-8?B?TjBDYUcyTER0Y29nSzdBeUZlWXh1ZHVILzJhYmRCR3Z2b0RXZU1DQ0FxbXVu?=
 =?utf-8?B?NVByUlc4Y1YvSW5SRmhNWmV6b3pnbC9WUW5FRXJzMVUyWjZRbWNHdEgvZzVw?=
 =?utf-8?B?TU1yN1BJNG9PNlhJR2pGaGhrd3AyalNkL1llY0Nidy9Qa3lYOVgxL2pCb3Y1?=
 =?utf-8?B?SkJmR01YREZuNzB6clhWNDF6Tk5MZ3llTlRqUTB3TGhlRWNuYmYveFFmQTVN?=
 =?utf-8?B?bVNGVkJwY1RGRkFwNXRPbVpLQW4vVkNzZEE2aGxTQ1FPVE05V1FOMFlha1Fn?=
 =?utf-8?B?NTlaYk1TbzdJa3ZBSlZGZkc4L2tQOUhZMy9tWXRZK3pXSnVJNkM3RFRyOTc5?=
 =?utf-8?B?WlBNQnFIbmNwNDNDS2N1ejY4V1lBMVQyL2ZUaklBcUxBWjVaeU8rR2hrN0FS?=
 =?utf-8?B?R2gwU2M5YytSVWZQbVljYWU5RnJTQ3BSZ1pvakxBUVVCSnBEZGIyeXlldWVT?=
 =?utf-8?B?WTEzZ2lMYndFOStWc2FVdUJTSjl1bzVLS3hmTlRMcGk5QTN0S2QrUWtUUUZ4?=
 =?utf-8?B?dDlXWEJocjZhVExRZll0UHVjTzZYZDcyR2lrSUcxcUJSRCtrd1BBT1gvRmYv?=
 =?utf-8?B?YmtxZXZuUktBSW9HT09Ib1EzTDJHcUM1a1JDcXlmTzBORnBDQUs5Tk1kTENy?=
 =?utf-8?B?VE05NEw5ZldvNExhZFdTQUs4aHpMSXEwRmZpTlMyQjBCOHBtMGFwb1Z5RTIr?=
 =?utf-8?B?UVhhSVc1aXJRM0pTblN0U1RyQmk0Z2lZYk03SUh2SURocGVYSm56dEFicVZS?=
 =?utf-8?B?a29xMXJ1d284WnRKOTBGSkUvdEx3RC8xSVI3blVRa2p0dEh1S253M3ViMVNM?=
 =?utf-8?B?VmpYL0ZFaXVpZ3YvZmU5M0RGeW5ZelBqRlVrR2M2M3E2QnN2aExNcnB5VjJ6?=
 =?utf-8?B?eGY2dHVaaFpXb205SXpGN2JjREdMcVd6MXJLRjk0czZscGlqa2JOeWw0TlBW?=
 =?utf-8?B?NVlidms5OHRXRzFYVzZWclJSQ091WTdSaktKbVhGK00vNC9lNUVYcC9jUlMy?=
 =?utf-8?B?Zis5M3BZeStSVDhHYzZiM29yS1pUUHlMNjhwNjlUWFBvYTFYWDB6WmswY0tI?=
 =?utf-8?B?dEk4MDJIQk1PUmZwS2V1bTVNNG9WRHlRby9ia3ZFNnJQdFFGZklSSEpPSE5S?=
 =?utf-8?B?T1JRY05OQXhlQWpzRzBPa0dwZ0x3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jdYvTrx/X/qodyfaWxYVnekjzWkosiEVTbLFWWmjq5EkCo72iofifd27quqxT5b5fz9pfeK5ez2O/SUNa+DoFP27pl3umlQh2dZNLSSIw4D6HvSxqSqpc1OGt+1XW0kuztpFE4gEXUPrh17qtKwMd4qTvpBRgPHZ0RpHTIwEDQaml87SrADDjBELR4xkfAAJItQYeAUIVULmssYKm901a6igRDDOfsdmerjV225oMmjypBQXK4dP5gXzyDuFtE4Hr2CjQhrBZFdqaThe81ppmDR71gTizlTCtzfPVZ10A5t35PA67uVDKcY2QFk7BS94pmmn0O7+znVVG1KZxqNMJbzcdt3XJd4gk8E+W87060mKtePwneAK+ozBpAAdg6ZR2uRfEVHl4ixNlbEF5oeTQPQxUjIo0aLBibYsQd2nzGjzL8gkfoLHvGnmyHflk4yO
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:51:26.0429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc854461-b732-48bd-193e-08de62f90871
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8680-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-adivi@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 27CE3D5D8C
X-Rspamd-Action: no action


On 03/02/26 11:55, Péter Ujfalusi wrote:
>
> On 30/01/2026 13:01, Sai Sree Kartheek Adivi wrote:
>> The PKTDMA V2 is different than the existing PKTDMA supported by the
>> k3-udma driver.
>>
>> The changes in PKTDMA V2 are:
>> - Autopair: There is no longer a need for PSIL pair and AUTOPAIR bit
>>    needs to set in the RT_CTL register.
>> - Static channel mapping: Each channel is mapped to a single
>>    peripheral.
>> - Direct IRQs: There is no INT-A and interrupt lines from DMA are
>>    directly connected to GIC.
>> - Remote side configuration handled by DMA. So no need to write to
>>    PEER registers to START / STOP / PAUSE / TEARDOWN.
> Plus I suppose..
>
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   drivers/dma/ti/k3-udma-common.c |  29 ++++-
>>   drivers/dma/ti/k3-udma-v2.c     | 219 ++++++++++++++++++++++++++++++--
>>   drivers/dma/ti/k3-udma.h        |   3 +
>>   3 files changed, 232 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
>> index ba0fc048234ac..d6459bcc17599 100644
>> --- a/drivers/dma/ti/k3-udma-common.c
>> +++ b/drivers/dma/ti/k3-udma-common.c
>> @@ -2461,12 +2461,21 @@ int pktdma_setup_resources(struct udma_dev *ud)
>>   
>>   	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
>>   					   sizeof(unsigned long), GFP_KERNEL);
>> +	bitmap_zero(ud->tchan_map, ud->tchan_cnt);
>>   	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
>>   				  GFP_KERNEL);
>> -	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
>> -					   sizeof(unsigned long), GFP_KERNEL);
>> -	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
>> -				  GFP_KERNEL);
>> +	if (ud->match_data->type == DMA_TYPE_PKTDMA_V2) {
>> +		ud->rchan_map = ud->tchan_map;
>> +		ud->rchans = ud->tchans;
>> +		ud->chan_map = ud->tchan_map;
>> +		ud->chans = ud->tchans;
> It has single channel space and the TX/RX functionality alternates
> within the space?
> chX: TX, chX+1: TX, chX+2: RX, chX+3: TX, etc?
Yes Peter, that is the case.
>
>> +	} else {
>> +		ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
>> +						   sizeof(unsigned long), GFP_KERNEL);
>> +		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
>> +		ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
>> +					  GFP_KERNEL);
>> +	}
> ...
>
>> diff --git a/drivers/dma/ti/k3-udma-v2.c b/drivers/dma/ti/k3-udma-v2.c
>> index af06d25fd598b..6761a079025ba 100644
>> --- a/drivers/dma/ti/k3-udma-v2.c
>> +++ b/drivers/dma/ti/k3-udma-v2.c
>> @@ -744,6 +744,146 @@ static int bcdma_v2_alloc_chan_resources(struct dma_chan *chan)
>>   	return ret;
>>   }
>>   
>> +static int pktdma_v2_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct udma_chan *uc = to_udma_chan(chan);
>> +	struct udma_dev *ud = to_udma_dev(chan->device);
>> +	u32 irq_ring_idx;
>> +	__be32 addr[2] = {0, 0};
>> +	struct of_phandle_args out_irq;
>> +	int ret;
> Nitpick: revers christmas tree declaration order.
>

