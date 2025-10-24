Return-Path: <dmaengine+bounces-6976-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC0C043EF
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 05:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8709A19A1AAB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 03:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43926E158;
	Fri, 24 Oct 2025 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FxfWEOVX"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50516248F48;
	Fri, 24 Oct 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276447; cv=fail; b=Xlqc4qIEJ8Ji8J7omQXhdwtGY04Oo3RxGBIN2BtfsEIis0tPsF8qem6b1q5beSBVeN4NnS6o/i7i3yaxRKh7tFR3lHhIcz2Veqq2oyiaNj+5roSCeXC+AHPnQ2WOarUbDGtkIa2KGnlFyDWOYLEYkRezLj43wGsaSMPQUCJ/qyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276447; c=relaxed/simple;
	bh=yGeTPyZeH1XO4ti2HBChjgJCEDagu5lZlCsHR1FO2pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JPlr/kaJ6kIrzh+AWjVHVUFvidaw5rX+rnoR5yZcAhcDwM1lwv+dZbm+H53EmVb/UFjoyHs98GoQvEwwhUzgv2knLYSCPBJQDtiiFBfiUEyL6sDFZTxsuYBI8+wsSbC52KX2v9IeTB4vjtACYATMYl1z25uitskHZk/U/LHMl20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FxfWEOVX; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+2nE4lFOw3hzqOxnNgro+0sL8jKBP/QSNj4DG4TxP7jJJd8hW1LrWBWxgX+b8a/sre2iMKvfwuTLbBkpKadjdYSsGDn2Na7xdsGc/xCJ7+iZm60/vhJ8u8nPLWUF1e69wFkkyB8XdNhv1psJSsBudCiO/PFTFTYWh2w4iDOoksJ9d/r5V0WxpbKE2TqMvLUIQZgqAN5T82p88S8C7jagX5tcn58Hm/KRleEG6j3sw1vgGN/u7BZPq48oK1JGu1lfAn2f122RrazOE5HM6Qm5lQofqpEnpCYtzmBk8pv2ARj4x9IkrLvBvp7I46RwArKOihinl9XJuQiYpHFiwDZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsV1xUzaI3Nu5zXVhO5nmX6y6dDs9b7XFY0Kui4zNnk=;
 b=AJdFWzBkUp7YgI6XPL+hpTB3sTrSpyccD11Wd5fhFNYe90lziX5hCmLdgZZyLl4D0yLypNl+zG8c5tuJvoi1Wd/HXNUi0k3ShE5UkiQMg8Et4nDLglyrMr4WbLHvsY0DQ2CPrLoJa+1Z1ODwYhG4nIfXAJWZY/SnVXo8wP4z96d7xeJtj56skDCv8uLlWH4WI9zwcMIEdMxg8didO69CmOBOh+j734a+HtfPRmFw+qV4HcOg9EywL00jriJJY/xKLOR2ctTAZt3DwzUbakYmn3CIRRqxREvCTcXM8Ka0Mbm4DDim8Vp+UnSrE+ZvIDRPujnFIPuxDSW4WdCYWjBK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsV1xUzaI3Nu5zXVhO5nmX6y6dDs9b7XFY0Kui4zNnk=;
 b=FxfWEOVXQzIfKCaqTQybweH9j/4RVllPnOMKrkoZox4FMn/+U9SMDxk+oQOBzLegw7nzmpWVgF3ascnnp31bSZnUXXdZNnnX8d4/xZ7hEu1hI/aUqY3k7XD1gBNgxWpKrXFEWA36fbt+ZpVy0GI2z2flowrtGA30pBnYOJHYGqgZ8WWdKcUm7XSqNDamReE0Nci8ZfjFk+H927MpHIuzfROrlLUcJLAaTTmzokybuY7rb+EMvlcLMNwULssvajbLkNhFz+IGe5VgutJZ5/MJ96uGvMG1PFUZqVyokoUsRyBVsWBJklb+ojEF0JvrioFpwTNGvDPeNMLEg0zCWBIeUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 03:27:22 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 03:27:21 +0000
Date: Thu, 23 Oct 2025 23:27:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW
 offsets
Message-ID: <aPryDenvU7VTYpBp@lizhi-Precision-Tower-5810>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dcd676-0bd2-4f03-2eaf-08de12ad3dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|19092799006|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vnTw8VwXJebJXVgajvKKyK4qWp14qBGPVzZ4Oerkt8E0jJe980yIJ0Sm0pmw?=
 =?us-ascii?Q?q0Q420oBo7CpkPjmvRrPBPArPlVYUYUNjIThBBTW3eN0m8myre7bUGfJ1N0s?=
 =?us-ascii?Q?tQib3h88mIFf1j7F/6TYJMvcnNoOADDfcPKvWWQl9SdXeSU2ND36uBdZ+9yu?=
 =?us-ascii?Q?KVoxvXHTu/NLdUfQNLuFd0tV4LinXqMXbDAFEY5xDUdfIeQnsXb+hGPnpmTI?=
 =?us-ascii?Q?6KXveWVIBg0+O1KouuP7FNy8Ltt91HJCvheU9IpIa7t7iiLF9jh9HxtLp8OQ?=
 =?us-ascii?Q?BnkBI2L3/QacSBJv9AZkikXuRSN5G3RNAWq+tJy+ucydKlxyROjwDnjpq2is?=
 =?us-ascii?Q?01IOHMTY6/8iEJNwS9f//ix567zWCrATK/iyHnaCXzjkLAbur3SWDVqHwtr2?=
 =?us-ascii?Q?1kqQWnv8bP9FtPDdrL6/e0LgGqN0k++VHhYKMN1KcHgdN49NXdziyuOVZepU?=
 =?us-ascii?Q?9Txx8CoiWcxzMR3ViYVgPts+N51gzul2OwBKHZoLreuPdn22qisF67b6A0Ig?=
 =?us-ascii?Q?JjIPiGToS/OBbi+tw5B20OaGgqq2+ec7FNrfXx/VeAh3hnPW4a7uBLj1xrdg?=
 =?us-ascii?Q?ZAqq++Hji0f9jhCCLKwHKpUoVDuSpmPpi/EOHYicGwubszP9FdzFBW5ohoTS?=
 =?us-ascii?Q?P1g2TS7du2oyZWf5W6IglfLhEpge8xNDeePGknnbyS2/0h9k9oR2C/38+KbJ?=
 =?us-ascii?Q?jzuPzo4Rhn7dHa7feexf4scWk2OBz/s80praHImPpL9eVy1oSCSf7CfOw8ff?=
 =?us-ascii?Q?OHb3T9j4oRoONqgOzqkX3Nlq3tD9AKXK/ohZj8r4nz1tYngq7wWDqibh3jtQ?=
 =?us-ascii?Q?F1HXtnKBxieFLgYg4U7PEa1QSDWUjRuv37dqM2Itd617gNRCfy48mX4ObbbT?=
 =?us-ascii?Q?+ihsPPhb4PpDuSipdlbBdbjRTsMGuHSbftZncyEqeOvrMg77d/eWn/UY2mFT?=
 =?us-ascii?Q?EFqloTjy1MsT8uwNTKjYRQQn36oohufEpMQdH3jwQVfMZ4wxTr0Ud4vJc/+R?=
 =?us-ascii?Q?VSqMTOuMq/UGeGyum9x08z8cpkklcm799JBICFIKOoSaFnEIs73he0UbXaNy?=
 =?us-ascii?Q?2+z9o/qR1WZEd6TvOoHjw0IcQNZ7WwM6DLsvr5xk49342/z3ppuyAP+reO9l?=
 =?us-ascii?Q?UjOGS62EdO67yuOgTaWb2PGDmTVYO47puqJZFVfD4J+pNmdMQQ3Sfa6k8jNA?=
 =?us-ascii?Q?AZJDAFya7WDQeGRCPbPz2ywj1KllIOUU8O62Z9m1gbuq1A+UJeWv+6A8F74C?=
 =?us-ascii?Q?ttF98rMnRed3x8UQ/D24ZY0pcIRqBPs4s2gMLHy2v//qk6Ot8ZhzDH2aFFir?=
 =?us-ascii?Q?CDGQP5nFiDGY/8TdIJRz/yq9/N53x18Y23MI6JRmz4DCFw0l1sCIXGgmMH9T?=
 =?us-ascii?Q?PU5eMZmJpTUCjm/yqDWSpwROaRcSMAYyXDPcG7zrXIpedWjeTZQS7MMlVHDA?=
 =?us-ascii?Q?jTl8p3wXe8T+RkWOw/GAiZO8Zs98urYL/h/sSonwso3GbQ9fgI74CngE4Gzx?=
 =?us-ascii?Q?KGe8vd1JddvJzJQzJ6zw1qwJVCasS/0+i0Vz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(19092799006)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Th2McYJAjuFPiirkRg/01tvCWeJ+KGdgBV5XVXNSKz1EV906E2VTLIlnjjZa?=
 =?us-ascii?Q?fUSvFSk0Xx6y4GVMQ1/iiwEh3V5wgnJSPGS3AkVPszOZ4hfnj0FePaqB4/k8?=
 =?us-ascii?Q?nAYPpmxZFinscsGfiDJsDKjor03zoQw5CxN/nNya7DTbcCtkoe+sHt5ixj7U?=
 =?us-ascii?Q?2DLdklZritmRyhuY+RmyGusTyasaOrYzVRhnxz6ieSjgQ4f7VW41zVrZ1dd1?=
 =?us-ascii?Q?q/+sJ5eIdGDXw1Y2MiSVmZgshH1xyEdtEWaR+Iz4NC1D9g7G8GnixlIvKgZP?=
 =?us-ascii?Q?wfUwORlLY7WEkXWtHgiEvCgoW6ylAtfMMwPk6kIUs3EnD9qpToh3649i68eb?=
 =?us-ascii?Q?LCxSUnBbDYzjf3l6kfoMOthGEk0/OgS3Ez9hBlsUj7bAsBYsiL1YwA4+6aFL?=
 =?us-ascii?Q?G18e62EZcg8jlR25t9vzKyJFdIBcyUWvzBTxizvFGnw99L9LBd3ZNSma/xen?=
 =?us-ascii?Q?82GuBdEPpPYIw3RYrelokfkNQE/j7K5HcV5Z+v76PLTGIH/lqS5HGSGtk6Da?=
 =?us-ascii?Q?lZau78ISmOME33eI8xoeclfiwZM4o4icAxIRoChN0bskqDIBQhm08fctIVOD?=
 =?us-ascii?Q?P01IE+2zSNDa9N6ql99rVXRceAGsyaBJnvf4IIhxb6rUdU8lUcFDfXs9Rudl?=
 =?us-ascii?Q?Zt+3RkgdnD7TbictM8buei/aOPjgoRV/biVVoDrR5iYxdwnd4WTXLKZi1rEO?=
 =?us-ascii?Q?5uk4mXOkL375Pl7mAvqIzB8y/AlFBRaSeJw3M8ESKCFkZG95pmFZYWmwNG06?=
 =?us-ascii?Q?YXPDOPD8fU3IlhExv2O6bWKv51xXIbYPHETnfjDqqxCZqOMhOyw/JpzGNNyd?=
 =?us-ascii?Q?bEP9aqL5FOPSI417Kc+QQ7aWzZL5xyORMmAdtd8oZxVhk8InoBsUFledt0OA?=
 =?us-ascii?Q?Dh7aGdQ0M11i9OMQLF6+AH1yphvdony7I8QtjVjGnIanN2JpWjcnosEWyx1p?=
 =?us-ascii?Q?oMjU+a4iMte3lVshYF7ENww7SdpaJHo2pkp5CV93Jx0S15eYDwtINqjC/2oE?=
 =?us-ascii?Q?HH4N/NfPFh7xEWOAvVWLDQWk5vLjGpgzwb3sHeDJdKRh3Kjf95KqI29lY8+x?=
 =?us-ascii?Q?4cWWhHkAt8Qtg6MGs5AFHsOGd2EmnTyQme/hrj4QSHv8OR0BLhrLntbjSf+6?=
 =?us-ascii?Q?rLcIRBnGTMDFEx3UtZIeTQYkxt87/QZgMFfGxpv1k/C5UjQ8D51KlcYdDeB4?=
 =?us-ascii?Q?NJfjjk01C66FGKuezeAdNtDAiPF3vAHC1nSAkYD2QxxDT7fXb4CPqCIh03gT?=
 =?us-ascii?Q?3X2uKSPOiqnprlInOB8Pd4ZjmbiLLVBjZXAOXqgE3y+CrlYf6Sp1CrNOHxS/?=
 =?us-ascii?Q?p494DgelG64tkb6xxGbUQHpeann2guTqWA4kU92qqBMnhhoodBqvuW+DBcam?=
 =?us-ascii?Q?8tDudC7OhNDW3gZwQCYNFqdpdW7wkvxtQ3WDoZVnNzaKkALkYh0HqvzMKKFX?=
 =?us-ascii?Q?ghDXCnUNgcDts8PAUwpVo1X5U06IUMsPW17qBVcacp2uq0tilMkjjjKaZ1gd?=
 =?us-ascii?Q?/IzAE7Vy97O+sY0hqZTOu4r+qqNDeAiXrPpirlG05iUN0nFITm1G9wSDnATd?=
 =?us-ascii?Q?QXlImOJDuC/VkTGAt54=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dcd676-0bd2-4f03-2eaf-08de12ad3dc6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 03:27:21.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2VNiCGUqMWTktNeFcC0I7oWID6zmLMAwAwXo58nyZ0MDZtBQ2yrZpzSudRLnaiKCE2Vr95fCIRD0CQTnrTD2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

On Thu, Oct 23, 2025 at 04:18:51PM +0900, Koichiro Den wrote:
> Hi all,
>
> Motivation
> ==========
>
> On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
> does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
> result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
> (EP) is not possible even if we would add implementation to create a MSI
> domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
> traffic must fall back to doorbells (polling). In addition, BAR resources
> are scarce, which makes it difficult to dedicate a BAR solely to an
> NTB/msi window.
>
> This RFC introduces a generic interrupt backend for NTB. The existing MSI
> path is converted to a backend, and a new DW eDMA test-interrupt backend
> provides an RC-to-EP interrupt fallback when MSI cannot be used. In
> parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
> windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
> The vNTB EPF and ntb_transport are taught about offsets.

Map multi address to one bar is quite valuable, so we can start it as the
first steps.

But I have a problem about DWC iATU address map mode. for example, bar0
to cpu address 0x8000000 (Local CPU).  but difference RC system, at RC side
bar0 address is variable. May be 0xa000_0000 (RC side), maybe 0xc000_0000
(RC side).

Set bar0 mapping before linkup.

How do you know PCI bus address is 0xa0000000 or 0xc0000000.

Frank

>
> Backend selection is automatic: if MSI is available we use the MSI backend.
> Otherwise, if enabled, the DW eDMA backend is used. If neither is
> available, we continue to use doorbells. Existing systems remain unaffected
> unless use_intr=1 is set.
>
> Example layout (R-Car S4):
>
>   BAR0: Config/Spad
>   BAR2 [0x00000-0xF0000]: MW1 (data)
>   BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
>   BAR4: Doorbell
>
>   # The corresponding configfs settings (see Patch #25):
>   echo 0xF0000 > ./mw1
>   echo 0x8000  > ./mw2
>   echo 0xF0000 > ./mw2_offset
>   echo 2       > ./mw1_bar
>   echo 2       > ./mw2_bar
>
> Summary of changes
> ==================
>
> * NTB core/transport
>   - Introduce struct ntb_intr_backend and convert MSI to the new backend.
>   - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
>   - Rename module parameter to use_intr (keep use_msi as deprecated alias).
>   - Support offsetted partial MWs in ntb_transport.
>   - Hardening for peer-reported interrupt values and minor cleanups.
>
> * PCI Endpoint core and DWC EP controller
>   - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
>   - Implement inbound mapping for DesignWare EP (Address Match mode), with
>     tracking of multiple inbound iATU entries per BAR and proper teardown.
>
> * EPF vNTB
>   - Add mwN_offset configfs attributes and propagate offsets to inbound maps.
>   - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
>     set_bar().
>   - Provide .get_pci_epc() so backends can locate the common eDMA instance.
>
> * DW eDMA
>   - Add self-interrupt registration and expose test-IRQ register offsets.
>   - Provide dw_edma_find_by_child().
>
> * Renesas R-Car
>   - Place MW2 in BAR2 to host the interrupt window alongside the data MW.
>
> * Documentation
>
> Patch layout
> ============
>
> * Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
> * Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
> * Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
> * Patches 18-19 : NTB/EPF glue (.get_pci_epc())
> * Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
> * Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
> * Patch 24      : R-Car: add MW2 in BAR2 for interrupts
> * Patch 25      : Documentation updates
>
> Tested on
> =========
>
> * Renesas R-Car S4 Spider
> * Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)
>
> Performance measurement
> =======================
>
> Even without the DMA acceleration patches for R-Car S4 (which I keep
> separate from this RFC patch series), enabling RC-to-EP interrupts
> dramatically improves NTB latency on R-Car S4:
>
> * Before this patch series (NB. use_msi doesn't work on R-Car S4)
>
>   # Server: sockperf server -i 0.0.0.0
>   # Client: sockperf ping-pong -i $SERVER_IP
>   ========= Printing statistics for Server No: 0
>   [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
>   ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
>         siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
>   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
>   Summary: Latency is 5995.680 usec
>   Total 45 observations; each percentile contains 0.45 observations
>   ---> <MAX> observation = 6121.137
>   ---> percentile 99.999 = 6121.137
>   ---> percentile 99.990 = 6121.137
>   ---> percentile 99.900 = 6121.137
>   ---> percentile 99.000 = 6121.137
>   ---> percentile 90.000 = 6099.178
>   ---> percentile 75.000 = 6054.418
>   ---> percentile 50.000 = 5993.040
>   ---> percentile 25.000 = 5935.021
>   ---> <MIN> observation = 5883.362
>
> * With this series (use_intr=1)
>
>   # Server: sockperf server -i 0.0.0.0
>   # Client: sockperf ping-pong -i $SERVER_IP
>   ========= Printing statistics for Server No: 0
>   [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
>   ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
>         siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
>   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
>   Summary: Latency is 127.677 usec
>   Total 2145 observations; each percentile contains 21.45 observations
>   ---> <MAX> observation =  446.691
>   ---> percentile 99.999 =  446.691
>   ---> percentile 99.990 =  446.691
>   ---> percentile 99.900 =  291.234
>   ---> percentile 99.000 =  221.515
>   ---> percentile 90.000 =  149.277
>   ---> percentile 75.000 =  124.497
>   ---> percentile 50.000 =  121.137
>   ---> percentile 25.000 =  119.037
>   ---> <MIN> observation =  113.637
>
> Feedback welcome on both the approach and the splitting/routing preference.
>
> (The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
> later if preferred.)
>
> Thanks for reviewing.
>
>
> Koichiro Den (25):
>   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
>     access
>   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
>   NTB: epf: Handle mwN_offset for inbound MW regions
>   PCI: endpoint: Add inbound mapping ops to EPC core
>   PCI: dwc: ep: Implement EPC inbound mapping support
>   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
>   NTB: Add offset parameter to MW translation APIs
>   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
>     present
>   NTB: ntb_transport: Support offsetted partial memory windows
>   NTB/msi: Support offsetted partial memory window for MSI
>   NTB/msi: Do not force MW to its maximum possible size
>   NTB: ntb_transport: Stricter checks for peer-reported interrupt values
>   NTB/msi: Skip mw_set_trans() if already configured
>   NTB/msi: Add a inner loop for PCI-MSI cases
>   dmaengine: dw-edma: Add self-interrupt registration API
>   dmaengine: dw-edma: Expose self-IRQ register offsets
>   dmaengine: dw-edma: Add dw_edma_find_by_child() helper
>   NTB: core: Add .get_pci_epc() to ntb_dev_ops
>   NTB: epf: vntb: Implement .get_pci_epc() callback
>   NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
>   NTB: Introduce generic interrupt backend abstraction and convert MSI
>   NTB: ntb_transport: Rename MSI symbols to generic interrupt form
>   NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
>   NTB: epf: Add MW2 for interrupt use on Renesas R-Car
>   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
>     usage
>
>  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
>  drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
>  drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
>  drivers/ntb/Kconfig                           |  15 ++
>  drivers/ntb/Makefile                          |   6 +-
>  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
>  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
>  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
>  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
>  drivers/ntb/intr_common.c                     |  61 +++++
>  drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
>  drivers/ntb/msi.c                             | 186 +++++++------
>  drivers/ntb/ntb_transport.c                   | 155 ++++++-----
>  drivers/ntb/test/ntb_msi_test.c               |  26 +-
>  drivers/ntb/test/ntb_perf.c                   |   4 +-
>  drivers/ntb/test/ntb_tool.c                   |   6 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.c  |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
>  drivers/pci/endpoint/pci-epc-core.c           |  44 +++
>  include/linux/dma/edma.h                      |  31 +++
>  include/linux/ntb.h                           | 134 +++++++---
>  include/linux/pci-epc.h                       |  11 +
>  29 files changed, 1310 insertions(+), 300 deletions(-)
>  create mode 100644 drivers/ntb/intr_common.c
>  create mode 100644 drivers/ntb/intr_dw_edma.c
>
> --
> 2.48.1
>

