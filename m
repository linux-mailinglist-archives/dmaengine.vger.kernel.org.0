Return-Path: <dmaengine+bounces-6373-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74975B424E1
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228BF16433D
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D86228CB0;
	Wed,  3 Sep 2025 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lnmg3WrR"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E33225A35;
	Wed,  3 Sep 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912539; cv=fail; b=BRrV8d+2UOr3X8ERYG75YJQ1SKn0yjy8n6hpwgbLEfT0ULH6esehiW5KbCxPx1p4Fn/Sf/StiPgVlDukqoR61P905hehoBXvB3eMshbHtn6Aa3fF/B/UNSx9QCm3mj0c3ilyTiM6Dc3hz7U2hLye3DJB5/0uZAhFHAlutrxZEQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912539; c=relaxed/simple;
	bh=TsEbJrucDgH6AZzxJhLLdavwdpbsL7YJSi9K8rZqhhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IB5JDdEK5aGA1qP6ymKQ31seAbopP7MyjlsUx50yjTYZj7HSBebBLwJNwt7WuptF5HhNq7iRFXr8md1tHB5807/s00ZLy/3lXIo0C9LZEzIsfqebKbHie2HkyRitvb5HZezXLXl8A0CTr6QsCEe3V6KvvrW6Rh6bxKvFGnAcd6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lnmg3WrR; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCUF9cucsWb+vec4rfMLEi45YxHKdNqEiGDsu4R6bL0biE6Ngdfv7fdfTmWQt5xYXSFuPGx8bkTTJc9u+XxDhpaAnqMqVrTKHyvPvXZpYPMwGl1zdfXOWt8YpCWvGxSjhY9kPpK/jdECz9omtRGsdn9Il9CsBwBo/Y6xamiXEV1EJqUZJJBVQ6abGaRLk8yj0F0FtkjMRnMo/H9OTXoM5gXFTag/Im5JWxcvVf7nsatHfZSKxfjoNctUroGczwsHVMzlgzZYn2SnskE4B2EwgdegkrAZ7D5fgx2WVZcMIRhG2v+5r7qRMm1SYsIOTG0kL7hbu9vu5o7aqiu8+v6Wyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fhlXx4rOGpIcUe6Zp0g8tDZeSkJimuxLkYsLiOuNPs=;
 b=T4HkjIqH3XnKw8GoLqmH+AB/mFdwly8NQSfLi8eV95pjQNp/Gs3QpTZjHZ+7jZ+Daa0L8nmDzunHCkvCq+MtmgmF5DHq2Gt3prfpfpO+JO+C1+iXKU/lfTCoKYvUu4lM21diOdLBrQPyqd7Q+BQWYG37QUYl0wO1lZpZ99jWYodGJPTMgr4ML5YzNcekDgG3OFH9wyGQ7sjqWYgz7M/Ch19IiA+AXyLCGvrOVshaUVCo3LbK/NhchBy58HnWP89FVqTYM+wh+mUU8cIQN1FbNPBhcs2IGwo9Qn8De6V8UNdCgsYlk4+4XGSTg0Ab+NWyJV1wYmOIwCGRN0dUsT1l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fhlXx4rOGpIcUe6Zp0g8tDZeSkJimuxLkYsLiOuNPs=;
 b=lnmg3WrR31v3ZRxL4RgBnfJhDNV9gF3Em/JBdhC5hhDoRlbn6BdoIFAW3LqcBFl/Q+/Qx2s4CMnVWHC4xwRl6Bc/O06V1dAmyTQ32OFt83/FSfajcJxvXyf57T9PZ+S2WQa7oz9udaYI549Sy1Oaubi1rovwLHM+HAaGnNzgwtG0rGnU84zH+ITahv79bAJVHTyfnxq4beclbci4HaJtZNow9N/WlrmioTQbyMApK2JvYMwZHz0bMUfgtY+RvveOQbTAvL/7D3hf0fI2Ts1cl6RkVHvkcJGOnRyPe+ri6X2tevTxcbbecm9cJgBDq8DvwG18ySVcszaQsWiqDrPtkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7482.eurprd04.prod.outlook.com (2603:10a6:102:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Wed, 3 Sep
 2025 15:15:34 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:15:34 +0000
Date: Wed, 3 Sep 2025 11:15:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] dmaengine: imx-sdma: drop remove callback
Message-ID: <aLhbjvVytJnOgkvL@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-10-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-10-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d51dcd-89e7-4dc0-0b9f-08ddeafcbae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|7416014|366016|376014|1800799024|52116014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t5TLNGDWNkqHtF5wUXCZIN66iFn0+U3eBPTHqSYJRPGdCWzsAwzQfur4u+3u?=
 =?us-ascii?Q?cT6Oz46QRtxNIVkkEHUfMBXsQaJBvKbGLwAVxitenBMAWEOjeq+Lwq+dl4pg?=
 =?us-ascii?Q?DkRwGK+oBgVJSj/9eEAPGQVcBjX53+hFQrd4rEKuCd4wncxjPrNtKLpedJxa?=
 =?us-ascii?Q?t5FYfNwl0uWFv5gHthez7Dryb1tjdA0zws2kmA6ot+p5XPrLCXGHXQBEYF/E?=
 =?us-ascii?Q?RwWMrU/LnZVriAKjEj9PId7TqFkFrgo2XknvzKgOHzqGNUl+6hzWLcPr/cCs?=
 =?us-ascii?Q?s+wiLN/xst2eqPzErX9xZyzL2ICzNkKaysQ4+6mtS2tfvvRb1zsDKR+LfthN?=
 =?us-ascii?Q?abww7RcrgrJ6qY3gwxOxINP7oGt1b/XyVbc4gW6MUnt+HG1cKaLLIe8cv1Iw?=
 =?us-ascii?Q?oHo7O1mX9PXHTcdS0aHXtjH4yyzkJGgimEsnNdzzomo6oHCwybQH6ytyEXGf?=
 =?us-ascii?Q?WFypJ2MKeKyY/jstVz1iEb9hS1xmP1ZrK5j/NS7vsb6aQali/5F2YvnOLlB5?=
 =?us-ascii?Q?xYb9Z4BBIf1tdZmOvkakGPLV6AgUfIuy0aA5xUvDMx9dqbQHBAOz0Otit50X?=
 =?us-ascii?Q?e0rs7Ee+k2oV4RMeZtBhPfUjbQ2umB6Lvd9wzvuJEC3SBMpPRUJx/Cpz0z6u?=
 =?us-ascii?Q?KXHnEcKnvLcI5tIhKCV5PXwY280XCnsSEbX3jg/ik5WVDXUj/SiGEupC0tyJ?=
 =?us-ascii?Q?ENdidU0po6tV9o50+gsygHSEkSl55OI36BG0wCVklTSTGhJmqrknPUwUABt8?=
 =?us-ascii?Q?WvGwPEZ35NoUEeZZsW7Cmz5IPcRgW/UjBnytmdbeoU0i1UD6pcDNv3vTG+Ka?=
 =?us-ascii?Q?nJqwHH6N+YdPlB3BfPmDc0sw+b8rzfl79WMTuDezwrGcqbktZuCkUH8NVLfT?=
 =?us-ascii?Q?GOsWtD7NbPRT7yu4PptWZ/RLGieaDhbvD9Ru+bb8q8sflhS5+18S5LOm3lF5?=
 =?us-ascii?Q?JncNI2GC7ZueXUyg9XnTnok7v6cQXedYcQ9UrWDGO4c4Xr2XvInF6ouG7Dna?=
 =?us-ascii?Q?OtfQA1xPc8WyDn1zkC+HY3SRgSW48za4MGV0n0GAZZeHsaAUdUNs6ycWBEj0?=
 =?us-ascii?Q?ZHbmvRLllIMWdNDrRmT3PjpOO5B/nfpSip27fso3Ow0JQFtVCPGU32csejnw?=
 =?us-ascii?Q?4YTiQR2WsEViM0+tEuEMHDV+3uYbRg+uHEydtWytbxVxmlGfQYZgFqIbq69f?=
 =?us-ascii?Q?ldkv9CHyREU+/18Q2JAH5hys4+/xMRs5yphQewX12eabokDXnQdx38gjLulg?=
 =?us-ascii?Q?aDCE4nvcemIodh75bgNEwLOSjHmbq4BS84jZwjjR/XC5KI1i9T3L7RbpSEoB?=
 =?us-ascii?Q?1nnPCzdcxPp1o4uwmoR7+Cew+ajJIcaoMY/JmUhxQmJqs87bzKeS9Tl7buaQ?=
 =?us-ascii?Q?+W496VF9teF1c5wE4jm5Wwz12PlwpGYZ5ChcBy+W3FbjkD41uEB/ex/bjDjv?=
 =?us-ascii?Q?WkXd1Zd9IUc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(7416014)(366016)(376014)(1800799024)(52116014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a0epYaI0HW6Z5wGKiU1SxPGWyrgCPBAr2s27P7B8ORZDmzVDIXbXVB1GgzO0?=
 =?us-ascii?Q?h3ihi3oi4a69ZQPdfMPUbw5FAvkUkx9hryjcjCpMC7vaf9KLoVH6W62ivwmW?=
 =?us-ascii?Q?nEI7jod+/6UD1xA6uFdeJi5G6eCNaM+l9Nh5pS+P3R6zuVwriP+cJNsL/0N1?=
 =?us-ascii?Q?zAtlZzZoCBGC+LUcDryqjEvSe+mHpm5jr/1KARi0Rt7FbBrruOEre4CCTEu2?=
 =?us-ascii?Q?aI8ab4ef71E5dEcEMxQMW2kK5Ib/hviZV7ujmOVeZ5M33qgrvS5Cx+l9lzHB?=
 =?us-ascii?Q?MvMTJfMMVT4tWCnFnZu/2MuxpNuIQf6TeghSEGeLN3QiexLDBGkFCoL4pX3T?=
 =?us-ascii?Q?zki1PJXngS6vX1p3dDWJDOzeEuSo1TaWrL0WcYZ00R4UwFyfboGKEX0PmePX?=
 =?us-ascii?Q?AWnL7mH0MZYfLx2/4aKCSRpMH60I15dLEodWQxcMiZ1Y8PT3xK+tTQ+4jsNk?=
 =?us-ascii?Q?LxP7ZwSlxKgeJ+8NqkeqXoR2MlGdoeCiMJrMBdZH+s1Qg/qTbpv7Bm2GE6aC?=
 =?us-ascii?Q?iK6Z29uWDIhhplmcoKv8oJY2HUfzMyacQ2/cZ0Vffg2heae5I44h1wGHtkNN?=
 =?us-ascii?Q?JPBSUvF5QftqBB5TTokriHAnIVwTy3FWd8qncZRLszrgMDo6Cq5ugle8b3mj?=
 =?us-ascii?Q?EIclHDAeoppJo76ZLcKt+fBvLK/s+N7/HQo2P4NCbJ4MVA4BG05y9EE+Piu9?=
 =?us-ascii?Q?HPE5gzkcoG0mVLzNBlchituV0R98ArlTd/9tH3iUgjrbPOkJaLoMKFfa/OAl?=
 =?us-ascii?Q?rNyGLQprIxtlX6KSz3c/+elD9l7DQsht4+WhaUEPtNZmqKRAPDs3DTMJzF4e?=
 =?us-ascii?Q?DCn97t6eKyrjZo+H88oLS9fy/EkdQqHJZ+ThcchAMvoMsguYJ+91SLXGF2dp?=
 =?us-ascii?Q?QjthghtQ+6M1oeWSdspsZo4qnKyvyQLaAstQWO6p1Vutgis1d/gTvnro64JG?=
 =?us-ascii?Q?G+KCb0aQAa2bKGaPXqf+U6aMwtgLcsEMiEHhghv6Pcv3JOwmqPuSPQ7KfaXg?=
 =?us-ascii?Q?G4YT+OHxXkB2UsGpuCJ3kaptH9jy6I3OAkX1cx+P3fBYXtAh8CXlCKSKBAwW?=
 =?us-ascii?Q?4fqLVSyXoSMfjx2p4yecG9Uayabg15eNZE7C/F6vgU+0zznvvTGTcl5kewmX?=
 =?us-ascii?Q?PNAYckgc2PmbQ0kzadIz/g701sqKJ2t+xxJd969eMQgju8tKAD8bmTFk/lMw?=
 =?us-ascii?Q?w8LEqk49+orq03Vt7IoOjX3ietZe6IlTox/8M4ubK3tIBGuhBiqWehlSW5sy?=
 =?us-ascii?Q?pZs0djhWWcDo/2a1yE8qEGeVsZbOwG/j1B07DC3E3CbJOiUvb7AcVFkLs84b?=
 =?us-ascii?Q?7vVVEIo1rwun+anvInTVRmjlFZlc9+36hD3i1MTf25jcommCvFBbnwbSs8nL?=
 =?us-ascii?Q?lzIupLcUlIhyyUE+ytsqKkDfMPb+8sj01pNwKGGLNjIQxv9MQbVLLdWOQDGr?=
 =?us-ascii?Q?b1fbKoy5RqGVCFTe5ZIlNINrshbgOq1zlFqjyTcbdt7dAECZGVs63OskzbbH?=
 =?us-ascii?Q?S44WQuVV+h8xRLefDLjTlvBTscEHyu+0dfwONmh+jFlToy/71LMu3Hhmvzbs?=
 =?us-ascii?Q?L7eQF1Br3W1rFY1XpiAF0eyFSBp8aPQCuaJteNpBM54w39pJ6fZdT9EeBfA8?=
 =?us-ascii?Q?4Ao0FhLUto9J/MREEvkOLGcAJKLsLpLicXPzFSgY1Vnn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d51dcd-89e7-4dc0-0b9f-08ddeafcbae1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:15:34.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fiYPWyL1ChJdvgnMKS/r/dgrijQkRyK3BbxBDUQ5jp9FTtKRNCXIo7Trl3ThHWM9ls0urNAm6U31//gw93V1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7482

On Wed, Sep 03, 2025 at 03:06:18PM +0200, Marco Felsch wrote:
> The whole driver was converted to the devm APIs except for this last
> for-loop. This loop is buggy due to three reasons:
>  1) It removes the channels without removing the users first. This can
>     lead to very bad situations.
>  2) The loop starts at 0 and which is channel0 which is a special
>     control channel not registered via vchan_init(). Therefore the
>     remove() always Oops because of NULL pointer exception.
>  3) sdma_free_chan_resources() disable the clks unconditional without
>     checking if the clks are enabled. This is done for all
>     MAX_DMA_CHANNELS which hang the system if there is at least one unused
>     channel.
>
> Since the dmaengine core supports devlinks we already addressed the
> first issue.
>
> The devlink support also addresses the third issue because during the
> consumer teardown phase each requested channel is dropped accordingly so
> the dmaengine driver doesn't need to this.
>
> The second issue is fixed by not doing anything on channel0.
>
> To sum-up, all issues are fixed by dropping the .remove() callback and
> let the frameworks do their job.

I not realize devlink have this beanfit also. devlink may need more review,
which change some default behavior. I suggest put dmaengin dmalink at this
patch to new serial.

It is easily omited by other dmaengine owner if mixed it to cleanup serial.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/dma/imx-sdma.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 6c6d38b202dd2deffc36b1bd27bc7c60de3d7403..c31785977351163d6fddf4d8b2f90dfebb508400 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2405,25 +2405,11 @@ static int sdma_probe(struct platform_device *pdev)
>  	return 0;
>  }
>
> -static void sdma_remove(struct platform_device *pdev)
> -{
> -	struct sdma_engine *sdma = platform_get_drvdata(pdev);
> -	int i;
> -
> -	/* Kill the tasklet */
> -	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
> -		struct sdma_channel *sdmac = &sdma->channel[i];
> -
> -		sdma_free_chan_resources(&sdmac->vc.chan);
> -	}
> -}
> -
>  static struct platform_driver sdma_driver = {
>  	.driver		= {
>  		.name	= "imx-sdma",
>  		.of_match_table = sdma_dt_ids,
>  	},
> -	.remove		= sdma_remove,
>  	.probe		= sdma_probe,
>  };
>
>
> --
> 2.47.2
>

