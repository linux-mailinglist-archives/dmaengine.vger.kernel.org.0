Return-Path: <dmaengine+bounces-7818-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CDFCCE5A4
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 04:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFFE0300A353
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 03:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938A21638D;
	Fri, 19 Dec 2025 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ReXX9Whf"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDECEEB3;
	Fri, 19 Dec 2025 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766114393; cv=fail; b=E27KuavM43gDKS5f2zMUmOvwmc17Q10GPe6Oxl4Ur4VqMDdl5EWc+dXEbBtKWnL4AAHIXE99bYGKJ5ADsJ1ChI5LEgOCU++mPBaAWj1zKfTRCmJXd5rNRmpReQOk1+D+QqfLwgBCDfnWYc/mmQe12EilTlyjXW/msXuP9ySfktk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766114393; c=relaxed/simple;
	bh=001wSt+YUM8GNV5/HMpyIWDI7HDV8VKNWHbrHcOzWf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SHMNORFbbanD29haeK0pJotMcOMN0cnwVsgD7a8JyKXb5O0rxFrA6MiwoHjdL/ZFL0ziClZLamZC10UeFTzj9xh4IfjC24fKtUY1+Mb5qJrcL4MsJD+Rnm+haHW20bpV6ufdL+V4JIsgvLOolbKbOGai9FdAKZBNaew/t472euE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ReXX9Whf; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctzFgAkIHz2MON5RSOf+yGU+OPeo5iAzocwUzBC0W5cbzQ13XZr5JPFB6nHKFH0U/AybbaKCaX/tMn5F6HH6u12ObhoGLKv8z5ZVkiS9VSAaMN1oiwxQHlvxkpk0iSskisrmp2UrcrSRvTgBRn4RjFj/WHyzGb0k4l1KuK1iSaXtInSCvczjSZDqlcCmkzzEmCyu2K9f8OqhNZTqyXesjseAbHQrKqYLCv4d6ldxb6z42EfTgoohLCOiu4giM0BmbW8jyFLVG6uoXux+3ryoeq7iU9LJlARYjZZV4KRWCKQuruzCeTLlQb/UPdjR1LlcKzK1mQY0me4jixJe82Kz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1wXbGY7ZIJ26vXDxPleGJpm2LC2Ks+3IAe4Lo7zz1g=;
 b=l+CBSQSNmpkZ8tg1lj5/KL11cuC7NHOgg8gZ/BifiYMWbHB1Vu+SiYzoEHLoaBaCsOxHOPU7HprYF7LP/JKLu8PcvfijwADpsZLzZyWglYST+1cDD3zRFLVmskkMcFNCagQGvKP8SX29DeV1NB47K6zODkBvKHtwQpGfZ+Kty9+sa2Y9036eO+fHzlyXFMzAgsEJyhlpG2G9Y9g39xF3KaYL8lp5iVBUWRm2ioJY5zvgiRUGTxDBpGGuLU8QPER7NtM0KrSjytIYbQNxKGxU7oz3rgUlzk0GHkmgdvfE4eeVOAamSNBw37vcgmNXioU6I5CVMMK02f9agWWKy8sDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1wXbGY7ZIJ26vXDxPleGJpm2LC2Ks+3IAe4Lo7zz1g=;
 b=ReXX9WhfSanlszuI7iu6StoyDFKGrQ6Rtf7isYnGQ4kv/KGAc050t9jTeQnsVR0H062jjQdOehRSc1B9jBOdRaUcYEpks/Tx97hUxPtdSMQzmoeWIAbi1GOz9UM7BRoGT7+Ud6T9uTHzVyvUxJmW42rn2igaRJc6ZOcBqoC7ce4AyCFxJVP23jCH0jIpsegPgnqldlKX1NufrjSXMlm/O84wIUoyPKODTJvdupjHRcp5JbAAYQfvW2p6WJAixVnkHSbgSwMxn+PPlV9wyJ84Vr5syARA1xxsZ+i7Ja8iFQ2Nbj8B/hUQvfk8FATWfqqckM/93VmpDdRVT9eewcxzsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB8490.eurprd04.prod.outlook.com (2603:10a6:102:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 03:19:47 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 03:19:46 +0000
Date: Thu, 18 Dec 2025 22:19:35 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be,
	magnus.damm@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us,
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com,
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de,
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 02/35] NTB: epf: Add mwN_offset support and config
 region versioning
Message-ID: <aUTER+i1707eGdqN@lizhi-Precision-Tower-5810>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217151609.3162665-3-den@valinux.co.jp>
X-ClientProxiedBy: PH7P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::35) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 99302d18-5b6f-46f1-3867-08de3ead7647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|19092799006|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LTvtooI8D9Ldi7M8xE274tnZ8mlA7rC4+ILUIMF8ORJ9RxeRKePdIFu4J+Cw?=
 =?us-ascii?Q?+MQAK3FLHIrenBDLu0Uio2ubCCyYMbJZysyl3rm9JDN81zTYea5hqClTzS3t?=
 =?us-ascii?Q?zInjjlTDxDCK02I5hdiNv/uLwvjXESWKJl0ryeVTndP5DXviIxWd+3yz1fxW?=
 =?us-ascii?Q?fUG9IMXy9qa6kQAONjZazUd/S2c90SHp4pCxUB3lbREJbJzSzp0rpvbBoyyF?=
 =?us-ascii?Q?3pSFIQzoLTbyHWPfybyV1HGAd2SA+g0TPJoqev1AH5SjoNl1mzK8du048et8?=
 =?us-ascii?Q?fKNXKTg/5vh9v1jQKTh+Y2UtOvS50ljEH4hE6X75fVumhQE56MVMaWI567nG?=
 =?us-ascii?Q?O+idlJu8pQDqAeUZf10DStdwyXKuVC9e+2LaF/uTff4PakSKsNX0wpn12r7s?=
 =?us-ascii?Q?IQWCTAbMe611sN6sVGul1TB99H2H8a+WL/m94TORBHxwS+xUGsPLYLrjacuY?=
 =?us-ascii?Q?po++/IfW5kxFgXMp/j2iBnNEcN3ArDsZJ+H3qMdoi3BdjNRn018emkRIv+6b?=
 =?us-ascii?Q?75YA6NX4NbrI8qYYtI7rknsA5ekzSByve79QYyKFeUg44LWGfcHqkq2Ob34O?=
 =?us-ascii?Q?c1TyK4uzTD7rQiaMnR4jE7VMOEGb8Pbi1xAy32QcD9HYLgTaoy0ENewuc2qd?=
 =?us-ascii?Q?JMMOUFglmSs8NJszWcsWACAQkdYVL8htfWW8woTGawRCV8ZVD7gMVxWJakM5?=
 =?us-ascii?Q?Whd2wYsPUfCc/O4KSDuIHTTqR1Ev1Jiav1eeAzE05TQL3oNAEO5+dcMHUyiH?=
 =?us-ascii?Q?smbu1qieyhqeGos2tyXBGARtmzAPkYN+nJ2a7h2doYaGC0JYHp1hwjJTwucW?=
 =?us-ascii?Q?yqCyqODVLS9fsZH9QswiM/mdYKy0gMRO4vDRSXTtjBae2r9vDueSvKP0e8iV?=
 =?us-ascii?Q?zA9iC/odMpTyCBC0PSCeBCTwrushEViY8vOCNyY4ub8ArlfftbGVu9/LWghN?=
 =?us-ascii?Q?2yOjf0sSYpXGAFXCqrv2rOS6IrWLbl3s1kV/BynslqGCzWPdeU0pyZwwNf9w?=
 =?us-ascii?Q?Lj5SrOZl9ztziUSt/wSvycSuXQxwjfFi9iL7PMIh06usV6PEqq0rPeRpyAq/?=
 =?us-ascii?Q?B7prJ1gnWkGLltwO8KnddjDm6H3qYK9kCZowf9nz+qLSz5ZVnySlzRxeMkYN?=
 =?us-ascii?Q?yGu5vHzcVWZWbeVpQ4kfjOOwCsBf1lVJwUi+oVftJtLpC2os/rGgF3k0uG7g?=
 =?us-ascii?Q?/3CqXgFQDss+eLDdfWajkxkosbymOeq/G1hum4pGtndKGik/feu/rwr68U7R?=
 =?us-ascii?Q?wm7UduCn3udqNYdHqi7VUiwbx8EGV0gknoTCyRdKwvHj7ZF6HGDjxCPPk4es?=
 =?us-ascii?Q?9CKqrNi1cX8a34l8jnFgAtP7BztCp/0z3glEspUgkLnrBVA3uvM3OvGJgKNJ?=
 =?us-ascii?Q?2ZtXToRF55A01N04v1SJ3udJhxTIyHN7HgkMKEWCQaypYSaHiQAuLmU60him?=
 =?us-ascii?Q?Y2ikcPyBDUxy3ncuTp1vOexWDilgsLVU1HEhdcMb48Ut1uRr+RZI5BrwQu1R?=
 =?us-ascii?Q?AEeT1yTu1RtSEV/Ug3wQVPYntjsTL8/WPH01?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(19092799006)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xqZSwccPi95LSTrPCMwCYBkAwnwskmPPaZwgXdzLJ/hzhNTStyf+E/fkVIA8?=
 =?us-ascii?Q?CYtqVAFYwNhhpT7o+c5aJn7yC1vEBABSPK+ClybZmeKLAghx6O3RNiS71FgT?=
 =?us-ascii?Q?l+WsCpwly8NWOiQALX/fdhRYD5hfvxeZr66/QbyjZC4y6tZyWeK/xILBqPYF?=
 =?us-ascii?Q?d1Kfxan5PzhvWDoW3eNuKccw/S9JCX91rYeM7c+8fNM7vObJX7qL43rxR3nG?=
 =?us-ascii?Q?GFvf0PzS2tU5wUmBgM8GDgN255SQzptdY0MlLHg+g5iKx4CtMkPEaum22CY3?=
 =?us-ascii?Q?LVXP2Ku6T/qHVU81V2yvUABJI37kI3UUINTHzUgwz/0N5na3GV52Dj7dNquj?=
 =?us-ascii?Q?cS1deIq1yqfn8fE2UHI1uWZP7angNCKnnRy9ANrnDD6JnfSsMezp9WMNo355?=
 =?us-ascii?Q?pnTQL8hmQP49FEzpU7FS+3KA82R5N534uhxspk8yGZaVQeMwqj+v2YUfDviG?=
 =?us-ascii?Q?KeB7Ez+CzhSc0ERgSUw1O0nJypC0pmKmO+mKYXs/5RUZg4lYt6YOiVvs/luQ?=
 =?us-ascii?Q?e0mAACP64DI7lFCYTEQPW9rpKnrKwaiQ7X2wVfhzdIzenuIzCc7b6g085Qku?=
 =?us-ascii?Q?xocm6mQOxv8Y8l5JtD/2fs18IZDD+cnZXHILK0mMWGhYaDiM54c252jk54fu?=
 =?us-ascii?Q?GQDpP9cz/2lmwUfUt1EYyAitzx0o4NYYu3DO5K3GUxZ7rysbPRc/RQdH5zeV?=
 =?us-ascii?Q?NkA2NGZwZ2OskXHKOePVDHWd1G0FKoLfhS0uT0anfF3HcL6suy48tt3jbH+a?=
 =?us-ascii?Q?uKkDUVXNXoKH3Rcx2z/sGApqsECDW4sbF0W0b7MidwUenWWlBmjfpmqtj4Yy?=
 =?us-ascii?Q?trhivwkh3U+vV89e9lJ5hNoyntfnUHmX/coeVwwxtg5KjLemrGDnxF2jOGge?=
 =?us-ascii?Q?hv+kZjkz7xZIbAjw5Vx2sgVClIwcAwh0wpiqIH6q/vpJSg3xbQs6TQXUlyIQ?=
 =?us-ascii?Q?oiGtPJTATJUrqJfUmVsvUK0zFzkED+LmrMT44gGGAl8yy9WSd3s/t4QDeJbQ?=
 =?us-ascii?Q?BTFfQf6Ba7mcIEdN9KohihFz/r8nEgEfkFKnkLh1kpF5khPHVGds/mLlAFB/?=
 =?us-ascii?Q?oT2b1ajo9xuusVIFfSGdex44aEEzLABUMhINbA/39joGdnKGVP/mfpsihcaM?=
 =?us-ascii?Q?Y9XLTV3+Iti59klh/ThJiraUYdlEvjR5GgXtKs+YOnBXjDKd/aY1l7rf3Dh3?=
 =?us-ascii?Q?/oeNifcvNJpBtCo46zrZndGWD325SK0mjZB/5evlVPFkrj+C/J4wSJukZ+H9?=
 =?us-ascii?Q?zvkv4hUY5UcLxCht9XigOH3J2E1GpH/Wn4ojlZfZCta25iyD8wgpyuqsPph7?=
 =?us-ascii?Q?17Qg1MV59twNysLH52Vn2Nac4SXYLaazKSzzKW0kAMt6fFBO3TmzHVgLoPye?=
 =?us-ascii?Q?xX8pAkVvhlJVfox5FVsJ1n/JQyeNz8C+6KHt8FivGF/3/YNZXU5iBjSrQ2p3?=
 =?us-ascii?Q?I5ojBpNITQTs17BVJh+zfpEUTKz6C0R8IHMxGpDHkzZzfph3fL/VVyHhmPAZ?=
 =?us-ascii?Q?E1xzQ9Ew6XcVZRp7GBbZz+yb1USOnXkEbA1ixw581P8IyThyfj1mPCbBwrx8?=
 =?us-ascii?Q?qM8tYWUaotGbjnQgVnH2Vz0LeuvpIe2JUuN95vGB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99302d18-5b6f-46f1-3867-08de3ead7647
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 03:19:46.9178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT4ANcx4zpTfzKPOgvNZGdlz4pojRZERlsfrIbEr0zbGKmSJqJE4DZrK8uqNIcNVnajBHZZfw4sTupfipa9Gtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8490

On Thu, Dec 18, 2025 at 12:15:36AM +0900, Koichiro Den wrote:
> Introduce new mwN_offset configfs attributes to specify memory window
> offsets. This enables mapping multiple windows into a single BAR at
> arbitrary offsets, improving layout flexibility.
>
> Extend the control register region and add a 32-bit config version
> field. Reuse NTB_EPF_TOPOLOGY (0x0C), which is currently unused, as the
> version register. The endpoint function driver writes 1
> (NTB_EPF_CTRL_VERSION_V1), and ntb_hw_epf reads it at probe time and
> refuses to bind to unknown versions.
>
> Endpoint running with an older kernel that do not program

Is it zero if EP have not program it?

> NTB_EPF_CTRL_VERSION will be rejected early by host with newer kernel,
> instead of misbehaving at runtime.

If old one is 0, try best to compatible with old version.

Frank
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c               |  44 +++++-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 136 ++++++++++++++++--
>  2 files changed, 160 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index d3ecf25a5162..126ba38e32ea 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -30,18 +30,22 @@
>  #define NTB_EPF_LINK_STATUS	0x0A
>  #define LINK_STATUS_UP		BIT(0)
>
> -#define NTB_EPF_TOPOLOGY	0x0C
> +/* 0x24 (32bit) is unused */
> +#define NTB_EPF_CTRL_VERSION	0x0C
>  #define NTB_EPF_LOWER_ADDR	0x10
>  #define NTB_EPF_UPPER_ADDR	0x14
>  #define NTB_EPF_LOWER_SIZE	0x18
>  #define NTB_EPF_UPPER_SIZE	0x1C
>  #define NTB_EPF_MW_COUNT	0x20
> -#define NTB_EPF_MW1_OFFSET	0x24
>  #define NTB_EPF_SPAD_OFFSET	0x28
>  #define NTB_EPF_SPAD_COUNT	0x2C
>  #define NTB_EPF_DB_ENTRY_SIZE	0x30
>  #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
>  #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
> +#define NTB_EPF_MW_OFFSET(n)	(0x134 + (n) * 4)
> +#define NTB_EPF_MW_SIZE(n)	(0x144 + (n) * 4)
> +
> +#define NTB_EPF_CTRL_VERSION_V1	1
>
>  #define NTB_EPF_MIN_DB_COUNT	3
>  #define NTB_EPF_MAX_DB_COUNT	31
> @@ -451,11 +455,12 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  				    phys_addr_t *base, resource_size_t *size)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> -	u32 offset = 0;
> +	resource_size_t bar_sz;
> +	u32 offset, sz;
>  	int bar;
>
> -	if (idx == 0)
> -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> +	offset = readl(ndev->ctrl_reg + NTB_EPF_MW_OFFSET(idx));
> +	sz = readl(ndev->ctrl_reg + NTB_EPF_MW_SIZE(idx));
>
>  	bar = ntb_epf_mw_to_bar(ndev, idx);
>  	if (bar < 0)
> @@ -464,8 +469,11 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  	if (base)
>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
>
> -	if (size)
> -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> +	if (size) {
> +		bar_sz = pci_resource_len(ndev->ntb.pdev, bar);
> +		*size = sz ? min_t(resource_size_t, sz, bar_sz - offset)
> +			   : (bar_sz > offset ? bar_sz - offset : 0);
> +	}
>
>  	return 0;
>  }
> @@ -547,6 +555,24 @@ static inline void ntb_epf_init_struct(struct ntb_epf_dev *ndev,
>  	ndev->ntb.ops = &ntb_epf_ops;
>  }
>
> +static int ntb_epf_check_version(struct ntb_epf_dev *ndev)
> +{
> +	struct device *dev = ndev->dev;
> +	u32 ver;
> +
> +	ver = readl(ndev->ctrl_reg + NTB_EPF_CTRL_VERSION);
> +
> +	switch (ver) {
> +	case NTB_EPF_CTRL_VERSION_V1:
> +		break;
> +	default:
> +		dev_err(dev, "Unsupported NTB EPF version %u\n", ver);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  {
>  	struct device *dev = ndev->dev;
> @@ -695,6 +721,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  		return ret;
>  	}
>
> +	ret = ntb_epf_check_version(ndev);
> +	if (ret)
> +		return ret;
> +
>  	ret = ntb_epf_init_dev(ndev);
>  	if (ret) {
>  		dev_err(dev, "Failed to init device\n");
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 56aab5d354d6..4dfb3e40dffa 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -39,6 +39,7 @@
>  #include <linux/atomic.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>
> @@ -61,6 +62,7 @@ static struct workqueue_struct *kpcintb_workqueue;
>
>  #define LINK_STATUS_UP			BIT(0)
>
> +#define CTRL_VERSION			1
>  #define SPAD_COUNT			64
>  #define DB_COUNT			4
>  #define NTB_MW_OFFSET			2
> @@ -107,7 +109,7 @@ struct epf_ntb_ctrl {
>  	u32 argument;
>  	u16 command_status;
>  	u16 link_status;
> -	u32 topology;
> +	u32 version;
>  	u64 addr;
>  	u64 size;
>  	u32 num_mws;
> @@ -117,6 +119,8 @@ struct epf_ntb_ctrl {
>  	u32 db_entry_size;
>  	u32 db_data[MAX_DB_COUNT];
>  	u32 db_offset[MAX_DB_COUNT];
> +	u32 mw_offset[MAX_MW];
> +	u32 mw_size[MAX_MW];
>  } __packed;
>
>  struct epf_ntb {
> @@ -128,6 +132,7 @@ struct epf_ntb {
>  	u32 db_count;
>  	u32 spad_count;
>  	u64 mws_size[MAX_MW];
> +	u64 mws_offset[MAX_MW];
>  	atomic64_t db;
>  	u32 vbus_number;
>  	u16 vntb_pid;
> @@ -454,10 +459,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	ntb->reg = base;
>
>  	ctrl = ntb->reg;
> +	ctrl->version = CTRL_VERSION;
>  	ctrl->spad_offset = ctrl_size;
>
>  	ctrl->spad_count = spad_count;
>  	ctrl->num_mws = ntb->num_mws;
> +	memset(ctrl->mw_offset, 0, sizeof(ctrl->mw_offset));
> +	memset(ctrl->mw_size, 0, sizeof(ctrl->mw_size));
>  	ntb->spad_size = spad_size;
>
>  	ctrl->db_entry_size = sizeof(u32);
> @@ -689,15 +697,31 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
>   */
>  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  {
> +	struct device *dev = &ntb->epf->dev;
> +	u64 bar_ends[BAR_5 + 1] = { 0 };
> +	unsigned long bars_used = 0;
> +	enum pci_barno barno;
> +	u64 off, size, end;
>  	int ret = 0;
>  	int i;
> -	u64 size;
> -	enum pci_barno barno;
> -	struct device *dev = &ntb->epf->dev;
>
>  	for (i = 0; i < ntb->num_mws; i++) {
> -		size = ntb->mws_size[i];
>  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> +		off = ntb->mws_offset[i];
> +		size = ntb->mws_size[i];
> +		end = off + size;
> +		if (end > bar_ends[barno])
> +			bar_ends[barno] = end;
> +		bars_used |= BIT(barno);
> +	}
> +
> +	for (barno = BAR_0; barno <= BAR_5; barno++) {
> +		if (!(bars_used & BIT(barno)))
> +			continue;
> +		if (bar_ends[barno] < SZ_4K)
> +			size = SZ_4K;
> +		else
> +			size = roundup_pow_of_two(bar_ends[barno]);
>
>  		ntb->epf->bar[barno].barno = barno;
>  		ntb->epf->bar[barno].size = size;
> @@ -713,8 +737,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  				      &ntb->epf->bar[barno]);
>  		if (ret) {
>  			dev_err(dev, "MW set failed\n");
> -			goto err_alloc_mem;
> +			goto err_set_bar;
>  		}
> +	}
> +
> +	for (i = 0; i < ntb->num_mws; i++) {
> +		size = ntb->mws_size[i];
>
>  		/* Allocate EPC outbound memory windows to vpci vntb device */
>  		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
> @@ -723,19 +751,31 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  		if (!ntb->vpci_mw_addr[i]) {
>  			ret = -ENOMEM;
>  			dev_err(dev, "Failed to allocate source address\n");
> -			goto err_set_bar;
> +			goto err_alloc_mem;
>  		}
>  	}
>
> +	for (i = 0; i < ntb->num_mws; i++) {
> +		ntb->reg->mw_offset[i] = (u32)ntb->mws_offset[i];
> +		ntb->reg->mw_size[i] = (u32)ntb->mws_size[i];
> +	}
> +
>  	return ret;
>
> -err_set_bar:
> -	pci_epc_clear_bar(ntb->epf->epc,
> -			  ntb->epf->func_no,
> -			  ntb->epf->vfunc_no,
> -			  &ntb->epf->bar[barno]);
>  err_alloc_mem:
> -	epf_ntb_mw_bar_clear(ntb, i);
> +	while (--i >= 0)
> +		pci_epc_mem_free_addr(ntb->epf->epc,
> +				      ntb->vpci_mw_phy[i],
> +				      ntb->vpci_mw_addr[i],
> +				      ntb->mws_size[i]);
> +err_set_bar:
> +	while (--barno >= BAR_0)
> +		if (bars_used & BIT(barno))
> +			pci_epc_clear_bar(ntb->epf->epc,
> +					  ntb->epf->func_no,
> +					  ntb->epf->vfunc_no,
> +					  &ntb->epf->bar[barno]);
> +
>  	return ret;
>  }
>
> @@ -1040,6 +1080,60 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>  	return len;							\
>  }
>
> +#define EPF_NTB_MW_OFF_R(_name)						\
> +static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> +				      char *page)			\
> +{									\
> +	struct config_group *group = to_config_group(item);		\
> +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> +	struct device *dev = &ntb->epf->dev;				\
> +	int win_no, idx;						\
> +									\
> +	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
> +		return -EINVAL;						\
> +									\
> +	idx = win_no - 1;						\
> +	if (idx < 0 || idx >= ntb->num_mws) {				\
> +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> +			win_no, ntb->num_mws);				\
> +		return -EINVAL;						\
> +	}								\
> +									\
> +	idx = array_index_nospec(idx, ntb->num_mws);			\
> +	return sprintf(page, "%llu\n", ntb->mws_offset[idx]);		\
> +}
> +
> +#define EPF_NTB_MW_OFF_W(_name)						\
> +static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> +				       const char *page, size_t len)	\
> +{									\
> +	struct config_group *group = to_config_group(item);		\
> +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> +	struct device *dev = &ntb->epf->dev;				\
> +	int win_no, idx;						\
> +	u64 val;							\
> +	int ret;							\
> +									\
> +	ret = kstrtou64(page, 0, &val);					\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
> +		return -EINVAL;						\
> +									\
> +	idx = win_no - 1;						\
> +	if (idx < 0 || idx >= ntb->num_mws) {				\
> +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> +			win_no, ntb->num_mws);				\
> +		return -EINVAL;						\
> +	}								\
> +									\
> +	idx = array_index_nospec(idx, ntb->num_mws);			\
> +	ntb->mws_offset[idx] = val;					\
> +									\
> +	return len;							\
> +}
> +
>  #define EPF_NTB_BAR_R(_name, _id)					\
>  	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
>  					      char *page)		\
> @@ -1110,6 +1204,14 @@ EPF_NTB_MW_R(mw3)
>  EPF_NTB_MW_W(mw3)
>  EPF_NTB_MW_R(mw4)
>  EPF_NTB_MW_W(mw4)
> +EPF_NTB_MW_OFF_R(mw1_offset)
> +EPF_NTB_MW_OFF_W(mw1_offset)
> +EPF_NTB_MW_OFF_R(mw2_offset)
> +EPF_NTB_MW_OFF_W(mw2_offset)
> +EPF_NTB_MW_OFF_R(mw3_offset)
> +EPF_NTB_MW_OFF_W(mw3_offset)
> +EPF_NTB_MW_OFF_R(mw4_offset)
> +EPF_NTB_MW_OFF_W(mw4_offset)
>  EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
>  EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
>  EPF_NTB_BAR_R(db_bar, BAR_DB)
> @@ -1130,6 +1232,10 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
>  CONFIGFS_ATTR(epf_ntb_, mw2);
>  CONFIGFS_ATTR(epf_ntb_, mw3);
>  CONFIGFS_ATTR(epf_ntb_, mw4);
> +CONFIGFS_ATTR(epf_ntb_, mw1_offset);
> +CONFIGFS_ATTR(epf_ntb_, mw2_offset);
> +CONFIGFS_ATTR(epf_ntb_, mw3_offset);
> +CONFIGFS_ATTR(epf_ntb_, mw4_offset);
>  CONFIGFS_ATTR(epf_ntb_, vbus_number);
>  CONFIGFS_ATTR(epf_ntb_, vntb_pid);
>  CONFIGFS_ATTR(epf_ntb_, vntb_vid);
> @@ -1148,6 +1254,10 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
>  	&epf_ntb_attr_mw2,
>  	&epf_ntb_attr_mw3,
>  	&epf_ntb_attr_mw4,
> +	&epf_ntb_attr_mw1_offset,
> +	&epf_ntb_attr_mw2_offset,
> +	&epf_ntb_attr_mw3_offset,
> +	&epf_ntb_attr_mw4_offset,
>  	&epf_ntb_attr_vbus_number,
>  	&epf_ntb_attr_vntb_pid,
>  	&epf_ntb_attr_vntb_vid,
> --
> 2.51.0
>

