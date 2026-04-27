Return-Path: <dmaengine+bounces-10155-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ6QAVLE72lsFwEAu9opvQ
	(envelope-from <dmaengine+bounces-10155-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 22:17:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDA3479DC7
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 22:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC1330DF964
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC931F984;
	Mon, 27 Apr 2026 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hMJCquiW"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012027.outbound.protection.outlook.com [40.107.209.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594D3043BE;
	Mon, 27 Apr 2026 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320788; cv=fail; b=l9y6cZMzKu3OsKRpp8KwrpNX1iGww1AXkoGQbn9HlGChl89TEGLzG91JvcGJhZVfSLwhwD+JuJ8nCT4tso9nYwZwVGZ4w9gBK+sNSS+kqW/vhz+SmOdB86KHUaiDogPfAlClbrOgpf6TeTkk8+c83IaCW5R+4UXp0dBp9Eb+04o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320788; c=relaxed/simple;
	bh=nxQPkLzoRwgP9w+X7bgNDKStPP5w+ze2qZKtyO5SFGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=azu3YSO6VRq83U24FrFMDRj2KZmFo/f7PvvXap8GrbSxG9wvZL54Debrzw/12qXVGmKTKGzCDNqkfKs1xYHezvvij3m5q6dfOc4mWaz8H20DSyyAaLmfBQM3oselvBB3sR8BIN6oigal+DI0RL7pQmb1r0qG5yVS/DOnocNs7yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hMJCquiW; arc=fail smtp.client-ip=40.107.209.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtrDbDcz6oik0VAePSzg5fGR+cooJsvCiqVpAkRyxjo7tVYcK6FTW120At87PvC2HmYqvF+zAYmUozmBiDpk3obvOrmRqnQu5b4NUoZkF4ujvP7nKdWKNRWeaLOXO5lx22JtfQpfCueE0stod3ZgwyZHZra4CSp8si7hhoGCGMHOU9NRGgQZvWgZxjvpiddt/5heAo5jaUAbusoeb6/N+ctwOqovcjGb3J/PDBJNthLIqytbew6CjsXMgRhp3uIkXxoc2xEaZ44Y9Ktv5ANbxXoHDUfrqejvOg1lxzqXzqzdTsDZXzt8mwjNLgfzVceatnj1bajoVfBGEPtevW6/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKWQR0wFCYKwd7/WyoEVlZ7dAryoy8A/34DACb4Mweg=;
 b=eIPokbumH3eDN+DqP5Ep1KaEMIWbZhTzgBKsNv19VF/W6X7jjPowB4UntDHWj76GVOLpVErRkTwf2pJ/YrDs45ZN6xDND6686ErEpWA2qQXwRCmtP46ysRgjHvM1NVSf8oin7VwsuXb30pKGJB4D4xu/biMyeV+73vzwzUrpYBXo7hdAidNUQHrxfYLBQEUhcH9MtIkFcqmeakpXHhSDEtl8blygh6QE25OuMpVAmZUWxT7paNvKfjp0MlyKuWB9S5BekJIjYVv4y8EE8wAO9HrTEKcIsKrwKajDUUZC4yUEssV8xNuhIqndzV8atExLn9UGWsZ3+sD76wTjiGaGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKWQR0wFCYKwd7/WyoEVlZ7dAryoy8A/34DACb4Mweg=;
 b=hMJCquiWsKvsKPfnV6x+XewanJiprCXhKZ7l3EnI0mUQee6FHRXLrWa9OPoGIpSx+3ijfDDYf7rNW7PoM7DOSBnLPvsXAImaoD6B98Y7Upx4a9+jmx8qzSA1GldDlcxK8Pewp0jwDRy5JdWZd5Oq81ubXZq43utYi9tCvPcHtbJVcvLFWW/q7KgNksf7InTQ6smdi1OyjYpNmneI+Yx09fiTp08WMkqdpQGjsSSQVU9D7WqLP1BLpIUpVlAs267Rgj9nox2HtSQ5p5eE42gWq/zkifeODpWv1mo/3UxmRXJegCDfavI3oSRox5pAtdJxjEw5pvmed4+9e03qhtyLkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 20:12:58 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 20:12:57 +0000
Date: Mon, 27 Apr 2026 16:12:55 -0400
From: Yury Norov <ynorov@nvidia.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 9/9] uaccess: Convert small fixed size
 copy_{to/from}_user() to scoped user access
Message-ID: <ae_DR6NYwy05mhAe@yury>
References: <cover.1777306795.git.chleroy@kernel.org>
 <8780eb2ef80575931a339e5225bc80eb13e9be6c.1777306795.git.chleroy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8780eb2ef80575931a339e5225bc80eb13e9be6c.1777306795.git.chleroy@kernel.org>
X-ClientProxiedBy: BN9PR03CA0683.namprd03.prod.outlook.com
 (2603:10b6:408:10e::28) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfef69d-b376-4a04-fa4d-08dea4995fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	od/438acft25Q7RIva94Fxe/74ILZrpC6Pf2LMgzKavMVDWiDXC8uUoFq51iqUDaeoOUGT2b7TNIfay4ho0beW8vBSY0l8mrYDUcnR7pCpHtvSlyDnRz5/wnwyZGpPSPU6HBMY0s4gTTvMQ7j0VfwxRe5kbixpH2JA3xdZrASXEZ0pDl1d1WJThBE+/uDOUOALBd8YwZ/+eeNpvnwFCD5DW3KE3lR/Xb2wgRjP9OoLwepFg1JjlfF7x6lpvxpSuiwfFobDUXA7Mqqcz9R6V0ZMrYf9s0pCS4lu/upE91liCZMK8a6QVcT7bHE1yqSUEYYdyWzmVdOCGRVsBtyzVPHpVCQ/H/ouWq0d8egAxhDCKXbaYNKhonqrA1fBXpvk7reDl5D9oT4zLApwPnJxjUXjXzFA80TEJcRTmM79P+K2WrN+x//RhjVGYrw5pmVliJLTW6G/qltB//r5oYHnZqjOuThXK718Z7PTqzjJ0ujUCmUN5I3dUam74AL7WiU47YOnjqHI9K4DCSsiwq2QroO6C3f6BX2+0WK07DzbTXOTuRKVwj1Nkp+F2oyodFlbSeL+I1H/MYBrTTz4hFS3IGNmkgEDTZWJeEFpqkCbnH+WC250/oWJ2xTuA6uT0mLue6TD/so+mr20GkqDu2inq+/ILmI9NvNmWVpTgfUNLmDuiIhDW2dC1N/PLuNJVvEX/LdXBnej8nvO2Fm1k4Q6rMCXk86ZerjhL/ymTd8rnhDvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WIrm7lyr11ondb9zM/aFtj1gKgk8kypk8TAM2g+Ohof+5WQlgtD6zGVPj+Qj?=
 =?us-ascii?Q?Fl/MRzepnMFlWaP+kwU9gjhd02anG8z5ZTflf6LYu+ClIguvgmZIH1trgYIR?=
 =?us-ascii?Q?xpyX4jFk+mQH/otJqXtEelOmF0//lkOX7LVVqlCazvFwry5EU7dmu7JNJT/W?=
 =?us-ascii?Q?IbGi6+a3YEyzdP/EZUUe3nrTxRbrRZDNSHUnwQzjhjLJiSehNgJ8L+6UzAPV?=
 =?us-ascii?Q?dDiNnwHotXKiFihodbBo+fEfI9W9aOKkkT0AlLxUbPwVzVgwuLl/IAV6kHSk?=
 =?us-ascii?Q?Kzy9/VaCvcedh+Ekb8EKVC7l56CzmOv5ObfYMSjBWAnrfSoPrNwnCy5NnRdU?=
 =?us-ascii?Q?+FtCnuU/ZC3EWU1Q5bSAez3Rz0iUWDmQskAPeHnSo6sutK7XR5O2RLiUuC/r?=
 =?us-ascii?Q?TIh2Opz5P54jcYUxkqzjzr+dfuklzkPQHeF1CQUTNTlOgTAHwWNUkyQLDi3E?=
 =?us-ascii?Q?NDPoW5DvCmJyWmxlu3tHIfhbRrBWcq2jwEo4eXMYF6sudilgr+NzPPVAXOBs?=
 =?us-ascii?Q?W6uDfUElRNq/ZzmcZcSEdDnPL0FMBctSTiRLhtrsd3gRRYkZvoBJZH9wsh0x?=
 =?us-ascii?Q?GbgOffPEcvqnuzeH3DQD7hxNGedeVFBu5LMfUDfI8tj0JD0NoO/jMCEwwEGj?=
 =?us-ascii?Q?7Zi4xjZGRB85BK8gVagzsgxl6saeseYWtOB89bfaFHfEn7HIk8Qq6sZMkaUV?=
 =?us-ascii?Q?yJP5GoHZqlylAB4zzpIdOnati8J4GDK/OEUABB6jkmNyPeclWcz3JebExSLH?=
 =?us-ascii?Q?ojb86TGjorvvhaPeWb0Yty2WVHv32UrZhDB58hWeKWGUhdof5c/zfJOiZVOT?=
 =?us-ascii?Q?CJZCc/8139A05YvEL0fjDybsXnGcOzdz+mYd84MuTyf9vfyb2aP1taw2oHX/?=
 =?us-ascii?Q?K0wCh7XR/H/K7aaltZN8NRbRjuDiXGsAQd9dLyhJq4YfT2SK73apbNYHwsJd?=
 =?us-ascii?Q?3zR8++zrasGafDCm+TTNhPJkSJ1MDgMJtjv+Y9PwKG/4VF+yZvV3vgJGVFPt?=
 =?us-ascii?Q?4YicrggVdQoDsPXtMFzhWO14linokl4iwe5aTOUhxYvXZaAyowQpt5wfurCs?=
 =?us-ascii?Q?Ayh9RyF73+nepCUQNc4DUAy07tlFq34oGBkP1+a3753zs4MtmQJulZf3OBuZ?=
 =?us-ascii?Q?8F1Z190YLYL3QKV3jRJoJFKhU2RgBcxzG8PxQBDiQn2AWAUsEQLhYhcpZcuj?=
 =?us-ascii?Q?53L9khHWvM6P9qP8xVFd7/dphsBE6M7uEjQ2JGmn1fKCkKJBY/FtpAUEIEY5?=
 =?us-ascii?Q?dYVWF6lgfU0RkNfTzK7/pit+VVUkKfk4YFbI1g+As9p6XbLpIHR9no3K8oRY?=
 =?us-ascii?Q?v33Wt8tpGQ/3QrvQJMeRlNrgwRWMxq3uLTATB4vDm1ilG0jimpQPBgxrT/2X?=
 =?us-ascii?Q?VPGoCPEn4HUnV1Mf+lE7vxxp/vFpjRqDvwJGbqps0Rn8nFvgrd5mY4EHSgZ6?=
 =?us-ascii?Q?smSLlB6AP2eTUV01HAxRBefOvYtdF0qSe93p9Fi3Qzo4FDMJkG8BRLxDyuov?=
 =?us-ascii?Q?k8rLzPpoXpCwmf+kEClhjVMbMDbLikFkJlonRdZYJawiYwXY05H8rZBhQLWP?=
 =?us-ascii?Q?0feHNzp89zyUqPHP7LbSe0EVRO2Kaec+AqlfTVYtXHhrn6dgv4ER9PjPwQYz?=
 =?us-ascii?Q?SGZWHJfMP3Dwbx/9JF7Ar0+yL48OyXDsjmJqC5FYyMLMeziXXEes+OYa4KgX?=
 =?us-ascii?Q?5okmJIxxdB9AxsqQWPd+OzFWlm0XzrT0CAAYw0BwF9WQUj40YsjQQ+uWqIJ+?=
 =?us-ascii?Q?MlBpJt8puB7ETX/Bjze8q8/K1KeWGNB4KYXANyzSR2LWPBEqi39e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfef69d-b376-4a04-fa4d-08dea4995fc0
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 20:12:57.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4Ck4zF95sPRkpw+1DBvmDDt+EvJGjHXhYAqkKsZVyTO5WLUeoARd7Y3XQH+qd9LnDnkEcQd9xWJtVVZZwcboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
X-Rspamd-Queue-Id: 5BDA3479DC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10155-lists,dmaengine=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 07:13:50PM +0200, Christophe Leroy (CS GROUP) wrote:
> copy_{to/from}_user() is a heavy function optimised for copy of large
> blocs of memory between user and kernel space.
> 
> When the number of bytes to be copied is known at build time and small,
> using scoped user access removes the burden of that optimisation.
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  include/linux/uaccess.h | 47 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 33b7d0f5f808..3ac544527af2 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -50,6 +50,8 @@
>   #define mask_user_address(src) (src)
>  #endif
>  
> +#define SMALL_COPY_USER		64

Let's make it L1_CACHE_BYTES, and maybe configurable?


