Return-Path: <dmaengine+bounces-6476-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43668B540A9
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 04:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DD31C25021
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 02:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1B221277;
	Fri, 12 Sep 2025 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JHgG1n4d"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C120E702;
	Fri, 12 Sep 2025 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645328; cv=fail; b=e1VIBo6vqGJxxbGqOA4ow5DImk5LURFrWefSOwGOpWdfAPHgedw++APjTnysW4flREU+LU8EtFyARwYSUEEKdO41qYQTHxc0DXy1ALc9A2xQKP3kaZeZC7HhhuS5cstnvC5H9ueyhYJG1RUk0755qsMhzMKB3yjeBclqpDxb/1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645328; c=relaxed/simple;
	bh=MmK88YIRensk2IHdAQ50p4sRv84/3A4uaHHGVm1EacU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kDPhZdeFU2pY09otzGPqEQGyzC0F3VMUSEkChrTqwkkgrA2E1NXHyrXVW69ijZ+VZ8krkS4yL37l+ChqYIJyJO8Kvv6MBCPraKcz2YdgNL04wMFcI7XBD3WmixSw2BzoIrYYkMRbWspYCw6LVpmvp+lqCJz5P2/ghwcSZjoJOpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JHgG1n4d; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGS1f/fQdWoUI8AIdYzhtAZ4rBvi32CtLnv7I6DjDgmksvR1maPSW3zFYRGkPcg87U78gThX7K+jjgJsn4ffJMtBYJukftdb/NClOwYduBpEtKfLp39KadRyRX+OJO11Zpowxi+r2LnX/2Od916T1GRGigIBP6+Gmn0EDBnBXQEhrQ+nMiG0xYLdKo9TJy3gSXbmo/hyTmC6HMq37IVQZmC4CZE5sJxSNg0GtkKf/pnmMSUwOHdjY94Qjfkt5I6OTELOwldyKkQPjM9RgFwjUSR+01ss/BxVilUft4mKp0BzUI46mWayLFOA5Od7hVCr+3/I8yC+leccVYyFdjTwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmK88YIRensk2IHdAQ50p4sRv84/3A4uaHHGVm1EacU=;
 b=J/4zWv4FdRJmrHi25hgw7ntwM++wL23Te1fS/LwDpQAesG3p4Ln4FBraA8W4u7qkeBGe9A5aYZan6C+ugJU90ClQdqoploCi65AizoHwuiiwvdJqOPZe6w1PZYbpZZdEG1iHuki+XclBnKkKNSFJEvJ+zhh1wSSiUbZGVVDCGdwQRW2AATVva4GkbnuSa6UcJ2gOaqhpFpFzBK9W/jIrWpc8jXLnPBwq1RJRotyfW5oUMwDwaBQirJ3wQAswmiK22Z4SLvLTIQDBb+NvzzK7R5gy3pFAyB57R+oonkRw2qFZV2Vw1hQMp+m3tPe+8llni6JovL5WJl38iDd80n9sIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmK88YIRensk2IHdAQ50p4sRv84/3A4uaHHGVm1EacU=;
 b=JHgG1n4dTMe2WRyxuIqrH3xWWO79S5sKzuOU18fLoOJi2S7jGJV3bmPvEk14LVfnw85Go7aZCUpDrysYr3Cp4xEZE90vW7Tia5RqnDbfxtCQO8U/IkjYM5vDjTPAKhVzoGs+/eXCh65WRl8+BHXFElQdRB2AT1TkLtr3xPa5l9jOCz1Tn9ocYmAjgItRoWQ0fimuGusVlJRiZ8Vl/jCPGg7kEVzhLTu8uRS0OnIDQ2iihjtXZ186T6Yw6dypQOB1xfrKOUC90RN6PF7zF1jzSdOHOJbIp918ynZrcVnBOZHcn5T8xywFog5HEMVGqnzGp+WFVQ4/rdX5P97Z9MJC9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7391.eurprd04.prod.outlook.com (2603:10a6:800:1b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Fri, 12 Sep
 2025 02:48:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Fri, 12 Sep 2025
 02:48:40 +0000
Date: Fri, 12 Sep 2025 12:00:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 06/10] dmaengine: imx-sdma: make use of devm_kzalloc
 for script_addrs
Message-ID: <20250912040007.GF5808@nxa18884-linux.ap.freescale.net>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-6-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-6-d315f56343b5@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: 26059813-0154-46a8-0caa-08ddf1a6dfe8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+7Ip8tWlnFz0m8NCLvIFg4pmCCLr13hzNn3o/9/I9WGzatvCIOKsow6gv/m?=
 =?us-ascii?Q?/DNTYqWWqUlO/417bcTKHVZbrKlUUguSsat6yev8wq0VZs8BwVunX6Ibzb+B?=
 =?us-ascii?Q?JNpWdaagNTzLol50LCawE5h28MXggh4CkKVuCwYt3hLNdXIVwhE3LJ73M7bU?=
 =?us-ascii?Q?Ca+wFA2eAVQhmLyATDUp5nr/w7QDOAHT8V6z+Rrz1YNKXcjiUPRK3Zs9QEFH?=
 =?us-ascii?Q?96BJXBG5wPDn+GD/DcM//XnBwiZ8F5OhwGbawwJ7o6J+kOJpZcbl6a7dyzaj?=
 =?us-ascii?Q?NRteYJ20qGRAAxSv01ulUTqX6QMxe51dYtjx+TeVj/arqIB0c0pOHfcIzreH?=
 =?us-ascii?Q?SytMwPvMBpuHr5RvnelQIdqvz1Nkg8WXiG8ipei/m5AlQmDPUdKlBIUXEpAk?=
 =?us-ascii?Q?TK2W0LDZ1oujyXqukVm4Gl9V54Oddp82RP3Mg+37a7HL8FTig0UFXbO999jk?=
 =?us-ascii?Q?aC8HPiq35f88+kCli1uZHlN/LcTTmbKeFxAvy/GWv967LYbEd9K0hBLOaIjI?=
 =?us-ascii?Q?0vJwfqjOM6qV6VHIAJj4BDxo6lgJsUMdJmtlzhSERdaU+3boyqyKZnJAd5HH?=
 =?us-ascii?Q?WFj/S3hezHejEW56FATevGbuexj7yMcjmysgM0/a0+zweBsVOsJpZWdN3LUk?=
 =?us-ascii?Q?5DbnuJr7PlWXeoZCYbJNPCFIn05TiWTppEw23Sm8bEUGA4z1wWIimWZjwbFx?=
 =?us-ascii?Q?fNLvwwvsC/VRNDfze3vH1zk0nv0xrO8YR59JuaIM+8vnPPZGJd4G3lnl81r9?=
 =?us-ascii?Q?gBUAJf3NIHCbX7U73n6BYk/C1vVYinIkLZq8+Nj9erN9MdqP1IqptfLfNbuW?=
 =?us-ascii?Q?TkoW/uBnJaKs9kJQrkLNxi3mCB+WtKyVAHuau52leOwqzk4SRM9YGY4UcX62?=
 =?us-ascii?Q?4kSlOXTLttlgBwcTcTy6YVSyaXcB5dBqaRt3ycSSfPYXHPZL6MEA/SoDA8U3?=
 =?us-ascii?Q?4OgDm1w9xdVynFenMmn/NbNmPxCMa3DBfT+aJF7bvDd1aDTM5vjepjNgCk4n?=
 =?us-ascii?Q?v5AK63owrWGEgrowv77SkB0nXXRe1mwPciWm2rKATp7cjRXEmimp1hLaPL5V?=
 =?us-ascii?Q?MUxnb5+YQtqUi6ZVBxxmMn76jzLxFJsga1uGqcU8EwZ6qS9J0DV8yeZpL7Kx?=
 =?us-ascii?Q?MG39WF1NL0CCzj9cXri1PoNK763InwKzHniVkoBuAwjyFtKWAmYjsal1CCfq?=
 =?us-ascii?Q?VSRq7GpY9qIbKH62gyCAUSbDvu2nWp60K88GxppOAaGKIcYSvw8VO5qdbMsz?=
 =?us-ascii?Q?mAJH69AM5XYunNmSrKWTD42AS9VxJZU7GEJp00AZoGbwo7mA0dgxkIKqXWxQ?=
 =?us-ascii?Q?goGjluUG2KCPyKeDorGzKztf0K8m269x5ool//l6oXcWknYUJCHlZjC4RZtv?=
 =?us-ascii?Q?dr/6+aJJ5CzEncSUuwRCFHVA+LQM/iQaxOnyR5dlvzzRy7dD5zjuwHxfbvtu?=
 =?us-ascii?Q?cN0+/BINSnSpJyiHPcIEr8Lw0Hl/bv1Zwqzrntu20da6NfUgUscKDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i4lfGnuo3XWFld9jOhMKa1tKn7xT/uO6Zybojzf5tQf4lzmGT6NKPudjZHAZ?=
 =?us-ascii?Q?VtsSdtUmFgJLm/LhH9oWaMoZF/rNOFJP539dk+1jZ/XOe4xzoTl2JIxZsgJa?=
 =?us-ascii?Q?USsjifDPlwBN0luZEIxE7fbAghWLaLdcQ8xQUCFdX1XEWPtXWwG1J+Kth22V?=
 =?us-ascii?Q?iepd9CcZRvo4mE1AXgr62aHunoqvzfJeD60NrqkLYOqvexkIplPBvydkB6JB?=
 =?us-ascii?Q?qEDCGj1g7CJWmW9sK73pZasIhwN/vvESRlUMUXTmDRFH6OrIJ9W/98wDKFLk?=
 =?us-ascii?Q?3BkfTvQmldY6pEK96B4Ga32DuZKfseyplwepV/EwS+wN9c1TyvHgp/FoHzU9?=
 =?us-ascii?Q?Q7suJe5R/yBEaxftfBJcGJ9Det/xEFrN5A4DSeJxHO4EORB6dgUz1zTAVFxc?=
 =?us-ascii?Q?hsU2bZO8i/QKx7pfCYIgGqaIbXsnP/+Kk95DqrJuS4ZA0mPJdnZHwwLmdhXa?=
 =?us-ascii?Q?Zic4IwjXu1kTgp6DeVE8h75OqdyvxSnJdebl/8h2OX7brCc7tY68xaIk5jO9?=
 =?us-ascii?Q?SWURsCwF79tbpD4NOiMvt/nYjkC+FqIhNpvbapAcSq3vzImFBpVaSGf81jW7?=
 =?us-ascii?Q?ZqgS2cFdIR9X9qXhoJITZJWu6GQ+i1vYfto6q4TmOakA0PedGXXllxVLYdnG?=
 =?us-ascii?Q?K8brpGPrfkWZTjUwZOQ4iOEOxwv17bRyXEU5LX6v7u9o4mdDrQKWj315XF3r?=
 =?us-ascii?Q?z0phQfvvDlh/sGpVn22sSDKN6tUeePx4uZi8Kngb19rywi6zB2gKNi1yVFAn?=
 =?us-ascii?Q?QodqEDYdS/5QmJ3ge92EvDvyOh4Ih6sTgv80K+H59sJJDC62aKYEu5Wq5EIa?=
 =?us-ascii?Q?vfWXYR26xcYYQ40CGXZIFp0EutxVklV8a9JfbEKtihGhYoBA7q8XodZcdkkp?=
 =?us-ascii?Q?MpJ6b+MzbFe0vbninYNJRznpthst8cUNmdwx8TT3DtO/dB3Kwo1eMxeA6Imb?=
 =?us-ascii?Q?+SroMfm+MBIE/wpS9R4O6luAjzD0TwEUSBLNho83+GonFR9p3+nlNQsAbxHd?=
 =?us-ascii?Q?Ot3U4Sww3d/Fyf1teoLuZrb/aSChOx/WTvu8uYbBss77NXxX8xwNuHQDy5/l?=
 =?us-ascii?Q?hXjK3ZvDgfj7dVEMHq2XMtQTPmBizDDyzxCmV3x1Kl7sZP1WaXTuO6RpPj0E?=
 =?us-ascii?Q?XFSx9V8EBLomHHzuJq4RGXNlR83LUd7JIy8j6AnrgCAnOrd3J5lV68A6Nqz6?=
 =?us-ascii?Q?6/k861+wegrFfRZp8xMVxlAELxgV0NMDcoOVKDi4cJmLT6zjoYnjovZDfIV/?=
 =?us-ascii?Q?MWyvTK8rMmLMWXadVw6jyQh6mzpQ0bZC0kwkqBRfjMOt7MEf7Yc6NFOC7U+t?=
 =?us-ascii?Q?PUAsX4EQxPKk54lKQ/tazEmWBSwF2LYusn0vojVi/4lhmABKZ34MBn64DwDK?=
 =?us-ascii?Q?S7iziVxodGdP2W41gVhN9bzx+V1+gRc7ZTawgEaqoUQpQiB0IB/dUGilTtBq?=
 =?us-ascii?Q?ZYHqZKe9VPAihgShszzYVMAq9eXvpbmXw91+UTiyCx48g0rJFsPMMiDdkN/s?=
 =?us-ascii?Q?QKcsa3XjlCHaQ3aDHwU6RrlmKagcDkibOti8JhF+rrQyleFMUV+nzUmiU4rv?=
 =?us-ascii?Q?npq59JaDIEqlwO4PqW6L/3u/DdkpPLBEJtcfFhbG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26059813-0154-46a8-0caa-08ddf1a6dfe8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 02:48:40.4313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhNJB7PiaZ+vNf/PFwirDxiuvDQIXS5MuybQt0DK9LFHMljflQIIYvWUHF/XL7d7Hb3Peq9yZSwP9H8r6tbKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7391

On Thu, Sep 11, 2025 at 11:56:47PM +0200, Marco Felsch wrote:
>Shuffle the allocation of script_addrs and make use of devm_kzalloc() to
>drop the local error handling as well as the kfree() during the remove.
>
>Reviewed-by: Frank Li <Frank.Li@nxp.com>
>Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

