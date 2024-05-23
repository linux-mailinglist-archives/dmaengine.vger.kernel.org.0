Return-Path: <dmaengine+bounces-2146-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691038CDCC4
	for <lists+dmaengine@lfdr.de>; Fri, 24 May 2024 00:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F9F2810AA
	for <lists+dmaengine@lfdr.de>; Thu, 23 May 2024 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDC484A4E;
	Thu, 23 May 2024 22:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QnTjk5Kr"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2088.outbound.protection.outlook.com [40.107.13.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B282D9A
	for <dmaengine@vger.kernel.org>; Thu, 23 May 2024 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501755; cv=fail; b=Ha7FOTnfehT8CTftnY8EB6YgJYzqZ52BNV4fRyClC9Px4VuP5xGc2ggK+JprlpAQynMUNernC8/9FBjy+3IiKSuM6Fu/maio4dTIfJ87mL/cAf4PtlHEV9+iUvEY2cS95l7uJcUzLlwsg4Xk8bvKZWvm+YnnHwVslPJs/mlTeRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501755; c=relaxed/simple;
	bh=p5iM7kACsGEzAX5tN81yHhfbbRy7AZp3jbbEmMXAR7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HJ/1lE0n3O2jQgaejEAIRzpCcvVaj0kNtL675YqWSlCk9NEgztoApggk8WrjZpZgeal1528C3QhSY2zOm6aahz3d2LVAoG7mOvkl7CiOTe6AZDqQQio+5pMJPvnaSKRVho00mXI4MNCbnhM57GxUyGMGoEkZNMa2KAlg0bDU880=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QnTjk5Kr; arc=fail smtp.client-ip=40.107.13.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4Bsisyf0fmieNHNaYpy/7RurAydUOV/HQ6jTCyHhe8vSxHbgrJOP8WuGhPiPGz9Y/gLI1oaZRiAkix3rnAuN3LrztxBaotzzczRFuNvVfVR/OKWesRIrJSFFAPvrqCYKFFYDDtungrQaS8DEfoNwh+h79ZXm527T8CxmbnedqzbaDdbHE9dTwRv2/kpWcYSKoEkQyfDLsr+pF6ZJPqmyeOQc1dF5u39fEsFFvrLjhN4gdDORyl4cKhgODaplO73URhaFXwmYKBvDda3II/DYfFHHkFmEBf38mXHKNzBuIUbJKENMB5k7C/U1ekkDi8vGiFw4+dXJpjHPoxijSQ1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se/C6P2b+TOvTwnnmXASCMcq3gbLqUPFt4qQnzVEUXk=;
 b=ere5GEb7khqlDW5UOrbhnb8cQY3Ka9gyakQs1aLH+g1SkPv71wD94llLra9wMjUkmDtxdrfcWuYLnY5nhi7GO0ZTvKZj0tuZDT2Rj58i5TT984eIxRIeqgFPQtymDfRko4DN5rEqGX6CtlUYUXocVphDJ3Y6+6N9JUHzSPQsJjgcny7IYQ7Z7gYJUqi8xtuYX3l0/PO8Lo69knPXEpD7BDFDscdYnYa/36+KL3NCkxAJVCYsiNXaWgZdBhhyl3D0O1zKi6gLL0XT11bUpnhl+7KFleX64uu2phNmQ+yJp6E+S5+y2d7YrOFY6CacQXEuQKDjLVCR9VJVO2s6hfPQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se/C6P2b+TOvTwnnmXASCMcq3gbLqUPFt4qQnzVEUXk=;
 b=QnTjk5KrQnk52LoqL6Rnom/mu25IoGNAT/MYlh2XKiqaGDaa2/bCi1+ovzhvUZ0L049EtGVRh2sOj5sjMzwqqanxQxGyCsYxzqssVCMP2FFJMFQpjFL68GaghRiqP1eb+xsb/Xqg2Rxj0PJdC4qHoyIzh8u26eKrdE6bSby+7QM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 22:02:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 22:02:28 +0000
Date: Thu, 23 May 2024 18:02:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Basavaraj Natikar <bnatikar@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, vkoul@kernel.org,
	dmaengine@vger.kernel.org, Raju.Rangoju@amd.com
Subject: Re: [PATCH 2/7] dmaengine: ae4dma: Add AMD ae4dma controller driver
Message-ID: <Zk+87eRJBvbO+BhG@lizhi-Precision-Tower-5810>
References: <20240510082053.875923-1-Basavaraj.Natikar@amd.com>
 <20240510082053.875923-3-Basavaraj.Natikar@amd.com>
 <Zj5kmc766qmOwjq1@lizhi-Precision-Tower-5810>
 <22e39316-d446-46a4-9c11-96e97413f842@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e39316-d446-46a4-9c11-96e97413f842@amd.com>
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9ca132-864c-49ed-735c-08dc7b740941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9fcT3mU8Tzean73up9cjnNY/6eXg5kWqWMQLknyWu+DhTZ+FDUsF5RUc91K?=
 =?us-ascii?Q?qTZ6V56Rrkms0QIkSyf+PQCwWIUNgq7Y9Rf/L47ged5oP8vV56soANl/t5X9?=
 =?us-ascii?Q?L/dAlWhDUIuRpS6fGxsi71xaRzJyWQdPLqoJFQtjExJzXgvVkXOvpJ0AEeWT?=
 =?us-ascii?Q?PnFKRwEY6MC4//CTt3LHFRPwkMBdHmBGGHmOfRYZrg3EaUiNWsvC9MzDWuIT?=
 =?us-ascii?Q?z0k0EGrtxevFvuTR3z+sdyOpvYLxbK8xQX+NgenxEBqsTCyWfvKn3s4R4Peh?=
 =?us-ascii?Q?w+5Re9PSGfT1nAP7iXCo7HC3gxhXgd5lPWgVsIp6YgrxqcZWO6xOXnqy24dg?=
 =?us-ascii?Q?xd33p4ZWRlp5FfLlOMFMNAZvPwWKoAUFChOfl768I0Oeydrss+TiQD63di7c?=
 =?us-ascii?Q?FBpmbybaQprjH2pzOt5JOUZrHO+yMiflfV8F2aNK6nce7l18+CP0Pgi0lne3?=
 =?us-ascii?Q?nT+7wK0deZ39uWWWkRlxohelblZdpaBoT1YiERwV3r6yJvaZzZfrKCtzMDgX?=
 =?us-ascii?Q?kNzwIJhLwyK77IVOWpmCPkBKuSoQy0O3xy8cLDHCAGM9IXCkIe3ciE2oHfhS?=
 =?us-ascii?Q?tMtjgxN0nhs/H/LPe1s8SJTuTLkgnLo/nW0merVD32qVZiIwQCC+1BVk02Gq?=
 =?us-ascii?Q?n+lBhHnTX7C5Zqm1epfRlECDK20iw/oHgevCRlwiuIyQPvfw1Gxx6BPJsHjw?=
 =?us-ascii?Q?oG+sc9jZYAbqL76S9y0vqodoqOY5A0z4mrnXNtrg/WMkoJs22qcf7H9obFCF?=
 =?us-ascii?Q?qJvV3C8+TYNcBuqP+ak29v9J/o+RdndvzwREclNLJU1+JLEi52BteAzE6qce?=
 =?us-ascii?Q?cGmUZAJm2MGXfXyslyNJnONRYhcBSE6Yq0RX3fU+0sgquB/xK3xUCKX2iorN?=
 =?us-ascii?Q?dLHRASqZxjGP6GrOXEE8yCxyzpeMR6zzIQSU/qcEkR7WQ4GFE+B0PnlPu8lB?=
 =?us-ascii?Q?N1rr4iu1vB2rmAseruE65nYS3lFG5zTPRFUrcSaaOXn3c+b9SkAg8ZOn4NL7?=
 =?us-ascii?Q?OHIMCxLtUm/1lYzNX/FtivUJqJWwpKEGmN15OyMqlFn6xNn8N7IQYZNiVRIY?=
 =?us-ascii?Q?nsfhRoFK2/3PyDK/R4jmrC81yRijY5kEseL+6/OiVPmTe8aXq5Hb7dlhH5H1?=
 =?us-ascii?Q?K56La2i/5q5defb1oPBHci8BpyqzWfvWHZzuPACUZZhgupmEALQ3AJ3QCGaP?=
 =?us-ascii?Q?jXfS4lrFsI/RjMiTL3/L9P+5Do8+MKJTTDwrkOxt/TOSCkPz37M9KgcNYx8q?=
 =?us-ascii?Q?q1UKGUZsIEoymkUMg/WR5KQxOpTC3t3Aids498pijg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?19s+bWUcUfC4VGHfuzkKJ9Wh1vbrLWRtGVAlupDRBvO7tijk43eDrELMy09w?=
 =?us-ascii?Q?bgKG+/6RAqCBvQnQayWGCWfJCFORfWctlDqMhH8ibB48E5U7P7fSwfSIejH9?=
 =?us-ascii?Q?5Navk3QD2/reGt1ARmGM1u45Z9IfiViveLGROfVxIjzTY+QBOVxO7NnzJCW/?=
 =?us-ascii?Q?F5kOEp9BLu2wYAhnuThogUXcoGgCq3Uv7oN71ij/zEO3j+xFAeu+WtqNhr6u?=
 =?us-ascii?Q?oP8ERhpob3dYiU6AR4lmnWNhPO2/dAcD9+/Wxd1kJNuCEBLe9TEr5sMGj4+6?=
 =?us-ascii?Q?mGa8UYaftZtqg4CX9aUhnueCo7kir9h08sfXO9BUrfb1QX26MdlN1hoGP/U5?=
 =?us-ascii?Q?1nP5SJEkuMobXrLQIjUnQK9r/wxTYnoFvs2TorW+3acAMlBZMJ8r6NFHtu5v?=
 =?us-ascii?Q?u4O4T//2tM/whq5HMTxlicDdEIKLBdiKcJIUEm1O8yOSXPIpixbG8IhDGnn/?=
 =?us-ascii?Q?XVMHF57gjqBJ6zHV4mupu/VEQCCmUBobLuVopQ6zJ/47PUWawEJNQE1CoVG9?=
 =?us-ascii?Q?9uw8b5ooO/3C3k5z6zXEyEvbrBEDvMwNiOpQ33DWD/Q2rKE/6d5Qf2pH5hAf?=
 =?us-ascii?Q?3Mz2L88w4o1+a2RSOLG5UKIs7QyGug4cTQg0/k7nAl4rrRg2xcOGMBJ8j9RC?=
 =?us-ascii?Q?rzJhZZv+ti0qtp+wxTnWkxv+VLW06r/Cb2f5KxN7PBDw3gg8SehamlK5KW5V?=
 =?us-ascii?Q?XRk7OrHsnknqZQlldlB1WzzuMeYUyYMCuoWmmEtwnfMF7un3ortkekg+z1ae?=
 =?us-ascii?Q?nb0EFe5Jqtlzl0AA6KPHP/mEjbiujBWjtiX6//JzFn2/7uZlXtzQ2O0TDsfY?=
 =?us-ascii?Q?JgRIgRj7DhNu6fBlWLagbTJkTDa4kNjI7czTcQB/2swKqD/9Pz5WW4g6JHXk?=
 =?us-ascii?Q?89JV/DVAp+q5P2N47NnLDU6PIOdKNz0dXZii07ppxUWC5QysNsXLiiLoXe4z?=
 =?us-ascii?Q?+wSv6s1ryxNjXf3PU0ykYFYjWmfpl8keLUA2Ohsgn1VbIkRC0OgioQP4WT4g?=
 =?us-ascii?Q?ZgKX3NT/Die1mK5/mtRLJmccaQolYqvlWVRCRGRas5wrvMaOlFtIj8EH6vK2?=
 =?us-ascii?Q?zQa3JoMnT+sqtahODvI7j9RJgYoQhglhqcCaQEnAplZS9BJWfoBEu9v/OGFU?=
 =?us-ascii?Q?fKRGTvK4DK11SuHZBqXmdO0MnQF9KJph2dVYdL1Qfg+OyimS07MOTiY5Mece?=
 =?us-ascii?Q?Jf1GPGx5EKIMixt5mIwCbtV8E7lg9bHRs+0RJKYNqfVGKKoBPAJpXWgMfexV?=
 =?us-ascii?Q?jIcO/tiKvcn731+lNSIwL9vMDhddILcbhz/3PEg89VABZZ1HTsv0olZSytxW?=
 =?us-ascii?Q?WCHKn0YrVWxS1Y1nF0yMAfZFtFER4Hvp7scQVVtZwRTgA/5eumDy+pnUw5xy?=
 =?us-ascii?Q?WkS5mEybmvs+/rly2wABON3CR9cgV2Mk9rbJaxv1OBHf8sNl5lSzgQbk5/7H?=
 =?us-ascii?Q?2pMJ8ZEavp1/PpRm9KGP9+T6dgZUu6d7Av0XKpwO3cJoGMgCRDzKwMya0Izc?=
 =?us-ascii?Q?DcFTKAcQgmnwAEplUXT8NgyAX0gLiC8VitMVzbqP7LsXD48opmdk5wY/1/f4?=
 =?us-ascii?Q?x9glqcHqRXsfECQamCE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9ca132-864c-49ed-735c-08dc7b740941
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 22:02:28.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nAaM/O4phr+3/8lfgMrDuTve05UoggE36pPTfWYSzGPQj4WFA1UirclEDIRHAcJacKZNPXhd9v/Cg8puwq9OTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

On Tue, May 21, 2024 at 03:06:17PM +0530, Basavaraj Natikar wrote:
> 
> On 5/10/2024 11:46 PM, Frank Li wrote:
> > On Fri, May 10, 2024 at 01:50:48PM +0530, Basavaraj Natikar wrote:
> >> Add support for AMD AE4DMA controller. It performs high-bandwidth
> >> memory to memory and IO copy operation. Device commands are managed
> >> via a circular queue of 'descriptors', each of which specifies source
> >> and destination addresses for copying a single buffer of data.
> >>
> >> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
> >> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> ---
> >>  MAINTAINERS                         |   6 +
> >>  drivers/dma/amd/Kconfig             |   1 +
> >>  drivers/dma/amd/Makefile            |   1 +
> >>  drivers/dma/amd/ae4dma/Kconfig      |  13 ++
> >>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
> >>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 206 ++++++++++++++++++++++++++++
> >>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 195 ++++++++++++++++++++++++++
> >>  drivers/dma/amd/ae4dma/ae4dma.h     |  77 +++++++++++
> >>  drivers/dma/amd/common/amd_dma.h    |  26 ++++
> >>  9 files changed, 535 insertions(+)
> >>  create mode 100644 drivers/dma/amd/ae4dma/Kconfig
> >>  create mode 100644 drivers/dma/amd/ae4dma/Makefile
> >>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-dev.c
> >>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma-pci.c
> >>  create mode 100644 drivers/dma/amd/ae4dma/ae4dma.h
> >>  create mode 100644 drivers/dma/amd/common/amd_dma.h
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index b190efda33ba..45f2140093b6 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -909,6 +909,12 @@ L:	linux-edac@vger.kernel.org
> >>  S:	Supported
> >>  F:	drivers/ras/amd/atl/*
> >>  
> >> +AMD AE4DMA DRIVER
> >> +M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> +L:	dmaengine@vger.kernel.org
> >> +S:	Maintained
> >> +F:	drivers/dma/amd/ae4dma/
> >> +
> >>  AMD AXI W1 DRIVER
> >>  M:	Kris Chaplin <kris.chaplin@amd.com>
> >>  R:	Thomas Delev <thomas.delev@amd.com>
> >> diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
> >> index 8246b463bcf7..8c25a3ed6b94 100644
> >> --- a/drivers/dma/amd/Kconfig
> >> +++ b/drivers/dma/amd/Kconfig
> >> @@ -3,3 +3,4 @@
> >>  # AMD DMA Drivers
> >>  
> >>  source "drivers/dma/amd/ptdma/Kconfig"
> >> +source "drivers/dma/amd/ae4dma/Kconfig"
> >> diff --git a/drivers/dma/amd/Makefile b/drivers/dma/amd/Makefile
> >> index dd7257ba7e06..8049b06a9ff5 100644
> >> --- a/drivers/dma/amd/Makefile
> >> +++ b/drivers/dma/amd/Makefile
> >> @@ -4,3 +4,4 @@
> >>  #
> >>  
> >>  obj-$(CONFIG_AMD_PTDMA) += ptdma/
> >> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma/
> >> diff --git a/drivers/dma/amd/ae4dma/Kconfig b/drivers/dma/amd/ae4dma/Kconfig
> >> new file mode 100644
> >> index 000000000000..cf8db4dac98d
> >> --- /dev/null
> >> +++ b/drivers/dma/amd/ae4dma/Kconfig
> >> @@ -0,0 +1,13 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +config AMD_AE4DMA
> >> +	tristate  "AMD AE4DMA Engine"
> >> +	depends on X86_64 && PCI
> >> +	select DMA_ENGINE
> >> +	select DMA_VIRTUAL_CHANNELS
> >> +	help
> >> +	  Enable support for the AMD AE4DMA controller. This controller
> >> +	  provides DMA capabilities to perform high bandwidth memory to
> >> +	  memory and IO copy operations. It performs DMA transfer through
> >> +	  queue-based descriptor management. This DMA controller is intended
> >> +	  to be used with AMD Non-Transparent Bridge devices and not for
> >> +	  general purpose peripheral DMA.
> >> diff --git a/drivers/dma/amd/ae4dma/Makefile b/drivers/dma/amd/ae4dma/Makefile
> >> new file mode 100644
> >> index 000000000000..e918f85a80ec
> >> --- /dev/null
> >> +++ b/drivers/dma/amd/ae4dma/Makefile
> >> @@ -0,0 +1,10 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +#
> >> +# AMD AE4DMA driver
> >> +#
> >> +
> >> +obj-$(CONFIG_AMD_AE4DMA) += ae4dma.o
> >> +
> >> +ae4dma-objs := ae4dma-dev.o
> >> +
> >> +ae4dma-$(CONFIG_PCI) += ae4dma-pci.o
> >> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> >> new file mode 100644
> >> index 000000000000..fc33d2056af2
> >> --- /dev/null
> >> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> >> @@ -0,0 +1,206 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * AMD AE4DMA driver
> >> + *
> >> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> >> + * All Rights Reserved.
> >> + *
> >> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> + */
> >> +
> >> +#include "ae4dma.h"
> >> +
> >> +static unsigned int max_hw_q = 1;
> >> +module_param(max_hw_q, uint, 0444);
> >> +MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
> > Does it get from hardware register? you put to global variable. How about
> > system have two difference DMA controllers, one's max_hw_q is 1, the other
> > is 2.
> 
> Yes, this global value configures the default hardware register to 1. Since
> all DMA controllers are identical, they will all have the same value set for
> all DMA controllers. 

Even it is same now. I still perfer put 

+static const struct pci_device_id ae4_pci_table[] = {
+	{ PCI_VDEVICE(AMD, 0x14C8), MAX_HW_Q},
				    ^^^^^^^^

+	{ PCI_VDEVICE(AMD, 0x14DC), ...},
+	{ PCI_VDEVICE(AMD, 0x149B), ...},
+	/* Last entry must be zero */
+	{ 0, }

So if new design increase queue number in future. 
You just need add one line here.

Frank

> 
> >
> >> +
> >> +static char *ae4_error_codes[] = {
> >> +	"",
> >> +	"ERR 01: INVALID HEADER DW0",
> >> +	"ERR 02: INVALID STATUS",
> >> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
> >> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
> >> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
> >> +	"ERR 06: INVALID ALIGNMENT",
> >> +	"ERR 07: INVALID DESCRIPTOR",
> >> +};
> >> +
> >> +static void ae4_log_error(struct pt_device *d, int e)
> >> +{
> >> +	if (e <= 7)
> >> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
> >> +	else if (e > 7 && e <= 15)
> >> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> >> +	else if (e > 15 && e <= 31)
> >> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> >> +	else if (e > 31 && e <= 63)
> >> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
> >> +	else if (e > 63 && e <= 127)
> >> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> >> +	else if (e > 127 && e <= 255)
> >> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
> >> +	else
> >> +		dev_info(d->dev, "Unknown AE4DMA error");
> >> +}
> >> +
> >> +static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
> >> +{
> >> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> >> +	struct ae4dma_desc desc;
> >> +	u8 status;
> >> +
> >> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
> >> +	/* Synchronize ordering */
> >> +	mb();
> > does dma_wmb() enough? 
> 
> Sure, I will change to dma_rmb which is enough for this scenario.
> 
> >
> >> +	status = desc.dw1.status;
> >> +	if (status && status != AE4_DESC_COMPLETED) {
> >> +		cmd_q->cmd_error = desc.dw1.err_code;
> >> +		if (cmd_q->cmd_error)
> >> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
> >> +	}
> >> +}
> >> +
> >> +static void ae4_pending_work(struct work_struct *work)
> >> +{
> >> +	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
> >> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
> >> +	struct pt_cmd *cmd;
> >> +	u32 cridx, dridx;
> >> +
> >> +	while (true) {
> >> +		wait_event_interruptible(ae4cmd_q->q_w,
> >> +					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
> >> +					   atomic64_read(&ae4cmd_q->intr_cnt)));
> > wait_event_interruptible_timeout() ? to avoid patental deadlock.
> 
> A thread will be created and started for each queue initially. These threads will wait for any DMA
> operation to complete quickly. If there are no DMA operations, the threads will remain idle, but
> there won't be a deadlock.
> 
> >
> >> +
> >> +		atomic64_inc(&ae4cmd_q->done_cnt);
> >> +
> >> +		mutex_lock(&ae4cmd_q->cmd_lock);
> >> +
> >> +		cridx = readl(cmd_q->reg_control + 0x0C);
> >> +		dridx = atomic_read(&ae4cmd_q->dridx);
> >> +
> >> +		while ((dridx != cridx) && !list_empty(&ae4cmd_q->cmd)) {
> >> +			cmd = list_first_entry(&ae4cmd_q->cmd, struct pt_cmd, entry);
> >> +			list_del(&cmd->entry);
> >> +
> >> +			ae4_check_status_error(ae4cmd_q, dridx);
> >> +			cmd->pt_cmd_callback(cmd->data, cmd->ret);
> >> +
> >> +			atomic64_dec(&ae4cmd_q->q_cmd_count);
> >> +			dridx = (dridx + 1) % CMD_Q_LEN;
> >> +			atomic_set(&ae4cmd_q->dridx, dridx);
> >> +			/* Synchronize ordering */
> >> +			mb();
> >> +
> >> +			complete_all(&ae4cmd_q->cmp);
> >> +		}
> >> +
> >> +		mutex_unlock(&ae4cmd_q->cmd_lock);
> >> +	}
> >> +}
> >> +
> >> +static irqreturn_t ae4_core_irq_handler(int irq, void *data)
> >> +{
> >> +	struct ae4_cmd_queue *ae4cmd_q = data;
> >> +	struct pt_cmd_queue *cmd_q;
> >> +	struct pt_device *pt;
> >> +	u32 status;
> >> +
> >> +	cmd_q = &ae4cmd_q->cmd_q;
> >> +	pt = cmd_q->pt;
> >> +
> >> +	pt->total_interrupts++;
> >> +	atomic64_inc(&ae4cmd_q->intr_cnt);
> >> +
> >> +	wake_up(&ae4cmd_q->q_w);
> >> +
> >> +	status = readl(cmd_q->reg_control + 0x14);
> >> +	if (status & BIT(0)) {
> >> +		status &= GENMASK(31, 1);
> >> +		writel(status, cmd_q->reg_control + 0x14);
> >> +	}
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +void ae4_destroy_work(struct ae4_device *ae4)
> >> +{
> >> +	struct ae4_cmd_queue *ae4cmd_q;
> >> +	int i;
> >> +
> >> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> >> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> >> +
> >> +		if (!ae4cmd_q->pws)
> >> +			break;
> >> +
> >> +		cancel_delayed_work(&ae4cmd_q->p_work);
> > do you need cancel_delayed_work_sync()?
> 
> Sure, I will change to cancel_delayed_work_sync.
> 
> >
> >> +		destroy_workqueue(ae4cmd_q->pws);
> >> +	}
> >> +}
> >> +
> >> +int ae4_core_init(struct ae4_device *ae4)
> >> +{
> >> +	struct pt_device *pt = &ae4->pt;
> >> +	struct ae4_cmd_queue *ae4cmd_q;
> >> +	struct device *dev = pt->dev;
> >> +	struct pt_cmd_queue *cmd_q;
> >> +	int i, ret = 0;
> >> +
> >> +	writel(max_hw_q, pt->io_regs);
> >> +
> >> +	for (i = 0; i < max_hw_q; i++) {
> >> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> >> +		ae4cmd_q->id = ae4->cmd_q_count;
> >> +		ae4->cmd_q_count++;
> >> +
> >> +		cmd_q = &ae4cmd_q->cmd_q;
> >> +		cmd_q->pt = pt;
> >> +
> >> +		/* Preset some register values (Q size is 32byte (0x20)) */
> >> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
> >> +
> >> +		ret = devm_request_irq(dev, ae4->ae4_irq[i], ae4_core_irq_handler, 0,
> >> +				       dev_name(pt->dev), ae4cmd_q);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		cmd_q->qsize = Q_SIZE(sizeof(struct ae4dma_desc));
> >> +
> >> +		cmd_q->qbase = dmam_alloc_coherent(dev, cmd_q->qsize, &cmd_q->qbase_dma,
> >> +						   GFP_KERNEL);
> >> +		if (!cmd_q->qbase)
> >> +			return -ENOMEM;
> >> +	}
> >> +
> >> +	for (i = 0; i < ae4->cmd_q_count; i++) {
> >> +		ae4cmd_q = &ae4->ae4cmd_q[i];
> >> +
> >> +		cmd_q = &ae4cmd_q->cmd_q;
> >> +
> >> +		/* Preset some register values (Q size is 32byte (0x20)) */
> >> +		cmd_q->reg_control = pt->io_regs + ((i + 1) * 0x20);
> >> +
> >> +		/* Update the device registers with queue information. */
> >> +		writel(CMD_Q_LEN, cmd_q->reg_control + 0x08);
> >> +
> >> +		cmd_q->qdma_tail = cmd_q->qbase_dma;
> >> +		writel(lower_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x18);
> >> +		writel(upper_32_bits(cmd_q->qdma_tail), cmd_q->reg_control + 0x1C);
> >> +
> >> +		INIT_LIST_HEAD(&ae4cmd_q->cmd);
> >> +		init_waitqueue_head(&ae4cmd_q->q_w);
> >> +
> >> +		ae4cmd_q->pws = alloc_ordered_workqueue("ae4dma_%d", WQ_MEM_RECLAIM, ae4cmd_q->id);
> > Can existed workqueue match your requirement? 
> 
> Separate work queues for each queue, compared to a existing workqueue, enhance performance by enabling
> load balancing across queues, ensuring DMA command execution even under memory pressure, and
> maintaining strict isolation between tasks in different queues.
> 
> >
> > Frank
> >
> >> +		if (!ae4cmd_q->pws) {
> >> +			ae4_destroy_work(ae4);
> >> +			return -ENOMEM;
> >> +		}
> >> +		INIT_DELAYED_WORK(&ae4cmd_q->p_work, ae4_pending_work);
> >> +		queue_delayed_work(ae4cmd_q->pws, &ae4cmd_q->p_work,  usecs_to_jiffies(100));
> >> +
> >> +		init_completion(&ae4cmd_q->cmp);
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> >> new file mode 100644
> >> index 000000000000..4cd537af757d
> >> --- /dev/null
> >> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> >> @@ -0,0 +1,195 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * AMD AE4DMA driver
> >> + *
> >> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> >> + * All Rights Reserved.
> >> + *
> >> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> + */
> >> +
> >> +#include "ae4dma.h"
> >> +
> >> +static int ae4_get_msi_irq(struct ae4_device *ae4)
> >> +{
> >> +	struct pt_device *pt = &ae4->pt;
> >> +	struct device *dev = pt->dev;
> >> +	struct pci_dev *pdev;
> >> +	int ret, i;
> >> +
> >> +	pdev = to_pci_dev(dev);
> >> +	ret = pci_enable_msi(pdev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> >> +		ae4->ae4_irq[i] = pdev->irq;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int ae4_get_msix_irqs(struct ae4_device *ae4)
> >> +{
> >> +	struct ae4_msix *ae4_msix = ae4->ae4_msix;
> >> +	struct pt_device *pt = &ae4->pt;
> >> +	struct device *dev = pt->dev;
> >> +	struct pci_dev *pdev;
> >> +	int v, i, ret;
> >> +
> >> +	pdev = to_pci_dev(dev);
> >> +
> >> +	for (v = 0; v < ARRAY_SIZE(ae4_msix->msix_entry); v++)
> >> +		ae4_msix->msix_entry[v].entry = v;
> >> +
> >> +	ret = pci_enable_msix_range(pdev, ae4_msix->msix_entry, 1, v);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ae4_msix->msix_count = ret;
> >> +
> >> +	for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> >> +		ae4->ae4_irq[i] = ae4_msix->msix_entry[i].vector;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int ae4_get_irqs(struct ae4_device *ae4)
> >> +{
> >> +	struct pt_device *pt = &ae4->pt;
> >> +	struct device *dev = pt->dev;
> >> +	int ret;
> >> +
> >> +	ret = ae4_get_msix_irqs(ae4);
> >> +	if (!ret)
> >> +		return 0;
> >> +
> >> +	/* Couldn't get MSI-X vectors, try MSI */
> >> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
> >> +	ret = ae4_get_msi_irq(ae4);
> >> +	if (!ret)
> >> +		return 0;
> >> +
> >> +	/* Couldn't get MSI interrupt */
> >> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void ae4_free_irqs(struct ae4_device *ae4)
> >> +{
> >> +	struct ae4_msix *ae4_msix;
> >> +	struct pci_dev *pdev;
> >> +	struct pt_device *pt;
> >> +	struct device *dev;
> >> +	int i;
> >> +
> >> +	if (ae4) {
> >> +		pt = &ae4->pt;
> >> +		dev = pt->dev;
> >> +		pdev = to_pci_dev(dev);
> >> +
> >> +		ae4_msix = ae4->ae4_msix;
> >> +		if (ae4_msix && ae4_msix->msix_count)
> >> +			pci_disable_msix(pdev);
> >> +		else if (pdev->irq)
> >> +			pci_disable_msi(pdev);
> >> +
> >> +		for (i = 0; i < MAX_AE4_HW_QUEUES; i++)
> >> +			ae4->ae4_irq[i] = 0;
> >> +	}
> >> +}
> >> +
> >> +static void ae4_deinit(struct ae4_device *ae4)
> >> +{
> >> +	ae4_free_irqs(ae4);
> >> +}
> >> +
> >> +static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	struct ae4_device *ae4;
> >> +	struct pt_device *pt;
> >> +	int bar_mask;
> >> +	int ret = 0;
> >> +
> >> +	ae4 = devm_kzalloc(dev, sizeof(*ae4), GFP_KERNEL);
> >> +	if (!ae4)
> >> +		return -ENOMEM;
> >> +
> >> +	ae4->ae4_msix = devm_kzalloc(dev, sizeof(struct ae4_msix), GFP_KERNEL);
> >> +	if (!ae4->ae4_msix)
> >> +		return -ENOMEM;
> >> +
> >> +	ret = pcim_enable_device(pdev);
> >> +	if (ret)
> >> +		goto ae4_error;
> >> +
> >> +	bar_mask = pci_select_bars(pdev, IORESOURCE_MEM);
> >> +	ret = pcim_iomap_regions(pdev, bar_mask, "ae4dma");
> >> +	if (ret)
> >> +		goto ae4_error;
> >> +
> >> +	pt = &ae4->pt;
> >> +	pt->dev = dev;
> >> +
> >> +	pt->io_regs = pcim_iomap_table(pdev)[0];
> >> +	if (!pt->io_regs) {
> >> +		ret = -ENOMEM;
> >> +		goto ae4_error;
> >> +	}
> >> +
> >> +	ret = ae4_get_irqs(ae4);
> >> +	if (ret)
> >> +		goto ae4_error;
> >> +
> >> +	pci_set_master(pdev);
> >> +
> >> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> >> +	if (ret) {
> >> +		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> >> +		if (ret)
> >> +			goto ae4_error;
> >> +	}
> > needn't failback to 32bit.  never return failure when bit >= 32.
> >
> > Detail see: 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f7ae20f2fc4e6a5e32f43c4fa2acab3281a61c81
> >
> > if (support_48bit)
> > 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48))
> > else
> > 	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
> >
> > you decide if support_48bit by hardware register or PID/DID
> 
> Sure, I will add only this line dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)).
> 
> >
> >
> >> +
> >> +	dev_set_drvdata(dev, ae4);
> >> +
> >> +	ret = ae4_core_init(ae4);
> >> +	if (ret)
> >> +		goto ae4_error;
> >> +
> >> +	return 0;
> >> +
> >> +ae4_error:
> >> +	ae4_deinit(ae4);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void ae4_pci_remove(struct pci_dev *pdev)
> >> +{
> >> +	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
> >> +
> >> +	ae4_destroy_work(ae4);
> >> +	ae4_deinit(ae4);
> >> +}
> >> +
> >> +static const struct pci_device_id ae4_pci_table[] = {
> >> +	{ PCI_VDEVICE(AMD, 0x14C8), },
> >> +	{ PCI_VDEVICE(AMD, 0x14DC), },
> >> +	{ PCI_VDEVICE(AMD, 0x149B), },
> >> +	/* Last entry must be zero */
> >> +	{ 0, }
> >> +};
> >> +MODULE_DEVICE_TABLE(pci, ae4_pci_table);
> >> +
> >> +static struct pci_driver ae4_pci_driver = {
> >> +	.name = "ae4dma",
> >> +	.id_table = ae4_pci_table,
> >> +	.probe = ae4_pci_probe,
> >> +	.remove = ae4_pci_remove,
> >> +};
> >> +
> >> +module_pci_driver(ae4_pci_driver);
> >> +
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_DESCRIPTION("AMD AE4DMA driver");
> >> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> >> new file mode 100644
> >> index 000000000000..24b1253ad570
> >> --- /dev/null
> >> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> >> @@ -0,0 +1,77 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * AMD AE4DMA driver
> >> + *
> >> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> >> + * All Rights Reserved.
> >> + *
> >> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> + */
> >> +#ifndef __AE4DMA_H__
> >> +#define __AE4DMA_H__
> >> +
> >> +#include "../common/amd_dma.h"
> >> +
> >> +#define MAX_AE4_HW_QUEUES		16
> >> +
> >> +#define AE4_DESC_COMPLETED		0x3
> >> +
> >> +struct ae4_msix {
> >> +	int msix_count;
> >> +	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
> >> +};
> >> +
> >> +struct ae4_cmd_queue {
> >> +	struct ae4_device *ae4;
> >> +	struct pt_cmd_queue cmd_q;
> >> +	struct list_head cmd;
> >> +	/* protect command operations */
> >> +	struct mutex cmd_lock;
> >> +	struct delayed_work p_work;
> >> +	struct workqueue_struct *pws;
> >> +	struct completion cmp;
> >> +	wait_queue_head_t q_w;
> >> +	atomic64_t intr_cnt;
> >> +	atomic64_t done_cnt;
> >> +	atomic64_t q_cmd_count;
> >> +	atomic_t dridx;
> >> +	unsigned int id;
> >> +};
> >> +
> >> +union dwou {
> >> +	u32 dw0;
> >> +	struct dword0 {
> >> +	u8	byte0;
> >> +	u8	byte1;
> >> +	u16	timestamp;
> >> +	} dws;
> >> +};
> >> +
> >> +struct dword1 {
> >> +	u8	status;
> >> +	u8	err_code;
> >> +	u16	desc_id;
> >> +};
> >> +
> >> +struct ae4dma_desc {
> >> +	union dwou dwouv;
> >> +	struct dword1 dw1;
> >> +	u32 length;
> >> +	u32 rsvd;
> >> +	u32 src_hi;
> >> +	u32 src_lo;
> >> +	u32 dst_hi;
> >> +	u32 dst_lo;
> >> +};
> >> +
> >> +struct ae4_device {
> >> +	struct pt_device pt;
> >> +	struct ae4_msix *ae4_msix;
> >> +	struct ae4_cmd_queue ae4cmd_q[MAX_AE4_HW_QUEUES];
> >> +	unsigned int ae4_irq[MAX_AE4_HW_QUEUES];
> >> +	unsigned int cmd_q_count;
> >> +};
> >> +
> >> +int ae4_core_init(struct ae4_device *ae4);
> >> +void ae4_destroy_work(struct ae4_device *ae4);
> >> +#endif
> >> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
> >> new file mode 100644
> >> index 000000000000..31c35b3bc94b
> >> --- /dev/null
> >> +++ b/drivers/dma/amd/common/amd_dma.h
> >> @@ -0,0 +1,26 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * AMD DMA Driver common
> >> + *
> >> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> >> + * All Rights Reserved.
> >> + *
> >> + * Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> >> + */
> >> +
> >> +#ifndef AMD_DMA_H
> >> +#define AMD_DMA_H
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/dmaengine.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/spinlock.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/list.h>
> >> +#include <linux/wait.h>
> >> +#include <linux/dmapool.h>
> > order by alphabet
> 
> Sure, I will change it accordingly.
> 
> Thanks,
> --
> Basavaraj
> 
> >
> >> +
> >> +#include "../ptdma/ptdma.h"
> >> +#include "../../virt-dma.h"
> >> +
> >> +#endif
> >> -- 
> >> 2.25.1
> >>
> 

