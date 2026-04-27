Return-Path: <dmaengine+bounces-10157-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI3fNNXN72mBGQEAu9opvQ
	(envelope-from <dmaengine+bounces-10157-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 22:57:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 968CD47A66F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 22:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F46A3012332
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156B374198;
	Mon, 27 Apr 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ekpevu7d"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC657EEA8;
	Mon, 27 Apr 2026 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777322884; cv=fail; b=B2hIoX+BcMLzMBdA/BHGOLNnBxK4Xg7+reWTV89xL57S+kn9acW2p7AviPnEZBcdYeP8bDnMHKWJ9VG2Cc8Jm7iFJxGOEwoxOoIEyXz/GSidiQgBm/6gBHltnB+iFZEWcQzNsIdu5tEqAHHDxHJLwglV1h61shn1nlR1bCEiaE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777322884; c=relaxed/simple;
	bh=jmPZoAm3q6p8k29599qEZNUvgzWuS9W537WpfeQ/d7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qK3KtmgTs7Cy9hLbvJJAAySsOhUCPYZ29g/mFJ5GeBQ8RHDbtnxd/AxhJ/o/o0/bXZoLQZia+xkVpeRgRh9jUGBavy8/L8sU5F1Yx+AJHKsPCdCMs5wZhsdbz1hzd8/1MG9kqTO+Dc3mU0B9B1iT3wLt8B5+uOFvTEhqOEzlyrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ekpevu7d reason="signature verification failed"; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKJfc55gBn7/JbJs21SiRzUuW0AsfDVMTGZmA7fovsVtMpwpJXl5dlFpVdpigSVe3EWg0hBB0fu4CdI1q6zDfHGeLadKtZhEqjE7ydQqdN2j4UzanfOMKli8tBLxG4xE9Gnus/RcdDUX4LAPWvelU3Kl+4NLuekf+MSaWUp21k9wamSHm393QK0i3y9MWuF2ysFyqzpmJJz8Mdo8isyyLOcS7eDXfzYJEZpvSAG2PouwHF3KGxptafxFzeABcOnr6b5s15caTbUtbWG0RfIUe5QbTeBgBo6MVAuW/CqNsRX4shiveKpaPp65fKEDjq8A+rCDlEl4UQlySXJLv6V2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJfDnkGQDnB7YqaX7jhz4r3pYQAr7nSK9IhgO8ax4J4=;
 b=rsQdUUbJcU9so0R7/zFg7mRBFAySidN5CdO0zGCGM86QKGAxvA74BKUH63WvS3Tk0mL+vASpIam1O4Zmh9rAGrdThUTlvlpfrqYPGShsqKfmDSbcq7tlmSOjpQkHGHahsJfn4U+n1o1vBx2EYhJ7brHFuKBy8kjZ7GFVjMtKqJ2iNZogaxH/G+wSti4US7N076mGb2fGyHmqtBMXTy6dvPieTRnpIUVrrTK2hX7jlr0w0xx58LcxU6+u4oe9MNGftQmzh7t1iNY2TSYrUg+Wkyi7Yd1NqHn0grLjG9obOU0YhlxEFl5sm8V4hgpq+BBuW9cBSBY8C+KZtmfBhZuaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJfDnkGQDnB7YqaX7jhz4r3pYQAr7nSK9IhgO8ax4J4=;
 b=Ekpevu7dvZexS27zf6AAushYVGKE2eyKqudikxclym3HcV42ATS6kdvhzRmxkgoE3UM6ANC+pGpRxFyh9gBzNh+b00reJl7lqMvIcy0JSfz+541KpWAKDyh+fz1lMlsGeW3w+f1gCG0cF+47eMxsS70gUjxMLhEN/viVEI3YCTpyhfe82oiQ3gIWQdD+eiGmuV51mjdQ3D5GBVCPtTRshca6OeMvxGY3iEbIzJsPiy+dpjuwSxW2GRx6o6JVH4a9y2xQ5lYy5EeK7FzcAG1vNoor5k6rR6JO3aXcfZMvQmoZFdkb1mqFlj8XmeJn6ScLYqvaY181izAl3zJrlxnFHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 20:47:58 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 20:47:57 +0000
Date: Mon, 27 Apr 2026 16:47:53 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [RFC PATCH v1 2/9] uaccess: Convert INLINE_COPY_{TO/FROM}_USER
 to kconfig and reduce ifdefery
Message-ID: <ae_LeSk7XDEseaZb@yury>
References: <cover.1777306795.git.chleroy@kernel.org>
 <9fe875d2f55af59c12708336c571a46038528678.1777306795.git.chleroy@kernel.org>
 <ae-tVFVfx72oCC_i@yury>
 <f54c3c2b-33da-42a0-80b7-0f6615d930ce@citrix.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f54c3c2b-33da-42a0-80b7-0f6615d930ce@citrix.com>
X-ClientProxiedBy: BN9PR03CA0735.namprd03.prod.outlook.com
 (2603:10b6:408:110::20) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: e21d145c-03ba-4a6a-9777-08dea49e433e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HCC9cdge92V4m6hZLbkxYjY9nSdZMvY3eUrYJzVoB9gQOqmxAPK6rdaWqs+TbJRNyZBGFNrE679QPKqMgPKQHmcjESEesO2VJjPgChKtepPLUYOE/LkQQGZsmv4w+55OFZ+Sur4Mu4JOw7V/vNmvJwOlYlBhT92YWuGJR6DXk2yQMvjP+eOYlTJdO+YTWa/Jz5KJgNrHtOAvm1it4WHU2ZBZLuL/AhrqVVwkzc+IPXkcU79jgOjI9ydER1cGo3HoLCd6gdpsP3eOfNEEF1DgB1xwOU0GvQzD1FHx6RYh0dNBNICPgU4SwossH1u0yrKpK7DamImEaixNUhDIX5GqeLTvugMJVVzxBSaEiDILCjAbZA9Z+OHcM1SVIztBG4AIVhyBRLw7KvN9n80fJiW1prOhuq6i0UkL/bhvl2RXV8f/qvckHvjveZOF5G5W/CDJJbwSEMR5qmaHNd2zViXK41IHDwoAcE3lAUf9N3NwqTg0t13f/0OcaYbRU6vQ/EEXYIwU1f+9BVtx4tw2aV5CPMy3zTFmt8JHaFRFe4e6l7ArpDbBZg6Xml+AFgUU08CpDyCP3LHA2k7Yz8eX8hEKDJ4RCJADvvVuGPsqeH/7bVuUQfTS8EKRrxfaQNDlPFfA8ce4uzJFhb290nwgicqO9fWHhu657hjQi6f4ke3+NIkg+bbwnEo9XuQ/fkQEeFoGpwGekFQ1Ooc0oaJTcAZVREVLsSoJWh99E1nS7yB9CuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?2oPD54n5ZXNlK/kFqbJNXD1QtsOVDwh+UJSvy6M6BXER4piMhd4MdKi/hs?=
 =?iso-8859-1?Q?dtPpvaj4LxnpiHlSbO1r9fiNIKnpbVyt/rHkG6vZrPFcZWV33Wt3zTJ3qe?=
 =?iso-8859-1?Q?ckpBkmbC6Q5Mugc8CDDrjZOIIHIUCmJaeWHL6owAAl4UEDpaubTbrYmMuI?=
 =?iso-8859-1?Q?NqIws0lQ62II3JN8RQZuKwQsrYOL7Nq5cL28v9C0yBSaStZjc/oua7D88W?=
 =?iso-8859-1?Q?lVp9FnMbzl5ZdPFHkvwcurNSWE6BI72RYLGmhfxuw+iEalNBTLg93jaryl?=
 =?iso-8859-1?Q?OQazywBMu1WZqV5znY98J8cAhbSaXoqNerO0nX5QD3UEwjJsWjGXnlR9MF?=
 =?iso-8859-1?Q?Bg4g2NlweZOcbd0J9a6HGZaL0npF+/is4ng5baw4IKHSBGb/WHSXYdb4td?=
 =?iso-8859-1?Q?d3TtbuomhIdQorREntl9+RMaFZfUQj6JJP8xowgTVew4wom6mp8Ds/aio3?=
 =?iso-8859-1?Q?yk6XHj08kGeyGvaiem4uBZf8Y2rOkdQseejpE4luAqcRFsSolHHNQ72xfS?=
 =?iso-8859-1?Q?bae/SS8Lc8zTresY8jBaOtgkXkNPTJHB5HQDPPRP+g3130C3EcS8eD5tGO?=
 =?iso-8859-1?Q?NzZ+ymHQUjmXdjSLHoKhP4TdN5hksLFroHF4YT+CieTOYyfTC3T4uN14Js?=
 =?iso-8859-1?Q?UL87gmptyN6VwoW6YhMFZgHudT/IN/KukxSYBtWnZHqw/I/RRpeaTAknI1?=
 =?iso-8859-1?Q?7z1yyEgD+nkCwBsbgf4V2o7fXMYFCDwVMoMNrl5ZLCY2ZZVCbVB+K2+wJ/?=
 =?iso-8859-1?Q?inPaRdegXyxv3Z2bAPJAkiT8X0ISDMOe2eOf9iNEETkwOYz7Jr4nKvc80u?=
 =?iso-8859-1?Q?XmIxrPRpBAhnAr8S7xfczH+Qqehg2TjkgAz64f8ZE8/9i1wG7mXVO1Q9as?=
 =?iso-8859-1?Q?0uNtSUBT6CwjDIu2Amsqe4AUMw/9zUCctXgXVLfEx9aZcp1+1Dsxtt2N8z?=
 =?iso-8859-1?Q?/L7OSlnpIcZg+TM7s8ia0P1nx+MU3SMI3qOYqLkDN6MHjtMX1beye9a0NQ?=
 =?iso-8859-1?Q?ax9jU/0KlCxKchpGqMjIocKvlky4JLfKCTiBpS5XjJfREJ2e7Jew9rHsl9?=
 =?iso-8859-1?Q?w8ClFQzQqaLDDgE4HpS45w/MKo9f93Ash6uWAME71hU/OPJaLBOz0Hpldd?=
 =?iso-8859-1?Q?m2FT9tRGyPVIo1L+3HqLJUg9o1OscoKBqdF68jUKqgmevSHEfa1UBdv373?=
 =?iso-8859-1?Q?tsqh6SgzYUFHbhsPtvMgwVDmVKImbZY1DOP0fd8wUojL2nHmKHuapuUelP?=
 =?iso-8859-1?Q?Cy7jKpGJCTnRVCFUP+TcIiCMeg7jztgl1gZm6ZF5OEMPnLSgVXNc2frsXG?=
 =?iso-8859-1?Q?i7Tl4usifn7qlFirf9xjgi/muZGT3O54fymYbGeXPWXs9yYi6E734lRU3s?=
 =?iso-8859-1?Q?esZwUYXTz+a6EE2LAkm2J/jh8f4tiKB+vx1FITuMB8F09K/S0rGrQCfbOA?=
 =?iso-8859-1?Q?zQJYWuF7cpp6qPoJQ4D/NwHej7OthQv0ts8RpcxqFrX8r2QFTE2kxBnbRQ?=
 =?iso-8859-1?Q?zH+VYeLWY/k489znw1njCgLLGESMF0DyOWS6pKnzOdAZGSqYkjDH97a4Pw?=
 =?iso-8859-1?Q?fCVnJ+gzPGl0Z8ysg8nsTHrAvnWX/YKoJKKlW6ayYaVF/toGLaJhXQXBwU?=
 =?iso-8859-1?Q?hXseQkaBmAmk8jvoDWKtBllEbMiEapN9iuDyfvYHntUDaL2Gy1qlm+aosx?=
 =?iso-8859-1?Q?1NyFkDKiwyMNtj9YU33Xjg14+fUyMnYdXGjdpUJk60YTi5RRQJD2DjjAV+?=
 =?iso-8859-1?Q?wuTrE0HYz7zXrNZJofNvR8+A56trLl7EwyrqY231N4pMe/m58Zda1V/tIq?=
 =?iso-8859-1?Q?bdVf26XRYGA8BCZj3ziv31rtyHAsm+JkxqEH6VRAcg40GKElJycg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21d145c-03ba-4a6a-9777-08dea49e433e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 20:47:57.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApBP39ijwBDa3/RbspzeLaHHXUB2RtFB8F4ypsIudayixW1tFGUX6nHaIuJK1Cdq2xPDFGyR8Es6N/9hhOEExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
X-Rspamd-Queue-Id: 968CD47A66F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10157-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-0.797];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 09:39:33PM +0100, Andrew Cooper wrote:
> On 27/04/2026 7:39 pm, Yury Norov wrote:
> > On Mon, Apr 27, 2026 at 07:13:43PM +0200, Christophe Leroy (CS GROUP) wrote:
> >> Among the 21 architectures supported by the kernel, 16 define both
> >> INLINE_COPY_TO_USER and INLINE_COPY_FROM_USER while the 5 other ones
> >> don't define any of the two.
> >>
> >> To simplify and reduce risk of mistakes, convert them to a single
> >> kconfig item named CONFIG_ARCH_WANTS_NOINLINE_COPY which will be
> > We've got a special word for it: outline. Can you name it
> > CONFIG_OUTLINE_USERCOPY, or similar?
> 
> You can't swap the "in" for "out" like this.  "out of line" is the
> opposite of "inline" in this context, while "outline" means something
> different and unrelated.

Check KASAN_OUTLINE vs KASAN_INLINE for example

