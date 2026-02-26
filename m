Return-Path: <dmaengine+bounces-9122-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x9NHB3uun2nvdAQAu9opvQ
	(envelope-from <dmaengine+bounces-9122-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 03:22:51 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3981A0136
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 03:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF45D301F9E8
	for <lists+dmaengine@lfdr.de>; Thu, 26 Feb 2026 02:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767530E0F8;
	Thu, 26 Feb 2026 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EZZHcRmY"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021081.outbound.protection.outlook.com [52.101.125.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E87278753;
	Thu, 26 Feb 2026 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772072568; cv=fail; b=C7r/uvgYopOlX/UDkmEqnsyyqwcn21jMLLXOzX6EhodSRcaTrbmGndybld+oa6tWRzPt9CQAKL77WshiBzB0UEFPPxw8ER10cFw6Yyl8g57ANWZ7WetF9rGGvcZ2HKGHrAF8wmAtlYm4UOrvnL3+ktF03EjCNs3VRnjFcJM0OD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772072568; c=relaxed/simple;
	bh=Q5oTp51x6kkhUCf5jMtDv66EiyDUTk8xrxGrzj+TKOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r1ja6LhdYcQASRONBprdnymz3rrsF93UJBQxswBDsSD+hKeOJkrh7ZQ8Xryq+PjcP5xXKy3F1fzoOA41XmJDikeLuZz4l58Jlg5W7A5apGlDsm0psRIIpvwc3vymSVNRugAzLBdRWb/YjasKvQXCMMJQ0FupCroHw9lkvD16S3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EZZHcRmY; arc=fail smtp.client-ip=52.101.125.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUtCz0c2pNc41OKQ2McQFShrmjF+nSb+IU3Q26F9xYDLWh5pFV5yAMM4XbcBAVemePapW1MFvCLkDDsk2antGZrO7HzDESmQk0/11f4wYN0132AohNF3wYXJMgAySnPx9hz3SYkhWqjIaj7TsEwrWxCNUr6+EeoFaRJsvW/NHWG/YFSUXbypfYnKAk0OVoDTB0jEaj0ogGej+Mpg6OzS4ubyw3Vagxx1V1a6xug6GCATsa4cXA2jgD2FCpGF92CrZFoF+tFmlU/QO94wc5L7ry2CmpTBfQ0Pmixfv8jrNPJuMMN7AwVhcd/M9dVu7Z4tDmSJspkLUrtA3RijbVaEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qOiChlAXH1FzXwCLqBw2AijsvpzWjMCUwfsn8OzPyw=;
 b=XD8ycj/jcB/i9JvnUN1NOdMeauSqZjBKvn9ecL18P2cIXZllC+IH5QJjPxwa5wyzxj6CJfQ+yDqLhILEAMMvvcjFJHTUz+jk7ptLd6f8xUmNuSJVkNt8cDnD8hat0qisv5V0sb0nzSwvYdKwaqZfmu84hHB8AQlnXrB9w+Mqks3msRw4cT3F8uogSo8zpcCRmFGilr3ij4MP+KceQj+VMKpljgvQU5Kn9INGWlhcPXPq0tyCBSmtBAo0HP5cc6753v65MKduzoif6M7D65FE4mGpG9k/wtBxLt8sLSZDCg5OFYnxZhE4skcIMhDEmypdFyt4D264QdRnrgGd6bjFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qOiChlAXH1FzXwCLqBw2AijsvpzWjMCUwfsn8OzPyw=;
 b=EZZHcRmYWasUrRARe+vRqQyNXLH/AfZRS3abfzO/vfK/mKFVs49Qj6jFaNktLq2KbkrowzsRe9cWbLSBuuC+p4aHkjdSYikoDp+8UTZ8ECZYplySIvQpWMggNpa+Y+QrI5yWvXy9RjmpJGJ65BUDqvUNCP6ZG9QgoMzSPcCPe6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYTP286MB3452.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 02:22:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 02:22:43 +0000
Date: Thu, 26 Feb 2026 11:22:41 +0900
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
Message-ID: <jjklzlblwbqleshgnhiedqioxskt45awph5rlkh5bymvitk3fq@blisaiwi3zor>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com>
 <d7mh5d2amod6uzmzib4qnun46al73r77uljzhizq2v6w5ame4v@et65inoxhexa>
 <aZ8aUcV4RN2EL5n3@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ8aUcV4RN2EL5n3@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYTP286MB3452:EE_
X-MS-Office365-Filtering-Correlation-Id: af2fd275-3d20-43f6-e244-08de74ddec13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	BLE7sOxPQQw8jPe5MMCWhgDT8lqBtYEaOT284U+ztr4/uS86vsKuttJw/1pFNzqnAYvB16tLePGjWRfPbtaOF0MQfpoMQJmlg5W3HDSQDS5EC6NFemThqmQ3mssSjcn4ghFeHZri+khK3vU1s0pKgnzcIADDyHIVK/r5zQj5Z+w1e8oltevbzqqF8MKGHyPGVKUWMaKR8+d7gKGCtgQP/V1pl5IjyZAanAdn0UXwQRrOinEtZacUHd5vTEAQdfbVplNW9r3vqHgBF8mES+XQDRtmv+omggQgu3KLF3tEDUuumgL/wXc/p+jzgOSlzSRie2+AIw8pNfULerg5VOE6Mryu9tEjlQwHHukoneixGeO+zHQYICCN89R59o9kTZHYhrvtvVtOn3CG2/G0DsZyNPF0MZZcwLrU+TpEtcy7/FnrdjiLXzwy1HDwCV76apzu2zl7B1eLvMQIZBFVGJ28RwjckAuPhuSFPvRccotl6mBBKJsDnCHt/BCL9hhQE1rmY5Lsdxayj9Nqdavz4/XHoL17ctCxMz89WFq00eb5LVb07ZzaTyYlJBAk6sHg5Vs6SRA4hiTOf8M5DKNbclfyiQVtNIYvXx5K0OAK0l3J9niz4RPXl4HhKHGYVZNrDS8mS6+wFV3NE7ZCOBMxKQ3IsbU5ABxRdGR/sPRu/Qe317dwQO1Bt0sbvoB8l/mISxeFY2cDlZUYG3PRFcmDTmGj1SKgUfDYTl5rkhUNtidU0Fs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w0UHzdeTRAUEZ3z0DiAJWG9i1GwjIQu2zf4kTyzEcNJ101CCaI6+FTVb2dXM?=
 =?us-ascii?Q?F/UV2UIGDOSBycNfMRrq3FooC/KES8zV0Z9g84Lc3qnV3VLZsPBbSy2cIQ8o?=
 =?us-ascii?Q?X3SaFze9W6oD2uFzlZpdF000fSsBNQovkdynorcUOJsAhw7WJqv2qt510hj0?=
 =?us-ascii?Q?XDPSk3mqIMi5dhCowuhd/+DTt85swtmM+fhyGHBiatrYhyeRyJOgV+f4rUKy?=
 =?us-ascii?Q?rwJDMogtltg4MFjsoA8IHtmY7rYQQMAljiJmqfXPY61c8bjLjqHwYI1/Yt0h?=
 =?us-ascii?Q?n2/FfQNhEFmnUCB2eUM9FPCLAFYQyDFBk6abvBea4UKSy2w5UpHRwpbaDmlp?=
 =?us-ascii?Q?rLHiGMBv+paw0NqdpGDvaci220LX9ey2mCNlFzEP/Xje85VMMts47yCt2pJS?=
 =?us-ascii?Q?/qMKWXgk2lhMPabYFjvwv2Lt6PxPZO49eWtB/2V4GVI1bC4y91c72ksCEaCA?=
 =?us-ascii?Q?q/0wlCihuriujPflGVlz1g3WfR29Eb2O5amDz92fJbTXGMarP1ZTJme4XV2j?=
 =?us-ascii?Q?mp+nXNS2e+DSx+3knMuK26s0gfSdLHWl+hgW6CpWW97z4Y1bgKC1ZADRbSFp?=
 =?us-ascii?Q?7GqiV5C/O24Tw/zEQy5FhvBZW4mq7gD8vFaOAKBbshJ7fAjLxT+qX5cmIunb?=
 =?us-ascii?Q?F75F6SZRSVRciIBcGmUhCoRtXu03JJmj70gTpwA4ccJg75fCtvogZO//sQPk?=
 =?us-ascii?Q?5PrTHK53gjz6gMKaTzsXkIt4qAt0SbvpaCuSRaOZSg2l/R3ZRt7MvI9rDnJd?=
 =?us-ascii?Q?VBnW6qIJURxFlUA3Bf9wiyCR3/tzeXw+ToCzq6QFL1kBzilLQITcZ6jCuE/T?=
 =?us-ascii?Q?cFxe2qwkOpoZ/0BliisHDQeA7TQB+mgZEXtiFTo62fGKUxMHL2KoGSTMRibl?=
 =?us-ascii?Q?nPm1vESSi5rPd5G0IpJbDdflCxZfKlfSFk7MdXeltWKk43htF/J3TMnBsk3Z?=
 =?us-ascii?Q?lrGzanXueERN331VBZzfwcGH5ZLi4q2v9PXO7b5K9EJ6AnjeJZBo+oaaLMch?=
 =?us-ascii?Q?YlvtjInDxzsAakVeQfH3wr4iTm84W7mhdZxhRCWVfAZKBUzWA8zk7CzMMHY/?=
 =?us-ascii?Q?mOsNK6wkHytB7GHxmKz8MX41c5QqE5S+kGp2OLwUEYa5UcxlRdeHLh8waRgw?=
 =?us-ascii?Q?EeYWtEjc5yMcC0OdqFRuEiUvqsjpNepAFbPhxNwGPMF4QD4ywReZG7wM1Dp2?=
 =?us-ascii?Q?0dYfUdITClSYtIwvVxFC6v+K1PQ8QpTh4opattQDsVD1EcWpaHdugpAPC5SS?=
 =?us-ascii?Q?LyyfumtQIfzzH85j8fXab3a5s/MZ2QLotc8k4TdTU8LBFRrtwvT7e+vOW8wa?=
 =?us-ascii?Q?gCIrP/wg9jzgPNpPSDwqEzlTkR0xEQfqDNypa9JmZCqbXxojb7eLddU3+vEv?=
 =?us-ascii?Q?YWRetlcXESq/0RbJTuGRTwsPXYyg8nMNfU8f/hP3XYput2Kg3g71TcUVrvtV?=
 =?us-ascii?Q?3aj+nC5QlKNk32tvw8edgmi3SPUsxv/4gmhMgg6QExuEbk+WnkvQVX2ehF2J?=
 =?us-ascii?Q?M14Vaz/KkrszdXS0V082jZBAD5o28X0ONy7IdOBbGt6YzB248ZIkYFXKCbYk?=
 =?us-ascii?Q?0FY/mU4T0xPD8H0kLkzZ9vbbv86Spkw49ZTKhNpJk2yl2UJMbq786SkLJpRM?=
 =?us-ascii?Q?wsQfseZtVGGJrAO+oCi8sNUg+PV4KTo8ZJ7yLV0cP85RFgrNRsHIao+J5kor?=
 =?us-ascii?Q?JMBhlkqZ8yKatkg75zxqgWlo3JAMliGYV7/+bAHioQVWCMVZik7DZ50Fi2DL?=
 =?us-ascii?Q?zGsImcTC0N83HLVaZQOdnRK69srJjKmdqeX4FoX4dJx0G0UvEUVi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: af2fd275-3d20-43f6-e244-08de74ddec13
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 02:22:43.1179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7w6Z+9DVZ0p+WF39PQ1j3TriZvYRUvpTmJc2XYvDqa+jKZfsmeTHvTL3Kh8JajVBk86Qs/rB+gb34DkJFsA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3452
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9122-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 5D3981A0136
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:50:41AM -0500, Frank Li wrote:
> On Wed, Feb 25, 2026 at 05:26:02PM +0900, Koichiro Den wrote:
> > On Fri, Jan 09, 2026 at 10:28:21AM -0500, Frank Li wrote:
> > > The DONE_INT_MASK and ABORT_INT_MASK registers are shared by all DMA
> > > channels, and modifying them requires a read-modify-write sequence.
> > > Because this operation is not atomic, concurrent calls to
> > > dw_edma_v0_core_start() can introduce race conditions if two channels
> > > update these registers simultaneously.
> > >
> > > Add a spinlock to serialize access to these registers and prevent race
> > > conditions.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > vc.lock protect should be another problem. This one just fix register
> > > access for difference DMA channel.
> > >
> > > Other improve defer to dynamtic append descriptor works later.
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> >
> > Hi Frank,
> >
> > I'm very interested in seeing the work toward the "dynamic append" series land,
> > but in my opinion this one can be submitted independently.
> 
> This patch serial is actually straight forwards. we can ask vnod pick first
> one in case have other problems. put together to reduce patch's dependency.

Yes, I see.

My understanding is that the originally planned dependency chain was:

  #1->#2->#3

#1 [PATCH v2 0/8] dmaengine: Add new API to combine onfiguration and descriptor preparation
   https://lore.kernel.org/dmaengine/20251218-dma_prep_config-v2-0-c07079836128@nxp.com/
#2 (this series)
#3 [PATCH RFT 0/5] dmaengine: dw-edma: support dynamtic add link entry during dma engine running
   https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/

I'm not sure whether #1 will proceed, as the thread appears to have stalled. I
might be missing something, though. In any case, #1 is semantically orthogonal
to #2, so I believe #2 can be considered independently.

Thanks,
Koichiro

> 
> Frank
> >
> > Even in the current mainline, under concurrent multi-channel load, this race can
> > already be triggered.
> >
> > Also, with this patch, dw->lock is no longer "Only for legacy", so we should
> > probably update the comment in dw-edma-core.h.
> >
> > Best regards,
> > Koichiro
> >
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > index b75fdaffad9a4ea6cd8d15e8f43bea550848b46c..2850a9df80f54d00789144415ed2dfe31dea3965 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > @@ -364,6 +364,7 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >  {
> > >  	struct dw_edma_chan *chan = chunk->chan;
> > >  	struct dw_edma *dw = chan->dw;
> > > +	unsigned long flags;
> > >  	u32 tmp;
> > >
> > >  	dw_edma_v0_core_write_chunk(chunk);
> > > @@ -408,6 +409,8 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >  			}
> > >  		}
> > >  		/* Interrupt unmask - done, abort */
> > > +		raw_spin_lock_irqsave(&dw->lock, flags);
> > > +
> > >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > >  		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > >  		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > > @@ -416,6 +419,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > >  		tmp |= FIELD_PREP(EDMA_V0_LINKED_LIST_ERR_MASK, BIT(chan->id));
> > >  		SET_RW_32(dw, chan->dir, linked_list_err_en, tmp);
> > > +
> > > +		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > > +
> > >  		/* Channel control */
> > >  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> > >  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> > >
> > > --
> > > 2.34.1
> > >

