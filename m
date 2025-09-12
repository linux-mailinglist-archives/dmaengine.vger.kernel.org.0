Return-Path: <dmaengine+bounces-6472-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A8B53FFD
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 03:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AAA1B2676B
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 01:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37B915747D;
	Fri, 12 Sep 2025 01:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="u5Hwfcp6"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49C21348;
	Fri, 12 Sep 2025 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641863; cv=fail; b=AOrtw/MJEzzI/r8QV7G3iryrBICCMfQRrqJtt1anmDfw4EaKEgvy3w7tY4DyFID+FxLk79rke712CS+uXs0ph2geOKCZVtGUbdYKCjnv4qspog2sdPkc2Gh1BfOK/l1CsIx0vlnjeMYZEOYKhu1Q4y7dZJZHKD9DhyDuwYsFEco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641863; c=relaxed/simple;
	bh=8kGQqQjHjdKaV6V65eIcTLom4piArz3DgKrG5CzW9u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c7kIWfeLN17a8U5SyTluSwx0OIYyXz1d34+nznsqhu3tyrMUEO3V/PtTWBuKsV8YwP94NU5vUnz8lgkhgxvG7F3SS7q4JlGUBztBMxgkktyi1jgBb3ilKB20l46ObnTYV4hzzVC6aW3LTjqwmY0tSI1bSkrwa5+ikh2RvhQ4G8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=u5Hwfcp6; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC1SAvLCaP8u/IbH1YIOX5ZPzVLll56WvLYP6YfTP0DoXJQawfj5cpJovFT9rSiRppLnDPUOdZ92cc7I0Ej+T9reD+aetQn42Bv65surYM5SKDVpHxbHdjZwFFfWfwgRFLkhSPSS3chImRGokqAXRcNhNl2yWG/qv+Y5ymtpmT1+FIw1lflY4+Iz9CSwbRgH2g0VcQ3qGlvD01X+zpEvAPNwaFsW+PlZhCXgzeTVMLRhiru4T6yPeGQ8c9mZm+zidTcrCW1JBmXbEE4lFb05+hrymrSroqCH5l2uzYfefUt0bvz70IPK5CAH0GFxOJ1Ub2BJSWvR50aVTOd/6AVNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kGQqQjHjdKaV6V65eIcTLom4piArz3DgKrG5CzW9u8=;
 b=ZPSXYCvHx0wtKFZWBCz5nPH5MH5QV9qZWebxzqLyWTabbVZUIFegUT2Js5g/J3Rp3KK1X/NoryZ+pS3D7t5TWBwLlvgRv8/4Yp5PmsqB9h+VV87uEEvlmkuiIqYLyfkvq7dmdP5Bz6OD6y3sCb+U8Sm12yr6KMdq7rkvg0L6DVWRDj2wa9kofrV2Noaxiv7/WAFH8B4/4I91NABLAjfVHLcczN3iYtYne4sht0oHxYtreet92LuU04NQLzoQnbvfPz9f9cPDSZnT2mU+fGU6C2UEd/30Dz6pHLfyLKKvVz3TmvWY/5+NcCnHvb7qEnosU8Yr8FS5TehOZxbDUsr63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kGQqQjHjdKaV6V65eIcTLom4piArz3DgKrG5CzW9u8=;
 b=u5Hwfcp60qSVKf0LGe3l++4NNVBgdPQGgA15QyfETNmfzlbK6EyVSmak3exM/CrpegsJDVLKmRdLxEOOJq/XuNgDbkcZv0YeECuWyzbk0vJngF8KKY520yhsers/NmLPzKPGERXcz+tHwXmZwPzo7wJqmib9VuVfST5/xL0R+dsIc2eSfIW5CZdg6Lart8ZWprpzawXrCpgOznnTEJ1/Ci1e5kAijgHNezZRX4hM25xXZmaXYsD1rE4B7irnwEBKaaDQnM/5hNcPWA8UCNDH9uypNgfU5Qyo2btU8tK8X18B82+KFyi/zSwedCLIhe+DI0Hi1FAPHjx94YcdOhLt2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11333.eurprd04.prod.outlook.com (2603:10a6:102:4f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 01:50:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 01:50:55 +0000
Date: Fri, 12 Sep 2025 11:02:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Message-ID: <20250912030223.GB5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc71661-7392-40f8-d4a7-08ddf19ed001
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLiCtfB51r4PSnVgsFUFQuofg9AEGH0dx+c15jO2BaGLOUeYQWrlv/tkFTxi?=
 =?us-ascii?Q?elp8KQ1fIYV7N7KsnNCpOkaWWhXQAIJJO02N6Zttrkfv3FemA72NwFqYzCPe?=
 =?us-ascii?Q?JYUUUIX5xV4fzXCfloGwvRPeE6hvt32hDU30saH24D1kBfzdfHuFz4dPDBfy?=
 =?us-ascii?Q?rmoZSsmnqmTNxhFnnHsUwh3cxxr2geXIy5CvLVyIw1bNcFG4seG5JBLgUvlc?=
 =?us-ascii?Q?Fcj9bNyi4cAiJgJWfdwrva4dE0F94YpXGUbBIQv6oaAqBZiJ4FCksBrYysw+?=
 =?us-ascii?Q?KFh/CtJsxkkB1wzdBkocghMVOWYObE960UDRQjhhaAKTl1MdvXf2hf/ffLQf?=
 =?us-ascii?Q?iabjo5zDKfIuhqI7YSA0rWtfFaqGPKJas3Jle5lxFWjPXjnGNK4w+fWGa6hy?=
 =?us-ascii?Q?cf/FyWhAi1rsfCfnuMsKIJRg+op1lW81tarNfzW5HDpdtDgEfiZPn/GhhdMs?=
 =?us-ascii?Q?djfjV9en0LlHqzrArVFkvVOIRoeYRPMZYUA7Z35V7S0FxTCNnXNXtPU+/c5N?=
 =?us-ascii?Q?s53lJ9f+vzu7u9VBQlu8veIsuotMEeT/m/8t4F4M/Pj2B0mqtaGRYszZ7vZg?=
 =?us-ascii?Q?9sIHFpQTiaZO6sefCuTthLq/rXSg3QssqmXj84+hJDOghH1upyFXk6slkxst?=
 =?us-ascii?Q?rePsmXo5Ye9fVG666VuALtOKlK1qqKOxr2WNAntQxxGW8DlUCErmn4EfBhBd?=
 =?us-ascii?Q?6qjtV3O2AsJ6/1bf8HRVKOGG+PLHJjrJbWNdxpK25A+2bIUjx8VoJU4ZCibM?=
 =?us-ascii?Q?UEwgy/Fmf2s66JDvxM+2rIzCa6m/fKJWnAKK9JygVttodDNMY8qLI/3wBtLv?=
 =?us-ascii?Q?8H6r0qPLgkh2DbYQJsRpbeFV6jnWxzraN0KjlEeEYBkGvO2ie/iEJpW8QCbD?=
 =?us-ascii?Q?hj4pfEemmhrpVVYPOg6Ttl5JmkRXBtV17S5+cjUXuT60/PB2n33Ges8ATevb?=
 =?us-ascii?Q?RgtyWnikUwnqGcu92YmX0nnHT7dIaNMNyQcKmuniQxeCniett+zYdCjunafI?=
 =?us-ascii?Q?chvVLMY1p8YWc6yTf89yBYTlZWgDG1nAu3Mfpc/5UYCffQxTmivYfMK4+iQO?=
 =?us-ascii?Q?uQb2X+8v3zPMpTwwa0RzKOmIT3fAY2/pr+sqvAlw6hMcRcAvOU3vkRm6PjgV?=
 =?us-ascii?Q?U/oJC8HCBgqkjjkMkYjKAVl6yFB8Xley54cl30V98EwvHdyJPpxxV3oJF6uK?=
 =?us-ascii?Q?DPKD3SbuTHtu64kSl38YSe3lu5++gSxoo4zapNsoYZHpQux1Fl1vsmOVeJ4g?=
 =?us-ascii?Q?CzMSaaYOrW1LUwwgPKI1IyngvxrOR4KTrtQ7BhAoUydRFoVtqFumb8n17mpP?=
 =?us-ascii?Q?qkDNNjuN8IM5Dp1j6gZ3iKTJcV7hP7NF4CbQoS+zQpDK/B25uqS/zNJbh9PK?=
 =?us-ascii?Q?64xBphRXRTVd+zbmjUFbzjW04jBtXdbZql/aNxjmP8kFxd3Eim9/SguPws8i?=
 =?us-ascii?Q?sph5sdB9nwOULGl0kNBc5/D/HtNaUn/wTKtGevx8QwWtkCARCQVUrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wnSufzxvm9qO1+D7bPeLCcdAHJGUhVFGyi/eICmjuOCrlnVUHlKEU98Bzf/4?=
 =?us-ascii?Q?JQYnN94iMJlOSdiAjVTdEqc/I0kowxYa4C49G66+8K+ASWWfw9INmbdC+w7o?=
 =?us-ascii?Q?cOKM6z84U64pqLo+j0HZc/Ar1RzFNCXnvh06Fwqi1aMvhRHR8j7G7CPX6NjP?=
 =?us-ascii?Q?s+1kd4cw/IkDH8vCcm10u7GrZ3hnNCjg9zmkDguCOeRdgcERaNUb3vr7TooI?=
 =?us-ascii?Q?bHppWeIgdGItsdD7y1FTtnU7MbqW0jvmuGwWmxfLozlUh9X//ZoGXdwhVo5A?=
 =?us-ascii?Q?ZWSyRjiMSMqIVUeB5X48zJG4llv3nYDvrsf5tJ4JvNqKMMhZMOxal/k6fFM7?=
 =?us-ascii?Q?ZsQ58BM6LwPnBxGgHVKLhf8xGW+g1DMCLqv+iCNNfAtgmvH+Orhi9ojOS3q1?=
 =?us-ascii?Q?TBUbtCuYUD4el802sN+TsJYa/QgvLvQjIvtU3SQVKX5kapfP6saHF2A0vzyy?=
 =?us-ascii?Q?wwidx+w56mOaCMxEBMRNYNMmjVQ5BBRAWo3XoF+Y6DJpKOWiqsrrBrqKelw6?=
 =?us-ascii?Q?PzuRLGVuJWmbC1g7xDfNXhQqY2Jiq2SJB0PFyA9lnOXiD94vN6nk3myeZv9J?=
 =?us-ascii?Q?Yr1RwCKhPQ9KQe/HG/2YWPPzLxIcewem2SaXSXZYa1rSWgH3G0yIgNm5DpHI?=
 =?us-ascii?Q?r0K3w5sfAiZzFqVMjSqotbltdKCLdyxqCn5WwgkHaxkTIivM3rtBGgY00HzF?=
 =?us-ascii?Q?0Bnz96/oPkosxX1LBPAUtiXNkR7U331Pn5eK/FmDUc/SFPiNGFvQKS9q90UY?=
 =?us-ascii?Q?gK1EodipPhkreEXWEVDgl2ZnN1ohijdcDkAXp8gptK459lKiVe7flk1nPw+6?=
 =?us-ascii?Q?vyxJLplAoqg6iHiJv7t3AEMgBB8kz+Nyh7zqKnZunyRN+yxwCPyp00sqW016?=
 =?us-ascii?Q?nrop0SqUrJIARTjicPIeQqaPCfvcsIVYN2KcKaMcN24TIEVJ7lIZjak4mhzc?=
 =?us-ascii?Q?DIhwzEVOO92txPhGcpCagwofhs+gzLGefNBWrRmMsL8mJz3aTl1l8+zaOkXD?=
 =?us-ascii?Q?RQPxTl7YxGSPgDfadPWinPwWicQW3bKnKEr+fvkfLiWdJCrDTlRJHg7bu2sJ?=
 =?us-ascii?Q?kxggLXB+0ixZ7ushOXf76rA3kp1asUhK2wn3aVEEscjDowwwzr5F6IOChFRb?=
 =?us-ascii?Q?/3nXoPTo3Bt9dsEfUCgBjyAcVx0mdG9uNj9LK6pyJfVgRF+AKBPQHKRFpWwL?=
 =?us-ascii?Q?/IG6PyWkgmuwhXgb1T/gWXCH+slbQijnTvekNanWgx0vqVpaeanDj/ofSACO?=
 =?us-ascii?Q?9GD7udNPeqo572ejnK0EASd7HOVsfMsHqwK0LQ7f12Z6wQZvmn3kmT1kkiqH?=
 =?us-ascii?Q?zkg8QDObGA2dALdvK8V30uC7PlP7geGflWjkMqD8mPVq74H2NsjkSAvtejNY?=
 =?us-ascii?Q?mNXPvJLDSqYwD/NsL5bm70Fslip3IKbyMDi0vIQI2VsX6tkEJ9PI0D0/nS++?=
 =?us-ascii?Q?dh8n41Yom2peu/Nt2A7x//yrE4qzzPzK+DYbnoz5SLY1NHmRxK1WA0NUcHaM?=
 =?us-ascii?Q?H9zc3KRdSaNygPwU9zWuvtHhBqBc+wFxVKA3RKsd+XZHOz9lxINyIejLP22Q?=
 =?us-ascii?Q?UYAmyiyST3x4POdhhLf6QKmGrqd6Q8m4CEsaIc3U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc71661-7392-40f8-d4a7-08ddf19ed001
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 01:50:55.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b12XGXWBvNVPJloqmS9bFVSYHKhMfWuFQLEL2EQfy4/Gzy2cT4JpihKbtsKM7Bbs7Ml3maIKITHCSUAhTbkOcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11333

Hi Marco,

On Thu, Sep 11, 2025 at 11:56:43PM +0200, Marco Felsch wrote:
>Starting with i.MX8M* devices there are multiple spba-busses so we can't
>just search the whole DT for the first spba-bus match and take it.
>Instead we need to check for each device to which bus it belongs and
>setup the spba_{start,end}_addr accordingly per sdma_channel.

Could you please explain a bit why it is per sdma_channel, not per sdma_engine?

As I understand, all the channels belong to a sdma engine should use same
spba_{start,end}_addr.

Thanks,
Peng

