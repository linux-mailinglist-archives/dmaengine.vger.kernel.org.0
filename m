Return-Path: <dmaengine+bounces-12135-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I17VBWuZTmowQQIAu9opvQ
	(envelope-from <dmaengine+bounces-12135-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:39:39 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC772998D
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 20:39:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=q8KHEI0Q;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12135-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12135-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D12A330A3329
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E12F4D90A0;
	Wed,  8 Jul 2026 18:35:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EEE4D8D9C;
	Wed,  8 Jul 2026 18:35:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535758; cv=fail; b=NBtp2F4IpYVnmy3aICvo5OKke+lCqeYAPhJXrgQsBhLrK7dLdW66nb5tA5oAwAVn4XG+mqjxveIOxAaKLAtkCqYEzgXOYajt/3NtU8eB0cZACLMgGYKLZ6hBkiRNmRk8yEjLkTdk9TCv/3IIhsa4fhehxVLTAebIuJseL5bY69I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535758; c=relaxed/simple;
	bh=xVhlwJbRwUhGf8e0Dio4Nvw0DYyz7mMtCcMyh28PDsg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Qq9z0wAtP7LSTCPR5GA7DH/4KQ+XmDBaxC+7OIEv1Y55urzxiqOPS1k2azqexDJB4pXGb9rI//tuX1JAbf0NxU7PKbz58NHFxfqy/WigclxWkykI+s7+juJxxOC1rlZMLEqFdfydYpp+AhLKJ+87/HROy2CZSmiTgW4C4Pgg/w4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q8KHEI0Q; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3PRwgkg8AcsUjtwK1MGs98Atak7dCi2Xw3MAxgQI1Tn7yg5YlivshAkAlI6Z9b4c3iS6AqcdyPJkcz+Yp99L6znehv5Xqs6Xz7m8RXR5OzVaWuuC1kdpR/781cQqqtsrvwuh68vnBCxcUTVjoBSI1SO0OQ8kjP+/t2DqSrVCCDBHqAe59KcAtIZHTdCcjei5bx2EK1L/BpBQI4xoZ7erMkJW8rWVe9PINCA383+1O8Wn0asOlOTb9wFmy2EPNeowxN+Bwq9RDmuX+X1lBXzQiUoyHhl2Y0lTT0vxKLHi79U5jigCun2rVA9BXtGroQFMGrW+I2q8qwFFGWO2Np3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IBzu0YizHu4ieCAx5ptGgFcvIylz1CC5Qo7MwGDL7g=;
 b=QhN4PprE7Z1mUHAGtu/r8XF9zwKM/iv9tLJU1zuEj7pLO7yDVVIGTw1ZFEtV7LmM1HX7AhQviyUbEEyADnFRbICw1z5v4kp8W0PT3OFemC3m8ynIGjPeMjplYvcZYqYPCBpeATDiNsVE57qBAJnRg4LmpQHMKrSJEP7e/+OQ4f6yOiTuT7bu9uo020Ip6pUsTnwtYRgtgzHMnDXrjPMSN1YpYI4c9FSiPe+nv60Wii95R4pggE0o46VRpXGXYhqH9JZvmWmb09hWQzXs27exFkDhGlkix/6Ub5ILrtQ0fd88EwrwcqL6Z8dXQxZ/nob0jG31t+xuBwNQkSWse//Ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IBzu0YizHu4ieCAx5ptGgFcvIylz1CC5Qo7MwGDL7g=;
 b=q8KHEI0QhoTTWReiuo1wcTei//+AnovdrRfakty0DpyyqBLf1WZ9SnG6k9zjZoFVUHcYZthPvi2A/TSkzaS9Z3wrk67mvyW9ioTKDgm+iUgq1mvEDSr9JfdIM0dWi1mYna0wB4YVcrnzbD5FrQJfroNJNXOtiX9OPfOwxVW06kaB4LZL9Eu6rPoWnJetguGwfeIeRBPE6O6v0QAdCxxqhhhUYHPTLnR0KxLbMKyzMMhCgs8L/xGvllolQyd1gurj3SHz98xG7tpjM7YkxSxCZJf9Gq4kBi/U3UwnG4OHrElH8+1b7EdVBo6Ul8ZNtRzewJ+aRWuKwN+fJI420Wc8hw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 18:35:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 8 Jul 2026
 18:35:53 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 08 Jul 2026 14:35:09 -0400
Subject: [PATCH v4 09/10] dmaengine: dw-edma: Use burst array instead of
 linked list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-edma_ll-v4-9-cc128f0afb61@nxp.com>
References: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
In-Reply-To: <20260708-edma_ll-v4-0-cc128f0afb61@nxp.com>
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
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783535707; l=8015;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fvdFCwUx61ZpT1ZZozWHeW4fTH43wYc3zVYFhM+WSTE=;
 b=ozYqzQ8zpyS+MDjTmQTZyXlkjRk0IMWfhWXKJ20cDcCe2uWhajVCqbYGn6IT4DE7w86RQ4HwT
 Fj8Io3lwU6HBjM21577zouQz9DjNhAU78BpwT4JYMn1bBZlVVkfzSge
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::30) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: d05da47f-7883-4144-cfc1-08dedd1fbde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|19092799006|376014|1800799024|23010399003|56012099006|22082099003|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	rNmcriXnBAu+k+5Nur4bVPmks0rthUvM1Ihj0r9VZBljZ9TJVPS/S549HUS9Zt6uHiV/jK4XFMIsAz2TODYy4D1Nh6zo3z8P0DP49IK2H05BN65zuFs3KklY4CXRHfgx5Ro9xPXz+LBAIyeI0c8fVerhiyi3EnF6l3oadlvQr/Ab8bcVAbdm18O+vjZOp0sK55J1Aa+kZdqvmHOy6Cqvc9hsRBt1RuTqE3ez0IlCNRkXmozrMmJpRsptz79am4hzE2GLuggUTf0mSPRoar+1J2FFEHujEE/x79c63YjJ5ef0E6/4qBbuFVGIDeIYmOkkayZ1u0goz0u/y6b3dwELI6Fhj4JXe8hLqALuoVAmAMpWuk4VUiT+8WT+ICkRoJ+l/vf+PiF9ld02DSK/rgkuGVobO1Wq79gCRA6KHA5blOHLUUipBvoI5XBjSEI8S7IxcSTyk1edkX0lNUIp5JypEqWXiStzzf628tDP/ACBZ0uigbMsis+svB3BrOMcbbHhkfcLMAFBHoxkY3J3/7MaIENU039nlNooQZSzhYrQCVWhczjmlLq0VxXPbg6HKv9RTZVXPFOhYSAM5OQNJNwH8r7+X8vfOc7SkuWlO3UmBVboCt0kgcc4KW5lTbAHz8Xg/tltYo1vFn3EFjZHuG8DgnWgPg19idiX6zRalEwLfSApFENWlV9EeiWrmkT2WyzN68mtrXD4p87cDuIi9MJxvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(376014)(1800799024)(23010399003)(56012099006)(22082099003)(11063799006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnFuTUJzVjVVM0NSbjZZd2FtN0RQU0NWS3lHUkxPbUswSEhTbjhsTFlQYkxH?=
 =?utf-8?B?OFNQQUhNS1QwbGkzWkhHbEVYelNEYkFCVU44UmNITzhUbFFCZXZ5eFlvaUtG?=
 =?utf-8?B?UEZ1aFVQVnBnMHZ2MWJBVUNoeG5DMFdEK3lDaFNMcExQN3RLUzlLK2dKa25T?=
 =?utf-8?B?T2srK0lKT0t3Tk1IQjBla1JiaHd4amY4bTQzN3ZOczN1dWlZbFQ5dkM5cWl4?=
 =?utf-8?B?akgzUWhKV01IbEEvMTZEKyt2ZFpQUlBVRkQxbEg4MFAwcnNJRWlqdExrZHR4?=
 =?utf-8?B?V0pKVlZXMUE1WExmMjlFUEJhVUVWeVZISlpvb0hZWHZuOG5QRXFRd0RwNE5u?=
 =?utf-8?B?WXJ1RXdTUW03R25oMk1TTmtHZ0tjcTh3STU5SmQ1KzhXYU9ON0dtMnJXei9C?=
 =?utf-8?B?NFdJV0UvcWNqOFAwdHVFeDRlR3JHbjhIeUhWYVE5Y1IvSHdtNnpXeHlsa3dw?=
 =?utf-8?B?VmJjcmtLRGhXb25hQTBLL3NtbUgxbEFuaFV5c0ZYVEZXZENvNTJpNkwzazJa?=
 =?utf-8?B?SGNBL0dpa0dWaFo4R2M3ZHdpcm9nRGpoNjRWV2FIU2FQeFhNMmU1Zk5nK0xO?=
 =?utf-8?B?RWowSFlTQ1FtcEtaNG5weklDd291NDhoMTNRY243MTFKQ3RXMDBJOEtBZFJI?=
 =?utf-8?B?Q3l0Sk1KSVgrTXZEMm1MZU9zQStJQTMvREZuVmNYN2RKTEcwWXRtb1UrTW9y?=
 =?utf-8?B?a1lpWGU3QlNicEdrb0xteWdENVpCazB0MExydE14ajB0S21RajVBSVlGdExa?=
 =?utf-8?B?QkJmVU1PNmRxZXVBSU43SHluRlNOQ1FiS3h5VERwMFJVSGN1eHJtZkI2ei9J?=
 =?utf-8?B?SC8yYlNLNXBNaVlBa1NWeGlXUEtWTW9UUS9LNVJZd0M5REtXVnpnVmZKNTM5?=
 =?utf-8?B?c2daYUQwQVpJVlBHNjNvVE9HdVMrUVBYUUxvUHFwbktjVmJ4eVBaVHN6aVla?=
 =?utf-8?B?UGR5MnFUNWh1MGlBd0V0T29zT25sOVljYjcvb2g0UjA2L1c1NEdITGwrdmF0?=
 =?utf-8?B?RS9sbktLTVFuN3k2a0VYQ3NxKzNRQXRhcmtQWlFJc3ZDblJ1bE93YlVEQjV2?=
 =?utf-8?B?Q21HcnVZUlJLQ1puNnF6YXJnQ2swQ2l0LzhaQlFmR05jSWFONGRuVDVzODBW?=
 =?utf-8?B?emJhdFdaWDZPMldWTmRPeWdpS2Z1VFlodFl6Q3BNRC9XT2VZaHgwcVVrSXha?=
 =?utf-8?B?S1BXb0g0dGI3RnA2dGM0ZS9MT1V5bVMrYjdMdTFwcFN0R1YrUkpHQjFOeTRH?=
 =?utf-8?B?ZWRXcitSdFZvZWhlazhoNHMzcE8rbmcvUkloclAyQzE0anpkUnZ3K1A1RE42?=
 =?utf-8?B?b25qUmZzcmZkbnJRaURYaSsvWG41QWNFeXE5WWlUZThLS3dGOUNVdVo3ckUw?=
 =?utf-8?B?bmFQSVJYVlU0REpWMWZUYmpaTjNlS3dKRGhvSVZaQURKc2ZXUEdqMXlPTjAv?=
 =?utf-8?B?Yk4zWXJLYm9JNmIvSjFKUy9HOUhlM1VmdU9pZ05zaXh6MlEwLzNKc3JJY3ZX?=
 =?utf-8?B?ZGMwbzRVeXZhdnJZZEpJMWxuUHBTU1kzK2JLUDduMjIxQmdLVCt5ajJsOGxm?=
 =?utf-8?B?Sy9sSG5yR0FqQUEraWJXVmZibGI3VnVZeXhFaGYxUld1VzNqRG9DV2crRURn?=
 =?utf-8?B?c1Nqd2JHM2NCelp3a1pIajZBTXB0UlhuODQ1RnA4MXFLM1lGUUJXSzVkY0x3?=
 =?utf-8?B?VFhZSWFkcFhtZTg5Zm9pZGxwSlpFVDgzeUlMUCtjOEtLMmVQZEZHRStMQ3Ux?=
 =?utf-8?B?VGRYazVkeHp0UEZ4b1RDRUhsV2ZaSHZJaXM4VWFiT3JYT1IyUkhYbHVUQ2Iy?=
 =?utf-8?B?T2VhbU1kdzdOUjhMaTBpSFdZNC9zL2xnNXpROWRzdjVwNFY4dllWQjREcjhu?=
 =?utf-8?B?aEd4ZURpMG00QWc3dVd5Z1BGN1RSajVrY2FVMDVIRnFqS1NPbVFERXR0SUhl?=
 =?utf-8?B?eDQrVGdFMmRCV1E3bjU1NlVFZXVuWmg2aGZYaDlBSzNhS1pPRFFGMWZ1QStZ?=
 =?utf-8?B?Yy9uMXdac0pvcnFBNXBOOXV3dXV6SEgza3dnVUhlcDdEY1VRaW5qdjBWQWhX?=
 =?utf-8?B?cDA3ZWhLaGFwZUt0ZVdicDNMeFJsNmlNMzNBQ2ZzRzhHOVVMMTBnckw1UUV4?=
 =?utf-8?B?ZmNKRWlFcXg2Tmo3ZTNrNWJnZUJRdDdiQWo2RmVQN1Z3RFlCRkdHbjAxWkh2?=
 =?utf-8?B?ZFQyakVhMDBjMERhMmp4aGxuNUZxYklTWkpDZjJlVmRZYnB5azBpK3g3TlFo?=
 =?utf-8?B?M1E0WVhla2tINDVEOXB4YU5PSzZhWGZqQm4ydVY1ZzdnK21Ucm5BL1VLblVm?=
 =?utf-8?B?dzdFRjVoejNiQTdzd3FtYXowL3R3MlNHb3Z2b0wxOUVNWWVhZ2pHTjNtMG42?=
 =?utf-8?Q?0jxzUI+lLUFjHYxjOpHp4fTBGKAQZplt/0xgg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05da47f-7883-4144-cfc1-08dedd1fbde4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 18:35:53.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWJouPUg3oZvDhrWA7gpUZHdXCp0jfiNlx+WbjXAvyTB3q7q2fdIF90QWrMUH9kx6XvmeKSPuNJ3kpYtJXE3OVdhpFlwr9mg844EszuxbUUm+HC1JWRD9DXY3eNLdIcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12135-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,valinux.co.jp:email,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,nxp.com:mid,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75FC772998D

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
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c | 120 +++++++------------------------------
 drivers/dma/dw-edma/dw-edma-core.h |   9 +--
 2 files changed, 26 insertions(+), 103 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index f52d9fd18e573..01bee22fe3b3e 100644
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
+		if (!(i % chan->ll_max)) {
+			u32 n = min(cnt - i, chan->ll_max);
+
+			chunk = dw_edma_alloc_chunk(desc, n);
 			if (unlikely(!chunk))
 				goto err_alloc;
 		}
 
-		burst = dw_edma_alloc_burst(chunk);
-		if (unlikely(!burst))
-			goto err_alloc;
+		burst = chunk->burst + (i % chan->ll_max);
 
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


