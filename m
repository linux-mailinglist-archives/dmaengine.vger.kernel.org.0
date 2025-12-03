Return-Path: <dmaengine+bounces-7490-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E0C9F606
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id BDD133000942
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492EE303A35;
	Wed,  3 Dec 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aT/aw59s"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011049.outbound.protection.outlook.com [40.107.74.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329C3043AF;
	Wed,  3 Dec 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773773; cv=fail; b=DZjr9ZxBYLIZHcEBtPOSlvGFSCo+BxwQbdtmneRN0b5EHoULyGkNWzcDiwdav0co+xk/3QNhUU7EsY1EDfLALvFuH8pRky3mMvrXChYjdJxLkDHvyi6mHX1xvlSMTVlXRIqPZ+tonrmNd2qISfLmJvmYcaAwltsuMiwCw/3NYrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773773; c=relaxed/simple;
	bh=RYmnVaylwMGpM3RoHGb9+96KLXFFixwSYj6gxVeKtwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FSzmFlmSJvXAhnzK1J33vc3I5F6T3vJJtPUrgcGlEYPQrj5rWWOaSL6b80SXGR8v7UXcWDUtli70O7D2S9IUkFEWrqDSO9rQEyHGzdCdYPGyzFTFLXYsIvQYYAyEcaCsWgnvmGOID6TJG8XQKq4y6t9J4voxUYpB0WlnT/uQKx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aT/aw59s; arc=fail smtp.client-ip=40.107.74.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmKF9Q1KCkjZM6AGXZj++ig10wHepXe5pZwD6lO6AqQGxQiJJJ6U1Ln7q78pBbLNqSz5Gp8+RtFy8M1clnKuHUwyoYUHOifNkj8W6c4Wddtv47Oi3zl+Y2kRrwzel8un7fD2rZNOCfhxAq6L9qU0g5hsPA79XcJC3jD0azeXvAWBuTADsnF3AeQiwv/D5dcAIC4ULlBhsdKFdD0QuJ+RqlK1e62W6kbVIP2QHoaPhL1/RTpwbfkT8zOECXgv7xeoGfQAkKnKQ4wKYDbRCNy3YQWHwvCPi24dd/4eLCwvwkwTUNNEr23tqDO43JpN/FWHsfT69VsMkPUIncQ6PHynuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nF1q/2cEJR8UlMQEe0sK9kAz9tGjMBTEDzVX0+ihuw=;
 b=BPnce10SflvT0k9vNhj2ZHZ8GY7UX4OF8vcCl2bQhg77lluR6EaJbPjXUrsLs/0Te06tOTl1JLzPr+vAXUHXB/kjy3QON3aY7r9V26Hq89lncA8IiuZSKi5IVT+vHDePytcbo5OueCihCjpa3meeqzBSzLUsCzv2CWfvyEt6bIrKj+wKny8lrw5TXe6SM5SqGtYxg+mNrdNn3cDJoXXbN3QgAeh0BAhjkJpy6rc9hsKgTgciR7OJdb4ww9EbQzVYgIa9y/ExWn2gAC6q1sIlbTRyk5BC9y9BFvVQ1LqChI+vsPhONoKJAL0mLhZqDq+D/P2nLP4qDKNxP8xf9ZEBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nF1q/2cEJR8UlMQEe0sK9kAz9tGjMBTEDzVX0+ihuw=;
 b=aT/aw59ski4Pa61J9TbP7cvrLewSK4hf5KKo/oA6GuepzTcGcXPefJ//BSXxFYNac47QjWSpvyaccbOnm1Db5HVgNWR4mzalC1gwcTdAqmAi3bEhkgY9vUwVltcKQWPQqgAIRvxajaxPoywnYqqvr42QIr7uf6NEpns624vZSmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY7P286MB6817.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:322::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 14:56:07 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 14:56:07 +0000
Date: Wed, 3 Dec 2025 23:56:05 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <6acrh23nnjc6exrcvbrc4ce42iwlikdotr2k4drzovaw6zuzg3@yt56kjrcg7gy>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS6H_6gBEQjmQUG0@ryzen>
 <mb2tkza65fj77i3cjs7t2lrcrxnlesn7aibf46zq3c3fahjp7i@2hcziakdeo5s>
 <aTAOoWRYMk1qZG0B@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTAOoWRYMk1qZG0B@ryzen>
X-ClientProxiedBy: TYCPR01CA0187.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY7P286MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b81997-ad78-4a76-f9a6-08de327c16a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QqGX8L+qUktzpUa+C0NGfZRN+aPy4GdFF1s1ceJk41H3yNpP1jLuJuUJaU/D?=
 =?us-ascii?Q?KISPnbf7lPr5Ylnw8MCHzLNoXaq0An49Gz0YPyq3bWBMFEeQeNdEwL4IZbRS?=
 =?us-ascii?Q?83QGLZbxzK2CM7DGCHdeEHIb1imMRxOwmPxwKN1cbgKemo5BRFZ1hMtF7/sQ?=
 =?us-ascii?Q?cFH173gYrAyYiJwQlPg0g4uK8vxvyMFXZGMakZ6u/ivlm7v/htX/dmU0Iy3X?=
 =?us-ascii?Q?LtdLppsjEH5uBMrAzwrBQMdZg/ybcuQQW8BrT/X8Xzr+ePD1YSxAHex+nljW?=
 =?us-ascii?Q?9pESmqv4dO4gxqRBlMt3BOKvCNMFjJOW6IYT1zH5ZDDVCzW66oIfxTFqKqwu?=
 =?us-ascii?Q?74nvc6dwQIExzYzuEjOypWM9k6CT8QGAzniQU7VB+coBLXinW8Sx912ZEUfO?=
 =?us-ascii?Q?M0IXitDRD5GxmG7G9G6kIpKTmvMR9GNxjqEtZCF+XlrqnrGJW2AFnaGH8b/t?=
 =?us-ascii?Q?ZXWJdgB6qVhUn5wJOCnG6kpsKzVQKv5y9ngKj/GDT1su9MqIg+0QXBOt7UY1?=
 =?us-ascii?Q?udi57mxNC8+fpwkHKtPK3MKD0QC5xYF2M4l15QIwnO9cj+X6EYpFX9FmkbfH?=
 =?us-ascii?Q?XeXa1H1MEdiIjqnrFUpCJJKq/eLuxG8Nw6poMcLZ2iRzKaXRilCo8CW7qEsj?=
 =?us-ascii?Q?b5vZBGlwTDs73AdQbyYP1ovj+SO6V2Lzs3xFDZcZZK1nhQ2P+9j0tDLswXjI?=
 =?us-ascii?Q?dK+3C3R+yyaE3+gwMuH5KR7MZu0aUt3ZKq6k+FSV3M3MJDwt75Q7SvsEuAbe?=
 =?us-ascii?Q?+1xWtB8nOuHp4y25zR05EN7Bv/42YtFifCaTNEZ3h99DaNP7fHR9LaXPUaGP?=
 =?us-ascii?Q?EQc6+5qevV15qV8bkuB2rTMnrgFwkxUh3A+jqoJqIPXe+snDq5DppW7u70m1?=
 =?us-ascii?Q?D5NOvJySKXHwmDudzotfLc4aSYd3g+Yyb9uVKDh8nTH/Ed6QF6VCTd+Pbav0?=
 =?us-ascii?Q?cINg+osViMqW83yg4Chq/+Px810VN70WEnYDy2k0roPPHg0HbT7feU9724Ea?=
 =?us-ascii?Q?TTiU8ZB0XQqVv0HoUYT24rE7jjZa/bYn3xdw2/2ctS6Va7ASBmkB2qEWMQ72?=
 =?us-ascii?Q?kio5a3UUAg06AZ/eKLFWnsus51ASxsYWLd/NNeVvIiWSsYt7vott1YkOX1As?=
 =?us-ascii?Q?bidEafpZlyVdPuTZynLkHcUG2J3AtzdUG0jKXxCd4nHIAY81wq6Unxzkp84j?=
 =?us-ascii?Q?Ef8DVU7z37ypyMd0CFM4+4IZ6M9YI+Di4M97qISe4DiqXh+qFmRqvGCtxAtG?=
 =?us-ascii?Q?M5WvlLjGSTwyYWIk3TyEZL8D56n7FZAfWyiF4mnQz/MD/qj/Q0ceAEFKaXeR?=
 =?us-ascii?Q?rlcwW0qhDNzLmHxG5oz8PNh+1iof+dqlNe4ihRzkGYnAQXGSd+QoW/bIlgrq?=
 =?us-ascii?Q?nAYaFYm8cdpzOaEEMJb77CmWY3MX6JHNHXdOVZqVyTydM3BIU0oq25epRKSK?=
 =?us-ascii?Q?POlv3AoBB3s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pk9nco76Eq+4CD8dyKcegb+pEh23Nw+YIDKxHPjX8EXCeM/OTdoUgke1c319?=
 =?us-ascii?Q?QrOT0sGJXwpFHJC5uwabeYP0ud2zxgp9aW5rqhWOwZqXHA8SPPMR/qpnl7Ul?=
 =?us-ascii?Q?HJMi3Zl68+bSf93IommkFSBn7oqH67PTlnNB+eHYMfTHo2L8fb+t3Lb2UxEp?=
 =?us-ascii?Q?0tAUl5u4X4Zj7DtVg3a5wA9CZphxyd1ldepAT3V5jXIM8j65I8Jrsz3sFjqH?=
 =?us-ascii?Q?VQ6NTJZAm9C04uo6uVqFS8y6L6pEPpsE62CJSwZffWVpKsD7SFB0iZK1U3BH?=
 =?us-ascii?Q?1gY7wVSE4c4vGPtqqXiUs04f2+YdIIODK+j2R9tg0YlhN0G/vd8TWHebe6So?=
 =?us-ascii?Q?QS/ucVlFgP5uSlJNLYItfBXAiPLdvHVqgmJovQiMudyHIpcWJLxW5pe7nSXk?=
 =?us-ascii?Q?lpktwZNTFdWrsj4V2HAxq+wqO3iZqDUCizT8Mb6SbZn70unza7U2JUYB9F76?=
 =?us-ascii?Q?eknppM8qIlCBmokaTmcROO1QrJ0lQ4U6XJw8PVUD2Il6bXeuXGJd3j4xo7Hp?=
 =?us-ascii?Q?q10BCvDqeTs9xzC9OyiyqiFWmkvNuQcKD3T/bYalrdcvmSDX504BN9stqs5l?=
 =?us-ascii?Q?yi0w6DLtIcC5ez5T8fSSVnPeWmD3yZKvmFa0kMTnsOdECLiMTEttyGteDCiP?=
 =?us-ascii?Q?/uSPKfCxfbw+Sbqq3dX5hTaVGrO9e2K/XRcfxIYsF1iGbtKytWCF4AHK69r3?=
 =?us-ascii?Q?IPBk1/0/C7h8GhKmTjdcpbwLOtWE89UQM9fc27VVYVlTUjYgsOdOot9iT0tb?=
 =?us-ascii?Q?FdJtoMr/Q4/baud9MkXp2LJ/rp7MebAtTDsfx9iElAaTDPQBuYojAN3Wi3di?=
 =?us-ascii?Q?3sqxNWThgso8P4PsvRR3AYYI0I/BlBJF4637Zle6XlxVf7cCV2/jIZmOAy5y?=
 =?us-ascii?Q?B05FAlP9ug1CuN0a5L+Ek7Zp+r81dNvpQwGoWsCyXevTTRRpW/u+JUQIASsT?=
 =?us-ascii?Q?U8lc+o1t0wbu0OXE1lFv+bygbAlKSclyFexAqTDWVOcI/PG3nKgvqAAYZw7B?=
 =?us-ascii?Q?Ajft4H4N9qrnhFjjxB1HabKoj/GqJ+1R/4ta8VgybpZsNCyYwhJDRNJg4ieM?=
 =?us-ascii?Q?wzswPgJ2JcJMpP9OOPI8Rj1/5WOSjjRLkYA7cDXeNk+ll/maiujQWFmR8z8n?=
 =?us-ascii?Q?nNOIcw9EH5gkxHxUl7JkfBNgKhCzG18G3nXy91yadJ8Ze9i9Cay1ltqHGES1?=
 =?us-ascii?Q?X+bfPsMjCPr+DmqWu5YsnP6W+kndNdq2pO6GjTh3Cx8KJ9UqDcT3tfzWgtQA?=
 =?us-ascii?Q?sA1D8cFdJItLDkfZV55WvHyvgb8T2FYzozvpDga9nCkiO45XIreov9yLHHA2?=
 =?us-ascii?Q?6ZAIUIhvjC0kHFu9hUHOjGFMNq/M7nQ9NQtf0aVcuemlTgGytIFx2gKMfVIV?=
 =?us-ascii?Q?OLyOollU1ptsQ5/5oNlu5HhnMOD/svP/OgLDBcXKqpbPDqeT5SX9tKNgE5WY?=
 =?us-ascii?Q?n6MJkMifR2EIGOcc3mSmyTCeh+Wj9a5GuGrT+oCq+1QR3mXfWbK0aWQJuIWn?=
 =?us-ascii?Q?+rB5zAYxVfeyUgLsJGwJzgJbu3H9tjd5HhVQ6xrVhGZbPrreUFGBsgpTUy1M?=
 =?us-ascii?Q?YMEgYEYpt1+Ua0XIN2LxkSu15ncE4vxQcPUCoc30sp04f43vcnnQb5KzcRrz?=
 =?us-ascii?Q?v7w+L8A3Kds8S0GELXC/HVw=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b81997-ad78-4a76-f9a6-08de327c16a6
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 14:56:07.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoREdbEMjT3VTkdqLraYIWEoPqOoEv6THP/cC9M41ly4Of+gT482cuZF3CfIgrHbJxeqCZyQr4YJLeNHPvAPxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6817

On Wed, Dec 03, 2025 at 11:19:13AM +0100, Niklas Cassel wrote:
> On Wed, Dec 03, 2025 at 05:30:52PM +0900, Koichiro Den wrote:
> > On Tue, Dec 02, 2025 at 07:32:31AM +0100, Niklas Cassel wrote:
> > > On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> > > > dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> > > > for the MSI target address on every interrupt and tears it down again
> > > > via dw_pcie_ep_unmap_addr().
> > > > 
> > > > On systems that heavily use the AXI bridge interface (for example when
> > > > the integrated eDMA engine is active), this means the outbound iATU
> > > > registers are updated while traffic is in flight. The DesignWare
> > > > endpoint spec warns that updating iATU registers in this situation is
> > > > not supported, and the behavior is undefined.
> > > 
> > > Please reference a specific section in the EP databook, and the specific
> > > EP databook version that you are using.
> > 
> > Ok, the section I was referring to in the commit message is:
> > 
> > DW EPC databook 5.40a - 3.10.6.1 iATU Outbound Programming Overview
> > "Caution: Dynamic iATU Programming with AXI Bridge Module You must not update
> > the iATU registers while operations are in progress on the AXI bridge slave
> > interface."
> 
> Please add this text to the commit message when sending a proper patch.
> 
> Nit: I think it is "DW EP databook" and not "DW EPC databook".

Thanks for pointing it out. Noted.

> 
> 
> However, if what you are suggesting is true, that would have an implication
> for all PCI EPF drivers.
> 
> E.g. the MHI EPF driver:
> https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-mhi.c#L394-L395
> https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-mhi.c#L323-L324
> 
> uses either the eDMA (without calling pci_epc_map_addr()) or MMIO
> (which does call pci_epc_map_addr(), which will update the iATU registers),
> depending on the I/O size.
> 
> And I assume that the MHI bus can have multiple outgoing reads/writes
> at the same time.
> 
> If what you are suggesting is true, AFAICT, any EPF driver that could have
> multiple outgoing transactions occuring at the same time, can not be allowed
> to have calls to pci_epc_map_addr().
> 
> Which would mean that, even if we change dw_pcie_ep_raise_msix_irq() and
> dw_pcie_ep_raise_msi_irq() to not call map_addr() after
> dw_pcie_ep_init_registers(), we could never have an EPF driver that mixes
> MMIO and DMA. (Or even has multiple outgoing MMIO transactions, as that
> requires updating iATU registers.)

I understand. That's a very good point. I'm not really sure whether the
issue this patch attempts to address is SoC-specific (ie. observable only
on R-Car S4), but I still think it's a good idea to conform to the
databook and avoid the Caution. It is also still somewhat speculative on my
side, as I have not been able to verify what is happening at the hardware
level.

Koichiro

> 
> 
> Kind regards,
> Niklas

