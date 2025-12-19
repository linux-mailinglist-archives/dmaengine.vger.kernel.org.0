Return-Path: <dmaengine+bounces-7819-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFCCCEC6C
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 08:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B787B301B817
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4359723F424;
	Fri, 19 Dec 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lQr7gcbd"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010015.outbound.protection.outlook.com [52.101.228.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B8221B9C1;
	Fri, 19 Dec 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766129007; cv=fail; b=pXZFuXLR9HrgMWshjIxAmmmfchbbfcXauTGfNo3rrQK/dgm3NxODxU0XsThUOFmFDcx3EQXgn970fK3miydmLKWkkkyS+pTejyiYWLTVmPtGKh1DVTCkmh1fkFvOgRLuVSdNxFIk65JrCzpx3rra2RVK8Y8optZU5iZraEfldhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766129007; c=relaxed/simple;
	bh=NQOuR6oTW4hqAWJPMZDJxvaLGGJR4gDYISKthtDjuiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kZsE+TWl9GGVRgqqfgj9VmbNsJIMZsj+Ci0mKuzWjmNX6ddkuWd4SlSVuX0Bj59BONuMu/Bitm5gW1X9S6In4e0FJf9mFdLJ3YiT1TxLii22CagNljZE9H8+rv82yT6Oyc0EuwkYBy58Ug5pjerAn4DsOIfeybCWLq2tdMSlYsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lQr7gcbd; arc=fail smtp.client-ip=52.101.228.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP1worhae/yaOpOVbUxDgQV5livR0Eb90YSBbeSSBDAeKgOuTNALi3Ez5pQkHJBm86qts1TwZR+Sv9grPT1mS0ousY0vpCZicX3IsEe7a9YidTOzZxl1CbZiNevZgmjE15ffRWSW5dmP0PjubAINkT7JGrtqjKIw4uNqRLvlaf0B91eQjHNxgIJHmyhdCMLc1rTQEEx9z7ZRIlesDFCiCEKVD6MTKrasie4QZsV7nkMoT8/GtplfCLFS8HIsBQcLCH5hRtI7M3MQJrHfP8lxyBVPYynXZuLR/04Hq/QVo9M7NqQMH/3pac2TeYn173pY0l/HuEkyUpsuWsRL5E4fSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96bL59ETmZXyoR4ik80E4zQR4KcV9K4tg7V0elOvY2c=;
 b=L8pvja/AElq6hvWtvC4Za556k1/TFsETD+hfIVqMh5w3LU7KU/C2/FovRPUt/2nmriHCAnYqq8UFkgkHgnBI/cbWoyy+X3D6muprj0X6gJV0CUyFL283NCAzfdioo98ldl6yW/WelRK3HjaMozHpwJIJelq3MFawF3lqGpGDneeUEg4/oHN9FY6djkpKJs72k6YiEcbc34vvRFH69vkMTb6DeIanm3vGHjv560n+yDSQ5LIb74tT/esQuqgmDyBT9rEz04BTlu598IYLv0rQXY3UX/Oxfj/yMJw9wJXsrGfIEeOWNeis7Jo1ZK38YsHv4Ujw76gpoZq3YYu2nwMxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96bL59ETmZXyoR4ik80E4zQR4KcV9K4tg7V0elOvY2c=;
 b=lQr7gcbdWfobSDPbbfvAW2Y2k25VZoTZVRVSHY2hA2ljwxjU4+FQnONc7Mxn1VD0D4oQD+73WZQeM8fO/l8pM1mR1OWj9iFPV7WrZq3rQVo60qhJGnqQg/gxcy/fR1GaRpZOOFif7yUzmiKfRjKIwQfZ/Y2+ZsNGTXxBmxz2s2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2957.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:308::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 07:23:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2b5:5bff:7938:b48c%7]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 07:23:22 +0000
Date: Fri, 19 Dec 2025 16:23:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be, magnus.damm@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us, 
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com, 
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 02/35] NTB: epf: Add mwN_offset support and config
 region versioning
Message-ID: <cceh3rea3k66awhnkp5jnq7liuyxq6hb2fkuxlhexnfuamxhph@jifoggj5t7ql>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-3-den@valinux.co.jp>
 <aUTER+i1707eGdqN@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUTER+i1707eGdqN@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2957:EE_
X-MS-Office365-Filtering-Correlation-Id: 00880394-e1ab-4027-eb53-08de3ecf7da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQnDQU2SQhc2AaDDFRdzXz1/LZ+83uIXqan9k3ebinNNQ0SsbGL3SRbGT0T2?=
 =?us-ascii?Q?C4WsmEIx4jVm8Ns1rZ16ZnuaEOnJE35liWssj7d3F/dwcdE/LzQqwk/3kpZz?=
 =?us-ascii?Q?W8f3+MZc62PJlvlC8wFfQQskMyI9Vq4ZrFNGuwFJ0x+PBysEaHM7MxqH1cIo?=
 =?us-ascii?Q?skipHUuLT76p2ZNRA0tgJ5oOikCdgpkznzqYHeU3tbS0jriOhrac2hef3Wx0?=
 =?us-ascii?Q?fF7uq7qKMyjHOUVXY3NdHZDoLV1LfBHxbJ4q1ea10ehzba2LHckZxC3e5fdP?=
 =?us-ascii?Q?TUkm8QYVhkEqko1dKeOsa/p3OIfnDFoKsMsuCN33e0hCLVrucYvJFoBlKnLQ?=
 =?us-ascii?Q?pl0eum0uLQEOVPant0737ronRL0VmnhHLM7Zq4X8XLFWJGsAQYVi7BnQ0cFu?=
 =?us-ascii?Q?NPHgI98HRRDiCt19yR+1q16gbDfafi/NEdGJgrqumtUj6Xo4uyX4DJyXSLf8?=
 =?us-ascii?Q?iB6RTS77OrY1TR8P8apOG67BtGkfCHyuuOXuBBtoKzK5QMGtEMWXC4vO8Xyo?=
 =?us-ascii?Q?Xomjya3bMJrw7qZZoB1+4GGF/kx5CR1sCNv4zDezWcQdLEyNrpLu65nbiGBj?=
 =?us-ascii?Q?f7XXwyE5peIBDFS+M7tNiS2wilpR8uaDTP+S7oQ66CrJawH6Cly9uq+8uKKq?=
 =?us-ascii?Q?VV2MzhieOtnEVWaLIydD/y3fV1LBtyBlN8ojKBPdMm4c839y1ZP7ZphKWQ73?=
 =?us-ascii?Q?GXasDsIslOA3l9VtpOBD39SSru+MyqhAbr8Mb6kYoZOb+SJEfxa5+q1w8w+c?=
 =?us-ascii?Q?+tD1QYu9vUxS/U3qs/+K4TFh68YGMeGYBaN/fu4eZ3zJMJONiL23cmMlEgtv?=
 =?us-ascii?Q?yATJjj0xipH4lyc2LTxEc4EkBJe2UYEZZUK7I7cxNOrqJagWNPKp8gl0rZPS?=
 =?us-ascii?Q?nJvkczhTsvRRK0NGNVn8fCaYCkvi+/tq4xc0aG2f9BeKvkagz0w30W03CoWl?=
 =?us-ascii?Q?2M70m4r8Osh8NQPiPgEVVUOd1diD71G/7xPeKdRjcSWz+3lOsPdfAc1Szzpb?=
 =?us-ascii?Q?Q2YUAzJtUNbUHfnWPtifVlvwVr6bJdH6Xv4rGWe3zbILNfzQ+AusduF1iwkk?=
 =?us-ascii?Q?9d9wyamoBBRJiMXSFdV4ZJQf0aTdMCq2GeyXL4MNjuFZgIhoeKzgggmbdMT/?=
 =?us-ascii?Q?IIeXfLddsw6mg0wsODf8NYgjXkFXPQGtdZAk0VGW98ZLM9FMlUazbHg4K6tz?=
 =?us-ascii?Q?Lqjia3SYCAIxeOBaIe9uQdOEwygOMdjOHrNYMOK0iZ/uUpMFTI/DD0S08qgI?=
 =?us-ascii?Q?AKrPnnefe11KIZfNp2FJSOBhJtTUiYZP4pd7FrRJBj1twtP6ERSAWiRlWd0v?=
 =?us-ascii?Q?b2Fpq7zeIBvafh1j59CDsZ3Z0c4kZcQ3XAjQCu+onsvr4YxsOVzMbl667LuV?=
 =?us-ascii?Q?vGveZZYJ8f9RtMBwatkshhkcoFnUXdn+T8m05Rvy5EC7+kOwsqF/0bTOieGQ?=
 =?us-ascii?Q?HpIvw3CRQ2C+S3EH0S/gevGHFwCsiN+L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ccff+zyZ07idbMDUDRU3AFchG3Bjr4RuCkZzGgXRZoCXP4pYUFaO2eCYAOQK?=
 =?us-ascii?Q?grvRX2cygkaIsumfAQ6OeAyBpAi767xYWVcxI02vORdgIYoYjji5DmyNx4jt?=
 =?us-ascii?Q?EEpthv1m007/ROrparH7kvFhok17o+K1sYKfUkkl0hRiRM0B9zGXkm3Sma9f?=
 =?us-ascii?Q?krGL7ozlEhobDB1hQChTPaTChgAUINh8s3wFRupwRvQWpsIsq86zByBH6PvD?=
 =?us-ascii?Q?Alo+TUCExbRsWBzs83/MyEt1tNlSL0VIYKhgrPb1WTBVP89dP7NCUq9AqX7A?=
 =?us-ascii?Q?ui66agWTx5f7WIjKN/w4mVn+074rTgIy39AxNLOxMe2o8XddRWy8V7Ilzo72?=
 =?us-ascii?Q?6zbO3ZXaNCByRxww4bpRqB/3P9793IIxojNvs46DWYOkynV5Nc5VED7pWz9V?=
 =?us-ascii?Q?JdfPo7qJx2CsBPcRbusMo4pEx3xEOSnviydVJ8odaSVJAT1XMiKlz1j+m/Bs?=
 =?us-ascii?Q?1zd0MKt1LPw5/QiH163OnViaMuIwUWqKmCcBYD5HAhvHZSqYRj8xZAs4tWox?=
 =?us-ascii?Q?BhtqUhabo/Oy3ltVkeaTjR/6qyBkXBBHF765wDNSSABbFH7RF4xBY/DEKQSS?=
 =?us-ascii?Q?nUTgGCWTtsDR9OwIv1AUqF57zydqt+l1qyvfnOBIfTRVBs1Eg958twigX5c3?=
 =?us-ascii?Q?+GdJtshFrs7PT6WG048FklaGS91ESzJe3EuZumNBUxak+0Z0LqRWA/EP+xq9?=
 =?us-ascii?Q?Be0MLHJPv6LdDmYFDue6M65phSi4mStwlC1R0x0svw36VUloeX+SFUGBUyp1?=
 =?us-ascii?Q?aZ5HnVNXML25KtgrsrHVF0dMhoWpLd2BLMDS34jMrSNp1GtljexT+ji0DF+S?=
 =?us-ascii?Q?iFoA95ZJ+GIxOLZzDeyc3wut615B/V1dh4bmdT3ncG5t2Pb3YJnSJaO01UWh?=
 =?us-ascii?Q?NTSVr/QiG3z6ZHw9F4vceWjdPcA/ZCcqtxmq11t4VZzss95mucMCSKgfioVj?=
 =?us-ascii?Q?sgMMzklZ+Fw36aWYfdQUHyE6TUjcLZDkgoRIuWNpxUx7xSO6UwKWsEXC03Lp?=
 =?us-ascii?Q?E/T+CV1dFNnwNypao6RkgpomhYQd9mGrNxZLuVUFAigrxQA4lHiKfoc1aFh5?=
 =?us-ascii?Q?nBaVfoHN6iC5SsUw2ZzaSgcXbAQbRQH/vfCMYOcxbaI+76gJCfUvdSgdW0nj?=
 =?us-ascii?Q?rf47UJo63HQ7bDlUNOP20Tk5T4pErsSBIqFPKv6Z/bjFa++6l8qPq3p6YJlU?=
 =?us-ascii?Q?I1AKzCbYOwgFt4Nte35l3FHrBagJ2MEI8nhnagaCvWweUGxtCOr5L2wry5Am?=
 =?us-ascii?Q?MsiK98PqugjFLojck7QAwRT+3m5pIIwbXEXIMsB+W0icvlIezoTUb7Zq08nc?=
 =?us-ascii?Q?jUd0Y5KqijUSnUx2EEEwDFZ7u5D3JT4LcEzdgoQNVDrriXMs8umD0dgRQkrb?=
 =?us-ascii?Q?byJ4e7ynrWGRKUGr7JOETXqEuTSCry/vAlpdhwGr9V0w0KQdZZP4ija2TG3j?=
 =?us-ascii?Q?Ytx5Ro7673D4UNRru1oHiE+36Gzr47rzye7e7b+x0E6cM6F/GMbbybvxMQz5?=
 =?us-ascii?Q?E8ZxChcHJ48D/67RZbF5MUm8rPr23Emk6FOTfQdMAbvCos/3wQXVSVD7THJG?=
 =?us-ascii?Q?Xu9W2/XMjrRGJBzyjtyaZvaK5cnNP89rGo7dDXR/o0Xu2JR0NNDgBzJeb4DO?=
 =?us-ascii?Q?60o3RIe88mZxZS8nP4sw0Xg=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 00880394-e1ab-4027-eb53-08de3ecf7da8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 07:23:22.1080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wAYKQQD7wpIKziLASPRRkkp2XiQUEUyrmIimwEl2JzmWctPNUelSvdL3WzkomozOC7V6Oh+h1gAqgMHXEBO0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2957

On Thu, Dec 18, 2025 at 10:19:35PM -0500, Frank Li wrote:
> On Thu, Dec 18, 2025 at 12:15:36AM +0900, Koichiro Den wrote:
> > Introduce new mwN_offset configfs attributes to specify memory window
> > offsets. This enables mapping multiple windows into a single BAR at
> > arbitrary offsets, improving layout flexibility.
> >
> > Extend the control register region and add a 32-bit config version
> > field. Reuse NTB_EPF_TOPOLOGY (0x0C), which is currently unused, as the
> > version register. The endpoint function driver writes 1
> > (NTB_EPF_CTRL_VERSION_V1), and ntb_hw_epf reads it at probe time and
> > refuses to bind to unknown versions.
> >
> > Endpoint running with an older kernel that do not program
> 
> Is it zero if EP have not program it?
> 
> > NTB_EPF_CTRL_VERSION will be rejected early by host with newer kernel,
> > instead of misbehaving at runtime.
> 
> If old one is 0, try best to compatible with old version.

Ok, I'll do so. (If the overall direction of this RFC v3 will be agreed
upon, it will be addressed as part of a smaller patchset maybe.)

Thanks for the review,
Koichiro

> 
> Frank
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  44 +++++-
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 136 ++++++++++++++++--
> >  2 files changed, 160 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > index d3ecf25a5162..126ba38e32ea 100644
> > --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> > +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> > @@ -30,18 +30,22 @@
> >  #define NTB_EPF_LINK_STATUS	0x0A
> >  #define LINK_STATUS_UP		BIT(0)
> >
> > -#define NTB_EPF_TOPOLOGY	0x0C
> > +/* 0x24 (32bit) is unused */
> > +#define NTB_EPF_CTRL_VERSION	0x0C
> >  #define NTB_EPF_LOWER_ADDR	0x10
> >  #define NTB_EPF_UPPER_ADDR	0x14
> >  #define NTB_EPF_LOWER_SIZE	0x18
> >  #define NTB_EPF_UPPER_SIZE	0x1C
> >  #define NTB_EPF_MW_COUNT	0x20
> > -#define NTB_EPF_MW1_OFFSET	0x24
> >  #define NTB_EPF_SPAD_OFFSET	0x28
> >  #define NTB_EPF_SPAD_COUNT	0x2C
> >  #define NTB_EPF_DB_ENTRY_SIZE	0x30
> >  #define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
> >  #define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
> > +#define NTB_EPF_MW_OFFSET(n)	(0x134 + (n) * 4)
> > +#define NTB_EPF_MW_SIZE(n)	(0x144 + (n) * 4)
> > +
> > +#define NTB_EPF_CTRL_VERSION_V1	1
> >
> >  #define NTB_EPF_MIN_DB_COUNT	3
> >  #define NTB_EPF_MAX_DB_COUNT	31
> > @@ -451,11 +455,12 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> >  				    phys_addr_t *base, resource_size_t *size)
> >  {
> >  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
> > -	u32 offset = 0;
> > +	resource_size_t bar_sz;
> > +	u32 offset, sz;
> >  	int bar;
> >
> > -	if (idx == 0)
> > -		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
> > +	offset = readl(ndev->ctrl_reg + NTB_EPF_MW_OFFSET(idx));
> > +	sz = readl(ndev->ctrl_reg + NTB_EPF_MW_SIZE(idx));
> >
> >  	bar = ntb_epf_mw_to_bar(ndev, idx);
> >  	if (bar < 0)
> > @@ -464,8 +469,11 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
> >  	if (base)
> >  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> >
> > -	if (size)
> > -		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
> > +	if (size) {
> > +		bar_sz = pci_resource_len(ndev->ntb.pdev, bar);
> > +		*size = sz ? min_t(resource_size_t, sz, bar_sz - offset)
> > +			   : (bar_sz > offset ? bar_sz - offset : 0);
> > +	}
> >
> >  	return 0;
> >  }
> > @@ -547,6 +555,24 @@ static inline void ntb_epf_init_struct(struct ntb_epf_dev *ndev,
> >  	ndev->ntb.ops = &ntb_epf_ops;
> >  }
> >
> > +static int ntb_epf_check_version(struct ntb_epf_dev *ndev)
> > +{
> > +	struct device *dev = ndev->dev;
> > +	u32 ver;
> > +
> > +	ver = readl(ndev->ctrl_reg + NTB_EPF_CTRL_VERSION);
> > +
> > +	switch (ver) {
> > +	case NTB_EPF_CTRL_VERSION_V1:
> > +		break;
> > +	default:
> > +		dev_err(dev, "Unsupported NTB EPF version %u\n", ver);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
> >  {
> >  	struct device *dev = ndev->dev;
> > @@ -695,6 +721,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
> >  		return ret;
> >  	}
> >
> > +	ret = ntb_epf_check_version(ndev);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret = ntb_epf_init_dev(ndev);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to init device\n");
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 56aab5d354d6..4dfb3e40dffa 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/atomic.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> > +#include <linux/log2.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >
> > @@ -61,6 +62,7 @@ static struct workqueue_struct *kpcintb_workqueue;
> >
> >  #define LINK_STATUS_UP			BIT(0)
> >
> > +#define CTRL_VERSION			1
> >  #define SPAD_COUNT			64
> >  #define DB_COUNT			4
> >  #define NTB_MW_OFFSET			2
> > @@ -107,7 +109,7 @@ struct epf_ntb_ctrl {
> >  	u32 argument;
> >  	u16 command_status;
> >  	u16 link_status;
> > -	u32 topology;
> > +	u32 version;
> >  	u64 addr;
> >  	u64 size;
> >  	u32 num_mws;
> > @@ -117,6 +119,8 @@ struct epf_ntb_ctrl {
> >  	u32 db_entry_size;
> >  	u32 db_data[MAX_DB_COUNT];
> >  	u32 db_offset[MAX_DB_COUNT];
> > +	u32 mw_offset[MAX_MW];
> > +	u32 mw_size[MAX_MW];
> >  } __packed;
> >
> >  struct epf_ntb {
> > @@ -128,6 +132,7 @@ struct epf_ntb {
> >  	u32 db_count;
> >  	u32 spad_count;
> >  	u64 mws_size[MAX_MW];
> > +	u64 mws_offset[MAX_MW];
> >  	atomic64_t db;
> >  	u32 vbus_number;
> >  	u16 vntb_pid;
> > @@ -454,10 +459,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
> >  	ntb->reg = base;
> >
> >  	ctrl = ntb->reg;
> > +	ctrl->version = CTRL_VERSION;
> >  	ctrl->spad_offset = ctrl_size;
> >
> >  	ctrl->spad_count = spad_count;
> >  	ctrl->num_mws = ntb->num_mws;
> > +	memset(ctrl->mw_offset, 0, sizeof(ctrl->mw_offset));
> > +	memset(ctrl->mw_size, 0, sizeof(ctrl->mw_size));
> >  	ntb->spad_size = spad_size;
> >
> >  	ctrl->db_entry_size = sizeof(u32);
> > @@ -689,15 +697,31 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
> >   */
> >  static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  {
> > +	struct device *dev = &ntb->epf->dev;
> > +	u64 bar_ends[BAR_5 + 1] = { 0 };
> > +	unsigned long bars_used = 0;
> > +	enum pci_barno barno;
> > +	u64 off, size, end;
> >  	int ret = 0;
> >  	int i;
> > -	u64 size;
> > -	enum pci_barno barno;
> > -	struct device *dev = &ntb->epf->dev;
> >
> >  	for (i = 0; i < ntb->num_mws; i++) {
> > -		size = ntb->mws_size[i];
> >  		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
> > +		off = ntb->mws_offset[i];
> > +		size = ntb->mws_size[i];
> > +		end = off + size;
> > +		if (end > bar_ends[barno])
> > +			bar_ends[barno] = end;
> > +		bars_used |= BIT(barno);
> > +	}
> > +
> > +	for (barno = BAR_0; barno <= BAR_5; barno++) {
> > +		if (!(bars_used & BIT(barno)))
> > +			continue;
> > +		if (bar_ends[barno] < SZ_4K)
> > +			size = SZ_4K;
> > +		else
> > +			size = roundup_pow_of_two(bar_ends[barno]);
> >
> >  		ntb->epf->bar[barno].barno = barno;
> >  		ntb->epf->bar[barno].size = size;
> > @@ -713,8 +737,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  				      &ntb->epf->bar[barno]);
> >  		if (ret) {
> >  			dev_err(dev, "MW set failed\n");
> > -			goto err_alloc_mem;
> > +			goto err_set_bar;
> >  		}
> > +	}
> > +
> > +	for (i = 0; i < ntb->num_mws; i++) {
> > +		size = ntb->mws_size[i];
> >
> >  		/* Allocate EPC outbound memory windows to vpci vntb device */
> >  		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
> > @@ -723,19 +751,31 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> >  		if (!ntb->vpci_mw_addr[i]) {
> >  			ret = -ENOMEM;
> >  			dev_err(dev, "Failed to allocate source address\n");
> > -			goto err_set_bar;
> > +			goto err_alloc_mem;
> >  		}
> >  	}
> >
> > +	for (i = 0; i < ntb->num_mws; i++) {
> > +		ntb->reg->mw_offset[i] = (u32)ntb->mws_offset[i];
> > +		ntb->reg->mw_size[i] = (u32)ntb->mws_size[i];
> > +	}
> > +
> >  	return ret;
> >
> > -err_set_bar:
> > -	pci_epc_clear_bar(ntb->epf->epc,
> > -			  ntb->epf->func_no,
> > -			  ntb->epf->vfunc_no,
> > -			  &ntb->epf->bar[barno]);
> >  err_alloc_mem:
> > -	epf_ntb_mw_bar_clear(ntb, i);
> > +	while (--i >= 0)
> > +		pci_epc_mem_free_addr(ntb->epf->epc,
> > +				      ntb->vpci_mw_phy[i],
> > +				      ntb->vpci_mw_addr[i],
> > +				      ntb->mws_size[i]);
> > +err_set_bar:
> > +	while (--barno >= BAR_0)
> > +		if (bars_used & BIT(barno))
> > +			pci_epc_clear_bar(ntb->epf->epc,
> > +					  ntb->epf->func_no,
> > +					  ntb->epf->vfunc_no,
> > +					  &ntb->epf->bar[barno]);
> > +
> >  	return ret;
> >  }
> >
> > @@ -1040,6 +1080,60 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> >  	return len;							\
> >  }
> >
> > +#define EPF_NTB_MW_OFF_R(_name)						\
> > +static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
> > +				      char *page)			\
> > +{									\
> > +	struct config_group *group = to_config_group(item);		\
> > +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > +	struct device *dev = &ntb->epf->dev;				\
> > +	int win_no, idx;						\
> > +									\
> > +	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
> > +		return -EINVAL;						\
> > +									\
> > +	idx = win_no - 1;						\
> > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > +			win_no, ntb->num_mws);				\
> > +		return -EINVAL;						\
> > +	}								\
> > +									\
> > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > +	return sprintf(page, "%llu\n", ntb->mws_offset[idx]);		\
> > +}
> > +
> > +#define EPF_NTB_MW_OFF_W(_name)						\
> > +static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
> > +				       const char *page, size_t len)	\
> > +{									\
> > +	struct config_group *group = to_config_group(item);		\
> > +	struct epf_ntb *ntb = to_epf_ntb(group);			\
> > +	struct device *dev = &ntb->epf->dev;				\
> > +	int win_no, idx;						\
> > +	u64 val;							\
> > +	int ret;							\
> > +									\
> > +	ret = kstrtou64(page, 0, &val);					\
> > +	if (ret)							\
> > +		return ret;						\
> > +									\
> > +	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
> > +		return -EINVAL;						\
> > +									\
> > +	idx = win_no - 1;						\
> > +	if (idx < 0 || idx >= ntb->num_mws) {				\
> > +		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
> > +			win_no, ntb->num_mws);				\
> > +		return -EINVAL;						\
> > +	}								\
> > +									\
> > +	idx = array_index_nospec(idx, ntb->num_mws);			\
> > +	ntb->mws_offset[idx] = val;					\
> > +									\
> > +	return len;							\
> > +}
> > +
> >  #define EPF_NTB_BAR_R(_name, _id)					\
> >  	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
> >  					      char *page)		\
> > @@ -1110,6 +1204,14 @@ EPF_NTB_MW_R(mw3)
> >  EPF_NTB_MW_W(mw3)
> >  EPF_NTB_MW_R(mw4)
> >  EPF_NTB_MW_W(mw4)
> > +EPF_NTB_MW_OFF_R(mw1_offset)
> > +EPF_NTB_MW_OFF_W(mw1_offset)
> > +EPF_NTB_MW_OFF_R(mw2_offset)
> > +EPF_NTB_MW_OFF_W(mw2_offset)
> > +EPF_NTB_MW_OFF_R(mw3_offset)
> > +EPF_NTB_MW_OFF_W(mw3_offset)
> > +EPF_NTB_MW_OFF_R(mw4_offset)
> > +EPF_NTB_MW_OFF_W(mw4_offset)
> >  EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
> >  EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
> >  EPF_NTB_BAR_R(db_bar, BAR_DB)
> > @@ -1130,6 +1232,10 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
> >  CONFIGFS_ATTR(epf_ntb_, mw2);
> >  CONFIGFS_ATTR(epf_ntb_, mw3);
> >  CONFIGFS_ATTR(epf_ntb_, mw4);
> > +CONFIGFS_ATTR(epf_ntb_, mw1_offset);
> > +CONFIGFS_ATTR(epf_ntb_, mw2_offset);
> > +CONFIGFS_ATTR(epf_ntb_, mw3_offset);
> > +CONFIGFS_ATTR(epf_ntb_, mw4_offset);
> >  CONFIGFS_ATTR(epf_ntb_, vbus_number);
> >  CONFIGFS_ATTR(epf_ntb_, vntb_pid);
> >  CONFIGFS_ATTR(epf_ntb_, vntb_vid);
> > @@ -1148,6 +1254,10 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
> >  	&epf_ntb_attr_mw2,
> >  	&epf_ntb_attr_mw3,
> >  	&epf_ntb_attr_mw4,
> > +	&epf_ntb_attr_mw1_offset,
> > +	&epf_ntb_attr_mw2_offset,
> > +	&epf_ntb_attr_mw3_offset,
> > +	&epf_ntb_attr_mw4_offset,
> >  	&epf_ntb_attr_vbus_number,
> >  	&epf_ntb_attr_vntb_pid,
> >  	&epf_ntb_attr_vntb_vid,
> > --
> > 2.51.0
> >

