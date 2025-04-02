Return-Path: <dmaengine+bounces-4798-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35320A7901C
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D550C3B01A1
	for <lists+dmaengine@lfdr.de>; Wed,  2 Apr 2025 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460223957D;
	Wed,  2 Apr 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dJZpduz2"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB11DA5F
	for <dmaengine@vger.kernel.org>; Wed,  2 Apr 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601338; cv=fail; b=o272NpZHzjcHzB1Kf2a9upwQP4s8HgDmUc5bXT52q09oTUu9BtQg+g6LeVg3X42EC8YxDY11J0LTpDrHym+ZAaHSl6LIuqQyirNYeauh/ryrXRbvVJxdqote9VrtSnFtnFb1VHsZrW3dRmmpBmohMptWcwN9nS+ovTUkjgXbR6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601338; c=relaxed/simple;
	bh=QKO1IAk5x3xNKuZOU6y5xIrCZXBMwImqPsfRC0WPrQo=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cBmKqThj8HyZOGem880Adi16cWfT2ydG97JmpO3jhCmNMIUSdf5EeQVY7k+jyV4UgjxEOVEWYZG7bLs9PFhB+Z5ps0991COAU0fZfd0HhZTXaTH01CetDU2s17CLHzqYk5CRwhJSDxMDe8r18xx2/iZGO7yR55cdVdj/dOcQRH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dJZpduz2; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IixUpBUYbuuXSNaI4IitzdwBIga1kp78FVPOxFOaOV7dTY2Eh14nwkJ6R5fRJA/JR/LE4DJi/tz4668VdXzyP4hNtQj5SrXLFVa8bq9jmyVGg9Pz5rRbBo5opaw6VxIlAuvwslSzPU8gXEsJ6w0FhoZ2ziBVadq3i28phtItsYc7yO4xo3HeuBDz0ffuLxmU5CWmlP4nCgRkIhbFFWByod1MV7V7IwioGBE824zOZyWSgjjTBlyP9kg9J4fG6rOrASxq5s23btvsULFGAN13mvYOYnk+Ik8ibSgTPLZfNTuxd5Wf0z010hiPyUBZViT3VmevLC8FZXxwuNHcHtKo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghTFBOlQg3p1SB2dsYIQocXUGECUCk6OINvZuh4UDVE=;
 b=Nbk5zxKpUkroTzbUiS99Eu2l/kDUueIkwwN+/DXcP1/6+okzVRZUH1pqcVMzMLCYAo9+fl9B9Xt3uj5EdwiMAlFpC/22Tx+7qGnnUz+yZdw0vtOkp1RlPE4TGD1KXmPZLPVGHiSk/oDzrM1G7qGV8S2MSstsfPgBMlUgYVmRaqZVKjE1LqVoWDcJF4d4/qQAPEtKpRm8sxM5ukq97jVrc49HcsDDH4Py0JHT71+M/QoSFNcPZpLmZJ4JnByWP9g+KD2z4dXLO6Nlr4GbYACcAJ5WuQVGFVhPEvYiqNRuG898JxEG5OfPo6K7MuEkS3EMl+mHm2TojS2d7GO4WcqsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghTFBOlQg3p1SB2dsYIQocXUGECUCk6OINvZuh4UDVE=;
 b=dJZpduz24zqzcZyt9tJrfOvlDi1O2mzPCUM6KMEgKZJOVt0C7wloHRC2141ReDzW9YJv9fva/pMq8O4KWcDpX9p02GPgMn5KAal+6wcFTkS0XX/WJHvN7TfY/lad1A868Wu7f7Aa4EWc9PdpJwfnhYaPiC1vhVcqP0Uwl6Mjwbs=
Received: from BN9PR03CA0933.namprd03.prod.outlook.com (2603:10b6:408:108::8)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 13:42:12 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:108:cafe::cd) by BN9PR03CA0933.outlook.office365.com
 (2603:10b6:408:108::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.42 via Frontend Transport; Wed,
 2 Apr 2025 13:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 13:42:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 08:42:11 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>, Vinod Koul
	<vkoul@kernel.org>, <dmaengine@vger.kernel.org>, Alexander Shiyan
	<eagle.alexander923@gmail.com>
Subject: Re: [PATCH] dmaengine: at_xdmac: Fixed printk format specifier when
 printing driver information.
In-Reply-To: <20250328105654.143676-1-eagle.alexander923@gmail.com>
References: <20250328105654.143676-1-eagle.alexander923@gmail.com>
Date: Wed, 2 Apr 2025 08:42:09 -0500
Message-ID: <87a58y8ytq.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: ee62c34a-b2b8-4949-72a4-08dd71ec2c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l5k8Tc7CJuz9k30GKj7NZc7jnQa2IScMPu+5vm+tjcfm6l3hFq6wIFh5kFTx?=
 =?us-ascii?Q?tmRaacTouEizOgfw+t3aun/3bZahynngzH3fDYXDQ7w1N9m7muCayyyLloxM?=
 =?us-ascii?Q?2vMVBDcwsThkHtXn1yElCKLVrovBq9c/cnCreSR9xDnfjPiUSY9jCAiZ6uks?=
 =?us-ascii?Q?XBVrg1agaL9B48M5TD9H60QAfVOgndnDMnqWJ/W66GYSXsmVHuqRGpEGep3t?=
 =?us-ascii?Q?zcsyPOzaAWTfs/esiiEaKUNZitQtp7bfE9RsI3FCNpMXwnamCVGF7fM+K669?=
 =?us-ascii?Q?R6Aplx2lKJDTeyOMhn9Wo7mXucI/XvyZxygk4SXBWDyfv5hoCEAh/NMaE1M5?=
 =?us-ascii?Q?E/N589OaXo5lnKdZRBJmVYgY3b7Fbov9gOptPf2zpr62UwBQT0CVVpPeuO+q?=
 =?us-ascii?Q?Hikc64rZj3zy5qeetLoiD6KRAzhaR0bpVA4k6D6KK4bQnGfgbka5lY5CMFVZ?=
 =?us-ascii?Q?5j3FXX0QSqnKEb0QDwbtp0QaHuHO3LPAmKAmrM1x0VpTlTYSq/LXtKArfoon?=
 =?us-ascii?Q?Gx0/oISFKrXA6oWuZEAmPf7G8+ibsi19FpOAk3/Rtjsb4dlQiyCa57YEeO91?=
 =?us-ascii?Q?eA287G3UU4+iG5PNlTM2zD1zZKK4EM5KO81+vvEcMwLptQVi6tGwgKTuZi0/?=
 =?us-ascii?Q?hNuiVtTN44YBM872+zNw3jtFY126VdKsSl6lS3hqLPZFNWa1icdUZpFuNqli?=
 =?us-ascii?Q?7Cw/BynbsXnXFIYAV9iTJDjImI+A+oaVCOxvwdT8r5efVt6gS6Ngz7TErtwl?=
 =?us-ascii?Q?Ec2MX0pnk6a9yBa+EngBbnVCTPDytTIFuvAvDQ3VShCFtaDGQdhJZpfi7+Jd?=
 =?us-ascii?Q?1iUn+obSBmRnIwSmkCRPC1XUWjkH47GPzAcoE6CxTMxFmFio04GWnWY5Fgw0?=
 =?us-ascii?Q?B1RUxnC8obI2i++Oy+bLH33P10u2T3BAjZRrR5IbvYVOceX1CTnwOfUst7aa?=
 =?us-ascii?Q?6J13oKdRunY5oHSOHHMiNbiJxScUxqjPouW9+itGs4ejx/KO4iH68zjxOUUS?=
 =?us-ascii?Q?4tzzndWwNFQOn40Itn7GBDtAbVuSEpjY8tgWA+rBAJdldUizf/MQvsaHfQtt?=
 =?us-ascii?Q?oy2/UIYuHwwukKPnjnOqHGe3CJccpRdOMYC3gD5/u6x0qG1S2WQH+LJAGcFs?=
 =?us-ascii?Q?7LKLU8y4zYx8771Vo60KWtUvIwvZcqmLvZjZ0RDnQdpBYR1+t/HOiFOVKmLn?=
 =?us-ascii?Q?7yyeYJOLivGcJdEAA27vYYnNq5Ew/MdxcpRELsa0OMmfBYrbYJhYBuMU6fOf?=
 =?us-ascii?Q?IrsTLIlD6TslbN0dieyk39sITGKoivr3/TxxUtLftKNpCms8dzg9kdcir8oQ?=
 =?us-ascii?Q?+0H+qHO4vdJx9+WyA4eRgsBwlLr9MArbQBeEGxnuEEgnC7TofU9nj7Jic4fh?=
 =?us-ascii?Q?FwjPD9hmCB0hOUHWQNfKughpjfvcgj/O1kQaabu8YWcNeI2/m2wQqnRTbcHK?=
 =?us-ascii?Q?gNlT++WqSSevIYFexO6T3ualI0klDFDq4+7TfORmrkHtYxezApAJLJ5BeJyT?=
 =?us-ascii?Q?TejgclvvutE8B6M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:42:12.3431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee62c34a-b2b8-4949-72a4-08dd71ec2c2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

Hi Alexander,

Alexander Shiyan <eagle.alexander923@gmail.com> writes:
> Use the correct printk specifier to print the address, otherwise
> you get weird information:
> at_xdmac f0010000.dma-controller: 16 channels, mapped at 0x(ptrval)
> at_xdmac f0004000.dma-controller: 16 channels, mapped at 0x(ptrval)
>
> After the change, the information looks much more informative:
> at_xdmac f0010000.dma-controller: 16 channels, mapped at 0xc8892000
> at_xdmac f0004000.dma-controller: 16 channels, mapped at 0xc8894000
>
...
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -2409,7 +2409,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
>  		goto err_dma_unregister;
>  	}
>  
> -	dev_info(&pdev->dev, "%d channels, mapped at 0x%p\n",
> +	dev_info(&pdev->dev, "%d channels, mapped at 0x%px\n",
>  		 nr_channels, atxdmac->regs);

dev_info (i.e. printk) obfuscates kernel pointers by design. This change
would defeat that.

Please refer to the discussion of pointers in
Documentation/core-api/printk-formats.rst for an explanation of the
"(ptrval)" behavior and whether it's appropriate to use %px here:

  Before using %px, consider if using %p is sufficient together with
  enabling the 'no_hash_pointers' kernel parameter during debugging
  sessions.

As well as related discussion in Documentation/process/deprecated.rst:

  %p format specifier
  -------------------
  Traditionally, using "%p" in format strings would lead to regular address
  exposure flaws in dmesg, proc, sysfs, etc. Instead of leaving these to
  be exploitable, all "%p" uses in the kernel are being printed as a hashed
  value, rendering them unusable for addressing. New uses of "%p" should not
  be added to the kernel. For text addresses, using "%pS" is likely better,
  as it produces the more useful symbol name instead. For nearly everything
  else, just do not add "%p" at all.

