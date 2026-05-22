Return-Path: <dmaengine+bounces-10717-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLerNcfND2paPwYAu9opvQ
	(envelope-from <dmaengine+bounces-10717-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 05:30:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FB5AE573
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 05:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19AA0300C91F
	for <lists+dmaengine@lfdr.de>; Fri, 22 May 2026 03:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF25234887E;
	Fri, 22 May 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aQbbRZSS"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020117.outbound.protection.outlook.com [52.101.228.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93001346777;
	Fri, 22 May 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779420610; cv=fail; b=JGd63OMLRLNrjk69zIxQt0GprMnVMO8h3jjF4Q/ju2X4dEM2S5VLX3cC7IlvpRZEVoeEPGW/9gWJIB8UAzvdjVjnIfhOjq0toNg3IUxQo3C8Hw7VHTGjqnDIbyeD6eZ57ecxVtNmt59lMm/x0kn4RVEYM7D7FaWTIUp+y1W9IfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779420610; c=relaxed/simple;
	bh=OKBV4P9DoanrXENjJYqvOkullnoguLoVe/EdFIA0Hdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uzicm1eJrieNgqmA6j273eRkN37v89XES7Gpx+nP9o4/msg6AiRmqkKNKGQqB/ND9Bktr9joNc9XcRXbcf+awanZYb455MkdUS2zBKV/8LFuiHr+Xozk6adGAlWXbbWXoC+8TY4S1edEjS3Vbv16zhKzy1qaXJYFr3di5VnX1EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aQbbRZSS; arc=fail smtp.client-ip=52.101.228.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz5FqLvzbds39L5P6sxWGZWR0WreeszlZ7wdD//3LGjmWRrQlNV/+SkcIyulZ/HeJygfkUQeD+sRS8ZGAvp9vUbCStCexQ8e1+JffLhkg7Ae+oT0eIM41u5WoOQskLsXA0px6DJ3VSqEbTqqG0/gxWA8nZyoWql0H7Uj83z3dcwDB9/4Rjn/5C8XAzZQ0Ix4PWpCkjrCIIf0nc5/defPI1mnEfOQIdzg7uj1bgWrrl9pwEu1STEWw/ZjgJLHBhMZ4QUsie+RYOMaQ4chu4BKMw2CNR7TWpLnPlqYZBstbvG4TCQrgR1+vxF2VlaKmdyY2pa9DPQasbZgYi8co5sJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AokRoklS7sh1eP+WLfB6xq8ufellWtzCZyOpDMt4ahE=;
 b=R3zG9thTpS8JBi9yjfhWj2OZBDYu374PC+HnDmVm5/XHOrkS6+MpZnR0Wovdt/nP2mMwLyX4AcRS3plpplj1YcsbVnAk/rykxTxSV4J4aoA0VCxbHuw+9zzNvY1IXH9ErBTt8+cVWknptQMmH1IVCFGa2cQ9EMJwvqhEmByV9fCKY/4ps+duNddRZlnLSecB6SnKtM/2Xg8V2bpjpnGmFxmNPV/VaccmnOrl/kRbhkN41Si4r1LpkMeyAzY8MV1WDCUW/rBwJLOcsJp+kvD+4P/h50KULHcAHw/Eig/e26mtlQ49AWrYb4vpKo14Rap7ibkltUOqny7VnTyHLCl0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AokRoklS7sh1eP+WLfB6xq8ufellWtzCZyOpDMt4ahE=;
 b=aQbbRZSSdBt2WqXMJYbxWZDKBAV1DlJZYVE6cogul2D/+8F7BtjUCBB7ao4+Xkmj6b/gGrLS2U6gQQCIA5Pt/eotDpnivwV67jNHOASncimuqHIkvyAekxDr/qxLjHAHT8oSumPJkTvCmNi0mzxNnjX+jsrrTLsQ2H7yn8S4lhE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7596.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:442::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 03:30:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 03:30:04 +0000
Date: Fri, 22 May 2026 12:30:03 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: dw-edma: Initialize IRQ data before
 requesting IRQs
Message-ID: <kjslqii4bs3g4pi22mxh72hxnlm7nkesdd3va6zi5fhmjamerw@j7lbrlq5oszd>
References: <20260521142153.2957432-1-den@valinux.co.jp>
 <20260521142153.2957432-4-den@valinux.co.jp>
 <ag8aX_2eOmInjpGN@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag8aX_2eOmInjpGN@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fcaa5d-fc61-49cc-c19a-08deb7b26a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	OF347O1IbwCDK+k9JiXdIPK4GYFD96rRntkZfrxPLtF7sf2bGMWU5vKYP17Oiim11rFYZqOGXMDhOem0kvlVnd4MePYAeWA7co34h4T7zJS/c1UUs5N8zMesONjCzt/MKbhZxzFbgtmYFf/1RrQjNQ0VAUuSxjYUuNYiLvs+A7U40MvjKv/x0DwDKh9Qv57TMUzY4CsN+1MCsN3AFeMcn1DAoRrhTDuRQtnSMweZEDw1BMysqy4SF1DOcE4pRZ1MvyQDwSeUYSX+IsL4laj05QNzHJftXqaryPrHkPK4tNsbOmRn5wdpeZopHjXsI3Dd9RCT2rgRreNMvA2PEwuSp1uWKCQ1+lUTEUAB0BtLkaBPlvB7w3iOFsZzVeQXm5LFnnMy82e7cSu44ufh/0RXvCQrmkrJWrNYIXfAM73pi0NEvM0djDCemK8Z8z25tChetkJC+Dc1hZWnkE8QQn8q2kmD4f5LiPolIw3IyOyDfCqQLW9RB0tLBKpIEOTotHx6V9IoHl4Z71q6GDSMECWtDzCe6MPNzMIlD85cYLec6jHY2Zn39fLDNCeFgSaOdQvJgCm3b9vPWBngu3h9/37+y0cGR8dUfdWUCfhvOCI4fTNajzHX68xmbljvpKESL+s4X3IasXGARDtg7PK9maqZqWkOos0YGpJ7mnCPT+exNrz6DQXiur6eS37tzVZIaWcr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ICK+dE2k5D8hJVOVzQue4LryJH0XVYqLV5j4+dZK/zM21bfzU8ggaeYbFURV?=
 =?us-ascii?Q?PwRV3vkGu5fLGtbXuFAR5Xf6z1Mwhp1XriKpVfs8+m4yGsEORU3dZb3bENFy?=
 =?us-ascii?Q?MisyW00J1s3pHxXwnWoM03tS43Cy8eHPrr0VFwloXHBfkglu7WtcVTMFqiya?=
 =?us-ascii?Q?RNXSoqISdzgY4CWQK6nVCdLLBpykgXwmARNDR7AfSFCWgyou2fxhEyiiMq/s?=
 =?us-ascii?Q?LaMLU/7I+1iJqT7cbex6IDoTmIBhoxyYCH4e5GsfQYN2WqtZZPSuMOA9oatS?=
 =?us-ascii?Q?emPdZ2DrJW1YqzOxnJfEhWoFpvFkJkNuV3eoxm2BIHwbRbEFeV+lO0MmBqH8?=
 =?us-ascii?Q?es7GpIW7o7TfCxDnvtISTeIpYI2YV4CxiaHnmHss1kooXVnj8iJBp+uG3Uxx?=
 =?us-ascii?Q?UFq3m5NA9M6sMeUidwSienP0rhSz1NA+vyJ1cCfnqBfwxS8uWEPWbcxRE6Lt?=
 =?us-ascii?Q?d2TZIJBmuWm4mkRCo28LSHFsNFZSNus07chsTULzFQqr9Mg34+kN7LTdQBS0?=
 =?us-ascii?Q?2XDSXBH6CqX7KQjJ+nC+rPJlYXLBNIE6ImSrjpGjDFROf/eDNfgrs6JWNFht?=
 =?us-ascii?Q?yOBoSJn1xzpRMvaNWhosHMThGBGhHOR8ziEBkodx12mjugfeAQIXTiZ51VQ1?=
 =?us-ascii?Q?Z6l8t85NSoBi+tqq5mav2cpusBmgvB0NW44M38zysPf7jaHc6mhLoLONmPQ2?=
 =?us-ascii?Q?9zv0ODwrVS5k1YSqrobMYmsrghp/SsZFrutJRGWxYUfcL+Rr4X9pzlKphZec?=
 =?us-ascii?Q?g0McxzrpCT6A1wLsBVzKihj56FbRoavNycyCP2wvioxLE2MmSZYTvlOK9at8?=
 =?us-ascii?Q?K0vGmzihC9Sw/gSSUQsAAti5A2dNIn6dCGj3iM66oJqw/NwN5OOk3EFBKfuQ?=
 =?us-ascii?Q?Q53+EEiE4mcZE3qfgIpyihBiNXd94MtjztSSCB5jFMwr+SL2YTUBCr16GQDU?=
 =?us-ascii?Q?tOoBj4Wh6nCDnxxVpifNvmsymTytAnjtvNo8DTUIKZ/L2zahSImua3O/QQQ3?=
 =?us-ascii?Q?BxIA0RUs2eHC82pRL75ORJUgl6ujJo+bSyuW7/5BvDlghtHqDPXNvEfLBWK+?=
 =?us-ascii?Q?0oE5DmfVOu5twHeQYj3Im6gNn/Qj9IwE5IF3yq6YiviDAvsNd9/PFHZUJwX7?=
 =?us-ascii?Q?bUHQ6Wn4/V/sI4wBnNSTYAHk0c4ctBq0qpN/h58J+ogptHxuLu+lBqmhFWyP?=
 =?us-ascii?Q?2x4Pcx01N5Dd3ubbao9339Zbx8gvD2EI+9RiLQOuTiNAFP0z1XxADF7ipMz1?=
 =?us-ascii?Q?SQswQ8MlwCnHcCrPd2RBPadqd8KEl63dYjeA5RdTyyCuSJC3B5ibeKp7uP8d?=
 =?us-ascii?Q?Y8wKv99kDa3ryWpyyVx2fifs92F0vwv5AcoaqBjrazsAKGt/GJwYLplh2UdC?=
 =?us-ascii?Q?IJtbFWnuk0Zir6J11sPxO3PVkkZNjttsKKCII3kx0oBxJSolcYfvgIFiNM2D?=
 =?us-ascii?Q?krD6eOa96unV73QoqtCNOjmOm5VeYnTqHGX8bMC6HV5yzWVHeWHwZlybDHrr?=
 =?us-ascii?Q?XUI1RoMfEYYZPfhwvWEMXQx6glKAThnnSZOBMtho4ajTFDxHvqDboQ3xdFTX?=
 =?us-ascii?Q?uCrej0ind6sB4fPx+xVIHCnlM3fjOeV1vP/yS+cu6VOPG5ha/LoImGJyXcG9?=
 =?us-ascii?Q?wv0kNxsBaulA4MepgaZXEBrkAcL6HSJOWqiFDDtm2adz0+EGUMRm1GfG6Qz0?=
 =?us-ascii?Q?PHSYodWc2GoR2WQPVGs9GPQ/ank3zZS0suF3RMnWLWVMHLVjZ3u4LI1m9Tjc?=
 =?us-ascii?Q?45v1SN6z7RkdrJ3IPTj5wmjSBW9lTAoP6XtjFe4Im9DF/MEn91H4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fcaa5d-fc61-49cc-c19a-08deb7b26a44
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 03:30:04.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZcNlx1Ga/T7vKwjhVC/wwKshccozRPCp3KNOg2RXAPmMo9d3+7eR8VE4G0L+WsjoB/63Bm2ey/2aYqDunYQjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7596
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10717-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 352FB5AE573
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 10:44:47AM -0400, Frank Li wrote:
> On Thu, May 21, 2026 at 11:21:52PM +0900, Koichiro Den wrote:
> > dw_edma_irq_request() passes struct dw_edma_irq to request_irq()
> > before dw_edma_channel_setup() fills the back pointer. A shared
> > interrupt can therefore enter the handler with dw_irq->dw still NULL,
> > leading to a NULL pointer dereference.
> >
> > Set the back pointer before installing each handler.
> >
> > Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Hi Frank,

Thanks for reviewing.

After Sashiko raised another point about patch 3, I looked into the init
ordering again. I now think patch 3 is half-baked fix, and probably not
needed in this small-fixes series.

The two Sashiko comments were about the IRQ handler being registered before
dw_edma_channel_setup():

  https://lore.kernel.org/dmaengine/20260521072453.E5AD21F00A3C@smtp.kernel.org/
  https://lore.kernel.org/dmaengine/20260521155834.D8DFF1F00A3C@smtp.kernel.org/

For current upstream, I don't think a shared IRQ alone can reach
dw_edma_done_interrupt() or dw_edma_abort_interrupt(). dw_edma_core_off() runs
before dw_edma_irq_request(), and the handler still needs DONE/ABORT status bits
before it dispatches to those callbacks.

So patch 3 only fixes part of a defensive ordering concern, and the later
Sashiko comment shows that moving irq->dw alone would be incomplete anyway.
If we want to harden this path, I think the cleaner change would be to split and
reorder the setup flow like this:

  Before:
    (1). dw_edma_irq_request()
      (1-a). allocate/populate dw->irq[] and cache MSI messages
      (1-b). request_irq()
    (2). dw_edma_channel_setup()
      (2-a). initialize channels, including vchan_init() and
             dw_edma_core_ch_config()
      (2-b). register the DMA device with dma_async_device_register()

  After:
    (1-a) -> (2-a) -> (1-b) -> (2-b)

But that is more of a cleanup/hardening change than a small pre-existing fix.
(If preferred, I can send a separate patch for that.)

So my conclusion is that only patches 2 and 4 are really needed in this series.
Patch 3 should be dropped. If a respin is needed for any resons, I will send v2
with dropping Patch 1 and 3.

Best regards,
Koichiro

> 
> >  drivers/dma/dw-edma/dw-edma-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c2feb3adc79f..d221e3efcb36 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -929,7 +929,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  		else
> >  			irq->rd_mask |= BIT(chan->id);
> >
> > -		irq->dw = dw;
> >  		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
> >
> >  		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
> > @@ -1018,6 +1017,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >  	if (chip->nr_irqs == 1) {
> >  		/* Common IRQ shared among all channels */
> >  		irq = chip->ops->irq_vector(dev, 0);
> > +		dw->irq[0].dw = dw;
> >  		err = request_irq(irq, dw_edma_interrupt_common,
> >  				  IRQF_SHARED, dw->name, &dw->irq[0]);
> >  		if (err) {
> > @@ -1043,6 +1043,7 @@ static int dw_edma_irq_request(struct dw_edma *dw,
> >
> >  		for (i = 0; i < (*wr_alloc + *rd_alloc); i++) {
> >  			irq = chip->ops->irq_vector(dev, i);
> > +			dw->irq[i].dw = dw;
> >  			err = request_irq(irq,
> >  					  i < *wr_alloc ?
> >  						dw_edma_interrupt_write :
> > --
> > 2.51.0
> >

