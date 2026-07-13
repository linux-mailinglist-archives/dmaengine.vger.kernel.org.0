Return-Path: <dmaengine+bounces-12410-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8l54HFMbVWoVkAAAu9opvQ
	(envelope-from <dmaengine+bounces-12410-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:07:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D0E74DDDA
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:07:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=NgvL8Aen;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12410-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12410-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8699330237E1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F91345CA1;
	Mon, 13 Jul 2026 17:04:19 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5B3451CC;
	Mon, 13 Jul 2026 17:04:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962258; cv=fail; b=R5ddRlcB811kHFjtIF/ARdL45zuWWPvpyUXBxM6vjud3p08TAS8QRQ1j1z4OVBIMZzEyYz7SgXZzn0pERMN10/gA54A9/NZsRlThTLrvsJ/CZEHE+Fs4RHOV7S8k0FxNUsym1+FFg0LKVqVOyEabAt05SoolDA08IyU7zlKcW6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962258; c=relaxed/simple;
	bh=WcasGRwXS4tGBntr8l/pZRkjKm3/6TUvGZkMIvf260M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=if26125wEFsZPdoX2HkNzFBg0su4JrN8GERdKQdKvEiCwLFoOpH5jCj7St6SSxJgUdHFFdFwun/OcloWsW/d61hcmP8xCCYaERrxLhSAZxB6W20//e0WqKupKhmb2ez4NILRMQiPWDtC6PnB81L4VzaCnFu9V4S/dW/ESCTUE3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NgvL8Aen; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO3hBbZ6guc8wjM07kFWYFV+y9hmhS6acbC+Ienkn2NY9la5Ym9EKCjTf75OffMsabuuoaDSgcuDrailsntQHsDApprOxVK5LYtxw5Cyn45E7qg4Vc6j5eBKfrFmOml20SSIwNWONSqPT2Hn+TNd4C9BGQSYj80zgO1EggduESEFxN6NyZs5cAISgumXnfHMW+G+1y159t84g0Vmv+bO9izjfpf/NpIQWoCD0OA83EOuAP7FWzTLsMJD9dVRlr9Qw06mJvr4kOx8nncQKW3M2iFU2Vp72PlziN0oXrcqz/RNKz9tqtf59OD3i6xzJyVPESfe0iSJ6J1pr+LGgJAVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVb5QdCd1+vq0mawbB2lEK3nqqNvHiB3vMQrQDBteLM=;
 b=QXFjuAa8tk3zkpxtv3cGe8RCIhrv50kf3iH0emUZ+OBVEiYFswfAy31jqXwnJyOf3j91kn9vHVFbq7yb2ZtQapUlB6DUD/SraUu3MnZV3qndKfWq5qlGuHVkTQ7SncQ+sEes6Yn53fN+njaCfttrY3IgKI8adHah8KoWDTKKKBItHGWsRAoA4xvwl8eAGOThrEJCYu2t6R7dLEClBKUN6c6HtULP2yCApGgN2LBVcK/KlBZyIs+uF7s+brIyUZuh/kA+rUhI2Tw2fE6PXtLFkpNqxtK8Siq+kkzDNQGiNGdRJVRUj6OS7371nCItFqnssZmgUgeer3HmR8enjxzt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVb5QdCd1+vq0mawbB2lEK3nqqNvHiB3vMQrQDBteLM=;
 b=NgvL8AenBTR203W2ZP0A3DeIEltscQ6ooSaq4PBEo7jyoZfhClNVneKDDvYXJ7MSuG7xizhm6JKNmWaD87eEaiPQ3cnB21lJaCT7mfAKEjf1EFQRMrLNv8Z+CEJ+Dr07don8W0KQRUqMUy9t1qs7x9yqYe+iGVImo1IwFPo3KtMy2Kc1SSB0sfHlvOKKZzkCi+uMO+AG3M9HvOD4CeR3/xxMtA+AHruk6haZM4odO5URqWfUF5OpYY60SPpBFaV6WaQ9uAsTH29/toa91zCv/MUJRNQ/5spXZ8Lx+EVMjgcYsVriQZ6NGGaITn3YBlbC/sm/5DsTIIW11jufDhdc3Q==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:04:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:04:09 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:27 -0400
Subject: [PATCH v7 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260713-edma_ll-v7-9-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=8343;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9GJ8FbtVyhi/XUXTaNKKA7UjMTGkE8Fwsbh7PswC91k=;
 b=Ktr/HPoWHGPzQ0UbG6UwUxYHWUg0l8VtvFRNmazzHOQNLjTfAuuK1Yv+3ksGBOhx5xwGssvz7
 lzczQwa4n3cBy7/UPwchICl+OJ97CWqMoOrO8Qzj/HaY3jEpiTbOT/Q
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:806:23::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: a54d84a0-1b5f-4e6f-b61c-08dee100c169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kOWId4nE0EqeA0uOFmOEBodQhIMb6vNuDYCV5KB8JH2eOVA2pz5OHKcyvpFaX6LxTFEweOiQTUaHMuE43YvZ4IFP5o10w3LW5n67LJk2yrSY4A7xNSCUmwG6sE9sTHzN3gJ1i+wrv3LJ5pITTIlGzPf3aZHPajjXxpNwkQiaUVsO13AFis9IWcbq/7t2b8MHSVrlKe++W4NO19DzWCpuD8gCEJd57afNJrINq8mVgJ0fsHn75/9+hYfyIcZuxCZ1cFsVqNr8Cm2xwJMfY60Of3tZTGu+BA/o9nUr+n9cEG0o8SfSlnS/g+bqzD3jsSmhP6lmPG/SXfEeQORVxov2EPevyXrRr6e6hNlHzK60k65FczIpivLZqd1jD6IDXhLl5q602DG9/xS0ZPwF9zL+l0q5zxhjRy6o8wb+MJs+rSidUY9XDpmH71sAbfE15eBaLIw6BWzlHJk5+eVgrI/JCr4q7liQ3HA+KEFROIdua/Jp/Q6zP9aP2F6HSXSLCkBBxXH6GbJ7NSjLWk6JKU5z2h1VlAJhzfkqfO8xyrzpd2NJyuEMyABOuyV2n7qKTEeeEeNFunwXLxdZP73R2VdFqrD85UdZLmnU07x8VyPZmdcEMf9R6+pazfuW50rQ4GE721PJIf3i6cM62vXkFj8L8bGugzobAhtphDAPbU1tbzdyz8cqG+SHdPcBk9CDGGGceRz9ba3cKihlUqKIF1Mg4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGJ4bURnOE54UGNpQ0EyRkhUVjNHaEdjR2JDT3dZL3Nscm9jM05mWTIzL0Vy?=
 =?utf-8?B?WVBSTFluRjgxNnRhbS9hOVNJblJWWXIzcFJvZ2hmZEM2QU1YcHVpQ24zWUxK?=
 =?utf-8?B?a01ub0Q1WUlPL2ZndWNod1Q3aXRzN0xhVzJzRFkrOVIzazhuZHZackx0Mlc3?=
 =?utf-8?B?QW84R0hPTjVEMGhCb0U2emdRaHRudGxBWTdpLzhYblh2ejVpRTlHUWtRQjZJ?=
 =?utf-8?B?SXBrdDJiNVFpK0FtU2JtaGlBZmhQR3FKSGs1N2F2SHk4RFhlNUxHTExjWTZn?=
 =?utf-8?B?MUZNMEl3elAxYlpYbmoyTmh4VFJlS2lpQ2xUT2VpQU1HcXB1YTJQWjRlanNm?=
 =?utf-8?B?V2IxbWd3U01IeUVuNUpwUDdIbDNIOUtLVFhyOVZKVERrNEkxZWxxSmhyKzJi?=
 =?utf-8?B?Rlp1cE9IbzFDUEJSVFFNZjNkemRMQWxxWWlEWTl1S1NPb0wrcSt3REtHc01Q?=
 =?utf-8?B?eTF5dElUVjlxd1ZpakJvRUNqV1NCWFVkaklsODFadXRHRnlRa0RmYVZtNk9C?=
 =?utf-8?B?aXdrM3VWS2VEbmpCOEQvbXcrYm5sNi9BNDZVekQwR3ZtNTAvZG9ZVDVBUmRU?=
 =?utf-8?B?UVdZV1BzOXJWaGsvdVhDb1JUUTJBUDJySmc2ZU8wSHdpeElxNW8wMWExcE5P?=
 =?utf-8?B?dGY0VE54d0ZWNldLOUh1MGU5U3c2UEdmVXFCNXp4YXJnTlNHRTAvL1hKY21P?=
 =?utf-8?B?RWF2SFVTOU5pNGpFaVR4UlNKbDZTdHNQMHloa3hlamtiN0tSZFlnaHhRMUZT?=
 =?utf-8?B?eGxWRXBENUhnM1hxSlYxc2FBbExJMGZXOEF6eFMwWEJpdFBhbEdoT1JXb2c0?=
 =?utf-8?B?SFdUWVNyZm1VNjl6SUdGS2hxaUY2K0NaRjhKZjR0UHJ6RVBzOWN0T2ROcGpY?=
 =?utf-8?B?eU1iMHEvSTg2NE1tS1FSQzRzWFJlSnBzMXYxbEROSmZTS3BFeHJxeVc2TmNR?=
 =?utf-8?B?Y29TVGhJRjRFKzRORzhFc3hrUUdad0JzQ2FaNCtxY2JZSVdCUVNoVTF6ZVJV?=
 =?utf-8?B?U3pCQ05WSHFGVDBwbUZGemtzelkyUzNMeE1JcXJ5QitLRDEyVEsrdVV1MTZX?=
 =?utf-8?B?a2tYa0t6ZnZQeUtOZzlhYzNrNWpvMGsyVGxabWhWdzZmSHgwV1pJTmdCK2Ez?=
 =?utf-8?B?VUlmNWJvVUdOM3l6MFNQcUpzc09TQjFrMTZUUFBONkNZQkVYdjMvNWh2V0pY?=
 =?utf-8?B?cWV3M2RxYi9PRGZiSmgrcjg4dlVGclk4M2MxdjlSdVZ3ZjZucFlMeUtySm9a?=
 =?utf-8?B?S3E3YURublpPYlVBT2lXcExvcW01QnEyQWI5MlB3d0hwQUdhTFpic1RNVDlj?=
 =?utf-8?B?WlBETDZQRGxKMk8ycC9aUE02eDFNRlpTWlVtSGY4WjRzRkYvMUNTTlBkYk9E?=
 =?utf-8?B?dmVQMlNIYndXN3pDcmJ4MnZjd0I5aklwNEtISUJKSDBPVDBuRkoxcWd4ckp5?=
 =?utf-8?B?UlZyZEIxWEFMNjZQMWdYYTVWK2ZHZXUvQi9ZdjMvaVNQTnk0OFdDNEM3elhq?=
 =?utf-8?B?YTZsT3Z3K2EwL1FHVzErS2YrKzRXSzlSNTJ3d043bm9Ka2tDS1NkM3ZNSjBO?=
 =?utf-8?B?WHdKZnFPQVZ6ZDcvU0k4dnJCTUZ0QnN2c1ZydkpHMW5FRXZsUlVCVU1OQzZu?=
 =?utf-8?B?TGRQWmVyaERVRkVNSU9za3hpL3oyY0N4QUZOdkV0OVlTZ1BUeHhPa3cwQWxu?=
 =?utf-8?B?ZDgvb2plcnFQdWI1cWNMbXNXWVcwR2hQOWQ1anRvY0JEWFE3cHJxaUR4WkRM?=
 =?utf-8?B?ZXJYYTErdjNNaGV4ME1pVmUrQlhhN09pY0dKcXViOFlxVzd1UFpOUVQvekVw?=
 =?utf-8?B?L0UrcGRjS3poZCtYSER2MzVzREZ0YmFnRlZGWkxVZEd6dVduNjNPSzF2Yk5W?=
 =?utf-8?B?T2tsWXpVQkhxVEluMmRXNWRPNTZhWUpvMzZINk9jTC8zeWV4U2NFTktFZGo1?=
 =?utf-8?B?MXBNWDlWV2pvUEhHV2pFbm0wUk1jS1h6TnhlWGNOWDBuOUVkT3pDN2d2MlNB?=
 =?utf-8?B?MkJnL0MxMy9PbDYwNHZ6MHVnK2FjMk9Ib01uNG9rcGZyWUdrOVJWRllGNXU1?=
 =?utf-8?B?YUJ5VjBDZVhrUXpFVVJBUHlPNVE0WndzQ2MrbEV4T1czNlVnVGFzMTRLWEZq?=
 =?utf-8?B?R09idzVMNGxueTE5NjZNWVVPQ2hObzM5eU5VQ3JDaUM3TDVrSlVQM3ZNcmpJ?=
 =?utf-8?B?WDlQaTdXanZxNTRSNWhIY1NyUVF6cHNzSi85NUVuQ2oydUZDS3dWRDJzVDVn?=
 =?utf-8?B?ZFo0VXNtZmJpcW9VcTVYTTNaK0JiLzZ1VjJ4U0hzdnIvK1lKK2NldjhsKzR6?=
 =?utf-8?B?bjN0YUp6RjlvVi9YWWZoQUJVNVF0TjY2VjBVK1huTS9JdWlzakVkZDFzRWtQ?=
 =?utf-8?Q?NaUM6ST/YwIBPe83bfWLMcYQELonmj8yD6kh8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54d84a0-1b5f-4e6f-b61c-08dee100c169
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:04:09.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0apEUcGXxuxvp8jeaI72RjUlU2Sf0cESWUrUyss2+Yd8qkkBB3dSpfaNH4xcROa35d0d+zKd2jWlrYtiFTbTNnGwbCXLnaPtbDRAdPFrzy6KLFNndFDHp7VF3WJG6JGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12410-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,NXP1.onmicrosoft.com:dkim,amd.com:email,nxp.com:email,nxp.com:mid,oss.nxp.com:from_mime,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68D0E74DDDA

From: Frank Li <Frank.Li@nxp.com>

The current descriptor layout is:

  struct dw_edma_desc *desc
   └─ chunk list
        └─ burst list

Creating a DMA descriptor requires at least three kzalloc() calls because
each burst is allocated as a linked-list node. Since the number of bursts
is already known when the descriptor is created, a linked list is not
necessary.

Allocate a burst array when creating each chunk to simplify the code and
eliminate one kzalloc() call.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change in v7
- One more place, use bursts_max instead of chan->ll_max because non-ll
mode only allow 1 burst pre-transfer. Found by sashiko AI.

change in v6
- use bursts_max instead of chan->ll_max because non-ll mode only allow
1 burst pre-transfer. Found by sashiko AI.

change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 120 +++++++------------------------------
 drivers/dma/dw-edma/dw-edma-core.h |   9 +--
 2 files changed, 26 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f52d9fd18e573..c028011cc61ca 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -40,38 +40,15 @@ u64 dw_edma_get_pci_address(struct dw_edma_chan *chan, phys_addr_t cpu_addr)
 	return cpu_addr;
 }
 
-static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *burst;
-
-	burst = kzalloc_obj(*burst, GFP_NOWAIT);
-	if (unlikely(!burst))
-		return NULL;
-
-	INIT_LIST_HEAD(&burst->list);
-	if (chunk->burst) {
-		/* Create and add new element into the linked list */
-		chunk->bursts_alloc++;
-		list_add_tail(&burst->list, &chunk->burst->list);
-	} else {
-		/* List head */
-		chunk->bursts_alloc = 0;
-		chunk->burst = burst;
-	}
-
-	return burst;
-}
-
-static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
+static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc, u32 nburst)
 {
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
-	chunk = kzalloc_obj(*chunk, GFP_NOWAIT);
+	chunk = kzalloc_flex(*chunk, burst, nburst, GFP_NOWAIT);
 	if (unlikely(!chunk))
 		return NULL;
 
-	INIT_LIST_HEAD(&chunk->list);
 	chunk->chan = chan;
 	/* Toggling change bit (CB) in each chunk, this is a mechanism to
 	 * inform the eDMA HW block that this is a new linked list ready
@@ -81,20 +58,10 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
 
-	if (desc->chunk) {
-		/* Create and add new element into the linked list */
-		if (!dw_edma_alloc_burst(chunk)) {
-			kfree(chunk);
-			return NULL;
-		}
-		desc->chunks_alloc++;
-		list_add_tail(&chunk->list, &desc->chunk->list);
-	} else {
-		/* List head */
-		chunk->burst = NULL;
-		desc->chunks_alloc = 0;
-		desc->chunk = chunk;
-	}
+	chunk->nburst = nburst;
+
+	list_add_tail(&chunk->list, &desc->chunk_list);
+	desc->chunks_alloc++;
 
 	return chunk;
 }
@@ -108,53 +75,23 @@ static struct dw_edma_desc *dw_edma_alloc_desc(struct dw_edma_chan *chan)
 		return NULL;
 
 	desc->chan = chan;
-	if (!dw_edma_alloc_chunk(desc)) {
-		kfree(desc);
-		return NULL;
-	}
 
-	return desc;
-}
+	INIT_LIST_HEAD(&desc->chunk_list);
 
-static void dw_edma_free_burst(struct dw_edma_chunk *chunk)
-{
-	struct dw_edma_burst *child, *_next;
-
-	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &chunk->burst->list, list) {
-		list_del(&child->list);
-		kfree(child);
-		chunk->bursts_alloc--;
-	}
-
-	/* Remove the list head */
-	kfree(child);
-	chunk->burst = NULL;
+	return desc;
 }
 
-static void dw_edma_free_chunk(struct dw_edma_desc *desc)
+static void dw_edma_free_desc(struct dw_edma_desc *desc)
 {
 	struct dw_edma_chunk *child, *_next;
 
-	if (!desc->chunk)
-		return;
-
 	/* Remove all the list elements */
-	list_for_each_entry_safe(child, _next, &desc->chunk->list, list) {
-		dw_edma_free_burst(child);
+	list_for_each_entry_safe(child, _next, &desc->chunk_list, list) {
 		list_del(&child->list);
 		kfree(child);
 		desc->chunks_alloc--;
 	}
 
-	/* Remove the list head */
-	kfree(child);
-	desc->chunk = NULL;
-}
-
-static void dw_edma_free_desc(struct dw_edma_desc *desc)
-{
-	dw_edma_free_chunk(desc);
 	kfree(desc);
 }
 
@@ -166,23 +103,17 @@ static void vchan_free_desc(struct virt_dma_desc *vdesc)
 static void dw_edma_core_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
-	struct dw_edma_burst *child;
 	u32 i = 0;
-	int j;
 
 	if (chan->non_ll) {
-		child = list_first_entry_or_null(&chunk->burst->list,
-						 struct dw_edma_burst, list);
-		if (child)
-			chan->dw->core->non_ll_start(chunk->chan, child);
+		if (chunk->nburst == 1)
+			chan->dw->core->non_ll_start(chunk->chan, &chunk->burst[0]);
 		return;
 	}
 
-	j = chunk->bursts_alloc;
-	list_for_each_entry(child, &chunk->burst->list, list) {
-		j--;
-		dw_edma_core_ll_data(chan, child, i++, chunk->cb, !j);
-	}
+	for (i = 0; i < chunk->nburst; i++)
+		dw_edma_core_ll_data(chan, &chunk->burst[i], i, chunk->cb,
+				     i == chunk->nburst - 1);
 
 	dw_edma_core_ll_link(chan, i, chunk->cb, chan->ll_region.paddr);
 
@@ -206,14 +137,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
-	child = list_first_entry_or_null(&desc->chunk->list,
+	child = list_first_entry_or_null(&desc->chunk_list,
 					 struct dw_edma_chunk, list);
 	if (!child)
 		return 0;
 
 	dw_edma_core_start(child, !desc->xfer_sz);
 	desc->xfer_sz += child->xfer_sz;
-	dw_edma_free_burst(child);
 	list_del(&child->list);
 	kfree(child);
 	desc->chunks_alloc--;
@@ -425,14 +355,14 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
 	enum dma_transfer_direction dir = xfer->direction;
 	struct scatterlist *sg = NULL;
-	struct dw_edma_chunk *chunk;
+	struct dw_edma_chunk *chunk = NULL;
 	struct dw_edma_burst *burst;
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
 	u32 bursts_max;
 	u32 cnt = 0;
-	int i;
+	u32 i;
 
 	if (!chan->configured)
 		return NULL;
@@ -499,10 +429,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 	if (unlikely(!desc))
 		goto err_alloc;
 
-	chunk = dw_edma_alloc_chunk(desc);
-	if (unlikely(!chunk))
-		goto err_alloc;
-
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
@@ -530,15 +456,15 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer,
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == bursts_max) {
-			chunk = dw_edma_alloc_chunk(desc);
+		if (!(i % bursts_max)) {
+			u32 n = min(cnt - i, bursts_max);
+
+			chunk = dw_edma_alloc_chunk(desc, n);
 			if (unlikely(!chunk))
 				goto err_alloc;
 		}
 
-		burst = dw_edma_alloc_burst(chunk);
-		if (unlikely(!burst))
-			goto err_alloc;
+		burst = chunk->burst + (i % bursts_max);
 
 		if (xfer->type == EDMA_XFER_CYCLIC)
 			burst->sz = xfer->xfer.cyclic.len;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 27415f3a2d04b..4950c57fca34f 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -43,7 +43,6 @@ struct dw_edma_chan;
 struct dw_edma_chunk;
 
 struct dw_edma_burst {
-	struct list_head		list;
 	u64				sar;
 	u64				dar;
 	u32				sz;
@@ -52,18 +51,16 @@ struct dw_edma_burst {
 struct dw_edma_chunk {
 	struct list_head		list;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_burst		*burst;
-
-	u32				bursts_alloc;
-
 	u8				cb;
 	u32				xfer_sz;
+	u32                             nburst;
+	struct dw_edma_burst            burst[] __counted_by(nburst);
 };
 
 struct dw_edma_desc {
 	struct virt_dma_desc		vd;
 	struct dw_edma_chan		*chan;
-	struct dw_edma_chunk		*chunk;
+	struct list_head		chunk_list;
 
 	u32				chunks_alloc;
 

-- 
2.43.0


