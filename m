Return-Path: <dmaengine+bounces-9280-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ELLKuepqWlSBwEAu9opvQ
	(envelope-from <dmaengine+bounces-9280-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 17:05:59 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DF2215199
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 17:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A8033068246
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725103793DB;
	Thu,  5 Mar 2026 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gNZfztZY"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620A28506B;
	Thu,  5 Mar 2026 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726640; cv=fail; b=AwqBmUgS9eHs16iKMWGuf9gztl4cnJZ8V/C6dXbRllltJCQ0CnCf4JBeg3JMseAdYGM4FB3Lxd88F84AXw6yTRbwK5gFMLzoiapZOdIsDVQiTL1Do3TTkEudwedlrZ0hwhuXqU8aPQZdUk/lJ59O4DUkFNR3c9XeIU45i7kdxlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726640; c=relaxed/simple;
	bh=DOvVIv6VzmwnEJWcCIieq8jieaNQ+DjoRQDFUqvxGJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tD62oOv8StJDrCMue4XNIa4fq9lO7E+pGKYTf/Sw1u+xEZMq4B5nl4N09n4cGBBdBao6G9Ktehx4PBj8lIxn0TklsZKLiA4hiFo0Bex858TY6KvvBZrTKxMbVhgYtLqxNep5eLgEQYHADOfUJlfaH/fj8s/5+uxEghpLsZzR3Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gNZfztZY; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfuZ42xU5cMGlU2cAvyue7/CyJs9+dSP26pmTlFjOkQyTX3hU50WTgK8QYrcFKaeNH0J55w7C3z0Wt4vNf6dtHzvuX+fKPK5aGOdbJsM8Fjor7XawnYKxMUNTkiFvwqgqf0vkzyVIVUB2TOlIX0urqW87TWCYSK0JuwiThy/sAt3Rz6fXWW0iP40IVZEzgYjgIQ6QybK5JEx6HnzcODwwUW8Uim9i7N/iwn3AhDxtD1rNu9e8sefNBLJSJ+gj5/RGtjguzUDgL7h+KPLDT5FB67Kg1pV0iBqrgpPxoHy3iD78aiRNlNT/1qRkKnegm0ytCtavpvTV2tXdtBPfWRXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTclqpw+i3KX76YrcvQ84XC49WE9kjnpC7aBlzZD0p8=;
 b=l4Dage/1y0A2TKgtUP4ZP+vSyiEyl2sri0s/XxOOd8hXvLQkb7islo060xOhM1HIQmwEsTG8ZfVJ8KhU7sHqYWBXq7gS/64sh0o23g4mnLOD2RiUmEe3XsvJ+kZcYIkZEIVSTMQAlrNGWKxjbwfh90UD+XpcA3oBMnVg9kWqKNQnX4sFub2LgLtnb1WoOW+j/q9DDaYc5cnpr3l4gx2Zc4GPdOaPWVI1me98qpKT4ZU3TuCQ8q2sZRbBEtVTZxDUBIkHI4vIeKFg9RqWdypDT5saV+opp53DPkxmrTyeFl5fRBzqo87KziGOgRMRNQ79vxTvo2gNFb2j2jIcH6BnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTclqpw+i3KX76YrcvQ84XC49WE9kjnpC7aBlzZD0p8=;
 b=gNZfztZY4SzdrCoJBhKgspj3UtOP7Mb2LRPtf78yrdF8Olg+/Mr/YzGmhcaKu2taEA0p9XaNgL8T73bPw0sdO/pFk3si709jdqStgPqKeHLZX3s6yYK3OM1Qi15gEvF2o26sUlkU8vysg1isJrBawI2KBMpGzRbpI5LiByXaxVA2F5jVL4PSPb/+7HjKBm5sSImj8AQd9mSCMcNrNZ+ZHa1GsAaTG+iawTB1+CvIfNsrg0tPUQSdV25fRU/gYaA/5nIMedJtslC/Wj8078HZXz1F6YIXSxyR2UhQauy+dTTP9XWfe967JYCQJcRoNyCKm1nR687uaXYGKDBehTIS4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10748.eurprd04.prod.outlook.com (2603:10a6:102:485::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 16:03:55 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 16:03:55 +0000
Date: Thu, 5 Mar 2026 11:03:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aampZJo-9UgzpIV1@lizhi-Precision-Tower-5810>
References: <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120E7C753B717E4C8B9E7819577A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZ4l4IHqObEP8DfP@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203E3A32F0670DB15D63059575A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aahkKZ9EBwWfwy95@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CE2DB5EB97512E51F76B957DA@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120CE2DB5EB97512E51F76B957DA@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: PH7P220CA0044.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10748:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fcc6d06-547d-4829-6ae4-08de7ad0cd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	mKLs3GjTnCzvAfPsZJHtgXeey+A5QvjJcl3bMe2qcWYeiZG1/sGZVe2JC5fCf/xzrCmQhotjMFd4pYKAYykPKZ4TRBKcIHC7ubJGPl7VQY6ZFiXUtloirTsgj8C2erGsS3Am+0qYV3fO7V4j34iC0lWMPCrqdGIs65MMGFg3v01Qf7sGD2MRqyEHNJ4horYxCEHZJEQUCR+ZU8I2Z21Ddzj2NZEQWa/T29Ri4Jt9qrdNqM4Izuxkv0IK3++mMFQHtOJULHj3NV90hMlW27b/VJnbcT2ZhDLCJooQmVY18+xe7Ei+EB6lQNARN8oKsdhTvmQRPa4CDW2Ah9DsJpdqllvt8GjKvSDOUZg6kOnmWohQGjHRG0G+rfxWipT5BC5JUhEqccAf8BNQUP7TG12cIOR1dQZKGeu1Iw38RG9SVzZWMOPyGj8tyegzzsT6uLmGC0+jIB+WhCr1PxMvZh++RW+hDAICQlEV/78Yv+kSf8RO+5IZ3VBAkzCgqVwQfhqborF643HAz/nyEqn4QzLZ3Wq4lGC0SS7yYNXagJWG3KcUHhw1f+nd8BMc727vSWLzXveCL9AORX/i+uji5vxntwz8EYHUDrvz5Tggmf4P5rx413+Rg9omRAgY3pellFTQVdH89xYI+vpVzgsZ4SxEGkdiJ4yBSWkcj44ZLEyGUvhzo+WuTnlUle10zx0BKq1E8iFYxlydK4NwO0zbD5R3KhhizEomgYDTm9JcqlysL0BA1MGUxiKpZ/nnUvCAHIqP38VIBWs+xJ856xgDGiEs25jl000v1OKIf2kx9rjcXT8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LpfaWbm8XfYMCMrHQYvbqMeNjEiqmwoJ503g+Ywq2YadW5ksKnJcX9klYUzK?=
 =?us-ascii?Q?JsSoWbE9hKAtlDxagaUXtKS+ixTKtfrWNZlJjab/mIN9ng3ehLEEVyFvRhpL?=
 =?us-ascii?Q?p5Zpz0AByAIPDaJB6IIYXHdRuaSuk6F3vU+IzBmWHwDm1OitgdR5opcCUo6f?=
 =?us-ascii?Q?V+KuefyyFLFrJ7cIAvKUJDpfJMB+m8tSmdjqbVsJbJguegpbmqgn8Ufl2mDX?=
 =?us-ascii?Q?hVwv1E8Xmt7CkpjHUWoD3cN+I+sXSxra7f5jPHosC7qN+7UDbv97UMhEjL46?=
 =?us-ascii?Q?CmG/QhE27UockDxDN29S+WYASpdTIkKOUKYRI/OOSTByiVUDpYLUCLbjPtdD?=
 =?us-ascii?Q?X1jtOoC3Pk75b8p6vsRr5BYsqnpVDb0jsBM38QKMzpjzFufgzEKCuVdjJrDA?=
 =?us-ascii?Q?7FHIOPwz7FTp1It7aMm7+6ODrwe1iFLChEuXDmG5x5RW1PBtXoHkBguXWYzQ?=
 =?us-ascii?Q?P0P5uAnXETRf9sy45vYBjOL3+Y8QXHexHFbupWdsrxNPx2wibNs6sH3fJLxl?=
 =?us-ascii?Q?1m/2mvGbuIyaCO/jqyXf3iUZB6Re0q2htHoy+yHY9u4srKPkOMGekFuP9V0T?=
 =?us-ascii?Q?BHNWc/msJ4MsZIdeIMizzpEdtafgmFh/Bwx88dgddvxjcxm/4StYAAdaOn+E?=
 =?us-ascii?Q?kTFjVX2qBVSjxDNhsJz8Xy8gE3Z1gtppSNpOR+guVCvBDXqHh3aF2UbeTXtE?=
 =?us-ascii?Q?j9lNnsRolfAN1SZKFeNJtVcC2rmoAUFn4P8dJh2CpAOp+dAxSqhOjlnAfJlD?=
 =?us-ascii?Q?fAgIv+kDYlAxO36psNECm/F1j2cYfw+zq2YHSYkcQwCjrGH/FXK3P77cDb60?=
 =?us-ascii?Q?98BwkeABswaYl2IsvyveuZy4PZBzMo37jxmiTYfYtROoKAsdhbkg5ybH10MX?=
 =?us-ascii?Q?bGi/ZC3NNb5djb6mny/B33L5TO2Ls5rNvWmT9ge7XW9JGmUAXBVwaHO35Ehu?=
 =?us-ascii?Q?jUkW2+PeQEc9eA6gPsZC5o/qhJkHYKgGSYRl6zuy7p7DUEZdjWaNABvxcHTM?=
 =?us-ascii?Q?xgEdzjfBf5vtUpWELCib55mk6k0szQJIneKEjDlhojC0Oon0Q29GBs3IxivT?=
 =?us-ascii?Q?DzNecxyUsXs1VYeP0N1uceV2Bh9ce7wYQ5BkVZLbXjhGgByx2A6ai+VF5UAA?=
 =?us-ascii?Q?fXoIrfORXuJT4eclFydCrkbY5idFlEb6u4POzUNYg8OA2wVvrcEOorn11LD2?=
 =?us-ascii?Q?p9EsO3yVc7rVKlHqFMVa7usXypfq4JmASd08JLjSXFWyI7hdPPbhm790xwOR?=
 =?us-ascii?Q?br/7DhUAVLx+NItCHT4rzSpLS/9+kqoMejCi+uJTgMiaT2In/RtsD13/Bwbp?=
 =?us-ascii?Q?oz8cepc7tuT8BnCpERF8kikYUe81RzgKIOwkQ+ibmkDBvUWqEo9UnkljfOmq?=
 =?us-ascii?Q?rzSdFolHQluovPhydpIVm5g2tJvxxKXpY/IG8ytuNnmBsbRiWyCUcb0ePQKM?=
 =?us-ascii?Q?7mpAIQ7iq+65Dy3voy/1UBOfUisF/ZBI2bFVTZF3sh74MWnD+Qo7kI5kFIO1?=
 =?us-ascii?Q?2Yugzf0B7jkVWxNf+BdQHQRzUSkD1JGTSCTvFXYvPA6eI939mnUsn+0W60kd?=
 =?us-ascii?Q?U31gVcGXgXYsUb/S9DyWABc+2LU0OBEZmd6Wd1WGttkt+xh0BmpRMOWP0HFy?=
 =?us-ascii?Q?jeS+yW+FqlTb0jGPo65kRTrCOCg8uxNXNM1bW0IWjBDYPGv5qjUrIUHPFjRn?=
 =?us-ascii?Q?TTgUDBJcYhMupLmIREu8fajUgXvqwWcxnTl0VYlyoR94D/1u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcc6d06-547d-4829-6ae4-08de7ad0cd98
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:03:55.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KT8Tt+z2rhMdEEfBuxeIuD8sA/VNLypPc7w+K1Klltw8JwaWENPb/hygkVSSY+tVa2u3DLIrXEC46ZOwq0XE3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10748
X-Rspamd-Queue-Id: 15DF2215199
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9280-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,nxp.com:dkim,nxp.com:email]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:15:41PM +0000, Verma, Devendra wrote:
> [Public]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Wednesday, March 4, 2026 10:26 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Feb 25, 2026 at 12:06:12PM +0000, Verma, Devendra wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > > -----Original Message-----
> > > > From: Frank Li <Frank.li@nxp.com>
> > > > Sent: Wednesday, February 25, 2026 3:58 AM
> > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > > > mode
> > > >
> > > > Caution: This message originated from an External Source. Use proper
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > On Mon, Feb 23, 2026 at 04:40:07PM +0000, Verma, Devendra wrote:
> > > > > [AMD Official Use Only - AMD Internal Distribution Only]
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Frank Li <Frank.li@nxp.com>
> > > > > > Sent: Friday, February 20, 2026 9:33 PM
> > > > > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > > > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > > > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > > > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > > > > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add
> > > > > > non-LL mode
> > > > > >
> > > > ...
> > > > > > > But if it about writing a new function to check the LL mode
> > > > > > > support then I think the current variable is good enough which
> > > > > > > provides good readability and do not create any ambiguity
> > > > > > > compared to the ll region size
> > > > > > comparison.
> > > > > >
> > > > > > It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip.
> > > > > > So we add more cap flags in future.
> > > > > >
> > > > > > Frank
> > > > > >
> > > > >
> > > > > Hi Frank, could you elaborate what you mean by adding the cap flag?
> > > > > How it is going To help identify the overall chip state?
> > > > > I do not understand what is being implied here.
> > > >
> > > > non_ll in chan means current status, which indicate one channel work
> > > > at non_ll mode or ll mode.
> > > >
> > > > here dw_edma_chip means hardware's captiblity, indicate if hardware
> > > > support ll mode.
> > > >
> > > > Distingiush hardware limition or current working mode.
> > > >
> > > > Frank
> > >
> > > Thanks for the explanation!
> > > Hardware supports the LL mode / non-LL mode, just that there is no
> > > piece of code available which can perform the non-LL mode as only one
> > > mode was supported initially by the respective developers.
> > > So, providing it as capability does not look justified as in any
> > > scenario hardware is capable of non-LL mode. Theoretically, non-LL
> > > mode should have been the default mode.
> > >
> > > The non-LL mode is not a hardware limitation either. LL mode needs
> > > extra configurations and in the absence of that, interpretation could
> > > be, enable the supported other mode which is non-LL mode.
> >
> > Yes, that's reason why I don't want to add non-ll in dw_edma_chip, which
> > should provide hardware's information.  non-ll actually miss ll_region
> > information.
> >
>
> I think, non_ll can be interpreted without using the ll-region related information
> as well. My view regarding the dw_edma_chip struct is slightly different,
> it does not provide the hardware capability rather stores a snapshot of
> configuration based on information provided by different means,
> please take a look at my comment below related to this.
>
> > >
> > > With the current non_ll inside the dw_edma_chip, when non_ll = false,
> > > indicates It supports both the modes LL and non-LL, but requires user
> > inputs to enable it.
> > > With non_ll = true, the dw_edma_chip or the hardware has no choice but
> > > to work in non-LL mode only. This is the interpretation for the flag in non_ll.
> >
> > we need distingiush current state and HW/SW captiblity. in dma_chan, non_ll
> > means current working state.
> >
> > but the same words 'non_ll' in dw_edma_chip is HW/SW capablity.
> >
> > dma_chan: non_ll       means current channel use LL OR non LL.
> > dma_edma_chips: non_ll means only support non LL mode OR both.
> >
> > The same words "non_ll" means difference. We should try to avoid this case.
> >
> > if you want to add field in dw_edma_chip, avoid use the same words because
> > their means is difference.
> >
> > Frank
>
> Can we please simplify this interpretation, the non_ll in all the scenarios should mean non-LL mode
> only if set to true.
> dw_edma_chip : non_ll = true, it shall mean that all the channel, at chip level, can work in non-LL mode ONLY.
> dw_edma_chan: non_ll = true, it shall mean that individual channel is configured for a transaction in non-LL mode.

When read "a->non_ll", need good back check what type of a to know which
one.  if use difference name
	a->non_ll;
	b->cfg_no_ll;

It will not think more about what is a/b.

>
> Above all, a nice comment related to the flag shall be good enough to make the understanding clear, at the
> places where declared.
> Since the beginning my emphasis is that 'non_ll' flag should be treated for what it implies, i.e non-LL mode.
> It was included in two different sets of structs to show the hierarchy how it could affect the overall functionality
> depending upon where 'non_ll' is set to true.

> Coming to the dw_edma_chip struct, I do not understand why the dw_edma_chip struct is about
> hardware capability, it is more about the configuration of the chip which is filled anyway at the time
> of probe() function calling. This struct does not provide any capability information at the time of probe() calling
> rather it is filled based on the params configured by user either as static info (eg: snps_edda_data) or by reading
> the capability registers (eg: VSEC and channels enabled by reading config space).
> I hope this clears the doubt. Please let me know if any further information required related to the non_ll flag
> Interpretation.

I don't want to take more time at this kind small stuff. I am fine if
vnod Or mani (who pick up these patches) think it is okay.

Frank

>
> Regards,
> Devendra
>
> > >
> > > With the capability, would it not make the statement, that if non_ll =
> > > true, it supports non-LL mode but that does not mean to be mutually
> > > exclusive and not support LL mode at the same time?
> > > If there is a requirement regarding the capability then it can be
> > > taken as a separate update but I am not sure what purpose it can serve wrt
> > non-LL functionality.
> > > Please let me know your thoughts on this and lets conclude.
> >
> > >
> > > Thanks!
> > >
> > > > >
> > > > > - Regards,
> > > > > Devendra
> > > > >
> > > > > > >
> > > > > > > > Frank
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Frank
> > > > > > > > > > > > > > >  };
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > > > > > --
> > > > > > > > > > > > > > > 2.43.0
> > > > > > > > > > > > > > >

