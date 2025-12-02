Return-Path: <dmaengine+bounces-7469-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E42C9BECB
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 16:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0383A6BC4
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1197124BBF0;
	Tue,  2 Dec 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AL00iX9Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011044.outbound.protection.outlook.com [40.107.130.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAF13D891;
	Tue,  2 Dec 2025 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764688826; cv=fail; b=WDItpMXXjF5V4lA5KHwOZVBWQXdi9YDgMDQz7TgFaz3JvbCVnzJWeXb9f4LyQPkCjRSnahIWVL/8GtEeX4BLjgpN9d2yFpsRkYtQOmtLkCT9fqXSwMMts2913fRQOuX80/MgeoCS+kTCYZXj2VwN2rGHHNmMu+q/+0/mWOvXtic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764688826; c=relaxed/simple;
	bh=Mp74CE06WfVvoTg9+psb5bPVO9qGRh1HsaL134/a5RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q0REUbOtBWIip4t2h+gFLBkHm0+MU1gaxxzu6eh6+qWpdr4xBEPDQeit2H6WPEf+BT7RlGiKGwIdFdrr7qx/SHDOpeEOVnFYCYSNNrHVCqruLBF9YkDmYPlpT87Lz/0vRLUOt9t/XMIueUMohiHNBIaC9WpiwPfBaEyPKhyyasA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AL00iX9Y; arc=fail smtp.client-ip=40.107.130.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTST4HGCS1voTXXHKyRY5mE5wJzH6sGzU+dhbRk+DHgymNWZ0u1QFTtirbLqxtn3giAGb8EBEjCrngMegmZxkzQlK8duJU4snYZA6x8mpfE9C65cSZ6HzEj9SStJnM3CIUN3yAl3p/suF2mVyrZ8kAYxUElknEGz6vBEmnoEoPito3K2uMC1AwkWKTzm57rg6DVYav79X/zPDu6J2O6xaRVmdgQLGz5lclkEbSRjCHPi2bWJF5A4RTw4NokNYq77Z7zn9JKNHzPBS+IeMFIvwC7bSfMc9nrCgUhBvgttTBYKpRTREZlxLvtoH//SSLG2SbmabBwT5ReJtyCLN7wUlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDl/l+oxZk8MN32T6OZNw5rs5qIgIT2neZ3p97uotYQ=;
 b=Bm6WLBdNSTcEkQcJhlrdLX4JWgjMp5XmHvXTW2PKe7nlotW7BC8aUzCINJrT2HR/qdPemV/F8FGj8NyuyAJe5vYPhyEBuGdvVLEhjmiWPLj2c3MJoILO5k11uCE0OdIDIZBlr0eBZ4SR7r2x1r8CTcqrhAzHtte44Lg1t3fuJk+HVVK41A8cOo/Mgm8/O+psuow95hoNCFHSjk1WO9FnvJoS9fmchNjiCfxBjbVlmaJpxtWSYGZfkPSn/AzBv0+5bYJiuqNAL+gohErnIPTpbqQ8nqpWHGtbqDykkYTa5hlR66lb3oRoim/Rt1Rdu/DrnxsrPny/N2CA/ZvV9l184Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDl/l+oxZk8MN32T6OZNw5rs5qIgIT2neZ3p97uotYQ=;
 b=AL00iX9YkkQKk5ceAFM4RR5+J5hiYYLzYJOjjnXDpQQ1mwBdszFaIDZgvOhr9DP62/RJvWRSWlRQ7veVhj/fk7Fj0r+EGP8baZqASfNjhQp9RjzlbMVcjFi1lWNMOMww6qMg1zzAKNn/JFyN8mlhNOF83HLTtpiTHr4TWyRRjw10vHAmPvjliKfdHBYaE7Puqk11bS6ON+FiTZtDlBSs4oeb4B6Rx/8o+YhxqpfR7uC3IXITCciWE3qpELfOV+19cSd81vugYoX0DWazeM7eSdcqI1HFD+bKBBsnfd9Le7I8dkOaeDvBsHvWwHioQutHstywvqyTioLTFIUUYTh2Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GVXPR04MB9804.eurprd04.prod.outlook.com (2603:10a6:150:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 15:20:19 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 15:20:19 +0000
Date: Tue, 2 Dec 2025 10:20:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
	robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
	arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <aS8Dp/TSEPhXL2FV@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <aS39gkJS144og1d/@lizhi-Precision-Tower-5810>
 <ddriorsgyjs6klcb6d7pi2u3ah3wxlzku7v2dpyjlo6tmalvfw@yj5dczlkggt6>
 <aS6yIz94PgikWBXf@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS6yIz94PgikWBXf@ryzen>
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GVXPR04MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: fb760b84-78a4-47cc-1290-08de31b64dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oYMuJfJK7S4yyX1E/lGxu5R4x0Ssgi7Vshe9FQ4HAWkCYuvlHvk00Yvg0rGc?=
 =?us-ascii?Q?k9T0bIiMmcCQJbh6j2lFxfIhkPput9dJOW2cMKYO7wuyImP5qJE/XwmjA7yx?=
 =?us-ascii?Q?niVDoWc3Ip5HTr50eNu2O2EpbdJKRBYOssVkoSywDbk0DmAaoPG6gvpVsekd?=
 =?us-ascii?Q?T9085Bl00VelPr8O6WsG8qpaVulLQKau86zelb9a9KmDyPCXwj1NKzyYfdZM?=
 =?us-ascii?Q?lEhbOx2JyeQhqXk/Nguq8SSFkP/evsl1vrH1Q55JYqs/U6sqMh/n5D0kCAxb?=
 =?us-ascii?Q?FXxA82qic+T65COgGesFIATvkMgx9ID0E7gctPqtfn+aikMZqVDRGeb8GxSS?=
 =?us-ascii?Q?Wztq+T1JGd19viLYBKPCT3vqwcohb6pD59VdIG0CHW7npxUiwampPWUla7Tb?=
 =?us-ascii?Q?RGiSO+eIidZzN3G7K9po9lqA6uGnA28abmReedGwHHEKUBCOHJbQV3BoEHt4?=
 =?us-ascii?Q?esAe4HQtSWFqLYHeh6Kcn2nBs/06iagKz80pj+VQ2Rt4h6RdBPHgOn75738v?=
 =?us-ascii?Q?yl3WxTZaZijiXUKDldKydUIWn2r1iEbq8ol68xs+tXc2qqbKWvY+5HTX9uK0?=
 =?us-ascii?Q?XKdRUyJFUnqVd63XBHczGrsld70br0Uuv8r1g6jqKfbf1ADRpsLjL3MRJEgX?=
 =?us-ascii?Q?TFdQ7oV6mlLnL/rlvfTYs78RzgUKfMIJgFEszGwqL3z5Mk7sBuzX+vAjKZS6?=
 =?us-ascii?Q?GP1ZrSdXNn/VKL9Cg/jqmUyhz0eBmele7amcwaq/Rsdev2raSKoc4etf/s2S?=
 =?us-ascii?Q?jvX7x/FOn6A6+PFOintZsj/iAB2eyllQBHqnFsACR6jOB8nWlfrThu0DpSAi?=
 =?us-ascii?Q?rW3vCWCIpuI5Cc/WinXDLhRTClz57Iq27mN+bn7ifSjAj3hB9cLXsOTQH/OZ?=
 =?us-ascii?Q?lWbA1cR8EZz9RWaEBoSqeY+L0xkf/Vy++C6a3KWY+fJiuDHaGl8C5uUtEHDa?=
 =?us-ascii?Q?Lnv3gY8lQwC/fTp+kQkEOZmYfGzzhYj2qI4y/YvdYo8PnUsF8RUmBkY8fSIY?=
 =?us-ascii?Q?Rr5cnApEw+405F38KacpStkPIhwMedfn+Sg1mFJL60fPlaBY7p4fpq8SpLWw?=
 =?us-ascii?Q?VjWZasGrWsYlO4ijC8hJzwWzwE+kMFgng9rjX3byhr1ABO8mUDLVp+armknH?=
 =?us-ascii?Q?0vlbYRDcm6ddV3kl/4qdI7y2Cho+WvfDVoiJRt0RXVyI9fQyIwrH3qnH7DBZ?=
 =?us-ascii?Q?e2QTBQFbTYOI5zpzh3TirxkZBT/sxfxHLHXi0jwgvPzrRPT6cm1nOEzxcD26?=
 =?us-ascii?Q?VuqxsSQN/Yh00iDgSdEoQhq2P7J+EJqzCfKZlxKbqTpDMVyIfj3+K4czCrxv?=
 =?us-ascii?Q?f2mBl87vOeqjAGcgdNSs/VMj0/vGx53tIaWpcMjnJdmGhQ76eGxYtfwrUDyB?=
 =?us-ascii?Q?XUAONw/PpKa48PSnbRGyuMn3rT8scunyb2MqU4y/CAT0RBY305lkW5BZ1tpg?=
 =?us-ascii?Q?+0I++rIHWLRsfZAr96p3nCbrnpSTeNvCOs2hHLciCAV/UOyPlt3vOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Br+fivt5u/iju51fxCStivnQ43zEGoH5AtQxv5DGsaLnVoi6XRCMrlVSkGgQ?=
 =?us-ascii?Q?4tdLSm1mNGjwAcrk9Aj5u7J4PZucLxk/G5Y9cQN6Qvk6J2MnSJ4am56i7S3z?=
 =?us-ascii?Q?sva4nwIhyFDY8G312oUipe8+can1OTGAT+KSt3vD3uYaRtE7/9ojtJELpnKC?=
 =?us-ascii?Q?a5kMd/HSdJujDigkeLxtT6CgpsxBttJAl8NENP+AGZrIf3+ba7x2L3KsEy5i?=
 =?us-ascii?Q?brDAg8/eEjFhvv1hAsQaY+6D+1y1ex4dsGRmaNDG0kxoEfQTahHEIvf8TR8S?=
 =?us-ascii?Q?iZx6AwP/YJVF9ndaYIL5CveCnF87JRRpmgcFoNusaoev77OUvpKpYFigQWh9?=
 =?us-ascii?Q?hr3ibRpdfV0Rts7rFWBcz7T1Xp6XNRwGHTuvPemX4fr0CNcV/8JteUyHehtK?=
 =?us-ascii?Q?pyOqAKpdqu5qYzeXj7eKMXZFxyK6VIQ+xEidKW+7N2d7C2ZP7kE+2PnWaDNK?=
 =?us-ascii?Q?JMTso/vkI5x3CWbw7fI0pbwWUfEioZSSHtAwK2ZjhNyhy7VFsYQqrfBXLEES?=
 =?us-ascii?Q?+G9us+0Pkx5WSXvrNrztOXfa6ie8gOGx1QhtcBLrCiYHqIThcbBeFE7bDf87?=
 =?us-ascii?Q?mGYSSHy2hcBnH+/zInc2gnyFcVIdL6iTISun02N9ZdxIxt7EkDxIwkGM0IPd?=
 =?us-ascii?Q?9ZuHPscdKXrcIIcDOdXet4MJewin66mx3HuufYxOsYz02i/gLlxXZR2pGrQs?=
 =?us-ascii?Q?/RNGtWd/JGgGcRtP55t+aHAbJJz/FSucKgUTK8fMXCdCL0Coeybj+5NhmgAr?=
 =?us-ascii?Q?BArMlWY8XaQLdGEzmzl7XwtmLDEyPNzO2uBRSeyw22zklU7n+Jke3V2W0M+K?=
 =?us-ascii?Q?d39BGuNkcVxigXcX64mzpjNQVUkm45eJqMj4crGgukFrQDGrJtG/1Vent3xT?=
 =?us-ascii?Q?OxbkzQft9hxnsoyyq2PS1MYaul1ssIreYIqy25rCCdaPypDUE2/HtNdC9fbt?=
 =?us-ascii?Q?MV8Fjcsjfa/AvDZasL/Jb85EWuY7ZJixsjtmFQb8SShyUb90wI4dz7WuhHUz?=
 =?us-ascii?Q?VXUbkT8VK+qB3XRb8mXJqZY31xBimwS7xaSgjH47ueSP/ikeBm8qwsxsIptd?=
 =?us-ascii?Q?dvI6IzdsKn8w3AWEdHKK5+0iQ4Rs0GOzH3TsmNXOesSN5t+p6zoeyNx0AQOz?=
 =?us-ascii?Q?WvkHoiUmrUZ8AJ02YxQ9ueXP08QFDMOPaUXWuMi3dMjXYEXdn6nXqnQhHK7g?=
 =?us-ascii?Q?nTuAfua2FAbYvYhBL0Az4EikJkppUdaXTpFCiJSua18w0JACMicP66xPwhLQ?=
 =?us-ascii?Q?tFQOZLVGrMU1iUjDVQUnWbK9vkpXjRI8NMIFqIInIfSdyrV45LtS/QUrCRAb?=
 =?us-ascii?Q?rcD81JVPjowqILhJTCaG9yFkGCjUrDeoJw4OcqLT0IaLqKjf3DltfTxDeLt0?=
 =?us-ascii?Q?TX9fEg4k91722BYFXyqST07Ztx4s/8jyA2j/fcIwZigLRpHjrKd85KqgqZMW?=
 =?us-ascii?Q?cAw5lgoO6k8jzhHiAJvmHeeFtT2XpNrZJHhYDsiv3NOT41xFI/b9kmaQhWVd?=
 =?us-ascii?Q?FOXKxywUqwrzZ1rM3ehcYt+DEYeJ3tAYj7FnjG99qzGK6c/E4/8nY3JtfKmA?=
 =?us-ascii?Q?mU/8fl1NDRalf1mi6Y+KUJLFeLKFbvBv/ct29BFs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb760b84-78a4-47cc-1290-08de31b64dfd
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:20:19.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCkGkx1gMkkdVO6+2ZrSpwos43+rKtn+TLrPL1y+SnFcdZ8Ey6hxTZofO0gw35usv8TFTvQEvaEgKrQRD2Xc1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9804

On Tue, Dec 02, 2025 at 10:32:19AM +0100, Niklas Cassel wrote:
> Hello Koichiro,
>
> On Tue, Dec 02, 2025 at 03:35:36PM +0900, Koichiro Den wrote:
> > On Mon, Dec 01, 2025 at 03:41:38PM -0500, Frank Li wrote:
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
> > > >
> > > > Under high MSI and eDMA load this pattern results in occasional bogus
> > > > outbound transactions and IOMMU faults such as:
> > > >
> > > >   ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
> > > >
> > >
> > > I agree needn't map/unmap MSI every time. But I think there should be
> > > logic problem behind this. IOMMU report error means page table already
> > > removed, but you still try to access it after that. You'd better find where
> > > access MSI memory after dw_pcie_ep_unmap_addr().
> >
> > I don't see any other callers that access the MSI region after
> > dw_pcie_ep_unmap_addr(), but I might be missing something. Also, even if I
> > serialize dw_pcie_ep_raise_msi_irq() invocations, the problem still
> > appears.
> >
> > A couple of details I forgot to describe in the commit message:
> > (1). The IOMMU error is only reported on the RC side.
> > (2). Sometimes there is no IOMMU error printed and the board just freezes (becomes unresponsive).
> >
> > The faulting iova is 0xfe000000. The iova 0xfe000000 is the base of
> > "addr_space" for R-Car S4 in EP mode:
> > https://github.com/jonmason/ntb/blob/68113d260674/arch/arm64/boot/dts/renesas/r8a779f0.dtsi#L847
> >
> > So it looks like the EP sometimes issue MWr at "addr_space" base (offset 0),
> > the RC forwards it to its IOMMU (IPMMUHC) and that faults. My working theory
> > is that when the iATU registers are updated under heavy DMA load, the DAR of
> > some in-flight transfer can get corrupted to 0xfe000000. That would match one
> > possible symptom of the undefined behaviour that the DW EPC spec warns about
> > when changing iATU configuration under load.
>
> For your information, in the NVMe PCI EPF driver:
> https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L389-L429
>
> We take a mutex around the dmaengine_slave_config() and dma_sync_wait() calls,
> because without a mutex, we noticed that having multiple outstanding transfers,
> since the dmaengine_slave_config() specifies the src/dst address, the function
> call would affect other concurrent DMA transfers, leading to corruption because
> of invalid src/dst addresses.
>
> Having a mutex so that we can only have one outstanding transfer solves these
> issues, but is obviously very bad for performance.
>
>
> I did try to add DMA_MEMCPY support to the dw-edma driver:
> https://lore.kernel.org/linux-pci/20241217160448.199310-4-cassel@kernel.org/
>
> Since that would allow us to specify both the src and dst address in a single
> dmaengine function call (so that we would no longer need a mutex).
> However, because the eDMA hardware (at least for EDMA_LEGACY_UNROLL) does not
> support transfers between PCI to PCI, only PCI to local DDR or local DDR to
> PCI, using prep_memcpy() is wrong, as it does not take a direction:
> https://lore.kernel.org/linux-pci/Z4jf2s5SaUu3wdJi@ryzen/
>
> If we want to improve the dw-edma driver, so that an EPF driver can have
> multiple outstanding transfers, I think the best way forward would be to create
> a new _prep_slave_memcpy() or similar, that does take a direction, and thus
> does not require dmaengine_slave_config() to be called before every
> _prep_slave_memcpy() call.

Thanks, we also consider put slave config informaiton into prep_sg(single).
dmaengine_prep_slave_sg(single)_config(..., struct dma_slave_config *config)
to simple error handle at dma transfer functions.

dmaengine_prep_slave_single_config(
	struct dma_chan *chan, size_t size,
	unsigned long flags, dma_slave_config *config)

config already include src and dsc address.

Frank

>
>
> Kind regards,
> Niklas

