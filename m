Return-Path: <dmaengine+bounces-10148-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFcjKWql72mpDgEAu9opvQ
	(envelope-from <dmaengine+bounces-10148-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:05:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3E478235
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 20:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F75C30A71E1
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881C3ED12A;
	Mon, 27 Apr 2026 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JEzvcYXQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615B93E92B9;
	Mon, 27 Apr 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312748; cv=fail; b=b4TLatg3zyOa1OhlflAS21g47m877pY/VhKSf6B/pPCbZsMFUQaGM5Eoq5efpqzQ9owW8nNuyfLSn3s5NSek5XenM1dykT8oHRGxcv84rf7XuHbj7Yp8wtIzJgfZQJ6goMVzKpNTo6DOzABcBwYUFO6uImHwGApWVwZ03fC7LfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312748; c=relaxed/simple;
	bh=PuFAP3hMj1cXVAXj0lTuvnZCyiOne4/d0V8P6ehqzx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KIcj1o8grkYAa7GA1e9WZZ6j3tPeotfEabZnwYc5xrpQzhQRJMESd+uXoBBxtZ2muj8D3QTq2Gp+iIfCSG6bSoO5MoeuXXzsJFeGxCWmYvm2RUofVc7315Yn6WX1Tbb7lCMVeAeFpP0K/fmEKPpX1nR/As/aaLAPLPN80bJjAoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JEzvcYXQ; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwpVDJgRLpkyPrfWdsCpP94nHFQqYhYYfzZrq3/Y3eNMNV9kiDiO/lbPQcnh84Kc9KV6mYkk8nn970vbv0+7s6iPEYVW6K4EoChbQ41Qt789Udh9qXYG0iRgkAlDfrPUTQ8sayrAf1ja/JDhQMouPOkZWD58nKWYqpFBMo1DDNj8wVNgDK9FxRdlDaJopLZdzHGxZYNJ5taZ4f+3AlBWDxckohAjQSiNvLpxdNeatx21GsEOk2kuIxck61/13uzdWjKAIWRN7lHpHYgB1JwAWYdhnI0JhIPLSMLkKBOcW0uKNe5jsqRdVec4b90SQh3bBTkUz0ka/PlhmT5JsiSnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWBdJXFvUsRNS535pCc24v4leweSht+XdLI4YB0XzRQ=;
 b=JzUtnzYfifHT4anVN/U1LZ+ey7uTRcx8Nn6Nm2hS9ao6k8XZlQLiaLdpmpmADTsoF0ln9yrZ43mTgzp40gS4qmCP3SHZse2kmq2eYIeYuMuHwoWEH5Vv7fhlfZ2f/diNwlwlNxlMKsTb0izAMGGMQ4cYn6SIIE/MJoDjMtlx4eVbTb6wUFNjAz0H8mGu6ee9kYZLwb1h4NdHsUxdFPnysIwTjLgK6AvD73khRL2k8fi7iymz8mICE66X711dcKdxGAaSE87cWJD8y89JkEkcX+zpl2DCijx6ZDalEAkq61Vdd/L+W8dfRfgTksTcDbvv+E+khdr+3nyDPvxgL3L9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWBdJXFvUsRNS535pCc24v4leweSht+XdLI4YB0XzRQ=;
 b=JEzvcYXQdwVjYZQlnStgbJQRfUGE245OkUv62d/erL7f0QOnr7fp+plL1zfa5mv2O11r5j+JLE5qQdINthQPR+Bj7wYWw46AWrQu/eYz6ED1n8xbwCAyvlDxh9XEzqZC2g1/3KWQVSH/DH18jJwgAfYkttpt/Blmd/pUHyEDc3Wkd3edhlrvX1h1qaZ6ZPmQk/87myHHQ3TrQ1ak0Xvkilcg5V0KT50UAZqYfZ39xcshyA39b5FsO98OY/S/YtJ/myHG6I+ftEFEH6NVP/B7k+6+4RVku7Lrcmp3zsQ+ArtGrvl5bXoyxfgJj2OT6m5rwYJbHAOe8gpGdj72kjww1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 17:58:53 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 17:58:53 +0000
Date: Mon, 27 Apr 2026 13:58:51 -0400
From: Yury Norov <ynorov@nvidia.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
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
Message-ID: <ae-j2_QirCySZD02@yury>
References: <cover.1777306795.git.chleroy@kernel.org>
 <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
X-ClientProxiedBy: BN1PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:408:e2::13) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA0PR12MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 33128524-511f-440c-0040-08dea486a4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T80DamO5jzLhtBsxTULWy0efzaMbF8i7bT0PZKZ+UW4Z1vXusNNCyeFtPNKLbujbu9HADo2BygF39wi6lx74qp3NIinqoXF6o8xZWMAAFsZmucFOM22V5xO7kTuoG3Q6DbZQuR99ud23XQ2FkmrxQgMHmfI3XdFsqYAVjCS9aGVDF45G53+B/x+14PhezRjA9hqQvcw9EvJb6nHARdhsgHJSbcoZorjI9T48oVUEponu+eLNKghANZW7qOCu576IfZ6NRYzsY8ql1Bj8uCnhHA2nhVrKxbbZHG6LptctXV/l6KubZ/U3ZJxrPqPY1X92d625k4fagqEvx268olGcNZDaxDxTtIunEves9hFv+KACk+0uW+ma5OsqtlX5HthzXN6Acbz5tPRPmIKZ/YCyosbcqxLc7ZwX6TI/oKUfq/0tyKExxJEp/Vfc/ZG4cPWp456yUxuQQ7c0zO0EIJ+8b2gQDonWZCvn2KJzNH3N0drPOUzCQcDDQjndG2yh9Ke573Rkt//8VoZT4MTwoNB6z6b1QOagadBkLNDtxDt0AE1XfaIibN7XpAHe5nsEIn2aXs/8ZEHWz0Zv0D5+n5iwRxATzlfDoLqw+IUuN8nm7pwCMHkXF52Sms8QQtJ2rJZUXeJqLYfMQUF/D3X8mn4B7tCVxc1mKoVLz9/1oBAf2bseKRBX0rfB9ZeVX7GBdP+qZAYwkxdtBveQtq9fZ/UIGHDRO8YYxr5lavOVhUA40rc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ev31P6fGlLQLOmFhG9wf+2ZENF2CJrasImnLdTMkk4B07wVpIqdqcEhUwVr?=
 =?us-ascii?Q?VcuKpfWBww+Qglw6NKPvrbqw/iKodwZS6hoQ2ezn6gKQJTXowcVzIMKKmPVI?=
 =?us-ascii?Q?CaGe2PzzTfbrd+1/kBuQd5inX41eLfMXGSMB4El+/BGeY7LidWaO2U6MXIZl?=
 =?us-ascii?Q?To5KMHCCmaxaSW+0abx+uHxslGaDNGAxlD0ajEnVCyj2PyGw8gfavgZvUBeC?=
 =?us-ascii?Q?31Pn2vGdNJPTEao0o8nkBbqzRysmZBZFRsyFAwtcHiF+LMJewEDkGWcf3C7D?=
 =?us-ascii?Q?MhvHUO7rY2T4Gp8yOxYlhdkCQq0m4ykawDCJw9P3w79tbrFqeU7DKZcc6Svj?=
 =?us-ascii?Q?gpUdDiMP1u+wbi6ktqsa2/SBsCawL8yd85/gdX8JeS4P5U//2zVMdqlbS5oF?=
 =?us-ascii?Q?Om8kn23qHMWd1W0xp+L9zqhhURuKBI3C8K6/P0P2OiLTdsZ7lPLULvDBkdZf?=
 =?us-ascii?Q?UKjydMyY/3pcrF3sadi8xEKK6PbOoyabovH4OGdbUvrwD7GG4qRTd8pK59oC?=
 =?us-ascii?Q?snIKpVz1xKnwCa6xY5VnFP5/u/JjDPLADrD/WslKg8YXRFtCzAtBrdImcj0f?=
 =?us-ascii?Q?8yOAh4lyWUDPVX2WM00ySuZhGhvO+v6NJ73vz9XlsUfOsWyYZ9DOEzjUfhbH?=
 =?us-ascii?Q?0YLtM7C7LxhLfanXFKSW+D7acdbl8uANIv2lLYjkqPUxgpfNe8f+7W2LB5Nn?=
 =?us-ascii?Q?7Np0MclwQhDcY1GLCNhmF+qQmAOMVCLRhyHjLhLWkRHgj+alwIysbQ3EuYLN?=
 =?us-ascii?Q?5yHcsNNjsFo0wDyhRUVx5wyCMlW+Z4NGoPr32ydxiktuCQaON6kbvoanfM01?=
 =?us-ascii?Q?VM4/fS2+speM2tcePSAnjiQa5qjOFuYZ0VtZfeGTBIZ1yXD2cHpN1ixZN0Rz?=
 =?us-ascii?Q?L/dQY0op7e/9Yk5F3A4lFGTivTaixUSEIjTezh3qI+wT/tBYEl0Z0XCO2hjU?=
 =?us-ascii?Q?sFOU7EJ1CIL6HbyGijpDH3Yp4I8rMW9VuNbKDzbyWnaJJg9tVdo0/XIJrdAh?=
 =?us-ascii?Q?vVKIJZb+31gwlMVE1kXLTM4rt1jmj4rcA1rNCuw4fD++YKU0KqxirVrsn6kC?=
 =?us-ascii?Q?lZa0X05s4hYIlo7g4DALYttelKqcNX1HEGU6vO71rQrVfydGtRIQzA8hZ8rQ?=
 =?us-ascii?Q?O80VU2eqMYB7eYpBItWytqLFV33JZ/cuulFCjhdnG06CQcNI6/4ovyhT3Aa8?=
 =?us-ascii?Q?PiZXBZphvtTKhhJqQ1c7RRKZs8niebQgxVT+NqLMFlyPhkta2YjjpBXgNIIx?=
 =?us-ascii?Q?h+iPSpkL/BZ7G18/IWgE5T5t9GEq5s5xWwSmey7027/BRYe03neS8L78GvQZ?=
 =?us-ascii?Q?5ceRI/ymV7A6xiSGKp4h0GdJvHPIvbvLvAXTNPJXPyEy/lkYzUg06m/F5Ppx?=
 =?us-ascii?Q?Ucqpyqpi7uPkJEjc3424leqnNg3d1TwAm//hlnXAadNRP0K+njbmTw4CpTe2?=
 =?us-ascii?Q?4HHWlSZ9YpBEw+Ohv14Uf9RwjiFvVAghctOlWmh5sz2AhDjQMGMs8VSWcPgV?=
 =?us-ascii?Q?CT54kkzGd7BsoQ2aPoLVEhjPxQJKnRuZKDOQB6HL77e6jo+Karv0u6QI8scU?=
 =?us-ascii?Q?/P+zWIUoY7Vp26Mnav/FMyG/vDm64Qhe7JrRNaXxdZN6cKMY0RccPxeEvM6K?=
 =?us-ascii?Q?cokd+q0bbXdS3sEK+pM8MrC/A2+EernBjELOWvLW6UNcdosIRiZXx3jxfYAW?=
 =?us-ascii?Q?NoTKA/lHF00/AFzSuUQZeA/Bt64WCRihJQrbIN0bhLrfQCWWaLbXoiNjdnxt?=
 =?us-ascii?Q?OgQB96s+EfSA5RhJu/4bwnEHg5Lb6TZfXmPjZN7/WMw6zB/yunPn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33128524-511f-440c-0040-08dea486a4e3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 17:58:53.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFLDrWxkcKDSdWjcRZ0FWTXyKov5/udW2ySQZAiU/0h1WJYCpRdFgW8eHZBY8qsOSQ9+hnLtwBfn4bjMnIR9OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
X-Rspamd-Queue-Id: 51B3E478235
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10148-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 07:13:48PM +0200, Christophe Leroy (CS GROUP) wrote:
> At the time being, x86 and arm64 are missing unsafe_copy_from_user().

No, they don't. They (should) rely on a generic implementation from
linux/uaccess.h, like every other arch, except for  PPC and RISCV.

But they #define arch_unsafe_get_user, and the unsafe_copy_from_user()
becomes undefined conditionally on that.

So please, fix that bug instead of introducing another arch flavor.
We'd always choose generic version, unless there's strong evidence
that arch one is better.  


Thanks,
Yury
 
> Add it.
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  arch/x86/include/asm/uaccess.h | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 3a0dd3c2b233..10c458ffa399 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -598,7 +598,7 @@ _label:									\
>   * We want the unsafe accessors to always be inlined and use
>   * the error labels - thus the macro games.
>   */
> -#define unsafe_copy_loop(dst, src, len, type, label)				\
> +#define unsafe_put_loop(dst, src, len, type, label)				\
>  	while (len >= sizeof(type)) {						\
>  		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
>  		dst += sizeof(type);						\
> @@ -611,10 +611,29 @@ do {									\
>  	char __user *__ucu_dst = (_dst);				\
>  	const char *__ucu_src = (_src);					\
>  	size_t __ucu_len = (_len);					\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> -	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> +	unsafe_put_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
> +} while (0)
> +
> +#define unsafe_get_loop(dst, src, len, type, label)				\
> +	while (len >= sizeof(type)) {						\
> +		unsafe_get_user(*(type __user *)(src),(type *)(dst),label);	\
> +		dst += sizeof(type);						\
> +		src += sizeof(type);						\
> +		len -= sizeof(type);						\
> +	}
> +
> +#define unsafe_copy_from_user(_dst,_src,_len,label)			\
> +do {									\
> +	char *__ucu_dst = (_dst);					\
> +	const char __user *__ucu_src = (_src);				\
> +	size_t __ucu_len = (_len);					\
> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
> +	unsafe_get_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
>  } while (0)
>  
>  #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> -- 
> 2.49.0
> 

