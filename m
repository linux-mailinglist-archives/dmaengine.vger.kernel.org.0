Return-Path: <dmaengine+bounces-9481-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKamHqxduWnYAgIAu9opvQ
	(envelope-from <dmaengine+bounces-9481-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:57:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C32AB4D6
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A36603003800
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC543D567F;
	Tue, 17 Mar 2026 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bbo6WAYY"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488AA3D5678;
	Tue, 17 Mar 2026 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773755818; cv=fail; b=MCPGzgkagJMRIBW59NwzlrAxmXVfgtOH8aXRDqGamwZ8xkremZ459viI3MlOAeP5bXpTzlUq/jLc4UqP6pOeNw/pRoanch2q+y0LFw1S0xnGYSF5PhGqYweE7YR6UpWZvsREV3Lw/Z7Hh/YgmOcp144tkmuxkmxRi3uqChXxnYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773755818; c=relaxed/simple;
	bh=oM6fRg6Osy0eYwdI//cDgQaURo3V0Skoaev3psL4UZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BSfJ1t0c4QeyLpEvpOAGFXI7T+Qe54/g1y2mxmq8u6MyaGRnZdvgH1oXDEUAoJ5Ehi55Q/CdaZXVRO9YroIqz6930NLSLhKh13ObMFZrYjerJ7A5lr9HhinsumI/ugCM7EbGXn6uhxPlNM2Dfzo7QVBxXNHz1d9oWD4JRXOKdcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bbo6WAYY; arc=fail smtp.client-ip=52.101.72.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/gQfVYxQsqtXQWd5vGpmy319znDFhYzzhUh3ADZ0AvfIKHBdSjQnI3nybZracPBAdlWmkBgve0Kq7QH4OkTfHk02aJQBm2lzneCCE89zoWzgWQRKWWw8jGYuzZ4hIPYG/SaywqAsWscLBp9aUQe2plNjVVhcPCEm/TwzRaYL8fDKf9QZJz/DIq4ECd+zbDmdHRQ97Kj3aetM5bqVJNBdw9+4uBeaM6PnYYQUEYMVx1Ur6CjoSBBhlVP29hq2YU3j7vUOXELqaYei3NHIQTc2v9KcFHB4xW0qozZFq01IIzhdWkIy4/VL+h305OBYIADzRhDXA/tF1D6OF5fim966Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM6fRg6Osy0eYwdI//cDgQaURo3V0Skoaev3psL4UZI=;
 b=n5IcBg/bPXEy9cYp10oEQwSRsn1rwTaAliytwZpHB6hL5H4Uu0YMMMdzoZJ/9JjSTCvUoDceauVTsudpSUNbYZN3JCP4FtJQlHvVAoRhLIOA3IZYWZF5F5YeEwsmwDIuRJwZlHbk2o3KS9UJKhe35rhUYSlCQ+4qMc3VebIWifw4PVgGWJ1z1poFx6F9Bv8G9acwO5Tws751MvhbGl1XYMF5OeyaOsMCmctZrWu8Cc3U7JtvzUd2oMpjvOPw9hR3dPA4jLrYQwPPW45ZrmXDvM83FF7FnzZVfEEcOoMOiL7z5EOC/TBMfK8vGxtL8vJTGedAz9fiReLvoDUGMnWiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM6fRg6Osy0eYwdI//cDgQaURo3V0Skoaev3psL4UZI=;
 b=Bbo6WAYYWy9fM+fdMTCJXIz1GGUA03/kDrIAtCOwLFH/0+XhnOxqu2y32PRV+7/wmf5LOKnEuakWW/gQvV+xeRGcyRhdP1Uvqf9HqSREHVEnk92H0yJS8vQ8cLaB/5LHdG1SJq6W4PZq7Peb99D24PYIn36JeTxoZfWpyB/Xy1tM50mqN1XoewZhxxVievvMF5DsMy50aJyntyfYOgcpNdaaBPlYnbvsQRT01DHcp7JRqsStnGQrEUVAYuMhnEXPyG29s4rQinXlZjb6JI4CxC9A6ZXFKQrGocH62DKZ0OCLgMi4AT48VWtm4RhdwWuxx8ro0qlF+IPMt8DILlmaSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB10191.eurprd04.prod.outlook.com (2603:10a6:800:22c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 13:56:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 13:56:44 +0000
Date: Tue, 17 Mar 2026 09:56:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] dmaengine: Add common dma_slave_config and split it
 into src and dst parts
Message-ID: <abldnCdb1R511CBt@lizhi-Precision-Tower-5810>
References: <20260114-dma_common_config-v1-0-64feb836ff04@nxp.com>
 <aa6t8QrrlearBOXI@vaman>
 <aa7Y20I2_Hlp63gk@lizhi-Precision-Tower-5810>
 <abksYB2WQ0oNDSbS@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abksYB2WQ0oNDSbS@vaman>
X-ClientProxiedBy: PH7P221CA0070.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB10191:EE_
X-MS-Office365-Filtering-Correlation-Id: cc332435-dd91-48aa-888d-08de842d05cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	udBajCE3VLggz8G090VQ5lKiaW8HC8t+H1dkV5ObVbvW38gQJlYD/C4oWcarRI/UKzpjhCc4c+0VdBSH03ZdbMLGVQwPvBw49ErJBVxNWybFE17dgOT9ExKBLPVBIsx6+mEJoQQw7e9XWF7FXbXYyEDh4L63dFwaTWIZmKwZiEfd78Zro4VGlhNr1dr9J9kKt9ucmLAuzguz9MsEbYeHhgWhirIfmV0O+Icje6OoyM7qqjsrazgER4mcqtf9mh/lKArTwPHr47GVbSlZuqeQgPX7omg4s+rPq4T4CDzLXP4hb81UtxZZJvZv8W57xGnQ4Udig/Erh3rb8DUBUi46MEG5jbtpkhlUvJEBoNWuDhi1CXbaIiP5b7bIH+J4N3B4hvbsSlrET2W9hcLUpfZ0Xa8cz4nRRnhrh0n3NjjW2VmsII3+P2ATTAdzV3teVs1MwJ3i2FMdpLXRoSPix+XDVbK6y6yfrhbRHZqH5JvXa1PT2EC/k1CWYXY7HTFibu5usyWi0GKd8ClelomDiU2DBicD/4YYv3h+ci/C9yTPL9EaCnOD7BmoIaY+fGo8EaNqqqnN+uIPpfEjJoN1/eNiyRP59R7Z/Czwz3e7t2jq7ZT/2cft/ORqzgqwbjAuK3H4JQ8Ro59CWj1fBHf9DZJ4QPYg6/lqjlefl4aef09OHeEYndW8Dk9yqBRNWTb1ru4UUKK+0PHbpKeGkS9AzBj9k3rxG0RTxsU1LiwDhXYZCrWq/BzIS4y6AZU1gXEWidCdzTMMghEQG7XZ173QEliPU5Dd8fQuwIzobRi8sC4anz8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Z38TtnIRurJ73lP3iOPQaCKqrqbmg/2dLc9/xBo0vx2D/EBvP1KeY6rzvWn?=
 =?us-ascii?Q?KGSku6ShTVXjb8iaKyJmMZipnDeOezIibGDQmgsgr5WLKABMxzS2wyb1wS9c?=
 =?us-ascii?Q?AfaY/ErHgTeMhK0WYYemEugujMt55FMnlV54C6v7PASkXniQmjOkr+beIPkf?=
 =?us-ascii?Q?+k4T3Hm6ja5G4NIhDRYrL52F1zZiHZAZMEt0x7jLPoEUz4/dj/x79mCR19W8?=
 =?us-ascii?Q?qISf7gHzJT5kC5ydf1gNzfeePKpmF9eCI197/I4YZ5boAhsZ4LRvFSTJQxwV?=
 =?us-ascii?Q?3HugnX0PvBGolIXI5xZen96Kd8USdHifH5IXAUgvrjqZ4eg1d9iEMA2ptYmu?=
 =?us-ascii?Q?lE+jCgqcehRj5Wqnwin60kG+ULdmTqmiYJurppG7ThW57zpbPQ24N2CVFgqe?=
 =?us-ascii?Q?9GeWboEfq5EsF5e0ecgQrdMTwHzzoCqSO0M6e8I/5b/Aypd08QpgY4zrhek2?=
 =?us-ascii?Q?YPytNRVbUMKyi4lmYUG+X6WXCEr3ODfHOq9U/p45heehL5SfiLTibV3rMyiX?=
 =?us-ascii?Q?GrTm7hcT8kmloXZlGjX+mh5Lj84MFdUZM8d+LgxKcY65DWELjumBpGujknGS?=
 =?us-ascii?Q?9pyVotPZ0hX8wpd3P9DoYQNLPFw6C7qXzVl+7n3BnbnNszc3JBEzp2UBp8BG?=
 =?us-ascii?Q?qT5Q4kgUNrMGrLZdKqGYqNbKpiKEbDS1tLkhR1hhpc8qAFzToqLuV+ZrY0eN?=
 =?us-ascii?Q?Ea+WP7C33lm62PK07+MRTiPdpCn/psl/2eMYcQeCrUhGin+gC8DBLIeV+0cl?=
 =?us-ascii?Q?wkRIe401PxrcSeWGAvqZNWV8yOOIcwB+1ffFptgSbkPWv+ydZLjtrP1Nx2SX?=
 =?us-ascii?Q?/N3CACP20dlxaxa7JNyqQGEwLz/rGyK+BJ4+4grHzqGMjJqRIL1yVvCcs8ec?=
 =?us-ascii?Q?Po5QRVjoC9bdj5r7e1Tfv9swPxk6wqNmz07XrHzicM8i940j9W5LEQC1Fqtq?=
 =?us-ascii?Q?O+CVuj2JE4yZx8nIUqIkgumUkgEtOLXLyBVN2q1kuSGtNfbtpRWF8oBfPVCk?=
 =?us-ascii?Q?iqCPoMI+8G+zahiKuwwC6F8qmy55TSS/ARyc3N5mhXZbDiPC7J8A9Z8EAZlQ?=
 =?us-ascii?Q?5KtIn0kqRUoN6gtfy29PjMqKuDm3Ubp5Qebt7FRRcLBus74W6Lxll2btgS8B?=
 =?us-ascii?Q?XYVkXM+qbr6vQcADPSl3PcGHK6nGVO70lUu97+gsyfXF/Q8n1rU3IaSs8K58?=
 =?us-ascii?Q?Z9VVyqFt8WLD2DgKZQQTr/VHRaKW8tvE4r7cLL+6hoMnB2r8Y7AcffOIEq+7?=
 =?us-ascii?Q?X5qtLHl/92a0tM5D2vtNEyyIfm7ZHH0VYI4QscLPjrkYoWmQVFUtTeYo7fYd?=
 =?us-ascii?Q?Tsk7SKvfo+FkgnuzpNKIeTqcpFtF+tEenN2ujokSA/u682Mz/3H/TH/2rkJ3?=
 =?us-ascii?Q?ncG3osLBillN/TnS7q1dRm8OU5jfIDHJ0DdDwnLe8N1dEK99Xfrc6M/fTTxt?=
 =?us-ascii?Q?1ry4Gh6t7wE+EpHJZDkaKygA83WC3Z2AI4HGaHlvLyYiCwyrISs+SZY2FnEZ?=
 =?us-ascii?Q?s1Le7pyI+tOTnTTeTdm09FESZ7Fm5kcrBI/2MK4LxeWRCveghlLoxC5+olR/?=
 =?us-ascii?Q?HR+qDm0BXO/cO9ELzH9iJ5MNfIIOxjRm11lYiXLas3vto/Gr/2gN9yUiA4tv?=
 =?us-ascii?Q?WB1wdkUJ22v0ms+x8vK+sc3dxkwQfqi3gWn9KXrOsPRQM9U3kXYklyxlL3lt?=
 =?us-ascii?Q?2yj3osVNTEqo8Lls6oUELWjBxHL6KxVgeKVGpm8ijWiC0Fuk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc332435-dd91-48aa-888d-08de842d05cc
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:56:44.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUmZlrgH7+oyPaSfsuxu6zt5ZuHEPC6e1RJMS3mm73XXG3pdvEX1oEXipmS7YJtbhKdhJi3FB4E91kpFS+qZ/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10191
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-9481-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D7C32AB4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:56:40PM +0530, Vinod Koul wrote:
> On 09-03-26, 10:27, Frank Li wrote:
> > On Mon, Mar 09, 2026 at 12:24:33PM +0100, Vinod Koul wrote:
> > > On 14-01-26, 12:12, Frank Li wrote:
> > > > Many DMA engine drivers store a dma_slave_config per channel. Propagate
> > > > this configuration into struct dma_chan to avoid duplicating the same
> > > > code in each driver.
> > > >
> > > > Much of dma_slave_config is identical for source and destination. Split
> > > > the configuration into src and dst groups and use a union to preserve
> > > > backward compatibility. This reduces the need for drivers to repeatedly
> > > > check the DMA transfer direction.
> > >
> > > The reason why we had both the src/dstn sides was intended method to
> > > allow upport ofr device to device dma. Some interest was shown for that
> > > at that time.
> > > I dont think we have such a user even now...
> >
> > My means is the field name is identical, not value identical although most
> > case is the identical. but it is possible, especial FIFO space windows,
> >
> > sound/soc/fsl/fsl_asrc_dma.c use DEV_TO_DEV, at least src and addr use
> > differece address.
>
> Yeah so this would break if we go ahead. Thanks for looking this up

Sorry, what break? This patch just group these informations.

Frank

>
> --
> ~Vinod

