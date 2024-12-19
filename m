Return-Path: <dmaengine+bounces-4042-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2888F9F798C
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 11:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB58C188E5C9
	for <lists+dmaengine@lfdr.de>; Thu, 19 Dec 2024 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C29223C7B;
	Thu, 19 Dec 2024 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="awxLHmNb"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD2222371D;
	Thu, 19 Dec 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603893; cv=fail; b=g2A/SfYL2yPFVHdelZpUcSRdg76DNhESGf27u3WqSNALcE6lHUzCshAIexS27oFHKN1VzKeAQLe/flpKpLbaiMg6aPy1d4m+QMUjzENyZrCdXxjX4ucsFpf/rc49wwwqr2ypBEk4fYYMyBWUNVhnYKlOaZTaRt7Ec/KswLEUBgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603893; c=relaxed/simple;
	bh=+EQjfRbS6pUksXCoo1RLf9J4Wu9HOahBDCktosA7hy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdnmI/6l1dq65PbKUxhyRF1Vg0IGnF7ng9JZUIe4awOB2Obn4uVAdBmf2aZL/dH5HW8tVtRclHSRYyTSdbCfWrusHUpmKc2PywrGhnpzwX8bJksziTQoNd5NZIckTFh6e6L4uiHMSjzJr+wgwkR0hE6xRUwpur2TF2xlEZL5ZWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=awxLHmNb; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYNhHNBEHULSZ8okSKEjebAClsgRuNfm/cskwgji6u6j0s7kWu0yvxOXRJX49/FoeowskZ4BQb9NtwqbUnhzmZ0P/OTKtGXGu3YfDBURosOvzPyVKt4Ph/ayZzvTWelnjBcQNjcN8VRwNmmI2kmoHySI/MMtDGQq1dDyqXfuJzFyy6Xzl2GbQJ4P8xiIp3qXZIMdWoTQofLMRIB+RnK3rrWHMLMi/uou4VKWFz0Hsex25TEt1/D+/xVoh37RsLoXCoK1wec1yiHrXnRFnIUOywrzRcA2G8r8q0VAmV467K9GAIIMCY/2I45FPafVSSZ2SkyTmvtaA0PDsr4nZowHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfq1ciCyrr52NINz2DKlSeJUJzmw6YcZSgtL8D3O6LI=;
 b=IBWFVVgfx0z1OAE4Y/O7gAiRvShb+ZjssBfjiweuGH+cK13Zddu5PGfytb9FRTJVtxbJN0JCshpibbNXKftNbp3181VNlG9G1C3rcYhs5pFlsAkKo0IFH1Uw/px/LXNWALTmWmNYCETUSOlWh7vgCaAoUpx+EfcHb4BTsC26ZyDKqpebNzrWfYOB29nWQM85LPmrAjnfeREyHS3Wo1TrrzB6RHiGMhiuY9xjrYzfFeAkVqJ503VMEb/8NKKtFn4HSOjF+g/Vs7zAMvgyXKeRPgxk/A/MuO5EyirB+Cqvs7ESdUPMcKvIBdAdD/z9LrYb9Z+ncgfQXs5ZNAVn7AAgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfq1ciCyrr52NINz2DKlSeJUJzmw6YcZSgtL8D3O6LI=;
 b=awxLHmNb1CO3zIJVch//lBv02mxoQ/oJcgrE6Aq2a43/6i/H5nelR01rSvk0yrf1wZJO7s903ZT+aWuoz+QQuRDQXPYE0qOiFAl7g+2Rp8Sc4/3R5wwUjr0V+LhQnlaiKZGpx1L9Y20PzPEYnD8yDvUtZQetJ3PYl1YQD00lprPjqcdU6sYEr/A3NS2A7WvxMDyXUt3VNAvRjrgzle/iwZd3WViyUYvU13/IOLVmKQ7zsmWbzoRO57ooIRQTQZUoi8V5ZtW+6dLegnJLEbfgidn508yRQ5NQL6/0Pu/+INSsDqCxfbBU/JDeOGSenZI8z2dZ8wcWvShZvJqBiGH8AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:24:47 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 10:24:47 +0000
From: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Subject: [PATCH v3 5/5] dmaengine: fsl-edma: read/write multiple registers in cyclic transactions
Date: Thu, 19 Dec 2024 12:24:14 +0200
Message-ID: <20241219102415.1208328-6-larisa.grigore@oss.nxp.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
References: <20241219102415.1208328-1-larisa.grigore@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|GV1PR04MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c63b1b0-21a7-42a2-cdb5-08dd20175ccc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkUxUm9BZ0NUMEc3K0ZQNE9kQ1AveTJMam5MQ1Z6cEpGM2x2TGhCUVZKejha?=
 =?utf-8?B?M3A5ZFNCYldFU25sSG1nWFhGNnNXT01QSFVMV0dwcGhPZk53RUtXWUZrQm9h?=
 =?utf-8?B?TUR3WHdYUE5PTHBoRFVvWHE4U3JaVzNQeERHcUJ3a1dWMTBlNjIvbVgrVmhh?=
 =?utf-8?B?djJpZEgrY0hjM3RzOXIxc0lxT2g2aVpMWEErc0NvcUhyU2JQR1FpR2dlRTlX?=
 =?utf-8?B?TDEwVGhQV0I1Y2l3L2NVSkp1NGU3b3NmZjVzQnlWdW9XU2xhVDZFM0UyZGFV?=
 =?utf-8?B?ZVhuSVMzZW5SV0kwazM4cDUrMXdZb2xVQXg2SStoZXhFSlNvaGcvQVVpRHI3?=
 =?utf-8?B?aDBPQnNUOVVEcWRkbmE5YjYvdGIydGQ2ekFLNUd6K2l2YzRTWEZldmRpTSts?=
 =?utf-8?B?SWlBSllOcVJXVkFRQURsaXllOEUzMUoxQXhDWnZsTjZzWFpMVFlFQnhGOW1X?=
 =?utf-8?B?MFF6T201ZkZNSHFpS0hkMXJ6dGVrTHc1emgyQ1F6T3YwT2ZKeUdSSm9KUDM3?=
 =?utf-8?B?L2tJT1VkWVI3R2NsRTJxSFlOKzRDSmVxd3VSQ0JMa3A2YXFMVXJ6K09hSVht?=
 =?utf-8?B?VzdsMGx0QW0wWTNsbzdaaStpa2lONi9UUk1mZVZQRGg1aWJuQVVtN0s5VFJ2?=
 =?utf-8?B?M3AvRjRDbmVJY0JPampOWjdPZzZhSWtHNWEvTjZJdkRmTFBRcjY4aWprOTFv?=
 =?utf-8?B?b3RqYVJFMWxvT0RZdTkrU1VvNEgyckpLZWE3YVFHWm42cm5kekJQQUg0eEN3?=
 =?utf-8?B?ZGlQbFVmUXhheFV1MUpSb21zaC82UlZXdjI5bTVIbS90YWRLV0FkNnZCR05L?=
 =?utf-8?B?VTU1QU1SQW5uMnRCMHdYT3IwQmgzTUhKRDZhY3hhSHFwbjJRL1YxZm16RFJL?=
 =?utf-8?B?RnI4OTBBNEEzSFhWajBDbXJRSk5nTk1HWGt6RU9MeHNVYjl4WktBbWVPYnd5?=
 =?utf-8?B?L2xGREVyNDJnY0dpeDRqeDh4SHB0aFROejVDTjFEN1NGTktGZE9TSmJ5RlFv?=
 =?utf-8?B?U1ZrbG1QYUQ5Z0szVXZQaFV0eHkrdlZHT0kzUzQ2UTZ3cEk0Z21kSTdvVFVs?=
 =?utf-8?B?bTcwYmRwRHpuTzA4MUdLRkdHUmZaNFZ6V0hEZGhCbXFFckxEd1hMbGFqU05E?=
 =?utf-8?B?N3orNlNFZHBOWWVZY0hZMTAzVGVyaUNLcUQ5YnozVElKRzNXOXp6YnVodmlI?=
 =?utf-8?B?bzJSQksrdEhvWlM2cjF4SXNUcFprcm5HSmVEcEE2cStMRzRscVI1ci9hZUVw?=
 =?utf-8?B?aE44dGdKMXJpaGJsbVhkNW9pZXJkQ0R1NEJVbUU3OVdLUDJkb0d0VXEvNlF4?=
 =?utf-8?B?a1p0VDZDMndvcHNjNjV3TXk1SDA1bllGQThvb0p0Y1gvSmxFRXlQNDlMaS9t?=
 =?utf-8?B?OW5OekJndFBicElNdk9WSktqM3gyNWwrVFErQkppNlh5ckRncEtoRStTYjJp?=
 =?utf-8?B?aEN3V2F5aXU1OVBheXY3R1pqSEhwSjY1blZFOStLY05qaXJJMHhkcHdiUVV4?=
 =?utf-8?B?MXdwWTZ0dXhOSk9uUjdBbWRKS0dVUmhwbDlINFZYSFVDNmlaQzRwRHpSOTZw?=
 =?utf-8?B?aW9tTmhRVkJDUkM5OERuQjdyZFV6d3RPZVBxVVpwOUJVRmhqN1hJTnNwaTFj?=
 =?utf-8?B?eHpJS0Q0eEVxSTRhb3FSQmpHOVl6OWpSbkRmN2RrWkpXUFJ3VEE0SllZdzdt?=
 =?utf-8?B?RlRDT2pRSXNua2p2czhLd1oxc2NWTTFGb3BjOFFNZkVKRWM4S1FlaUwzS0dF?=
 =?utf-8?B?dGFKQzFLZldRNkJId05jN0t6VVdXN01YbXBaMklWYmpBS2NQN294d01HaGQ2?=
 =?utf-8?B?blFlMVRVUDhPYkdBZGNWaXYxUERreXlEYTV0YTM5R2l1Sy9xOFZCVitvSHRz?=
 =?utf-8?Q?75MihLd74woK9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1RmdXZnSjdFQ0xKRVZBNEJhdTc2SWNaNFVtb004dUtpbDM5NmRzaVJVamY0?=
 =?utf-8?B?c0VhWkhxVjNWa0ZBamRXWFM4YkdxdXFYZ0FkL0R2Rmk4dFA2L0pCY09CckNz?=
 =?utf-8?B?a21lWFZqUDFtcmcxMmpyK1BUYWc0RVhZOWdxVnMwNGJFOE5oMGx3SXZFcGZY?=
 =?utf-8?B?azZzNTEvakM4a0k3TEZML3orVlFKbnZjd0tVSkhoY1VCV3dIcmpQclNpQzFm?=
 =?utf-8?B?SmpFY21ScytuQk9teUw2c0ZiTXZaTU1sS0UxMXBuY1BBWFJDQ3pxU0FDNkZi?=
 =?utf-8?B?bWhuWjJOUGp4RjJ2cGZIYmxYeVdGYjIrTytnMXNDbUtoN1g2QmwvT1RLcEdk?=
 =?utf-8?B?b2xlbUNJS0JtU2NDMHMyZG9HUmYyVVZ6RFNNWnBTZHdTWTlBbzAxK2Y3S1FL?=
 =?utf-8?B?S0RtVzZPcksveDUvZWtzQmN2Z0kvK0F5dmh1NWYwcEVaWlpFdTBzZTJqeldy?=
 =?utf-8?B?VG56Q2RPRW0zV0g5RDFuNVhrb1d0dXRmQkVJT0JxcXRBaEVNNmJtdmg2YVpC?=
 =?utf-8?B?Y3NJTndDS0pXVlpBamNVUkticEFhRTgrQkE4aTB5Y1E3VDdNaFF4Sk5NSmpP?=
 =?utf-8?B?cEtyNVU1U2xpQ0F3SGNYcjBkNGpCeVl5dmhXSjZUUHNvZ3l3QUwyYXZqa1R0?=
 =?utf-8?B?VnlYbFFoZjd5OHl5SjhZYnRMQXp0UDlBYktFNnB6eVFjUGdIZDZFWEZOWHVV?=
 =?utf-8?B?dittN1IyOXB6NHJwb3RWbkc4cVY2c0RSRlNmSHB3Z250YXJleGcwbGhJZU5v?=
 =?utf-8?B?ZmFXTjhqbVVVSC9YNGVSd3V1aFNxVzVjVG1MaHZRWGNZQURyOW5tbHpBQSt1?=
 =?utf-8?B?Y09DRlZRREp4TWk3MjlhU0VrV2RWbEZOVkZlY1NHUWxNZGF0U2VMMDhvK3FT?=
 =?utf-8?B?clF5bnJEZ1ZuSUdrOXhVZXptbUg4dTVITFFaOHB5WEZUVTZCQ3FZTzd6cGFU?=
 =?utf-8?B?L0pGNncrdy9wTkVKNXVxTmxXT2pzWmplSmRLV29qOFlISDlRVUl4RVUxVk1U?=
 =?utf-8?B?OGdIOTF6K1dsT2lyUGxDUXE1ZDY2Q0ZQQzdXZWVWQURoQkJIclozWXFoeXdH?=
 =?utf-8?B?bC9PYjRidTRrK2VxSXVUOFF0NytBTytzazFHN2UxeEE3cHRzYzF6OVFKY2lY?=
 =?utf-8?B?MTVLSHMyRTFOZW1FZktTL2tnbnZ1RTBzUjF5L2w2K0ErbEpFM25lOUkyTkQ3?=
 =?utf-8?B?UERCTEdRY3FRNnI3QlhmSmxpVVRiVXphTFNJcWFYWHdkTkZUeFFrd2E3OWY3?=
 =?utf-8?B?T0lNS25WYkFFeW4zc21lLzEwWGJIUTJvTWI0LzZOam9SUFUrVVFSdlZNVzYw?=
 =?utf-8?B?UStMeFhFZjZ3VHhKV1YwVys4Znh3T2FXK0VqRjlFcHZtOE9ha0VDS2IzNDky?=
 =?utf-8?B?Y1kraHVXR2toMUViT1hGWjJDVUY0bnQyWExpYjF6c2tzWWtCNkNzTTZVYTVK?=
 =?utf-8?B?L1dhaWd4ZCttNk5TQmVYQ1pkQVJDeHpQSUVYZE1LNGdxNHgzMXpjNHVhNU51?=
 =?utf-8?B?WENNUjNleS9mMjZ1aUhhQnpabzREa0R1U2s5YUtqNk1rRms0UzdSNUMzMzd2?=
 =?utf-8?B?TWgxb2tjM1p0V1ZqWC9PNUtUSlBmVzdjZlNTVFhRLzJIL3phdGdlaFdvSGl5?=
 =?utf-8?B?QjhnY3V6L3BCRVpFU3k2dkozNlBDcWIxQktRZHVNRlNwZnNmc2JERzNEZnE1?=
 =?utf-8?B?V3BIL0c3TllES2lLY2NvL2JMSlM3VDg4UDY3bWtqanpMd2hjVzdiMGxtRldZ?=
 =?utf-8?B?VkwrZkZ3dS9lK2FuQjlSYTVoVEtBWVdPYVF4QjU4SVRDN2Z4NHk4bnlRY2o5?=
 =?utf-8?B?ZFlxblJONHBiK0RsckVqOXBickoyWm9JTWFZSUVSMnF3Umk3TjgzcktIMlZq?=
 =?utf-8?B?NFpvVnNrblgwWmNqMmxEK1FIUWpVTXIxSno3cDl2ZkhHMXlxRGlCakJKV0VK?=
 =?utf-8?B?R1NFOVZMRUk5UmNKb3JLczZXUk9oWERndEpmdFFud2taY010M0xKRXZoWllQ?=
 =?utf-8?B?QUUzdEROdlhrUmlsTE5ncFVTTTdLSUNYclhjTDNWWCs2NkdBOUg3amZHVjR0?=
 =?utf-8?B?dDlMdUk2bXUzUVpZeDVId3JvZDNEVXhORlJna09lS01vZC82YzZtd3lrWTd0?=
 =?utf-8?Q?u3gMELUiimFGNwek2DmCdImRS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c63b1b0-21a7-42a2-cdb5-08dd20175ccc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:24:47.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTRmVZaGULAXQzKgQoLRur+6ta1Z3mTTrUAu9qyi//EmGtMgGCUDrhz7RomAcoXjfs3G8Clq8CrdFX0uVLjLeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

Add support for reading multiple registers in DEV_TO_MEM transactions and
for writing multiple registers in MEM_TO_DEV transactions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
---
 drivers/dma/fsl-edma-common.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index b7f15ab96855..443b2430466c 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -480,8 +480,8 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 		       bool disable_req, bool enable_sg)
 {
 	struct dma_slave_config *cfg = &fsl_chan->cfg;
+	u32 burst = 0;
 	u16 csr = 0;
-	u32 burst;
 
 	/*
 	 * eDMA hardware SGs require the TCDs to be stored in little
@@ -496,16 +496,30 @@ void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
 
 	fsl_edma_set_tcd_to_le(fsl_chan, tcd, soff, soff);
 
-	if (fsl_chan->is_multi_fifo) {
-		/* set mloff to support multiple fifo */
-		burst = cfg->direction == DMA_DEV_TO_MEM ?
-				cfg->src_maxburst : cfg->dst_maxburst;
-		nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-(burst * 4));
-		/* enable DMLOE/SMLOE */
-		if (cfg->direction == DMA_MEM_TO_DEV) {
+	/* If we expect to have either multi_fifo or a port window size,
+	 * we will use minor loop offset, meaning bits 29-10 will be used for
+	 * address offset, while bits 9-0 will be used to tell DMA how much
+	 * data to read from addr.
+	 * If we don't have either of those, will use a major loop reading from addr
+	 * nbytes (29bits).
+	 */
+	if (cfg->direction == DMA_MEM_TO_DEV) {
+		if (fsl_chan->is_multi_fifo)
+			burst = cfg->dst_maxburst * 4;
+		if (cfg->dst_port_window_size)
+			burst = cfg->dst_port_window_size * cfg->dst_addr_width;
+		if (burst) {
+			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
 			nbytes |= EDMA_V3_TCD_NBYTES_DMLOE;
 			nbytes &= ~EDMA_V3_TCD_NBYTES_SMLOE;
-		} else {
+		}
+	} else {
+		if (fsl_chan->is_multi_fifo)
+			burst = cfg->src_maxburst * 4;
+		if (cfg->src_port_window_size)
+			burst = cfg->src_port_window_size * cfg->src_addr_width;
+		if (burst) {
+			nbytes |= EDMA_V3_TCD_NBYTES_MLOFF(-burst);
 			nbytes |= EDMA_V3_TCD_NBYTES_SMLOE;
 			nbytes &= ~EDMA_V3_TCD_NBYTES_DMLOE;
 		}
@@ -623,11 +637,15 @@ struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 			dst_addr = fsl_chan->dma_dev_addr;
 			soff = fsl_chan->cfg.dst_addr_width;
 			doff = fsl_chan->is_multi_fifo ? 4 : 0;
+			if (fsl_chan->cfg.dst_port_window_size)
+				doff = fsl_chan->cfg.dst_addr_width;
 		} else if (direction == DMA_DEV_TO_MEM) {
 			src_addr = fsl_chan->dma_dev_addr;
 			dst_addr = dma_buf_next;
 			soff = fsl_chan->is_multi_fifo ? 4 : 0;
 			doff = fsl_chan->cfg.src_addr_width;
+			if (fsl_chan->cfg.src_port_window_size)
+				soff = fsl_chan->cfg.src_addr_width;
 		} else {
 			/* DMA_DEV_TO_DEV */
 			src_addr = fsl_chan->cfg.src_addr;
-- 
2.47.0


