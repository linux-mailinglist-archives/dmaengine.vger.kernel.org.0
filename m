Return-Path: <dmaengine+bounces-8417-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CzEAtw8cGmgXAAAu9opvQ
	(envelope-from <dmaengine+bounces-8417-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 03:41:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E61DA4FF2E
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 03:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8F225CEE89
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26C340D90;
	Wed, 21 Jan 2026 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jus5uKhk"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021119.outbound.protection.outlook.com [52.101.125.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84434216B;
	Wed, 21 Jan 2026 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963211; cv=fail; b=qd46Y9IVNs9D9lELCOps2G0GtPLak/5QS5nULovvLXkl8XpWQigjw48b3n7xd57Sr4jnR6ZM3HhG9UiobKZ0CsQxUwtN9RKHmbHdMN1aGeJpkeGh3d/Z4o/UQEvDv5m7sKLuVbUmth331IT89f+vBXIE9ZdeII1Yz3V9Hp3gxRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963211; c=relaxed/simple;
	bh=ecaxOtmbvboWzDu2NV6kulwOqVe3IM6yEfwSCoQkWp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CFtAa8NFId9zBeuOglYYdbNm1zLR46NTIK4kFT5YbWf8z+EmZburMkVvtVJeVuRdBh79luLmg8RKYTpENHLmn2FJdcdgL49S/4AErLUlat/zFnrZE8BO78lbfWhCAw1mM8Nt+N6pxAECsfWIOuWO5eRaieM13SClK+TXW2kbp7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jus5uKhk; arc=fail smtp.client-ip=52.101.125.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpcKIma+IuV7FvQWtHTTH58Egx91myjJ+PRc36NyfvZDyuJXJSBieqLWRZmsSPUOR5mxbyk9TOg1elHyxLq+s9lxaVdGv8ev6W5PDihAwUzd7Yvt1NPznk0LOT5EA26gjv+ZbGACJGwuz7vvhvnN09S7CcxA+Nw3Ni1Zc3gaLtg+vSJRnuSdb0u4obq5x8xTXD8ZlMiYxGEFixoKRdzUDXQPTmvlMDjLxtNA7kdw8eX7axJHfJLaKPn2Ws7QIbkTexmAq7/Z7QhNXunFOKVN7vhzftIiQMYeo4nL0h9/0g/sXkKh0e1y46d6pFewgolzleXXn2hhi7GB2WoB+SB+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynxWwIqeGRZ8N40fsPTgX4x6Pt1Q+UibM9nW8Fp8PtA=;
 b=SUFNMOzKnaFviFyrbA63WH/61tHClf29kKiwCDw4VCZPdzdZtV0NNGgmuQcbQelyjIoUvK+5//TZsXgMbg5e0oYiNvV4Ah/diNy1H8tRqjYE91QAuobxKDoKMCse+UMLeNxo4x01N1gaR3dpZoUgbrU7ZIl/G7uplznrmzDOQzluI7VTq17unN22mPETSae2flqR7bkzlonVyZYlRw5T75ReGZoPrpmA0Wgh6hGhoUeLzlM7yTQVHGFpLmptJX+KEA57/Vj1vE3Z7MSRLH8WtxE7UhY+MTigelpYAOoAq2VABtvenNvTFBjShj+f+9HrvLLSIuMKlLwvLO3w9vBE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynxWwIqeGRZ8N40fsPTgX4x6Pt1Q+UibM9nW8Fp8PtA=;
 b=jus5uKhkiPCzVpb1t5tOw/eXVxfed1dcD1oTJksUpCfOIUIcXKfqlJAy1KlxsuaWyVi0MGjpF6hcC8nHDBN0Ih+Zr9A1M5r6GWWA+eQKXwlw6GHVEpEY/Ma+e13JrUHR2YfGmYc5EAoeEHZVOIBpM0Lf1bLMAe4VhoA4KgN/03I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB4711.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 02:40:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 02:40:03 +0000
Date: Wed, 21 Jan 2026 11:40:02 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Frank.Li@nxp.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
Message-ID: <n66x766qqxixppfxmjweybavomjxpdsty3hxrms4pyexetecls@gfc3ycmlnxpd>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <120e42c4-9ba8-4f4b-a06c-61888fc961d1@intel.com>
 <cfc0d357-18c3-40b8-b355-0055bd82bac8@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc0d357-18c3-40b8-b355-0055bd82bac8@intel.com>
X-ClientProxiedBy: TY4P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB4711:EE_
X-MS-Office365-Filtering-Correlation-Id: 763410c5-a986-4ad7-2924-08de5896611b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T0sPa2aFj5b5zZsFkLBwu6HmZGspjSIAS2pQCP+qLmIYah+N7MZxeEgJkpdD?=
 =?us-ascii?Q?IoiwQ/MJUu3q0I4PhpElvsrHYSCEvthKrHWcG2fkEVrhIusoh1nwwj+8Ph+n?=
 =?us-ascii?Q?35DSlLxgfcO1SrrZoIOHZ+rnvnIO1lRJz6O2/4c2cv5QvKRXJleZY0CVN0Ch?=
 =?us-ascii?Q?0NTzyosp87YfnJ+80e243hS+HA5ewBW4GhANV10x3bWSC8u1FVn0qQusORhz?=
 =?us-ascii?Q?Z6B5Y/xnOP/b9LzB9HgIaz8khKlbY38BYeYlXZrm4sovE/5CLyteGZx52s92?=
 =?us-ascii?Q?5kiVUepR4NN2eND3B9pmOLtx3y1yQFu+43EIk4n8Nadkrg5Y5hQxPxQ1h6gf?=
 =?us-ascii?Q?NZsTcpu4mDOoLF9pNkjkMA3mr6wUv0DTRy+jmu3QdbV2v0AvGuYlSOk2X58h?=
 =?us-ascii?Q?X3hBDxUK4B9mAq4VjzjGirjLQpAf7A+6uhXANX/U21QG71yAEqeXg1eWI4un?=
 =?us-ascii?Q?BFx1xooERsgPu0aLBCjBhpq0+5o9J1Jo8BGj8W7P/H2Uvo8m4kcZb1E5H/Ig?=
 =?us-ascii?Q?Z/EwBuQJxRE7PXpdgIfmbLxTPeTnn0njOAS7+nvOP1DsUkU/WDXaP9QhNaH4?=
 =?us-ascii?Q?T0gN9yC5CmlztDGOx+i6ZLv3tT6dUvj6NgIouZQFS/Z5YtG0bmtOknq6WsKV?=
 =?us-ascii?Q?Xvy5WPaOSs//3A4/1eaf3y37RaoSqbICct5BU3h44zvh5V3v23oKHoKz8Efm?=
 =?us-ascii?Q?Ccmcf4e4Gz7TC6w0J67J227H/c3pCGqJnXzCQNbMBJiLV55FVpTSrM9WJL2N?=
 =?us-ascii?Q?89TP0jrVvM3eUDVyZXPSQxLxpG6pQI3OCQQSgZVvv6ZFl5k0MYC5lZJVy7qp?=
 =?us-ascii?Q?Mr1WEtWba0bLj454fUZ2F65jfnkP6SB2MdZCkU1aT4nlytZeYdD6GHj82wp6?=
 =?us-ascii?Q?W6I4CkG6qRsX5wol0Qimy3nGPJQPLaSrqJVLB80/oBgr0ugAavj9UjuPhGYP?=
 =?us-ascii?Q?OtRe3MwR9fwq+YN7S2hfPMWW4/KbaAfQm+Vjr4Cr6sD7TFznuP97c/FAOE3E?=
 =?us-ascii?Q?3Q7PG9HssRqjnovw95gYgITuoggr3eWLVi6MNH5UisWBUVvzLbrlxatfFR4x?=
 =?us-ascii?Q?bstMLfPxJaCZp/ht3Y+FwzoDiACYkwK970x/Z7hu131cRwY5c/uml5fxhs3c?=
 =?us-ascii?Q?dZPrplViVDdI6kQa2WRKAESu3uG6+wcrDfpK9slQtJmSQv9VYo+UOi/L7xgM?=
 =?us-ascii?Q?R2yztgjj2EvTByCTpUH+eGBgmV1emZTd1JJ1n9gcibFHBw+a0iewbx/kemVh?=
 =?us-ascii?Q?qJfTeqeSpkE6QNtM0iy1eyVpiG8wcRj1el+zZ1AyR7hoQO8d+ED63MEQcN53?=
 =?us-ascii?Q?av0Oaxyo47BhAl1Wr05lLNZa6+OfKzzCw0ngtKkiADETv+fUif7zRrfqZPYq?=
 =?us-ascii?Q?AqlLpFNG7adejblcJt2nWXcIkyxyGfYgCX5bTgIdGMZcCbCxBYoS32LwDj0i?=
 =?us-ascii?Q?FQicACNctObQkfljFrbMvrZENZ7rUTkHvX7zBtl+d25rBbKi8f4VicElYpzT?=
 =?us-ascii?Q?rsWtwnnOisCQbFJoi4b8V3nawQXKXjk2OPQgPkNyD/Z64d0y63LasKpt0/Vl?=
 =?us-ascii?Q?f88zmqHnGuUWnOyqPao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2zg7NPKsK4vGoIX0ZUGMPgHPg3QbqWz/RDj+y/xFug6foQQbPc5aWDJlqfQE?=
 =?us-ascii?Q?o5Ze+M1StBj+rBWOc1SHa1H/cj4s151dOmWZNTcV8Rw7/NAnnbNn6uXCOLtl?=
 =?us-ascii?Q?REbuKHX09DYGW238WGxRVTWP0gIdc/9oBiunSX/t3NhQfQ2OnMDNF6XbUhPd?=
 =?us-ascii?Q?JfkzXE+T88t5fAKFMN/ScgnfC/H6vJlYuZ7952jBTqSyMR6YJE3IA3cV+lty?=
 =?us-ascii?Q?bQZsqG205T5HKnDcM0Hv7NO7Oey8kYr0PlwLUqccNCkiefBe3hXx1THAJ0p0?=
 =?us-ascii?Q?tVZIvg7QFSWUWpCbhU8XagSq8Z+Z1ispvREKwuSe8uTbeQS39tyYtrci1Zer?=
 =?us-ascii?Q?uJdVNU2HiS66TN8QH4+uRAWJUn9fjwgbNV9OK/HbB6CNLH7ufDvSUehRbVa2?=
 =?us-ascii?Q?tCsq05JlDVrZbKY5neZazuQ5pajqdPUEMJNA40xWe0ab3Z59O+LQZRGrjPSQ?=
 =?us-ascii?Q?WRTr7gNuntYms9xd7vcxL3h5ZcO28ckdVBYUl5ERwV2H3tRTzeG1ZU0rchEL?=
 =?us-ascii?Q?nfIRCnEzaUY6qOKdzSK4DMWTy0Fl9x0S26JOSetxzEh9COgZu5UoYHyk1OqM?=
 =?us-ascii?Q?gqb03uvAjnjhNyWYDyOzPgJinXs4Yi278Mv6cGv5MLcqpiv2E4U8MoPCoVMx?=
 =?us-ascii?Q?UclL9KJp/7+oZTyAiphCFbhISJlor+xgLXh5zXgPPcNEjyp8IRw9Vq92Ypt6?=
 =?us-ascii?Q?dvL3iEquPZBrlb6V8wJmKbcCen8zb+h3DyGtAk30864Jti/mMH9ioieGPPPi?=
 =?us-ascii?Q?ksfRvTJ2UUU5LNNOAB++g9OKc2QiV4z9U5SHhp9O5aam6XMxH9IJGdV3x5PM?=
 =?us-ascii?Q?l5Ig/77lw3jruKtH4EoIBpjS5fLxrRrcg+LJw2v1ljil0PQ6AWHWY1v/CGDF?=
 =?us-ascii?Q?3M2yVPCsT/LnN8svcdaALv6S61VyUDMPXw6skp0qxvDuD4r7x5Q6sBl4PqvU?=
 =?us-ascii?Q?oadO1DnDT0GHsrZGUqFzVwlE0SkJkBuLhRkalcM/B2MSfyPNBYuZPpX3/0Q4?=
 =?us-ascii?Q?VeQiffOMljSfZaSoGV/LGXzCT5Efw/nlwgY5fdRgCpgFZGGqOoDp6jKV16QS?=
 =?us-ascii?Q?HooT/q4TClvEo91uPAjMBxvlK8/zMOqxQkvcnu2a0GS+bUwrsha1TdC2Mtp/?=
 =?us-ascii?Q?unb8y5DgTggpwu1lj05uA1e7Dz/P8o++stJ9QrV29eEcHWd5wlgo3NcKVKZT?=
 =?us-ascii?Q?PGH1zUjiBSQiFMaopywPsAfoRaWYvrjRjtD7Y+exa2tkU7qvroypQSZl1Q0N?=
 =?us-ascii?Q?cmvCMjC+ZO1cJxkbzc3VY2zIGfXpKKTjnJvo7RdXVjgiaWAXM7QGg8BlskkD?=
 =?us-ascii?Q?1kv4kiMOAV1MQfQEmnHSvpcjtO0PNrhF9p1r2Xdmy9nWQjCKkDVKHgrPbPS8?=
 =?us-ascii?Q?R1xNJcTG4wVcXhqYPuDtAkIAje+2AS8e3CLy4jw5PZxrZBNHH7p57g0uRhUk?=
 =?us-ascii?Q?RPxj44cLOBNfpEQJOXVzNkPGAVgxPZkMptHI+HWujer3we3KkS0UDPMoRC5d?=
 =?us-ascii?Q?AKoUn35K/Gdf94oRaHv2h212caGiHCpQefXR0YtscWV+pTG8pYSTj6tDMuxe?=
 =?us-ascii?Q?Y+MC9EIR2NRUdFlDEo5Ot+nKeak3FCV2Qt7TdVHxnrbRFldhxX9MzCCXfUQB?=
 =?us-ascii?Q?diGyP9/XEjD3aV2t4/gaG1jnfx10ICXum8On1M3DzMtC4IuaNSFChOXW7slU?=
 =?us-ascii?Q?QlIEZD8Ut2OgsGCqEpcLsAnhhKm9A+44BVrCPqmYsBH13NFu6fwrCndlPFiO?=
 =?us-ascii?Q?5HjTIJhUV4R5RANbjT9zMeXfEzPhXVkKDcvZ5VbM0Mse12hh8m/5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 763410c5-a986-4ad7-2924-08de5896611b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 02:40:03.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMiUUT9QqxLTSF41LREU7sCY18kiUWjK8oms2P6xCo6vRX28VDTJwxB3/pLNTHvZ5FutVVZOtlDhzWGZckRQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4711
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8417-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E61DA4FF2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:47:32AM -0700, Dave Jiang wrote:
> 
> 
> On 1/20/26 11:30 AM, Dave Jiang wrote:
> > 
> > 
> > On 1/18/26 6:54 AM, Koichiro Den wrote:
> >> Hi,
> >>
> >> This is RFC v4 of the NTB/PCI/dmaengine series that introduces an
> >> optional NTB transport variant where payload data is moved by a PCI
> >> embedded-DMA engine (eDMA) residing on the endpoint side.
> > 
> > Just a fly by comment. This series is huge. I do suggest break it down to something more manageable to prevent review fatigue from patch reviewers. For example, linux network sub-system has a rule to restrict patch series to no more than 15 patches. NTB sub-system does not have that rule. But maybe split out the dmaengine changes and the hardware specific dw-edma bits from the ntb core changes.
> > 
> > DJ
> 
> Ah I do see your comment that you will split when out of RFC below now.

Thanks for the comment. You're right that the series is huge.
Should another RFC iteration turn out necessary, I'll make sure to
keep netdev out and will see further splitting. (Though I don't think I'll
need to send another huge RFC series, as the usecase scenario and the
overall picture seems to have already conveyed.)

Koichiro

> 
> DJ
> >  
> >>
> >> The primary target is Synopsys DesignWare PCIe endpoint controllers that
> >> integrate a DesignWare eDMA instance (dw-edma). In the remote
> >> embedded-DMA mode, payload is transferred by DMA directly between the
> >> two systems' memory, and NTB Memory Windows are used primarily for
> >> control/metadata and for exposing the endpoint eDMA resources (register
> >> window + linked-list rings) to the host.
> >>
> >> Compared to the existing cpu/dma memcpy-based implementation, this
> >> approach avoids window-backed payload rings and the associated extra
> >> copies, and it is less sensitive to scarce MW space. This also enables
> >> scaling out to multiple queue pairs, which is particularly beneficial
> >> for ntb_netdev. On R-Car S4, preliminary iperf3 results show 10~20x
> >> throughput improvement. Latency improvements are also observed.
> >>
> >> RFC history:
> >>   RFC v3: https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/
> >>   RFC v2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
> >>   RFC v1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/
> >>
> >> Parts of RFC v3 series have already been split out and posted separately
> >> (see "Kernel base / dependencies" section below). However, feedback on
> >> the remaining parts led to substantial restructuring and code changes,
> >> so I am sending an RFC v4 as a refreshed version of the full series.
> >>
> >> RFC v4 is still a large, cross-subsystem series. At this RFC stage,
> >> I am sending the full picture in a single set to make it easier to
> >> review the overall direction and architecture. Once the direction is
> >> agreed upon and no further large restructuring appears necessary, I will stop
> >> posting the new RFC-tagged revisions and continue development on
> >> separate threads, split by sub-topic.
> >>
> >> Many thanks for all the reviews and feedback from multiple perspectives.
> >>
> >>
> >> Software architecture overview (RFC v4)
> >> =======================================
> >>
> >> A major change in RFC v4 is the software layering and module split.
> >>
> >> The existing memcpy-based transport and the new remote embedded-DMA
> >> transport are implemented as two independent NTB client drivers on top
> >> of a shared core library:
> >>
> >>                        +--------------------+
> >>                        | ntb_transport_core |
> >>                        +--------------------+
> >>                            ^            ^
> >>                            |            |
> >>         ntb_transport -----+            +----- ntb_transport_edma
> >>        (cpu/dma memcpy)                   (remote embedded DMA transfer)
> >>                                                        |
> >>                                                        v
> >>                                                  +-----------+
> >>                                                  |  ntb_edma |
> >>                                                  +-----------+
> >>                                                        ^
> >>                                                        |
> >>                                                +----------------+
> >>                                                |                |
> >>                                           ntb_dw_edma         [...]
> >>
> >> Key points:
> >>   * ntb_transport_core provides the queue-pair abstraction used by upper
> >>     layer clients (e.g. ntb_netdev).
> >>   * ntb_transport is the legacy shared-memory transport client (CPU/DMA
> >>     memcpy).
> >>   * ntb_transport_edma is the remote embedded-DMA transport client.
> >>   * ntb_transport_edma relies on an ntb_edma backend registry.
> >>     This RFC provides an initial DesignWare backend (ntb_dw_edma).
> >>   * Transport selection is per-NTB device via the standard
> >>     driver_override mechanism. To enable that, this RFC adds
> >>     driver_override support to ntb_bus. This allows mixing transports
> >>     across multiple NTB ports and provides an explicit fallback path to
> >>     the legacy transport.
> >>
> >> So, if ntb_transport / ntb_transport_edma are built as loadable modules,
> >> you can just run modprobe ntb_transport as before and the original cpu/dma
> >> memcpy-based implementation will be active. If they are built-in, whether
> >> ntb_transport or ntb_transport_edma are bound by default depends on
> >> initcall order. Regarding how to switch the driver, please see Patch 34
> >> ("Documentation: driver-api: ntb: Document remote embedded-DMA transport")
> >> for details.
> >>
> >>
> >> Data flow overview (remote embedded-DMA transport)
> >> ==================================================
> >>
> >> At a high level:
> >>   * One MW is reserved as an "eDMA window". The endpoint exposes the
> >>     eDMA register block plus LL descriptor rings through that window, so
> >>     the peer can ioremap it and drive DMA reads remotely.
> >>   * Remaining MWs carry only small control-plane rings used to exchange
> >>     buffer addresses and completion information.
> >>   * For RC->EP traffic, the RC drives endpoint DMA read channels through
> >>     the peer-visible eDMA window.
> >>   * For EP->RC traffic, the endpoint uses its local DMA write channels.
> >>
> >> The following figures illustrate the data flow when ntb_netdev sits on
> >> top of the transport:
> >>
> >>      Figure 1. RC->EP traffic via ntb_netdev + ntb_transport_edma
> >>                    backed by ntb_edma/ntb_dw_edma
> >>
> >>              EP                                   RC
> >>           phys addr                            phys addr
> >>             space                                space
> >>              +-+                                  +-+
> >>              | |                                  | |
> >>              | |                ||                | |
> >>              +-+-----.          ||                | |
> >>     EDMA REG | |      \     [A] ||                | |
> >>              +-+----.  '---+-+  ||                | |
> >>              | |     \     | |<---------[0-a]----------
> >>              +-+-----------| |<----------[2]----------.
> >>      EDMA LL | |           | |  ||                | | :
> >>              | |           | |  ||                | | :
> >>              +-+-----------+-+  ||  [B]           | | :
> >>              | |                ||  ++            | | :
> >>           ---------[0-b]----------->||----------------'
> >>              | |            ++  ||  ||            | |
> >>              | |            ||  ||  ++            | |
> >>              | |            ||<----------[4]-----------
> >>              | |            ++  ||                | |
> >>              | |           [C]  ||                | |
> >>           .--|#|<------------------------[3]------|#|<-.
> >>           :  |#|                ||                |#|  :
> >>          [5] | |                ||                | | [1]
> >>           :  | |                ||                | |  :
> >>           '->|#|                                  |#|--'
> >>              |#|                                  |#|
> >>              | |                                  | |
> >>
> >>      Figure 2. EP->RC traffic via ntb_netdev + ntb_transport_edma
> >>                   backed by ntb_edma/ntb_dw_edma
> >>
> >>              EP                                   RC
> >>           phys addr                            phys addr
> >>             space                                space
> >>              +-+                                  +-+
> >>              | |                                  | |
> >>              | |                ||                | |
> >>              +-+                ||                | |
> >>     EDMA REG | |                ||                | |
> >>              +-+                ||                | |
> >>     ^        | |                ||                | |
> >>     :        +-+                ||                | |
> >>     : EDMA LL| |                ||                | |
> >>     :        | |                ||                | |
> >>     :        +-+                ||  [C]           | |
> >>     :        | |                ||  ++            | |
> >>     :     -----------[4]----------->||            | |
> >>     :        | |            ++  ||  ||            | |
> >>     :        | |            ||  ||  ++            | |
> >>     '----------------[2]-----||<--------[0-b]-----------
> >>              | |            ++  ||                | |
> >>              | |           [B]  ||                | |
> >>           .->|#|--------[3]---------------------->|#|--.
> >>           :  |#|                ||                |#|  :
> >>          [1] | |                ||                | | [5]
> >>           :  | |                ||                | |  :
> >>           '--|#|                                  |#|<-'
> >>              |#|                                  |#|
> >>              | |                                  | |
> >>
> >>     0-a. configure remote embedded DMA (program endpoint DMA registers)
> >>     0-b. DMA-map and publish destination address (DAR)
> >>     1.   network stack builds skb (copy from application/user memory)
> >>     2.   consume DAR, DMA-map source address (SAR) and kick DMA transfer
> >>     3.   DMA transfer (payload moves between RC/EP memory)
> >>     4.   consume completion (commit)
> >>     5.   network stack delivers data to application/user memory
> >>
> >>     [A]: Dedicated MW that aggregates DMA regs and LL (peer ioremaps it)
> >>     [B]: Control-plane ring buffer for "produce"
> >>     [C]: Control-plane ring buffer for "consume"
> >>
> >>
> >> Kernel base / dependencies
> >> ==========================
> >>
> >> This series is based on:
> >>
> >>   - next-20260114 (commit b775e489bec7)
> >>
> >> plus the following seven unmerged patch series or standalone patches:
> >>
> >>   - [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
> >>     https://lore.kernel.org/all/20251202072348.2752371-1-den@valinux.co.jp/
> >>
> >>   - [PATCH v2 0/2] NTB: ntb_transport: debugfs cleanups
> >>     https://lore.kernel.org/all/20260107042458.1987818-1-den@valinux.co.jp/
> >>
> >>   - [PATCH v3 0/9] dmaengine: Add new API to combine configuration and descriptor preparation
> >>     https://lore.kernel.org/all/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/
> >>
> >>   - [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
> >>     https://lore.kernel.org/all/20260115084928.55701-1-den@valinux.co.jp/
> >>
> >>   - [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
> >>     https://lore.kernel.org/all/20260105075606.1253697-1-den@valinux.co.jp/
> >>
> >>   - [PATCH] dmaengine: dw-edma: Fix MSI data values for multi-vector IMWr interrupts
> >>     https://lore.kernel.org/all/20260105075904.1254012-1-den@valinux.co.jp/
> >>
> >>   - [PATCH v2 01/11] dmaengine: dw-edma: Add spinlock to protect DONE_INT_MASK and ABORT_INT_MASK
> >>     https://lore.kernel.org/imx/20260109-edma_ll-v2-1-5c0b27b2c664@nxp.com/
> >>     (only this single commit is cherry-picked from the series)
> >>
> >>
> >> Patch layout
> >> ============
> >>
> >>   1. dw-edma / DesignWare EP helpers needed for remote embedded-DMA (export
> >>      register/LL windows, IRQ routing control, etc.)
> >>
> >>      Patch 01 : dmaengine: dw-edma: Export helper to get integrated register window
> >>      Patch 02 : dmaengine: dw-edma: Add per-channel interrupt routing control
> >>      Patch 03 : dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
> >>      Patch 04 : dmaengine: dw-edma: Add notify-only channels support
> >>      Patch 05 : dmaengine: dw-edma: Add a helper to query linked-list region
> >>
> >>   2. NTB EPF/core + vNTB prep (mwN_offset + versioning, MSI vector
> >>      management, new ntb_dev_ops helpers, driver_override, vntb glue)
> >>
> >>      Patch 06 : NTB: epf: Add mwN_offset support and config region versioning
> >>      Patch 07 : NTB: epf: Reserve a subset of MSI vectors for non-NTB users
> >>      Patch 08 : NTB: epf: Provide db_vector_count/db_vector_mask callbacks
> >>      Patch 09 : NTB: core: Add mw_set_trans_ranges() for subrange programming
> >>      Patch 10 : NTB: core: Add .get_private_data() to ntb_dev_ops
> >>      Patch 11 : NTB: core: Add .get_dma_dev() to ntb_dev_ops
> >>      Patch 12 : NTB: core: Add driver_override support for NTB devices
> >>      Patch 13 : PCI: endpoint: pci-epf-vntb: Support BAR subrange mappings for MWs
> >>      Patch 14 : PCI: endpoint: pci-epf-vntb: Implement .get_private_data() callback
> >>      Patch 15 : PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
> >>
> >>   3. ntb_transport refactor/modularization and backend infrastructure
> >>
> >>      Patch 16 : NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
> >>      Patch 17 : NTB: ntb_transport: Dynamically determine qp count
> >>      Patch 18 : NTB: ntb_transport: Use ntb_get_dma_dev()
> >>      Patch 19 : NTB: ntb_transport: Rename ntb_transport.c to ntb_transport_core.c
> >>      Patch 20 : NTB: ntb_transport: Move internal types to ntb_transport_internal.h
> >>      Patch 21 : NTB: ntb_transport: Export common helpers for modularization
> >>      Patch 22 : NTB: ntb_transport: Split core library and default NTB client
> >>      Patch 23 : NTB: ntb_transport: Add transport backend infrastructure
> >>      Patch 24 : NTB: ntb_transport: Run ntb_set_mw() before link-up negotiation
> >>
> >>   4. ntb_edma backend registry + DesignWare backend + transport client
> >>
> >>      Patch 25 : NTB: hw: Add remote eDMA backend registry and DesignWare backend
> >>      Patch 26 : NTB: ntb_transport: Add remote embedded-DMA transport client
> >>
> >>   5. ntb_netdev multi-queue support
> >>
> >>      Patch 27 : ntb_netdev: Multi-queue support
> >>
> >>   6. Renesas R-Car S4 enablement (IOMMU, DTs, quirks)
> >>
> >>      Patch 28 : iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
> >>      Patch 29 : iommu: ipmmu-vmsa: Add support for reserved regions
> >>      Patch 30 : arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe eDMA
> >>      Patch 31 : NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
> >>      Patch 32 : NTB: epf: Add an additional memory window (MW2) barno mapping on Renesas R-Car
> >>
> >>   7. Documentation updates
> >>
> >>      Patch 33 : Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset usage
> >>      Patch 34 : Documentation: driver-api: ntb: Document remote embedded-DMA transport
> >>
> >>   8. pci-epf-test / pci_endpoint_test / kselftest coverage for remote eDMA
> >>
> >>      Patch 35 : PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
> >>      Patch 36 : PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
> >>      Patch 37 : misc: pci_endpoint_test: Add remote eDMA transfer test mode
> >>      Patch 38 : selftests: pci_endpoint: Add remote eDMA transfer coverage
> >>
> >>
> >> Tested on
> >> =========
> >>
> >> * 2x Renesas R-Car S4 Spider (RC<->EP connected with OCuLink cable)
> >> * Kernel base as described above
> >>
> >>
> >> Performance notes
> >> =================
> >>
> >> The primary motivation remains improving throughput/latency for ntb_transport
> >> users (typically ntb_netdev). On R-Car S4, the earlier prototype (RFC v3)
> >> showed roughly 10-20x throughput improvement in preliminary iperf3 tests and
> >> lower ping RTT. I have not yet re-measured after the v4 refactor and
> >> module split.
> >>
> >>
> >> Changelog
> >> =========
> >>
> >> RFCv3->RFCv4 changes:
> >>   - Major refactor of the transport layering:
> >>     - Introduce ntb_transport_core as a shared library module.
> >>     - Split the legacy shared-memory transport client (ntb_transport) and the
> >>       remote embedded-DMA transport client (ntb_transport_edma).
> >>     - Add driver_override support for ntb_bus and use it for per-port transport
> >>       selection.
> >>   - Introduce a vendor-agnostic remote embedded-DMA backend registry (ntb_edma)
> >>     and add the initial DesignWare backend (ntb_dw_edma).
> >>   - Rebase to next-20260114 and move several prerequisite/fixup patchsets into
> >>     separate threads (listed above), including BAR subrange mapping support and
> >>     dw-edma fixes.
> >>   - Add PCI endpoint test coverage for the remote embedded-DMA path:
> >>     - extend pci-epf-test / pci_endpoint_test
> >>     - add a kselftest variant to exercise remote-eDMA transfers
> >>     Note: to keep the changes as small as possible, I added a few #ifdefs
> >>     in the main test code. Feedback on whether/how/to what extent this
> >>     should be split into separate modules would be appreciated.
> >>   - Expand documentation (Documentation/driver-api/ntb.rst) to describe transport
> >>     variants, the new module structure, and the remote embedded-DMA data flow.
> >>   - Addressed other feedbacks from the RFC v3 thread.
> >>
> >> RFCv2->RFCv3 changes:
> >>   - Architecture
> >>     - Have EP side use its local write channels, while leaving RC side to
> >>       use remote read channels.
> >>     - Abstraction/HW-specific stuff encapsulation improved.
> >>   - Added control/config region versioning for the vNTB/EPF control region
> >>     so that mismatched RC/EP kernels fail early instead of silently using an
> >>     incompatible layout.
> >>   - Reworked BAR subrange / multi-region mapping support:
> >>     - Dropped the v2 approach that added new inbound mapping ops in the EPC
> >>       core.
> >>     - Introduced `struct pci_epf_bar.submap` and extended DesignWare EP to
> >>       support BAR subrange inbound mapping via Address Match Mode IB iATU.
> >>     - pci-epf-vntb now provides a subrange mapping hint to the EPC driver
> >>       when offsets are used.
> >>   - Changed .get_pci_epc() to .get_private_data()
> >>   - Dropped two commits from RFC v2 that should be submitted separately:
> >>     (1) ntb_transport debugfs seq_file conversion
> >>     (2) DWC EP outbound iATU MSI mapping/cache fix (will be re-posted separately)
> >>   - Added documentation updates.
> >>   - Addressed assorted review nits from the RFC v2 thread (naming/structure).
> >>
> >> RFCv1->RFCv2 changes:
> >>   - Architecture
> >>     - Drop the generic interrupt backend + DW eDMA test-interrupt backend
> >>       approach and instead adopt the remote eDMA-backed ntb_transport mode
> >>       proposed by Frank Li. The BAR-sharing / mwN_offset / inbound
> >>       mapping (Address Match Mode) infrastructure from RFC v1 is largely
> >>       kept, with only minor refinements and code motion where necessary
> >>       to fit the new transport-mode design.
> >>   - For Patch 01
> >>     - Rework the array_index_nospec() conversion to address review
> >>       comments on "[RFC PATCH 01/25]".
> >>
> >> RFCv3: https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/
> >> RFCv2: https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
> >> RFCv1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/
> >>
> >> Thank you for reviewing,
> >>
> >>
> >> Koichiro Den (38):
> >>   dmaengine: dw-edma: Export helper to get integrated register window
> >>   dmaengine: dw-edma: Add per-channel interrupt routing control
> >>   dmaengine: dw-edma: Poll completion when local IRQ handling is
> >>     disabled
> >>   dmaengine: dw-edma: Add notify-only channels support
> >>   dmaengine: dw-edma: Add a helper to query linked-list region
> >>   NTB: epf: Add mwN_offset support and config region versioning
> >>   NTB: epf: Reserve a subset of MSI vectors for non-NTB users
> >>   NTB: epf: Provide db_vector_count/db_vector_mask callbacks
> >>   NTB: core: Add mw_set_trans_ranges() for subrange programming
> >>   NTB: core: Add .get_private_data() to ntb_dev_ops
> >>   NTB: core: Add .get_dma_dev() to ntb_dev_ops
> >>   NTB: core: Add driver_override support for NTB devices
> >>   PCI: endpoint: pci-epf-vntb: Support BAR subrange mappings for MWs
> >>   PCI: endpoint: pci-epf-vntb: Implement .get_private_data() callback
> >>   PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
> >>   NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
> >>   NTB: ntb_transport: Dynamically determine qp count
> >>   NTB: ntb_transport: Use ntb_get_dma_dev()
> >>   NTB: ntb_transport: Rename ntb_transport.c to ntb_transport_core.c
> >>   NTB: ntb_transport: Move internal types to ntb_transport_internal.h
> >>   NTB: ntb_transport: Export common helpers for modularization
> >>   NTB: ntb_transport: Split core library and default NTB client
> >>   NTB: ntb_transport: Add transport backend infrastructure
> >>   NTB: ntb_transport: Run ntb_set_mw() before link-up negotiation
> >>   NTB: hw: Add remote eDMA backend registry and DesignWare backend
> >>   NTB: ntb_transport: Add remote embedded-DMA transport client
> >>   ntb_netdev: Multi-queue support
> >>   iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
> >>   iommu: ipmmu-vmsa: Add support for reserved regions
> >>   arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
> >>     eDMA
> >>   NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
> >>   NTB: epf: Add an additional memory window (MW2) barno mapping on
> >>     Renesas R-Car
> >>   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
> >>     usage
> >>   Documentation: driver-api: ntb: Document remote embedded-DMA transport
> >>   PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
> >>   PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
> >>   misc: pci_endpoint_test: Add remote eDMA transfer test mode
> >>   selftests: pci_endpoint: Add remote eDMA transfer coverage
> >>
> >>  Documentation/PCI/endpoint/pci-vntb-howto.rst |   19 +-
> >>  Documentation/driver-api/ntb.rst              |  193 ++
> >>  arch/arm64/boot/dts/renesas/Makefile          |    2 +
> >>  .../boot/dts/renesas/r8a779f0-spider-ep.dts   |   37 +
> >>  .../boot/dts/renesas/r8a779f0-spider-rc.dts   |   52 +
> >>  drivers/dma/dw-edma/dw-edma-core.c            |  207 +-
> >>  drivers/dma/dw-edma/dw-edma-core.h            |   10 +
> >>  drivers/dma/dw-edma/dw-edma-v0-core.c         |   26 +-
> >>  drivers/iommu/ipmmu-vmsa.c                    |    7 +-
> >>  drivers/misc/pci_endpoint_test.c              |  633 +++++
> >>  drivers/net/ntb_netdev.c                      |  341 ++-
> >>  drivers/ntb/Kconfig                           |   13 +
> >>  drivers/ntb/Makefile                          |    2 +
> >>  drivers/ntb/core.c                            |   68 +
> >>  drivers/ntb/hw/Kconfig                        |    1 +
> >>  drivers/ntb/hw/Makefile                       |    1 +
> >>  drivers/ntb/hw/edma/Kconfig                   |   28 +
> >>  drivers/ntb/hw/edma/Makefile                  |    5 +
> >>  drivers/ntb/hw/edma/backend.c                 |   87 +
> >>  drivers/ntb/hw/edma/backend.h                 |  102 +
> >>  drivers/ntb/hw/edma/ntb_dw_edma.c             |  977 +++++++
> >>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  199 +-
> >>  drivers/ntb/ntb_transport.c                   | 2458 +---------------
> >>  drivers/ntb/ntb_transport_core.c              | 2523 +++++++++++++++++
> >>  drivers/ntb/ntb_transport_edma.c              | 1110 ++++++++
> >>  drivers/ntb/ntb_transport_internal.h          |  261 ++
> >>  drivers/pci/controller/dwc/pcie-designware.c  |   26 +
> >>  drivers/pci/endpoint/functions/pci-epf-test.c |  497 +++-
> >>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  380 ++-
> >>  include/linux/dma/edma.h                      |  106 +
> >>  include/linux/ntb.h                           |   88 +
> >>  include/uapi/linux/pcitest.h                  |    3 +-
> >>  .../pci_endpoint/pci_endpoint_test.c          |   17 +
> >>  33 files changed, 7855 insertions(+), 2624 deletions(-)
> >>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
> >>  create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
> >>  create mode 100644 drivers/ntb/hw/edma/Kconfig
> >>  create mode 100644 drivers/ntb/hw/edma/Makefile
> >>  create mode 100644 drivers/ntb/hw/edma/backend.c
> >>  create mode 100644 drivers/ntb/hw/edma/backend.h
> >>  create mode 100644 drivers/ntb/hw/edma/ntb_dw_edma.c
> >>  create mode 100644 drivers/ntb/ntb_transport_core.c
> >>  create mode 100644 drivers/ntb/ntb_transport_edma.c
> >>  create mode 100644 drivers/ntb/ntb_transport_internal.h
> >>
> > 
> 

