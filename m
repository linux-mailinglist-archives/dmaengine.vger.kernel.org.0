Return-Path: <dmaengine+bounces-9353-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIIeEBrtrmnGKQIAu9opvQ
	(envelope-from <dmaengine+bounces-9353-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 16:54:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B439B23C27D
	for <lists+dmaengine@lfdr.de>; Mon, 09 Mar 2026 16:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0883307BA91
	for <lists+dmaengine@lfdr.de>; Mon,  9 Mar 2026 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3663D7D7E;
	Mon,  9 Mar 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9pJETLL"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11F4377EC6;
	Mon,  9 Mar 2026 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070842; cv=fail; b=J9XxZm3sFGDNxp/qKy7HTklBIJCajdVbDrFvtHfgRYS9X2x+2ASk5B7fDOPT9VqS/gxO5Kf3fNvP7BqFpLavyvC09FDcjxwoBnb1FBtsQ7ryp3WTMeLZ1oJL6TT25n8HtydVQMt3qQv9W7JQmmzfqWBcBv4kszny2BcGrJ6KW9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070842; c=relaxed/simple;
	bh=WpMwLkz9fxRI0AMyS7qd/FmuIYO3uox3dBZesbvlj6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tL1QFhNvoy4ZWhTnsb1WFAEWT6BAjmC56hs3zJ972XV/fzMpuYhi+ipXyYX9ZiTHo6gL82fWwzou/g+rjxUVKLOT2+el6UB9OiBxxrhR0C7jux+vodxX/qNWfCeTFgB6Qti8NGxafTmob2/WeW8ImKW6BdEjHr3tYEwUyhSwEY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U9pJETLL; arc=fail smtp.client-ip=52.101.66.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdNfAVGKJ0z5OJoK0Cg9/hMdRgnzCR7XJCPqPsom3F6bUgPmPoW4M4im6IJv6Tcb/YzJ8/FjHqTqjsPLA3fpzzUaaDdcJB1+ZvRm9XHyXGZko4TlCplZTiSZ8I9jVkJud5GqzthATjvXjKQbuKPA6Ho+jUCukdCG52LJTEvP1F5rugPc06/2znvAMHlYqid/mBPHKJ7AR4X8hv85sWZgperfdAzKR1LjfbqAbgv1Ask1CJTVIeVwlMopZBE2H4Zor/1JK1O7PPPhoGzwGlauW3a4lgXhOQ5bXlFFBNOt3M+8+mMB6Ts5dzEsl3QRczdkaVh945BCn2fiLlCXfBHqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPulvLwTTFTdu+406zX5G5rVs4O8zQFM8/ZpbVODJRQ=;
 b=FLPIA+EGdhfNPZJRAGWEHn2emha8UWNSyyBYHloJExtrbF/650ijrGiWzduss2VUc4ncS04Jrcb2SiWWLSLe1nzfUq8xZMYc1R7XdQlOjd5PIQ7KiR4ls/HbhU2tC8uOVjhYvLvQ5jrMxkCdgiLa9bebrcbJ7DoIzLQGECAEEEVhpWwhEcoL5lFwqMnvn15m4gH4eSpRI07P2sMhh5BLI+lQAsVN0XzyINVcRJWvIrdYQp3H/3SoYj21i4p5k8h/R3ves0vrgp7b9f7VG1YNhmzQsqlCYWrjUr1Trkf2/QOiC1gMVkawOkiADQwT8PpplaoLGJk3itzlfl2447g0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPulvLwTTFTdu+406zX5G5rVs4O8zQFM8/ZpbVODJRQ=;
 b=U9pJETLLRdQ6smyU6mj9qas28hAerMvTSGp2aD80frFteLAqRiQHqoZ3bpou7tg4RFb+IgMP4qJhsUHS/ivupCF6VbGBzecuETpS4MoIAWzE3qoAH8r0u/YVK5kPWbOlGr1XbdmXnGKIMhfIyuahWKh+Bgoz5e1RiqkwQUd2+vDfxKWInvI/LavLdL3OnrC6kLEBCmcikXSOoA3CnobrJ7Ri5Skkf+u8NAFZ+ymm1l5g5D7iH0nGMMzV+zjA0VJDNRxwu59iQ3R+Q/zXc/wSELigRkKk9xaVvTGqIntST/ueUg8bXaUm0Fd777ChLnjsLI1/Wo4E/L8XGCC98WM5lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10518.eurprd04.prod.outlook.com (2603:10a6:150:1eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 15:40:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9678.017; Mon, 9 Mar 2026
 15:40:35 +0000
Date: Mon, 9 Mar 2026 11:40:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aa7p7V7Dt_NbaOV8@lizhi-Precision-Tower-5810>
References: <20260306115228.3446528-1-devendra.verma@amd.com>
 <20260306115228.3446528-3-devendra.verma@amd.com>
 <aatEUuynXVVYEhWy@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120969E61FCC5C46F1C1B739579A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120969E61FCC5C46F1C1B739579A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:806:21::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10518:EE_
X-MS-Office365-Filtering-Correlation-Id: 3007d591-f0ab-45bd-694f-08de7df234de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	qn7g28MPHAO+4TZE2cCcKAynRz9OjevIfsio35z5LfSXh3DJ2HgJeTxWKB679tZvpYj/9En6aASx7OkwxsY3fOro5KpOspmn/BSxmtvpWh342ls1wRzy5UGasxfwjyywKjcIOBP98LpINEEi2ovxAOmu+j0oCBVpfUo4bEylEe193bZebSZNIvwS7SKlmJ0CgrfImFOcPGbh6lz5qtRVoK9goPE7haNQGxkl+ThVS6pxN4d3VsfHMmBLZIPN4cWNAy08b9A34YHJ6WgxWn+OsyN6qPdd3QYF0qQN/mRL3ukqab0APKpK1p05aZBMXl7bONqCKZ9Ww9cVue2SSamxlmDQiwt58X3o4/aeQUWdAOtwQSG786b5zQ7i5GQcOGCec4SsuppTSiPtJRTC8+aONt0+7DxDpu/8Iaq5hZc84asMPjC0u/vBVdR8Hl0vjNvjFWz7bYbmUrHdtYOsoTUlUd+e2x58D0nwcSl2BdK5vh549yJi/OAFxU060HTX/yAnn0tk0OMfHk1qXXv27jirLYWDMoMDP2pv1YZ64/3G1XQq9G1zYm7NqVCyBFk/WvxeGreBl+NIl0EOsMgp6/d4vIrEtIYu+Wi36OFIo0btrrYwWmIAKyQ7J0k2XjduPZ/xXGaenpO31B4ZvIS5t3EFvLMpYPKTp2hPpzv8+PUeF9EZfibMOaIkbGM/X7q6wh/8xNM6u/kQSsz50+FsEcYf9EH3FOiER4hbz63pWqi5PTUnIQWMxld0BxpBdVMHueT3b3suZxQrTAb79/ViZAaRSdqxuzBnUCxbHnosxxdYQ60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4vf+IeA1tPoR/QhX/O5GGKRubLDnda4mDSWpyRurThNlCIdONQENVzntAyZf?=
 =?us-ascii?Q?MzV3yaCD055FA2jY5EC+dusyndSG+XuX6cDM2iMGuvlD06kXqhnY4pbuayUF?=
 =?us-ascii?Q?7GHfMXhPTwxo8QbSK15wbvAQ6VYgB2pVh1DtWIbDTePruvh11xjKZLQLEQd9?=
 =?us-ascii?Q?eFgOAPQApalzB0pMmTMkdWYIioNHMGDHTDn2KM4AHToHPm1Uv36f2tes8M3h?=
 =?us-ascii?Q?cUGXDxi25MEZCaSxrCdbxvzkE8CNRAzc5UDZEgTehPfeYr42ZSgp13XE1czD?=
 =?us-ascii?Q?mZJxOPpjD+KwJGweSszKOHmQ3g6AHJ/Xj0vajdx3ITRy3yNbTgLxP3C3sppK?=
 =?us-ascii?Q?BH4akm2arAMKJmaMwiXHbEMtGqqzFfhqPgfdP4RisE6UitCE7rOmegl9rh6m?=
 =?us-ascii?Q?hSUtXCyGPoeTOybewPJxWpDNqKAjDLPrSu80b6FfdbAJG0XqA0cPouGpG2eB?=
 =?us-ascii?Q?HVDCa4kB7oqKEnumJQyHFab0LBOzkFtVOJ5I3xDr+l9YMOpXmlF6jb/yl3PZ?=
 =?us-ascii?Q?29CjXv6sknccS56rcCMai3HaY6URYSCJDpQVXZZtozXGSXy22nI7iQjV5uVT?=
 =?us-ascii?Q?8rCmWGK2vcujqzouFp0PklxAweRjve/Tet+YvrXGCS14iLZJAMtHsi4mjkS/?=
 =?us-ascii?Q?7I62KyUtGMt/bxgVEwx5v11Fa9JfRGXSfmmju04jNhScBunX9SpAV6LzgKPF?=
 =?us-ascii?Q?ECG5KCAqllmK/j7sGlRC392412FRGEv4jEOmsaQYecW61e06V419HmFIM3Oj?=
 =?us-ascii?Q?zsSj0mDD/AQjKZxQDhEmW24njSNU5NW/FE37KtikazJIhyx8tycl7/QlGY0f?=
 =?us-ascii?Q?RjFS6QctrkTwjBPhIOrMQweHtg7dzVyLQ48ole6leyMgMrWV3LRDHuISBkfY?=
 =?us-ascii?Q?BZxFx/xbUSsHLyR90YBWggHwJeyfWT36MmTB2DxLazM4MMPCaGDq+BuibTjR?=
 =?us-ascii?Q?WX9bv5gJdSChwk1NZ6PHPNX0mmZVf96OiWTFVfVsTB3KbYusKmN543mHwZEy?=
 =?us-ascii?Q?+fkTso8/rKP/IFZdCjuJvJqz8sprKQrAAZODdWzNf7jI39rcIFqX45pgEOVg?=
 =?us-ascii?Q?4KvavoFVztuugU82LvKloSpKE8l8sEb7wURio7OHRm5t8jcd5C1lnMomcNNL?=
 =?us-ascii?Q?PECQRvCmKoC/K+W4BdicqNmrKnZYmaU8Z5umlBqfbgd/yEQh+Ll32UMPeCAT?=
 =?us-ascii?Q?1be25lzMgphpTS12idpYThndyVqXTj58MYe9I1QczergEtCe8k9MRStDYbnI?=
 =?us-ascii?Q?ClMLFdWMEIwFTw3Dutb3SQrJMt8DS3G9aPvVXKLln5gBFZr8lCn/fFkPjovU?=
 =?us-ascii?Q?wshYskt4pi/ks7Is7lFLt8vrb9/zab+8Ka6lKy1t4otV09rzdo7PnTQURAbM?=
 =?us-ascii?Q?sjITIrMVzyWtsoVRppjTl8HN+b05un4fu/cLGl0/KoVhd+zEYO147ZBFHrJr?=
 =?us-ascii?Q?5fHRZY/ARN5VW+uQkLxNezKr7YUrobGTZ0R5hmmff/K1L2UXiF/YcySqDrHN?=
 =?us-ascii?Q?r/nHUGqoOsQDQhB0kfpANNhy9ZFXYz5ni7VKTE5zkIJ6Ei+IKbCx+aMZmeZf?=
 =?us-ascii?Q?O7RoF9goN+bfe/r6D3fPQXXJFPX2xjtlObwK5Q3N9yBBkdDdwKrhy+X9fJsp?=
 =?us-ascii?Q?ypMoIrhu/lWkazPaLvC942tZg3Dm4vG/EhjL1THqJQWZ1QsPKtVwh4qZvQsY?=
 =?us-ascii?Q?/azbRlQdkSXF/9oLV4mGV4xx/DietyRnjIb17keajJCQRd22?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3007d591-f0ab-45bd-694f-08de7df234de
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 15:40:35.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbPOSPjKQxw3TH6ChIJvH39ND0uIS61A3cSCcbkpaWiYALCEwwpGKFUGzOLRdPPI5li5eVxcxfrYvX+6yuMUug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10518
X-Rspamd-Queue-Id: B439B23C27D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9353-lists,dmaengine=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:18:33AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Saturday, March 7, 2026 2:47 AM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH v11 2/2] dmaengine: dw-edma: Add non-LL mode
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Fri, Mar 06, 2026 at 05:22:28PM +0530, Devendra K Verma wrote:
> > ...
> > > +             /*
> > > +              * When there is no valid LLP base address available then the
> > > +              * default DMA ops will use the non-LL mode.
> > > +              *
> > > +              * Cases where LL mode is enabled and client wants to use the
> > > +              * non-LL mode then also client can do so via providing the
> > > +              * peripheral_config param.
> > > +              */
> > > +             cfg_non_ll = chan->dw->chip->cfg_non_ll;
> > > +             if (config->peripheral_config) {
> > > +                     non_ll = *(int *)config->peripheral_config;
> > > +
> > > +                     if (cfg_non_ll && !non_ll) {
> > > +                             dev_err(dchan->device->dev, "invalid configuration\n");
> > > +                             return -EINVAL;
> > > +                     }
> > > +             }
> > > +
> > > +             if (cfg_non_ll || (!cfg_non_ll && non_ll))
> > > +                     chan->non_ll = true;
> >
> > this logic have a little bit complex
> >
> > if (cfg_non_ll)
> >         chan->non_ll = true;
> > else
> >         chan->non_ll = non_ll;
> >
>
> Thank you for your suggestion.
> I think it is individual preference. I am not sure what seem to be complex in the
> logic floated for review as all the boolean operations are easy to comprehend
> in a single statement.
> I am sure there are multiple ways to write the same logic.
> To me, the logic you suggested looks bigger with the same outcome delivered.
> If after distinction in variable names and simple boolean ops still cause confusion
> then I am not sure till what point it can be simplified.
> If fewer lines of code can deliver the same result, then it should be ok to keep it.
> I would request to keep the change of the floated review.

Reader need thank more about "cfg_non_ll || (!cfg_non_ll && non_ll)" to
make sure it is correct and what it do, need create true table in brain.

It is not enough straight forwards.

Frank

> Thanks!
>
> >
> > > +     } else if (config->peripheral_config) {
> > > +             dev_err(dchan->device->dev,
> > > +                     "peripheral config param applicable only for HDMA\n");
> > > +             return -EINVAL;
> > > +     }
> > >
> > ...
> > >
> > >  struct dw_edma_irq {
> > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > index b8208186a250..f538d728609f 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > @@ -295,6 +295,15 @@ static void
> > dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > >       pdata->devmem_phys_off = off;
> > >  }
> > >
> > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > +                              struct dw_edma_pcie_data *pdata,
> > > +                              enum pci_barno bar) {
> > > +     if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> > > +             return pdata->devmem_phys_off;
> > > +     return pci_bus_address(pdev, bar); }
> > > +
> >
> > Reduce each patches's changes, make each patch is straightforward
> >
> > Create Prepare patch firstly, change pci_bus_address() to
> > dw_edma_get_phys_addr()
> >
> > just
> >
> > dw_edma_get_phys_addr() {
> > {
> >         return return pci_bus_address(pdev, bar); }
> >
> > So this patch just add
> > two lines here
> >
> > if (pdev->vendor == PCI_VENDOR_ID_XILINX)
> >         return pdata->devmem_phys_off;
> >
> >
> > others look good.
> >
> > Frank
> >
>
> Regarding this we already had discussion and it was concluded to let this piece of code
> to be as is. Please check the discussion at the following link:
> https://lore.kernel.org/all/aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810/
>
> > >

