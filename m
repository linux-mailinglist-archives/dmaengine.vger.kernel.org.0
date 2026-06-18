Return-Path: <dmaengine+bounces-11586-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0ZHOKTFAM2rF+gUAu9opvQ
	(envelope-from <dmaengine+bounces-11586-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 02:47:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A669CEC5
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 02:47:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=uDLqNdOP;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11586-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11586-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA19C30387A6
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 00:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7D29405;
	Thu, 18 Jun 2026 00:47:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020099.outbound.protection.outlook.com [52.101.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F72248AF;
	Thu, 18 Jun 2026 00:47:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781743663; cv=fail; b=ERm7gAWLDEqx0MTvQyg2lu/B5abDqxp1ryzqJMKfx6HO5Er0ExBd+tt2j3uJ+PUA5GnOtzF5AoSFOsrAjpIGtt3n9jBUtP/FpGAaJmBgxG/LAowZufX+pstq7NXv2SR/rW+EPzU31j2wMrqvZorMs/NRpjgdjRhRI3PE+2ZVquw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781743663; c=relaxed/simple;
	bh=E9QUNi562GAKhdpZ7UHuBFBRSDOJJYdTzKrGmg43Q4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G5j/OwMMAeGNlVCcTO84DsO09vBgRDIBQz7eakW/4/JR8l+FaI2R20jgHLqdRz6YzpQi6j9/1DbE22xT7r20v465EQVMqk5ivLO/SmneWX9TbTiZRmCnaRH+KoQZEYxwTL83bDmP8YIPIF1++r6dQnkTowuRXSDo1GMe21vKs1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uDLqNdOP; arc=fail smtp.client-ip=52.101.228.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVVHZzqzD3aPO7bQ7/RkQfecchXEbxO6GaSqNM8zANHfeZ7O/9eDoWZumu7euAXiKnzEZ5qJnvJVrv0OXzNk4lov2xEFkS321Lzlk08Ea6De83mQtwJcDOdBMOu/9j5AgVs5ednNYhh9fySvMr1v+73GkYQXNwDqEFy2vOdccT78F8ca/TlCvUt7ZLMO661Pun+A5Oi0pxxZr5cppVRydE1iE4W973jcKZeqRGfx2hGCpbwFWu0ju8HcQVqWpy8k+qojlGLi+yoywsBsjIIyiYfb/RuIrb6/b+tu9bT7KSSKkgCX72qT8VAyxwKgz1S/+4lwGNYCx76Pz3bpP7INng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUGOMgehB2g/gkjlP721g8DrAl0llX8HtdOBe3xI7AE=;
 b=kVebdCigTVfyBx+N58CSyHvkF5PkgukfWuAVannG0z0Y/QqAma2VKnrkgpMcxASZUG6IT8vvqQwY9e7qlQMdRsP01uOH3yDYWu9/fvVRW6299Yq/MIKA5Rtze/lInljhsgesuoeIZhu7YBEfLeCm3aGVs3QT/C5aVsJEzpE4psUuBuG7AFbCBr+dxaWY+8oJcmfZv9a+y5XBznTdr6gv01zBVJBAgTYVoIj62+qi2GY8xjTD3V/4oIID0EVhe2bTQ9gYz52oNgQ39hzxf7I1JDPfuUcYZ6EB+LYiVDdqs2EK9AMDA0e2+fu3itNE3Sj/oAxgSQ9Z7uKJRZX/hyEpBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUGOMgehB2g/gkjlP721g8DrAl0llX8HtdOBe3xI7AE=;
 b=uDLqNdOPYXcZLFwzUOz4bd+bRFtvfEOz2+VxrKgX1p3lPmDRFw2yE5HT1T/QOFUsCTjA4eXgTyxM6LMZSPjOAHkzf8TZe0TJg8od35qJghxkCHyVR9ZCu7ouZNKDYGTpSBrhllqnoVSwRhKRF1d222zvgB5rLsA4cqnHdSZXFIU=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5242.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:166::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 00:47:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 00:47:35 +0000
Date: Thu, 18 Jun 2026 09:47:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: "Verma, Devendra" <devverma@amd.com>, Frank Li <Frank.li@oss.nxp.com>
Cc: Devendra K Verma <devendra.verma@amd.com>, Frank.Li@kernel.org, 
	bhelgaas@google.com, mani@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH v15 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <asye6p5hobxvn2e5axiepl3qpvvtmytzdpcvdpcamdqfk7pog7@cfh65ggwnyas>
References: <20260318070403.1634706-1-devendra.verma@amd.com>
 <20260318070403.1634706-3-devendra.verma@amd.com>
 <zhpsuwq5agslelgebbtvrg4uks4xweov7ywhmkxdngq7lzajip@e4umiii6kzko>
 <4ffb23c5-de2e-44f6-8d15-0f9ac563b609@amd.com>
 <ajKmbwr4vuN8cFuU@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajKmbwr4vuN8cFuU@SMW015318>
X-ClientProxiedBy: TYCP286CA0375.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: d55dbd38-cda6-471a-e3ac-08deccd3305d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|10070799003|7416014|376014|4143699003|18002099003|56012099006|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	QOcP81ZylD60WJKgY38KgCyePBkN6/kSmiWvNizwHwf0jShJ5uhm2uPvM0LtY0YlU+CdrrmQTraZTb+kHJ/v5FvPOkfG21U4fuJPX0FeFUi3EAOmC6las7EjKRUsbcsx/IAOcA6Kao+6mKofP/bP5TmlyF86j3ah8VPczpiXdQa6i0bHfhfGZfsiocxSdR+YgfR47LLa6+qsazM8f3MehsZHnk/Amb3PQMzxxGju7ikmo8i41Zgijt8rrlzXi2JzLYbJcZDPvJssBVFe1HSR17m7YkCkLbXBdqCnXn0B8WoqsDFo9HsqesGN9RXhyr2YHgjdGGimi4dxh9md+bfB5hD3+TvkfxlI99WOsaEkhvAUot8NMLNyjnOCUxol6khCc+TFmlEQtfou3eKE76kS9nqz8tSLbOwoCr9M0SJHX5KxoYJVOJT05dpJRCrSe2jBZk3m2fuK5k8lk1TWo1XAxvGzDoW60JTllPGUorqCKAoVeEA1cAV5VKkJVmb6xsFhLXUAa6iuEED3mPEYddpKCiKN3B5AdEFK8y/h0TpbTfA0vBhOQkhXJPQ+HL8GNUlFbpI/P+WBDgB9ZaKy6ot3zrXD++KmWAtaqVnkoF8/diyq8EC3xh3NLQiUWVQy+yREN5/7f6Gak3O+BaUSlpBac8ehHJPKw380kMfmg7FzOXqOIh6nALVex9Xi2jJ+0mbW4Bqua9M+iRntfMuQmck8pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(7416014)(376014)(4143699003)(18002099003)(56012099006)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mr8y2JCAd4t9fIc12foc+VU9NIH//Iy0ZiQlqY82XDppWw44wjrwrfUtvAmM?=
 =?us-ascii?Q?6yQ6xKT9x0DsSvmsL98w+uBkCPFC8JOV2S0xnBk/mPHSzDxP13vfjFd+LT1d?=
 =?us-ascii?Q?qODAfdVbYszbHsY5Bpz7Z0X0MZa5a7E285cuP8BLCpsGLDrRu23Y4fhWk2bB?=
 =?us-ascii?Q?+hYODlFbOd3Xlv04w8b4UCqgdOpYhBZeFq0t9AVPrdvK4kx35/yIao1kGXPq?=
 =?us-ascii?Q?CmY1fJGFlzHSOoZWZVN41i0w3VAzH8sbhJ/Dc9tfOmvEZp4Rg1v6LCFzaG16?=
 =?us-ascii?Q?1b4U3sF5OMS+zPpvObTL+bspxOTDPTWSEfUoDocODYkfK3bj8o9kCIq4jdoh?=
 =?us-ascii?Q?437EP+5VzuB8fzV/H7jCAoosfDNnyGyoeFhygHiXPcKzoTU7Xle5D5JrgPhA?=
 =?us-ascii?Q?avUlv0nmg6QsWtzHCstk9MRVIocFEBZscEd56snXaRMUvyRyiTXiYl1pjMDy?=
 =?us-ascii?Q?agKGJZovfCC8jQ7UhYTXEO0CUkbseqVzOdkUPnT6T+1vjAWqbuGzop5IFBiM?=
 =?us-ascii?Q?5oUZ2WdOazED8wQGDxiRowB7vpFE0UWZ/cJ+hlg/KA/pMWOXXK0rtpnUhlQ6?=
 =?us-ascii?Q?+1t3bpLdprvFPuYOyKnKO4klcCkzHJQcXbpaENczFi2LxDpRi76MnOkrxKcO?=
 =?us-ascii?Q?sbUvUTCj1io5m2G+e173SHpX9am63HCA6wTIjL/Z2oSX4DZZC6fF8YzYRQC3?=
 =?us-ascii?Q?V0jRfKc5c7BgzSN7YlbNDggpN9Net8wvEBgdahq1nIxcN4cApLaPu34P+RWu?=
 =?us-ascii?Q?2n5jp32mrxvWPmpZf6zKkeKON8dCypP7RUjHQP4notlxicHEGl1EJ1cnOLgj?=
 =?us-ascii?Q?0S5V34vvCKElVLNk4mPUd6fe8DJHlxBgPQvcFRGyROryRgiZBGZ4ilKZXVda?=
 =?us-ascii?Q?Lp7qHnyLTxnBdA4u4m8QMFRbrJWtyiTzw3tNzcSKA04GkEktEjicp4sVzejR?=
 =?us-ascii?Q?zO/by51s2sV6YRRoWo6glCnwAU/jBN4QBSOf87XYP6FA09FSXOVTUDX4Lx8z?=
 =?us-ascii?Q?8od8RHqICkwrOKa8MmjFvtcZm3+Qcae/4bhohnZYobP7fLL9v5FSqJSc0/Xs?=
 =?us-ascii?Q?YftGhFqFHeOt/k0KnHbt9hfLfQ/xZk3saB4tfBxBy6E8ys71qLVinD/nrwEe?=
 =?us-ascii?Q?0v3JO46g7+u9O3JvH5UEA8NA0fHwnQpfOpJmvSx8ZtivuHDFq4sAnxGqTYq2?=
 =?us-ascii?Q?e+9aDp44L4sgN5LIWAWQ0NXBD/Ie4fkUc/87g2tm2cMm8shuqhGkSDsAdOZP?=
 =?us-ascii?Q?oXJxdtYfKNcPgUkyqhP3UQQN9z8gTRSscky31DL2DIKFndP2WYbh4AejyyoZ?=
 =?us-ascii?Q?WbdU66DGY7aIel/I15ltMhwi4P5IpAVmOsfq8GPr9J4Ub7QwrbVGO34ECzxS?=
 =?us-ascii?Q?KW5zqFBOm+MvM40VqoO6/AgFbk5oZjzx3Rl4BCh8fbFaUHPEZS56QtVzkJRa?=
 =?us-ascii?Q?6UJJH8OVrJPf5jA9e99XrSgmD3uglhWt92xozLuKpTfSqZW2gRrwV6UFbZKo?=
 =?us-ascii?Q?UzYAiSEbYCVcaGimO3mdTSbQDIkf91pPgLgmwTGgqS4lMrUrr+/uakZV5ZvJ?=
 =?us-ascii?Q?1Vpug3H08JSaR+dgVd2vvTjJ3STNw8PE55a/zGPpFpBiRiqUOgGxkQm3X/mN?=
 =?us-ascii?Q?tzklHYR2mgpdawAN4WRWKtR8zLrjrgafpzrSJTOeY5V14CnbCHESEMkqQo/8?=
 =?us-ascii?Q?kpCucRs5vR4HgFK1mhy9N/lWu9/blZmPkwrNkIHCTlLzBPPmC5kpOsGGm9Wo?=
 =?us-ascii?Q?FrdNCqDN8RhMIVn1RuARpPUj59O8jqvTrlaBog7o9genRFCBldb7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d55dbd38-cda6-471a-e3ac-08deccd3305d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 00:47:35.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVLI4PYAItCOrFXT5fjPcjZmfjtan5UYGFmeX0C/mK8BlpaJvPw7Cm5RUC9DqVxMr8oWAT10aLdH/3lP4syDJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5242
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11586-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devverma@amd.com,m:Frank.li@oss.nxp.com,m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:bhelgaas@google.com,m:mani@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michal.simek@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:email,cfh65ggwnyas:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E03A669CEC5

On Wed, Jun 17, 2026 at 08:51:43AM -0500, Frank Li wrote:
> On Wed, Jun 17, 2026 at 05:13:32PM +0530, Verma, Devendra wrote:
> > [You don't often get email from devverma@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi Koichiro
> >
> > My first reply was auto-formatted as per the column limit but got
> > expanded after I sent it.
> > Re-sending the reply with correct formatting.
> >
> > Please excuse for the spamming!
> > regards,
> > Devendra
> >
> > On 17-Jun-26 08:47, Koichiro Den wrote:
> > > On Wed, Mar 18, 2026 at 12:34:03PM +0530, Devendra K Verma wrote:
> > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > The current code does not have the mechanisms to enable the
> > > > DMA transactions using the non-LL mode. The following two cases
> > > > are added with this patch:
> > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > >    the device side DDR is not configured, then the IP can still be
> > > >    used in non-LL mode. For all the channels DMA transactions will
> > > >    be using the non-LL mode only. This, the default non-LL mode,
> > > >    is not applicable for Synopsys IP with the current code addition.
> > > >
> > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
> > > >    and if user wants to use non-LL mode then user can do so via
> > > >    configuring the peripheral_config param of dma_slave_config.
> > > >
> > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > Changes in v15
> > > >     Rebased the branch
> > > >
> > > [snip]
> > > > +
> > > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > > > +{
> > > > +    struct dw_edma_chan *chan = chunk->chan;
> > > > +
> > > > +    if (chan->non_ll)
> > >
> > > Hi Devendra (cc: Frank),
> > >
> > > Sorry for dropping a comment now that this has already landed.
> > >
> > > I'm wondering about the lifetime of chan->non_ll. This patch lets a client
> > > select non-LL mode through dma_slave_config.peripheral_config for a transfer,
> > > but the state is stored on the channel.
> > >
> > > We use chan->non_ll in prep to choose bursts_max, then read it again later in
> > > dw_hdma_v0_core_start() to choose the LL vs non-LL start path. If the channel is
> > > reconfigured between prep and start, or before a later chunk is started from the
> > > interrupt path, couldn't we start a descriptor in a different mode from the one
> > > it was prepared for?
> > >
> >
> > The mode is implemented with the intention that after prep, the
> > submitted descriptor shall completed with the chosen mode. So, yes the
> > mode is decided in the prep call and all the subsequent descriptors are
> > completed with the chosen mode unless it is overridden by another prep
> > call.
> >
> > > (Note: Frank's not-yet-merged dma_prep_config v7 series [1] also looks at
> > > potential races around config+prep on the same channel from multiple process
> > > contexts, as I understand it. But this seems like a separate issue, since the
> > > state is read again at transfer start time.)
> > >
> > > Should non_ll be snapshotted into the descriptor/chunk, maybe as
> > > dw_edma_desc.non_ll, or is the rule that clients must not reconfigure the
> > > channel while anything is pending/running?
> > >
> >
> > I am not aware of any such rule which specifies that modes can not be
> > mixed but it would not be a good idea to mix both. Let me give an
> > example, in the non-LL mode the channels *can* utilize the LL-regions
> > for data transfers. If for such a non-LL data transfer where LL-region
> > is used and intended by the user then changing the mode after setting up
> > the mode to another one can cause data corruption.
> >
> > Eg:
> > Channel LL-region = ADDR
> > Mode set to non-LL -> DDR destination to ADDR to (ADDR + size)
> > First non-LL burst -> writes data to ADDR till size bytes.
> > Second burst configured for LL -> overwrites the data at ADDR with
> > descriptor information.
> 
> I don't think we need mix LL and no-LL, previously config suppose only do
> once before prepare and never change again.
> 
> But recently there are more user case to config for each prep. After [1]
> merge, we can consider more. There should be no risk now if DMA consumer
> don't change it during prepare.
> 
> Frank

Devendra, thanks for your quick response. That seems to confirm my concern.
Whether we keep that as an implicit assumption, or make the driver robust
against it, is probably a subsystem/maintainer call. I do not intend to push
this further for now.

Frank, thanks for the follow-up. Besides [1], I suspect that [2] may also affect
the eventual implementation if we decide to make it robust.

Anyway, thanks both for the quick clarification! Let's revisit this when [1]
and/or [2] settles.

[2] https://lore.kernel.org/dmaengine/20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com/

Best regards,
Koichiro

> 
> >
> > This one causes the data corruption for the first burst
> >
> >
> > > Or was this already discussed, and there is some implicit restriction that
> > > clients must not mix LL and temporary non-LL requests from multiple contexts on
> > > the same channel?
> > >
> > > [1] https://lore.kernel.org/dmaengine/20260521-dma_prep_config-v7-0-1f73f4899883@nxp.com/
> > >
> > > Thanks,
> > > Koichiro
> > >
> > > > +            dw_hdma_v0_core_non_ll_start(chunk);
> > > > +    else
> > > > +            dw_hdma_v0_core_ll_start(chunk, first);
> > > > +}
> > > > +
> > > >   static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
> > > >   {
> > > >      struct dw_edma *dw = chan->dw;
> > > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > index eab5fd7177e5..7759ba9b4850 100644
> > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > @@ -12,6 +12,7 @@
> > > >   #include <linux/dmaengine.h>
> > > >
> > > >   #define HDMA_V0_MAX_NR_CH                  8
> > > > +#define HDMA_V0_CH_EN                               BIT(0)
> > > >   #define HDMA_V0_LOCAL_ABORT_INT_EN         BIT(6)
> > > >   #define HDMA_V0_REMOTE_ABORT_INT_EN                BIT(5)
> > > >   #define HDMA_V0_LOCAL_STOP_INT_EN          BIT(4)
> > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > index 270b5458aecf..61d6064fcfed 100644
> > > > --- a/include/linux/dma/edma.h
> > > > +++ b/include/linux/dma/edma.h
> > > > @@ -97,6 +97,7 @@ struct dw_edma_chip {
> > > >      enum dw_edma_map_format mf;
> > > >
> > > >      struct dw_edma          *dw;
> > > > +    bool                    cfg_non_ll;
> > > >   };
> > > >
> > > >   /* Export to the platform drivers */
> > > > --
> > > > 2.43.0
> > > >
> >

