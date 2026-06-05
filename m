Return-Path: <dmaengine+bounces-11177-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hv0KNqw0ImpaTwEAu9opvQ
	(envelope-from <dmaengine+bounces-11177-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 04:30:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EED644B12
	for <lists+dmaengine@lfdr.de>; Fri, 05 Jun 2026 04:30:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=EgQfV7Fm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11177-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11177-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD44730247C7
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jun 2026 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F53845D5;
	Fri,  5 Jun 2026 02:26:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020092.outbound.protection.outlook.com [52.101.228.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497A1EF39E;
	Fri,  5 Jun 2026 02:26:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780626402; cv=fail; b=lYJrSHg8NzivW0/Uqu8LlUiveS/0eLor00WwCvbr2JQLjZRd1z1ZCi+YZRN1/MXh4rXK4h6ymsNN0LDt5E9wrnyLlZmawY+AYvRnAp02naHWbyW1KsUlXU37ab8uuc0ONR+fnUiusy/lGlk5xxvPdVc6WXBpqpqIkWnkDoPwBQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780626402; c=relaxed/simple;
	bh=TWLPW3V4J4w22PlFm0BnI2rBuChnnPBmKQolKkTKhHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WPYdcaC2BQNmn//Bi9LMenlcrCLtjLgnrtMJHQqFLHmfXEjbGBSEKS2Rddbt0ggjH50re7k91dgRH8HoHrYz5KIq2wZnbwWqeKssOmi5kwIF1XgYoHoobhpEhKo7V3kqAE6Nhwtes7LQvoxWdtT0l16QIUMKbElXGhVNScVF+xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EgQfV7Fm; arc=fail smtp.client-ip=52.101.228.92
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJS7LHRkkHeGZJNPWKOPLyL2NRch2qeI3o0OweqvpyECtJ/ZEmJ30e4JB5EBP3OdVx1YnJLuBNm83gUWRFPMfSMZafHdwyRAoeS0e4mfqfvtVf9D09UcmxwrZIZOMs87SExZ5VbXgKgyYfeCoeK1mMASJRjWWsV3fHWxvezjai2Qxj0qIkoE9+ZtmAsf4gzZ9liW14367LDlbL2aY7/ymT/I2o1nkiKzBsmOAnAsyoAoJVsEVXgxOxwfS8d/9oqm3MacB0WJYOew1aaC+tYB0ysXrKzqm6FIATWL4LKVjeX9fwv+sAlSbLbIi8aEhHXVi0kiZXQ5a0sSutbGMZl17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Nl0Z+P3vQprTnf8107lLFZh+jA54Io5YnVyMVvz9aQ=;
 b=TUmLdTSVe8wM2sfZ8CU39h2SjpX4jrDIS10pGmrhKaObGPTvPee0awsQmV3wCT8ty6gQ/6mSrl4RlIPrGDfWGHQH6DcEc7wa0BnryrwxzNRDuz4B18bPpirSv78I9/SOMqQRk4rh49L6kcCTMEwVklAevLnMKAMLSyN2oDTRnopXbxUTUBo0F0p4qhrxovjjEhO/52Gq3CI/kqKfsyTw/PgsH/uqFZI9ACY8n7B4BOJ3eRrsSnFDOmy/DUWne7SDz+9l0Pl8cMXOjHUXtMfoHNxFcDBHicYqhweUFOajHgADUY233ytagtsxMLXK8le3k24NMtKOfW5rzRtHWohC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nl0Z+P3vQprTnf8107lLFZh+jA54Io5YnVyMVvz9aQ=;
 b=EgQfV7Fme5ONkbOYbsQJ+1J++R+yPdOjuxxVl/htOTrylWi+rtCyjhtXgyf9TXmu6+xhc2K4K0urVP2wsIv/9/DLtpoEsVxLlG0eEmfMxWDLMJYxF463PR1jDyU2hyxIayCoZW7z8UeKG/n7tMfz4cj+wTLD+4BLWy1EN1Zsb1U=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6881.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 02:26:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:26:27 +0000
Date: Fri, 5 Jun 2026 11:26:27 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] dmaengine: dw-edma: Add hardware channel filter
Message-ID: <54dmyjswl3ndn74o5zk34yuqrp6aytpi3oytmwc4ft7ihlivys@gwayafimmpbz>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-2-den@valinux.co.jp>
 <aiHipgrBEKYRZqhg@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiHipgrBEKYRZqhg@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY6PR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cc9cc5-7dc7-4e7c-b4fc-08dec2a9d8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	R4ZXasLJjGiydgsRvBZVRkn/u7MMbnvP0wNKZK43bkNLH2oAKm3TwXGNx3JW1Un2zsBVwz+zs3Tw6lUUnwosQbkcUz/onUyHGovGiXTxZSR4Y64I0E93n/WjT91HVMvmu+9yV438MHEj1F985Ha5+oNHWVuTCinRiodfCTpggdUgUiq//kkCTe/cU0YFksHhRZnr/2AFvldtj3JXRqeBNpSjzn1cp+U9M+g1XtM/nHWG7P8po7Hy2wI/EUI3w4cfl6wxGSsTBAf98yFUZ/AVmCle5I0UEHX/czS2+unTSM02ShAjFQ3hTs2fPrC7C2D+qsUil7edI4QErc8nz7MeqVYu+FPRb4Y+UArrWNkSu0ewXFS2QMj6sUqpjZobjk+69I38e1IEAhgNnKYM0lsrRS5ondjI9XEteDqYI5N/MMa3+/5VBOkxYJs0w977kt1dWJKettwacYMk2ScwotV2AJWwhTb+C1kjudQ1WYch0Za1yf9dosCFwO/5QjXCspBH21pO+3sRQXCracas2aixJo6dMByv5Zid+F7oRaBxCCWrmgA+un3Clep5U7so1knhbXzeABc403+dayeaud8AQUK4aVMzFOa/fjf3eaqgO6bmEiWoEyhtXQ3nuVcZQrZUifAzvi96Cpn9xKwDHZVoSGdYPZDEv/8LAfRGyGe9+K0i+KMEymNoy+rflfeo6u9KCdJrOpAtpQ0ZHjUXWuiZEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MesgqcVlDOFffqdDSxbS7SV4zoUbVF6BcKMnZSaSK6Af/LNjWvpdbMiaSUFu?=
 =?us-ascii?Q?AoDTFSUFUPMfDZUH75d6ShB3M3qlyOWABj3vmLdPXyYwLkCQutz+9lhL0CVD?=
 =?us-ascii?Q?0HQrwNB651uXQKm8vwhgCWavnCpsw+Yh4KzBDdVfrzi16o6q8sADOrxg2wf+?=
 =?us-ascii?Q?KwL7ZCTsAt1ZDd7QGGbr6496+FUkM4uYWo5xrxJW4rpUSWax2UOfzWwivP8W?=
 =?us-ascii?Q?SljihFeJZXyiFVh8OOm9ko8/ur/DK5gO4qWwj0vjw+eOHaZoNINewbqsnZDe?=
 =?us-ascii?Q?ut/B/rdjOLKSGWQKY/beeOj6IYnnmYTVe0TyTP02UvTlfAb5upwpi7kfYN7Y?=
 =?us-ascii?Q?E9P6uMntvNFDlkKL4byj5/uDLHuqG/kxHRbAiHoLYeTSMSBHNwc4I6IIJ7iY?=
 =?us-ascii?Q?sVDCO9onqe8eDJfUyT0jMrbj4H7Ogw9loln4PBxXNyNplUFEgN5yKzBqMljC?=
 =?us-ascii?Q?Gidlaw0lbBwfRvCPz/T62kYwtVWwQbhMQ506F1OWHIgzynVODd4kZAio+lll?=
 =?us-ascii?Q?G+yIb79wH3WrWf0mPHz6Eo6z3ambdGHwN8uUn8W8Xx1UhfhGd9N7x+Qaxe7q?=
 =?us-ascii?Q?2nZYFOfWcddiuGOi3EXciswo4zkEN2P8xY+czgYGAQMYBPZeTKEXWV1N5r1u?=
 =?us-ascii?Q?tYX3b1oigeid0Eiw2bDi3FiYsX8UTgz2F4CSRvZdMnTPqJ+QvlzoEN5uB26g?=
 =?us-ascii?Q?IOb3oTAXF1hUIpiw4fGbg4xTXsm5MAglix2Vdbxzs7wGcwJ+YxZ4GYT3m4Zh?=
 =?us-ascii?Q?o/Qlvf71FMg1OpbtStfWv/Xh0ThA0St5vC3iF8Hlv5J4sJGTn5jhr5IZR0rV?=
 =?us-ascii?Q?fhae7ol6AVx5ovOwzBBSvFGa8/xLQu3MbrMlmxcgAOcSI4uQu2E6hyyfY8Iy?=
 =?us-ascii?Q?2sPHWW+0/5kbXvIkv+3HRRHB7WP3EwBxWDb4ptXQjUKEiWZ2Bon5M4VcdHCu?=
 =?us-ascii?Q?PsUXMwbKOx7vTPh4bmYde1gqfm6UxkMPs06K0VXUkZ8EeWuFNnnIjBSVw9YU?=
 =?us-ascii?Q?ZssQn052QXbSkn84ycQ1WfVs2ek+gIEyLe+q3Z3or+nt93WmXGVktA7HHjPC?=
 =?us-ascii?Q?o5Z619Hkgd+68DLqkTRlp25gASqN9FZIwAYK3HDdsDqhSruMz3nJSNGWPKzY?=
 =?us-ascii?Q?QmApyB8i0702BGE0iKP8fQvLGEHtanAJ/TIRzxkIbe69i4Jh2Lx380MqYQzz?=
 =?us-ascii?Q?SFk0h3asVaee+Ej2GxMjHRDv7pcNldXU5Avt44QYi4QheBW8S4+xJZ3Y9Xi0?=
 =?us-ascii?Q?HN/h1338DK5c/izeC+AHlS+JLKvcPfUqeGjYhJilDsx4VA/Ayf3Zlk1T15oN?=
 =?us-ascii?Q?KYc5pXmGtwELjlVWGCIog6JCpcqMMmyUnNPCJUZ8+lUGTQ4FptvK8KT9+8B0?=
 =?us-ascii?Q?MiR3McKRtWxlpM1RZ2V4O7/miU1UjMnLt2yL+RTw07dECyFiZn2HJNHwcVu8?=
 =?us-ascii?Q?H6unnO4TkuSfs8PI/ZT2nJSmnVfAZjlSzIYCl35tcYZRXwrmnHyLKQxTgOVI?=
 =?us-ascii?Q?XIlfvrM1AFLiw/s/Bp8O4a2qRv6JwiGeGH/QxIDwZEGrkXSwHWbWkJ2cRsuQ?=
 =?us-ascii?Q?lBbY5Mb/oaNZgHnPBUre7hslzFKyRus5R6Tv4d5zroDOH1NKnI7gxmWiW0Zk?=
 =?us-ascii?Q?2aTGqb0kQUV4JDe/+fcbvNG0K1IjcYnzRvkpgl+PDuFbXS5lNyBDg7C5hmvw?=
 =?us-ascii?Q?LVNBenWLxYrdk7dvCRdKS1BPWcfJFzBl2IptvanKb9LzNdk6a+Nd9CSDd1Dx?=
 =?us-ascii?Q?N9PsfNdsxldyhDUpueJq0+d2/2gGRM+E68qsV0/hlmWuCmAx3GoZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cc9cc5-7dc7-4e7c-b4fc-08dec2a9d8e2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:26:27.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL4/RhtlLmxHTI7Z8yIfXOfTxs9bfFuanSbFPOowVSQ+QU8WASJ57cYKOaZRKEDi9PiKSTySsJLszgeBnMqOyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6881
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11177-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,synopsys.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32EED644B12

On Thu, Jun 04, 2026 at 04:40:06PM -0400, Frank Li wrote:
> On Mon, May 25, 2026 at 03:24:09PM +0900, Koichiro Den wrote:
> > Add a dma_request_channel() filter that matches a DesignWare eDMA
> > write/read hardware channel by hardware channel number.
> >
> > PCI endpoint resource enumeration can describe hardware channel metadata
> > and let consumers claim it through the normal DMAengine request path.
> > This avoids returning an unclaimed dma_chan pointer to the caller and does
> > not require making dma_get_slave_channel() public.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v2:
> >   - New patch. Replace the raw channel lookup helper with a
> >     dma_request_channel() filter.
> >   - Do not make dma_get_slave_channel() public.
> >     Patch 01/12 "dmaengine: Make dma_get_slave_channel() public" is
> >     dropped.
> >
> >  drivers/dma/dw-edma/dw-edma-core.c | 15 +++++++++++++++
> >  include/linux/dma/edma.h           | 18 ++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index c2feb3adc79f..80b4a168225b 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -1189,6 +1189,21 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> >
> > +bool dw_edma_filter_hw_chan(struct dma_chan *dchan, void *param)
> > +{
> > +	struct dw_edma_hw_chan_filter *filter = param;
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (!filter || dchan->device->dev != filter->dma_dev)
> > +		return false;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +
> > +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> > +	       chan->id == filter->id;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_filter_hw_chan);
> > +
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 1fafd5b0e315..3e15cf83b784 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -106,10 +106,23 @@ struct dw_edma_chip {
> >  	bool			cfg_non_ll;
> >  };
> >
> > +/**
> > + * struct dw_edma_hw_chan_filter - DesignWare eDMA hardware channel selector
> > + * @dma_dev: DMA controller device to match
> > + * @write: true to select a write channel, false to select a read channel
> > + * @id: hardware channel number within the selected direction
> > + */
> > +struct dw_edma_hw_chan_filter {
> > +	struct device	*dma_dev;
> > +	bool		write;
> > +	u16		id;
> > +};
> > +
> 
> I have not seen user for this, not sure why it need be in this public header

Thanks for the review.

It is used by the DesignWare EP resource provider added in part 2:
https://lore.kernel.org/linux-pci/20260525063129.3316894-4-den@valinux.co.jp/
Since that provider lives outside drivers/dma/dw-edma, the filter definition
needs to be visible outside the dw-edma core.

As a side note, this was added in v2, after Sashiko's feedback [1]. The v2 model
is:

  - The PCI aux resource provider describes static HW channel resources, rather
    than potentially unstable dma_chan pointers.
  - When the EPF delegates some of the channels to the peer host, it requests
    the channel by matching the HW channel id.

If the lifetime/removal model changes based on your feedback on [PATCH v2
03/12], we could possibly go back to the v1 model [2], where the PCI aux
resource provider describes channel resources with dma_chan pointers. In that
case, we would need to document that those dma_chan pointers must remain valid
for the lifetime of the aux resource consumer, and this dw_edma_hw_chan_filter
helper would no longer be needed; dw_edma_find_channel() could be revived [3].

[1] https://lore.kernel.org/dmaengine/20260521065525.C65DB1F000E9@smtp.kernel.org/
[2] https://lore.kernel.org/linux-pci/20260521063405.2842644-3-den@valinux.co.jp/
[3] https://lore.kernel.org/dmaengine/20260521063115.2842238-3-den@valinux.co.jp/

Best regards,
Koichiro

> 
> Frank
> 
> >  /* Export to the platform drivers */
> >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> >  int dw_edma_probe(struct dw_edma_chip *chip);
> >  int dw_edma_remove(struct dw_edma_chip *chip);
> > +bool dw_edma_filter_hw_chan(struct dma_chan *chan, void *param);
> >  #else
> >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> >  {
> > @@ -120,6 +133,11 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline bool dw_edma_filter_hw_chan(struct dma_chan *chan, void *param)
> > +{
> > +	return false;
> > +}
> >  #endif /* CONFIG_DW_EDMA */
> >
> >  #endif /* _DW_EDMA_H */
> > --
> > 2.51.0
> >

