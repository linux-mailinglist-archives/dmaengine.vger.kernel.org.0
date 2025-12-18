Return-Path: <dmaengine+bounces-7795-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A89CCA448
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 05:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81F743010998
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 04:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BF920C00A;
	Thu, 18 Dec 2025 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AiMNzYaW"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011028.outbound.protection.outlook.com [40.107.74.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645F51DFF0;
	Thu, 18 Dec 2025 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766033450; cv=fail; b=FC9MfmYWOg82Pl5dU/6LJfSAYwbqQOsteUKQ4Tou603IK2ZqW9JH/qckw7gQZCqI85UiIl9GPcemTMrCXMFGRVOgcHivNELqDw9nnTC+27ErKpSLvw7oyRX4tlwi8Lgi1Rn9FH/1UyU98VYwtVqyBrPLTSY83F7gp30unwgwvqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766033450; c=relaxed/simple;
	bh=/SGOhKmx/cu1MSfQaVGU5jWWi1f7Vph4t6zyHEO0k48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i7nJF65z+9ZHdxAdm+82L2Uzopqv1hMSjV1gVepTVmcAaGxdh+2e/ANZOwdrMcarLpc3G7+DMd7a/QkTntBVPjDC5DUcQWxW75+oREXtp6LYpIZ5zEffr+izMkpwHNRdQ6ozPWr8rNpe5kKI55UN/aZbScCWNq0AYObvVUGuAR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AiMNzYaW; arc=fail smtp.client-ip=40.107.74.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmcx5py7uZDZ3xNa+IQ+rQBqzzSx+LhdS7YHRVvNzFaaW9DAsitHDaFi0sCYe78k3FL0UHB7TCoz0KOE5f51Cf/RsDmWu62CcoU3kLBcFIZaPbeLWDPmAomGvuoHWase8ZsVcI65e05c1U6mIHno1IgIlDO9O4MCtGX5SV+PWgVwf+wX8ucFSizQ8SbyK0o13FGFTNIUNc9anPE0e5gQ66DUpwKNjMqZd3arR1mH4jxzUHDPilhkrpFD/sBe8GI/mSVlap7mXD4mC1ao6oBO0Qusrqar63iUP5yu+UrCEDIcfOR9gu4Y0ASd209d3rTZFtKE6cqBPpMEGXaf5UBcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzb1WHwp+s6dMMqaoiPlCo+T3ia+emKNLNrvOYa9kDU=;
 b=o7DGWzZGw+2PAQZtHumvDqkUenLGtmk6UwEXFj6pK+B2HgdThxHwt006ZTD4NjRW65QfekXScvp3BRxAk98YGAjmBLEohFJe6CbfxykFySrRguAhlFpl4w+g4B+JBKBOuNl2sG70l0RRYED6w99Xzn6wdZc58UpceFM0eDzcYo1kLUlw0PyojXC4PPI8nazx7c/7ZILmfr0SHorT+TlvRqackSUVGkOfOy+j8M8uIY2TwNwhL4TyYzt2O0CVIe/bcN8Mv4R7RkqoHYHiWk6gGdVx1s6hUain2rnca5ipRxvj4sSrzqehbNllJhaIgPefCHjuGMDY+vj/DQmMVPV3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzb1WHwp+s6dMMqaoiPlCo+T3ia+emKNLNrvOYa9kDU=;
 b=AiMNzYaWyKS330qbNbr9VWyBdJD+BQ7oUCVDbrCYXiIyAMpcDVgi6olez+Y79NUgpIa0vIvz6yAsZYRvaPvhZhmEW1ogQL1uFQYxj50ELjx6tvAj4oNjpW9L4bGnh4AztNL4UDCiEZVKjDOtTCcP9nmNyxZMDgFw4nlr1y5/84U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 04:34:54 +0000
Received: from TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b17b:8311:62f:5639]) by TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b17b:8311:62f:5639%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 04:34:52 +0000
Date: Thu, 18 Dec 2025 13:34:50 +0900
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
Subject: Re: [RFC PATCH v2 20/27] NTB: ntb_transport: Introduce remote eDMA
 backed transport mode
Message-ID: <5vfz64ngk2nmzmc6azbmaymhl5lkpac7wo5ay42pcnjk5io6rx@jye4prt5ners>
References: <20251129160405.2568284-21-den@valinux.co.jp>
 <aS4Lcb+BjjCDeJRz@lizhi-Precision-Tower-5810>
 <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
 <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
 <27mhsc7pksxyv62ro2m4u4xblednmlgsvzm6e2gx4iqt2plrl2@ewtuiycdq3vj>
 <aTBh86H5m6PpIxMk@lizhi-Precision-Tower-5810>
 <47ns4b4oskh5yukig7sr4okhw6gvqf4q5yin2ibrpue5zrcplp@ybozsroia2fk>
 <aTHsGerE5phzLrgk@lizhi-Precision-Tower-5810>
 <nbjr7ovjgvrvcr7sntrgcjyui5tukp6utd5bvqc3hsdopsl3vi@or4vjl3owblf>
 <aTL09kE6y9A0gLSn@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTL09kE6y9A0gLSn@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::19) To TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:257::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2708:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4c4e63-1ca4-4c46-a3d6-08de3deec955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?yNqxyhJkiFNBD3sD59bakWVnn4+Ba1TSTnkzDopIl20WthshgrWPp30hMgMA?=
 =?us-ascii?Q?c60JOucS0ld4S0579ZJnK3Pz4m16zXtzOoxRINR2cZTId8z4Lukxgw0/BWYn?=
 =?us-ascii?Q?vs9ajugvnkbTCXzC+5zsduSdrhd3QSqdoHI9fY86FaqfNLtwoM+jTBndosKd?=
 =?us-ascii?Q?H7qTmWAI6KujElarHUgLWFIntSI1pmjfssa0mqp3pa3DMZFsXoefRK4msac7?=
 =?us-ascii?Q?Sfqhslx+i2wU0Y1IjaEr9aPRQsjqhiqwEh3U1kruSqGyzVlbsj/VvOCYPXcu?=
 =?us-ascii?Q?IXo9RYIx1GLpl7P1WZKbA/r13UsNxMaBqZsKkSyk3oinT9Wm+YgxJyyyCT1B?=
 =?us-ascii?Q?NiYbDK9TcrLiHCQRF0nAEFu8dnAiiiwqhgplII1KxOaK94NjGgVdrsQjXUID?=
 =?us-ascii?Q?qWr2srTBj8iFdbIrhEDqT+BL/Jeq9yhiP9kCxTUQyX4LhRhSNuEDN9QcEpwv?=
 =?us-ascii?Q?RL3sJxFwC0ttabGVyJRa0ZRsSlESLI9yfDS2bxmLePOUMWwJnTOFhGtBJCge?=
 =?us-ascii?Q?6KXb3HaoRoWqvTTKZfrieAoTLKLRgM/ByDvdCXc5BB/ktcaT6ALfaOk06A5v?=
 =?us-ascii?Q?o/7ZED1A5l7dIr1KNvpOf4rHtz1vv7wCzIwpTka0tuq4xtsobI+IdPoxV0DW?=
 =?us-ascii?Q?6P70qBe5r2QYx1seKnTB+c+QeYMY//TPSvUzAYy6XVquQbMcO7ojxK7mDQoa?=
 =?us-ascii?Q?rcoihFdmhoRyLGnvl97/hEr7JQUHdoFuLLz7FzWGaw3OuYlNGM3w+8wz6buT?=
 =?us-ascii?Q?TjaDmn5jpSapSYAS1pWfv98OUJJZpNZZ6hK5YG/Hu88nFZ8vvsypnt4oftbX?=
 =?us-ascii?Q?SuZigHBXWeeucLCrwlsso3bxJWkE8vYdzjv6jx37KmTE/e+OX1qbMr/wDXoe?=
 =?us-ascii?Q?12zmARUmiLvcf9YTusL7GvQLLR02hRCC16kEsscGamkgII95LI4agGfBqJbJ?=
 =?us-ascii?Q?ulnWP1k68+2KZkrw8RMc3y/eFjhaNsDvpz4YSiQ6m4XWD3DHLGQ0Bvzn8iQA?=
 =?us-ascii?Q?aZmXRaNq3JeUoTLFlLVOTpcdWm4hDHwuGCQyyMzwRbOAzLsUPK3GWWZxMwXE?=
 =?us-ascii?Q?Fd7O2XW0Vx5fQMxMDy86vdAKXYlc2O4qH05QV3Wmz6LtrHZ60YjZl1cK7NEy?=
 =?us-ascii?Q?kwA3s6y0v/xiovxtW3jsjEUgPxUBL38mqy0qhoKdcxhn/RYy1VbyL9MsALz4?=
 =?us-ascii?Q?WcOPTkYQRgicOW0aKqTPU2sy3zkzA3xkyPeNLMCXjZ+0LkcWKgmn4RN9tlsD?=
 =?us-ascii?Q?tVkkGTYVn9AwoIrvYuXE8ZJQCT01HYgPSNF6aNLeVXReKN7ae+35blMrTwXO?=
 =?us-ascii?Q?BeMexg3HH0NXa37SdAc+UOaT6evAzDfAhqv23zjLMAxwrbeJcP8zr2MuOqe2?=
 =?us-ascii?Q?IC8PrYcsX34t3vxuuHI3+Mf221gMSCSV1gQE5krgbIOkuf44fK5u6ERbgIpB?=
 =?us-ascii?Q?6KDD10SD6XbyYB2UtRXGqYMwZOBYt6hV?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?pw8PlaF8zYFp8qqhtpNgyKLu9VRZ+AFqkuBHjdggderCD/uwJ8QKo3q1FTfB?=
 =?us-ascii?Q?UiVrIT0pZjucxYa1wd5hBAEOdR+j/AIry/3TR1r/vRdhhEPqaEnwbi1bdtoS?=
 =?us-ascii?Q?qooA9UnmJ2FX4Isbc4QIaSL40bFIbNheeGSq7WQL86cggH0W6+T6qyHEd9ND?=
 =?us-ascii?Q?weWCYyHvOwWbUtMbmiaxgfbH8e00kuq/Pi9udUiQn5PHPhkPe+Mkgq5lDF3q?=
 =?us-ascii?Q?dsfG4/ampuMnsc2ZpxMNhET9w6LbWJugp/MLz61ItoGKu0Rsufo+0IU3H/kh?=
 =?us-ascii?Q?03QP2oYC+LI1s6huR01UpcdqugP0kKn4ZTAOQAemOWJ1mCzYTXubkWs/ELzS?=
 =?us-ascii?Q?GTqrjx737OwHyIRh1+dAjzVdSph+DggFI0AA1f66y6N3Oaszh/JOpw0480hN?=
 =?us-ascii?Q?CrXQMGYkKvnZ7Nf8CqqkTgA+2qYycOSAmWvPEw1Hy9oJn9sNuJ0GluVERXUL?=
 =?us-ascii?Q?dKV7CJuTyyFEPqCIft41TxK44psoaBBVVQJ2O1Cq8ldSjSufI8O/TsKja5yJ?=
 =?us-ascii?Q?FoFMIJ7hApOYahJkJ3ZdThkqIMmcqKqzvjzDMsVAc+e7ZQ5J03pqY+p5v256?=
 =?us-ascii?Q?FFSibnvsW3MyCyyT0MM4K6YxM3efelTp/Xwd6ICEOvs84WowPIutn2FFNbU5?=
 =?us-ascii?Q?ynOEqpcvmE3SL8NF0pu04PJ611Tr9qIAFbyMILJ/yQIr07/YU2zdyYyteUa1?=
 =?us-ascii?Q?PJvXxbuptNsoPfxA2NTktfZzT9IMlCq2sf0+pcg+yWmjvvgAl/GjSh7tkzEj?=
 =?us-ascii?Q?DrzJpgs34B/5LkAkZ76a8tWclniHNXkM/9Wa0cbcLlKJC021+zTVHDRE9MUX?=
 =?us-ascii?Q?6j8GMyssL1zmJ05jLaczuLAjkgxR1AaMtWfVOeLUOnoQwPwwxYsV8NBqMxKr?=
 =?us-ascii?Q?re6Z3gMd/LyzHUXPdKGgg4/RpWAHvEMncDUbg3qDegc8vplBU4x1sVgjUGON?=
 =?us-ascii?Q?bztrModyUm0y5qooA/9nBAqSj5LRQnuC+j+RVi+wW3LONNWvWwAPZxtCRpbP?=
 =?us-ascii?Q?C+UTdolkmbYd1y9Sxg7Bcgj4iRsCt3kjsKppEgokxpCNpR6VuL6/RlLgIhp9?=
 =?us-ascii?Q?KsnObYT61bzqmaMeXvSULUjam85C6jSjmYDPmW5fl0Tay6X4HD3k+XMwfNcD?=
 =?us-ascii?Q?JdWEXDpu/4gdFJ4D9RtMSNLHJaStde5GnPYeGuEGL767yP+W9Zp16a4g0qbU?=
 =?us-ascii?Q?mwjMVZ4WbRdUegGetkKoAY6v5hEqEnqsxqPzumd/GWUe6UYTMOwYD7P8WqA5?=
 =?us-ascii?Q?xNLOZMZ7/HXZ85pyv6YxrUqytRxCIbgL9HUoQvsThJ8xSpHjCLyGd8Tee2dl?=
 =?us-ascii?Q?nmN88BxCsM11YMYOLrVlUyBuQUANJGg2m5XctOhjIhjW4szSsx2zGNajKull?=
 =?us-ascii?Q?moR2WGz9EGUOoNiizJXSthwLS7h4Z/EkOBgz7UoQ684gHGB9SluUxtdwOOzP?=
 =?us-ascii?Q?HD2LG6wCDCWNjK/9EES1UzD/suymdhG2Iq5NNEn0myqrtGOg9ft9wukvLeuD?=
 =?us-ascii?Q?rbFgKBPy2UjX706jVK1X59G13tVHAawMz9ZcZNxWDqzuhzJrq0T8H058w+Ks?=
 =?us-ascii?Q?97quUYfvJctOIqmk3gxYdOQMgOpXOxe0rpZ3htZqyV5Bkg6iHbtj4m9lWF6w?=
 =?us-ascii?Q?Seh/4DYBWR0NNO7S4T/3lrA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4c4e63-1ca4-4c46-a3d6-08de3deec955
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 04:34:52.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++F26e4ino6hlHYNQWW3NtQq2YrtDAlA/63M6EMMn4yoaqgS7+Mu8SZceZapZh8j1lL0CgqAYt0bGzM3bIJ4Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673

On Fri, Dec 05, 2025 at 10:06:30AM -0500, Frank Li wrote:
> On Fri, Dec 05, 2025 at 12:04:24PM +0900, Koichiro Den wrote:
> > On Thu, Dec 04, 2025 at 03:16:25PM -0500, Frank Li wrote:
> > > On Fri, Dec 05, 2025 at 12:42:03AM +0900, Koichiro Den wrote:
> > > > On Wed, Dec 03, 2025 at 11:14:43AM -0500, Frank Li wrote:
> > > > > On Wed, Dec 03, 2025 at 05:53:03PM +0900, Koichiro Den wrote:
> > > > > > On Tue, Dec 02, 2025 at 10:42:29AM -0500, Frank Li wrote:
> > > > > > > On Tue, Dec 02, 2025 at 03:43:10PM +0900, Koichiro Den wrote:
> > > > > > > > On Mon, Dec 01, 2025 at 04:41:05PM -0500, Frank Li wrote:
> > > > > > > > > On Sun, Nov 30, 2025 at 01:03:58AM +0900, Koichiro Den wrote:
> > > > > > > > > > Add a new transport backend that uses a remote DesignWare eDMA engine
> > > > > > > > > > located on the NTB endpoint to move data between host and endpoint.
> > > > > > > > > >
> > > > > > > ...
> > > > > > > > > > +#include "ntb_edma.h"
> > > > > > > > > > +
> > > > > > > > > > +/*
> > > > > > > > > > + * The interrupt register offsets below are taken from the DesignWare
> > > > > > > > > > + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> > > > > > > > > > + * backend currently only supports this layout.
> > > > > > > > > > + */
> > > > > > > > > > +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> > > > > > > > > > +#define DMA_WRITE_INT_MASK_OFF     0x54
> > > > > > > > > > +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> > > > > > > > > > +#define DMA_READ_INT_STATUS_OFF    0xa0
> > > > > > > > > > +#define DMA_READ_INT_MASK_OFF      0xa8
> > > > > > > > > > +#define DMA_READ_INT_CLEAR_OFF     0xac
> > > > > > > > >
> > > > > > > > > Not sure why need access EDMA register because EMDA driver already export
> > > > > > > > > as dmaengine driver.
> > > > > > > >
> > > > > > > > These are intended for EP use. In my current design I intentionally don't
> > > > > > > > use the standard dw-edma dmaengine driver on the EP side.
> > > > > > >
> > > > > > > why not?
> > > > > >
> > > > > > Conceptually I agree that using the standard dw-edma driver on both sides
> > > > > > would be attractive for future extensibility and maintainability. However,
> > > > > > there are a couple of concerns for me, some of which might be alleviated by
> > > > > > your suggestion below, and some which are more generic safety concerns that
> > > > > > I tried to outline in my replies to your other comments.
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > +
> > > > > > > > > > +#define NTB_EDMA_NOTIFY_MAX_QP		64
> > > > > > > > > > +
> > > > > > > ...
> > > > > > > > > > +
> > > > > > > > > > +	virq = irq_create_fwspec_mapping(&fwspec);
> > > > > > > > > > +	of_node_put(parent);
> > > > > > > > > > +	return (virq > 0) ? virq : -EINVAL;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static irqreturn_t ntb_edma_isr(int irq, void *data)
> > > > > > > > > > +{
> > > > > > > > >
> > > > > > > > > Not sue why dw_edma_interrupt_write/read() does work for your case. Suppose
> > > > > > > > > just register callback for dmeengine.
> > > > > > > >
> > > > > > > > If we ran dw_edma_probe() on both the EP and RC sides and let the dmaengine
> > > > > > > > callbacks handle int_status/int_clear, I think we could hit races. One side
> > > > > > > > might clear a status bit before the other side has a chance to see it and
> > > > > > > > invoke its callback. Please correct me if I'm missing something here.
> > > > > > >
> > > > > > > You should use difference channel?
> > > > > >
> > > > > > Do you mean something like this:
> > > > > > - on EP side, dw_edma_probe() only set up a dedicated channel for notification,
> > > > > > - on RC side, do not set up that particular channel via dw_edma_channel_setup(),
> > > > > >   but do other remaining channels for DMA transfers.
> > > > >
> > > > > Yes, it may be simple overall. Of course this will waste a channel.
> > > >
> > > > So, on the EP side I see two possible approaches:
> > > >
> > > > (a) Hide "dma" [1] as in [RFC PATCH v2 26/27] and call dw_edma_probe() with
> > > >     hand-crafted settings (chip->ll_rd_cnt = 1, chip->ll_wr_cnt = 0).
> > > > (b) Or, teach this special-purpose policy (i.e. configuring only a single
> > > >     notification channel) to the SoC glue driver's dw_pcie_ep_init_registers(),
> > > >     for example via Kconfig. I don't think DT is a good place to describe
> > > >     such a policy.
> > > >
> > > > There is also another option, which do not necessarily run dw_edma_probe()
> > > > by ourselves:
> > > >
> > > > (c) Leave the default initialization by the SoC glue as-is, and override the
> > > >     per-channel role via some new dw-edma interface, with the guarantee
> > > >     that all channels except the notification channel remain unused on its
> > > >     side afterwards. In this model, the EP side builds the LL locations
> > > >     for data transfers and the RC configures all channels, but it sets up
> > > >     the notification channel in a special manner.
> > > >
> > > > [1] https://github.com/jonmason/ntb/blob/68113d260674/Documentation/devicetree/bindings/pci/snps%2Cdw-pcie-ep.yaml#L83
> > > >
> > > > >
> > > > > >
> > > > > > Also, is it generically safe to have dw_edma_probe() executed from both ends on
> > > > > > the same eDMA instance, as long as the channels are carefully partitioned
> > > > > > between them?
> > > > >
> > > > > Channel register MMIO space is sperated. Some channel register shared
> > > > > into one 32bit register.
> > > > >
> > > > > But the critical one, interrupt status is w1c. So only write BIT(channel)
> > > > > is safe.
> > > > >
> > > > > Need careful handle irq enable/disable.
> > > >
> > > > Yeah, I agree it is unavoidable in this model.
> > > >
> > > > >
> > > > > Or you can defer all actual DMA transfer to EP side, you can append
> > > > > MSI write at last item of link to notify RC side about DMA done. (actually
> > > > > RIE should do the same thing)
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > To avoid that, in my current implementation, the RC side handles the
> > > > > > > > status/int_clear registers in the usual way, and the EP side only tries to
> > > > > > > > suppress needless edma_int as much as possible.
> > > > > > > >
> > > > > > > > That said, I'm now wondering if it would be better to set LIE=0/RIE=1 for
> > > > > > > > the DMA transfer channels and LIE=1/RIE=0 for the notification channel.
> > > > > > > > That would require some changes on dw-edma core.
> > > > > > >
> > > > > > > If dw-edma work as remote DMA, which should enable RIE. like
> > > > > > > dw-edma-pcie.c, but not one actually use it recently.
> > > > > > >
> > > > > > > Use EDMA as doorbell should be new case and I think it is quite useful.
> > > > > > >
> > > > > > > > >
> > > > > > > > > > +	struct ntb_edma_interrupt *v = data;
> > > > > > > > > > +	u32 mask = BIT(EDMA_RD_CH_NUM);
> > > > > > > > > > +	u32 i, val;
> > > > > > > > > > +
> > > > > > > ...
> > > > > > > > > > +	ret = dw_edma_probe(chip);
> > > > > > > > >
> > > > > > > > > I think dw_edma_probe() should be in ntb_hw_epf.c, which provide DMA
> > > > > > > > > dma engine support.
> > > > > > > > >
> > > > > > > > > EP side, suppose default dwc controller driver already setup edma engine,
> > > > > > > > > so use correct filter function, you should get dma chan.
> > > > > > > >
> > > > > > > > I intentionally hid edma for EP side in .dts patch in [RFC PATCH v2 26/27]
> > > > > > > > so that RC side only manages eDMA remotely and avoids the potential race
> > > > > > > > condition I mentioned above.
> > > > > > >
> > > > > > > Improve eDMA core to suppport some dma channel work at local, some for
> > > > > > > remote.
> > > > > >
> > > > > > Right, Firstly I experimented a bit more with different LIE/RIE settings and
> > > > > > ended up with the following observations:
> > > > > >
> > > > > > * LIE=0/RIE=1 does not seem to work at the hardware level. When I tried this for
> > > > > >   DMA transfer channels, the RC side never received any interrupt. The databook
> > > > > >   (5.40a, 8.2.2 "Interrupts and Error Handling") has a hint that says
> > > > > >   "If you want a remote interrupt and not a local interrupt then: Set LIE and
> > > > > >   RIE [...]", so I think this behaviour is expected.
> > > > >
> > > > > Actually, you can append MSI write at last one of DMA descriptor link. So
> > > > > it will not depend on eDMA's IRQ at all.
> > > >
> > > > For RC->EP interrupts on R-Car S4 in EP mode, using ITS_TRANSLATER as the
> > > > IB iATU target did not appear to work in practice. Indeed that was the
> > > > motivation for the RFC v1 series [2]. I have not tried using ITS_TRANSLATER
> > > > as the eDMA read transfer DAR.
> > > >
> > > > But in any case, simply masking the local interrupt is sufficient here. I
> > > > mainly wanted to point out that my naive idea of LIE=0/RIE=1 is not
> > > > implementable with this hardware. This whole LIE/RIE topic is a bit
> > > > off-track, sorry for the noise.
> > > >
> > > > [2] For the record, RFC v2 is conceptually orthogonal and introduces a
> > > >     broader concept ie. remote eDMA model, but I reused many of the
> > > >     preparatory commits from v1, which is why this is RFC v2 rather than a
> > > >     separate series.
> > > >
> > > > >
> > > > > > * LIE=1/RIE=0 does work at the hardware level, but is problematic for my current
> > > > > >   design, where the RC issues the DMA transfer for the notification via
> > > > > >   ntb_edma_notify_peer(). With RIE=0, the RC never calls
> > > > > >   dw_edma_core_handle_int() for that channel, which means that internal state
> > > > > >   such as dw_edma_chan.status is never managed correctly.
> > > > >
> > > > > If you append on MSI write at DMA link, you needn't check status register,
> > > > > just check current LL pos to know which descrptor already done.
> > > > >
> > > > > Or you also enable LIE and disable related IRQ line(without register
> > > > > irq handler), so Local IRQ will be ignore by GIC, you can safe handle at
> > > > > RC side.
> > > >
> > > > What I was worried about here is that, with RIE=0 the current dw-edma
> > > > handling of struct dw_edma_chan::status field (not status register) would
> > > > not run for that channel, which could affect subsequent tx submissions. But
> > > > your suggestion also makes sense, thank you.
> > > >
> > > > --8<--
> > > >
> > > > So anyway the key point seems that we should avoid such hard-coded register
> > > > handling in [RFC PATCH v2 20/27] and rely only on the standard dw-edma
> > > > interfaces (possibly with some extensions to the dw-edma core). From your
> > > > feedback, I feel this is the essential direction.
> > > >
> > > > From that perspective, I'm leaning toward (b) (which I wrote above in a
> > > > reply comment) with a Kconfig guard, i.e. in dw_pcie_ep_init_registers(),
> > > > if IS_ENABLED(CONFIG_DW_REMOTE_EDMA) we only configure the notification
> > > > channel. In practice, a DT-based variant of (b) (for example a new property
> > > > such as "dma-notification-channel = <N>;" and making
> > > > dw_pcie_ep_init_registers() honour it) would be very handy for users, but I
> > > > suspect putting this kind of policy into DT is not acceptable.
> > > >
> > > > Assuming careful handling, (c) might actually be the simplest approach. I
> > > > may need to add a small hook for the notification channel in
> > > > dw_edma_done_interrupt(), via a new API such as
> > > > dw_edma_chan_register_notify().
> > >
> > > I reply everything here for overall design
> > >
> > > EDMA actually can access all memory at both EP and RC side regardless PCI
> > > map windows. NTB defination is that only access part of both system memory,
> > > so anyway need once memcpy. Although NTB can't take 100% eDMA advantage, it
> > > is still easiest path now. I have a draft idea without touch NTB core code
> > > (most likley).
> > >
> > > EP side                          RC side
> > >              1:  Control bar
> > >              2:  Doorbell bar
> > >              3:  WM1
> > >
> > > MW1 is fixed sized array [ntb_payload_header + data]. Current NTB built
> > > queue in system memory, transfer data (RW) to this array.
> > >
> > > Use EDMA only one side, RC/EP. use EP as example.
> > >
> > > In 1 (control bar, resever memory space, which call B)
> > >
> > > In ntb_hw_epf.c driver, create a simple 'fake' DMA memcpy driver, which
> > > just implement device_prep_dma_memcpy(). That just put src\dest\size info
> > > to memory space B, then push doorbell.
> > >
> > > in EP side's a workqueue, fetch info from B, the send to EDMA queue to
> > > do actual transfer, after EP DMA finish, mark done at B, then raise msi irq,
> > > 'fake' DMA memcpy driver will be triggered.
> > >
> > > Futher, 3 WM1 is not necessary existed at all, because both side don't
> > > access it directly.
> > >
> > > For example:
> > >
> > > case RC TX, EP RX
> > >
> > > RC ntb_async_tx_submit() use device_prep_dma_memcpy() copy user space
> > > memory (0xRC_1000 to PCI_1000, size 0x1000), put into share bar0 position
> > >
> > >             0xRC_1000 -> 0xPCI_1000 0x1000
> > >
> > > EP side, there RX request ntb_async_rx_submit(),  from 0xPCI_1000 to
> > > 0xEP_8000 size 0x20000.
> > >
> > > so setup eDMA transfer form 0xRC_1000 -> 0xEP_8000 size 1000. After complete
> > > mark both side done, then trigger related callback functions.
> > >
> > > You can see 0xPCI_1000 is not used at all. Actually 0xPCI_1000 is trouble
> > > maker,  RC and EP system PCI space is not necesary the same as CPU space,
> > > PCI controller may do address convert.
> >
> > Thanks for the detailed explanation.
> >
> > Just to clarify, regarding your comments about the number of memcpy
> > operations and not using the 0xPCI_1000 window for data path, I think RFC
> > v2 is already similar to what you're describing.
> >
> > To me it seems the key differences in your proposal are mainly two-fold:
> > (1) the layering, and (2) local eDMA use rather than remote.
> 
> Not big difference between remote and local DMA. My major means just use
> oneside is enough. If eDMA handle in remote, EP side need virtual memcpy
> and RC side to handle actual transfer.
> 
> I use EP as example, just because some logic R/W is reverted between EP/RC.
> RC's write is EP's read.
> 
> >
> > For (1), instead of adding more eDMA-specific handling into ntb_transport
> > layer, your approach would keep changes to ntb_transport minimal and
> > encapsulate the eDMA usage inside the "fake DMA memcpy driver" as much as
> > possible. In that design, would the MW1 layout change? Leaving the existing
> > layout as-is would waste the space (so RFC v2 had introduced a new layout).
> 
> It is fine if NTB maintainer agree it.
> 
> >
> > Also, one point I'm still unsure about is the opposite direction (ie.
> > EP->RC). In that case, do you also expect the EP to trigger its local eDMA
> > engine? If yes, then, similar to the RC->EP direction in RFC v2, the EP
> > would need to know the RC-side receive buffer address (e.g. 0xRC_1000) in
> > advance.
> 
> 'fake DMA memcpy driver' already put 0xRC_1000 to one shared memory place.
> 
> >
> > You also mentioned that you already have some draft. Are you planning to
> > post that as a patch series? If not, I can of course try to
> > implement/prototype this approach based on your suggestion.
> 
> Sorry, I have not actually worked for ntb eDMA before. My work base on RDMA
> framework. Idealy, RDMA can do user-space(EP) to user space (RC) data
> transfer with zero copy.
> 
> But I think NTB is also a good path since RDMA is over complexed.
> 
> Frank

Hi Frank,

Thank you for the review and the discussion. Apologies for the delayed
response here in this thread, I needed some time to think through the
re-design.

After further consideration, I sent RFC v3 [1] with the following design:
* all the read channels (including a channel for notification) are driven
  by host (RC)
* all the write channels are driven by endpoint (EP)

This way we can avoid both ends touching and updating per-direction
registers concurrently at runtime [2]. Also the data plane behaviour
becomes symmetric in both directions, resulting in a simpler data path in
the NTB transport layer compared to RFC v2. As you commented earlier, RFC
v3 no longer relies on the duplicate hard-coded register offsets, and leave
dma_device/dma_chan initialization to the standard path. RFC v3 no longer
hides eDMA instance on enpoint side, like I did in [RFC PATCH v2 26/28]
[3].

But still I didn't implement the fake DMA memcpy driver idea in RFC v3.
Instead, I chose MW1 layout optimized for eDMA-backed transport, since it
reduces MW1 usage and makes it possible to scale to multiple queue pairs
with deeper ring buffers, which helps fully exploit the potential of the
eDMA-backed transport.

[1] https://lore.kernel.org/all/20251217151609.3162665-1-den@valinux.co.jp/
[2] as a somewhat relevant topic, I've found an existing issue that becomes
    observable under heavy load across multiple channels.
    https://lore.kernel.org/all/20251217151609.3162665-23-den@valinux.co.jp/
[3] https://lore.kernel.org/all/20251129160405.2568284-27-den@valinux.co.jp/

Thank you again for your time and for the review,

Koichiro

> 
> >
> > Please let me know if the above understanding does not match what you had
> > in mind.
> >
> > Thank you,
> > Koichiro
> >
> >
> > >
> > > Frank
> > > >
> > > > Thank you for your time and review,
> > > > Koichiro
> > > >
> > > > >
> > > > > Frank
> > > > > >
> > > > > > >
> > > > > > > Frank
> > > > > > > >
> > > > > > > > Thanks for reviewing,
> > > > > > > > Koichiro
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Frank
> > > > > > > > >
> > > > > > > > > > +	if (ret) {
> > > > > > > > > > +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> > > > > > > > > > +		return ret;
> > > > > > > > > > +	}
> > > > > > > > > > +
> > > > > > > > > > +	return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > ...
> > > > > > >
> > > > > > > > > > +{
> > > > > > > > > > +	spin_lock_init(&qp->ep_tx_lock);
> > > > > > > > > > +	spin_lock_init(&qp->ep_rx_lock);
> > > > > > > > > > +	spin_lock_init(&qp->rc_lock);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static const struct ntb_transport_backend_ops edma_backend_ops = {
> > > > > > > > > > +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> > > > > > > > > > +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> > > > > > > > > > +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> > > > > > > > > > +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> > > > > > > > > > +	.rx_poll = ntb_transport_edma_rx_poll,
> > > > > > > > > > +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> > > > > > > > > > +};
> > > > > > > > > > +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> > > > > > > > > > +
> > > > > > > > > >  /**
> > > > > > > > > >   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> > > > > > > > > >   * @qp: NTB transport layer queue to be enabled
> > > > > > > > > > --
> > > > > > > > > > 2.48.1
> > > > > > > > > >

