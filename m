Return-Path: <dmaengine+bounces-7459-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD0C9A543
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9C341127
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3862F9DA4;
	Tue,  2 Dec 2025 06:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="diXjWAKb"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010035.outbound.protection.outlook.com [52.101.228.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E01F151C;
	Tue,  2 Dec 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657242; cv=fail; b=l6myeUEzD/x777LUalLKJFJ8bbo8Igdw+VUBXFX6Wf9Qkpy7ZE3x5chNYr+SW53UW5lcU/X+xS9ZvbUj3SZwx2CgMFQSpnYNkZ6WbYmUDgMey44mo/k0paRMvuJBP/KHPvfqTgkFAwWL+RpSm3kUMyi0xyRJWT0xVjcVKE7KsS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657242; c=relaxed/simple;
	bh=v2XZQAFiRRXGd73VXAoYoaqxa6GMuFftcbvz3gG0bdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Aj/2g7sn473T/n5TM8XRdMzOb7Zo71CBhG+xGkejbXQCVZutDxJwY2jNKw6vH8bZs1k4aAX8Ai8DTkveda9dlSmPCDGTL4KAKxhwQI8KaksGFG6aOE1MBZl/i0YbKByAM3K5TR6Efdo8ByVQeQHwNkhWDNDj4lTRgmKIV7n278E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=diXjWAKb; arc=fail smtp.client-ip=52.101.228.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwxZ5s0hvjROgUNuSUCI1jPAp3LHKfHMyUe1P/6q5Bq/o14bRKVWt27eEx9wYH6cucn5ajDLReu/2h6ZC3qQNNrMhmzJIvTCPI8NvgvTaLL3zoeulbkcIm6UGW02ETC/ouTmJE8kXI/BoZaJvHkXDtPrDSxH8hxTslwUihmS311CTn7yA+0YB47/1c4HoEFEESjm9e0pgKHRc/I1LWBL7lSxbHBZppgLYVAEXRW7mdac5lkykfMqvJSYv2lyJ4GQPLRWMD85JolZ1sC7qTyYTWUEutMraRh2myyk33OyuRef0DIY1iKH6M5q4ojw9jEOAU0aIhX0wGTB+7hJoIVVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9y6tWRl9Q8bOxypxt9eumd2jGjTOFGR2ABA4SUfqc8=;
 b=fOZogpEkvrf02ZVS5HPV0eeH10W9RsDp68L30muaPNmQHjD0vndoBkGazYVFcwsLA4b1J46G4nq0TAKqRQ27bMcsfhx4P2E3bSRcQkLIrryPPTO+9gDR8cd3iCiTSvtsioYpod+C0lHbL3a7pZ9Bx1vsmqGnpqbL7W9M21/sxBJkvOpzBFLUXDewyQhZaQ2DCMGssvppjszDjZngGgy8B2iatvB/Ya5/HrkDGhAtNNtsWOXzuqiKLjpwxXRI7m0Kk4OuuN9LrH2gwFAi+5W5c1B2AVUu5g3eVkuIM7kWAscgn3zChFbL037l7A/QmHxoe0ncXM6Qx5oKH/iTDqbX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9y6tWRl9Q8bOxypxt9eumd2jGjTOFGR2ABA4SUfqc8=;
 b=diXjWAKbtICKASAyUJfblsxcPfSARjRvHv1/nrWXBq5Z+QHSOelIsXyQAdAoz4vLh9C5F6Nxvlhr6rA2fnYQ3gI/u4VLCWcz3/32RBP1SzMh/P0psYbDtfZFODhTuZeBzr4VJZvQNrUvXdNfkFZd+WhIYD77SC4/DlcJmiEndt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY4P286MB7525.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:351::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:33:58 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:33:57 +0000
Date: Tue, 2 Dec 2025 15:33:57 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 14/27] NTB: ntb_transport: Move TX memory window
 setup into setup_qp_mw()
Message-ID: <rgc2guhv66v2gqyjiox2oslhvctbqygkl75uwouj7e5e3w6bgs@djdn4yp7akv4>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-15-den@valinux.co.jp>
 <aS30YHfDUH7mRheL@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS30YHfDUH7mRheL@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::15) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY4P286MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: cabbf7e4-44ab-4157-0f4d-08de316cc5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vbKH+KW/vCO28KhnYgLYkE4jpmLkUohDeJgmlqIPVhoTHruCST4pFmfOP21Z?=
 =?us-ascii?Q?Ko4b7ISu2fLCHvLSzPHBOwIsDXLWBlLrwyUN9g/5r4WtXwJfF6QwboljIYHN?=
 =?us-ascii?Q?vr3Tm3hWrjR8CtV4JeDl+BCQAS1GVwdEbU6Y/yjvhiqTMYo5lyzgLuacWzi9?=
 =?us-ascii?Q?33MrmLfGV/w72LwIwXiMZ7MltzlJ++XFEdByldtNMLh8LzTiSHxXmwbopypK?=
 =?us-ascii?Q?IZbPLCkUaN2ERUq6dxzap5lTD8Kn/jONssPD+M3sKqNfdA4RT/VtSEmDlIQp?=
 =?us-ascii?Q?KbcTyxPRyaekajF5Zz5JAl2sO+2qyEAZWd5oQ57TlOfh4YybKw2QC8QyEweC?=
 =?us-ascii?Q?0atATn2Z4CFseg6cmQVNPTZkQiFUsq2FnYZcBRzT3D0F6Zj0Gd8vYYg5fK7f?=
 =?us-ascii?Q?YDcB4QO/JnpfkaE0oCxoATgSTWop1a2qyC00SmWGfnf+d/7sDdl95pdr+H/3?=
 =?us-ascii?Q?2kybfAGtYK+8rcmrhG8FK28g8Dp7YffPHP3D4QtvuQVp7/flpS4JcA1NAp4z?=
 =?us-ascii?Q?9uTDh1r+TgYRugR+xq+uAZakyFmexPp6X0oQGLVF0TnCqQ1mA+Xnufg5j+4l?=
 =?us-ascii?Q?JvKeIHfA3X9ijKheW8AdDpewfIlP5o3miYFGCUxmEPYFDqgkbGcWnbWhy0yd?=
 =?us-ascii?Q?g2KJrtE3dsX4mo/1AxZm3hIzWG7CXspjIvT2r8vFFm2zauJvSrdujhu2W2Wo?=
 =?us-ascii?Q?Kw/7NSC6z/qlYpUrX/0yKuh/6WZQ0tLLQwekWiR8AOwlgG3CsE5u0Mt4MyiW?=
 =?us-ascii?Q?naDu3aXc+GAuunVpLlfP7jc0ny354iuHD/WNz9WwMl+yPoQIJmHVkILgRmGq?=
 =?us-ascii?Q?22DGYj8wCI2WrIZwP5qgVTUu12M34HVJH14TO55emYz/Vtm5yyz7cm3PkWwX?=
 =?us-ascii?Q?KZxvt6Lp2efmbRwbJQRARptYB2V44OCCp9jhG5XY/dkIwVAcaWuvrsgKAyKo?=
 =?us-ascii?Q?27kERRqh4F9nN/M0b3saM3e2QXgwSRvVp6aZWAMCggrkc/dJ1Djc2Cti/GGJ?=
 =?us-ascii?Q?BzYsh40dvnDLjorPUucXDM40uhOjaWHDoeJ0bA+TRbu2sf33oMnVV8iBB10o?=
 =?us-ascii?Q?elA3QJabLWq8/+ZEHxUtu9ZYTeYg9yiWwUlx3QY1tooQqiwljH1i0EYmY33C?=
 =?us-ascii?Q?T3QRZcqZWyUCxYQzKys2/qA16W+TUjSJraaTKfWkAAtlFUdgI73Au2u0JhNi?=
 =?us-ascii?Q?C2dSU5nqI89qd9LdIGtwyRC23m6aOuMGMsrXuvbwI9amKQf59AehLSMue5g5?=
 =?us-ascii?Q?VgKAZC+kIHdHZx5a3pyO5xC5zJHD/LE8sos1vnWPAU5Vd/JCyglC9VpCwz9Y?=
 =?us-ascii?Q?XxPdIt/9a63MT6sqhZ6/EZRemPi1tM3yTCk9yOtiZOPqY9BJtfpQ9XIq/C7k?=
 =?us-ascii?Q?tn91g+YtADmBDiBZr87jbvOYgGYB4WEVFQdfM/KCo0wJeQjx9va22jUZnsoa?=
 =?us-ascii?Q?ivEBiWZkYV2lykvYAK4lHVWFXDQri8j+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PPqamHi5ILJhT37rsYW0q7LDRfwTt+0DOQAQJ0tiyOreidMm2ACRLZvtasPY?=
 =?us-ascii?Q?/61YcLKg1/DgVoPGM709cWvU/qcPgTjevNYu/EznkKrvCF51VIEdWl/crkoe?=
 =?us-ascii?Q?MLpVCg+wJ5AIPm0BzNa7lYtodmpfw5FOAK4ESxidIPl58Tew4uimL9bahacY?=
 =?us-ascii?Q?QXRmSOjXeAFArS+JXthHyVi9xhWo7AaGZorLakwO/c1rdbLATELPcnc/Sl1j?=
 =?us-ascii?Q?J0HzwzDWK29S6tmCpUpT9freCTVWZzjWdfeHZdQIu1VLJjidAMlNrFEyM6kB?=
 =?us-ascii?Q?qXz6DKgWZiJ+DUDiGoTe5K37HokoxDt41jfZ1Q1R/8x5GKFyzWYr3Oni8hdf?=
 =?us-ascii?Q?r+vsHOO0g1bGYKM66D+xAv23s0ax4O61sRgwK/jxKyeUPcvr/8ZUd4w1KOIV?=
 =?us-ascii?Q?Cwn5eZwLLDJX4QKDVLzVaYhNju3AjuRqff1r2ZdfhMll9xwpHLwHlB23fmtv?=
 =?us-ascii?Q?5Ew/N9CXW+6otJzqhgxS/4PS30Sl3eCMK5R/doHZsYA80MojWgfseNJZLOZs?=
 =?us-ascii?Q?NmaWygMaqk0ZngSnAR0puw4XW1NPYfEn2WLc+1995oiM+gVHTri6E85c9Y8c?=
 =?us-ascii?Q?1oUBaKpIPcv3koGWfjKddomDETZM27/17q1oKiEdqbmqhu84zi8ecqj7uVAy?=
 =?us-ascii?Q?94OVMd7ewIQfXRFl9IWW83tuh0cErVIcP0gvE5E+n2O6q7nW15Nprs81ispR?=
 =?us-ascii?Q?rqcA5uCVctVzfSE4LQhGapn/+OLZl9Jw0RJQxeDpmDPplJaRLeYBt0fk8vSs?=
 =?us-ascii?Q?66hxCOzudRkliVlEswD/YbZ4vYJuwQ8YMjAmAnurcQLL9KxiG553ZAwqf+nx?=
 =?us-ascii?Q?fdIR6CeBDkXiaEW0LgYkshzVdvoXWh1c1ob0X8c9or3geaSdj/dHbt00LORP?=
 =?us-ascii?Q?ubNeYYMAdYZIynZ3t9XF/kHEy+/pdXFtuG87npBgGrdZfP73INAD3Lh4lsEc?=
 =?us-ascii?Q?cUbRCRx8ij+Wwx91vG02k8UjsoxxKDpkvocx4hUhE/gE+tUM2dbtcJhesEe4?=
 =?us-ascii?Q?AckiqYD+mAIPcf7SP/SJc1mEKqNVlzfhThX/TB4j8aqhxUTptl59YC+STxa6?=
 =?us-ascii?Q?eGkHt3F6wEcuwMr+NXCBsvytN9/N4OxwI8Yo3yjiLPHZUoyWuHwXUwUvqUMa?=
 =?us-ascii?Q?noh3vqSfefb1+TkGzmrzJzIjNec14I41j/9/y86p6HuGo1XATVdKxETDHq5D?=
 =?us-ascii?Q?2iM7bZcnIKaRieDaoqxmBhiDiI1dC4DzK2j7rpPIXsQhU4YI7hvN9DHtrsYD?=
 =?us-ascii?Q?DxMOQqUuJYJDFtq9mKGKqdgToPQEv3rOKSs2AUxt2RbjV+4A0f9wluinHruX?=
 =?us-ascii?Q?IraGsrL7lHOYxIhBAtSJjzkkMxMYtpU6rYFX3l5aCTGOjXOE8Rvh2pco6OEI?=
 =?us-ascii?Q?rktVvYUaQ+JSpImLa/lfBXzsvBt+Y5sk7pPAQ0lkcIrDVpYwjPvv7vali4Bg?=
 =?us-ascii?Q?pc+8uGwE8aHRKXHJ+QYKUi3qq3X0cWqKmGcyFdVBnv3ze3RwN49uoadVHyKr?=
 =?us-ascii?Q?7pEudfnpfjpCQHY4C10/uZ6x7s6bFp6DpND2w9KAaZnmmOAlmc39lmEMMBVU?=
 =?us-ascii?Q?anAADwfk9YsJEZZuTt0IUXS21Q7guutmJGClVa/9y85qZxZcHLq04nZJ+vNQ?=
 =?us-ascii?Q?aqtJ3eICj9cU0zPPu4PGa30=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cabbf7e4-44ab-4157-0f4d-08de316cc5d4
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:33:57.9396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmAUV6MJyhliCp7lZrW477bRogO8xursbihLyx2lMVFbsQTXsUrfOav2UskpP2loneGTXa0f/2UID6EFz1SM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7525

On Mon, Dec 01, 2025 at 03:02:40PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:52AM +0900, Koichiro Den wrote:
> > Historically both TX and RX have assumed the same per-QP MW slice
> > (tx_max_entry == remote rx_max_entry), while those are calculated
> > separately in different places (pre and post the link-up negotiation
> > point). This has been safe because nt->link_is_up is never set to true
> > unless the pre-determined qp_count are the same among them, and qp_count
> > is typically limited to nt->mw_count, which should be carefully
> > configured by admin.
> >
> > However, setup_qp_mw can actually split mw and handle multi-qps in one
> > MW properly, so qp_count needs not to be limited by nt->mw_count. Once
> > we relaxing the limitation, pre-determined qp_count can differ among
> > host side and endpoint, and link-up negotiation can easily fail.
> >
> > Move the TX MW configuration (per-QP offset and size) into
> > ntb_transport_setup_qp_mw() so that both RX and TX layout decisions are
> > centralized in a single helper. ntb_transport_init_queue() now deals
> > only with per-QP software state, not with MW layout.
> >
> > This keeps the previous behaviour, while preparing for relaxing the
> > qp_count limitation and improving readibility.
> >
> > No functional change is intended.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/ntb_transport.c | 67 ++++++++++++++-----------------------
> >  1 file changed, 26 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 57b4c0511927..79063e2f911b 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -569,7 +569,8 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
> >  	struct ntb_transport_mw *mw;
> >  	struct ntb_dev *ndev = nt->ndev;
> >  	struct ntb_queue_entry *entry;
> > -	unsigned int rx_size, num_qps_mw;
> > +	unsigned int num_qps_mw;
> > +	unsigned int mw_size, mw_size_per_qp, qp_offset, rx_info_offset;
> >  	unsigned int mw_num, mw_count, qp_count;
> >  	unsigned int i;
> >  	int node;
> > @@ -588,15 +589,33 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
> >  	else
> >  		num_qps_mw = qp_count / mw_count;
> >
> > -	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
> > -	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
> > -	rx_size -= sizeof(struct ntb_rx_info);
> > +	mw_size = min(nt->mw_vec[mw_num].phys_size, mw->xlat_size);
> > +	if (max_mw_size && mw_size > max_mw_size)
> > +		mw_size = max_mw_size;
> >
> > -	qp->remote_rx_info = qp->rx_buff + rx_size;
> > +	/* Split this MW evenly among the queue pairs mapped to it. */
> > +	mw_size_per_qp = (unsigned int)mw_size / num_qps_mw;
> 
> Can you use the same variable firstly to make review easily?
> 
> tx_size = (unsigned int)mw_size / num_qps_mw;
> 
> It is hard to make sure code logic is the same as old one.

I'll do so. Thank you!

Koichiro

> 
> Frank
> 
> > +	qp_offset = mw_size_per_qp * (qp_num / mw_count);
> > +
> > +	/* Place remote_rx_info at the end of the per-QP region. */
> > +	rx_info_offset = mw_size_per_qp - sizeof(struct ntb_rx_info);
> > +
> > +	qp->tx_mw_size = mw_size_per_qp;
> > +	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> > +	if (!qp->tx_mw)
> > +		return -EINVAL;
> > +	qp->tx_mw_phys = nt->mw_vec[mw_num].phys_addr + qp_offset;
> > +	if (!qp->tx_mw_phys)
> > +		return -EINVAL;
> > +	qp->rx_info = qp->tx_mw + rx_info_offset;
> > +	qp->rx_buff = mw->virt_addr + qp_offset;
> > +	qp->remote_rx_info = qp->rx_buff + rx_info_offset;
> >
> >  	/* Due to housekeeping, there must be atleast 2 buffs */
> > -	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
> > -	qp->rx_max_entry = rx_size / qp->rx_max_frame;
> > +	qp->tx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> > +	qp->tx_max_entry = mw_size_per_qp / qp->tx_max_frame;
> > +	qp->rx_max_frame = min(transport_mtu, mw_size_per_qp / 2);
> > +	qp->rx_max_entry = mw_size_per_qp / qp->rx_max_frame;
> >  	qp->rx_index = 0;
> >
> >  	/*
> > @@ -1133,11 +1152,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  				    unsigned int qp_num)
> >  {
> >  	struct ntb_transport_qp *qp;
> > -	phys_addr_t mw_base;
> > -	resource_size_t mw_size;
> > -	unsigned int num_qps_mw, tx_size;
> >  	unsigned int mw_num, mw_count, qp_count;
> > -	u64 qp_offset;
> >
> >  	mw_count = nt->mw_count;
> >  	qp_count = nt->qp_count;
> > @@ -1152,36 +1167,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  	qp->event_handler = NULL;
> >  	ntb_qp_link_context_reset(qp);
> >
> > -	if (mw_num < qp_count % mw_count)
> > -		num_qps_mw = qp_count / mw_count + 1;
> > -	else
> > -		num_qps_mw = qp_count / mw_count;
> > -
> > -	mw_base = nt->mw_vec[mw_num].phys_addr;
> > -	mw_size = nt->mw_vec[mw_num].phys_size;
> > -
> > -	if (max_mw_size && mw_size > max_mw_size)
> > -		mw_size = max_mw_size;
> > -
> > -	tx_size = (unsigned int)mw_size / num_qps_mw;
> > -	qp_offset = tx_size * (qp_num / mw_count);
> > -
> > -	qp->tx_mw_size = tx_size;
> > -	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
> > -	if (!qp->tx_mw)
> > -		return -EINVAL;
> > -
> > -	qp->tx_mw_phys = mw_base + qp_offset;
> > -	if (!qp->tx_mw_phys)
> > -		return -EINVAL;
> > -
> > -	tx_size -= sizeof(struct ntb_rx_info);
> > -	qp->rx_info = qp->tx_mw + tx_size;
> > -
> > -	/* Due to housekeeping, there must be atleast 2 buffs */
> > -	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
> > -	qp->tx_max_entry = tx_size / qp->tx_max_frame;
> > -
> >  	if (nt->debugfs_node_dir) {
> >  		char debugfs_name[8];
> >
> > --
> > 2.48.1
> >

