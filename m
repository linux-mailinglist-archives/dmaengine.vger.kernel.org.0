Return-Path: <dmaengine+bounces-9140-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OsDDho6oWlrrQQAu9opvQ
	(envelope-from <dmaengine+bounces-9140-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 07:30:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C81B3422
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 07:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F37130427E5
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 06:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036553E9F80;
	Fri, 27 Feb 2026 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="T4ImeH/e"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021139.outbound.protection.outlook.com [40.107.74.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C843E9F9C;
	Fri, 27 Feb 2026 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173795; cv=fail; b=YWcCAqTLwJ/mwJA3CngoBwulLZ5o+oTzlkHfXYTwLlnct0WCDi8IvgHdolzwj4/phuCIoYyt2WnJD6LCZnx04b7LrdybUuDH7pVS24WsRf9FF3pB7nf6nQivTKmeSKonhrbhCxHIV+DInK8rCfeD77gDHtKF5TdKHg/6lYb66Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173795; c=relaxed/simple;
	bh=aCTne5jhAA1Rd53KmkgSOCrl5hqPaNSwG3QaMmNdkSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aN89FkLxtzN6wUjovWWgj9zNhPn6e0GlBfJSGurARNaDUrBkyzy1AYF338JYn/imV6eCYveOQ/54U3fOYd7YaJOqL3US+3bAVhoDRgFoxuTpW31CPRUOR0FOYJolazQlurmfIEyxQzwzq9Hb9wthzOAfFOmsZcjyfTWW+kj+a2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=T4ImeH/e; arc=fail smtp.client-ip=40.107.74.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liNkP2xwGTAKuNuHdGtjkbvXfhOMiiaAvxWI10KnBPkIpiIIW0plv8vSMJaMe1Vsa4MDpl27bl4wHdT6FnuAzXFZmfqjvwpsLGwas1xa6+PYeKgcRJ7V3T0XTSiHuPRa/7HWpOeU63mKVLqk6GGFHDDn+QbHSVIlCuh6ihGAKcv9Ne0TDs2qdWkS5Nja9DbYQVcsxr8bsSyDIqIs6uNjIp4LUQeiorJGNH9Q9hMCQQmU8WMlID7w/tYxpAN6BVlEqJ0oI84oSPAcacyHdDyctGYFxunCNLA5ERLaB0rXD/vUeQqKbiYuMJh6LN6ukblm9YxYLhBTaSxVcQC2vqP2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eXgJNBRChIsR4yJoaTWxib7myGesRQVhsgovYsy1Lk=;
 b=m4J5jxnXr78X+a5/bBHarbggh1mQo09PQmK/od+3EqkM1yYTGaCOvMGms2JN7rgkx/E51Osj8S7nLpHjTnPSUIDVwfDoqUphMZDuB+fyyoC6wIdTAiOjk5LFCE61e1or+bBoWgEjMpiKBO6OFJV99hP526MTATDG5KmtqmKHKC1NlEO3+64Mxz58T+2QulbolYK2Et95+ACkA32mYK60BXoTkMcQinA2dQ0eQQvxmXWLOEoo0IWyRKFu/H3IMyGrbr8n+CAW0PUlIJ11vinh3A0UlFi/zSBRyDxYgwKxuw48U9nVXmjIUqhgwf+M1bfG1WW86c1wpl3WN5l48V9lHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eXgJNBRChIsR4yJoaTWxib7myGesRQVhsgovYsy1Lk=;
 b=T4ImeH/eIDKbgElgrQ8O+Tl2WIhEWXrhIhtzQ93+Ie1nRojGUwH2cWqKwQcWCm9BqlRlwGfWZxa5bqJc0pvbxNy4ba3YLB+88A7CoJPKSRNfCvv+g1CddI7LCW8bx/Vs9tYVx0YRrE3hBYNJb5elfmGh6aKqfkf2qN1mEgpV740=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5878.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 06:29:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 06:29:49 +0000
Date: Fri, 27 Feb 2026 15:29:47 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 01/11] dmaengine: dw-edma: Add spinlock to protect
 DONE_INT_MASK and ABORT_INT_MASK
Message-ID: <2t6tu7g2jh6tfavrfxkqx5yvd5kq5p3u3bamtjc3awjc7g46vj@cistlknk5qe2>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com>
 <d7mh5d2amod6uzmzib4qnun46al73r77uljzhizq2v6w5ame4v@et65inoxhexa>
 <aZ8aUcV4RN2EL5n3@lizhi-Precision-Tower-5810>
 <jjklzlblwbqleshgnhiedqioxskt45awph5rlkh5bymvitk3fq@blisaiwi3zor>
 <aaBlb42x3qQxOYjk@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaBlb42x3qQxOYjk@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e6ecdf-17bb-4caa-ba7a-08de75c99bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	2jyKaJOGeDD8dCitcZflZ4osj+kpOvkBkzeY9rXPRMqL4KqX94KPIL60Cmvzv1HDjdLvREi19vmjp5GZ4+idNlZ29LCnarV6TuNnFejO5By4dRRD5u37JKeXbILUoy9v8q1H4a7YjTzrwuUEP06QmF6cITtgM776MeK+znE6vdq7pArl2h5kZhTL2V7skiiDzNMh1JjTCIB3FFfPRrucCNXle4297/XqaSlZKq2tAlIEcO8IRGVm8XzhmLm9v/EwqBalXEJLEvb4lh4KgmKGWiFjbqAN7gB2jFy82GkZX7W3wl3jXB0dWo1iwyEVscjLxLuYV1+6YDfxib0J32CLEn4LuufXL8G+ehlb+yTx4R+ePkZ2ocr84tAfygYt9ZTLC+vQAihP35rY/iB4/A69Ab1DxUeCmHWzFqit3zfr9eWKyyjQRflgga5QmG4+1CPrZLRN0lWpBDbP69iAPCj5jSwaqUaCJwDbMH8cTrkE2DyJFnos3p+kV6tnyqQ6eKnJMDV/M9bApYgaGFd8M/dGI7EfRQOmedKOno1ui7kt1VD4UYsE+uupNzkud3i6NVsCMAv2WFR8wnLZQBArxJfQao1lBLoLTSHdEcB2Sjjdbhk8qjWBRNi21eI1+Z9ldWMKc+iuTuMGlDb28Eyn1O5nlKoOoxLQsvPs158ttRwgNssD/77UGpU8Hb7hINODTaBv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WXxQPkEWRb/x6Fvp1QvY8LLyI2lFrqIDmy1nz29tKsj2Zw9SyOICYKqZ/KzA?=
 =?us-ascii?Q?ruUPGKIgvkeaKcH4BvUipp52n3cEX6tqqe9dffQW6vQoUSG2qvw+//MSgM4f?=
 =?us-ascii?Q?7joYugVtbvItQ//st10stJoOKWLaPFME2cb2Cu2hqczaXM/flXWNvNGABF8v?=
 =?us-ascii?Q?2SA+pIjfJcSFgAINCno77O38tTzvqhKMqAGt2fcLjGr38LzhzUmDgDkImWAz?=
 =?us-ascii?Q?V/jUA58o3K6m2wzDxwxVlLTkBo8mVioBmUrH6K2btzrkD7fZ6Vb65bMYb0Ei?=
 =?us-ascii?Q?K6HrbmZVmzmYilNHLa5LjFNMW3EIUjxkeTXN/efJshNrFGCF3/YSt7WzNeXo?=
 =?us-ascii?Q?cTDSnu4MEQPbdWD7KZTOYNrnHDy+ZbavCuVKtOob/SmFhHTDcIYDo25SphhY?=
 =?us-ascii?Q?HwKzLXgL+F0AheyQNOeRy3Iq7wYXEzVoWn+gCNVpHnAyorqvbnF25YOqH2sM?=
 =?us-ascii?Q?bC/hCFN3ePDl+Cgfp8wbi7i+eIbNEb/m6f0w/htol6oJi4nLCGtcYyIPquwa?=
 =?us-ascii?Q?/MhQixHP6ranvJO7rP0KakQ0QG6WalyiBq+/6khDzxNbNIUWGJsbc4YEbVOh?=
 =?us-ascii?Q?ATcbdpz9qT+4NuDs9SN6NwVLjz0YKsMwwNVJL5HqKw+F7gX2xVLl7QTxKoj/?=
 =?us-ascii?Q?+D1UZRkClQ5Gs5lFKp3/4f7atcutuxLlxL+GlNErWUYPNI5Ur3HQ02SiMdZf?=
 =?us-ascii?Q?e9wCnDIZ+I0j2Y6d4oYpgcUeBKU3nPXQeT4FAYzF4h0IdECNQoK++TJap24E?=
 =?us-ascii?Q?GMcWVfZCwW3u+UPBddTEJyQ67UEe2cYygR3B4ALTprkznQPOf/YIKwTCfwkQ?=
 =?us-ascii?Q?RL7cZNW+v0d+AeMnd2GMGpEAP3jauGyUSDRYV8nYNLBhutpAipKal0ts53VH?=
 =?us-ascii?Q?Nr6pm3iwKxEFq4+pEFQ5S2/1+VMHqalHZ2numyirp49pJwBvcQD1+7bvDnGs?=
 =?us-ascii?Q?+Y2tNO7zQ25Eah/3xGK2JZCJ5SijWFlLi8sCJJOlL5/APASXKC0AU57frPrf?=
 =?us-ascii?Q?d2OLD0kpKyCEAGWZBkPVJEKzN8HGvnPw9xtmtPxC29mIjusYVWK7xInJNF8Q?=
 =?us-ascii?Q?TS3cjTnPHfvjopfVYOdk+N5Tno0Hfl1SiQm2P7Df/JYmB0cWea1uRbhpPLqp?=
 =?us-ascii?Q?JECVT3OZKLq9/J7EMRbyyvxMKsDicS8+9ZjH1nqz+78LgaZO4fLCrHoJzRVk?=
 =?us-ascii?Q?jNcD2AbgLcxLW4f/uC56+17lXDsvRsYq2rklM04pNOi79C3RaFIOPAeVStJz?=
 =?us-ascii?Q?VsGoZnRCfwrIxBlSM5YEjnW1loAf/Ww4cXuv7VpTzoPZAl7tugiATtKN/k27?=
 =?us-ascii?Q?SBbfX1cGsVvTJ15AlEJcPfOgbFMzLhQmTJaTGnkFSlSF+fMlZ5HHBOXkz2Yk?=
 =?us-ascii?Q?eKt3qRWOIC9Xjzjrutvp3G3JXQJtfBXJ2PgoJqFQUyV4y4wrHn5HETPT8idE?=
 =?us-ascii?Q?1pXj4mixhJI2kL2jEEhVnKaz3ShCpiN5svtzs/Kgah8LZdefFEulxnjYNIVr?=
 =?us-ascii?Q?r9wL5+LlT3RaoSUzzgMinCA5LbRBzt37gdImyVUqsCshV94hUHU9fx11DLIz?=
 =?us-ascii?Q?/tBJwFlEWhtrAQcextu2m/3+z/Rg+ku04K6fxPiOTT5zXWJ/bhOmnrrro3U3?=
 =?us-ascii?Q?htJiYoqWysvJrH0AwvS6FCAZJAZS7PVFl6ICtuEo28pA/nllQ4Iq0KdCI58t?=
 =?us-ascii?Q?ktKBpjkWN5+nMxRIuyzXpslyvY7SMkxyxMVgxZqU+sHDlHWIqSBii1ZwiDLK?=
 =?us-ascii?Q?0Y4AHI+DH5fLbob9djkA9HxZPvOBw6bFmbJOvb822ltkbhBhF4D6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e6ecdf-17bb-4caa-ba7a-08de75c99bad
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 06:29:49.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2t2yH8njxb+Gadsq8tpR7wfLm0GTA/k94j675P6/rtXRBMM46gLOIqA+sUP2ob4+D6qjKNfseMsRrsrFeSqGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5878
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9140-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,nxp.com:email]
X-Rspamd-Queue-Id: D67C81B3422
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:23:27AM -0500, Frank Li wrote:
> On Thu, Feb 26, 2026 at 11:22:41AM +0900, Koichiro Den wrote:
> > On Wed, Feb 25, 2026 at 10:50:41AM -0500, Frank Li wrote:
> > > On Wed, Feb 25, 2026 at 05:26:02PM +0900, Koichiro Den wrote:
> > > > On Fri, Jan 09, 2026 at 10:28:21AM -0500, Frank Li wrote:
> > > > > The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
> > > > > channels, and modifying them requires a read-modify-write sequence.
> > > > > Because this operation is not atomic, concurrent calls to
> > > > > dw_edma_v0_core_start() can introduce race conditions if two channels
> > > > > update these registers simultaneously.
> > > > >
> > > > > Add a spinlock to serialize access to these registers and prevent race
> > > > > conditions.
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > vc.lock protect should be another problem. This one just fix register
> > > > > access for difference DMA channel.
> > > > >
> > > > > Other improve defer to dynamtic append descriptor works later.
> > > > > ---
> > > > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > >
> > > > Hi Frank,
> > > >
> > > > I'm very interested in seeing the work toward the "dynamic append" series land,
> > > > but in my opinion this one can be submitted independently.
> > >
> > > This patch serial is actually straight forwards. we can ask vnod pick first
> > > one in case have other problems. put together to reduce patch's dependency.
> >
> > Yes, I see.
> >
> > My understanding is that the originally planned dependency chain was:
> >
> >   #1->#2->#3
> >
> > #1 [PATCH v2 0/8] dmaengine: Add new API to combine onfiguration and descriptor preparation
> >    https://lore.kernel.org/dmaengine/20251218-dma_prep_config-v2-0-c07079836128@nxp.com/
> > #2 (this series)
> > #3 [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link entry during dma engine running
> >    https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
> >
> > I'm not sure whether #1 will proceed, as the thread appears to have stalled. I
> 
> Vnod said he will review #1 in this week. If not progress, I will create
> new one without dependent #1.

Thanks for letting me know that.

Best regards,
Koichiro

> 
> Frank
> 
> > might be missing something, though. In any case, #1 is semantically orthogonal
> > to #2, so I believe #2 can be considered independently.
> >
> > Thanks,
> > Koichiro
> >
> > >
> > > Frank
> > > >
> > > > Even in the current mainline, under concurrent multi-channel load, this race can
> > > > already be triggered.
> > > >
> > > > Also, with this patch, dw->lock is no longer "Only for legacy", so we should
> > > > probably update the comment in dw-edma-core.h.
> > > >
> > > > Best regards,
> > > > Koichiro
> > > >
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > > index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > > > @@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > > >  {
> > > > >  	struct dw_edma_chan *chan = chunk->chan;
> > > > >  	struct dw_edma *dw = chan->dw;
> > > > > +	unsigned long flags;
> > > > >  	u32 tmp;
> > > > >
> > > > >  	dw_edma_v0_core_write_chunk(chunk);
> > > > > @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > > >  			}
> > > > >  		}
> > > > >  		/* Interrupt unmask - done, abort */
> > > > > +		raw_spin_lock_irqsave(&dw->lock, flags);
> > > > > +
> > > > >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > > > >  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > > > >  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > > > @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > > >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > > > >  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
> > > > >  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> > > > > +
> > > > > +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > > > > +
> > > > >  		/* Channel control */
> > > > >  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> > > > >  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >

