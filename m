Return-Path: <dmaengine+bounces-10329-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SASiKo1AAmo/pgEAu9opvQ
	(envelope-from <dmaengine+bounces-10329-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:48:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E48B4516007
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F09473008623
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E623AE199;
	Mon, 11 May 2026 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z1T4RBbL"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698EB1E9B3D;
	Mon, 11 May 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532487; cv=fail; b=KgYnG85cZzYOc7I3fvEJpZ89Xy08gFMzI3ZD6U1mdWV75ie0AuEoYNIe1iovnhko4PPBNE926RbXKEHLy0elyPBnuyu96VePsAYKy1FmvpjcwYfkxa0DKIJwgkc4Qgs/lIT4D8Yfb0PTCAULbj28T8TA75rWxsXgN7HWs7hChMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532487; c=relaxed/simple;
	bh=fFaQnQjoROxs9VzRGt3GBkVk0TyxL6O9BEe2dk93H2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vkpmn/p0LAfuHuDIwzq32pumNIZlEKScgWpB9bavoK1vMuWqzV/U9CSasdN7QMWsD2f4p9HQM9TEz5Y3Ds1M4braUx75l+yNn07+EyJiShfRvR9cN8QT7QQy9y6iRk6uI5XMFignTneQicB+1RIOOMbcdpcg9GaNJTA28EiNBgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z1T4RBbL; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agR1sZS+JCsMkmLFg4zS9VAjmlLL8OVV8affYNZBa6kD+waPSjxn8bTuM9pUXGBSNSl/aAnaYzrvteybzVsTJ23CJBkIMVEHMhRktohxmbLwJjBNETDtzu0X2GayMGWU3PrlQVRXq//BqaQCZCQpXZjWPXAauVo5HcUtTfodOKYS8hHGvi5WM9bacxL8R7cdHdGGAHAyaVahW97n9IiZHHuhTUby1v3S5FX4FsvgA4tHzBfVnx8v8Qc1HkNZe9oqL36T5Ojkri+jDXanh/A6ZmbH5VeVOvPPK/4/lWuUzzzBZXWFFZa3qV01N1EsnhFUx0Eopb6bvM0DiQn9+eeLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1y9lslIwJtLsXJNLC6+kaxciyPg9BuwhgXNqDxV/h0=;
 b=cJ3i6xpQpGEJCwf4dL64AIhd7cLFEeaWxhpmMhrwJY94KuST/oF2bpy7Nj34xU05+dgPAmhznnp8WUxz6b+OJYdlv0nVPq3ZvDScU1+LpPBjjwQ/o/6HYZaZWlqMI9peRmPpxEoZDvW3BzWiU2Ry119a7P4S/1pvWmVfQNhLL+OADz/jU8FnoWegc2IL7L64lPf6TE64Ku+jcDzdrptbXAoqhiUIPTuaw9peXZrp9nUtdhYoJjnGSPijW6wBT7/sY/a0Ie3NF4AUKWbkCCMfxWnRtCNTJ99H9auThSIF//ESGGWyxJWhhzhjWtM1R3vyuuwKAYXtnjcqF6q4r9t93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1y9lslIwJtLsXJNLC6+kaxciyPg9BuwhgXNqDxV/h0=;
 b=Z1T4RBbLYJd/bhYlhBzSxYQ15XBp9yJGWpx7fORJlC6YIjlUqOAG0lH4KrnGE448dh77DKymc6lSeDN9riTIa5DfJKomChg2cBGYHKVJ6pqdLgd08XtqDNDtmw1Bh+MZNQO0jsZVIXzR0xRI5iXbQtSvZjgNk1QXtwFNEyl02oTuzdvEOBYkbWTokbNyXQWGEn7awDNtkbFm0V02kRJvcx9XgWSSQqZ8TU96QWA54AcA8prDptlh/KD4goOZHLQIv/c14I4eMtQnGSnsbs1Qo4KEVkzNuG5hDhiqJ/s56juY+IDUam8Ut/bAYN2gQ2gZ8r3zACi+zadUIuRM27uIHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU4PR04MB12274.eurprd04.prod.outlook.com (2603:10a6:10:62b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 11 May
 2026 20:48:02 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 20:48:02 +0000
Date: Mon, 11 May 2026 16:47:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nathan Lynch <nathan.lynch@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>, John.Kariuki@amd.com,
	Kinsey Ho <kinseyho@google.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	PradeepVineshReddy.Kodamati@amd.com,
	Shivank Garg <shivankg@amd.com>,
	Stephen Bates <Stephen.Bates@amd.com>,
	Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 23/23] dmaengine: sdxi: Add DMA engine provider
Message-ID: <agJAeVtiJnQ1In6_@lizhi-Precision-Tower-5810>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
 <20260511-sdxi-base-v2-23-889cfed17e3f@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-sdxi-base-v2-23-889cfed17e3f@amd.com>
X-ClientProxiedBy: PH7P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU4PR04MB12274:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ada47ab-e6e0-473f-c033-08deaf9e97ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|19092799006|11063799003|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	vsdtOrdC8lsI5OiKZqByfi3D4QsLYeHZULli0omHj8bJ3u8fWToMNHfP64npIeoiKomNrfb5CihxMugZfxIrGE4MZaxPW24mYt9ydeH6iAexgUI3N58LZSVVX8uijDXBOY+65n3hL80Gayk5T351IAPBc+C1xigjKh2qmjQt7YgJWyeYivMO11T5M814ObW8d6TURUd9Ws37ZsByAYJwSd8WYmv9a3h+28NngF81UzO+0QQQNFqG5gnmciebCoGXEHGNQAA2JSMJMlZNnj3gdL3s+W7rrj+FLRLtcN2AsrLnk/L+qwQaFIj2UXWn9RCTk/uuUOXoM6pEMF1LIJTLu86cWyd/XM4HmtxmQYgQ9A5BzpZd0YmdFFA9cVLBuTt5Lo4PLkYOUYoQywO9oJKRc9XWsPmWQABmSPCWoWSMHJYxbmBVs5HcKCrL7jbU6OZ+Cus8DQWwLIrFDZUAa7s30YN6ic2DjpoQom0k3cG/P/lhOatX1gKDIkf50sm1EdXLFoo+TY4DPVwTLZov6/vtCquJvMQIPSVj6RC1FBX0rEXIm/NBpIjiAJRxK7lWun7zo0vQsNBGtseFgZ65NCyIfG/qCUrr2wIGw/+XvktQyEZTAWWVMXJz8uV1bv1QTbD8Wtl031kfXl3ZSBMfxvhqW9gTUeQepEsTQdIeirpg3nkNzB1JG5WEVSBgknjmMTzaq7gLw24PVe0PGox4VyowL5mX07KhG204R7vVvm1rvvfKxy5LnWUK7noUVVbEJH6V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(19092799006)(11063799003)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0cqJ9gcHsEL4rXzY4zX83D5jctVB16NypAkJMvr9o4QrrZXR84H18UTWy6R?=
 =?us-ascii?Q?J8XRHatVn4/pZ+7FVjnxkCFCYMNHDwqOG0BMKVajQoi6C9pAKLfjwm7LtPlB?=
 =?us-ascii?Q?dvRqG9v462YBLiPzXlpjLfqN96ejTjI8qDBELEwr0qhficQmHyBvXxEcamFy?=
 =?us-ascii?Q?cWrdmtxRFd8T+xCDXbmG6OuHdtCVgKRfZVe4CCc9FMOQbDG04gdCyJFaRxSb?=
 =?us-ascii?Q?osY/CousgcHEkggub+vq91DR1h4VIPqh3Le8SmlFm3ZDA+SeHWC0pOJLs5gW?=
 =?us-ascii?Q?PQPqBYYyfS23LtXjfb31tCWfRSbNDLhQdVh3N9/J+bbO8wdrhZ1GP+PevvjT?=
 =?us-ascii?Q?P4+p5Bl88+WvKba9O73n61nN6s2duMORDmHWG92qpa1ZWD5aLVacGqa4Knxh?=
 =?us-ascii?Q?mQW2QysaPGqFXR3oSkh0x8HnD+W248Hv+DNU1Rtv2/5wXJJygQyGSS6Q5Lkm?=
 =?us-ascii?Q?CSyVHmm8XVf0Ur6WVDIeYYPyc9OS6Dv1k+c3jYA8noWp608xISND3mNeYKHy?=
 =?us-ascii?Q?siq7aFgwY2QHYiy0DjLVOrZhY6R56V0UZ3eS1BQOYw0i9+ak2MEnKRIXczDH?=
 =?us-ascii?Q?NsJJsYnJQLmRW8gJ+Uh6hqnARgUz/fUSsLiXynal9XF619b0mCChTM5g0Eyy?=
 =?us-ascii?Q?7Ua/ZZY/hA4HgNfi+aJsgQkqk3uf/qNZyxPYwVGQNpgl3ROAUKZxFb2ASpm/?=
 =?us-ascii?Q?+V4I3SRdKH5rIHKSSQIUsYuvA1CUXOfPmwZWn+jNCYXqXqSLdLbDHTw3s+HJ?=
 =?us-ascii?Q?jqhd08MyjAt2tMZXUl67hQjbsA8q1Ysy1nf+/B1XkwW830wPi37JboRVLX26?=
 =?us-ascii?Q?mPljaBa83rbTnjGNEDVUo9OjAqh9pAtYbLUo0gc1ThJDn8r4HVU+g05Ja+Xp?=
 =?us-ascii?Q?+z8bES5Sn82fYj5ZRa4E6u7YlEKRFQCAclD8rdl2mHpkqu3aIynGaf/dwjKT?=
 =?us-ascii?Q?pA/x3dCXtVA3lXX1gbHCOWYXfqDdzsnWU6kgBJgRPN4qTmocETSyFJVgAt1f?=
 =?us-ascii?Q?sRi+mtP5gEjAKIuGlPiSZxOMn2RBMybCL089baW6MZAbk696VaG4Pr7lb9tM?=
 =?us-ascii?Q?oTz61ZTBEDbbFqgZQx8l4hTfZ4JxqbP0ZOs7OQZyEL4g/8bwUJc379Sj3lGp?=
 =?us-ascii?Q?fNILtsKtQKKjBfH82vy/rK9MhPN0VBcM6TNMUGlHIAJV+eWcAwu2v4gCa980?=
 =?us-ascii?Q?G6XLUtULkCtsWWLlmz4lx0/HHKmMg/NAzMO1S0UXlzJCqhEWbEdrPLrA4Bew?=
 =?us-ascii?Q?CivSGwUyPd2AV1Lwjc48yWP2T1nqs9QxTWzrDa+/QpYa9Icp6QuIp8OdLDVB?=
 =?us-ascii?Q?Nb4EpBDUOXeQO1DO980cxKjZaZ0CkLM2C3na3Nx7UvKYf5QVTLq5Wd4j07gK?=
 =?us-ascii?Q?8z95owiIDlrbtbfXiC+SO/ZsZLV9C+794pGrbmMzs4lX8Hu+UZt30o+ON1Qq?=
 =?us-ascii?Q?ioIBVHXZ5fpfL3QLu7ERfEmE+SoA3i+YTbNRjTCm5Y3EJoDuw/sup6O2K+Eq?=
 =?us-ascii?Q?ypGUwru8fNfu/GR/9q2Kc9xb6wzNEHdqSoDha3vvGd4a+GjieO8/2Uq8VfDr?=
 =?us-ascii?Q?7YcRbFX24KrjppenWRDHqzZfIsMOQN8FI6NEpR5PvejNNSJwWfNMIjiVR4QF?=
 =?us-ascii?Q?JgVRO3r7GXUdhQh0W9bpOGItrfcE/huD4sjcWpovir0vGLlUyimMy12qU/7r?=
 =?us-ascii?Q?GM1Zpb+JqntdT1H8k91BcXpIbCHw5D6691A0A62HQg7VuiZ8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ada47ab-e6e0-473f-c033-08deaf9e97ae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:48:02.0143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWvBCtjVHnX0iOVuZgwRnVxIeZgSASBdiBa6YXhYjgVwtvna1/MTxjs/5121MPH4TNaB6wdkrWBpLPhBxtnKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12274
X-Rspamd-Queue-Id: E48B4516007
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10329-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:dkim,amd.com:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:16:35PM -0500, Nathan Lynch wrote:
> Register a DMA engine provider that implements memcpy. The number of
> channels per SDXI function can be controlled via a module
> parameter (dma_channels). The provider uses the virt-dma library.
>
> This survives dmatest runs with both polled and interrupt-signaled
> completion modes, with the following debug options and sanitizers
> enabled:
>
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_KASAN=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_SLUB_DEBUG_ON=y
> CONFIG_UBSAN=y
>
> Example test:
>   $ qemu-system-x86_64 -m 4G -smp 4 -kernel ~/bzImage -nographic \
>     -append 'console=ttyS0 debug sdxi.dma_channels=2 dmatest.polled=0 \
>      dmatest.iterations=10000 dmatest.run=1 dmatest.threads_per_chan=2 \
>      sdxi.dyndbg=+p' -device vfio-pci,host=0000:01:02.1 \
>      -initrd ~/rootfs.cpio -M q35 -accel kvm
>   [...]
>   # dmesg | grep -i -e sdxi -e dmatest
>   dmatest: No channels configured, continue with any
>   sdxi 0000:00:03.0: allocated 64 vectors
>   sdxi 0000:00:03.0: sdxi_dev_stop: function state: stopped
>   sdxi 0000:00:03.0: SDXI 1.0 device found
>   sdxi 0000:00:03.0: sdxi_dev_start: function state: active
>   sdxi 0000:00:03.0: activated
>   dmatest: Added 2 threads using dma0chan0
>   dmatest: Added 2 threads using dma0chan1
>   dmatest: Started 2 threads using dma0chan0
>   dmatest: Started 2 threads using dma0chan1
>   dmatest: dma0chan1-copy1: summary 10000 tests, 0 failures
>   dmatest: dma0chan1-copy0: summary 10000 tests, 0 failures
>   dmatest: dma0chan0-copy1: summary 10000 tests, 0 failures
>   dmatest: dma0chan0-copy0: summary 10000 tests, 0 failures

Look like this is standard dmatest method, I suggest put these information
into cover letter.

>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---
>  drivers/dma/sdxi/Kconfig  |   1 +
>  drivers/dma/sdxi/Makefile |   1 +
>  drivers/dma/sdxi/device.c |   2 +
>  drivers/dma/sdxi/dma.c    | 499 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/dma.h    |  11 +
>  5 files changed, 514 insertions(+)
>
> diff --git a/drivers/dma/sdxi/Kconfig b/drivers/dma/sdxi/Kconfig
> index 39343eb85614..41158e77b991 100644
> --- a/drivers/dma/sdxi/Kconfig
> +++ b/drivers/dma/sdxi/Kconfig
> @@ -1,6 +1,7 @@
>  config SDXI
>  	tristate "SDXI support"
>  	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
>  	help
>  	  Enable support for Smart Data Accelerator Interface (SDXI)
>  	  Platform Data Mover devices. SDXI is a vendor-neutral
> diff --git a/drivers/dma/sdxi/Makefile b/drivers/dma/sdxi/Makefile
> index 419c71c2ef6a..80b1871fe7b5 100644
> --- a/drivers/dma/sdxi/Makefile
> +++ b/drivers/dma/sdxi/Makefile
> @@ -6,6 +6,7 @@ sdxi-objs += \
>  	context.o     \
>  	descriptor.o  \
>  	device.o      \
> +	dma.o         \
>  	ring.o
>
>  sdxi-$(CONFIG_PCI_MSI) += pci.o
> diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
> index 79bd77639479..1c5c6741eadb 100644
> --- a/drivers/dma/sdxi/device.c
> +++ b/drivers/dma/sdxi/device.c
> @@ -21,6 +21,7 @@
>  #include <linux/xarray.h>
>
>  #include "context.h"
> +#include "dma.h"
>  #include "hw.h"
>  #include "mmio.h"
>  #include "sdxi.h"
> @@ -314,6 +315,7 @@ static int sdxi_device_init(struct sdxi_dev *sdxi)
>  	if (err)
>  		return err;
>
> +	sdxi_dma_register(sdxi);
>  	return 0;
>  }
>
> diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
> new file mode 100644
> index 000000000000..6c0ab04c1939
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.c
> @@ -0,0 +1,499 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SDXI dmaengine provider
> + *
> + * Copyright Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/container_of.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/spinlock.h>
> +
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +#include "completion.h"
> +#include "context.h"
> +#include "descriptor.h"
> +#include "dma.h"
> +#include "ring.h"
> +#include "sdxi.h"
> +
> +static unsigned short dma_channels = 1;
> +module_param(dma_channels, ushort, 0644);
> +MODULE_PARM_DESC(dma_channels, "DMA channels per function (default: 1)");
> +
> +/*
> + * An SDXI context is allocated for each channel configured.
> + *
> + * Each context has a descriptor ring with a minimum of 1K entries.
> + * SDXI supports a variety of primitive operations, e.g. copy,
> + * interrupt, nop. Each Linux virtual DMA descriptor may be composed
> + * of a grouping of SDXI descriptors in the ring. E.g. two SDXI
> + * descriptors (copy, then interrupt) to implement a
> + * dma_async_tx_descriptor for memcpy with DMA_PREP_INTERRUPT flag.
> + *
> + * dma_device->device_prep_dma_* functions reserve space in the
> + * descriptor ring and serialize SDXI descriptors implementing the
> + * operation to the reserved slots, leaving their valid (vl) bits
> + * clear. A single virtual descriptor is added to the allocated list.
> + *
> + * dma_async_tx_descriptor->tx_submit() invokes vchan_tx_submit(),
> + * which merely assigns a cookie and moves the txd to the submitted
> + * list without entering the SDXI provider code.
> + *
> + * dma_device->device_issue_pending() (sdxi_dma_issue_pending()) sets vl
> + * on each SDXI descriptor reachable from the submitted list, then
> + * rings the context doorbell. The submitted txds are moved to the
> + * issued list via vchan_issue_pending().
> + */
> +
> +struct sdxi_dma_chan {
> +	struct virt_dma_chan vchan;
> +	struct sdxi_cxt *cxt;
> +	unsigned int vector;
> +	unsigned int irq;
> +	struct sdxi_akey_ent *akey;
> +};
> +
> +struct sdxi_dma_dev {
> +	struct dma_device dma_dev;
> +	size_t nr_channels;
> +	struct sdxi_dma_chan sdchan[] __counted_by(nr_channels);
> +};
> +
> +/*
> + * A virtual descriptor can correspond to a group of SDXI hardware descriptors.
> + */
> +struct sdxi_dma_desc {
> +	struct virt_dma_desc vdesc;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_completion *completion;
> +};
> +
> +static struct sdxi_dma_chan *to_sdxi_dma_chan(const struct dma_chan *dma_chan)
> +{
> +	const struct virt_dma_chan *vchan;
> +
> +	vchan = container_of_const(dma_chan, struct virt_dma_chan, chan);
> +	return container_of(vchan, struct sdxi_dma_chan, vchan);
> +}
> +
> +static struct sdxi_dma_desc *
> +to_sdxi_dma_desc(const struct virt_dma_desc *vdesc)
> +{
> +	return container_of(vdesc, struct sdxi_dma_desc, vdesc);
> +}
> +
> +static void sdxi_tx_desc_free(struct virt_dma_desc *vdesc)
> +{
> +	struct sdxi_dma_desc *sddesc = to_sdxi_dma_desc(vdesc);
> +
> +	sdxi_completion_free(sddesc->completion);
> +	kfree(to_sdxi_dma_desc(vdesc));
> +}
> +
> +static struct sdxi_dma_desc *
> +prep_memcpy_intr(struct dma_chan *dma_chan, const struct sdxi_copy *params)
> +{
> +	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
> +	struct sdxi_akey_ent *akey = to_sdxi_dma_chan(dma_chan)->akey;
> +	struct sdxi_desc *copy, *intr;
> +
> +	struct sdxi_completion *comp __free(sdxi_completion) = sdxi_completion_alloc(cxt->sdxi);
> +	if (!comp)
> +		return NULL;
> +
> +	struct sdxi_dma_desc *sddesc __free(kfree) = kzalloc(sizeof(*sddesc), GFP_NOWAIT);
> +	if (!sddesc)
> +		return NULL;
> +
> +	if (sdxi_ring_try_reserve(cxt->ring_state, 2, &sddesc->resv))
> +		return NULL;
> +
> +	copy = sdxi_ring_resv_next(&sddesc->resv);
> +	(void)sdxi_encode_copy(copy, params); /* Caller checked validity. */
> +	sdxi_desc_set_fence(copy); /* Conservatively fence every descriptor. */
> +	sdxi_completion_attach(copy, comp);
> +
> +	sddesc->completion = no_free_ptr(comp);
> +
> +	intr = sdxi_ring_resv_next(&sddesc->resv);
> +	sdxi_encode_intr(intr, &(const struct sdxi_intr) {
> +			.akey = sdxi_akey_index(cxt, akey),
> +		});
> +	/* Raise the interrupt only after the copy has completed. */
> +	sdxi_desc_set_fence(intr);
> +	return_ptr(sddesc);
> +}
> +
> +static struct sdxi_dma_desc *
> +prep_memcpy_polled(struct dma_chan *dma_chan, const struct sdxi_copy *params)
> +{
> +	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
> +	struct sdxi_desc *copy;
> +
> +	struct sdxi_completion *comp __free(sdxi_completion) = sdxi_completion_alloc(cxt->sdxi);
> +	if (!comp)
> +		return NULL;
> +
> +	struct sdxi_dma_desc *sddesc __free(kfree) = kzalloc(sizeof(*sddesc), GFP_NOWAIT);
> +	if (!sddesc)
> +		return NULL;
> +
> +	if (sdxi_ring_try_reserve(cxt->ring_state, 1, &sddesc->resv))
> +		return NULL;
> +
> +	copy = sdxi_ring_resv_next(&sddesc->resv);
> +	(void)sdxi_encode_copy(copy, params); /* Caller checked validity. */
> +	sdxi_completion_attach(copy, comp);
> +
> +	sddesc->completion = no_free_ptr(comp);
> +	return_ptr(sddesc);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +sdxi_dma_prep_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
> +		     dma_addr_t src, size_t len, unsigned long flags)
> +{
> +	struct sdxi_akey_ent *akey = to_sdxi_dma_chan(dma_chan)->akey;
> +	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
> +	u16 akey_index = sdxi_akey_index(cxt, akey);
> +	struct sdxi_dma_desc *sddesc;
> +	struct sdxi_copy copy = {
> +		.src = src,
> +		.dst = dst,
> +		.src_akey = akey_index,
> +		.dst_akey = akey_index,
> +		.len = len,
> +	};
> +
> +	/*
> +	 * Perform a trial encode to a dummy descriptor on the stack
> +	 * so we can reject bad inputs without touching the ring
> +	 * state.
> +	 */
> +	if (sdxi_encode_copy(&(struct sdxi_desc){}, &copy))
> +		return NULL;
> +
> +	sddesc = (flags & DMA_PREP_INTERRUPT) ?
> +		prep_memcpy_intr(dma_chan, &copy) :
> +		prep_memcpy_polled(dma_chan, &copy);

Maybe I am wrong. According to my understand "DMA_PREP_INTERRUPT" is trigger
irq when complete.  without DMA_PREP_INTERRUPT, don't trigger irq when
complete, not means use polling.

for example,
tx1 = prep(flags = 0)
submit(tx1);
tx2 = prep(flags = DMA_PREP_INTERRUPT)
submit(tx2);

issue_pending();

DMA Consummer just expect get irq when tx2 complete to reduce irq numbers.

If using polling here, it will reduce transfer efficacy. Of course,
virt-chan depend on irq to continue next descript.

Frank



> +
> +	if (!sddesc)
> +		return NULL;
> +
> +	return vchan_tx_prep(to_virt_chan(dma_chan), &sddesc->vdesc, flags);
> +}
> +
> +static enum dma_status sdxi_tx_status(struct dma_chan *chan,
> +				      dma_cookie_t cookie,
> +				      struct dma_tx_state *state)
> +{
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(chan);
> +	struct sdxi_dma_desc *sddesc;
> +	enum dma_status status;
> +	struct virt_dma_desc *vdesc;
> +
> +	status = dma_cookie_status(chan, cookie, state);
> +	if (status == DMA_COMPLETE)
> +		return status;
> +
> +	guard(spinlock_irqsave)(&sdchan->vchan.lock);
> +
> +	vdesc = vchan_find_desc(&sdchan->vchan, cookie);
> +	if (!vdesc)
> +		return status;
> +
> +	sddesc = to_sdxi_dma_desc(vdesc);
> +
> +	if (WARN_ON_ONCE(!sddesc->completion))
> +		return DMA_ERROR;
> +
> +	if (!sdxi_completion_signaled(sddesc->completion))
> +		return DMA_IN_PROGRESS;
> +
> +	if (sdxi_completion_errored(sddesc->completion))
> +		return DMA_ERROR;
> +
> +	list_del(&vdesc->node);
> +	vchan_cookie_complete(vdesc);
> +
> +	return dma_cookie_status(chan, cookie, state);
> +}
> +
> +static void sdxi_dma_issue_pending(struct dma_chan *dma_chan)
> +{
> +	struct virt_dma_chan *vchan = to_virt_chan(dma_chan);
> +	struct virt_dma_desc *vdesc;
> +	u64 dbval = 0;
> +
> +	scoped_guard(spinlock_irqsave, &vchan->lock) {
> +		/*
> +		 * This can happen with racing submitters.
> +		 */
> +		if (list_empty(&vchan->desc_submitted))
> +			return;
> +
> +		list_for_each_entry(vdesc, &vchan->desc_submitted, node) {
> +			struct sdxi_dma_desc *sddesc = to_sdxi_dma_desc(vdesc);
> +			struct sdxi_desc *hwdesc;
> +
> +			sdxi_ring_resv_foreach(&sddesc->resv, hwdesc)
> +				sdxi_desc_make_valid(hwdesc);
> +			/*
> +			 * The reservations ought to be ordered
> +			 * ascending, but use umax() just in case.
> +			 */
> +			dbval = umax(sdxi_ring_resv_dbval(&sddesc->resv), dbval);
> +		}
> +
> +		vchan_issue_pending(vchan);
> +	}
> +
> +	/*
> +	 * The implementation is required to handle out-of-order
> +	 * doorbell updates; we can do this after dropping the
> +	 * lock.
> +	 */
> +	sdxi_cxt_push_doorbell(to_sdxi_dma_chan(dma_chan)->cxt, dbval);
> +}
> +
> +static int sdxi_dma_terminate_all(struct dma_chan *dma_chan)
> +{
> +	struct virt_dma_chan *vchan = to_virt_chan(dma_chan);
> +	u64 dbval = 0;
> +
> +	/*
> +	 * Allocated and submitted txds are in the ring but not valid
> +	 * yet. Overwrite them with nops and then set their valid
> +	 * bits.
> +	 *
> +	 * The implementation may start consuming these as soon as the
> +	 * valid bits flip. sdxi_dma_synchronize() will ensure they're
> +	 * all done.
> +	 */
> +	scoped_guard(spinlock_irqsave, &vchan->lock) {
> +		struct virt_dma_desc *vdesc;
> +		LIST_HEAD(head);
> +
> +		list_splice_tail_init(&vchan->desc_allocated, &head);
> +		list_splice_tail_init(&vchan->desc_submitted, &head);
> +
> +		if (list_empty(&head))
> +			return 0;
> +
> +		list_for_each_entry(vdesc, &head, node) {
> +			struct sdxi_dma_desc *sddesc = to_sdxi_dma_desc(vdesc);
> +			struct sdxi_desc *hwdesc;
> +
> +			sdxi_ring_resv_foreach(&sddesc->resv, hwdesc) {
> +				sdxi_serialize_nop(hwdesc);
> +				sdxi_desc_make_valid(hwdesc);
> +			}
> +
> +			dbval = umax(sdxi_ring_resv_dbval(&sddesc->resv), dbval);
> +		}
> +
> +		list_splice_tail(&head, &vchan->desc_terminated);
> +	}
> +
> +	sdxi_cxt_push_doorbell(to_sdxi_dma_chan(dma_chan)->cxt, dbval);
> +
> +	return 0;
> +}
> +
> +static void sdxi_dma_synchronize(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
> +	struct sdxi_ring_resv resv;
> +	struct sdxi_desc *nop;
> +	int err;
> +
> +	/* Submit a single nop with fence and wait for it to complete. */
> +
> +	if (sdxi_ring_reserve(cxt->ring_state, 1, &resv))
> +		return;
> +
> +	struct sdxi_completion *comp __free(sdxi_completion) = sdxi_completion_alloc(cxt->sdxi);
> +	if (!comp)
> +		return;
> +
> +	nop = sdxi_ring_resv_next(&resv);
> +	sdxi_serialize_nop(nop);
> +	sdxi_completion_attach(nop, comp);
> +	sdxi_desc_set_fence(nop);
> +	sdxi_desc_make_valid(nop);
> +	sdxi_cxt_push_doorbell(cxt, sdxi_ring_resv_dbval(&resv));
> +
> +	err = sdxi_completion_poll(comp);
> +	WARN_ONCE(err, "got %d polling cst_blk", err);
> +
> +	vchan_synchronize(to_virt_chan(dma_chan));
> +}
> +
> +static irqreturn_t sdxi_dma_cxt_irq(int irq, void *data)
> +{
> +	struct sdxi_dma_chan *sdchan = data;
> +	struct virt_dma_chan *vchan = &sdchan->vchan;
> +	struct virt_dma_desc *vdesc;
> +	bool completed = false;
> +
> +	guard(spinlock_irqsave)(&vchan->lock);
> +
> +	while ((vdesc = vchan_next_desc(vchan))) {
> +		struct sdxi_dma_desc *sddesc = to_sdxi_dma_desc(vdesc);
> +
> +		if (!sdxi_completion_signaled(sddesc->completion))
> +			break;
> +
> +		list_del(&vdesc->node);
> +		vchan_cookie_complete(&sddesc->vdesc);
> +		completed = true;
> +	}
> +
> +	if (completed)
> +		sdxi_ring_wake_up(sdchan->cxt->ring_state);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sdxi_dma_alloc_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dev *sdxi = dev_get_drvdata(dma_chan->device->dev);
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
> +	int vector, irq, err;
> +
> +	sdchan->cxt = sdxi_cxt_new(sdxi);
> +	if (!sdchan->cxt)
> +		return -ENOMEM;
> +	/*
> +	 * This irq and akey setup should perhaps all be pushed into
> +	 * the context allocation.
> +	 */
> +	err = vector = sdxi_alloc_vector(sdxi);
> +	if (vector < 0)
> +		goto exit_cxt;
> +
> +	sdchan->vector = vector;
> +
> +	err = irq = sdxi_vector_to_irq(sdxi, vector);
> +	if (irq < 0)
> +		goto free_vector;
> +
> +	sdchan->irq = irq;
> +
> +	/*
> +	 * Note this akey entry is used for both the completion
> +	 * interrupt and source and destination access for copies.
> +	 */
> +	sdchan->akey = sdxi_alloc_akey(sdchan->cxt);
> +	if (!sdchan->akey)
> +		goto free_vector;
> +
> +	*sdchan->akey = (typeof(*sdchan->akey)) {
> +		.intr_num = cpu_to_le16(FIELD_PREP(SDXI_AKEY_ENT_VL, 1) |
> +					FIELD_PREP(SDXI_AKEY_ENT_IV, 1) |
> +					FIELD_PREP(SDXI_AKEY_ENT_INTR_NUM,
> +						   vector)),
> +	};
> +
> +	err = request_irq(sdchan->irq, sdxi_dma_cxt_irq,
> +			  IRQF_TRIGGER_NONE, "SDXI DMAengine", sdchan);
> +	if (err)
> +		goto free_akey;
> +
> +	err = sdxi_start_cxt(sdchan->cxt);
> +	if (err)
> +		goto free_irq;
> +
> +	return 0;
> +free_irq:
> +	free_irq(sdchan->irq, sdchan);
> +free_akey:
> +	sdxi_free_akey(sdchan->cxt, sdchan->akey);
> +free_vector:
> +	sdxi_free_vector(sdxi, vector);
> +exit_cxt:
> +	sdxi_cxt_exit(sdchan->cxt);
> +	return err;
> +}
> +
> +static void sdxi_dma_free_chan_resources(struct dma_chan *dma_chan)
> +{
> +	struct sdxi_dma_chan *sdchan = to_sdxi_dma_chan(dma_chan);
> +
> +	sdxi_stop_cxt(sdchan->cxt);
> +	free_irq(sdchan->irq, sdchan);
> +	sdxi_free_vector(sdchan->cxt->sdxi, sdchan->vector);
> +	sdxi_free_akey(sdchan->cxt, sdchan->akey);
> +	vchan_free_chan_resources(to_virt_chan(dma_chan));
> +	sdxi_cxt_exit(sdchan->cxt);
> +}
> +
> +int sdxi_dma_register(struct sdxi_dev *sdxi)
> +{
> +	struct device *dev = sdxi->dev;
> +	struct sdxi_dma_dev *sddev;
> +	struct dma_device *dma_dev;
> +	int err;
> +
> +	if (!dma_channels)
> +		return 0;
> +	/*
> +	 * Note that this code assumes the device supports the
> +	 * interrupt operation group (IntrGrp), which is optional. See
> +	 * SDXI 1.0 Table 6-1 SDXI Operation Groups.
> +	 *
> +	 * TODO: check sdxi->op_grp_cap for IntrGrp support and error
> +	 * out if it's missing.
> +	 */
> +
> +	sddev = devm_kzalloc(dev, struct_size(sddev, sdchan, dma_channels),
> +			     GFP_KERNEL);
> +	if (!sddev)
> +		return -ENOMEM;
> +
> +	sddev->nr_channels = dma_channels;
> +
> +	dma_dev = &sddev->dma_dev;
> +	*dma_dev = (typeof(*dma_dev)) {
> +		.dev                 = dev,
> +		.src_addr_widths     = DMA_SLAVE_BUSWIDTH_64_BYTES,
> +		.dst_addr_widths     = DMA_SLAVE_BUSWIDTH_64_BYTES,
> +		.directions          = BIT(DMA_MEM_TO_MEM),
> +		.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR,
> +
> +		.device_alloc_chan_resources = sdxi_dma_alloc_chan_resources,
> +		.device_free_chan_resources  = sdxi_dma_free_chan_resources,
> +
> +		.device_prep_dma_memcpy = sdxi_dma_prep_memcpy,
> +
> +		.device_terminate_all = sdxi_dma_terminate_all,
> +		.device_synchronize = sdxi_dma_synchronize,
> +		.device_tx_status = sdxi_tx_status,
> +		.device_issue_pending = sdxi_dma_issue_pending,
> +	};
> +
> +	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	for (size_t i = 0; i < sddev->nr_channels; ++i) {
> +		struct sdxi_dma_chan *sdchan = &sddev->sdchan[i];
> +
> +		sdchan->vchan.desc_free = sdxi_tx_desc_free;
> +		vchan_init(&sdchan->vchan, &sddev->dma_dev);
> +	}
> +
> +	err = dmaenginem_async_device_register(dma_dev);
> +	if (err)
> +		return dev_warn_probe(dev, err, "failed to register dma device\n");
> +
> +	return 0;
> +}
> diff --git a/drivers/dma/sdxi/dma.h b/drivers/dma/sdxi/dma.h
> new file mode 100644
> index 000000000000..d38870ea7d91
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright Advanced Micro Devices, Inc. */
> +
> +#ifndef DMA_SDXI_DMA_H
> +#define DMA_SDXI_DMA_H
> +
> +struct sdxi_dev;
> +
> +int sdxi_dma_register(struct sdxi_dev *sdxi);
> +
> +#endif /* DMA_SDXI_DMA_H */
>
> --
> 2.54.0
>

