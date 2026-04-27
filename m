Return-Path: <dmaengine+bounces-10151-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIBZMHOt72lIDwEAu9opvQ
	(envelope-from <dmaengine+bounces-10151-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:39:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8699D478B73
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8DD1301CC47
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 18:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525723ED118;
	Mon, 27 Apr 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pmvWhp/o"
X-Original-To: dmaengine@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CA364EA4;
	Mon, 27 Apr 2026 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315176; cv=fail; b=Tr+8UB1I7Phd9cb1YgUiGgr4Zpl492dJNfXFBeSvOHNKzaz3WlbC2ujNJYQZUxJjIAh2EKpyJzjHIW8Xe3KrlttOvobdO/szjxTcN8ir2ehtFiI48cWnPS/XSlB+7F872JvbBaaM5yVwfU2A0kr8uw/HiBgYXB+Po3W6R/A5Ajo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315176; c=relaxed/simple;
	bh=v6nZWslnPRtWXM9K4AUWXCfW7Bzv0P3BDwGs6enAYTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CQcodAoPTkbSJ2RNQAk9rW0Pzqyfnp/mQMeY8IrL92z9IGXVexeFRqzuYNIZEYxgqGtpCTsUTNCe9691xr59QHio4nH0tROVNGefZEUgDIGru+dp2+c+dcwGMusXpl5NBaJuz0y+QdaQ/opUyExzJsPGJD2r3C9KcZSxnezdRBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pmvWhp/o; arc=fail smtp.client-ip=52.101.43.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQeGa+YdNTuEb823qdZS8Hpotu2r72E0T7L133DkAjYdxm4sXHNsSUmdDgfuLqSgZ8ptJqXAaawtnWfzbuYE9JgTht/7aoE/UBY4fb8CsN7gCBIZfgKE1at/fpNpM0xSdAZJWuaUqRa0tqhI+N/yx9xph7PK0K68mzfAl3ULUBoKMqt7kO8SmQqIRPQp/EyHUjaf8pVm2IKhXkERYsuE6sazi1OyFGe8w6Tpyc067R/wsyQcV3mHt7zG29uYi1UdlBEBwV7zkb5+etoOikaMn5emW16FR/V0uWFWi+xABha/3wJBSOsptBb5XuUEJ0gI46UsoZZATZeItdPD4X+E7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nALNUxvPaXzFesZYqSMaFrytkX4CgELDa/JWTp7Lw8s=;
 b=px9mAWIgpW1g8A++4bB0b0HuBTVzWQKUHx38Lv15RAJgY6RPeHYUnILh/TwEOgn2886PJ4HV1v36kbLLG0HxUFAomMviDfWTHNqC74F0NXfW2B6flkUGEtIYX1KuG62cISJfxDrgdMABrDWp6xVA2MUygcqCtHSOnaMZ5ZNilmoI++yqNmdF0OaD0k2KfXGmE6cSPLaiwtfXftefCRmJeENOcw80UlNkg4EMTulJcftI1iU27D4XyjUiX2sDWu2PtYSLmYIgPWNxczRp1XfiNZwvXibbYm5a4muPrwHvEBOL77eyyAZhWYd43uPx0Y5scO9gl7o17mc1PxH3v/Hq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nALNUxvPaXzFesZYqSMaFrytkX4CgELDa/JWTp7Lw8s=;
 b=pmvWhp/oxEcxQMryFRvqYtTB0A/GaOLun2mURAQK9jJXjqt4Nrc84ZfAfdVzaosEdXMWAP59oi4+UbMy4mec1KbzWHAyoF57I8DflvmrAbfhIb57bYv5qY2FGaPKUQk1zJRQQp9CqnyFj5VocFwyiXwUgS9FNTnrrFLeiZOJ1G9JrF4fAHR8lxFNj5/FwsIq3FU1ajVbQb2H+3//9zc7t+U20kMXMalri61t8NRsJ5k3/mDo4BdG+GEoyoHOcMDJdBMl8UX3LCr93JIqZbyQOPZZ1D/mW+4NjIfkYIV4DzD/8KPPzEEOg0Q59M3wKfLfO1wJ1sZJFQP38+wbciAclw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:39:19 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:39:19 +0000
Date: Mon, 27 Apr 2026 14:39:16 -0400
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
Subject: Re: [RFC PATCH v1 2/9] uaccess: Convert INLINE_COPY_{TO/FROM}_USER
 to kconfig and reduce ifdefery
Message-ID: <ae-tVFVfx72oCC_i@yury>
References: <cover.1777306795.git.chleroy@kernel.org>
 <9fe875d2f55af59c12708336c571a46038528678.1777306795.git.chleroy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fe875d2f55af59c12708336c571a46038528678.1777306795.git.chleroy@kernel.org>
X-ClientProxiedBy: BN9PR03CA0924.namprd03.prod.outlook.com
 (2603:10b6:408:107::29) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d3e4e6-a43d-4919-49fd-08dea48c4adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TPoVweG6k+dJJz5MfIFVzAwybwz2jm9fSNM7cxd69vHJE9UR7v6gWyNzsADjvW7ykt1GxFh4Loi1ek62Aro4GaYSpAgmWTn2FafAKuzv9brpXCmKrPkRpx9DEAPIV+O5dQy3egB7SEzayZhdD/hWFuNZI6/aSgi9lHWX7gRMsSsQ+hETpWZ33SUUr8PWk26gfuJDFv6mOEW2uC2BXHmIXUBpyDzOLTJkWEZLidp+7/nea6eckeX0OWVi4bEZfR9vET0pIew0s/JD7Zz/RgAl3L1OS3LR+WDk0Cj+9xRSjoZt6hvaQHTWsroBoiVTErBG9cZcE6iDBPvkBn6JALg+xzh67RQUZnSxe3dpsNnBDx7CyfIbDUoxU3lAu9QNZYDT1pjKtmsR0xUxypUJz8heZAAejUX+cI5zyhEOMCfbZhYDfC8lL5HRKEb55UhgnG1W7/6v/FhxkMwqKMlyWokoOjOY4UTekvoZ2YoBlTz/0SexmXJCV8GlzzJCCy3Y1wJ/gnGl1oiAmGAyfo29/0sdy3H4BAYwxQB+IiP82ASQGpLESNwitwXe5+qlNSYOiiNPhvXQr7YPxg9TQ20Ipo3dS/oLszmjrr6IMeWdSIzAycLxAjM4ybcGKoHCvx/iHvz1ya1/Lu6sN7VNJ7G92kgR4XUfztSnUa/+T4Ty1oGleBPJ/1/eGU/xx0C11jRZy6aMFQ1qLzVFXPf+Rw3f5XbXFGlI7ibkCm1ybi3SLvQHJsk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oib4bKcV8LA5vdjLqJ8bgcxtg+HiGQmptbpLOggOnOXMP8WzMNQrzTBLxW0t?=
 =?us-ascii?Q?J/O13Po8omZAsmm/pQpy/oqttV579odYMQrIVxXSjgf18STek1XRrKGwVmp0?=
 =?us-ascii?Q?l0BU1ufe1EiXFQOU6+6botm2sdTbVj9guzWn35tmDPDQr3Dwwmyjq5n/e4XI?=
 =?us-ascii?Q?SzRjxH/T3DI21r6vl4cCl334Ew2ij5/yQJC8A/DRNX+V7pyzPYuZovSr9F/H?=
 =?us-ascii?Q?Wgm4eMo8ZKAXBaCC+JcutRhN7eAH9v+cW52Q3ahFRH6xBK3C4/Z3i735rmIV?=
 =?us-ascii?Q?aMfpxHZ0SFW7fKav66AdZnuwM6sLZ9JgRxdV6lUM7BH/+pQ+3Pt5OuxuIF7P?=
 =?us-ascii?Q?wOEzXGgLg/FCQyv3W40kHRzWP2soqwyli3M0yrSc+NSjlNU55HajGFi1JvaI?=
 =?us-ascii?Q?tiNl9ri9lNxc+qE7KdAVPFL/2e+CEWg2vZahotUnAp3114m5sQG/4rVIg4gm?=
 =?us-ascii?Q?gd9zXeVaEsINZnTiz1qVCTLSKFcxLzulAejw8jMwtJRbeGBzK4ZC1e7VOCW+?=
 =?us-ascii?Q?aKVYJaES/nOjEprimIme29LeOa01vmBbY6+qz+yCseVYOQCq9CdDX7e1deoV?=
 =?us-ascii?Q?zaTnta1O/6L4nX1080PXzmu9mTtYtJNQO3DF9ovWHiONsmGP4U11bu49laOs?=
 =?us-ascii?Q?B0UU9IxLtWutiJxYBVD0KN4xfooNicHXXZR6LrmeOgPpcSsKDeGO2BnYG9lv?=
 =?us-ascii?Q?jdgN60ENdKBvmSOFTzCRkCByFYt+/x7RaSBTKsrsbJl8Enat/5Q9rpxaSuYv?=
 =?us-ascii?Q?Hk0QJmiBMLq/XaaCVVftv/lOLZiG1rfq9bJc6AGkJ7Be2P6481HfBvkVoSKm?=
 =?us-ascii?Q?7dS46V0SCDnMF6O9L5WMOGcQF3/JmPJwDC3bbG0KXyXraugzFpO2I2A/zirX?=
 =?us-ascii?Q?a/CdkcxQ4G6IILYhs8aeRubhtiJ4TjMT/T5Mn38f6As5actrgh5OSaby7k/P?=
 =?us-ascii?Q?p/eP1WrTDycIQ7kQbNn0vPkAk/h7ELW35FbH3Phz+HVj/qsyPVuI3ZrMXUag?=
 =?us-ascii?Q?WAN4DeGhJIVi4hPoLtGwda6uakBNXByYqWFG6Y8WSZFrAuFMwEgvc3vSyFyl?=
 =?us-ascii?Q?Dx5n3nRrxw1RgZUiiAKDP0rwsC7WGhhl7rCLYH8tGf3cooY4z46us5fwXFjC?=
 =?us-ascii?Q?wNTDl7f7oWOaDilXo0Jux13wM3eh0BtH51CgLCN9tDrJnzsW7ZyZvcKQk5Tn?=
 =?us-ascii?Q?O9ixfPU/YHVSwPfjb9gBof+EiT69zyPNYsZE4X2O8CyU4Z8XVVbkKhgMngy9?=
 =?us-ascii?Q?YRDPa867pPjQhJc3j8j98MgOVgWGheyih5q5W+m9AMvdBEneu+a9dnByQyMn?=
 =?us-ascii?Q?qCLgefyIDgxtIR+PcNMkMkPhjugjUNVEanta6lIV/gHJ2JE334rR3ZB3QcoQ?=
 =?us-ascii?Q?NbJNKCyplpSmz2mdkoBN9xHWSzQA2d2/nRHmtmEYPxzVHY+pAEBbGSLUGA+G?=
 =?us-ascii?Q?n7hhnzbzDtnl+NVWD79E8VDdTdq6sg4VE3PrKKvMdORAmzEkarJh1RDPehzr?=
 =?us-ascii?Q?rf0jUwl/4QGQHSZRpxkK/lDw7l5CdWKgWv1KnfHZnVpP43iLu8DuyVVHQL2R?=
 =?us-ascii?Q?VCkeADDpChtUpYBLJdlINE5FPPK7QdiOkkbRoLE8VBbhAFo5vAXH2E7YlciW?=
 =?us-ascii?Q?k0gtUjR84c84anx2yV2+7D9n2SuoEUaYGM1OOv9cl/uolZtt2Je3yiYv7HTI?=
 =?us-ascii?Q?yD9W0nKiIOg27gfW0ZUuL7Zq68OzdAmeaqD7+UqqyPO6Vm6rjH2beLlolKD3?=
 =?us-ascii?Q?NnU9q5OrFzP7EEzyxKROJwYEahtrjRNUQfGufTekFC1cKWXYO/DQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d3e4e6-a43d-4919-49fd-08dea48c4adf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:39:19.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EMi8W1U4wKLqFUR+2jNWxP3McH9TdZjJFX+Py1zekodl7uM/ruq8Dm5SoHnnrACMPwMaK2iGgbUgpHPN2cF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
X-Rspamd-Queue-Id: 8699D478B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10151-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 07:13:43PM +0200, Christophe Leroy (CS GROUP) wrote:
> Among the 21 architectures supported by the kernel, 16 define both
> INLINE_COPY_TO_USER and INLINE_COPY_FROM_USER while the 5 other ones
> don't define any of the two.
> 
> To simplify and reduce risk of mistakes, convert them to a single
> kconfig item named CONFIG_ARCH_WANTS_NOINLINE_COPY which will be

We've got a special word for it: outline. Can you name it
CONFIG_OUTLINE_USERCOPY, or similar?

> selected by the 5 architectures that don't want inlined copy.
> 
> To minimise complication in a later patch, also remove
> ifdefery and replace it with IS_ENABLED().
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Andrew has taken my consolidation patch for INLINE_COPY_USER:

https://lore.kernel.org/all/20260427085814.7ca0b134603b8d5813e23396@linux-foundation.org/

Please base your series on top of it.

I'm not sure this patch is relevant to the goal of your series. Maybe
send it separately?

Thanks,
Yury

