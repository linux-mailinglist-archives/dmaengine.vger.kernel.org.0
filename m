Return-Path: <dmaengine+bounces-8430-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KDGNvL8cGmgbAAAu9opvQ
	(envelope-from <dmaengine+bounces-8430-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 17:21:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7E559CFE
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC91568BE31
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6094A5B18;
	Wed, 21 Jan 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RS66Kbty"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26170221DB9;
	Wed, 21 Jan 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009058; cv=fail; b=C5zMz9469wptVlFNgj7YVHJGQnh5cTBSGc0gmk8KPoIWOWgNYVyNuYYqzIFxmE+RPGOEMDyZ9+Upyj5mtlzp860l2bHR6tvYsllMnotXlm4s+Wddf5BVAjIQdWEqtpdLil1Rur1mNqlyKJz9WJ7wPs6FW2CQ/ofgkii4BDysfaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009058; c=relaxed/simple;
	bh=1OgAO6lq441B51rHqFjgWT3NUlyLZveY5qZu6AWiAhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p6m+sNgwrxY2hGxVqg7/xttk2PR2hp09+zUa/xwSKPpeh/EOPOX0ncymMdkxRhfS1Z9FGTR8yyrs5FVreB/9QzLe3wUQFp/MDpr7DgJvPJhnK20S0oikQMwmLuuEuCm7dZvSnbNwQPBT7Fwf77YKntxrhX25ppyYoAy+uvIzoOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RS66Kbty; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq8ZXydGAObKFFZeIJN9n0DMXllQjL5ZfLT0fz/WhAHm+yeQJx8WqQwHst6EH2y/gPkpXcZpz79IqTblRcqlr8MzSpWxSsOrc3KWvTuGOQPpJ/8T8NMuS/v5RbG843KZxToz1UKReETIjluNo3J9J3GgCGqdzTMV2bue42u/Ql65GVtQFr8IdS5Bm9Y2axefcXGlIfv27XEGrKMy44IV27eejwCU6tGlyz/CZoBrm5XvdK7GX6uF+WgZrGt9sIYxePWLaqCXSIHoyLSTEF/i4LL4H4taEfJIYfLLCcVGt1vUNJ4m1yubNknQpWsMaeQADYaD+lZbVuNFAkLhGZde3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GT6ICyEycLultmfqSNN0qm9MZSItpnVp1gcD8f1wCw=;
 b=qWQG+dnlgFiBfDRdWUUc/HsPIm3Rvp2DcfYPhG5Il7vpJJKUm5hR7R/NdDqRueX/z++1cIDgdEtpndlCp+63mdI+9Vb45g7Bdy183U1uFZBDTHHblxADiDEgEHhbKWM/sLQ2IRZL3LiAZXQ5SxyiiI3gsSLHdqQxkXOOV/dTaqrGUK0xvrTUDl3q5v6YBLPvki7tko+ma3XTW2TEMjt0iRDKg7tqPRsYTDvahaQzeVqRYgGJjWGy3jdLueK6B4vEv00zDf64RIgWoQObnTwI9pFs4SulT+y+X/ZqFnJ+n3syd+63G2s+x+/JEd5O52e0sjtkNtLSqEll3HQw+j2JSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GT6ICyEycLultmfqSNN0qm9MZSItpnVp1gcD8f1wCw=;
 b=RS66KbtyeoDBwGLWrrag2BSnRlZ2TTf9VaTiy8+H8A7pFYUl7sjXJKvb18VKdrQGK/c+bh6gWlysoJc7i4570j/JNkvXwOrlCnCueCE+nBJcM/XX61BqyvgEK+3JjfEHvGcXdGtnFJ3RRuL6gyNpyGVnathlH9Fanwvsct2LtGEJM+8npl7y6ZXMtf/VtgrrO8qjduOn2/MqDJM9tTAlDd2trtT/Nhr99H7Ll1Wwr1Q2Of2gTgeDnpkKYKJnTrlqc8jeswLo7PSrMGbHOkI+Xnk1MQ8XvzeoJUj+3DpJ3a+I5gnWiKf3UnFK0GUVr/CAp0BN7+f637MOp+CHJFPIKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DU4PR04MB10982.eurprd04.prod.outlook.com (2603:10a6:10:589::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 15:24:12 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 15:24:12 +0000
Date: Wed, 21 Jan 2026 10:24:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	geert+renesas@glider.be, robh@kernel.org, vkoul@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, iommu@lists.linux.dev,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 05/38] dmaengine: dw-edma: Add a helper to query
 linked-list region
Message-ID: <aXDvkRCZXQ/dPwRd@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-6-den@valinux.co.jp>
 <aW0S60D2uALBXdtQ@lizhi-Precision-Tower-5810>
 <e4y664ylum35wvj4endwprzpp4cvfaggklik5mxvdkgmakuqyj@lgevmhllem72>
 <tuhaxwmmcjfltih7ckfo2l5ltzicnj6zfc5ka3pvqlljn7ldu2@ibo5eo62lndn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tuhaxwmmcjfltih7ckfo2l5ltzicnj6zfc5ka3pvqlljn7ldu2@ibo5eo62lndn>
X-ClientProxiedBy: PH7PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:510:33d::10) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DU4PR04MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 0863f963-9aa0-42a4-f85d-08de59012148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RRQMHWjjRZ6eLGVhgUsbNQVaoLuDa5YsA0ngMD0ZR4U5QLlJ2LaNboPBHbTw?=
 =?us-ascii?Q?OF/KdSgg6M3C7IiHTPvJw6Ix72f1g/PSJj6uFX65OwaCZNejaEfLzgOJFMPu?=
 =?us-ascii?Q?YSR5gdDp85kQnJkkEOAn3F0QopuNZ2FzgP5QYQ7rknmgeovEvagCysodLDkk?=
 =?us-ascii?Q?9a/g4G7SGGoYsPLQKkdibzygzBG6Dm/CT8WfiIfysdkl71hR2mxHM9RI9Thb?=
 =?us-ascii?Q?vSL3ORpR3XNaeS8ebCtbCcRMOtHaCSHfD9tjtBsaMV0YS77VvDbBX5A6bS1S?=
 =?us-ascii?Q?QzpTe8igWUtT/h8iDmprXJGqCRvvRfMBs9hOO/1e4L72OyUlNk++xWuXWMqa?=
 =?us-ascii?Q?vLI6Dhm3oLIDXL/F+ZYLPcfbUzVCUsZS+eH0QAnfj3uJUe8ddJy/jf1Jx2Il?=
 =?us-ascii?Q?STlZZBymMIorwyjkw+pEBqta4X+RVczv78UU/ot/bjORg1ig+GuEY4AyNXsR?=
 =?us-ascii?Q?upHzJBm3T/yAVKHCmB/hoAl+0qsGEujUiTFwqTz8c8tcRv7xtr7R4W5U7PFY?=
 =?us-ascii?Q?LVSeyL+iFxfbhuHYRwca0bYN6vr1PHA3TVIlQFq/IN2PIVdv1NkT8HZvym4V?=
 =?us-ascii?Q?W3csWMY6qHDj9QdQILmZTEqIaK/XwwTp1We8fzO1ROmiUUb9ngDyE6Oj3gfK?=
 =?us-ascii?Q?pwBcxPLu6QZp6gGBQ+n7KSWHqz2iAtqvvG6ymf66B95iEnV4rQIT6EV0JDST?=
 =?us-ascii?Q?pmxVl1JWV0tYBhmdizgaz3OB5sFZa0q2tP3Cn8s9vT1NGI0Gf8qz6A5+xR0d?=
 =?us-ascii?Q?6qY0IqDwzwzD8SGWYMmpPWkm83nnh/HOM4iZR1qJWCqBthmgWQjsnL/sAQBi?=
 =?us-ascii?Q?c8FLZrfXUNZfSiWFhpWO5zubTHmQcAiu0GoU+UayVmKMBpAfqggIKakj7mJF?=
 =?us-ascii?Q?1JdzV/J9MKdPadSkWECqo/88GD/7rSYnUUMCyUYVwT+dz11LhwmFEQplWp4l?=
 =?us-ascii?Q?9pWNCzadaOL9C4hLoqp3stPu8hMYofmy9hRwr0fq+DbFZP8865noUGv3cJo9?=
 =?us-ascii?Q?bLH0OlotCru3DFTihlyiBPqDe/y62gMT7HCdajRwUiJKp2W4IlUpKZ1XIDjr?=
 =?us-ascii?Q?bbKsvO1CFdRiV1eg4AjTsjuLRUohjlns4Du4XpbY6G4K343rXaNpILmR2RPk?=
 =?us-ascii?Q?cnk3fIN/fUZvdEYgnNi+Z8pLFxCC4wMB96PdhnA4TGckw79XW6oVVj5kr/Qn?=
 =?us-ascii?Q?nU8JMs00MMEIh6Gr8NFpPHcSm5E7+PZijinmsMTBj93gCwMfXsNDNhan6tio?=
 =?us-ascii?Q?8Qwqx88Fk2/o1GGXJMzwg3C0xtpbT0H4zjP3ezQOA39ninS5XnpRxSFXRqqg?=
 =?us-ascii?Q?FPKo3kAfjGQNr8sQv/KvB+Fp4U31ruIuBFS7shpflR3W9gusfQTZCyLaqVdx?=
 =?us-ascii?Q?1umcecBmUuVGPKJ7qYMy4h4epytcXVa2wAMDjpQrs/r8X55YgOGsgtrZ/kAL?=
 =?us-ascii?Q?jVP+L6gBA6/4Tjqkf5mjQQrRdHNZdn8dh8SgzG7H6tg2c+z+s4oZpbnAzF91?=
 =?us-ascii?Q?Lg44UY/AceT1WjiHybpua9Yh0wFbEL1STZfLn8ASg54KZYilLGWNaIFxeDrv?=
 =?us-ascii?Q?eds8U45W5RQExWAL0PWiDGea6AETsGy1VkJ7ZmF5aTEiz+lszS7oNUnqP1Zc?=
 =?us-ascii?Q?NrrvUCmaPZ/wA5uSgg2QtzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+SPTKHrU1NBch0tnGzibuOmEefVa39qLNxjImfjhBy/4f2gfNAggWBfVTZbh?=
 =?us-ascii?Q?LNzVpomkqAeFDy3F1ZTXBpq66nxHs8K6fXADGdDWj4Mjwr7vz/NAvjoRjore?=
 =?us-ascii?Q?Ymwp4Qt3mNHzYDu7sqSt3kcBFERGIzC/7pcJwU6KYZARmfl/2VSm7AXt+tgo?=
 =?us-ascii?Q?+S6VCLNp/mvXY1H1cnqT9IfwwaFsGCUmDtM0pQezqb9Nafvtni4VDNfy2skC?=
 =?us-ascii?Q?kmbU53x3bgKmji68ocYznszy+ZgIebkAi/A0qzdrfZEsATfDrqEg9Cc5nXMF?=
 =?us-ascii?Q?h/A6QTG9myV+12vAJhHwLkLPticNGKR1TPmVJLChl7IXcLevcc8Tz/L6Egjy?=
 =?us-ascii?Q?tDrn1LQW/wODEQTEveiTdEnFiU+u+JcoECQzZNRc80rErfHaK7lmuU/QPSqO?=
 =?us-ascii?Q?emQbzeOanmnVwHrBT4Irz+wF2pJFC8OTPAk2izlimnaJtFDLSWUpJkeFEj7Q?=
 =?us-ascii?Q?Re35eeX7WVpYlUUCUtIYl+1PUj07Gegetk3Ch8w8/azyBu4b62Nmp4Gj4zyv?=
 =?us-ascii?Q?Xkb1cHqxAeI4Rv+T0hS83Z6aj4ny4PJGN3I+iIvVmsc32Vfkeo+zg2ywI+tU?=
 =?us-ascii?Q?sucSz0wr4lxnHJ/yxtkc7mP81rhARqeOTkaJBQI2T4VoIgWjFWSZ5DFuxEew?=
 =?us-ascii?Q?5VGTKBw7tR/aRKtA8ujylpeeotujmj35/kwo7z0YtJXVB76u91k/7pQx2TmA?=
 =?us-ascii?Q?yt9Uv4UKTYp9vVSkVLN4gT8CBsd8cW5ZhZMnfoj2gC1QuD1ls9gtE6H/B0wi?=
 =?us-ascii?Q?aYxKnZpdt1f+FThWd+bit+szMyl183MiTkDueds+k+4fIBDKr0keN719nI16?=
 =?us-ascii?Q?lTkiN2qA7vkE1toOc7xKv6idZRop501rfJ10eP9TXhwiZPi00Vk5S7wbTBmo?=
 =?us-ascii?Q?KgAa/XUVtK5k8mCIOnN5rAzxoCNWqA3WO6arL+/N3Q8Mz4ERtrKouDS6ajX0?=
 =?us-ascii?Q?e+OnGjclMkgq4bQaqbKmnAIf7T3FnwtzU7FSz25CTo3JfV1LBRDsUkYvilLI?=
 =?us-ascii?Q?SLqT2tM6oH2LmavfL/UwWMgFfXDjiCJE099qMiwnCYgkZvgr42/Hzul8vzW0?=
 =?us-ascii?Q?FgAM9giVlojofUAzwr9iDOoGPJrMBuUu5hDw8f27WVPkN9vu5rUc/O5D8XZU?=
 =?us-ascii?Q?wRTnRu1pC6yfIFAjL38TKev2ukgjFbJQYSZTP1bPUWHndv8T7O7/ucHWUXtz?=
 =?us-ascii?Q?b07lwmhjF6Ydg553AOKs2gIbBXHJU/IBgqZP6H8iL/aljxNe+7+EMtxXB2rt?=
 =?us-ascii?Q?GvyC0iZ5kLeAq39rz9ztIRh5OGY+Bj3Ww/C2gzPoYhI4b2jvbyHKOEBg1o+S?=
 =?us-ascii?Q?IO0ii9WSOJLnqsdBXwoNkqW02i6Yxk18T7pLjOyYVrdNg/iJKvAMEVOI3fGT?=
 =?us-ascii?Q?Yl9KHuGnLNZEcdDyyDlSbf/nnZqNBRG6klf1YzKw68+Q3AnTcM9E2uGJtXq2?=
 =?us-ascii?Q?yKzi6CzD2s3KOIUHGOKX7aDfQSev0KgxoTiZpRGvLn1zzLvTqPvYJ2hFWRqo?=
 =?us-ascii?Q?BHzhbqvhyXSNF8dtGj6MCtWq6YsmvkfQvfSZIQ8I4sBtcHpwvRsBfgCQoew1?=
 =?us-ascii?Q?1F0IA3+KSpAYh6NVdmy8FWmyFPU188NUvSHducJKo1s6Qbmq1b8KlUBrz0Da?=
 =?us-ascii?Q?iCiQS1n8iI4Q4ZyUI/LVHxYT7PidMqkoGpCb7CMkc6UjP5VUYJOuZPObLSXf?=
 =?us-ascii?Q?4DNBAutwSPFXMm5r0cJoV7a6tsyfGvDFNdt83SbUTzOW+aoX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0863f963-9aa0-42a4-f85d-08de59012148
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:24:12.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Supy9cjjClTy+5FueGwvGWWk1jcd2BcU4dwI5g4O+69xCEhaTG5GQcxOuHCwRnMXh+zblKq9gKPd+NborIj1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10982
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8430-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nxp.com:dkim,synopsys.com:email,valinux.co.jp:email]
X-Rspamd-Queue-Id: 7F7E559CFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 05:41:11PM +0900, Koichiro Den wrote:
> On Wed, Jan 21, 2026 at 10:38:53AM +0900, Koichiro Den wrote:
> > On Sun, Jan 18, 2026 at 12:05:47PM -0500, Frank Li wrote:
> > > On Sun, Jan 18, 2026 at 10:54:07PM +0900, Koichiro Den wrote:
> > > > A remote eDMA provider may need to expose the linked-list (LL) memory
> > > > region that was configured by platform glue (typically at boot), so the
> > > > peer (host) can map it and operate the remote view of the controller.
> > > >
> > > > Export dw_edma_chan_get_ll_region() to return the LL region associated
> > > > with a given dma_chan.
> > >
> > > This informaiton passed from dwc epc driver. Is it possible to get it from
> > > EPC driver.
> >
> > That makes sense, from an API cleanness perspective, thanks.
> > I'll add a helper function dw_pcie_edma_get_ll_region() in
> > drivers/pci/controller/dwc/pcie-designware.c, instead of the current
> > dw_edma_chan_get_ll_region() in dw-edma-core.c.
>
> Hi Frank,
>
> I looked into exposing LL regions from the EPC driver side, but the key
> issue is channel identification under possibly concurrent dmaengine users.
> In practice, the only stable handle a consumer has is a pointer to struct
> dma_chan, and the only reliable way to map that to the eDMA hardware
> channel is via dw_edma_chan->id.

If possible, I suggest change to one page pre-channel. So there are a fixed
ll mapping.

> I think an EPC-facing API would still need
> that mapping in any case, so keeping the helper in dw-edma seems simpler
> and more robust.
> If you have another idea, I'd appreciate your insights.

I suggest add generally DMA engine API to get such property, some likes
a kind ioctrl \ dma_get_config().

Frank

>
> Regards,
> Koichiro
>
> >
> > Thanks for the review,
> > Koichiro
> >
> > >
> > > Frank
> > > >
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-core.c | 26 ++++++++++++++++++++++++++
> > > >  include/linux/dma/edma.h           | 14 ++++++++++++++
> > > >  2 files changed, 40 insertions(+)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index 0eb8fc1dcc34..c4fb66a9b5f5 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -1209,6 +1209,32 @@ int dw_edma_chan_register_notify(struct dma_chan *dchan,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
> > > >
> > > > +int dw_edma_chan_get_ll_region(struct dma_chan *dchan,
> > > > +			       struct dw_edma_region *region)
> > > > +{
> > > > +	struct dw_edma_chip *chip;
> > > > +	struct dw_edma_chan *chan;
> > > > +
> > > > +	if (!dchan || !region || !dchan->device)
> > > > +		return -ENODEV;
> > > > +
> > > > +	chan = dchan2dw_edma_chan(dchan);
> > > > +	if (!chan)
> > > > +		return -ENODEV;
> > > > +
> > > > +	chip = chan->dw->chip;
> > > > +	if (!(chip->flags & DW_EDMA_CHIP_LOCAL))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (chan->dir == EDMA_DIR_WRITE)
> > > > +		*region = chip->ll_region_wr[chan->id];
> > > > +	else
> > > > +		*region = chip->ll_region_rd[chan->id];
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_edma_chan_get_ll_region);
> > > > +
> > > >  MODULE_LICENSE("GPL v2");
> > > >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> > > >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > index 3c538246de07..c9ec426e27ec 100644
> > > > --- a/include/linux/dma/edma.h
> > > > +++ b/include/linux/dma/edma.h
> > > > @@ -153,6 +153,14 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> > > >  int dw_edma_chan_register_notify(struct dma_chan *chan,
> > > >  				 void (*cb)(struct dma_chan *chan, void *user),
> > > >  				 void *user);
> > > > +
> > > > +/**
> > > > + * dw_edma_chan_get_ll_region - get linked list (LL) memory for a dma_chan
> > > > + * @chan: the target DMA channel
> > > > + * @region: output parameter returning the corresponding LL region
> > > > + */
> > > > +int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > > > +			       struct dw_edma_region *region);
> > > >  #else
> > > >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> > > >  {
> > > > @@ -182,6 +190,12 @@ static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
> > > >  {
> > > >  	return -ENODEV;
> > > >  }
> > > > +
> > > > +static inline int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > > > +					     struct dw_edma_region *region)
> > > > +{
> > > > +	return -EINVAL;
> > > > +}
> > > >  #endif /* CONFIG_DW_EDMA */
> > > >
> > > >  struct pci_epc;
> > > > --
> > > > 2.51.0
> > > >

