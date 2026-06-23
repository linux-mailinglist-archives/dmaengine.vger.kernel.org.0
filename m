Return-Path: <dmaengine+bounces-11737-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bC0pC+AFOmrf0AcAu9opvQ
	(envelope-from <dmaengine+bounces-11737-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 06:04:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E3E6B3F06
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 06:04:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=Amd7vj4O;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11737-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11737-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37C283050925
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 04:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC439184A;
	Tue, 23 Jun 2026 04:03:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020096.outbound.protection.outlook.com [52.101.229.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0E39022B;
	Tue, 23 Jun 2026 04:03:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187414; cv=fail; b=khlpGPW1TnYqS+b3c7JbHc9W+2y4o4YxpjA6z9fXu4PQAy0NMz/Ivdvo2eTZ389tJYAt44lk4p6GhIi4UNhB815lSGALNthBsOBA3A7lkFOoIy5zAdLPD46hbiHZmdPaOGnOC1yrD8qLktvdlVdN3S4xa5a1d6HJ/L147qVs8tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187414; c=relaxed/simple;
	bh=QvdHUgrBzF7+E0oLLXNBWU7YN+pLf0hG/H64fosnb/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jt+y3Jvz92u8EvGt7FRXA0ioKNJdiuzu06B/w9TcpMmlc0c3QBdj72Ma5HauLux6uA7N3tV1q8oVoOKXJaEaBjMbMO3++WQ6mrRG64Ejp32IAL0uBqzMi83kE2WfQ96QQ1NctMZqPuGnq2UMiGJ97ZA1tNDwp/gPsWdk8ziW9jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Amd7vj4O; arc=fail smtp.client-ip=52.101.229.96
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/TLIUIPlRhhxap2okZoodD8/zuRkJNl25jlRreB8F2klfhzvmTANhToHrDuv7c8z1xDYYF2rdd4Vis65sBcfCcZcrSzL3trk+f10CwXJYb9qX5bK/bQZ4BJd7jjhEJ6WCGSldcAaYoFf21JGMWhVcQsQTjnjs5k5viu+6e4YsCHXlqa6kZtJu2/R3/b/4JBwlXqTYoBh74P+xafXl17w5mPIFmSQVY+OVwi5hz66km/i0u3Hix3q8K6WoC1ihziyr5KYPi0J7LFG3VbH69fCL5AMMWmGJWdrdwkbVg0lk7cj6C7eMtL/2zF3HXRZkRfPj6oL44eAoItCAibwTp7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke6b8Tn60Hbem2pbCHUy2Z1pf8ru80yAC/izTQPwcpM=;
 b=Kv8cSJD/OnaZZwx1lDU7tQ9Xkw8V8It3lF5cey2bqDoIaziNRz6nRBb/r2FFHYwcjVlbH4OzwPOcH4antANc4s7mzx1NPlfOvf+ztKmtyLlM9l1W3P+VVqmUd3W+GkVIEs5xNA1CS+pAPb3qAlGBCVV3GrYnWv41B8o/k6RZeR7bQAxTtWNai8DCsh8XeXauEludxxGcslf1pQOnAd4ES6Y+Ar4+zmuvdcz+EJXSOUC29eQan/QwCNoSgGjZZRKMDLTC5qGbMViFHOnmrRkavPV37G9t9V6jgClXQmpfD0ORX6IRoa7wYnmomLLlGbDsJQQGLB/QYdM0Qv6mywuEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke6b8Tn60Hbem2pbCHUy2Z1pf8ru80yAC/izTQPwcpM=;
 b=Amd7vj4OdWi8fzJE7e+FhMFgsvW14pEXDwBQ7meBzDUvxxGLuhD8JQg813oKY4nbLn9ZEBxy7pOPrLSPPmJ/hFkzXpXmPmAjHHisCwYpds0rJeyo1mfk585ckBKuyafQBpJoM24y2TRN+ACt3B+HtvZ1x40LgvukIjQbU/a7Gi8=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB1702.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 04:03:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 04:03:27 +0000
Date: Tue, 23 Jun 2026 13:03:26 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/13] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <3223kd5l6luttbwtqn5nubsehml7edmvezjt5wvsvlzj7dg7vr@y5la7xq6r2ho>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-2-den@valinux.co.jp>
 <ajlWCeFlcGFbeLwY@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlWCeFlcGFbeLwY@SMW015318>
X-ClientProxiedBy: TYCP301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB1702:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9fc200-f638-483f-8a6c-08ded0dc614f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|23010399003|18002099003|22082099003|6133799003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9nUaDI2THjyrxChGA2C1KGlEUbWdpja/jrNTtGh0cOzUo+nSwYY1w1GWcoOwm0sjTfV6QBnCCpL1ZSw37gh8GTq01KW0z+zDk0MJ5zvGHKs7Wjtk6P93ygoGCTSd2UJX1yQn5ukyV2wpTySKvYR04OtfJocG5ii/KASu3THrMJs22uA8zeNrheY+6FV5Bh2em00HhUcYIvLnDaEzA9TTIXBENeBEaO9dwGkKgkN8lNYixJgm+dxtTL1PidFSE+2xCOMVoPex2C1CqKK5Xg38Wbbu2dhbJuu+p0LcW/06zI3/z7Erk9Z2e+k/7SjVgoGvKqWQLn3NIohi84/luGzBojIha8WGrjGBRkZBvJXuKPq/uniBsqOImQ3tvwB6Ocv44rMnRb+NO/zYeMRIJEug9Lsj0qSZMp88A5+PYGg0MaOyE25tCailKQQJHVDde7s+JBHkhGXlPCiWlPUpXkpJg4OpqJZCez4xfcMIh+A2ciXViq7L6drdaJ400LQ2AjlbckEn8W0t+EOAb1XGu7IIY4gTqBQGjYZlqnzDTJQQirReA7AAeaDCuxAahLdOVehRtW4lV+LP/9O9r1GebViUn5brpEqbGyczgYrfwQ+KIXBrNspq5CIyzenQcSnR8CVmKU1XqpRQvBHyMgAQqfHrt0RoszjgLdlvQgdyTdWgt7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYIoKMz/3tzgprtIFbh4nLOkVKZekZl1/HgN43W7Ls5913uBTzROI5gzMIah?=
 =?us-ascii?Q?xah88koH704xhdoakRpPmv8GgxPooqNEqD0yS0eSxn8ixjUBBnY4/pb9FQXk?=
 =?us-ascii?Q?PyowpBLvEHJvMv+VIPgIUZw7ts/vUTk6P4TqB73tnK4VP/fq77HcOCJiRcHl?=
 =?us-ascii?Q?AUdGxzzAluPitKLJr8kP5h8Hids+ET1F2PeF+kvmGZL0HjtdVEUGwS+sQaFR?=
 =?us-ascii?Q?z4QNMrkhAZR+0+faiqyXh3NKjgl2IawPwWwSoJRlBIjD25MC4y+c2IN8lnV1?=
 =?us-ascii?Q?GbeBefic/zcbl7Ru8fxkAbsCtMWYVntFXMABweCswIjg5fNrt28tNeIA+ccw?=
 =?us-ascii?Q?00rUbpbYsBHbRyfz1pjJCRrzAfZM4L8LjqwYa5giTueZ9cYSYVU1YDRRA/o5?=
 =?us-ascii?Q?bghcD6AlUWAfSZ1fsv2JiilEKTfj6B4545jGGd2xYczQpB47EZo2kiRLQ9qc?=
 =?us-ascii?Q?2WCjuUO7VqRbkQUdubVlhD2Lc0MyTYtgGg0cVlqk5he7dPTKagsPuqgUXs1J?=
 =?us-ascii?Q?ECaHFpQKSRVu7SQqiklPswZIyh8hRPfLR5u7dh10tUwlDP8EOHNJ9DGyG6TI?=
 =?us-ascii?Q?hBUFF8XZDw3ebdeLcIn2737S6uYs+y5p2tUJR1McssBTqNgrPN8O7eboZv5S?=
 =?us-ascii?Q?2pnOSWNBtf9uxRzXIJ9FlCx4vXzdDBREFPjtxym5r8i4MtAI9PKllsNW89Di?=
 =?us-ascii?Q?2RQVhhWZCuavvysp4mLSKrWHguswkZr+jqV0tBzkGkOo1KfO8whAcDzm3Y6V?=
 =?us-ascii?Q?I9EtLQZimE5UD+pOeDkXKsw2vGy0sUstRlYJ7F8RzcxZHuYjggWW16c+Ikwf?=
 =?us-ascii?Q?No8C2NPfkz7YTriU0ox8HFBPTfJCqmRXr98aTGNIpRCQ2TNtEeAj+ygL6f5w?=
 =?us-ascii?Q?B1vvvpRm86O1LshzC1VpJMcTJUnktasMcmAnsjAlcBnquwTsnoJDaVu2kB2K?=
 =?us-ascii?Q?3251lC2puW0kH0vVUTX8VHo0vieD5w2QLG5F2Vk1pPrVuGkXOt8yg85LNiSu?=
 =?us-ascii?Q?H4jk4URW5gRLHhTPlZACKqm7yo9PCkBWKtPYwdIEhQeASIqAy4vAHfP35lv9?=
 =?us-ascii?Q?AuAEEKK6osUw4UH6oC17ryF73xpRilYD+LIooR+jmxVPFNML4FqpFXKbH8Uj?=
 =?us-ascii?Q?sjmPTW8EqsIoKhIJLncj0pQFnA3NpEg1CmlQvj3Fvbe625plPMUCjtKlIUvV?=
 =?us-ascii?Q?MKRMWkkWgdcNSWdI2hMoUk4+CSWtd/BzwrK5xAKAonDK9NgzRwxeI5y0U/4j?=
 =?us-ascii?Q?I/kyrLJKLMolpsIqihVdPzt+/m1UcE727xctSm3mZ6Z9pZzpBCLRgGV2jBAG?=
 =?us-ascii?Q?Axvtw4Tisjen0Ejawld0V92JEIOPXigo8NwyE9L81RWFfZh/iksgwA38bREG?=
 =?us-ascii?Q?ecsZJuTt3tCdC7QEcbwsEDtF9SDOa/sea79PTH7MkGPSjOa9FsTjDrkIsb8g?=
 =?us-ascii?Q?yxPehwCRcMQp3Jk2klTMoPE7H+UXgVQPiEHlTahc7/qpMP4kk3/7266LlH9g?=
 =?us-ascii?Q?9yp7WGP47KoGdojzGcu+n2pNQ4LoBrEdfBOIDET/YrpUoOL9Vg92vA0h2h1i?=
 =?us-ascii?Q?cO8GkjgycP5xferLUaxM/r/OwrcFxutleNEst8SeE6XLCtrJaoyMTOw0IqYD?=
 =?us-ascii?Q?4qSRj8YrxT6bRES9Lg2oRYpUD5okVauDbqcu0dFuqbyLCGtXWRN4z0OozH/4?=
 =?us-ascii?Q?ZJlyML+wbfMsPiWZsf6tguDpQRDhtjFKTJhNT3X0ssQztHW+wh9YyJt8CTbz?=
 =?us-ascii?Q?03ntHj33Scas0Qit1ZLOZWLA7n2mjoaPPg+sP2/JTQG1SGGwUjqa?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9fc200-f638-483f-8a6c-08ded0dc614f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:03:27.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 806i2cltQrg1yEuZflgViZtPxTzJFdw2IEG9K8+91Pvvl6Z4g/vRpO2XbyxYYWXIad2UmHqPM9SRZW8fhfL9vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1702
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
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11737-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74E3E6B3F06

On Mon, Jun 22, 2026 at 10:34:33AM -0500, Frank Li wrote:
> On Sun, Jun 21, 2026 at 02:00:28AM +0900, Koichiro Den wrote:
> > DesignWare eDMA can signal completion locally through edma_int[] and
> > remotely through IMWr/MSI. When channels are delegated to a remote
> > frontend, the local endpoint side and the remote host side must not both
> > service the same DONE/ABORT status.
> >
> > Add channel interrupt routing state and initialize it from the
> > controller instance configuration. Update the v0 eDMA and HDMA native
> > paths so linked-list interrupt generation, HDMA non-linked-list
> > interrupt enables, and DONE/ABORT masking follow the selected mode. For
> > HDMA native non-linked-list channels, use the dedicated remote
> > stop/abort enables without local stop/abort enables.
> >
> > Keep the existing dw-edma-pcie host-side instances in remote interrupt
> > routing mode so their IMWr/MSI completion model remains unchanged after
> > local routing becomes the zero value.
> >
> > Note that the routing mode describes where a channel should report
> > completion. It does not, by itself, say whether this dw-edma instance
> > owns the interrupt status. A local instance must ignore remote-only
> > channels, and a remote instance must ignore local-only channels, even if
> > such interrupts are unexpectedly delivered. Otherwise the non-owner side
> > could steal the interrupt from the owner by clearing shared DONE/ABORT
> > status.
> >
> > Suggested-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v3:
> >   - Remove DW_EDMA_CH_IRQ_DEFAULT; local routing is the zero value
> >     (Frank).
> >   - Set existing dw-edma-pcie host-side instances to remote interrupt
> >     routing in this patch, preserving the legacy IMWr completion model.
> >   - Remove an unreachable HDMA native check (Sashiko).
> >   - Clarify local/remote instance ownership after Frank's question.
> >   - Mark non-owner IRQ handling guard paths unlikely.
> >   - Add HDMA native interrupt routing while keeping the existing non-LL
> >     int config ABI.
> >   - Keep HDMA native linked-list local interrupt generation enabled for
> >     remote-routed channels while masking the local edma_int[] output.
> >   - Use remote-only stop/abort enables for HDMA native non-LL remote-routed
> >     channels.
> >   - Drop the peripheral_config IRQ-routing ABI; initial routing comes from
> >     chip setup and channel ownership handoff can override it.
> >   - Keep dma_slave_config from resetting channel ownership routing.
> >
> >  drivers/dma/dw-edma/dw-edma-core.c    | 14 +++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++
> >  drivers/dma/dw-edma/dw-edma-pcie.c    |  1 +
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++++++----
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 41 ++++++++++++++++-----------
> >  include/linux/dma/edma.h              | 30 ++++++++++++++++++++
> >  6 files changed, 99 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 89a4c498a17b..7a24248b84e9 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -219,6 +219,17 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
> >  	}
> >  }
> >
> > +static enum dw_edma_ch_irq_mode dw_edma_get_irq_mode(struct dw_edma_chan *chan)
> > +{
> 
> dw_edma_get_default_irq_mode() ?

Yes, that naming is a better fit.

> 
> > +	struct dw_edma_chip *chip = chan->dw->chip;
> > +
> > +	if (chip->irq_mode == DW_EDMA_CH_IRQ_REMOTE &&
> > +	    !(chip->flags & DW_EDMA_CHIP_LOCAL))
> > +		return DW_EDMA_CH_IRQ_REMOTE;
> > +
> 
> return chip->flags & DW_EDMA_CHIP_LOCAL ? DW_EDMA_CH_IRQ_LOCAL : DW_EDMA_CH_IRQ_LOCAL

Assuming the second value meant DW_EDMA_CH_IRQ_REMOTE, yes.

The default can be derived from DW_EDMA_CHIP_LOCAL only (even if CHIP_PARTIAL is
introduced), so the chip-level irq_mode is unnecessary, as you pointed out
below for another hunk.

I will simplify this.

> 
> > +	return DW_EDMA_CH_IRQ_LOCAL;
> > +}
> > +
> >  static int dw_edma_device_config(struct dma_chan *dchan,
> >  				 struct dma_slave_config *config)
> >  {
> > @@ -853,6 +864,8 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
> >  	if (chan->status != EDMA_ST_IDLE)
> >  		return -EBUSY;
> >
> > +	chan->irq_mode = dw_edma_get_irq_mode(chan);
> > +
> >  	return 0;
> >  }
> >
> > @@ -904,6 +917,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  		chan->configured = false;
> >  		chan->request = EDMA_REQ_NONE;
> >  		chan->status = EDMA_ST_IDLE;
> > +		chan->irq_mode = dw_edma_get_irq_mode(chan);
> 
> if already set in dw_edma_alloc_chan_resources(), needn't set again?

You're right, but I would drop the hunk in dw_edma_alloc_chan_resources().
The initial routing can be set during channel setup.

> 
> >
> >  		if (chan->dir == EDMA_DIR_WRITE)
> >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 6474cacf7195..42f2f25ef377 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -81,6 +81,8 @@ struct dw_edma_chan {
> >
> >  	struct msi_msg			msi;
> >
> > +	enum dw_edma_ch_irq_mode	irq_mode;
> > +
> >  	enum dw_edma_request		request;
> >  	enum dw_edma_status		status;
> >  	u8				configured;
> > @@ -224,4 +226,15 @@ dw_edma_core_db_offset(struct dw_edma *dw)
> >  	return dw->core->db_offset(dw);
> >  }
> >
> > +static inline bool
> > +dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
> > +{
> > +	struct dw_edma *dw = chan->dw;
> > +
> > +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> > +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> 
> is it okay to simple return false here?

I do not think so. For a delegated channel, the EP-side dw-edma must not clear
DONE/ABORT status if the local handler is entered for another channel and
happens to observe status on the delegated channel.

For example, when nr_irqs == 1, dw_edma_interrupt_common() handles both write
and read directions from the same IRQ line. A local EP-owned WRITE completion
can enter the handler while an RC-owned READ channel also has DONE/ABORT status
pending. Without the ownership guard, the EP-side handler could clear the
RC-owned READ status.

HDMA native has a similar case within one direction: if one WRITE channel is
owned locally and another WRITE channel is delegated to the RC side, an
interrupt for the local channel can make the handler walk the same direction and
observe the delegated channel status.

So this should not simply return false. The guard is not for the expected
interrupt path; it is there to keep the non-owner side from consuming shared
sompletion status when the handler is entered for some other reason.

If I am missing the concern behind your question here, please let me know.

> 
> > +	else
> > +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> > +}
> > +
> >  #endif /* _DW_EDMA_CORE_H */
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 791c46e8ae4c..70ea031147d1 100644
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -419,6 +419,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >  	chip->dev = dev;
> >
> >  	chip->mf = vsec_data->mf;
> > +	chip->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> >  	chip->nr_irqs = nr_irqs;
> >  	chip->ops = &dw_edma_pcie_plat_ops;
> >  	chip->cfg_non_ll = non_ll;
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index cfdd6463252e..1781ba4f022e 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -256,9 +256,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	for_each_set_bit(pos, &val, total) {
> >  		chan = &dw->chan[pos + off];
> >
> > +		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
> > +			continue;
> > +
> >  		dw_edma_v0_core_clear_done_int(chan);
> >  		done(chan);
> > -
> 
> clean up these unncessary chagnes.

Will fix.

> 
> >  		ret = IRQ_HANDLED;
> >  	}
> >
> > @@ -267,9 +269,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	for_each_set_bit(pos, &val, total) {
> >  		chan = &dw->chan[pos + off];
> >
> > +		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
> > +			continue;
> > +
> >  		dw_edma_v0_core_clear_abort_int(chan);
> >  		abort(chan);
> > -
> >  		ret = IRQ_HANDLED;
> >  	}
> >
> > @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  		j--;
> >  		if (!j) {
> >  			control |= DW_EDMA_V0_LIE;
> > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> > +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
> 
> you define DW_EMDA_CH_IRQ_REMOTE, sugget don't use reverise logic.
> 
> 	chan->irq_mode == chan->irq_mode

Agreed. I will use that for more simple comparison.

> 
> >  				control |= DW_EDMA_V0_RIE;
> >  		}
> >
> > @@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  				break;
> >  			}
> >  		}
> > -		/* Interrupt unmask - done, abort */
> > +		/* Interrupt mask/unmask - done, abort */
> >  		raw_spin_lock_irqsave(&dw->lock, flags);
> >
> >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> 
> I think need also check chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL

If the mask operation is limited to DW_EDMA_CHIP_LOCAL, the RC-side dw-edma-pcie
instance for delegated EP DMA would clear the local interrupt mask when it
programs the channel, as that instance is not marked DW_EDMA_CHIP_LOCAL.
That would re-enable the EP-local edma_int[] path for a channel whose completion
is owned by the RC-side.

Those redundant interrupts would not be fatal because
dw_edma_core_ch_ignore_irq() guards against the local side consuming the status,
but they should still be avoided in the normal path.

I guess your concern is the existing EDDA/MDB/CPM6 path, right? Those devices
historically did not mask the local interrupt when using remote completion.

> 
> > +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		} else {
> > +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		}
> >  		SET_RW_32(dw, chan->dir, int_mask, tmp);
> >  		/* Linked list error */
> >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > index 2beec876b184..7ba6bdbffc17 100644
> > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > @@ -49,6 +49,26 @@ __dw_ch_regs(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch)
> >  		writel(value, &(__dw_ch_regs(dw, EDMA_DIR_READ, ch)->name));	\
> >  	} while (0)
> >
> > +static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
> > +{
> > +	val &= ~(HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN |
> > +		 HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_REMOTE_STOP_INT_EN |
> > +		 HDMA_V0_ABORT_INT_MASK | HDMA_V0_STOP_INT_MASK);
> > +
> > +	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE && chan->non_ll)
> > +		return val | HDMA_V0_REMOTE_ABORT_INT_EN |
> > +		       HDMA_V0_REMOTE_STOP_INT_EN;
> > +
> > +	if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE)
> > +		return val | HDMA_V0_LOCAL_ABORT_INT_EN |
> > +		       HDMA_V0_REMOTE_ABORT_INT_EN |
> > +		       HDMA_V0_LOCAL_STOP_INT_EN |
> > +		       HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_ABORT_INT_MASK |
> > +		       HDMA_V0_STOP_INT_MASK;
> > +
> > +	return val | HDMA_V0_LOCAL_ABORT_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
> > +}
> > +
> >  /* HDMA management callbacks */
> >  static void dw_hdma_v0_core_off(struct dw_edma *dw)
> >  {
> > @@ -132,6 +152,8 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >
> >  	for_each_set_bit(pos, &mask, total) {
> >  		chan = &dw->chan[pos + off];
> > +		if (unlikely(dw_edma_core_ch_ignore_irq(chan)))
> > +			continue;
> >
> >  		val = dw_hdma_v0_core_status_int(chan);
> >  		if (FIELD_GET(HDMA_V0_STOP_INT_MASK, val)) {
> > @@ -238,11 +260,7 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
> >  		SET_CH_32(dw, chan->dir, chan->id, ch_en, BIT(0));
> >  		/* Interrupt unmask - stop, abort */
> >  		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup);
> > -		tmp &= ~(HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
> > -		/* Interrupt enable - stop, abort */
> > -		tmp |= HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
> > -		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > -			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
> > +		tmp = dw_hdma_v0_core_int_setup(chan, tmp);
> 
> Can you use small patch to create helper dw_hdma_v0_core_int_setup() only

Sure, I will split it out.

> 
> >  		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
> >  		/* Channel control */
> >  		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);
> > @@ -293,17 +311,8 @@ static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
> >  	SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
> >
> >  	/* Interrupt setup */
> > -	val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
> > -			HDMA_V0_STOP_INT_MASK |
> > -			HDMA_V0_ABORT_INT_MASK |
> > -			HDMA_V0_LOCAL_STOP_INT_EN |
> > -			HDMA_V0_LOCAL_ABORT_INT_EN;
> > -
> > -	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > -		val |= HDMA_V0_REMOTE_STOP_INT_EN |
> > -		       HDMA_V0_REMOTE_ABORT_INT_EN;
> > -	}
> > -
> > +	val = GET_CH_32(dw, chan->dir, chan->id, int_setup);
> > +	val = dw_hdma_v0_core_int_setup(chan, val);
> >  	SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> >
> >  	/* Channel control setup */
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 1fafd5b0e315..c0906221a7c7 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
> >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> >  };
> >
> > +/**
> > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > + * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
> > + * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI), without
> > + *                            delivering local edma_int[].
> > + *
> > + * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
> > + * bus, and remotely using posted memory writes (IMWr) that may be
> > + * interpreted as MSI/MSI-X by the RC.
> > + *
> > + * For the v0 eDMA linked-list programming path, DMA_*_INT_MASK gates the local
> > + * edma_int[] assertion, while there is no dedicated per-channel mask for IMWr
> > + * generation. To request a remote-only interrupt, Synopsys recommends setting
> > + * both LIE and RIE, and masking the local interrupt in DMA_*_INT_MASK. See the
> > + * DesignWare endpoint databook 6.30a, Linked List Mode interrupt handling
> > + * ("Software Programming of an Endpoint's LIE and RIE Bits for Linked List
> > + * Transfers", Attention).
> > + *
> > + * HDMA linked-list watermark interrupts have the same LWIE/RWIE guidance. HDMA
> > + * non-linked-list mode has dedicated local and remote stop/abort interrupt
> > + * enables, and the remote CPU programming examples use remote enables without
> > + * local enables.
> > + */
> > +enum dw_edma_ch_irq_mode {
> > +	DW_EDMA_CH_IRQ_LOCAL	= 0,
> > +	DW_EDMA_CH_IRQ_REMOTE,
> > +};
> > +
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:		 struct device of the eDMA controller
> > @@ -76,6 +104,7 @@ enum dw_edma_chip_flags {
> >   * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
> >   * @db_offset:		 Offset from DMA register base
> >   * @mf:			 DMA register map format
> > + * @irq_mode:		 default per-channel interrupt routing
> >   * @dw:			 struct dw_edma that is filled by dw_edma_probe()
> >   */
> >  struct dw_edma_chip {
> > @@ -101,6 +130,7 @@ struct dw_edma_chip {
> >  	resource_size_t		db_offset;
> >
> >  	enum dw_edma_map_format	mf;
> > +	enum dw_edma_ch_irq_mode	irq_mode;
> 
> This are already have flags dw_edma_chip_flags, not sure why need irq_mode,
> suppose, if set DW_EDMA_CHIP_LOCAL, pre channel should be default as
> DW_EDMA_CH_IRQ_LOCAL

Yes, the chip-level irq_mode is unnecessary.

Thanks a lot for the detailed review,
Koichiro

> 
> Frank
> >
> >  	struct dw_edma		*dw;
> >  	bool			cfg_non_ll;
> > --
> > 2.51.0
> >

