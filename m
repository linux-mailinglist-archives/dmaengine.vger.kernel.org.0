Return-Path: <dmaengine+bounces-10154-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEYaCRK572kbEQEAu9opvQ
	(envelope-from <dmaengine+bounces-10154-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 21:29:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C1B4794A4
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F943026759
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43AF3EE1CE;
	Mon, 27 Apr 2026 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPchTHpL"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A023E92A0;
	Mon, 27 Apr 2026 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777317591; cv=fail; b=tH6yuCJbrB/omk9PJIL34WJcrsRDVjNHxx46cokL5tXSyBllBDzxZS+1X6QDODQTemV6Sd8/NswWmUjjNwKlXU0KGZA9UPEtuVvWB1KVpDEjpj64/q47+gT+fH12dfp92xU0YBBaj2NXDaKePigT7kr822LZHI42fK5iqySP3SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777317591; c=relaxed/simple;
	bh=QZFzIQdZ3YBkWl+pry9Vul/3AcxOOWxKfKh1ZrhYsFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uWc2Xus6gOAmT4Sm+7Thk/qLIGdcXfbCdX+C1ZeugXjwZdOkngjVFbezg23rsBNtJqFT8tryFNoYb+rlzGKqyvL5AsXo3h+GH0bXbWEqJFV/6rSeMHICIQdvvo91R9uNUFjTBfuaCJP9G7P6ZUd5/H+UHbxH9mt6VUsiO4ROIFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPchTHpL reason="signature verification failed"; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVhEHbKse9FapnN2cz2aJUX+HTxcItqfquBUQFwLCiP5WPrtNQiNPTnGI4MIon3AgmkAQl5HhYuSQnuQt8IDeRYhgInyB/AOQdBwrpUiHITV3f694UVLHuUrOiv9b2cfG6r3+auR6MSVkkcLuQ4Y+tF/rhfDNeBCXess0F+F/TkXrV+dz92vsSLlL5tn1Ynl2fbpcNoIAef0KBxuv6gcdjE4t82LvHJAaDNASNUKyKFm7x4T0BsLAz0/sYnIg36y560VeNc7zOL4T4Ud5AI185ZovsKb5e37aJIb1I3/TkqG0ULl2gwnmAIb6WWT/tvMtVulTJ6c/93Ndgr0CuF4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kehAw/qIO6D93HVE5am8hZKsLTTbdaFhcjGhCC5rQk=;
 b=barriPy2JoAhTOU2YWoiBczra9jgxyFIS6Vn5fMeLmZuoQbamS7hXIudelNBWOJlYCTT4fz6sLrJvnhUdW9BOtoGyJggKAsOzpYbdXTAoZYuiChGWVjjK4zj5T6ViLKFtxvsysAksVjZEfM7DJVmWiyYI9e45cpEy9i20IgZjrl32t2DE427qEOO5vlB9eYx56Yl/nXGgL4VLYapDOlIgCcuJftQuYsdND79AhJHc1YvPlUNuHXQ+n3CfukGLrY/uuf3W2l/Yujue6iK9C39RkCuvxgHmU04+3GeYVYQvrsxPBRvQZHz5V/LPu92hWZsyj93vuK0RwQezDTTJlGlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kehAw/qIO6D93HVE5am8hZKsLTTbdaFhcjGhCC5rQk=;
 b=YPchTHpLT9QyaGFbz/V/HaxoYwml60CPwBCohwTGccSxQF5xp4aCWy87+9L75FNFxG+fxrmiBfrijK9S2U71MhRFySlXZXPcGWovjvdfkNvvp25q1PAB1mr+HmzjdR2xRedKx7NR5nzOddAsQnNEGyggXH0WqDfgUQo8MCzVvhQJIRQ9THI7KbDluLzImajEqpi/FOh1jFu/Gzsx5Px0K5iD8tBWuFPua2hJduhxINK682Oc8hT1rNV3ppOrrAFmrK5A2egSfIVt/1zbLX+OPjABfYsc675DnlpFoxG5tXvBSDdEGGHoW1lpS7Myqc3PGBqojvAzWyzSfMH/AHuVBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Mon, 27 Apr
 2026 19:19:39 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 19:19:39 +0000
Date: Mon, 27 Apr 2026 15:19:36 -0400
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
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
Message-ID: <ae-2yLWSGnfeTvh1@yury>
References: <cover.1777306795.git.chleroy@kernel.org>
 <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury>
 <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org>
X-ClientProxiedBy: BLAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:208:32d::6) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: c742778b-fa9b-44f9-51b3-08dea491ed5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	shZ1u0REr6wDLRLPyyEdIcR7HSBaBLI9bkPwQrtikVH2FtKB2JxFo1blEpu1cI3NJl8SRfbhAKLYIVGCuUMzmvBnxw+FuY/TWQm+eDHPdr22c6rn1JUuzt3nYVxIbuuLTVTRWsq+e+SUyzbYaEEs9iTQJbTfJiMIr1QcnMs7HyZ09hEYM4Y4qXo4Dqr7nhb5zdIkE0fiLtqy/Zisxe0E2yKOvU4HmFcaFOiR7Aq6DJwZzTG+BR733bn5EC71RBcWvOANFgJM2znxVv/dOuQYufc4G4dUHtXgydGyNUS+fngDUjvyX5MkmDLhOMznjZqXlYqgeu5lMUCpG8HffRFHlOXhBcrYgf+ovMMHaCYbFuDT66UC1VDFvb4rz83Hk2Lnl6vSSpPTv8rxpTSPpx4cdJdNmo0Mn5Mi/3x46vGIX9O5JTAct5Ir50zvkKLZe7/Kp1qSfB39msc26Lzz7LD733/o3mPnQXyAGLurnHZgJ5jM3FLt650dCqhJcZlPMaXHq6+AjtwJTG6y+mX2JUt2792E1LYJn7KjXVu8/xqn/7IpL5oC4IQQUgghT221wDL3lrh3xCL1IuqFJShNLP2kKxWwgFBJzIfU0pnScVGPPU9YsipaXNEtmsuD5RQqnXWq43E7KCoMjIP73gvWalBIhJkqTKcX6NUkX7ot5JSYyuNq1A833Lgaec6O0C//zC9ubi3rz9CymfV/P6BrxHZIhmtQ5semmv0gY0c6C5hRnqM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?T8W6XhUXwT9dv5kuj9kFMa1Pc+caKbpom/7i+ro0mWLEx/WsMCf7Uv+yLt?=
 =?iso-8859-1?Q?gAyF6hz8bSDC1bWR1FTEkkI65aMUmC7iyx7e6/xfNDa3Fqe7SiC1j77stI?=
 =?iso-8859-1?Q?LrG24onu6fFBF8DWYf6MIuIlkdgrbAd2EiVVGxnofgYgHTQhw5136OB8qO?=
 =?iso-8859-1?Q?CnzmyDAwjI33B1CjeJnNBBJkCzrksdZvxIcHW0uIe6E0PZHf537RLpIETM?=
 =?iso-8859-1?Q?s+cBh7JvH4GNxPjZACl7GXrozKiFqXSwFIzHaU9Zd4jSjyzd0KPJpIHPKf?=
 =?iso-8859-1?Q?8h/I+NEnIGw4Lnjlmh9mYKMwd0qS2GIHpVaOy1bH5MCjGmjowRaXjQ79be?=
 =?iso-8859-1?Q?jGRLn+Oomml9guRrsFzOQ7DbbOlFy8pqy9R+D9ZnGVn8wEgYSRw75xgmry?=
 =?iso-8859-1?Q?2ACNauoKPoUzpnRmfqW3sPF9JS/tvt2t2PPNVTZJLV6vuJBnNmyWilx/9u?=
 =?iso-8859-1?Q?SrlYzTyazTZWIZbUeG2soKD4eNVokxFYJQoBgEsGEV2njiNv6HUubbi0pF?=
 =?iso-8859-1?Q?Vqp14jJqz5sSfFayA6WZcArZ+USE5vjanuqRtNQfdkNsKj0R4pEMc493o0?=
 =?iso-8859-1?Q?NCXeFBw/ojt6aGg8g6h7tHIHZcYuw7ohhZUMOvg3ffhlK9u79tO7oKpC3u?=
 =?iso-8859-1?Q?wiPOjYl6brt/0GKfD3iRNbrV6TRbbioNcjuDS7LZqgWxe6vMy7NndX+woA?=
 =?iso-8859-1?Q?uRdr5blnc5k3cJWHAzCHgJ5WF2JWGApq1uyN9UWgvqNw083HRffGg6P5ix?=
 =?iso-8859-1?Q?cG24FhHq+kscs9DSxIC+Aujk67lP+3jqbld/7XWy8cKm8qvSHwRqhWblhk?=
 =?iso-8859-1?Q?2okcTJPbDNOuvYYOSGTPE+vmAEFbkK1UHPvMUY9ATxehETfXPZs7yjb3aq?=
 =?iso-8859-1?Q?w3hdW7xtyg3/7tDEWG7+fOEy9FFT/gEBpvxotxF6oySrb2HXqp/fqrjhbq?=
 =?iso-8859-1?Q?+CZwwgugua6eO4UL5qPz9hiIFbMAfNaGqRykJRiykn+pL+t1YHattmJ89+?=
 =?iso-8859-1?Q?zMjzPmRht5LCTdelXGsXfPIKJiFXD3T9vDfN3lmWj4Ts7wlilxpgiOpMaL?=
 =?iso-8859-1?Q?p7E3h5ji6cLKiR9cNwmzJTNOGBx5zvsEG4+PNQXhBDGMpxOVgOl+EeAV9d?=
 =?iso-8859-1?Q?2s3FGgMUZVYPP9cV5NsthWoh6iNfuRN7NkopE2q3yxMVZlN6dt7HdpbO1Y?=
 =?iso-8859-1?Q?0fu25Ra/a3yy2XE0TtJPHqDm12P85rdM3CgNkUv822FbtecXgL64Qkuo5p?=
 =?iso-8859-1?Q?bU1qrEG+LOPjM/jMvPhwRHc5ppnq/gaXYhFU5FH0G3K5d4d0ixkRyi37Wv?=
 =?iso-8859-1?Q?QFsdW6QrX/SrL3DsdbaAqQnL1rxC0EQG3YCsMUYGRLPRYd9ad5xPY0x+Rq?=
 =?iso-8859-1?Q?pi74xEsiw9PrH9X+6nGn6Y3d7VcpnV6Av8/J+hqLZLRt6W9B7IXfCaTIAV?=
 =?iso-8859-1?Q?8KCRWdm4ExrgkDdvMYea8olZLEBlvgMeZtCVoxZ810+OR4vZKUUMbB37Ha?=
 =?iso-8859-1?Q?gwC1ZTD4TpsWjGJNj5Ry/c9tX5RkpCdCKRBegPQIrqdU1WX41QArSPS9fb?=
 =?iso-8859-1?Q?xDEYSUCFDpxyHnIl4mh4MFcUHTIxFSpQAIB1z5w75JzJg+rYBE9y0Z0uA2?=
 =?iso-8859-1?Q?hx89znOZLi5+tvIZldfaxSE1Dk0RrYzkMtqQuuDh61/I6rksRc2kt6jYug?=
 =?iso-8859-1?Q?hvJgjrdcklYMst8NSnorft9iaeq41s5Z02Our3r1w88xwCK/RrRq8aIdSR?=
 =?iso-8859-1?Q?gpisMPDwKRAml31b4cWNg8wz9VF+bGszAp5BtKObcEufaeReWjiKmyXNV3?=
 =?iso-8859-1?Q?qbI4euw+Po2OswoqiwgiX8xIAeThU5sXrO2JRJTwu37/nYFGOi2s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c742778b-fa9b-44f9-51b3-08dea491ed5d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 19:19:39.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40kb2lLpGDA1U6OK1K/FxB8sAmuWJ+U6w4mJNOJ6ae5Bq52M+Y3YVxXlUqHMzI9liQk01DjxzLicYADua7DWLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678
X-Rspamd-Queue-Id: 94C1B4794A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[nvidia.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[Nvidia.com:s=selector2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10154-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[Nvidia.com:-];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	NEURAL_HAM(-0.00)[-0.753];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 08:20:38PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 27/04/2026 à 19:58, Yury Norov a écrit :
> > On Mon, Apr 27, 2026 at 07:13:48PM +0200, Christophe Leroy (CS GROUP) wrote:
> > > At the time being, x86 and arm64 are missing unsafe_copy_from_user().
> > 
> > No, they don't. They (should) rely on a generic implementation from
> > linux/uaccess.h, like every other arch, except for  PPC and RISCV.
> > 
> > But they #define arch_unsafe_get_user, and the unsafe_copy_from_user()
> > becomes undefined conditionally on that.
> > 
> > So please, fix that bug instead of introducing another arch flavor.
> > We'd always choose generic version, unless there's strong evidence
> > that arch one is better.
> 
> But they both implement the exact same unsafe_copy_to_user(). What is the
> difference here ?
>
> Should that function become generic too ?

This is what Linus said when added x86 implementation for copy_from_user()
in c512c69187197:

  Note that it only does this [arch version] for the copying _to_ user space,
  and we still don't have a unsafe version of copy_from_user().
  
  That's partly because we have no current users of it, but also partly
  because the copy_from_user() case is slightly different and cannot
  efficiently be implemented in terms of a unsafe_get_user() loop (because
  gcc can't do asm goto with outputs).

In the unsafe_copy_to_user case, arch versions were justified. Just as
said, I'm not against arch version for unsafe_copy_from_user(), but it
should be explained very well.

