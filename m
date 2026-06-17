Return-Path: <dmaengine+bounces-11580-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycqOFkirMmrU3QUAu9opvQ
	(envelope-from <dmaengine+bounces-11580-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 16:12:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F5169A719
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 16:12:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ENVyuuCG;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11580-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11580-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65DE6301AFF8
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jun 2026 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699B43637A;
	Wed, 17 Jun 2026 14:12:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010065.outbound.protection.outlook.com [52.101.84.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160543D4E8;
	Wed, 17 Jun 2026 14:12:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705541; cv=fail; b=LHpCPvVNE/u+LS+s76zI5NOJH0w5xIvc3qOSN3GcnIS+VWSAX3debJTNt4eWN4UdLvnG6LsPkQBG688GU0GUa+KB9SrLIdeanaIWrNdnsJK69EVDxrR805CwJSyNw6vUTtGLyQOxZnrHU9RLGjv9ORcQximTayrJyu2grXobx9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705541; c=relaxed/simple;
	bh=Sge0wCIJ/Mb8bGFNcfI0zwf7ng7GNZEJlqWf3eK/TME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QXPXowLuXRW4FUJY4DsAnrSnbzs3dRdnvXKGsHhHwgozZcuR8K0r9f8kw21MZ0pcZhtXv7TwxzsaZv+qXN6dvLA2c74rnZAK1pCHWqLA0LnHeU9cLPlbsPFvl1fMQMjY7iFPYYZjOoyna34Lc6vlGaYAASGS1Y46TZKk2Oj6mZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ENVyuuCG; arc=fail smtp.client-ip=52.101.84.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emNCeYe6KrOqGNrOyblTzUnhuUeMZ5XqXaLF0ZA0qw5rvvt6So7FeTGBXbQUhqNlxb6/o+KLgqVKOalzfehJpC7i9IyXYLCfoEDnffIKfh3dE6swoh6rN6Rtkc012Hvb3VXSCjnrpIyCkC9UNvHeF8FC1VRtMbsJBP6eGM5FynQsHTfWB0XvVwo5ERyz+QN1bCktL6/7QlrVUZkm1cUfeM1w8K5Bt9Du5r2sZzof6RqS0hOBY2rokkINL5l731lJWZNCKZhAhzyFpG8Fq55YPsQ5l8adZSN8LoRPclpuyxp80RFj99PZw5YKAal3Wk8eLMw/2DyPCQfqin2u+2ZGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxtK4dG3RGgEllZmy+Bk7pjfoNOwkWMKpDQ1I/g2+GY=;
 b=HWJMm9Cbsx6Jy8HsPMrEiL1+x/BdlVJkuVlx/8J0bpB2Vbu1AC4CTTAobIQh8KlX88nygdMgkTFXuUK6Fm8OqOszESngSP1KPbrVdQrheaFX1BKfxCR14h6x7kGJ+uXVjngQalRzD7zVRo0N72XnMEmz5PG3Qx2SGPn1gZhXmL5FskQ3gx3FJelua1MeSgdSvrIFHsRVuDy44kG3ZPuE9xNY/5Qx5OUdIa8xS5Nvb23NAOvwG0IKdZ6X9WBtgmEmWgpsNq9r366CxS31kYyW/uSqstpg5NTxm4/Mnvr1FznZMSvmJtvy5kMD58JhhumtJxKEOKkdl8yQxbyiTlGaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxtK4dG3RGgEllZmy+Bk7pjfoNOwkWMKpDQ1I/g2+GY=;
 b=ENVyuuCGco1W0z0YDJd6MA8Bt3oQs26a+zxSH5MobbH3h7VzhVDUYoTUICB2R6vAGmlEOE/Az+FJu6f+gEw+GhJgY4D947PIUn7Tr/vZkZ/K9oM3UybTA0Wr03gowm2l0tSbKU3jyhBbzYLlAYhPfIfD2OXBzAx4rGyYMhvceRA6dDlmtk5Wa7o0WgbCsze77+UmPKz3GaLzEPL6iJ6mac4vZ3BN5suVGga9irD01790u8J0vvkwvHfn70VBrBFCovwrZosIfPt2U0JkWrxSv6ftfEADF+TP5EktxfzlSb3q58I8uds4uSCPbRze+NzZcx5digJ//vY8r3G3cFrUtg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB7848.eurprd04.prod.outlook.com (2603:10a6:20b:288::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 14:12:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 14:12:15 +0000
Date: Wed, 17 Jun 2026 09:12:07 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dw-axi-dmac: fix __le32 on set of
 CH_CTL_H_LLI_VALID
Message-ID: <ajKrN7UeLxlUKY8V@SMW015318>
References: <20260617084944.705266-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617084944.705266-1-ben.dooks@codethink.co.uk>
X-ClientProxiedBy: SN7PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:806:126::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: f03f7937-eb6e-44dd-acf1-08decc7a6e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|19092799006|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H3WSxEDOt3hcNlVdbLVBMATHy/1uggU9QLjJORrgpWVGeW+13REIIzG/8W0HUMfjrExY0m/UEIGupSCnApQgXx1m3jm0QMkBuraHFGJgBsK2OBsXc+Izl7+8FaknkIgTg1QwOG4gHaJx4R5xDGxSnBdodWcX8d0RqkfDwmi3LNfSPUwzhqd3BUHHzhiKm42mUoteSkjO73xfCByee1pzlNrlqv0SsSYpDJ6VO5QfhOOlJgsZIjXSlssiFPyAiKhTUbPhwZ++krNi/dnx8UfGE5rNVZIqKiyfjhuYh3p1tU0Zs+NOkAYKs9hWNj9na9rdR02UcM88E0Pd7tXGrsMWy5YkXsEII42OgNVysiCrT6IfU/hEm3iLCQLIF3PmD//2tk58cWPXatQwhdIMapp09PII5KGtCDhKP2zjlp+6Oe9zBAvUoQ+HOhZFap+QWHfdVxCEeWL8Em1GRty/LErRtUocqdsF3iE0ZuKiIWKw9ZnYafMMf/XZBJkcWKfftaGE47L9b805cG7L7nAx4vKHo4DROe51EJcji04aZ6VYAYyNM6mu8q3bOXjMWMGhX66zrEMRNLDQ5t2yy+8JyasQro8Y7lKR4IrMTjZORKFJEb3le48ONYckMp0a+wbsVsDFC6SA3LCaTNUhpCJJgfNFoiy0PzSwbOIrkPml9++0Y6eUC2Dj4wTqR9PLkhPeDo4G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(366016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?duuPkhma4qK6zy491OSLJkd1jxBHPVQ+PUHkxUKk4Nh8KahfQk3LC1tO1htC?=
 =?us-ascii?Q?LOYlm0TPJ+/e9MDLogAujChyWEjycrUtKoBk0younrs0JkUnANykOo2wH7pS?=
 =?us-ascii?Q?lv7AaNVDI10Buv7r3yCW1Pu5JR8MwgB8VlZXw3/6vqhZ2vVE5YkfwN9VxoyN?=
 =?us-ascii?Q?t8iP+adOf50gGOFx5YvT36U37tpAgOlJK0tTwOrw6PsahHnr1pkOi20gqxeS?=
 =?us-ascii?Q?N/S8lKwU3Ap3Cqf4d3kiotIVw1ZtyzEFKCARxVxc4IaTfvWHciO7uI1PvvwR?=
 =?us-ascii?Q?OOz3QZYgArVP4Ze3EuLUNatxH+44+RXhtu8y1DljviyvVQdP8g7ORssaS309?=
 =?us-ascii?Q?9EKrtjVfvLwRW05A2xvMrfERlBxG515hpEI3EVzUmVenE1yWZBIt5oCe7TJE?=
 =?us-ascii?Q?Gt+nNidKTonWpDI39FMY8HRAqjmzOk1qI1eXKDf+nAU5gNY2HJAfy4eWPJz7?=
 =?us-ascii?Q?6YA3gTx4UxgGflrTP6i4FEozHTtF6ZiwuHFaZMZqbh5XukjIcwjm+gNzXCmY?=
 =?us-ascii?Q?rseur1XZd7KNj+sjKU6lVEhL1SpFzlDqIDLzFclbBvO9jgFvShHjMdvxBp40?=
 =?us-ascii?Q?GHxiW4JsOxqfbBL8QyXplJySGcvyrScCJewCsZ0LjuAkbhNjN37tKV2IaaTs?=
 =?us-ascii?Q?qXFFozMb4/fO9aTrXy77c5VSuzMYCt4T77SYfWX+/49zmFdprnUw1i7Jt843?=
 =?us-ascii?Q?RowUZLauuXRg3duNsprgrMglvJqy5cj3DyoJSkVulwz9ztpZAodJ/5e98hry?=
 =?us-ascii?Q?L9VQjh2c1EOmKyD3N1hm2TJY8E4gJzDeHQq+gQ4WLYYo9Cg8FPLiCaOldjq1?=
 =?us-ascii?Q?i1ouLwkP2GoxSlbCwZ89uH4RjtvC0F+mBi1xr/iRksKTaTN2XaDXMIQ0f/RG?=
 =?us-ascii?Q?0Hq4XRJA3O1mkb7NpMc3PiU5CvoT+FSLpEIOoT+fihIvLceuXyD0I2vR5VS3?=
 =?us-ascii?Q?y+ncY/TqmmLb7kqa/b7eyHAbeBzKBH0gfv4c+UJHA/XmW5uveVuZpTPKROTu?=
 =?us-ascii?Q?dOnSKxv6INkoGs4PPh+e8WViqOA6BfJmeXqtS7Mija4QkniWyLIfuR+xgfcl?=
 =?us-ascii?Q?8iMCYl2xcXe/dxf/qTR4EFOiWF+p2f08lQpixcxMbJADjOGDSEkYuc8BQ0uF?=
 =?us-ascii?Q?fL8+Odst20WLvkXIfSid/spNaEBSbmV1/DzDPtho+yvMK+/iYrsJKZm7XXKZ?=
 =?us-ascii?Q?3yF+IEq86wZavulBb2ibRQ/YiJkifk9/TM2YBtPYHixJ1wM1mDqaJKZhmhKV?=
 =?us-ascii?Q?ziZz5SbrhGhZezGOlXxDwiHm8iVTrz8RhKxGtCV4HG4+YVNERYzPdlykTvZQ?=
 =?us-ascii?Q?xV75w7drItPoO0m0JYmkrSWJw6Lu+ZS79zBo5rWl1HBIPqqqIWgkmssKQeC9?=
 =?us-ascii?Q?R0cB05dniL5uEAcMni+qEbN8FmEQ4bWnlcN3PiO9aImA5M3Wa0W31F0GewRF?=
 =?us-ascii?Q?gcYt9/RCftmGLZ7FVKUemFa93PX55YbOCRGtT3HVRiLncug/GXNGDb3BG8SM?=
 =?us-ascii?Q?o0X6wvMxsc5WqznPowdzNZT0Z1NRUTBAbCkNNIs18I2hLjwcPBofQFD67KCY?=
 =?us-ascii?Q?oENtyIO3qv5pAjQvhILJ+C8dKOBilPte9XXxCMx5lJKiyWeQ2Bn8Lu0lpb28?=
 =?us-ascii?Q?nM2OmZl3VgmqIgjtZATuO/12XFZc0AKkSR2eQ7At0lzrZkJTzr70k1efq/ry?=
 =?us-ascii?Q?HgU4Swd96nYb4d2FeUFVK02Ax1G/wNrt7/lY6IIgmIeLIZWvsKvOFIr/Ml7d?=
 =?us-ascii?Q?bL4GWe0IJrv/3BBLv6YBtQGz8Hn+ciMUjsdPXaJgi4jXKDbnC8tT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03f7937-eb6e-44dd-acf1-08decc7a6e93
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:12:15.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jx7qauyNPH/3jimjDqEzUgw7dhyejkvthEk/CQPUXbS9SxhBQiHtYrht4QdyPt0oz/AcotruOGcQODj0UMeGvcDEoh7U/U/0k+8RMPIIFP5CpKEr2kGecd+ux2XDnc4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7848
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.dooks@codethink.co.uk,m:Eugeniy.Paltsev@synopsys.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11580-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,codethink.co.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6F5169A719

On Wed, Jun 17, 2026 at 09:49:43AM +0100, Ben Dooks wrote:
>
> When writing the lli->ctl_hi, this is an __le32 type so the
> value being orred should be convered to __le32 by cpu_to_le32.

Not sure if it can pass sparse warning check.

Frank
>
> Fixes 1deb96c0fa58a ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> Note, the call to axi_chan_irq_clear() is passing lli->status_lo
> through which is also an __le32 but it does not seem to be set
> anywhere. Is this also a bug?
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4d53f077e9d2..8311df2f11bb 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1123,7 +1123,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
>                                 hw_desc = &desc->hw_desc[i];
>                                 if (hw_desc->llp == llp) {
>                                         axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
> -                                       hw_desc->lli->ctl_hi |= CH_CTL_H_LLI_VALID;
> +                                       hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
>                                         desc->completed_blocks = i;
>
>                                         if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
> --
> 2.37.2.352.g3c44437643
>

