Return-Path: <dmaengine+bounces-10161-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HjPBZbj72nTHQEAu9opvQ
	(envelope-from <dmaengine+bounces-10161-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 00:30:46 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324547B7AE
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 00:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFB7F303AF0B
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E26C34C806;
	Mon, 27 Apr 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nMn9Mg2e"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F25A264A97;
	Mon, 27 Apr 2026 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329030; cv=fail; b=uxjiPRgsemOguxFsr/u526sua9Ji81Pb35xtaH2pR6oTiZQPDe+winqAOCzoPI0BhOUkrWj+qJttYHC+f9hh1032kQe//BSN8FpP1BAy2dzYtVb3KBLfP0muF8yw7elhPOLjzfULjh96oAHNIb1gvtfIAKgmeiHhZ7/Pnj6ey1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329030; c=relaxed/simple;
	bh=msNz8K+R7tcezW+jasT95EJ5zMdq6fMm1GADMREockM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UzOeaFQ06qyjKdPahMdOFf/DENR+JGpgtdfdpzfacIoAJjlCQM00LBJXgr5pu6Jc/5uBc/NgNTEy8P6FyruwZ/71jtiAIVefZQpjYJtI0XGTluDo+0bCdQ9APmAqUcokGs8hmrGsN68f5O7OZImPtCmjuVmiEWuHWVhCdrccdPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nMn9Mg2e; arc=fail smtp.client-ip=40.107.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw2dkYic0VXH1kOjwz3jIZQqr8NTQVH9DBTRDd+uRIJW8uYvfM3m58iBDy5zpHYFWzEy5HurjZ12uATc9tuoWjt6/VUzJQgYZAXBZYTEWP2XEmKALhwnH1ENaA8Ac3CwlRTLvFMEwZgba4b3Efi2fsBGQWsShlfVbk+iphjAE+Pk8XuV/eyWjUpmRM4Y9HTRa5iR9RbjMNZZynCz9AHHff0s05EhkIWAfnApXK/qNRqGYLDiFlw7SNnaj3GyeIXPMO8znU+1Kcc/CMVRnCsFx/w1kA7TU7UcIRQb+Rb580j65fMEeEArkSpCjuQa2ek7DCgnd0gLF6jXF9N06qZxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INTDocwjeOkxaSI4e6JrPlp7Kh7b3u8/5GXqjyNfeUk=;
 b=SqLxt4MZPnahGOYqHMCjywU0/HSF4waA/vwnt9ydy1Lm3yrvjNZmkOwuRl93fy6RdmE6bPOC0ZQH4p62+pUUajNd8KxX3yJjBZ746IuQ8gH2tmJrktf9NUD/vrVHw11Y2NBVtrlIsVl9bi7Gqi3ZmgASKvtgOkWY/PmrmgA8udiJVCjbw3br3CieEjsiA/YIbcoZFACykvsdKe3H0iQEMKywElW7FGY/qQYU/hi4PYicWTB3SL3zcJzUqBCWxEiVibRndteACQ6BsdcLI27Rvh553IDZD+jPGF6v9qtpISs3YncftmVw4ldPrz0yQOOExCWF0vjzgVzKvTwuTXEdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INTDocwjeOkxaSI4e6JrPlp7Kh7b3u8/5GXqjyNfeUk=;
 b=nMn9Mg2etjSkCULYpJ5Rnl9/tmBSYad+HpQiMXeFiB6hdvpkrBodtOjFqLvvae82lTwKkV5GAhUHMYupb9utCbBt74zqUto3WQW72bithMtImxRQVa6G6ZaLkW4OIEKHFvEKJ+4xMIBslyesZGqZr4aXMhT6ctHxrHNz0lcJuSDOtu83n51qwHc7wWb/LGrn5RUMmskk9za8NlV0oTff8Bpmfg6PDqFInZvOWRUYF9K6Lc76NhEMq83jHNyESr4la6NDuNth/60Y4SeDe0uNCU02GfnTMD1so+hMFearXgJnH1poNP4yUWzDn8gizO53kHtparXBSnIxAyJtXuIfFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 22:30:21 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 22:30:18 +0000
Date: Mon, 27 Apr 2026 18:30:16 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ae_jeJLlVWjJ4sOY@yury>
References: <cover.1777306795.git.chleroy@kernel.org>
 <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury>
 <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org>
 <ae-2yLWSGnfeTvh1@yury>
 <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-ClientProxiedBy: BN0PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:408:e9::22) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3655ce-20ef-4e2c-2fe2-08dea4ac8fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/PUX5wTJGMs/KBsNviNpWA288jfovgZeFH/D5rlo4Ft68PLkNzRu+VJLbwZPVL7WMTmGE/7sGAUjidmOrf6PO7cVfcrQe6QT08Oqm4vVTbq+1kk8SU+vprwEBmYwG+gAfH2qmWzaQJsEm7YpHDRuW/7Cs1/Xk+BrlRiawZrKiyZzPhbDmpZp82G1md2nBR6MipihlTfUyQ+saizppq6JVvqKLc5dE++LYGjddOZxiO3yutMfU07Cp5tvF3yobREfTw/fDdOZgk2+rMoVASDdUVkAaqH0FXJ28Bm6NVJs+NSRjDYnMLXVfJoJcrsNuF4W22tsLIY5w3wDLjkrtfUAaGwMnqXvKgmEE1qpibH4HaSjxrWfCswHPCx7Vc7oELIEGKApXlepMVtafKQ1eBm0bnWKqspLr19ifmkOBqioMXptCdlJ75n5gVcLiBzfflllkv55OjNYGzmu/P23vn89/MqFVHCPYaOOw1vjLjy3Olm5/wQLP++hGKYxXIrZ64iQpyo+GIlD3HGQMFC+oPQ+4alqqHQ0+kc6l4epUtSsHVmWOEFWpRzFBafriU8ilGCl8/f8jCwsnB3t+/+q8pFFXiilqgDF9lWOw60zcIbP7xO24Ozxdu5GXF2ThaRP8NVaPA/4be0MJgysKa4xa0hnonHdTiIDcF4SkkqpHjiJ5qwmY2Gce2PdYuEwEpTf8TjR66psUlL2DcOZVs8sQNjcffnyedzo5Nat0VSDOW7wgzk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y1CvQpZYZ2eMHe2MhRl9jMjiWbPAKKWXFKb0rNr6P2FKNpuYqlm0vHnj/c+p?=
 =?us-ascii?Q?etrijvKck7MltKVOhuLlrUk/4maEie31AAuCO4vEDEQz7eLSMhE+LXqZ7580?=
 =?us-ascii?Q?/dTzhhd6ZXj5MAUt3SGOfXeBZ9mnjjf2uZ2zVl0944wpMj1aPR6bhJJsKwkp?=
 =?us-ascii?Q?VUL5kcdJLltj/bbXdIYt5R4Q5sFcreBO2t2YjdncWBk9awGhHkshgH2+xQK3?=
 =?us-ascii?Q?KZ9jZvFRcaTs7WARWb/cK4emdp6bDzM7GZoacpZC4jFUpUOAzU++q1cUqbIp?=
 =?us-ascii?Q?IcojDKNgAE9HncwAue719JnQVeUjYbuQfI9vFrEzSJwqQkAaJNY/N9KIqHH5?=
 =?us-ascii?Q?gb6ElO029nGL4z2hh5SKSqKFAJYfJvd6N318L3xLFXMXoREhQbz05reO9kR7?=
 =?us-ascii?Q?GWI0NeihuZjKnE/Ak2IoeTePP++KCVgyuhiSD0PXj7MCcQGFIfSjdMtsrSD0?=
 =?us-ascii?Q?qpof8HORPaHefDg6xtvU0Ls17iRCuj1Xtuu5fBcRshNrriAJmj0nlZqzlPp0?=
 =?us-ascii?Q?oq96Gm2fPd5N0qcJLOIB4vfutS46eOW3OBK4BlzxlMwOHl6WCEd/wmb2kDAK?=
 =?us-ascii?Q?VPTN1pR756Yxc8PWdgyvhKBLft+N8lDJQGyoSrLOClJEovN6quxxF5UrmLgl?=
 =?us-ascii?Q?BSzU4GMBOjLU5qQqVVM1fzFPiQJrPzyeuGPUF6s5eWsZMUNFhY8uESY52c+S?=
 =?us-ascii?Q?SE6TQJUy1lWTLGmxVFeFQgD9qZCVc47lVZv/tMLN8sA71HzeCfL2tx6zUAP1?=
 =?us-ascii?Q?hu81S/ywLrBvCHKaffr0P8d1j0edNWOzngwXYnwimWLWnJ+OOYH82yO8AfMj?=
 =?us-ascii?Q?9OG00BjXZXIsalWG80IQlBy27WpQ84/1c9oAnvbNeJfjdgOz4uIbM6FHkYyA?=
 =?us-ascii?Q?MupGlptk1Xu50YbzeOZ03kGiMKX0VxGdprIqVjtikQtw3BlYFt0IIGwsWiy8?=
 =?us-ascii?Q?wb6reRFBF6KZAnTmSERVS8uD68yLvuu4uDhGLoBqPxQofaxbHl5bqyIHeiVZ?=
 =?us-ascii?Q?JmIJF4RPeAJ5/v6RFBLjGohX5ZjyNkXJb9RZjSdHP1ziqpItJ3rcJG2ZFZJT?=
 =?us-ascii?Q?TOtNJUdl8MYzQUzieK78aUKDOyKuWpAWh2Jep6/sVe9CBZ2NlHHJGqtGJ0+6?=
 =?us-ascii?Q?owwVe4C6J1ikL7yn0gdEWIiiyjuOxoCdI3+hulZemm7LK5thRU+ZyJaPjQR+?=
 =?us-ascii?Q?YK+iuiqW4QYnqG8Bp71RoCe6giJoTJeiqfcGpFeX0h22VmfkFjYMyp/W8nb3?=
 =?us-ascii?Q?mBn+6WSNLOLGrrznB6jKXoRf6cnQ1xEMeJxPdXY/BnX2sOfoIY42tLqAScbN?=
 =?us-ascii?Q?LtZ7qBEv6zip7I8sQ5//f4FDcyaAHJDISd0ze+LMD1SGCz1vUejeBGt5jNwE?=
 =?us-ascii?Q?iyPDDoJ3VJHJ8aGIrV8p6MgUo+UO94WHdRtz/JHe7JLmdPqflsqW5Z53kqYw?=
 =?us-ascii?Q?MP/nGig0/bW+qSUHZi0ybA7U9qUULzBtAdJ3gf4NkhxIRHImljJP3sZS+AbG?=
 =?us-ascii?Q?VX+xV6ny9hftAe82VJ9ewoJIvZ1jOdavxAo38YgxrnhYM4VA4PLlPxMJgrFB?=
 =?us-ascii?Q?bl95emjkBX7MxnGkfKrgN0u2MtTSs3sO1Wdm6BH6ZQ9kazGSKdvWqMQAmcgZ?=
 =?us-ascii?Q?2TAXsG9f2jiTJy/XjYe+XqDYMz+09yazlugWhbXrIX8heUtqQqlD4RBq2C5J?=
 =?us-ascii?Q?CuCIR2G+UzaeT6rHBATVfYnF1JfQa1er7U7HJW5PSDW8XBt5cyY/COXOF+YI?=
 =?us-ascii?Q?h6yFwkKGk0zfxpHpRxxXg2KPpUtDCbrrUbX4jMC5IsdF387MIWjR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3655ce-20ef-4e2c-2fe2-08dea4ac8fa5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 22:30:18.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yVCjxcKtFstGt67IdVeO9hT/qCk0UDq0EBYtz0042ex6ttmtrXzmmIlGerSzGsUENgCE8ayV5UchO391MZbfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
X-Rspamd-Queue-Id: 9324547B7AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10161-lists,dmaengine=lfdr.de];
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
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,Nvidia.com:dkim]

On Mon, Apr 27, 2026 at 02:52:05PM -0700, Linus Torvalds wrote:
> On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
> >
> > This is what Linus said when added x86 implementation for copy_from_user()
> > in c512c69187197:
> 
> Note that some things have happily changed in the six+ years since...
> 
> >   That's partly because we have no current users of it, but also partly
> >   because the copy_from_user() case is slightly different and cannot
> >   efficiently be implemented in terms of a unsafe_get_user() loop (because
> >   gcc can't do asm goto with outputs).
> 
> now everybody can do asm goto with outputs.
> 
> Yes, it's disabled on older versions, so it's not *always* available,
> but all modern versions do it. And if you care about performance, you
> won't be using an old compiler.

The minimal GCC version is 8.1, and asm goto with outputs is supported
since GCC-11. That would brake the build, if we just switch to using it
without "CC_IS_GCC && (GCC_VERSION >= 110100)" guard.

Is it worth to maintain 2 version of the function? I don't know...

Thanks,
Yury

