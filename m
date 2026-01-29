Return-Path: <dmaengine+bounces-8588-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHtPF4fhe2lyJAIAu9opvQ
	(envelope-from <dmaengine+bounces-8588-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 23:39:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BACE9B56FC
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 23:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 048D2300B126
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A40C366837;
	Thu, 29 Jan 2026 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cCt6WlPJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF5287263;
	Thu, 29 Jan 2026 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726181; cv=fail; b=Td6F2P/Y0Igt75oV2rXJlhtemcw7u2z2o8LESrd5UrQD25uFhHkd0nzC+QRwKLrquBvuLfF6P5qBaGeP1oZhitqImNwTyvpOUnoEI2bHFXBB147GOeFof2XyTv/ngQiRvPdlDR+D+mMpkI2BeeLXtr/hUtW57uPpKK4BOnOux4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726181; c=relaxed/simple;
	bh=RUzTGio5pBn4zzqMItSthJGkUZdzzuTFThnDmm5at5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGhelblqYmOB5w4ds2PVrazQs2YE6EIgkOvXEN3A+FnW4VDEj6tVXznhkKvQWExau9D+eKe4JhnZxS173kNaJgjlCgq74RFVgSu9sqmm45kaA4aZxA3atbGswDTNTx8JwZxNO0Exy0A3B29de/pTKsNvl9oAa5S/3RhjJAUC4wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cCt6WlPJ; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swnS9qBy1XZGlYU+KHRdoKrGWKLAYYzBDbK8cW/F8qNlTcmGkzYUZnItp97TPZ2jMqvviS9jyKLUpDiwjwxuUAoe23NjkeThlVIgQGTX0uoqkx6ZscmAqfN6Aw5L35QU9aRrKdZwfTkvEu/QgJHXoGLa6AdcgygAO9FFQ64CJ+yLxarm4UE4rjaW4nmQ7N/QZ3wVEwFy1TVdvaJGJsau3hWzKdWTK+r9UeHB9+zNB2oOblrYdDvFD9O1VVP4c7YEkRJZx9K/k6ZUH8Wft2Oqje9pspfIpgMP3O6dvwOdQUkWAbvT3Bb/xsulm1ZEgltavBXQYrSkRogG08mUJZ5Mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t8o8I5TXpexSD0I9UNxOAtB05Yy5/zMpVNSR28SPIk=;
 b=nR2rvwYbVkdMZhM8rgFGUq/zAawdHL77NiqyDwlRGhXlLLO8y7vqGvKLV0lsd04Az0Yi4PMcmZnxYXgYhHnMwM3H12ycpy9kW9JGc+nmes2xvFDFQGecQT/0g4pemX6fU8NIh5A2aNV/4nAYWqyWBskL5mhxe8RfPDkmLqEyJHgdz7H3BXmrZ3jS+FMYiELH4BzhAxUKeaPSEt+HC9xDlwTEj4IPOkX7lJ4XfzNcQLnYOw63OzlEwq5yKciIcFzN5mOrn0ENIZb/2NaVXlThbC+pGeOAzh8LGrM5x84z1qbqixqdTNg/cMEyZ+gp3voC+aDcyKWH4mmhIkJply4+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t8o8I5TXpexSD0I9UNxOAtB05Yy5/zMpVNSR28SPIk=;
 b=cCt6WlPJHmjI2l378DQO+EmaG+aQpHA6rYPymbRI73siVoD7O2IQhTnEXEGkvTU3ZWT7YfoU529t87ODOKrXX5bhpxfCslxkRYGK9Z3jeaOsIvVgcDKZAS5owN4BSBxDvJL8NAKXH7UyXCF3GRNXwywwd6SCVkq9gm3QE3mTn01pYtRCaytTlTvjmS18OzYIAB+Q4oPpDHSRHj+0cTJxRPK019mEZXh6vxp3llEAib8Z0nPV5HcMBjbT7gfjLVFajd0jz2suagHfII68lJ+oyq8xban4xNDMayLTdlvTF0tDiffFb1VvHXVvBsH12zOiMj2+tPQVrTXuAeKIk7JCzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by PA1PR04MB10676.eurprd04.prod.outlook.com (2603:10a6:102:48b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 22:36:15 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%5]) with mapi id 15.20.9520.010; Thu, 29 Jan 2026
 22:36:15 +0000
Date: Thu, 29 Jan 2026 17:36:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Longbin Li <looong.bin@gmail.com>, Ze Huang <huangze@whut.edu.cn>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v3 2/3] dmaengine: dw-axi-dmac: Add support for CV1800B
 DMA
Message-ID: <aXvg064x6gYcCHRD@lizhi-Precision-Tower-5810>
References: <20260120013706.436742-1-inochiama@gmail.com>
 <20260120013706.436742-3-inochiama@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120013706.436742-3-inochiama@gmail.com>
X-ClientProxiedBy: PH7PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:510:339::16) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|PA1PR04MB10676:EE_
X-MS-Office365-Filtering-Correlation-Id: 088aa81a-15be-4050-dbe9-08de5f86cfdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7HSAEP9nUfzOdQ5p9cpdBJyrwD2wTEfWf9CWvzBuxsa6e3TV8vTCUu80UW91?=
 =?us-ascii?Q?/XlleaLaxyUYgMIafp6Z0ddZMT19G1mU5JQUD499wogs4gM/J8GTAtw4rd0k?=
 =?us-ascii?Q?/CcWowXGSZBEZy1vM1dmAEkgxHQV9CNl+sR6f5mN2CbhrlQqf5b2XCcUdxRU?=
 =?us-ascii?Q?lDheft/5hTHSzf5bMJnTFgk/nOj219Yy0WvxwPMPbfPFdMQbEsGL796eS0r5?=
 =?us-ascii?Q?V+1Xf8r4N4xiddMEUHgQm7/FDwpdGAZ+zuUfW6HRgVxf/XqTx9sJiSIyT6m5?=
 =?us-ascii?Q?3scMFGr+O/Cv1vGfW6mi0ZibPnMfhTaApsk5aSFv6zAb6ZW4gxbrlhBQHWyZ?=
 =?us-ascii?Q?kxyXSCx6IXt0z3lRpjhw7X/IVDTtUN/wpEQXEGeOuAGM5QwYr5ClO8E7qz/d?=
 =?us-ascii?Q?xxiwJ3bNFEu3tJTVHeH1HItnFqTW8Upo5yHV12hg5jUy8uMWUmmzqydXQ9iM?=
 =?us-ascii?Q?TKG0jOATYlEVn2ZvNnA9BZqfnX6gNCObVjUg8eaHRHc2JUxtmI9DVYBi/GYO?=
 =?us-ascii?Q?mgiLDMUrBBx6B/xaJsWI9EtlZtri2pxyMGNj4sONI7tJv0JBWLd1GbCP3ABS?=
 =?us-ascii?Q?uQ0G1Lr/jYktsn2PPI0ksqRpGDjYbsBdbq9zR0HyqWqWcDIHKiZyVIFFbnD0?=
 =?us-ascii?Q?b0SOlkHhpVyg5tYPG8yg1AgtMBAAxO4g5RWRjXqGzXr6JpxNErE66R5JNqxF?=
 =?us-ascii?Q?o6RJaPjrDxDHrKK/L1DezmbvyiueyiYLIT9iiLwjlpMLOKpuSwPWZZ7Hgzk4?=
 =?us-ascii?Q?DyrxbPJiW0cX2ISuZJLBpS+NX3qoTh6+ifO8ZLtYS1PSqzxAFjJ6hflZ+2o0?=
 =?us-ascii?Q?vOBeVj8+CHh+wP61A/swr6TTZ8yhWq+K28c3BywzBC+xYvP+L2WG4uS3ky6D?=
 =?us-ascii?Q?GbAUtJ4Nib/ofvblb02gwAcIBTKQs96NHlcHrYN7jk9S1wH547CG2BosUgMT?=
 =?us-ascii?Q?XEqI6F0/fG/rx+gdjPd5YPzJFWgD/Cd9R+xtX49uPOI4yAf9Cc0/8x2GDXyp?=
 =?us-ascii?Q?pt/yxI0otu96Rl/qNf3D5YJQAB6tgkBWTYvVoTx/jKOe4zuiiXmQCI9WsAqJ?=
 =?us-ascii?Q?Wd8Anau62d248vF54IrRYHg9q3+iGuE4ayj+RnnU7KMNHwYsOcOTtfdxx4d8?=
 =?us-ascii?Q?QIRnNV3/DnKvafiz7ljJglqrCGjMtxET0rhz6BA+LtrUGFyJaj8X4O48F15T?=
 =?us-ascii?Q?q+5URqRgG9Ubi7hrTyElVS2SS7NHNa325P/hCWX5UlM7X3Gki7jkSVf323LP?=
 =?us-ascii?Q?4a2AOoZwA6+5YNFOAJl1q6MWR7UKOE23s6TmhQXL0ZjIIgXXiw8sM971uluj?=
 =?us-ascii?Q?ldufST0fF++A6/TqKXKofTTAxW8VeX4FK1okNqs2gT8SChniW1sErNmNemtx?=
 =?us-ascii?Q?ouBI/NaJrd3gKsh8lriB5pUurZgpDrI+Ihm4/wjds792mTRbSxRDbo84ua7f?=
 =?us-ascii?Q?kE1whIgqUSYLgB8Y/HH+WdrZDTWBKr87iIVl0M2+UqR7fNUWsuwOFE0xSPzc?=
 =?us-ascii?Q?sk0GD/5sRLum9FkIaMgY18j6ZC0Kf54rcNCtnDKEo6/xIlDbAOlwlarD5NHq?=
 =?us-ascii?Q?Ne1PjtatUqymlVCKTuQBkD87083avzjRxfGuMbuO2nuRI4ydNBdMVbNGPgp8?=
 =?us-ascii?Q?F+Rba7E4lYZRirReOeta+K4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Us5kQ30iPPbp1mrUFsl2w9t+n37fK2RLfiPmkefubqMdbDlp2+3hwrTEHY1?=
 =?us-ascii?Q?OQymXYrliWHkTqheWI98GJEtYWRJT6DG+kbkVCD7cJDV+jv8mKfMmn0kmWbW?=
 =?us-ascii?Q?g/cL4yrOHORWSOYl/W4qhHz2GsZvOW6S2dk5BSOCH6NyNOm371B5AkfDgNYX?=
 =?us-ascii?Q?GqOdqu2BHzG8Ze+ODoGu3H0TPQL5oW5F6Yv6wfAlzcULMlinzT+TlpEIF/oC?=
 =?us-ascii?Q?Q81KUR4b0NUHjLUX63Aj3KNFG+JPFweUe/3MF4bR09+Ny0sMqoZeSlHm8jc5?=
 =?us-ascii?Q?v4EoD8tYqBTM8BI11RbU24Foq7/kvP0FD+dO8RJugDQAGKMGejNxIav/ShlH?=
 =?us-ascii?Q?EAsKDtVsQgl6dt72mfAskKraIiI41jlDTtwH+9eMX0X9jcWIMTJD3Av8RCnp?=
 =?us-ascii?Q?Cm63JtRVfkNjK72zMVgFgnSvhD47geQe25CKaX9P3bmW4ax8se0O5yWDWwnA?=
 =?us-ascii?Q?rS4UIuJ0m12G3gq2XYC1+uqiNleGO9/h+EgZNyJckotsXVbrkWIiA69WLhuh?=
 =?us-ascii?Q?DB/JOBjdXg5a6W21slsdPJCKnlTrcMb2t6wfErFbzoA+ezdIXYXnOrJuDDae?=
 =?us-ascii?Q?nbYJinSg6MdK0v9vvrV9bGY6zbNvSlWl0nrO9vQdLg82wL0hzs3V1O7MaDFj?=
 =?us-ascii?Q?y3glRi0DX2UgJWqLseVgFNILb/rJYXUyDnd8q8ENrZR8Xfymom43vdIPcKjs?=
 =?us-ascii?Q?YMQvY2516C6zbghG0+4x/lfwiTXD0y2MKB+V6qRbghC1pjXBCVhHQiptMIov?=
 =?us-ascii?Q?SSbima+QZ5On4X7SDYomjmoabnqF8dcBFus10l5pQ6GVBOrQtre82F8oseXz?=
 =?us-ascii?Q?+84tsiCY0UmUUbzhL1JTSG0rAf1k5ZJDzzj457d3MhTwVSK0mAb+2tkKN9nI?=
 =?us-ascii?Q?rofw02TOykYowi/nDhuSmhv8OMYjKWvj0W3GV8L37Sz1GRzdJXG6agoB6fq9?=
 =?us-ascii?Q?++2k0/SkILNCdzAzbNLDu6TwibcGGWsf0S+6SSt3fId2wFnxmiH2sK9KjKmn?=
 =?us-ascii?Q?fBePnawJEaHe2Tx7GMdkkjLQ9SJdL99ZVNzghM12EVxR2XTMgpW12BZlTq9J?=
 =?us-ascii?Q?MR7Fjl5Q76or5Xm0EWx9r+tCdtHSlYIxmgp3D0pAUI2aYKPyqdnk1SYY+/2s?=
 =?us-ascii?Q?OU6+mpCdBxqTkchDD97sw6ZJdhDKpC+mNC1NYyi9uQlnfCZnX0hbjaqod2V4?=
 =?us-ascii?Q?H0+noUgELmwWHvhNffBz7gm6JADOWPWcGTcUR3y/1sEocK1ix3nfj02aq7t+?=
 =?us-ascii?Q?Ykv3f9qEOEQFkUJL0lCP3Cd4/yjD7xlR8qHq5xCaTFt6JH0ZmdWPXUJ3XoUh?=
 =?us-ascii?Q?jfrXK3DqABgnFMs/3DZvVsSuJEsMLMjaSVWWBNv1DW7H6cUp8vcl4rhSZeaV?=
 =?us-ascii?Q?A6FWKxReD7CaQGw4Fee+kTo0JfaNwuvf8HHjm2a5E2s0Tfqq0uRh5JSqnClC?=
 =?us-ascii?Q?ju93zI+C/h65Rg1HRrchBYcIsXpWk68upAzjqFvou2x4ooTNAwMVrt21D5bv?=
 =?us-ascii?Q?bomktfhRQjBjM0q+HGHslfR3hS/QVxGYBzmk3QjmXUYCOM1i/cLjTYEyMulp?=
 =?us-ascii?Q?ICBH84z+bRDee7/c417R51AhTigisKVlmM9f50VpvLwvWDdLxeNBVzrJ5Mq6?=
 =?us-ascii?Q?aVCh3yBRvqCnO+11nMUYk9NE5fjXpKG0dEEe+/BfBgEbfQFT5R5u8KbGCg67?=
 =?us-ascii?Q?01ieS+rlLAS8OQWBRVxZIYbZiB820gvXN6eqdmIt+zoE5QpH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088aa81a-15be-4050-dbe9-08de5f86cfdd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 22:36:15.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7WLG2MnFq0wArfq1IzufTf9hYOAAfbTPXF0QzxJl2NyPFP9qjGaxROK8SlKAtGwgkXQ7nEB+x4phwfrV4RXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10676
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8588-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[synopsys.com,kernel.org,outlook.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,whut.edu.cn,vger.kernel.org,lists.linux.dev,lists.infradead.org,gentoo.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim]
X-Rspamd-Queue-Id: BACE9B56FC
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 09:37:04AM +0800, Inochi Amaoto wrote:
> As the DMA controller on Sophgo CV1800 series SoC only has 8 channels,
> the SoC provides a dma multiplexer to reuse the DMA channel. However,
> the dma multiplexer also controls the DMA interrupt multiplexer, which
> means that the dma multiplexer needs to know the channel number.
>
> Allow the driver to use DMA phandle args as the channel number, so the
> DMA multiplexer can route the DMA interrupt correctly.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 25 ++++++++++++++++---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
>  2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index b23536645ff7..89ded0207832 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -50,6 +50,7 @@
>  #define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
>  #define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
>  #define AXI_DMA_FLAG_USE_CFG2		BIT(2)
> +#define AXI_DMA_FLAG_ARG0_AS_CHAN	BIT(3)
>
>  static inline void
>  axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
> @@ -1360,16 +1361,27 @@ static int __maybe_unused axi_dma_runtime_resume(struct device *dev)
>  static struct dma_chan *dw_axi_dma_of_xlate(struct of_phandle_args *dma_spec,
>  					    struct of_dma *ofdma)
>  {
> +	unsigned int handshake = dma_spec->args[0];
>  	struct dw_axi_dma *dw = ofdma->of_dma_data;
> -	struct axi_dma_chan *chan;
> +	struct axi_dma_chan *chan = NULL;
>  	struct dma_chan *dchan;
>
> -	dchan = dma_get_any_slave_channel(&dw->dma);
> +	if (dw->hdata->use_handshake_as_channel_number) {
> +		if (handshake >= dw->hdata->nr_channels)
> +			return NULL;
> +
> +		chan = &dw->chan[handshake];
> +		dchan = dma_get_slave_channel(&chan->vc.chan);
> +	} else {
> +		dchan = dma_get_any_slave_channel(&dw->dma);
> +	}
> +
>  	if (!dchan)
>  		return NULL;
>
> -	chan = dchan_to_axi_dma_chan(dchan);
> -	chan->hw_handshake_num = dma_spec->args[0];
> +	if (!chan)
> +		chan = dchan_to_axi_dma_chan(dchan);
> +	chan->hw_handshake_num = handshake;
>  	return dchan;
>  }
>
> @@ -1508,6 +1520,8 @@ static int dw_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>
> +	chip->dw->hdata->use_handshake_as_channel_number = !!(flags & AXI_DMA_FLAG_ARG0_AS_CHAN);
> +
>  	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
>
>  	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
> @@ -1663,6 +1677,9 @@ static const struct of_device_id dw_dma_of_id_table[] = {
>  	}, {
>  		.compatible = "intel,kmb-axi-dma",
>  		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
> +	}, {
> +		.compatible = "sophgo,cv1800b-axi-dma",
> +		.data = (void *)AXI_DMA_FLAG_ARG0_AS_CHAN,
>  	}, {
>  		.compatible = "starfive,jh7110-axi-dma",
>  		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index b842e6a8d90d..67cc199e24d1 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -34,6 +34,7 @@ struct dw_axi_dma_hcfg {
>  	bool	reg_map_8_channels;
>  	bool	restrict_axi_burst_len;
>  	bool	use_cfg2;
> +	bool	use_handshake_as_channel_number;
>  };
>
>  struct axi_dma_chan {
> --
> 2.52.0
>

