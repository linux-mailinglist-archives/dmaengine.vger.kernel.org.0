Return-Path: <dmaengine+bounces-8831-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBplOEZ/iWl2+AQAu9opvQ
	(envelope-from <dmaengine+bounces-8831-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:31:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5502110C197
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 07:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 896B13008774
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783E325723;
	Mon,  9 Feb 2026 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qvktZMTI"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021104.outbound.protection.outlook.com [40.107.74.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE72FE048;
	Mon,  9 Feb 2026 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618605; cv=fail; b=YCGIbb5/aZMcUMeCtvTnFIVqZNjUyK/Pxe5qN8qyE3ED86MFM4JwJMhEYujuyfzfClVD+0YxMerNxXpEv0FIrki76q9MFHkD9wXSInw1R8KD0QcGr9EDiKWyuwv+KkoLAsL6wv/koJr7qQcs3Kvp8o7jfxB2BCAU31D+BmiP2Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618605; c=relaxed/simple;
	bh=IzccJqE7Lm912wY0VygQRmfcaqtAjyn8prFD5KjsMS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iubedgHhHEgy9RT9yio2ebOar/VsLgiwg7FZqXxjmgqxbGH/9+7MAvAtR93dbFPQgfW4zcpdg7IZqbiiMmtYz8KEWoUv1BIxz3fCeLAjcB1nxcOiQJnL673a4CkpiPhuohCugc21jmfFMk6+k27DALtIyruFKrnaetPEe9ykNVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qvktZMTI; arc=fail smtp.client-ip=40.107.74.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDJ8GA6ZS3pPIOdXDZ+iQe7z6afVCYVUkK3JrWM2spMe2me7kV47yZXDWSfpWnSuymmw8CGcYZUmYOgep6LpskiSSGtaBUMpbRo42xh0AvUE/hfjCz0cUH7JPhpf+f0uVFy/rx386ujKI8JElmKONZny1EzG3yrDTMoht4yEp+Qs4c5lJr4dWQy9VoDyDBxHJBTZe5tW8RLP9uKhvNn/ZDJB6Vqwm2o7bQBtxCL7f2s/dxhVv+cBIRuBibUdPtQSgDYUz8J4wJYU8ocOR2b9N+CLnQj0tLgU6anSvwMhJhF2SiXEvF5ZzojjOIMuNmkIVfGofSs9Snop4cHP/RjJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usXujhdztx84mPQSgni/ZWDOTKEq4ka90KIk3iW/c2k=;
 b=ukt6ZP0JmBlLeeJ2APv31OnSsoFIzeYMtdUhEgcpXUHbHkBnmCHr6MBK3Z7pzArNbUPj7gkvO3/qvHV4vLOvB7B7gKQvdFzVa3V+o4uyo+Mqwre+NJ6SWqMplV26Y2PtBMicel+gJaFxQsnfJFE7pSh5GWgC3ndcTljNg8l2JQoypLiGynjYikuVbCt2WyBgfYCsq9M2zI5vwezejOFaU2plskEr8iKED0X/Gyb1oaXI6U2eA/0DM3DMKFDI9bi5TLgxieM9F64hMtDhzA7rXKzx1urhIRGs95bDTVPBJFV7TSCUcRxBYUUXj8Y7rDVtBEUr30UrMNBEs2JuWDyR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usXujhdztx84mPQSgni/ZWDOTKEq4ka90KIk3iW/c2k=;
 b=qvktZMTIbzoSmnh9Q/9P8CInoNPZz7P3VyjY0zMX5/Lx7slz/Ydida+IIUbK30VCbs3SIAgz7DSFreGLc3ccjKK4nPQc4EP0+OVS6LvwAZFrP+7RuLFNHGuwTU868CFtjlnekVW+MiqlbABlow0YxviRkFtqicco2z0Lb3WAqwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4425.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 06:30:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:30:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com,
	cassel@kernel.org,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	kishon@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
Date: Mon,  9 Feb 2026 15:29:49 +0900
Message-ID: <20260209062952.2049053-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209062952.2049053-1-den@valinux.co.jp>
References: <20260209062952.2049053-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0101.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c05052-ef6e-462a-23bb-08de67a4a904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0QLFf9Ie/3+p9gGXRu6y0zhE6cLW0tg7tBOLMY3l4k2417yTdxI4B6Il4N80?=
 =?us-ascii?Q?9NPrs/w6IrtV/DBMU0J/U4xxlIFQkXfdy5XAsEP7wK07V9BOK4cvj4D0VOzH?=
 =?us-ascii?Q?20jirR/InbO8KznPJlgwlo1QBLccRf2jrCahzMp5xQaVXXi12D/2Rv4pPFcS?=
 =?us-ascii?Q?5OYlAAVZagdBsgLByzG4gG9h6EGKAR/cRKE2OF8GODBfBxPtvy5O6mwqZFcV?=
 =?us-ascii?Q?4tpvyRCiNTJsUce+JHrslJjnnVbaDCIvn4L2zRUkKrSLAYFkw2MB2WZ1gFs3?=
 =?us-ascii?Q?Yq7Q8SYKrPjE3CStn2gGzjFykJBOcPi5TTWxEzU6lq1xOH0KUA3hT5ZiOkC7?=
 =?us-ascii?Q?vYBu7MGCJupOoYOIo1JlxMszkA4YhpKj7YUYZOAi8tT8eAGSfs8R0XjzkA8Q?=
 =?us-ascii?Q?NuMe/KLOj/drm2yz+b3hMEO6XUhk5twmVaKqkujSX3EL39kFaD8O6Bx3n9Qa?=
 =?us-ascii?Q?nbhyDwa881TlaGyBqEICSR3cVau54oe6L1l5iop1Oww+Xs1Cg2vzNDG5AHqm?=
 =?us-ascii?Q?lA71kZDFldItOxFMlZtu53eMhCTBXWeLmbj8YXqy7ttbKu9cKGKXn/ku0zMc?=
 =?us-ascii?Q?aKtIfffYEqjG0Q708TjqMkzb6Ug9VKNL0hMxLSMJmmC2kPbqrk4LN/mPtbc5?=
 =?us-ascii?Q?g7lKXBTasVOSxOLxgLfEov8hfndfVC0ylHqRr94KBSSxsUEwnBMHdD5bUomk?=
 =?us-ascii?Q?93sZPsPDkjPMZTch2NomTFkAqWmgACIhmzmLy3poKsVmqg1Pd2tb4xmh115B?=
 =?us-ascii?Q?TEHyFvlHukKXfLbNtv1UYmwQhfEI8N4Mevwwy5gvs0uqRQ68PUsVUh+xAyG1?=
 =?us-ascii?Q?JvIBi+ovc8+RoaQbWsDsvTD2g5fMU6ZZ5iIHAvXOracLE13XaHrawvAz7Obu?=
 =?us-ascii?Q?w990CFc8y4SK4bApgnZ0Nybz7zcOwgTfEyBUi9sU0kS2tNcBEPbYPG8hf7dI?=
 =?us-ascii?Q?HvyjjPt5xGsyQO9a5aeD0PIa9RXyHmE4rdozAg+hsJgZpGMKTYt8l4Hqsk0E?=
 =?us-ascii?Q?h5Kpz3TNGsrmfZfHliPPDOknmt6c3f0hp5R3V7bFdEy5W0I78Ruc5NWfRh62?=
 =?us-ascii?Q?5usm/ub/uvWi4MLmVBs0dSDRFq3SC4BFp8Q9HMX3V74u1rKXbu4g6Xi4vA2Z?=
 =?us-ascii?Q?GXHZOf3aa3kcSQaByEHHyvdcwVarlyWTiUXA9XkhoTa7zjD/rNmTObP81n/2?=
 =?us-ascii?Q?6Z+doJsYnu10lOJhGexg2XvnPO4hjkllUT46HHo9kg6uLq64hlSkYeaj23cu?=
 =?us-ascii?Q?bcRiG5FhJUtBezgDN0mLHoXLiUxMUVxRqV/vsG4q2IM1ABVtxzlWcPJubDNM?=
 =?us-ascii?Q?XWbeoV44EfIvi5NDA/DeVfWVby2+adBZf9YHBynm/L/pRqsKt4GQQpxW0JNb?=
 =?us-ascii?Q?unItXOZSgNzdkYRvJCUUYbkt6zaBqFrFnnif8jPJNpVdBVBhTmEUo9MMauAh?=
 =?us-ascii?Q?FOtH0K8tNVXN13mWzlz1IqAoPwJqLtjaxFSXM5+6rMAko2DvOiEEypBn5U97?=
 =?us-ascii?Q?q/5bBsa2bZphAqSKAfbEe/FN4cHq6OAddLFdGdMfFKF16suJQfzwUyH+9LRu?=
 =?us-ascii?Q?q01054kT9mAsJSXo4uisumnUurtMT0M8h35aY9bXZhi+n2RD+sSuFUTD3ivQ?=
 =?us-ascii?Q?9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R+pwtGplNnnt3BbRw+5WdEAUV9m6cY9Lq365fk60eNTQKOlxuBXhsGOhH/7O?=
 =?us-ascii?Q?tcHSjG4mSsc5yYWQBjnXX1ouS3NJRSeiFXuJfG2Ay2JlFON4IMtFbR+sB8D7?=
 =?us-ascii?Q?XAsvK1fC2KZhypvpvMaUTo1gURWnRGtzuAGAz9bDWmAMheV5pos/AFaGCG1c?=
 =?us-ascii?Q?/PnOxR8PxTF1yyzOxTShB4XHJDgasFAvyiPBio8gTYAKhg1G/8vyCcgHzI+/?=
 =?us-ascii?Q?lzgVRZHFHDdg44ERsVOfXBwHmjKkqZXvv5JBjUYAMjPCFR7S9c4S+Fys4RjW?=
 =?us-ascii?Q?MsMLjmN5wQNHB5GRBmVkzNXuOEzSsXr9laVTXuvCJP+eFsJNnajzhu2OqOIA?=
 =?us-ascii?Q?x+jcyhhR4T9oejD0qV/LES76m6BlitStt82ofz3xbJRHSmQiJcBBJWYgDmIe?=
 =?us-ascii?Q?qAaGCjvWB0DrPvJcZP1PW4MiZCNO+hsJGbCOH3HC6gNHJ52z/D8G2acmsijK?=
 =?us-ascii?Q?EKh7cRLwsjYRW3AKbkwXbS3aKupj77ix7cELeTNZAtWK/nqR5UnL7tMbv7ny?=
 =?us-ascii?Q?ocwgFfQiba3x0heoTICnPpybMswb187ZHLdPWKsZw+x+8+DWNq5oMwtb4Ozs?=
 =?us-ascii?Q?K/+amuPEZmHaDn0zmC5G+Uvz/vb7Km4TFVLxKUXg1EyCguw/Z3FRwwQCN0qD?=
 =?us-ascii?Q?VaogU+rHCt3HLDIz7TkbiUvMz6n6UH2RZ2MLV4Tg33vYy7rwMcQUxrjSobiu?=
 =?us-ascii?Q?9lXD24HlyCPb+aas6nvkV4UUNT6uTf+oT49uJjXkYw04iPevixYDqOMWCzs1?=
 =?us-ascii?Q?qc4tskllc28EapTwF5EpR2NK1jV/kzjWO2KnTxUFfe0/RzRhjwuDuGpdMS3w?=
 =?us-ascii?Q?UalUg+ZFpLIyMiZWFj4PpwIvXP1cAeLICOwhoCofkkaERMkw9bjLtk0ozNuV?=
 =?us-ascii?Q?OKHAyv7ySnZnZrzOCsGz7LnWtZLLYqeYizOpQMrVr4YOzo+KdwmYt3ViQc6T?=
 =?us-ascii?Q?hvr38ZxmTtCE2hPECBFqrC7S+nqjqq3+MhuUIpNKHmzwXS4H3sjsHmDD3gLk?=
 =?us-ascii?Q?JG3pfk8w46VNEUHucnn2EnX4pCIt4z8M1ndLc1Vo8V7HcmsHpfaA+gcHJU+e?=
 =?us-ascii?Q?vsybceUG/P2fhlxtP5jSnnuZ+a40A3drI/+9YXYLIlh9H3b7q5bbAH71IIJh?=
 =?us-ascii?Q?QrQLeauFdjj3XSITXkBfaQgJCO9B7FtKZ5HZUV7+B3HGulkttzmNc3cGNtw2?=
 =?us-ascii?Q?MUp2UTy4EW8+tY8UYKhrAIoqJAVt+njx77p4FGRkv1PX8qlr71tSrbkhxAyf?=
 =?us-ascii?Q?HLN7DapCzi4Ntuf+FS6is3ytvreU3j76QWSOElWhhhuRftEQKP3zGdrmy76A?=
 =?us-ascii?Q?IW/GeSyaTYq1s2xuiMYX6o3ao8qFiDHFQf5So18wYx/W1TIejaRp7fIJV3uK?=
 =?us-ascii?Q?jtkj1rDD76CR3pGv0ZCavzXA8sYuaMmBibG2m/DjJcQzXJadXL726FEsV0oG?=
 =?us-ascii?Q?+K4TfxD7s3qG/D7xhBUcnAj0FNiCskBsR9ELZ/h1n6lIX7wYaIUvskSDmxCm?=
 =?us-ascii?Q?24gGw9VX4aRU1b/7rpmzfmt9ddocMplUUWg2842LXiany6TL5VQ0xeZ3SOiB?=
 =?us-ascii?Q?ROmWnteIAOW/3d2B8OCU3GeKqdGTKeKqLB1i/vu4y01YGVK783OXXqx7icX2?=
 =?us-ascii?Q?Q6Bdg0qDLgmPO7ynnsQCPaizSbOLxgTdJN6igynyQpaEeegdKWdVB5qjt+Z5?=
 =?us-ascii?Q?TPq7Y6I3wiihzX0gcUKQB+Bs+EoZp3koD/pO/C639ZMB6l9/nT/32o8VssFz?=
 =?us-ascii?Q?MYxslBzI7SJZ2I8SbFpaCwYtg5Ir8qzn7frO+yrCGW9EUEscRlcP?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c05052-ef6e-462a-23bb-08de67a4a904
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 06:30:04.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpblmbiW6AGaOOVbN7h82/k3zdi6QFKVa3qYJRsyqbKOav7NiI/wOSl8IaYNKEjxahFcr8toE0b2zH3CZJWgVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8831-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid]
X-Rspamd-Queue-Id: 5502110C197
X-Rspamd-Action: no action

pci_epf_test_enable_doorbell() allocates a doorbell and then installs
the interrupt handler with request_threaded_irq(). On failures before
the IRQ is successfully requested (e.g. no free BAR,
request_threaded_irq() failure), the error path jumps to
err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().

pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
doorbell virq, which can trigger "Trying to free already-free IRQ"
warnings when the IRQ was never requested.

Track whether the doorbell IRQ has been successfully requested and only
call free_irq() when it has.

Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 6952ee418622..23034f548c90 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -86,6 +86,7 @@ struct pci_epf_test {
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
+	bool			db_irq_requested;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epf *epf = epf_test->epf;
 
-	free_irq(epf->db_msg[0].virq, epf_test);
+	if (epf_test->db_irq_requested && epf->db_msg) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		epf_test->db_irq_requested = false;
+	}
 	reg->doorbell_bar = cpu_to_le32(NO_BAR);
 
 	pci_epf_free_doorbell(epf);
@@ -741,6 +745,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 	if (bar < BAR_0)
 		goto err_doorbell_cleanup;
 
+	epf_test->db_irq_requested = false;
+
 	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
 				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
 				   "pci-ep-test-doorbell", epf_test);
@@ -751,6 +757,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 		goto err_doorbell_cleanup;
 	}
 
+	epf_test->db_irq_requested = true;
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
-- 
2.51.0


